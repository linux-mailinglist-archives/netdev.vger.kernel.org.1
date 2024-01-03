Return-Path: <netdev+bounces-61067-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E3758225F5
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 01:30:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 163591F20FD0
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 00:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59B1865E;
	Wed,  3 Jan 2024 00:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MX5RtoZG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40CE123C7
	for <netdev@vger.kernel.org>; Wed,  3 Jan 2024 00:30:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BE8D2C43395;
	Wed,  3 Jan 2024 00:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704241830;
	bh=POeBsNcajkb12/kN/B1eM94dYMSabah6byb5HVx0E4M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MX5RtoZG0TVuZPlVKpoZw5pKg4m4IAaBckete4gDJdCvdfhwNHB0tt1FoHcm7huOJ
	 agPD3/u1WQj1nsjz0xXt17wNS9ALD+BeIzjiMx5wQ1XRoOfLuvP1qvexKyj6VpjWe7
	 x71ftTmMKHI2aeqmLLU2ZV502ypIXaYBeAJipneWktJr1ickvwaTcg6KKv3VT/B7jC
	 GfNV4zhhfW0X64dl833fQC5DWltsa9Dv+pOYBj9DjcLWQwEtX++Il3SUEPF1F8n2qQ
	 oGTmQbHWOkIb8fPCjlPkg+YNcyY+g89nUEfXEONs+5DKPjFdS4LYgMqeVVMTEcWnDy
	 tWHim0xAG37QQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A23E5DCB6D1;
	Wed,  3 Jan 2024 00:30:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: ethtool: Fix symmetric-xor RSS RX flow hash
 check
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170424183066.18204.11995325820650497392.git-patchwork-notify@kernel.org>
Date: Wed, 03 Jan 2024 00:30:30 +0000
References: <20231226205536.32003-1-gerhard@engleder-embedded.com>
In-Reply-To: <20231226205536.32003-1-gerhard@engleder-embedded.com>
To: Gerhard Engleder <gerhard@engleder-embedded.com>
Cc: ahmed.zaki@intel.com, netdev@vger.kernel.org, davem@davemloft.net,
 kuba@kernel.org, edumazet@google.com, pabeni@redhat.com, jia.guo@intel.com,
 jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com, horms@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 26 Dec 2023 21:55:36 +0100 you wrote:
> Commit 13e59344fb9d ("net: ethtool: add support for symmetric-xor RSS hash")
> adds a check to the ethtool set_rxnfc operation, which checks the RX
> flow hash if the flag RXH_XFRM_SYM_XOR is set. This flag is introduced
> with the same commit. It calls the ethtool get_rxfh operation to get the
> RX flow hash data. If get_rxfh is not supported, then EOPNOTSUPP is
> returned.
> 
> [...]

Here is the summary with links:
  - [net-next] net: ethtool: Fix symmetric-xor RSS RX flow hash check
    https://git.kernel.org/netdev/net-next/c/501869fecfbc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



