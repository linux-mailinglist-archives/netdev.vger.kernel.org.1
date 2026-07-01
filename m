Return-Path: <netdev+bounces-303857-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RlQ4CBCMRWo9BwsAu9opvQ
	(envelope-from <netdev+bounces-303857-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 23:52:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 69D036F1F70
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 23:52:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=rzoGVCf9;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303857-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303857-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 63DD9305488C
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 21:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA0937206F;
	Wed,  1 Jul 2026 21:47:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7B825333F
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 21:47:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782942454; cv=none; b=S5CRMFoCNsBRlBpLT8tYg3PlGU/g1YtVpca5ekmArLGg27aoabGBdpwaeDmDkkbOXKiJ09rjSwdUx12o4HBhCbYtMoQ6dP3wSvQOH6PrB96NeNnbGn79C8UvrHTVdBUNkXneqj3v+rFsjN2Cta64wWzmayK6HYZ4I33eFwWeOeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782942454; c=relaxed/simple;
	bh=U1MHLwzs2hVH2Bl+EC1aDM8E/bTMCVplBdWelSXv1rA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=hZHyYQv3Xx270ul+mvDp9xm5Nz7jqtsktmW+slO7UIICgT8qr0aWTYBT9ZUrxGQHMGmypjWwOw2dJwikMB7bZ+crwuYp5VcTmcaxwP67O/zFyXUx+2Nr4h71Z6UXKQWLH+Nl+ev14TP00DojPsf5bWs0JW5XcQ2q3Ino5Mg+7PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rzoGVCf9; arc=none smtp.client-ip=95.215.58.189
Message-ID: <89720193-e8ad-4bb3-b6d2-3253413b18ab@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782942450;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zfnpZAPYTjU1y1/bwelr25Tajv7sMv4wyV/Tmx+tLN8=;
	b=rzoGVCf9Acoz9pVzpj75/n7UWOFKgNHVycrnsStv71NID/Qz5Ub0cTx3lcOw5vNVod2J6N
	TsrOJMMr/45V3a5iN9QYmSE0AT8pNjLNo09jOfmP6GhFin4fHZ8svOooad4TGjqFxRENlu
	Ic/WX4RdMeR75Zo13tcGVVOEwoSEDrA=
Date: Wed, 1 Jul 2026 22:47:16 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v3 2/3] ptp: Add driver for R-Car Gen4
To: =?UTF-8?Q?Niklas_S=C3=B6derlund?=
 <niklas.soderlund+renesas@ragnatech.se>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "DavidS. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, linux-renesas-soc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
References: <20260701090607.1108208-1-niklas.soderlund+renesas@ragnatech.se>
 <20260701090607.1108208-3-niklas.soderlund+renesas@ragnatech.se>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260701090607.1108208-3-niklas.soderlund+renesas@ragnatech.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-303857-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:niklas.soderlund+renesas@ragnatech.se,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:geert+renesas@glider.be,m:magnus.damm@gmail.com,m:richardcochran@gmail.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-renesas-soc@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:niklas.soderlund@ragnatech.se,m:krzk@kernel.org,m:conor@kernel.org,m:geert@glider.be,m:magnusdamm@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[ragnatech.se,kernel.org,glider.be,gmail.com,lunn.ch,davemloft.net,google.com,redhat.com,vger.kernel.org];
	FORGED_SENDER(0.00)[vadim.fedorenko@linux.dev,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vadim.fedorenko@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,renesas,dt];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 69D036F1F70

On 01/07/2026 10:06, Niklas SÃ¶derlund wrote:
> Add driver for the gPTP timer found on R-Car Gen4 devices. The timer is
> system-wide and shared by different Ethernet devices on each Gen4
> platform. The operation of the timer is however not completely in
> depended of the systems Ethernet devices.
> 
>    - On R-Car S4 is gated by the RSWITCH Ethernet module clock.
> 
>    - On R-Car V4H is gated by the RTSN Ethernet module clock.
> 
>    - On R-Car V4M is gated by its own module clock, the system have
>      neither RTSN or RSWITCH device. But the module clock is the same as
>      RTSN on V4H and the documentation referees to it as tsn (EtherTSN).
> 
> The gPTP device do have its own register space on all three platforms.
> But on S4 and V4H it will share its clock and reset property with
> RSWITCH or RTSN, respectively.
> 
> Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

[...]

> +static int ptp_rcar_gen4_adjfine(struct ptp_clock_info *ptp, long scaled_ppm)
> +{
> +	struct ptp_rcar_gen4_priv *priv = ptp_to_priv(ptp);
> +	s64 addend = priv->default_addend;
> +	bool neg_adj = scaled_ppm < 0;
> +	unsigned long flags;
> +	s64 diff;
> +
> +	if (neg_adj)
> +		scaled_ppm = -scaled_ppm;
> +	diff = div_s64(addend * scaled_ppm_to_ppb(scaled_ppm), NSEC_PER_SEC);
> +	addend = neg_adj ? addend - diff : addend + diff;
> +
> +	spin_lock_irqsave(&priv->lock, flags);
> +	iowrite32(addend, priv->base + PTPTIVC0_REG);

how are you so sure that addend will always fit into s32? It looks like
it may go over in some cases, no?

> +	spin_unlock_irqrestore(&priv->lock, flags);
> +
> +	return 0;
> +}


