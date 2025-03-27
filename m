Return-Path: <netdev+bounces-177908-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 08675A72DAA
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 11:23:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D40857A24CD
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 10:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAA1A20E317;
	Thu, 27 Mar 2025 10:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SWgaPvOS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1ADB12CDA5;
	Thu, 27 Mar 2025 10:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743070978; cv=none; b=P/JLC/lAT0SvAzUmgAcP9eCXYaAxaGRUQoqrE7gFxCeU35eXg/s77E9L5pDJQO80LT9Cy4ppIgW7nI7dASLwofw+dN0IwCJvuOq7JBzrVAstfy9Cd7PC1Rj7MuO8SZZ2mn2LX49XPiWF5LfzKY4Fv9AwJwIFjd45BaKMc45L0t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743070978; c=relaxed/simple;
	bh=onC2cPkoWuivMWkwbIejecRWNWFMPpdPB4L097wT13E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UT5v7FOFctx3ASUGVLABYkOJfOt0MgCkAYGUouPFSuLd5KDy3E+RNi5XOO1DpO6isrNwQWPqmrr/SamTW7w5c+kY9Y4Qeu0zvLcFFK/YMDg1ivbJ4Y6Es8LjZe3IXB3hQ0rPgVbXuk5p9X++gjuirLymN62zC2BnGierEmKnRWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SWgaPvOS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30405C4CEDD;
	Thu, 27 Mar 2025 10:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743070978;
	bh=onC2cPkoWuivMWkwbIejecRWNWFMPpdPB4L097wT13E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SWgaPvOSxlwbSGAUb8pz1AnUlfyX0Asp09RR4CK4p84O0IFk2U1SKz9B6su0/DTVb
	 kO5sjUjXVDSyqkAymacDuuOBVVEoRX677/oWkUxnICnFt3OPRzfY/jBfTzNGyGRGsE
	 lxvZ2JKpCDQpz7MqOYhfY3Kg79qzlwT7XojeCzAywzmh+yMMNcux3ZqDHSWDGXS4hI
	 Dl8mBUcV6LA934wMqqHnoUdWZeiUjUjcQAgjGDQ22WchkT+bjc35TmUS98jmPXGekP
	 HAG0q7NnrvdB6nKePeEFnNYOAisNL0BLdeIH+pTx8O3dULU+l/WggiwkAIqLzc/HC6
	 2AIb6ag490XXQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE78D380AAFD;
	Thu, 27 Mar 2025 10:23:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] Networking for v6.15
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174307101429.1989557.18259424854785309630.git-patchwork-notify@kernel.org>
Date: Thu, 27 Mar 2025 10:23:34 +0000
References: <20250326163652.2730264-1-kuba@kernel.org>
In-Reply-To: <20250326163652.2730264-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: torvalds@linux-foundation.org, davem@davemloft.net,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com

Hello:

This pull request was applied to netdev/net.git (main)
by Linus Torvalds <torvalds@linux-foundation.org>:

On Wed, 26 Mar 2025 09:36:51 -0700 you wrote:
> Hi Linus!
> 
> A bit late this time, due to badly timed vacations and unmovable
> "work work". You will see at least 3 conflicts pulling this:
> 
> fs/eventpoll.c
>  https://lore.kernel.org/all/20250228132953.78a2b788@canb.auug.org.au/
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] Networking for v6.15
    https://git.kernel.org/netdev/net/c/1a9239bb4253

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



