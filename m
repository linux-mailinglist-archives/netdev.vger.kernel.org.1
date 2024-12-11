Return-Path: <netdev+bounces-150982-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 924A89EC421
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 06:06:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D23B1164D12
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 05:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 333181BDAA0;
	Wed, 11 Dec 2024 05:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="mQjqKCKo"
X-Original-To: netdev@vger.kernel.org
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5DA6F30C
	for <netdev@vger.kernel.org>; Wed, 11 Dec 2024 05:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733893593; cv=none; b=TquGa3pTvsf83oiSiNeDj9bIueDtrtGDISe0+/ptB7QQYONF6ZZuAAzK89zQy7vgLEC5NKtXKypqO32nxnxPZiemjuwPE6lnwRu9ajaG5O/+L+RgkR8/S1oLnRG8VRkHJAKt57dCZB6nBtgqbnu9wsJGOI3jnnrer4YSDua1I2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733893593; c=relaxed/simple;
	bh=fD0kUrP5zXbjWk61sEra1X2LzzU8Cg5EylNBGaTfV04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FO3KGTAjpcSZkXS4LGF4OfPfNAQibFMR4O9jn07Wtr95zzbaEII5orIHdMknYmtxl2oEQ2YQV1tV8aIP6yasbdi2ck8UCFac8OPKVAg1PX6Zqex4LtBEtLl/s4TX4ZX48yGBD6G3GdO+LzItvegb9WrSP3x2s9nylcSvopL/roM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=mQjqKCKo; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1733893587; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=t2wV/CE0BewcdP68ZAlyyjtK2BIaAHmpNTm91hSe4Kk=;
	b=mQjqKCKoylUKaPfiXTMNerZ//R7zoFnfYHXOSoVnlglWIOzv7AtCNmVTMAHz6TAODmRBsSmS10Iu1DjDBg6JRK6FZkkiY0f5Tmwx79/btL1OdmHepPwy6QOIDKaPOp28gcWI6HTEdt5kxsKp/u1DMMUmqBq749G0RkC7/jCfW4Y=
Received: from localhost(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0WLH0FG0_1733893586 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 11 Dec 2024 13:06:27 +0800
Date: Wed, 11 Dec 2024 13:06:26 +0800
From: "D. Wythe" <alibuda@linux.alibaba.com    >
To: John Ousterhout <ouster@cs.stanford.edu>
Cc: "D. Wythe" <alibuda@linux.alibaba.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v3 11/12] net: homa: create homa_plumbing.c
 homa_utils.c
Message-ID: <20241211050626.GA128065@j66a10360.sqa.eu95>
References: <20241209175131.3839-1-ouster@cs.stanford.edu>
 <20241209175131.3839-13-ouster@cs.stanford.edu>
 <20241210060834.GB83318@j66a10360.sqa.eu95>
 <CAGXJAmxbv=0Aw61cfOg+mtcrheV7y3db7xYcwTOfjvLYT61P7g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXJAmxbv=0Aw61cfOg+mtcrheV7y3db7xYcwTOfjvLYT61P7g@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Tue, Dec 10, 2024 at 05:59:00PM -0800, John Ousterhout wrote:
> It used to be that RPC ids were only unique to a port, not to a node;
> when I changed Homa to make ids unique within a client node I somehow
> forgot to remove the dport argument from homa_find_server_rpc. I have
> now removed that argument.
> 
> > Anyway, the judgment of whether the skb comes from the same RPC
> > should be consistent, using a unified function or macro definition.
> 
> I agree with this in principle, but this case is a bit special: it's
> on the fast path, and I'd like to not  invoke skb_canonical_ipv6_saddr
> if the ids don't match; if I move this code to a shared function, I'll
> have to pass in the canonical address which will require the
> conversion even when the ids don't match. I don't think there are any
> other places in the code that compare packets for "same RPC" except
> the lookup code in homa_rpc.c, so a shared function would probably
> only be used in this one place. Thus, I'm inclined to leave this code
> as is.

This class maintenance issue is fine as long as the maintainer feels
it's okay. I won't object to this.

> > > +                                     *prev_link = skb2;
> > > +                                     prev_link = &skb2->next;
> > > +                                     continue;
> > > +                             }
> > > +                     }
> > > +                     *other_link = skb2;
> > > +                     other_link = &skb2->next;
> > > +             }
> > > +             *prev_link = NULL;
> > > +             *other_link = NULL;
> > > +             homa_dispatch_pkts(packets, homa);
> 
> > > +
> > > +             iph = (struct iphdr *)(icmp + sizeof(struct icmphdr));
> > > +             h = (struct common_header *)(icmp + sizeof(struct icmphdr)
> > > +                             + iph->ihl * 4);
> >
> > You need to ensure that the comm_header can be accessed linearly. The
> > icmp_socket_deliver() only guarantees that the full IP header plus 8 bytes
> > can be accessed linearly.
> 
> This code only accesses the destination port, which is within the
> first 4 bytes of the common_header (the same position as in a TCP
> header). Thus I think it's safe without calling pskb_may_pull?

You are right, but there is still a small issue. The standard
practice is to directly obtain the nested iphdr from skb->data, rather than
from icmphdr + size.

FYI:
		<  skb->head
...
iphdr		<- head + network_header
icmphdr		<- head + transport_header
nested-iphdr	<- skb->data
homahdr		<- skb->data + iph->ihl * 4

> 
> Thanks for the explanation; I have now removed the comment.
> 
> > > +     sock_poll_wait(file, sock, wait);
> > > +     mask = POLLOUT | POLLWRNORM;
> > > +
> > > +     if (!list_empty(&homa_sk(sk)->ready_requests) ||
> > > +         !list_empty(&homa_sk(sk)->ready_responses))
> > > +             mask |= POLLIN | POLLRDNORM;
> > > +     return (__poll_t)mask;
> > > +}
> >
> >  Always writable? At least, you should check the state of the
> >  socket. For example, is a socket that has already been shutdown still
> >  writable? Alternatively, how does Homa notify the user when it
> >  receives an ICMP error? You need to carefully consider the return
> >  value of this poll. This is very important for the behavior of the
> >  application.
> 
> I think it's OK for Homa sockets to be writable always. If the socket
> has been shut down and an application attempts to write to it, it will
> get ESHUTDOWN then. Message sends in Homa are always asynchronous, so
> there is no notion of them blocking. ICMP errors are reflected at the
> level of RPCs (on the server side, the RPC is discarded if an ICMP
> error occurs; on the client side, an error will be returned as
> response, which will make the socket "readable").

Sounds reasonable.

> 
> However, your comment makes me wonder about polling for read on a
> socket that has been shutdown. If I don't return -ESHUTDOWN from
> homa_poll in this case, I believe the application could block waiting
> for reads on a socket that has been shutdown? Of course this will
> never complete. So, should I check for shutdown and return -ESHUTDOWN
> immediately in homa_poll, before invoking sock_poll_wait?

Always invoke sock_poll_wait before checking any state, If you got RCV_SHUTDOWN,
you should return at least a mask with POLLIN (not -SHUTDOWN), then
return 0 (in most cases) in homa_recvmsg(). You can refer to tcp_poll for
this.

> 
> -John-

