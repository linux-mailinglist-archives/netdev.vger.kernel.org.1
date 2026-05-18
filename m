Return-Path: <netdev+bounces-288789-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2IvTE+pcCmoX0QQAu9opvQ
	(envelope-from <netdev+bounces-288789-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 02:27:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DD972564814
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 02:27:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C89153009161
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 00:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 057E817A2F6;
	Mon, 18 May 2026 00:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="dkJ1BovY";
	dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="cydewFPO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.uniroma2.it (smtp.uniroma2.it [160.80.4.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D8D625
	for <netdev@vger.kernel.org>; Mon, 18 May 2026 00:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.80.4.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779064037; cv=none; b=AyVO1m9RP+YmI+J5N/p7uSR6w6Hp046YVVxqOGd0wW3e6Bsb3Sd92KFCAgagFV8uxIZC7Y0VfTXrqldolT+2E5/xpBnI3v/NscLTjsb1+xhocxMKzWgv3oeuwmT4kn4zvzXUdKq+d8NrLcU6U7U5tWvj7JjC32xvwgZQTSTgXPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779064037; c=relaxed/simple;
	bh=7h2enbGctrQWWXAc7Qk6Pok5+8n4jTaTSAZOOzHdEII=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=oLYslcec3JmnVx3cW8LTPhov6iVm+BS8PGv/ly1SVh2i82w2i6LCgUqpNSzoS9CdkwXPCab6u51ROwbPSYRQt9ZRV+zWURcprc/gyDa0K0gSr5b4uR3j9T7eP1DDFBhzJZe+ao53oG7rQSFEV/nETTZqaeOoSmTNGE/LpJAz9g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it; spf=pass smtp.mailfrom=uniroma2.it; dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=dkJ1BovY; dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=cydewFPO; arc=none smtp.client-ip=160.80.4.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniroma2.it
Received: from smtpauth-2019-1.uniroma2.it (smtpauth.uniroma2.it [160.80.5.46])
	by smtp-2015.uniroma2.it (8.14.4/8.14.4/Debian-8) with ESMTP id 64I0QSdV027107;
	Mon, 18 May 2026 02:26:34 +0200
Received: from lubuntu-18.04 (host-95-246-236-184.retail.telecomitalia.it [95.246.236.184])
	by smtpauth-2019-1.uniroma2.it (Postfix) with ESMTPSA id 5524E120535;
	Mon, 18 May 2026 02:26:24 +0200 (CEST)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=uniroma2.it;
	s=ed201904; t=1779063984; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q83iHMFkqa+wxFCgKiJIAuLPuVm0wlViXHFr6DmufXw=;
	b=dkJ1BovYiqaiBrvI2TwyJUOx6Bep7bqUfzcWxp6zUHeEUOqAItSnNonPCpkOkC45UOTFz3
	hyYEcHnP5Xxk63Dg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniroma2.it; s=rsa201904;
	t=1779063984; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q83iHMFkqa+wxFCgKiJIAuLPuVm0wlViXHFr6DmufXw=;
	b=cydewFPOTaJNlQ1tZ9HcKU+visYBmm9u1J+5POiqhT11XyQ6xHJ2+p5k6fyBvZLyNXidZz
	OOF0ikpiES9Ed6atwJ/od+FZ/dH6jBkNdIjg7NtvHmGGnMSPIHGX1se0SzMwq78UChfNwH
	xwEOr00scsf32mY8A16RIeNb0rDUs99h1tnaFvubHXzDFJ0xWKLamJhUZrM3HxpzZ7Obnp
	wAZX21QxP3ccwlBia0NcrK2hRVfIhU52wIxlucuhp6LTvbBj+lTyTw9JR8HYpdm6/q/8tU
	xBqNX9F4wjrvjo2U4+3y5/C4VQpsFQLjfMy6Y05AEAQi6tB/ecBv7QktfhoI/g==
Date: Mon, 18 May 2026 02:26:23 +0200
From: Andrea Mayer <andrea.mayer@uniroma2.it>
To: Justin Iurman <justin.iurman@gmail.com>
Cc: Weiming Shi <bestswngs@gmail.com>,
        "David S . Miller"
 <davem@davemloft.net>,
        David Ahern <dsahern@kernel.org>, Eric Dumazet
 <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>,
        Simon Horman <horms@kernel.org>,
        Alexander Aring
 <alex.aring@gmail.com>, netdev@vger.kernel.org,
        Xiang Mei <xmei5@asu.edu>, Andrea Mayer <andrea.mayer@uniroma2.it>
Subject: Re: [PATCH net] ipv6: rpl: add NULL check for idev in
 ipv6_rpl_srh_rcv()
Message-Id: <20260518022623.80d82c9c2184760aecc0f70b@uniroma2.it>
In-Reply-To: <2e7d302f-a03e-4df3-8e6c-9339166a831e@gmail.com>
References: <20260515125530.3396293-2-bestswngs@gmail.com>
	<2e7d302f-a03e-4df3-8e6c-9339166a831e@gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.100.0 at smtp-2015
X-Virus-Status: Clean
X-Rspamd-Queue-Id: DD972564814
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[uniroma2.it,none];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[uniroma2.it:s=ed201904,uniroma2.it:s=rsa201904];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	URIBL_MULTI_FAIL(0.00)[uniroma2.it:server fail,asu.edu:server fail,sea.lore.kernel.org:server fail];
	TAGGED_FROM(0.00)[bounces-288789-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,kernel.org,google.com,redhat.com,vger.kernel.org,asu.edu,uniroma2.it];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrea.mayer@uniroma2.it,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[uniroma2.it:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Sun, 17 May 2026 20:58:25 +0200
Justin Iurman <justin.iurman@gmail.com> wrote:

> On 5/15/26 14:55, Weiming Shi wrote:
> > ipv6_rpl_srh_rcv() calls __in6_dev_get(skb->dev) and dereferences the
> > result without a NULL check.  When addrconf_ifdown() concurrently clears
> > dev->ip6_ptr via RCU_INIT_POINTER(dev->ip6_ptr, NULL), __in6_dev_get()
> > returns NULL and the subsequent READ_ONCE(idev->cnf.rpl_seg_enabled)
> > triggers a NULL pointer dereference.
> > 
> >   BUG: kernel NULL pointer dereference, address: 0000000000000370
> >   Oops: Oops: 0000 [#1] SMP NOPTI
> >   RIP: 0010:ipv6_rthdr_rcv+0x3bf/0xe70
> >    ipv6_rpl_srh_rcv (net/ipv6/exthdrs.c:504)
> >    ipv6_rthdr_rcv (net/ipv6/exthdrs.c:691)
> >    ip6_protocol_deliver_rcu (net/ipv6/ip6_input.c:478)
> >    ip6_input_finish (net/ipv6/ip6_input.c:532)
> >    ip6_input (net/ipv6/ip6_input.c:540)
> > 
> > Add a NULL check for idev, dropping the packet when the device has no
> > IPv6 configuration.
> > 
> > Fixes: 8610c7c6e3bd ("net: ipv6: add support for rpl sr exthdr")
> > Reported-by: Xiang Mei <xmei5@asu.edu>
> > Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> > ---
> >   net/ipv6/exthdrs.c | 4 ++++
> >   1 file changed, 4 insertions(+)
> > 
> > diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
> > index 95558fd6f447..19002e551a03 100644
> > --- a/net/ipv6/exthdrs.c
> > +++ b/net/ipv6/exthdrs.c
> > @@ -498,6 +498,10 @@ static int ipv6_rpl_srh_rcv(struct sk_buff *skb)
> >   	u32 r;
> > 
> >   	idev = __in6_dev_get(skb->dev);
> > +	if (!idev) {
> > +		kfree_skb(skb);
> > +		return -1;
> > +	}
> > 
> >   	accept_rpl_seg = min(READ_ONCE(net->ipv6.devconf_all->rpl_seg_enabled),
> >   			     READ_ONCE(idev->cnf.rpl_seg_enabled));
> > --
> > 2.43.0
> 
> The fix is correct, but this is a duplicate of Andrea's patch (see [1]) 
> where Eric suggested to use kfree_skb_reason() with 
> SKB_DROP_REASON_IPV6DISABLED. Based on the above, I don't think this 
> patch should be accepted.
> 
>   [1] 
> https://lore.kernel.org/netdev/20260428224816.11223-1-andrea.mayer@uniroma2.it/  

Hi Justin, thanks for CC'ing me.

Yes, the correct approach is the one Eric suggested, which I have
ready in my v2. I'll send it shortly.

Thanks Weiming for independently catching this as well.

Thanks,
Andrea

