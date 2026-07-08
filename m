Return-Path: <netdev+bounces-306000-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UTVnFzzDTmp5TgIAu9opvQ
	(envelope-from <netdev+bounces-306000-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 23:38:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA50A72A921
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 23:38:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=oLWiMIEJ;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306000-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306000-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 486B1301BA72
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 21:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A36443F6C26;
	Wed,  8 Jul 2026 21:34:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC623AB29E
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 21:34:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783546489; cv=none; b=UkR7ZsHvGA13ktRY/B4ZnMJsoHDI86K5nycpWo6AQbaiMnlZAP0P1PFfyax60/CAccqNEDf+9iJ0LeEcj60ZNmEczuNglSmIA7t96eDKuLSSVNStnmQDKMMNzTGPuf/Mh6qNQ66KdjPoDFPjgtjBIbc161bQTf2A2N3vYO/eS54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783546489; c=relaxed/simple;
	bh=QOSXPs572gwC1zNEaba3iUlnyvy4QAECU2owztJON50=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GLHImM4uDqvUgENWsUW5VQgOAPu4JCT3ilUMQJQuxllvDBLGb1gevqbY6BYegHdospL5yvXl9+5ebPgK4LtmE/sVhS5iNOBqfuaDkfvhTk/I3awVfI8Jq+xLog6/nL5o+23dYXnJ+bIX+JoBSpnF7w99wO4+pQawBFE6X7tfR5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oLWiMIEJ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BDF51F01559
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 21:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783546488;
	bh=QOSXPs572gwC1zNEaba3iUlnyvy4QAECU2owztJON50=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=oLWiMIEJ0W+2X8o0NSe2rZ6aZ3sA6U0G3Dq+g9ru8SeVgFY7ajC/IFv/EZWpsR5Xk
	 geK/gPYk+UMZRfpa7k1QenCnUGWTbPm3ZsHpkyFzbIAayQBkS6sjilk9ExJRQu8Fs8
	 7EUnOZAdU1U0xEUWoDATI9FLYwtAhcc2Ly8+nhDxtj4JA8NlBLjGZxSP1Y6GZSOwvI
	 c+vM8ee3gvlIvJVR8u83IXaNI3/rRtMq7NuqbKXPpIyvrNqSEkSKhU01Jg0EunLJhk
	 uLfFyYjwY7928goknVNQYJCKy4nlHiR+Dd4FM77K/mm76Z7uNJh7YJTm+FHDnLrUBz
	 pC+WHzxSmARzw==
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c029505b389so44354866b.1
        for <netdev@vger.kernel.org>; Wed, 08 Jul 2026 14:34:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RoEFfmhTSfm6ZGD3HjtWxi7qMLo1G9SrNDxVEE3Sc7r7wl0njCCXY8N1TwAj/m6Z1vUxXAi0hM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkSyGQyOgowV+K8mCamuT8TN2ocXQAeBZcgsLft54HhEiaAsu4
	+bLoeOCleDkTCiDSHdmy+zG4ERU0mDWMb4bVTTh3wDAG5zo27zwjhR79lniwDtgXNn0+bilSYV6
	2zsmGmF2k2otACLYwPlTaEfiTKUkSlQ==
X-Received: by 2002:a17:906:2099:b0:c15:c323:36e5 with SMTP id
 a640c23a62f3a-c15e744ffafmr1138866b.10.1783546486746; Wed, 08 Jul 2026
 14:34:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260701-mt8189-clocks-system-base-v1-0-2b048feea50a@collabora.com>
 <20260701-mt8189-clocks-system-base-v1-2-2b048feea50a@collabora.com>
 <20260701193311.GA1402559-robh@kernel.org> <d1e37bd4f2a05fed6c7bfdc5d9a0fa90c892d608.camel@collabora.com>
In-Reply-To: <d1e37bd4f2a05fed6c7bfdc5d9a0fa90c892d608.camel@collabora.com>
From: Rob Herring <robh@kernel.org>
Date: Wed, 8 Jul 2026 16:34:35 -0500
X-Gmail-Original-Message-ID: <CAL_JsqK8mmkhp8rM1QVB8cqLmTVqy5toFdt3Y1AFLJ5-wOdhgQ@mail.gmail.com>
X-Gm-Features: AUfX_mw1Ig80oWjopfC3vG9UTQnueKyNCwAlWOrtHD_SpQ7K2JXbmkzTxRjcs9w
Message-ID: <CAL_JsqK8mmkhp8rM1QVB8cqLmTVqy5toFdt3Y1AFLJ5-wOdhgQ@mail.gmail.com>
Subject: Re: [PATCH 02/15] dt-bindings: clock: mediatek: regroup MT8188
 dt-bindings into MT8186
To: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Brian Masney <bmasney@redhat.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Chun-Jie Chen <chun-jie.chen@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Edward-JW Yang <edward-jw.yang@mediatek.com>, Richard Cochran <richardcochran@gmail.com>, 
	kernel@collabora.com, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-306000-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:louisalexis.eyraud@collabora.com,m:mturquette@baylibre.com,m:sboyd@kernel.org,m:bmasney@redhat.com,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:matthias.bgg@gmail.com,m:angelogioacchino.delregno@collabora.com,m:chun-jie.chen@mediatek.com,m:p.zabel@pengutronix.de,m:edward-jw.yang@mediatek.com,m:richardcochran@gmail.com,m:kernel@collabora.com,m:linux-clk@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:netdev@vger.kernel.org,m:krzk@kernel.org,m:conor@kernel.org,m:matthiasbgg@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[robh@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[baylibre.com,kernel.org,redhat.com,gmail.com,collabora.com,mediatek.com,pengutronix.de,vger.kernel.org,lists.infradead.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robh@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CA50A72A921

On Wed, Jul 8, 2026 at 8:45=E2=80=AFAM Louis-Alexis Eyraud
<louisalexis.eyraud@collabora.com> wrote:
>
> Hello Rob,
>
> On Wed, 2026-07-01 at 14:33 -0500, Rob Herring wrote:
> > On Wed, Jul 01, 2026 at 03:11:07PM +0200, Louis-Alexis Eyraud wrote:
> > > Regroup the MT8188 clock and system clock dt-bindings into MT8186
> > > ones
> > > to ease maintainability and have common files for several currently
> > > supported SoC or new future ones, that have the same kind of clock
> > > controller design.
> > >
> > > Note:
> > > The `#clock-cells` property is a required property for all
> > > compatibles
> > > declared in MT8188 clock and system clock dt-bindings but not in
> > > MT8186
> > > ones.
> > > To avoid ABI breakage, conditional blocks to check this requirement
> > > for MT8188 compatibles are added, rather than enforcing it for
> > > MT8186
> > > compatibles.
> >
> > If the existing DTs are just wrong, then I would just make #clock-
> > cells
> > required. But please update the .dts files so the warnings don't
> > grow.
> >
> I've tested to make the #clock-cells required for the MT8186, MT8192
> and MT8195 system and functional clock controllers.
> I did not see new warnings, so no extra dts patches would be needed.
>
> I'll add new patches (one per SoC) in the next revision of the series
> for this, as it simplifies the grouping patches (no more if/then to
> require #clock-cells for the MT8188/MT8189 clock controllers) and the
> note in commit message could be removed.
>
> > The grouping I would do here is:
> >
> > - clock controller only
> > - reset controller only
> > - both clock and reset controller
> >
> > That should avoid any if/then schemas.
> >
>
> By this grouping, I understand you suggest having separate dt-bindings
> files, that could look like:
> - mediatek,mt8186-clock.yaml: clock controllers
> - <name to be found>: reset controllers
> - <name to be found>: clock controllers with reset controller
> - mediatek,mt8186-sys-clock.yaml: system clock controllers.
> - <name to be found>: system clock controllers with reset controller
>
> Is that what you meant?

I think so, but not sure I understand the distinction with clock
controllers and system clock controllers.

> There is no pure reset controllers for those SoC so no dedicated file
> would needed at the moment.
> The system clock controllers all have reset-controllers, even they may
> currently be not all implemented, so no separate files for system clock
> controllers would needed as well.
>
> Also, from what I see the current dt-bindings, the system clocks
> controllers for the MT8186/MT8188/MT8192/MT8195 SoC have the #reset-
> cells property but it is not required for them (examples:
> mediatek,mt8188-infracfg-ao or mediatek,mt8195-infracfg_ao).
>
> With the patches to make the #clock-cells property required, I already
> removed the biggest if/else block in mediatek,mt8186-clock.yaml, so
> only the one regarding #reset-cells property remains.
>
> So, should I create separate files, following the grouping suggestion,
> for the v2 of this patch?

Shrug. There's no hard rule here, it's a judgment call. With one
if/then block dropped, it's a bit more tolerable to keep it as-is. If
the if/then schemas are as long as the rest of the schema (minus any
example), then I would say to split the schemas.

Rob

