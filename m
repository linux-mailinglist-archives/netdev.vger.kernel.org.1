Return-Path: <netdev+bounces-14792-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E18FA743D3C
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 16:10:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E63521C2091C
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 14:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3553156F3;
	Fri, 30 Jun 2023 14:10:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7C3156D8;
	Fri, 30 Jun 2023 14:10:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A5ECDC433C0;
	Fri, 30 Jun 2023 14:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688134221;
	bh=7CYcR8BA5JgYH65UpytxLCS7BxTnhGd2xR2qkutsLnk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=G07+d/045UoBv4V6bxu1Swi4owEqwJFA8JgwLdWjc/n/oplRus+WFOeduwiY53mjE
	 83NbcokNzGzLs2Ma5igjQBO0ZenjmKuQOWmy5Z+BWO9+/YBTAI66sEC40jeSEGAvdC
	 RvhNFkCC/AsiQM0AEoibmGHJkT9MIDpipi7KpTkl2WqxEby4Fdx2zHjh5bmldJCUDG
	 eBuIxRS01P8jOEd55uaDUEH75NTDxCzc2Q/U2i6zuvBJsLy1cvKkJrbU2ulHPGjBeZ
	 J9mpvVkzsL8DRWLd64IfJWHm415Z9lZuibtJv5En6oxbO4G9hNIVu1sDOP9lzl8gMh
	 sDtnjAYhZ4N7A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7F52AC561EE;
	Fri, 30 Jun 2023 14:10:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v4 0/2] Fix missing synack in BPF cgroup_skb filters
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168813422151.21445.13036199053257466608.git-patchwork-notify@kernel.org>
Date: Fri, 30 Jun 2023 14:10:21 +0000
References: <20230624014600.576756-1-kuifeng@meta.com>
In-Reply-To: <20230624014600.576756-1-kuifeng@meta.com>
To: Kui-Feng Lee <thinker.li@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
 song@kernel.org, kernel-team@meta.com, andrii@kernel.org,
 daniel@iogearbox.net, yhs@fb.com, kpsingh@kernel.org, shuah@kernel.org,
 john.fastabend@gmail.com, sdf@google.com, mykolal@fb.com,
 linux-kselftest@vger.kernel.org, jolsa@kernel.org, haoluo@google.com,
 netdev@vger.kernel.org, kuifeng@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Fri, 23 Jun 2023 18:45:58 -0700 you wrote:
> TCP SYN/ACK packets of connections from processes/sockets outside a
> cgroup on the same host are not received by the cgroup's installed
> cgroup_skb filters.
> 
> There were two BPF cgroup_skb programs attached to a cgroup named
> "my_cgroup".
> 
> [...]

Here is the summary with links:
  - [bpf-next,v4,1/2] net: bpf: Check SKB ownership against full socket.
    https://git.kernel.org/bpf/bpf-next/c/223f5f79f2ce
  - [bpf-next,v4,2/2] selftests/bpf: Verify that the cgroup_skb filters receive expected packets.
    https://git.kernel.org/bpf/bpf-next/c/539c7e67aa4a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



