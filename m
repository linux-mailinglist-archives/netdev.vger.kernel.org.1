Return-Path: <netdev+bounces-131544-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8761F98ECD9
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 12:20:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B05B11C21139
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 10:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C4A114F123;
	Thu,  3 Oct 2024 10:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ik18hoec"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D0114EC6E;
	Thu,  3 Oct 2024 10:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727950831; cv=none; b=Uvkw+0VkpeacWFeRHDKRygJqndXEDnHxT6/FG3gbEbamApZ3Psz+DCcDuqCaVGSRifp5DJMMDaOE5bAfYyDK/579a4t4W3QB4J2XgZPwSx1Y3MxYHTIyQqsLUTbximl+/YxO8RcKZp6+Ul+i0m381W+KvtmOd3HpmnV0rrjeCBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727950831; c=relaxed/simple;
	bh=W+J3sXHerufqv59d1vgtIjOoGzeoC+wZ5UortO9HzSI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qhvFUQC2V2CxDAGJBfAchkjpSXwBDxE4IH24SgU+YsNxjZTnP5r5DogAuVnjVashrd43UXqK1qLUbK74kfCw2llr2qEfvc8QmEI2g6LfM5ZKH00HnKefQrMMqLpMxJwmE+OApi2DOoWFzJFIzn23OcRvfJqvr2aD0Ta1Cuzo7iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ik18hoec; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E257C4CED0;
	Thu,  3 Oct 2024 10:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727950830;
	bh=W+J3sXHerufqv59d1vgtIjOoGzeoC+wZ5UortO9HzSI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ik18hoecff6emTLWTbwnXqAJ3XqGq0//OYLXWLgvaslePaeH6+/sEsmUYN1jTFzaM
	 lqNQ9+a6IbN0P3RoaX2vZjRzw9z2R1UXJcJZuzBZpJ5FgJqzeDdMOeHvwqmgEWVozZ
	 VB1wY0C1hru5KV7+gYF2ODs8jKUciXPEe+0j4BZk6KyJVvxe1TVRQK8yv1Xb31dz2I
	 BGIE+eJZf6DbqK52YrTdkinrQBQlRcZEn3K3sKIA9LSJNdbj4NpzxmGUZDQ5QjGLD1
	 jpaKXZI93b7n+hqvGeE2mY4sHo+tTQcd23Y1QNzYG28aLHPmxGgv5jmIge28AGZtFk
	 D6CoH3Oas/QvQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE2A3803263;
	Thu,  3 Oct 2024 10:20:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] dt-bindings: net: xlnx,axi-ethernet: Add missing reg
 minItems
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172795083352.1807590.8456410815088222865.git-patchwork-notify@kernel.org>
Date: Thu, 03 Oct 2024 10:20:33 +0000
References: <1727723615-2109795-1-git-send-email-radhey.shyam.pandey@amd.com>
In-Reply-To: <1727723615-2109795-1-git-send-email-radhey.shyam.pandey@amd.com>
To: Pandey@codeaurora.org, Radhey Shyam <radhey.shyam.pandey@amd.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, git@amd.com, ravikanth.tuniki@amd.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 1 Oct 2024 00:43:35 +0530 you wrote:
> From: Ravikanth Tuniki <ravikanth.tuniki@amd.com>
> 
> Add missing reg minItems as based on current binding document
> only ethernet MAC IO space is a supported configuration.
> 
> There is a bug in schema, current examples contain 64-bit
> addressing as well as 32-bit addressing. The schema validation
> does pass incidentally considering one 64-bit reg address as
> two 32-bit reg address entries. If we change axi_ethernet_eth1
> example node reg addressing to 32-bit schema validation reports:
> 
> [...]

Here is the summary with links:
  - [net] dt-bindings: net: xlnx,axi-ethernet: Add missing reg minItems
    https://git.kernel.org/netdev/net/c/c6929644c1e0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



