Return-Path: <netdev+bounces-28676-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB4AF7803C2
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 04:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAF711C2159C
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 02:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41AD3810;
	Fri, 18 Aug 2023 02:20:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E1B808
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 02:20:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1476CC433C9;
	Fri, 18 Aug 2023 02:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692325222;
	bh=27VysPV0b8V0Dz5HI05dWn4hEmm68QsycKK4shFWNOg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lkdv/HAD3Z633T+7leOzXI00YBnp8BzsKKePmYPTudjyTsO8NiXUyriLzW/4q0oVL
	 a9bbBUDwo+5YTRovN0WVSrNMslv3h8bbPjJZwbsQ3QCccxVAfBYqESHqwpn/RnlPIX
	 6vakAblATYWSUddBNR2adiXQGMvbpUV90FUY+2m4eMXpGygDqe6jJWyS3tVTUOJGYK
	 HRlrSPXKKnzADPZr77Tta+q69W0r3XYMyyJo9Y66n1XNe90uQ7kpg96oDe916SSyUs
	 rIDnyXd24Cf+8+mpvCorhA1wLAoX5ysMWeEmloE8fTvp7fNbY9YAuvcukDL4rN+0RQ
	 YcdAXmQR6+iSw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EAC9DE1F65A;
	Fri, 18 Aug 2023 02:20:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: ena: Use pci_dev_id() to simplify the code
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169232522195.19288.14355057199725554158.git-patchwork-notify@kernel.org>
Date: Fri, 18 Aug 2023 02:20:21 +0000
References: <20230815024248.3519068-1-zhangjialin11@huawei.com>
In-Reply-To: <20230815024248.3519068-1-zhangjialin11@huawei.com>
To: Jialin Zhang <zhangjialin11@huawei.com>
Cc: shayagr@amazon.com, akiyano@amazon.com, darinzon@amazon.com,
 ndagan@amazon.com, saeedb@amazon.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 michal.kubiak@intel.com, yuancan@huawei.com, netdev@vger.kernel.org,
 liwei391@huawei.com, wangxiongfeng2@huawei.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 15 Aug 2023 10:42:48 +0800 you wrote:
> PCI core API pci_dev_id() can be used to get the BDF number for a pci
> device. We don't need to compose it mannually. Use pci_dev_id() to
> simplify the code a little bit.
> 
> Signed-off-by: Jialin Zhang <zhangjialin11@huawei.com>
> ---
>  drivers/net/ethernet/amazon/ena/ena_netdev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - net: ena: Use pci_dev_id() to simplify the code
    https://git.kernel.org/netdev/net-next/c/a5e5b2cd47bc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



