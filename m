Return-Path: <netdev+bounces-183399-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0029A9094F
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 18:47:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3ED975A3A19
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 16:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A0CF215F7D;
	Wed, 16 Apr 2025 16:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VPzxV/07";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hxRXYTd0"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D874B21ABC8
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 16:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744821915; cv=none; b=SKPoVkxxYRxpZsXYnVQGIfMj8WmUleYFofvZKaIbVoJjYF9nz/D6gcp9dcmfmmtd4t3oT9D++QUfuS296uACtVDzMn8bwmAbL5t3CGkL374OQOyFzYW8L5D7QDIefgqBsdsvcJ2uVcYMrVSVtREOUI4CjZzmz7PrGDiljLrsy8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744821915; c=relaxed/simple;
	bh=Wmgzh6V9aEN5MoM8rG729i1Aed+tdUjUzpemSxZ3c64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=guLwKEKhNWBQHWu7kuTSVGj809vkBkWdrq1z9HGsoNvQtlDzt9XPF0Id9dZcw6R/Q+vhcSLehhpErbDnGJZFyt+yaxIQOEjPg2Aj+gq2pQcnkAYmnpPxpENL8cYAcJvmT9lgwT67Ecsfh+T5b+JbdhUaLtGZQzTQ3z8xL5JH9yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VPzxV/07; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hxRXYTd0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 16 Apr 2025 18:45:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744821911;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mbwdgzKrST60cbCIoCy8g7wioTLdrdLgtt0x5jivJNE=;
	b=VPzxV/07ztnNT6YRhE3/URlyBmsWGd+X5mvBVbAmySKk4S8wSkxxJZkpNzi9P11bt/+FlR
	Lu6PFrkZtivvVv+L8wO3uuwxnt1xiWilUF2o/y5+zCbmPZkzTqpYdbjkHZmu250ceWHFZs
	rUXzZkaBKacAXuEbM+KGrMwni1vXDmJwK5HatLhwKm5eBCKXUxepa1xnPtIpdLIZZwCui0
	Y1QoFqfrH95fatFdDv79kGTlxlI+WBt5wQMrWHpOIYrlEKZKtTZtqJdUQax3zO5lDK6b1M
	CgsjEdK5gFIbwvTllAXjWMJnXKb51gdZAm7CY2mYW4oTcItacSeGsX8srMYqjQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744821911;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mbwdgzKrST60cbCIoCy8g7wioTLdrdLgtt0x5jivJNE=;
	b=hxRXYTd0oKfgCc8bzuP/mBUMAraiGrP2kkEafJJ+CL6g1BPtqkFY7HUPAQPG6zyoO8YeVO
	Ts88F70AA2t53GDA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Aaron Conole <aconole@redhat.com>
Cc: netdev@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Eelco Chaudron <echaudro@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>, dev@openvswitch.org
Subject: Re: [PATCH net-next v2 12/18] openvswitch: Move
 ovs_frag_data_storage into the struct ovs_pcpu_storage
Message-ID: <20250416164509.FOo_r2m1@linutronix.de>
References: <20250414160754.503321-1-bigeasy@linutronix.de>
 <20250414160754.503321-13-bigeasy@linutronix.de>
 <f7tbjsxfl22.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f7tbjsxfl22.fsf@redhat.com>

On 2025-04-15 12:26:13 [-0400], Aaron Conole wrote:
> I'm going to reply here, but I need to bisect a bit more (though I
> suspect the results below are due to 11/18).  When I tested with this
> patch there were lots of "unexplained" latency spikes during processing
> (note, I'm not doing PREEMPT_RT in my testing, but I guess it would
> smooth the spikes out at the cost of max performance).
> 
> With the series:
> [SUM]   0.00-300.00 sec  3.28 TBytes  96.1 Gbits/sec  9417             sender
> [SUM]   0.00-300.00 sec  3.28 TBytes  96.1 Gbits/sec                  receiver
> 
> Without the series:
> [SUM]   0.00-300.00 sec  3.26 TBytes  95.5 Gbits/sec  149             sender
> [SUM]   0.00-300.00 sec  3.26 TBytes  95.5 Gbits/sec                  receiver
> 
> And while the 'final' numbers might look acceptable, one thing I'll note
> is I saw multiple stalls as:
> 
> [  5]  57.00-58.00  sec   128 KBytes   903 Kbits/sec    0   4.02 MBytes
> 
> But without the patch, I didn't see such stalls.  My testing:
> 
> 1. Install openvswitch userspace and ipcalc
> 2. start userspace.
> 3. Setup two netns and connect them (I have a more complicated script to
>    set up the flows, and I can send that to you)
> 4. Use iperf3 to test (-P5 -t 300)
> 
> As I wrote I suspect the locking in 11 is leading to these stalls, as
> the data I'm sending shouldn't be hitting the frag path.
> 
> Do these results seem expected to you?

You have slightly better throughput but way more retries. I wouldn't
expect that. And then the stall.

Patch 10 & 12 move per-CPU variables around and makes them "static"
rather than allocating them at module init time. I would not expect this
to have a negative impact.
Patch #11 assigns the current thread to a variable and clears it again.
The remaining lockdep code disappears. The whole thing runs with BH
disabled so no preemption.

I can't explain what you observe here. Unless it is a random glitch
please send the script and I try to take a look.

Sebastian

