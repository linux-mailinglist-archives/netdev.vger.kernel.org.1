Return-Path: <netdev+bounces-305824-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4HWJEAZWTmqUKwIAu9opvQ
	(envelope-from <netdev+bounces-305824-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 15:52:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D7995726F86
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 15:52:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=collabora.com header.s=zohomail header.b=PB5MOWP6;
	dmarc=pass (policy=none) header.from=collabora.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305824-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-305824-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4A30030A07F9
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 13:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF25C3803DE;
	Wed,  8 Jul 2026 13:45:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319CB3803C5;
	Wed,  8 Jul 2026 13:45:12 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783518314; cv=pass; b=oYY/oVNaCP7uLoe0PTVCicIFO3l5YgUrh1OhbEUzepc+W2ItmirxN7v4j9ipJm12AzJeQbr71g/VckDTbRRBORujhDVi5XqKZSBuwt7wnqY2U7EsvjUD4VIhRb+ZN0/FJhoAOiHL7xyMMzNVkxrQIt0JMhpv/l+L+VE+l1TeZCk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783518314; c=relaxed/simple;
	bh=qWprFcj4shuGHq5yxrj4ujGarnc9yIZ52TmhC/6XIwk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IeqW/652y/JdA/mEbObu9LYYVzPNHHeJvYPDKIrpc6OZ4txuMJb1Hk+Eu0viFrDBRO/kTQcEUPl0UfyguQIL4lYP2BwyCsNxLfwDabbDfPEFH9uBIhKsbcrT8kB7zJydi0ChUEOoI2xM9dRvgfZcpB6Is/TmMZcEPlkTKosRpUQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=louisalexis.eyraud@collabora.com header.b=PB5MOWP6; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal: i=1; a=rsa-sha256; t=1783518290; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=HBq9iS9jB6ewfkBvD6l/hbdZk9lWKDtHUbN71aNOZzsPLaY3iejK0SyY1j/4NBwcd9eUXrS+SniQU/2qJDseInB9kzWsSB1x5o6XcRGzRTkW3fzh9mXmRrTEM38b/bPRWHnLqzQmtdZzhYRN5kTvn5g1GWHdz5W38zNcUGDPR1w=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1783518290; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=qWprFcj4shuGHq5yxrj4ujGarnc9yIZ52TmhC/6XIwk=; 
	b=m6cuxMrOVq4L8VkW/d073JvTz5zzxha3+ZKqTNROYRjUXXEbtxF1PaXWsflkd0SVK0gOre6P4sulmjdLtx0F7J7LCaaYCla+xr1elj1AHOb6EwnWOZdvoZfLQkQ5KHmdyjACCyE8UQsMr+OELEjcVBo68P3XkKdoxRn2PSiEQ64=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=louisalexis.eyraud@collabora.com;
	dmarc=pass header.from=<louisalexis.eyraud@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1783518290;
	s=zohomail; d=collabora.com; i=louisalexis.eyraud@collabora.com;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=qWprFcj4shuGHq5yxrj4ujGarnc9yIZ52TmhC/6XIwk=;
	b=PB5MOWP6bfWP1uYvdd2mougUVnAF9pEe1jEhriEp822oJuoalAbrJcw9fBaiUssu
	cjDdpxFnM0U3H7mB8Krxm0/TwkhW5jVwv7DdRs4J8Eur4cNdBl08RvlqbcuxgegdjJS
	wDFfIWKK2x+8boHirToKdrVaKDl1pBin8nwP48/w=
Received: by mx.zohomail.com with SMTPS id 178351828794519.896016735108105;
	Wed, 8 Jul 2026 06:44:47 -0700 (PDT)
Message-ID: <d1e37bd4f2a05fed6c7bfdc5d9a0fa90c892d608.camel@collabora.com>
Subject: Re: [PATCH 02/15] dt-bindings: clock: mediatek: regroup MT8188
 dt-bindings into MT8186
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
To: Rob Herring <robh@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>,  Brian Masney <bmasney@redhat.com>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley	 <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>,  AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, Chun-Jie Chen
 <chun-jie.chen@mediatek.com>, Philipp Zabel	 <p.zabel@pengutronix.de>,
 Edward-JW Yang <edward-jw.yang@mediatek.com>,  Richard Cochran
 <richardcochran@gmail.com>, kernel@collabora.com,
 linux-clk@vger.kernel.org, 	devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, 	linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, 	netdev@vger.kernel.org
Date: Wed, 08 Jul 2026 15:44:42 +0200
In-Reply-To: <20260701193311.GA1402559-robh@kernel.org>
References: 
	<20260701-mt8189-clocks-system-base-v1-0-2b048feea50a@collabora.com>
	 <20260701-mt8189-clocks-system-base-v1-2-2b048feea50a@collabora.com>
	 <20260701193311.GA1402559-robh@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[collabora.com:s=zohomail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	HAS_ORG_HEADER(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-305824-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:robh@kernel.org,m:mturquette@baylibre.com,m:sboyd@kernel.org,m:bmasney@redhat.com,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:matthias.bgg@gmail.com,m:angelogioacchino.delregno@collabora.com,m:chun-jie.chen@mediatek.com,m:p.zabel@pengutronix.de,m:edward-jw.yang@mediatek.com,m:richardcochran@gmail.com,m:kernel@collabora.com,m:linux-clk@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:netdev@vger.kernel.org,m:krzk@kernel.org,m:conor@kernel.org,m:matthiasbgg@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[louisalexis.eyraud@collabora.com,netdev@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[baylibre.com,kernel.org,redhat.com,gmail.com,collabora.com,mediatek.com,pengutronix.de,vger.kernel.org,lists.infradead.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[louisalexis.eyraud@collabora.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[collabora.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D7995726F86

Hello Rob,

On Wed, 2026-07-01 at 14:33 -0500, Rob Herring wrote:
> On Wed, Jul 01, 2026 at 03:11:07PM +0200, Louis-Alexis Eyraud wrote:
> > Regroup the MT8188 clock and system clock dt-bindings into MT8186
> > ones
> > to ease maintainability and have common files for several currently
> > supported SoC or new future ones, that have the same kind of clock
> > controller design.
> >=20
> > Note:
> > The `#clock-cells` property is a required property for all
> > compatibles
> > declared in MT8188 clock and system clock dt-bindings but not in
> > MT8186
> > ones.
> > To avoid ABI breakage, conditional blocks to check this requirement
> > for MT8188 compatibles are added, rather than enforcing it for
> > MT8186
> > compatibles.
>=20
> If the existing DTs are just wrong, then I would just make #clock-
> cells=20
> required. But please update the .dts files so the warnings don't
> grow.
>=20
I've tested to make the #clock-cells required for the MT8186, MT8192
and MT8195 system and functional clock controllers.
I did not see new warnings, so no extra dts patches would be needed.

I'll add new patches (one per SoC) in the next revision of the series
for this, as it simplifies the grouping patches (no more if/then to
require #clock-cells for the MT8188/MT8189 clock controllers) and the
note in commit message could be removed.

> The grouping I would do here is:
>=20
> - clock controller only
> - reset controller only
> - both clock and reset controller
>=20
> That should avoid any if/then schemas.
>=20

By this grouping, I understand you suggest having separate dt-bindings
files, that could look like:
- mediatek,mt8186-clock.yaml: clock controllers
- <name to be found>: reset controllers
- <name to be found>: clock controllers with reset controller
- mediatek,mt8186-sys-clock.yaml: system clock controllers.
- <name to be found>: system clock controllers with reset controller

Is that what you meant?

There is no pure reset controllers for those SoC so no dedicated file
would needed at the moment.
The system clock controllers all have reset-controllers, even they may
currently be not all implemented, so no separate files for system clock
controllers would needed as well.

Also, from what I see the current dt-bindings, the system clocks
controllers for the MT8186/MT8188/MT8192/MT8195 SoC have the #reset-
cells property but it is not required for them (examples:
mediatek,mt8188-infracfg-ao or mediatek,mt8195-infracfg_ao).

With the patches to make the #clock-cells property required, I already
removed the biggest if/else block in mediatek,mt8186-clock.yaml, so
only the one regarding #reset-cells property remains.

So, should I create separate files, following the grouping suggestion,
for the v2 of this patch?

Regards,
Louis-Alexis

> Rob

