Return-Path: <netdev+bounces-205643-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 201C2AFF75D
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 05:19:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E0BA4A78D2
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 03:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B4CC280037;
	Thu, 10 Jul 2025 03:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OslSLc+W"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654F62AD0F
	for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 03:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752117588; cv=none; b=sqn049Az51KdTV//RKeAGW3lBk8HBsbAky3cuTC34wElj1lhlwqwEQT9hq1HcI0H6GwwCgvvVxGc2SX+MPLtt8TgeZdFdm7pakPv/jLtGZxVPdgPYDLhW4w07MB7OatnmicRLuA0amMIg8YRlRNC5Bk1WMng7NPqVllGJ0XHldE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752117588; c=relaxed/simple;
	bh=7l7QuvV5xdBQYnc/kAJi1S1wWCC3UpOcinS0YwXa7ds=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OMWg0aZ5LqxP2W/k5lub6FQncRg6IEmR9dQEodp8GdHtUmBLKaC4ceNKY1vdAj6ZaqB2BTg5Gk2G6Zt8S0oPLR93yEjoZDRr+T6+URI/lpts9ActQ7BWuzGN+2aqTbRLGn1hUKQe82Ja5nYCzTBIx2B18/yX8RY2S/rCO82P86U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OslSLc+W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D02E2C4CEEF;
	Thu, 10 Jul 2025 03:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752117587;
	bh=7l7QuvV5xdBQYnc/kAJi1S1wWCC3UpOcinS0YwXa7ds=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OslSLc+WKbYO1+lA/N+KqYTk9O7d15u51CVgVK1FRChRVaytM6FTg92mpSdIyApRn
	 oOuF9Fh8CBfL+tzOF3GkNLIbhrW6y9LLbEEFBU9FzuWIhuo2nlTiTRXJh3UOaNm1Fq
	 nmJsL5EefL+9PvriMOIvwpyBGmkGCQHgjdQe+MFqb5C5GBrVFg3qcFdpa2wXnM+Jtw
	 ff1Gey9FT0VCH5J6EZo9e5+lgnLaZaSHsS8cu62HtX8CNQdWHIcVLJpGsLDCjVBHBS
	 /L+8Q5swLywcyaUKWwN17Y9whGKd5DpEjU3Lf+tttKoHEFbP8/zHLiOTb6RRG81YQQ
	 POok5UpZSbr5Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C6B383B261;
	Thu, 10 Jul 2025 03:20:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next v2] MAINTAINERS: remove myself as netronome maintainer
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175211761029.973534.12736882115115374721.git-patchwork-notify@kernel.org>
Date: Thu, 10 Jul 2025 03:20:10 +0000
References: <20250708082051.40535-1-louis.peens@corigine.com>
In-Reply-To: <20250708082051.40535-1-louis.peens@corigine.com>
To: Louis Peens <louis.peens@corigine.com>
Cc: davem@davemloft.net, kuba@kernel.org, horms@kernel.org,
 netdev@vger.kernel.org, oss-drivers@corigine.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  8 Jul 2025 10:20:51 +0200 you wrote:
> I am moving on from Corigine to different things, for the moment
> slightly removed from kernel development. Right now there is nobody I
> can in good conscience recommend to take over the maintainer role, but
> there are still people available for review, so put the driver state to
> 'Odd Fixes'.
> 
> Additionally add Simon Horman as reviewer - thanks Simon.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] MAINTAINERS: remove myself as netronome maintainer
    https://git.kernel.org/netdev/net/c/ee48b0abeca9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



