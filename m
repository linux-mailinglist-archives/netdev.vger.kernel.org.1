Return-Path: <netdev+bounces-117711-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4D7E94EDF6
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 15:20:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61EB5284CD7
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 13:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E208017BB3D;
	Mon, 12 Aug 2024 13:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TdF1lh6o"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2CD1D699
	for <netdev@vger.kernel.org>; Mon, 12 Aug 2024 13:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723468834; cv=none; b=Coex2Nwe6cXXVfyTvUivyYO9NKaigxxVSGDDLTWBjWuHSw2b0SxCEUuB0YABSl50IUsUKkgOMruW3JNFdDii+GzC8xYfEdQczY5fy1Yrl0kZZr7oJ/Jd9UFsyUsC9OJlpKgzkBYMwQH5m2qpRYatX3BVdew3UjwcC1qj0rG33OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723468834; c=relaxed/simple;
	bh=+020HrR4MBP5uoKg8f7G9My+Jaeg/Tuu75tFzORbkZc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EULuz3d1w2zqx+g71qJyJm02xW+IpyFX+tNE3rs7+B3vjTsZRh9KvLkreX8x6QIbjEMP4MeDG3VYLfF4CqJ73A6vhl3t0+LNX5kvLpRMdPEZVltS2Sqcae1mb0/TGUDdtRJmMi+J1QS7ChDbMsOCIqVmOLuvl6g7tvn8hi2wT/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TdF1lh6o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F3F2C32782;
	Mon, 12 Aug 2024 13:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723468834;
	bh=+020HrR4MBP5uoKg8f7G9My+Jaeg/Tuu75tFzORbkZc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TdF1lh6o0KYwHYblI/z8MQyxzt6QK22qFyXMKByPMN2OmYY2aLLVIRfP3XPwsrUN3
	 PkikIeRYr6N4h8gryTGVg5SEm3x1GoYuB5uNZVZAc1KjT5G3e93RSPJGpWa5+bUjF8
	 XsmRtzyetG7wFhLQPAm1XCBj+amY1arkE/JgeYNIyb1bfR+L8h6NE+XMBhqqOrP2+K
	 8qskyRFp2Qc3jOcNCKfDvZUQWOXYbQppKmUbcp6G9LEYOATQZt7Z5kGrJol2i6bSvN
	 jve76L9O8JLARp9akLUCTVFRVbmFSyI96vsmrw1uErNBdq9p4ETfIPrY99Y/rG+Z6N
	 1NGkmgqslxjSg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70F20382332D;
	Mon, 12 Aug 2024 13:20:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v5 00/12] ethtool: rss: driver tweaks and netlink
 context dumps
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172346883299.1022466.11800069202302120676.git-patchwork-notify@kernel.org>
Date: Mon, 12 Aug 2024 13:20:32 +0000
References: <20240810053728.2757709-1-kuba@kernel.org>
In-Reply-To: <20240810053728.2757709-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, michael.chan@broadcom.com, shuah@kernel.org,
 ecree.xilinx@gmail.com, przemyslaw.kitszel@intel.com, ahmed.zaki@intel.com,
 andrew@lunn.ch, willemb@google.com, pavan.chebbi@broadcom.com,
 petrm@nvidia.com, gal@nvidia.com, jdamato@fastly.com, donald.hunter@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri,  9 Aug 2024 22:37:16 -0700 you wrote:
> This series is a semi-related collection of RSS patches.
> Main point is supporting dumping RSS contexts via ethtool netlink.
> At present additional RSS contexts can be queried one by one, and
> assuming user know the right IDs. This series uses the XArray
> added by Ed to provide netlink dump support for ETHTOOL_GET_RSS.
> 
> Patch 1 is a trivial selftest debug patch.
> Patch 2 coverts mvpp2 for no real reason other than that I had
> 	a grand plan of converting all drivers at some stage.
> Patch 3 removes a now moot check from mlx5 so that all tests
> 	can pass.
> Patch 4 and 5 make a bit used for context support optional,
> 	for easier grepping of drivers which need converting
> 	if nothing else.
> Patch 6 OTOH adds a new cap bit; some devices don't support
> 	using a different key per context and currently act
> 	in surprising ways.
> Patch 7 and 8 update the RSS netlink code to use XArray.
> Patch 9 and 10 add support for dumping contexts.
> Patch 11 and 12 are small adjustments to spec and a new test.
> 
> [...]

Here is the summary with links:
  - [net-next,v5,01/12] selftests: drv-net: rss_ctx: add identifier to traffic comments
    https://git.kernel.org/netdev/net-next/c/10fbe8c082fd
  - [net-next,v5,02/12] eth: mvpp2: implement new RSS context API
    https://git.kernel.org/netdev/net-next/c/f203fd85e666
  - [net-next,v5,03/12] eth: mlx5: allow disabling queues when RSS contexts exist
    https://git.kernel.org/netdev/net-next/c/a7f6f56f604a
  - [net-next,v5,04/12] ethtool: make ethtool_ops::cap_rss_ctx_supported optional
    https://git.kernel.org/netdev/net-next/c/ce056504e2e5
  - [net-next,v5,05/12] eth: remove .cap_rss_ctx_supported from updated drivers
    https://git.kernel.org/netdev/net-next/c/fb770fe7584f
  - [net-next,v5,06/12] ethtool: rss: don't report key if device doesn't support it
    https://git.kernel.org/netdev/net-next/c/ec6e57beaf8b
  - [net-next,v5,07/12] ethtool: rss: move the device op invocation out of rss_prepare_data()
    https://git.kernel.org/netdev/net-next/c/a7ddfd5d5703
  - [net-next,v5,08/12] ethtool: rss: report info about additional contexts from XArray
    https://git.kernel.org/netdev/net-next/c/bb87f2c7968e
  - [net-next,v5,09/12] ethtool: rss: support dumping RSS contexts
    https://git.kernel.org/netdev/net-next/c/f6122900f4e2
  - [net-next,v5,10/12] ethtool: rss: support skipping contexts during dump
    https://git.kernel.org/netdev/net-next/c/3d50c66c0609
  - [net-next,v5,11/12] netlink: specs: decode indirection table as u32 array
    https://git.kernel.org/netdev/net-next/c/8ad3be135212
  - [net-next,v5,12/12] selftests: drv-net: rss_ctx: test dumping RSS contexts
    https://git.kernel.org/netdev/net-next/c/c1ad8ef804e4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



