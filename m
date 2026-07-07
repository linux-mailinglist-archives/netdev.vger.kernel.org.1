Return-Path: <netdev+bounces-305769-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XlUTI9YvTmqcEwIAu9opvQ
	(envelope-from <netdev+bounces-305769-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 13:09:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 740DC724ABD
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 13:09:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=VYhC0NRF;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305769-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-305769-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A7D6A300138C
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 11:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C001142B736;
	Wed,  8 Jul 2026 11:09:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE57E420E85
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 11:09:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783508944; cv=none; b=JuED9qGYLr+05cXsFlTHvDcnYcXrux2QSIYq7w1kLsVpLVuzMCNunYoUBVldmqR75GAp8ltauVNz8K8y0T8F4AAYQjdxsYtf1WIU3fcFmf5bIPcMmNgtzfcHTpwgME4La2XjhcZ1z2WyTPD4Me+w3nnisJE5EPdWom4KLmZA3rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783508944; c=relaxed/simple;
	bh=Ch4qZpXD8kAZhrpg54ek7qWALqUDSIIDtce5DKYs4yk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j+cm6pKyCxCHR0uJQ0TOT3hCa3agudUbW9Zu+cO6G3xXiKtxBJ8/AWD+ikYIZqad2O7PJd8emLJhqopXGVZcsObT8wB32mSjf6+VXBqDHWYeiRcYeKezwUTYsQgB+PSbfntRn+Oya70OJnzyWQAAHWYfQiYIcH+P6fzpyJ2dfDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VYhC0NRF; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A41F51F000E9;
	Wed,  8 Jul 2026 11:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783508938;
	bh=gs9vAao4aEUztfSrj1GntTCmCsvmgmNhJErp1+vaAV8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VYhC0NRFX/R5yPpYWMLdvV+A2mpX75pUuN5SAOAky/nkA/xKZ0fk338ufUa4eYZum
	 irV2XBLT8JN0W7gJ5GGcVJjjtbibzMx6XSs1SQnuKswvqLRCjZSzeIyYC4+anLNgBf
	 C25tD/m/gvjZyXwTv5JmFu15uGcVpSeMq86PIUsuNPn1NEYo9jX+j7RO2/gTvR5/hV
	 aoVR7LV6iHoMjKNR6lFvDO+O2kER8cru5WkzGM02FrqO+CSo4UWVOlur9vkbc/3B3P
	 42iJygU0jmylzDQFTVrbeT5jVH9lZtz+w8oTBX8B2ggHm957ggebSbGf7Qw006X9Ao
	 UliByQC6fDEMA==
From: Simon Horman <horms@kernel.org>
To: dddddd@hust.edu.cn
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	david@ixit.cz,
	error27@gmail.com,
	krzk@kernel.org,
	kees@kernel.org,
	kuba@kernel.org,
	sameo@linux.intel.com,
	michael.thalmeier@hale.at,
	dzm91@hust.edu.cn,
	hust-os-kernel-patches@googlegroups.com
Subject: Re: [PATCH net] nfc: pn533: fix use-after-free in pn533_recv_frame
Date: Tue,  7 Jul 2026 19:06:52 +0100
Message-ID: <20260707180649.1434511-4-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260627131345.1548407-1-dddddd@hust.edu.cn>
References: <20260627131345.1548407-1-dddddd@hust.edu.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-305769-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:dddddd@hust.edu.cn,m:horms@kernel.org,m:netdev@vger.kernel.org,m:david@ixit.cz,m:error27@gmail.com,m:krzk@kernel.org,m:kees@kernel.org,m:kuba@kernel.org,m:sameo@linux.intel.com,m:michael.thalmeier@hale.at,m:dzm91@hust.edu.cn,m:hust-os-kernel-patches@googlegroups.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,ixit.cz,gmail.com,linux.intel.com,hale.at,hust.edu.cn,googlegroups.com];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,sashiko.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 740DC724ABD

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
nfc: pn533: fix use-after-free in pn533_recv_frame

