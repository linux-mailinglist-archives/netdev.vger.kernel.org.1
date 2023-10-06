Return-Path: <netdev+bounces-38458-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25C6B7BB015
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 03:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 4A600282135
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 01:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E60D917CA;
	Fri,  6 Oct 2023 01:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A4gy7FOO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63C515AD;
	Fri,  6 Oct 2023 01:40:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 369FCC433D9;
	Fri,  6 Oct 2023 01:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696556426;
	bh=Ybo4PA+YOfwHZpwG7F/ih3tq0pio/1SFsEdxpMf6r90=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=A4gy7FOOEFBLp+72P2HX9SBrrMGxjF3zHnLKAk/YUwO1+AZVdxXjIKo/XZqzDk0kF
	 jNWAkSrVA/mA1dhI5kpJpQ52pgSvCdw0cGhXTJ4fA13UpAz2tyyyvGAWCX+ycoGO3l
	 0YRA9XVKq7jnsxFXf2LBx9fvOdGwOyzPdCb6xwg67ajYR39LTU5H6+gg6g/tBFIkCK
	 txD7meyQqCC0PqRd0rtu0xy+KhP+TIZ9hf+eJNuq7Pw5oJoD/Y3kg1QMt7CqQnxXzW
	 AFIyXsU7C5Udh8UaRanl7M6dHjglHMDMeVEZTQvvFxATkSepM69JYb7VfgvFvlXskc
	 iah+SLQCq89lg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1A346E11F52;
	Fri,  6 Oct 2023 01:40:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] nfp: Annotate struct nfp_reprs with __counted_by
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169655642610.20160.13967622151608370397.git-patchwork-notify@kernel.org>
Date: Fri, 06 Oct 2023 01:40:26 +0000
References: <20231003231843.work.811-kees@kernel.org>
In-Reply-To: <20231003231843.work.811-kees@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: horms@kernel.org, simon.horman@corigine.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 oss-drivers@corigine.com, netdev@vger.kernel.org, louis.peens@corigine.com,
 gustavoars@kernel.org, nathan@kernel.org, ndesaulniers@google.com,
 trix@redhat.com, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org, llvm@lists.linux.dev

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  3 Oct 2023 16:18:43 -0700 you wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
> array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct nfp_reprs.
> 
> [...]

Here is the summary with links:
  - nfp: Annotate struct nfp_reprs with __counted_by
    https://git.kernel.org/netdev/net-next/c/4514aa9f56fd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



