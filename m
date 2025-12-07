Return-Path: <netdev+bounces-243956-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7218FCAB881
	for <lists+netdev@lfdr.de>; Sun, 07 Dec 2025 18:43:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2064530221B8
	for <lists+netdev@lfdr.de>; Sun,  7 Dec 2025 17:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 182C02DA77F;
	Sun,  7 Dec 2025 17:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nk27sf5v"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E899B24677A
	for <netdev@vger.kernel.org>; Sun,  7 Dec 2025 17:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765129399; cv=none; b=Fw/ExiHCrSF6kzYqmD+Ttqao9K0TbXrVzcSDoXU7xcBpS8KmpOIlcigLKYF14s6pmIrWStFChtAQU3TmNNgyhDgyL4VlsH8uqs/WKewzabWqOgqhxub/xIG+zbry/FiTWpUY2jYhHkcv5ousXlFO/MxBLF6m6sJPylJesx2xzNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765129399; c=relaxed/simple;
	bh=lyvGs2ZkCspr7EZvzOCRfUrjqP2BdxChSvemNjmnBtQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TkYTBRsIpbVKgrT2KdDZx6ua6givoekMnVUHHgpgqPMQTMjLZbaGcf5vurHyQkSsGtUYOhqXpsxCDWkFLFooSWvPz62dY4qFnCMVGSUZWJygEggFXQ9wnSND1X/gCuAkcpuBZg7lK6Jzx3TOaNn2SGy91E8fwUiiByylfYwFec4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nk27sf5v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64F47C4CEFB;
	Sun,  7 Dec 2025 17:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765129398;
	bh=lyvGs2ZkCspr7EZvzOCRfUrjqP2BdxChSvemNjmnBtQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nk27sf5vjwoM2C5LZoK2N8uMbC36h2Et0IMVOs5MfA+d7iFOO54J+aDwVBddKP6nE
	 VJcUePNh4+g44kPgSRML+bmCTdJiSPz4jT6/rZkBQzSTBNrIaDS4GXIRfCxnN22W1v
	 KzUSn1d0uGVB4jVoPRYBBoIuk1dbHHSmV7Wpa4IhXnZTenhptP985Aglu75emfTC31
	 C9W7DX/xsGtEWeLeACl8b8ZlRNMnJlOwKHZ4B19rNM8nvkqZlsWB4PwM3S0Qr0uC1p
	 f9iTBAFxcIHSO7uZ9/ZK3zwuKioPBNwPTtcxdt9REcdaF9mTC6HxhX4CO6uTgfG94t
	 R/qMtvH5KHT6A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F2AE93808200;
	Sun,  7 Dec 2025 17:40:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2 1/1] lib,tc: Fix 'UINT_MAX' undeclared error
 observed
 during the build with musl libc
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176512921479.2492763.17730960894747579841.git-patchwork-notify@kernel.org>
Date: Sun, 07 Dec 2025 17:40:14 +0000
References: <20251203021124.17535-1-nemaakhilesh@gmail.com>
In-Reply-To: <20251203021124.17535-1-nemaakhilesh@gmail.com>
To: Akhilesh Nema <nemaakhilesh@gmail.com>
Cc: netdev@vger.kernel.org, stephen@networkplumber.org

Hello:

This patch was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Tue,  2 Dec 2025 18:11:24 -0800 you wrote:
> - utils_math.c:136:20: error: 'UINT_MAX' undeclared (first use in this function)
> - tc_core.c:51:22: error: 'UINT_MAX' undeclared (first use in this function)
> 
> Signed-off-by: Akhilesh Nema <nemaakhilesh@gmail.com>
> ---
>  lib/utils_math.c | 1 +
>  tc/tc_core.c     | 1 +
>  2 files changed, 2 insertions(+)

Here is the summary with links:
  - [iproute2,1/1] lib,tc: Fix 'UINT_MAX' undeclared error observed during the build with musl libc
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=6c1113633fde

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



