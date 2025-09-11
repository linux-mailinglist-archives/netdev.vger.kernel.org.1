Return-Path: <netdev+bounces-221950-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EB32B52676
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 04:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F11173A316F
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 02:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA60F21256C;
	Thu, 11 Sep 2025 02:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OuVWkBXg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9607A155A4E
	for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 02:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757557807; cv=none; b=BNB7T1bi5EObubRZylxO7yqKFEEHsODNuC+mMpM/tNymd+sqHv3/rUwX+puo7XCWghYmW3N36GBur+rC4T9JOMuu/8AhR1uStCYhY1dB/0B1nBAPHgMiC/6hhR5MjA320X8gFj50N9DFwFEt5nGkvMd2pM+DRoPjihZabWKgo64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757557807; c=relaxed/simple;
	bh=3ffhi3BOqNCXLgBhafEypyr1K7l3BN8x2OrJkT1f5Kg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RoA5qmuLs2iHoqSeShaN8IKeYl9Zf9DAnQ8Ty7kuFjCNOZYMoPvQSL76OWU8elvduwqqmdSMWSoehglqZY/79ocp1tXlwzaoPB5SRtfAH4pDY7s+f49mOqM2rQrX1m6id1WiXr7GyC8klu++t/7vtVEvLOO57i2Jkm7EVoGQbS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OuVWkBXg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B192C4CEEB;
	Thu, 11 Sep 2025 02:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757557807;
	bh=3ffhi3BOqNCXLgBhafEypyr1K7l3BN8x2OrJkT1f5Kg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OuVWkBXgg5TLiWC4B/JRC/2ScyasOMhm9spp/rItEdb5dTzqQzjcZxJchDh5qhAje
	 8edbFbV4nkftzl/5+OCw0B8Vm3dazxkguL4zStwsF3fLpUTIFSrJov/xJ18QLKAXlv
	 u1uuByaeZ6GUTiowcoLZ6fr6u5uP/wjoooyi++hPtrwGpXeWwu7wu+fONQcjPktuPH
	 ppHOHysMJFtfYOSm+ZmmIG7Sld0s+yXP3B9LCY3UsnJjaIPN37U9N3sW+vpshmjqb1
	 mzJ7n8vny1u9Sk6RMEkEXSJrEfcwcOFnvpY4MclXqbl7QIsuZbR6Bn23RZSW9z6QfC
	 0jr8swHqnJC/Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E0D383BF69;
	Thu, 11 Sep 2025 02:30:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/4][pull request] Intel Wired LAN Driver Updates
 2025-09-09 (igb, i40e)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175755781000.1633754.12964871765130141893.git-patchwork-notify@kernel.org>
Date: Thu, 11 Sep 2025 02:30:10 +0000
References: <20250909203236.3603960-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20250909203236.3603960-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Tue,  9 Sep 2025 13:32:30 -0700 you wrote:
> For igb:
> Tianyu Xu removes passing of, no longer needed, NAPI id to avoid NULL
> pointer dereference on ethtool loopback testing.
> 
> Kohei Enju corrects reporting/testing of link state when interface is
> down.
> 
> [...]

Here is the summary with links:
  - [net,1/4] igb: Fix NULL pointer dereference in ethtool loopback test
    https://git.kernel.org/netdev/net/c/75871a525a59
  - [net,2/4] igb: fix link test skipping when interface is admin down
    https://git.kernel.org/netdev/net/c/d709f178abca
  - [net,3/4] i40e: fix IRQ freeing in i40e_vsi_request_irq_msix error path
    https://git.kernel.org/netdev/net/c/915470e1b44e
  - [net,4/4] i40e: fix Jumbo Frame support after iPXE boot
    https://git.kernel.org/netdev/net/c/503f1c72c31b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



