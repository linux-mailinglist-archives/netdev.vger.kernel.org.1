Return-Path: <netdev+bounces-156128-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB1E3A050D5
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 03:33:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00E833A944D
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 02:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 488B6134AB;
	Wed,  8 Jan 2025 02:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nE00iDW9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E63187550
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 02:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736303415; cv=none; b=TSZ2z1U4mO7UPkfnF6jlmA0rBCRW2UIbb1PZNHImYJWi+Q0ybYg2EWi51+as0cNtcyJwzRdISXfy+QY/UUTumvz85J8Y0bQQ/dJu+0xb+uKFw/GmJ9BFnYowpuPVmEoY+OZq9nkXIfj3XrPaKkc+Gv6PHaAr/cM7Tnc+wPj+WmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736303415; c=relaxed/simple;
	bh=IbccK+46t4fjHYUb2q7+5luvr8OHE2ZPx45gVqV5deM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=InSPtc+t13RsVvEXhnC4J4yrFEnvusR/fBp8bJx+4dBUCJ8LbpPbzKmyy9zKORHEkt90PKoycBxOBLid9oZytL9AKHVP4JoI1YDyF/QiTnIvxZVeNADJg4nCBVrurysbytSXogm3DpkOHzMRo90x9X3apTIwYy5sD7qe9wtjwVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nE00iDW9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B694C4CED6;
	Wed,  8 Jan 2025 02:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736303415;
	bh=IbccK+46t4fjHYUb2q7+5luvr8OHE2ZPx45gVqV5deM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nE00iDW93uZIWfP/OJvp70z6BBDlc9TSaecKLKow4ShIvFTO5+Wp9LHF3x7wH5PYS
	 327YCqGfm4ySUslkGBCIpaTSz2gOFKo3BT2OGvlOKl/TTrzEyJd87UBLjAi4uCG0Mm
	 vD46VcmV72Ww5CTzwQgschkJjAF270SCgeEF4LVNbhXoMlQ3v5xiyVxKh5BhWBjszf
	 A6tCgnrb/VE8kG5XKuI1S7Xy9pP20286emOPN4sE45HFvupeBKC+wVb5F+78e7hg5E
	 HlWz/HoxYB6/O68UrDDr+5u/NlFK8gsst4to/aB4Oqw9d/V+TmkhZEEAmJ0dJBhQY0
	 eygBhxEST4sXQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE4C3380A97E;
	Wed,  8 Jan 2025 02:30:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 00/15][pull request] Intel Wired LAN Driver Updates
 2025-01-06 (igb, igc, ixgbe, ixgbevf, i40e, fm10k)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173630343651.171397.1006504547689960181.git-patchwork-notify@kernel.org>
Date: Wed, 08 Jan 2025 02:30:36 +0000
References: <20250106221929.956999-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20250106221929.956999-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  6 Jan 2025 14:19:08 -0800 you wrote:
> For igb:
> 
> Sriram Yagnaraman and Kurt Kanzenbach add support for AF_XDP
> zero-copy.
> 
> Original cover letter:
> The first couple of patches adds helper functions to prepare for AF_XDP
> zero-copy support which comes in the last couple of patches, one each
> for Rx and TX paths.
> 
> [...]

Here is the summary with links:
  - [net-next,01/15] igb: Remove static qualifiers
    https://git.kernel.org/netdev/net-next/c/f70b864ccc84
  - [net-next,02/15] igb: Introduce igb_xdp_is_enabled()
    https://git.kernel.org/netdev/net-next/c/6dc75fc230ec
  - [net-next,03/15] igb: Introduce XSK data structures and helpers
    https://git.kernel.org/netdev/net-next/c/80f6ccf9f116
  - [net-next,04/15] igb: Add XDP finalize and stats update functions
    https://git.kernel.org/netdev/net-next/c/0fe7cce6000c
  - [net-next,05/15] igb: Add AF_XDP zero-copy Rx support
    https://git.kernel.org/netdev/net-next/c/2c6196013f84
  - [net-next,06/15] igb: Add AF_XDP zero-copy Tx support
    https://git.kernel.org/netdev/net-next/c/f8e284a02afc
  - [net-next,07/15] igc: Allow hot-swapping XDP program
    https://git.kernel.org/netdev/net-next/c/484d3675f2aa
  - [net-next,08/15] igc: Fix passing 0 to ERR_PTR in igc_xdp_run_prog()
    https://git.kernel.org/netdev/net-next/c/8b6237e1f4d4
  - [net-next,09/15] igb: Fix passing 0 to ERR_PTR in igb_run_xdp()
    https://git.kernel.org/netdev/net-next/c/8ae94669b1f3
  - [net-next,10/15] ixgbe: Fix passing 0 to ERR_PTR in ixgbe_run_xdp()
    https://git.kernel.org/netdev/net-next/c/c824125cbb18
  - [net-next,11/15] ixgbevf: Fix passing 0 to ERR_PTR in ixgbevf_run_xdp()
    https://git.kernel.org/netdev/net-next/c/35f715cb77c3
  - [net-next,12/15] i40e: add ability to reset VF for Tx and Rx MDD events
    https://git.kernel.org/netdev/net-next/c/07af482e6465
  - [net-next,13/15] igc: Link IRQs to NAPI instances
    https://git.kernel.org/netdev/net-next/c/1a63399c13fe
  - [net-next,14/15] igc: Link queues to NAPI instances
    https://git.kernel.org/netdev/net-next/c/b65969856d4f
  - [net-next,15/15] intel/fm10k: Remove unused fm10k_iov_msg_mac_vlan_pf
    https://git.kernel.org/netdev/net-next/c/605237372a53

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



