Return-Path: <netdev+bounces-186854-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BCAFAA1C35
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 22:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29A963B2C9F
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 20:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13F412620C1;
	Tue, 29 Apr 2025 20:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AUDsH7YF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4064261362
	for <netdev@vger.kernel.org>; Tue, 29 Apr 2025 20:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745958597; cv=none; b=a2jV4VNvaASKaF/swzAwbXjVhOqmqp+W368fAb15kr1V0EG7NuEeC8A+l/w/bPgRMKn1SQSprE3uOzFzDKAFRZr5Qvj56ZvRsamohqrNPTIZpAvNJwCuuOfdCcZGKFiPWR/j9Mh5fLaC76udKZQmCJGpJDoaCF6GoivYl7FTap8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745958597; c=relaxed/simple;
	bh=MC5Q5Fo5wugvYVHXpUkq4oPy2O43US4MefR961PzDPA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=d/xx4ZO0EXMQBHjJGxKOEqq8cVKP8jUa3u3X7WqoaxVEZE6z7HUzvkac7hWcZkcaUcKAXkVqjEUYmYYV0TZ5jdovpB9gGubxrUFCKe/3CWOeO6KVmgn/HOBWVCFafqU1cH9pzcEoyrkXKTAulnh7KCaTrI/oKt8Scm3LwBCrNB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AUDsH7YF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C548EC4CEE3;
	Tue, 29 Apr 2025 20:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745958596;
	bh=MC5Q5Fo5wugvYVHXpUkq4oPy2O43US4MefR961PzDPA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AUDsH7YFpN+zo3HxrAUsiiKq7Y4tR1524T0Q6OCENwxf3TYGpz5FMKWm9xC0KzXvU
	 Y+SOnxFADthNr8sJ5+UDioi1bI7lxzARIYTXRVzaqiQlT1K6cOXcaKmi0YC+bL/OUR
	 SA2Ltbm6HKdfdXv1398zDggdF1pvGHCjjmU1zVuJYFxUtyi7egdyvVmhUN3HPGVvFe
	 L2aXPW0mPY+2azJbMclIhJWkaRRpUOyf5ufHxCu/IR5teOFFoOwcfhdTTTeOnKgKx+
	 YrA2g1fLPFObudKFdHPlFfrvCSgdW9R/sUMu2hwwVzX8+DoZSsqrnGUQg20cVJs/l4
	 oidA5+ZU53URA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EABEB3822D4E;
	Tue, 29 Apr 2025 20:30:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH ethtool-next] channels: support json output
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174595863575.1788116.7871745700019155362.git-patchwork-notify@kernel.org>
Date: Tue, 29 Apr 2025 20:30:35 +0000
References: <20250429150332.2592930-1-kuba@kernel.org>
In-Reply-To: <20250429150332.2592930-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: mkubecek@suse.cz, netdev@vger.kernel.org

Hello:

This patch was applied to ethtool/ethtool.git (master)
by Michal Kubecek <mkubecek@suse.cz>:

On Tue, 29 Apr 2025 08:03:32 -0700 you wrote:
> Make -l | --show-channels support JSON output format.
> 
>   # ./ethtool -j -l '*' | jq
>   [
>     {
>       "ifname": "eth0",
>       "rx-max": 32,
>       "tx-max": 32,
>       "combined-max": 32,
>       "rx": 0,
>       "tx": 0,
>       "combined": 20
>     },
>     {
>       "ifname": "veth0",
>       "rx-max": 80,
>       "tx-max": 80,
>       "rx": 1,
>       "tx": 1
>     },
>     {
>       "ifname": "veth1",
>       "rx-max": 80,
>       "tx-max": 80,
>       "rx": 1,
>       "tx": 1
>     }
>   ]
> 
> [...]

Here is the summary with links:
  - [ethtool-next] channels: support json output
    https://git.kernel.org/pub/scm/network/ethtool/ethtool.git/commit/?id=64226907d0d6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



