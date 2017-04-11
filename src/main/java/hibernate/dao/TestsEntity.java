package hibernate.dao;

import javax.persistence.*;
import java.util.HashSet;
import java.util.Set;

/**
 * Created by Alex on 03.04.2017.
 */
@Entity
@Table(name = "tests")
public class TestsEntity {
    @Override
    public String toString() {
        return "TestsEntity{" +
                "idTest=" + id +

                ", time=" + time +
                ", title='" + title + '\'' +
                '}';
    }

    private int id;

    private Integer time;
    private String title;
    //связь с родителем
    private Teacher teacher;
    @ManyToOne (cascade = CascadeType.PERSIST, fetch = FetchType.LAZY)
    @JoinColumn(name = "id_teacher",referencedColumnName = "id")

    public Teacher getTeacher() {
        return this.teacher;
    }

    public void setTeacher(Teacher teacher) {
        this.teacher = teacher;
    }
    //связь с потомком
    private Set<ResultsEntity> results = new HashSet<ResultsEntity>();
    @OneToMany(mappedBy = "test",cascade=CascadeType.ALL, fetch = FetchType.LAZY, orphanRemoval = true)

    public Set<ResultsEntity> getResults() {
        return this.results;
    }

    public void setResults(Set<ResultsEntity> results) {
        this.results = results;
    }

    public void addResult(ResultsEntity result) {
        result.setTest(this);
        this.results.add(result);
    }
    //связь с потомком
    private Set<QuestionsEntity> questions = new HashSet<QuestionsEntity>();
    @OneToMany(mappedBy = "test",cascade=CascadeType.ALL, fetch = FetchType.LAZY, orphanRemoval = true)

    public Set<QuestionsEntity> getQuestions() {
        return this.questions;
    }

    public void setQuestions(Set<QuestionsEntity> questions) {
        this.questions = questions;
    }

    public void addQuestion(QuestionsEntity question) {
        question.setTest(this);
        this.questions.add(question);
    }
    //множ связи
    private Set<GroupsEntity> groups =new HashSet<GroupsEntity>();
    @ManyToMany(fetch = FetchType.EAGER,mappedBy = "tests")
    public Set<GroupsEntity> getGroups() {
        return this.groups;
    }
    public void setGroups(Set<GroupsEntity> groups){
        this.groups=groups;
    }



    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false)
    public int getId() {
        return id;
    }

    public void setId(int idTest) {
        this.id = idTest;
    }



    @Basic
    @Column(name = "time", nullable = true)
    public Integer getTime() {
        return time;
    }

    public void setTime(Integer time) {
        this.time = time;
    }

    @Basic
    @Column(name = "title", nullable = true, length = -1)
    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        TestsEntity that = (TestsEntity) o;

        if (id != that.id) return false;

        if (time != null ? !time.equals(that.time) : that.time != null) return false;
        if (title != null ? !title.equals(that.title) : that.title != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = id;
        result = 31 * result + (time != null ? time.hashCode() : 0);
        result = 31 * result + (title != null ? title.hashCode() : 0);
        return result;
    }
}
