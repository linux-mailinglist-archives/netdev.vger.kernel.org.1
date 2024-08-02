Return-Path: <netdev+bounces-115450-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 565A6946636
	for <lists+netdev@lfdr.de>; Sat,  3 Aug 2024 01:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2E431F22430
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 23:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B49E13B28D;
	Fri,  2 Aug 2024 23:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rj6YErjk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2685C22EF4
	for <netdev@vger.kernel.org>; Fri,  2 Aug 2024 23:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722642033; cv=none; b=heJ0rdZPw0YqJHbOiV20UAqiIz2n3qi6MKkFpzF36USMRe+HuIBqmKAb7GOlXkdZkWim/HM9jxLUn/ia8G/b9XlL2RObhvgskFYvG6eu7CUEctX9aV8gOJ5MjLTD0yerwErGtgbewTUdwNTV3jEUQ+/D+Oq5Zp3POrz4VPXy+S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722642033; c=relaxed/simple;
	bh=f0UxB63zUiPeLGbpLnETLpfny0o+hxqO9dYrUn6lHUY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dTcux028B5LCg2umIsXzS05D0wZ5J3EkNtNGOzyJrLWrjrIvrZp0X8nXBxSyLz4tPd6cPNUN7PiAixqUTIDUZ5SAIeO+UU0bQReEtZ5nv0C+qbGK1UaC41pnIuH+CKNwGcDZA5epw3sBqmVtbnFaXmWPHODn1WrAj0GLvbKUwV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rj6YErjk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A2831C4AF0B;
	Fri,  2 Aug 2024 23:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722642032;
	bh=f0UxB63zUiPeLGbpLnETLpfny0o+hxqO9dYrUn6lHUY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rj6YErjkkPTxSy5CVQagXH7CwTkB3nyHk4b7b114+/J+X9oChRlEqmvDw1FGoZRPl
	 Km/kdiQbMEuOunnhEijP6O2cAl7530ddki7z0kBEcsQTeHURSCGQiUBs25p9+2trsV
	 d5A/DVWumyhgtazo1/2pGWi4R51HY/1I+htQIo83iS6iEhaMwEDX5aGYqj6fIchVKR
	 uE/KzFNIzHkno0hweGly5NN+gEauEX6vBsCFT+3w0XW58uFx2ZmnrsAJqNuiXKuHIc
	 2F7YXP3PmWJpuZ0cOrepSQEjz0lNdTd0lWsIDTY/kie122LxzWuLBxSbmfr/7q6tht
	 OgZDMTHpCzLYw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 91340C43330;
	Fri,  2 Aug 2024 23:40:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] linkmode: Change return type of linkmode_andnot
 to bool
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172264203259.30831.16041794314528294229.git-patchwork-notify@kernel.org>
Date: Fri, 02 Aug 2024 23:40:32 +0000
References: <20240801-linkfield-bowl-v1-1-d58f68967802@kernel.org>
In-Reply-To: <20240801-linkfield-bowl-v1-1-d58f68967802@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 01 Aug 2024 21:00:03 +0100 you wrote:
> linkmode_andnot() simply returns the result of bitmap_andnot().
> And the return type of bitmap_andnot() is bool.
> So it makes sense for the return type of linkmode_andnot()
> to also be bool.
> 
> I checked all call-sites and they either ignore the return
> value or treat it as a bool.
> 
> [...]

Here is the summary with links:
  - [net-next] linkmode: Change return type of linkmode_andnot to bool
    https://git.kernel.org/netdev/net-next/c/7e1d512dab50

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



