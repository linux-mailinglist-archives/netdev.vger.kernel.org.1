Return-Path: <netdev+bounces-264116-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +GofACvaqGnGxwAAu9opvQ
	(envelope-from <netdev+bounces-264116-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 02:19:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 01C5C209C0B
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 02:19:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 05A01301493D
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 01:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA50A1E0E14;
	Thu,  5 Mar 2026 01:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rlzUDTpa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59FD70818;
	Thu,  5 Mar 2026 01:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772673571; cv=none; b=NTh4lep/IIUzRRJ3DhYFNmmd0+IiOEKr3WlZtAobP4ENETZU1wZLMikPUTx9ciUrhYfmN+2H9AJSGhe5et69REev/Uo6Obg/zQ3h1POBqv5eeH2P8QNxjw6LOhIWiIOEcYcgi+iESBtdFIebLvb8f7sQB6ff1amOtM83e3CKeqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772673571; c=relaxed/simple;
	bh=SJgJUSlbM0rWTCeOP9mtbVawQoV2iB6zzm2a1EHew0w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PRPADWGQTyJn5iw6Np9lZE+sw9bJpzzxlRncEqXhRAb3xs/VcM0EHcb/RUsSqf0AJ8Melo9ZB6ulijR/spb4gondvhfqR87bg+tJCq9VqwSUjiL6uU+/ww4ZWrN6sea8+X+NLBM7PNTNOuyzdVnq17T84hdrKE1JFMqmbsZUkaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rlzUDTpa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEE5EC4CEF7;
	Thu,  5 Mar 2026 01:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772673571;
	bh=SJgJUSlbM0rWTCeOP9mtbVawQoV2iB6zzm2a1EHew0w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rlzUDTpatw1KlZJ0lBnyead6hhyKQ3ueBTOvQa5yikmwOk4YkW9KkMESw4RQrifZe
	 AR5u5cbhDwW6y5r2slDOOaJPsSNumsc5JDNEdOELvy5oyIPnI3mFttxZ34RaP14xio
	 GTGslIGJqvLQKbEqZqJE/13nN8sizTeK+ytSJpk72xKNAgWRK1lEna7wdepRUB/UJ9
	 KvkLRbuMnXI/gDS1kD75FDlXVmc3I9FFWkcfy8VlySfCdGRxrLF4ywHgp5KhjWG5DZ
	 Tx12rFH473xqVu1qA0/YGoSIuDtNpQjIAhWQz7N4uyghyYtE5q0IR99SH7Be3wFUHI
	 ffHMREQXY26SA==
Date: Wed, 4 Mar 2026 17:19:30 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Koichiro Den <den@valinux.co.jp>
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen
 Hubbe <allenbh@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, ntb@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] net: ntb_netdev: Support ethtool channels for
 multi-queue
Message-ID: <20260304171930.5c3625eb@kernel.org>
In-Reply-To: <20260228145538.3955864-5-den@valinux.co.jp>
References: <20260228145538.3955864-1-den@valinux.co.jp>
	<20260228145538.3955864-5-den@valinux.co.jp>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 01C5C209C0B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kudzu.us,intel.com,gmail.com,lunn.ch,davemloft.net,google.com,redhat.com,lists.linux.dev,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-264116-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Sat, 28 Feb 2026 23:55:38 +0900 Koichiro Den wrote:
> +static const struct ntb_queue_handlers ntb_netdev_handlers;

can we move some code around to avoid this forward declaration?

> +static int ntb_set_channels(struct net_device *ndev,
> +			    struct ethtool_channels *channels)
> +{
> +	struct ntb_netdev *dev = netdev_priv(ndev);
> +	unsigned int new = channels->combined_count;
> +	unsigned int old = dev->num_queues;
> +	bool running = netif_running(ndev);
> +	struct ntb_netdev_queue *queue;
> +	unsigned int q, created;
> +	int rc = 0;
> +
> +	if (channels->rx_count || channels->tx_count || channels->other_count)
> +		return -EINVAL;

Pretty sure core will protect from this since your get will return 0
for corresponding max values

> +	if (!new || new > ndev->num_tx_queues)
> +		return -ERANGE;

same, core should protect against this

> +	if (new == old)
> +		return 0;
> +
> +	if (new < old) {
> +		if (running)
> +			for (q = new; q < old; q++)
> +				netif_stop_subqueue(ndev, q);
> +
> +		rc = netif_set_real_num_queues(ndev, new, new);
> +		if (rc)
> +			goto out_restore;
> +
> +		/* Publish new queue count before invalidating QP pointers */
> +		dev->num_queues = new;
> +
> +		for (q = new; q < old; q++) {
> +			queue = &dev->queues[q];
> +
> +			if (running) {
> +				ntb_transport_link_down(queue->qp);
> +				ntb_netdev_queue_rx_drain(queue);
> +				timer_delete_sync(&queue->tx_timer);
> +			}
> +
> +			ntb_transport_free_queue(queue->qp);
> +			queue->qp = NULL;
> +		}
> +
> +		goto out_restore;
> +	}
> +
> +	created = old;
> +	for (q = old; q < new; q++) {
> +		queue = &dev->queues[q];
> +
> +		queue->ntdev = dev;
> +		queue->qid = q;
> +		queue->qp = ntb_transport_create_queue(queue, dev->client_dev,
> +						       &ntb_netdev_handlers);
> +		if (!queue->qp) {
> +			rc = -ENOSPC;
> +			goto err_new;
> +		}
> +		created++;
> +
> +		if (!running)
> +			continue;
> +
> +		timer_setup(&queue->tx_timer, ntb_netdev_tx_timer, 0);
> +
> +		rc = ntb_netdev_queue_rx_fill(ndev, queue);
> +		if (rc)
> +			goto err_new;
> +
> +		/*
> +		 * Carrier may already be on due to other QPs. Keep the new
> +		 * subqueue stopped until we get a Link Up event for this QP.
> +		 */
> +		netif_stop_subqueue(ndev, q);
> +	}
> +
> +	rc = netif_set_real_num_queues(ndev, new, new);
> +	if (rc)
> +		goto err_new;
> +
> +	dev->num_queues = new;
> +
> +	if (running)
> +		for (q = old; q < new; q++)
> +			ntb_transport_link_up(dev->queues[q].qp);
> +
> +	return 0;
> +
> +err_new:
> +	if (running) {
> +		unsigned int rollback = created;
> +
> +		while (rollback-- > old) {
> +			queue = &dev->queues[rollback];
> +			ntb_transport_link_down(queue->qp);
> +			ntb_netdev_queue_rx_drain(queue);
> +			timer_delete_sync(&queue->tx_timer);
> +		}
> +	}
> +
> +	while (created-- > old) {
> +		queue = &dev->queues[created];
> +		ntb_transport_free_queue(queue->qp);
> +		queue->qp = NULL;
> +	}
> +
> +out_restore:
> +	if (running) {
> +		ntb_netdev_sync_subqueues(dev);
> +		ntb_netdev_update_carrier(dev);
> +	}
> +	return rc;
> +}

The logic LGTM, but the function is a little long.
Would it be possible to split it up?