This commit adds a spinlock cmd_state_lock to serialize access to dev->cmd 
in pn533_recv_frame() and the command completion worker. It aims to prevent 
a use-after-free when a command is detached and freed while being 
concurrently received.

> diff --git a/drivers/nfc/pn533/pn533.c b/drivers/nfc/pn533/pn533.c
> index d7bdbc82e2ba2..921e93a5f16f5 100644
> --- a/drivers/nfc/pn533/pn533.c
> +++ b/drivers/nfc/pn533/pn533.c

[ ... ]

> @@ -458,10 +477,10 @@ static int __pn533_send_async(struct pn533 *dev, u8 cmd_code,
>  	mutex_lock(&dev->cmd_lock);
>  
>  	if (!dev->cmd_pending) {
> -		dev->cmd = cmd;
> +		pn533_set_current_cmd(dev, cmd);
>  		rc = dev->phy_ops->send_frame(dev, req);
>  		if (rc) {
> -			dev->cmd = NULL;
> +			pn533_set_current_cmd(dev, NULL);

[Severity: High]
This is a pre-existing issue, but if dev->phy_ops->send_frame() fails, it
jumps to the error label and frees cmd. If a concurrent receive scheduled 
the complete work, could that work also free cmd, causing a double free?

>  			goto error;
>  		}

[ ... ]

> @@ -569,10 +588,10 @@ static void pn533_wq_cmd(struct work_struct *work)
>  
>  	mutex_unlock(&dev->cmd_lock);
>  
> -	dev->cmd = cmd;
> +	pn533_set_current_cmd(dev, cmd);
>  	rc = dev->phy_ops->send_frame(dev, cmd->req);
>  	if (rc < 0) {
> -		dev->cmd = NULL;
> +		pn533_set_current_cmd(dev, NULL);

[Severity: High]
This isn't a bug introduced by this patch, but if dev->phy_ops->send_frame() 
fails in pn533_wq_cmd(), cmd is freed. Does a race condition exist here 
similar to __pn533_send_async(), where concurrent complete work could also 
free cmd?

[Severity: High]
Additionally, this is also a pre-existing issue, but does this error path 
drop the command without calling complete_cb and without clearing 
dev->cmd_pending? Could this leave the command queue permanently hung 
upon transient bus errors?

>  		dev_kfree_skb(cmd->req);
>  		kfree(cmd);
>  		return;
>  	}

[ ... ]

> @@ -2165,6 +2184,15 @@ static int pn533_data_exchange_complete(struct pn533 *dev, void *_arg,
>   */
>  void pn533_recv_frame(struct pn533 *dev, struct sk_buff *skb, int status)
>  {
> +	unsigned long flags;
> +
> +	/*
> +	 * Hold cmd_state_lock across the whole receive path so the current
> +	 * command cannot be freed by pn533_send_async_complete() between the
> +	 * dev->cmd check and the stores into it.
> +	 */
> +	spin_lock_irqsave(&dev->cmd_state_lock, flags);
> +
>  	if (!dev->cmd)
>  		goto sched_wq;

[Severity: Medium]
This isn't a bug introduced by this patch, but if there is no active command 
(!dev->cmd), this jumps to sched_wq without freeing the skb. Does this leak 
the skb if an unexpected frame arrives?

>  
>  	dev->cmd->status = status;

[ ... ]

> @@ -2182,6 +2210,7 @@ void pn533_recv_frame(struct pn533 *dev, struct sk_buff *skb, int status)
>  
>  	if (pn533_rx_frame_is_ack(skb->data)) {
>  		dev_dbg(dev->dev, "%s: Received ACK frame\n", __func__);
> +		spin_unlock_irqrestore(&dev->cmd_state_lock, flags);
>  		dev_kfree_skb(skb);
>  		return;
>  	}

[Severity: High]
This is a pre-existing issue, but does pn533_rx_frame_is_ack() safely read 
from skb->data here? Since there doesn't appear to be a check for skb->len 
before calling it, could this result in an out-of-bounds read if a malformed 
or short frame is received?

