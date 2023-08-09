Return-Path: <netdev+bounces-26049-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 474B4776A95
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 23:00:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0263281D7E
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 21:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED6411D2F1;
	Wed,  9 Aug 2023 21:00:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0DF1C9E7
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 21:00:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 516DEC433C7;
	Wed,  9 Aug 2023 21:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691614822;
	bh=SOoTGlb3BDAlzV5cEM78sSIMwW7YvSVduLTCKopqddg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VRfj6DKAwQKW+ubWdzAyBrq+h5ktb2Uu7HZIA/7JNN0Gw+GXSAlwvPcW50vCCa8eE
	 Eet/JcAi70e1dct2K5IaRWpYzVr5GZRvLoIMuRMgOOL8XQqA3StbtmDuyrl50LnTFp
	 hoWlipEeg3UFb3R/bGRVkn2Sz4N0Jhlpqpq/4KkpurExnZzoMOXGlw/keF5sAp5tAs
	 Zu+xODHhAJe2s5Nq8WZokFrV/1t32Ae5BiH3YtdbRtzx2GkRvYyp/UZsWy64/p5uia
	 LuqnHyKYbhBnmdZIZHQMM/xellFmTZjCwcv/oHKAQLo+HN7inrnuCNHT78ppzOUWC3
	 O1MxSoj2/W+Zg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 36DC5C64459;
	Wed,  9 Aug 2023 21:00:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] vlan: Fix VLAN 0 memory leak
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169161482221.5018.952158660366415659.git-patchwork-notify@kernel.org>
Date: Wed, 09 Aug 2023 21:00:22 +0000
References: <20230808093521.1468929-1-vladbu@nvidia.com>
In-Reply-To: <20230808093521.1468929-1-vladbu@nvidia.com>
To: Vlad Buslov <vladbu@nvidia.com>
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org, amir.hanania@intel.com,
 jeffrey.t.kirsher@intel.com, john.fastabend@gmail.com, idosch@idosch.org,
 horms@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 8 Aug 2023 11:35:21 +0200 you wrote:
> The referenced commit intended to fix memleak of VLAN 0 that is implicitly
> created on devices with NETIF_F_HW_VLAN_CTAG_FILTER feature. However, it
> doesn't take into account that the feature can be re-set during the
> netdevice lifetime which will cause memory leak if feature is disabled
> during the device deletion as illustrated by [0]. Fix the leak by
> unconditionally deleting VLAN 0 on NETDEV_DOWN event.
> 
> [...]

Here is the summary with links:
  - [net,v2] vlan: Fix VLAN 0 memory leak
    https://git.kernel.org/netdev/net/c/718cb09aaa6f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



