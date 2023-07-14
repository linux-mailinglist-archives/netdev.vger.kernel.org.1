Return-Path: <netdev+bounces-17887-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C30E775367E
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 11:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C21D31C215E4
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 09:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA61DF6A;
	Fri, 14 Jul 2023 09:30:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80FA0D528
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 09:30:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0B67AC433C7;
	Fri, 14 Jul 2023 09:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689327021;
	bh=IIWAe0NQt7hQ52AYeH7Fl8uRHTVIRV1HOhISTeoKp4k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JJL43PYwtuw22nfaCtzyQV901socAiuVhOT4jCeHewKIpKvLtasXZ00VnnweXy088
	 JwVV23M1nzjEP3DojBGqNyOiChphOlYH4Orh6ALso35jneLiZgr6aSjeRhRoZ6GcDZ
	 eYpoBNFuJ2Hl9NCKx4b2o9NTzmsjOqvHnWwKMVXvH4MTpIBzpcaJMAjme0F2Bc5weW
	 rTtvIGh3aVRKz4waeygyPaIkVRCoyakXdagqvR7i9gbGKC2RC0DXxdO386GCRIIN3K
	 mUykM0pYhdPMjiPsuuGiB+qYPZcY41+sE/pKWDVw7pjtsxT98I0yctJgMH+1xb2a4u
	 nUF94pLyvYcBw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E45F4E49BBF;
	Fri, 14 Jul 2023 09:30:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net] gso: fix dodgy bit handling for GSO_UDP_L4
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168932702093.18845.9473507199122445355.git-patchwork-notify@kernel.org>
Date: Fri, 14 Jul 2023 09:30:20 +0000
References: <ZLA0ILTAZsIzxR6c@debian.debian>
In-Reply-To: <ZLA0ILTAZsIzxR6c@debian.debian>
To: Yan Zhai <yan@cloudflare.com>
Cc: netdev@vger.kernel.org, kernel-team@cloudflare.com, edumazet@google.com,
 davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 marcelo.leitner@gmail.com, lucien.xin@gmail.com, herbert@gondor.apana.org.au,
 andrew@daynix.com, jasowang@redhat.com, willemdebruijn.kernel@gmail.com,
 linux-kernel@vger.kernel.org, linux-sctp@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 13 Jul 2023 10:28:00 -0700 you wrote:
> Commit 1fd54773c267 ("udp: allow header check for dodgy GSO_UDP_L4
> packets.") checks DODGY bit for UDP, but for packets that can be fed
> directly to the device after gso_segs reset, it actually falls through
> to fragmentation:
> 
> https://lore.kernel.org/all/CAJPywTKDdjtwkLVUW6LRA2FU912qcDmQOQGt2WaDo28KzYDg+A@mail.gmail.com/
> 
> [...]

Here is the summary with links:
  - [v2,net] gso: fix dodgy bit handling for GSO_UDP_L4
    https://git.kernel.org/netdev/net/c/9840036786d9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



