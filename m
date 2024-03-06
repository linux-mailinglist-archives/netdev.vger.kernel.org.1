Return-Path: <netdev+bounces-77870-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D854C873456
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 11:34:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8754BB2639F
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 10:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B62360B91;
	Wed,  6 Mar 2024 10:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b721zG2J"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A8C60B8B
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 10:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709721029; cv=none; b=OOXCtjJRkQwrluvGnWCJEcWZz7l9Eix51ouqXCeITXr4gdEhaIARI0nBONBp2mgMjin4Dps+k2JiqU39q3blYAtATRP/S2uo4AO6IcQ2nTqC4B4B2ABSYv4BwwPkTFie9TSFlw2tw7GCf/Lz3sQbU/XhSG0kIIX0haCUNeWNVUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709721029; c=relaxed/simple;
	bh=fbT0n1kW69sksQbxATExcO2OfwYK4tW5K5SienuZMWI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UuHaMwM/O0xjrj3eNikeqEYwMwUz3PXSXuJN/7wFOY/uNXr0KcdmJ1r4Xkh+upWGR5PdjkpLPuc3PGbTAcMCTRMmwh7ZcMzgMDvzC6Xd2NL2yuMvevrVZqfdFHeqBzNCiGEEzSo2QDKbkK36G9kxmh4RkgTCwqLxV2nZ8sCHMdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b721zG2J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B788AC43394;
	Wed,  6 Mar 2024 10:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709721028;
	bh=fbT0n1kW69sksQbxATExcO2OfwYK4tW5K5SienuZMWI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=b721zG2JsD/Bjz+DUSZPZOIHZ8/ZVcmgrXBuAwm97HdGBuXC+07p94QmFwzNdihOA
	 L/7fur7nPIjKBtp+NtBT8+lU6aK0C7eF2oTxk0NPVTF0RxCh2/smpLwwdKBgx602Jj
	 BzCsfbh7FkWzwzHJfZnd1uFd1aqt8e1+2THxQVt687JV8or1C7TciUXCxcbkPKVpov
	 lgUtvFpG4bBB0rYP+lM5UjEph3d5bTii7jztRl8KKWxltu7cyzjXfbb7y1w/RhP9KS
	 rkY215Fig/x4tHCf6guK59CLbGadWTO/SoUQJTaUZML5Zot7xa9TqD2K1oxgKCFTLN
	 AFi3vPgCKOOtA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9EE19D88F80;
	Wed,  6 Mar 2024 10:30:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/8][pull request] Intel Wired LAN Driver Updates
 2024-03-05 (idpf, ice, i40e, igc, e1000e)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170972102864.17397.8507912109620128467.git-patchwork-notify@kernel.org>
Date: Wed, 06 Mar 2024 10:30:28 +0000
References: <20240305185737.3925349-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20240305185737.3925349-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Tue,  5 Mar 2024 10:57:28 -0800 you wrote:
> This series contains updates to idpf, ice, i40e, igc and e1000e drivers.
> 
> Emil disables local BH on NAPI schedule for proper handling of softirqs
> on idpf.
> 
> Jake stops reporting of virtchannel RSS option which in unsupported on
> ice.
> 
> [...]

Here is the summary with links:
  - [net,1/8] idpf: disable local BH when scheduling napi for marker packets
    https://git.kernel.org/netdev/net/c/330068589389
  - [net,2/8] ice: virtchnl: stop pretending to support RSS over AQ or registers
    https://git.kernel.org/netdev/net/c/2652b99e4340
  - [net,3/8] net: ice: Fix potential NULL pointer dereference in ice_bridge_setlink()
    https://git.kernel.org/netdev/net/c/06e456a05d66
  - [net,4/8] ice: fix uninitialized dplls mutex usage
    https://git.kernel.org/netdev/net/c/9224fc86f177
  - [net,5/8] ice: fix typo in assignment
    https://git.kernel.org/netdev/net/c/6c5b6ca7642f
  - [net,6/8] i40e: Fix firmware version comparison function
    https://git.kernel.org/netdev/net/c/36c824ca3e4f
  - [net,7/8] igc: avoid returning frame twice in XDP_REDIRECT
    https://git.kernel.org/netdev/net/c/ef27f655b438
  - [net,8/8] intel: legacy: Partial revert of field get conversion
    https://git.kernel.org/netdev/net/c/ba54b1a276a6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



