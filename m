Return-Path: <netdev+bounces-223819-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F27D8B7CA06
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 14:06:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CED8E2A3970
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 00:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DA1D17A2E0;
	Wed, 17 Sep 2025 00:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jD9VIHSO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC457137932
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 00:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758068405; cv=none; b=FRzjtpFncrJpxXSBSm/17ViKmz0F10KSKYPQcae1ZJGLrV2SBmrry0v7sLukBOStznVxKLnFjLmevicFyiq3mJ6OAX7m3ZLC9oui4BfztuElLZZPwynrphpk1m0sLOQPIj9KP1Qzn7v3+Y9TAeoowNCOg96hGgkPV91NmbmKwes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758068405; c=relaxed/simple;
	bh=ZFq0Rxc+luRkULSDKLDLM1pqM/513r9czWHezIhlwjo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AubD80DeooVyrcOExNTPwgCY5Tj4u/wqyd2CHj7YZLbYRpsT98Q3LlyXp/kTRE0w2CD6I1NOySg0Hb9eRFxBdH4RrbYyWp0T9YP64HjB3+ysY3dSrIPFNcqOuxq9+frbUFHIjio82eOw5x7zbQvpVxUIRq4cBklD+nL2Bzgg7vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jD9VIHSO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6685CC4CEEB;
	Wed, 17 Sep 2025 00:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758068405;
	bh=ZFq0Rxc+luRkULSDKLDLM1pqM/513r9czWHezIhlwjo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jD9VIHSOM3ZH19rpMHVa3/9K0bOJkCJXqO9jx7OyeNcRwa1UInldmnKbHtzyeKMg+
	 65PMUOBoUo6BECcVOTROm6eCu/o/pvRfqyYj5mrzBAi3wnZd7Y6iqfiGlwdOAQQ8xO
	 CjbpcdTeMtA64Id0ZhwIifczEzLz6ugqp1POEEeXbJspDO1inE4qxv4U05MUndPPRi
	 6cbs6riERrFP4BMUuMx0QxHyYTp3AWO4kQZlGcz0M95F8MvyBXR1phhy9p8Nwg4E85
	 7rbBbKRKLxoq6t32PNGl+d/nlyxKN+ff+KEI7bzqc0AkZJUeUDYxv9AG89VQ1TPXrq
	 fbSFSS8FgYdPQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AEE0339D0C1A;
	Wed, 17 Sep 2025 00:20:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] MAINTAINERS: make the DPLL entry cover drivers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175806840651.1411137.18175392444356919099.git-patchwork-notify@kernel.org>
Date: Wed, 17 Sep 2025 00:20:06 +0000
References: <20250915234255.1306612-1-kuba@kernel.org>
In-Reply-To: <20250915234255.1306612-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 vadim.fedorenko@linux.dev, arkadiusz.kubalewski@intel.com, jiri@resnulli.us

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 15 Sep 2025 16:42:55 -0700 you wrote:
> DPLL maintainers should probably be CCed on driver patches, too.
> Remove the *, which makes the pattern only match files directly
> under drivers/dpll but not its sub-directories.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: vadim.fedorenko@linux.dev
> CC: arkadiusz.kubalewski@intel.com
> CC: jiri@resnulli.us
> 
> [...]

Here is the summary with links:
  - [net] MAINTAINERS: make the DPLL entry cover drivers
    https://git.kernel.org/netdev/net/c/94ff1ed3030e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



