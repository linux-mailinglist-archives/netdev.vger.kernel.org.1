Return-Path: <netdev+bounces-212042-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0671CB1D6E9
	for <lists+netdev@lfdr.de>; Thu,  7 Aug 2025 13:49:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21CC056052F
	for <lists+netdev@lfdr.de>; Thu,  7 Aug 2025 11:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F10301F4615;
	Thu,  7 Aug 2025 11:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="U60vL/HY";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="YZEKvmbQ"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A46C20B7F9;
	Thu,  7 Aug 2025 11:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754567345; cv=none; b=PLRUsBWbO+rCoOELNau5Uj1p0PaOCzatpj/NBYgOuAWTE+vOOjA9HQ9ckhO3SwDC0Wi+c8UyOIaXGAZPoE44XPGayxjRFFFHhx9gLG85ktGfIWT1B/KHKNujd2WOsuIXR1x5g5j7usLZTK6JZ6IiMwRBfDEWP+VNOghAwlff6YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754567345; c=relaxed/simple;
	bh=4Dfm16dtenqZus4B42uNTr1IMVz5WLJ9W5cHmjdS4zM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tUjy1erseDRZECm03k1weXmqJvh+ths5vumb2iZ+0M2lHXuvUyI7DdL/SJBxE6oI1UWPLIMfmVN3dn29fn2PA7BFMBao8b3BojSMPW/7JJ52sPrAL9tposKjVzu0Ev41PRQHrTolAxyPcPZZUIm/I+ebNap3cp87J1j51FPh9U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=U60vL/HY; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=YZEKvmbQ reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1754567341; x=1786103341;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=i4uPAJ9IW9vl88ePcdpKzjtiZLMIb7GgbwNe3+1BvWY=;
  b=U60vL/HYE98SySrBhYoGQydt9LI2SAjQu4ASfJojDgKjV9Vtf/Nl9pp8
   DgRz+ZD/9tkc+EiAWkz5WUI5nJyPv+wjBtAhn3z49uLTbjcWn4y0Tz2xT
   BjfLiREaKoFxhhwI8Hr1Nz6C8xLaysvDCA1cW2JMxl3dNdwnaB4Ku9/th
   aQNXwx+d27jgEiNPsX3SgYQ3AFExXz9unp8lcH85Z7dFCTLbM3suNy2vA
   05G2qgIA7dOvRsFfX3QpT+nQeYgBzoM63OMg6o1zs0e3/qefculF8TWsl
   XtfASwLJaM3rJeSWitOU0oZ+Jhgy+T5XFVMDlcYOi3/dFHeLIewEhPvtZ
   A==;
X-CSE-ConnectionGUID: JhyOYoELRGids6Bki+OUFQ==
X-CSE-MsgGUID: MWiHtDpCT6Gx+H7wzZdvGQ==
X-IronPort-AV: E=Sophos;i="6.17,271,1747692000"; 
   d="scan'208";a="45636873"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 07 Aug 2025 13:48:58 +0200
X-CheckPoint: {689492AA-4-410E8DD8-CEA8F0F8}
X-MAIL-CPID: DB5FC63FD761EBF6D413EA6E6EFE8B37_3
X-Control-Analysis: str=0001.0A00211B.6894924C.001C,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8A688160F56;
	Thu,  7 Aug 2025 13:48:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1754567333;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i4uPAJ9IW9vl88ePcdpKzjtiZLMIb7GgbwNe3+1BvWY=;
	b=YZEKvmbQVMlloS5TBtRx2jH63mxAKDXRmp81JNNnnORSKU65/CXFVB4N7q/JCJyI8NtVIg
	lE9IhQN6SaJRWHltDgRY/9dDZO43cbUlx8KQ32bnqCGyfiIMaI7eiwGu33SIot7wwgVQ/o
	b4IxJib7SlKv3XFzErmdh1nIgwXsb/uVwGLgB5j2DbEXG6p+WChtd300JvPe/vR9t/4T/A
	vjpFiTogyMpRD4ccus+sBNvweEOpOmdnsRy76uyrnHo8uDsGuuH3wfZ2r/Dvz6WjB1tF9x
	vT6Wk/a1+ulF4sGtukHQE2vvb9J+LlSn5GAvOnp0YFtBRbxjYs/gAFt69n7qkw==
Message-ID: <e659763b2535701e9061d0a19e1ce9c285d92045.camel@ew.tq-group.com>
Subject: Re: [PATCH v2] phy: ti: gmii-sel: Force RGMII TX delay
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Michael Walle <mwalle@kernel.org>
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>, Andrew Lunn <andrew@lunn.ch>, 
 linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, nm@ti.com, vigneshr@ti.com, Vinod Koul
 <vkoul@kernel.org>,  Kishon Vijay Abraham I <kishon@kernel.org>
Date: Thu, 07 Aug 2025 13:48:52 +0200
In-Reply-To: <20250806135913.662340-1-mwalle@kernel.org>
References: <20250806135913.662340-1-mwalle@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Last-TLS-Session-Version: TLSv1.3

