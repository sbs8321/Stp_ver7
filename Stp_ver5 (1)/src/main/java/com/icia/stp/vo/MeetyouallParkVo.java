package com.icia.stp.vo;

public class MeetyouallParkVo {
   private String prkplceno;
   private String prkplcenm;
   private String prkplcese;
   private String prkplcetype;
   private String rdnmadr;
   private String lnmadr;
   private int prkcmprt;
   private int basictime;
   private int basiccharge;
   private int daycmmtkt;
   private int monthcmmtkt;
   private String metpay;
   private String spcmnt;
   private String latitude;
   private String hardness;
   private String parkimg;
   private int hourpayment;
   private String owner;
   private int state;
   public MeetyouallParkVo() {
      super();
      // TODO Auto-generated constructor stub
   }

   public MeetyouallParkVo(String prkplceno, String prkplcenm, String prkplcese, String prkplcetype, String rdnmadr,
         String lnmadr, int prkcmprt, int basictime, int basiccharge, int daycmmtkt, int monthcmmtkt, String metpay,
         String spcmnt, String latitude, String hardness, String parkimg, int hourPayment) {
      super();
      this.prkplceno = prkplceno;
      this.prkplcenm = prkplcenm;
      this.prkplcese = prkplcese;
      this.prkplcetype = prkplcetype;
      this.rdnmadr = rdnmadr;
      this.lnmadr = lnmadr;
      this.prkcmprt = prkcmprt;
      this.basictime = basictime;
      this.basiccharge = basiccharge;
      this.daycmmtkt = daycmmtkt;
      this.monthcmmtkt = monthcmmtkt;
      this.metpay = metpay;
      this.spcmnt = spcmnt;
      this.latitude = latitude;
      this.hardness = hardness;
      this.parkimg = parkimg;
      this.hourpayment = hourPayment;
   }

   @Override
   public String toString() {
      return "MeetyouallParkVo [prkplceno=" + prkplceno + ", prkplcenm=" + prkplcenm + ", prkplcese=" + prkplcese
            + ", prkplcetype=" + prkplcetype + ", rdnmadr=" + rdnmadr + ", lnmadr=" + lnmadr + ", prkcmprt="
            + prkcmprt + ", basictime=" + basictime + ", basiccharge=" + basiccharge + ", daycmmtkt=" + daycmmtkt
            + ", monthcmmtkt=" + monthcmmtkt + ", metpay=" + metpay + ", spcmnt=" + spcmnt + ", latitude="
            + latitude + ", hardness=" + hardness + ", parkimg=" + parkimg + ",hourPayment=" + hourpayment + "]";
   }

   public String getPrkplceno() {
      return prkplceno;
   }

   public void setPrkplceno(String prkplceno) {
      this.prkplceno = prkplceno;
   }

   public String getPrkplcenm() {
      return prkplcenm;
   }

   public void setPrkplcenm(String prkplcenm) {
      this.prkplcenm = prkplcenm;
   }

   public String getPrkplcese() {
      return prkplcese;
   }

   public void setPrkplcese(String prkplcese) {
      this.prkplcese = prkplcese;
   }

   public String getPrkplcetype() {
      return prkplcetype;
   }

   public void setPrkplcetype(String prkplcetype) {
      this.prkplcetype = prkplcetype;
   }

   public String getRdnmadr() {
      return rdnmadr;
   }

   public void setRdnmadr(String rdnmadr) {
      this.rdnmadr = rdnmadr;
   }

   public String getLnmadr() {
      return lnmadr;
   }

   public void setLnmadr(String lnmadr) {
      this.lnmadr = lnmadr;
   }

   public int getPrkcmprt() {
      return prkcmprt;
   }

   public void setPrkcmprt(int prkcmprt) {
      this.prkcmprt = prkcmprt;
   }

   public int getBasictime() {
      return basictime;
   }

   public void setBasictime(int basictime) {
      this.basictime = basictime;
   }

   public int getBasiccharge() {
      return basiccharge;
   }

   public void setBasiccharge(int basiccharge) {
      this.basiccharge = basiccharge;
   }

   public int getDaycmmtkt() {
      return daycmmtkt;
   }

   public void setDaycmmtkt(int daycmmtkt) {
      this.daycmmtkt = daycmmtkt;
   }

   public int getMonthcmmtkt() {
      return monthcmmtkt;
   }

   public void setMonthcmmtkt(int monthcmmtkt) {
      this.monthcmmtkt = monthcmmtkt;
   }

   public String getMetpay() {
      return metpay;
   }

   public void setMetpay(String metpay) {
      this.metpay = metpay;
   }

   public String getSpcmnt() {
      return spcmnt;
   }

   public void setSpcmnt(String spcmnt) {
      this.spcmnt = spcmnt;
   }

   public String getLatitude() {
      return latitude;
   }

   public void setLatitude(String latitude) {
      this.latitude = latitude;
   }

   public String getHardness() {
      return hardness;
   }

   public void setHardness(String hardness) {
      this.hardness = hardness;
   }

   public String getParkimg() {
      return parkimg;
   }

   public void setParkimg(String parkimg) {
      this.parkimg = parkimg;
   }

   public int getHourPayment() {
      return hourpayment;
   }

   public void setHourPayment(int hourPayment) {
      this.hourpayment = hourPayment;
   }

public String getOwner() {
	return owner;
}

public void setOwner(String owner) {
	this.owner = owner;
}

public int getState() {
	return state;
}

public void setState(int state) {
	this.state = state;
}

}