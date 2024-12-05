Return-Path: <netdev+bounces-149232-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 764829E4CDA
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 04:50:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 360C3285491
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 03:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 405AA191F8F;
	Thu,  5 Dec 2024 03:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c/GxZgVb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC4E1917FB
	for <netdev@vger.kernel.org>; Thu,  5 Dec 2024 03:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733370622; cv=none; b=bUMUjeFEcu3O47ytE8o9sqrqcbWFcyowapZwg67N7oNl8KTc/u/hJUZHzy6vicoJ9DSmgeGtxLQTXfTB/Qra/paJqO6yACgwF8UuMteR7G86aS+M2Mu3fdKmJC+Xdp+ZF9MVsXMRFsMchj+Dv+uSFA2WAVidcYZN6jo4v8iwgVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733370622; c=relaxed/simple;
	bh=EuXl4FWr/T9VF0imfPV3Z1ABDPpxNliT4KtggchgUO8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jgQZiVuLlYvuM7pQDUyB4hCG4DM4LLdMFjpcgpe7fPue/rCSb+e73NtQYlK+MMFzwaaQP4JwYXCH+o05hpVe5I6dU9ni5j+4VAktWRCI4+YV8gElBp0aQ+MyfRE3Hy9IWBOmYtb/4dd16hx+wvlZr8848/4Q/k4e/B9EySfO6W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c/GxZgVb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A66F8C4CEDC;
	Thu,  5 Dec 2024 03:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733370621;
	bh=EuXl4FWr/T9VF0imfPV3Z1ABDPpxNliT4KtggchgUO8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=c/GxZgVb8Nt3LgBfM5SsHorEJp8JuevvM61p8bqtCK+R4TW2EdC1JPOVImQCl4Pq1
	 izROiborjT5g8T4j9tFZrzO9b7mUClFhpHGxzL8Lq8HyQmdYt/occl1TFKNAV3neQ1
	 vtNpGJdLKwIkMGRq/cZKI9EbAExn0R8sZ1RMmeneLRoy/9kSGodsbdjhyuaiXoXJw5
	 FgkEkQQ9gY8HBC5v9EqVxMf2kP/ZqxeP79OGvaVq0e4nixzOej5QXmGZLDO2dgaatQ
	 QJF4OnCE1XKLmpZPnjTbBewJouxYgUJLfoaiORaiQnUFXdlVduCiqBAamLD0Bvwuf4
	 2afbngYV/8Jeg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7135E380A94C;
	Thu,  5 Dec 2024 03:50:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/9][pull request] Intel Wired LAN Driver Updates
 2024-12-03 (ice, idpf, ixgbe, ixgbevf, igb)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173337063625.1436302.12316177454307244267.git-patchwork-notify@kernel.org>
Date: Thu, 05 Dec 2024 03:50:36 +0000
References: <20241203215521.1646668-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20241203215521.1646668-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Tue,  3 Dec 2024 13:55:09 -0800 you wrote:
> This series contains updates to ice, idpf, ixgbe, ixgbevf, and igb
> drivers.
> 
> For ice:
> Arkadiusz corrects search for determining whether PHY clock recovery is
> supported on the device.
> 
> [...]

Here is the summary with links:
  - [net,1/9] ice: fix PHY Clock Recovery availability check
    https://git.kernel.org/netdev/net/c/01fd68e54794
  - [net,2/9] ice: fix PHY timestamp extraction for ETH56G
    https://git.kernel.org/netdev/net/c/3214fae85e83
  - [net,3/9] ice: Fix NULL pointer dereference in switchdev
    https://git.kernel.org/netdev/net/c/9ee87d2b2199
  - [net,4/9] ice: Fix VLAN pruning in switchdev mode
    https://git.kernel.org/netdev/net/c/761e0be2888a
  - [net,5/9] idpf: set completion tag for "empty" bufs associated with a packet
    https://git.kernel.org/netdev/net/c/4c69c77aafe7
  - [net,6/9] ixgbevf: stop attempting IPSEC offload on Mailbox API 1.5
    https://git.kernel.org/netdev/net/c/d0725312adf5
  - [net,7/9] ixgbe: downgrade logging of unsupported VF API version to debug
    https://git.kernel.org/netdev/net/c/15915b43a7fb
  - [net,8/9] ixgbe: Correct BASE-BX10 compliance code
    https://git.kernel.org/netdev/net/c/f72ce14b231f
  - [net,9/9] igb: Fix potential invalid memory access in igb_init_module()
    https://git.kernel.org/netdev/net/c/0566f83d206c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



