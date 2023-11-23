Return-Path: <netdev+bounces-50605-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E74487F6497
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 18:00:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1C15280FFE
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 17:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8AB23FB2A;
	Thu, 23 Nov 2023 17:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nu4zFTA6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82F224B53
	for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 17:00:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8ACBAC433CB;
	Thu, 23 Nov 2023 17:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700758826;
	bh=sq9a7agLBKvujsPVZbWmPWMEPPyZt0vkGZvkg2sAwDM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nu4zFTA6IbjtFqP8JW506Dqo6xPbJS2RLYSMpm2y48v/tKhtlSIMgk7YnL/FvN6Ph
	 G1W9fQqbS9n0iOOJ97pJYjPQG8p3B+A1pzp1iYblUtgj1a38t6GJJsegcH65rJXblP
	 NtrehgItcQFV5u4D5HtONWtPOs9yqogK1JvP0r19PXMXtMBy/S0O8JQ1G25Gdz4yaG
	 iltnq0IS/ftOAsvuLmHH7MzWwaI/O4BBIAFmRWBWA7LL+wnewg9CVMu58gKCtcViix
	 gDSe8NHkmF+wP7+pjOXI2OcJf/7Ac7i2Zxc4CjM37qYd1kbN9Ev6G9mhXcesfTNP7p
	 m0J3ZqqKrJ3Ew==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7448EC3959E;
	Thu, 23 Nov 2023 17:00:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: axienet: Fix check for partial TX checksum
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170075882647.541.11957078215794048376.git-patchwork-notify@kernel.org>
Date: Thu, 23 Nov 2023 17:00:26 +0000
References: <20231122004219.3504219-1-samuel.holland@sifive.com>
In-Reply-To: <20231122004219.3504219-1-samuel.holland@sifive.com>
To: Samuel Holland <samuel.holland@sifive.com>
Cc: radhey.shyam.pandey@amd.com, ariane.keller@tik.ee.ethz.ch,
 daniel@iogearbox.net, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, michal.simek@amd.com, pabeni@redhat.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 21 Nov 2023 16:42:17 -0800 you wrote:
> Due to a typo, the code checked the RX checksum feature in the TX path.
> 
> Fixes: 8a3b7a252dca ("drivers/net/ethernet/xilinx: added Xilinx AXI Ethernet driver")
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> ---
> 
>  drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [net] net: axienet: Fix check for partial TX checksum
    https://git.kernel.org/netdev/net/c/fd0413bbf8b1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



