Return-Path: <netdev+bounces-116248-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65EDC94990F
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 22:28:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DC161F20F43
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 20:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5465016DEA6;
	Tue,  6 Aug 2024 20:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NefCCksu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308AA15F330
	for <netdev@vger.kernel.org>; Tue,  6 Aug 2024 20:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722976086; cv=none; b=omToShlPrRAngXC6i03v+7Ht3Pj/utUoZYFubhNxnE3zftYyDvpzJ/dYVjWGqfrn6dS3pEx5noIJ+ybAjRikflA+suGEhCEIPguX8OAO3OOg96bEfvxNLNhWt3GWpXs2T8MryqzAwqPnkC4cESwmrRi8DJdZQEzuoANXF0SHSmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722976086; c=relaxed/simple;
	bh=yF8NCqlfk5BL/2l4vDuoqqwT4Aj+KKj8ylZQ2PTp7+8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=V2A7rh1WinfFMwpRqgbmuKw+QVemZO3VenXthru0TIVjblDRwBXBRpSgQs+u5/gD/EiyCg4hg8YiXDLk8WoZBQbztN1JH7Dt8cfk7JWZLqtzbP2daMST3ype42CH3kPsmVksF5uZO8l9P3mVlDoeLGlbBib+BwCYsbp56ychh3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NefCCksu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0B76C4AF0E;
	Tue,  6 Aug 2024 20:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722976085;
	bh=yF8NCqlfk5BL/2l4vDuoqqwT4Aj+KKj8ylZQ2PTp7+8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NefCCksuutjLO/dO1s+ufjgPXAgLiE0pWCMUtYpFuc4NrhBQW2p4nLPLxMCjUaueN
	 RliXI5snRSb477Hd3Tz37ddutnTWFGpW/2qg0dlKwHfEkvVf82p7IME75Dyy5AW6uk
	 4jW0eqIlT3VkHtLXJyWWcGQV1CHUKeWQ2OmlRIy9CM0Y97G4Cgs9KTrAWuiXIQVPpw
	 fwwZA3XalA6nIPGwsagXe3I3TStPZ8DOS2cUpCGN+3hY0pM/038mvLYnfHOQn+bze+
	 NR8Gn8lWNsbPkX1u2YMnRgUUMU+A+5fvau6se9iTtHt5zANceTIXOPP8MEE/51mgKJ
	 1ZC/HlUU9dUEQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE98F3824F34;
	Tue,  6 Aug 2024 20:28:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] MAINTAINERS: Update Mellanox website links
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172297608425.1692635.3954071372668689220.git-patchwork-notify@kernel.org>
Date: Tue, 06 Aug 2024 20:28:04 +0000
References: <20240805052202.2005316-1-tariqt@nvidia.com>
In-Reply-To: <20240805052202.2005316-1-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, saeedm@nvidia.com,
 gal@nvidia.com, leonro@nvidia.com, rrameshbabu@nvidia.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 5 Aug 2024 08:22:02 +0300 you wrote:
> From: Rahul Rameshbabu <rrameshbabu@nvidia.com>
> 
> Point to the nvidia.com domain.
> 
> Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> 
> [...]

Here is the summary with links:
  - [net-next] MAINTAINERS: Update Mellanox website links
    https://git.kernel.org/netdev/net-next/c/c4e2ced14af0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



