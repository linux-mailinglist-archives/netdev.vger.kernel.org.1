Return-Path: <netdev+bounces-177470-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E762EA70476
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 16:00:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F5303A9B4B
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 15:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FCFF25BAC6;
	Tue, 25 Mar 2025 15:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TKOQw/8U"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5E325B694
	for <netdev@vger.kernel.org>; Tue, 25 Mar 2025 15:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742914807; cv=none; b=erLedwO+mtr3SHbnLTVH7+/Uj4XTP6MCm7zqAfixnq355FvGORLNB2cE72VKUD6fIu7B4WAZp0mmfnM3Cdutx5mjCwkEGkmY9PiLVMAY2nFmNvkVzoEz+epOuSgaEo0+T43kXS2uRiH9aWBXcAr2IP3ZbSdFLZn22VPj9xXTTXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742914807; c=relaxed/simple;
	bh=uFN9doZhgRkV1dZeM1rdThYPCTigzXxTXi712BmtlnM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=f9E/anejfsEEKqRYVfO/dS/Hi7MdO301z5VhyjKNtzExv60dhJ0ZXqDCFmwh0q6HtsyiEh9dsYoDyaYWUPjks1cNt/PDpKwlMNWsWt+5nnA5Qrow92MEHY2xnaUADYNDtcVmtd1p2tWfD5T/pheTj22oQGNUNvTgZyUsXMer4cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TKOQw/8U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B69A0C4CEED;
	Tue, 25 Mar 2025 15:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742914806;
	bh=uFN9doZhgRkV1dZeM1rdThYPCTigzXxTXi712BmtlnM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TKOQw/8U+gGVecTX4D7E+5ce3y+AuC9q+19CZN4n+WVQBlCms8x/ZgCQ6K4u0QzJv
	 TXdj3/CYmNoEsgNW5BWk1GuWI/jnC5s7NswLdEm6iwSqOclVWi2Urw0yXn7N9UxLPY
	 /ut5d+xANffjidTbyAVZ6ekFbc+bQJibyTvvztRuqp9pOXus0HvY/a+MjCgLIkG/xE
	 uiK7qVnUlFYsPyvrHUhDWfD7WHDyQheuDOSy0ktq80U/htAbuu5SLqZDM6SJq/3pvf
	 Qt7uk9ZppOXPnCBgk886/BUe+sGISnY4ylOekoF/mtwhcjMuhZpg/EcXdCSr/X1MyV
	 pMw1GYsvh97kg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D97380CFE7;
	Tue, 25 Mar 2025 15:00:44 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next 0/3] sfc: devlink flash for X4
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174291484274.606159.17848152999707551854.git-patchwork-notify@kernel.org>
Date: Tue, 25 Mar 2025 15:00:42 +0000
References: <cover.1742493016.git.ecree.xilinx@gmail.com>
In-Reply-To: <cover.1742493016.git.ecree.xilinx@gmail.com>
To:  <edward.cree@amd.com>
Cc: linux-net-drivers@amd.com, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 andrew+netdev@lunn.ch, ecree.xilinx@gmail.com, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 20 Mar 2025 17:57:09 +0000 you wrote:
> From: Edward Cree <ecree.xilinx@gmail.com>
> 
> Updates to support devlink flash on X4 NICs.
> Patch #2 is needed for NVRAM_PARTITION_TYPE_AUTO, and patch #1 is
>  needed because the latest MCDI headers from firmware no longer
>  include MDIO read/write commands.
> 
> [...]

Here is the summary with links:
  - [v2,net-next,1/3] sfc: rip out MDIO support
    https://git.kernel.org/netdev/net-next/c/c339fcdd738b
  - [v2,net-next,2/3] sfc: update MCDI protocol headers
    https://git.kernel.org/netdev/net-next/c/25d0c8e6f0bb
  - [v2,net-next,3/3] sfc: support X4 devlink flash
    https://git.kernel.org/netdev/net-next/c/5726a15499da

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



