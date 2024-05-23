Return-Path: <netdev+bounces-97858-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F4E38CD88F
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 18:40:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF71B28323C
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 16:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D91E1B7FD;
	Thu, 23 May 2024 16:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EYNuEVw2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D1817C8B
	for <netdev@vger.kernel.org>; Thu, 23 May 2024 16:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716482433; cv=none; b=mFwl+iTkaRtV16RsynDmzhuMuH9UZCkQvi1QBMrBs5ajusw8uA4rZnEw/24pOP2L0VClxGGXZBrvuCgDiNz8h/OkM04lQ1QG2Aa/dcFWAZAsep0k6KcbnqPByxvF1WMzUMQ/IHVKUB12RgDrKpMwdWdosSDNisbrTuszwjTt7PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716482433; c=relaxed/simple;
	bh=lP1fi0HpY05KZ3Qd4qtSbceL9YgV7m8wIxafB5Ao19E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GZLc3+xztKZN0pqkqb/cMvNrz4hEvLQJL6YlBCId+ohDaSVAvIxpWHJ0DA7gS1DPZpi8YyUkoQWHaxE7Bg9zka9tGvqcToE+SDhOBbi+HkbPc7CmQtKjvLxsGFgA3a0Wx+3JaIoOkRHsLU+ycrZe/jdi9wVYCyx1vBTRbjlgDaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EYNuEVw2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C5F76C2BD10;
	Thu, 23 May 2024 16:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716482432;
	bh=lP1fi0HpY05KZ3Qd4qtSbceL9YgV7m8wIxafB5Ao19E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EYNuEVw2AdY+ynzyHnUAUC3TENSFG2ZAjJZIELwor7Q66JZeeco22JIpTG8cOuGf1
	 mPjfRwACUzz5eiijpiYgPS4CtjRscudH94nsJvpUFbj/JC2LVPfEe9zrU5HGIo9XB4
	 2sf9AUbCtlBSduH04B8hdYM7PK4AGXyvtToIprwwyyrWfJepqgEEuFqIHbxQnM1yTP
	 yPqq1dCe0UQuxSV3R7UA/d3vNF10VrOrQWlPt0us+FytJXQ6PFruGgRe5D4mGLXHg5
	 O3qrA7AgBM5FnO0Siaq1boqyRPVskHPxoKh2PGsjKpgxktz66wqMpS2ZaYyNb2Isdn
	 xOlAc2V96maJg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AECF9C43617;
	Thu, 23 May 2024 16:40:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [iproute2 PATCH] Fix usage of poll.h header
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171648243271.722.4134780323331977659.git-patchwork-notify@kernel.org>
Date: Thu, 23 May 2024 16:40:32 +0000
References: <20240518223946.22032-1-ismael@iodev.co.uk>
In-Reply-To: <20240518223946.22032-1-ismael@iodev.co.uk>
To: Ismael Luceno <ismael@iodev.co.uk>
Cc: netdev@vger.kernel.org, stephen@networkplumber.org

Hello:

This patch was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Sun, 19 May 2024 00:39:44 +0200 you wrote:
> Change the legacy <sys/poll.h> to <poll.h> (POSIX.1-2001).
> 
> Signed-off-by: Ismael Luceno <ismael@iodev.co.uk>
> ---
>  misc/arpd.c   | 2 +-
>  misc/ifstat.c | 2 +-
>  misc/nstat.c  | 2 +-
>  misc/rtacct.c | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)

Here is the summary with links:
  - [iproute2] Fix usage of poll.h header
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=f9601b10c211

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



