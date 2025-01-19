Return-Path: <netdev+bounces-159597-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B24BA15FDE
	for <lists+netdev@lfdr.de>; Sun, 19 Jan 2025 02:51:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93BA7188547D
	for <lists+netdev@lfdr.de>; Sun, 19 Jan 2025 01:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E27C19047F;
	Sun, 19 Jan 2025 01:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TI2/5zKV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093E218027
	for <netdev@vger.kernel.org>; Sun, 19 Jan 2025 01:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737251422; cv=none; b=rFkyrQBxVRw/d09P6gCnR+g0goL62m5h3VXWVpS+ljyGkwZY3a/iZTm52LuF9QtDQ1tUNUbV4AN97APEDqYr3GadJHUei/b9ii4EQ4kiROqUnnylvmTQpsdc0ub6nuq02JrOs03Plfme3Nhutyan3xAdxCpcqJMd0i2qNXSJHfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737251422; c=relaxed/simple;
	bh=12b5FhJ4ZVCQorHp/2Zf8MJdVjH6z/e07nuCw4iRIIY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OZoFuA3M9A2nrZFoNefJTrGxu1cgvP4lVSyf5PwuDWtYDGRsgYczczaNIyY5JBP7salopYlA+2FDfPXbkw2TLIc68MhpJEjL3gpG6FDp73sGwm03V/HsccLwOsVT4bLIbfb713IT2JSEZ0Upm8BaGTOwh/V1GD540Z1RhSEwPrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TI2/5zKV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FC6AC4CED1;
	Sun, 19 Jan 2025 01:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737251421;
	bh=12b5FhJ4ZVCQorHp/2Zf8MJdVjH6z/e07nuCw4iRIIY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TI2/5zKVdnJNhKng8hg8KwEB7y5l6OUUdYrYbEFOZ0W0W2m1T+emJALJbHQBPb63g
	 z4mGg9BV1wPUgPGkE23KhvFz1/GJqhZCs4UlAP9A0srHfX8h3Rq69L4iNOBwpzIIZW
	 3nCFJYpV+daVQD9zRpGOL0H1f58yuJjmZGdp/Dyp6FvhHp0CgPMUwtLBeyyTWAfKn0
	 ztAQSLqTLbE/Sfr1fZe4AVd/DmggS+qDVmcaG5wPuomkL21U8xYcgEtDaV+y+cl9Zi
	 4JN2Qmuf/gv2IaYUy7XRqgsKnBwXCFFH4U0A0ky6stG1lWPPK9p+x8sjjORYvRVRRX
	 JfviXqM4naHZA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70B2A380AA62;
	Sun, 19 Jan 2025 01:50:46 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] eth: bnxt: fix string truncation warning in FW
 version
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173725144499.2533015.1222534693782036747.git-patchwork-notify@kernel.org>
Date: Sun, 19 Jan 2025 01:50:44 +0000
References: <20250117183726.1481524-1-kuba@kernel.org>
In-Reply-To: <20250117183726.1481524-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 michael.chan@broadcom.com, pavan.chebbi@broadcom.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 17 Jan 2025 10:37:26 -0800 you wrote:
> W=1 builds with gcc 14.2.1 report:
> 
> drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c:4193:32: error: ‘%s’ directive output may be truncated writing up to 31 bytes into a region of size 27 [-Werror=format-truncation=]
>  4193 |                          "/pkg %s", buf);
> 
> It's upset that we let buf be full length but then we use 5
> characters for "/pkg ".
> 
> [...]

Here is the summary with links:
  - [net-next] eth: bnxt: fix string truncation warning in FW version
    https://git.kernel.org/netdev/net-next/c/17656eb5cfe5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



