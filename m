Return-Path: <netdev+bounces-98355-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 311228D10B8
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 02:01:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFFFA281E5B
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 00:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B41A17BCE;
	Tue, 28 May 2024 00:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j1loUf65"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1293713C807;
	Tue, 28 May 2024 00:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716854431; cv=none; b=bNYxJYzvRDvoNmZw378haFGNzjV0u95GHENu3ng5ZxtZhRPvK455y+k6n2ywqjv4WF3GFV0Tuz3Ywa5OafXxKCgB6f5ElMeKFjq9f7w0TJnwjiZZL0CT8Wn8CWMtg6r6HUsVuyWOWf+7+WCQgImXgCY4j6aQyD5canPsMmTuGH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716854431; c=relaxed/simple;
	bh=KnOCp2qhtwB51yC8a+Iale1moRumwnl3EQ9O+oTkxCM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ejSmpyC0ci+1Stvmswg2c7CAl78wKgqDj6sOJAfIepU9r1O3O176+BUJYuDuQBJi5wiNnZFbl00LJc7kjOidBy5A93AriGGwClokgQNGD1Kly5X9DppEj2FutxVCu3fjIdpuYPIfDDpbbG/QWJhp9FKLrS1ExSZQyoq6dy0589w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j1loUf65; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 57F70C32789;
	Tue, 28 May 2024 00:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716854430;
	bh=KnOCp2qhtwB51yC8a+Iale1moRumwnl3EQ9O+oTkxCM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=j1loUf655B/12OXxmz6XPk1DzVfz+SJQkxtzId1vXSOuCaGKIj2udpntUcyywQc3E
	 NpqrQEfcE3rCVGqHE/mWnUeXUWuyModqdUSEA7JYsAs89XnMMjcm+0koEuMYDKRNcY
	 oofkqkWTsJS5LFtMZOaHCBa+iv7ZWvPIcfJptNU/3twSW8cqDLJzN6zEaVmNJ9b2XI
	 bwyFW7AWZuhbJAT5N/7cwjg18bLpjy03WgPpeh/NmFsuPffmWYe1nSgZ1ZjUgasPyo
	 3AZKaqkVwnt9wv31KK36JyjVOIMCp+DE3jCY1GxFxPuw19uywQddfBCUEFiVFXGQM5
	 75uT42PW+voVQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 41836D40196;
	Tue, 28 May 2024 00:00:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] dt-bindings: net: pse-pd: ti,tps23881: Fix missing
 "additionalProperties" constraints
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171685443026.27081.17116209068347534643.git-patchwork-notify@kernel.org>
Date: Tue, 28 May 2024 00:00:30 +0000
References: <20240523171750.2837331-1-robh@kernel.org>
In-Reply-To: <20240523171750.2837331-1-robh@kernel.org>
To: Rob Herring (Arm) <robh@kernel.org>
Cc: o.rempel@pengutronix.de, kory.maincent@bootlin.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, krzk+dt@kernel.org,
 conor+dt@kernel.org, andrew@lunn.ch, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 23 May 2024 12:17:50 -0500 you wrote:
> The child nodes are missing "additionalProperties" constraints which
> means any undocumented properties or child nodes are allowed. Add the
> constraints and all the undocumented properties exposed by the fix.
> 
> Fixes: f562202fedad ("dt-bindings: net: pse-pd: Add bindings for TPS23881 PSE controller")
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net] dt-bindings: net: pse-pd: ti,tps23881: Fix missing "additionalProperties" constraints
    https://git.kernel.org/netdev/net/c/12f86b9af96a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



