Return-Path: <netdev+bounces-295597-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EM2JMmM3ImrATwEAu9opvQ
	(envelope-from <netdev+bounces-295597-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 04:41:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F060644B91
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 04:41:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=bS6+64Rt;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295597-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295597-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B50033061DC2
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 02:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FF713ED5A7;
	Fri,  5 Jun 2026 02:38:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8ADA3E6DD0;
	Fri,  5 Jun 2026 02:38:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780627133; cv=none; b=Bp5UX8MJvXqC8g6wp6u9cflp9f7sFkXMG6TdBx/rggK4PiTrcfsy3xAqJW9elK6bl86D0BcJD4n0JCM6cX0CeXwIERzYKrMgDCxahe52g7bkeXhfJKzQe5T6jAZxYIC3WsBaNjSXjIR+Ay87J6IXdiKhOxkI5+SiaU+FuCXIUIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780627133; c=relaxed/simple;
	bh=rTktFG9E4JYEFV6ivWdDsbfvKiXe4oRm5BMUo6cmBOk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U8uVEUDfAT6RNnYF4qoVf0Xm5brM6iy9pde3PHxc/S+NFYU2DChFwu/oZHAK2YbMIInRbN2ixfRCWSVwKyp43BYLINGMcrdmy4HosKKdY4wxKn1wj5wfkJtLIJ3Ph5vrYsOMIwC0DUXY7S9vqiUq0EB8nfa3HVNy6VuMkJmNCOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bS6+64Rt; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF7F61F00898;
	Fri,  5 Jun 2026 02:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780627121;
	bh=ORcGEpk+1LHGMwqTCxsfopu7BY34W6Odp2QB8kbgOFI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bS6+64Rt3voWnf3oMNMXAyBKfv3pACefd0fbr31vZoKa25FLwKqsum+QZDQDPVE3M
	 MltPOAyUY9Ix6gExiY2dLQXmb5rJTVwk8WX0wDQ9VsS82kgN4qY7Ogq+cDt+c3LRm+
	 AFmOMnuaYO9lD1xguFlRraBFiz8c5RQ1X9FvwNlNywFs68VDHElrslp7ua2T1gK/NE
	 S5jrvESG7qGT/43fgXPgIXwTlLWhMdErqIDHFhcyvPiPVD+kPjErbVu0G16Nb0kDQj
	 Ndul8DKOhmhbm+hb30f6vkhIODiFVLkSiDnLFfqDqVQxiQnzNTfWAk2l3sALfVxlJc
	 o4xtz2ygh345Q==
From: Jakub Kicinski <kuba@kernel.org>
To: sukhdeeps@marvell.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	horms@kernel.org,
	vadim.fedorenko@linux.dev
Subject: Re: [PATCH net-next v4 11/12] net: atlantic: add AQC113 TX timestamp polling and PTP TX classification
Date: Thu,  4 Jun 2026 19:38:39 -0700
Message-ID: <20260605023839.3629209-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260602135452.516-12-sukhdeeps@marvell.com>
References: <20260602135452.516-12-sukhdeeps@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-295597-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:sukhdeeps@marvell.com,m:kuba@kernel.org,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,m:horms@kernel.org,m:vadim.fedorenko@linux.dev,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3F060644B91

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: atlantic: add AQC113 TX timestamp polling and PTP TX classification

This patch wires PTP TX timestamp polling into aq_ring_tx_clean(), adds
IPv6 PTP packet classification in aq_ndev_start_xmit(), and moves the
RX-flow and VLAN filter reapply calls from aq_ndev_open() into
aq_nic_start().

> diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_main.c b/drivers/net/ethernet/aquantia/atlantic/aq_main.c
> index 4ef4fe64b8ac..1da14786fe5c 100644
> --- a/drivers/net/ethernet/aquantia/atlantic/aq_main.c
> +++ b/drivers/net/ethernet/aquantia/atlantic/aq_main.c
> @@ -68,14 +70,6 @@ int aq_ndev_open(struct net_device *ndev)
>  	if (err < 0)
>  		goto err_exit;
>  
> -	err = aq_reapply_rxnfc_all_rules(aq_nic);
> -	if (err < 0)
> -		goto err_exit;
> -
> -	err = aq_filters_vlans_update(aq_nic);
> -	if (err < 0)
> -		goto err_exit;
> -
>  	err = aq_nic_start(aq_nic);

[Low]
The commit message bullet says:

    Remove stale aq_ndev_open() PTP call that was moved to aq_nic_start().

The lines actually removed from aq_ndev_open() are
aq_reapply_rxnfc_all_rules() and aq_filters_vlans_update(), which are
RX-flow-classifier and VLAN-filter helpers rather than PTP calls.  Should
this bullet be reworded to describe the filter helpers that were actually
moved?

Also, aq_nic_start() is invoked from atl_resume_common() in aq_pci_func.c
in addition to aq_ndev_open().  Moving these helpers into aq_nic_start()
means RX-flow and VLAN filters will now be reapplied on every PM resume,
which is a behavioral change beyond plain deduplication.  Should the
changelog call this resume-path side effect out explicitly?

[ ... ]

> diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_ring.c b/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
> index e270327e47fd..dd1af3deb2d1 100644
> --- a/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
> +++ b/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
> @@ -311,6 +311,27 @@ bool aq_ring_tx_clean(struct aq_ring_s *self)
>  		if (likely(!buff->is_eop))
>  			goto out;
>  
> +		if (unlikely(buff->request_ts) &&
> +		    self->aq_nic->aq_hw_ops->hw_ring_tx_ptp_get_ts) {
> +			u64 ts = self->aq_nic->aq_hw_ops->hw_ring_tx_ptp_get_ts(self);
> +
> +			if (!ts) {
> +				if (time_after(jiffies,
> +					       self->ptp_ts_deadline)) {
> +					/* Timeout: free skb, unblock ring */
> +					buff->request_ts = 0;
> +					dev_kfree_skb_any(buff->skb);
> +					buff->skb = NULL;
> +					goto out;

[Medium]
Can the timeout branch desynchronize aq_ptp->skb_ring from buff_ring?

aq_ptp_xmit() pushes every PTP TX skb into aq_ptp->skb_ring via
aq_ptp_skb_put() (which holds its own reference via skb_get()), and
aq_ptp_tx_hwtstamp() consumes them in strict FIFO order:

aq_ptp.c:aq_ptp_tx_hwtstamp() {
    struct sk_buff *skb = aq_ptp_skb_get(&aq_ptp->skb_ring);
    ...
    skb_tstamp_tx(skb, &hwtstamp);
    dev_kfree_skb_any(skb);
}

The new timeout branch frees buff->skb and advances sw_head, but does not
dequeue the matching entry from aq_ptp->skb_ring.  After a timeout, the
stale skb pointer remains at the head of skb_ring while the buff_ring
moves on.

When the next PTP TX timestamp arrives, would aq_ptp_tx_hwtstamp() pop
that stale skb and call skb_tstamp_tx() with the timestamp belonging to
a later, unrelated packet?  Every subsequent PTP packet would then have
its TX timestamp misattributed by one slot until aq_ptp_tx_timeout_check()
calls aq_ptp_skb_ring_clean() to fully drain skb_ring (~10s later).

Should the timeout branch also dequeue and drop the head of skb_ring,
e.g. via aq_ptp_skb_get() followed by dev_kfree_skb_any() of the returned
skb, to keep skb_ring and buff_ring in lockstep?

> +				} else {
> +					buff->is_mapped = 0;
> +					buff->pa = 0U;
> +					break;
> +				}
> +			}
> +
> +			aq_ptp_tx_hwtstamp(self->aq_nic, ts);
> +		}
>  		if (buff->skb) {
>  			u64_stats_update_begin(&self->stats.tx.syncp);
>  			++self->stats.tx.packets;

[ ... ]

