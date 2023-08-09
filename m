Return-Path: <netdev+bounces-26031-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B82D0776996
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 22:11:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 713D6281D9F
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 20:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C91501CA06;
	Wed,  9 Aug 2023 20:10:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449DE24532
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 20:10:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CA799C433C8;
	Wed,  9 Aug 2023 20:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691611825;
	bh=piYt+g9sntga2HkUgHLh+f1vH/zN1FuQNEVIgkh3ct8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kYv7HleFv74VVQS713U5YyUl0XkSzP8XW7Wc9omRLw1hTBvQ0kLoPCTuIzOD2+d3I
	 bCtrjkrOP14gFiKaJ78vH4jJlqqYpQUhIj8Hitr172KN9BHuf9WqCSvKSfemUbCcOI
	 4hbeDF3/nEH4T4+jqnS7Pzwi4FmIXpU6R3ZOd2W6H7p1IxRfqpZW0y11BgUpNDJuPL
	 6wsNKoKyvqh+MI7hsrDUV3jooR4QisL2UP0pTUkkUjQWRb1SZXLc9eex1Cs/yGECGY
	 Y8w5Vkhhhpa5Nh9zWQQ5XRTwVPPRYOD6xkchUG6XkbEk58pfA6Lu/+cV7OxaRb95LP
	 Y4zBoPRSg9PCQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AB599E33090;
	Wed,  9 Aug 2023 20:10:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: txgbe: Use pci_dev_id() to simplify the code
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169161182569.10541.796625748475203323.git-patchwork-notify@kernel.org>
Date: Wed, 09 Aug 2023 20:10:25 +0000
References: <20230808024931.147048-1-wangxiongfeng2@huawei.com>
In-Reply-To: <20230808024931.147048-1-wangxiongfeng2@huawei.com>
To: Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc: jiawenwu@trustnetic.com, mengyuanlou@net-swift.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 maciej.fijalkowski@intel.com, andrew@lunn.ch, piotr.raczynski@intel.com,
 netdev@vger.kernel.org, yangyingliang@huawei.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 8 Aug 2023 10:49:31 +0800 you wrote:
> PCI core API pci_dev_id() can be used to get the BDF number for a pci
> device. We don't need to compose it mannually. Use pci_dev_id() to
> simplify the code a little bit.
> 
> Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
> ---
>  drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Here is the summary with links:
  - net: txgbe: Use pci_dev_id() to simplify the code
    https://git.kernel.org/netdev/net-next/c/d8c21ef7b2b1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



