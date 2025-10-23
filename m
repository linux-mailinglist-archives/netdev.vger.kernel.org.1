Return-Path: <netdev+bounces-232145-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C26C01C4A
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 16:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33F781884270
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 14:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B859230F7ED;
	Thu, 23 Oct 2025 14:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IxVmq1SJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909AC30ACFF;
	Thu, 23 Oct 2025 14:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761229835; cv=none; b=H7kON4OFM68L0REhGWqrQAd9yAEcKW6HuDmnucSVM37COfPxA+LAkXhbg40ShKyBjRNWTEMiq6c39f4GFslPoRkaQV4AwiWg3TDIxSvBWcvvw1ldmBnHbgHxDUlVZXPJUZ97BipZIOtqLPPDkB2TnJcKe11YWqITB2/EfowDTJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761229835; c=relaxed/simple;
	bh=5EExnN7gsO/XceRkVCZsD8PNVtYXY7UJwfNTTnd58sA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JN5mceFbNSErASr/ZGCh7GxAj66LevkYtGn6rqmGdMn6ytfGSI4z13GxBAoib5+72MH+U9sCtucocysX1YOPbcweydFava7dS/XHRQMQcN8A8VbsbDYY4l4rW9ECWjfDhscVnEFiGH+rnlUsQ0quWolVZxpR5vca5Tt6ea8NnIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IxVmq1SJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D28BC4CEE7;
	Thu, 23 Oct 2025 14:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761229835;
	bh=5EExnN7gsO/XceRkVCZsD8PNVtYXY7UJwfNTTnd58sA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IxVmq1SJRNQJfQusb1WTfbamXvNj4R0K6h0hpmV8CnTK9w3rxNGaJKIcrq5C9w7Ir
	 /QMfRy7Mbj7dMNawdsleito7ZpRkYtAEurADog5qEkaHqwq+X/+9i1ihWnnRHQzGJf
	 dtqzXCWSpHytkaVn+3ojfVG0B+lt3BVlx8ryb5MquSdDaPGCT/Jj/Y2GHdSgFcsm5E
	 hSW6sSsiVVb32Es2TKiinjwhOjWZ/OdXrsPCRMlSN3IO8SD6zzGLBum4tYP+zBrz2o
	 Gq58TIIA/1mUvDj5AHSsjq1SSz6hID65oFE8B+GV9GuRCDJHTc/2brLin6zmZpt+uJ
	 ACIS2/BDyjFbg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE0BD3809A97;
	Thu, 23 Oct 2025 14:30:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: phy: micrel: always set shared->phydev for
 LAN8814
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176122981550.3105055.6331670234588911698.git-patchwork-notify@kernel.org>
Date: Thu, 23 Oct 2025 14:30:15 +0000
References: <20251021132034.983936-1-robert.marko@sartura.hr>
In-Reply-To: <20251021132034.983936-1-robert.marko@sartura.hr>
To: Robert Marko <robert.marko@sartura.hr>
Cc: daniel.machon@microchip.com, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, vadim.fedorenko@linux.dev,
 horatiu.vultur@microchip.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, luka.perkov@sartura.hr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 21 Oct 2025 15:20:26 +0200 you wrote:
> Currently, during the LAN8814 PTP probe shared->phydev is only set if PTP
> clock gets actually set, otherwise the function will return before setting
> it.
> 
> This is an issue as shared->phydev is unconditionally being used when IRQ
> is being handled, especially in lan8814_gpio_process_cap and since it was
> not set it will cause a NULL pointer exception and crash the kernel.
> 
> [...]

Here is the summary with links:
  - [net] net: phy: micrel: always set shared->phydev for LAN8814
    https://git.kernel.org/netdev/net/c/399d10934740

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



