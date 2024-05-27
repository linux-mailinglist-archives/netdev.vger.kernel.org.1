Return-Path: <netdev+bounces-98159-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6AAE8CFD77
	for <lists+netdev@lfdr.de>; Mon, 27 May 2024 11:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 870171F20F2D
	for <lists+netdev@lfdr.de>; Mon, 27 May 2024 09:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41A2213A88B;
	Mon, 27 May 2024 09:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FdcuncO/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2E913A86B
	for <netdev@vger.kernel.org>; Mon, 27 May 2024 09:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716803430; cv=none; b=Y5GFzMUlmkoJUQXMnQUqbt4F1YE/RzWE4mShIFQhLL8ON6xd1BNK9d45cqusGfTOlFCSIHwoAamkOOpJa3AcZfriFSBfA4ToKEQ2g7m2LpDHwvUm08okHg+sNmHfs3arQQujCOGV1KY+wdZ7R/q6OlVRTNZDOSDh+2JUGD+ryT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716803430; c=relaxed/simple;
	bh=LoDdLQztJTxm7FcPWPIdsWFTk+OlueoeFCMnjKr/Nts=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cnYfMXHbyo14UCngfGshdYPiAQeTPx0L5ZSkOwwqzXhD3lDmygub8bpxKzLJBSJOWFTzm+RTasdgbNiOV2frOyIAZMhD+RfV2N+RosM9H+MhIAiGDPW7E01aLOwVzEiUhN1e1iDym0IRl75VHUew/hBVaEG68pHY88ZNjTRHNpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FdcuncO/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AA9FCC32786;
	Mon, 27 May 2024 09:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716803429;
	bh=LoDdLQztJTxm7FcPWPIdsWFTk+OlueoeFCMnjKr/Nts=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FdcuncO/bsnHTjU/wf2S1MkbFQObFugGuhwv+cu0Fomqc7RNcd6ZJKq7h7rtBSK2x
	 KbJjO3OUNfIil2PDvQ9lgMNwPgBO+U56FYhpYmu+1B1EEt8uaweUTQE/CytOLgqHGV
	 V6l/m0eZomkGwxjXISJIgBYSw0f98jvxe1QdjJBaX1hK1D6JStBHFd0DLAdBoPTaNP
	 +Xiw3o5aXkyM7RvtfrrxCT0iXi0Rc7JchbQiIWaLpZUgoSWCj+k7UMBUlPt1+tSUL2
	 gEhiPlhc3AsjpLN+zfEUfBO1wpIrlfpG6jpdIv0eROD/j5wjy1lsEXJ9K4hr78BbL7
	 fROd0tOJl3xMA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 97ECED3C6E1;
	Mon, 27 May 2024 09:50:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net] af_unix: Annotate data-race around unix_sk(sk)->addr.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171680342961.8026.6155204364138673404.git-patchwork-notify@kernel.org>
Date: Mon, 27 May 2024 09:50:29 +0000
References: <20240522154002.77857-1-kuniyu@amazon.com>
In-Reply-To: <20240522154002.77857-1-kuniyu@amazon.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, kuni1840@gmail.com, netdev@vger.kernel.org,
 syzkaller@googlegroups.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 23 May 2024 00:40:02 +0900 you wrote:
> Once unix_sk(sk)->addr is assigned under net->unx.table.locks and
> unix_sk(sk)->bindlock, *(unix_sk(sk)->addr) and unix_sk(sk)->path are
> fully set up, and unix_sk(sk)->addr is never changed.
> 
> unix_getname() and unix_copy_addr() access the two fields locklessly,
> and commit ae3b564179bf ("missing barriers in some of unix_sock ->addr
> and ->path accesses") added smp_store_release() and smp_load_acquire()
> pairs.
> 
> [...]

Here is the summary with links:
  - [v2,net] af_unix: Annotate data-race around unix_sk(sk)->addr.
    https://git.kernel.org/netdev/net/c/97e1db06c7bb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



