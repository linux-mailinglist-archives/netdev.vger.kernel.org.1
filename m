Return-Path: <netdev+bounces-32117-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5889E792D02
	for <lists+netdev@lfdr.de>; Tue,  5 Sep 2023 20:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89BC21C20AA8
	for <lists+netdev@lfdr.de>; Tue,  5 Sep 2023 18:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9D88DDC5;
	Tue,  5 Sep 2023 18:01:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E65DDC4
	for <netdev@vger.kernel.org>; Tue,  5 Sep 2023 18:01:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E7B23C433D9;
	Tue,  5 Sep 2023 18:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693936900;
	bh=w2dz+14NU7wgPktFqWoWCxY5vNqW0fD/lMmbU7wuRUA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Grh1gCzPJwBoY2NovXfJaDS7goXK78+PtHBA7/6GI5Sx0WVXzjYLml6SnzA/600BT
	 y/Y3mPZ4T4s8dPjmfd2iHl41wvYvga6k12mgyOBWXKGgSjSRb5ONjnPv50mS+NIBBi
	 WxnHlgaJ5ueXPCoTuMUC/CLZ9+qhNSIVds2ZeNJ15VRqjqnxTgnF97gO/lMc1vjTIg
	 YtqlGKCW1nbJfmS90P1vPM+3VSVyeXCWQufVw/MqbuDiV0AhfG1KK7CKQOMelOSles
	 BQivMlFwDd3Nve0M9D4zrbgCpv+2Lpc2sga+Z8e2Nq+Mt3Acgo8Uo+iykK3H19xeFs
	 r2MwFBvajbG8Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CC7C3C2BBF6;
	Tue,  5 Sep 2023 18:01:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] igmp: limit igmpv3_newpack() packet size to IP_MAX_MTU
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169393689983.22693.8787710265740710535.git-patchwork-notify@kernel.org>
Date: Tue, 05 Sep 2023 18:01:39 +0000
References: <20230905042338.1345307-1-edumazet@google.com>
In-Reply-To: <20230905042338.1345307-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, David.Laight@ACULAB.COM,
 zengyhkyle@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue,  5 Sep 2023 04:23:38 +0000 you wrote:
> This is a follow up of commit 915d975b2ffa ("net: deal with integer
> overflows in kmalloc_reserve()") based on David Laight feedback.
> 
> Back in 2010, I failed to realize malicious users could set dev->mtu
> to arbitrary values. This mtu has been since limited to 0x7fffffff but
> regardless of how big dev->mtu is, it makes no sense for igmpv3_newpack()
> to allocate more than IP_MAX_MTU and risk various skb fields overflows.
> 
> [...]

Here is the summary with links:
  - [net] igmp: limit igmpv3_newpack() packet size to IP_MAX_MTU
    https://git.kernel.org/netdev/net/c/c3b704d4a4a2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



