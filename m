Return-Path: <netdev+bounces-24704-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B0EF771503
	for <lists+netdev@lfdr.de>; Sun,  6 Aug 2023 14:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D72B281330
	for <lists+netdev@lfdr.de>; Sun,  6 Aug 2023 12:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF4DA3C00;
	Sun,  6 Aug 2023 12:30:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80FA7F2
	for <netdev@vger.kernel.org>; Sun,  6 Aug 2023 12:30:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F23DDC433C9;
	Sun,  6 Aug 2023 12:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691325021;
	bh=CQ86uxx6RdQPzj6iMBlGWmI1RFdI+qA4beNHy08LRN8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=F0ukhswDgb/pWZn5ZMdCEekXRwfEFDWPDb0KiI8RUpT3upgwreSJlgIKl305Mm0db
	 H6y1JRiTzvnGGECnoM1hmN9UUPqpsD/D77fvgXvLQRFwqBKa69TAizEl1Rc+MNzzFu
	 H2I9O3fTQ+9jRmwjVAvOe1q36TSJ9XHNLvJj/6bQQ12ZKawSbp+yrJNkhbk1TL83Nw
	 0GjZ0C6QD39C1hKXmIjmSCRoGMyqtyRB/MBXnZkBicZtL5eBhXYs5PCpPKSBsrbf8s
	 uRxsN8sHuDre98OXz4r7h7lL2x+te7FM4VXKB+kjT0v1038njr5ubdnGz0YDyE7G5P
	 qEoTWhIbYTbxw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D9EEBC395F3;
	Sun,  6 Aug 2023 12:30:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] macsec: use DEV_STATS_INC()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169132502088.16904.2314205828504126416.git-patchwork-notify@kernel.org>
Date: Sun, 06 Aug 2023 12:30:20 +0000
References: <20230804172652.1962-1-edumazet@google.com>
In-Reply-To: <20230804172652.1962-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, soheil@google.com,
 syzkaller@googlegroups.com, sd@queasysnail.net

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri,  4 Aug 2023 17:26:52 +0000 you wrote:
> syzbot/KCSAN reported data-races in macsec whenever dev->stats fields
> are updated.
> 
> It appears all of these updates can happen from multiple cpus.
> 
> Adopt SMP safe DEV_STATS_INC() to update dev->stats fields.
> 
> [...]

Here is the summary with links:
  - [net] macsec: use DEV_STATS_INC()
    https://git.kernel.org/netdev/net/c/32d0a49d36a2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



