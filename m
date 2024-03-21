Return-Path: <netdev+bounces-80938-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83433881BFB
	for <lists+netdev@lfdr.de>; Thu, 21 Mar 2024 05:40:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37E9C1F22541
	for <lists+netdev@lfdr.de>; Thu, 21 Mar 2024 04:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AD5D1BDF4;
	Thu, 21 Mar 2024 04:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kh2h7OyI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E411170B;
	Thu, 21 Mar 2024 04:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710996028; cv=none; b=fu/lmQ+4V/6y/r6msaaRFFUKdQcMDR6g9u2PJZG5MvkD203d2PvlWAJ0BDx2FBPAbP5TpgSwNeQWpt+l8HtOyQJBw1ah/x+ud1EK2mvVTDRQtO9b0I1HceviT9dkzMEUHj32ILiF/+bdB6zLbbWUUpwel1POqve6wJLStWyn4rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710996028; c=relaxed/simple;
	bh=uA9xvKenq6yzo4uiIv9CvYKDW+9ns9ESg8gM94/FWnQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EXvwCMjrE5VYxahi0tu4ItcZ520R9Z7smurynji3OnjhRaBxuAvPwUmK2UOP8nl6TCBtjcODW1fIG91qID1x1pyVDseBYOf6lZnTQyZGhcnl2Z18DkJ1h2BmxiKOPBUG+SD2MzBmXQ8GmIhNigneJAoh3V24ZDBs7QfD9NXTLNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kh2h7OyI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 159B6C43390;
	Thu, 21 Mar 2024 04:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710996028;
	bh=uA9xvKenq6yzo4uiIv9CvYKDW+9ns9ESg8gM94/FWnQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kh2h7OyIodoxf8k66YguqbUr1lpsUxqidO7QB3LDXnWBH3bcQt6PWMtmlsqaRPIXl
	 +vQW2lX/KgLyhS/ARALe8hb8cF7IQV7d78zUAGZ8UTEulPWgx7yqL81wMOMtCfmHZM
	 60skzxE6YCub9ww/ZnW5jVtl7MuSSxEJEZfHWUKXm4coVKGJjTDuPHBY226mROyNCz
	 Azz6TKE3jZBE/QVPyUkVyfXobBIdYfaz6ma/o+BUoqi3G0xZ4DrZVW1wQpQ2h61C2N
	 UAjPFBlwD2XhoJ9G6fp3Sk0Ag5lQJ7TlHLeTelgTGWahreUEpdKFLR5PGwmDPm8qFm
	 W6YufAou9QsUw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F0AECD982FC;
	Thu, 21 Mar 2024 04:40:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net] ionic: update documentation for XDP support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171099602798.26207.6141228760505625495.git-patchwork-notify@kernel.org>
Date: Thu, 21 Mar 2024 04:40:27 +0000
References: <20240319163534.38796-1-shannon.nelson@amd.com>
In-Reply-To: <20240319163534.38796-1-shannon.nelson@amd.com>
To: Shannon Nelson <shannon.nelson@amd.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, corbet@lwn.net, bagasdotme@gmail.com,
 linux-doc@vger.kernel.org, brett.creeley@amd.com, drivers@pensando.io

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 19 Mar 2024 09:35:34 -0700 you wrote:
> Add information to our documentation for the XDP features
> and related ethtool stats.
> 
> While we're here, we also add the missing timestamp stats.
> 
> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
> 
> [...]

Here is the summary with links:
  - [v2,net] ionic: update documentation for XDP support
    https://git.kernel.org/netdev/net/c/f7bf0ec1e73d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



