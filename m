Return-Path: <netdev+bounces-245828-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D8AC9CD8C55
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 11:21:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CE7543033692
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 10:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC1D35CB96;
	Tue, 23 Dec 2025 10:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="IhFgqHP1"
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4D435CB82;
	Tue, 23 Dec 2025 10:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766484511; cv=none; b=sscjdms8iPZ4id1SbStR7ukBATZy7IUaB1fvpyJ443IMs7YZHj4nN9bTWwkz0NEK+wblpdmCQHyIKBJkbFheai/kNqUN2WdaQzZSnANrtV2McjZVOAvOkLgXAHgpqjueqizub/i7/VhzeLq2n48gJ74auVTDFSYo/QR93PIbwIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766484511; c=relaxed/simple;
	bh=JNGiNAGvu5BeFX13l01Mg+QJwFGQAeRiT43tDf7fHNw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sEQVU7/Jr3Ok67rXIXGiqyOUxa/6LArq7qnguhz4f2VLxv/rmHlE7MphZ5AYAX+hpa5l000XiMST4B+iqLtJxm1Q0bvkl7+DT0DiIoPGBFkcylwGP1zOST6UKq/FKWNjQ4CqIpKwqidqETLJHgLg5K4AmeB0YVlUZA9XuLnX6MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=IhFgqHP1; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=7vz8auM+jcUc2hAYGsMLStFhz1D3Y7UaPxjnMI5s8Xs=; b=IhFgqHP1GUyUXw2e2WppA8sT5A
	E2e/bg8r/zpzLgdXJ9wyP1cEAHajzOcod8xvXX4kZ6Fmj8vv2amU3I+dYWnAdz9o1zrtYr/vL28cI
	cJASb8hag5BtrC2UvUlW4GMBN/iZMopzoegLHOzZpRla6AeO2fllyUfGD01u+4c3v+8CEma/rnw4g
	eCuqkgX9WPlPYAoYnxRbZHQS8sXSjD2a6Jz+fVur63geVM1p8fLMcG7UviiVR5ocdX82H9rAkCRPE
	lJxfFfqOBxrZwz6ZcoWZrSUtY1XusdH34oBCWnOB7QLmfmvYUMYFPhDLPHnczPI96U8Siw1l8eyqK
	caPnpUnA==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1vXywo-006KW7-6n; Tue, 23 Dec 2025 09:44:53 +0000
Date: Tue, 23 Dec 2025 01:44:48 -0800
From: Breno Leitao <leitao@debian.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	asantostc@gmail.com, efault@gmx.de, gustavold@gmail.com, calvin@wbinvd.org, 
	jv@jvosburgh.net, kernel-team@meta.com, Petr Mladek <pmladek@suse.com>, 
	Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH net-next 0/2] net: netconsole: convert to NBCON console
 infrastructure
Message-ID: <zj3ypkmghcvlo44taf6t2vl55bpsozezltl3myytqlhzddvhai@ccncziu5a4f6>
References: <20251222-nbcon-v1-0-65b43c098708@debian.org>
 <b7b10bf1-5294-4515-8d82-31c870525ff7@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7b10bf1-5294-4515-8d82-31c870525ff7@redhat.com>
X-Debian-User: leitao

On Tue, Dec 23, 2025 at 08:12:08AM +0100, Paolo Abeni wrote:
> On 12/22/25 3:52 PM, Breno Leitao wrote:
> > This series adds support for the nbcon (new buffer console) infrastructure
> > to netconsole, enabling lock-free, priority-based console operations that
> > are safer in crash scenarios.
> > 
> > The implementation is introduced in three steps:
> > 
> > 1) Refactor the message fragmentation logic into a reusable helper function
> > 2) Extend nbcon support to non-extended (basic) consoles using the same
> > infrastructure.
> > 
> > The initial discussion about it appeared a while ago in [1], in order to
> > solve Mike's HARDIRQ-safe -> HARDIRQ-unsafe lock order warning, and the root
> > cause is that some hosts were calling IRQ unsafe locks from inside console
> > lock.
> > 
> > At that time, we didn't have the CON_NBCON_ATOMIC_UNSAFE yet. John
> > kindly implemented CON_NBCON_ATOMIC_UNSAFE in 187de7c212e5 ("printk:
> > nbcon: Allow unsafe write_atomic() for panic"), and now we can
> > implement netconsole on top of nbcon.
> > 
> > Important to note that netconsole continues to call netpoll and the
> > network TX helpers with interrupt disable, given the TX are called with
> > target_list_lock.
> > 
> > Link:
> > https://lore.kernel.org/all/b2qps3uywhmjaym4mht2wpxul4yqtuuayeoq4iv4k3zf5wdgh3@tocu6c7mj4lt/
> > [1]
> > 
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> 
> ## Form letter - net-next-closed
> 
> The net-next tree is closed for new drivers, features, code refactoring
> and optimizations due to the merge window and the winter break. We are
> currently accepting bug fixes only.
> 
> Please repost when net-next reopens after Jan 2nd.
> 
> RFC patches sent for review only are obviously welcome at any time.
> ---
> To save me a few moments, I will not send the same messages in reply to
> the others pending  net-next patches of yours, but this still applies :-P

Shame on me! I haven't paid attention to the announcement emails. Fixed
it now.

Sorry for the noise,
--breno

