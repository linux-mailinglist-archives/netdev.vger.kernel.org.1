Return-Path: <netdev+bounces-127602-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 53E30975DA8
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 01:21:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED45EB22C65
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 23:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85B591BCA0D;
	Wed, 11 Sep 2024 23:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YAA+58B1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD741B9B45;
	Wed, 11 Sep 2024 23:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726096837; cv=none; b=F7EzOOSQs55QtUHIEnNRI4Cxch12CFhx9AczGu236tUTmLQkDO88NjiYCF5vVo5epui0zNuf3yP4G+SHhVuNPgmzdV4cTu9jNDRRQnCrhVUgq2raXeAx5YrtkZNVUt7qNITK9Fanij1i7slsBeBrxtVfWakcn5hIRuxxV1tWtK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726096837; c=relaxed/simple;
	bh=E6hbaUCATMi6KhHvTCaZEaoztd+MwFpjrHMdDITsagU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BgdvSiCpDQMylB+fls1W1MqOX03EcDFdpUXQv08J5mQUQnXEerrPGB2kYNgf0witpChVc8GQHtSo8Ar40Z9Ner/ScnRGO99VY8LrjtHtQRjbqbf1AHUMw6voEfazxpds/nJBZWIdwaaXc6ibCbxmyfbJhfalzkLLMPRILbxeb0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YAA+58B1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5AA4C4CECD;
	Wed, 11 Sep 2024 23:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726096836;
	bh=E6hbaUCATMi6KhHvTCaZEaoztd+MwFpjrHMdDITsagU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YAA+58B1+H0wqU1v/oDaC1nPADX0XOsZiwO+yJPrudC1kYNBJwFk0HxZuiK2Uv131
	 5unFdwU7d0hISidlSjrBdVeLLtwyXnsaiNAxWvUaGcACRxfXXGE/52CtaB262uChWu
	 Qjb1ow2IRnX5l9Ow3/zQ57yU0ClBuhncXro2EYKplOXiJLgtvx3JHBOCLiJUnXxA4r
	 a4oqOgBppoBJxDPFOIkCUpvnJ0XFjmG6VWyjkgBB3jrIvcCLNoOwrWGqYoxWUq1XCs
	 FhigSe2n8Sx8MKm4JEB5zwDNUkeyLExuGS1hXvCImjcNMBLGUFCmHBvHzZDcZBhUUk
	 VtIWBl/OD/y4w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E9E3806656;
	Wed, 11 Sep 2024 23:20:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net] net: dsa: felix: ignore pending status of TAS module
 when it's disabled
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172609683781.1105624.8461423176901679362.git-patchwork-notify@kernel.org>
Date: Wed, 11 Sep 2024 23:20:37 +0000
References: <20240906093550.29985-1-xiaoliang.yang_1@nxp.com>
In-Reply-To: <20240906093550.29985-1-xiaoliang.yang_1@nxp.com>
To: Xiaoliang Yang <xiaoliang.yang_1@nxp.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, vladimir.oltean@nxp.com, claudiu.manoil@nxp.com,
 alexandre.belloni@bootlin.com, UNGLinuxDriver@microchip.com, andrew@lunn.ch,
 f.fainelli@gmail.com, michael@walle.cc, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  6 Sep 2024 17:35:50 +0800 you wrote:
> The TAS module could not be configured when it's running in pending
> status. We need disable the module and configure it again. However, the
> pending status is not cleared after the module disabled. TC taprio set
> will always return busy even it's disabled.
> 
> For example, a user uses tc-taprio to configure Qbv and a future
> basetime. The TAS module will run in a pending status. There is no way
> to reconfigure Qbv, it always returns busy.
> 
> [...]

Here is the summary with links:
  - [v2,net] net: dsa: felix: ignore pending status of TAS module when it's disabled
    https://git.kernel.org/netdev/net/c/70654f4c212e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



