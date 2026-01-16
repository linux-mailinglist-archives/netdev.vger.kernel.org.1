Return-Path: <netdev+bounces-250428-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AEC51D2B1FB
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 05:03:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 427F030116EE
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 04:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD703322B67;
	Fri, 16 Jan 2026 04:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lCNdfa8n"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAAAF3446D0
	for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 04:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768536232; cv=none; b=KOkM+RgGgSsKltlXJgklDbV+/qQe7HCUJuuZFUHMCH+aQ6Cs6If0kpju5ffoSNWZUa1AE7YJPV/zsBtWYpIfxEtVKJAoMNjJJ9N9w1LDi4+smQtcAgZ+Hyqp5POBPr81ccO5MMfehAWHbw/REDRKvNOb9Y5ybi2gMg3F5K21hDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768536232; c=relaxed/simple;
	bh=nj1EPiUiD998p4veCvGpA6WcFHl00bzxN0R/CqsPE4M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=B7IdiARk8LX2A0PWbqAVGjieaLD037HIGuQDUW2bkB1qbZCgtjAeN0ug5McP37dj+trEh7RHIPjRPVe4IzapMZ3E159Fvvj377YlcsZqs6PxABGN3TjddJOA7XCmaFzayE21T6GOzJjh2YC4kDV4+fTYZ6m0ZZShK1ndV6sfeF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lCNdfa8n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56AA4C16AAE;
	Fri, 16 Jan 2026 04:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768536232;
	bh=nj1EPiUiD998p4veCvGpA6WcFHl00bzxN0R/CqsPE4M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lCNdfa8nDQQMiUbCw/HcFlq1nAMO2FDgQ7bEOen20WfPGO1t9xVai+VNRjFpNgT3d
	 1Xuyr0FsQDisic0djz95AxHWzpVkpsgzdjDR0sjSI1xYFgBoDmC9KD+OksDtjcVO9s
	 iCsZ2TrOwCqQRAqqPUWoFehifw1rIvR5ZtxZMwqkx6B3LqJNUoFy0bTHbrZAXLAO8R
	 93VTpBAWxRzYLC7ikBRMVslXDYFMNbYFVA/eR2WoBFyoryzHW8KzWRqYuSckeipbjY
	 pZm4F6fd/SpH2d8bicpXd6+ff+ozZMCpspNH3Kat/o5nfQucLe5oZNG1WyVQM6RNOP
	 Sw5i/YiLRy5sw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 78813380AA4C;
	Fri, 16 Jan 2026 04:00:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/6][pull request] Intel Wired LAN Driver Updates
 2026-01-13 (ice, igc)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176853602402.76642.12923651451053248903.git-patchwork-notify@kernel.org>
Date: Fri, 16 Jan 2026 04:00:24 +0000
References: <20260113220220.1034638-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20260113220220.1034638-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Tue, 13 Jan 2026 14:02:13 -0800 you wrote:
> For ice:
> Jake adds missing initialization calls to u64_stats_init().
> 
> Dave stops deletion of VLAN 0 from prune list when device is primary
> LAG interface.
> 
> Ding Hui adds a missed unit conversion function for proper timeout
> value.
> 
> [...]

Here is the summary with links:
  - [net,1/6] ice: initialize ring_stats->syncp
    https://git.kernel.org/netdev/net/c/8439016c3b8b
  - [net,2/6] ice: Avoid detrimental cleanup for bond during interface stop
    https://git.kernel.org/netdev/net/c/a9d45c22ed12
  - [net,3/6] ice: Fix incorrect timeout ice_release_res()
    https://git.kernel.org/netdev/net/c/01139a2ce532
  - [net,4/6] igc: Restore default Qbv schedule when changing channels
    https://git.kernel.org/netdev/net/c/41a9a6826f20
  - [net,5/6] igc: fix race condition in TX timestamp read for register 0
    https://git.kernel.org/netdev/net/c/6990dc392a9a
  - [net,6/6] igc: Reduce TSN TX packet buffer from 7KB to 5KB per queue
    https://git.kernel.org/netdev/net/c/8ad1b6c1e63d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



