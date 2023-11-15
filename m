Return-Path: <netdev+bounces-47942-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC3A7EC0A6
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 11:30:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F530B20C8F
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 10:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C5CEDF51;
	Wed, 15 Nov 2023 10:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CoT8AobS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287E6FBF2
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 10:30:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B0CDEC433C8;
	Wed, 15 Nov 2023 10:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700044226;
	bh=Vc4nsd6ka1LNOyAVrVBoa92MLDgHLso/pLWqy/mJRk4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CoT8AobSKCWe7yMd3ymdtef3OuPXLj2644BhJpoowcfO3PRgur6doD35AzZpRpLfa
	 fdTTYt9Wwmls32Po34UUMxkEk84p1KXQP/AJmEVGGHiBB6nLn/O4RZzJ/P5QVID3YV
	 1Hks4ADhXzXl1nKYH9v6EX0ZF+V7xy8tWlGbdnup81Mut0saefUu+5pQDT7HdEXs4D
	 r9opGRdLOMIfu7ibDuBPLbz64PlfeOxdxx9m1gawPc6SAQ/6si2iGZRaqfcrV2EyHb
	 uH/h+cOg1N+SUMJ9szjaJDhcImjNjS5xerJ7j8y+PPhubfCP9mZZoQ4NLN/3VWsURv
	 5cftRq75E69UQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 91FB8E1F66F;
	Wed, 15 Nov 2023 10:30:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 00/13] bnxt_en: TX path improvements
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170004422659.6186.11675832716561991871.git-patchwork-notify@kernel.org>
Date: Wed, 15 Nov 2023 10:30:26 +0000
References: <20231114001621.101284-1-michael.chan@broadcom.com>
In-Reply-To: <20231114001621.101284-1-michael.chan@broadcom.com>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, gospo@broadcom.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 13 Nov 2023 16:16:08 -0800 you wrote:
> All patches in this patchset are related to improving the TX path.
> There are 2 areas of improvements:
> 
> 1. The TX interrupt logic currently counts the number of TX completions
> to determine the number of TX SKBs to free.  We now change it so that
> the TX completion will now contain the hardware consumer index
> information.  The driver will keep track of the latest hardware
> consumer index from the last TX completion and clean up all TX SKBs
> up to that index.  This scheme aligns better with future chips and
> allows xmit_more code path to be more optimized.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,01/13] bnxt_en: Put the TX producer information in the TX BD opaque field
    https://git.kernel.org/netdev/net-next/c/34eec1f29a59
  - [net-next,v2,02/13] bnxt_en: Add completion ring pointer in TX and RX ring structures
    https://git.kernel.org/netdev/net-next/c/7f0a168b0441
  - [net-next,v2,03/13] bnxt_en: Restructure cp_ring_arr in struct bnxt_cp_ring_info
    https://git.kernel.org/netdev/net-next/c/d1eec614100c
  - [net-next,v2,04/13] bnxt_en: Add completion ring pointer in TX and RX ring structures
    https://git.kernel.org/netdev/net-next/c/7845b8dfc713
  - [net-next,v2,05/13] bnxt_en: Remove BNXT_RX_HDL and BNXT_TX_HDL
    https://git.kernel.org/netdev/net-next/c/9c0b06de6fb6
  - [net-next,v2,06/13] bnxt_en: Refactor bnxt_tx_int()
    https://git.kernel.org/netdev/net-next/c/ebf72319cef6
  - [net-next,v2,07/13] bnxt_en: New encoding for the TX opaque field
    https://git.kernel.org/netdev/net-next/c/5a3c585fa83f
  - [net-next,v2,08/13] bnxt_en: Refactor bnxt_hwrm_set_coal()
    https://git.kernel.org/netdev/net-next/c/877edb347323
  - [net-next,v2,09/13] bnxt_en: Support up to 8 TX rings per MSIX
    https://git.kernel.org/netdev/net-next/c/0589a1ed4d33
  - [net-next,v2,10/13] bnxt_en: Add helper to get the number of CP rings required for TX rings
    https://git.kernel.org/netdev/net-next/c/f5b29c6afe36
  - [net-next,v2,11/13] bnxt_en: Add macros related to TC and TX rings
    https://git.kernel.org/netdev/net-next/c/f07b58801bef
  - [net-next,v2,12/13] bnxt_en: Use existing MSIX vectors for all mqprio TX rings
    https://git.kernel.org/netdev/net-next/c/ba098017791e
  - [net-next,v2,13/13] bnxt_en: Optimize xmit_more TX path
    https://git.kernel.org/netdev/net-next/c/c1056a59aee1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



