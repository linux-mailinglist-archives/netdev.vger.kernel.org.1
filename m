Return-Path: <netdev+bounces-305791-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MnE5DX9DTmpyJwIAu9opvQ
	(envelope-from <netdev+bounces-305791-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 14:33:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 72AA472653B
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 14:33:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=collabora.com header.s=zohomail header.b=h6bRTRdC;
	dmarc=pass (policy=none) header.from=collabora.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305791-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-305791-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 947DF301A1D6
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 12:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 963A843E4AB;
	Wed,  8 Jul 2026 12:29:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A7443E492;
	Wed,  8 Jul 2026 12:29:11 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783513753; cv=pass; b=ONGvUjXaRu5OvqxO+mPDZcJ3bMzR6l00BNPR+j2TF4kmgHJAus86If2b7M0civ1cMG46CQmQ1y8xeOGLa0GmL2OHcb3ZAJubsVHqyC9neiK8wgm4oC4kslWPVwvtQyEJ/r7jzhZroN+L8w/myy3iT2ibjgX8GTkfYgCrSvBUHDw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783513753; c=relaxed/simple;
	bh=hNxi3I7/AjHCOFwddBwrPLCzilKwHtStVx43u1/rLDU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=B6GJNT0p95tBMNxy6Mwk/yI/l9DM4cm35P3X2SoGuZSfp6+QGM32VCmzcwB7VEc3lESA9xVOfAROvPItJMLyjVHAlzp1mOz8gN4fs2rl+rxapyXJKE24qhrE7JH3q3SFEG59ZSTgE7YyIWlkSbnSAUUhRN2ogZOcxxL3PL3TP3A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=louisalexis.eyraud@collabora.com header.b=h6bRTRdC; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal: i=1; a=rsa-sha256; t=1783513718; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=dmk5QtOSqylrvj1O3kiWrYo5jOBHtMdHnLgwpkgK/OeYJcaygEFc908bdEjJcwFL8duOUKfqaBXGOC+SRZSCHufdPYaYi9PLGNM8bRxhcFLFnofEyRbsoTBNyULAcUmy14ns31kQof4IQPKzXk0XT8RQSPfV+HzfwpBImuFSjoI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1783513718; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=QCvu92owlqFigfn30SNdUxyYgy9yaDdYJCfmb5B8+hA=; 
	b=TUVE5cAWvaUKOL/7VkXKNsheZFAnqsjFihWOVi5E8/Lf3tOGzoa/GO+f4zkq6Tnoe+IopkOelUVU/gUR72HtIh4Cuvzg1DGca0jE5//B0m0MTT5dIGFCJ1yRRuscfQIB3dWcW5Zc8zDQl5E1y6DCGRw/JiBf04r8cl6BSbEceZo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=louisalexis.eyraud@collabora.com;
	dmarc=pass header.from=<louisalexis.eyraud@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1783513718;
	s=zohomail; d=collabora.com; i=louisalexis.eyraud@collabora.com;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=QCvu92owlqFigfn30SNdUxyYgy9yaDdYJCfmb5B8+hA=;
	b=h6bRTRdCEfGpTsXUdZushp4txBmx8lAJ2sgujTR/sAo9JJSBSlceJfhV4vZkaYkY
	rtrySVIeuYT8F3dzrFdpWNZza1RcYhMupJRR8ITAYN7hBDSSyKEo6vz8FjpFDY09sUP
	Nkn2iZd7+RFWywEK1Pwpr2rr8GIUn8Cc/b1GUQZQ=
Received: by mx.zohomail.com with SMTPS id 1783513715946883.1743690151607;
	Wed, 8 Jul 2026 05:28:35 -0700 (PDT)
Message-ID: <e390664dc439043a43b6ded3c50c9a2bb5bbd2f6.camel@collabora.com>
Subject: Re: [PATCH net-next 5/6] net: stmmac: mediatek: add support for TX
 deallocation adjustment feature
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, Andrew Lunn	
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet	 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni	 <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski	 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Richard Cochran	 <richardcochran@gmail.com>, Matthias Brugger
 <matthias.bgg@gmail.com>,  AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, Biao Huang
 <biao.huang@mediatek.com>, Maxime Coquelin	 <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: rmk+kernel@armlinux.org.uk, kernel@collabora.com,
 netdev@vger.kernel.org, 	devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, 	linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, 
	linux-stm32@st-md-mailman.stormreply.com
Date: Wed, 08 Jul 2026 14:28:30 +0200
In-Reply-To: <2a421449-01eb-4066-8c19-d554ff8e4f6e@bootlin.com>
References: <20260707-dwmac-mediatek-mt8189-v1-0-17f345eaaca3@collabora.com>
	 <20260707-dwmac-mediatek-mt8189-v1-5-17f345eaaca3@collabora.com>
	 <2a421449-01eb-4066-8c19-d554ff8e4f6e@bootlin.com>
Organization: Collabora Ltd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ZohoMailClient: External
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[collabora.com,none];
	R_DKIM_ALLOW(-0.20)[collabora.com:s=zohomail];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-305791-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:maxime.chevallier@bootlin.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:richardcochran@gmail.com,m:matthias.bgg@gmail.com,m:angelogioacchino.delregno@collabora.com,m:biao.huang@mediatek.com,m:mcoquelin.stm32@gmail.com,m:alexandre.torgue@foss.st.com,m:rmk+kernel@armlinux.org.uk,m:kernel@collabora.com,m:netdev@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:linux-stm32@st-md-mailman.stormreply.com,m:andrew@lunn.ch,m:krzk@kernel.org,m:conor@kernel.org,m:matthiasbgg@gmail.com,m:mcoquelinstm32@gmail.com,m:rmk@armlinux.org.uk,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[bootlin.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,collabora.com,mediatek.com,foss.st.com];
	FORGED_SENDER(0.00)[louisalexis.eyraud@collabora.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[louisalexis.eyraud@collabora.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[collabora.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt,kernel];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 72AA472653B

Hi Maxime,

On Tue, 2026-07-07 at 11:11 +0200, Maxime Chevallier wrote:
> Hi,
>=20
> On 7/7/26 10:21, Louis-Alexis Eyraud wrote:
> > The MT8189 SoC has in the Ethernet control 0 register from the
> > peripheral configuration (pericfg) additional bits to adjust the TX
> > deallocation.
> >=20
> > In preparation of MT8189 SoC support, add its definition, use in
> > the
> > set_delay_v2 callback, and a support flag in the platform data.
>=20
> Can you elaborate a bit on this ? I don't quite get what you mean by
> "tx deallocation", this seems to have to do with RGMII timings from
> the register access pattern, but the local boolean flag for the
> feature
> is named "use_stage_fine", I'm failing to connect all the dots here
> with the different terminology in use :(
>=20
The data sheets I have, don't have info regarding this register, so
I'll try to get more and improve commit and/or code description.

I'll also check if the register definition name is consistent
(downstream driver and upstream u-boot use this stage fine term).

The use_stage_fine feature flag could be renamed anyway to match what
it does.

> >=20
> > Signed-off-by: Louis-Alexis Eyraud
> > <louisalexis.eyraud@collabora.com>
> > ---
> > =C2=A0.../net/ethernet/stmicro/stmmac/dwmac-mediatek.c=C2=A0=C2=A0 | 25
> > ++++++++++++++++------
> > =C2=A01 file changed, 19 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
> > b/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
> > index bcc0baef3f71..6b0a42b5839f 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
> > @@ -37,7 +37,8 @@
> > =C2=A0#define ETH_FINE_DLY_RXC	BIT(0)
> > =C2=A0
> > =C2=A0/* Peri Configuration register for mt8189 */
> > -#define MT8189_CTRL0_TXC_OUT_OP		BIT(20)
> > +#define MT8189_CTRL0_TXC_OUT_OP			BIT(20)
>=20
> Extra whitespace inserted here :)
>=20
Oops, to be fixed in v2

Regards,
Louis-Alexis

> Thanks,
>=20
> Maxime

