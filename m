Return-Path: <netdev+bounces-303811-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id I1hpGGFtRWp4/woAu9opvQ
	(envelope-from <netdev+bounces-303811-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 21:41:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D980E6F0FB3
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 21:41:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="MhLYFGI/";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303811-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303811-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DFD50301A2AB
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 19:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B68AA42642B;
	Wed,  1 Jul 2026 19:33:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850814252BF;
	Wed,  1 Jul 2026 19:33:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782934395; cv=none; b=CcOPCwhwutJNWg/8uxMwrCiLrbQPkNcy2by2y5/gE3DCdtOon9QRTsR3RjiZLkKDg65N4DeLpQATNktHwTfjcXrSa1UxiGObZENh+c/pQJox2NmS81GX/Zd5R9p9n3XTcOk3rIu7DmnhIunLGibUzd/iDFdzZvwpDjPre8w8eMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782934395; c=relaxed/simple;
	bh=VgWJ83UthhnAvdr5Eoj2uXpaRt7ZDKNwQ8no4cpjcqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UH7iYlg3uBG2191prMMv7XeStmmEmJ+kRav5dqev6oVUyl370U7zpejvJSyYM8kJgAj6tJtmYVNs6NeQEuV2cTX5pnQiTbZb1rmFSpKwBccyTGarJvW4mgyRoPmeoUHxjo2x0/UbXCUKVe7DOOpKSpIkwMFQIAKmW/FYvvkICAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MhLYFGI/; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB78F1F00ACF;
	Wed,  1 Jul 2026 19:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782934393;
	bh=y4PTITJeaNIkozE3meEc+/LOStBuvpZ1F0k6rTLYgIc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MhLYFGI/EzKuP0AVdYS4aO1EMqKxNLXd2UtHw+U00joiFOhrJAEyjvIl0cvJ6T6Qg
	 fW5ng+J7F6CL6oYjPneYixOL0SNKMctoP/Q2wnskcH0qzocOhKL93CfIH1NJlFQvaI
	 E9Mfg4QqkMhtKDhW2CxtmLPxDJQvJ19SOn5+5NJUZ4xgajSqShtMk2Q40EUfwf2CGi
	 jeOK6uIld3FhNMt6Az2A5lj0hPSwl0M0Fpti4OPF49D9Nyq9bPYBXBvUmEeZoz2sF6
	 lgHBrjryZeYyqieAhnFf60lYg8NPtmjrFnD66oSKqaK6hF0Y+GgiBlCF3EsUG7zL2M
	 ekVorbgfO2pMg==
Date: Wed, 1 Jul 2026 14:33:11 -0500
From: Rob Herring <robh@kernel.org>
To: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Chun-Jie Chen <chun-jie.chen@mediatek.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Edward-JW Yang <edward-jw.yang@mediatek.com>,
	Richard Cochran <richardcochran@gmail.com>, kernel@collabora.com,
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH 02/15] dt-bindings: clock: mediatek: regroup MT8188
 dt-bindings into MT8186
Message-ID: <20260701193311.GA1402559-robh@kernel.org>
References: <20260701-mt8189-clocks-system-base-v1-0-2b048feea50a@collabora.com>
 <20260701-mt8189-clocks-system-base-v1-2-2b048feea50a@collabora.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701-mt8189-clocks-system-base-v1-2-2b048feea50a@collabora.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-303811-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:louisalexis.eyraud@collabora.com,m:mturquette@baylibre.com,m:sboyd@kernel.org,m:bmasney@redhat.com,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:matthias.bgg@gmail.com,m:angelogioacchino.delregno@collabora.com,m:chun-jie.chen@mediatek.com,m:p.zabel@pengutronix.de,m:edward-jw.yang@mediatek.com,m:richardcochran@gmail.com,m:kernel@collabora.com,m:linux-clk@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:netdev@vger.kernel.org,m:krzk@kernel.org,m:conor@kernel.org,m:matthiasbgg@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[robh@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robh@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[baylibre.com,kernel.org,redhat.com,gmail.com,collabora.com,mediatek.com,pengutronix.de,vger.kernel.org,lists.infradead.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D980E6F0FB3

On Wed, Jul 01, 2026 at 03:11:07PM +0200, Louis-Alexis Eyraud wrote:
> Regroup the MT8188 clock and system clock dt-bindings into MT8186 ones
> to ease maintainability and have common files for several currently
> supported SoC or new future ones, that have the same kind of clock
> controller design.
> 
> Note:
> The `#clock-cells` property is a required property for all compatibles
> declared in MT8188 clock and system clock dt-bindings but not in MT8186
> ones.
> To avoid ABI breakage, conditional blocks to check this requirement
> for MT8188 compatibles are added, rather than enforcing it for MT8186
> compatibles.

If the existing DTs are just wrong, then I would just make #clock-cells 
required. But please update the .dts files so the warnings don't grow.

The grouping I would do here is:

- clock controller only
- reset controller only
- both clock and reset controller

That should avoid any if/then schemas.

Rob

