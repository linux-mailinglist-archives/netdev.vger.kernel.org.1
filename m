Return-Path: <netdev+bounces-287772-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kCqJEWkoBWoYTAIAu9opvQ
	(envelope-from <netdev+bounces-287772-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 03:42:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id ADC0253CCB1
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 03:42:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9FFB13005E81
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 01:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94FB5281357;
	Thu, 14 May 2026 01:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pGlr4GsH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F8F274FD1
	for <netdev@vger.kernel.org>; Thu, 14 May 2026 01:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778722917; cv=none; b=nLtIP9qIeV0RLgbzYjOtgLOefWd3In2YbF2KjgdHnrCfAtn7IsscIPLYNlYdqff8HlNma7oQv7soHu1a1J+NvBt0Y4i14wmmGizpD9t4Ec2fqLA1ayFXJm1xom9eMT+YbExrH6+wsxj8aanB3sE6xyrbrm9Tuvaj50U+1XTPy48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778722917; c=relaxed/simple;
	bh=rUv1QNkG7OogrXi3TDmP/xJINDxPkwortusFfbIAf+M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WKGR3T4+L0NBAZllmH2kxI8PPgyTYq1+y0RtTd59maV7fRsnedNgtzzCJ0tcPAYksrinLJ/ZEc7Vz5cehB8fFu+tTiAKb77mDHT4zil5cobhwPWVHXLmJzNx3B72/C/jxRydHJuwfYlJVygymTHDyWbBXzIeSLiNVPJjnjlBohA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pGlr4GsH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52E52C19425;
	Thu, 14 May 2026 01:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778722917;
	bh=rUv1QNkG7OogrXi3TDmP/xJINDxPkwortusFfbIAf+M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pGlr4GsHz0Rq4Y2czTYCm9lAjFAvK9BMxbPCdaVys4PiBpAQ/ytaAbG/a3Df+Of/0
	 3W8d5Hnyg9H2tDwXg3OW82jpLuotksNCv6kCaCKfqL8aCYpkRFTFfQXArw3wbIU2Xu
	 e6AnTcmHAkud1YWYjOKrPurQ+Do1tCgWOxkR7mp/A9gMEWqJsqnemcYSWDMIlgPUhp
	 Gy5m9crjxb1x1XwALounuKx/Fxfzu/LNV4V17MeLjLNbh+9NFVCNui6aLsz+ESBxr2
	 kc/20wDtjk5yc587b0L34lK1Ekb0MwCp3FB/o1iS28tnD2MhUYCACBgK6yGKWHuNhB
	 oBDWBGmM7qxog==
Date: Wed, 13 May 2026 18:41:55 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Wei Wang <weibunny.kernel@gmail.com>
Cc: netdev@vger.kernel.org, Daniel Zahka <daniel.zahka@gmail.com>, Willem de
 Bruijn <willemdebruijn.kernel@gmail.com>, David Wei <dw@davidwei.uk>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Wei Wang
 <weibunny@fb.com>
Subject: Re: [PATCH v14 net-next 3/5] psp: add a new netdev event for dev
 unregister
Message-ID: <20260513184155.0b5f71f6@kernel.org>
In-Reply-To: <20260508042611.130945-4-weibunny.kernel@gmail.com>
References: <20260508042611.130945-1-weibunny.kernel@gmail.com>
	<20260508042611.130945-4-weibunny.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: ADC0253CCB1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,davidwei.uk,lunn.ch,davemloft.net,google.com,redhat.com,kernel.org,fb.com];
	TAGGED_FROM(0.00)[bounces-287772-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Thu,  7 May 2026 21:26:08 -0700 Wei Wang wrote:
> +static int psp_netdev_event(struct notifier_block *nb, unsigned long event,
> +			    void *ptr)
> +{
> +	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
> +	struct psp_dev *psd;
> +
> +	if (event != NETDEV_UNREGISTER)
> +		return NOTIFY_DONE;
> +
> +	rcu_read_lock();
> +	psd = rcu_dereference(dev->psp_dev);
> +	if (psd && psp_dev_tryget(psd)) {
> +		rcu_read_unlock();
> +		mutex_lock(&psd->lock);

Let's check here if psp_dev_is_registered(psd) before
calling the notify. The list should be empty on a dead device
so psp_dev_disassoc_one() is fine, but it will be easy to forget
and add some code that doesn't expect dead devices in notify.

> +		psp_nl_notify_dev(psd, PSP_CMD_DEV_CHANGE_NTF);
> +		psp_dev_disassoc_one(psd, dev);
> +		mutex_unlock(&psd->lock);
> +		psp_dev_put(psd);
> +	} else {
> +		rcu_read_unlock();
> +	}
> +
> +	return NOTIFY_DONE;
> +}
> +
> +static struct notifier_block psp_netdev_notifier = {
> +	.notifier_call = psp_netdev_event,
> +};
> +
> +static DEFINE_MUTEX(psp_notifier_lock);
> +static bool psp_notifier_registered;
> +
> +/*
> + * psp_attach_netdev_notifier() - register netdev notifier on first use
> + *
> + * Register the netdevice notifier when the first device association
> + * is created. In many installations no associations will be created and
> + * the notifier won't be needed.
> + *
> + * Must be called without psd->lock held, due to lock ordering:
> + * rtnl_lock -> psd->lock (the notifier callback runs under rtnl_lock
> + * and takes psd->lock).
> + */

This is so almost kdoc :) Either remove the top line with the function
name, or add Returns: and make it a real kdoc (slight preference towards
former)

> +int psp_attach_netdev_notifier(void)

