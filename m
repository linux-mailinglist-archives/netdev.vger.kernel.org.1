Return-Path: <netdev+bounces-117038-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A85594C743
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 01:15:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A59FA2883B8
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 23:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 110FE15ECC3;
	Thu,  8 Aug 2024 23:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pappasbrent.com header.i=@pappasbrent.com header.b="SLWAQcFw"
X-Original-To: netdev@vger.kernel.org
Received: from h7.fbrelay.privateemail.com (h7.fbrelay.privateemail.com [162.0.218.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B3B15CD42;
	Thu,  8 Aug 2024 23:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.0.218.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723158908; cv=none; b=dcNpr1RdA04k8NJXiE9+/URNKQ7HH5nvo1qh7cZ22FXRQAdzPv0hM9yPU97lC/84Z8zk9MNM+xyGfMpzVwD+lYoKEJ34ppMVGdbbDiuA4nkMr4xc4C4UyZUAHhCFVQKLeF8+wm+CNLqF6GTcxPV9VJJFmDCsox6YkB8f3ID1JUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723158908; c=relaxed/simple;
	bh=Rxcemb5AM9icEFOPV8G026DZTivKZkLwihXXrq2Vv0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GOl9shFcBNIUk8CGKpNtSMElnhIz8+/VBn/ig8eWlRq4QQQLQDnCztPwSRLkbsS/cuZ8CIyvYs2Ce3/MmHWc9V5nflqJar/vdPpKoe1Pjif2SIEszjkwqQ5h4hyeoDNJLKdf+yAvWJsRWq05bOrceSz497xQJ0EI81gDQ4fEQ6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pappasbrent.com; spf=pass smtp.mailfrom=pappasbrent.com; dkim=pass (2048-bit key) header.d=pappasbrent.com header.i=@pappasbrent.com header.b=SLWAQcFw; arc=none smtp.client-ip=162.0.218.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pappasbrent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pappasbrent.com
Received: from MTA-09-4.privateemail.com (mta-09.privateemail.com [198.54.127.58])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by h7.fbrelay.privateemail.com (Postfix) with ESMTPSA id F2692604EB;
	Thu,  8 Aug 2024 19:15:02 -0400 (EDT)
Received: from mta-09.privateemail.com (localhost [127.0.0.1])
	by mta-09.privateemail.com (Postfix) with ESMTP id 9102A18000BB;
	Thu,  8 Aug 2024 19:14:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=pappasbrent.com;
	s=default; t=1723158894;
	bh=Rxcemb5AM9icEFOPV8G026DZTivKZkLwihXXrq2Vv0o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SLWAQcFwgBg/JAuWcCYZSK1/SY7USZP4B6xU60BzkzYLVxqplXrzyRnfVltiGJZiQ
	 CBd5ZNy+f12BQMnO6UdnkhdO6oInNyxoXiitwJ1+CsPW79/qhoVz3FsaJ6J/mieGft
	 VblyurbOjDmVCO2RLjcOAmJOT0n+NmKZDMjH4uYFnOC5DPZUA7uIIDWdIRMy2ofOvN
	 YsjnqbVQgP5bVKBg7rz73CaHvRyLzqkILhY8PkzA3b8nGgomf+4sGUQ8l9NIvc/ABo
	 nPiYE+cu2H9lfatb82uqEf1CeQ+JojeToK9IkA/kUevFj9ukVyPHwRDw9nDeixcd8X
	 HsO9zy+lUB3nQ==
Received: from pappasbrent.com (syn-050-088-208-203.res.spectrum.com [50.88.208.203])
	by mta-09.privateemail.com (Postfix) with ESMTPA;
	Thu,  8 Aug 2024 19:14:45 -0400 (EDT)
Date: Thu, 8 Aug 2024 19:14:42 -0400
From: Brent Pappas <bpappas@pappasbrent.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
	kuba@kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, pabeni@redhat.com
Subject: Re: [PATCH] ipv6: mcast: Add __must_hold() annotations.
Message-ID: <ZrVRYiA8Nk3c/7lp@pappasbrent.com>
References: <20240808190256.149602-1-bpappas@pappasbrent.com>
 <20240808202347.32112-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240808202347.32112-1-kuniyu@amazon.com>
X-Virus-Scanned: ClamAV using ClamSMTP

The 08/08/2024 13:23, Kuniyuki Iwashima wrote:
> From: Brent Pappas <bpappas@pappasbrent.com>
> Date: Thu,  8 Aug 2024 15:02:55 -0400
> > Add __must_hold(RCU) annotations to igmp6_mc_get_first(),
> > igmp6_mc_get_next(), and igmp6_mc_get_idx() to signify that they are
> > meant to be called in RCU critical sections.
> > 
> > Signed-off-by: Brent Pappas <bpappas@pappasbrent.com>
> > ---
> >  net/ipv6/mcast.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> > 
> > diff --git a/net/ipv6/mcast.c b/net/ipv6/mcast.c
> > index 7ba01d8cfbae..843d0d065242 100644
> > --- a/net/ipv6/mcast.c
> > +++ b/net/ipv6/mcast.c
> > @@ -22,6 +22,7 @@
> >   *		- MLDv2 support
> >   */
> >  
> > +#include "linux/compiler_types.h"
> Why "" ?

That was an accident; my language server (clangd) inserted the include
for me while I was typing and included the header with quotes instead of
angle brackets. I will submit a corrected patch if that will make this
change acceptable.

> Btw, I think for_each_netdev_rcu() / rcu_dereference() in touched
> functions are enough to cleary annotate RCU is needed there.

I see your point. I noticed that igmp6_mc_seq_start() calls
rcu_read_lock() and is annotated with __acquires(), and
igmp6_mc_seq_stop() calls rcu_read_unlock() and is annotated with
__releases(), so it seemed to me that the extra __must_hold()
annotations would be preferable. Unless there's a reason to prefer
__acquires() and __releases() over __must_hold()?

> Even without it, I prefer rcu_read_lock_held(), I'm not sure to
> what extent sparse can analyse functions statically though.

AFAIK, Sparse only uses these annotations to check for context
imbalances, and does not check, e.g., whether macros that access shared
values such as rcu_dereference() are only invoked in critical sections.
Full disclosure, I am working on a static analysis tool called Macroni
to provide more static checks for RCU (this is how I found these
unannotated functions).

> >  #include <linux/module.h>
> >  #include <linux/errno.h>
> >  #include <linux/types.h>
> > @@ -2861,6 +2862,7 @@ struct igmp6_mc_iter_state {
> >  #define igmp6_mc_seq_private(seq)	((struct igmp6_mc_iter_state *)(seq)->private)
> >  
> >  static inline struct ifmcaddr6 *igmp6_mc_get_first(struct seq_file *seq)
> > +	__must_hold(RCU)
> >  {
> >  	struct ifmcaddr6 *im = NULL;
> >  	struct igmp6_mc_iter_state *state = igmp6_mc_seq_private(seq);
> > @@ -2882,7 +2884,9 @@ static inline struct ifmcaddr6 *igmp6_mc_get_first(struct seq_file *seq)
> >  	return im;
> >  }
> >  
> > -static struct ifmcaddr6 *igmp6_mc_get_next(struct seq_file *seq, struct ifmcaddr6 *im)
> > +static struct ifmcaddr6 *igmp6_mc_get_next(struct seq_file *seq,
> > +					   struct ifmcaddr6 *im)
> > +	__must_hold(RCU)
> >  {
> >  	struct igmp6_mc_iter_state *state = igmp6_mc_seq_private(seq);
> >  
> > @@ -2902,6 +2906,7 @@ static struct ifmcaddr6 *igmp6_mc_get_next(struct seq_file *seq, struct ifmcaddr
> >  }
> >  
> >  static struct ifmcaddr6 *igmp6_mc_get_idx(struct seq_file *seq, loff_t pos)
> > +	__must_hold(RCU)
> >  {
> >  	struct ifmcaddr6 *im = igmp6_mc_get_first(seq);
> >  	if (im)
> > -- 
> > 2.46.0

