Return-Path: <netdev+bounces-40922-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8762D7C91D1
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 02:30:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B85811C20FC8
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 00:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D62D36B;
	Sat, 14 Oct 2023 00:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eay5vYTJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB1615AC;
	Sat, 14 Oct 2023 00:30:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 35C51C4339A;
	Sat, 14 Oct 2023 00:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697243427;
	bh=qXHcb+8ArQUczUJqaU2Tky+9gId0V5ZhXHayMa6wpfA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Eay5vYTJTdIAwdF69vMwbD/Nm3g9UzhqHBA5b/6blwgekYREvJfMAphHN7/mxutCZ
	 7q3NDXWqUKl5ATZ8TCZWrt639W3pez389oP+ZfBm3fDuknPufwgU5AMFBLsPn9Ma4/
	 BYxkzQs1vz4lq4uNMmSjmb0G2TZ5MDbQVcryN/aYqQ2F6wQOxcVsItRIgo3ZuvAqZ5
	 00etRf00Jzz23f/78mTNmHLZJk32J4vDU+3peDcK40ynbWtBFyq5NkESimYI8f6hYX
	 KzK/oHBVTuDdsTH3cvEdwY2G5CXmUwU/jxI13krd+j72vfiJSr+D02s0SumsRnTYmC
	 qGyrRvsmjSsTg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0BE08E1F66E;
	Sat, 14 Oct 2023 00:30:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: phy: tja11xx: replace deprecated strncpy with
 ethtool_sprintf
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169724342704.24435.10662096936331983951.git-patchwork-notify@kernel.org>
Date: Sat, 14 Oct 2023 00:30:27 +0000
References: <20231012-strncpy-drivers-net-phy-nxp-tja11xx-c-v1-1-5ad6c9dff5c4@google.com>
In-Reply-To: <20231012-strncpy-drivers-net-phy-nxp-tja11xx-c-v1-1-5ad6c9dff5c4@google.com>
To: Justin Stitt <justinstitt@google.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 12 Oct 2023 22:25:12 +0000 you wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> ethtool_sprintf() is designed specifically for get_strings() usage.
> Let's replace strncpy in favor of this dedicated helper function.
> 
> [...]

Here is the summary with links:
  - net: phy: tja11xx: replace deprecated strncpy with ethtool_sprintf
    https://git.kernel.org/netdev/net-next/c/c3983d5e99b2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



