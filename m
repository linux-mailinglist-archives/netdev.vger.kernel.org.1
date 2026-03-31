Return-Path: <netdev+bounces-273429-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8BgFLnUfy2mdEAYAu9opvQ
	(envelope-from <netdev+bounces-273429-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 03:12:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B88BC362FE4
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 03:12:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 968A930138C7
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 01:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEBB52F6193;
	Tue, 31 Mar 2026 01:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="onh1qYY3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A181A276028
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 01:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774919534; cv=none; b=jbsHur+obqOFNKHZpJ7xguY6xoYnI0sAJky4wJTWW9SZKyPlIUPcBstlIlzy4oG1WTYG9WUc7I0V6Vs8s0tXpEpg9EPZjs6h0D9V5+AFxMEJk958Sv5SOYtIGvUp1RYxpTtmMluOTmcO1XKsF/wJ12kZywvuJ6R5VbG8lCwp3LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774919534; c=relaxed/simple;
	bh=fHmX/2PSBqraUYCCVlw86C6nhif0YECjWQSA8RFYKN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NFG1HVEoushZMWAtutc84AvJ3f4OY+FgDMkbnjjxfVPSMFK8kEc0d8gbrQi7mNXOZFkzkMyLroRPq/i9Tqx9rfD5lDqj2R0jmNhTd9L3NYCeXkjBcQ53/1R7QYPkiNwkszaLR1AcJtgLqIbju/Fa0twex3bA9gThOtU6oHXTisQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=onh1qYY3; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2b2589c26e3so10749505ad.1
        for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 18:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774919533; x=1775524333; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gHya3nDOhvSscb5HxUxMbuiOG1umaeqEh879kAKNIbY=;
        b=onh1qYY3kSRmtV+lHun+gnY0orlwLX0EA5jo4GWf6NkNjC6aZq1m1VVWh8wv6YfBOO
         oAScDkuzB4N6dSKbRfqg7pt5ZoPSioHdoP+W5eJaW4Nv2gXJqtdMdN5jqc1p/ybCWHcV
         65TuQCZaI1eVJSRP3BfoJA8KDHktXmWMNB6uh23h4C4ZCw7anBCQrgXmZ8vfG/xn9cnL
         vha3pIim3q18k8SPnRVp69lcD5ZgpLL22TjzfenOLhucgKn1Oq02C81nbbDFAK9p1WFH
         A3kOVIuY+8XwEKDKoiUcQRYZZ2fmcTN160/dnKexfFlYIfFcJKCuD+1VmqemqGom2pNq
         NSwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774919533; x=1775524333;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gHya3nDOhvSscb5HxUxMbuiOG1umaeqEh879kAKNIbY=;
        b=L5BGr/DLTkyOWnH+u08y3CeOqrf/ncjLvJ/k3dmqiCzWGt95a847bxgCIAj+vfc1Hx
         5a0ubqSBTh78jN7zEv6wOKNnFDRr29pMH0MUkU+NHXnvOerXj4hI/Abjt3GP7L4rTnhC
         iVCXnlC3MBq2b9bf055kIdoJdh0wlQl75MRDk7pd6k2/zba1dMT2s8oHC+HK+uC708rb
         49nRbUThUelaMmXHq8SSEX8N478mjb+UUsrld1AbeP6xyDYwWBN4Gln42E0semfwPytG
         T3gnDctzzZVSFbMUqu8VnkWriVgiYppPF7cleNmVSgXU7nfad04DWoIeewN6IbokWeBv
         VUJg==
X-Forwarded-Encrypted: i=1; AJvYcCVzgBImE+VWdRC/w23YQca8+1/l+7zaL3rAleDIz1zlMxwF0lWegWqIAnqQJOaBf5fufgRlO0I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+qMjdaz5rgsarrYNsQKkDs0A6gSdgu8EvBlpC3va3A8gkp9t6
	+Wipy5fQCFvt9+3x0Suisof0hp8can8SOe1LAQg/Jcw0ZsrATkui+7j+
X-Gm-Gg: ATEYQzx2jTqvoWXVJnUU9omwH1Z9ni4pBmHjn5uemQU+SOAfy6CDHn+FUR3uIO7P9LG
	N1eDjUOxehW+maEpkKiSZsbuuabllzNa3lXnFqqdJ73KWTi77tbNPylglwYbTS3ib641qHtpaSc
	AzyqiZWbHWcEcqEbrpxXqwSBhYpE0s2XaZCY1Va8KipIHrbU3BPaWkabZYYTzR3oiwShKWax7Yv
	0zoodjcEwiCauc8kNxPxHcsBwtS54Xb7y999/AoIiQVsNQZ0ZfMRO0W5luN7gaa945ioCwzmvU5
	AUTQSUxvFoVinM7ernFvJ3ZWGUQWWVH1WuLUT8fGn5zt5Xfjg2FIwDJg4LFfks1OFrsOmYdhfjG
	1dBNBWUWTxFtgM5PF6lYDMdq1mfapMoPr5JJhz0aVp0Zolx1qZ5El4wHrdegIy01Vdvz9TjdEpn
	R3EkCRPV+JzwL0Jm4W75dk9IDFXTQ=
X-Received: by 2002:a17:903:46c6:b0:2b0:66bc:2282 with SMTP id d9443c01a7336-2b0cdc20726mr155720055ad.6.1774919532953;
        Mon, 30 Mar 2026 18:12:12 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b24264256asm93152335ad.13.2026.03.30.18.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 18:12:12 -0700 (PDT)
Date: Tue, 31 Mar 2026 01:12:04 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	David Ahern <dsahern@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Fei Liu <feliu@redhat.com>
Subject: Re: [PATCH net v2] ipv6: fix data race in fib6_metric_set() using
 cmpxchg
Message-ID: <acsfZAktU2O2ODCN@fedora>
References: <20260327-b4-fib6_metric_set-kmemleak-v2-1-366b2c78b5c2@gmail.com>
 <20260330174628.0cb1ebc6@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260330174628.0cb1ebc6@kernel.org>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273429-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,google.com,redhat.com,linux.dev,gmail.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B88BC362FE4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 30, 2026 at 05:46:28PM -0700, Jakub Kicinski wrote:
> On Fri, 27 Mar 2026 10:24:47 +0800 Hangbin Liu wrote:
> > --- a/net/ipv6/ip6_fib.c
> > +++ b/net/ipv6/ip6_fib.c
> > @@ -730,17 +730,24 @@ void fib6_metric_set(struct fib6_info *f6i, int metric, u32 val)
> >  	if (!f6i)
> >  		return;
> >  
> > -	if (f6i->fib6_metrics == &dst_default_metrics) {
> > +	if (READ_ONCE(f6i->fib6_metrics) == &dst_default_metrics) {
> > +		struct dst_metrics *dflt = (struct dst_metrics *)&dst_default_metrics;
> 
> Why does this exist? To cast away the const?

Yes, cause cmpxchg doesn't accept const type.

> 
> >  		struct dst_metrics *p = kzalloc_obj(*p, GFP_ATOMIC);
> >  
> >  		if (!p)
> >  			return;
> >  
> > +		p->metrics[metric - 1] = val;
> >  		refcount_set(&p->refcnt, 1);
> > -		f6i->fib6_metrics = p;
> > +		if (cmpxchg(&f6i->fib6_metrics, dflt, p) != dflt)
> > +			kfree(p);
> > +		else
> > +			return;
> >  	}
> >  
> > -	f6i->fib6_metrics->metrics[metric - 1] = val;
> > +	struct dst_metrics *m = READ_ONCE(f6i->fib6_metrics);
> 
> No variable declarations in the middle of a function please.

Oh, I thought it's OK now since kernel supports C99...

I will fix it.

Thanks
Hangbin

