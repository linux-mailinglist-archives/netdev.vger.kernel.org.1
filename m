Return-Path: <netdev+bounces-24308-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5843076FBB5
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 10:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 878431C20A12
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 08:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74C0E8BFC;
	Fri,  4 Aug 2023 08:10:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B56848E
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 08:10:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A1DE8C433CB;
	Fri,  4 Aug 2023 08:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691136621;
	bh=YZNe9yQeBFUem9NuaEnUAGWF5xNRlgYGY0hSbJMMoVU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lWgdqsyRWkHhMBGxNnJlT1TrUkZQ3JoCO8ezc1Rwm12HWnwGfktyiLyiw6845hmwV
	 OYP/liHSaJmwr1C4pJa39aFM8NtD9MmzAJ5XmGX8uBaqhB53dJwniP7Wdz0YvtQdaX
	 E+gmigPhrRyCemggFQiqBr++EAVupUJatvbtMmQ6+0pN8M7MbXwaevrSWx2JqUK61i
	 8nvWvYmnrey5bCh+ionB+VQt3wIJuoIbzBxMvtx7vwJ8PBR8Tyz38eH37gT+3AURwH
	 Yu3y4MF3akGZepWa0Zlpl28ETXztchHPrVR1yWMjf25W8jr8UDoI+CAyAVUa4GhMwT
	 ro9EoPH8W+UdQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8386AC6445B;
	Fri,  4 Aug 2023 08:10:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH V6 net-next] net: mana: Configure hwc timeout from hardware
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169113662153.21944.15547696025000936680.git-patchwork-notify@kernel.org>
Date: Fri, 04 Aug 2023 08:10:21 +0000
References: <1690974460-15660-1-git-send-email-schakrabarti@linux.microsoft.com>
In-Reply-To: <1690974460-15660-1-git-send-email-schakrabarti@linux.microsoft.com>
To: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, longli@microsoft.com,
 sharmaajay@microsoft.com, leon@kernel.org, cai.huoqing@linux.dev,
 ssengar@linux.microsoft.com, vkuznets@redhat.com, tglx@linutronix.de,
 linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
 schakrabarti@microsoft.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed,  2 Aug 2023 04:07:40 -0700 you wrote:
> At present hwc timeout value is a fixed value. This patch sets the hwc
> timeout from the hardware. It now uses a new hardware capability
> GDMA_DRV_CAP_FLAG_1_HWC_TIMEOUT_RECONFIG to query and set the value
> in hwc_timeout.
> 
> Signed-off-by: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
> 
> [...]

Here is the summary with links:
  - [V6,net-next] net: mana: Configure hwc timeout from hardware
    https://git.kernel.org/netdev/net-next/c/62c1bff593b7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



