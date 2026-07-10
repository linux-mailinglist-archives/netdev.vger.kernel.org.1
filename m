Return-Path: <netdev+bounces-306551-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jItnAH/uUGrA8gIAu9opvQ
	(envelope-from <netdev+bounces-306551-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 15:07:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E180C73B122
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 15:07:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=collabora.com header.s=zohomail header.b="kl+P/qm1";
	dmarc=pass (policy=none) header.from=collabora.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306551-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-306551-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D5313300B8CE
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 13:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A777342B72C;
	Fri, 10 Jul 2026 13:02:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A24442A7BD;
	Fri, 10 Jul 2026 13:02:45 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783688566; cv=pass; b=fd20H49iOVJc2Vf15fMiFqJJRPobYKUwmJ5q8NObcYSkcwEhKxfN6JsQOLjjoQAX1+vNwn2wPZjd/dygLBokRYz1LWY4KPYD6/VKcehbg5ffEjIKQnwdDxMMknyaRNYQKJqeK/WB8OBZ5kBDxTRsFnnwf27qUufJau9XW2M3vc0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783688566; c=relaxed/simple;
	bh=eXraE2Ns3ecpg4pFHewAEJ+5B988G+Typl4Tddd0b+U=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Jv185HeArQpcpD5ORoRLlpgSCCqVAuT0flX4TLKrlM1nVZsnPvcauth/30pNDRNvZIT92EJqQyGCTzCbH7bCeyiKkC2JphmtKjsdoakZMuRS3W2ZwrMBn8lU1WqsQz+8/pwBXbSO7TEOQYNcRnwQD9MZoe4NvHib4THKQ3WobDE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=louisalexis.eyraud@collabora.com header.b=kl+P/qm1; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal: i=1; a=rsa-sha256; t=1783688516; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ISZa+ManoF2nBvi4nTAyJ9DU4BKNlYwz03LQvMQkHYoUe0CwahrjMdN6U40+peTpQQ62bK6+WOGP17oT+XPbcLcrh8Hn1R6MOMRmn4J74SQnPKFKCxGUyo5QXKvWhVFZrYh0VfB/73o34hOVp8PEXIWG7wNrYskfac7SuNCJZzA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1783688516; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=FDOpiS3Kf0XVsCPqWZd9Util7kCEb/QH0STMK5AmhRc=; 
	b=QyeMUJQmgEDpJB8FNwljqg+k3ypIDZtIs/RdRCBtRNEK28Ciobf2XD4oogYedBz0PKHHvr2cHcd6No0X/6F3AXDZF3wMCqlCksRSxyAMqrlYXBzhoqkuUlrSgCSdkz55F19UAqu+pPi80OEfetVSqwxIyiKdpfyTVY9JpxBdODQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=louisalexis.eyraud@collabora.com;
	dmarc=pass header.from=<louisalexis.eyraud@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1783688516;
	s=zohomail; d=collabora.com; i=louisalexis.eyraud@collabora.com;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=FDOpiS3Kf0XVsCPqWZd9Util7kCEb/QH0STMK5AmhRc=;
	b=kl+P/qm1h+PtSgnueLSQiYD9lJMQ0FTQXGx1Pu47QyxBVoGT416mmNHWriG4olj+
	Yr8Fb2awyfmKajDd5G3P08ShGRUlUQdo7heCbwQImMDLmm82t4ZLm/by/Hv0CHLePS6
	bQccwDOnwqPU0+euCr2nA2PGYxdWj6M8y1DdTYi8=
Received: by mx.zohomail.com with SMTPS id 1783688513797335.15709494826183;
	Fri, 10 Jul 2026 06:01:53 -0700 (PDT)
Message-ID: <f85e08cf5e119e30ab4513e78ffa833fbe0832b7.camel@collabora.com>
Subject: Re: [PATCH net-next 1/6] dt-bindings: net: mediatek-dwmac: add
 support for MT8189 SoC
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley	
 <conor+dt@kernel.org>, Richard Cochran <richardcochran@gmail.com>, Matthias
 Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno	
 <angelogioacchino.delregno@collabora.com>, Biao Huang
 <biao.huang@mediatek.com>,  Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	maxime.chevallier@bootlin.com, rmk+kernel@armlinux.org.uk,
 kernel@collabora.com, 	netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, 	linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, 
	linux-stm32@st-md-mailman.stormreply.com
Date: Fri, 10 Jul 2026 15:01:46 +0200
In-Reply-To: <6ea11726-8d50-411e-afab-da346e09ab9b@lunn.ch>
References: <20260707-dwmac-mediatek-mt8189-v1-0-17f345eaaca3@collabora.com>
	 <20260707-dwmac-mediatek-mt8189-v1-1-17f345eaaca3@collabora.com>
	 <b810b9cd-8f5e-4c9d-8496-908aae55dac1@lunn.ch>
	 <8304b0a704c8db697767584b8c34388f07ba401d.camel@collabora.com>
	 <6ea11726-8d50-411e-afab-da346e09ab9b@lunn.ch>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-306551-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[louisalexis.eyraud@collabora.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[24];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:richardcochran@gmail.com,m:matthias.bgg@gmail.com,m:angelogioacchino.delregno@collabora.com,m:biao.huang@mediatek.com,m:mcoquelin.stm32@gmail.com,m:alexandre.torgue@foss.st.com,m:maxime.chevallier@bootlin.com,m:rmk+kernel@armlinux.org.uk,m:kernel@collabora.com,m:netdev@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:linux-stm32@st-md-mailman.stormreply.com,m:krzk@kernel.org,m:conor@kernel.org,m:matthiasbgg@gmail.com,m:mcoquelinstm32@gmail.com,m:rmk@armlinux.org.uk,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,collabora.com,mediatek.com,foss.st.com,bootlin.com,armlinux.org.uk,vger.kernel.org,lists.infradead.org,st-md-mailman.stormreply.com];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt,kernel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E180C73B122

Hi Andrew,

On Wed, 2026-07-08 at 16:35 +0200, Andrew Lunn wrote:
> > On Tue, 2026-07-07 at 14:42 +0200, Andrew Lunn wrote:
> > > > +=C2=A0 - if:
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 properties:
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 compatible:
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 contains:
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 enum:
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 - mediatek,mt8189-gmac
> > > > +=C2=A0=C2=A0=C2=A0 then:
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 properties:
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clocks:
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 items:
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 - description: MAC Main clock
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 - description: PTP clock
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 - description: RMII reference clock provided by
> > > > MAC
> > >=20
> > > Since this is a MAC, it sounds like it is consuming its own
> > > clock?
> >=20
> > In the driver ([1]), this clock is described as being only used and
> > needed in RMII when MAC provides the reference clock, and useless
> > otherwise (RGMII/MII or RMII when PHY provides the reference
> > clock).
>=20
> So it sounds like this is a clock output, going to the PHY, as its
> reference clock input. So ideally, the PHY should consume this clock,
> not the MAC.
>=20
> > Its use and configuration also depends on the "mediatek,rmii-clk-
> > from-
> > mac" vendor property ([2]) presence in devicetree.
>=20
> This makes it sounds like it is historically wrong, and the patch is
> just extending this to the new device.
>=20
> Do you have a board using RMII? Can you list the clock in the PHY
> node, not the MAC, and see if it still works?
>=20

I don't.=C2=A0
All the MTK Genio boards (510, 520, 720, 1200 EVK) I have are using
RGMII only.

> Ideally, for a new device, we should not repeat past errors.

So, do you want I remove this clock from mt8189 clocks list for v2?

Regards,
Louis-Alexis

>=20
> 	 Andrew

