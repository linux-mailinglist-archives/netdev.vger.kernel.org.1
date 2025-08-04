Return-Path: <netdev+bounces-211606-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 203B5B1A562
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 16:59:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD9AE3B3761
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 14:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E7BE20A5F3;
	Mon,  4 Aug 2025 14:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="pFVdMTG0";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="Q+CSfJJG"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D51202C48;
	Mon,  4 Aug 2025 14:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754319586; cv=none; b=conUOY+ekhvfLaqUiXU9S3KAg1eqSrlqDLjGPLWGhiLnjg72SRMLXhr1u7LAja50GxraRvsYnGmUjxtHPNnCGOsYfERzH+lnlbKSBBSRLrUN9daAjFf0EHipDLBbTR/JBjqwR8csm30SBNFwpkf1CGnrrPCeYyYKOfhOKnxjgK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754319586; c=relaxed/simple;
	bh=qslvpgSPQVNPfES6FMAqcUkv0Ja3oSTYgdRkbFjlhig=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=d/OfzqklpErckhYEoOjHYDCXyt4WXigMlbXptfV7cWPxiCvX5cDJ1nUYSHoSR0zqDi1x4qqQJ3I+fLlGW7Pqz3Sd2HOgAxdK4PEGM5NbCOxwvXZKM8BB9NYArfXL+YhEgp2nNhAZM0i4bkqU49te4BXuJN76Y9r3hvy92PJzisg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=pFVdMTG0; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=Q+CSfJJG reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1754319582; x=1785855582;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=MkfIX3ZMBulcVFVuwO2zoj4dBD5Ai/L7cAOlg+iF3Jk=;
  b=pFVdMTG0UZVtIa2+fxfMUWpoBESd7E3GxAERl5n3B2mS/yGURnDpayds
   8jWpZ4e4bzj0g5v+VKXQSaM7mPyaMpQ96ZkChsW/LJPXx5yVge/M1QGKy
   NWF/ri+m5WB+JLOEKeGZw2Gb6oXAkp7T6KgmGhPbk4zMspcX0ghboVejZ
   cDfofiQVC61BdjCqrCqFhsJKLp9DcuNjo/7PrZ5IH1hFYqoMHLWmYoUDP
   +OTGwUznuZllZ1i82cOL9c+P+EYVdVC1731Pcz19uxy5gcFnu/aceoBWo
   8vEQeY8MnOkh32ubAAe39PnuKsrtzf7dLypYsAsaalxnF9U8NvPZfzjKh
   g==;
X-CSE-ConnectionGUID: OsXyHa9zSmCC7MQXBA011Q==
X-CSE-MsgGUID: NyNxjxqRST6VMUC5QDS0Xg==
X-IronPort-AV: E=Sophos;i="6.17,258,1747692000"; 
   d="scan'208";a="45574052"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 04 Aug 2025 16:59:38 +0200
X-CheckPoint: {6890CAD9-17-B55D79DF-CE943F87}
X-MAIL-CPID: 764733419859115D6BB5CFE5A12E32E5_5
X-Control-Analysis: str=0001.0A00211C.6890CADC.0070,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DF171163678;
	Mon,  4 Aug 2025 16:59:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1754319573;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MkfIX3ZMBulcVFVuwO2zoj4dBD5Ai/L7cAOlg+iF3Jk=;
	b=Q+CSfJJGcwfGOaPlXrjM/gru8Wml+0BCPZ/2ELxa7WqptbzZ5ihfXVeL/SSYiR3hcgYR9l
	yEYuZ+C5IVyli+rmG7zSMhlK3nc1+tEyKPVeHJCxW/2KcaXvsgMFX84L2vCB0uaEfBRZmE
	NOuykwvi0znao1i8GjhC3d3CjRAwqUnKZF6+pwCupRDDc6VR66TxPtmXU5bptlsLjzH8aY
	MPOwf4B0nsEqJjO0gD3hcU3jHM/pqlplkvP7oAQ1MHtX1SORZuAFac4DXeIessSHfXKU4e
	q0tFcG3B/JYy9+aVg5upRzsWZvIBP0wJax6H9O0m9ZmLKmmUIjIhHZAOnZVY2g==
