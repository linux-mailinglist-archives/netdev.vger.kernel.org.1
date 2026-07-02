Return-Path: <netdev+bounces-304091-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wqyWIa4+RmrGMgsAu9opvQ
	(envelope-from <netdev+bounces-304091-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 12:34:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D23A76F5F98
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 12:34:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=YaethcaP;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304091-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304091-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B3920317C471
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 10:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F18844252AC;
	Thu,  2 Jul 2026 10:10:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794F13C0A1B
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 10:10:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782987055; cv=none; b=una/u/TFqZ3B8/V/7EQ3wTtTSpTCxlkzyZyDtZrrhOTOdRgyHk5xttj1ybAYtJJxWaRdGgVudJZihCoYCVFXIqFwDD5DF+mfvyv6GIQbEidI9CGCq5rlXlrzevH3bFgH3Xs8+3OyEBzC3cWr5ILvfS2GNc2i0QMVM3Tqg0HFcCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782987055; c=relaxed/simple;
	bh=fBCPbCEt6IRbt++TcIaQzKwqQquUr/Ojx7GQcVJ78RY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FV5YyRCC450oaMS6eKT7SxZw8rH/+WrYUZnvaRH0DFen8r+SBIadDYXwawQUNdwEPoV5UNDqZaIZ8qS7OyFPQeDq4qY7xPFHBxheyjqvr1P+jMVWFwYSPodU+6LD1TzpvEq+civhhZA/Oekw1mRJe+Vts6JX82OOrF3u7qWzjsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YaethcaP; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782987053;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6XQvYBxzq9cA9EnRdG58KTop6kEZAUb/md9ghFS7/9s=;
	b=YaethcaPRZ8UBq0V2TjyVTd3VScuUWZ7/IZWsAb1tvkKZR1lcnIBYoVmZQL+8NFmzdSWoU
	4eDR8xu6eNE0PTGmJU22RRIm2mmtH2qgisUAc4DNjLIgGKZbpwQX7yd66U2OvWXEnsnAfd
	uDzchuVghrZiHE7oE2DR2UJizn0OOmM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-582-3pywi8uFM5ecYwVKJwpHbQ-1; Thu,
 02 Jul 2026 06:10:50 -0400
X-MC-Unique: 3pywi8uFM5ecYwVKJwpHbQ-1
X-Mimecast-MFC-AGG-ID: 3pywi8uFM5ecYwVKJwpHbQ_1782987049
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B368E1944D20;
	Thu,  2 Jul 2026 10:10:48 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.48.252])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8E53536F09;
	Thu,  2 Jul 2026 10:10:45 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: jk@codeconstruct.com.au
Cc: matt@codeconstruct.com.au,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	gregkh@linuxfoundation.org,
	netdev@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: Re: [PATCH net-next 04/12] net: mctp: usblib: Move TX transfer processing to mctp-usblib
Date: Thu,  2 Jul 2026 12:10:35 +0200
Message-ID: <20260702101041.139249-1-pabeni@redhat.com>
In-Reply-To: <20260630-dev-mctp-usb-1-1-v1-4-86a311fc67b7@codeconstruct.com.au>
References: <20260630-dev-mctp-usb-1-1-v1-4-86a311fc67b7@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-304091-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jk@codeconstruct.com.au,m:matt@codeconstruct.com.au,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:gregkh@linuxfoundation.org,m:netdev@vger.kernel.org,m:linux-usb@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:url,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D23A76F5F98

From: AI Reviewer <ai@example.com>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/
---
net: mctp: usblib: Move TX transfer processing to mctp-usblib

This change moves the TX path from mctp-usb into the mctp-usblib helper
by splitting it into push, send, and complete steps so future packed
transfers can carry multiple MCTP packets per USB transfer. The current
implementation keeps a 1:1 mapping between packets and transfers, with no
tx context persisting beyond a single send.

