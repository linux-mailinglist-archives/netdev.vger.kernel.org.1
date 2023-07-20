Return-Path: <netdev+bounces-19334-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C514275A4F9
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 06:10:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7ED11281C0F
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 04:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 909E01843;
	Thu, 20 Jul 2023 04:10:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF9210F7
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 04:10:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BDA74C433C7;
	Thu, 20 Jul 2023 04:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689826220;
	bh=IzrPItfPXPpMIbx0STLZY2Pu3dc+0+0YpMqGv8v3fcY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UtsfIDM3Txbg2oLqd0n7XqCizvSl09XEKpZnAhCrte4JcBtXWIS6R9s7G9Ac21+Cl
	 Y2MRlVDx0mFRO/1061wkPA0R3hTsNKhDadrHLnBO6244B7rODveVWinonY1nX/unZy
	 KnjiU80iVVCveXCbGWB4R9u8H0TJryOEOhrAuC+w7Xrcr89vwYkXQu7W0Niygh/WIh
	 ISuPctJcNZJwTVmzRBbpP8tU1gQtoOHCaK4RCPeYAqnGKL2JD689mF70Zh/vqTT1Jp
	 bxY7Q+JFVwsPTdyIhf1HFCfQXhtXA0VyiGLELdkMoetkJjn+24npuCNTGhm3YRQjqB
	 J2zYSZOhTdrVw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9D82FE21EFE;
	Thu, 20 Jul 2023 04:10:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/3] clean up the FEC driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168982622064.10021.16174389409619192350.git-patchwork-notify@kernel.org>
Date: Thu, 20 Jul 2023 04:10:20 +0000
References: <20230718090928.2654347-1-wei.fang@nxp.com>
In-Reply-To: <20230718090928.2654347-1-wei.fang@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, xiaoning.wang@nxp.com, shenwei.wang@nxp.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-imx@nxp.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 18 Jul 2023 17:09:25 +0800 you wrote:
> When reading the codes of the FEC driver recently, I found there are
> some redundant or invalid codes, these codes make the FEC driver a
> bit messy and not concise, so this patch set has cleaned up the FEC
> driver. At present, I only found these, but I believe these are not
> all, I will continue to clean up the FEC driver in the future.
> 
> Wei Fang (3):
>   net: fec: remove the remaining code of rx copybreak
>   net: fec: remove fec_set_mac_address() from fec_enet_init()
>   net: fec: remove unused members from struct fec_enet_private
> 
> [...]

Here is the summary with links:
  - [net-next,1/3] net: fec: remove the remaining code of rx copybreak
    https://git.kernel.org/netdev/net-next/c/3b23ecd53ab5
  - [net-next,2/3] net: fec: remove fec_set_mac_address() from fec_enet_init()
    https://git.kernel.org/netdev/net-next/c/36bde9c1accb
  - [net-next,3/3] net: fec: remove unused members from struct fec_enet_private
    https://git.kernel.org/netdev/net-next/c/636a5e88233a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



