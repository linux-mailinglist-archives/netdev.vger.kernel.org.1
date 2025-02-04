Return-Path: <netdev+bounces-162363-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6809DA26A3F
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 03:50:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC8F41887508
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 02:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CAA11482F5;
	Tue,  4 Feb 2025 02:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wcg2tMzp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4717814658D
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 02:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738637408; cv=none; b=iboa533hQyfMDcqIaTCsNme8V3G5Uiv5MhT+nL1qZXs6PZjNZF4e0QodJ9Y/Pwct2IAyG3bmX8p9kDF7AmbbqW8CtMBBvAvzaM/E3BI209mByFeLZupSQj4b61O+7Fnl4m8sH4WbyrBZjSOg/e0IFRlzgOc1IgACE8HAhWFDPAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738637408; c=relaxed/simple;
	bh=kUuqY/yv1X4kSKFiiQviC1HLu85SHQZqXDQqudv5MZY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Q/Gl3hKdAfeQlPXKMwSoMtfSYKCu6W+7Zh+A2Z1zb/9iQrdW4wMnbuSi4GmazIuZkBbpjuTG6btCm61Qzi/T3jEd2QVe/WE4tfmQAOvzR/j9252qDdoAcdda9CIntOg5aLRwPw6Zgb8tfiYrT65AGadZgdu/ymEJkIk3W0ba+uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wcg2tMzp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9898FC4CEE2;
	Tue,  4 Feb 2025 02:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738637407;
	bh=kUuqY/yv1X4kSKFiiQviC1HLu85SHQZqXDQqudv5MZY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Wcg2tMzp9oSh/RzTn8O5VjuNpGqZRPMa6Kk1c8ourHv34ataX110uh4ou8Cgppppc
	 TRmsE28BmW3KLMyalkKRZOhzLqNUb8Les4nulr1tsB0hxZum3lnVcYps1EYgZ738Up
	 MpC277GKqlJwrmqoqKq18pVpbI/7PIe6/sKb2hCj+y8FLC2PYOCt0lGiaN77ZP1ukv
	 9Zb8T+x+ooNpqURBtYFqc4YhbLbZHsdHopsp/i3A1N6bcptD3I5l/6uHI2OJDPZRTt
	 ZCfwp3d5BfLL8+XU9yjt21itA63V0nsSENP/0XzTKGPY5PF91KnBnfS0OHqhSjLJDJ
	 RztlF9QNwlHUQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAFD7380AA67;
	Tue,  4 Feb 2025 02:50:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/4] ethtool: rss: minor fixes for recent RSS changes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173863743475.3581294.11419863244803246846.git-patchwork-notify@kernel.org>
Date: Tue, 04 Feb 2025 02:50:34 +0000
References: <20250201013040.725123-1-kuba@kernel.org>
In-Reply-To: <20250201013040.725123-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, shuah@kernel.org,
 ecree.xilinx@gmail.com, gal@nvidia.com, przemyslaw.kitszel@intel.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 31 Jan 2025 17:30:36 -0800 you wrote:
> Make sure RSS_GET messages are consistent in do and dump.
> Fix up a recently added safety check for RSS + queue offset.
> Adjust related tests so that they pass on devices which
> don't support RSS + queue offset.
> 
> Jakub Kicinski (4):
>   ethtool: rss: fix hiding unsupported fields in dumps
>   ethtool: ntuple: fix rss + ring_cookie check
>   selftests: drv-net: rss_ctx: add missing cleanup in queue reconfigure
>   selftests: drv-net: rss_ctx: don't fail reconfigure test if queue
>     offset not supported
> 
> [...]

Here is the summary with links:
  - [net,1/4] ethtool: rss: fix hiding unsupported fields in dumps
    https://git.kernel.org/netdev/net/c/244f8aa46fa9
  - [net,2/4] ethtool: ntuple: fix rss + ring_cookie check
    https://git.kernel.org/netdev/net/c/2b91cc1214b1
  - [net,3/4] selftests: drv-net: rss_ctx: add missing cleanup in queue reconfigure
    https://git.kernel.org/netdev/net/c/de379dfd9ada
  - [net,4/4] selftests: drv-net: rss_ctx: don't fail reconfigure test if queue offset not supported
    https://git.kernel.org/netdev/net/c/c3da585509ae

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



