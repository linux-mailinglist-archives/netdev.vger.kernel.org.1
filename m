Return-Path: <netdev+bounces-29133-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0E7B781AC6
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 20:35:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A7132810D9
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 18:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 077931398;
	Sat, 19 Aug 2023 18:34:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818BC10E1
	for <netdev@vger.kernel.org>; Sat, 19 Aug 2023 18:34:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0F685C433CB;
	Sat, 19 Aug 2023 18:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692470065;
	bh=xJqq30GVP9dEXWNakAzjnM5C9RyUKB7hh/Zt0sn9jZo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GsO003p3z1dOp4Z3+cBG5ktT6ExSJl4QCpjOwc9QhpzDyATRHcHb6ABig21p6Pbyl
	 wHsreed2ti2QkCik1EJXTE6fxBf5y73tNtBMysNUst5BSAUBttl2GiSvPUZzFan3PK
	 f9PlKQIK3HHGjK+s41aQ5vQg4hYJljuw368B6MMNrdxli2+TByAyJXlQdWJFnm8RlC
	 X6P3K/w/B6aMv97AHO6orHqUwf7uqohcgJXucXNikzqy3H8/Lk1K4ga+QrLrezvg6O
	 MsJkApwjdntlFjIAz9Cac+fXFD89W/7ZV/Webuc26WpCEoBpE12gXyi6apqrEdAhD6
	 Gqb8RmUswyt/Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id ED4E8C59A4C;
	Sat, 19 Aug 2023 18:34:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] stmmac: intel: Enable correction of MAC propagation
 delay
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169247006496.18695.9713799103278897460.git-patchwork-notify@kernel.org>
Date: Sat, 19 Aug 2023 18:34:24 +0000
References: <20230818111401.77962-1-kurt@linutronix.de>
In-Reply-To: <20230818111401.77962-1-kurt@linutronix.de>
To: Kurt Kanzenbach <kurt@linutronix.de>
Cc: alexandre.torgue@foss.st.com, joabreu@synopsys.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, netdev@vger.kernel.org, j.zink@pengutronix.de,
 richardcochran@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 18 Aug 2023 13:14:01 +0200 you wrote:
> All captured timestamps should be corrected by PHY, MAC and CDC introduced
> latency/errors. The CDC correction is already used. Enable MAC propagation delay
> correction as well which is available since commit 26cfb838aa00 ("net: stmmac:
> correct MAC propagation delay").
> 
> Before:
> |ptp4l[390.458]: rms    7 max   21 freq   +177 +/-  14 delay   357 +/-   1
> 
> [...]

Here is the summary with links:
  - [net-next] stmmac: intel: Enable correction of MAC propagation delay
    https://git.kernel.org/netdev/net-next/c/58f2ffdedf7b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



