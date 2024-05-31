Return-Path: <netdev+bounces-99624-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4710A8D5840
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 03:40:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01EB5289214
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 01:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADDA81171C;
	Fri, 31 May 2024 01:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RwHOnC3j"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82047EAE7;
	Fri, 31 May 2024 01:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717119633; cv=none; b=k5L1GRaO6uzWzSPlHkSUA5R+HjC6ggknzXgzpKJKymV8qSGcOFZLPuLnHOXF8bCvzli9C2Ngwvbz222Nzf3xt4C6G1OVSFFt026LUL9IYPPAaHq6c9/IBpF23jehCNn8w2goSiVjxqTP76YrIy1kw9e53JaFXcRosfi+4HwRq/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717119633; c=relaxed/simple;
	bh=0QcoVA6kHXD2J3K8hFxrVZXAMa5lJRX2YC7JyYwXKB8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mY9vbFOKXBk4qkOZRWx0Ok73mUF5PEaCnJ1AzH7rlFv5FNhHTKUtws1ikTAx3CYi0+IIiywF0oJtgjSkBn1YHoTQaz5153ZBlirA5qLy6xSBRHhdPRvvo/pjq/qmzYgQJwwwdN84c5IFEB23MguCcSdOKLprrs19CjzjQBRkZXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RwHOnC3j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1A338C4AF08;
	Fri, 31 May 2024 01:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717119633;
	bh=0QcoVA6kHXD2J3K8hFxrVZXAMa5lJRX2YC7JyYwXKB8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RwHOnC3jCNFDY2o1kGmkqDFFHKEx8K1DgJYFqW7iRywvaOtMQn66lKn2Lw///RetX
	 yk4JuXK12EUNLxAgEzwvRDRbYOpUv+K5czj4SzmJc76m5ja5M/lEyRpxAaZc2TFraN
	 Q4jOAC9BHWrWS0U7cUJfGJlzhsCqGHuKhqI6FMfrZnz5C5WFn2FWjUkku03mtPAgiG
	 6N6q0PxRGlK99RpULvdMohKWbjNH2pVaBbEKIkNuBKxTJgPq5H7gxhkiYnS2OgKahE
	 ++/FVWbvEv92GBHoPeyzLxgC1hF7cpdQxtSki31DXbEdq9meRe1vH0YVaBqLMFOJ6/
	 3IvrNtY5Bqlzg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0CD4AD84BD0;
	Fri, 31 May 2024 01:40:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] dt-bindings: net: ti: icssg_prueth: Add documentation for
 PA_STATS support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171711963304.18580.11844749195457939777.git-patchwork-notify@kernel.org>
Date: Fri, 31 May 2024 01:40:33 +0000
References: <20240529115225.630535-1-danishanwar@ti.com>
In-Reply-To: <20240529115225.630535-1-danishanwar@ti.com>
To: MD Danish Anwar <danishanwar@ti.com>
Cc: conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org,
 pabeni@redhat.com, kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, srk@ti.com,
 vigneshr@ti.com, r-gunasekaran@ti.com, rogerq@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 29 May 2024 17:22:25 +0530 you wrote:
> Add documentation for ti,pa-stats property which is syscon regmap for
> PA_STATS registers. This will be used to dump statistics maintained by
> ICSSG firmware.
> 
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> ---
> Changes from v1 to v2:
> *) Updated description of ti,pa-stats to explain the purpose of PA_STATS
>    module in context of ICSSG.
> 
> [...]

Here is the summary with links:
  - [v2] dt-bindings: net: ti: icssg_prueth: Add documentation for PA_STATS support
    https://git.kernel.org/netdev/net-next/c/2f19a795e1f9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



