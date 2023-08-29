Return-Path: <netdev+bounces-31280-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D712078C6CE
	for <lists+netdev@lfdr.de>; Tue, 29 Aug 2023 16:05:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AA9E2811F8
	for <lists+netdev@lfdr.de>; Tue, 29 Aug 2023 14:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1A1117753;
	Tue, 29 Aug 2023 14:05:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A5C14AA7
	for <netdev@vger.kernel.org>; Tue, 29 Aug 2023 14:05:12 +0000 (UTC)
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CED2CD1
	for <netdev@vger.kernel.org>; Tue, 29 Aug 2023 07:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1693317906; x=1724853906;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HIjB6DSGcDiXSyJUkfXprhzVVBjmfilf4Wii2YLRbOw=;
  b=oiQKfJANMP30n/nTDZpQs3IrnBL0+RhY4JVpdxNDsqJ8IsHffP+5mzFn
   aIBmlyFtDStHBJoSbsovTf173nbjYJc/JlVWpCqYOLeDNHK1fcJRMzAkt
   3yZjNpAFxupk1xuDkSJnUQejsDW5xBFGpZ2HkzJqHDdTPxoEsJVEDaFtN
   lH9czGadEzZOvqRmJ/FJT3Otmjuq3m0A6eIvyj6LCXM8ChTBgaZLPdZKK
   Vsz8GLdb8JtaCWqVRr1gOfwJhdMt+6nAI1YNnvT09ydPQMLkKjMT+v6eh
   CUIQnCJze3A2g7bXNPocLZpfybvGdUdzZelYunLa8EMq9dhagGFNZsPk0
   Q==;
X-IronPort-AV: E=Sophos;i="6.02,210,1688421600"; 
   d="scan'208";a="32680003"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 29 Aug 2023 16:05:04 +0200
Received: from steina-w.localnet (steina-w.tq-net.de [10.123.53.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 0271E280045;
	Tue, 29 Aug 2023 16:05:03 +0200 (CEST)
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next] net: stmmac: failure to probe without MAC interface specified
Date: Tue, 29 Aug 2023 16:05:03 +0200
Message-ID: <4507976.LvFx2qVVIh@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <E1qayn0-006Q8J-GE@rmk-PC.armlinux.org.uk>
References: <E1qayn0-006Q8J-GE@rmk-PC.armlinux.org.uk>
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

Am Dienstag, 29. August 2023, 15:29:50 CEST schrieb Russell King (Oracle):
> Alexander Stein reports that commit a014c35556b9 ("net: stmmac: clarify
> difference between "interface" and "phy_interface"") caused breakage,
> because plat->mac_interface will never be negative. Fix this by using
> the "rc" temporary variable in stmmac_probe_config_dt().
>=20
> Reported-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
> I don't think the net tree is up to date with the net-next, so this
> patch needs applying to net-next preferably before the pull request
> to fix a regression.

On top of next-20230829:
Tested-by: Alexander Stein <alexander.stein@ew.tq-group.com>

Thanks

> Thanks.
>=20
>  drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c index
> 35f4b1484029..0f28795e581c 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> @@ -419,9 +419,8 @@ stmmac_probe_config_dt(struct platform_device *pdev, =
u8
> *mac) return ERR_PTR(phy_mode);
>=20
>  	plat->phy_interface =3D phy_mode;
> -	plat->mac_interface =3D stmmac_of_get_mac_mode(np);
> -	if (plat->mac_interface < 0)
> -		plat->mac_interface =3D plat->phy_interface;
> +	rc =3D stmmac_of_get_mac_mode(np);
> +	plat->mac_interface =3D rc < 0 ? plat->phy_interface : rc;
>=20
>  	/* Some wrapper drivers still rely on phy_node. Let's save it while
>  	 * they are not converted to phylink. */


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



