Return-Path: <netdev+bounces-236952-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55D44C425AB
	for <lists+netdev@lfdr.de>; Sat, 08 Nov 2025 04:21:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B51CB3AC46A
	for <lists+netdev@lfdr.de>; Sat,  8 Nov 2025 03:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 189592D3A7B;
	Sat,  8 Nov 2025 03:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ge52T5Wv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80D22D29CE
	for <netdev@vger.kernel.org>; Sat,  8 Nov 2025 03:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762572066; cv=none; b=gV255Dp5qamG9qG3aYwNK+uXyIyZQ8OSjmRmqEnJ5fswSvpSu+rVYjqxJENPuUf7Kdq0faTK7MTEbtFnbvg7um1KNFg5XBFFqDEcq8iC9mQ7OxdXHbhKZf5qf/wW95B4r+VR4ewP5JFbQ4RlBlKO2PRBimt73KbPiBnEZyp+7ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762572066; c=relaxed/simple;
	bh=1ypZ0K0HG870g1PRrIh9q2XL9y+td7ZsG/LcoLT30KM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Zh0Kd3ORcsZPLZzvfwfbuyxZwPfYXveTV24gmU8hLD/g7eehf3P8H3YoQ+njCeNQky/5PgNjUAOlnG91kL4VR/Qig3Uu7dgM7XDU4ZZ9cmkDjoGmwRsA7R+o7qU/pglnExcV0UJziZB7HHBDBFa/bQuSV4xTKgooO4YTyocU1oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ge52T5Wv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75E1AC4CEFB;
	Sat,  8 Nov 2025 03:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762572064;
	bh=1ypZ0K0HG870g1PRrIh9q2XL9y+td7ZsG/LcoLT30KM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ge52T5WvSez8JXvPUqcRK4ReIjZoKidtSO0O2UOsCm8bydx0UbPh7pHGD1Qu849lS
	 mI+HhK6pMzfp+41aZWZ0o5HaHGP3O0VFY4XgXKO+nhMWGQVlaA/9SWn6KUflpiPZXE
	 rRqBIg1g5A/9bxgRcHIDpUdN3+81Xo2Lxld9Lx2mnEZ6Qb2Ibak5DgEusOC/wzcLhK
	 S7SkQFXgHiPMrsLX5FF2jn5vij5T3p94KlkybNQ4dM9B3vsxHMuWbrsafH7VkfXbVs
	 tRV2aMonVSpUo3CET7g7bjlmw55sQLc0DELCt/kUj7REjX2Oc6rUCAtem9hMiOz8wg
	 iSYmB/3HVRcZw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE8C3A40FCA;
	Sat,  8 Nov 2025 03:20:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/8][pull request] Intel Wired LAN Driver Updates
 2025-11-06 (i40, ice, iavf)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176257203649.1236021.10430486598233853122.git-patchwork-notify@kernel.org>
Date: Sat, 08 Nov 2025 03:20:36 +0000
References: <20251106225321.1609605-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20251106225321.1609605-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 jacob.e.keller@intel.com

Hello:

This series was applied to netdev/net-next.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Thu,  6 Nov 2025 14:53:09 -0800 you wrote:
> Mohammad Heib introduces a new devlink parameter, max_mac_per_vf, for
> controlling the maximum number of MAC address filters allowed by a VF. This
> allows administrators to control the VF behavior in a more nuanced manner.
> 
> Aleksandr and Przemek add support for Receive Side Scaling of GTP to iAVF
> for VFs running on E800 series ice hardware. This improves performance and
> scalability for virtualized network functions in 5G and LTE deployments.
> 
> [...]

Here is the summary with links:
  - [net-next,1/8] devlink: Add new "max_mac_per_vf" generic device param
    https://git.kernel.org/netdev/net-next/c/9352d40c8bcd
  - [net-next,2/8] i40e: support generic devlink param "max_mac_per_vf"
    https://git.kernel.org/netdev/net-next/c/2c031d4c772f
  - [net-next,3/8] ice: add flow parsing for GTP and new protocol field support
    https://git.kernel.org/netdev/net-next/c/12ed3e5a03a8
  - [net-next,4/8] ice: add virtchnl definitions and static data for GTP RSS
    https://git.kernel.org/netdev/net-next/c/38724a474c0f
  - [net-next,5/8] ice: implement GTP RSS context tracking and configuration
    https://git.kernel.org/netdev/net-next/c/3a6d87e2eaac
  - [net-next,6/8] ice: improve TCAM priority handling for RSS profiles
    https://git.kernel.org/netdev/net-next/c/f89e4e151233
  - [net-next,7/8] ice: Extend PTYPE bitmap coverage for GTP encapsulated flows
    https://git.kernel.org/netdev/net-next/c/41e880eb8482
  - [net-next,8/8] iavf: add RSS support for GTP protocol via ethtool
    https://git.kernel.org/netdev/net-next/c/3da28eb277c1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



