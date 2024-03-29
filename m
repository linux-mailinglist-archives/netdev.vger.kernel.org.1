Return-Path: <netdev+bounces-83435-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA09E892422
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 20:21:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06F411C21B21
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 19:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08DC913791E;
	Fri, 29 Mar 2024 19:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QConQ2gS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D911C130E5D
	for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 19:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711740029; cv=none; b=RmpMqlvowzA2J1FlZacSclcmr2SVZ6BUO9aLvtVLhlGJPzwf6iONP6Bjpg9Tg+w16lSpab+lBgVrYaLrP4u4/QHstP0CaDZo1EMeZI+f9DcLw8NwD3FcTFLHujKm/r7fOdtUaJWW8nPPO10ui0iHuZqLb44yR/u4xd9GDfLk1Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711740029; c=relaxed/simple;
	bh=xK9UQ4L2csXg3g0et0oQeu3yKR6g6/T8jgTOGySpvXY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=o18jyr+BLQ4ea7ESra7dSLb8ea41L8+DlW/Ob2Y3DKVAJCOcl8C+JTAkyjTdggCQLxHPammIy1TCZx87Q6yTrpohB9qb9/kLA/ehZxJnPZhsmEfuN4cpC7LNtUWTvAcfmA7czNlLMHLcmB5q957CU6CTC9Bwyk8+wFPvGSm2MTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QConQ2gS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 73A48C433F1;
	Fri, 29 Mar 2024 19:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711740029;
	bh=xK9UQ4L2csXg3g0et0oQeu3yKR6g6/T8jgTOGySpvXY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QConQ2gSe8GN/qRIHxiwM+DZ26lC6wddQYo3PV4h5eDD1rB1J4TrSG5AvAhU4uP3o
	 k+f4lqijnlkHGELPJCj82UAXR+3jKU4eiIPmL4PVXZSirN3RUPTgVP7FVeQm3epaPb
	 c6N58OpvUUUKcvF5Ndj/ruTpCRyz/1RVvC5kJKdhwqEzbxP1oldCsV3wmv7gh+3nqn
	 xWns21SkOyS8hARzR8ToiBT5fIhZHKGBCNTZFbVuMhhwrawMElR0AXf2Lg0/MvWctG
	 J0mqJ5nI/HPbGYm6uwuA2sB/YLOdD8gBRuCs/3Whtj16q3O4DgL76b4YqKK6Zz9T3Y
	 lqsS7knLVrL7w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 63DADD84BAF;
	Fri, 29 Mar 2024 19:20:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/3][pull request] Intel Wired LAN Driver Updates
 2024-03-26 (i40e)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171174002940.11543.12058564124559271129.git-patchwork-notify@kernel.org>
Date: Fri, 29 Mar 2024 19:20:29 +0000
References: <20240326162358.1224145-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20240326162358.1224145-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Tue, 26 Mar 2024 09:23:41 -0700 you wrote:
> This series contains updates to i40e driver only.
> 
> Ivan Vecera resolves an issue where descriptors could be missed when
> exiting busy poll.
> 
> Aleksandr corrects counting of MAC filters to only include new or active
> filters and resolves possible use of incorrect/stale 'vf' variable.
> 
> [...]

Here is the summary with links:
  - [net,1/3] i40e: Enforce software interrupt during busy-poll exit
    https://git.kernel.org/netdev/net/c/ea558de7238b
  - [net,2/3] i40e: fix i40e_count_filters() to count only active/new filters
    https://git.kernel.org/netdev/net/c/eb58c598ce45
  - [net,3/3] i40e: fix vf may be used uninitialized in this function warning
    https://git.kernel.org/netdev/net/c/f37c4eac99c2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



