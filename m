Return-Path: <netdev+bounces-299500-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MbIkHtUcMGp6NwUAu9opvQ
	(envelope-from <netdev+bounces-299500-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 17:40:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D16D1687C99
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 17:40:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=MBzk29dZ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299500-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299500-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5CD8730C5002
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 15:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9D8F3F1AAB;
	Mon, 15 Jun 2026 15:35:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F6A405C52
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 15:35:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781537703; cv=none; b=WvnS/nVDs0r+0tW/CYHZWA2Bye1TpxYrT/RSO/knuJbs3GCwHBvqAzsEdj4GH1MZhS45Jxkz8da2qm0YoHR4ssSYg5LAdf8PmnLaT2XKjtikYxXtQrpIU/CdLLrJkXUeQZe4PIx4bepwATLh042xr60a4Jts07G58HYmwuvAEmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781537703; c=relaxed/simple;
	bh=d98kcthOM0gMZdNWf68Lz6H91/isa754lxZq2ugkS5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jnR/g54T3itO3tniL7RZ+q0MVZW4vfUUlNrcrgnTPxsYn0mNzb8QnJUdQiSPFv8Vfm1MRRrTnQ9ZuEomUNWeH2SAld2MEPKy8BbMfIFs/YcOKUa6q6QWEVYZDL/1LuTHDkokH0BVWiLQH1Cd83tQW7wot1WUsDP4llxZkiQ0wx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MBzk29dZ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA8321F000E9;
	Mon, 15 Jun 2026 15:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781537702;
	bh=KrIaSO/ZO6K1FnrFLw8wD6DuseJBE+Qqfiz9rZBR01Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MBzk29dZNVaLC3Y10iyTWg1g+gDobi84bFPH4oDa+rrI23ZDp0/jvq0hAh1KcOwDA
	 KLS/+mn2ogtdV+p08olD86Rjucvtzgd2v0KnBAFW6poWCEH6RNCrtrxekK9vn1jZ9G
	 5secdHvLjEtVXaw8pGjZK6fWGvhqfPGxKWIATuWyibx9muKgS0pHgtBZtcSYgUAiWS
	 k2hbsScgz5W4u7L3ygGTKmr8wHUazudPtiZrk9Kbg/Hgl8f7INOAs5xlO1qZHWsHsC
	 O3knsWtQ3Ci2c2Nwr84Pf20JgkrR/6GqG3oeD1jC12Fg+GPv0TE13LVbb0SG4SfYQ+
	 VS2towlwaoBhg==
From: Simon Horman <horms@kernel.org>
To: nikhil.rao@amd.com
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	brett.creeley@amd.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	eric.joyner@amd.com
Subject: Re: [PATCH v4 1/6] pds_core: add support for quiet devcmd failures
Date: Mon, 15 Jun 2026 16:34:02 +0100
Message-ID: <20260615153400.772876-3-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260614050052.1048328-2-nikhil.rao@amd.com>
References: <20260614050052.1048328-2-nikhil.rao@amd.com>
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
	TAGGED_FROM(0.00)[bounces-299500-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:nikhil.rao@amd.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:brett.creeley@amd.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:eric.joyner@amd.com,m:andrew@lunn.ch,s:lists@lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,sashiko.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D16D1687C99

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
pds_core: add support for quiet devcmd failures

This commit introduces support for suppressing error messages during device
commands by adding a boolean parameter to wait and lock functions. It changes
pdsc_devcmd_wait and pdsc_devcmd_locked into internal __pdsc_devcmd_wait and
__pdsc_devcmd_locked variants that handle the new messaging flag. This
functionality is intended for negotiating the PDS_CORE_IDENTITY_VERSION_2.

> diff --git a/drivers/net/ethernet/amd/pds_core/dev.c b/drivers/net/ethernet/amd/pds_core/dev.c
> index bded6b33289ce..dd9989cfe6b3f 100644
> --- a/drivers/net/ethernet/amd/pds_core/dev.c
> +++ b/drivers/net/ethernet/amd/pds_core/dev.c

[ ... ]

> -int pdsc_devcmd_locked(struct pdsc *pdsc, union pds_core_dev_cmd *cmd,
> -		       union pds_core_dev_comp *comp, int max_seconds)
> +static int __pdsc_devcmd_locked(struct pdsc *pdsc, union pds_core_dev_cmd *cmd,
> +				union pds_core_dev_comp *comp, int max_seconds,
> +				const bool do_msg)
>  {
>  	int err;
>  
> @@ -197,7 +199,7 @@ int pdsc_devcmd_locked(struct pdsc *pdsc, union pds_core_dev_cmd *cmd,
>  
>  	memcpy_toio(&pdsc->cmd_regs->cmd, cmd, sizeof(*cmd));
>  	pdsc_devcmd_dbell(pdsc);
> -	err = pdsc_devcmd_wait(pdsc, cmd->opcode, max_seconds);
> +	err = __pdsc_devcmd_wait(pdsc, cmd->opcode, max_seconds, do_msg);
>  
>  	if ((err == -ENXIO || err == -ETIMEDOUT) && pdsc->wq)
>  		queue_work(pdsc->wq, &pdsc->health_work);

[Severity: Critical]
This isn't a bug introduced by this patch, but it occurs in the function
modified here.

Can this queue_work() call trigger a use-after-free during driver removal?

Looking at pdsc_remove() in drivers/net/ethernet/amd/pds_core/main.c,
destroy_workqueue() is called but the pdsc->wq pointer is not cleared:

pdsc_remove() {
    ...
    if (pdsc->wq)
        destroy_workqueue(pdsc->wq);
    
    mutex_lock(&pdsc->config_lock);
    set_bit(PDSC_S_STOPPING_DRIVER, &pdsc->state);
    
    pdsc_stop(pdsc);
    pdsc_teardown(pdsc, PDSC_TEARDOWN_REMOVING);
    ...
}

Subsequently, pdsc_teardown() issues a RESET command to the firmware.
If the firmware is unresponsive and the command times out, we reach this
error path in __pdsc_devcmd_locked(). Since the pdsc->wq pointer was never
set to NULL, the check here succeeds, and it attempts to queue work to a
destroyed workqueue.

Should pdsc->wq be explicitly set to NULL immediately after being destroyed
in pdsc_remove() to prevent this?

>  	else
>  		memcpy_fromio(comp, &pdsc->cmd_regs->comp, sizeof(*comp));
>

