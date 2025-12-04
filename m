Return-Path: <netdev+bounces-243574-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 660CECA3EAC
	for <lists+netdev@lfdr.de>; Thu, 04 Dec 2025 14:55:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 78EBC304EFEC
	for <lists+netdev@lfdr.de>; Thu,  4 Dec 2025 13:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 748FC33FE16;
	Thu,  4 Dec 2025 13:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="HKvNJFcj"
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9AF341678;
	Thu,  4 Dec 2025 13:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764855876; cv=none; b=fa9MN89pTDeChKTZkBcZXZzPb9rVkd/pnj99I2vKXdPYU1zfhm7CqltqaZ6WQeOTo7kapmoDnPC1AD0AM3szyvQlVVdhaBKmdII6pn+I1qSghQYqlopbMMi9ZQfOlLXGSejYLbfmjK8f5AnrN6pXqjG5fMerKyj1sqIHL8+vulE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764855876; c=relaxed/simple;
	bh=9Ogr3JDeOqxGNUKGzHBlBtlsu8R6M/Fv3fz4YQgTjSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kcFSVgTNKZ0724MJ2tC5h8FS5iMPRCKUa33Qfh6m0M5W2CZPvttV6q0lnrjYMXIGM0/wB/tW7II11IWdBhhRSJdElNhFBYSE80wDImfbsd8kat737HMU4+6wMJ7btt7C/a6UdRBodJkts+he5SKaar/sv1NJGo9L1Jt6xQaj05Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=HKvNJFcj; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-ID:Content-Description;
	bh=7NuXqo3aSvpmuekAC2C1oe2uL7mQ1FsOsgMv4C/bFqU=; b=HKvNJFcjb1ZHB9prvVO2vn88xZ
	UeGWDDHCt2CH+GY9Kp9ev6bl6EjsdNHV4RmsDaO+Z0M9CN0m/NBvc2cqhSk5NT2bWuXbv1/SX6t78
	5vIsJKavBekBSG3W83crDBNgJJzS8Qr9kWmJpS0JBZqoury5CV/L+k6TaoZmIa8vvzW5/2OLqYFRC
	eH+o65SAhuUBBa1Ippoy8GBzC9vXVRywqLytQA2p8eo5vpmCgwMu+A3zA37zdUn97WCXRHsbiMgO3
	Jfnue9Xvqbd7RA0hWS87bYJfZoGzz5WXc2td4OhERYMSgXFWuur9N773Why8NfsXyF7LO3vcRSv7p
	nMrBhwHQ==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1vR9cz-0036dm-K6; Thu, 04 Dec 2025 13:44:14 +0000
Date: Thu, 4 Dec 2025 05:44:09 -0800
From: Breno Leitao <leitao@debian.org>
To: Fabian =?utf-8?Q?Gr=C3=BCnbichler?= <f.gruenbichler@proxmox.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, leit@meta.com, open list <linux-kernel@vger.kernel.org>, 
	"open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next] net: veth: Disable netpoll support
Message-ID: <fjv5oojsuazpdofdrgggwfcafw5vheus3wwzccq22aeztrbyew@yguz7qsd6djk>
References: <20240805094012.1843247-1-leitao@debian.org>
 <1764839728.p54aio6507.astroid@yuna.none>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1764839728.p54aio6507.astroid@yuna.none>
X-Debian-User: leitao

hello Fabian,

On Thu, Dec 04, 2025 at 10:20:06AM +0100, Fabian Grünbichler wrote:
> On August 5, 2024 11:40 am, Breno Leitao wrote:
> > The current implementation of netpoll in veth devices leads to
> > suboptimal behavior, as it triggers warnings due to the invocation of
> > __netif_rx() within a softirq context. This is not compliant with
> > expected practices, as __netif_rx() has the following statement:
> > 
> > 	lockdep_assert_once(hardirq_count() | softirq_count());
> > 
> > Given that veth devices typically do not benefit from the
> > functionalities provided by netpoll, Disable netpoll for veth
> > interfaces.
> 
> this patch seems to have broken combining netconsole and bridges with
> veth ports:

Sorry about it, but, veth ends up calling __netif_rx() from a process
context, which kicks the lockdep above.

__netif_rx() should be only called from soft or hard IRQ, which is not
how netpoll operates. A printk message can be printed for any context.

> https://bugzilla.proxmox.com/show_bug.cgi?id=6873
> 
> any chance this is solvable?

I don't see a clear way to solve it from a netpoll point of view,
honestly.

From a veth perspective, I am wonderig if veth_forward_skb() can call
netif_rx(), which seems to be safe in any context. Something as:

	diff --git a/drivers/net/veth.c b/drivers/net/veth.c
	index cc502bf022d5..cf6443e5d7bc 100644
	--- a/drivers/net/veth.c
	+++ b/drivers/net/veth.c
	@@ -318,7 +318,7 @@ static int veth_forward_skb(struct net_device *dev, struct sk_buff *skb,
	{
		return __dev_forward_skb(dev, skb) ?: xdp ?
			veth_xdp_rx(rq, skb) :
	-               __netif_rx(skb);
	+               netif_rx(skb);
	}

	/* return true if the specified skb has chances of GRO aggregation
	@@ -1734,7 +1734,6 @@ static void veth_setup(struct net_device *dev)
		dev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
		dev->priv_flags |= IFF_NO_QUEUE;
		dev->priv_flags |= IFF_PHONY_HEADROOM;
	-       dev->priv_flags |= IFF_DISABLE_NETPOLL;
		dev->lltx = true;

		dev->netdev_ops = &veth_netdev_ops;

