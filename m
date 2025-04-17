Return-Path: <netdev+bounces-183709-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A5AA919A3
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 12:47:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB4C619E4218
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 10:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 248C9226D00;
	Thu, 17 Apr 2025 10:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BXYbGfC/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="i3OE926u"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476331DE3C8
	for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 10:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744886861; cv=none; b=VIq0ei6MdT2GGHYlTWxZINqS/L5Ffl8UblrEN0Q3jsKKkLFLV6XZxpRK2Hh7hrrzUhquRHjC3eU/dvkaPKaTFdDuPFkX4K7+0MzY9oTLG39qpG/fB8WphuCBS8bL/HU6aGcs34cNo56wfgSs9e5R9k9NhyueqsKPkbm/JTZDtjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744886861; c=relaxed/simple;
	bh=EXRjzrTP9O8p8sLtyIX1We14XNqb9tDT2QzFmedEDco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tzsTejUCF3PvB7qDgGSEGNwmyFI+3m5+cAlI6PWVpvYZHcEItVRJAas+9/gXsjoc1nSswzAV3mm0F+Ta4UIPKr8jMFWxJSCYeNnLcPR3ft71IuFpVF4Xy/kY6mgEZHU5Z055HVjlCL49pydiZz8Htz2q3P0Kli8w58XjvnN+0yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BXYbGfC/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=i3OE926u; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 17 Apr 2025 12:47:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744886857;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hAst5GKyyBj/mcMHisU1+LM9XPB4UXnzyH9fIQay3kg=;
	b=BXYbGfC/QNMTIFB5tCE/QHDsnnw5LHy21MUT+gr7tA0fcoyiJLOcb8oJKzABRMIUuEdHpV
	2i/3WsISi67t16ixg0Lq5BTtWQvJLNzB4cuhc00nZeMH37AFHnGLGgU48G6OphfZsQkKRG
	XznpTTpYPi+5ki6IpTpZI93HIow7ZHn1KavU2/OfyOT65kwnL3hz0QdvL/KCamoJCg7575
	sRaqFl4m30R5SfrCjOOrEuDNm2ViQgzbW9UO+N26BzbR+70VvVOegmiiT5YuVr6my+wUNH
	vCx46g6Pm0M6qk3/Yr/dmJLbzVcgjeW27Xx/QjvH4WWEpPpdxzxCpAIkMpm5xQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744886857;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hAst5GKyyBj/mcMHisU1+LM9XPB4UXnzyH9fIQay3kg=;
	b=i3OE926uYDDFmuF2HuiGuSYqJUQqKrpPdCtyjeuBjDfdFCPi3GbtFxw8t6W6JCogf6R4JA
	9wJ+iL774hgqrtAw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH net-next v2 13/18] net/sched: act_mirred: Move the
 recursion counter struct netdev_xmit
Message-ID: <20250417104736.pD2sMYXv@linutronix.de>
References: <20250414160754.503321-1-bigeasy@linutronix.de>
 <20250414160754.503321-14-bigeasy@linutronix.de>
 <75e10631-00a3-405a-b4d8-96b422ffbe41@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <75e10631-00a3-405a-b4d8-96b422ffbe41@redhat.com>

+ Ingo/ PeterZ for sched, see below.

On 2025-04-17 10:29:05 [+0200], Paolo Abeni wrote:
> 
> How many of such recursion counters do you foresee will be needed?

I audited the static per-CPU variables and I am done with this series. I
need to go through the dynamic allocations of per-CPU but I don't expect
to see any there.

> AFAICS this one does not fit the existing hole anymore; the binary
> layout before this series is:
> 
>  struct netdev_xmit {
>                 /* typedef u16 -> __u16 */ short unsigned int recursion;
>                 /*  2442     2 */
>                 /* typedef u8 -> __u8 */ unsigned char      more;
>                 /*  2444     1 */
>                 /* typedef u8 -> __u8 */ unsigned char
> skip_txqueue;                /*  2445     1 */
>         } net_xmit; /*  2442     4 */
> 
>         /* XXX 2 bytes hole, try to pack */
> 
> and this series already added 2 u8 fields. Since all the recursion
> counters could be represented with less than 8 bits, perhaps using a
> bitfield here could be worthy?!?

