Return-Path: <netdev+bounces-61432-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EB49823A85
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 03:10:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49B511C249AB
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 02:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F6871FB3;
	Thu,  4 Jan 2024 02:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IC1iJk4x"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06274443E
	for <netdev@vger.kernel.org>; Thu,  4 Jan 2024 02:10:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CC429C433C7;
	Thu,  4 Jan 2024 02:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704334229;
	bh=pAAWsW1q6RTZ31xrua2PV7HZpIAKS49xYIxXQwMJiq8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IC1iJk4xxVYVkTjA8gMSLpI/t/8uctAzc1/ybFdkabGDnnnmElt78DHASeykLNrxS
	 mjV4DxqvwnBboel3rMaTrPDdSVFBPRvF/B3Xh3MFLNsAZ3tRuzcqFLUnWq2aafRTEo
	 HD5/Z2X3b62AQIj0LQ/+WgDqyOVjVAMo6nEIlUFLjt0L1PoeXs64sSSBHuwVMpVxOF
	 ejF0fTfgfv9ZcpBJX5I8NI5bvsrgrTUrjEeM0nWj6cGYMrsurLNE3bPWK+fV9rMMh2
	 6K/dOog+Muuvm2uDSuDENGDBWnpC+DPgtb2caECpgEuBa/dTcmUvn/S44M9rIElK4y
	 VcwrTZL+Fb1Cw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B7EB7DCB6FF;
	Thu,  4 Jan 2024 02:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next 00/11] ENA driver XDP changes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170433422974.9915.18424626064538917734.git-patchwork-notify@kernel.org>
Date: Thu, 04 Jan 2024 02:10:29 +0000
References: <20240101190855.18739-1-darinzon@amazon.com>
In-Reply-To: <20240101190855.18739-1-darinzon@amazon.com>
To: Arinzon@codeaurora.org, David <darinzon@amazon.com>
Cc: davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
 dwmw@amazon.com, zorik@amazon.com, matua@amazon.com, saeedb@amazon.com,
 msw@amazon.com, aliguori@amazon.com, nafea@amazon.com, netanel@amazon.com,
 alisaidi@amazon.com, benh@amazon.com, akiyano@amazon.com, ndagan@amazon.com,
 shayagr@amazon.com, itzko@amazon.com, osamaabb@amazon.com,
 evostrov@amazon.com, ofirt@amazon.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 1 Jan 2024 19:08:44 +0000 you wrote:
> From: David Arinzon <darinzon@amazon.com>
> 
> This patchset contains multiple XDP-related changes
> in the ENA driver, including moving the XDP code to
> dedicated files.
> 
> Changes in v2:
> - Moved changes to right commits in order to avoid compilation errors
> 
> [...]

Here is the summary with links:
  - [v2,net-next,01/11] net: ena: Move XDP code to its new files
    https://git.kernel.org/netdev/net-next/c/d000574d0287
  - [v2,net-next,02/11] net: ena: Pass ena_adapter instead of net_device to ena_xmit_common()
    https://git.kernel.org/netdev/net-next/c/39a044f4dcfe
  - [v2,net-next,03/11] net: ena: Put orthogonal fields in ena_tx_buffer in a union
    https://git.kernel.org/netdev/net-next/c/009b387659d3
  - [v2,net-next,04/11] net: ena: Introduce total_tx_size field in ena_tx_buffer struct
    https://git.kernel.org/netdev/net-next/c/23ec97498026
  - [v2,net-next,05/11] net: ena: Use tx_ring instead of xdp_ring for XDP channel TX
    https://git.kernel.org/netdev/net-next/c/911a8c960110
  - [v2,net-next,06/11] net: ena: Don't check if XDP program is loaded in ena_xdp_execute()
    https://git.kernel.org/netdev/net-next/c/436c79358595
  - [v2,net-next,07/11] net: ena: Refactor napi functions
    https://git.kernel.org/netdev/net-next/c/b626fd9627d4
  - [v2,net-next,08/11] net: ena: Add more debug prints to XDP related function
    https://git.kernel.org/netdev/net-next/c/2b02e332c151
  - [v2,net-next,09/11] net: ena: Always register RX queue info
    https://git.kernel.org/netdev/net-next/c/ea5c460023aa
  - [v2,net-next,10/11] net: ena: Make queue stats code cleaner by removing the if block
    https://git.kernel.org/netdev/net-next/c/4f28e789be76
  - [v2,net-next,11/11] net: ena: Take xdp packets stats into account in ena_get_stats64()
    https://git.kernel.org/netdev/net-next/c/782345d24874

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



