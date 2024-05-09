Return-Path: <netdev+bounces-94831-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5808C8C0D03
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 11:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13A63281FF7
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 09:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4660714A0B1;
	Thu,  9 May 2024 09:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q9nFlMXz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1EF149C7C;
	Thu,  9 May 2024 09:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715245230; cv=none; b=Q+R+P/UThgzRi4LuDZE1BNkmHGL41fxyYAjqvgz5vmZGh2ZwtaAifd3p5FzrBzUyaqwC3mvlQ3ssdP94q4ADa8f67uXxjY/S5PzxjzrSfEVIUNye9EJrHvhtAcNWN6ZNrl53ySF4sBbTP2KOjxjiJuOUg4cvXrorgnu7gN2Ktl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715245230; c=relaxed/simple;
	bh=1bw+AV7yOayLR8BA8955PiotGL1IEXnI0/nmhHgiWxg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=o5aO6Y+YayHofFUTEfRy/YpRHFnXCPxViETP1W9CMw7XOKsZTjaBneMyrJX87rD5woupwmScxhrdawPl2j1Nolr9U2YreGBMu22X9g7e9UZrKh3p9sbnBRPu0BHBxATGya8cne5FQCiiaA18DR5be3QYL0m1maMeWsi5lOCbO6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q9nFlMXz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A9C21C2BBFC;
	Thu,  9 May 2024 09:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715245229;
	bh=1bw+AV7yOayLR8BA8955PiotGL1IEXnI0/nmhHgiWxg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=q9nFlMXz+BCOUhlzbXkHFKsuFBpp19NrDQckaRCnhKEDj9LUBYl14j5Tun6Snlxbc
	 f4IY8z8LVYNOP1xYvuRONIvOP2VKTP7ib0FeVlBMzN2iFNFfHbooZpFwO0xilk24ax
	 5TPuqlHBb1/JLmNVk48KzeQc0nvOMGQXOhHPdExtVMCnPMfYB4RDRCnj6cEH0NaHmN
	 Ubnl5GejZOTNRXfPMB+a7cZPtMXP9PX6IgJlskPAfn/SbZooRLtNz1vtB4Wh+Apvm9
	 S34/JAID593BtrRpixV2kkQWDSdOyYjSZQ+VentD5EHKvzuJW79efe05ibXlIlTFUE
	 oBBK1MOIl2kDw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 992FFE7C112;
	Thu,  9 May 2024 09:00:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH V3 net 0/7] There are some bugfix for the HNS3 ethernet driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171524522962.30298.276584443025659640.git-patchwork-notify@kernel.org>
Date: Thu, 09 May 2024 09:00:29 +0000
References: <20240507134224.2646246-1-shaojijie@huawei.com>
In-Reply-To: <20240507134224.2646246-1-shaojijie@huawei.com>
To: Jijie Shao <shaojijie@huawei.com>
Cc: yisen.zhuang@huawei.com, salil.mehta@huawei.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jiri@resnulli.us,
 horms@kernel.org, shenjian15@huawei.com, wangjie125@huawei.com,
 liuyonglong@huawei.com, chenhao418@huawei.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 7 May 2024 21:42:17 +0800 you wrote:
> There are some bugfix for the HNS3 ethernet driver
> 
> ---
> changeLog:
> v2 -> v3:
>   - Fix coding errors in "net: hns3: using user configure after hardware reset", suggested by Simon Horman
>   https://lore.kernel.org/all/20240426100045.1631295-1-shaojijie@huawei.com/
> v1 -> v2:
>   - Adjust the code sequence to completely eliminate the race window, suggested by Jiri Pirko
>   v1: https://lore.kernel.org/all/20240422134327.3160587-1-shaojijie@huawei.com/
> 
> [...]

Here is the summary with links:
  - [V3,net,1/7] net: hns3: using user configure after hardware reset
    https://git.kernel.org/netdev/net/c/05eb60e9648c
  - [V3,net,2/7] net: hns3: direct return when receive a unknown mailbox message
    https://git.kernel.org/netdev/net/c/669554c512d2
  - [V3,net,3/7] net: hns3: change type of numa_node_mask as nodemask_t
    https://git.kernel.org/netdev/net/c/6639a7b95321
  - [V3,net,4/7] net: hns3: release PTP resources if pf initialization failed
    https://git.kernel.org/netdev/net/c/950aa4239989
  - [V3,net,5/7] net: hns3: use appropriate barrier function after setting a bit value
    https://git.kernel.org/netdev/net/c/094c28122852
  - [V3,net,6/7] net: hns3: fix port vlan filter not disabled issue
    https://git.kernel.org/netdev/net/c/f5db7a3b65c8
  - [V3,net,7/7] net: hns3: fix kernel crash when devlink reload during initialization
    https://git.kernel.org/netdev/net/c/35d92abfbad8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



