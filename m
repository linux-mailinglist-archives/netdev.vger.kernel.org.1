Return-Path: <netdev+bounces-37300-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C6707B493B
	for <lists+netdev@lfdr.de>; Sun,  1 Oct 2023 20:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id E8C8A28198E
	for <lists+netdev@lfdr.de>; Sun,  1 Oct 2023 18:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 240561772D;
	Sun,  1 Oct 2023 18:40:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12616EED5
	for <netdev@vger.kernel.org>; Sun,  1 Oct 2023 18:40:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 73002C433CA;
	Sun,  1 Oct 2023 18:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696185625;
	bh=vHpYQw4Xo9ncTL+cTD5bhjtdjFWeRqIriCu/Ce16oc4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BEstLtKJIXt0IJ4gCEvv4DRQRrPAiKpdLtX0LWl0eWl3Nty1flLkeAMAk6VoQ3hFH
	 zfw2pT3j66ZWc4mAFtr0hI1r+/FdoaNS5LzyTt6pfQTwiVmIB3ytjv0Jx8v8IPwEBb
	 Lswz85b/WEMSd+P5Aqfm8HJK4pxY7Vc3lDKxHO2ou4ct8H8qk6GPllQmsiRm14NXTE
	 PExldMIYnTMvAOv5UWs9RqqO5bctrk+swoNCnH8Je1QlBthCz46pHYh+NRrdY+sVYa
	 8FInmRSG0tvh+6NaOnjbWMJZ8lSCfrKmpZj7YuRXGfRFBRx+qMZRFTMMqhW2JbMr+k
	 JgyencAyzITyw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4CF22C73FE1;
	Sun,  1 Oct 2023 18:40:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v6 0/3] Insulate Kernel Space From SOCK_ADDR Hooks
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169618562530.20334.3438760815048190740.git-patchwork-notify@kernel.org>
Date: Sun, 01 Oct 2023 18:40:25 +0000
References: <20230926200505.2804266-1-jrife@google.com>
In-Reply-To: <20230926200505.2804266-1-jrife@google.com>
To: Jordan Rife <jrife@google.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, willemdebruijn.kernel@gmail.com, netdev@vger.kernel.org,
 dborkman@kernel.org, horms@verge.net.au, pablo@netfilter.org,
 kadlec@netfilter.org, fw@strlen.de, santosh.shilimkar@oracle.com,
 ast@kernel.org, rdna@fb.com, linux-rdma@vger.kernel.org,
 rds-devel@oss.oracle.com, coreteam@netfilter.org,
 netfilter-devel@vger.kernel.org, ja@ssi.bg, lvs-devel@vger.kernel.org,
 kafai@fb.com, daniel@iogearbox.net, daan.j.demeyer@gmail.com

Hello:

This series was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 26 Sep 2023 15:05:02 -0500 you wrote:
> ==OVERVIEW==
> 
> The sock_sendmsg(), kernel_connect(), and kernel_bind() functions
> provide kernel space equivalents to the sendmsg(), connect(), and bind()
> system calls.
> 
> When used in conjunction with BPF SOCK_ADDR hooks that rewrite the send,
> connect, or bind address, callers may observe that the address passed to
> the call is modified. This is a problem not just in theory, but in
> practice, with uninsulated calls to kernel_connect() causing issues with
> broken NFS and CIFS mounts.
> 
> [...]

Here is the summary with links:
  - [net,v6,1/3] net: replace calls to sock->ops->connect() with kernel_connect()
    https://git.kernel.org/netdev/net/c/26297b4ce1ce
  - [net,v6,2/3] net: prevent rewrite of msg_name and msg_namelen in sock_sendmsg()
    (no matching commit)
  - [net,v6,3/3] net: prevent address rewrite in kernel_bind()
    https://git.kernel.org/netdev/net/c/c889a99a21bf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



