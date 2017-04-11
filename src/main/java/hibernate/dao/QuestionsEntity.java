package hibernate.dao;

import javax.persistence.*;
import java.util.HashSet;
import java.util.Set;

/**
 * Created by Alex on 03.04.2017.
 */
@Entity
@Table(name = "questions")
public class QuestionsEntity {
    @Override
    public String toString() {
        return "QuestionsEntity{" +
                "id=" + id +
                ", type='" + type + '\'' +
                ", score=" + score +
                ", text='" + text + '\'' +
                '}';
    }

    private int id;
    private String type;
    private Integer score;
    private String text;

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
    //связь с потомком
    private Set<VariantsEntity> variants = new HashSet<VariantsEntity>();
    @OneToMany(mappedBy = "question", fetch = FetchType.EAGER,cascade=CascadeType.ALL, orphanRemoval = true)

    public Set<VariantsEntity> getVariants() {
        return this.variants;
    }

    public void setVariants(Set<VariantsEntity> variants) {
        this.variants = variants;
    }

    public void addVariant(VariantsEntity variant) {
        variant.setQuestion(this);
        this.variants.add(variant);
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
    @Column(name = "type", nullable = true, length = -1)
    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    @Basic
    @Column(name = "score", nullable = true)
    public Integer getScore() {
        return score;
    }

    public void setScore(Integer score) {
        this.score = score;
    }

    @Basic
    @Column(name = "text", nullable = true, length = -1)
    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        QuestionsEntity that = (QuestionsEntity) o;

        if (id != that.id) return false;

        if (type != null ? !type.equals(that.type) : that.type != null) return false;
        if (score != null ? !score.equals(that.score) : that.score != null) return false;
        if (text != null ? !text.equals(that.text) : that.text != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = id;

        result = 31 * result + (type != null ? type.hashCode() : 0);
        result = 31 * result + (score != null ? score.hashCode() : 0);
        result = 31 * result + (text != null ? text.hashCode() : 0);
        return result;
    }
}
