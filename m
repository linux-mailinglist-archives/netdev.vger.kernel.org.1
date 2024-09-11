Return-Path: <netdev+bounces-127197-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66228974891
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 05:20:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14A2E1F26967
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 03:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B55937171;
	Wed, 11 Sep 2024 03:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s3w0zgxE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3581A3398B
	for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 03:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726024832; cv=none; b=GkENF4TEDmYhnsfgyLpfaEPvWwznlYMyorQFEdmSJdieZwk74yuULB1A+cCgRS0P1chyV5JHuKA9V+lxGjlv+99fwG9WkDtasOFeGOf9jfEvWo4HyykR8X1pEuAK6XDjTOJGP7SoVIgXNmjZTFZlEJqzXHXdINRub8EkONKKdw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726024832; c=relaxed/simple;
	bh=WN6jyE6vub/qOYYjPRys+gkvPSxcvv6MD1fnNL5Er98=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jLKVcFHtz/zZZ63xP9w99PyYRv7LZJZ+ECU8krPxkPQiEhgcsjIDsRF4ulBtOmHN9DYHwMbUwppxwpHfZCb/raVsOCdyhnlxRPHUXjaoruBZOkO7HNlgL6+nPMzJN1doyi8pL4JcuSoQ2m1hKlLxW7XvJg8bn9IdKkBdJjgritY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s3w0zgxE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADDB3C4CEC5;
	Wed, 11 Sep 2024 03:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726024831;
	bh=WN6jyE6vub/qOYYjPRys+gkvPSxcvv6MD1fnNL5Er98=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=s3w0zgxEsED5VArBVFOBMqTk1U0xScy2hpDmAAA+IlG4p4XwjZpTKz+Q6PnB81CRe
	 GXaHwtj0CJbHI3yAnQtL3y0fl4VTlLEmeTlb1ZnhaofBHCO+JgS7g0DtD8prFucvw8
	 NWBCAW+vUsbsSAMu3CFFwvpEHJ6eCWiV27XZre/xH1cpbocnaXIi3z40VGmqkggbHP
	 kl51lhEbPO28zyH95MkBXs12MWDFzb8tV1rQASOCv2Hz8j8m515Sb2iy7cTdnGQQL4
	 5uDWyIQf71kt9UPBKdcXS7G1sIKRAp5GcZjRZNhfkODk12uPX2kvJA5fCQJi8DTnA0
	 HbAaWZs1paS5w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD4C3822FA4;
	Wed, 11 Sep 2024 03:20:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net 1/7] net/mlx5: Update the list of the PCI supported devices
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172602483277.473764.10914302582891504021.git-patchwork-notify@kernel.org>
Date: Wed, 11 Sep 2024 03:20:32 +0000
References: <20240909194505.69715-2-saeed@kernel.org>
In-Reply-To: <20240909194505.69715-2-saeed@kernel.org>
To: Saeed Mahameed <saeed@kernel.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, saeedm@nvidia.com, netdev@vger.kernel.org,
 tariqt@nvidia.com, gal@nvidia.com, leonro@nvidia.com, msanalla@nvidia.com

Hello:

This series was applied to netdev/net.git (main)
by Saeed Mahameed <saeedm@nvidia.com>:

On Mon,  9 Sep 2024 12:44:59 -0700 you wrote:
> From: Maher Sanalla <msanalla@nvidia.com>
> 
> Add the upcoming ConnectX-9 device ID to the table of supported
> PCI device IDs.
> 
> Fixes: f908a35b2218 ("net/mlx5: Update the list of the PCI supported devices")
> Signed-off-by: Maher Sanalla <msanalla@nvidia.com>
> Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
> Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
> 
> [...]

Here is the summary with links:
  - [net,1/7] net/mlx5: Update the list of the PCI supported devices
    https://git.kernel.org/netdev/net/c/7472d157cb80
  - [net,2/7] net/mlx5e: Add missing link modes to ptys2ethtool_map
    https://git.kernel.org/netdev/net/c/7617d62cba4a
  - [net,3/7] net/mlx5e: Add missing link mode to ptys2ext_ethtool_map
    https://git.kernel.org/netdev/net/c/80bf474242b2
  - [net,4/7] net/mlx5: Explicitly set scheduling element and TSAR type
    https://git.kernel.org/netdev/net/c/c88146abe4d0
  - [net,5/7] net/mlx5: Add missing masks and QoS bit masks for scheduling elements
    https://git.kernel.org/netdev/net/c/452ef7f86036
  - [net,6/7] net/mlx5: Verify support for scheduling element and TSAR type
    https://git.kernel.org/netdev/net/c/861cd9b9cb62
  - [net,7/7] net/mlx5: Fix bridge mode operations when there are no VFs
    https://git.kernel.org/netdev/net/c/b1d305abef46

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



