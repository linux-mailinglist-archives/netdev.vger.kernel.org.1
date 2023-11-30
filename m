Return-Path: <netdev+bounces-52371-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 137CE7FE82E
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 05:10:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8BEEB20BF4
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 04:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68B7A1641F;
	Thu, 30 Nov 2023 04:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uhbqsAox"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF3213FED
	for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 04:10:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CAEACC433C9;
	Thu, 30 Nov 2023 04:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701317430;
	bh=7JVNHmT810vuDew3NxLvYmkKo0/YnDg0jFaNOHL8u+g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uhbqsAoxmu5vEe0xV3DJhCd++IlwkOXPhcH19aQxuyNntYDW+9HT96G+LGofeLhOa
	 +5LGtz1vwZn1gWE5oofrIUkMiqxlBlT4pNervZvZW3uEyugMDnrB2ajubG4I0SOjr1
	 XNVVpTDu7EvPLyap0TVUIhkw/PVV4gHqKr3PM+Wm1+3nrbPO5/FTxRjE9IXAspLRSN
	 2SlU3Q1o+E9qGc/qL5CyjiT6KIukbgAGLKt3y8mz3aRA3k/EryqCwd+cahlaAr4kw9
	 zLiPU5RuZI1ouPJSSGs9xstYx5AgtN7gNjLSpdGjicvenO/e6BdRPzAeRttRM82MUv
	 9aBZ3OwrEONdQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AD97EE00092;
	Thu, 30 Nov 2023 04:10:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next PATCH v3] net: phy: aquantia: drop wrong endianness
 conversion for addr and CRC
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170131743070.26382.14989467541066978129.git-patchwork-notify@kernel.org>
Date: Thu, 30 Nov 2023 04:10:30 +0000
References: <20231128135928.9841-1-ansuelsmth@gmail.com>
In-Reply-To: <20231128135928.9841-1-ansuelsmth@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 robimarko@gmail.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 lkp@intel.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 28 Nov 2023 14:59:28 +0100 you wrote:
> On further testing on BE target with kernel test robot, it was notice
> that the endianness conversion for addr and CRC in fw_load_memory was
> wrong.
> 
> Drop the cpu_to_le32 conversion for addr load as it's not needed.
> 
> Use get_unaligned_le32 instead of get_unaligned for FW data word load to
> correctly convert data in the correct order to follow system endian.
> 
> [...]

Here is the summary with links:
  - [net-next,v3] net: phy: aquantia: drop wrong endianness conversion for addr and CRC
    https://git.kernel.org/netdev/net-next/c/7edce370d87a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



