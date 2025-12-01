Return-Path: <netdev+bounces-243055-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83DE9C98F1B
	for <lists+netdev@lfdr.de>; Mon, 01 Dec 2025 21:03:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A72F3A3B9D
	for <lists+netdev@lfdr.de>; Mon,  1 Dec 2025 20:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A033246BB9;
	Mon,  1 Dec 2025 20:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZStsFEZE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7C922578D;
	Mon,  1 Dec 2025 20:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764619392; cv=none; b=rSOkQtR0yRHUgbFZ6TXTP/p0zXvnQCAfRqarGG2s/+MbW2t80USofnetgkP7C34MI7EebroCou8cEfpDIWykipMsDd8rCHZHsUKcYqGSq+GNe2MCCCJ9bcyHGRMPL89DUYP6VQWZWiMNAfaJMjDQTffnmOlUJfjQGMFComvMSm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764619392; c=relaxed/simple;
	bh=FEMsSSZ5HXl/D+Uyr8Mh2BCsw+8YVrF0kXmFD4v30Mw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=E98wtPt6iUN302eY0kHI9ci1VF0QzWlRCvUm0ul4yjR0cv1YTU9l4ykc5/43xdauulbxiaQ/pdWOLzUT4I3Ytbvu/jMMzILVCcAu5nMITVZ869UCakOZsckl7m75uSiJ+Z09oDvboT3ZLMQXC94mcErrsQdht4UE+N+bh71FGJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZStsFEZE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE966C4CEF1;
	Mon,  1 Dec 2025 20:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764619391;
	bh=FEMsSSZ5HXl/D+Uyr8Mh2BCsw+8YVrF0kXmFD4v30Mw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZStsFEZEQegj9Lhobtrq7rCpPn+GKlz1ArXjQDt15T6H2MRbiuReeijNW+Opf+FGD
	 zuzKlOSc4I1uL2bKUlP35cQCkhezyUmELuuH8u5450F9H2QtRdeEe59BsEpLU2R+jF
	 zcRwtqcCBqoIzA0B4P9MiWeKkE8fUOLj9R8m7ITJRlmc+aEBqMq6OVCxO5PVd733vs
	 qzaLar3BaNKTHHvJtU5ahQ9n4yVLgm/mWLMvfsg6z7PXu9lzQxS6v6PQY0v8I1ljFB
	 cS8ookcwrRc3OXeo+WNsvpNjLQxoP12ZPnK8guVTKPbfhmP/mZZm0tAG71oB58w+wi
	 bmSeOmQJGwzYw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F28E1381196A;
	Mon,  1 Dec 2025 20:00:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/3] net: freescale: migrate to
 .get_rx_ring_count() ethtool callback
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176461921179.2515760.13851100903689517014.git-patchwork-notify@kernel.org>
Date: Mon, 01 Dec 2025 20:00:11 +0000
References: <20251128-gxring_freescale-v1-0-22a978abf29e@debian.org>
In-Reply-To: <20251128-gxring_freescale-v1-0-22a978abf29e@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: claudiu.manoil@nxp.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 ioana.ciornei@nxp.com, vladimir.oltean@nxp.com, wei.fang@nxp.com,
 xiaoning.wang@nxp.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 28 Nov 2025 05:11:44 -0800 you wrote:
> This series migrates Freescale network drivers to use the new .get_rx_ring_count()
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
  - [net-next,1/3] net: gianfar: convert to use .get_rx_ring_count
    https://git.kernel.org/netdev/net-next/c/d3fbfb8b2c4a
  - [net-next,2/3] net: dpaa2: convert to use .get_rx_ring_count
    https://git.kernel.org/netdev/net-next/c/b2d633926901
  - [net-next,3/3] net: enetc: convert to use .get_rx_ring_count
    https://git.kernel.org/netdev/net-next/c/ca8df5b877d4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



