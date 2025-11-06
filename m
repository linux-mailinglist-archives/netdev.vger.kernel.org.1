Return-Path: <netdev+bounces-236153-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B0D7C38E3E
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 03:40:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2D4434ED8A9
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 02:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F5F6246327;
	Thu,  6 Nov 2025 02:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UHNircHW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74AAD242D7D;
	Thu,  6 Nov 2025 02:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762396838; cv=none; b=a4KqgJAEuso++f2WeGIO6EGZOI8054avKO5nzEOydtYpXzJlgSVw3qYWq/rsGeOLUu+ocEthLUDi6wfqmhsvnMbZUzRWwqkFlhHUnHbjti4FlsxMT0PHnqNLu5ruLwee+gZ2U27S2uLwV7Jar8u+n4HQKRI7pxsoNEzuQHDyLR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762396838; c=relaxed/simple;
	bh=GxAFBY0FuzXylt3WKOzyYIHU0Sz+s/MVF/ONHT3Sg0o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ifGgzLYlLfyI0WzBREuAwA0lBu5TZ7EnnrVyhNcDE8y58hxrayOhgv6eo8c+07ok/hXPYO/xH7szBaF/7Sg39ZBo0hHBXC2gyhJ3pjafq7ZVRz7GBMzbcZVAXbnIO14nEjW6TWnyiujy8R4Xr+tjYoTD4YRC3EB+OoMdATxXV78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UHNircHW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 037F8C4CEF8;
	Thu,  6 Nov 2025 02:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762396838;
	bh=GxAFBY0FuzXylt3WKOzyYIHU0Sz+s/MVF/ONHT3Sg0o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UHNircHWcHy3PSqdTQHRBGrQqufuaIO7vo9bAJHYDavrkSDS6yd5KUQWNWgxTGwug
	 ce5X2nKkdAstgwgC8PrTSBfOWA0OsfZHrPD7Q8EcVs/0HDhe3qJicv7h0LKF9mbYPd
	 trKNLNtgaGMIeMRM+DpX8KdBIeM7TliSUDBCXFZID8JSYEaLXrei5t9PJHlZh1QfGe
	 0BBOBaMPALeSeAR0D+oBJ70s27Yly4HDNijFHkFnT0d7oNT53Ec6a7aaDcNIWUZocr
	 DS5yLFR9608fokkKIj6gCWZX2ETBeX8BJ7IrN+Kyd0TJtqin22QDAOzFz8xsPWv8/4
	 Tg5FQ/wedVDlw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70CFC380AAF9;
	Thu,  6 Nov 2025 02:40:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/4] net: stmmac: socfpga: Add Agilex5
 platform
 support and enhancements
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176239681110.3843222.1196366168534081089.git-patchwork-notify@kernel.org>
Date: Thu, 06 Nov 2025 02:40:11 +0000
References: <20251101-agilex5_ext-v2-0-a6b51b4dca4d@altera.com>
In-Reply-To: <20251101-agilex5_ext-v2-0-a6b51b4dca4d@altera.com>
To: Rohan G Thomas <rohan.g.thomas@altera.com>
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 richardcochran@gmail.com, s.trumtrar@pengutronix.de, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 01 Nov 2025 01:27:06 +0800 you wrote:
> This patch series adds support for the Agilex5 EMAC platform to the
> dwmac-socfpga driver.
> 
> The series includes:
>    - Platform configuration for Agilex5 EMAC
>    - Enabling Time-Based Scheduling (TBS) for Tx queues 6 and 7
>    - Enabling TCP Segmentation Offload(TSO)
>    - Adding hardware-supported cross timestamping using the SMTG IP,
>      allowing precise synchronization between MAC and system time via
>      PTP_SYS_OFFSET_PRECISE.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/4] net: stmmac: socfpga: Agilex5 EMAC platform configuration
    https://git.kernel.org/netdev/net-next/c/93d46ea3e984
  - [net-next,v2,2/4] net: stmmac: socfpga: Enable TBS support for Agilex5
    https://git.kernel.org/netdev/net-next/c/4c00476d4480
  - [net-next,v2,3/4] net: stmmac: socfpga: Enable TSO for Agilex5 platform
    https://git.kernel.org/netdev/net-next/c/e28988aef70f
  - [net-next,v2,4/4] net: stmmac: socfpga: Add hardware supported cross-timestamp
    https://git.kernel.org/netdev/net-next/c/fd8c4f645496

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



