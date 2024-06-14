Return-Path: <netdev+bounces-103516-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45646908647
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 10:28:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEA971F22693
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 08:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E5A4185087;
	Fri, 14 Jun 2024 08:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="maj2hoIn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5hSzIfF4"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD0B1836DE;
	Fri, 14 Jun 2024 08:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718353692; cv=none; b=OejZWGD9DdEss+AXLITChL0GjZu900Lq1a6KqiWg7WIh4t7oCbHI41b6xG5UqOlAcONz+AHsQoBynOnRV58QdgMVXJqKtXQsOWHAkIxsNvnOBaE3tHpwIHqfAUmsIUVyFAKHPkZQxqnUCaYZllH3Y9o8w2JaaHxyxbt20Trocj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718353692; c=relaxed/simple;
	bh=5y3JIRl5B8fTjGFCjViDuLr0cHXTRA4yiKCDgSZN1NI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VTyGFXPQg+kROBoOQ1+udMpz2cwqlCUSa2JA+CByz4ipeAYfUQtE25VD0EZKb85VaiKJkFEij+6bHyvb9kD9I5uyGM38v2BIZf2pzJQO5/fg67NIrtkv6VdVUlYlHERg6+dmUfK0SLdY0PKCqPvwSBKlBqn21rTR86R6GjU/178=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=maj2hoIn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5hSzIfF4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 14 Jun 2024 10:27:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718353680;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L3nKvveBbIdAVcomoyZQI6KphWn4AlPcGB27/+M6BDk=;
	b=maj2hoIn4ulJag7Dw8dSiyVu8OHipxA/llSTfgfpS2gSsRxF2HK4wjf6a0dqFcF3DyyLdX
	t2XLX1MN9BGC+FtR6rbVv3aSwGFWGcIETjaAAFlT8dBVpuYBDZkfzcxeHZ3gvl7sgiqmim
	IIRoHPnnnyYMJFzrApetR2NjJEhoDQBgVFORMJBGK0IRJmGV6EHpvjAjvBojsrMOZxOGU/
	GoXav+Jg828LyRBoPPNRFoPIOr8MESwr51QtLgR2TShBXdqFg6WPVCKGAOs2nC+1z/xREx
	3mlRoddFN13R6OZqfBw700iBIqKDHoyHRtLhcPvO3tvfm1mLaLjgeLmT30qSqw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718353680;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L3nKvveBbIdAVcomoyZQI6KphWn4AlPcGB27/+M6BDk=;
	b=5hSzIfF4aLTdTYxEaqozQd2jH7+jZXJQfrFiItzikUfs1NXoNEyRIcu4b3IfQdmAIDNa+M
	sSbDkT29lfPLuFDQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Daniel Bristot de Oliveira <bristot@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eric Dumazet <edumazet@google.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>,
	Ben Segall <bsegall@google.com>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Juri Lelli <juri.lelli@redhat.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH v6 net-next 08/15] net: softnet_data: Make xmit.recursion
 per task.
Message-ID: <20240614082758.6pSMV3aq@linutronix.de>
References: <20240612170303.3896084-1-bigeasy@linutronix.de>
 <20240612170303.3896084-9-bigeasy@linutronix.de>
 <20240612131829.2e33ca71@rorschach.local.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240612131829.2e33ca71@rorschach.local.home>

On 2024-06-12 13:18:29 [-0400], Steven Rostedt wrote:
> On Wed, 12 Jun 2024 18:44:34 +0200
> Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> 
> > Softirq is preemptible on PREEMPT_RT. Without a per-CPU lock in
> > local_bh_disable() there is no guarantee that only one device is
> > transmitting at a time.
> > With preemption and multiple senders it is possible that the per-CPU
> > recursion counter gets incremented by different threads and exceeds
> > XMIT_RECURSION_LIMIT leading to a false positive recursion alert.
> > 
> > Instead of adding a lock to protect the per-CPU variable it is simpler
> > to make the counter per-task. Sending and receiving skbs happens always
> > in thread context anyway.
> > 
> > Having a lock to protected the per-CPU counter would block/ serialize two
> > sending threads needlessly. It would also require a recursive lock to
> > ensure that the owner can increment the counter further.
> > 
> > Make the recursion counter a task_struct member on PREEMPT_RT.
> 
> I'm curious to what would be the harm to using a per_task counter
> instead of per_cpu outside of PREEMPT_RT. That way, we wouldn't have to
> have the #ifdef.

There should be a hole on !RT, too so we shouldn't gain weight. The
limit is set to 8 so an u8 would be enough. The counter is only accessed
with BH-disabled so it will be used only in one context since it can't
schedule().

I think it should work fine. netdev folks, you want me to remove that
ifdef and use a per-Task counter unconditionally?

> -- Steve

Sebastian

