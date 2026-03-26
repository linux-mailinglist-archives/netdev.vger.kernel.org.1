Return-Path: <netdev+bounces-271893-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yOmPLK/cxGlf4gQAu9opvQ
	(envelope-from <netdev+bounces-271893-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 08:13:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B3B5E3304FF
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 08:13:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AC24F3011518
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 07:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87F3C37E2ED;
	Thu, 26 Mar 2026 07:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J+y2kx4M"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE8B30CD82
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 07:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774509226; cv=none; b=ij0qepaCcSevY8KC4PJrz5h5JyuwjdhXl3e6WTnL2Dmv5SH1DVWuC/EUm4BHsaSaPSEuNLOHsb17+Gqp7aCfSwoenBjGDMLKx2vD7Pz1FlO/akPIgZlKXfOsItsc4JdDQkC5ZQbEokTj77sp4yxA6WRD73xgOwpYbSGujuqNM20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774509226; c=relaxed/simple;
	bh=bTDNJQJ2BTBWHEWSJAUYnCHpBJNJEvBkSP6nAY2yOgI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rLZGu6pYmGJ8zmsXbv2c44krux5GVT47ShP5xOaWFTZkJO713RA2K9EMyBMVkU6dn9JZRsZQEU+bivF8X/YvnDd6PqN1IG0Qw3rxy/HWWtQFmf5itCf7djk3w9bTREkWiW9qNmgO99/TFD1sDdjn9Q5JM/R7Oo5DFSJ1ztXgq6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J+y2kx4M; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3585ec417f6so779949a91.1
        for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 00:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774509225; x=1775114025; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eKuLNumimo4tNVPTjHcoFEswgzukVDeIxukvY81gtSo=;
        b=J+y2kx4MDg7LkDn8lkE7gskg8IjcZYWC9aMSPDHIO3lINHXmxkezfdQSgdZ0rXb3jJ
         4uwPj5J1SDL+JlyEXJyOb2MP1wSEnzB5TyXxJJVDzeMcceVuQxJmgAsCvNtGm7EwYzTp
         ScVsXCRZ8UsVBLcRKXe0cDeGakB2+7ZfxJvi2cMODcIbZYB2Uw0TXTnvENYk0GZTIbwT
         Z2lOXUoRFCUKpGyi8JOe64/CmWBNfaqIFY84JPSkviS71HWdf3Snj06ITvlHh7p8Ia9q
         lXB2HETABPLfyFImnlrOXomdqp2r+nyewfl1VOqEp5xy/SD7+hIuUPGcEBUD1bDUw46h
         n3+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774509225; x=1775114025;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eKuLNumimo4tNVPTjHcoFEswgzukVDeIxukvY81gtSo=;
        b=JfnydSVo8XlU9eZoCDPTbS9pza2NherfQQf1aYB0mV6GyKotvKt7bMryrOcK2wm60f
         aaQMTGSSiFQve7tB+5S89XbDLwyr/fGfra8lyuaEK8qGATpGpsmpCKIm89uhqFu8A2mJ
         hdcYRSDoy+obGn/ja3cyQYhpl5EgnxPjGZsbnf92C6yWsbXZ5v5Lb6sKD06a6Tq7pxVw
         Jh8fbBh4S1RW3T6SpFrWK4uui95179RfELdRdSi23/5KZEpikJHsJxUOvDReeqqAyy7Q
         Fr58WzNlgSBMuWdXyypFqr/yFbMi/jtqQ+jAiLsqIyvnQERNTUFkwYUmz5ztK9KMf3UG
         DYbw==
X-Forwarded-Encrypted: i=1; AJvYcCWUqNu7zbPGVwSiAKtuW4lU3JXXbD5kh+QS4zTp/fHKpKUDHnL63qY9lDlrelXWDm3S6t9AaG4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEjs+FNay4D6fjtKPVYXI2sY+J3gnQaW3mXgHkAt4du8/73ndA
	Wtp1yunaetquIFBiEULEifVW1yjU4qtsR9hEiwLocKRqKtHPMbc8BnC/
X-Gm-Gg: ATEYQzzY2MnBhXCb/n5YNthf3eSV5fyfr4TspdcdIBvLXnkNKhm3mVyeNf0rvceb0kN
	hIk+GHeVMR+RZ/+KJJf0j+hmpbwKdTvTsB8+SkvzprMrTLjCpQhr85XT2jJVRs8M7i6EwLWwamD
	eowZLxfuOX3D8PNgG2jSqhflvS5DTdnnISWVJfJKC53N4uAwJeMUWYNktBZT62XsRgbPJGCNeqP
	YVe5doCF1cjO+8CgECprcc76fgDl3PNTE3Z/jtnsoR+UN8CG+IuA8AY+6KRiF0dpwHOUp2QfbFs
	Hfg3LyGupozpaOq0G36+qli4iH3YQPZYT3+i23z2KH+wgWHaupfvyZgXTyNYxbVYA/MBMWzsouw
	NAOvfVp8Yq6veVXvqzMnBF3VR8po/xrWyAQA1hq4PzU5bbBULeFT2Ogi4YIHSIa+vgPhuxqUpKr
	e8zxnGKirDgMFdP4tE0EHL8s3WPOpS6vi1I9tq/g==
X-Received: by 2002:a17:902:f712:b0:2b0:ba48:274 with SMTP id d9443c01a7336-2b0c4818b3cmr6299305ad.1.1774509224571;
        Thu, 26 Mar 2026 00:13:44 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0bc773997sm20834375ad.6.2026.03.26.00.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 00:13:43 -0700 (PDT)
Date: Thu, 26 Mar 2026 07:13:36 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, David Ahern <dsahern@gmail.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Fei Liu <feliu@redhat.com>
Subject: Re: [PATCH net] ipv6: fix data race in fib6_metric_set() using
 cmpxchg
Message-ID: <acTcoK1P7SFpDfwV@fedora>
References: <20260326-b4-fib6_metric_set-kmemleak-v1-1-c89fc1b312c0@gmail.com>
 <e53a26e9-1120-4486-8b53-5caa8b959a28@linux.dev>
 <acTV0uiLrGTByBAC@fedora>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acTV0uiLrGTByBAC@fedora>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,google.com,redhat.com,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-271893-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[liuhangbin@gmail.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: B3B5E3304FF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 26, 2026 at 06:44:43AM +0000, Hangbin Liu wrote:
> On Thu, Mar 26, 2026 at 02:23:15PM +0800, Jiayuan Chen wrote:
> > 
> > On 3/26/26 12:22 PM, Hangbin Liu wrote:
> > > fib6_metric_set() may be called concurrently from softirq context without
> > > holding the FIB table lock. A typical path is:
> > > 
> > >    ndisc_router_discovery()
> > >      spin_unlock_bh(&table->tb6_lock)        <- lock released
> > >      fib6_metric_set(rt, RTAX_HOPLIMIT, ...) <- lockless call
> > > 
> > > When two CPUs process Router Advertisement packets for the same router
> > > simultaneously, they can both arrive at fib6_metric_set() with the same
> > > fib6_info pointer whose fib6_metrics still points to dst_default_metrics.
> > > 
> > >    if (f6i->fib6_metrics == &dst_default_metrics) {   /* both CPUs: true */
> > >        struct dst_metrics *p = kzalloc_obj(*p, GFP_ATOMIC);
> > >        refcount_set(&p->refcnt, 1);
> > >        f6i->fib6_metrics = p;   /* CPU1 overwrites CPU0's p -> p0 leaked */
> > >    }
> > > 
> > > The dst_metrics allocated by the losing CPU has refcnt=1 but no pointer
> > > to it anywhere in memory, producing a kmemleak report:
> > > 
> > >    unreferenced object 0xff1100025aca1400 (size 96):
> > >      comm "softirq", pid 0, jiffies 4299271239
> > >      backtrace:
> > >        kmalloc_trace+0x28a/0x380
> > >        fib6_metric_set+0xcd/0x180
> > >        ndisc_router_discovery+0x12dc/0x24b0
> > >        icmpv6_rcv+0xc16/0x1360
> > > 
> > > Fix this by replacing the plain pointer store with cmpxchg() and free
> > > the allocation safely when competition failed.
> > > 
> > > Fixes: d4ead6b34b67 ("net/ipv6: move metrics from dst to rt6_info")
> > > Reported-by: Fei Liu <feliu@redhat.com>
> > > Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> > > ---
> > >   net/ipv6/ip6_fib.c | 6 ++++--
> > >   1 file changed, 4 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
> > > index dd26657b6a4a..64de761f40d5 100644
> > > --- a/net/ipv6/ip6_fib.c
> > > +++ b/net/ipv6/ip6_fib.c
> > > @@ -730,14 +730,16 @@ void fib6_metric_set(struct fib6_info *f6i, int metric, u32 val)
> > >   	if (!f6i)
> > >   		return;
> > > -	if (f6i->fib6_metrics == &dst_default_metrics) {
> > > +	if (READ_ONCE(f6i->fib6_metrics) == &dst_default_metrics) {
> > > +		struct dst_metrics *dflt = (struct dst_metrics *)&dst_default_metrics;
> > >   		struct dst_metrics *p = kzalloc_obj(*p, GFP_ATOMIC);
> > >   		if (!p)
> > >   			return;
> > >   		refcount_set(&p->refcnt, 1);
> > > -		f6i->fib6_metrics = p;
> > > +		if (cmpxchg(&f6i->fib6_metrics, dflt, p) != dflt)
> > > +			kfree(p);
> > >   	}
> > 
> > 
> > [...]
> > 
> > >   	f6i->fib6_metrics->metrics[metric - 1] = val;
> > 
> > Suggest using marked accessors to suppress KCSAN warnings:
> > 
> > struct dst_metrics *m = READ_ONCE(f6i->fib6_metrics);
> > WRITE_ONCE(m->metrics[metric - 1], val);
> 
> Thanks, I will update this in next version.

BTW, do we really need to WRITE_ONCE here? What if the `val` are different
on 2 CPUs? This would hide the problem, right?

Thanks
Hangbin

