Return-Path: <netdev+bounces-273419-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WO/nIK0by2kEEAYAu9opvQ
	(envelope-from <netdev+bounces-273419-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 02:56:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 849E6362E55
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 02:56:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 535043016173
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 00:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3562930148B;
	Tue, 31 Mar 2026 00:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rYN1BQDI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11FF62F0C45
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 00:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774918546; cv=none; b=vBylVHJ8rQ3qenMXGPYW/H5nKzdDGcl7B4+0eHuMZ4qkb9WTKiWCS7yv3hUTLQbFOlI0U2BA7X91vl8HKvX7/R+iMJMrDfefCUHb6qzG8tqp7uS2fTfbrf5JOBMp5EY7ULsFFO82cRyHBVcWVABcmKdlqItnDNcD1RqoG4Mktcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774918546; c=relaxed/simple;
	bh=6VWnwKCtLnWqHGSa40yFHxYONx3Lgko7Y7sHDwXSda8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JxefLrOaTy+D0Oh4fkmI+JR8GIk0SgMLnW8GPI0Mdxmc3iMeG5/TVbK3wMQAGHr6X3sL7j6oNxQjsozTHR0SDNA08UWJ2eS4luRVSjYSDjrTyYRXG0LVVw5zoVEsftXxdOomiogo4Y9KiqgMWmoS7JC5Yk1dBTJk2oNejBDd09U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rYN1BQDI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45F6FC4CEF7;
	Tue, 31 Mar 2026 00:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774918545;
	bh=6VWnwKCtLnWqHGSa40yFHxYONx3Lgko7Y7sHDwXSda8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rYN1BQDISx/fEKeahPT0/1kRmWI8hoO2QNsmenKYDjX/Je0JlpJh7Y9pvAtrXjRtV
	 FiAbhtWUPo4x/44MxT77QTBdUAxr/3d9Z1AN2e8H4B+zTYCVcBTSl8doEevyPM6+Xp
	 CrIuLoKSY1UvFN4OpJ9xK0tMo+71enGweOKPs3t5cx2wGcEaKZ7ebbpTHbRLUAMrBC
	 dMabwF0PnnN18aa+SRFt3Je8Wnu/xzqdVMwXbE8THGsxbYWiP81jwrJVGezNzvsulW
	 PLa3kozfdj4oCWq7KgyIB8HRtoqCtXEGzjuuzJtmSPWJfbgacCxuWlWXzOLdwry1ih
	 rHp1Gfny4y9Yg==
From: Jakub Kicinski <kuba@kernel.org>
To: jiawenwu@trustnetic.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	mengyuanlou@net-swift.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	richardcochran@gmail.com,
	linux@armlinux.org.uk,
	horms@kernel.org,
	michal.swiatkowski@linux.intel.com,
	jacob.e.keller@intel.com,
	kees@kernel.org,
	joe@dama.to,
	larysa.zaremba@intel.com,
	abdun.nihaal@gmail.com,
	leitao@debian.org
Subject: Re: [PATCH net-next v6 08/11] net: wangxun: delete service_timer before cancel service_work
Date: Mon, 30 Mar 2026 17:55:40 -0700
Message-ID: <20260331005540.3459751-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260326021406.30444-9-jiawenwu@trustnetic.com>
References: <20260326021406.30444-9-jiawenwu@trustnetic.com>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,net-swift.com,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com,armlinux.org.uk,linux.intel.com,intel.com,dama.to,debian.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-273419-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 849E6362E55
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: wangxun: delete service_timer before cancel service_work

This commit reorders timer cancellation before work cancellation in the
device removal path to prevent new work from being queued after the
device goes down.

> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c b/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
> index ade2bfe563aaa..5565062c74713 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
> @@ -48,6 +48,7 @@ void wxvf_remove(struct pci_dev *pdev)
>  	struct wx *wx = pci_get_drvdata(pdev);
>  	struct net_device *netdev;
>  
> +	timer_delete_sync(&wx->service_timer);

Is timer_delete_sync() the right API to use here? Since this is a device
teardown path, using timer_shutdown_sync() would permanently prevent the
timer from being re-armed by concurrent operations.

>  	cancel_work_sync(&wx->service_task);
>  	netdev = wx->netdev;
>  	unregister_netdev(netdev);

Does cancelling the timer and work before unregister_netdev() leave a race
window?

Since the network interface is still registered and hardware interrupts
are not yet disabled, could an interrupt or a concurrent interface up
operation call wx_service_event_schedule() and place wx->service_task
back into the workqueue?

If unregister_netdev() then completes without cancelling this newly
queued work, could the work execute after the wx structure is freed,
resulting in a use-after-free? Moving the sync cancellations after
unregister_netdev() might prevent this.

> diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
> index ddc7cea9d7c28..01ceaf270b706 100644
> --- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
> +++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
> @@ -936,6 +936,7 @@ static void txgbe_remove(struct pci_dev *pdev)
>  	struct txgbe *txgbe = wx->priv;
>  	struct net_device *netdev;
>  
> +	timer_delete_sync(&wx->service_timer);
>  	cancel_work_sync(&wx->service_task);
>  
>  	netdev = wx->netdev;

The same questions regarding timer_shutdown_sync() and the potential race
window with unregister_netdev() apply to this removal function as well.

