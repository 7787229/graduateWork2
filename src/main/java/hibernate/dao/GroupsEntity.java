package hibernate.dao;

import javax.persistence.*;
import java.util.HashSet;
import java.util.Set;

/**
 * Created by Alex on 03.04.2017.
 */
@Entity
@Table(name = "groups")
public class GroupsEntity {
    @Override
    public String toString() {
        return "GroupsEntity{" +
                "id=" + id +
                ", title='" + title + '\'' +
                '}';
    }

    private int id;
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
    //множ связи
    private Set<TestsEntity> tests =new HashSet<TestsEntity>();
    @ManyToMany(fetch = FetchType.EAGER)
    @JoinTable(name = "groups_tests",
            joinColumns = @JoinColumn(name = "id_group"),
            inverseJoinColumns = @JoinColumn(name = "id_test"))
    public Set<TestsEntity> getTests() {
        return this.tests;
    }
    public void setTests(Set<TestsEntity> tests){
        this.tests=tests;
    }
    public void addTest(TestsEntity test){
        tests.add(test);
    }


    private Set<Pupil> pupils =new HashSet<Pupil>();
    @ManyToMany(fetch = FetchType.EAGER)
    @JoinTable(name = "groups_pupils",
            joinColumns = @JoinColumn(name = "id_group"),
            inverseJoinColumns = @JoinColumn(name = "id_pupil"))
    public Set<Pupil> getPupils() {
        return this.pupils;
    }
    public void setPupils(Set<Pupil> pupils){
        this.pupils=pupils;
    }
    public void addPupil(Pupil pupil){
        pupils.add(pupil);
    }

    public void clear (){
        this.pupils .clear();
        this.tests.clear(); ;
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

        GroupsEntity that = (GroupsEntity) o;

        if (id != that.id) return false;

        if (title != null ? !title.equals(that.title) : that.title != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = id;
        result = 31 * result + (title != null ? title.hashCode() : 0);
        return result;
    }
}
