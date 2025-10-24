Return-Path: <netdev+bounces-232573-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C63C06B6C
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 16:34:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DFC93B110C
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 14:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36B063074AE;
	Fri, 24 Oct 2025 14:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NTq0776Y"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5082FB092;
	Fri, 24 Oct 2025 14:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761316451; cv=none; b=i6sv3OBH9H01kQ6E5H0CWlqf9ZeyaHfXPIzUVbvgKfRlviXvGxJwS32LXyfaGgpfk4NgLWy9XoB8b3UOeVEYVDZtYxPCkxo7ytslBQWjbzUzlt7uGYqr7bQsoymiXj1GVGu8XfVsYzaNZ54vmP2hVicwMrjO1039MMspw3p4Owc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761316451; c=relaxed/simple;
	bh=zGo14bksHo5YyomxwNoopLi1of3EChNJA/a1tqnelDg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=i39TXX6TBtNinYlzZZoTx0ZwwlAmEmDbLNY6d1EUux0C5I0D603Likeex7e32RYoErSiAZVH3nOciOkK3AR6GhiRPHAc8rsl/0hXjRANWtjSrwLMeo3trMvMeIntATsU7Gpq5jxy4yd0yCl3xw7a/pJu2s/Kq3q0O5OsKJ24Jfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NTq0776Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C942C4CEF1;
	Fri, 24 Oct 2025 14:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761316450;
	bh=zGo14bksHo5YyomxwNoopLi1of3EChNJA/a1tqnelDg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NTq0776YTnC6tZHvA9KO4i/PrO7IpLdJgFf91/x9sutLqx1KUDcz2uqbnYBPGLMWR
	 QTq0llDiN9UBD4kSgJMfUOJvZmtMxDcfWWvQIM+nB9VF9UPQKpoodiFRUUbLpcnpBY
	 g4iHIRw+DIhcMnZ8Y+29nD/GEvysl/uLJnDsDePHBvdlqvA1zVegXQv4rlMyLKvuAe
	 oQEeR7t9fJTjfB+6mcVDJpIqK/lJ0eL5dSzEAZVWLDnxc8MXSr4+3v+2/PyHQ8KIEc
	 3wHnsMRwqWvag83Y43QiUkD3EYx8KqI12bS5YGwLY/Jtn7qmzoMNJFxbZCuukZvS2O
	 fczsxHs20gOMA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADECB380AA40;
	Fri, 24 Oct 2025 14:33:51 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] bluetooth-next 2025-09-27
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176131643051.3904207.15505622347342083711.git-patchwork-notify@kernel.org>
Date: Fri, 24 Oct 2025 14:33:50 +0000
References: <20250927154616.1032839-1-luiz.dentz@gmail.com>
In-Reply-To: <20250927154616.1032839-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This pull request was applied to bluetooth/bluetooth-next.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 27 Sep 2025 11:46:16 -0400 you wrote:
> The following changes since commit 1493c18fe8696bfc758a97130a485fc4e08387f5:
> 
>   Merge branch 'selftests-mark-auto-deferring-functions-clearly' (2025-09-26 17:54:37 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git tags/for-net-next-2025-09-27
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] bluetooth-next 2025-09-27
    https://git.kernel.org/bluetooth/bluetooth-next/c/d210ee58da1e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



