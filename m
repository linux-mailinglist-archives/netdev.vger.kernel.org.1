Return-Path: <netdev+bounces-282155-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Vv/uBIBR8Wm7fwEAu9opvQ
	(envelope-from <netdev+bounces-282155-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 02:32:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 49FB448DC2D
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 02:31:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 768953024A48
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 00:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9BA338DF9;
	Wed, 29 Apr 2026 00:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QZTLccq1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8721640DFDE;
	Wed, 29 Apr 2026 00:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777422716; cv=none; b=BK0kDpxfAk0juQObb4pZTcXKApiSBgvLhX4EsebnkwQK9PFf4HflMXuJr/lEvdoljrjMppOYjtGmCJSg/hbYZUmP6/BHezNH8vmApBGSXbv6yAYipEBceOIMLn0Nu/jGxMU2/CjGz69hDPga8ARolsqJ6lc0JSTzLt2pmsb5yuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777422716; c=relaxed/simple;
	bh=5cwocb0fy34F3UPSlPfYA0SYAJqzs7LuAxA+luBHnQw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o8Mgiyvis6JE/hI6wNuCcenMnjVBJT1kx3DqHFp4wEgar+OZBr0A4xT5HcjWNArAiUDuzhz1dAtp2SNAP7/LpVpLXo2akuwWu6g87DUn0j8IIbcFDhN+rOWgL4Df2hyIgAyzbhpFOQ14W5h4Ui99SLibU48fWVDmNuz4wyZ8JFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QZTLccq1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 849F9C2BCAF;
	Wed, 29 Apr 2026 00:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777422716;
	bh=5cwocb0fy34F3UPSlPfYA0SYAJqzs7LuAxA+luBHnQw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QZTLccq1EIFjtt/9EnlBB/Rv9e3F6p8wMW2b3fcAxmZQgqKAEYCeFal+fAw2K+XiS
	 K1TBfmva7moM0YVgEx3SUPwiU0Hb91rALuu6EK4qBYLLNgkepjyqCOjPcYINrTgD3Z
	 AboLSgw/wqQYQU+CdZnP539cMBFq5aEHu1H1opbw4usqYjUJOtkZ3zQHIWXmSfP90X
	 6vCqWf+OtmYbLBixf3sMRsb6KUM99ysJpEa/xr1KKNL+pD1WkA+sNX9hvYVV+zyBfK
	 21DWi02IwMY9iIIf8WeYLevNWs0TvvA9FMUULDGcbSFlPhCWptKUt03mOfQQwNa6pA
	 SOtBnegi+r7zw==
Date: Tue, 28 Apr 2026 17:31:54 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Martin Karsten <mkarsten@uwaterloo.ca>
Cc: Dragos Tatulea <dtatulea@nvidia.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>, Gal Pressman <gal@nvidia.com>, Tariq Toukan
 <tariqt@nvidia.com>, Joe Damato <joe@dama.to>, Frederik Deweerdt
 <fdeweerdt@fastly.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH net-next 1/2] net: napi: Fix interrupts permanently
 disabled during busy poll
Message-ID: <20260428173154.7b6864ef@kernel.org>
In-Reply-To: <4c45f423-ea41-4ae8-9cb0-7aca9157d8a4@uwaterloo.ca>
References: <20260428175134.1197036-2-dtatulea@nvidia.com>
	<20260428175134.1197036-3-dtatulea@nvidia.com>
	<20260428164004.1f6902ac@kernel.org>
	<4c45f423-ea41-4ae8-9cb0-7aca9157d8a4@uwaterloo.ca>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 49FB448DC2D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282155-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Tue, 28 Apr 2026 20:04:13 -0400 Martin Karsten wrote:
> On 2026-04-28 19:40, Jakub Kicinski wrote:
> > On Tue, 28 Apr 2026 17:51:30 +0000 Dragos Tatulea wrote:  
> >> Under certain conditions a queue can be left out with interrupts
> >> disabled and with the napi re-scheduling timer permanently stopped.
> >> This behaviour is triggered by the napi busy poll path when
> >> gro-flush-timeout and defer-hard-irq are set. Here's a sequence of
> >> operations:
> >>
> >> 1. Busy poll starts, NAPI_STATE_SCHED is set to avoid rescheduling napi
> >> from the timer.
> >>
> >> 2. During napi poll, driver disables interrupts due to being in poll
> >> mode (napi_complete_done() returns false because napi->state has
> >> NAPIF_STATE_IN_BUSY_POLL set).  
> > 
> > Why does the driver have IRQs disabled in busy poll?  
> 
> The problems occurs in irq deferral mode when both gro-flush-timeout and 
> defer-hard-irqs are nonzero and NIC interrupts are disabled.

Okay.

> >> 3. At the end of the busy poll (busy_poll_stop()):
> >>    3.1 napi timer is scheduled and skip_schedule is set (due to config)
> >>    3.2 napi->poll() is called:
> >>      - driver poll() processes exactly budget packets
> >>        and exits early => napi not scheduled.
> >>        (interrupts are still disabled at this point)
> >>    3.3 Since napi poll processed budget packets, __busy_poll_stop()
> >>      is called with skip_schedule set => napi is not scheduled here
> >>      either.  
> > 
> > with skip_schedule it calls:
> > 
> > 	clear_bit(NAPI_STATE_SCHED, &napi->state);
> >   
> >> 4. If the napi timer from 3.1 gets to be triggered due to slow napi poll
> >> or some other reason, the timer will run with no effect (due to
> >> NAPI_STATE_SCHED being set).  
> > 
> > And here you claim STATE_SCHED is still set?  
> 
> Labelling this with number 4. might be misleading, sorry! The concern is 
> that a short enough timer (compared to the duration of the driver poll) 
> can be triggered before the NAPI_STATE_SCHED bit is cleared at the end 
> of Step 3.3.

Ah. Just say that :D Two pages of buggy text, y'all would have been
better off using this one paragraph as the commit message.
Please don't use AI for generating commit messages if that's the cause.
It really is spectacularly shit at it.

