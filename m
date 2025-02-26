Return-Path: <netdev+bounces-169683-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B015A453C8
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 04:11:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0730D19C21F0
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 03:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8571B22E3FF;
	Wed, 26 Feb 2025 03:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QIncSe2w"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A89522DF97;
	Wed, 26 Feb 2025 03:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740539414; cv=none; b=YK8BdLrDQjB8QSv4zjkvON7n5EBGrC0QPS72UXeb5X7q9TPqsKYu5WmOtEm6OP47N9XmywnaNNQe6mtCm8pDQGLtlMtN9RDDtC2V+jrXB2skMU+Vx+ZIQPHXlYyTh81yXxK1A7gtQGCsIBzuTwqxUjQijKscPWEMWWYt1uVDiEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740539414; c=relaxed/simple;
	bh=xb1Ws3bRO0blUM9PSeZztd+NuBUlLGUqP26dTAHjMRI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bZml6M/qy3v91m3ZKn2PJtaJOWWiI4tG1MyX3S+PUxEjikYZuSD77OAiLG0Qsk7OBnQ/6ZGIg1O7fjIpjMhRHO+R3F7vj50E0iJHjO2i9CVEBlIDeUT91rKCix4umRQBAAB+q41hQMPL08+rsehzkzmZkOXoaZrCO3j/f0GtsvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QIncSe2w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B8BBC4CEE4;
	Wed, 26 Feb 2025 03:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740539414;
	bh=xb1Ws3bRO0blUM9PSeZztd+NuBUlLGUqP26dTAHjMRI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QIncSe2w0gnj/xTCpk3F9XVaRNXhqsA+m8/u8R2tCNYvDf5VEPKtzhQUqZ9c6Jqfj
	 vaVYu6ffc8zP6ppmTVqvqfSgQFebkPW/1WNc3XRbUYG2Uxj7LncINPvmgFqR9RGQMH
	 nbuB84wOG9uxwlusK/3weIxPEp7iUemebs/5Cs2x7yK8Q/9noQ2Fy+RqMIZbz5SYNY
	 yBkRVuON5r/XXuSPb16hWMHB5cKigpCU4u/y5lW20itPFPFh0RgD69Qww4Ku7duZpK
	 bkwnaW81aVC6ValgPaO9OfsGbIbiCPjnXRv3x7T1TquLFHl0mHdLRl3qtkrNFQWPIx
	 TKIrrQnkodR5Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33AEB380CFDD;
	Wed, 26 Feb 2025 03:10:47 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v5 0/4] Symmetric OR-XOR RSS hash
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174053944574.217003.9851382411515226384.git-patchwork-notify@kernel.org>
Date: Wed, 26 Feb 2025 03:10:45 +0000
References: <20250224174416.499070-1-gal@nvidia.com>
In-Reply-To: <20250224174416.499070-1-gal@nvidia.com>
To: Gal Pressman <gal@nvidia.com>
Cc: davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, tariqt@nvidia.com, ecree.xilinx@gmail.com,
 ahmed.zaki@intel.com, linux-doc@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 24 Feb 2025 19:44:12 +0200 you wrote:
> Add support for a new type of input_xfrm: Symmetric OR-XOR.
> Symmetric OR-XOR performs hash as follows:
> (SRC_IP | DST_IP, SRC_IP ^ DST_IP, SRC_PORT | DST_PORT, SRC_PORT ^ DST_PORT)
> 
> Configuration is done through ethtool -x/X command.
> For mlx5, the default is already symmetric hash, this patch now exposes
> this to userspace and allows enabling/disabling of the feature.
> 
> [...]

Here is the summary with links:
  - [net-next,v5,1/4] ethtool: Symmetric OR-XOR RSS hash
    https://git.kernel.org/netdev/net-next/c/ecdff893384c
  - [net-next,v5,2/4] net/mlx5e: Symmetric OR-XOR RSS hash control
    https://git.kernel.org/netdev/net-next/c/4d20c9f2db83
  - [net-next,v5,3/4] selftests: drv-net: Make rand_port() get a port more reliably
    https://git.kernel.org/netdev/net-next/c/0163250039c3
  - [net-next,v5,4/4] selftests: drv-net-hw: Add a test for symmetric RSS hash
    https://git.kernel.org/netdev/net-next/c/da87cabaf877

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



