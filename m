Return-Path: <netdev+bounces-230243-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC37BE5B8D
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 00:51:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 469D4188374C
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 22:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 668DF2E8DF4;
	Thu, 16 Oct 2025 22:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FWZtRiwc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425D02E8DE5
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 22:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760655038; cv=none; b=b3QgeOjbAz0rKYxGcwfo89uqX1Mu6bZxKSNOHwzjDICg8D6BzPnqwb/G3aESG1e8Vwo8kqxlCPvsvWDR7wNOv+MmdM1z5ZIjHJ/neXrZrOctLcdUFyzUtb5a7733WQgh/FIqWMjtA4FBpl98uzbmG7zvtU1wYa6tIPHmiqiSYyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760655038; c=relaxed/simple;
	bh=N7OTCWj0j2gzufZF89WLD79cP37N22sZyinYxRQamV0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nuj8WT5GMAqIYu+PUKra2yl2GF61Bu67aFEth5VIsQ2thJWRXDgubOrsRHVuL5+8XFyGDVfpcMlIWWCepFXYCgfPLrEuFZmCp/h3PbhUGBVxUdGsZPsaz10K8mFmkrmA74TU1KpcvIstevxlmfOoUmOWvD+LIF4SImXCrhskgUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FWZtRiwc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D63FAC4CEF1;
	Thu, 16 Oct 2025 22:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760655036;
	bh=N7OTCWj0j2gzufZF89WLD79cP37N22sZyinYxRQamV0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FWZtRiwcHWDRBDNZmvp8H/54mOkAqu0pKosaUd1xOPGn3KyDPDNzk/eHLhXDK359t
	 +QGnKeXUrwb05n/N8eNGfRuil+PBJVJAliI+J7DDwcGgZfhFj27PJ/adGPT5DjaoLb
	 xhHmAUKb0k/TkFWaVp0XJolWBLt/pYm/NVAfnRe4J7l4DfySJILSt0Rh7K9ev7X6h3
	 IaPeWAUIl6t+mEaWu58WrpnuQKhGE7IaCYTBAeO/hDbnrSt/BHoqthRFOA5wnnDe11
	 IoSvpf3z8cu9qjhgxDTTC5bRPLmmteA+VqoVvqlUjw8+FHugeNOX8r+Pu5eDLQ+8zN
	 UuSilLT3VAing==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E7C39D0C23;
	Thu, 16 Oct 2025 22:50:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] netdevsim: add ipsec hw_features
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176065502075.1934842.8405691575194373905.git-patchwork-notify@kernel.org>
Date: Thu, 16 Oct 2025 22:50:20 +0000
References: <20251015083649.54744-1-liuhangbin@gmail.com>
In-Reply-To: <20251015083649.54744-1-liuhangbin@gmail.com>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 sd@queasysnail.net

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 15 Oct 2025 08:36:49 +0000 you wrote:
> Currently, netdevsim only sets dev->features, which makes the ESP features
> fixed. For example:
> 
>   # ethtool -k eni0np1 | grep esp
>   tx-esp-segmentation: on [fixed]
>   esp-hw-offload: on [fixed]
>   esp-tx-csum-hw-offload: on [fixed]
> 
> [...]

Here is the summary with links:
  - [net-next] netdevsim: add ipsec hw_features
    https://git.kernel.org/netdev/net-next/c/38c31c2620de

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



