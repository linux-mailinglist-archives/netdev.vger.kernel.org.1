Return-Path: <netdev+bounces-294424-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Eg7wJtdMH2pXjwAAu9opvQ
	(envelope-from <netdev+bounces-294424-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 23:36:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DF0326321CC
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 23:36:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=gdRTkv9p;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294424-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294424-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8F8843012EBF
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 21:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C44203A48DF;
	Tue,  2 Jun 2026 21:31:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0FFD368D43;
	Tue,  2 Jun 2026 21:31:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780435889; cv=none; b=TF1+qZjfIVy4sS1Xy5/eUB14lf5l1/e3OYmmiVczVFPM2TlQWplEJepbHn13h3XzmXNOQL88+zUfJazIUeeWlOuKreFyq8xMJtFs0GpRjWMT/eyQmJC2pMDwNUuUR9UviVtf219HzWz3AlBOrPkpX+H2m6jxj6Mk2yxbM2jmrFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780435889; c=relaxed/simple;
	bh=spHV9ysapO6njltPNLa3fNt7DOa820E3TcB58toW3v4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MpS6P+R2weHIPj1p8k/VFSIWjOD4vTiLk8ru1TLcUNpFsL92TBQRrJvqlCBNIAx7EPxHNlQIL5p/8weFl419pSwCp08fWNCNK4sqr23F7WpRGHdbnqiYZ7092RauWYBRrvw5XJNdtvh4yqB2HdclSMHRUzkzuIt0MSqmzAE3OXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gdRTkv9p; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F127D1F00893;
	Tue,  2 Jun 2026 21:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780435888;
	bh=K7zyTGQMZDcEmLO+p23hKPpA+8ThdoLRwkfC/1A1qj8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=gdRTkv9pk/VsQqNy9akN0dS1aqQoO4wAHLsT3d/dj/Ys8Fr1PwrAhy+YrEly8/x89
	 9ygmq8gT44/WGXsEt95d8kM1ouW++FKHdjfmb1tSOIbT/MlWWoL9a6J1i9Xw2ejBGd
	 mb7PXPSZfQ2grw+y7symBS7cB6WuT38UmC1UzHg1OA1XbQYbHTZc5cJIgTmletEFud
	 1DqnXp0x36RewK8fGDIobByMyoXQ/kL7mNmM5AuLVXvnBbu7fj0gPL9qhXZ0IHFXv1
	 XtENklNk/n1kXGrEUBKOrbUGgN1b/nl+ri3XIQXiH6vX7zipbi93sHktsywD2lldPL
	 TTB6yFy6ql4YA==
Date: Tue, 2 Jun 2026 14:31:27 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Dong Yibo <dong100@mucse.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, danishanwar@ti.com, vadim.fedorenko@linux.dev,
 horms@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 yaojun@mucse.com
Subject: Re: [PATCH net-next v5 2/4] net: rnpgbe: Add basic TX packet
 transmission support
Message-ID: <20260602143127.097ed301@kernel.org>
In-Reply-To: <20260528023150.239532-3-dong100@mucse.com>
References: <20260528023150.239532-1-dong100@mucse.com>
	<20260528023150.239532-3-dong100@mucse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-294424-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:dong100@mucse.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:danishanwar@ti.com,m:vadim.fedorenko@linux.dev,m:horms@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:yaojun@mucse.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DF0326321CC

On Thu, 28 May 2026 10:31:48 +0800 Dong Yibo wrote:
> +static int rnpgbe_maybe_stop_tx(struct mucse_ring *tx_ring, u16 size)
> +{
> +	if (likely(mucse_desc_unused(tx_ring) >= size))
> +		return 0;
> +
> +	netif_stop_subqueue(tx_ring->netdev, tx_ring->queue_index);
> +	/* Herbert's original patch had:
> +	 *  smp_mb__after_netif_stop_queue();
> +	 * but since that doesn't exist yet, just open code it.
> +	 */
> +	smp_mb();
> +
> +	/* We need to check again in a case another CPU has just
> +	 * made room available.
> +	 */
> +	if (likely(mucse_desc_unused(tx_ring) < size))
> +		return -EBUSY;
> +
> +	/* A reprieve! - use start_queue because it doesn't call schedule */
> +	netif_start_subqueue(tx_ring->netdev, tx_ring->queue_index);
> +
> +	return 0;
> +}

please use existing helpers from include/net/netdev_queues.h
-- 
pw-bot: cr

