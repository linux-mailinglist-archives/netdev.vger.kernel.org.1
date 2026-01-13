Return-Path: <netdev+bounces-249250-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C6992D16453
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 03:19:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C4FB1300F72A
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 02:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E28A2BEFFB;
	Tue, 13 Jan 2026 02:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="gb3o+ZcR"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2BE257423;
	Tue, 13 Jan 2026 02:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768270760; cv=none; b=AyPHsG7rMj7kUeuXF4zkOvD+W9wc6/TA3ImWaASp4hMAmvtY/ULoobXsLzE/ItIy2cLph/o7qtHJKMtY250KmXMYSD5GMEovNdTKLj2S7v4qSLeErMILw/BLlNkhlOaxHZ+rc/N7LE8vI/4IPfgfU5yvCDIKv0hKQ5ssbnEh4Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768270760; c=relaxed/simple;
	bh=TJn0iiD3S1e1mJdBvUIfALaRjCn9XNtxKFmkEP8NGYs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lJbYyk72h3C0yqFGdXhNTKvg9hqH8BpBH1zTmRKwvahmXsaVGXj9u0d8c0NCdGKRL7/7J3obed/c0dX1D4/mlKEEMcbo2a2w/aI2V9jX0xAf6ZO+iDcGbRzHvN1R4gR/q1Yk658HCYIf02IoOu2ejEkJvU9XbaePECsq4QbsJXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=gb3o+ZcR; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 60D2IkHK22110009, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1768270727;
	bh=/7UYmLXIsEPCx4Cb3ttL8SM1JRy/evR1z1ykAtNkesw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=gb3o+ZcRNG2f0ycYh4rA4qNiHIXkTIlfeq78hcVv7sF33xWaY6jawMvlX7iqQ9CxY
	 CWgUqipMcS7zy0BedQpga/N9XX+F1hnK3gyt3BWYQ+WtIsu6l9NCUdS8mpCOlAfLJI
	 9BK/vIDVR5uf2iGVs5qholuVSmSoDfHcWKzm876HqPNVfnEhXVXI88eQJw+zSg4JTm
	 ZgCCUYSsMpxzyQUna9ffHsnKN9NYHpdRKDthHljrvHWQ5BuAB+758Fm4Q+1gvbCk1n
	 cRDD4GpL25QYpkX2DZgoO3QuSaFtqRH+DK6EIVWgbl8exi3cQ4e+nBq4ZmftvkdaCf
	 TG/GuJ/f9DZzw==
