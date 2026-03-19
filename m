Return-Path: <netdev+bounces-269362-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yLP9MIC5u2mtmwIAu9opvQ
	(envelope-from <netdev+bounces-269362-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 09:53:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 418E32C81AE
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 09:53:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BC7B73013886
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 08:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FDAB3612D2;
	Thu, 19 Mar 2026 08:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="W3qBLApM"
X-Original-To: netdev@vger.kernel.org
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6F023ABBF;
	Thu, 19 Mar 2026 08:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.3.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773910394; cv=none; b=HgTrxT0All5ZBbXKnp555MLHdt6jX5wmyA7HrP52MoZe10OSEHQJOQGuGo1LqjF7aKTbxXEuGvcnkJTPKZ5ao8KMvqFU5hSqUIbpmWZ4d+fsxqgTLn7N3q31SDbmjtpXqhVQWjwP7olsZ92Bh+AM/xcRWl43ykbLi5msRo7t7Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773910394; c=relaxed/simple;
	bh=XcgTkBn1hvnVeb3QtXPkrP+XToR4/t8Vz09bJHiC/Fc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Bd/kSNHpj6ji//pklLpDdchQPvh3zCwTgZCiLH4fYBHzC+HOxupJmMSppfS2NkhDOc4rGPv8Ik78YpUFJ7aKzj589HZF+GScr9sSWcxVro1Zku3mTWFf9VbB0ITQEi02/BhfgrHC9I9qsH5desHYGGdv8Rd8WXq+XdG449Zy1t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=W3qBLApM; arc=none smtp.client-ip=188.40.3.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=ew.tq-group.com; s=default2602; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=Cy4910z4yKJ6chHebZmM0+S0xkDCsGUvQzxCGdWrqlo=; b=W3qBLApMiwlOSyK7y9elQXdTFi
	Ic0InLtfkfyj1C62uw3fTiOnT+O35+LH4qoEWpSFVLiOJKHcuyrOPj4cl7gOUKW2yyZ3LXWl6Pbyn
	mMBFpnsXxRWDN7EWDUM50FKvaIWP4C01mMX7o9WTRt8SPK18qccGeHVvbxm96fvqq0T/NHc0Xf4Va
	toG7EHiV0OA9zZTf6fIByGYVeqh2CJGFC+ybWqLlGa7pqlNAx8t+x7wKFe1i3oyQRmMd3DGzG96N0
	ZYJdmolg1BIT0yEwkQGihJQYjVxe5nAuGmedBO4Fv4wW1hcWpByAFscuGxTyukKWCbOf6lmBdmSuB
	ZuBfNjzg==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
	by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <nora.schiffer@ew.tq-group.com>)
	id 1w397i-000Gux-1c;
	Thu, 19 Mar 2026 09:52:58 +0100
Received: from localhost ([127.0.0.1])
	by sslproxy03.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <nora.schiffer@ew.tq-group.com>)
	id 1w397h-000NT9-1X;
	Thu, 19 Mar 2026 09:52:57 +0100
Message-ID: <4cd1dc92490b7e441378c85da3a0e14010ba74d0.camel@ew.tq-group.com>
Subject: Re: [PATCH 6/7] net: ethernet: ti: am65-cpsw: add support for J722S
 SoC family
From: Nora Schiffer <nora.schiffer@ew.tq-group.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,  Nishanth Menon
 <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo
 <kristo@kernel.org>
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>, Rob Herring <robh@kernel.org>,
  Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>, Neil Armstrong
 <neil.armstrong@linaro.org>,  netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux@ew.tq-group.com
Date: Thu, 19 Mar 2026 09:52:56 +0100
In-Reply-To: <4cc3dd9fab460d35215c8f97496b9ae16c5bcb22.1773751309.git.nora.schiffer@ew.tq-group.com>
References: <cover.1773751309.git.nora.schiffer@ew.tq-group.com>
	 <4cc3dd9fab460d35215c8f97496b9ae16c5bcb22.1773751309.git.nora.schiffer@ew.tq-group.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1.1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Virus-Scanned: Clear (ClamAV 1.4.3/27945/Thu Mar 19 07:24:38 2026)
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ew.tq-group.com,quarantine];
	R_DKIM_ALLOW(-0.20)[ew.tq-group.com:s=default2602];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269362-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[ew.tq-group.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nora.schiffer@ew.tq-group.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,tq-group.com:email,tq-group.com:url,ew.tq-group.com:dkim,ew.tq-group.com:mid]
X-Rspamd-Queue-Id: 418E32C81AE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 2026-03-18 at 15:05 +0100, Nora Schiffer wrote:
> The J722S CPSW3G is mostly identical to the AM64's, but additionally
> supports SGMII.
>=20
> Signed-off-by: Nora Schiffer <nora.schiffer@ew.tq-group.com>
> ---
>  drivers/net/ethernet/ti/am65-cpsw-nuss.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ether=
net/ti/am65-cpsw-nuss.c
> index d9400599e80a4..fc57d5e6edf4c 100644
> --- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
> +++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
> @@ -3468,6 +3468,13 @@ static const struct am65_cpsw_pdata am64x_cpswxg_p=
data =3D {
>  	.fdqring_mode =3D K3_RINGACC_RING_MODE_RING,
>  };
> =20
> +static const struct am65_cpsw_pdata j722s_cpswxg_pdata =3D {
> +	.quirks =3D AM64_CPSW_QUIRK_DMA_RX_TDOWN_IRQ | AM64_CPSW_QUIRK_CUT_THRU=
,

Ah, I just realized that I sent the wrong version of this patch,
AM64_CPSW_QUIRK_CUT_THRU only exists in the TI vendor kernel... sorry about
this, will fix in v2.

Can someone from TI answer if AM64_CPSW_QUIRK_DMA_RX_TDOWN_IRQ is needed fo=
r the
J722S?

Best,
Nora



> +	.ale_dev_id =3D "am64-cpswxg",
> +	.fdqring_mode =3D K3_RINGACC_RING_MODE_RING,
> +	.extra_modes =3D BIT(PHY_INTERFACE_MODE_SGMII),
> +};
> +
>  static const struct am65_cpsw_pdata j7200_cpswxg_pdata =3D {
>  	.quirks =3D 0,
>  	.ale_dev_id =3D "am64-cpswxg",
> @@ -3495,6 +3502,7 @@ static const struct of_device_id am65_cpsw_nuss_of_=
mtable[] =3D {
>  	{ .compatible =3D "ti,am654-cpsw-nuss", .data =3D &am65x_sr1_0},
>  	{ .compatible =3D "ti,j721e-cpsw-nuss", .data =3D &j721e_pdata},
>  	{ .compatible =3D "ti,am642-cpsw-nuss", .data =3D &am64x_cpswxg_pdata},
> +	{ .compatible =3D "ti,j722s-cpsw-nuss", .data =3D &j722s_cpswxg_pdata},
>  	{ .compatible =3D "ti,j7200-cpswxg-nuss", .data =3D &j7200_cpswxg_pdata=
},
>  	{ .compatible =3D "ti,j721e-cpswxg-nuss", .data =3D &j721e_cpswxg_pdata=
},
>  	{ .compatible =3D "ti,j784s4-cpswxg-nuss", .data =3D &j784s4_cpswxg_pda=
ta},

--=20
TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld, Germ=
any
Amtsgericht M=C3=BCnchen, HRB 105018
Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stefan Sch=
neider
https://www.tq-group.com/

