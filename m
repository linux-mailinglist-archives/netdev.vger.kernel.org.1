Return-Path: <netdev+bounces-194637-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CFFFACBAB4
	for <lists+netdev@lfdr.de>; Mon,  2 Jun 2025 20:04:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 125687A745D
	for <lists+netdev@lfdr.de>; Mon,  2 Jun 2025 18:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E330822541F;
	Mon,  2 Jun 2025 18:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lmCdLq/C"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE9E22156F;
	Mon,  2 Jun 2025 18:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748887402; cv=none; b=tTuwfPgTsVEC8PykcwueqjHw8AbmAkrklZUoqNaH4C06TdSeXuByM3Td30o751aritcq+0h+gieDTjJt4QHu3Y+aUaO/eiigQTaFytvNkgKCMQgSgdFNnR5g8a9GGuCTecOXmtLYMsxF3F+U48rvHnu6/RX+RRszdp7A3kLxXwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748887402; c=relaxed/simple;
	bh=A1T/x23jmsV1Y9GSJdCXt8WvIJyk2Ht5Dg+DuQ2FuhI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iOaS5oHORy0dy98DMBFcoMkuB/NJdd6QV0xNU7wl6uWkp/sr9p/5265eHrkVsmWJpAEACT2ea+7YaREFZxek9dG4H+cmkTocx1Mox3bqmfGYk7KMpcMxmeNy0UUPlLw/1sj25IUW1aV0VLhIe3swdMZyKfwmJGMxYMHBO6fYkhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lmCdLq/C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F18AC4CEEB;
	Mon,  2 Jun 2025 18:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748887402;
	bh=A1T/x23jmsV1Y9GSJdCXt8WvIJyk2Ht5Dg+DuQ2FuhI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lmCdLq/C4/8/vFPvziRtbnQOU9e48/EeTHZmXwT4Y4aZ4RnyGxvnzrwuxI34Yczgs
	 39TD+kjC59h3fgbvi34YleTgJIUgjXgCI/QaBSz2xp2HBvmk7v/iMZIv9r809HLJnt
	 HbdU9r2cOPu52seUiYiGOnryIS5XJWBszUTjrRQJgszFFvbLAwLUyfF6VU49K3jO/h
	 sPadwEl5hD4ki9HFE0JEUOUfDx1IwrUsWUr5JOEw85t2/08ewlZEm6TcEVNy4IvMXK
	 iNomHXP8XieXc6KDowd/n6hE13G46+APsUpJIiJ8X9G3WGHyUvPBwi4JHtSS67afpq
	 FF/KargOFtlIw==
Date: Mon, 2 Jun 2025 11:03:18 -0700
From: Kees Cook <kees@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Pranav Tyagi <pranav.tyagi03@gmail.com>, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH] net: randomize layout of struct net_device
Message-ID: <202506021057.3AB03F705@keescook>
References: <20250602135932.464194-1-pranav.tyagi03@gmail.com>
 <053507e4-14dc-48db-9464-f73f98c16b46@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <053507e4-14dc-48db-9464-f73f98c16b46@lunn.ch>

On Mon, Jun 02, 2025 at 04:46:14PM +0200, Andrew Lunn wrote:
> On Mon, Jun 02, 2025 at 07:29:32PM +0530, Pranav Tyagi wrote:
> > Add __randomize_layout to struct net_device to support structure layout
> > randomization if CONFIG_RANDSTRUCT is enabled else the macro expands to
> > do nothing. This enhances kernel protection by making it harder to
> > predict the memory layout of this structure.
> > 
> > Link: https://github.com/KSPP/linux/issues/188

I would note that the TODO item in this Issue is "evaluate struct
net_device".

> A dumb question i hope.
> 
> As you can see from this comment, some time and effort has been put
> into the order of members in this structure so that those which are
> accessed on the TX fast path are in the same cache line, and those on
> the RX fast path are in the same cache line, and RX and TX fast paths
> are in different cache lines, etc.

This is pretty well exactly one of the right questions to ask, and
should be detailed in the commit message. Mainly: a) how do we know it
will not break anything? b) why is net_device a struct that is likely
to be targeted by an attacker?

> Does CONFIG_RANDSTRUCT understand this? It is safe to move members
> around within a cache line. And it is safe to move whole cache lines
> around. But it would be bad if the randomisation moved members between
> cache lines, mixing up RX and TX fast path members, or spreading fast
> path members over more cache lines, etc.

No, it'll move stuff all around. It's very much a security vs
performance trade-off, but the systems being built with it are happy to
take the hit.

Anything that must stay ordered due to invisible assumptions would need
a distinct anonymous array to keep them together.

> Is there documentation somewhere about what __randomize_layout
> actually does? Given you are posting to a networking mailing list, you
> should not assume the developers here are deep into how the compiler
> works, and want to include a link to documentation, so we can see this
> is actually safe to do.

The basic details are in security/Kconfig.hardening in the "choice" following
the CC_HAS_RANDSTRUCT entry.

-- 
Kees Cook

