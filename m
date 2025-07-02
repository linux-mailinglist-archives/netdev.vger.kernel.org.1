Return-Path: <netdev+bounces-203528-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51BABAF6495
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 00:00:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CD2A4E65ED
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 22:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E0B22FAC3;
	Wed,  2 Jul 2025 22:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u2eft135"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61FC222836C
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 22:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751493605; cv=none; b=kmPOiAonQ1mZbAx9ynjaNK4y+kYtKtxc3bRV3JsHU4Zkh/2vNPMC9I4ypcIWmbBLPD0PYf9jj5EmD8c100TecTzo61dvobfNgfzvC95osgWsMqf6OhXxiKst8Cg4/o+J4e3Hh+WOiH99vlvyHGJ0O0E9iHWWn/eOSc/xtiZ+dCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751493605; c=relaxed/simple;
	bh=fMVQZnUJTq6drq4dsft2Gy8p3CjNjWIq7VAyrd8l6FA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pRdtHmU6WCFmybDozk4BgB+VXq4NmtV28UYbhzg22G2c4ayutjHU5PXFIEE0GiOFHD74X58ncx+X7RPXzHUuJd1B+eDhOI/Lw3pKFUc6g9wXJ80TCP//fz2Y/AVbjCCLL5mYDndg4ixouP89+8NuHAGCbqYRxj9VbRlhMGH7dZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u2eft135; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE891C4CEE7;
	Wed,  2 Jul 2025 22:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751493605;
	bh=fMVQZnUJTq6drq4dsft2Gy8p3CjNjWIq7VAyrd8l6FA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=u2eft135FRxdoJlVwQXjf6Vku0QJ5/s5v3XQKRQ+RVip2fAzuZe+5ClSWcFqFPUA1
	 s/EGTw4S9u5A9I5dtO/wTiI0NaMWe5kfWY3nzUFPT4L5wOWB6RZX3Tfzo0xOdVnxUR
	 2a3YxClonKXKT/cLnEZtR4m72an7xWhiijn6bBDeZIpuuQBCbSKWn3Tu+/RTClCUbz
	 b6CxzXZGWfp2sEwqYvNUtWV3gd7Mqagn0jT71fWqsUud9aoidZ7JD8JxQzTtwbqWsZ
	 2PnDekBH6nfwK6+GHXNr3WMnzPUKEIOBnTLsQSRMRmIsS5etKAM3LUt0f0HXLfugXZ
	 rALLHNZdkeBnQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE22D383B273;
	Wed,  2 Jul 2025 22:00:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [RESEND PATCH net-next v2] amd-xgbe: add support for giant packet
 size
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175149362950.877904.15981259893074932366.git-patchwork-notify@kernel.org>
Date: Wed, 02 Jul 2025 22:00:29 +0000
References: <20250701121929.319690-1-Raju.Rangoju@amd.com>
In-Reply-To: <20250701121929.319690-1-Raju.Rangoju@amd.com>
To: Raju Rangoju <Raju.Rangoju@amd.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 Shyam-sundar.S-k@amd.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 1 Jul 2025 17:49:29 +0530 you wrote:
> AMD XGBE hardware supports giant Ethernet frames up to 16K bytes.
> Add support for configuring and enabling giant packet handling
> in the driver.
> 
> - Define new register fields and macros for giant packet support.
> - Update the jumbo frame configuration logic to enable giant
>   packet mode when MTU exceeds the jumbo threshold.
> 
> [...]

Here is the summary with links:
  - [RESEND,net-next,v2] amd-xgbe: add support for giant packet size
    https://git.kernel.org/netdev/net-next/c/9e2a7ad4ae90

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



