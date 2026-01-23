Return-Path: <netdev+bounces-252625-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aA5bFf/mcmmErAAAu9opvQ
	(envelope-from <netdev+bounces-252625-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 04:11:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 55D306FEF0
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 04:11:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5A45D3002531
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 03:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9368337F8D3;
	Fri, 23 Jan 2026 03:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fj1R0gOL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7AF1324B22;
	Fri, 23 Jan 2026 03:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769137909; cv=none; b=CbINqk/cT8hjsikJ5LjGEe077ymtdCYvWAk45jUzuNNh9TzkAmc7wppm8sQKoBYXJr3u7RKBUn8KL6cuXsUkz9YSoVFrBTAcOnwgeOQ5QoI77v17Su1rCIeqAYjdd80LsZySlox2BFt3yRYWmAPhecLARdNpfvvfDaTmuEEgA1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769137909; c=relaxed/simple;
	bh=2sduAVtZ4sB8Xd4nr5su39mrxAhJpvtA6zzQa7Mf+Do=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BiZL0RFLMcQCT9CiCAmumCRsMgU9tWVNMbSEaoTYTR8C+Gs1kfqLBE3egXumCumj8Rz/9JkXx7feS22caoS6AAqFyMfbsrSl6urqGdkxD7S/y1wFsP9ipDds8mdPEqhuccIgTijRjN8Ff9UYtaf1+wbG9AngjBhQwHXQwFp4nAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fj1R0gOL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76D01C116C6;
	Fri, 23 Jan 2026 03:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769137908;
	bh=2sduAVtZ4sB8Xd4nr5su39mrxAhJpvtA6zzQa7Mf+Do=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fj1R0gOLXQUlFV3n7CSQAixhVa2ZWA18o7kpvaFwNZqp679B28Fi7ZvcfkzlHy8ZL
	 71LQ2/8l+4ggAMsuaY4KT4up2NbE1UJRc5XJ9OUIo2MSm1Tcr1lqwJ+McFmgRKI7e0
	 uzD6p7KWyF7iD4CrEzmL9jaLLYyyvB9vKYFywt0wqXSpkkrddkb+PpwLWZ8c8RXeg/
	 sD3cqqGdPWqz94sNG7VJUI7/e603y0jBa7l57RosrsZtVmiVy+PzH0idRmwA+P+w4h
	 QVjPwnPOVzJhcfQoxxEtBx9BQsM7Cn46HpwTnydgsrfvOy6nir4xY0WaALfgqVYQ0f
	 ir7IyRs7p84LA==
From: Jakub Kicinski <kuba@kernel.org>
To: itazur@amazon.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	graf@amazon.de,
	itazur@amazon.co.uk,
	conor+dt@kernel.org,
	dwmw2@infradead.org,
	devicetree@vger.kernel.org,
	xmarcalx@amazon.co.uk,
	linux-kernel@vger.kernel.org,
	edumazet@google.com,
	robh@kernel.org,
	richardcochran@gmail.com,
	andrew+netdev@lunn.ch,
	mzxreary@0pointer.de,
	pabeni@redhat.com,
	dwmw@amazon.co.uk,
	netdev@vger.kernel.org,
	krzk+dt@kernel.org,
	davem@davemloft.net,
	mail@bchalios.io
Subject: Re: [v6,2/7] ptp: vmclock: support device notifications
Date: Thu, 22 Jan 2026 19:11:34 -0800
Message-ID: <20260123031133.3059291-2-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260121143402.3092-3-itazur@amazon.com>
References: <20260121143402.3092-3-itazur@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,amazon.de,amazon.co.uk,infradead.org,vger.kernel.org,google.com,gmail.com,lunn.ch,0pointer.de,redhat.com,davemloft.net,bchalios.io];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[20];
	TAGGED_FROM(0.00)[bounces-252625-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.993];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 55D306FEF0
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
ptp: vmclock: support device notifications

This patch adds optional device notification support to VMClock, allowing
the hypervisor to notify the driver when seq_count changes. It also adds
poll() support to propagate these notifications to userspace.

> diff --git a/drivers/ptp/ptp_vmclock.c b/drivers/ptp/ptp_vmclock.c
> index b3a83b03d9c1..38b2bacb755e 100644
> --- a/drivers/ptp/ptp_vmclock.c
> +++ b/drivers/ptp/ptp_vmclock.c

[ ... ]

> +static void
> +vmclock_acpi_notification_handler(acpi_handle __always_unused handle,
> +				  u32 __always_unused event, void *dev)
> +{
> +	struct device *device = dev;
> +	struct vmclock_state *st = device->driver_data;
> +
> +	wake_up_interruptible(&st->disrupt_wait);
> +}
> +
> +static int vmclock_setup_notification(struct device *dev, struct vmclock_state *st)
> +{

[ ... ]

> +	status = acpi_install_notify_handler(adev->handle, ACPI_DEVICE_NOTIFY,
> +					     vmclock_acpi_notification_handler,
> +					     dev);

Since acpi_install_notify_handler() is called here, should there be a
corresponding acpi_remove_notify_handler() in vmclock_remove()? Currently
the handler remains registered after device removal, which could lead to
a use-after-free if the hypervisor sends a notification after the driver
state has been freed.

[ ... ]

> @@ -549,6 +653,11 @@ static int vmclock_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>
> +	init_waitqueue_head(&st->disrupt_wait);
> +	ret = vmclock_setup_notification(dev, st);
> +	if (ret)
> +		return ret;

[ ... ]

> @@ -581,6 +690,8 @@ static int vmclock_probe(struct platform_device *pdev)
>  		return -ENODEV;
>  	}
>
> +	dev->driver_data = st;

Is there a race window here? The ACPI notification handler is installed
in vmclock_setup_notification() which runs earlier in vmclock_probe(),
but the handler accesses device->driver_data. If the hypervisor sends a
notification between vmclock_setup_notification() and this assignment,
vmclock_acpi_notification_handler() would dereference NULL or garbage.

I see this is fixed later in the series by commit 47fdd294385e which
moves dev->driver_data = st before vmclock_setup_notification().
-- 
pw-bot: cr

