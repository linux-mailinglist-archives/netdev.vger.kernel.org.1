Return-Path: <netdev+bounces-121049-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CAEA95B7D0
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 16:00:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10CAA1F23831
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 14:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D867517D354;
	Thu, 22 Aug 2024 14:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mkQg9FcV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B7E1DFF8
	for <netdev@vger.kernel.org>; Thu, 22 Aug 2024 14:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724335234; cv=none; b=JDLzQg8Gu4mqWbj9XihXejA/ui0P9cwRKZyBwK07r6u2yCzKkDo9jWcT2mwnoe+3vr1WB3bIr+AaQ0evaCb3DTUTn3eomecRLGMLE7zNTkQtUsap1DVE6Mf3Nv9M2ar1hcycnrgPYFURpN+ONDstiGsoM4IXR1M1ZrDmKCSG4Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724335234; c=relaxed/simple;
	bh=6L5II+KzpMaZHfyIDudIpbl4vr5cltI1mtcNf51B6xw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CJNaFR0JQ0Q0ElQdfrVtty0rhlds+IvGtrMh3aP5HfFNj5zfwQaP/JL0BsxWBW9oJ6UDEhoiztqSqI1T7uPTxDO/dVBxydEt/rZKhAZ4usq0vC4KZrb4BoODDCHbKKgAl7Jcz+4chy2JcPMx3YwyCdq7I/xItaXC+zlKalJ5Mug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mkQg9FcV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B9F8C32782;
	Thu, 22 Aug 2024 14:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724335234;
	bh=6L5II+KzpMaZHfyIDudIpbl4vr5cltI1mtcNf51B6xw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mkQg9FcVeugCrpCzqUM8WwNblnST3PVb772VIdSAbgXVEswGitBeCFaAAQeGWrJIL
	 6jix5YSawapg++HtIw8Qzb9ZQEPmGCSsKKYvaDpsmp9gJ+J6ms5czn2p+ow9o7T15c
	 kn97utv9QQ7JR8NuCSj/U3knScGdi6g372r2hinISxoS67A8UV8ZIeo2OsjVTV8IkY
	 poG5wFFmDv3btQbwVcIWRcSVRtMqtvH+dwJS0tvuHP7m8gdlRcu9IZ03pGPjRc+ggg
	 ZRA+arfYG8Cv5BhXBKNlJqvh+igToimhO0HwRDeO+gqsGcfXBKi3ZPcDZh0KNQ0pVK
	 WPBmafvwoRqUw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 712583809A80;
	Thu, 22 Aug 2024 14:00:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 0/5] MAINTAINERS: Networking updates
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172433523427.2333572.11240831029460717109.git-patchwork-notify@kernel.org>
Date: Thu, 22 Aug 2024 14:00:34 +0000
References: <20240821-net-mnt-v2-0-59a5af38e69d@kernel.org>
In-Reply-To: <20240821-net-mnt-v2-0-59a5af38e69d@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, leitao@debian.org, 3chas3@gmail.com,
 cooldavid@cooldavid.org, yyyynoom@gmail.com, richardcochran@gmail.com,
 willemdebruijn.kernel@gmail.com, linux-atm-general@lists.sourceforge.net,
 netdev@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 21 Aug 2024 09:46:43 +0100 you wrote:
> Hi,
> 
> This series includes Networking-related updates to MAINTAINERS.
> 
> * Patches 1-4 aim to assign header files with "*net*' and '*skbuff*'
>   in their name to Networking-related sections within Maintainers.
> 
> [...]

Here is the summary with links:
  - [net,v2,1/5] MAINTAINERS: Add sonet.h to ATM section of MAINTAINERS
    https://git.kernel.org/netdev/net/c/1ac66c4960e1
  - [net,v2,2/5] MAINTAINERS: Add net_tstamp.h to SOCKET TIMESTAMPING section
    https://git.kernel.org/netdev/net/c/eb208fecd77d
  - [net,v2,3/5] MAINTAINERS: Add limited globs for Networking headers
    https://git.kernel.org/netdev/net/c/8cb0a938d90b
  - [net,v2,4/5] MAINTAINERS: Add header files to NETWORKING sections
    https://git.kernel.org/netdev/net/c/f2d20c9b97f0
  - [net,v2,5/5] MAINTAINERS: Mark JME Network Driver as Odd Fixes
    https://git.kernel.org/netdev/net/c/46097a926624

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



