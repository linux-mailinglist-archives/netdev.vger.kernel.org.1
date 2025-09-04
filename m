Return-Path: <netdev+bounces-219761-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65116B42E3D
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 02:30:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D47955820C7
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 00:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03B701922DD;
	Thu,  4 Sep 2025 00:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="odTFl1GK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CADA67260B;
	Thu,  4 Sep 2025 00:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756945813; cv=none; b=FlRQYOkuiAQ2iYf1/rTRMJAzDiypyJM15xt7NoiQsrF9XfPqWQJfU1VXduZGshWUMYADM/9Sd5x6fqBZAwRfvEJzhDp7z7kALbgIqGfL6fMXyhlcyQCFqS8UsGJUZ0NT38aoMAnLN3adx47gRDGaVhb3ud9MJq7HOopxPz3YG8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756945813; c=relaxed/simple;
	bh=8YlLKo7oKMWe8nMTgXzhGD4l4zeBWdl4jzzaNRcv3tI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MgL2xgyG1P8wQggbjvNIfbccmRe971Mav5RxPz1OUOjhm8W3GCieakfTpsnLZFKGmosiD88uzp/ukrnfE4perYDYxPa/z3IUu2IWriUko6Sr4EDP34dFH5lWFSgfY8H/++7zhRGi82dpEuPhhhaW0MVvYjO7s1X6MSDbirAojt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=odTFl1GK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3D84C4CEE7;
	Thu,  4 Sep 2025 00:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756945813;
	bh=8YlLKo7oKMWe8nMTgXzhGD4l4zeBWdl4jzzaNRcv3tI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=odTFl1GKsc0uOzFyuMlYWir6XzVmSovsSYkA/xcaWKNQtdYQlS9T3uBVU9o2PoHWA
	 7Z1fpfd8zoBxEgMigj3OdlYdg+E7uhhRRqQwRbGpSoukVwTIjsi35J6SvPeuHxXtel
	 r32A6otZXFewij2nw6qwkycC5XSa3m1gyVykv3RVLkQdoYEh5rzB78+XNHtHz29kbo
	 3ADAomyrMukrTo2wGOeW6kGpBYnyhlEXTgl9LgGLzyfprTmgtLw36C3To/zkyB2UiY
	 QQKe/+5l/3KHjBwxcc1vv0xXv4o4kV0DwW38s1xJUJs6e7IYiJINqnrlgjt1V+X1ew
	 7LME9mPlprWdw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF72383C259;
	Thu,  4 Sep 2025 00:30:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4 0/3] net: stmmac: allow generation of flexible
 PPS relative to MAC time
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175694581848.1248581.9473792758575091904.git-patchwork-notify@kernel.org>
Date: Thu, 04 Sep 2025 00:30:18 +0000
References: <20250901-relative_flex_pps-v4-0-b874971dfe85@foss.st.com>
In-Reply-To: <20250901-relative_flex_pps-v4-0-b874971dfe85@foss.st.com>
To: Gatien CHEVALLIER <gatien.chevallier@foss.st.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, richardcochran@gmail.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, jstultz@google.com,
 tglx@linutronix.de, sboyd@kernel.org, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 1 Sep 2025 11:16:26 +0200 you wrote:
> When doing some testing on stm32mp2x platforms(MACv5), I noticed that
> the command previously used with a MACv4 for genering a PPS signal:
> echo "0 0 0 1 1" > /sys/class/ptp/ptp0/period
> did not work.
> 
> This is because the arguments passed through this command must contain
> the start time at which the PPS should be generated, relative to the
> MAC system time. For some reason, a time set in the past seems to work
> with a MACv4.
> 
> [...]

Here is the summary with links:
  - [net-next,v4,1/3] time: export timespec64_add_safe() symbol
    https://git.kernel.org/netdev/net-next/c/96c88268b79b
  - [net-next,v4,2/3] drivers: net: stmmac: handle start time set in the past for flexible PPS
    https://git.kernel.org/netdev/net-next/c/adbe2cfd8a93
  - [net-next,v4,3/3] ARM: dts: stm32: add missing PTP reference clocks on stm32mp13x SoCs
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



