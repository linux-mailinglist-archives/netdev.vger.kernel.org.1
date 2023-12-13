Return-Path: <netdev+bounces-54181-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C54806322
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 01:03:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C184A2821EE
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 00:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7A5AEC0;
	Wed,  6 Dec 2023 00:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="DvEZEIpV"
X-Original-To: netdev@vger.kernel.org
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A216118F;
	Tue,  5 Dec 2023 16:03:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1701820989;
	bh=ronpnnEzcd7JvKQZCY6xrXsmrmM+QLQMggAqInw3QwU=;
	h=Date:From:To:Cc:Subject:From;
	b=DvEZEIpV5IyNkQFg473L7biH43IG3v6k6WQNTupyg73eUlS9bYxF8hdUGY15f2ovN
	 fu4A/T/HpGbAdCI9oIf1C295YC89+d90A4i8SHB6lU6woDTmDLodBDgWgQuyogS4Yv
	 cDuFLJOylfS34sQygw23Tc3r+vS2Rba8CFYA+7i/P3XRZSDmMraF03gTuQvMM9XSLI
	 gNRFLNggtkT7k9dXc9MlDR5cbBzt0w4VzyobKiKY3UlARdXn4GR50IHEgsAw/7s2iR
	 OR1RGael1IsJhrrtUo+D1Id7ZejsPQFQHQPB2zmfewNM8FaAuSUPpZCFAOc9GKLs8C
	 23ZLMCD9CPITg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4SlHfh2WzFz4wc6;
	Wed,  6 Dec 2023 11:03:07 +1100 (AEDT)
Date: Wed, 6 Dec 2023 11:03:06 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Jianheng Zhang <Jianheng.Zhang@synopsys.com>, Networking
 <netdev@vger.kernel.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>, Rohan G Thomas <rohan.g.thomas@intel.com>
Subject: linux-next: manual merge of the net-next tree with the net tree
Message-ID: <20231206110306.01e91114@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Ywn_.bCg_=VIfBrJ+KiY.nh";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/Ywn_.bCg_=VIfBrJ+KiY.nh
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the net-next tree got conflicts in:

  drivers/net/ethernet/stmicro/stmmac/dwmac5.c
  drivers/net/ethernet/stmicro/stmmac/dwmac5.h
  drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
  drivers/net/ethernet/stmicro/stmmac/hwif.h

between commit:

  37e4b8df27bc ("net: stmmac: fix FPE events losing")

from the net tree and commit:

  c3f3b97238f6 ("net: stmmac: Refactor EST implementation")

from the net-next tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/net/ethernet/stmicro/stmmac/dwmac5.c
index 8fd167501fa0,ea92650f5c97..000000000000
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
@@@ -573,145 -573,7 +573,8 @@@ int dwmac5_flex_pps_config(void __iome
  	return 0;
  }
 =20