On Wed, 2025-08-06 at 15:59 +0200, Michael Walle wrote:
> Some SoCs are just validated with the TX delay enabled. With commit
> ca13b249f291 ("net: ethernet: ti: am65-cpsw: fixup PHY mode for fixed
> RGMII TX delay"), the network driver will patch the delay setting on the
> fly assuming that the TX delay is fixed. In reality, the TX delay is
> configurable and just skipped in the documentation. There are
> bootloaders, which will disable the TX delay and this will lead to a
> transmit path which doesn't add any delays at all. Fix that by always
> forcing the TX delay to be enabled.
>=20
> This is safe to do and shouldn't break any boards in mainline because
> the fixed delay is only introduced for gmii-sel compatibles which are
> used together with the am65-cpsw-nuss driver and are affected by the
> commit above.
>=20
> Fixes: ca13b249f291 ("net: ethernet: ti: am65-cpsw: fixup PHY mode for fi=
xed RGMII TX delay")
> Signed-off-by: Michael Walle <mwalle@kernel.org>
> ---
> v2:
>  - reject invalid PHY modes. Thanks Matthias.
>  - add a paragraph to the commit message that this patch shouldn't
>    break any existing boards. Thanks Andrew.
>=20
>  drivers/phy/ti/phy-gmii-sel.c | 58 ++++++++++++++++++++++++++++++-----
>  1 file changed, 50 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/phy/ti/phy-gmii-sel.c b/drivers/phy/ti/phy-gmii-sel.=
c
> index ff5d5e29629f..ed078475c4cb 100644
> --- a/drivers/phy/ti/phy-gmii-sel.c
> +++ b/drivers/phy/ti/phy-gmii-sel.c
> @@ -34,6 +34,7 @@ enum {
>  	PHY_GMII_SEL_PORT_MODE =3D 0,
>  	PHY_GMII_SEL_RGMII_ID_MODE,
>  	PHY_GMII_SEL_RMII_IO_CLK_EN,
> +	PHY_GMII_SEL_FIXED_TX_DELAY,
>  	PHY_GMII_SEL_LAST,
>  };
> =20
> @@ -127,6 +128,22 @@ static int phy_gmii_sel_mode(struct phy *phy, enum p=
hy_mode mode, int submode)
>  		goto unsupported;
>  	}
> =20
> +	/*
> +	 * Some SoCs only support fixed MAC side TX delays. According to the
> +	 * datasheet, they are always enabled, but that turns out not to be the
> +	 * case and the delay is configurable. But according to the vendor that
> +	 * mode is not validated and might not work. Some bootloaders disable
> +	 * this bit. To work around that, enable it again.
> +	 */
> +	if (soc_data->features & BIT(PHY_GMII_SEL_FIXED_TX_DELAY)) {
> +		/* With a fixed delay, some modes are not supported at all. */
> +		if (submode =3D=3D PHY_INTERFACE_MODE_RGMII_ID ||
> +		    submode =3D=3D PHY_INTERFACE_MODE_RGMII_TXID)
> +			return -EINVAL;
> +
> +		rgmii_id =3D 0;

Can't this just be the following? (maybe with an error message)

if (soc_data->features & BIT(PHY_GMII_SEL_FIXED_TX_DELAY)) {
	if (rgmii_id !=3D 0)
		return -EINVAL;
}



Best,
Matthias

> +	}
> +
>  	if_phy->phy_if_mode =3D submode;
> =20
>  	dev_dbg(dev, "%s id:%u mode:%u rgmii_id:%d rmii_clk_ext:%d\n",
> @@ -210,25 +227,46 @@ struct phy_gmii_sel_soc_data phy_gmii_sel_soc_dm814=
 =3D {
> =20
>  static const
>  struct reg_field phy_gmii_sel_fields_am654[][PHY_GMII_SEL_LAST] =3D {
> -	{ [PHY_GMII_SEL_PORT_MODE] =3D REG_FIELD(0x0, 0, 2), },
> -	{ [PHY_GMII_SEL_PORT_MODE] =3D REG_FIELD(0x4, 0, 2), },
> -	{ [PHY_GMII_SEL_PORT_MODE] =3D REG_FIELD(0x8, 0, 2), },
> -	{ [PHY_GMII_SEL_PORT_MODE] =3D REG_FIELD(0xC, 0, 2), },
> -	{ [PHY_GMII_SEL_PORT_MODE] =3D REG_FIELD(0x10, 0, 2), },
> -	{ [PHY_GMII_SEL_PORT_MODE] =3D REG_FIELD(0x14, 0, 2), },
> -	{ [PHY_GMII_SEL_PORT_MODE] =3D REG_FIELD(0x18, 0, 2), },
> -	{ [PHY_GMII_SEL_PORT_MODE] =3D REG_FIELD(0x1C, 0, 2), },
> +	{
> +		[PHY_GMII_SEL_PORT_MODE] =3D REG_FIELD(0x0, 0, 2),
> +		[PHY_GMII_SEL_RGMII_ID_MODE] =3D REG_FIELD(0x0, 4, 4),
> +	}, {
> +		[PHY_GMII_SEL_PORT_MODE] =3D REG_FIELD(0x4, 0, 2),
> +		[PHY_GMII_SEL_RGMII_ID_MODE] =3D REG_FIELD(0x4, 4, 4),
> +	}, {
> +		[PHY_GMII_SEL_PORT_MODE] =3D REG_FIELD(0x8, 0, 2),
> +		[PHY_GMII_SEL_RGMII_ID_MODE] =3D REG_FIELD(0x8, 4, 4),
> +	}, {
> +		[PHY_GMII_SEL_PORT_MODE] =3D REG_FIELD(0xC, 0, 2),
> +		[PHY_GMII_SEL_RGMII_ID_MODE] =3D REG_FIELD(0xC, 4, 4),
> +	}, {
> +		[PHY_GMII_SEL_PORT_MODE] =3D REG_FIELD(0x10, 0, 2),
> +		[PHY_GMII_SEL_RGMII_ID_MODE] =3D REG_FIELD(0x10, 4, 4),
> +	}, {
> +		[PHY_GMII_SEL_PORT_MODE] =3D REG_FIELD(0x14, 0, 2),
> +		[PHY_GMII_SEL_RGMII_ID_MODE] =3D REG_FIELD(0x14, 4, 4),
> +	}, {
> +		[PHY_GMII_SEL_PORT_MODE] =3D REG_FIELD(0x18, 0, 2),
> +		[PHY_GMII_SEL_RGMII_ID_MODE] =3D REG_FIELD(0x18, 4, 4),
> +	}, {
> +		[PHY_GMII_SEL_PORT_MODE] =3D REG_FIELD(0x1C, 0, 2),
> +		[PHY_GMII_SEL_RGMII_ID_MODE] =3D REG_FIELD(0x1C, 4, 4),
> +	},
>  };
> =20
>  static const
>  struct phy_gmii_sel_soc_data phy_gmii_sel_soc_am654 =3D {
>  	.use_of_data =3D true,
> +	.features =3D BIT(PHY_GMII_SEL_RGMII_ID_MODE) |
> +		    BIT(PHY_GMII_SEL_FIXED_TX_DELAY),
>  	.regfields =3D phy_gmii_sel_fields_am654,
>  };
> =20
>  static const
>  struct phy_gmii_sel_soc_data phy_gmii_sel_cpsw5g_soc_j7200 =3D {
>  	.use_of_data =3D true,
> +	.features =3D BIT(PHY_GMII_SEL_RGMII_ID_MODE) |
> +		    BIT(PHY_GMII_SEL_FIXED_TX_DELAY),
>  	.regfields =3D phy_gmii_sel_fields_am654,
>  	.extra_modes =3D BIT(PHY_INTERFACE_MODE_QSGMII) | BIT(PHY_INTERFACE_MOD=
E_SGMII) |
>  		       BIT(PHY_INTERFACE_MODE_USXGMII),
> @@ -239,6 +277,8 @@ struct phy_gmii_sel_soc_data phy_gmii_sel_cpsw5g_soc_=
j7200 =3D {
>  static const
>  struct phy_gmii_sel_soc_data phy_gmii_sel_cpsw9g_soc_j721e =3D {
>  	.use_of_data =3D true,
> +	.features =3D BIT(PHY_GMII_SEL_RGMII_ID_MODE) |
> +		    BIT(PHY_GMII_SEL_FIXED_TX_DELAY),
>  	.regfields =3D phy_gmii_sel_fields_am654,
>  	.extra_modes =3D BIT(PHY_INTERFACE_MODE_QSGMII) | BIT(PHY_INTERFACE_MOD=
E_SGMII),
>  	.num_ports =3D 8,
> @@ -248,6 +288,8 @@ struct phy_gmii_sel_soc_data phy_gmii_sel_cpsw9g_soc_=
j721e =3D {
>  static const
>  struct phy_gmii_sel_soc_data phy_gmii_sel_cpsw9g_soc_j784s4 =3D {
>  	.use_of_data =3D true,
> +	.features =3D BIT(PHY_GMII_SEL_RGMII_ID_MODE) |
> +		    BIT(PHY_GMII_SEL_FIXED_TX_DELAY),
>  	.regfields =3D phy_gmii_sel_fields_am654,
>  	.extra_modes =3D BIT(PHY_INTERFACE_MODE_QSGMII) | BIT(PHY_INTERFACE_MOD=
E_SGMII) |
>  		       BIT(PHY_INTERFACE_MODE_USXGMII),

--=20
TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld, Germ=
any
Amtsgericht M=C3=BCnchen, HRB 105018
Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stefan Sch=
neider
https://www.tq-group.com/

