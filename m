Return-Path: <netdev+bounces-214925-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 368C3B2BEC8
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 12:21:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6ED83B210B
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 10:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CF8827700C;
	Tue, 19 Aug 2025 10:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aQLzjKbS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F2E1990C7;
	Tue, 19 Aug 2025 10:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755598799; cv=none; b=KYYkPxUSG4T7bOw3L1AWHzHzxp4+ghGWGMwoguz2vCg4xnLPeA1qkEFRuuwvSfOKDubxqqHIHhuRk5BGNusjkKeMCRlTe0OAm747zdika1Pycv+jrO0TVoBzBXDWFuFZXa1INtK9VKxtwo1Jtkg88qNTNxmcLbz0ZH8oyG3LU4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755598799; c=relaxed/simple;
	bh=fOqQzjbWihGF7hWIuWFVpu7NYnhvyZ0b0IjOWmZ63Cg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ue3j3dj3gYmOhZFxXQicaeCK24xgWMOXRpZ6+EhM/0BsnWUKE//kZBYZZ0WL672AjBZef9yWZANRrhWGBhKiHTiPLaFc1lhoT61Kyn5WgqZV+6QrSvqr9FJwWwHllJorC086KnnKz4da3PwcWGLj3Kap8YWsmoyIZabsEw7uc+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aQLzjKbS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6682FC4CEF1;
	Tue, 19 Aug 2025 10:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755598798;
	bh=fOqQzjbWihGF7hWIuWFVpu7NYnhvyZ0b0IjOWmZ63Cg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=aQLzjKbSCZkuYyxSLjr5w6wJwnBYKJ2ZZxh8TagiR8gBIztgORjpCm12eY23F9Hs9
	 QfGRy+q6W4o8e3UFQwq5ONhkaLEXBPkP+P7yCOhuxo/dbjs478UyqbY+Q/xFdkFwkt
	 rKyMghIW95rk5vA+Fob1FVc6gV4pKLZ1UTQ5TLWN5Efhxyos+nn84axo3l4lS+6bLY
	 jDSRsYLtlxHlYDOxoAqQsK8sJADTcsKo+KfGezOJyGFLb0Yk+NBFcJ3lrYBbFWHZEf
	 hqofLnNLoWVXvJ7jfQvmItfEVqcKfOGI++LPXQ093a9sulH8f0B0O1Pd+Vok8rEHNj
	 WsGzDqkQ1MYZw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 946BE383BF58;
	Tue, 19 Aug 2025 10:20:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next 0/2] net: macb: Add TAPRIO traffic scheduling
 support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175559880825.3483660.17220028783373782006.git-patchwork-notify@kernel.org>
Date: Tue, 19 Aug 2025 10:20:08 +0000
References: <20250814071058.3062453-1-vineeth.karumanchi@amd.com>
In-Reply-To: <20250814071058.3062453-1-vineeth.karumanchi@amd.com>
To: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
Cc: git@amd.com, nicolas.ferre@microchip.com, claudiu.beznea@tuxon.dev,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 14 Aug 2025 12:40:56 +0530 you wrote:
> Implement Time-Aware Traffic Scheduling (TAPRIO) offload support
> for Cadence MACB/GEM ethernet controllers to enable IEEE 802.1Qbv
> compliant time-sensitive networking (TSN) capabilities.
> 
> Key features implemented:
> - Complete TAPRIO qdisc offload infrastructure with TC_SETUP_QDISC_TAPRIO
> - Hardware-accelerated time-based gate control for multiple queues
> - Enhanced Scheduled Traffic (ENST) register configuration and management
> - Gate state scheduling with configurable start times, on/off intervals
> - Support for cycle-time based traffic scheduling with validation
> - Hardware capability detection via MACB_CAPS_QBV flag
> - Robust error handling and parameter validation
> - Queue-specific timing register programming
>   (ENST_START_TIME, ENST_ON_TIME, ENST_OFF_TIME)
> 
> [...]

Here is the summary with links:
  - [v2,net-next,1/2] net: macb: Add TAPRIO traffic scheduling support
    https://git.kernel.org/netdev/net-next/c/89934dbf169e
  - [v2,net-next,2/2] net: macb: Add capability-based QBV detection and Versal support
    https://git.kernel.org/netdev/net-next/c/d739ce4bebf4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



