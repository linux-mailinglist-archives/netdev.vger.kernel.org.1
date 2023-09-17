Return-Path: <netdev+bounces-34334-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EC1B7A353F
	for <lists+netdev@lfdr.de>; Sun, 17 Sep 2023 12:50:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD7852817EA
	for <lists+netdev@lfdr.de>; Sun, 17 Sep 2023 10:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F37A1C03;
	Sun, 17 Sep 2023 10:50:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79DB51877
	for <netdev@vger.kernel.org>; Sun, 17 Sep 2023 10:50:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CA31EC433C9;
	Sun, 17 Sep 2023 10:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694947823;
	bh=CMtmMxdUogLfRM9R7ZNNpC792BuEHfgBvqskvqLykqY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eNr5gaK68+L7d/1QAt0K9JCEMnzAMuCsglu+dhxjYtd6rksHFrznukoAQMV1HdZ9f
	 lD7/rijh3PYLzh8pTy7pqpJlrRkLKnM+31z/TRkVl0qUJPNKEXPsJP1kTGR43AVYMK
	 R1lK0JsjmJTTnOugXldBxKehGloUC+iESgThK/4h4XQyOMVMSMAqFVz6saFMGXA8SN
	 3J4KxGHeSytXNCE3ZWa2DRai6gbrUp03ORlJXGS1qv0ngoummC64MQvceqS/koa+nr
	 TlC2pD0El9OikfPhum3sw0lXxeibFAzpXXhYfiyH+rNM0HJ2W1yP3Hn+iOS0/hN9Pk
	 V62/zq3MyP7tg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B1027E26888;
	Sun, 17 Sep 2023 10:50:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/4][pull request] Support rx-fcs on/off for VFs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169494782372.17507.7665703462615733458.git-patchwork-notify@kernel.org>
Date: Sun, 17 Sep 2023 10:50:23 +0000
References: <20230913180334.2116162-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20230913180334.2116162-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, ahmed.zaki@intel.com

Hello:

This series was applied to netdev/net-next.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Wed, 13 Sep 2023 11:03:30 -0700 you wrote:
> Ahmed Zaki says:
> 
> Allow the user to turn on/off the CRC/FCS stripping through ethtool. We
> first add the CRC offload capability in the virtchannel, then the feature
> is enabled in ice and iavf drivers.
> 
> We make sure that the netdev features are fixed such that CRC stripping
> cannot be disabled if VLAN rx offload (VLAN strip) is enabled. Also, VLAN
> stripping cannot be enabled unless CRC stripping is ON.
> 
> [...]

Here is the summary with links:
  - [net-next,1/4] virtchnl: Add CRC stripping capability
    https://git.kernel.org/netdev/net-next/c/89de9921dfa7
  - [net-next,2/4] ice: Support FCS/CRC strip disable for VF
    https://git.kernel.org/netdev/net-next/c/730cb741815c
  - [net-next,3/4] ice: Check CRC strip requirement for VLAN strip
    https://git.kernel.org/netdev/net-next/c/7bd48d8d414b
  - [net-next,4/4] iavf: Add ability to turn off CRC stripping for VF
    https://git.kernel.org/netdev/net-next/c/7559d6724298

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



