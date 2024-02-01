Return-Path: <netdev+bounces-68029-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5005845AA1
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 15:50:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7F581C2294C
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 14:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CC5B5F490;
	Thu,  1 Feb 2024 14:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DEMCTBu0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594C75F48E
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 14:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706799027; cv=none; b=B947Sm1swBqxa20MYd+qR0yYb5iDOcev9gu5nBT16osQmDIerb+b/1+eYdcm7HqUkc5o80FnUzVJYLjAFKnDncl56dpF508/jg1qMQ+8KNbrUKV0FM78Bf4C/rCzlL6gYZYRNZD8X/5MCnm02mf53vc4KE9c2qe9KYG3KMQ4gEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706799027; c=relaxed/simple;
	bh=22iTqVvnKcCrSdyR4UYFp0JngmnUuDOInRZ0eakwJ3c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JtT/aK7OnAI2j5MPa6lRVDwoNfaf90X0ieh750MOUKdxDG6IlbyMD3zMyzEMsTUGeWD4SP0kqakZeooGYPkkvAUUSEniVqUF8nf93N1QoeTkX2MAWnD5FUOHQ5W1ffQE1Y5JqDSZzsA/vKLq3F0zFYDr9uV2Ozx6ocg7ZwpVptU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DEMCTBu0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D16E6C43330;
	Thu,  1 Feb 2024 14:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706799025;
	bh=22iTqVvnKcCrSdyR4UYFp0JngmnUuDOInRZ0eakwJ3c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DEMCTBu06RCRLNH+NG76Jdjq/712ch7i4t7NK5uV9wV6A1IAQiYbMgA9DIZdIWvyM
	 j62BZsfP2r2YZts1YNVncg6dkTZNNKozq0lQsXXa+tjpbenlFffI6qvutHIKWnSGUZ
	 WQRlcvKAV/8tQpDIJaqeKKMW3miwWPJk662n3PmDlZsuf7eYGxHPfCXCALgdK0Qjtd
	 W3pWIATkVsNxb45exprysFtMnYT6SRtIu7Ta5SvmARJwsQ/h+wVVGiAd0FFkJf8QOA
	 6XExFIUepj/iZJ5iiDdyRiHSLEL1OT1VUwbOc302vzuOwwfXGgZAyVDbAWvPKHJ0h5
	 tCyyTzIWX8VuA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B7E35C0C40E;
	Thu,  1 Feb 2024 14:50:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [patch net-next v2 0/3] dpll: expose lock status error value to user
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170679902574.28992.9418517904713262593.git-patchwork-notify@kernel.org>
Date: Thu, 01 Feb 2024 14:50:25 +0000
References: <20240130120831.261085-1-jiri@resnulli.us>
In-Reply-To: <20240130120831.261085-1-jiri@resnulli.us>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
 davem@davemloft.net, edumazet@google.com, vadim.fedorenko@linux.dev,
 arkadiusz.kubalewski@intel.com, saeedm@nvidia.com, leon@kernel.org,
 jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
 rrameshbabu@nvidia.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 30 Jan 2024 13:08:28 +0100 you wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> Allow to expose lock status errort value over new DPLL generic netlink
> attribute. Extend the lock_status_get() op by new argument to get the
> value from the driver. Implement this new argument fill-up
> in mlx5 driver.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/3] dpll: extend uapi by lock status error attribute
    https://git.kernel.org/netdev/net-next/c/cf4f0f1e1c46
  - [net-next,v2,2/3] dpll: extend lock_status_get() op by status error and expose to user
    https://git.kernel.org/netdev/net-next/c/e2ca9e75849e
  - [net-next,v2,3/3] net/mlx5: DPLL, Implement lock status error value
    https://git.kernel.org/netdev/net-next/c/2c54a4d71246

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



