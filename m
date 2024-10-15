Return-Path: <netdev+bounces-135380-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 234F699DAA8
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 02:26:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7A7B2810B4
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 00:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2B7A8F77;
	Tue, 15 Oct 2024 00:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C4Itt4d5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFFE191;
	Tue, 15 Oct 2024 00:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728951963; cv=none; b=f50l6KSdr9GrpZppJT0RKG3cAtFoe0e1wC67YVMXK4Se+jZTKm1U9MG0peplYnzhFju6nKaRoVkCjTUdAXUD6+4eX+GeuFJmgnrnBQgWTeko2xqEEgaYLAvd7b3DyuD7KOQc+N/gPNyhENnf2DdwDIClB0RZj56WXOl3uzMMxyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728951963; c=relaxed/simple;
	bh=1irKL8feAdHhHDFB2eddIyClO0Y4Pse8KtbdmmCG3HA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pIqGDTEzyWQYVomtTZzIGZfiT005jZDK5YZs+JAlozTtr9LDirrJe4PLU1ywAwyu662JzESnXDMSv8sHwZrUHl4ZtmZm9+FG36zVhJu6zLnbVWzTJTgM4PWnsFdnaYYeFjRs2B0kcuu1tK279OsS3iIhyrohAfNGdozcZY4JQCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C4Itt4d5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00F05C4CEC3;
	Tue, 15 Oct 2024 00:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728951963;
	bh=1irKL8feAdHhHDFB2eddIyClO0Y4Pse8KtbdmmCG3HA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=C4Itt4d5L7KqM0w3J6RXpsg3lo6dF6jBZaOyZXMQjaUed7m1JLrC3LQHwl/bVyDeD
	 6rYX2+DYleR8wwxg7r1FIGnz4RvIaxBc0QC798/OcxYwo0etj/4ZirbDvTQiAGTtK2
	 1cMOQhttUTGR1b8cr4nwXJ2W1ZwP5bhW17PGaFdof3WxWJP7tv1cnsZOP/0jcCfgsh
	 5W6v9NqXMhyDmrhdbDZblc3UcKjumhqxGtbKXSi4VgdfccJWIXU/Lt4szPpFJf4YEW
	 5EsttwSgRhXlQYMSvBqoiu/Xkfoty3aUdp6/FkKrgBX3w8NyA7cIGWH288HuV6Ki/P
	 pMI3pP9itGSMA==
Date: Mon, 14 Oct 2024 17:26:02 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Lorenz Brun <lorenz@monogon.tech>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] net: add config option for tunnel fallback devs
Message-ID: <20241014172602.7c55a4d4@kernel.org>
In-Reply-To: <20241009110421.41187-1-lorenz@monogon.tech>
References: <20241009110421.41187-1-lorenz@monogon.tech>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  9 Oct 2024 13:04:19 +0200 Lorenz Brun wrote:
> This adds a Kconfig option to set the default behavior regarding tunnel
> fallback devices.
> For setups where the initial namespace should also not have these, the
> only preexisting option is to use a kernel command line option which
> needs to be passed to every kernel invocation, which can be inconvenient
> in certain setups.
> If a kernel is built for a specific environment this knob allows
> disabling the compatibility behavior outright, without requiring any
> additional actions.

I don't hate the idea, but could you comment a bit more on practical
usability of such a change? Whatever software depends on the new
behavior will likely not work with distro kernels, right?

Did you consider kernel boot param?

