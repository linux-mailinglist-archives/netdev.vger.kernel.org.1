Return-Path: <netdev+bounces-165806-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C409A336AC
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 05:10:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A03EB188CAFB
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 04:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3667D206F1A;
	Thu, 13 Feb 2025 04:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bdrfSzvY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12632206F18
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 04:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739419805; cv=none; b=Q3tdfx7H6C6ndG5oxCEG8Yy05s7DLvnnMFaO9s1QmMAY4z7oc1BkCz5ySjB15v7hEf0jARw7uAbcjTDanW/a9bhj1ifcFiI20P3jWM3sq8fAji7o0OlzsGCBP1B9U3QYmDEraF/F6AcnTgNorhFsu6H/P3nG0EMAQAo5uUWwXs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739419805; c=relaxed/simple;
	bh=yxecivA3HqfeuUlNbsiCTz8RNK8LPYmgFi9JxoMuR9I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tajUNuv4v3T/5Ra9qHLzFk492Igb8Ko/84nmYju186QfDcwTUf93/s/iW2tUh+1V+IwL40s3Fv8LuJ1xmBgmt70USXPG9X5Xa2sixuIRPsS9U5l/Gv+ILzqU+LIMsOBMVGuHl4eMu3f5hsG7ZD548L8Z+d5SM+6DdZNDUQZtGQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bdrfSzvY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE910C4CED1;
	Thu, 13 Feb 2025 04:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739419804;
	bh=yxecivA3HqfeuUlNbsiCTz8RNK8LPYmgFi9JxoMuR9I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bdrfSzvY9pSDeSfSOKMWC216g7XEWljgzE/tkYomqP2E2RNgG9fegXEcK9239A9iZ
	 wxF8cx4ioQy1WpE2HO/VjEFjwG/d5plxlVII30ZZcgNueyJYCSrrXPzuNjxvLqMzeL
	 Eg171A67peIciGXvnTUDYxY33AnqzOKVkztIKohR7dvwFpmIDNtPPYc0qFB6j1Wq45
	 kTZ7qDrspI4KVfEPBbni/WkaELNfw3tGV3diyLyQjIf8d/WTSH+d7aUQ/v5uHqn2Dp
	 I0gz/fLl9KkcVFSpNKlDbqeY9qib6qgrIqymq3oI+EVlYh9mb4Iar8qvAMivpw3zDS
	 ySk2Pc/h+3IlA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E13380CEDC;
	Thu, 13 Feb 2025 04:10:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/6][pull request] Intel Wired LAN Driver Updates
 2025-02-11 (idpf, ixgbe, igc)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173941983402.756055.999082381175569643.git-patchwork-notify@kernel.org>
Date: Thu, 13 Feb 2025 04:10:34 +0000
References: <20250211214343.4092496-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20250211214343.4092496-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Tue, 11 Feb 2025 13:43:31 -0800 you wrote:
> For idpf:
> 
> Sridhar fixes a couple issues in handling of RSC packets.
> 
> Josh adds a call to set_real_num_queues() to keep queue count in sync.
> 
> For ixgbe:
> 
> [...]

Here is the summary with links:
  - [net,1/6] idpf: fix handling rsc packet with a single segment
    https://git.kernel.org/netdev/net/c/69ab25a74e2d
  - [net,2/6] idpf: record rx queue in skb for RSC packets
    https://git.kernel.org/netdev/net/c/2ff66c2f9ea4
  - [net,3/6] idpf: call set_real_num_queues in idpf_open
    https://git.kernel.org/netdev/net/c/52c11d31b5a1
  - [net,4/6] ixgbe: Fix possible skb NULL pointer dereference
    https://git.kernel.org/netdev/net/c/61fb097f9a64
  - [net,5/6] igc: Fix HW RX timestamp when passed by ZC XDP
    https://git.kernel.org/netdev/net/c/7822dd4d6d4b
  - [net,6/6] igc: Set buffer type for empty frames in igc_init_empty_frame
    https://git.kernel.org/netdev/net/c/63f20f00d23d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



