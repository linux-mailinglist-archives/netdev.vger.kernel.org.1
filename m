Return-Path: <netdev+bounces-304211-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ol4sN0h5Rmo6WwsAu9opvQ
	(envelope-from <netdev+bounces-304211-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 16:44:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 126E76F8FCC
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 16:44:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=lqcrlSz1;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304211-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-304211-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D958130D9BEA
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 14:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79842307AE3;
	Thu,  2 Jul 2026 14:39:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6172DC32A
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 14:39:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783003176; cv=none; b=TCJx9jIaLL8wI5FWvHpGPixHNjlhYcBVkbo275C6sKBymVRYp+KGnZy/uPeYIuwNd8NmjCYsuLKg3TpUxOcyoI/Siz5DsOZw6L7QxSymu9SJpUQD5n3rogFkHEzvi34G5v9tMvae08al73gvV0KAUtuCYGVQ9WhMEGPGm4gkWGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783003176; c=relaxed/simple;
	bh=L/NPPzq5kHhvrv6QsuzJnS6MZrQcmR/YB+ex+RGiEMA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Jy1Sf+hR0ifQJcd3xdeDxiZEV37nXnL6EVhp1LQVe/iaZRZwtsAfX7gxlTiOcXSgY8ZqbqnkmrkPfUb8omA9zFCrLBwEjk2N86nJq2yJr4gaHETwPFLLJVQ15dDCfPz0wswtlmfdo1f8M3LqALnPSDZILS00P14kt481gZga6p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lqcrlSz1; arc=none smtp.client-ip=91.218.175.179
Message-ID: <21d2e632-5307-4b48-be7b-1269b55f70fe@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783003170;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LWjwaroNdzliIQJ8UoOAO9arkJPTrD2GvIpHaj+RIz0=;
	b=lqcrlSz1fHkJhbMBRjSnMc+0uyXmMqsNEOivvoO232q2zS5L+FCwL7znNbdfBU0rIGJPS1
	k0SK5PYtKW9lC66EN1q1YhuWJV3cnOIPrhL2Ue6DXuWsSydBFqD7U34bbsPZjAmTPzhHsL
	iJ9gK2/z/XDYUrGqSqj6ES0aNqb+/ys=
Date: Thu, 2 Jul 2026 15:39:25 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v4 2/3] ptp: Add driver for R-Car Gen4
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
References: <20260702125525.2230427-1-niklas.soderlund+renesas@ragnatech.se>
 <20260702125525.2230427-3-niklas.soderlund+renesas@ragnatech.se>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260702125525.2230427-3-niklas.soderlund+renesas@ragnatech.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:niklas.soderlund+renesas@ragnatech.se,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:geert+renesas@glider.be,m:magnus.damm@gmail.com,m:richardcochran@gmail.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-renesas-soc@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:niklas.soderlund@ragnatech.se,m:krzk@kernel.org,m:conor@kernel.org,m:geert@glider.be,m:magnusdamm@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-304211-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[ragnatech.se,kernel.org,glider.be,gmail.com,lunn.ch,davemloft.net,google.com,redhat.com,vger.kernel.org];
	FORGED_SENDER(0.00)[vadim.fedorenko@linux.dev,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vadim.fedorenko@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,renesas,dt];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linux.dev:dkim,linux.dev:mid,linux.dev:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,ragnatech.se:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 126E76F8FCC

On 02/07/2026 13:55, Niklas SÃ¶derlund wrote:
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
> ---
> * Changes since v3
> - Clamp increment calculated to register limitations.
> - Check return value of clk_get_rate().
> - Disable PM if ptp_clock_register() fails.
> ---

[...]

> +struct ptp_rcar_gen4_priv {
> +	void __iomem *base;
> +	struct clk *clk;
> +
> +	struct ptp_clock *clock;
> +	struct ptp_clock_info info;
> +
> +	spinlock_t lock;	/* Registers access. */
> +	s64 default_addend;
> +};
> +
> +#define ptp_to_priv(ptp) container_of(ptp, struct ptp_rcar_gen4_priv, info)
> +
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
> +	/* Clamp value to register limits, defined as in nanoseconds.
> +	 * bit[31:27] - integer
> +	 * bit[26:0]  - decimal
> +	 */
> +	addend = clamp_val(addend, 0, UINT_MAX);

is it always positive number?

> +
> +	spin_lock_irqsave(&priv->lock, flags);
> +	iowrite32(addend, priv->base + PTPTIVC0_REG);
> +	spin_unlock_irqrestore(&priv->lock, flags);
> +
> +	return 0;
> +}

[...]

> +static struct ptp_clock_info ptp_rcar_gen4_info = {
> +	.owner = THIS_MODULE,
> +	.name = "R-Car Gen4 gPTP",
> +	.max_adj = 50000000,

even though clamping addend may work, I would suggest adjusting
".max_adj" value to the one which will not make addend overflow.
And as a reminder, .max_adj is the absolute value in ppb that can be set
for a single call of .adjfine - the value is checked against
[-(.max_adj),.max_adj] range.

> +	.adjfine = ptp_rcar_gen4_adjfine,
> +	.adjtime = ptp_rcar_gen4_adjtime,
> +	.gettime64 = ptp_rcar_gen4_gettime,
> +	.settime64 = ptp_rcar_gen4_settime,
> +};

