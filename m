Return-Path: <netdev+bounces-306293-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id P7DCMZm6T2qSnQIAu9opvQ
	(envelope-from <netdev+bounces-306293-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 17:13:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 146A9732AF1
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 17:13:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=fiMk1Kv2;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306293-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-306293-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8D8EF30A2FAC
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 14:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE98A382F28;
	Thu,  9 Jul 2026 14:58:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2442386C0A;
	Thu,  9 Jul 2026 14:58:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783609104; cv=none; b=AFH+u4oVM58FBn2UXsVTmNKJNjhCEvIQPm2P63RyebEoJVa3ldpl6H4ByLTUbkk1xxJwAOgLwdXdVpFRiswmgdr+pl9gf7WR4FJN1Ss4d2fmG0Qazktv4eho4zSU7fvKo/J2ymJvjITm23Syd5xmZVbpvzFqtbv2xG8eSX5nFlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783609104; c=relaxed/simple;
	bh=M2o5JBhcjSo6kFgzOaEEFUvnEMWhmrc8EJQoSa/YG7g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dxEKggz/l9xpViHYDuSHMqZCknElMFSSyoSfSOwV+9gPC0MYuRitv+mYvVBWPL9ZzP7cYt2yKSj88ubNSh5Vcll28S93gQUqfyM3iMiZ7nuuvmmJCQ2TgV4SdIU2WTuJTwLefvqYLFIVmPdkOMUESzg07XPuFtEmau0gVzfWIZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fiMk1Kv2; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B7B31F000E9;
	Thu,  9 Jul 2026 14:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783609103;
	bh=i8AtWB/O+soBGuSWP3QFa65Z4LA4DVivyGGeko0k400=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fiMk1Kv25zzEEjKvgoVw7WxR0leENu/UuhCZnVxUjJE8AbQ6myW4veAKuhpxHPoJH
	 iw1SBNrp7FUwXSM9PW6aF65eXgaoS86mL7DqCYoUALG5ooKQpBa7unkJK2nSzpi/h5
	 vzU92eeCc1UJ/1OMKywfi6pBAeI5CZRZJVxA7MOgXw+qfD1Xmf18ZBp0shh6b944hM
	 wTURj5MhFuAOBSobRNpgFvP5fB3vNEBa2nkfb3iQ1auvsqOs69RPFkZ7N5s4RJH56R
	 SPdL81RwZHl+2FbKogN0ETbcMfblfjaypmvHqtHfBiuKvU6Bqawa0VRvoZyZ4uNggO
	 kj54PsfgPPbtQ==
From: Simon Horman <horms@kernel.org>
To: zhaojinming@uniontech.com
Cc: Simon Horman <horms@kernel.org>,
	madalin.bucur@nxp.com,
	sean.anderson@linux.dev,
	netdev@vger.kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	igal.liberman@freescale.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 2/2] net: fman: add error cleanup path in fman_probe
Date: Thu,  9 Jul 2026 15:56:48 +0100
Message-ID: <20260709145647.1567539-2-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260703074324.907294-2-zhaojinming@uniontech.com>
References: <20260703074324.907294-2-zhaojinming@uniontech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-306293-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:zhaojinming@uniontech.com,m:horms@kernel.org,m:madalin.bucur@nxp.com,m:sean.anderson@linux.dev,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:igal.liberman@freescale.com,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,sashiko.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 146A9732AF1

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
net: fman: add error cleanup path in fman_probe

This commit introduces a new error cleanup path in fman_probe() to prevent
memory leaks when fman_init() or devm_request_irq() fail. It adds
fman_muram_finish() and fman_free_resources() to properly tear down
allocations and states.

> diff --git a/drivers/net/ethernet/freescale/fman/fman.c b/drivers/net/ethernet/freescale/fman/fman.c
> index 6947f3bc7c87e..752c0df0e17c5 100644
> --- a/drivers/net/ethernet/freescale/fman/fman.c
> +++ b/drivers/net/ethernet/freescale/fman/fman.c

[ ... ]

> +static void fman_free_resources(struct fman *fman, struct device *dev,
> +				bool irq_registered)
> +{
> +	/* Free IRQs first while fman is still valid */
> +	if (irq_registered) {
> +		if (fman->dts_params.err_irq != 0)
> +			devm_free_irq(dev, fman->dts_params.err_irq, fman);
> +		devm_free_irq(dev, fman->dts_params.irq, fman);
> +	}
> +
> +	kfree(fman->keygen);
> +	free_init_resources(fman);

[Severity: High]
If fman_init() fails internally (for example, in dma_init() or
keygen_init()), it calls free_init_resources(fman) on its own failure path.
However, it does not clear fman->fifo_offset or fman->cam_offset.

When fman_probe() catches this error, it jumps to err_no_irq and calls
fman_free_resources(), which will invoke free_init_resources(fman) a second
time.

Does this cause a double-free of the MURAM resources?

[Severity: High]
This is a pre-existing issue, but if fman_muram_alloc() fails during
fman_init(), it returns an error code (such as -ENOMEM) which is stored
directly in fman->fifo_offset.

Since the error code is non-zero, free_init_resources() will evaluate
if (fman->fifo_offset) as true and pass the error pointer to
fman_muram_free_mem().

Does attempting to free this pseudo-random error code cause corruption in
the gen_pool allocator?

> +	kfree(fman->cfg);
> +	fman_muram_finish(fman->muram);
> +	kfree(fman->state);
> +	kfree(fman);
> +}

[ ... ]

> @@ -2844,7 +2863,7 @@ static int fman_probe(struct platform_device *of_dev)
>  	if (err < 0) {
>  		dev_err(dev, "%s: irq %d allocation failed (error = %d)\n",
>  			__func__, fman->dts_params.irq, err);
> -		return err;
> +		goto err_no_irq;
>  	}
>  
>  	if (fman->dts_params.err_irq != 0) {

[Severity: High]
If devm_request_irq() fails here, fman_init() has already succeeded. At the
end of fman_init(), the FMan hardware is fully enabled via enable(fman, cfg).

Jumping to err_no_irq calls fman_free_resources(), which destroys the
structures and unmaps the MURAM memory. However, there doesn't appear to be
any call to stop or disable the active hardware.

Will the hardware continue to operate and perform DMA to the freed MURAM
addresses, potentially causing memory corruption?

