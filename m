Return-Path: <netdev+bounces-26702-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5649E7789FB
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 11:32:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F4CC1C216D4
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 09:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B00FC5679;
	Fri, 11 Aug 2023 09:30:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5FF63A3
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 09:30:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 83001C433C7;
	Fri, 11 Aug 2023 09:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691746223;
	bh=nXsL5D2SmR6PQ342tmIlwaCeQ8RW15hutcZ3pzvhXps=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=vFJZvuQZA3Q0urn7AXMvUTE3+di+0mGaQTSWA1u7LtOg/+LoNq/bYsV72l0+lEDWV
	 JHM6Mr42PJn0yb65hfg3hlJ1MXAD6IFcgb9R91nSOQ0WQqfbQ52p1UTOs4JyLhDiHe
	 MDhGJopTxJMlcuQw7sIVejEwiD1T48VyvfcEfJvCCqxRpN6XD85AW3Elrg59ca2DOE
	 tYfy7zF3/lHuo5I8jq8j68mBnp8WXiFD+icFjnMD2iUEpBAQP5n7HCS4RmwVwy5/F+
	 gEBLEulGhaNwEOFjT8Rn8IHsca5xV1L/lqQgj9a/uyBnrkWpfa4nVd8qx3Ao7fRm7V
	 vt4QwTJls/YVQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 62BCCC3274B;
	Fri, 11 Aug 2023 09:30:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: pcs: Add missing put_device call in miic_create
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169174622340.8242.5529034838264885270.git-patchwork-notify@kernel.org>
Date: Fri, 11 Aug 2023 09:30:23 +0000
References: <20230810140639.2129454-1-xiangyang@huaweicloud.com>
In-Reply-To: <20230810140639.2129454-1-xiangyang@huaweicloud.com>
To: Xiang Yang <xiangyang@huaweicloud.com>
Cc: clement.leger@bootlin.com, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, olteanv@gmail.com, f.fainelli@gmail.com,
 linux-renesas-soc@vger.kernel.org, netdev@vger.kernel.org,
 xiangyang3@huawei.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 10 Aug 2023 22:06:39 +0800 you wrote:
> From: Xiang Yang <xiangyang3@huawei.com>
> 
> The reference of pdev->dev is taken by of_find_device_by_node, so
> it should be released when not need anymore.
> 
> Fixes: 7dc54d3b8d91 ("net: pcs: add Renesas MII converter driver")
> Signed-off-by: Xiang Yang <xiangyang3@huawei.com>
> 
> [...]

Here is the summary with links:
  - [net,v2] net: pcs: Add missing put_device call in miic_create
    https://git.kernel.org/netdev/net/c/829c6524d672

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



