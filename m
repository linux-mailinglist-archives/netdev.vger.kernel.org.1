Return-Path: <netdev+bounces-35192-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A5A7A786D
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 12:00:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E86A281C7F
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 10:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F635156E0;
	Wed, 20 Sep 2023 10:00:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10EE4156DC
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 10:00:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9E84AC433C7;
	Wed, 20 Sep 2023 10:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695204022;
	bh=IM7wf+gO7ug5DmTUJ0WDo9+W8X+Ab5iJPeLjoBNCR6M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=n3ka9tx6xz56a8a99QnUV2EPaQJZLhJxM14WE+m0wZaB8I7OpBi8x5YWGdFte6BQo
	 Pn0AbABlvqM/bhRLBJKZ7yvI0xPT45woC9uk9hR6TKDnrpuUnZx3zepLg4NbC3dWPm
	 HEOASVS6hS36XBw2Bi9t4LRZ0rCHEKeWNbX+W4sOy/ipWb+B7JXtoQqC+mfiQTA5kk
	 SLYaDSrSdRVIV0DxbcF2MUf+hyiTke0RyLGTu1mNBqhVw5hAC6CawLHAu8e0bNjhJa
	 XxBUmBi1avPGlM6O1tuS4UIrcpubwkTXBRd/b8IoAqjGFEPe0fTekUXjoy62Soh65p
	 4IS5g2UFgnA+Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 863A6C41671;
	Wed, 20 Sep 2023 10:00:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] net: hinic: Fix warning-hinic_set_vlan_fliter() warn:
 variable dereferenced before check 'hwdev'
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169520402254.26831.13294850741304823650.git-patchwork-notify@kernel.org>
Date: Wed, 20 Sep 2023 10:00:22 +0000
References: <20230919022715.6424-1-cai.huoqing@linux.dev>
In-Reply-To: <20230919022715.6424-1-cai.huoqing@linux.dev>
To: Cai Huoqing <cai.huoqing@linux.dev>
Cc: vadim.fedorenko@linux.dev, dan.carpenter@linaro.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 19 Sep 2023 10:27:15 +0800 you wrote:
> 'hwdev' is checked too late and hwdev will not be NULL, so remove the check
> 
> Fixes: 2acf960e3be6 ("net: hinic: Add support for configuration of rx-vlan-filter by ethtool")
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/r/202309112354.pikZCmyk-lkp@intel.com/
> Signed-off-by: Cai Huoqing <cai.huoqing@linux.dev>
> 
> [...]

Here is the summary with links:
  - [v2] net: hinic: Fix warning-hinic_set_vlan_fliter() warn: variable dereferenced before check 'hwdev'
    https://git.kernel.org/netdev/net/c/22b6e7f3d6d5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



