Return-Path: <netdev+bounces-208728-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F7B1B0CE80
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 01:59:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5E4E543B2D
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 23:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2115024679F;
	Mon, 21 Jul 2025 23:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aHFMHJTr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0A21C32;
	Mon, 21 Jul 2025 23:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753142388; cv=none; b=cQiA+m7M91/Nvcn0PPlhmlXjpjJMwU0zwZNXPRiUNN1Xnl8oDeChqgkXF4lg6lK6KfDYRSrsoesiDrVbaMaR2BVCVWU6RSsP4ENYA1AloWnl6AKGyZzxPVi/Byv6euFGDcO5s6B4B/PwgDAttnOqzgreyaWadK3fdqQg4+QUF6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753142388; c=relaxed/simple;
	bh=fN+IVKjkNdKzhPIH+N6TLetMrBA/DKNpz6CqFau7crA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=u978LnSqapHtGVDvNeEQvgbRSjYA/lsFhiV7sjVesqi5RP3qzLZNc7iD9VpjEaE4Yuaf4JJI3rbHmBgy5RwG+pMPPF9I1C2QfJdC3DDoE9C3pfnvhdp7IF2A7CUBy0mO/JgE70R4YNaE+E4ofT+wan3ELfagDRJDmayw+HwMIj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aHFMHJTr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DFD6C4CEED;
	Mon, 21 Jul 2025 23:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753142387;
	bh=fN+IVKjkNdKzhPIH+N6TLetMrBA/DKNpz6CqFau7crA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=aHFMHJTrfKg8hghNAOVzrYs78HUX4G6dSGJTpAnrPghjFzSY0v9bUBuArK7nSNi+n
	 NabYBF9G4+RACiSuoWTTTIv9cempmhGmGaGHlcqyrlyCqOjQ11YRFB/NiRjl/EdBXH
	 WPd8YarWuLgjUpMEC5N4tHSH+KHPdcipq3rE4xgn4IViW9hBBYl4WXEV3tDTVRw4kj
	 71UplJfaQUl+6hrMo/nLxgqcQAq7yhDujYVrqeSLGzdwdwHjyn/Aqxn7hMphEQnSyB
	 +AIwYkl98WRxj0PWfFSOsJn9SEPmaPgqLS9VpH6M/mfG+TLhp1S3gcvmrVh9JXNYeJ
	 5R92noFjEHeSw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70DEA383B267;
	Tue, 22 Jul 2025 00:00:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: bcmasp: Restore programming of TX map vector
 register
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175314240626.236567.16899996830057736966.git-patchwork-notify@kernel.org>
Date: Tue, 22 Jul 2025 00:00:06 +0000
References: <20250718212242.3447751-1-florian.fainelli@broadcom.com>
In-Reply-To: <20250718212242.3447751-1-florian.fainelli@broadcom.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, justin.chen@broadcom.com,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 18 Jul 2025 14:22:42 -0700 you wrote:
> On ASP versions v2.x we need to program the TX map vector register to
> properly exercise end-to-end flow control, otherwise the TX engine can
> either lock-up, or cause the hardware calculated checksum to be
> wrong/corrupted when multiple back to back packets are being submitted
> for transmission. This register defaults to 0, which means no flow
> control being applied.
> 
> [...]

Here is the summary with links:
  - [net] net: bcmasp: Restore programming of TX map vector register
    https://git.kernel.org/netdev/net/c/18ff09c1b94f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



