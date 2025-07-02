Return-Path: <netdev+bounces-203119-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0B96AF0891
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 04:40:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4232D1C209CE
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 02:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89B711C863A;
	Wed,  2 Jul 2025 02:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kb788+94"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64ED51C5F2C
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 02:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751424001; cv=none; b=eSAF1UdVq2s2iQq2XDv85pYoeOvvoFfE/PpaGFdDNa4Lse9HpHBEjtlhy3Kw2+urBwp0yp30aT9AnVg0TddE/bpMULQmngWtM4iOHdkkLRmTQ+kaXWWTCCRB+pa2cY2onCVekaP3+cqNHmIL5QFHq5hyNZF6E4izNvKxIQHyrso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751424001; c=relaxed/simple;
	bh=NUGHRTV1q5xUqR1I/bL2A+lkkBUb518lzzZl/+P1l3o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=B28wkrumuhW+mktayMCfP/optQnnaTMrUohtf5xtKwPtHA6x75tDQwYw6rRw906bACjHDMevV7fPeh2Y0Mj3ttWlFnTBIMXnGHVlKxQXbkGlrP5xdJNohC3QBtc1ROpLl1o+0Cyc7FeJ14DBcE4ZfLDaJc9ZbWD7/tLzA1v9+Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kb788+94; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1321C4CEEB;
	Wed,  2 Jul 2025 02:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751424001;
	bh=NUGHRTV1q5xUqR1I/bL2A+lkkBUb518lzzZl/+P1l3o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kb788+94evpjnzJMWPeiMOr2smXS6GhM+mcOm4fnU9iI3i9zD99X23cCDunerPvvc
	 ieoF/kH1Njo/+iYqet7wLrjnOipc0pJPQ/RH98W99wiIiIpRmf9d+njdgSKFLLM8Us
	 IKvbQelheEBslGexqv9DuGl6QClVZGO14CtM08ss09C7A4GDi7yaWAR771T28fg9ez
	 u6E3ROqS1vXezWmTZFXRtPGuxySDVcDGLqds7a9aZ0XmD31IM4a3OlTTqygEvGEOlb
	 oi0QDCNG1hcUBIXNURW4azsFU/bvZyHuYCirD6cIcAmR6/X027uP5PIFLCFjmEb1UR
	 qs7GKoNS89xig==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAEEF383BA06;
	Wed,  2 Jul 2025 02:40:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: atlantic: add set_power to fw_ops for atl2
 to
 fix wol
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175142402549.183540.7984616141525583099.git-patchwork-notify@kernel.org>
Date: Wed, 02 Jul 2025 02:40:25 +0000
References: <20250629051535.5172-1-work.eric@gmail.com>
In-Reply-To: <20250629051535.5172-1-work.eric@gmail.com>
To: Eric Work <work.eric@gmail.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 irusskikh@marvell.com, mstarovoitov@marvell.com, dbogdanov@marvell.com,
 pbelous@marvell.com, ndanilov@marvell.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 28 Jun 2025 22:15:28 -0700 you wrote:
> Aquantia AQC113(C) using ATL2FW doesn't properly prepare the NIC for
> enabling wake-on-lan. The FW operation `set_power` was only implemented
> for `hw_atl` and not `hw_atl2`. Implement the `set_power` functionality
> for `hw_atl2`.
> 
> Tested with both AQC113 and AQC113C devices. Confirmed you can shutdown
> the system and wake from S5 using magic packets. NIC was previously
> powered off when entering S5. If the NIC was configured for WOL by the
> Windows driver, loading the atlantic driver would disable WOL.
> 
> [...]

Here is the summary with links:
  - [net-next] net: atlantic: add set_power to fw_ops for atl2 to fix wol
    https://git.kernel.org/netdev/net-next/c/fad9cf216597

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



