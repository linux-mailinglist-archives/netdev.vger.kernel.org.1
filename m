Return-Path: <netdev+bounces-229118-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A8D3BD8552
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 11:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9FAD54ECC87
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 09:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BD552E2DD4;
	Tue, 14 Oct 2025 09:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GMeWf2Qj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3612D8790
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 09:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760432422; cv=none; b=Dn00/WaQ4PfG4RKmB1rV3QWwYAnE7KyLcghDYoxSrlGAAaNzEK6OvEp2wK03jQrTLvRh+JbW2DWZ03qoMGepfoueQuHAM0f6xJUkYdd6RKXbTsSf8YSIVKpt3W12pO7QkPcZGPpCirxErawZAv0PUtBX9l0epl6tDmiPVm7WfYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760432422; c=relaxed/simple;
	bh=VY8IEiADNWnr3dmjBvf/mRwYAA+FiWk4tzM06D93t9I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pEjmoWlyfjYgJOJjXZqjLG+jk+Pn/R9iEdStHj2Jhgn/cVQ45YP5IFEb8ZsfSfKfRKfzNSGhahm/LgPWFvOCvW7pBNUsi/Ht+64VgEyDl92N6kW1d3Wv7GaQalp3b8FSG63bEoy0/AQc7ejYClF3iFnQMBlbvM1PmtotmAeA4HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GMeWf2Qj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85104C4CEE7;
	Tue, 14 Oct 2025 09:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760432421;
	bh=VY8IEiADNWnr3dmjBvf/mRwYAA+FiWk4tzM06D93t9I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GMeWf2QjKmsiL9Zfil2dl92xEgyrV1jo+DcRNJL6Skqm7v03mysKO1XzK8ilo5DYB
	 SsfryusnxUPqJ3Hrfw2JeJ4Q4kimLzIvboQExMJlp7X0ROwKq8YjUydBMUrWoVD9XO
	 FIGav9qkcvqJkFbdkcHJfX3kGnkMdaPfc215Cl81Kf2Xjb1YNOysnIrV0pzx0MFjl7
	 sBGXZaCbk5maUP2zT6u+5VW1aCc/R20qmmZvhoz6p5C3p1LTIyicJjz902dtj9XvCA
	 jx6/lxuVVtQRCG+3Nz6GYq4ip1IGL8tUARg8/y2RyMsBsU523Tmy8pqg7M430WQGTG
	 BUzYroF+FmaqA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 344B0380A970;
	Tue, 14 Oct 2025 09:00:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] amd-xgbe: Avoid spurious link down messages during
 interface toggle
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176043240701.3602094.4743541914037199511.git-patchwork-notify@kernel.org>
Date: Tue, 14 Oct 2025 09:00:07 +0000
References: <20251010065142.1189310-1-Raju.Rangoju@amd.com>
In-Reply-To: <20251010065142.1189310-1-Raju.Rangoju@amd.com>
To: Rangoju@codeaurora.org, Raju <Raju.Rangoju@amd.com>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, kuba@kernel.org,
 edumazet@google.com, davem@davemloft.net, andrew+netdev@lunn.ch,
 thomas.lendacky@amd.com, Shyam-sundar.S-k@amd.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 10 Oct 2025 12:21:42 +0530 you wrote:
> During interface toggle operations (ifdown/ifup), the driver currently
> resets the local helper variable 'phy_link' to -1. This causes the link
> state machine to incorrectly interpret the state as a link change event,
> resulting in spurious "Link is down" messages being logged when the
> interface is brought back up.
> 
> Preserve the phy_link state across interface toggles to avoid treating
> the -1 sentinel value as a legitimate link state transition.
> 
> [...]

Here is the summary with links:
  - [net] amd-xgbe: Avoid spurious link down messages during interface toggle
    https://git.kernel.org/netdev/net/c/2616222e4233

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



