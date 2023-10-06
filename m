Return-Path: <netdev+bounces-38517-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99CEE7BB4A4
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 12:00:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 055F128221B
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 10:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C67014A9F;
	Fri,  6 Oct 2023 10:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BRhmwgmY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646C6125B3;
	Fri,  6 Oct 2023 10:00:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BE053C433C9;
	Fri,  6 Oct 2023 10:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696586426;
	bh=Lv3Klna2FTPeB1l0WLzXoU1kCYsAsFAU4Irfc+zJ3yc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BRhmwgmYih5xopqLETDSS3Keu9xlfYM+GQ6LakR7JP8Pf6pSbjZ+i+Ewazp6IEsDp
	 rtOI6u8U1efgdBJ6AsiaqtdIZwwTWqP8lMId4oWHGLLL9AJ8O6W49/SfxAMYJZmetI
	 Jf27Fl43QL7+q0lHyaRmzvdq+kkFOX4MtjpqoYNGd1/ba9wVJjSVcWXuL60G6v9bWJ
	 9PW19QMJ192/xt/a10jgkyQuZnJqzOJvHVdEMfmELL8MSs6qZgTKS8zkq6208sn+tk
	 A6jEfMSqywh3dMUMSE5gXFra5z5fnIhB/lHMHTAt6r8IJ3WVxYQp7dgzrZfKpCf0PP
	 9uFsaIhg7XQ3Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9EBBFC595CB;
	Fri,  6 Oct 2023 10:00:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] nexthop: Annotate struct nh_group with __counted_by
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169658642664.19666.16771125566763338647.git-patchwork-notify@kernel.org>
Date: Fri, 06 Oct 2023 10:00:26 +0000
References: <20231004014445.work.587-kees@kernel.org>
In-Reply-To: <20231004014445.work.587-kees@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: dsahern@kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 gustavoars@kernel.org, nathan@kernel.org, ndesaulniers@google.com,
 trix@redhat.com, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org, llvm@lists.linux.dev

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue,  3 Oct 2023 18:44:49 -0700 you wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
> array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct nh_group.
> 
> [...]

Here is the summary with links:
  - nexthop: Annotate struct nh_group with __counted_by
    https://git.kernel.org/netdev/net-next/c/2a92fccdaca8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



