Return-Path: <netdev+bounces-298256-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id c8F/BRv0KmrjzwMAu9opvQ
	(envelope-from <netdev+bounces-298256-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 19:44:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 63C6F6741DD
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 19:44:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=AfsP4y7G;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298256-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298256-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1EA7F334E4F1
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 17:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D53F94BC029;
	Thu, 11 Jun 2026 17:33:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8277734252C
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 17:33:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781199201; cv=none; b=pzAw7rS+waxBGBXrUmRrl2g5Q11D1eVCFRFmf3G1Q7Bs4AQaLuMROpflkj5cMsIzMOVOyxKC5ODjVzfMRQaHdy6hzSEXLuUmEZAgeaephmAQdYjflGbjerIW6ZKKiKPAwAxm6qVERt5M/fRtV6Q47Qr6QJYqifoa+b9N2J/v9SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781199201; c=relaxed/simple;
	bh=p/XuMMQyoJRdJnJHMggCcDRZSsMCFaKh4AEgIW31fB8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ByscpGEboGDBBO95FbF9KLMGVIyiodAUK0Q37v8XVeJAkZa7mFJPRfca2xGdWBbLrGzbXHnnykO4vzx37uC9iQILuMxIfTcIzIKleuzJtsz8gXrPAUI2KvAGyC09C98DxKmPSV/KaBLGuOCWGvm/A0ojMer3yXzm3QNiwjP2mHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AfsP4y7G; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22A911F00893;
	Thu, 11 Jun 2026 17:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781199198;
	bh=LcnIak9Up9bACPzVo+bxEKJ/PBQ1lSy/+hG/6TAFxuA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AfsP4y7GSU2VVp8mFqZBdThNX50nAGF1QOGHMskqCrGBbHrIXMspO+nWkZ/51pCXn
	 Uf8CiaseepZMoyJ9qMdjguRUXWCEQOGcU6mDf0XJEyN9OgaLzi6jsGnWlo4QJ8rlcw
	 1sWeQUcqBLIhdWgThSjO6D67OEROmU+1r8PLoSMnTZL8zQr6TswZFn37XuvAry8Cv3
	 J9y5NHO2XuKJCoxaU6M2jCJreEEa0wEOFT0F+QRIcWDQKIc0JBDjemvmcXJnoso34W
	 5fzsWbhHFkSS1OfT9VEgSqQajDo4PboTKMsMBoGX2CaegG/C7D9g1vxIGUNr6eTYAV
	 tP1M0fpwFSmvg==
From: Simon Horman <horms@kernel.org>
To: nikhil.rao@amd.com
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	kuba@kernel.org,
	brett.creeley@amd.com,
	eric.joyner@amd.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com
Subject: Re: [PATCH net] pds_core: fix use-after-free on workqueue during remove
Date: Thu, 11 Jun 2026 18:32:02 +0100
Message-ID: <20260611173201.631727-2-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260610025952.196470-1-nikhil.rao@amd.com>
References: <20260610025952.196470-1-nikhil.rao@amd.com>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-298256-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:nikhil.rao@amd.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:kuba@kernel.org,m:brett.creeley@amd.com,m:eric.joyner@amd.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 63C6F6741DD

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
pds_core: fix use-after-free on workqueue during remove

This commit fixes a use-after-free on the workqueue during remove by
destroying the workqueue earlier and setting pdsc->wq to NULL.

> diff --git a/drivers/net/ethernet/amd/pds_core/main.c b/drivers/net/ethernet/amd/pds_core/main.c
> index 22db78343eb07..cb3ac26266aa7 100644
> --- a/drivers/net/ethernet/amd/pds_core/main.c
> +++ b/drivers/net/ethernet/amd/pds_core/main.c
> @@ -435,8 +435,10 @@ static void pdsc_remove(struct pci_dev *pdev)
>  		pdsc_auxbus_dev_del(pdsc, pdsc, &pdsc->padev);
>  
>  		timer_shutdown_sync(&pdsc->wdtimer);
> -		if (pdsc->wq)
> +		if (pdsc->wq) {
>  			destroy_workqueue(pdsc->wq);

[Severity: High]
This is a pre-existing issue, but can this destroy_workqueue() call deadlock
with pdsc_pci_reset_thread()?

The PCI subsystem holds device_lock() when calling pdsc_remove().
If pdsc_pci_reset_thread() is currently executing on this workqueue,
destroy_workqueue() will block waiting for it to finish.

However, pdsc_pci_reset_thread() calls pci_reset_function(), which attempts
to acquire the same device_lock(), resulting in a deadlock.

> +			pdsc->wq = NULL;

[Severity: High]
Can setting pdsc->wq to NULL here introduce a regression where the interrupt
handler dereferences a NULL pointer?

This assignment is executed before set_bit(PDSC_S_STOPPING_DRIVER,
&pdsc->state) and before pdsc_stop() masks hardware interrupts.

If an interrupt fires (e.g., a NotifyQ event) in this window,
pdsc_adminq_isr() will run. Because the PDSC_S_STOPPING_DRIVER state is not
yet set, the ISR check succeeds and it will unconditionally call queue_work()
with the NULL pdsc->wq:

pdsc_adminq_isr()
    ...
    queue_work(pdsc->wq, &qcq->work);

> +		}
>  
>  		mutex_lock(&pdsc->config_lock);
>  		set_bit(PDSC_S_STOPPING_DRIVER, &pdsc->state);

