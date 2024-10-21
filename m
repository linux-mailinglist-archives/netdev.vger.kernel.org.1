Return-Path: <netdev+bounces-137380-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D3409A5D29
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 09:34:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C2241C21261
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 07:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 704AC1DE4F5;
	Mon, 21 Oct 2024 07:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VTAQ6zMf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B6A194143;
	Mon, 21 Oct 2024 07:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729496057; cv=none; b=uNOrXIQUvKvR77npby8oxdeKZy1jljkXjzylkp8gdTophq+a/r5TgVB1IzQ8EzQ8rt8XtFzbn4oPi2unA3BzLOWsDRe3eSszRwF2DsS7DAMaxWi4ZAssfrIxlIC7QdvMWE9nh9+4hi3Yy4Xjj3zQvn2kAwMLofeokEZwbT578y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729496057; c=relaxed/simple;
	bh=gsSawrtkJ0SPMTh/Q/KujPjFOsjl/P4Ql2gWPxR89Bw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lKngqDpSjbZ6kqpOQOpNykEsLtMN6bNW2Vv1dyiIKI8byZevTSk5b5LRbaRwTbjRczoaeAeFoj04AALZZksea7yE6X7GjoR0z9EUX62t6I0FM0Z+bW4RxKAoN/mbaZJQZE+9ooKSf4xolx5GpFLLEihgFtd9MjTNxS/otR5zVqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VTAQ6zMf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B79EC4CECD;
	Mon, 21 Oct 2024 07:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729496057;
	bh=gsSawrtkJ0SPMTh/Q/KujPjFOsjl/P4Ql2gWPxR89Bw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VTAQ6zMf6x1pRE3ias5cp9cozdPiyn6dCvQwUIxkDYdmz2Dzfen04EGr4aTg+goji
	 6dMQPekzseilRxnXvDtjbFtJZDVnFlDsIZ6pPb055ndEbEhvV8+SBrssg3yaDc/vL3
	 WT5gUT0H64QT9IGXtF9ly2ykKt+0PmPd1zd/WAAjSfWd3GTyMzaW90ogt2mKF71bP1
	 z6f5KZlYKm2g94A/+xcaH93v1+WIgcW4lBRcCvQNGGxUcpB4PmkNc3Y5PDJpdeWZ3b
	 S//hcvyWDCtsPgUGxwLyn813GSx/3L8JBuMLyCkEQDtcgQXQ9AAgwXXktCJOtByQy0
	 JxjH+poFiE98w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33F8A3809A8A;
	Mon, 21 Oct 2024 07:34:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull request: bluetooth 2024-10-16
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172949606303.147197.13939738809258549859.git-patchwork-notify@kernel.org>
Date: Mon, 21 Oct 2024 07:34:23 +0000
References: <20241016204258.821965-1-luiz.dentz@gmail.com>
In-Reply-To: <20241016204258.821965-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This pull request was applied to bpf/bpf.git (master)
by Linus Torvalds <torvalds@linux-foundation.org>:

On Wed, 16 Oct 2024 16:42:58 -0400 you wrote:
> The following changes since commit 11d06f0aaef89f4cad68b92510bd9decff2d7b87:
> 
>   net: dsa: vsc73xx: fix reception from VLAN-unaware bridges (2024-10-15 18:41:52 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2024-10-16
> 
> [...]

Here is the summary with links:
  - pull request: bluetooth 2024-10-16
    https://git.kernel.org/bpf/bpf/c/d7f513ae7b10

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



