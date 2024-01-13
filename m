Return-Path: <netdev+bounces-63436-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C509A82CE13
	for <lists+netdev@lfdr.de>; Sat, 13 Jan 2024 19:10:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7341A1F22278
	for <lists+netdev@lfdr.de>; Sat, 13 Jan 2024 18:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD1375673;
	Sat, 13 Jan 2024 18:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lVmIKvAB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92BC023A8
	for <netdev@vger.kernel.org>; Sat, 13 Jan 2024 18:10:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 05864C43390;
	Sat, 13 Jan 2024 18:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705169425;
	bh=5dbfLaxR9aPpsskmo8od7M33aAcdh9uu5lZwAczsie4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lVmIKvABHQrEAQHDl/OZvvA3BxgYxf0Nb9KmmQY+8sOeOAvjguSo4LnT9m11ts2W0
	 9iusZFL4jJgb5egbXkCkCiox8qVEyOvsAwUvBg3bEpXFR5Wgt9wIlnCYxlyW/ZPIuL
	 oV4w3KUJRo0bQyA/hL9j3Dyhe47f/VX3+ZAiCqMhAsOEdiASEm6CCGTldb4VUJcYTU
	 zdP1Gi+CAd16Os4DqqNNNdHti8B/ODJndipQP+LTMlMgTwiuquOaalXk4itW6V71uJ
	 NnZPqc52QTOOLX3kWdZ/PopzDND0R7Te0XKgXy5hbgrjiHt+OWzBqk4Laj0XxBHSm+
	 syldYQO+5xD7Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E0F56DFC698;
	Sat, 13 Jan 2024 18:10:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: add more sanity check in virtio_net_hdr_to_skb()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170516942491.28180.3803271126480953156.git-patchwork-notify@kernel.org>
Date: Sat, 13 Jan 2024 18:10:24 +0000
References: <20240112122816.450197-1-edumazet@google.com>
In-Reply-To: <20240112122816.450197-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 willemb@google.com, netdev@vger.kernel.org, eric.dumazet@gmail.com,
 syzbot+7f4d0ea3df4d4fa9a65f@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 12 Jan 2024 12:28:16 +0000 you wrote:
> syzbot/KMSAN reports access to uninitialized data from gso_features_check() [1]
> 
> The repro use af_packet, injecting a gso packet and hdrlen == 0.
> 
> We could fix the issue making gso_features_check() more careful
> while dealing with NETIF_F_TSO_MANGLEID in fast path.
> 
> [...]

Here is the summary with links:
  - [net] net: add more sanity check in virtio_net_hdr_to_skb()
    https://git.kernel.org/netdev/net/c/9181d6f8a2bb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



