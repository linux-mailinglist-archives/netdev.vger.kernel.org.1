Return-Path: <netdev+bounces-196382-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 146A3AD46E2
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 01:39:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A84077A74AF
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 23:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0E9226E705;
	Tue, 10 Jun 2025 23:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YoQl3p2H"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B31017E
	for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 23:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749598752; cv=none; b=rs5y39TSFTeb+CoCq8ghTt2AHzpCQQDnVlpjVLrPh5JUjVwrz50Gzn3Y0t21Joey5T6Y3rkC+jdN4uICHoaxaCImlFj+SXGSakJ7NH7wV76fTX8ad/yieV2oCiRFShgKIIn6mQ42RczN7m/ZeN1hQt9PkOKY/OgsvVQN7geceoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749598752; c=relaxed/simple;
	bh=wo3Uf0n1PWV9t1y0Nc9oyrOqSDfMBAsZySvJFwrTNZI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NypVD14u9fr5ZIICCXE5Zx2wMeYNjXmkwK+23oH+UoJxOoj0DMyMi79Anb/yEGXbEnDVLJgjMblNHZw5MOS0ZlatrdPiuGh8wLYHop15FeNHUhc/p85uKHhnvH5D3RjHIq+9/JdeUVwB6mCQfmSI+wT9+W7CJBNYWjQlUxvbI2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YoQl3p2H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 176FEC4CEED;
	Tue, 10 Jun 2025 23:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749598752;
	bh=wo3Uf0n1PWV9t1y0Nc9oyrOqSDfMBAsZySvJFwrTNZI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YoQl3p2Hr1AKvaYa70WOVcPopmEn/aj0yMXttZbz2Glkm2m562CDcC06bVz9AdAkB
	 MRqx6mYF0VDL5feT27/as0EvEmnlMVpWHmde9m3LXPrdTkZPNiBqHatTD5JndUfqFK
	 CldLoLANf0lEc9BUpSMdXcKHF0P9MctJUwCz9foLDwEGdHO8XCpMGfJxkdz8XXb8Fo
	 CaGerg97Zbfuv31xwTJ/B3fgWfpLijwRpGmhm4WF8DscCeErkYx6BahM33iW9nF+IR
	 Y8S2Pz9sr9MDl5czhUb+ASM3hXtK1iqMZW3X/BTdeqVNkCPv1wSQ0ANf43uG2kolol
	 4HICSV1cO7e+A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADDB538111E3;
	Tue, 10 Jun 2025 23:39:43 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 00/11][pull request] Intel Wired LAN Driver
 Updates
 2025-06-09 (ice, i40e, ixgbe, iavf)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174959878248.2630805.4773411977374147072.git-patchwork-notify@kernel.org>
Date: Tue, 10 Jun 2025 23:39:42 +0000
References: <20250609212652.1138933-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20250609212652.1138933-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Mon,  9 Jun 2025 14:26:39 -0700 you wrote:
> Jake moves from individual virtchnl RSS configuration values, for ice,
> i40e, and iavf, to a common libie location and values.
> 
> Martyna and Dawid add counters for link_down_events to ice, i40e, and
> ixgbe drivers. The counter increments only on actual physical link-down
> events visible to the PHY. It does not increment when the user performs
> a software-only interface down/up (e.g. ip link set dev down).
> 
> [...]

Here is the summary with links:
  - [net-next,01/11] net: intel: rename 'hena' to 'hashcfg' for clarity
    https://git.kernel.org/netdev/net-next/c/78b2d9908b42
  - [net-next,02/11] net: intel: move RSS packet classifier types to libie
    https://git.kernel.org/netdev/net-next/c/141d0c9037ca
  - [net-next,03/11] ice: add link_down_events statistic
    https://git.kernel.org/netdev/net-next/c/e7aee24a89c8
  - [net-next,04/11] i40e: add link_down_events statistic
    https://git.kernel.org/netdev/net-next/c/f0768aec37c0
  - [net-next,05/11] ixgbe: add link_down_events statistic
    https://git.kernel.org/netdev/net-next/c/9acae9e2e289
  - [net-next,06/11] ice: redesign dpll sma/u.fl pins control
    https://git.kernel.org/netdev/net-next/c/2dd5d03c77e2
  - [net-next,07/11] ice: change SMA pins to SDP in PTP API
    https://git.kernel.org/netdev/net-next/c/a33a302b505b
  - [net-next,08/11] ice: add ice driver PTP pin documentation
    https://git.kernel.org/netdev/net-next/c/cb9e0de77761
  - [net-next,09/11] ice: add a separate Rx handler for flow director commands
    https://git.kernel.org/netdev/net-next/c/dc5e7a3513ef
  - [net-next,10/11] iavf: convert to NAPI IRQ affinity API
    https://git.kernel.org/netdev/net-next/c/b0ca7dc0e70e
  - [net-next,11/11] ixgbe: Fix typos and clarify comments in X550 driver code
    https://git.kernel.org/netdev/net-next/c/670678399edc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



