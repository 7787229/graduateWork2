package hibernate.dao;

import javax.persistence.*;
import java.util.HashSet;
import java.util.Set;

/**
 * Created by Alex on 03.04.2017.
 */
@Entity
@Table(name = "results")
public class ResultsEntity {
    @Override
    public String toString() {
        return "ResultsEntity{" +
                "progress=" + progress +
                ", id=" + id +
                '}';
    }

    private Float progress;
    private int id;
    //связь с родителем
    private TestsEntity test;
    @ManyToOne (cascade = CascadeType.PERSIST, fetch = FetchType.LAZY)
    @JoinColumn(name = "id_test",referencedColumnName = "id")

    public TestsEntity getTest() {
        return this.test;
    }

    public void setTest(TestsEntity test) {
        this.test = test;
    }
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

    //связь с родителем
    private Pupil pupil;
    @ManyToOne (cascade = CascadeType.PERSIST, fetch = FetchType.LAZY)
    @JoinColumn(name = "id_pupil",referencedColumnName = "id")

    public Pupil getPupil() {
        return this.pupil;
    }

    public void setPupil(Pupil pupil) {
        this.pupil = pupil;
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
    @Column(name = "progress", nullable = true, precision = 0)
    public Float getProgress() {
        return progress;
    }

    public void setProgress(Float progress) {
        this.progress = progress;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        ResultsEntity that = (ResultsEntity) o;


        if (progress != null ? !progress.equals(that.progress) : that.progress != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = progress != null ? progress.hashCode() : 0;

        result = 31 * result + (progress != null ? progress.hashCode() : 0);
        return result;
    }
}
