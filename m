Return-Path: <netdev+bounces-155600-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 58FB1A0324C
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 22:50:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15E3A7A2330
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 21:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D43C1E0DD5;
	Mon,  6 Jan 2025 21:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PhgvCN6o"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458CA145A11;
	Mon,  6 Jan 2025 21:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736200214; cv=none; b=UEN8HZ6X5keEdC6o+jWlZtkYltcnVuDhCSUMHaBBYdmy0qeCjWB8wz9MlcRc5Q69cMx4M3OthipuJk4+wdxXbzVDo1vPfGLORZsM+QrTjaGJC+HRDZO938HJPojsJnw/qoFMslsQTsWspIc6OXPyZvaiNX9XVz4ZtmJKcQg4cQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736200214; c=relaxed/simple;
	bh=fChATgADLibhMK0tTypbOiYL515hkAgGAV38XsG8XPE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TYD7DAXnOnAgXZGgtOwpD/+3myMXjrymm0Ge2zt1uDSNR7TBdlCFChQ4sY6fwrjUP2pkpgpqjYUbRk3IvHU0uRH2hznqjuYmf5HknoeuEqfWHRNxMU3RYVL32BLg+4hN/wpGosYBlvpE4AWKFatY0OqfSVpEKuDjzh+amlQYi9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PhgvCN6o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF59BC4CED2;
	Mon,  6 Jan 2025 21:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736200213;
	bh=fChATgADLibhMK0tTypbOiYL515hkAgGAV38XsG8XPE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PhgvCN6oji6b5XefgbPcNxe3NaPDWT5HUpitUYP5p+07+ITFrb+5lN5rYwB/kigm8
	 V9mSoylc7IvqCnpm/q8ZldMVS/1Ls+xah7EkYtvJ6E+rchATP04Fq+cLRs8kjtql+o
	 V8qDuNlipAb3D5JX8hO9OmJ4SBNclijiffziTmu6rdlaV4pqdnw9OOJSITfKQCZTGc
	 nt0Ve2jb1Dt15ElqYQ25mQN5re7p5Fl4c+lGdWPt0J2oXEKb1a1h75KUM2MyruPE/T
	 2skYrGx7pHXkhlFAMWLYK9Nwp8Hf+y0X3upJL4VpDA3NcpxCBGSU3FxYB5ZkuRAJSj
	 dQ9DgPNydZ3zw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34013380A97E;
	Mon,  6 Jan 2025 21:50:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/9] i40e deadcoding
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173620023500.3628195.15413086820847191505.git-patchwork-notify@kernel.org>
Date: Mon, 06 Jan 2025 21:50:35 +0000
References: <20250102173717.200359-1-linux@treblig.org>
In-Reply-To: <20250102173717.200359-1-linux@treblig.org>
To: Dr. David Alan Gilbert <linux@treblig.org>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  2 Jan 2025 17:37:08 +0000 you wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> Hi,
>   This is a bunch of deadcoding of functions that
> are entirely uncalled in the i40e driver.
> 
>   Build tested only.
> 
> [...]

Here is the summary with links:
  - [net-next,1/9] i40e: Deadcode i40e_aq_*
    https://git.kernel.org/netdev/net-next/c/59ec698d01eb
  - [net-next,2/9] i40e: Remove unused i40e_blink_phy_link_led
    https://git.kernel.org/netdev/net-next/c/39cabb01d26d
  - [net-next,3/9] i40e: Remove unused i40e_(read|write)_phy_register
    https://git.kernel.org/netdev/net-next/c/8cc51e28ecce
  - [net-next,4/9] i40e: Deadcode profile code
    https://git.kernel.org/netdev/net-next/c/81d6bb2012e1
  - [net-next,5/9] i40e: Remove unused i40e_get_cur_guaranteed_fd_count
    https://git.kernel.org/netdev/net-next/c/3eb24a9e0af3
  - [net-next,6/9] i40e: Remove unused i40e_del_filter
    https://git.kernel.org/netdev/net-next/c/38dfb07d9a65
  - [net-next,7/9] i40e: Remove unused i40e_commit_partition_bw_setting
    https://git.kernel.org/netdev/net-next/c/a324484ac855
  - [net-next,8/9] i40e: Remove unused i40e_asq_send_command_v2
    https://git.kernel.org/netdev/net-next/c/d424b93f35a6
  - [net-next,9/9] i40e: Remove unused i40e_dcb_hw_get_num_tc
    https://git.kernel.org/netdev/net-next/c/47ea5d4e6f40

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



