Return-Path: <netdev+bounces-161309-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC2D8A209D7
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 12:40:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 277DC1668F7
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 11:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B76C1A0BC9;
	Tue, 28 Jan 2025 11:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bh/ZuZl7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155CD19ABAB
	for <netdev@vger.kernel.org>; Tue, 28 Jan 2025 11:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738064407; cv=none; b=dBGvE8q9QBGmOLd2RxB2wVa2k8dKObhvBzGYVy8lLqAeZ4ExMqSxy3BCrMppCBiT/e0S4pzOfAkQDorem/FXlIcNntTVvc/gXcCrVvgND6iGJaOCd/Rtis3Ja4g91b09AZAdoA1J0w11vNTiX7Aq+PAlOf31vnbCYOGr6bTq2v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738064407; c=relaxed/simple;
	bh=9fMn3dnfpUZ94RXl8wLGSN2m2fLQSUrk8Mbppo14IYs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bPjSBTHtWHhp8e1psMruS1UhrcYXCv2wG1ZKedk7a7ZMB6oiKytn6BcFOy9TFIiO3di2n6XJl0G1zBGZz0o1c4W7xqFlfJrpn8BZtWTieX+jLCePlpRPBbQQf1qiww8B+lKDbT2X7DFSTe9T6ctBPzs32/ONSV2DSx9mVbSDcyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bh/ZuZl7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F6DFC4CED3;
	Tue, 28 Jan 2025 11:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738064406;
	bh=9fMn3dnfpUZ94RXl8wLGSN2m2fLQSUrk8Mbppo14IYs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Bh/ZuZl7wUN1QgBJuLQhe3LXxquONEo7TuH+Ed7LLKDtai38GSfxGyMoYn8jHuAvi
	 kInBmwKCXiDQUsoWSXvGLuEAz4Fu0lwT50wdEDc1F/gGwb2gNcXhftsLpuw0RloPfV
	 E8ra8ubpLtUC6vDhISA1IAPCGZEVndPm0AMTY+fE+m+NoMjbYxJK3ju8mEOFT8+CBt
	 UDVGpwXeHhosCwv8TchGsWR38/1zEAgWIBmSgtOBE26123tdPZg1BuFnhzSlDn7NQE
	 p/16hF4mDFe7xFQh5Up9r2KtLA/UTPiVy0HmLBYCP8GOz+DckmdcxW3OoRcjChW8Kn
	 We9RHs8THnw1Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70EDA380AA66;
	Tue, 28 Jan 2025 11:40:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ethtool: Fix set RXNFC command with symmetric RSS hash
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173806443227.3766242.421041889613188874.git-patchwork-notify@kernel.org>
Date: Tue, 28 Jan 2025 11:40:32 +0000
References: <20250126191845.316589-1-gal@nvidia.com>
In-Reply-To: <20250126191845.316589-1-gal@nvidia.com>
To: Gal Pressman <gal@nvidia.com>
Cc: davem@davemloft.net, kuba@kernel.org, horms@kernel.org,
 ecree.xilinx@gmail.com, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, ahmed.zaki@intel.com, tariqt@nvidia.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sun, 26 Jan 2025 21:18:45 +0200 you wrote:
> The sanity check that both source and destination are set when symmetric
> RSS hash is requested is only relevant for ETHTOOL_SRXFH (rx-flow-hash),
> it should not be performed on any other commands (e.g.
> ETHTOOL_SRXCLSRLINS/ETHTOOL_SRXCLSRLDEL).
> 
> This resolves accessing uninitialized 'info.data' field, and fixes false
> errors in rule insertion:
>   # ethtool --config-ntuple eth2 flow-type ip4 dst-ip 255.255.255.255 action -1 loc 0
>   rmgr: Cannot insert RX class rule: Invalid argument
>   Cannot insert classification rule
> 
> [...]

Here is the summary with links:
  - [net] ethtool: Fix set RXNFC command with symmetric RSS hash
    https://git.kernel.org/netdev/net/c/4f5a52adeb1a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



