Return-Path: <netdev+bounces-271874-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QH9tAODVxGnk4AQAu9opvQ
	(envelope-from <netdev+bounces-271874-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 07:44:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CE5D330040
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 07:44:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1ED3E30182A4
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 06:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F50933F8A4;
	Thu, 26 Mar 2026 06:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NB605RFX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037F333B6DF
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 06:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774507485; cv=none; b=Vp00+Lit+/CHUkvoVZPrQ6ePHysGEtfGvqyrsM4mdeb98m21Ot1P9kVEPy9KPf1+gX0jC7UStA1uqPRqZySOjA98bY/IUXSg8XfGLkKyeUL62ycJ0Q5kPqRNgz66CTGVUO7+0HAk/wBKrb3N4qc4FLL9KVdt1SQ0zvtfmJ1x52g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774507485; c=relaxed/simple;
	bh=cTFI/56JUcZ4cAuGpP4kp7NT5vjWSU3X2nCvauI43PU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O9j4/dJ2AQAtjF1QxSqb1DV3KhaNepTHzlu4qAnnjCfI95aV3lvLbQvZ7B7L0FV7c8YJ7fFL6T8+rQnfWfWN54DqkyyZUDWfxEmSIOasNvvuUBBftYVC5BlUbQFhLCh+3laddaq68qWkMYZgJuPn5TagEAoI4vwICsth7HDJ3gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NB605RFX; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2aecefc7503so4397115ad.1
        for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 23:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774507483; x=1775112283; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Kru7vUNhOtyR4Syf0A/Hk+c7YOS1xPH723hYN0xW0QY=;
        b=NB605RFXukQJ2pX/1dBeVvXvFHeRlMajf21/fzZxAbj6B5nhI2Hxm/YG+mFA5Qyu/m
         YjL9bk8E/Sb1x0FRV+8aO3Z8+c0y3W1/QqK/aDEKRppGjwwk6tmWRBIFqTZJSxG71/84
         ZkNGed/xZ+e+TgxOBuk2+qy7rOHSF41y2OP1hmbNlz34TbgBebRqTo/iIJL7taSRr66N
         Zx/bS+4Ei+0CyHHtcjGkSuxBuJoRwf9U3x061VYnkw0uwfhjXGCrJpXw0JCMYV9xOV3G
         fpjwaJ/Jzhkz/JSBin8NeqgKaYJ6V1bNhIpw5F7bxkywRRF4ss+ZHQBuF3jU/VNDL63B
         1BTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774507483; x=1775112283;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kru7vUNhOtyR4Syf0A/Hk+c7YOS1xPH723hYN0xW0QY=;
        b=Xw9okUeHm7EYyl5uf2ej35TYZFUyXbW0sjtVhmCfb0dr5dPZ5ynPK+1eYsuIuC41VN
         pupaLPWAfEEcfpNEXOdDPnxGQDXRbmwktx0U8qOvEsopTDctgrVPn1NT4bk+8wnS8FPp
         hbub50CAT092oOTytv54KV1/YZGLl8mWAr7iJdLav5FgklACvWDKJ1Xw+D1N0UA8AoZ8
         WgUy+pgq9sDHTgCo1mUT+wyu0xwHOhjPACubsBJFobEI/exBgXsTpJAscmkZ7oHRdGCS
         eYT99o9Od1Ith0SsDN2hRtFZfWfagULvPhQMwQkBxJGRXfG816SbWMspbxyhn7eV7OvU
         LDkw==
X-Forwarded-Encrypted: i=1; AJvYcCXP2clhrNMUGkD45/FeMdKsHkocjIUqEOeYihDA1MA1lr1B1LJ38vOiUDWpdptry/+pXSkZ7mU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGNQ/DGSdytcJS/g9aXvUIJqO3RnfcnqkcT8v9hmIpl0/wNISd
	bF+dN1wPDbXN2ji3dQ7Eb44oWfS1ZBKpNl0EUiv3KF32BbfJ8F+AJfEH
X-Gm-Gg: ATEYQzxK0T8f+sZpspoTD6M6xBbJuR8idu5MWmXZWHJ3l0BzBhm15M3IoE+sQrrmqVg
	pTk8+myxP50hstxaNDdSZbo6wb0AdUa4+c1e3ClYVCh64ooE1mFv567pEoCNpg3Aqode/dHPEkO
	qg6v+VhdwcMFzYo/MzE2zxcHyPENvxyQHZXKDZHxe0CsPAEmO/QnElps36uaAyxWLmB7IenAuzi
	tmkKBk1as3x16OVILu2H8ZVhfcUma6y7UJmGwQ+NBeazO8vEY+dw7kxHzE87KQ0+x9CK5xvyMNz
	V+b9WYGCvXBmxTJzSOcb7nlSk0nFdYvzj6wCXl8AopmBQxRD+VNi0T+2xvS6ksuu0gkpurhw7Kx
	H3uYx8pDw+L3fw28mblSOvOcx/h37++OKJH+1jG7Oc5sXIAXRkYIU+KXnmzi1tXAyVddCRw5HCP
	Ai+lVHSk2iQNK3vfpuUdx9RACTtsc=
X-Received: by 2002:a17:902:c40f:b0:2ae:6192:8d78 with SMTP id d9443c01a7336-2b0b0a0eeebmr72113905ad.1.1774507483145;
        Wed, 25 Mar 2026 23:44:43 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0bc912e50sm17798235ad.79.2026.03.25.23.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 23:44:42 -0700 (PDT)
Date: Thu, 26 Mar 2026 06:44:34 +0000
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
Message-ID: <acTV0uiLrGTByBAC@fedora>
References: <20260326-b4-fib6_metric_set-kmemleak-v1-1-c89fc1b312c0@gmail.com>
 <e53a26e9-1120-4486-8b53-5caa8b959a28@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e53a26e9-1120-4486-8b53-5caa8b959a28@linux.dev>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-271874-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,google.com,redhat.com,gmail.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[liuhangbin@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5CE5D330040
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 26, 2026 at 02:23:15PM +0800, Jiayuan Chen wrote:
> 
> On 3/26/26 12:22 PM, Hangbin Liu wrote:
> > fib6_metric_set() may be called concurrently from softirq context without
> > holding the FIB table lock. A typical path is:
> > 
> >    ndisc_router_discovery()
> >      spin_unlock_bh(&table->tb6_lock)        <- lock released
> >      fib6_metric_set(rt, RTAX_HOPLIMIT, ...) <- lockless call
> > 
> > When two CPUs process Router Advertisement packets for the same router
> > simultaneously, they can both arrive at fib6_metric_set() with the same
> > fib6_info pointer whose fib6_metrics still points to dst_default_metrics.
> > 
> >    if (f6i->fib6_metrics == &dst_default_metrics) {   /* both CPUs: true */
> >        struct dst_metrics *p = kzalloc_obj(*p, GFP_ATOMIC);
> >        refcount_set(&p->refcnt, 1);
> >        f6i->fib6_metrics = p;   /* CPU1 overwrites CPU0's p -> p0 leaked */
> >    }
> > 
> > The dst_metrics allocated by the losing CPU has refcnt=1 but no pointer
> > to it anywhere in memory, producing a kmemleak report:
> > 
> >    unreferenced object 0xff1100025aca1400 (size 96):
> >      comm "softirq", pid 0, jiffies 4299271239
> >      backtrace:
> >        kmalloc_trace+0x28a/0x380
> >        fib6_metric_set+0xcd/0x180
> >        ndisc_router_discovery+0x12dc/0x24b0
> >        icmpv6_rcv+0xc16/0x1360
> > 
> > Fix this by replacing the plain pointer store with cmpxchg() and free
> > the allocation safely when competition failed.
> > 
> > Fixes: d4ead6b34b67 ("net/ipv6: move metrics from dst to rt6_info")
> > Reported-by: Fei Liu <feliu@redhat.com>
> > Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> > ---
> >   net/ipv6/ip6_fib.c | 6 ++++--
> >   1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
> > index dd26657b6a4a..64de761f40d5 100644
> > --- a/net/ipv6/ip6_fib.c
> > +++ b/net/ipv6/ip6_fib.c
> > @@ -730,14 +730,16 @@ void fib6_metric_set(struct fib6_info *f6i, int metric, u32 val)
> >   	if (!f6i)
> >   		return;
> > -	if (f6i->fib6_metrics == &dst_default_metrics) {
> > +	if (READ_ONCE(f6i->fib6_metrics) == &dst_default_metrics) {
> > +		struct dst_metrics *dflt = (struct dst_metrics *)&dst_default_metrics;
> >   		struct dst_metrics *p = kzalloc_obj(*p, GFP_ATOMIC);
> >   		if (!p)
> >   			return;
> >   		refcount_set(&p->refcnt, 1);
> > -		f6i->fib6_metrics = p;
> > +		if (cmpxchg(&f6i->fib6_metrics, dflt, p) != dflt)
> > +			kfree(p);
> >   	}
> 
> 
> [...]
> 
> >   	f6i->fib6_metrics->metrics[metric - 1] = val;
> 
> Suggest using marked accessors to suppress KCSAN warnings:
> 
> struct dst_metrics *m = READ_ONCE(f6i->fib6_metrics);
> WRITE_ONCE(m->metrics[metric - 1], val);

Thanks, I will update this in next version.

Hangbin

