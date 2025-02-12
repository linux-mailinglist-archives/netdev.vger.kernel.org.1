Return-Path: <netdev+bounces-165666-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26463A32F83
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 20:20:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0FE53A7C38
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 19:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64108263C76;
	Wed, 12 Feb 2025 19:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n4HWfeko"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D565263C70;
	Wed, 12 Feb 2025 19:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739388011; cv=none; b=qPrrazHEle2rciK3ZSdOlD9nmaNcM8nJKqFP2WxcZON+MxwLcU4yjYdXM+Z/reAwxIxiHRPv5+jGwGUa1/CXY5jSpQ/Icplr+B04ZQJ5YjQlh/R3Mz7mbi0wtWAaz2L9q1ZDu9P+f4kkdnl56XJOjR/o3LRt8NaO/kkuyHTRD90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739388011; c=relaxed/simple;
	bh=1WW+uNDvmwN0ECzuokCDZGQJfHr6k4YKe5XB3jMJSnA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fgXSOG6OeDB+9STYJ6DAwiTkVAZXFI/CD3a9APvaisdfHszJhtXcC5RRa9HVtUb+4CNV6LwKhS4KtjF0e9sDI1D1wMm8YfjHqYbqXl5f29NKKyjqWbX+4uqJdmJRh+ZAt8xpoC9c8DfNHLruljYiKt5bzNVpgWpTVByA+NJwn1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n4HWfeko; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFAA5C4CEE5;
	Wed, 12 Feb 2025 19:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739388010;
	bh=1WW+uNDvmwN0ECzuokCDZGQJfHr6k4YKe5XB3jMJSnA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=n4HWfeko12ExRdsexwnSmX20Q8WVKtxhBNwPMX8tteLDrNesu9V4iohSnomxmnn7V
	 hsOKNoaRaK1Ub6zuURrW+bDYccG1OXMQmxUvi8WBCg1Q1WHsF889sLgxrHV5HO2H9C
	 VS5LOA+/w7udlI0k28oMfF/L6zRFvOhlYbiAJyKtU4POwxyrutBuMf56vdARbG4NkZ
	 uxNZb5OZ773EuF042BpkMt9DEZBVsDUPmqwW8+K53W6yN/z6K92NwpPdTASShLbqL9
	 HXPkDRNlO9iplaiuAlYR+UMV/1XXOn9A7qXffeBPGy/DuA1PTTZXG5TXQK8joDYDaX
	 WtUeFZ4uH9FBg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EC44D380CED8;
	Wed, 12 Feb 2025 19:20:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4 0/2] Use PHYlib for reset randomization and
 adjustable polling
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173938803951.632131.11030259893241909320.git-patchwork-notify@kernel.org>
Date: Wed, 12 Feb 2025 19:20:39 +0000
References: <20250210082358.200751-1-o.rempel@pengutronix.de>
In-Reply-To: <20250210082358.200751-1-o.rempel@pengutronix.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 kernel@pengutronix.de, linux-kernel@vger.kernel.org, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 10 Feb 2025 09:23:56 +0100 you wrote:
> Hi all,
> 
> This patch set tackles a DP83TG720 reset lock issue and improves PHY
> polling. Rather than adding a separate polling worker to randomize PHY
> resets, I chose to extend the PHYlib framework - which already handles
> most of the needed functionality - with adjustable polling. This
> approach not only addresses the DP83TG720-specific problem (where
> synchronized resets can lock the link) but also lays the groundwork for
> optimizing PHY stats polling across all PHY drivers. With generic PHY
> stats coming in, we can adjust the polling interval based on hardware
> characteristics, such as using longer intervals for PHYs with stable HW
> counters or shorter ones for high-speed links prone to counter
> overflows.
> 
> [...]

Here is the summary with links:
  - [net-next,v4,1/2] net: phy: Add support for driver-specific next update time
    https://git.kernel.org/netdev/net-next/c/8bf47e4d7b87
  - [net-next,v4,2/2] net: phy: dp83tg720: Add randomized polling intervals for link detection
    https://git.kernel.org/netdev/net-next/c/e252af1a67fe

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



