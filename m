Return-Path: <netdev+bounces-79300-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D306878AA3
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 23:20:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E63C1C20DA2
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 22:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 221AD57323;
	Mon, 11 Mar 2024 22:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b4MRZsPZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A3458100
	for <netdev@vger.kernel.org>; Mon, 11 Mar 2024 22:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710195632; cv=none; b=R6p+ojoSCotiwoFstOwrEbVlD2iFxS3Kjt4olEZuFygwG0s0RTVVGBYASpZubMgmnmKKhP4dIjs7Ar0oZNZqzR7bAnorqA8kQTniSkn7bT7dX+vOoWLQLEL1MA8b56WcjstJHDBW1tAC4qicCzkUkJv/w1biasAsfIZzTaRMxJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710195632; c=relaxed/simple;
	bh=nabhkSU6CaBpxlwRrt3a5IaEXZGVfr8nABdgY6Pclj4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gHFlkf0PwkO/MZUM7/XftUIgkylfW7HE0SftSHR35dLDrp+98VEzLO6ebUkPHVn17bVbkaR++R9poBVlkj+J775HRJESTlAd6wT4RDYprKuPDx6oakp1asGfgzf41sdXmehOeavppQNkMaUxuBUadDbRMfB1biXdLJRGKW6TvvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b4MRZsPZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9AC48C43394;
	Mon, 11 Mar 2024 22:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710195631;
	bh=nabhkSU6CaBpxlwRrt3a5IaEXZGVfr8nABdgY6Pclj4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=b4MRZsPZnofuJ3M3/A5jJMXtiMufFb8981jFLGR15obH8E04unZFUABCB1OxsEwAY
	 gEm8ORloGUDMRtSgN4EupTFKXPVt4ouxpoVVCfSzNZIpCUyknDsjRfZVwXVPz4oBCX
	 R0dysB/e0ANMbGHYDtQuM6pL1GDHsDYwe9Vt139Rauc7eh80yrSDWzVrVBGnPU05gY
	 A0g0uEdcj6cYkGpVsuAUeTV3grf8yEc+EPt6wxo1oXmRQT54YFn0Wt3CiXW/bOAMEo
	 uwWtNXjZfOQWku7gprRC7NysAr8HrF9ql33p4DLWOOJ8TyCFwRlDv59QCPiNl7sr2z
	 YI/Q5blD57/GQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7DE03C395F1;
	Mon, 11 Mar 2024 22:20:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: wan: framer/pef2256: Convert to platform remove callback
 returning void
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171019563151.21986.7590357224357705934.git-patchwork-notify@kernel.org>
Date: Mon, 11 Mar 2024 22:20:31 +0000
References: <9684419fd714cc489a3ef36d838d3717bb6aec6d.1709886922.git.u.kleine-koenig@pengutronix.de>
In-Reply-To: <9684419fd714cc489a3ef36d838d3717bb6aec6d.1709886922.git.u.kleine-koenig@pengutronix.de>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig_=3Cu=2Ekleine-koenig=40pengutronix=2Ede=3E?=@codeaurora.org
Cc: herve.codina@bootlin.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 kernel@pengutronix.de

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  8 Mar 2024 09:51:09 +0100 you wrote:
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is ignored (apart
> from emitting a warning) and this typically results in resource leaks.
> 
> To improve here there is a quest to make the remove callback return
> void. In the first step of this quest all drivers are converted to
> .remove_new(), which already returns void. Eventually after all drivers
> are converted, .remove_new() will be renamed to .remove().
> 
> [...]

Here is the summary with links:
  - net: wan: framer/pef2256: Convert to platform remove callback returning void
    https://git.kernel.org/netdev/net-next/c/0d1a7a8fac5b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



