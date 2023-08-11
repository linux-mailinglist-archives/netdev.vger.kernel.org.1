Return-Path: <netdev+bounces-26612-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CCB3778593
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 04:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CE94281B77
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 02:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E97DA5A;
	Fri, 11 Aug 2023 02:40:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4963A3D
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 02:40:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 43959C433C9;
	Fri, 11 Aug 2023 02:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691721622;
	bh=8pjrAMowRecTQnBYiomoSdxswD2PcA8CPzJpmXC+nQ8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qDpPgI/aQZ7JzJQECVJb2zMsBpe5sbkdLidjQoOGwPz4wHFxfegdqW4H318RQBEuX
	 1GCW8eSSb7em36WPDKK10NfTEANpy47iUeelxU8UtxBZPgU4vDunLMl82Qm8d3xf+Q
	 QFGYaejGoBDv3//cFTkju3Vb+KfuLm05I3UPyZwbFCmnoNP79XzD+xgsNQfCcmWGBM
	 e0FX5HrcmSfNoekzui1y4HHdoDluf+4lItRemqUHnIEIwdXqGu30icTNDLRkMph7R9
	 Pga61NbiEihg+pjOP6hBEO/atIcJafWg3lhqLNL2HHPHjVsZIMYjSChpGC0HTRbBSm
	 +ZlUBmmEtPWJw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2BE19C595D0;
	Fri, 11 Aug 2023 02:40:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: ethernet: 8390: ne2k-pci: use
 module_pci_driver() macro
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169172162217.18522.5852758556516414389.git-patchwork-notify@kernel.org>
Date: Fri, 11 Aug 2023 02:40:22 +0000
References: <20230810014633.3084355-1-yangyingliang@huawei.com>
In-Reply-To: <20230810014633.3084355-1-yangyingliang@huawei.com>
To: Yang Yingliang <yangyingliang@huawei.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 10 Aug 2023 09:46:33 +0800 you wrote:
> The driver init/exit() function don't do anything special, it
> can use the module_pci_driver() macro to eliminate boilerplate
> code.
> 
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  drivers/net/ethernet/8390/ne2k-pci.c | 16 +---------------
>  1 file changed, 1 insertion(+), 15 deletions(-)

Here is the summary with links:
  - [net-next] net: ethernet: 8390: ne2k-pci: use module_pci_driver() macro
    https://git.kernel.org/netdev/net-next/c/5604ac35cb6e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



