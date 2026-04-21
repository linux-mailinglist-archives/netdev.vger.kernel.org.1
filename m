Return-Path: <netdev+bounces-280109-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wNhXNwFv52ke8AEAu9opvQ
	(envelope-from <netdev+bounces-280109-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 14:35:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E331743AB07
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 14:35:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EA7903001CF8
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 12:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61C1D3D1CD0;
	Tue, 21 Apr 2026 12:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="f8uIoB+l"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8FB34CDD;
	Tue, 21 Apr 2026 12:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776774894; cv=none; b=DFdgw1FcXMPzZfErTX0lPKcGHxF2fGmBJtLjiz0wbU7XfXW3/pxWwdriEaOCZ8NyZQrQ4gXkS7VxyQzIWv3xoDaGCEEuhFxWpoVkVcneLr0HZ9OJj0j7Cebp5/tekMOqIip1ntuBziFsuApH8UIlHOQm75IvFE/657DeEKyHAQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776774894; c=relaxed/simple;
	bh=rwsA0pldTCqnZF90Sq2pS3bZwkJCbwSzoNZXgZew500=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mk1PODZiyWzoh6F+Dgsh1Is2/UVuMcbANSGvV0YmSlX02swui+Mo0FoM9zraZ6ibglt0hCWtH3yZqE6JgZvVsM2kB0x3AomIOeF0ToGNRY4P9azkE7u+MwZqNPKax9K/X8h3Jl2e7U8OE6yYZ/8aBWA914S/cmO/iJFGNHERY4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=f8uIoB+l; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=eQZ7su/6OU1So8UuL+bxoFXHxezoh2xag7pgncwwvlE=; b=f8uIoB+liwnukidODaj7xp9eyM
	n2K+rbbrM70JrLUxvVxaPWylYzGaf6IyqqR0Dv9C1DZgd+N5qJRNIDM0V4IFc/U9qDFPklLkH6FIj
	NB3bVl5SYMcrn6+yMgvjTyIoDT4wB+pf9BDiUE4kNqzUR/jOsEkLrgIWtJbg7Wrgqs8c=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wFAJP-00GtN3-UJ; Tue, 21 Apr 2026 14:34:43 +0200
Date: Tue, 21 Apr 2026 14:34:43 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Morduan Zang <zhangdandan@uniontech.com>
Cc: Petko Manolov <petkan@nucleusys.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: usb: rtl8150: free skb on usb_submit_urb() failure
 in xmit
Message-ID: <a5d743ed-d1db-401d-a3cb-2986a08b98bb@lunn.ch>
References: <678BC10BB9E39322+20260421111025.15833-1-zhangdandan@uniontech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <678BC10BB9E39322+20260421111025.15833-1-zhangdandan@uniontech.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-280109-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:email,lunn.ch:dkim,lunn.ch:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,uniontech.com:email]
X-Rspamd-Queue-Id: E331743AB07
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 21, 2026 at 07:10:25PM +0800, Morduan Zang wrote:
> When rtl8150_start_xmit() fails to submit the tx URB, the URB is never
> handed to the USB core and write_bulk_callback() will not run.  The
> driver returns NETDEV_TX_OK, which tells the networking stack that the
> skb has been consumed, but nothing actually frees the skb on this
> error path:
> 
>   dev->tx_skb = skb;
>   ...
>   if ((res = usb_submit_urb(dev->tx_urb, GFP_ATOMIC))) {
>           ...
>           /* no kfree_skb here */
>   }
>   return NETDEV_TX_OK;
> 
> This leaks the skb on every submit failure and also leaves dev->tx_skb
> pointing at memory that the driver itself may later free, which is
> fragile.
> 
> Free the skb with dev_kfree_skb_any() in the error path and clear
> dev->tx_skb so no stale pointer is left behind.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Morduan Zang <zhangdandan@uniontech.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

