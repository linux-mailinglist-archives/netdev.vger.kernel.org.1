Return-Path: <netdev+bounces-306291-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id g2dRHrK6T2qUnQIAu9opvQ
	(envelope-from <netdev+bounces-306291-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 17:13:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F9D9732AFB
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 17:13:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=CgLAoD0d;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306291-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-306291-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 17B62303CE22
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 14:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CE21386550;
	Thu,  9 Jul 2026 14:56:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F767377010;
	Thu,  9 Jul 2026 14:56:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783609004; cv=none; b=W+PXpbJBbS4ahmES4o245rIeWmnX9TUZTGetKnbGIQ4t2UAGq3+5aWDR176/ejoHwfchPexBdZEamcPG39CMU4OdAB+hN+g6XZ2NuF8uEa0rxht5mDVkFak88v26HhFNw8YYZPkhkwftYRiKgUfKHXLg10BFGmgK+ZgmdxolP5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783609004; c=relaxed/simple;
	bh=TQJVSEmgK2pnRa/3kxBc52RgFa45Ds4FjAw5r6rfJWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q5xi46Q+5cVuBFT7eU4tS5BdjAjDbx5hbaAEogDyYay4czucvJ9SlsqIFuXnm1VLcTwEA7+myZQl9g11XxYP9PlnQQRz9TZPfxpnwksgd/M00OkoSqOpYm7xgEO/Ff52wHHg+KS+yqZV+O+JRhSwkcvzD9j/6co6COidp779YL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CgLAoD0d; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 565A91F00A3A;
	Thu,  9 Jul 2026 14:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783609002;
	bh=8PPdhyG/OoajmkoLXEs7JweRhIy9ufxWopM4fkiI5W4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CgLAoD0dCog/p6/lFqW8T5sTI0crksNMdA64HYysAMw4rTwKP2jZbD66K7Lm/lHds
	 MZ+VFx6/EJiGMpD4HBYwZsg84Emt7mGIPhkVw2ZfoO87bOY4re7GtvUNvrfPE0BMKw
	 jDuYf3lXi+XAxiATFG+eOwTxoR1ZcjhWu5z0FdFHDcP+ZhSXyph0ssHA5ZRL54WhaS
	 bi5PmcIqOdRLkgBrE+aAv+NTsN0dSsMCU4iAFgZYxw31h4XM4NQRUQ1LK17a4A0Nb/
	 q6FJV+lhuJ4/xVrt26mt0OQ3eLPgbwrfWTcdghUu3sXtL+feNLJUaUA712LfSBmily
	 2W9mfZiD8o6QQ==
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
Subject: Re: [PATCH net v2 1/2] net: fman: move IRQ registration after init to prevent NULL deref and UAF
Date: Thu,  9 Jul 2026 15:52:23 +0100
Message-ID: <20260709145221.1564906-3-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260703074324.907294-1-zhaojinming@uniontech.com>
References: <20260703074324.907294-1-zhaojinming@uniontech.com>
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
	TAGGED_FROM(0.00)[bounces-306291-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 0F9D9732AFB

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev

Simon says:

I think we can treat the pre-existing issue flagged below in the context of
possible follow-up. But I'm wondering if you could take a look over
the first issue.

---
net: fman: move IRQ registration after init to prevent NULL deref and UAF

This commit moves IRQ registration in the fman driver from read_dts_node() to
fman_probe() after fman_init() has completed. The intention is to avoid a NULL
dereference or use-after-free caused by shared interrupts firing before the
driver state is fully initialized.

Link: https://lore.kernel.org/netdev/20260626162323.GE1310988@horms.kernel.org/

> diff --git a/drivers/net/ethernet/freescale/fman/fman.c b/drivers/net/ethernet/freescale/fman/fman.c
> index 299bab043175b..6947f3bc7c87e 100644
> --- a/drivers/net/ethernet/freescale/fman/fman.c
> +++ b/drivers/net/ethernet/freescale/fman/fman.c

[ ... ]

> @@ -2848,6 +2829,35 @@ static int fman_probe(struct platform_device *of_dev)
>  		return -EINVAL;
>  	}
>  
> +	/* Register IRQ handlers only after initialization is complete.
> +	 * This prevents two issues:
> +	 * 1) Pre-init NULL dereference: is_init_done(NULL) returns true,
> +	 *    so a shared-IRQ spurious firing before fpm_regs is set would
> +	 *    dereference NULL.
> +	 * 2) Use-after-free on probe failure: fman was kzalloc'd (not devm),
> +	 *    so on error paths kfree(fman) ran before devm_free_irq, leaving
> +	 *    a window where the handler could fire with a freed dev_id.
> +	 * By registering here, both problems are eliminated.
> +	 */
> +	err = devm_request_irq(dev, fman->dts_params.irq, fman_irq,
> +			       IRQF_SHARED, "fman", fman);

Simon says:

It seems to me that one possible way to address the raced flagged
below would be to register the handler earlier, but have a flag
so that that the handler is effectively an noop until initialisation
is complete.

[Severity: High]
Can this race condition lead to an unhandled interrupt storm and disable the
shared IRQ line?

By moving the IRQ registration here, the handler is registered after
fman_init() has completed. The fman_init() function configures the hardware
and enables its interrupts (e.g. via fpm_init() and enable()). Because the
interrupt is shared (IRQF_SHARED), the IRQ line might already be unmasked by
another device.

If the FMan hardware asserts an interrupt in the window between fman_init()
completing and this handler being registered, the shared IRQ will fire. The
other device's handler will return IRQ_NONE, and since the FMan handler is
absent, no one will clear the FMan interrupt.

This interrupt storm would cause the core IRQ subsystem to permanently
disable the shared IRQ line.

[Severity: High]
This is a pre-existing issue, but does the driver leak dynamically allocated
resources when unbound?

The FMan driver allocates several non-devm-managed resources (e.g., fman
via kzalloc_obj, fman->state, fman->cfg, and MURAM allocations). However,
the platform_driver structure completely lacks a .remove callback.

If the device is unbound via sysfs or the module is unloaded, the core
driver subsystem tears down devm resources like IRQs, but the dynamically
allocated FMan structures and MURAM pools appear to be permanently leaked.

[Severity: High]
This is a pre-existing issue, but can child devices (MACs) probe before the
FMan parent initialization is complete, leading to permanent probe failures?

In fman_probe(), read_dts_node() is called first, which calls
of_platform_populate() to create child MAC devices before the FMan parent
has finished initializing:

fman_probe() {
    fman = read_dts_node(of_dev); /* Calls of_platform_populate() */
    ...
    err = fman_config(fman);
    ...
    if (fman_init(fman) != 0) {
    ...
    dev_set_drvdata(dev, fman);
}

If the MAC driver is already registered when of_platform_populate() is
called, the MAC devices will probe synchronously. Their probe routine
calls fman_bind(), which reads the parent's driver data via
dev_get_drvdata().

Since dev_set_drvdata() is not called until the very end of fman_probe(),
fman_bind() would return NULL, causing the MAC probe to fail with -ENODEV.

> +	if (err < 0) {
> +		dev_err(dev, "%s: irq %d allocation failed (error = %d)\n",
> +			__func__, fman->dts_params.irq, err);
> +		return err;
> +	}