Received: from RS-EX-MBS3.realsil.com.cn ([172.29.17.103])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 60D2IkHK22110009
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 13 Jan 2026 10:18:46 +0800
Received: from RS-EX-MBS2.realsil.com.cn (172.29.17.102) by
 RS-EX-MBS3.realsil.com.cn (172.29.17.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.39; Tue, 13 Jan 2026 10:18:45 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS2.realsil.com.cn
 (172.29.17.102) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Tue, 13 Jan 2026 10:18:45 +0800
From: javen <javen_xu@realsil.com.cn>
To: <hkallweit1@gmail.com>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <horms@kernel.org>, <javen_xu@realsil.com.cn>, <kuba@kernel.org>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <nic_swsd@realtek.com>, <pabeni@redhat.com>
Subject: Re: [PATCH net-next v1 3/3] r8169: add support for chip RTL9151AS
Date: Tue, 13 Jan 2026 10:18:44 +0800
Message-ID: <20260113021845.411-1-javen_xu@realsil.com.cn>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <02c00a95-34c6-4b01-8f0a-7dbd113e26ba@gmail.com>
References: <02c00a95-34c6-4b01-8f0a-7dbd113e26ba@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain

> On 1/12/2026 3:45 AM, javen wrote:=0D
> > From: Javen Xu <javen_xu@realsil.com.cn>=0D
> >=0D
> > This patch adds support for chip RTL9151AS. Since lacking of Hardware=0D
> > version IDs, we use TX_CONFIG_V2 to recognize RTL9151AS and coming=0D
> chips.=0D
> > rtl_chip_infos_extend is used to store IC information for RTL9151AS=0D
> > and coming chips. The TxConfig value between RTL9151AS and RTL9151A is=
=0D
> >=0D
> > different.=0D
> >=0D
> > Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>=0D
> > ---=0D
> >  drivers/net/ethernet/realtek/r8169.h      |  3 ++-=0D
> >  drivers/net/ethernet/realtek/r8169_main.c | 28=0D
> > +++++++++++++++++++++--=0D
> >  2 files changed, 28 insertions(+), 3 deletions(-)=0D
> >=0D
> > diff --git a/drivers/net/ethernet/realtek/r8169.h=0D
> > b/drivers/net/ethernet/realtek/r8169.h=0D
> > index 2c1a0c21af8d..f66c279cbee6 100644=0D
> > --- a/drivers/net/ethernet/realtek/r8169.h=0D
> > +++ b/drivers/net/ethernet/realtek/r8169.h=0D
> > @@ -72,7 +72,8 @@ enum mac_version {=0D
> >       RTL_GIGA_MAC_VER_70,=0D
> >       RTL_GIGA_MAC_VER_80,=0D
> >       RTL_GIGA_MAC_NONE,=0D
> > -     RTL_GIGA_MAC_VER_LAST =3D RTL_GIGA_MAC_NONE - 1=0D
> > +     RTL_GIGA_MAC_VER_LAST =3D RTL_GIGA_MAC_NONE - 1,=0D
> > +     RTL_GIGA_MAC_VER_CHECK_EXTEND=0D
> >  };=0D
> >=0D
> >  struct rtl8169_private;=0D
> > diff --git a/drivers/net/ethernet/realtek/r8169_main.c=0D
> > b/drivers/net/ethernet/realtek/r8169_main.c=0D
> > index 9b89bbf67198..164ad6570059 100644=0D
> > --- a/drivers/net/ethernet/realtek/r8169_main.c=0D
> > +++ b/drivers/net/ethernet/realtek/r8169_main.c=0D
> > @@ -95,8 +95,8 @@=0D
> >  #define JUMBO_16K    (SZ_16K - VLAN_ETH_HLEN - ETH_FCS_LEN)=0D
> >=0D
> >  static const struct rtl_chip_info {=0D
> > -     u16 mask;=0D
> > -     u16 val;=0D
> > +     u32 mask;=0D
> > +     u32 val;=0D
> >       enum mac_version mac_version;=0D
> >       const char *name;=0D
> >       const char *fw_name;=0D
> > @@ -205,10 +205,20 @@ static const struct rtl_chip_info {=0D
> >       { 0xfc8, 0x040, RTL_GIGA_MAC_VER_03, "RTL8110s" },=0D
> >       { 0xfc8, 0x008, RTL_GIGA_MAC_VER_02, "RTL8169s" },=0D
> >=0D
> > +     /* extend chip version*/=0D
> > +     { 0x7cf, 0x7c8, RTL_GIGA_MAC_VER_CHECK_EXTEND },=0D
> > +=0D
> >       /* Catch-all */=0D
> >       { 0x000, 0x000, RTL_GIGA_MAC_NONE }  };=0D
> >=0D
> > +static const struct rtl_chip_info rtl_chip_infos_extend[] =3D {=0D
> > +     { 0x7fffffff, 0x00000000, RTL_GIGA_MAC_VER_64, "RTL9151AS",=0D
> > +FIRMWARE_9151A_1},=0D
> > +=0D
> =0D
> Seems all bits except bit 31 are used for chip detection. However registe=
r is=0D
> named TX_CONFIG_V2, even though only bit 31 is left for actual tx=0D
> configuration.=0D
> Is the register name misleading, or is the mask incorrect?=0D
> =0D
=0D
Previously, we used TxConfig for chip detection. But considering that the =
=0D
remaining version IDs are limited, we need to extend it. To remain the =0D
consistency of name, we choose TX_CONFIG_V2 to extend it. Bit 31 is =0D
reserved and always 0. Only if nic link drop, it will be set to 1.=0D
 =0D
> > +     /* Catch-all */=0D
> > +     { 0x00000000, 0x00000000, RTL_GIGA_MAC_NONE } };=0D
> > +=0D
> >  static const struct pci_device_id rtl8169_pci_tbl[] =3D {=0D
> >       { PCI_VDEVICE(REALTEK,  0x2502) },=0D
> >       { PCI_VDEVICE(REALTEK,  0x2600) }, @@ -255,6 +265,8 @@ enum=0D
> > rtl_registers {=0D
> >       IntrStatus      =3D 0x3e,=0D
> >=0D
> >       TxConfig        =3D 0x40,=0D
> > +     /* Extend version register */=0D
> > +     TX_CONFIG_V2    =3D 0x60b0,=0D
> >  #define      TXCFG_AUTO_FIFO                 (1 << 7)        /* 8111e-=
vl */=0D
> >  #define      TXCFG_EMPTY                     (1 << 11)       /* 8111e-=
vl */=0D
> >=0D
> > @@ -2351,6 +2363,15 @@ static const struct ethtool_ops=0D
> rtl8169_ethtool_ops =3D {=0D
> >       .get_eth_ctrl_stats     =3D rtl8169_get_eth_ctrl_stats,=0D
> >  };=0D
> >=0D
> > +static const struct rtl_chip_info=0D
> > +*rtl8169_get_extend_chip_version(u32 txconfigv2) {=0D
> > +     const struct rtl_chip_info *p =3D rtl_chip_infos_extend;=0D
> > +=0D
> > +     while ((txconfigv2 & p->mask) !=3D p->val)=0D
> > +             p++;=0D
> > +     return p;=0D
> > +}=0D
> > +=0D
> >  static const struct rtl_chip_info *rtl8169_get_chip_version(u16 xid,=0D
> > bool gmii)  {=0D
> >       /* Chips combining a 1Gbps MAC with a 100Mbps PHY */ @@ -5543,6=0D
> > +5564,9 @@ static int rtl_init_one(struct pci_dev *pdev, const struct=0D
> > pci_device_id *ent)=0D
> >=0D
> >       /* Identify chip attached to board */=0D
> >       chip =3D rtl8169_get_chip_version(xid, tp->supports_gmii);=0D
> > +=0D
> > +     if (chip->mac_version =3D=3D RTL_GIGA_MAC_VER_CHECK_EXTEND)=0D
> > +             chip =3D rtl8169_get_extend_chip_version(RTL_R32(tp,=0D
> > + TX_CONFIG_V2));=0D
> >       if (chip->mac_version =3D=3D RTL_GIGA_MAC_NONE)=0D
> >               return dev_err_probe(&pdev->dev, -ENODEV,=0D
> >                                    "unknown chip XID %03x, contact=0D
> > r8169 maintainers (see MAINTAINERS file)\n",=

