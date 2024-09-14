Return-Path: <netdev+bounces-128272-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5915C978CFF
	for <lists+netdev@lfdr.de>; Sat, 14 Sep 2024 05:08:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0305F1F23D70
	for <lists+netdev@lfdr.de>; Sat, 14 Sep 2024 03:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 542CB12E5D;
	Sat, 14 Sep 2024 03:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W4/w0XrN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5EBFC0B;
	Sat, 14 Sep 2024 03:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726283294; cv=none; b=kAFld/wkASQDEeZ/VO9KonAVzy6fmKwIghmn4HHqpfmHDXqZ/Y9uq2lgtwYBLR6+/RCX3b3CLf7lUbu6cOP9SAv4ANUsoOp1I4xpZrpqT4GPZ7Bx/9PbViBf+jpEjapambtmzxSv7Fgh3gWNAL6ienDe1lzKHvuI8EkGo483/qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726283294; c=relaxed/simple;
	bh=01LiX4IdLsRAyam9iMuifTX2AtQX9Z61foUD/g+ygE8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cxt7Yl9iQET8dSC8SXFubmNm7cSdJNA15z3R49TWJxwmt7MD9H+AxK0y1ZVmN4DSJypS5o6+i1ePQ+js0CpCzWp0Ugffes/X54+9lecQfvUH3M1CqYYs/x8feFlPL4GyPpmbqGoFTz0t06fQDpBkxgXpvFiXWz6l/qfaVCevXqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W4/w0XrN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 666EBC4CEC0;
	Sat, 14 Sep 2024 03:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726283293;
	bh=01LiX4IdLsRAyam9iMuifTX2AtQX9Z61foUD/g+ygE8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=W4/w0XrNdsL6JEWPgEJ9GuKWRW0p2I6e6UUvuV2hKsNooa/srTZSdSbKHSF9F+UJF
	 Uf7xWI7xiWMKZf6ixnODp1+aTPlm2mw6t3X4QMqGdj8pn1xo9XTxmcrHVMF4m5dPJv
	 HSMd3b685S3bHokhHP7f+fypvswzGOOsSJaqMiVzorqcBORgFsIjhYijUDjKZtJAjp
	 YrZWAlLWzLxdNEUC3zOdizpsgON9AParaKbXfYJoWANqSS+G2105n1LBBeN1H6++WS
	 8hPskDGND+T1FoSf2WbjTCGHIJV3PH798eHsD+4CCLGEut4Y7Y22ibjDRXZg7AiU21
	 EBE3fMV310Xfg==
Date: Fri, 13 Sep 2024 20:08:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Lorenz Brun <lorenz@monogon.tech>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: add config option for tunnel fallback devs
Message-ID: <20240913200812.7a92e6fc@kernel.org>
In-Reply-To: <20240913110234.166707-1-lorenz@monogon.tech>
References: <20240913110234.166707-1-lorenz@monogon.tech>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Sep 2024 13:02:33 +0200 Lorenz Brun wrote:
> This adds a Kconfig option to set the default behavior regarding tunnel
> fallback devices.
> For setups where the initial namespace should also not have these, the
> only preexisting option is to use a kernel command line option which
> needs to be passed to every kernel invocation, which can be inconvenient
> in certain setups.
> If a kernel is built for a specific environment this knob allows
> disabling the compatibility behavior outright, without requiring any
> additional actions.

We closed net-next for the rest of the development cycles:
https://lore.kernel.org/all/20240912181222.2dd75818@kernel.org/
please repost in a few weeks. Sorry about that.
-- 
pw-bot: defer

