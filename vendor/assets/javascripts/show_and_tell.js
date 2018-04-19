class ShowAndTell {
  constructor() {
    this.form_data_registry = {}
    this.question_list_registry = {}
  }

  /* API METHODS */

  register(form_name, form_data) {
    this.setOrUpdateFormData(form_name, form_data)
    .then(form_name => this.removeExistingEventListeners(form_name))
    .then(form_name => this.updateQuestionList(form_name))
    .then(question_list => this.addEventListeners(question_list))
    .then(question_list => this.showAllIfMatch(question_list))
    .catch(err => this.handleError(err))
  }

  /* INTERNAL METHODS */

  setOrUpdateFormData(form_name, form_data) {
    const result = this.setFormData(form_name, form_data)
    if (result) { return Promise.resolve(form_name) }
    else { return Promise.reject("cannot update form data") }
  }

  removeExistingEventListeners(form_name) {
    const question_list = this.getQuestionList(form_name)
    if (question_list) {
      question_list.getQuestionList().forEach(question => {
        const el = ShowAndTellPage.getGroupElement(question.getQuestion())
        if (el) {
          el.removeEventListener('change', g_el => { return question.showIfMatch(g_el) })
        }
      })
    }
    return Promise.resolve(form_name)
  }

  updateQuestionList(form_name) {
    const question_list = new ShowAndTellQuestionList(this.getFormData(form_name))
    if (this.setQuestionList(form_name, question_list)) {
      return Promise.resolve(question_list)
    } else {
      return Promise.reject("cannot update question list")
    }
  }

  addEventListeners(question_list) {
    question_list.getQuestionList().forEach(question => {
      const el = ShowAndTellPage.getGroupElement(question.getQuestion())
      if (el) {
        el.addEventListener('change', g_el => { return question.showIfMatch(g_el) })
      }
    })
    return Promise.resolve(question_list)
  }

  showAllIfMatch(question_list) {
    question_list.showAllIfMatch()
    return Promise.resolve(question_list)
  }

  handleError(err) { console.error("Show and Tell Error:", err) }

  /* GETTERS + SETTERS */

  getFormData(form_name) { return this.form_data_registry[form_name] }

  getQuestionList(form_name) { return this.question_list_registry[form_name] }

  setFormData(form_name, form_data) {
    return this.form_data_registry[form_name] = form_data
  }

  setQuestionList(form_name, question_list) {
    return this.question_list_registry[form_name] = question_list
  }
}


class ShowAndTellQuestionList {
  constructor(form_data) {
    this.question_list = form_data.map(question => new ShowAndTellQuestion(question))
  }

  getQuestionList() { return this.question_list }

  showAllIfMatch() {
    this.getQuestionList().forEach(q => q.showIfMatch())
  }
}


class ShowAndTellQuestion {
  constructor(question) {
    this.question_name = question.question
    this.monitors = question.monitors.map(m => new ShowAndTellMonitor(m))
  }

  getMonitors() { return this.monitors }

  getQuestion() { return this.question_name }

  // This is the function that gets called whenever an element changes.
  showIfMatch() {
    const input_value = ShowAndTellPage.getInputValue(this.getQuestion())
    if (!input_value) { return }
    this.getMonitors().forEach(monitor => {
      const answer_regexp = new RegExp(monitor.getAnswer())
      monitor.hideFieldsToShow()
      if (input_value.match(answer_regexp)) { monitor.showFieldsToShow() }
    })
  }
}


class ShowAndTellMonitor {
  constructor(monitor) {
    this.answer = monitor.answer
    this.fields_to_show = monitor.fields_to_show
    this.hideFieldsToShow()
  }

  getAnswer() { return this.answer }

  getFieldsToShow() { return this.fields_to_show }

  hideFieldsToShow() {
    this.getFieldsToShow().forEach(f => ShowAndTellPage.hideGroupElement(f))
  }

  showFieldsToShow() {
    this.getFieldsToShow().forEach(f => ShowAndTellPage.showGroupElement(f))
  }
}


class ShowAndTellPage {
  static getInputValue(field_name) {
    const group_element = ShowAndTellPage.getGroupElement(field_name)
    if (!group_element) { return null; }
    const input =
      group_element.querySelector("input[type=radio]:checked") ||
      group_element.querySelector("input[type=text]") ||
      group_element.querySelector("select")
    if (input) { return input.value }
    else { return '' }
  }

  static getGroupElement(field_name) {
    return document.querySelector(`[sat-field="${field_name}"]`)
  }

  static hideGroupElement(field_name) {
    const el = this.getGroupElement(field_name)
    if (el) { el.classList.add("dn") }
  }

  static showGroupElement(field_name) {
    const el = this.getGroupElement(field_name)
    if (el) { el.classList.remove("dn") }
  }
}