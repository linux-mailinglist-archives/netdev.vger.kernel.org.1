Return-Path: <netdev+bounces-167793-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E688DA3C54E
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 17:43:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4872717859B
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 16:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 675CE20D4E5;
	Wed, 19 Feb 2025 16:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ozypuuk2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oHs03R2q"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D247820CCFF
	for <netdev@vger.kernel.org>; Wed, 19 Feb 2025 16:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739983323; cv=none; b=NXlesTs3qCKBg1qISxfRu1QaTj9ae/R0T7Qrp7ibfKrjsAGvztP7+WOHYrEexo4avrjK1WDuYcsn5GT4XihNocCUzVrAamcNBPAyJy/RXfO5Nz3BEz3GscIhMFmRW4uZ75FetMo1UaL2oJm3ygVBJuZjlFb6GHjGffsl1/hTlI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739983323; c=relaxed/simple;
	bh=3WE9c28nTenyOY01h4FVikYtEGe8vofatjLwnE1E6n8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IvkM/tR2X7hfX+lt549yTnoaU+W5b9RGIbGOrAYi14S8Ha40xPhUl7JK/umq+jvUDICTHvjQSM0B8cSGDzkt+e90sB5AW7DM1nXBRoHu/mRox72QjRGPd0/KywP7md7Ye8VaNOXVn+SGuyAiXxUCNHPT0JZtzfCWDsqc3Ds0hiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ozypuuk2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oHs03R2q; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 19 Feb 2025 17:41:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739983320;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xURdQvOTBYw1m16Ux5gg7ydKENxtpgSZTp0XlJmrw5c=;
	b=Ozypuuk2Evj9/td5deWq4K7fnOM5aAQh2VMN8veuAZk22WThT+CmEooMOreCNL0Y9pYFNJ
	YlDWz49SSsDl5NhbqJwA8TEs0qqR1l6+6wQZ4/Hb8b8MH5+XOazHckPaBoZYzD3YaewxSU
	vytynPJp2aBIImBCiF0u5rIgrxnzw9iJhDaBDf8bWPJHcksFqxRxINctjuxUm9vwfYdGkB
	tWKzB2GwriMzuXkJBhI5cXNh2VQnXy3N8LXe1sFPI16a2D1DQVYjTB7jn96UcuBVpgnzPF
	W4mvQd6ySikDhvMytEBBwA1o7bTLXHOYuYrWs2OjDJBQrlWPVYhyizari3lwNA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739983320;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xURdQvOTBYw1m16Ux5gg7ydKENxtpgSZTp0XlJmrw5c=;
	b=oHs03R2qrVrFNPrlpYwTwhwZgQ34Iyfrj4mpb01qeuKBPQ5OcGoVjCmwhQlzQOdOm5k3Ei
	CPsdL2FcMC6A9bAg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Wander Lairson Costa <wander@redhat.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
	andrew+netdev@lunn.ch, netdev@vger.kernel.org, clrkwllms@kernel.org,
	jgarzik@redhat.com, yuma@redhat.com, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH net 0/4][pull request] igb: fix igb_msix_other() handling
 for PREEMPT_RT
Message-ID: <20250219164158.qYsR4V25@linutronix.de>
References: <20250204175243.810189-1-anthony.l.nguyen@intel.com>
 <20250205094818.I-Jl44AK@linutronix.de>
 <mrw3tpwsravsaibkcpptdkko3ff6qtk6w6ernqvjisk4l7owok@q6hmxkzcdkey>
 <20250206115914.VfzGTwD8@linutronix.de>
 <zy3irjybyc32hnow3ckhkfsrtfm5nev44aeovinlkkfc6tyyjv@gcblibp5ng3o>
 <20250212151108.jI8qODdD@linutronix.de>
 <CAAq0SU=aU=xpw0bDwaanFh_-r5tts0QNCtSmoteP3dM8-K6BFA@mail.gmail.com>
 <20250212152925.M7otWPiV@linutronix.de>
 <mtmm2bwn3lrsmsx3evzemzjvaddmzfvnk6g37yr3fmzb77bpyu@ffto5sq7nvfw>
 <20250219102916.78b64ee4@gandalf.local.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250219102916.78b64ee4@gandalf.local.home>

On 2025-02-19 10:29:16 [-0500], Steven Rostedt wrote:
> On Tue, 18 Feb 2025 11:50:55 -0300
> Wander Lairson Costa <wander@redhat.com> wrote:
> 
> >      kworker/0:0-8       [000] b..13  2121.730643: e1000_write_posted_mbx <-e1000_rar_set_vf
> >      kworker/0:0-8       [000] D.Zf2  2121.730645: igbvf_reset_L14: (igbvf_reset+0x62/0x120 [igbvf])
> >      kworker/0:0-8       [000] .N...  2121.730649: igbvf_reset_L16: (igbvf_reset+0x7b/0x120 [igbvf])
> >   irq/63-ens14f0-1112    [000] b..12  2121.730652: igb_msix_other <-irq_thread_fn
> 
> The preempt count is hex, so 'f' means 15. But that that latency field looks corrupted.

It is high but it kind of makes sense. We cap it at 15 so it might be
higher. But then we would have nesting but why? What confuses me a bit
is the Z because this would indicate NMI.
Also the entry after is a N and nothing else. I would expect a
sched_switch right after unlock so there should be no further entry from
kworker which must run at RT priority because it is boosted by
irq/63-ens14f0-1112.

> Thanks,
> 
> -- Steve

Sebastian

