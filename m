Return-Path: <netdev+bounces-198379-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27E8CADBEA0
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 03:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF61B1892D7B
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 01:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C45041C4A0A;
	Tue, 17 Jun 2025 01:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V+5uSCSW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BAB61B6CE9;
	Tue, 17 Jun 2025 01:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750124424; cv=none; b=Xi50dlsLpiCSQaYWHlYJC2gOEd78XdqUQa5ywSwzjnkht0ljdcM5Ub752OjkEvPA1jjJTm2so51XAV6beWwxADT588Nb283p1RGEXf/zBsz0yLoYH7wv9NMdDd84QE6X81aRyr+WfMkV9F/P8JfMVZVdw4dTC8LdW/bjLt2X1AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750124424; c=relaxed/simple;
	bh=9vcdhWXXHqmKY9oyggRbZ6mE52+fXVCv2XdPDyB6LM0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GZg9f5qVbRTK95CbGOejsifi+5VSrUZCC+CsZUX2xUY2ArNp1Vu4PnZn4QXYfJdr7bglNLwMPupik/UFcGOIPfPtyh5aUQLZWBzhrhf+EaLm9S38VdkdzNkKgUxPXjDfU92LpFUrXgh5CVI99SekjeteuUc8vTFA1pBpRquaMIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V+5uSCSW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75D8FC4CEEA;
	Tue, 17 Jun 2025 01:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750124424;
	bh=9vcdhWXXHqmKY9oyggRbZ6mE52+fXVCv2XdPDyB6LM0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=V+5uSCSWsN+wvXnUPx7Qr3kEyW21tImMTKBiB3r1phF24GiChGmDPBpOqxqr09IhW
	 Ui3F82Wv6rI0XqtXMKHGBpfdecyO/WjNosJVnQ/HOvsDsbIAInOSvI8V7xnK7LQE8w
	 g7BxABNtJu7ag4KG+8C136AnAjbHp4R5h++b1u0wXMMBtK6/iiW4s01NTybmuCbsVu
	 2WOzbdgBMUx4BIP3YDQTLpNjoaq/09zBFAWJlK/hTD0qmBI7WodhOZ7+8jvdybnSzb
	 MQKMhPzeEZ7A9ftvfFqusuFIEPtwp3VL0rnYsqy09afZfxlUlez6Gs9XIs1GyEIP6i
	 h4P1cbPMOrHbA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70B8038111D8;
	Tue, 17 Jun 2025 01:40:54 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/5] eth: migrate to new RXFH callbacks
 (get-only
 drivers)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175012445324.2579607.13530180263957478401.git-patchwork-notify@kernel.org>
Date: Tue, 17 Jun 2025 01:40:53 +0000
References: <20250614180638.4166766-1-kuba@kernel.org>
In-Reply-To: <20250614180638.4166766-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 bharat@chelsio.com, benve@cisco.com, satishkh@cisco.com,
 claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, wei.fang@nxp.com,
 xiaoning.wang@nxp.com, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, bryan.whitehead@microchip.com,
 ecree.xilinx@gmail.com, rosenp@gmail.com, imx@lists.linux.dev

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 14 Jun 2025 11:06:33 -0700 you wrote:
> Migrate the drivers which only implement ETHTOOL_GRXFH to
> the recently added dedicated .get_rxfh_fields ethtool callback.
> 
> v2:
>  - fix enetc
>  - move the sfc falcon patch to later series in case I need to refactor
> v1: https://lore.kernel.org/20250613005409.3544529-1-kuba@kernel.org
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/5] eth: cisco: migrate to new RXFH callbacks
    https://git.kernel.org/netdev/net-next/c/b4512e36ec9e
  - [net-next,v2,2/5] eth: cxgb4: migrate to new RXFH callbacks
    https://git.kernel.org/netdev/net-next/c/8d90593fd539
  - [net-next,v2,3/5] eth: lan743x: migrate to new RXFH callbacks
    https://git.kernel.org/netdev/net-next/c/a689e2300e17
  - [net-next,v2,4/5] eth: e1000e: migrate to new RXFH callbacks
    https://git.kernel.org/netdev/net-next/c/b8379a59b282
  - [net-next,v2,5/5] eth: enetc: migrate to new RXFH callbacks
    https://git.kernel.org/netdev/net-next/c/9a9f7ce8cb77

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



