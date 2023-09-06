Return-Path: <netdev+bounces-32176-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF6967934BB
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 07:10:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B99A1C20978
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 05:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94117815;
	Wed,  6 Sep 2023 05:10:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CFC3653
	for <netdev@vger.kernel.org>; Wed,  6 Sep 2023 05:10:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C8B95C433C7;
	Wed,  6 Sep 2023 05:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693977022;
	bh=ytjo8sb9cDVv7gZBbXX/8sJhH01+R2Khw+dVZu7RdDI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AFzXJHjw4zc5sV97TGt2qtC5kgbHP34/onull6LL8q8fr5+PUMy4EkOFvVhB3CdGl
	 L1TvaEu6Nrtcg4QuYzRoJzlX7SuysXxgxF6Ov9lhgODMBr51a25tL34SM0RFfTVuib
	 d1D1HPE7Kdkp25yqvRbPWjXllxF7VL/1ftcZGNY3ewoYwXL3uBQGY8huH0+8WN79N3
	 D2TNQYuRA+cdgc1yYtVqyn0SETHmYgWo3fpVj+v9qCeg4yQ2f/0LRwMtB9CicBM5UH
	 cFEVXm+b/fEE9wlOe8mmXcRwyQQwr92c9H40LZHOnFIcpRKn1NeUCMLCI22DyEC06S
	 8zYuQVooQt1Ww==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AD99AE22B01;
	Wed,  6 Sep 2023 05:10:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ip_tunnels: use DEV_STATS_INC()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169397702270.22023.2638258892419431116.git-patchwork-notify@kernel.org>
Date: Wed, 06 Sep 2023 05:10:22 +0000
References: <20230905134046.2050443-1-edumazet@google.com>
In-Reply-To: <20230905134046.2050443-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, syzkaller@googlegroups.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue,  5 Sep 2023 13:40:46 +0000 you wrote:
> syzbot/KCSAN reported data-races in iptunnel_xmit_stats() [1]
> 
> This can run from multiple cpus without mutual exclusion.
> 
> Adopt SMP safe DEV_STATS_INC() to update dev->stats fields.
> 
> [1]
> BUG: KCSAN: data-race in iptunnel_xmit / iptunnel_xmit
> 
> [...]

Here is the summary with links:
  - [net] ip_tunnels: use DEV_STATS_INC()
    https://git.kernel.org/netdev/net/c/9b271ebaf9a2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



