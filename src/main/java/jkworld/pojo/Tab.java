package jkworld.pojo;

public class Tab {
    private Integer id;

    private String tabName;

    private String tabNameEn;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getTabName() {
        return tabName;
    }

    public void setTabName(String tabName) {
        this.tabName = tabName == null ? null : tabName.trim();
    }

    public String getTabNameEn() {
        return tabNameEn;
    }

    public void setTabNameEn(String tabNameEn) {
        this.tabNameEn = tabNameEn == null ? null : tabNameEn.trim();
    }


    @Override
    public String toString() {
        return "Tab{" +
                "id=" + id +
                ", tabName='" + tabName + '\'' +
                ", tabNameEn='" + tabNameEn + '\'' +
                '}';
    }
}