Return-Path: <netdev+bounces-17850-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E370B753392
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 09:51:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EAEC282171
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 07:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B38B7499;
	Fri, 14 Jul 2023 07:50:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0EA747B
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 07:50:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A5C03C4339A;
	Fri, 14 Jul 2023 07:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689321021;
	bh=+2QWes2RE0i5IrBbJI6VRLfCnZbenJUeoe8xjeI1f+Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=at24sE3In6WxRarmoG+HSNEHsfHq6/mtzAYbb+BABrlbuN+15MJGO890lmMeuB59i
	 7juXT3dFX/YGlrAqzbyNZ7t10kDv0GGjhoCg92VvoAAdq3FTyeWn6fy3+ANniscL8m
	 UUjQfuGv9l4uMkpYTW4Y+50TjloFfrcyIH/dAn6DXA2roi7fUXgAXO7HlAm8XI4KJg
	 ey8yu46qkaxAAFF4NZbUCxNiDOuSMJV6RsVmQg0YLERsSxY+wb0TA0Hw2P94LMgIL7
	 um/ayUzCWbkS/vCNM8E5BycJdkNhn24R1oJXK5bCwUyDCOFIN4aezfKZdhD5SW5GyF
	 op4Gp1KjGOf/A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 83C3AF83708;
	Fri, 14 Jul 2023 07:50:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4] net: ngbe: add Wake on Lan support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168932102153.13275.8361831420054225085.git-patchwork-notify@kernel.org>
Date: Fri, 14 Jul 2023 07:50:21 +0000
References: <FCC13FFE712616EA+20230713060911.33253-1-mengyuanlou@net-swift.com>
In-Reply-To: <FCC13FFE712616EA+20230713060911.33253-1-mengyuanlou@net-swift.com>
To: Mengyuan Lou <mengyuanlou@net-swift.com>
Cc: netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 13 Jul 2023 14:09:11 +0800 you wrote:
> Implement ethtool_ops get_wol and set_wol.
> Implement Wake-on-LAN support.
> 
> Wol requires hardware board support which use sub id
> to identify.
> Magic packets are checked by fw, for now just support
> WAKE_MAGIC.
> 
> [...]

Here is the summary with links:
  - [net-next,v4] net: ngbe: add Wake on Lan support
    https://git.kernel.org/netdev/net-next/c/6963e463256e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



