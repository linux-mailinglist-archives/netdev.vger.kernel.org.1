Return-Path: <netdev+bounces-241985-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69402C8B624
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 19:08:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 143B43A1F15
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 18:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FCA130ACF0;
	Wed, 26 Nov 2025 18:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Ck9GrCIa"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D0C27145F
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 18:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764180506; cv=none; b=YhfGgSKzfUPyGDQ/R2Uga4UzwdJuJtwEz1RbX1X05ucyfpMtmJRf5YaPr392So0EvmWJ7W7yqwEZ8blq4dorwrCLrcUJ4656Vul7RKBRnHiU8YT3uH2jXn3xWKVXUFpPBbQ0RnARfPZIUlEZrTKVC019/qqRDiRhaxQJD46AIy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764180506; c=relaxed/simple;
	bh=2vHZnixxWT4TaMXqFluMRkXbh+v++mMm586S+pXahWU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=dvPMY53FQiIGWBrsNTLmnou83Sj/HFliRLaUfQ41cGoDnXVW/SxjiPC9pTRXo7B/x4sbMfWIe1FdRHbwNEYwPzC/RspeBScmrxSR3+bUMm3RkmeNvH1tF4xWR70FjlgACWVVZOBPhT2JkKfOcLSKNZlQVVMk0DexNd5OJdF0cno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Ck9GrCIa; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id E173F1A1D85;
	Wed, 26 Nov 2025 18:08:20 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 9B34360721;
	Wed, 26 Nov 2025 18:08:20 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8C6F4102F22D9;
	Wed, 26 Nov 2025 19:08:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1764180500; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=XkO9p8rK6RjRrBCy7/XhXYqGZ8sdXY37vJd20XZIRvQ=;
	b=Ck9GrCIaLwm8fuVkUewVo6REg81W6K48VRso8mT5H/fby7ZEA2CQPexR0uNlFoxHRK2rIz
	A+YcpPWmQl9CWkG4GJcFO5bcvkR8Y3VGLqQtZbAqxeQqTn5opNCFTF3DFd+aTQXA/m7Bjy
	JmsYaASlwsEcIAiV07oF9TcMoE+9EecwPU5M5CY2QWYa/fce7rU8EiQ6ckE6/eG2Wbv+QG
	gWdxBqwbDfRqifn7rL4F5Uijjv1t6I22XT7HXBGby4B30W7v7EJ9/IanI3FuuX8r8lBM7+
	as0Ze9vBQ9rk+lLJ/X13vukv9gh4Y796L2BfgnR/lvdOyGch0FVXpMaj/RxY8w==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 26 Nov 2025 19:08:14 +0100
Message-Id: <DEITSIO441QL.X81MVLL3EIV4@bootlin.com>
Cc: "Nicolas Ferre" <nicolas.ferre@microchip.com>, "Claudiu Beznea"
 <claudiu.beznea@tuxon.dev>, "Andrew Lunn" <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>,
 "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>,
 "Lorenzo Bianconi" <lorenzo@kernel.org>
To: "Paolo Valerio" <pvalerio@redhat.com>, <netdev@vger.kernel.org>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH RFC net-next 0/6] net: macb: Add XDP support and page
 pool integration
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251119135330.551835-1-pvalerio@redhat.com>
In-Reply-To: <20251119135330.551835-1-pvalerio@redhat.com>
X-Last-TLS-Session-Version: TLSv1.3

Hello Paolo,

So this is an initial review, I'll start here with five series-wide
topics and send small per-line comments (ie nitpicks) in a second stage.



### Rx buffer size computation

The buffer size computation should be reworked. At the end of the series
it looks like:

static int macb_open(struct net_device *dev)
{
    size_t bufsz =3D dev->mtu + ETH_HLEN + ETH_FCS_LEN + NET_IP_ALIGN;

    // ...

    macb_init_rx_buffer_size(bp, bufsz);

    // ...
}

static void macb_init_rx_buffer_size(struct macb *bp, size_t size)
{
    if (!macb_is_gem(bp)) {
        bp->rx_buffer_size =3D MACB_RX_BUFFER_SIZE;
    } else {
        bp->rx_buffer_size =3D size
            + SKB_DATA_ALIGN(sizeof(struct skb_shared_info))
            + MACB_PP_HEADROOM;

        if (bp->rx_buffer_size > PAGE_SIZE)
            bp->rx_buffer_size =3D PAGE_SIZE;

        if (bp->rx_buffer_size % RX_BUFFER_MULTIPLE)
            bp->rx_buffer_size =3D roundup(bp->rx_buffer_size, RX_BUFFER_MU=
LTIPLE);
    }
}

