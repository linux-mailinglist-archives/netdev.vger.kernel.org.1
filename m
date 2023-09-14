Return-Path: <netdev+bounces-33821-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 687637A0599
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 15:30:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A154E2818FE
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 13:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33CD1219E5;
	Thu, 14 Sep 2023 13:30:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59AA9241E0
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 13:30:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C07CFC433C9;
	Thu, 14 Sep 2023 13:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694698226;
	bh=7qdT8Z03n9r1d1GaZSfNQjF3IV3q0w3dQF+2ArONS0M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=E94X8LIxPkFRN+ntDy8pZduJ6AvAkF2p2IQWrclj/8S1939hpXSqsE4UQf19m04Tw
	 ie/C7wg9Df68h2h0HKU2Bcf3ySEzfAUJvbfIZPN0X8dTwzyddxFNZ3nzTQXbAopIll
	 01civ4dXn0WLxY6ZBIrowTEhnU7JReHwSLThLvgPiawUKK5pUtWUofzNsFMBJbNXcK
	 KTuTgeDoO2rQ0/Rd5llwiO3PDbQ1jn29P3Idxn+bOmf82N6+g94nQd0TLuO3ftG42b
	 JKumveq6QxBqIemjaTbIQvJCAB9cxKtb2eIvmAMSwbGyTOPVF4Z2JtjmkuOxwur6jM
	 UR+W1MRY3LcdA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A1E9DE1C28E;
	Thu, 14 Sep 2023 13:30:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: wangxun: move MDIO bus implementation to the
 library
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169469822665.5094.6762261233034281757.git-patchwork-notify@kernel.org>
Date: Thu, 14 Sep 2023 13:30:26 +0000
References: <20230912031424.721386-1-jiawenwu@trustnetic.com>
In-Reply-To: <20230912031424.721386-1-jiawenwu@trustnetic.com>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, andrew@lunn.ch, mengyuanlou@net-swift.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 12 Sep 2023 11:14:24 +0800 you wrote:
> Move similar code of accessing MDIO bus from txgbe/ngbe to libwx.
> 
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> ---
>  drivers/net/ethernet/wangxun/libwx/wx_hw.c    |  92 ++++++++++++++
>  drivers/net/ethernet/wangxun/libwx/wx_hw.h    |   7 ++
>  drivers/net/ethernet/wangxun/libwx/wx_type.h  |   1 +
>  drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c | 119 +-----------------
>  drivers/net/ethernet/wangxun/ngbe/ngbe_type.h |   3 -
>  .../net/ethernet/wangxun/txgbe/txgbe_phy.c    |  56 +--------
>  6 files changed, 106 insertions(+), 172 deletions(-)

Here is the summary with links:
  - [net-next] net: wangxun: move MDIO bus implementation to the library
    https://git.kernel.org/netdev/net-next/c/f55752402945

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



