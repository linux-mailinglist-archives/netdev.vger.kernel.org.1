Return-Path: <netdev+bounces-198454-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7A0AADC3D4
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 09:59:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95C7E3B80B5
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 07:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84A3728ECC9;
	Tue, 17 Jun 2025 07:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JFTDnT/k";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="n+tMbvLh"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D85B23D29D
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 07:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750147137; cv=none; b=M+dMganTkJ1XMawymnf089Qrtr85YeeD58UiuJ7apfEQpEZE1xhgU0IdpKJLE50BSJ3ayjxR8a4oFA5Awz/fUvEN9McwySSoR7t0Ez5TAkO2Ajf7SiVhd8MlmK5Du15MYj3Em2QPTY7sqEtw3eYlmBsoY5/Qi/U8C12jnM4cqZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750147137; c=relaxed/simple;
	bh=Woyq8+y5DSKuO8ou4JZKeaxHkdXwTHIBU65O6iZZupg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WoduyaVyTbE9+b7e+QWxkUz1rUqL3DyBEkwJTJrWUmvaBcL+uUptxzqzEXtTFAEhIbQwdXHVukX5x84snoY8zr6VufdMb55x1pKytr9XtoQcwenbaL4/kPwMAeELPZgnn0WvOP1FJl09UMdi/Wl2Jj73PVUq8Y8zfpwLkYkt+C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JFTDnT/k; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=n+tMbvLh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 17 Jun 2025 09:58:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750147134;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DGPo1pzfh03ZK7ZJn7htUGqXw4dGaQkmKEOuaawLXTE=;
	b=JFTDnT/kdY1rlTFmQOycn+5dYGRIzbz36Y0KgoFl/BlTvL/fRsmMy8Aha1f0Fbk7MZM97w
	ekV4FbLaAmktBWVn8N1Vfm44H7haCfIwzTdE9d2F4t6HdwU0y6SX/SuayVZfgUsA2kQXlS
	G7iwWPeygsUoWX9pPcc6N8yeb2ejQgzxQJOZz/8VbyXwPPNeiVmuYpmbV9oEWV0iQblr8R
	0AlyTDvrBgO6FSHEkIzt4TGEHMYpsD6Dvy6N3sp0wri9HuRkVoHLBkZmaQWPhGvhlQx+xv
	fkBxYqYESIJ14GkHNeh9yLgKzqU5kYLsvuubT4AKwbtCxfoXUnVnSpCHw5SpJA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750147134;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DGPo1pzfh03ZK7ZJn7htUGqXw4dGaQkmKEOuaawLXTE=;
	b=n+tMbvLhrsGIptg7IoYjiHCaPgD3TqtK81kLXfLBGHdk+TUbtm9cRFvO33dphww9Zz6RYW
	B6leF40erusDILAw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Gal Pressman <gal@nvidia.com>, netdev@vger.kernel.org,
	dev@openvswitch.org, "David S. Miller" <davem@davemloft.net>,
	Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Ilya Maximets <i.maximets@ovn.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net] openvswitch: Allocate struct ovs_pcpu_storage
 dynamically
Message-ID: <20250617075852._s0WQwZP@linutronix.de>
References: <20250613123629.-XSoQTCu@linutronix.de>
 <20250616150902.330c4ac3@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250616150902.330c4ac3@kernel.org>

On 2025-06-16 15:09:02 [-0700], Jakub Kicinski wrote:
> On Fri, 13 Jun 2025 14:36:29 +0200 Sebastian Andrzej Siewior wrote:
> > PERCPU_MODULE_RESERVE defines the maximum size that can by used for the
> > per-CPU data size used by modules. This is 8KiB.
> > 
> > Commit 035fcdc4d240c ("openvswitch: Merge three per-CPU structures into
> > one") restructured the per-CPU memory allocation for the module and
> > moved the separate alloc_percpu() invocations at module init time to a
> > static per-CPU variable which is allocated by the module loader.
> 
> IIUC you're saying that the module loader only gets 8kB but dynamic
> allocations from the code don't have this restriction?
8KiB is for build time variables such as those defined by
DEFINE_PER_CPU(). The module loader uses __alloc_reserved_percpu() to
access this PERCPU_MODULE_RESERVE) storage.
Regular alloc_percpu() (at module init time or later ) does not have
this restriction.

> Maybe just me but TBH the commit message reads like the inverse :S

I can improve the message but I'm not sure how.

Sebastian

