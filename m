Return-Path: <netdev+bounces-51065-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D8947F8DE1
	for <lists+netdev@lfdr.de>; Sat, 25 Nov 2023 20:20:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBF61281405
	for <lists+netdev@lfdr.de>; Sat, 25 Nov 2023 19:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9083D2F846;
	Sat, 25 Nov 2023 19:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aVGpPaBD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72EFF2207B
	for <netdev@vger.kernel.org>; Sat, 25 Nov 2023 19:20:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EB584C433C9;
	Sat, 25 Nov 2023 19:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700940024;
	bh=x1P2U8+ileI4olKcR6vT81q/7RE2xysJ3K6Mz872kjA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=aVGpPaBDK06M+sRrIYTg9aGz8bPuITkPNLFydx27yBpspZP12fXPqhaejTBJ9Gw9r
	 z7OA03VljR3UApbYhM34Y7ezH5PQPi83iLIbPo0MBN1w1YubMQZO3bS5Xv0NPQbB5B
	 +LnxpeMd4BFoXpQxVq5oZVncwpzGmnIiXZNubzWniXWO2Kcl1cI6/0sIvbEM+jrz+b
	 DosD+BcqRRDc7nHm8CyhMKZCB+ObDnE72/TwhHkyj03LVDRCNc5xA5/O3xno0rJYBv
	 iOqgQk2O8BqsJJm+sNhfFArSUc8ytx3eI3Q+fIFil3MdhsE7oRU2mfnUpsMekwVCgr
	 TV3wxLdeb5rIQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D06CAE00086;
	Sat, 25 Nov 2023 19:20:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: sfp: rework the RollBall PHY waiting code
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170094002384.26503.14965243825025429761.git-patchwork-notify@kernel.org>
Date: Sat, 25 Nov 2023 19:20:23 +0000
References: <20231121172024.19901-1-kabel@kernel.org>
In-Reply-To: <20231121172024.19901-1-kabel@kernel.org>
To: =?utf-8?q?Marek_Beh=C3=BAn_=3Ckabel=40kernel=2Eorg=3E?=@codeaurora.org
Cc: netdev@vger.kernel.org, rmk+kernel@armlinux.org.uk, kuba@kernel.org,
 andrew@lunn.ch

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 21 Nov 2023 18:20:24 +0100 you wrote:
> RollBall SFP modules allow the access to PHY registers only after a
> certain time has passed. Until then, the registers read 0xffff.
> 
> Currently we have quirks for modules where we need to wait either 25
> seconds or 4 seconds, but recently I got hands on another module where
> the wait is even shorter.
> 
> [...]

Here is the summary with links:
  - [net-next] net: sfp: rework the RollBall PHY waiting code
    https://git.kernel.org/netdev/net-next/c/2f3ce7a56c6e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