> diff --git a/drivers/net/mctp/mctp-usb.c b/drivers/net/mctp/mctp-usb.c
> index 531b7c994afb..385350792dd4 100644
> --- a/drivers/net/mctp/mctp-usb.c
> +++ b/drivers/net/mctp/mctp-usb.c
> @@ -29,90 +29,82 @@ struct mctp_usb {

[ ... ]

> @@ -220,7 +212,12 @@ static int mctp_usb_stop(struct net_device *dev)
>  	flush_delayed_work(&mctp_usb->rx_retry_work);
>  
>  	usb_kill_urb(mctp_usb->rx_urb);
> +
> +	spin_lock_irqsave(&mctp_usb->tx_lock, flags);
>  	usb_kill_urb(mctp_usb->tx_urb);
> +	spin_unlock_irqrestore(&mctp_usb->tx_lock, flags);

[Critical]
Can usb_kill_urb() safely be called from under spin_lock_irqsave()?

usb_kill_urb() starts with might_sleep() and then blocks on
wait_event(usb_kill_urb_queue, urb->use_count == 0):

drivers/usb/core/urb.c:usb_kill_urb() {
    might_sleep();
    ...
    wait_event(usb_kill_urb_queue, atomic_read(&urb->use_count) == 0);
    ...
}

With CONFIG_DEBUG_ATOMIC_SLEEP, would this trigger a
"sleeping function called from invalid context" splat because tx_lock
is held with IRQs disabled?

There also appears to be a nested-lock concern with the URB completion
handler taking the same tx_lock:

mctp_usb_out_complete() {
    ...
    spin_lock_irqsave(&mctp_usb->tx_lock, flags);
    mctp_usb->tx_urb = NULL;
    spin_unlock_irqrestore(&mctp_usb->tx_lock, flags);
    ...
}

The HCD giveback path needs to run the completion before urb->use_count
drops to zero. If the completion is waiting for tx_lock held by the
caller of usb_kill_urb(), and usb_kill_urb() is itself waiting for
use_count to drop, can this deadlock?

The next patch in the series ("net: mctp: usb: Allow for multiple urb
submissions from a packet tx", 5cf1f88ce49a) appears to remove this
lock-wrapped usb_kill_urb() in favour of usb_kill_anchored_urbs()
called outside the lock — should the fix be folded into this patch
instead?

> +
> +	mctp_usblib_tx_cancel(&mctp_usb->tx, dev);
>  
>  	return 0;
>  }

[ ... ]

> diff --git a/drivers/net/mctp/mctp-usblib.c b/drivers/net/mctp/mctp-usblib.c
> index 9b86eb4310ce..56eca496bbe4 100644
> --- a/drivers/net/mctp/mctp-usblib.c
> +++ b/drivers/net/mctp/mctp-usblib.c
> @@ -162,6 +162,186 @@ void mctp_usblib_rx_cancel(struct mctp_usblib_rx *rx)

[ ... ]

> +/*
> + * Completion for the ->send() op. This will update netdev stats and
> + * free the tx context.
> + *
> + * Likely called from (atomic) URB completion context.
> + */
> +void mctp_usblib_tx_send_complete(struct mctp_usblib_tx_ctx *tx_ctx,
> +				  struct net_device *dev, bool ok)
> +{
> +	mctp_usblib_tx_ctx_free(tx_ctx);
> +}
> +EXPORT_SYMBOL_GPL(mctp_usblib_tx_send_complete);

[High]
Does the body of mctp_usblib_tx_send_complete() match the comment
above it?

The comment says "This will update netdev stats and free the tx
context", and the function takes dev and ok parameters, but the body
only calls mctp_usblib_tx_ctx_free(tx_ctx) and never invokes
mctp_usblib_tx_stats_update().

Prior to this patch, mctp_usb_out_complete() updated counters for both
success and failure:

    case 0:
        dev_dstats_tx_add(netdev, skb->len);
        ...
    case -ENOENT:
    case -ECONNRESET:
    case -ESHUTDOWN:
    case -EPROTO:
        dev_dstats_tx_dropped(netdev);
        ...

After this patch, mctp_usb_out_complete() defers stats to
mctp_usblib_tx_send_complete(), which does not touch them. The only
caller of mctp_usblib_tx_stats_update() is the synchronous push()
failure path. Does this mean tx_packets, tx_bytes and the URB-failure
tx_drops counters are no longer incremented for any successful or
asynchronously-failed transmit?

Was the intent to call mctp_usblib_tx_stats_update(tx_ctx, dev, ok)
here before freeing the context?

> +
> +/* Prepare a skb for push() */
> +static int mctp_usblib_tx_skb_prepare(struct sk_buff *skb)

[ ... ]
-- 
This is an AI-generated review.


