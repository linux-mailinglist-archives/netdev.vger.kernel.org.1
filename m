Return-Path: <netdev+bounces-300921-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YljyJq5gOGrpbgcAu9opvQ
	(envelope-from <netdev+bounces-300921-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 00:07:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E48896ABB41
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 00:07:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=VAMdFzLx;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300921-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-300921-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D131A303428B
	for <lists+netdev@lfdr.de>; Sun, 21 Jun 2026 22:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01CB0371878;
	Sun, 21 Jun 2026 22:06:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014042EF652;
	Sun, 21 Jun 2026 22:06:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782079572; cv=none; b=jZw5//idDFrmnO3Gf7U8gUEDqlMmFIDtanhFpR8bwtKzqBkEbr0bua9G3qmrcW90/ghVDd629K9+WuI2QAGIrDRKZafUORbI/UvYVEry3JXobJhI7+LADL9Ze0OGCEWp2ALqSgR6sMQOiXXCiwUJdSzBLQ9+WfkqM9rQefuICTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782079572; c=relaxed/simple;
	bh=1DJqPRY6i99+vjc+yLgP3ut8+7CArs/ZawFf5y8LCzg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dgNvpSsnq9BQ/Bx+VLz8jk2VQGX+r+kF0MVtLN3fo3UCA7Ih/1XjHAYLrLqZPImJMamHBp7JBOQQE5Ka0qQmWriIipo09GAkAWKGLRo9JOXGgN19JZExOmxWZO0JzLtiqrBWQzHtkmOacT6KS9YIfsFTVEmb+bat+PIcp5DNybk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VAMdFzLx; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A0AE1F000E9;
	Sun, 21 Jun 2026 22:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782079571;
	bh=0jRK8ItK0sZaZhCC4/wpSQncIoEHVkfMVHG4sDnkFCU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=VAMdFzLxa2VAahWb9CUDyjwa+fBm2FAZ8QAsY+uUliz62lSeQ0vk0w2xdFJyijIMo
	 OzwKCzKxHAykiIsbLZiSSKImGPLTTXK3OqJ/5E3LKrDwJn7kXkZM/AoIXqZUd30bH3
	 NGMLYDdnkFtjRdgGU3MQ8sQ2WntHCYvjS1YaMhek6H4dPUfVMA9PILhM1e/88vI4B9
	 725vpvu3GfLv1ziSyxrXIv/x3Rg27QBwWqI8rzQ+Ms9DHioW1ypdt3bEjekNpulZeR
	 OHiUJWaibObyH0gIH+XOLFsgrU9wZeE5KxFanCHT7bGOv1xw91JuAOQ9SoNqMATg1k
	 OBARyPDTFlhMA==
Date: Sun, 21 Jun 2026 15:06:10 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: xuanzhuo@linux.alibaba.com
Cc: Menglong Dong <menglong8.dong@gmail.com>, eperezma@redhat.com,
 mst@redhat.com, jasowang@redhat.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 netdev@vger.kernel.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3] virtio-net: xsk: support tx wake up
Message-ID: <20260621150610.0ad5d02e@kernel.org>
In-Reply-To: <20260616115912.513183-1-dongml2@chinatelecom.cn>
References: <20260616115912.513183-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300921-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_RECIPIENTS(0.00)[m:xuanzhuo@linux.alibaba.com,m:menglong8.dong@gmail.com,m:eperezma@redhat.com,m:mst@redhat.com,m:jasowang@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:virtualization@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:menglong8dong@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,redhat.com,lunn.ch,davemloft.net,google.com,vger.kernel.org,lists.linux.dev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E48896ABB41

On Tue, 16 Jun 2026 19:59:12 +0800 Menglong Dong wrote:
> For now, XDP_RING_NEED_WAKEUP is not supported properly by the virtio-net
> in the tx path for example: we set xsk_set_tx_need_wakeup() in
> virtnet_xsk_xmit(), but we didn't call xsk_clear_tx_need_wakeup()
> anywhere, which means the user will call send() for every packet.
> 
> We call xsk_set_tx_need_wakeup() after virtnet_xsk_xmit_batch() if sq->vq
> is empty, as we can't be wakeup by the skb_xmit_done() in this case.
> Otherwise, we will clear the wakeup flag.
> 
> Race condition is considered for tx path.

Seems to follow what mlx5 does so presumably this is fine but IDK if
there's anything virtio-specific that we need to be worried about.

Xuan Zhuo, please TAL?
-- 
mping: VIRTIO NET DRIVER

