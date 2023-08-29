Return-Path: <netdev+bounces-31246-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54B0F78C509
	for <lists+netdev@lfdr.de>; Tue, 29 Aug 2023 15:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4D6528112E
	for <lists+netdev@lfdr.de>; Tue, 29 Aug 2023 13:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B128C156FC;
	Tue, 29 Aug 2023 13:20:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A8B156F3
	for <netdev@vger.kernel.org>; Tue, 29 Aug 2023 13:20:47 +0000 (UTC)
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98585184
	for <netdev@vger.kernel.org>; Tue, 29 Aug 2023 06:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1693315245; x=1724851245;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Rsg+3I5nwAao024D777CO27I/mKvRlEcVFmehdDKmio=;
  b=qBk5oV0SorUYAJsd96qDJB/ASh9j0BYc8HMzt+tM/GejieRfPYw4mHtb
   Yn2l2qNFdRwqTT8HfgkelosylFDmHDCLxWs8jpDCKXgEpEwEB4VDlJ4wE
   cCngoidBqr0tEevgLXG7y9G3f7i8lq+ABOSr8lYHPQe34q9iEE0DeGXjH
   89G4QICDRp38pfPknApW3E++JZnW/Um3Gke9n50uJVosAKxb6WLtxJi8s
   C/6LACR5IxQP5a3z+Rk/BHCvPoGfIFJzHp3DffTdZb3KfC9DMoqExdHS3
   Nfwn+sjXECVXLcEPdNW4XkC6eNH1v53SViiDgDvovcg+/z8doQGaksUqE
   g==;
X-IronPort-AV: E=Sophos;i="6.02,210,1688421600"; 
   d="scan'208";a="32678579"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 29 Aug 2023 15:20:43 +0200
Received: from steina-w.localnet (steina-w.tq-net.de [10.123.53.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 65E39280045;
	Tue, 29 Aug 2023 15:20:43 +0200 (CEST)
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Feiyang Chen <chenfeiyang@loongson.cn>, Heiner Kallweit <hkallweit1@gmail.com>, Jakub Kicinski <kuba@kernel.org>, linux-arm-kernel@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com, Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, Vladimir Zapolskiy <vz@mleia.com>, Emil Renner Berthing <kernel@esmil.dk>, Samin Guo <samin.guo@starfivetech.com>, Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno <angelogioacchino.
 delregno@collabora.com>, linux-sunxi@lists.linux.dev, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next] net: stmmac: clarify difference between "interface" and "phy_interface"
Date: Tue, 29 Aug 2023 15:20:43 +0200
Message-ID: <5966848.lOV4Wx5bFT@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <ZO3uUIFgtkIHHqjL@shell.armlinux.org.uk>
References: <E1qZq83-005tts-6K@rmk-PC.armlinux.org.uk> <12274852.O9o76ZdvQC@steina-w> <ZO3uUIFgtkIHHqjL@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Am Dienstag, 29. August 2023, 15:10:40 CEST schrieb Russell King (Oracle):
> On Tue, Aug 29, 2023 at 02:38:33PM +0200, Alexander Stein wrote:
> > > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> > > b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c index
> > > ff330423ee66..35f4b1484029 100644
> > > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> > > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> > > @@ -419,9 +419,9 @@ stmmac_probe_config_dt(struct platform_device *pd=
ev,
> > > u8
> > > *mac) return ERR_PTR(phy_mode);
> > >=20
> > >  	plat->phy_interface =3D phy_mode;
> > >=20
> > > -	plat->interface =3D stmmac_of_get_mac_mode(np);
> > > -	if (plat->interface < 0)
> > > -		plat->interface =3D plat->phy_interface;
> > > +	plat->mac_interface =3D stmmac_of_get_mac_mode(np);
> > > +	if (plat->mac_interface < 0)
> >=20
> > This check is never true as mac_interface is now an unsigned enum
> > (phy_interface_t). Thus mac_interface is not set to phy_interface
> > resulting in an invalid mac_interface. My platform
> > (arch/arm64/boot/dts/freescale/imx8mp- tqma8mpql-mba8mpxl.dts) fails to
> > probe now.
>=20
> Thanks for catching that. Does this patch fix it for you?
>=20
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c index
> 231152ee5a32..0451d2c2aa43 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> @@ -420,9 +420,9 @@ stmmac_probe_config_dt(struct platform_device *pdev, =
u8
> *mac) return ERR_PTR(phy_mode);
>=20
>  	plat->phy_interface =3D phy_mode;
> -	plat->interface =3D stmmac_of_get_mac_mode(np);
> -	if (plat->interface < 0)
> -		plat->interface =3D plat->phy_interface;
> +
> +	rc =3D stmmac_of_get_mac_mode(np);
> +	plat->interface =3D rc < 0 ? plat->phy_interface : rc;

I need to use plat->mac_interface on top of your patch. But despite that th=
is=20
fixes the probe error.

Thanks and best regards,
Alexander

>=20
>  	/* Some wrapper drivers still rely on phy_node. Let's save it while
>  	 * they are not converted to phylink. */


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



