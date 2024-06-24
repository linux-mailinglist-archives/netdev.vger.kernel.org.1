Return-Path: <netdev+bounces-106047-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5E1F914747
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 12:20:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 560FB1F251F3
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 10:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C6257E59A;
	Mon, 24 Jun 2024 10:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aqpVnVbM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bbCOtxhr"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B68134415;
	Mon, 24 Jun 2024 10:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719224427; cv=none; b=kHUXMNCz5lmm2k/7x3G3Oa2L14PYG9c33EvmekD2z2rOBjl3PosBfO/WMp7QeOoiFuN/GtUn7zibUPuMBuFd2Ypk8veYX3Y4HcuRW9b4bUBDw/vktWyE7+AnbyV0pXu9yyE5g8spLWtZm6SNblX/Jk46VjaVlXzGW+GeoE2Jlfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719224427; c=relaxed/simple;
	bh=49GetJzS1/9DXisEmwEIB+lxlkHR80nPRwzdeujz5/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dzOe95qkMUqT60muRbUrYBsteCOwxK6b8xwNdy3LaIUT2G4cyP78ibi1j0l/u7EwjytccCiSZdgXBlzlDkicZctDTzyxNMreWAvUCcYAZE6hE3p9CuSNMASPkgRLF9PrIb5+ndTrXkNhlZoxtDeplecU1jhNi8201feKf9zVqTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aqpVnVbM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bbCOtxhr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 24 Jun 2024 12:20:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719224420;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5Gb/W/MoapK223ZiKbDY+hfRqUcVWLe2F8ysbzCzywg=;
	b=aqpVnVbMT2FCMErnSL8VEo4Lww2axUso6Rpq8Q5kSsfZOtGe0fDWAVO0mvLFL9Ujj/49qR
	1HiWbx0IpKudpKmt2a5idRv2VKdayGMJv5niQSjcDqKogtAhj1Jq1amBF8lbappTIBmHBI
	5Tp9DT0DRg2ah2xhPFVc19vpO25jGJ74+gUYx1YE6UctyYKdz7q2lYJUuWwHSlHQBoYy4c
	judML0a1fS8VrCszjNtLleG0WCaIiSf0FklBvy5df3e064ZyE9Mh29Av4ZXzbiiLgn2K5G
	CD/T7Rn3/xnzZc0K5iW7beHAqSCpVamtxAzCEPZjlsH82BvXGIY7fxwGeTdoow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719224420;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5Gb/W/MoapK223ZiKbDY+hfRqUcVWLe2F8ysbzCzywg=;
	b=bbCOtxhr4fiyowF7SY+VwHXBM4829IoSDbIT0H93vkkAg3IkNubMPovAkcJjKp4J+LGnhB
	oFn8Gl8OKmpdNQDQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Daniel Bristot de Oliveira <bristot@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eric Dumazet <edumazet@google.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Paolo Abeni <pabeni@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>,
	Ben Segall <bsegall@google.com>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Juri Lelli <juri.lelli@redhat.com>, Mel Gorman <mgorman@suse.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH v9 net-next 08/15] net: softnet_data: Make xmit per task.
Message-ID: <20240624102018.WYAKspD9@linutronix.de>
References: <20240620132727.660738-1-bigeasy@linutronix.de>
 <20240620132727.660738-9-bigeasy@linutronix.de>
 <20240621191245.1016a5d6@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240621191245.1016a5d6@kernel.org>

On 2024-06-21 19:12:45 [-0700], Jakub Kicinski wrote:
> On Thu, 20 Jun 2024 15:21:58 +0200 Sebastian Andrzej Siewior wrote:
> > +static inline void netdev_xmit_set_more(bool more)
> > +{
> > +	current->net_xmit.more = more;
> > +}
> > +
> > +static inline bool netdev_xmit_more(void)
> > +{
> > +	return current->net_xmit.more;
> > +}
> > +#endif
> > +
> > +static inline netdev_tx_t __netdev_start_xmit(const struct net_device_ops *ops,
> > +					      struct sk_buff *skb, struct net_device *dev,
> > +					      bool more)
> > +{
> > +	netdev_xmit_set_more(more);
> > +	return ops->ndo_start_xmit(skb, dev);
> > +}
> 
> The series looks clean, I'm happy for it to be applied as is.
> 
> But I'm curious whether similar helper organization as with the BPF
> code would work. By which I mean - instead of read / write helpers
> for each member can we not have one helper which returns the struct?
> It would be a per-CPU struct on !RT and pointer from current on RT.
> Does it change the generated code? Or stripping the __percpu annotation
> is a PITA?

