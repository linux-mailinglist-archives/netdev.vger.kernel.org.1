Return-Path: <netdev+bounces-49058-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C61A7F089F
	for <lists+netdev@lfdr.de>; Sun, 19 Nov 2023 20:50:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DD021C203DF
	for <lists+netdev@lfdr.de>; Sun, 19 Nov 2023 19:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D623E182DE;
	Sun, 19 Nov 2023 19:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mSHsCy6h"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B916D199AE
	for <netdev@vger.kernel.org>; Sun, 19 Nov 2023 19:50:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4C5D1C433C9;
	Sun, 19 Nov 2023 19:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700423423;
	bh=BCt6WhVihJjrvA1IPS984F320NZ/JHPTtwnPPWptubk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mSHsCy6hnYkYp3Im74onfsOVG/+z8JWxRU+l0UgGj6cfeQfdGDBjYMV+/ZyQAI8kj
	 Cu3rMNpK5mL0G2bFA4wfuJLWA+KFsLNaHHJEGkjQJue0TxhXMQZlmSrUtzdGfhQ/wl
	 HGg6I9rv8zlId3wtGDhQOJE26+MsuVxuni5Uc8itnOud0Y7PioU1dCP64boKe7U8vJ
	 VoIilowhvo7cHnH5MlEkIPnodS3NkBs3Ck+0ZUf4Hn6rjJ+TlnJDiKoaMMga1O4bkw
	 plufsHXJ0M+yqUTLPHDJ0gxVo4Ff0soZBMzjM0YdwWEyhxTSDuHP/0LziHUsxAuA8t
	 ZQaZWZzblSyhg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 30F37E000A4;
	Sun, 19 Nov 2023 19:50:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net] wireguard: use DEV_STATS_INC()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170042342319.11006.13933415217196728575.git-patchwork-notify@kernel.org>
Date: Sun, 19 Nov 2023 19:50:23 +0000
References: <20231117141733.3344158-1-edumazet@google.com>
In-Reply-To: <20231117141733.3344158-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, syzkaller@googlegroups.com,
 Jason@zx2c4.com, liuhangbin@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 17 Nov 2023 14:17:33 +0000 you wrote:
> wg_xmit() can be called concurrently, KCSAN reported [1]
> some device stats updates can be lost.
> 
> Use DEV_STATS_INC() for this unlikely case.
> 
> [1]
> BUG: KCSAN: data-race in wg_xmit / wg_xmit
> 
> [...]

Here is the summary with links:
  - [v2,net] wireguard: use DEV_STATS_INC()
    https://git.kernel.org/netdev/net/c/93da8d75a665

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



