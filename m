Return-Path: <netdev+bounces-150575-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D52DC9EAC29
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 10:34:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90A1D28FE43
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 09:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3D40238758;
	Tue, 10 Dec 2024 09:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GVzT33Pd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42AA23874B;
	Tue, 10 Dec 2024 09:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733823014; cv=none; b=RDnZNOx/V5REXJRs5BN/T1/s8OQ/xKxSI994P1Ma8O/7gNY7TWxHF82YIBhS73YOFM8D2xsnorUpfRIrr2+Q/XY4ti2UDnhzjnH//R36bhlcWACTrSPgNlJ0YQGe6G/20LNTTtBYALcNtuAkACG3tRw/OaqDuQisXaJk1Q+79E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733823014; c=relaxed/simple;
	bh=GkVRoHsx2iptiDjIPdXGidSsexlfyrOMq7v23g/QgHk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aNT44btIumqNW24OUEYQaZWwVq87sIyqvfe6fZw3qdiVnHOlnb/dLLC8s2Hak+vxbvCsXdTAs4e0wKpHJWx4Gh0InTbuas0Wqyx58OOlvuHqwvSZfK1v2xbQEaAEvKOUl4avLRYEphiynAcqLB3Opiaun0rdOm9f7WSjiflSzQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GVzT33Pd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36FB3C4CEE0;
	Tue, 10 Dec 2024 09:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733823014;
	bh=GkVRoHsx2iptiDjIPdXGidSsexlfyrOMq7v23g/QgHk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GVzT33Pd1IKratl5ynrJiR7Ofsrd4GhJ71mjEb1VTXwTYATwth4GLgFlTNPOw8UvJ
	 oMg4mYIjKG7x3vskozR0sRpmSHOkOHfjmVGQ6NyVHJJ6odDivcpebP+SUQRI4uIlnO
	 XbHQ5YJruxXP8l0r+1ZksaErPN0XtyaUAs6yKSl7x7zwy6hW3A9+eWR2cbvVdFW31b
	 uMWn19YghQc5hcrDQzrmlma60ocvA3YctO64+gSN+5ha45liKpHMr5hc9mHQ4TIsBn
	 XmK7aFbVO3eORIiTRHBZ8zJ13wiwJcKYfbG1RMESbCH5L3dASAAdYEtI0Rwz5SgJ28
	 +SLwaRvqKbyxw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 15374380A95E;
	Tue, 10 Dec 2024 09:30:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net v2 PATCH] octeontx2-af: Fix installation of PF multicast rule
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173382302999.732950.12248715876136324508.git-patchwork-notify@kernel.org>
Date: Tue, 10 Dec 2024 09:30:29 +0000
References: <20241205113435.10601-1-gakula@marvell.com>
In-Reply-To: <20241205113435.10601-1-gakula@marvell.com>
To: Geetha sowjanya <gakula@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org,
 davem@davemloft.net, pabeni@redhat.com, horms@kernel.org,
 andrew+netdev@lunn.ch, edumazet@google.com, sgoutham@marvell.com,
 sbhatta@marvell.com, hkelam@marvell.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 5 Dec 2024 17:04:35 +0530 you wrote:
> Due to target variable is being reassigned in npc_install_flow()
> function, PF multicast rules are not getting installed.
> This patch addresses the issue by fixing the "IF" condition
> checks when rules are installed by AF.
> 
> Fixes: 6c40ca957fe5 ("octeontx2-pf: Adds TC offload support").
> Signed-off-by: Geetha sowjanya <gakula@marvell.com>
> 
> [...]

Here is the summary with links:
  - [net,v2] octeontx2-af: Fix installation of PF multicast rule
    https://git.kernel.org/netdev/net/c/af47a328e813

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



