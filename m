Return-Path: <netdev+bounces-115059-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0503E94502F
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 18:10:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3561B1C20FFD
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 16:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 498A11B32A1;
	Thu,  1 Aug 2024 16:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J/a/eyai"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2531E1DA58
	for <netdev@vger.kernel.org>; Thu,  1 Aug 2024 16:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722528634; cv=none; b=kAEWeZfmX1vgHPAnEaIiWHbSr7BPgXdEpZh69Qup9MbC2yn1bPhaFF7YChBLupErScmb0tbBLvfm6zAoyyI33ARdWZUYE0ABPHlzDPL+1UBE2AGsZB/eM9+OnyoLl3+ctc6gBEJkQ7yG+0Z8hC/KrGJiuVespS/SKuTk04Y2pAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722528634; c=relaxed/simple;
	bh=Y/sX/zmxHktBzaB8TR4dfCBPILI+Hm2uTCGfKYEj9tg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iiV0sScsIc5oyMj7mnntECWLvWY/DFSRe1tUz7E0p2un7LgC95JOwtIShCz6Cms3Z6ZzhQfLYC6obOIzNzq37SA1ifiNwEdMwol5d4ddz85yBWPj/oEWiD2vH/Y3zajlxcxPN56SJqw1li6LBEbV9SI5LKr871CqSRAZBg2Brr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J/a/eyai; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BD509C32786;
	Thu,  1 Aug 2024 16:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722528633;
	bh=Y/sX/zmxHktBzaB8TR4dfCBPILI+Hm2uTCGfKYEj9tg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=J/a/eyaiBlHOvuDBHSnC07I5a9GRiPL5kJKoyvA5VJEA4Xqm8/6VSUQhfIkdLpXZH
	 H/mvYTmc2QXDsmFIOcoDw8adXIFzqFYrzUcR3/wPluAJM8NZ2KbFjw7ytA84kdE8H0
	 FIjvafFcMP4/z+ls19VTqvO4TOfcZSXWKWolshgEU6F9lIlKs1y2w2AqTgUtciSkIS
	 4Bn7KfwVq+PlE41IkacW2T9rGtNHrHpHs1LmDemLOKkp+N1TH/aEz0gmfh+bsdwhUv
	 +doRwGbnCw2rEx36zzNovThjrgkpujkM37++OwVcopkCw0SKMMAB90/L/ckUlbiQI3
	 S/LiQtkbx3how==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A9661E8877B;
	Thu,  1 Aug 2024 16:10:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] ethtool: Don't check for NULL info in
 prepare_data callbacks
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172252863368.25785.6413993867614133011.git-patchwork-notify@kernel.org>
Date: Thu, 01 Aug 2024 16:10:33 +0000
References: <20240731-prepare_data-null-check-v1-1-627f2320678f@kernel.org>
In-Reply-To: <20240731-prepare_data-null-check-v1-1-627f2320678f@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, maxime.chevallier@bootlin.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 31 Jul 2024 10:15:28 +0100 you wrote:
> Since commit f946270d05c2 ("ethtool: netlink: always pass genl_info to
> .prepare_data") the info argument of prepare_data callbacks is never
> NULL. Remove checks present in callback implementations.
> 
> Link: https://lore.kernel.org/netdev/20240703121237.3f8b9125@kernel.org/
> Signed-off-by: Simon Horman <horms@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net-next] ethtool: Don't check for NULL info in prepare_data callbacks
    https://git.kernel.org/netdev/net-next/c/743ff02152bc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



