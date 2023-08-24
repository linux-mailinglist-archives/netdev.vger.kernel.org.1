Return-Path: <netdev+bounces-30463-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 706A67877D8
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 20:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AA19281664
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 18:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1934914F8B;
	Thu, 24 Aug 2023 18:30:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767AF15ACC
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 18:30:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E8608C433C7;
	Thu, 24 Aug 2023 18:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692901851;
	bh=DeKeaZL0R5C/9qoo3WdGT1JoCeASs543LFqTiYO4SKA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gXeWfMyB2VhAyi5FbRhfzVdWwr0KglhxFR1AwH11pWitYlB3vOwB4Vx08HKYAiWfq
	 zFR4opzgn4FP/UMRE7PkX6XvG/JMkGW+mWZNBuE54XFXDRWwswx7CdF9V34ehZatxj
	 mFFdCVsJehp3Wt5saC4Igkhq3GRP6tn94mwJaq8MBbIbMpCMxBvHQGU6n5BpT5bL8S
	 EzdJDTJ6k2bgecaBeiDESnRmSt0owFSDfy3fMGZ8lvRMMmR+10LadxIE3dfRsZ0YRS
	 OquaqWsCn+kZ1SVtvgGbv5Ic/fUmW4g/0HJsNrrTEjHdIl9wzu0yvYbs1ncKtq0gNV
	 MwdtnRf2UF+Kw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D220FE21EDF;
	Thu, 24 Aug 2023 18:30:50 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: generalize calculation of skb extensions
 length
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169290185085.21414.5074142110949284955.git-patchwork-notify@kernel.org>
Date: Thu, 24 Aug 2023 18:30:50 +0000
References: <20230823-skb_ext-simplify-v2-1-66e26cd66860@weissschuh.net>
In-Reply-To: <20230823-skb_ext-simplify-v2-1-66e26cd66860@weissschuh.net>
To: =?utf-8?q?Thomas_Wei=C3=9Fschuh_=3Clinux=40weissschuh=2Enet=3E?=@codeaurora.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 robimarko@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 23 Aug 2023 11:28:38 +0200 you wrote:
> Remove the necessity to modify skb_ext_total_length() when new extension
> types are added.
> Also reduces the line count a bit.
> 
> With optimizations enabled the function is folded down to the same
> constant value as before during compilation.
> This has been validated on x86 with GCC 6.5.0 and 13.2.1.
> Also a similar construct has been validated on godbolt.org with GCC 5.1.
> In any case the compiler has to be able to evaluate the construct at
> compile-time for the BUILD_BUG_ON() in skb_extensions_init().
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: generalize calculation of skb extensions length
    https://git.kernel.org/netdev/net-next/c/5d21d0a65b57

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



