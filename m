Return-Path: <netdev+bounces-242238-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 378C9C8DE1C
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 12:01:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 705413B0C3E
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 11:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6416432B9B4;
	Thu, 27 Nov 2025 11:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rv++yEYw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386832E88BB;
	Thu, 27 Nov 2025 11:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764241251; cv=none; b=ULIQNLTcdEeRTspiynnC9q63iHvk2/S6UNFiccSRc+yB+YqLuOZ5DadLx+0BJO83lWpW3eHNh19bfrIJO5lN+LIKd5L3/bSM9SRbBwf8wc2cslL8SiqeVCUVlXU1DtF2IVEmKJY412Co2h51ni9R1STyqVgIDiWCyUrHBVUekBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764241251; c=relaxed/simple;
	bh=B4okVeMlB9b1OI1qG2veRf2ts05h74Vlkw9wAE/CqlY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SYaXc+JbJk6ku74MPr+7vuYsHe9+8zt82IWPmWayKPgrGWsuIe4WxZRRRV1Yg+p0JbJsfcu6LdZdqRBQr81ro8eLzVGKAurjTk3yknW63YLxvNFtB7xxzYgLr97Lt2sUgBfwNrORqO9imEUva9+IFxvRw9R91cT1SINk0pHuFF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rv++yEYw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC003C4CEF8;
	Thu, 27 Nov 2025 11:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764241250;
	bh=B4okVeMlB9b1OI1qG2veRf2ts05h74Vlkw9wAE/CqlY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Rv++yEYwi/Z5VbKgp8LnwKYn7dy8Q9FI/yDZ0c9BT6DgtI7uX5+Bpxd+Gh7I6Ohcy
	 +iDNRXh1zrIuTH6ux8FgfALgExoqgCWJenSSSXIZrcpULAM20x8u0a0NCTC4cc31rq
	 x4qmMtQIzL+AGIbBPN3rEjb4zSPAgwnls3U5ofM4RUqFBTVwH8I7EbUqJYnqVRA/e8
	 UadgLKx7Mwi8esFAb1vMZZ1+nOQPp8v88GxVc2uOb07cwAC79Rtyk5CiXaEknWjAwI
	 zBMWl0h1R0eaTg4vCyMu4a9OHE37Rs8Bog+3QAjGDm1iCs0Aq3czAOeTwLwK/sb/mt
	 QSDXoc6p8S2cg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 710F0380CFD2;
	Thu, 27 Nov 2025 11:00:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/4] net: fec: fix some PTP related issues
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176424121226.2525348.15948340915673336193.git-patchwork-notify@kernel.org>
Date: Thu, 27 Nov 2025 11:00:12 +0000
References: <20251125085210.1094306-1-wei.fang@nxp.com>
In-Reply-To: <20251125085210.1094306-1-wei.fang@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: shenwei.wang@nxp.com, xiaoning.wang@nxp.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 eric@nelint.com, richardcochran@gmail.com, imx@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 25 Nov 2025 16:52:06 +0800 you wrote:
> There are some issues which were introduced by the commit 350749b909bf
> ("net: fec: Add support for periodic output signal of PPS"). See each
> patch for more details.
> 
> Wei Fang (4):
>   net: fec: cancel perout_timer when PEROUT is disabled
>   net: fec: do not update PEROUT if it is enabled
>   net: fec: do not allow enabling PPS and PEROUT simultaneously
>   net: fec: do not register PPS event for PEROUT
> 
> [...]

Here is the summary with links:
  - [net,1/4] net: fec: cancel perout_timer when PEROUT is disabled
    https://git.kernel.org/netdev/net/c/50caa744689e
  - [net,2/4] net: fec: do not update PEROUT if it is enabled
    https://git.kernel.org/netdev/net/c/e97faa0c20ea
  - [net,3/4] net: fec: do not allow enabling PPS and PEROUT simultaneously
    https://git.kernel.org/netdev/net/c/c0a1f3d7e128
  - [net,4/4] net: fec: do not register PPS event for PEROUT
    https://git.kernel.org/netdev/net/c/9a060d0fac9e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



