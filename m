Return-Path: <netdev+bounces-234529-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A912BC22CE5
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 01:40:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2FAD334D9DE
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 00:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD4D71EA7DD;
	Fri, 31 Oct 2025 00:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VziMbjcw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9861A1E32A2
	for <netdev@vger.kernel.org>; Fri, 31 Oct 2025 00:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761871240; cv=none; b=AWHsQMWyL52b8LSPXsQ97ID4k4qIvzLTUTrkW2VfCCHa/hkMNQk4HtGyR7ef+Hn26B/DqhlUjujT1Huipxss2NosCnBBoGUTSHVEEbpC0wbb+kCL4Z9pMLeS/8tPxwR+c5XO7bpml65bK+lnjPyV1KNj2spSBPpHGu1jcYNYiGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761871240; c=relaxed/simple;
	bh=0vuz2VHvA5+JVcY4xy7n0t6baXokYp0CeD4KL4ApNJs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mZTZ6m8/2dhwyOPKEP1RKNoZXHaWHkmq6V4oQhXwS2sJIHBAVNLCs/VB+JjBvF7ywFD+ZDCacm9odfoFIqgBJJ74AQ/0TBUQME/DgBBiyKYtMVh1OUb0JL5a9liW5WwgMkeHqPHYTq7nD576RzFN9c/XdLrLqrA4csqQg1Vwwz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VziMbjcw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06D2AC4CEFD;
	Fri, 31 Oct 2025 00:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761871240;
	bh=0vuz2VHvA5+JVcY4xy7n0t6baXokYp0CeD4KL4ApNJs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VziMbjcwzcZD+LmVtkQZC0JYjdBxSJWCRsJRYKrUfngLzC2v1QwEbU1lTMm/yur6O
	 NuYhjp6NzxG29b5X+elMdl8oQPJF5QbY2B4jU0HOobP32VFeUEB8iE5tkCWA4I6NRx
	 mAp8N0V+SScBWGWJUcGVjZTV3Gh6In8WlZkHzTOY92cjhn0zGH1rUXsr5ahdebNs6Y
	 97ekEuHz/H+qF5yHpHnsVo2JVLBEOIL5G5pjH8o+JexUcwqAGTPmWh/zhl6Dl2Mt4+
	 YZgCr//WUIXB5eSw89/Tp4Qql92lsZtkpD79sHB9ZMxJJyoTlWOiLQ6WjMUAXh2dd1
	 CSv9u5dYq8T7A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD753A78A6F;
	Fri, 31 Oct 2025 00:40:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/9][pull request] Intel Wired LAN Driver Updates
 2025-10-29 (ice, i40e, idpf, ixgbe, igbvf)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176187121650.4089032.16865163612180136513.git-patchwork-notify@kernel.org>
Date: Fri, 31 Oct 2025 00:40:16 +0000
References: <20251029231218.1277233-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20251029231218.1277233-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Wed, 29 Oct 2025 16:12:07 -0700 you wrote:
> For ice:
> Michal converts driver to utilize Page Pool and libeth APIs. Conversion
> is based on similar changes done for iavf in order to simplify buffer
> management, improve maintainability, and increase code reuse across
> Intel Ethernet drivers.
> 
> Additional details:
> https://lore.kernel.org/intel-wired-lan/20250925092253.1306476-1-michal.kubiak@intel.com/
> 
> [...]

Here is the summary with links:
  - [net-next,1/9] ice: remove legacy Rx and construct SKB
    https://git.kernel.org/netdev/net-next/c/9e314a3c525c
  - [net-next,2/9] ice: drop page splitting and recycling
    https://git.kernel.org/netdev/net-next/c/3a4f419f7509
  - [net-next,3/9] ice: switch to Page Pool
    https://git.kernel.org/netdev/net-next/c/93f53db9f9dc
  - [net-next,4/9] ice: implement configurable header split for regular Rx
    https://git.kernel.org/netdev/net-next/c/8adfcfd6a2ee
  - [net-next,5/9] ice: Allow 100M speed for E825C SGMII device
    https://git.kernel.org/netdev/net-next/c/ba2807b869a1
  - [net-next,6/9] i40e: avoid redundant VF link state updates
    https://git.kernel.org/netdev/net-next/c/a7ae783da0b9
  - [net-next,7/9] idpf: remove duplicate defines in IDPF_CAP_RSS
    https://git.kernel.org/netdev/net-next/c/5d9b400e6f7e
  - [net-next,8/9] ixgbe: fix typos in ixgbe driver comments
    https://git.kernel.org/netdev/net-next/c/6ef670d833a8
  - [net-next,9/9] igbvf: fix misplaced newline in VLAN add warning message
    https://git.kernel.org/netdev/net-next/c/9157b8a88c0b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



