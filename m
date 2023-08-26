Return-Path: <netdev+bounces-30840-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC497789329
	for <lists+netdev@lfdr.de>; Sat, 26 Aug 2023 03:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2B271C210A4
	for <lists+netdev@lfdr.de>; Sat, 26 Aug 2023 01:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D50238C;
	Sat, 26 Aug 2023 01:50:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7683B37F;
	Sat, 26 Aug 2023 01:50:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E4DFAC433C9;
	Sat, 26 Aug 2023 01:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693014639;
	bh=jnq2ZXaPKzpiTgh0gMz9NlxtChItt19jiQISyEwUlQc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ctO+CjOyxYr3noYo5XQubROAB54bt5YDU1OrDJEqyGp6VP04I3HdVaDsv+qwNu4Nh
	 31tULT11/zU31SXoOeql/yLV/xl5sWu30Nah6QC8uFj+KBZdg5Je8TJ/Q0NsKbmCPy
	 hLucqY99+cHcV3aGTGwkUgoWButh3rqnXzgUBQ4CME0j386jbNSRs8XaPKV8/j2AYq
	 YS4EpzmmL0Q+QyBcqtO2FxxHynBPauImIJzCg4kH+aQdpFDhQ89fmbcAxQqbzzF5o/
	 M7+i+eY5QoPxm4SscDm5h4CSXor9EhuhwbZ/TF4lja8mn/zmkaLVrg/X1gofuntqcK
	 5n0R41opxm0NQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C6121C595D7;
	Sat, 26 Aug 2023 01:50:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: bpf-next 2023-08-25
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169301463880.5289.10579477263705989380.git-patchwork-notify@kernel.org>
Date: Sat, 26 Aug 2023 01:50:38 +0000
References: <20230825194319.12727-1-daniel@iogearbox.net>
In-Reply-To: <20230825194319.12727-1-daniel@iogearbox.net>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, ast@kernel.org, andrii@kernel.org, martin.lau@linux.dev,
 netdev@vger.kernel.org, bpf@vger.kernel.org

Hello:

This pull request was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 25 Aug 2023 21:43:19 +0200 you wrote:
> Hi David, hi Jakub, hi Paolo, hi Eric,
> 
> The following pull-request contains BPF updates for your *net-next* tree.
> 
> We've added 87 non-merge commits during the last 8 day(s) which contain
> a total of 104 files changed, 3719 insertions(+), 4212 deletions(-).
> 
> [...]

Here is the summary with links:
  - pull-request: bpf-next 2023-08-25
    https://git.kernel.org/netdev/net-next/c/bebfbf07c7db

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