- static int dwmac5_est_write(void __iomem *ioaddr, u32 reg, u32 val, bool =
gcl)
- {
- 	u32 ctrl;
-=20
- 	writel(val, ioaddr + MTL_EST_GCL_DATA);
-=20
- 	ctrl =3D (reg << ADDR_SHIFT);
- 	ctrl |=3D gcl ? 0 : GCRR;
-=20
- 	writel(ctrl, ioaddr + MTL_EST_GCL_CONTROL);
-=20
- 	ctrl |=3D SRWO;
- 	writel(ctrl, ioaddr + MTL_EST_GCL_CONTROL);
-=20
- 	return readl_poll_timeout(ioaddr + MTL_EST_GCL_CONTROL,
- 				  ctrl, !(ctrl & SRWO), 100, 5000);
- }
-=20
- int dwmac5_est_configure(void __iomem *ioaddr, struct stmmac_est *cfg,
- 			 unsigned int ptp_rate)
- {
- 	int i, ret =3D 0x0;
- 	u32 ctrl;
-=20
- 	ret |=3D dwmac5_est_write(ioaddr, BTR_LOW, cfg->btr[0], false);
- 	ret |=3D dwmac5_est_write(ioaddr, BTR_HIGH, cfg->btr[1], false);
- 	ret |=3D dwmac5_est_write(ioaddr, TER, cfg->ter, false);
- 	ret |=3D dwmac5_est_write(ioaddr, LLR, cfg->gcl_size, false);
- 	ret |=3D dwmac5_est_write(ioaddr, CTR_LOW, cfg->ctr[0], false);
- 	ret |=3D dwmac5_est_write(ioaddr, CTR_HIGH, cfg->ctr[1], false);
- 	if (ret)
- 		return ret;
-=20
- 	for (i =3D 0; i < cfg->gcl_size; i++) {
- 		ret =3D dwmac5_est_write(ioaddr, i, cfg->gcl[i], true);
- 		if (ret)
- 			return ret;
- 	}
-=20
- 	ctrl =3D readl(ioaddr + MTL_EST_CONTROL);
- 	ctrl &=3D ~PTOV;
- 	ctrl |=3D ((1000000000 / ptp_rate) * 6) << PTOV_SHIFT;
- 	if (cfg->enable)
- 		ctrl |=3D EEST | SSWL;
- 	else
- 		ctrl &=3D ~EEST;
-=20
- 	writel(ctrl, ioaddr + MTL_EST_CONTROL);
-=20
- 	/* Configure EST interrupt */
- 	if (cfg->enable)
- 		ctrl =3D (IECGCE | IEHS | IEHF | IEBE | IECC);
- 	else
- 		ctrl =3D 0;
-=20
- 	writel(ctrl, ioaddr + MTL_EST_INT_EN);
-=20
- 	return 0;
- }
-=20
- void dwmac5_est_irq_status(void __iomem *ioaddr, struct net_device *dev,
- 			  struct stmmac_extra_stats *x, u32 txqcnt)
- {
- 	u32 status, value, feqn, hbfq, hbfs, btrl;
- 	u32 txqcnt_mask =3D (1 << txqcnt) - 1;
-=20
- 	status =3D readl(ioaddr + MTL_EST_STATUS);
-=20
- 	value =3D (CGCE | HLBS | HLBF | BTRE | SWLC);
-=20
- 	/* Return if there is no error */
- 	if (!(status & value))
- 		return;
-=20
- 	if (status & CGCE) {
- 		/* Clear Interrupt */
- 		writel(CGCE, ioaddr + MTL_EST_STATUS);
-=20
- 		x->mtl_est_cgce++;
- 	}
-=20
- 	if (status & HLBS) {
- 		value =3D readl(ioaddr + MTL_EST_SCH_ERR);
- 		value &=3D txqcnt_mask;
-=20
- 		x->mtl_est_hlbs++;
-=20
- 		/* Clear Interrupt */
- 		writel(value, ioaddr + MTL_EST_SCH_ERR);
-=20
- 		/* Collecting info to shows all the queues that has HLBS
- 		 * issue. The only way to clear this is to clear the
- 		 * statistic
- 		 */
- 		if (net_ratelimit())
- 			netdev_err(dev, "EST: HLB(sched) Queue 0x%x\n", value);
- 	}
-=20
- 	if (status & HLBF) {
- 		value =3D readl(ioaddr + MTL_EST_FRM_SZ_ERR);
- 		feqn =3D value & txqcnt_mask;
-=20
- 		value =3D readl(ioaddr + MTL_EST_FRM_SZ_CAP);
- 		hbfq =3D (value & SZ_CAP_HBFQ_MASK(txqcnt)) >> SZ_CAP_HBFQ_SHIFT;
- 		hbfs =3D value & SZ_CAP_HBFS_MASK;
-=20
- 		x->mtl_est_hlbf++;
-=20
- 		/* Clear Interrupt */
- 		writel(feqn, ioaddr + MTL_EST_FRM_SZ_ERR);
-=20
- 		if (net_ratelimit())
- 			netdev_err(dev, "EST: HLB(size) Queue %u Size %u\n",
- 				   hbfq, hbfs);
- 	}
-=20
- 	if (status & BTRE) {
- 		if ((status & BTRL) =3D=3D BTRL_MAX)
- 			x->mtl_est_btrlm++;
- 		else
- 			x->mtl_est_btre++;
-=20
- 		btrl =3D (status & BTRL) >> BTRL_SHIFT;
-=20
- 		if (net_ratelimit())
- 			netdev_info(dev, "EST: BTR Error Loop Count %u\n",
- 				    btrl);
-=20
- 		writel(BTRE, ioaddr + MTL_EST_STATUS);
- 	}
-=20
- 	if (status & SWLC) {
- 		writel(SWLC, ioaddr + MTL_EST_STATUS);
- 		netdev_info(dev, "EST: SWOL has been switched\n");
- 	}
- }
-=20
 -void dwmac5_fpe_configure(void __iomem *ioaddr, u32 num_txq, u32 num_rxq,
 +void dwmac5_fpe_configure(void __iomem *ioaddr, struct stmmac_fpe_cfg *cf=
g,
 +			  u32 num_txq, u32 num_rxq,
  			  bool enable)
  {
  	u32 value;
diff --cc drivers/net/ethernet/stmicro/stmmac/dwmac5.h
index 34e620790eb3,8b0f2c90faef..000000000000
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac5.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac5.h
@@@ -149,15 -102,9 +102,11 @@@ int dwmac5_rxp_config(void __iomem *ioa
  int dwmac5_flex_pps_config(void __iomem *ioaddr, int index,
  			   struct stmmac_pps_cfg *cfg, bool enable,
  			   u32 sub_second_inc, u32 systime_flags);
- int dwmac5_est_configure(void __iomem *ioaddr, struct stmmac_est *cfg,
- 			 unsigned int ptp_rate);
- void dwmac5_est_irq_status(void __iomem *ioaddr, struct net_device *dev,
- 			   struct stmmac_extra_stats *x, u32 txqcnt);
 -void dwmac5_fpe_configure(void __iomem *ioaddr, u32 num_txq, u32 num_rxq,
 +void dwmac5_fpe_configure(void __iomem *ioaddr, struct stmmac_fpe_cfg *cf=
g,
 +			  u32 num_txq, u32 num_rxq,
  			  bool enable);
  void dwmac5_fpe_send_mpacket(void __iomem *ioaddr,
 +			     struct stmmac_fpe_cfg *cfg,
  			     enum stmmac_mpacket_type type);
  int dwmac5_fpe_irq_status(void __iomem *ioaddr, struct net_device *dev);
 =20
diff --cc drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
index a74e71db79f9,f33f73de5cfe..000000000000
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
@@@ -1433,59 -1433,7 +1433,8 @@@ static void dwxgmac2_set_arp_offload(st
  	writel(value, ioaddr + XGMAC_RX_CONFIG);
  }
 =20
- static int dwxgmac3_est_write(void __iomem *ioaddr, u32 reg, u32 val, boo=
l gcl)
- {
- 	u32 ctrl;
-=20
- 	writel(val, ioaddr + XGMAC_MTL_EST_GCL_DATA);
-=20
- 	ctrl =3D (reg << XGMAC_ADDR_SHIFT);
- 	ctrl |=3D gcl ? 0 : XGMAC_GCRR;
-=20
- 	writel(ctrl, ioaddr + XGMAC_MTL_EST_GCL_CONTROL);
-=20
- 	ctrl |=3D XGMAC_SRWO;
- 	writel(ctrl, ioaddr + XGMAC_MTL_EST_GCL_CONTROL);
-=20
- 	return readl_poll_timeout_atomic(ioaddr + XGMAC_MTL_EST_GCL_CONTROL,
- 					 ctrl, !(ctrl & XGMAC_SRWO), 100, 5000);
- }
-=20
- static int dwxgmac3_est_configure(void __iomem *ioaddr, struct stmmac_est=
 *cfg,
- 				  unsigned int ptp_rate)
- {
- 	int i, ret =3D 0x0;
- 	u32 ctrl;
-=20
- 	ret |=3D dwxgmac3_est_write(ioaddr, XGMAC_BTR_LOW, cfg->btr[0], false);
- 	ret |=3D dwxgmac3_est_write(ioaddr, XGMAC_BTR_HIGH, cfg->btr[1], false);
- 	ret |=3D dwxgmac3_est_write(ioaddr, XGMAC_TER, cfg->ter, false);
- 	ret |=3D dwxgmac3_est_write(ioaddr, XGMAC_LLR, cfg->gcl_size, false);
- 	ret |=3D dwxgmac3_est_write(ioaddr, XGMAC_CTR_LOW, cfg->ctr[0], false);
- 	ret |=3D dwxgmac3_est_write(ioaddr, XGMAC_CTR_HIGH, cfg->ctr[1], false);
- 	if (ret)
- 		return ret;
-=20
- 	for (i =3D 0; i < cfg->gcl_size; i++) {
- 		ret =3D dwxgmac3_est_write(ioaddr, i, cfg->gcl[i], true);
- 		if (ret)
- 			return ret;
- 	}
-=20
- 	ctrl =3D readl(ioaddr + XGMAC_MTL_EST_CONTROL);
- 	ctrl &=3D ~XGMAC_PTOV;
- 	ctrl |=3D ((1000000000 / ptp_rate) * 9) << XGMAC_PTOV_SHIFT;
- 	if (cfg->enable)
- 		ctrl |=3D XGMAC_EEST | XGMAC_SSWL;
- 	else
- 		ctrl &=3D ~XGMAC_EEST;
-=20
- 	writel(ctrl, ioaddr + XGMAC_MTL_EST_CONTROL);
- 	return 0;
- }
-=20
 -static void dwxgmac3_fpe_configure(void __iomem *ioaddr, u32 num_txq,
 +static void dwxgmac3_fpe_configure(void __iomem *ioaddr, struct stmmac_fp=
e_cfg *cfg,
 +				   u32 num_txq,
  				   u32 num_rxq, bool enable)
  {
  	u32 value;
diff --cc drivers/net/ethernet/stmicro/stmmac/hwif.h
index 68aa2d5ca6e5,72412d733856..000000000000
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.h
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.h
@@@ -408,15 -419,9 +419,11 @@@ struct stmmac_ops=20
  				bool en, bool udp, bool sa, bool inv,
  				u32 match);
  	void (*set_arp_offload)(struct mac_device_info *hw, bool en, u32 addr);
- 	int (*est_configure)(void __iomem *ioaddr, struct stmmac_est *cfg,
- 			     unsigned int ptp_rate);
- 	void (*est_irq_status)(void __iomem *ioaddr, struct net_device *dev,
- 			       struct stmmac_extra_stats *x, u32 txqcnt);
 -	void (*fpe_configure)(void __iomem *ioaddr, u32 num_txq, u32 num_rxq,
 +	void (*fpe_configure)(void __iomem *ioaddr, struct stmmac_fpe_cfg *cfg,
 +			      u32 num_txq, u32 num_rxq,
  			      bool enable);
  	void (*fpe_send_mpacket)(void __iomem *ioaddr,
 +				 struct stmmac_fpe_cfg *cfg,
  				 enum stmmac_mpacket_type type);
  	int (*fpe_irq_status)(void __iomem *ioaddr, struct net_device *dev);
  };

--Sig_/Ywn_.bCg_=VIfBrJ+KiY.nh
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmVvujoACgkQAVBC80lX
0Gyb0gf/aaRcKm4HmpcrgeZ8qs9OSH7Q2xFtZJDhTrGR4jcMUHSinv8gyqUiEuvD
1GDEfMLfD+OQSPwl2Q5MXnZuZ86g18L2yEQ2eXJxJac0bON63DFJDXMfCi8COAWp
cydxfPSQ+/ybAsPjO+hYBJEouHIxmgC9W2cAssDiT4f6sD1ZWk10HkU+Qb1ARVeK
BOGULc06GE+upuPiTNjliWnq6NSvus/Wm7vbfh2yxXM2TRBqq/coGL2rS0aFb19I
B5Z9h3cbBrGp6+NeKE+LKEKrAYl2hDwTmsCiE7P3baELX61hhlbxK0m0mBGkyWf1
N7XLSWaWbH5xO7GIhFGWyzv0kQXkyA==
=WkX3
-----END PGP SIGNATURE-----

--Sig_/Ywn_.bCg_=VIfBrJ+KiY.nh--

