Return-Path: <netdev+bounces-219140-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49E18B4013E
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 14:50:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77FB31B60B54
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 12:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FE152D3735;
	Tue,  2 Sep 2025 12:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eXj0AARH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282F92D24A6;
	Tue,  2 Sep 2025 12:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756817426; cv=none; b=grLW5w5I/iBYoNcPOL/hPQ+c7KtBYgq5RgYblcO7YxvSafHJnet7abxj1Xg/ULtDsNcNwJJX8EMD8of4m9Tnrz85OtCaQQnrM+RPYUwIdTHdQwY0m4Ceockwvl0o2s52DWJh06EfBgkmDJFjCfnaZ4bTMAKg2LDFuEk/v1XK3ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756817426; c=relaxed/simple;
	bh=wqZtObeKB/uSkLt+mF3iBRFMdkEOwyqC6/cdbGY1IWo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NGFicr/haEhWmpZKbzmBxB/4357vBmLpTpytSNs0xXpZBOF9jMU5T6t8c/k990ADqcpF1rFWtn8fNr4DyHNG6W1QN4Fyfss6Q9PJm7VWT1FBW5k9yS5eqJbNQwcTVkR3k1O4hMtDCxg6IV6vgqgjvZn3BNX1OiOf5RajdKjbt2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eXj0AARH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADB03C4CEF5;
	Tue,  2 Sep 2025 12:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756817425;
	bh=wqZtObeKB/uSkLt+mF3iBRFMdkEOwyqC6/cdbGY1IWo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eXj0AARHucUDamcZbQBrrKeFjwRMPqpU1NDGNuCig/YAhVuN+P3NX9bBc/1fF+c6f
	 qrxoPM4Xm2lnLBC3EnGWTf4/gaFkBKpDLzXFql0FIN7AJFleia6rn9kkHrQR5QkKDS
	 pja1klGraGAcqoP5A5rlU29rM4hQKmZrEAkoMrO2n01x+hH2yQFmEoZAVFttlJEyZ+
	 igy0HSkBQipUeYpHRAhWiSehdlL9JRZZPrtUzMmUb0Lw1jItAUAdN08jwtbStJI8C5
	 +Dm9T+98pajHustw7L7Xsbf5s0Upz6KcXqMWxYloVQVV2+fbD/5oDgneK14AB+snJS
	 tz+FLonB+2FNA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71854383BF75;
	Tue,  2 Sep 2025 12:50:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v7 net-next 00/14] Add NETC Timer PTP driver and add PTP
 support for i.MX95
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175681743106.280373.4120937080041780119.git-patchwork-notify@kernel.org>
Date: Tue, 02 Sep 2025 12:50:31 +0000
References: <20250829050615.1247468-1-wei.fang@nxp.com>
In-Reply-To: <20250829050615.1247468-1-wei.fang@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 richardcochran@gmail.com, claudiu.manoil@nxp.com, vladimir.oltean@nxp.com,
 xiaoning.wang@nxp.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 vadim.fedorenko@linux.dev, Frank.Li@nxp.com, shawnguo@kernel.org,
 fushi.peng@nxp.com, devicetree@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 29 Aug 2025 13:06:01 +0800 you wrote:
> This series adds NETC Timer PTP clock driver, which supports precise
> periodic pulse, time capture on external pulse and PTP synchronization.
> It also adds PTP support to the enetc v4 driver for i.MX95 and optimizes
> the PTP-related code in the enetc driver.
> 
> ---
> v1 link: https://lore.kernel.org/imx/20250711065748.250159-1-wei.fang@nxp.com/
> v2 link: https://lore.kernel.org/imx/20250716073111.367382-1-wei.fang@nxp.com/
> v3 link: https://lore.kernel.org/imx/20250812094634.489901-1-wei.fang@nxp.com/
> v4 link: https://lore.kernel.org/imx/20250819123620.916637-1-wei.fang@nxp.com/
> v5 link: https://lore.kernel.org/imx/20250825041532.1067315-1-wei.fang@nxp.com/
> v6 link: https://lore.kernel.org/imx/20250827063332.1217664-1-wei.fang@nxp.com/
> 
> [...]

Here is the summary with links:
  - [v7,net-next,01/14] dt-bindings: ptp: add NETC Timer PTP clock
    https://git.kernel.org/netdev/net-next/c/d6900b8bd362
  - [v7,net-next,02/14] dt-bindings: net: move ptp-timer property to ethernet-controller.yaml
    https://git.kernel.org/netdev/net-next/c/db2d2de1c2a8
  - [v7,net-next,03/14] ptp: add helpers to get the phc_index by of_node or dev
    https://git.kernel.org/netdev/net-next/c/61f132ca8c46
  - [v7,net-next,04/14] ptp: netc: add NETC V4 Timer PTP driver support
    https://git.kernel.org/netdev/net-next/c/87a201d59963
  - [v7,net-next,05/14] ptp: netc: add PTP_CLK_REQ_PPS support
    https://git.kernel.org/netdev/net-next/c/91596332ff5d
  - [v7,net-next,06/14] ptp: netc: add periodic pulse output support
    https://git.kernel.org/netdev/net-next/c/671e266835b8
  - [v7,net-next,07/14] ptp: netc: add external trigger stamp support
    https://git.kernel.org/netdev/net-next/c/b1d37b27036a
  - [v7,net-next,08/14] MAINTAINERS: add NETC Timer PTP clock driver section
    https://git.kernel.org/netdev/net-next/c/dc331726469d
  - [v7,net-next,09/14] net: enetc: save the parsed information of PTP packet to skb->cb
    https://git.kernel.org/netdev/net-next/c/19669a57d7a0
  - [v7,net-next,10/14] net: enetc: extract enetc_update_ptp_sync_msg() to handle PTP Sync packets
    https://git.kernel.org/netdev/net-next/c/27dd0eca9347
  - [v7,net-next,11/14] net: enetc: remove unnecessary CONFIG_FSL_ENETC_PTP_CLOCK check
    https://git.kernel.org/netdev/net-next/c/d889abaac299
  - [v7,net-next,12/14] net: enetc: move sync packet modification before dma_map_single()
    https://git.kernel.org/netdev/net-next/c/7776d5e6e349
  - [v7,net-next,13/14] net: enetc: add PTP synchronization support for ENETC v4
    https://git.kernel.org/netdev/net-next/c/f5b9a1cde0a2
  - [v7,net-next,14/14] net: enetc: don't update sync packet checksum if checksum offload is used
    https://git.kernel.org/netdev/net-next/c/93081d4ed54e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



