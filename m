Return-Path: <netdev+bounces-85760-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B5789BFC4
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 15:02:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDD921F22CC2
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 13:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4641C7D3F6;
	Mon,  8 Apr 2024 13:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aZcReh+N"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165AB7BAFD
	for <netdev@vger.kernel.org>; Mon,  8 Apr 2024 13:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712581228; cv=none; b=eNoKJby+ccCzBIB/UUc5YwfgCRgHOMRvhcQGF1n3peAtp+BVxkLVEDrp+U1ZmNS2uDsyshWiH7A50N7ps129paLEgjzSLTv6wS4LX5EcP4g4QBID3J+Cqeax0iUplDgRETdYpDSnFf4uZK67036TDV0PGGGi7dbw7HRoVehUwPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712581228; c=relaxed/simple;
	bh=y6vZPoZt1ulbLLsdseWh5p+rOS0K30RZlRcO9RRLmxs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BuM19DLKPTW8690mTdYgP5i7asZWhI9Sk/wbUElbzMQHsTCVZA5oeSm8ssDwGJQ4/124Wbi+rlJJYqatC++lMFQQTbf4ivjtuNpjwEzVFYGb3ewWcYEraOq2rFXEFYNUkchLaeUfJlcgOdGCN0Buy4LzA3uLCpE0Vec1/hcySrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aZcReh+N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C7EFEC43390;
	Mon,  8 Apr 2024 13:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712581227;
	bh=y6vZPoZt1ulbLLsdseWh5p+rOS0K30RZlRcO9RRLmxs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=aZcReh+NnK+NSPRp1bcwSgfHTgehqg2VJsEunF/8IoRKWvVGoetSA2oau8tOP6qC8
	 tA8zvEE5epUbfw3jsumT70Ci/C/v6VRe8eUFr4yM2SwhbxAG+ReSWi46rlBmFavFM8
	 9vfw2cSEzOGnwL2AdtzB8qaHHWw1kQ8l3vtbNupMwAPBAlt0tpjHw/tHjQlQjohfY2
	 4GmO0nl5LqdjaId5PhNGY8I/mdps1oNLTbPg6YhjSEXredGkhM4Tec5PzkMY1xDNsH
	 77AGlYo5+RnHPlVkmKVGH6+g9+rrYl6BZQdgpX8Km/WABFsgGqVK9QoRLY3K6kKccs
	 j07x5IyvyVZdg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C093FC54BD4;
	Mon,  8 Apr 2024 13:00:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/3] bnxt_en: Bug fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171258122778.2224.18057783618226624946.git-patchwork-notify@kernel.org>
Date: Mon, 08 Apr 2024 13:00:27 +0000
References: <20240405235513.64668-1-michael.chan@broadcom.com>
In-Reply-To: <20240405235513.64668-1-michael.chan@broadcom.com>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, pavan.chebbi@broadcom.com,
 andrew.gospodarek@broadcom.com

Hello:

This series was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri,  5 Apr 2024 16:55:10 -0700 you wrote:
> The first 2 patches fix 2 potential issues in the aux bus initialization
> and error recovery paths.  The 3rd patch fixes a potential PTP TX
> timestamp issue during error recovery.
> 
> Pavan Chebbi (1):
>   bnxt_en: Reset PTP tx_avail after possible firmware reset
> 
> [...]

Here is the summary with links:
  - [net,1/3] bnxt_en: Fix possible memory leak in bnxt_rdma_aux_device_init()
    https://git.kernel.org/netdev/net/c/7ac10c7d728d
  - [net,2/3] bnxt_en: Fix error recovery for RoCE ulp client
    https://git.kernel.org/netdev/net/c/b5ea7d33ba2a
  - [net,3/3] bnxt_en: Reset PTP tx_avail after possible firmware reset
    https://git.kernel.org/netdev/net/c/faa12ca24558

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



