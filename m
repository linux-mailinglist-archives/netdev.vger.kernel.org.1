Return-Path: <netdev+bounces-305787-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4VocNS49TmoSJgIAu9opvQ
	(envelope-from <netdev+bounces-305787-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 14:06:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7134072621C
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 14:06:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=collabora.com header.s=zohomail header.b="EL8T/+B7";
	dmarc=pass (policy=none) header.from=collabora.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305787-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305787-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DF7A0300A4A0
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 12:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4D63438FEA;
	Wed,  8 Jul 2026 12:06:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1BFF439004;
	Wed,  8 Jul 2026 12:06:01 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783512363; cv=pass; b=WYP9O3qh2HSVKh5ptHe/CE2pdHf9PXEarZIXu3xMby5cWuPYca5KUgItN1eH+4bCMQFf+SAK6WRG4q+mJA+AEKeUO8lNtzplnKzpDyRMBbn7anAYS4tgG7AY6O8zF1xUAz1ri91r9QMOq2bxoKK3skEjCKac4st5VqDJuFhC4eE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783512363; c=relaxed/simple;
	bh=6MsS/5ImLavNv/BfJxFCPsCrHDT6SeV4eEKuOQYGJ/o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J3KEBofqGP0Wgk+wsydoAXU6XWPMHaH4RmDCCC131ylgVUSeIP721iNmTHxC5Uc0wMvckEyaQTbPzKJ9+pv3fP/6rrGox9J3soudBcUyAAISnv4xI5AmhjO9e2g9LPo6zjAajJB6oxVFBQl+15h9OWVGaWCPLaIeZqQ+nYDyhWc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=louisalexis.eyraud@collabora.com header.b=EL8T/+B7; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal: i=1; a=rsa-sha256; t=1783512307; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=KvgWjgnVrtF6+ZkBWicFziVYuQdsIssCDuicOCsak8yQIYN7+5NGdf+ouUluqMO+Ev9SpCAtLa9UAT0ZMlgXiSB9fnXQvS3VTwuC0nWRDjuzSKl2xyNx2lP4/AACMn9OXW18m83oYXQSvoABm1Md5du7KWpgypvrj/KL/C/BvOY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1783512307; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=wGYZTikwg2rXaLxaDX2K7Y9au6mX/qYf21+84FQdF+0=; 
	b=i+SFhQOt8b7X+gb4HX6jliFLSEB9iWLysvFJn85UUCNPBSUlqm6LfKn81LjB2ZHGWpqst9XokiDCZIokBV4eByx9ip9FUP+H/CCPbfSzyqN+p47WVR2x96GqZ1hz6NZyIuQ+FKj317l4DDPoEhyS7bJN1g38dA+n5857+d9hjZE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=louisalexis.eyraud@collabora.com;
	dmarc=pass header.from=<louisalexis.eyraud@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1783512307;
	s=zohomail; d=collabora.com; i=louisalexis.eyraud@collabora.com;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=wGYZTikwg2rXaLxaDX2K7Y9au6mX/qYf21+84FQdF+0=;
	b=EL8T/+B7liCUlfZVaMPg9+sHHWJLi6JR1rw48kEi/26KZG9GVaSE91tpGn8QaUwq
	zOQx89xA1YldfIIOlBnXMApdwV0+nR1dNcGKgWuVRwjL5ACuITyd4pP7q5KXz7I3mqp
	3q+Jp1BO50LeAAOOYScLmdFpi7obyJAdCFf/uy1o=
Received: by mx.zohomail.com with SMTPS id 1783512305076652.4555392247563;
	Wed, 8 Jul 2026 05:05:05 -0700 (PDT)
Message-ID: <658a04060e5c415af97dcc84284ab8962d1b7348.camel@collabora.com>
Subject: Re: [PATCH net-next 3/6] net: stmmac: mediatek: rename MT2712 and
 MT8195 variant methods
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
Date: Wed, 08 Jul 2026 14:04:59 +0200
In-Reply-To: <5dbd217b-8df5-42cd-9197-36e0fb91ffe7@bootlin.com>
References: <20260707-dwmac-mediatek-mt8189-v1-0-17f345eaaca3@collabora.com>
	 <20260707-dwmac-mediatek-mt8189-v1-3-17f345eaaca3@collabora.com>
	 <5dbd217b-8df5-42cd-9197-36e0fb91ffe7@bootlin.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-305787-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:maxime.chevallier@bootlin.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:richardcochran@gmail.com,m:matthias.bgg@gmail.com,m:angelogioacchino.delregno@collabora.com,m:biao.huang@mediatek.com,m:mcoquelin.stm32@gmail.com,m:alexandre.torgue@foss.st.com,m:rmk+kernel@armlinux.org.uk,m:kernel@collabora.com,m:netdev@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:linux-stm32@st-md-mailman.stormreply.com,m:andrew@lunn.ch,m:krzk@kernel.org,m:conor@kernel.org,m:matthiasbgg@gmail.com,m:mcoquelinstm32@gmail.com,m:rmk@armlinux.org.uk,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[bootlin.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,collabora.com,mediatek.com,foss.st.com];
	FORGED_SENDER(0.00)[louisalexis.eyraud@collabora.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[23];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[louisalexis.eyraud@collabora.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[collabora.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt,kernel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,collabora.com:from_mime,collabora.com:email,collabora.com:mid,collabora.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7134072621C

Hi Maxime,

On Tue, 2026-07-07 at 11:05 +0200, Maxime Chevallier wrote:
>=20
>=20
> On 7/7/26 10:21, Louis-Alexis Eyraud wrote:
> > In preparation of newer SoC support, rename MT2712 and MT8195
> > variant
> > methods and sub functions to more generic names.
> >=20
> > Signed-off-by: Louis-Alexis Eyraud
> > <louisalexis.eyraud@collabora.com>
> > ---
> > =C2=A0.../net/ethernet/stmicro/stmmac/dwmac-mediatek.c=C2=A0=C2=A0 | 32
> > +++++++++++-----------
> > =C2=A01 file changed, 16 insertions(+), 16 deletions(-)
> >=20
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
> > b/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
> > index 0cabab4fd89a..28e87990b0a1 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
> > @@ -110,7 +110,7 @@ static const char * const mt8195_dwmac_clk_l[]
> > =3D {
> > =C2=A0	"axi", "apb", "mac_cg", "mac_main", "ptp_ref"
> > =C2=A0};
> > =C2=A0
> > -static int mt2712_set_interface(struct mediatek_dwmac_plat_data
> > *plat,
> > +static int set_phy_interface_v1(struct mediatek_dwmac_plat_data
> > *plat,
> > =C2=A0				u8 phy_intf_sel)
>=20
> What does this naming of "v1 / v2" refer to ?
>=20
> I personally don't find it much better than the current one prefixed
> by the SoC
> name. You still end-up using registers that have the "MT8195_" prefix
> in their
> names in the 'v2' variants of these functions, so it still sound SoC-
> family specific :)
>=20
I agree.

In a work in progress version of this series, I had renamed all
register definitions as well (to remove the mt8195_ prefix) but dropped
the changes because too much difference for little gain.
I kept this patch but it does not really improve the code.

> I'd say you can keep the original names as-is, or if you really want
> a rename,
> maybe use the mt81xx_ prefix for MT8195 and MT8189 ?
I'll drop this patch in v2 to keep the existing names (and smaller
changes).

Regards,
Louis-Alexis

> Maxime

