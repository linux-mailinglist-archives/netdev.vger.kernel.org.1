Return-Path: <netdev+bounces-204781-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 780F4AFC0C5
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 04:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 405C416868A
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 02:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7687B224AF7;
	Tue,  8 Jul 2025 02:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gp6E7zD1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5096720766C
	for <netdev@vger.kernel.org>; Tue,  8 Jul 2025 02:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751941228; cv=none; b=R5l0KwWJUT5vST1Ou7sOBommyFYMMwKDZgC2TkGqrfKc3egmQQYjAuSyczREi+MhuucuuD6EoHWUSPQAvQeNzwA7YEh/lqVE/J7rVa8cJYlbHo8MQmkynSHIi2JRpwt5mvPpSoRIAAGWwVUn1nZfkSf+e6Phpl2t3u9IbEZ0fsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751941228; c=relaxed/simple;
	bh=yH9Y3eGDxw1AG/JNz74SxS2qg/gyYMfOIEAeT/PaHko=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AIUa8jYJSeLxFF8dNzGB/vHh6cxisin/h2yk1Tmajy0a1xrYFXRdndQbILpLdgdX4d9BPasnjzjsgrTJA3enFaAGw+MRYg7CQDpODP5xv9dvTaonr33x1SF+kfWDbSMb7pyi7YFNz4uoIB2YLR96cw1m7y5yX+mocj+Cl/smfxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gp6E7zD1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BEFDC4CEE3;
	Tue,  8 Jul 2025 02:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751941228;
	bh=yH9Y3eGDxw1AG/JNz74SxS2qg/gyYMfOIEAeT/PaHko=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gp6E7zD1AO3ZXlwbh6UA/ocbKwPlTrPh7qyaT2T5mIR2ExjDGG9ggrLsNw8V5lfab
	 9t56OZab3dk4dW7QCQ7YhoOObvgnaW3FmRK69wn0lfuym8I43Zl2z0AwbiV5PDG9js
	 k3/Viy6BC+otYxiGbGvj5I6EWdj/0ZEAsbRn5f0Szmaage/LruPuA1WYwtAEaUMf1A
	 cmoOu4EIkj+z5jgHqZ9L9rMBRpUA4HUYYtyjLBcJDWz9ejsFr6Cdqww7fPEIXNQZtb
	 XdlgcTm2YyBrCBSNeWGxoyGydfWvGvBbB29bncN0z1N7wkuUDJzYlUSCvfE1oZCiGB
	 Uu0Qn5MjJIN8Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E5238111DD;
	Tue,  8 Jul 2025 02:20:52 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 00/12][pull request] Intel Wired LAN Driver
 Updates
 2025-07-03
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175194125100.3546943.9877114969229167536.git-patchwork-notify@kernel.org>
Date: Tue, 08 Jul 2025 02:20:51 +0000
References: <20250703174242.3829277-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20250703174242.3829277-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Thu,  3 Jul 2025 10:42:27 -0700 you wrote:
> Vladimir Oltean converts Intel drivers (ice, igc, igb, ixgbe, i40e) to
> utilize new timestamping API (ndo_hwtstamp_get() and ndo_hwtstamp_set()).
> 
> For ixgbe:
> Paul, Don, Slawomir, and Radoslaw add Malicious Driver Detection (MDD)
> support for X550 and E610 devices to detect, report, and handle
> potentially malicious VFs.
> 
> [...]

Here is the summary with links:
  - [net-next,01/12] ice: convert to ndo_hwtstamp_get() and ndo_hwtstamp_set()
    https://git.kernel.org/netdev/net-next/c/23ddacab4e81
  - [net-next,02/12] igc: convert to ndo_hwtstamp_get() and ndo_hwtstamp_set()
    https://git.kernel.org/netdev/net-next/c/033d0bcf4a1f
  - [net-next,03/12] igb: convert to ndo_hwtstamp_get() and ndo_hwtstamp_set()
    https://git.kernel.org/netdev/net-next/c/b88428d3fc55
  - [net-next,04/12] ixgbe: convert to ndo_hwtstamp_get() and ndo_hwtstamp_set()
    https://git.kernel.org/netdev/net-next/c/8f3f4995e8ca
  - [net-next,05/12] i40e: convert to ndo_hwtstamp_get() and ndo_hwtstamp_set()
    https://git.kernel.org/netdev/net-next/c/8cc249787783
  - [net-next,06/12] ixgbe: add MDD support
    https://git.kernel.org/netdev/net-next/c/d5e3152037f3
  - [net-next,07/12] ixgbe: check for MDD events
    https://git.kernel.org/netdev/net-next/c/da3ab95f9b06
  - [net-next,08/12] ixgbe: add Tx hang detection unhandled MDD
    https://git.kernel.org/netdev/net-next/c/b11aa9614df0
  - [net-next,09/12] ixgbe: turn off MDD while modifying SRRCTL
    https://git.kernel.org/netdev/net-next/c/1a3ebc59f717
  - [net-next,10/12] ixgbe: spelling corrections
    https://git.kernel.org/netdev/net-next/c/b91c0e4d63d9
  - [net-next,11/12] igbvf: remove unused interrupt counter fields from struct igbvf_adapter
    https://git.kernel.org/netdev/net-next/c/9ebca2374dbb
  - [net-next,12/12] igbvf: add tx_timeout_count to ethtool statistics
    https://git.kernel.org/netdev/net-next/c/a31cb447b547

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