You are asking for

| #ifndef CONFIG_PREEMPT_RT
| static inline struct netdev_xmit *netdev_get_xmit(void)
| {
|        return this_cpu_ptr(&softnet_data.xmit);
| }
| #else
| static inline int netdev_get_xmit(void)
| {
|        return &current->net_xmit;
| }
| #endif

on one side so that we can have then

| static inline void dev_xmit_recursion_inc(void)
| {
|	netdev_get_xmit()->recursion++;
| }
|
| static inline void dev_xmit_recursion_dec(void)
| {
|	netdev_get_xmit()->recursion--;
| }

This changes the generated code slightly. The inc increases from one to
two opcodes, __dev_direct_xmit() snippet:

|         addl $512, %gs:pcpu_hot+8(%rip) #, *_45
local_bh_disable();
|         incw %gs:softnet_data+120(%rip)         # *_44
dev_xmit_recursion_inc();

|         testb   $16, 185(%rbx)  #, dev_24->features
|         je      .L3310  #,
|         movl    $16, %r13d      #, <retval>
|         testb   $5, 208(%r12)   #, MEM[(const struct netdev_queue *)_54].state
|         je      .L3290  #,
|         movl    $512, %esi      #,
^ part of local_bh_enable();
|         decw %gs:softnet_data+120(%rip)         # *_44
dev_xmit_recursion_dec();

|         lea 0(%rip), %rdi       # __here
|         call    __local_bh_enable_ip    #


With the change mentioned above we get:
|         addl $512, %gs:pcpu_hot+8(%rip) #, *_51
local_bh_disable();

|         movq    %gs:this_cpu_off(%rip), %rax    # *_44, tcp_ptr__
|         addw    $1, softnet_data+120(%rax)      #, _48->recursion
two opcodes for dev_xmit_recursion_inc()

|         testb   $16, 185(%rbx)  #, dev_24->features
|         je      .L3310  #,
|         movl    $16, %r13d      #, <retval>
|         testb   $5, 208(%r12)   #, MEM[(const struct netdev_queue *)_60].state
|         je      .L3290  #,
|         movq    %gs:this_cpu_off(%rip), %rax    # *_44, tcp_ptr__
one opcode from dev_xmit_recursion_dec()

|         movl    $512, %esi      #,
part of local_bh_enable()

|         lea 0(%rip), %rdi       # __here
|         subw    $1, softnet_data+120(%rax)      #, _68->recursion
second opcode from dev_xmit_recursion_dec()

|         call    __local_bh_enable_ip    #

So we end up with one additional opcode per usage and I can't tell how
bad it is. The second invocation (dec) was interleaved so it might use
idle cycles. Instead of one optimized operation we get two and the
pointer can't be cached.

And in case you ask, the task version looks like this:

|         addl $512, %gs:pcpu_hot+8(%rip) #, *_47
local_bh_disable()

|         movq    %gs:const_pcpu_hot(%rip), %r14  # const_pcpu_hot.D.2663.D.2661.current_task, _44
|         movzwl  2426(%r14), %eax        # MEM[(struct netdev_xmit *)_44 + 2426B].recursion, _45
|         leal    1(%rax), %edx   #, tmp140
|         movw    %dx, 2426(%r14) # tmp140, MEM[(struct netdev_xmit *)_44 + 2426B].recursion

four opcodes for the inc.

|         testb   $16, 185(%rbx)  #, dev_24->features
|         je      .L3311  #,
|         movl    $16, %r13d      #, <retval>
|         testb   $5, 208(%r12)   #, MEM[(const struct netdev_queue *)_56].state
|         je      .L3291  #,
|         movw    %ax, 2426(%r14) # _45, MEM[(struct netdev_xmit *)_44 + 2426B].recursion

but then gcc recycles the initial value. It reloads the value and
decrements it in case it calls the function.

|         movl    $512, %esi      #,
|         lea 0(%rip), %rdi       # __here
|         call    __local_bh_enable_ip    #
| 

Any update request?

Sebastian

