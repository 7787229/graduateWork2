package hibernate.dao;

import javax.persistence.*;

/**
 * Created by Alex on 03.04.2017.
 */
@Entity
@Table(name = "variants")
public class VariantsEntity {
    @Override
    public String toString() {
        return "VariantsEntity{" +
                "id=" + id +
                ", text='" + text + '\'' +
                ", answer=" + answer +
                '}';
    }

    private int id;

    private String text;
    private Boolean answer;

    //связь с родителем
    private QuestionsEntity question;
    @ManyToOne (cascade = CascadeType.PERSIST, fetch = FetchType.LAZY)
    @JoinColumn(name = "id_question",referencedColumnName = "id")

    public QuestionsEntity getQuestion() {
        return this.question;
    }

    public void setQuestion(QuestionsEntity question) {
        this.question = question;
    }

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false)
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }



    @Basic
    @Column(name = "text", nullable = true, length = -1)
    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }

    @Basic
    @Column(name = "answer", nullable = true)
    public Boolean getAnswer() {
        return answer;
    }

    public void setAnswer(Boolean answer) {
        this.answer = answer;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        VariantsEntity that = (VariantsEntity) o;

        if (id != that.id) return false;

        if (text != null ? !text.equals(that.text) : that.text != null) return false;
        if (answer != null ? !answer.equals(that.answer) : that.answer != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = id;
        result = 31 * result + (text != null ? text.hashCode() : 0);
        result = 31 * result + (answer != null ? answer.hashCode() : 0);
        return result;
    }
}
