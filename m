Return-Path: <netdev+bounces-242123-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15554C8C888
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 02:21:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF6D93B10CE
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 01:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF6742236E3;
	Thu, 27 Nov 2025 01:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sAKqyTga"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C793518FDDE;
	Thu, 27 Nov 2025 01:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764206465; cv=none; b=r91SgzYN874GixOZ5N9T8EWKEoOH5XTsazl/boPek4DigFhkcRdPFr/Mcil0/IYRgcZfTGccDvPDRP3tRaS3nPv2U43dXmMf3JEqr10u0oJC0e/42MEvwXjHhLKZezvDN3nT7tuxE7Cp4qIrXwAYO07EaRa15uMUsttdQi1m/WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764206465; c=relaxed/simple;
	bh=H3Sk4FkNlLvO2pxRyLrNJOf23k9YNgMuCOiAIH2os1Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VhW26IgaUF5FmnnvHu0ddCwAHE30+2+/clt5jNLJqRvRCfln/W39k4buYdtAyli/OmMIhmi7hPJTGG4tJ7KoT3ojvJ1jjBEVRy8eemzVidIy9R0+g7/FDtAEEBw3zpJs9YCM+kyfWjCd9VoMwPiVO8eGR3N7wlzfrj/UbJbOOi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sAKqyTga; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C94DC4CEF7;
	Thu, 27 Nov 2025 01:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764206464;
	bh=H3Sk4FkNlLvO2pxRyLrNJOf23k9YNgMuCOiAIH2os1Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sAKqyTgaMimz0WCFD8grun5Hjmibsqz3q9iVzkV7dsecfNNk/89w3I06e8UQlV3nH
	 C4ro0oTboWtZQYbhqjChXkJsStlm9W09if6B4VErCf6dUcKfKwl7RVtynHi0y1dWfT
	 bbPWY01ABapbeDurhIPy1s/NWlf88dJ6CgIkiKByKnPYBBEWigQct4AoCHE0WI8Tg8
	 7luWl0vOHPQD3DkYcZ/SoS5a71f0Qwk1+Bf3h8dnjrclkHBQqS8i0o36Mmensq4mHN
	 FC2p/J6ocUhFvvygtiilW2cbQldkqVLP90Rkz7GbFEqqehRnsO73Fa6rvGAjhdRUK5
	 tOeW6oj16QLeA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 340F7380CEF8;
	Thu, 27 Nov 2025 01:20:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/8] net: intel: migrate to
 .get_rx_ring_count() ethtool callback
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176420642599.1910295.10418248024267534204.git-patchwork-notify@kernel.org>
Date: Thu, 27 Nov 2025 01:20:25 +0000
References: <20251125-gxring_intel-v2-0-f55cd022d28b@debian.org>
In-Reply-To: <20251125-gxring_intel-v2-0-f55cd022d28b@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: aleksander.lobakin@intel.com, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com,
 aleksandr.loktionov@intel.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 25 Nov 2025 02:19:43 -0800 you wrote:
> This series migrates Intel network drivers to use the new .get_rx_ring_count()
> ethtool callback introduced in commit 84eaf4359c36 ("net: ethtool: add
> get_rx_ring_count callback to optimize RX ring queries").
> 
> The new callback simplifies the .get_rxnfc() implementation by removing
> ETHTOOL_GRXRINGS handling and moving it to a dedicated callback. This provides
> a cleaner separation of concerns and aligns these drivers with the modern
> ethtool API.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/8] i40e: extract GRXRINGS from .get_rxnfc
    https://git.kernel.org/netdev/net-next/c/a8acbcbaf6d0
  - [net-next,v2,2/8] iavf: extract GRXRINGS from .get_rxnfc
    https://git.kernel.org/netdev/net-next/c/fe0a3d7d1dca
  - [net-next,v2,3/8] ice: extract GRXRINGS from .get_rxnfc
    https://git.kernel.org/netdev/net-next/c/8e8c00e1d213
  - [net-next,v2,4/8] idpf: extract GRXRINGS from .get_rxnfc
    https://git.kernel.org/netdev/net-next/c/873a1942fbc6
  - [net-next,v2,5/8] igb: extract GRXRINGS from .get_rxnfc
    https://git.kernel.org/netdev/net-next/c/d6c744f46816
  - [net-next,v2,6/8] igc: extract GRXRINGS from .get_rxnfc
    https://git.kernel.org/netdev/net-next/c/768ce58dddb2
  - [net-next,v2,7/8] ixgbevf: extract GRXRINGS from .get_rxnfc
    https://git.kernel.org/netdev/net-next/c/3399fd519dd4
  - [net-next,v2,8/8] fm10k: extract GRXRINGS from .get_rxnfc
    https://git.kernel.org/netdev/net-next/c/73d834cd1774

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