Message-ID: <b2c38da8e02b5d5de3f1a2c514e7e84f43ee2400.camel@ew.tq-group.com>
Subject: Re: [PATCH] phy: ti: gmii-sel: Force RGMII TX delay
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Michael Walle <mwalle@kernel.org>
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>, Andrew Lunn <andrew@lunn.ch>, 
 linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, nm@ti.com, vigneshr@ti.com, Vinod Koul
 <vkoul@kernel.org>,  Kishon Vijay Abraham I <kishon@kernel.org>
Date: Mon, 04 Aug 2025 16:59:32 +0200
In-Reply-To: <20250804140652.539589-1-mwalle@kernel.org>
References: <20250804140652.539589-1-mwalle@kernel.org>
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

On Mon, 2025-08-04 at 16:06 +0200, Michael Walle wrote:
> Some SoCs are just validated with the TX delay enabled. With commit
> ca13b249f291 ("net: ethernet: ti: am65-cpsw: fixup PHY mode for fixed
> RGMII TX delay"), the network driver will patch the delay setting on the
> fly assuming that the TX delay is fixed. In reality, the TX delay is
> configurable and just skipped in the documentation. There are
> bootloaders, which will disable the TX delay and this will lead to a
> transmit path which doesn't add any delays at all. Fix that by always
> forcing the TX delay to be enabled.
>=20
> Fixes: ca13b249f291 ("net: ethernet: ti: am65-cpsw: fixup PHY mode for fi=
xed RGMII TX delay")
> Signed-off-by: Michael Walle <mwalle@kernel.org>
> ---
>  drivers/phy/ti/phy-gmii-sel.c | 52 +++++++++++++++++++++++++++++------
>  1 file changed, 44 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/phy/ti/phy-gmii-sel.c b/drivers/phy/ti/phy-gmii-sel.=
c
> index ff5d5e29629f..a0c19d00ff3a 100644
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
> @@ -127,6 +128,16 @@ static int phy_gmii_sel_mode(struct phy *phy, enum p=
hy_mode mode, int submode)
>  		goto unsupported;
>  	}
> =20
> +	/*
> +	 * Some SoCs only support fixed MAC side TX delays. According to the
> +	 * datasheet, they are always enabled, but that turns out not to be the
> +	 * case and the delay is configurable. But according to the vendor that
> +	 * mode is not validated and might not work. Some bootloaders disable
> +	 * that bit. To work around that enable it again.
> +	 */
> +	if (soc_data->features & BIT(PHY_GMII_SEL_FIXED_TX_DELAY))
> +		rgmii_id =3D 0;

The mode passed to phy_gmii_sel_mode by am65-cpsw is the same value that is
passed to the Ethernet PHY driver, so a case where rgmii_id =3D=3D 1 and wo=
uld be
reset to 0 is unreachable (PHY_INTERFACE_MODE_RGMII_ID and
PHY_INTERFACE_MODE_RGMII_TXID can't occur with the fixup in am65-cpsw).
Therefore we could return EINVAL here if PHY_GMII_SEL_FIXED_TX_DELAY is set=
 and
rgmii_id =3D=3D 1 instead of effectively ignoring the mode, which seems a b=
it more
robust to me.

Best,
Matthias


> +
>  	if_phy->phy_if_mode =3D submode;
> =20
>  	dev_dbg(dev, "%s id:%u mode:%u rgmii_id:%d rmii_clk_ext:%d\n",
> @@ -210,25 +221,46 @@ struct phy_gmii_sel_soc_data phy_gmii_sel_soc_dm814=
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
> @@ -239,6 +271,8 @@ struct phy_gmii_sel_soc_data phy_gmii_sel_cpsw5g_soc_=
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
> @@ -248,6 +282,8 @@ struct phy_gmii_sel_soc_data phy_gmii_sel_cpsw9g_soc_=
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

