Return-Path: <netdev+bounces-219742-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80D8CB42D88
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 01:40:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FD3F3B77BF
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 23:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16E5D2ECD28;
	Wed,  3 Sep 2025 23:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qk3IFFoF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2EFF2E9EB9
	for <netdev@vger.kernel.org>; Wed,  3 Sep 2025 23:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756942810; cv=none; b=eQjzPiJR027d03Ks2xqxbwP6qB+NwYbe9hgzAgEa8/l4sSMb5fho7i27gy8paVALjrIOIeJVCmyv6W9cBeeIT9q0sETbUKz3twWcFZ9GWWKplb794rW372tk3nRyXCr5f/l66fjUdJEUpxXbKEaLrll5ZbfQUljXpZX4WJNys0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756942810; c=relaxed/simple;
	bh=uV0gr0NPdfJrA+mjIMvkZoKxh1f2twwQWDFlvK2ZT7w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GBoWqN09zDrGJ2Y2qyfpnWCtD+m+p5w8rdVzd63WNflMzz09t+AG6DxQ9gTZ7za4e7RYcjtwQklbSgDJsb7sYclkPwgqflXMtRdqnyp2H2iUe9qIjZkoX94Z3hFLcz0y+7VSCqxsuti+0yqGV5LnrBc+GDGzKN8BhtgtPleb/xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qk3IFFoF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DF07C4CEE7;
	Wed,  3 Sep 2025 23:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756942808;
	bh=uV0gr0NPdfJrA+mjIMvkZoKxh1f2twwQWDFlvK2ZT7w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Qk3IFFoFl4UY251ATJKc3IPgI54xysEWgSEuPfBBWhGbsdvohYK3sq8tgcBH6yQ7C
	 2M85KPl3zU9sA2JDAiNCTptMTPnxQPljf268ZmgPu6p3Ra/Kke5MDwaDizpbDnT1aK
	 f4aSRb902/SABU/YIjFDwwp+cj55aWuH4ArUzuxvdYSydgXcVeSsUhvXXFVncC5cUV
	 m4t/dBQBX8s8Q7mQy6ziuGE5of61BXEDhgY04DP0dzodm342vddrcZqSNNUXA7HQRZ
	 oo1iD9V265g0UbnC8K+DdzfADksZ6s8bDtpO9R9xtu0yKUXlmuO0EKTr6NRSu/i+5B
	 26VYV9r0Zq6jw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE37383C259;
	Wed,  3 Sep 2025 23:40:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/8][pull request] Intel Wired LAN Driver Updates
 2025-09-02 (ice, idpf, i40e, ixgbe, e1000e)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175694281353.1237656.2000761863886349636.git-patchwork-notify@kernel.org>
Date: Wed, 03 Sep 2025 23:40:13 +0000
References: <20250902232131.2739555-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20250902232131.2739555-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Tue,  2 Sep 2025 16:21:20 -0700 you wrote:
> For ice:
> Jake adds checks for initialization of Tx timestamp tracking structure
> to prevent NULL pointer dereferences.
> 
> For idpf:
> Josh moves freeing of auxiliary device id to prevent use-after-free issue.
> 
> [...]

Here is the summary with links:
  - [net,1/8] ice: fix NULL access of tx->in_use in ice_ptp_ts_irq
    https://git.kernel.org/netdev/net/c/403bf043d934
  - [net,2/8] ice: fix NULL access of tx->in_use in ice_ll_ts_intr
    https://git.kernel.org/netdev/net/c/f6486338fde3
  - [net,3/8] idpf: fix UAF in RDMA core aux dev deinitialization
    https://git.kernel.org/netdev/net/c/65637c3a1811
  - [net,4/8] idpf: set mac type when adding and removing MAC filters
    https://git.kernel.org/netdev/net/c/acf3a5c8be80
  - [net,5/8] i40e: remove read access to debugfs files
    https://git.kernel.org/netdev/net/c/9fcdb1c3c4ba
  - [net,6/8] i40e: Fix potential invalid access when MAC list is empty
    https://git.kernel.org/netdev/net/c/a556f06338e1
  - [net,7/8] ixgbe: fix incorrect map used in eee linkmode
    https://git.kernel.org/netdev/net/c/b7e5c3e3bfa9
  - [net,8/8] e1000e: fix heap overflow in e1000_set_eeprom
    https://git.kernel.org/netdev/net/c/90fb7db49c6d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