Most of the issues with this code is not stemming from your series, but
this big rework is the right moment to fix it all.

 - NET_IP_ALIGN is accounted for in the headroom even though it isn't
   present if !RSC.

 - When skbuff.c/h allocates an SKB buffer, it SKB_DATA_ALIGN()s
   headroom+data. We should probably do the same. In our case it would
   be:

   bp->rx_buffer_size =3D SKB_DATA_ALIGN(MACB_PP_HEADROOM + size) +
                        SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
   // or
   bp->rx_buffer_size =3D SKB_HEAD_ALIGN(MACB_PP_HEADROOM + size);

   I've not computed if it can ever give a different value to your
   series in terms of total size or shinfo alignment. I'd guess it is
   unlikely.

 - If the size clamping to PAGE_SIZE comes into play, we are probably
   doomed. It means we cannot deal with the MTU and we'll probably get
   corruption. If we do put a check in place, it should loudly fail
   rather than silently clamp.

TLDR: I think macb_init_rx_buffer_size() should encapsulate the whole
rx buffer size computation. It can use bp->rx_offset and add on top
MTU & co. It might start failing if >PAGE_SIZE (?).



### Buffer variable names

Related: so many variables, fields or constants have ambiguous names,
can we do something about it?

 - bp->rx_offset is named oddly to my ears. Offset to what?
   Maybe bp->rx_head or bp->rx_headroom?

 - bp->rx_buffer_size: it used to be approximately the payload size
   (plus NET_IP_ALIGN). Now it contains the XDP headroom and shinfo.
   That's on GEM, because on MACB it means something different.

   This line is a bit ironic and illustrates the trouble:
      buffer_size =3D SKB_WITH_OVERHEAD(bp->rx_buffer_size) - bp->rx_offset

 - data in gem_rx|gem_rx_refill|gem_free_rx_buffers() points to what we
   could call skb->head, ie start of buffer & start of XDP headroom.
   Its name implied skb->data to me, ie after the headroom.

   It also made `data - page_address(page) + bp->rx_offset` hard to
   understand. It is easier for me to understand that the following is
   the page fragment offset till skb->data:

      buff_head + bp->rx_headroom - page_address(page)

 - MACB_MAX_PAD is ambiguous. It rhymes with NET_SKB_PAD which is the
   default SKB headroom but here it contains part of the headroom
   (XDP_PACKET_HEADROOM but not NET_IP_ALIGN) and the tailroom (shinfo).

 - Field `data` in `struct macb_tx_buff` points to skb/xdp_frame but my
   initial thought was skb->data pointer (ie after headroom).
   What about va or ptr or buff or frame or ...?

TLDR: I had a hard time understanding size/offset expressions (both from
existing code and the series) because of variable names.



### Duplicated buffer size computations

Last point related to buffer size computation:

 - it is duplicated in macb_set_mtu() but forgets NET_IP_ALIGN & proper
   SKB_DATA_ALIGN() and,

 - it is duplicated in gem_xdp_setup() but I don't see why because the
   buffer size is computed to work fine with/without XDP enabled. Also
   this check means we cannot load an XDP program before macb_open()
   because bp->rx_buffer_size =3D=3D 0.

TLDR: Let's deduplicate size computations to minimise chances of getting
it wrong.



### Allocation changes

I am not convinced by patches 1/6 and 2/6 that change the alloc strategy
in two steps, from netdev_alloc_skb() to page_pool_alloc_pages() to
page_pool_alloc_frag().

 - The transient solution isn't acceptable when PAGE_SIZE is large.
   We have 16K and would never want one buffer per page.

 - It forces you to introduce temporary code & constants which is added
   noise IMO. MACB_PP_MAX_BUF_SIZE() is odd as is the alignment of
   buffer sizes to page sizes. It forces you to deal with
   `bp->rx_buffer_size > PAGE_SIZE` which we could ignore. Right?

TLDR: do alloc changes in one step.



### XDP_SETUP_PROG if netif_running()

I'd like to start a discussion on the expected behavior on XDP program
change if netif_running(). Summarised:

static int gem_xdp_setup(struct net_device *dev, struct bpf_prog *prog,
             struct netlink_ext_ack *extack)
{
    bool running =3D netif_running(dev);
    bool need_update =3D !!bp->prog !=3D !!prog;

    if (running && need_update)
        macb_close(dev);
    old_prog =3D rcu_replace_pointer(bp->prog, prog, lockdep_rtnl_is_held()=
);
    if (running && need_update)
        return macb_open(dev);
}

Have you experimented with that? I don't see anything graceful in our
close operation, it looks like we'll get corruption or dropped packets
or both. We shouldn't impose that on the user who just wanted to swap
the program.

I cannot find any good reason that implies we wouldn't be able to swap
our XDP program on the fly. If we think it is unsafe, I'd vote for
starting with a -EBUSY return code and iterating on that.

TLDR: macb_close() on XDP program change is probably a bad idea.

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


