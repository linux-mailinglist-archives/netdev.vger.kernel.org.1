Return-Path: <netdev+bounces-86031-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C42289D4E1
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 10:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD7E71F24696
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 08:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB8B7D094;
	Tue,  9 Apr 2024 08:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qL0HEfCE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48343BBD8;
	Tue,  9 Apr 2024 08:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712652630; cv=none; b=miT7kRTSffPPNulCdWFpMztPfStfuW095/nQADpAbcth/E9qAk2g/4DKHJLrOQlxODdU7TPlB0aku7mxUy0owQZNmm8Ldp+y1DDf/eIdiqf7DaLIB4UocIidKPFWAhHhk/PEbuXZImWYkI6ZJ833i7wU9sT9tqIutu0t/5t61Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712652630; c=relaxed/simple;
	bh=Q4ES11jOkbMXvltt4Ah2URi6ImcpS1P/SLB6L3SPtDE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tsiFuDxn/mi1KRqgLX0VaVFFaFk0b7V0mL8eHcHc0FjF+dvFiVPOIthcARAxqksqzGV2EiFVZB9NptQvCiNjF0CzxEkG5OmpPfmToUwqt4f2EVSbC+uNXvE15VuEVZ1BV5i0RVRPr/J1mpMwLmb+mV9c9zr264XWywt+xTvmVWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qL0HEfCE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8E8F5C43390;
	Tue,  9 Apr 2024 08:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712652629;
	bh=Q4ES11jOkbMXvltt4Ah2URi6ImcpS1P/SLB6L3SPtDE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qL0HEfCE7Q8k/C9zAPv1NOObZXW0LVhcsFfmSWDcM+9A6ydNVa9EAKwm7tJQ+TIu/
	 oVbsqDp9kGCiFhwqwI8TjeuMAjB34E1Hwyj0kMVXlEPC0Jz8C1ZUqD7sDsqA1kBCUE
	 S+qC2jYDymzyMtB/l4EUlGXvIaefC3ZMrcMFraRVklvaBnXvT+Gr5w0uDbcc6mjA7x
	 Hq6v0ETvg9WCAtTy7cQJxwWMWawlPV4wG+fzDyQ5T0lVsNo6NBCQsvB66Xw7B2eLoZ
	 59Si06NpvTLrOUW+1973hqcAwDPeQM1/+ZT5CfeZkG99WVjVtoD/UKsL6mbYDDlxnF
	 nLfHMbVcrzHeA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7527AD6030D;
	Tue,  9 Apr 2024 08:50:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v6 00/10] Support ICSSG-based Ethernet on AM65x SR1.0
 devices
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171265262947.12361.18235980577062677327.git-patchwork-notify@kernel.org>
Date: Tue, 09 Apr 2024 08:50:29 +0000
References: <20240403104821.283832-1-diogo.ivo@siemens.com>
In-Reply-To: <20240403104821.283832-1-diogo.ivo@siemens.com>
To: Diogo Ivo <diogo.ivo@siemens.com>
Cc: danishanwar@ti.com, rogerq@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, andrew@lunn.ch,
 dan.carpenter@linaro.org, jacob.e.keller@intel.com, robh@kernel.org,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 vigneshr@ti.com, wsa+renesas@sang-engineering.com, hkallweit1@gmail.com,
 arnd@arndb.de, vladimir.oltean@nxp.com, linux-arm-kernel@lists.infradead.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org, jan.kiszka@siemens.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed,  3 Apr 2024 11:48:10 +0100 you wrote:
> Hello,
> 
> This series extends the current ICSSG-based Ethernet driver to support
> AM65x Silicon Revision 1.0 devices.
> 
> Notable differences between the Silicon Revisions are that there is
> no TX core in SR1.0 with this being handled by the firmware, requiring
> extra DMA channels to manage communication with the firmware (with the
> firmware being different as well) and in the packet classifier.
> 
> [...]

Here is the summary with links:
  - [net-next,v6,01/10] dt-bindings: net: Add support for AM65x SR1.0 in ICSSG
    https://git.kernel.org/netdev/net-next/c/dc073430db8d
  - [net-next,v6,02/10] eth: Move IPv4/IPv6 multicast address bases to their own symbols
    https://git.kernel.org/netdev/net-next/c/e1900d7ba9c9
  - [net-next,v6,03/10] net: ti: icssg-prueth: Move common functions into a separate file
    https://git.kernel.org/netdev/net-next/c/e2dc7bfd677f
  - [net-next,v6,04/10] net: ti: icssg-prueth: Add SR1.0-specific configuration bits
    https://git.kernel.org/netdev/net-next/c/6d6a5751cd8e
  - [net-next,v6,05/10] net: ti: icssg-prueth: Add SR1.0-specific description bits
    https://git.kernel.org/netdev/net-next/c/8623dea207a7
  - [net-next,v6,06/10] net: ti: icssg-prueth: Adjust IPG configuration for SR1.0
    https://git.kernel.org/netdev/net-next/c/95c2e689331e
  - [net-next,v6,07/10] net: ti: icssg-prueth: Adjust the number of TX channels for SR1.0
    https://git.kernel.org/netdev/net-next/c/604e603d73ec
  - [net-next,v6,08/10] net: ti: icssg-prueth: Add functions to configure SR1.0 packet classifier
    https://git.kernel.org/netdev/net-next/c/0a74a9de79c1
  - [net-next,v6,09/10] net: ti: icssg-prueth: Modify common functions for SR1.0
    https://git.kernel.org/netdev/net-next/c/ce95cb4c8d26
  - [net-next,v6,10/10] net: ti: icssg-prueth: Add ICSSG Ethernet driver for AM65x SR1.0 platforms
    https://git.kernel.org/netdev/net-next/c/e654b85a693e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



