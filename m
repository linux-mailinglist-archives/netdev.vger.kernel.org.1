Return-Path: <netdev+bounces-182525-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6218DA8900A
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 01:20:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C17C2189B247
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 23:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B8F81F417D;
	Mon, 14 Apr 2025 23:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oCaaE14K"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD6D1C861C
	for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 23:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744672802; cv=none; b=J60C4GWkcWNGbAkl/d8bBbUYHDJuAdCOwNQiQMF8lu/cm77r5uDLvf2zACoTg7PwQ65WIvSiDVfz7He0IweCv58yXkBnSko3tLFwYGEEFQ+VC8j1/lQO0hW0LtZcoMRt3CbwYS2j0UIh0dZm0mETH0j4UpfqFRoKfnQ9RxzBtvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744672802; c=relaxed/simple;
	bh=nl0WsaXN8zfDqKqQsUBbPg9P8XprSfYxUzITxU1ys6U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HMFfbk3YiCzXYxLj7HfHjGCAYuDaH0ztttEfuYXDGA6De7Pd/TsL240VKWkgrcarH/bYfU1XoL3CmIk/1IXeUQyn7Ajj3jS7zhHUil8LBkFiLUfb9Q9GijYJdUiJVZHHNxuwesIyAsbiVNyx2fAbsnLbPI6eKh52LCfJfURrBrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oCaaE14K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48D16C4CEE2;
	Mon, 14 Apr 2025 23:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744672802;
	bh=nl0WsaXN8zfDqKqQsUBbPg9P8XprSfYxUzITxU1ys6U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oCaaE14KMi3hjJUYg+IniMdeHEyb5JIbagJTB1f/CkPc6v2HEYeNWzfQxovuTssNO
	 So0YKKd8h2tLLVqY3stG28AxUgX3x1xMLbQXvbLd9ecXfx0Xli5TT0Ndy093C4uHBQ
	 KOfoE5Z8JTAWo8CH+yN6sjbDLwKpS0JNn0IvMyDBsC98d5QnOdLNDdEO8SKpH+jelR
	 ITL9/zR6m5ngKbAHNA2iURf/YP3B6B907MVZT20j8Vzuv1wGxzyfAJiN1pDFlJs64M
	 6YOb/tCzF5DO5JB1VCCUB94uSrGLyVeTZOfzmP6anO0+Qox+Yb7qZq7rpQmFfjq6gA
	 opMfj+Frnq7BA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 714973822D1A;
	Mon, 14 Apr 2025 23:20:41 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 00/15][pull request] Intel Wired LAN Driver Updates
 2025-04-11 (ice, i40e, ixgbe, igc, e1000e)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174467284024.2070846.4505710834726481114.git-patchwork-notify@kernel.org>
Date: Mon, 14 Apr 2025 23:20:40 +0000
References: <20250411204401.3271306-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20250411204401.3271306-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Fri, 11 Apr 2025 13:43:41 -0700 you wrote:
> For ice:
> Mateusz and Larysa add support for LLDP packets to be received on a VF
> and transmitted by a VF in switchdev mode. Additional information:
> https://lore.kernel.org/intel-wired-lan/20250214085215.2846063-1-larysa.zaremba@intel.com/
> 
> Karol adds timesync support for E825C devices using 2xNAC (Network
> Acceleration Complex) configuration. 2xNAC mode is the mode in which
> IO die is housing two complexes and each of them has its own PHY
> connected to it.
> 
> [...]

Here is the summary with links:
  - [net-next,01/15] ice: fix check for existing switch rule
    https://git.kernel.org/netdev/net-next/c/a808691df39b
  - [net-next,02/15] ice: do not add LLDP-specific filter if not necessary
    https://git.kernel.org/netdev/net-next/c/4d5a1c4e6d49
  - [net-next,03/15] ice: receive LLDP on trusted VFs
    https://git.kernel.org/netdev/net-next/c/2296345416b0
  - [net-next,04/15] ice: remove headers argument from ice_tc_count_lkups
    https://git.kernel.org/netdev/net-next/c/5787179c5183
  - [net-next,05/15] ice: support egress drop rules on PF
    https://git.kernel.org/netdev/net-next/c/40f42dc1cbb6
  - [net-next,06/15] ice: enable LLDP TX for VFs through tc
    https://git.kernel.org/netdev/net-next/c/517f7a08ca5f
  - [net-next,07/15] ice: remove SW side band access workaround for E825
    https://git.kernel.org/netdev/net-next/c/1e05c5a05d0d
  - [net-next,08/15] ice: refactor ice_sbq_msg_dev enum
    https://git.kernel.org/netdev/net-next/c/1fd9c91f7e8f
  - [net-next,09/15] ice: enable timesync operation on 2xNAC E825 devices
    https://git.kernel.org/netdev/net-next/c/e2193f9f9ec9
  - [net-next,10/15] ice: improve error message for insufficient filter space
    https://git.kernel.org/netdev/net-next/c/6cb10c063d6c
  - [net-next,11/15] ice: make const read-only array dflt_rules static
    https://git.kernel.org/netdev/net-next/c/fee4a79a1224
  - [net-next,12/15] i40e: fix MMIO write access to an invalid page in i40e_clear_hw
    https://git.kernel.org/netdev/net-next/c/015bac5daca9
  - [net-next,13/15] ixgbe: Fix unreachable retry logic in combined and byte I2C write functions
    https://git.kernel.org/netdev/net-next/c/cdcb3804eeda
  - [net-next,14/15] igc: enable HW vlan tag insertion/stripping by default
    https://git.kernel.org/netdev/net-next/c/f9c961efb0f4
  - [net-next,15/15] net: e1000e: convert to ndo_hwtstamp_get() and ndo_hwtstamp_set()
    https://git.kernel.org/netdev/net-next/c/39aa687a8494

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