The u8 is nice as the CPU can access in one go. The :4 counting fields
(or so) are usually loaded and shifted so there is a bit more assembly.
We should be able to shorten "recursion" down to an u8 as goes to 8
only.

I still used holes according to pahole on my RT build (the non-RT
shouldn't change):

Before the series:
task_struct:
|         /* XXX 5 bits hole, try to pack */
|         /* Bitfield combined with next fields */
|
|         struct netdev_xmit         net_xmit;             /*  2378     4 */
|
|         /* XXX 2 bytes hole, try to pack */
|
|         long unsigned int          atomic_flags;         /*  2384     8 */

struct netdev_xmit {
|         u16                        recursion;            /*     0     2 */
|         u8                         more;                 /*     2     1 */
|         u8                         skip_txqueue;         /*     3     1 */
|
|         /* size: 4, cachelines: 1, members: 3 */
|         /* last cacheline: 4 bytes */

after the series:
|         unsigned int               in_nf_duplicate:1;    /*  2376:11  4 */
|         /* XXX 4 bits hole, try to pack */
|         /* Bitfield combined with next fields */
| 
|         struct netdev_xmit         net_xmit;             /*  2378     6 */
|         long unsigned int          atomic_flags;         /*  2384     8 */

struct netdev_xmit
|         u16                        recursion;            /*     0     2 */
|         u8                         more;                 /*     2     1 */
|         u8                         skip_txqueue;         /*     3     1 */
|         u8                         nf_dup_skb_recursion; /*     4     1 */
|         u8                         sched_mirred_nest;    /*     5     1 */
| 
|         /* size: 6, cachelines: 1, members: 5 */
|         /* last cacheline: 6 bytes */

I don't understand why in the first case there is a warning about a 2
byte hole while there is a 4 byte hole due to the long alignment.
After the series there is still a 2 byte hole before atomic_flags.

> In any case I think we need explicit ack from the sched people.

I added PeterZ and Ingo.

> > diff --git a/net/sched/act_mirred.c b/net/sched/act_mirred.c
> > index 5b38143659249..5f01f567c934d 100644
> > --- a/net/sched/act_mirred.c
> > +++ b/net/sched/act_mirred.c
> > @@ -30,7 +30,29 @@ static LIST_HEAD(mirred_list);
> >  static DEFINE_SPINLOCK(mirred_list_lock);
> >  
> >  #define MIRRED_NEST_LIMIT    4
> > -static DEFINE_PER_CPU(unsigned int, mirred_nest_level);
> > +
> > +#ifndef CONFIG_PREEMPT_RT
> > +static u8 tcf_mirred_nest_level_inc_return(void)
> > +{
> > +	return __this_cpu_inc_return(softnet_data.xmit.sched_mirred_nest);
> > +}
> > +
> > +static void tcf_mirred_nest_level_dec(void)
> > +{
> > +	__this_cpu_dec(softnet_data.xmit.sched_mirred_nest);
> > +}
> > +
> > +#else
> > +static u8 tcf_mirred_nest_level_inc_return(void)
> > +{
> > +	return current->net_xmit.sched_mirred_nest++;
> > +}
> > +
> > +static void tcf_mirred_nest_level_dec(void)
> > +{
> > +	current->net_xmit.sched_mirred_nest--;
> > +}
> > +#endif
> 
> There are already a few of this construct. Perhaps it would be worthy to
> implement a netdev_xmit() helper returning a ptr to the whole struct and
> use it to reduce the number of #ifdef

While I introduced this in the beginning, Jakub asked if there would be
much difference doing this and I said on x86 at least one opcode because
it replaces "var++" with "get-var, inc-var". I didn't hear back on this
so I assumed "keep it".

If you want the helper, then just say if you want it at the begin of the
series, at the end or independent for evaluation purpose and I make it.

> Thanks,
> 
> Paolo

Sebastian

