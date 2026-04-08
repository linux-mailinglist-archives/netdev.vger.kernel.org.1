Return-Path: <netdev+bounces-276264-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ogVNOizO1Wm/+AcAu9opvQ
	(envelope-from <netdev+bounces-276264-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 05:40:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 72AB83B69B2
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 05:40:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AC094301A73A
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 03:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74F6234D90C;
	Wed,  8 Apr 2026 03:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oJOKc8hZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EDF62A1BF;
	Wed,  8 Apr 2026 03:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775619619; cv=none; b=fA6z673In1T1Sy/mkjgkmg5gw5pbeNgyPbZ1S62EFaRQ2g5sO47mwPyk6S3EnL4raZhnOlBoA8aDA0vH0dC6gnIIl4YmgfjqqbuWRrQxdwy1XLaVLfehdb43mCTKob2q0Ged+apjbkVJ4olvndYBF/J0E0N8QaDiyyUg+5xbAIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775619619; c=relaxed/simple;
	bh=Kont0VVzsAahMjG/zU+q+EG5+sNXbz70Gz8qhvfkxRw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OmCQoO0k/KrjdZKpLci+BCH3JSSW98ZY+8smkegzHN41wbRNyP3EuqKEmoQlCXwY1FG2XkGBqWSVI81prUQ2kWRTAUyljta+O66I590ToGd89CSX1iYhyfz/EUotP3fRvLC8WHf2TlykhyjKfbhuULZdBwzdyxVsiZl4BdBY++M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oJOKc8hZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 378C0C19424;
	Wed,  8 Apr 2026 03:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775619618;
	bh=Kont0VVzsAahMjG/zU+q+EG5+sNXbz70Gz8qhvfkxRw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oJOKc8hZKtrQkKfA2ne1vo+IxyUKm/HeqOnoRg301KxwkNVrVAF5h7L3jr3ymPaCe
	 5iCAR56MbDFfuOR9isRl8UJqmqvtitSvF0L+hf2RPCq/PShZZSddlRLktdTXA6Yt3T
	 bKqdBNnQS2/GS2HXBfvq/GgB7CYRjzTnZzgW9p5uhuci8fvpAIrIdtQhAO/MhZf/Eu
	 n+h67T3K+gOLLv2cEQceF+56bMkOpXzOiryF4XqoRF4ffeIzev88QtMhhGJ/nXPXfU
	 4+HKO9K9nVY5UtWtoDqMIhHUFkAgUoMKGJVc3RERcDty+83CspMQO0Q1YlrJVjEwX8
	 nvf8gn92ZzXVQ==
Date: Tue, 7 Apr 2026 20:40:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
 razor@blackwall.org, pabeni@redhat.com, willemb@google.com,
 sdf@fomichev.me, john.fastabend@gmail.com, martin.lau@kernel.org,
 jordan@jrife.io, maciej.fijalkowski@intel.com, magnus.karlsson@intel.com,
 dw@davidwei.uk, toke@redhat.com, yangzhenze@bytedance.com,
 wangdongdong.6@bytedance.com
Subject: Re: [PATCH net-next v11 03/14] net: Add lease info to queue-get
 response
Message-ID: <20260407204017.3fc79d1b@kernel.org>
In-Reply-To: <20260402231031.447597-4-daniel@iogearbox.net>
References: <20260402231031.447597-1-daniel@iogearbox.net>
	<20260402231031.447597-4-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-276264-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,blackwall.org,redhat.com,google.com,fomichev.me,gmail.com,kernel.org,jrife.io,intel.com,davidwei.uk,bytedance.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 72AB83B69B2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri,  3 Apr 2026 01:10:20 +0200 Daniel Borkmann wrote:
> +struct netdev_rx_queue *
> +__netif_get_rx_queue_lease(struct net_device **dev, unsigned int *rxq_idx,
> +			   enum netif_lease_dir dir)
> +{
> +	struct net_device *orig_dev = *dev;
> +	struct netdev_rx_queue *rxq = __netif_get_rx_queue(orig_dev, *rxq_idx);
> +
> +	if (rxq->lease) {
> +		if (!netif_lease_dir_ok(orig_dev, dir))
> +			return NULL;
> +		rxq = rxq->lease;
> +		*rxq_idx = get_netdev_rx_queue_index(rxq);
> +		*dev = rxq->dev;
> +	}
> +	return rxq;
> +}
> +
> +struct netdev_rx_queue *
> +netif_get_rx_queue_lease_locked(struct net_device **dev, unsigned int *rxq_idx)
> +{
> +	struct net_device *orig_dev = *dev;
> +	struct netdev_rx_queue *rxq;
> +
> +	/* Locking order is always from the virtual to the physical device
> +	 * see netdev_nl_queue_create_doit().
> +	 */
> +	netdev_ops_assert_locked(orig_dev);
> +	rxq = __netif_get_rx_queue_lease(dev, rxq_idx, NETIF_VIRT_TO_PHYS);
> +	if (rxq && orig_dev != *dev)
> +		netdev_lock(*dev);
> +	return rxq;
> +}
> +
> +void netif_put_rx_queue_lease_locked(struct net_device *orig_dev,
> +				     struct net_device *dev)
> +{
> +	if (orig_dev != dev)
> +		netdev_unlock(dev);
> +}

Pretty sure I already complained about these ugly helpers.
I'll try to find the time tomorrow to come up with something better.

