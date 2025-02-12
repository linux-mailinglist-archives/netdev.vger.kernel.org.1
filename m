Return-Path: <netdev+bounces-165331-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD1F4A31A9C
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 01:40:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6383F3A75F6
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 00:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A3EFC0E;
	Wed, 12 Feb 2025 00:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tlph9vm8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501A2FBF6;
	Wed, 12 Feb 2025 00:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739320809; cv=none; b=H6/2Z8F7Wju05YEH27xPshaxwkG2UMuN4Fe6mL1NlKvVJi7ljeqOJ4xm/oelbsqICHnu1Y/GWCDoRzwsDWSmlaJOzsafL7nDLp8NRFSCBk3x2rAGczOBrn/yGkOIrSRrFGMiNk/sC4zItsjDRbbkgA3gulzb+K8z68kMnfFGSiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739320809; c=relaxed/simple;
	bh=oCWwfNGxCQKYtvtgrXmiVJ8HiXZkgXpur1QcqnWncLI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=g1YduyEQOzzKBv/3GPHp6Dq7nHpodjndN5UFuH+d+0F6kgWcWpVh1OVZ+Ukz4gprXQijNqagr9kTZwtKwy6V1z9DauobibGNTkjuaxq2fPCZQOYhAMEtXuszqLP3HRPPRcqmBeH+zqySw5bHHk8BqBdpnejbXiFfJFWLhhj12sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tlph9vm8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A06DC4CEDD;
	Wed, 12 Feb 2025 00:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739320809;
	bh=oCWwfNGxCQKYtvtgrXmiVJ8HiXZkgXpur1QcqnWncLI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Tlph9vm8t/5i6AH669roEWZRljH/dley5MDy/6gcxDL1Ce3GInwpcEyij74H4y+J3
	 0y3DEXA5fMuHGOa4q/LZ4Tzxj4JdrvQLYJn1IFqZOKgfiHdzz2tWhS/qmFUhsiqxLT
	 OZBMRCiBLfHU+gUkVxrLv68LeDNZWu6mpE9xzl2Ek2su9zGP6hIoKUFoBehtPMWdBf
	 jNqoxnrTnpVJaUdmnJyusFKtJ+/c7IgzHfYngYSXk7h/Hpe5pvQhxXndE/bHf77aWn
	 quTXZ9MgRcEM41d1k8RPhHRlUrrvXUO8U554Ff/D2R+campeAXYdjrtZZxxrc8NZxd
	 PrMZEcb4hOrWg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3438B380AA7A;
	Wed, 12 Feb 2025 00:40:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH RESEND] net: wwan: t7xx: don't include '<linux/pm_wakeup.h>'
 directly
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173932083786.51333.5847568369053049903.git-patchwork-notify@kernel.org>
Date: Wed, 12 Feb 2025 00:40:37 +0000
References: <20250210113710.52071-2-wsa+renesas@sang-engineering.com>
In-Reply-To: <20250210113710.52071-2-wsa+renesas@sang-engineering.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-kernel@vger.kernel.org, ryazanov.s.a@gmail.com,
 chandrashekar.devegowda@intel.com, chiranjeevi.rapolu@linux.intel.com,
 haijun.liu@mediatek.com, m.chetan.kumar@linux.intel.com,
 ricardo.martinez@linux.intel.com, loic.poulain@linaro.org,
 johannes@sipsolutions.net, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 10 Feb 2025 12:37:11 +0100 you wrote:
> The header clearly states that it does not want to be included directly,
> only via '<linux/(platform_)?device.h>'. Which is already present, so
> delete the superfluous include.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Acked-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>
> 
> [...]

Here is the summary with links:
  - [RESEND] net: wwan: t7xx: don't include '<linux/pm_wakeup.h>' directly
    https://git.kernel.org/netdev/net-next/c/4d3f687e2432

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



