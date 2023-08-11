Return-Path: <netdev+bounces-26679-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71BC27788F6
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 10:30:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A30061C20E26
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 08:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 956CC53AD;
	Fri, 11 Aug 2023 08:30:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C37566C
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 08:30:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A8808C433C7;
	Fri, 11 Aug 2023 08:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691742625;
	bh=8EiBU0dz3H/OF6RAEDWOyCtT82/SNchJZhI3Ln0ixxs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Hj/thrbdncW4krp955lsmSzCPrQeXps4r2tIa1V//XZ7NfK1XUxl0JcJsf4h9UJ4n
	 k1cTFAGBWzfrsnQe2KxN4k/r1G99rPIKNLL1MlDtLFatEadJixv6CnJfUDP2A4UDoO
	 Gfn4ZEFytofAnZwg1x/ppJXg50ecvyHVb6MUp1SoVjfZwUY0eVudJQ0RkTgSn5MHEE
	 H0ZP4QNnpLc5x5kiX00ZS+G93rFUffWC/14Isx2xyx/4Z2dE11Gr0rQ8AJzkOkhjZp
	 i8inZdAyQzT+PPLZr1ZwQ4xF9gmRHSNoxmQWfvLfco3C89l6mpYQFDnABqHIWLyGKy
	 ZWlMF8KhoW3pA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 881B9C395C5;
	Fri, 11 Aug 2023 08:30:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] octeontx2-af: Harden rule validation.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169174262555.27025.15639158467197706342.git-patchwork-notify@kernel.org>
Date: Fri, 11 Aug 2023 08:30:25 +0000
References: <20230809064039.1167803-1-rkannoth@marvell.com>
In-Reply-To: <20230809064039.1167803-1-rkannoth@marvell.com>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 sgoutham@marvell.com, lcherian@marvell.com, gakula@marvell.com,
 jerinj@marvell.com, hkelam@marvell.com, sbhatta@marvell.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 9 Aug 2023 12:10:39 +0530 you wrote:
> Accept TC offload classifier rule only if SPI field
> can be extracted by HW.
> 
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
> ---
>  drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Here is the summary with links:
  - [net-next] octeontx2-af: Harden rule validation.
    https://git.kernel.org/netdev/net-next/c/12aa0a3b93f3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



