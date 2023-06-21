Return-Path: <netdev+bounces-12464-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A507379D4
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 05:41:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53E041C20D46
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 03:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F66379DE;
	Wed, 21 Jun 2023 03:40:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB70023BC
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 03:40:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3239BC433CC;
	Wed, 21 Jun 2023 03:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687318822;
	bh=0lRN5FnZLtCRTf6vn1eHcW7i4WruP/CJ51DKHEgN0M8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OCZa9nIj9DpB7wGlcvDTww8yIe1cWqwucCf8NAVI+Y2HhOl8pbn45M+ruoo/Mtwzk
	 oy0vg0LyIQCLJcxAUfTbqRI3JZDmqGjqFz0c/tYFQvtAc8Yju9J8TzC/LJQPR7t2ns
	 5jSm1rmdPdqahj08Gd4OZ3xgXLFz6hUltb6j8ThhdC08pBbtuzIfHSx0lRjpO2XYo+
	 KJsn5YuLZbyXCxaI9SCvldOmJQpw1H+79KotzKFfSehTsCY8BBWROIP2lzWE+tOXpG
	 rePqg1OwFTFCHG88UNeliV2AnSJ1FchO7VII1DZRtvIOZ0T5LFWmm1AecEGyFxNh0R
	 pKY0Akq3U1mKQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0FCC5E301FA;
	Wed, 21 Jun 2023 03:40:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/3] [v2] sfc: add CONFIG_INET dependency for TC offload
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168731882206.8371.11751260150778183648.git-patchwork-notify@kernel.org>
Date: Wed, 21 Jun 2023 03:40:22 +0000
References: <20230619091215.2731541-1-arnd@kernel.org>
In-Reply-To: <20230619091215.2731541-1-arnd@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: ecree.xilinx@gmail.com, habetsm.xilinx@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 simon.horman@corigine.com, pieter.jansen-van-vuuren@amd.com, arnd@arndb.de,
 jiri@resnulli.us, alejandro.lucero-palau@amd.com, netdev@vger.kernel.org,
 linux-net-drivers@amd.com, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 19 Jun 2023 11:12:09 +0200 you wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The driver now fails to link when CONFIG_INET is disabled, so
> add an explicit Kconfig dependency:
> 
> ld.lld: error: undefined symbol: ip_route_output_flow
> >>> referenced by tc_encap_actions.c
> >>>               drivers/net/ethernet/sfc/tc_encap_actions.o:(efx_tc_flower_create_encap_md) in archive vmlinux.a
> 
> [...]

Here is the summary with links:
  - [1/3,v2] sfc: add CONFIG_INET dependency for TC offload
    https://git.kernel.org/netdev/net-next/c/40cba83370c2
  - [2/3,v2] sfc: fix uninitialized variable use
    https://git.kernel.org/netdev/net-next/c/f61d2d5cf142
  - [3/3] sfc: selftest: fix struct packing
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



