Return-Path: <netdev+bounces-298569-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GbXQJbbYK2oZGQQAu9opvQ
	(envelope-from <netdev+bounces-298569-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 12:00:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 331E4678865
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 12:00:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="P/i2GS1i";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298569-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298569-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A286830071D4
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 10:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A9183806D8;
	Fri, 12 Jun 2026 10:00:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464A635B653
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 10:00:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781258420; cv=none; b=ZzQ4sInzjwbvFK82hQb9/IJZbUweqOJReEUzk4z/FG6qRjF8pKHeI2akkLCOc7nZ3xzJ/JH7dEtc4/HzofelzgfV1whEIq07wOr5rjHvT3JqBLzvIwSzkGrpHaOn+hE/t11uea8Arfq9+jOGTJImzeYHBDeFt708UFDMcLRwKk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781258420; c=relaxed/simple;
	bh=EO7Y+uBvKEMyetf5lCrZsS7Fq+fRpr1UF+ErthLdbKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WLAyy4iTiVN4Ap3+J8QgID3TW4jz49bKnN9/JqNStg6+70g1sbjrqyAlEvu+ntijfsoZrAOgMeLg5zehkWRIE6OPvy/popB46AEL3NwXCCSdWgo8fo+ChNhbhfsqrcleiu82fRmHDGBo0FN3bV/YRB/OI4QRl3qVbLTKLTp4Ans=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P/i2GS1i; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83CAD1F000E9;
	Fri, 12 Jun 2026 10:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781258418;
	bh=vRrg3KPRA4GzTnNy1FMzkDqJH1Weaqbx4NhX70ndGcs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=P/i2GS1iwimkFOnRWUVEwF/SEk6lazc+UxbspPcxRGOf3pZCcDCRS6shJSVni8+Is
	 L2S9mQ2Du+mSSm01P282aKM3ZWNFlmDYAwoNBz6rlwhyim92kWPpvt8AZK5UYbfoQ1
	 oJFbebygqtIgcz8H7KN0h/qhp6kjzdZUh0RvkdK3aSdrMl1Wn5rZz9jbOjOKd9djfl
	 +Xkx7kie7uL4AL9PnDYvAnsCqIvQLCQhH8YOZ+bFZxfRJ/wjW5um404gSyqdCiCR0A
	 FsNXayQrL+BXV+I1PHqpPOxnS5SufdSpIpd1EfST+cu+yPWri8VZVsx+LYlEK+ZC5r
	 F5YJu0v6X65Nw==
From: Simon Horman <horms@kernel.org>
To: anthony.l.nguyen@intel.com
Cc: Simon Horman <horms@kernel.org>,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org,
	ade@amicon.ru,
	dima.ruinskiy@intel.com,
	jacob.e.keller@intel.com,
	dish@amicon.ru,
	avigailx.dahan@intel.com
Subject: Re: [PATCH net-next 06/15] igb: Retrieve Tx timestamp from BH workqueue
Date: Fri, 12 Jun 2026 10:57:44 +0100
Message-ID: <20260612095742.662653-3-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260609213559.178657-7-anthony.l.nguyen@intel.com>
References: <20260609213559.178657-7-anthony.l.nguyen@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-298569-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:anthony.l.nguyen@intel.com,m:horms@kernel.org,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:andrew+netdev@lunn.ch,m:netdev@vger.kernel.org,m:ade@amicon.ru,m:dima.ruinskiy@intel.com,m:jacob.e.keller@intel.com,m:dish@amicon.ru,m:avigailx.dahan@intel.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sashiko.dev:url,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 331E4678865

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
igb: Retrieve Tx timestamp from BH workqueue

Retrieve Tx timestamp from system BH instead of regular system workqueue.

The current implementation uses schedule_work() which is executed by the
system work queue and kworkers to retrieve Tx timestamps. This increases
latency and can lead to timeouts in case of heavy system load. i210 is
often used in industrial systems, where timestamp timeouts can be fatal.

Simon says:

I think that first issue below, flagged as pre-existing, can be considered
in the context of possible follow-up.

However, the issues flagged below that, regarding scheduling work
and possible softirq storms, do seem to be something that warrants
investigation in the context of this patch-set.

> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
> index 49d46670695f3..17eff90af9e3d 100644
> --- a/drivers/net/ethernet/intel/igb/igb_main.c
> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> @@ -6571,7 +6571,7 @@ netdev_tx_t igb_xmit_frame_ring(struct sk_buff *skb,

[Severity: High]
This is a pre-existing issue, but does this function modify the shared SKB
data area without verifying exclusive ownership?

In igb_xmit_frame_ring(), just before the work is queued:

	if (adapter->tstamp_config.tx_type == HWTSTAMP_TX_ON &&
	    !test_and_set_bit_lock(__IGB_PTP_TX_IN_PROGRESS,
				   &adapter->state)) {
		skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;

If the SKB is cloned (e.g. via tc mirred or packet sniffers), won't modifying
the shared shinfo region create a data race with other network paths?

[Severity: High]
This is a pre-existing issue, but can the error path sleep in atomic context?

igb_xmit_frame_ring() runs in atomic context as the ndo_start_xmit callback,
but the cleanup path calls a blocking function:

cleanup_tx_tstamp:
	if (unlikely(tx_flags & IGB_TX_FLAGS_TSTAMP)) {
		...
		if (adapter->hw.mac.type == e1000_82576)
			cancel_work_sync(&adapter->ptp_tx_work);

Could this trigger scheduling while atomic warnings or potential deadlocks?

>  			adapter->ptp_tx_skb = skb_get(skb);
>  			adapter->ptp_tx_start = jiffies;
>  			if (adapter->hw.mac.type == e1000_82576)
> -				schedule_work(&adapter->ptp_tx_work);
> +				queue_work(system_bh_wq, &adapter->ptp_tx_work);

[Severity: High]
Does this change introduce a softirq polling storm for e1000_82576 MACs?

For this specific MAC type, the work is scheduled immediately upon packet
transmission. When queueing to system_bh_wq instead of a regular workqueue,
the polling loop in igb_ptp_tx_work() will now run in softirq context.

>  		} else {
>  			adapter->tx_hwtstamp_skipped++;
>  		}

[ ... ]

> diff --git a/drivers/net/ethernet/intel/igb/igb_ptp.c b/drivers/net/ethernet/intel/igb/igb_ptp.c
> index bd85d02ecadd8..7b44f9090631a 100644
> --- a/drivers/net/ethernet/intel/igb/igb_ptp.c
> +++ b/drivers/net/ethernet/intel/igb/igb_ptp.c
> @@ -832,7 +832,7 @@ static void igb_ptp_tx_work(struct work_struct *work)
>  		igb_ptp_tx_hwtstamp(adapter);
>  	else
>  		/* reschedule to check later */
> -		schedule_work(&adapter->ptp_tx_work);
> +		queue_work(system_bh_wq, &adapter->ptp_tx_work);

[Severity: High]
If the hardware timestamp is not yet valid, won't this work item
unconditionally reschedule itself to system_bh_wq without delay? 

Because the work requeues itself immediately, this could create a tight
polling loop in softirq context, maximizing the CPU's softirq time limit
and degrading network processing and overall system latency.

[Severity: High]
This is a pre-existing issue, but is there a use-after-free race condition
between igb_ptp_tx_work() and the watchdog task igb_ptp_tx_hang()?

Both functions independently check if the timeout has elapsed using
adapter->ptp_tx_start. If igb_ptp_tx_work() detects a timeout, it frees the
SKB and clears the state bit, allowing a new PTP packet to be queued:

	if (time_is_before_jiffies(adapter->ptp_tx_start +
				   IGB_PTP_TX_TIMEOUT)) {
		dev_kfree_skb_any(adapter->ptp_tx_skb);
		...
		clear_bit_unlock(__IGB_PTP_TX_IN_PROGRESS, &adapter->state);

If igb_ptp_tx_hang() concurrently evaluates the timeout as true based on the
old ptp_tx_start but is preempted, could it resume and mistakenly cancel
the work for the newly queued packet?

igb_ptp_tx_hang() {
	bool timeout = time_is_before_jiffies(adapter->ptp_tx_start +
					      IGB_PTP_TX_TIMEOUT);
	...
	if (timeout) {
		cancel_work_sync(&adapter->ptp_tx_work);
		dev_kfree_skb_any(adapter->ptp_tx_skb);

Would this cause a use-after-free by freeing the new SKB and corrupting the
driver's PTP state?

>  }

