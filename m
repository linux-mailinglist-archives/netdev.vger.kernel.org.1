Return-Path: <netdev+bounces-290099-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uJXuE/oXDmpT6AUAu9opvQ
	(envelope-from <netdev+bounces-290099-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 22:22:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D815997FC
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 22:22:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 21AF33038119
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 20:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55515363C72;
	Wed, 20 May 2026 20:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="otfqESK+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29AB82C11CF;
	Wed, 20 May 2026 20:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779308535; cv=none; b=rAGjnvWGaR71UmXeOrm0mxyt5ojgc7H9cg5qWeYwP96bnPN8wlHITvZzfJBnwWDnc///t7+TXq4wMkijUj3A33HgwPE99CEDqldOcGvDuddXu+TenhIRpf/gFcr3bPL8MV2r7msxEoHChYWAJ6TIsrm6oXnht3wXiuGPz8WTXRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779308535; c=relaxed/simple;
	bh=nRLqrDYk0roVUBeGzBI1ExnYXIRg22itoV4wyJXntaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VeoTabnt766dtvway8JWnodjpc4Oc7iwsFQNC5k/k+8L+PdVHfFyAxxN4QpXab6kKN6r+IXs0mt9tYxF49peUrftOB54FMMXdwskLIg2U8ARXWB21aaGS7WzCvU//40Eyj3HhsclcEIHTeAQiUW5XKbBTTZ/s8Q1Bw36XlQMqN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=otfqESK+; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EC161F000E9;
	Wed, 20 May 2026 20:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779308533;
	bh=t2xs/wezjVbb05royOoz11bvYw63xJEuge6uovnJQtE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=otfqESK+xcMmlnJRLdgDOVMKUep2r4hwO77Py4qQ1Xxtj3Vo9zswAUCiIsSv1KLvl
	 FJyF09J3y6dY/tWd55o8ze+2mVvkFh5aB995vX01eHlqymkis97AOGKx3fwJIOeZOD
	 6hijIejx/9dPWrs8Q4Z8hH6BpsanpdQhhWjkMYP6PSMTsVGjc2D6ldS3w9RP6BlumS
	 Rlh27Z6WSD5w3IcYBEbWRUcVz5GFz30oWMcc8TT5m5cOI+C6raJ4QsgFkChHN0MR1Q
	 I5QQMWrwBKCINohyXypQmJT79ND1GINXC4RPW0C5gT4zSGcml3VbZkQjIyoDseirQN
	 zqOMLDr9wik9A==
From: Simon Horman <horms@kernel.org>
To: len.bao@gmx.us
Cc: 'Simon Horman' <horms@kernel.org>,
	m.grzeschik@pengutronix.de,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arcnet: com90xx: Mark cards and numcards variables as __ro_after_init
Date: Wed, 20 May 2026 21:16:46 +0100
Message-ID: <20260520201644.1528107-3-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260516134628.30672-1-len.bao@gmx.us>
References: <20260516134628.30672-1-len.bao@gmx.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-290099-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmx.us];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: C2D815997FC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: 'Simon Horman' <horms@kernel.org>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev

Simon says: This is a driver that doesn't seem to have seen any
            real attention for some time. I do wonder if we should
	    leave it be.

	    But as we are here, I'm passing on the AI generated review
	    with some commentary.

---
arcnet: com90xx: Mark cards and numcards variables as __ro_after_init

This commit marks the cards and numcards variables as __ro_after_init since
they are only initialized during the init phase and are never changed
afterward.

> diff --git a/drivers/net/arcnet/com90xx.c b/drivers/net/arcnet/com90xx.c
> index b3b287c165617..bdcdccbfb0017 100644
> --- a/drivers/net/arcnet/com90xx.c
> +++ b/drivers/net/arcnet/com90xx.c
> @@ -67,8 +67,8 @@ static void com90xx_copy_from_card(struct net_device *dev, int bufnum,
>  
>  /* Known ARCnet cards */
>  
> -static struct net_device *cards[16];
> -static int numcards;
> +static struct net_device *cards[16] __ro_after_init;
> +static int numcards __ro_after_init;

Simon says: I believe this is an existing bug rather than a regression.
            But I am concerned that this patch may make it worse.
	    So I'm wondering if it should be fixed at the same time
	    by a series containing:
	    1. a patch to fix this overflow
	    2. this patch (to set __ro_after_init)

Could this change exacerbate an existing regression where we overflow the
cards array?

com90xx_probe() can test up to 32 default I/O ports. For each valid device
found, com90xx_found() unconditionally executes:

drivers/net/arcnet/com90xx.c:com90xx_found() {
    ...
	if (register_netdev(dev))
		goto err_unmap;

	cards[numcards++] = dev;
	return 0;
    ...
}

If more than 16 devices are successfully probed, this writes past the cards
array. Since this patch marks these variables as __ro_after_init, they are
now placed adjacently in memory.

Is it possible that the overflow will now clobber numcards with a pointer
value, leading to an out-of-bounds index on the next iteration?

Simon says: The issue flagged below also appears to be an existing bug
            rather than a regression. And I don't believe it impacts
	    this patch or needs to block progress of it.

Additionally, while reviewing this code, I noticed a second potential
regression in com90xx_found(). Are we registering the IRQ handler before
initializing the function pointers?

drivers/net/arcnet/com90xx.c:com90xx_found() {
    ...
	/* reserve the irq */
	if (request_irq(airq, arcnet_interrupt, 0, "arcnet (90xx)", dev)) {
		arc_printk(D_NORMAL, dev, "Can't get IRQ %d!\n", airq);
		goto err_release_mem;
	}
	dev->irq = airq;

	/* Initialize the rest of the device structure. */
	lp->card_name = "COM90xx";
	lp->hw.command = com90xx_command;
	lp->hw.status = com90xx_status;
    ...
}

If an interrupt triggers immediately after request_irq() completes (e.g., due
to a spurious interrupt), arcnet_interrupt() will execute, evaluate
!netif_running(dev) as true, and invoke lp->hw.status(dev).

Because alloc_arcdev() zero-allocates the private data, lp->hw.status is NULL
at this point. Can this lead to a NULL pointer dereference?

