Return-Path: <netdev+bounces-42484-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DAB57CED7F
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 03:21:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 412E4280FB3
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 01:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4FDA394;
	Thu, 19 Oct 2023 01:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R7foRs37"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71A253BE
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 01:20:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0E15EC433A9;
	Thu, 19 Oct 2023 01:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697678427;
	bh=4Jt+adihNcDbrT3taeIP8qd1Ar+wSk2WrP9pysQNyF8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=R7foRs37j/z2nEX9bg3YHCThgffIumL6Lg07grvgwoJZmODiQppuaSUElGHHeYls2
	 V5NsJBXhzd5vVWFAPnU2QPfO4To9FuczJ59/eHdwtgQ295HNtJTehviKPbrpSSAFTx
	 b43SH0SNFvVQNfRn8u7/GPdYwnxK9PIQzLv0yXihQQGvlBuHBPAl74A6ZmfRABUoHt
	 vN4KEYZ5uWMPEyOZL4cIeRwnW+Zalk8sqdI0O9/Q1tlNeX/T5YwCGsM2Kdm73C3qek
	 JCAnkJLnjH5baPOhpdDxpCoSoWa200flZZ9RZXb0EUIOV51dyyZm7VBiRoznVhKM7h
	 zsaufl/xroZUg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EE71CC04E27;
	Thu, 19 Oct 2023 01:20:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/9] Intel Wired LAN Driver Updates 2023-10-17
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169767842697.18183.15932552957556598663.git-patchwork-notify@kernel.org>
Date: Thu, 19 Oct 2023 01:20:26 +0000
References: <20231017190411.2199743-1-jacob.e.keller@intel.com>
In-Reply-To: <20231017190411.2199743-1-jacob.e.keller@intel.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 17 Oct 2023 12:04:02 -0700 you wrote:
> This series contains cleanups for all the Intel drivers relating to their
> use of format specifiers and the use of strncpy.
> 
> Jesse fixes various -Wformat warnings across all the Intel networking,
> including various cases where a "%s" string format specifier is preferred,
> and using kasprintf instead of snprintf.
> 
> [...]

Here is the summary with links:
  - [net-next,1/9] intel: fix string truncation warnings
    https://git.kernel.org/netdev/net-next/c/1978d3ead82c
  - [net-next,2/9] intel: fix format warnings
    https://git.kernel.org/netdev/net-next/c/d97af2440a0c
  - [net-next,3/9] e100: replace deprecated strncpy with strscpy
    https://git.kernel.org/netdev/net-next/c/7677f635bf80
  - [net-next,4/9] e1000: replace deprecated strncpy with strscpy
    https://git.kernel.org/netdev/net-next/c/341359e034e4
  - [net-next,5/9] fm10k: replace deprecated strncpy with strscpy
    https://git.kernel.org/netdev/net-next/c/48b238461b90
  - [net-next,6/9] i40e: use scnprintf over strncpy+strncat
    https://git.kernel.org/netdev/net-next/c/be39d0a61aed
  - [net-next,7/9] igb: replace deprecated strncpy with strscpy
    https://git.kernel.org/netdev/net-next/c/95e71e35e635
  - [net-next,8/9] igbvf: replace deprecated strncpy with strscpy
    https://git.kernel.org/netdev/net-next/c/a6c78d5f8d5d
  - [net-next,9/9] igc: replace deprecated strncpy with strscpy
    https://git.kernel.org/netdev/net-next/c/d10d64ad01db

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



