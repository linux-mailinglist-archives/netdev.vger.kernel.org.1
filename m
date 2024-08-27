Return-Path: <netdev+bounces-122549-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 331E8961AB5
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 01:40:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 658BD1C213D5
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 23:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 255671D45E4;
	Tue, 27 Aug 2024 23:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gd1dTgHD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0045015CD4A
	for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 23:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724802035; cv=none; b=U/1my+sjwoQ01yC0/Ap2Fquk9bYR+e9pVHEbuSQQrKVRPKRPQ9+KX+t/F585of3XoDTIFmaHv/BK0r0zHNTxoHuFW5wlw+Oap4YY1IauNpI3rxnH/BtsPRNYxxeE+236or06rV8gwlz1lsZxgTtp4thefYRACCTt0iRb7hjDEVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724802035; c=relaxed/simple;
	bh=4BzTvs8NBs6ocvY2hfaJvaO8XNvX8crvJ4Jo5XsfV5A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IJ6+NTnoQ20W5spOkwpoaKPGEogpngOVjRDsq0uSU9TBkDJTm4CgY5I0VAO+XA/RU0mivptXt3te1IQcalOtLA1C8Ueel9dGyxmTlwAqK/dDDoUiAiHiJSxPueAewpmJhAPxHPu2pXnYwCvdecvMMPPHNp6rflWfZ8KbnXobijM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gd1dTgHD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F806C4AF53;
	Tue, 27 Aug 2024 23:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724802034;
	bh=4BzTvs8NBs6ocvY2hfaJvaO8XNvX8crvJ4Jo5XsfV5A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gd1dTgHDnHhCDxQRmk2cTjFxSkuUmqCEPP3GNFNQSReXo6jZgJm6mEbSkuSCytTok
	 ckr1uG20FyaFyT149RISTz/qHHUKKdBYGaB5Sca7ACOZqtbDMoQlgobwajcSSjz+Sf
	 I7Rp3yUPmNhE42819fv8MwS/upL08SeAJ/VceRoh83l3gOOl5PajklFEd64Oayo+MD
	 Hpboo4lpQxaXP93V9PR/BDZZrsnEddJVuA8xvTxeCKd+jZyYuiyhyHJn1/uYtrki/4
	 YvJSF2N1t11GMGfOKbAOqZcnDzUBnWNAYeIvqQYAUmrWxP9MXEf+iAyyl8Yz/ZTW2C
	 nDZTlxZxvvW6g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE443822D6D;
	Tue, 27 Aug 2024 23:40:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/8][pull request] Intel Wired LAN Driver Updates
 2024-08-26 (ice)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172480203452.791272.2614238632948443273.git-patchwork-notify@kernel.org>
Date: Tue, 27 Aug 2024 23:40:34 +0000
References: <20240826224655.133847-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20240826224655.133847-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Mon, 26 Aug 2024 15:46:40 -0700 you wrote:
> This series contains updates to ice driver only.
> 
> Jake implements and uses rd32_poll_timeout to replace a jiffies loop for
> calling ice_sq_done. The rd32_poll_timeout() function is designed to allow
> simplifying other places in the driver where we need to read a register
> until it matches a known value.
> 
> [...]

Here is the summary with links:
  - [net-next,1/8] ice: implement and use rd32_poll_timeout for ice_sq_done timeout
    https://git.kernel.org/netdev/net-next/c/5f6df173f92e
  - [net-next,2/8] ice: improve debug print for control queue messages
    https://git.kernel.org/netdev/net-next/c/caf4daae871c
  - [net-next,3/8] ice: do not clutter debug logs with unused data
    https://git.kernel.org/netdev/net-next/c/6bd7cb522b1c
  - [net-next,4/8] ice: stop intermixing AQ commands/responses debug dumps
    https://git.kernel.org/netdev/net-next/c/74ce564a30ef
  - [net-next,5/8] ice: reword comments referring to control queues
    https://git.kernel.org/netdev/net-next/c/1d95d9256cfa
  - [net-next,6/8] ice: remove unnecessary control queue cmd_buf arrays
    https://git.kernel.org/netdev/net-next/c/448711c1dad0
  - [net-next,7/8] ice: Report NVM version numbers on mismatch during load
    https://git.kernel.org/netdev/net-next/c/b1703d5f794d
  - [net-next,8/8] ice: Adjust over allocation of memory in ice_sched_add_root_node() and ice_sched_add_node()
    https://git.kernel.org/netdev/net-next/c/62fdaf9e8056

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



