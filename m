Return-Path: <netdev+bounces-220544-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6366DB46837
	for <lists+netdev@lfdr.de>; Sat,  6 Sep 2025 04:00:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04E753A8F5E
	for <lists+netdev@lfdr.de>; Sat,  6 Sep 2025 02:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90A671A23AF;
	Sat,  6 Sep 2025 02:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZQw+RFSj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3BD19F137
	for <netdev@vger.kernel.org>; Sat,  6 Sep 2025 02:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757124005; cv=none; b=roxKLQtCDLpfphU4dy3XeVoFDsP6czp2c+I6aeI5BTpuP+bG2YUzlRXU7ho32LSFeZFvsuevsvnmi2RCDF+H9txkeNQyDgIjiYYAneyjk6OWCdwJ5B5xymo9Vx2NHLSha/OezNozS1gCRc3Kwgazceg0NZ6I74azqyP0HkhVzgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757124005; c=relaxed/simple;
	bh=EXTpDimrD71jZCY57QxP2cDPjeFi4jI26zptPDAqL6E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BqDVd2zYD2R3KL/jlNUq/JUtSeH2ckHPP+WmB5sa89Q7S1NluSPcsE80AZWtYWD7NkhcB2EOpHzg+a9dtJdfF8lNOw+JSiCWEj7hRvOpDTTEwmOYZalXUYk2neli+VUU3SDB37Q71qvh3MFhRyagpjg3zMH7V83MYsx8udTe1iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZQw+RFSj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC9FCC4CEF1;
	Sat,  6 Sep 2025 02:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757124004;
	bh=EXTpDimrD71jZCY57QxP2cDPjeFi4jI26zptPDAqL6E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZQw+RFSjo978Rw1kRGeSIP1gERbi/QgVd3Ke0m/cOa4cmj9XZb1gHB6p8Avbw6riF
	 HWpmRWC/gHF/UCpEA4BxLDVQG8xhh6WmHXk7fj3W9ifIco7Yv7xr+slg4OtJCEoEEk
	 h/bL3gs+cnVte8GBNLscn3XfShLxxDnvKFNOTVfIr9L/5qfhaE9hafhWi1PrkosRiz
	 Im6rrUXkZ9diP1D36rBNANDOxCjAYh3xtQm1IfNtDxMF0niqQ2b5/akxIeCtwDeYnL
	 56OovFMCHSo8/WoBDe3HQ1KsiOFXQSDWlZibTocwX6C5I2H0AulAuOYNDm+2s6wCci
	 M3Nvm7WPHntag==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D97383BF69;
	Sat,  6 Sep 2025 02:00:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] net: stmmac: correctly populate
 ptp_clock_ops.getcrosststamp
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175712400925.2744531.10227247903778981138.git-patchwork-notify@kernel.org>
Date: Sat, 06 Sep 2025 02:00:09 +0000
References: <aLhJ8Gzb0T2qpXBE@shell.armlinux.org.uk>
In-Reply-To: <aLhJ8Gzb0T2qpXBE@shell.armlinux.org.uk>
To: Russell King (Oracle) <linux@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, richardcochran@gmail.com,
 alexandre.torgue@foss.st.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, mcoquelin.stm32@gmail.com,
 netdev@vger.kernel.org, pabeni@redhat.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 3 Sep 2025 15:00:16 +0100 you wrote:
> Hi,
> 
> While reviewing code in the stmmac PTP driver, I noticed that the
> getcrosststamp() method is always populated, irrespective of whether
> it is implemented or not by the stmmac platform specific glue layer.
> 
> Where a platform specific glue layer does not implement it, the core
> stmmac driver code returns -EOPNOTSUPP. However, the PTP clock core
> code uses the presence of the method in ptp_clock_ops to determine
> whether this facility should be advertised to userspace (see
> ptp_clock_getcaps()).
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] net: stmmac: ptp: conditionally populate getcrosststamp() method
    https://git.kernel.org/netdev/net-next/c/bb427fb839de
  - [net-next,2/2] net: stmmac: intel: only populate plat->crosststamp when supported
    https://git.kernel.org/netdev/net-next/c/0c9fbb38e2a9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



