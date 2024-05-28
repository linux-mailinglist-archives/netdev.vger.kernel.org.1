Return-Path: <netdev+bounces-98354-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A818D10B3
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 02:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A24901C21358
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 00:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E517813C3D7;
	Tue, 28 May 2024 00:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sA7vnbgy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B4E17BA2;
	Tue, 28 May 2024 00:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716854430; cv=none; b=OSM85fXUJh+h6yZGUgwNOt1tyjKGMrPdJIN0jQQFJnsYx9r7Si1NAaJhYXtkdaOTRFBA9HfrirS3W1qEP4ahhJmhNIbdzK81uAlcI0hMgXiYHkg658OsKvk5Q5ALB+NlhfgFBVLc9DwlBAh3Blx8G9fHblXPghTmjjLlgqlGpWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716854430; c=relaxed/simple;
	bh=p/Ids7iJ/P4qpO7RCzP9/JpwQD2AHXNA87vte2+uDC8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=X/NOdODn0qU46OnocHv7K6UHToCzRKA31cP5ex8opY8BcvmC3AUcSZPJV1FLKEzGrBtUrKs6OyFciCPw/qGS4yzlXDeQNjxeX0/I3Z/K+0kNQopWc+9FZj2zXSfvS/wJR1jYW4neHqfPWO8nspszn28NOIDMPcXScx1kLrmdIYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sA7vnbgy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 44EA4C32786;
	Tue, 28 May 2024 00:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716854430;
	bh=p/Ids7iJ/P4qpO7RCzP9/JpwQD2AHXNA87vte2+uDC8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sA7vnbgy08cZWMj66YCXZdf1IwytxqVcNfT4j+rInX7njWEfHykrD9/wo8s7rQCFs
	 7nXE79dOdELRPVHCDGf+tFttW1JQZaJdC2j5tL1rZdx9OW9FfA4u8S2EuNFOEatGrU
	 kOfL0ivF7VZOWZq2zOLXbAI4EgGoM8MMgA2jDnkOJm6xULIjFJQtzCnSXO3A/Zgqb4
	 oZsbQ+LQwkrWNatyexllhAJpGsq2RgNodAAFvd7jXp9LzsYwoX47s+6/jpras8woSz
	 6VH9hfOf1H4fRHsn8pfT+tbqDcC2TYymD43lr1JV6AyQN0JQ2OCemw0Id/ZIb37mf3
	 6mq+Bj+funsBA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 31BB7CF21F8;
	Tue, 28 May 2024 00:00:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] dt-bindings: net: pse-pd: microchip,pd692x0: Fix missing
 "additionalProperties" constraints
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171685443020.27081.631455049098356051.git-patchwork-notify@kernel.org>
Date: Tue, 28 May 2024 00:00:30 +0000
References: <20240523171732.2836880-1-robh@kernel.org>
In-Reply-To: <20240523171732.2836880-1-robh@kernel.org>
To: Rob Herring (Arm) <robh@kernel.org>
Cc: o.rempel@pengutronix.de, kory.maincent@bootlin.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, krzk+dt@kernel.org,
 conor+dt@kernel.org, andrew@lunn.ch, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 23 May 2024 12:17:31 -0500 you wrote:
> The child nodes are missing "additionalProperties" constraints which
> means any undocumented properties or child nodes are allowed. Add the
> constraints, and fix the fallout of wrong manager node regex and
> missing properties.
> 
> Fixes: 9c1de033afad ("dt-bindings: net: pse-pd: Add bindings for PD692x0 PSE controller")
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net] dt-bindings: net: pse-pd: microchip,pd692x0: Fix missing "additionalProperties" constraints
    https://git.kernel.org/netdev/net/c/0fe53c0ab018

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



