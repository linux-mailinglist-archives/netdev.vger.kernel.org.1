Return-Path: <netdev+bounces-190596-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD950AB7BB2
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 04:40:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 098AE1BA6559
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 02:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D1A2951B7;
	Thu, 15 May 2025 02:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K47sOqFB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEEF7293B6F
	for <netdev@vger.kernel.org>; Thu, 15 May 2025 02:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747276800; cv=none; b=EVAHOqlIWQP7qda36isxEox6n4ih855GpDRAojcfj0MzIW0n4OjsyFaEzOtwRTWK4IknZe9TwaftYX7RbPH/iQRd+Dh5vdGCl+bAbf5rE9VTev4mZJjiLJs5slspFL3bk7kqxaBgVP8d3bwSC1qjZI+MqUMf9SJiP/lYHK16Teg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747276800; c=relaxed/simple;
	bh=Py97hMz6jwP+v8rrKGMkQrj1Dug2boa6NnOQ6GDgMvQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QITs1NhJkvRVjl8yjAC2J4hp6PbOSxCrReV0C+zMs1yNGPrIujaMC1fD54lf+pfXS5SY8j8VYu3oBbfkj2a1uBpCxcXvAKg9F5eSow8dT3bG+r+zI3bG3AjxU0/0fcw9ZtaGSMp2I9+vIet7m2eDdjqRH83THje2QM4R4sB+fHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K47sOqFB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F3CDC4CEE3;
	Thu, 15 May 2025 02:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747276800;
	bh=Py97hMz6jwP+v8rrKGMkQrj1Dug2boa6NnOQ6GDgMvQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=K47sOqFB19hHpRgjiCDz1Gkw7vER29mv1cPrx67X3YZifEVODF5zlInlgrJmOCdsB
	 phHIe4eX2dT2Swh2pRmNvahM/QNsI/fJPw6vHUD6fPG4OJjv9ep7ancbdCXsRPtpFx
	 cgZMkkMrSOhY1OXB/zUd62+TVy2Pb7uVQcHxEJ6x4l98ss8TdMBXn3qTCqluKdzuTq
	 ZBPNh2lyUwty00iFuxMXREc/mFRaxX8bXwTCfpXQEqdhslS2bSoDuV4yMvKK66oxlN
	 0JR6ASCQYTNcbNzRJo2i9Se0jf9RdyW6lPDjnKd9yYpxWKMIE63c8K6uYFyOrSfgHw
	 zijy4MXbkSVIw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD78380AA66;
	Thu, 15 May 2025 02:40:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net v2] octeontx2-pf: macsec: Fix incorrect max transmit size in TX
 secy
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174727683749.2587108.16441067105502949359.git-patchwork-notify@kernel.org>
Date: Thu, 15 May 2025 02:40:37 +0000
References: <1747053756-4529-1-git-send-email-sbhatta@marvell.com>
In-Reply-To: <1747053756-4529-1-git-send-email-sbhatta@marvell.com>
To: Subbaraya Sundeep <sbhatta@marvell.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, gakula@marvell.com,
 hkelam@marvell.com, sgoutham@marvell.com, lcherian@marvell.com,
 bbhushan2@marvell.com, jerinj@marvell.com, sd@queasysnail.net,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 12 May 2025 18:12:36 +0530 you wrote:
> MASCEC hardware block has a field called maximum transmit size for
> TX secy. Max packet size going out of MCS block has be programmed
> taking into account full packet size which has L2 header,SecTag
> and ICV. MACSEC offload driver is configuring max transmit size as
> macsec interface MTU which is incorrect. Say with 1500 MTU of real
> device, macsec interface created on top of real device will have MTU of
> 1468(1500 - (SecTag + ICV)). This is causing packets from macsec
> interface of size greater than or equal to 1468 are not getting
> transmitted out because driver programmed max transmit size as 1468
> instead of 1514(1500 + ETH_HDR_LEN).
> 
> [...]

Here is the summary with links:
  - [net,v2] octeontx2-pf: macsec: Fix incorrect max transmit size in TX secy
    https://git.kernel.org/netdev/net/c/865ab2461375

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



