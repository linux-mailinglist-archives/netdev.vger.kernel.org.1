Return-Path: <netdev+bounces-243559-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 496FECA3A42
	for <lists+netdev@lfdr.de>; Thu, 04 Dec 2025 13:43:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D52AB3037502
	for <lists+netdev@lfdr.de>; Thu,  4 Dec 2025 12:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92FA533FE36;
	Thu,  4 Dec 2025 12:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pyti1Zb1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6893033FE18;
	Thu,  4 Dec 2025 12:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764852191; cv=none; b=B2LX+8c+wmM3mfhmiJMX2839WGcPlwmKcbl3DQYuYhWwz14rI6H1oDw5DFvGXH/a188/Z89STQ3lTs/8HXVXLyfDV9LwnJcMxMWdzFrAVxv24l10d3TBhfi0+YJxf3OY779p/8+G07NqycuS+sMOdBfka4GUeR1oEpS9gDiw8CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764852191; c=relaxed/simple;
	bh=xFAqxUBVtgTOQCz9eEs01OaphGbuaHF4gkHguZnUyBU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CEqr95MoGuZY466vM5NdSEaLZ4w+beY7AVAE8D9Aj0xswIoVMwtzJXYnEOT6Y60WR1Uo5xWl3ggknuJDf3hL6OwHDWxKqtjz86NzU7Ja55SDSIUgiS8y5bXtxQiPfnf1WJHwiKSb4du8py7V0I8kfWJMSmy031b1LTIGYFUmU1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pyti1Zb1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2DEDC4CEFB;
	Thu,  4 Dec 2025 12:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764852187;
	bh=xFAqxUBVtgTOQCz9eEs01OaphGbuaHF4gkHguZnUyBU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Pyti1Zb1vtwwJqf5sENztIFqw8y48+ncYS/H4P93AzVKI0wVKOXoEz16oGSd0lqyO
	 0cdylY16jzmTg/lVpv9epYNA/WDMBYEiVy1d8x5saIf5XMdDljRLEhM0/47/qok0Io
	 N0rbI0ewTdh0otIvtqXWw7RSdVXyTG6JpMNAuekE2yQmyH6gWkuJBBD7gkTY/l+KnY
	 8R/9sD1bXw5HQnHSw4S8qpEhSCW3l6+6RTA3ztjxfOK/ZOYNoEZD2uX9t5zjtoMH0L
	 F7M0UkNRoOFTA+x3996TTyEpIE9Bjb2iZU7yhO+xpn2FDB5NOs00XsCM1MXHYPRi6x
	 XpHR9DqP8epuw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 787D63AA9A9D;
	Thu,  4 Dec 2025 12:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: dsa: mxl-gsw1xx: fix SerDes RX polarity
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176485200629.763406.7216085356112092216.git-patchwork-notify@kernel.org>
Date: Thu, 04 Dec 2025 12:40:06 +0000
References: 
 <ca10e9f780c0152ecf9ae8cbac5bf975802e8f99.1764668951.git.daniel@makrotopia.org>
In-Reply-To: 
 <ca10e9f780c0152ecf9ae8cbac5bf975802e8f99.1764668951.git.daniel@makrotopia.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: hauke@hauke-m.de, andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, ravi@prevas.dk,
 yweng@maxlinear.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 2 Dec 2025 09:57:21 +0000 you wrote:
> According to MaxLinear engineer Benny Weng the RX lane of the SerDes
> port of the GSW1xx switches is inverted in hardware, and the
> SGMII_PHY_RX0_CFG2_INVERT bit is set by default in order to compensate
> for that. Hence also set the SGMII_PHY_RX0_CFG2_INVERT bit by default in
> gsw1xx_pcs_reset().
> 
> Fixes: 22335939ec90 ("net: dsa: add driver for MaxLinear GSW1xx switch family")
> Reported-by: Rasmus Villemoes <ravi@prevas.dk>
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> 
> [...]

Here is the summary with links:
  - [net-next] net: dsa: mxl-gsw1xx: fix SerDes RX polarity
    https://git.kernel.org/netdev/net/c/5b48f49ee948

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



