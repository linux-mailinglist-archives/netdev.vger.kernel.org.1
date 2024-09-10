Return-Path: <netdev+bounces-127159-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C7D97466C
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 01:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5D101C2565D
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 23:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A564C1A4F24;
	Tue, 10 Sep 2024 23:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p2rmkwqU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811121993AF
	for <netdev@vger.kernel.org>; Tue, 10 Sep 2024 23:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726011028; cv=none; b=JdDj7FbOuayjO3pDUtvGC3cR2ZgwaastMtR7HX2fkOsXRdHlgG2bw5Sjo5uqn8W0kv5/G0XPePSpNiTeaoP0oxMw6e0tHE2eF1sMI0EVl71L9lJFmEa8s44U+fZXr6lgdamrEDKTKE6+8tlUiB4Yt/ujqlgl9Ys9K5ctDJz+Ac0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726011028; c=relaxed/simple;
	bh=g8g3qgKyn4Me385MAefaSqjyXks2D2DHU/71kQ3UuPE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fTpwavC0SvS+T92xe2Xjn9PWZ5tLwTaf2Srdbg8eLUAAPcu6HWN/0haD4ancWV0CxRC2hVb/xdY1EFVzQ8zfm2qm07Anet6piDzrUj5Pqe7hfYCa6cfl1nWHyK3n3vIDl3MJAK2NU46zaNi/l4OP7V8iX158BFdJlo2rdQAXOW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p2rmkwqU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9991C4CEC3;
	Tue, 10 Sep 2024 23:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726011028;
	bh=g8g3qgKyn4Me385MAefaSqjyXks2D2DHU/71kQ3UuPE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=p2rmkwqU0cCw6Z0WMC0Z8hHCMagQYLOMvVaFEqmRDNo0n9h9m9nsXuXx2yU/mxU0H
	 YLmWWUHrQGu7GI2YmEGms7+2ACFIT0q41OZ2Ibz5C6YWCfClYoTI8gWk6iAI8ssRxb
	 Vec4qvGSDVv/kqi/WdKbEzoCcxn3Uda1iyLuVAokev5LAZCfuCFmlHg1OsmNeU3NC2
	 +1Yy1cejK89a+4Ul1b26er9UeFAbHjDSjwd2yFxl7+RNWfosRg8tu/TMPVHyLdFOj6
	 PaHCKvcfJwIZf8GM5uiVT4OHoD+LjlODk4sObODgJX/03v4X7k8smVUYQWiW7vcjmM
	 ZNCUtuzTH6LjQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33CE13822FA4;
	Tue, 10 Sep 2024 23:30:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: =?utf-8?q?=5BPATCH_net_v2=5D_net=3A_phy=3A_dp83822=3A_Fix_NULL_poin?=
	=?utf-8?q?ter_dereference_on_DP83825_devices?=
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172601102902.426696.4937574624682433929.git-patchwork-notify@kernel.org>
Date: Tue, 10 Sep 2024 23:30:29 +0000
References: <66w.ZbGt.65Ljx42yHo5.1csjxu@seznam.cz>
In-Reply-To: <66w.ZbGt.65Ljx42yHo5.1csjxu@seznam.cz>
To: Tomas Paukrt <tomaspaukrt@email.cz>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, catalin.popescu@leica-geosystems.com,
 horms@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 06 Sep 2024 12:52:40 +0200 (CEST) you wrote:
> The probe() function is only used for DP83822 and DP83826 PHY,
> leaving the private data pointer uninitialized for the DP83825 models
> which causes a NULL pointer dereference in the recently introduced/changed
> functions dp8382x_config_init() and dp83822_set_wol().
> 
> Add the dp8382x_probe() function, so all PHY models will have a valid
> private data pointer to fix this issue and also prevent similar issues
> in the future.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: phy: dp83822: Fix NULL pointer dereference on DP83825 devices
    https://git.kernel.org/netdev/net/c/3f62ea572b3e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



