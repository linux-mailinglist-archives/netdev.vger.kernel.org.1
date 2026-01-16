Return-Path: <netdev+bounces-250432-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 28E90D2B22C
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 05:04:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 094A4304423C
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 04:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 276E53446C7;
	Fri, 16 Jan 2026 04:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DAiz8X/X"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E09313E08
	for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 04:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768536249; cv=none; b=tQ1spstHe+/fl0jH/Dcb+V4EMwqvmOWQMBUyON09cOVS1ZvybKblH0zSwlOeFUZUQBFYI43UMr/KQWuxOJHuYJ+7YFTe8zICxQ/U3oO9Q5ii1eme7Bbo/4rGB5L6EF3dm1u6j1uLKLnHzwV16I2mRSzsfCRPzB9APEMJip4Qh74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768536249; c=relaxed/simple;
	bh=thd+otaSdkVafouEz3jHSfcCPN0geo4mBnTOwhZw9sk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FDD7XskkDH0RpVwW3EYvH6laON5cDbppgIrKynN9ZYJAfh5V3bK1zeb4bcSjMsPlVsGmLa/fU9ryiQv9jk+UbQpSJ2Vx0QlTUBOu3PU2uZs41Ru8NO5SZhCMccsZFySk/RsB1LS1etTQOgqebbbk7jZCcQFxTKS3vDDQMu3PE3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DAiz8X/X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 932DEC116C6;
	Fri, 16 Jan 2026 04:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768536248;
	bh=thd+otaSdkVafouEz3jHSfcCPN0geo4mBnTOwhZw9sk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DAiz8X/XdxZoE2yFT1C072QmPoVjo1Q3fxBjH4Ibw7i0hzKTUnygtxk/3aITzHdCK
	 4cf4+sLUUf/GhImV7IWKOKs9bYs+KFp00VRwX4QuTbjtxjjpQwRFq6Ycgvo7HvlOsX
	 h8wQJnV4ds2HrA3hxQEICa+GZ6J1MMUeErbFCESjfLJn/6UWzRX37oQk6t/fSLsuus
	 ERyAylveuyQ7vlve+MEDS5DI9Wb6P+AyoMLshXtqvvJUJ2ZcMxXeADi9yDshAcP9jc
	 FqBed5KvnPFypSXEe2AT4/acPTo6E8Fn6IEimwYeQNL7hM3EO4GMbmZmNc3uYnzCKg
	 gFPwniqSSaUkg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B5B80380AA4C;
	Fri, 16 Jan 2026 04:00:41 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] bnxt_en: Fix build break on non-x86 platforms
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176853604027.76642.5758429555721967161.git-patchwork-notify@kernel.org>
Date: Fri, 16 Jan 2026 04:00:40 +0000
References: <20260113183422.508851-1-michael.chan@broadcom.com>
In-Reply-To: <20260113183422.508851-1-michael.chan@broadcom.com>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
 pavan.chebbi@broadcom.com, andrew.gospodarek@broadcom.com,
 sfr@canb.auug.org.au, lkp@intel.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 13 Jan 2026 10:34:22 -0800 you wrote:
> From: Pavan Chebbi <pavan.chebbi@broadcom.com>
> 
> Commit c470195b989fe added .getcrosststamp() interface where
> the code uses boot_cpu_has() function which is available only
> in x86 platforms. This fails the build on any other platform.
> 
> Since the interface is going to be supported only on x86 anyway,
> we can simply compile out the entire support on non-x86 platforms.
> 
> [...]

Here is the summary with links:
  - [net-next] bnxt_en: Fix build break on non-x86 platforms
    https://git.kernel.org/netdev/net-next/c/dc634118aaa0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



