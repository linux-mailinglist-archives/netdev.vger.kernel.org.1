Return-Path: <netdev+bounces-194682-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1677FACBE57
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 03:50:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 584B33A5ADD
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 01:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DB0C13C9C4;
	Tue,  3 Jun 2025 01:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NMtv2F6w"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB83D8821
	for <netdev@vger.kernel.org>; Tue,  3 Jun 2025 01:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748915401; cv=none; b=bK2fQ0OITvqvmXVynkvX/AkBX9SIygIrqqIfzKA+ry+3tVe5UkKg+Z+8dTTJm/a+t1DPkVKWvoDawv3tS3tYCzpStdwYROuPQVpOiWbNPu+zIJtGo0rNyfP9MeBfSUnpuj8Es8lEc55aCfUDQ7KZ4q0SWyRpk50kqAazpiYauLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748915401; c=relaxed/simple;
	bh=e4/LEM2jqdRluYvDNYGhU93ATjWJggHJDAs4A5XxH+Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MJV5kdfp7vKhVdQ+q0mM1XFW65zdMEHk+6er5zV0TSHpOTI34n5C4anC0m6RlygQy41g70rCEC3LAO4nfEjj5wfTLMwYd0EQLM6m+UYDdkU5WaUbpAd0pbh0TTxnwrVIDOLucDbv4BgsKeLjxhafQ4vRr6zwJ+Dka+0f5ek7ebA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NMtv2F6w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60C7BC4CEEB;
	Tue,  3 Jun 2025 01:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748915400;
	bh=e4/LEM2jqdRluYvDNYGhU93ATjWJggHJDAs4A5XxH+Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NMtv2F6wdf6IB/sdOO9iGBYChwMRQRN4YGJkDrTni5YP/gAjGjl9udATi5tNbSNSg
	 tREA70RfJ2JhiSqOYnvOYeLjeeuFpUFRdnfpz1UywO0AZd3aShn4x601O/isr/ddm5
	 Ef6KLVnTunpyEqmfKWRU5nK/RQTfhUzrPiqyaznZzmtB1bMtaxhwZpdfXpk6zkBNTQ
	 K6SRiuSqaBeRPS69h9FEdGpnrCF5mI4xZkIL0vqvJoYu57rfvse6PKQGvWeZKsWUrQ
	 QRw145hBoavOHVjBVzWPzaVs1LvSS0GQjJV/6ZcrMFNmSmfBL/RNEQcjRdilNXZvaW
	 LlZihEBdP/Hig==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33BDA380AAD0;
	Tue,  3 Jun 2025 01:50:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/5][pull request] Intel Wired LAN Driver Updates
 2025-05-30 (ice, idpf)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174891543300.981726.15089304946950452704.git-patchwork-notify@kernel.org>
Date: Tue, 03 Jun 2025 01:50:33 +0000
References: <20250530211221.2170484-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20250530211221.2170484-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Fri, 30 May 2025 14:12:14 -0700 you wrote:
> For ice:
> Michal resolves XDP issues related to Tx scheduler configuration with
> large number of Tx queues.
> 
> Additional information:
> https://lore.kernel.org/intel-wired-lan/20250513105529.241745-1-michal.kubiak@intel.com/
> 
> [...]

Here is the summary with links:
  - [net,1/5] ice: fix Tx scheduler error handling in XDP callback
    https://git.kernel.org/netdev/net/c/0153f36041b8
  - [net,2/5] ice: create new Tx scheduler nodes for new queues only
    https://git.kernel.org/netdev/net/c/6fa294257847
  - [net,3/5] ice: fix rebuilding the Tx scheduler tree for large queue counts
    https://git.kernel.org/netdev/net/c/73145e6d8107
  - [net,4/5] idpf: fix a race in txq wakeup
    https://git.kernel.org/netdev/net/c/7292af042bcf
  - [net,5/5] idpf: avoid mailbox timeout delays during reset
    https://git.kernel.org/netdev/net/c/9dc63d8ff182

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



