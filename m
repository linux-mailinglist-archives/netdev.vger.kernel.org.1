Return-Path: <netdev+bounces-105106-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09CD190FB04
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 03:40:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5FBC1F2211F
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 01:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9134112E78;
	Thu, 20 Jun 2024 01:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j0H2GOt5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1A3BA46
	for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 01:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718847631; cv=none; b=QT9k3AQcydFIKa3AYz9omFNUo/p+p5aKdOS8sovWF1ctnUTKDOvU2E7mrv8kO9D0UK8diLrmMLD+bu4yAeUBAjPRyl9qnv1NdsxGVQp44IttkAXPOPXblBRAskZDZPNyzrtTFP2dC+HQvfR1N2YUw68Wrhr9U3PneQMZwfm7/js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718847631; c=relaxed/simple;
	bh=JtQEV4FF3Q4SO0aRxgNU9rE+I2vw5jrE3DIIn0m2doY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ClesvlMMzmKTcnlfTKtIA1mk8Vfy0AyIhzb8tDoC9HqidGefHp4UrwEp7uTJeqNHWoD+BqEVV3Daltoti7KwN8+RAoQNaP4pWkmU1u5/KhTlBpiwOxB5NuaT+3T62K+9hJZL1bioLCRct423+gZnV2qAa7a+9oMBr14Y0fjc5eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j0H2GOt5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C7C1BC4AF09;
	Thu, 20 Jun 2024 01:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718847630;
	bh=JtQEV4FF3Q4SO0aRxgNU9rE+I2vw5jrE3DIIn0m2doY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=j0H2GOt5wM4CSPTKVAa01R+bOPy+EQsjmuwjsK5Q6f0F68PJ+vUZ1u/S+I1ewJLKG
	 yuizuw76llitV+z8s8GHrTvRID5mig9rj6PyiFV78cVsJqp9gh0xIcZLpp34zpZTVP
	 HSytOtfSNq/gK6cPV3Bp99Zoq2cZfTeQVTwTBqyS6xzFac+5CjXm8CXcRKm5G+PaFE
	 5uouxvqQ7+MISkn1Ppn/HPQxOBq4dch0oFN8GEV6uyyCOxK/LEAPNG3c21YAqZ8VON
	 JSq+KSb+9JeJsx4CNDWmYmXDmJrE/E5zi8B6fyS0dg7/gXsLTnCFpWoqkXcEQveR2B
	 2U9ZB6/q62g6g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A4918E7C4C5;
	Thu, 20 Jun 2024 01:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next 0/8] ionic: rework fix for doorbell miss
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171884763066.25211.4340482488422043694.git-patchwork-notify@kernel.org>
Date: Thu, 20 Jun 2024 01:40:30 +0000
References: <20240619003257.6138-1-shannon.nelson@amd.com>
In-Reply-To: <20240619003257.6138-1-shannon.nelson@amd.com>
To: Nelson@codeaurora.org, Shannon <shannon.nelson@amd.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, David.Laight@ACULAB.COM,
 andrew@lunn.ch, brett.creeley@amd.com, drivers@pensando.io

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 18 Jun 2024 17:32:49 -0700 you wrote:
> A latency test in a scaled out setting (many VMs with many queues)
> has uncovered an issue with our missed doorbell fix from
> commit b69585bfcece ("ionic: missed doorbell workaround")
> 
> As a refresher, the Elba ASIC has an issue where once in a blue
> moon it might miss/drop a queue doorbell notification from
> the driver.  This can result in Tx timeouts and potential Rx
> buffer misses.
> 
> [...]

Here is the summary with links:
  - [v2,net-next,1/8] ionic: remove missed doorbell per-queue timer
    https://git.kernel.org/netdev/net-next/c/4aaa49a282ad
  - [v2,net-next,2/8] ionic: Keep interrupt affinity up to date
    https://git.kernel.org/netdev/net-next/c/d458d4b4fd43
  - [v2,net-next,3/8] ionic: add private workqueue per-device
    https://git.kernel.org/netdev/net-next/c/9e25450da700
  - [v2,net-next,4/8] ionic: add work item for missed-doorbell check
    https://git.kernel.org/netdev/net-next/c/4ded136c78f8
  - [v2,net-next,5/8] ionic: add per-queue napi_schedule for doorbell check
    https://git.kernel.org/netdev/net-next/c/d7f9bc685918
  - [v2,net-next,6/8] ionic: check for queue deadline in doorbell_napi_work
    https://git.kernel.org/netdev/net-next/c/55a3982ec721
  - [v2,net-next,7/8] ionic: Use an u16 for rx_copybreak
    https://git.kernel.org/netdev/net-next/c/f703d56c0305
  - [v2,net-next,8/8] ionic: Only run the doorbell workaround for certain asic_type
    https://git.kernel.org/netdev/net-next/c/da0262c2c931

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



