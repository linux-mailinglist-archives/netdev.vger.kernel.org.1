Return-Path: <netdev+bounces-199546-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62EE2AE0AB4
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 17:40:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EE024A15C0
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 15:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4007C263F38;
	Thu, 19 Jun 2025 15:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VttZwXDv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1706924339D;
	Thu, 19 Jun 2025 15:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750347590; cv=none; b=TZC0CgcYAGoTKvUfZGbaE3pSAVFjEK+5dL18MeADookNnGBE5qAspsRQrnmCOpL3T5GHUY9l5TwmRarHUP5ZC1Hk5goiOaz4kJfk0rGA/fH8fvyANF4xw97hOJTtW2pGP7IqgE8MM9gDE9b6YSEzQ2X3h2XFx4GjbINePHnVqwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750347590; c=relaxed/simple;
	bh=VmB/GYTqV9qAe4X7/6sxHGc1CwbF8SPHioEspuEr9GA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GF0kUZBylqOyHtFjtKSn8BCTQzZbah0pIcguqYiD6MbPIvJBSROCCVutQWSQrDjBA8gnCWjQJm24y44aIG++h4dyzeARHO0o1KF66yVd4qsUtxyt2MnOWYBhuM3DWDdMkahqN4asIIvA3cIbh1yrB2XYKcfUdwQbIPzv4s5l9tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VttZwXDv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97AC7C4CEF1;
	Thu, 19 Jun 2025 15:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750347589;
	bh=VmB/GYTqV9qAe4X7/6sxHGc1CwbF8SPHioEspuEr9GA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VttZwXDvC8CfaWLo+ZAPd93i6aF9YRYnWVfUgPTvZZiHALmW+jVjDnqsnAdYStrJ4
	 oRQvQTrkxQre3FBv8WPQdeawC9uOg0gNGlm+sfBetyhPYFQ/yDX2QkjMGSrOgojixE
	 Wt7YpCBOP9prhXUeyxIzXjuh3QKJ7DmWu5eyyKJxBbouubYlxPxwW0lcDyO2hONRNL
	 C6NEzJIpQetLu0hn7JHuvzGleyZFCqECZwhjOqMQAnNQFOmu72FveUhb7BcvhGzOE1
	 eTMzLnb1KHvtD9U9rS5mA96d3jyAjr0NyCRCkqvAYDKA50TLwVqKWddDixxkS3R/Pj
	 V2JAMs4nCj2YQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF1538111DD;
	Thu, 19 Jun 2025 15:40:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] MAINTAINERS: Remove Shannon Nelson from MAINTAINERS file
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175034761749.906129.9697774327479250355.git-patchwork-notify@kernel.org>
Date: Thu, 19 Jun 2025 15:40:17 +0000
References: <20250616224437.56581-1-shannon.nelson@amd.com>
In-Reply-To: <20250616224437.56581-1-shannon.nelson@amd.com>
To: Nelson@codeaurora.org, Shannon <shannon.nelson@amd.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, brett.creeley@amd.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 16 Jun 2025 15:44:37 -0700 you wrote:
> Brett Creeley is taking ownership of AMD/Pensando drivers while I wander
> off into the sunset with my retirement this month.  I'll still keep an
> eye out on a few topics for awhile, and maybe do some free-lance work in
> the future.
> 
> Meanwhile, thank you all for the fun and support and the many learning
> opportunities :-).
> 
> [...]

Here is the summary with links:
  - MAINTAINERS: Remove Shannon Nelson from MAINTAINERS file
    https://git.kernel.org/netdev/net/c/a1113cefd7d6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



