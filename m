Return-Path: <netdev+bounces-60158-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F4A881DE9D
	for <lists+netdev@lfdr.de>; Mon, 25 Dec 2023 07:32:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2785D281590
	for <lists+netdev@lfdr.de>; Mon, 25 Dec 2023 06:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A01036D;
	Mon, 25 Dec 2023 06:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eSTXAWx1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E4515A8
	for <netdev@vger.kernel.org>; Mon, 25 Dec 2023 06:32:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D0CB2C433C9;
	Mon, 25 Dec 2023 06:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703485936;
	bh=g+ncAlkaBYYJJm+xDdVGRlq5cuPywo7Y6poYiXhHhEY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eSTXAWx1psEk5KGbiYmVS6z9e2RKsfcfT915f5km+bWPbfQZJ60OXzNtACJd3hCgZ
	 Yb3uPD2G/MmREiCymES2bDSP5WFbDu8rKb1KhDu7hfSw2WRavze0iGPrYUnwhO5vn9
	 LScE8fqlGY84norrrztV2pap4eVS1WZ0oIJnTcT8wOHi60vE10vCbTuARXhJf8+Mun
	 PgT+N3+Ixb1kUTnsPChqWuJnnmB0su+Lo3Nv/RuCcxAvJHPXa56S2lxbRfKC48Aqu3
	 8iE86/mzdeYnc/ZuP0s1yHj5wCvlmCoaaJoQQJTLfUzB/ihesy3Gb3kVNcMD+WH/ku
	 hIaVg5BhPoDHw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B983DE333D3;
	Mon, 25 Dec 2023 06:32:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: sfp: fix PHY discovery for FS SFP-10G-T module
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170348593675.20912.750297019338007310.git-patchwork-notify@kernel.org>
Date: Mon, 25 Dec 2023 06:32:16 +0000
References: <20231219162415.29409-1-kabel@kernel.org>
In-Reply-To: <20231219162415.29409-1-kabel@kernel.org>
To: =?utf-8?q?Marek_Beh=C3=BAn_=3Ckabel=40kernel=2Eorg=3E?=@codeaurora.org
Cc: netdev@vger.kernel.org, rmk+kernel@armlinux.org.uk, kuba@kernel.org,
 andrew@lunn.ch, quic_leiwei@quicinc.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 19 Dec 2023 17:24:15 +0100 you wrote:
> Commit 2f3ce7a56c6e ("net: sfp: rework the RollBall PHY waiting code")
> changed the long wait before accessing RollBall / FS modules into
> probing for PHY every 1 second, and trying 25 times.
> 
> Wei Lei reports that this does not work correctly on FS modules: when
> initializing, they may report values different from 0xffff in PHY ID
> registers for some MMDs, causing get_phy_c45_ids() to find some bogus
> MMD.
> 
> [...]

Here is the summary with links:
  - [net-next] net: sfp: fix PHY discovery for FS SFP-10G-T module
    https://git.kernel.org/netdev/net-next/c/e9301af385e7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



