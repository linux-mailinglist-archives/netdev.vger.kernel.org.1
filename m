Return-Path: <netdev+bounces-276241-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SKq9E/G51WkB9QcAu9opvQ
	(envelope-from <netdev+bounces-276241-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 04:14:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AC5E3B6316
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 04:14:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F268D302A7EA
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 02:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFF7C364043;
	Wed,  8 Apr 2026 02:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qxORY+mO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30E82EBBA9
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 02:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775614441; cv=none; b=ZAd02EPTqgq8Hcv+loR3pFVIOLJqz3dRGIB+mFxHxwb03Nx4swkm6DBTjd1geG1KpCFvvlZZHSGfeAVNJuvw7dTwvHlzYvdaODXfaOz9MHAtaG97SdnvOEZSUD+1nrI6nq+WY0L1hxZ+JQcqxShmbyhySPTt9NZvAypaKKzGKdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775614441; c=relaxed/simple;
	bh=8Z011OZJ/hp4ZK0NtZo+qftk/Cdc4YLBz/EvN2SWVzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Orr5SdsXoUXHRfOcRgvoa8qdsqvAQX+aWi2IajBDPbkbpTLcOjS/ImqcDHuL63ZChLNx27yzx/nFSpqYHG8fe71m79E6Aj5UGmJ1bSRE/H+s3VToZXN43JF5J4HwUn2J4Z/wtnq29x1lm+980fWYo2oafrZrSQ6m2FqgkZ5YznM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qxORY+mO; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ad9a9be502so36377665ad.0
        for <netdev@vger.kernel.org>; Tue, 07 Apr 2026 19:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775614439; x=1776219239; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZrqEsQlhG7wQ3AbqyenJlZ8xpMygE6DJ1GRcxwhPHwo=;
        b=qxORY+mOGXiESi71Z9ZyEBGp4Z9qnVPVYN3mSN3aCbOGm/i4PzLBV3vN9VZEIuR2HP
         Hd9yYDtwNiKuf9bRB6y1SaoZbMEl5HqJLbi4K3oBAoOIbmadScMwb9zL6t3V1cZ+/sL0
         99rkpAOUYd6eRebNc5m51rnXKUBHdc7R3ZPNgmFeTgTC22+G+r7kTdt56eEY6Nmvn4+L
         dpfjX1yOuWx6EgD3PwliOG/Ovpiw/LCthgfn54Cddxs+U90j87E09YJ79mIXrJ2Q2kqi
         nPyJDD83LaNHAFiyW0R5KTeRK7a9BtE/qMyMFl8YyqfSdtngolB1jm/dMH9AGrt0s0BK
         G8Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775614439; x=1776219239;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZrqEsQlhG7wQ3AbqyenJlZ8xpMygE6DJ1GRcxwhPHwo=;
        b=UMTMAoUusrmM/EoMOAZkBoG/NjkXf/+302fIve0vRfkEqPxKTmT9bmK3GEGJVAdwsJ
         E0oH6ZsXj5fmGgIWLok78GPY/nejb9URGz1rP2lTHkBaKt/vK6BXsa3B6dYz0Py8BeFb
         /HkzS+c9FujnvsrcZ/ygttGIwYaxJukKpvANt1Ae+SXsMnRmIM3zSjOOLtM6txnMp+hC
         9PQQVg+civj1M1J4Y4EeH2OBVw3C+CCUGWgpmhAfW3P+a8MMOvQNznJcYe08LW3z31S/
         RwyX4RgnRQm/SUVWTj0LLpX2kUzW68vnJDlweIW0TJjldU1+aQlActmeS1Hcv+iO84xd
         nqiw==
X-Forwarded-Encrypted: i=1; AJvYcCUAFb/sN8sXcOZzqqNdbfn5e2toyJtXGZZc/YcGqB73ObTe9EHpRzDU7GTPjhPT2ruTQh43Ip4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxorkmv/2Pp8ihWvyCy8IxhlsNY3UDswMYGvqUT20fBY+fWqJVq
	kIHGjCbAbypeDE/oFYQSr1EgYeRHAC/Qxe2h4z3zj3gQpXmcOqJdcdLW
X-Gm-Gg: AeBDieuWylFNJb7XXip58oWwCFFU/7Y6kkTYkM+8yuyzD7Ye4sw63zIfL1WUALYU/S+
	os6gbPSglGTBGbwrTVx+A/9eq9Ibp2iGdQJmFXupLSCEzcfpP0bXh5VlKQJITSEpK9XIqD/SXVH
	RMqx7FzH0eNHHV0VLxL5IcXfFQZQzKNyvuAbLtJgznp5iwR7IpEkFISogeMS/GSOpaJ7C3fPoJS
	sX0FJGEtEovqbtZz9rMZIBllvXS/JciXNKd0GlUEPS/5rIWrrj54qKWUzjakSGkmF7tKXL9JbAk
	PoGMsNIq2lQeCyFkPMpwu5/Dl6haZwHdDdM4/sfSw/xB0R6TRWOk80vBYyuhI+yeABSpMgMFCyE
	GssjRWLga86UIA8BZN2M49NyNlUHAvOyQls8KMC/I5DJwdFIDAF9l3GZ07d3D4TwVSmH0oItB5A
	aVXgAgEbQ2xR0949Ejii3IcKvagkc=
X-Received: by 2002:a17:903:1aa8:b0:2ae:66c9:494f with SMTP id d9443c01a7336-2b281706b99mr205153615ad.2.1775614439038;
        Tue, 07 Apr 2026 19:13:59 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2749a475fsm179219925ad.61.2026.04.07.19.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 19:13:58 -0700 (PDT)
Date: Wed, 8 Apr 2026 02:13:51 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jiayuan Chen <jiayuan.chen@linux.dev>
Subject: Re: [PATCH net] ipv6: add READ_ONCE() annotations to fib6_metrics
 reader paths
Message-ID: <adW539MBrLjt6Pl9@fedora>
References: <20260403-fib6_metric_read_once-v1-1-45de44912b24@gmail.com>
 <bc004773-aead-4431-95fc-860490773c49@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc004773-aead-4431-95fc-860490773c49@redhat.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-276241-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,google.com,gmail.com,vger.kernel.org,linux.dev];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[liuhangbin@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0AC5E3B6316
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 07, 2026 at 12:27:30PM +0200, Paolo Abeni wrote:
> On 4/3/26 6:16 AM, Hangbin Liu wrote:
> > diff --git a/include/net/ip6_fib.h b/include/net/ip6_fib.h
> > index 9f8b6814a96a..2dfb04fab5da 100644
> > --- a/include/net/ip6_fib.h
> > +++ b/include/net/ip6_fib.h
> > @@ -594,7 +594,9 @@ void fib6_update_sernum_stub(struct net *net, struct fib6_info *f6i);
> >  void fib6_metric_set(struct fib6_info *f6i, int metric, u32 val);
> >  static inline bool fib6_metric_locked(struct fib6_info *f6i, int metric)
> >  {
> > -	return !!(f6i->fib6_metrics->metrics[RTAX_LOCK - 1] & (1 << metric));
> > +	struct dst_metrics *m = READ_ONCE(f6i->fib6_metrics);
> > +
> > +	return !!(m->metrics[RTAX_LOCK - 1] & (1 << metric));
> 
> Sashiko notes that here you may want to add an additional READ_ONCE() on
> m->metrics[RTAX_LOCK - 1], which in turn looks like more a
> follow-up/separate change than a change specific to this patch

OK, I will drop this change in the patch.

> 
> >  }
> >  void fib6_info_hw_flags_set(struct net *net, struct fib6_info *f6i,
> >  			    bool offload, bool trap, bool offload_failed);
> > diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
> > index dd26657b6a4a..3c96580c2a03 100644
> > --- a/net/ipv6/ip6_fib.c
> > +++ b/net/ipv6/ip6_fib.c
> > @@ -1144,9 +1144,11 @@ static int fib6_add_rt2node(struct fib6_node *fn, struct fib6_info *rt,
> >  					iter->fib6_flags &= ~RTF_PREFIX_RT;
> >  				}
> >  
> > -				if (rt->fib6_pmtu)
> > +				u32 pmtu = READ_ONCE(rt->fib6_pmtu);
> 
> Here the READ_ONCE() on rt->metrics is still missing.

Which rt->metrics do you mean? I can't find it..


> 
> > @@ -1635,11 +1635,12 @@ __rt6_find_exception_rcu(struct rt6_exception_bucket **bucket,
> >  static unsigned int fib6_mtu(const struct fib6_result *res)
> >  {
> >  	const struct fib6_nh *nh = res->nh;
> > +	struct dst_metrics *m;
> >  	unsigned int mtu;
> >  
> > -	if (res->f6i->fib6_pmtu) {
> > -		mtu = res->f6i->fib6_pmtu;
> > -	} else {
> > +	m = READ_ONCE(res->f6i->fib6_metrics);
> > +	mtu = READ_ONCE(m->metrics[RTAX_MTU - 1]);

This is already a fib6_mtu() function.
> 
> After this patch there will be a single usage of the `fib6_pmtu` macro.
> I think it would be better to entirely drop it and replace with an helper:
> 
> static inline unsigned int fib6_mtu(const struct fib6_info *f6i)
> {
> 	const struct dst_metrics *m = READ_ONCE(f6i->fib6_metrics);
> 	return READ_ONCE(m->metrics[RTAX_MTU - 1]);
> }
> 

Should we rename the helper? e.g. get_fib6_mtu ?

Hangbin

