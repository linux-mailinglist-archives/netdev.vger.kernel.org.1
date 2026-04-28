Return-Path: <netdev+bounces-282144-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AOtRJ5BJ8WnAfgEAu9opvQ
	(envelope-from <netdev+bounces-282144-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 01:58:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 38A4748DA76
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 01:58:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 310C130C6EEA
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 23:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA8238AC93;
	Tue, 28 Apr 2026 23:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K15CZ1Vb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B45A389DE0;
	Tue, 28 Apr 2026 23:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777419606; cv=none; b=uv6kmOo+01jujOK3+WdY9dEKwv7p2452wHWCRh3Wr54OENDkaDnd3ZsdN2DlMTUrk5cFXVisBT1y49yuiFJxHLteWY0hbJ8XYMRRUELiK0gA/i851ImDkC9GgEihz6Kd1n+m2yH3gxRHGeuFXehqBFzUOXl/sOqUl2I/WMYJmgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777419606; c=relaxed/simple;
	bh=dU5du80avked/bp7Ff2bjphrxLEoRphHD9WiUhR9gjI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tNA4UraYTstbyOIrusuaNUg87ELhlRckRp5y43rio70Wde8OySCVohcwPUz2JEMKK8/nvulsuzpponFyIGWCQuQ3Zd4fGoyHD4ndNI6e/22FSS/2e8S7+IwH64Ms4YT0qTwe9vW5XraVReSk8MyRc9f0P1GVw8EZ+SVsib655a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K15CZ1Vb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38987C2BCAF;
	Tue, 28 Apr 2026 23:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777419605;
	bh=dU5du80avked/bp7Ff2bjphrxLEoRphHD9WiUhR9gjI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=K15CZ1VbQJ18znQN/yt9k9RvIrgCF1cFWyDr326J/KL05U8G/7nHeEokHpFgXWTK3
	 uyej1kKee599o12YGWAc8/FLY7WQJzCxzTBj/uUi2KfYV7t77ns5woRt75UwHtF7JL
	 ebyfWgYyTv8NW3bttLfcXvB6DHzzfax2Ko2awfU3j0A7W0EO3GEXryXdmjTjxBetcE
	 oGEMACnGCtGB51JEoqRtKzwSZ4asCzVy3N7Wc1IWZaPpf5OG+T6bQsqe4Ih1PEOUck
	 AbINsbi4BCV9T7K2SuzbUhS4usPlmTGHk16OmcHmRscOJ4Lv37QV2yhnaDvvi5ejj6
	 O1qtW+kzogM4g==
Date: Tue, 28 Apr 2026 16:40:04 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, Martin Karsten
 <mkarsten@uwaterloo.ca>, Gal Pressman <gal@nvidia.com>, Tariq Toukan
 <tariqt@nvidia.com>, Joe Damato <joe@dama.to>, Frederik Deweerdt
 <fdeweerdt@fastly.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH net-next 1/2] net: napi: Fix interrupts permanently
 disabled during busy poll
Message-ID: <20260428164004.1f6902ac@kernel.org>
In-Reply-To: <20260428175134.1197036-3-dtatulea@nvidia.com>
References: <20260428175134.1197036-2-dtatulea@nvidia.com>
	<20260428175134.1197036-3-dtatulea@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 38A4748DA76
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282144-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Tue, 28 Apr 2026 17:51:30 +0000 Dragos Tatulea wrote:
> Under certain conditions a queue can be left out with interrupts
> disabled and with the napi re-scheduling timer permanently stopped.
> This behaviour is triggered by the napi busy poll path when
> gro-flush-timeout and defer-hard-irq are set. Here's a sequence of
> operations:
> 
> 1. Busy poll starts, NAPI_STATE_SCHED is set to avoid rescheduling napi
> from the timer.
> 
> 2. During napi poll, driver disables interrupts due to being in poll
> mode (napi_complete_done() returns false because napi->state has
> NAPIF_STATE_IN_BUSY_POLL set).

Why does the driver have IRQs disabled in busy poll?

> 3. At the end of the busy poll (busy_poll_stop()):
>   3.1 napi timer is scheduled and skip_schedule is set (due to config)
>   3.2 napi->poll() is called:
>     - driver poll() processes exactly budget packets
>       and exits early => napi not scheduled.
>       (interrupts are still disabled at this point)
>   3.3 Since napi poll processed budget packets, __busy_poll_stop()
>     is called with skip_schedule set => napi is not scheduled here
>     either.

with skip_schedule it calls:

	clear_bit(NAPI_STATE_SCHED, &napi->state);

> 4. If the napi timer from 3.1 gets to be triggered due to slow napi poll
> or some other reason, the timer will run with no effect (due to
> NAPI_STATE_SCHED being set).

And here you claim STATE_SCHED is still set?

