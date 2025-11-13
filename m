Return-Path: <netdev+bounces-238415-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 128B1C5876B
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 16:45:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E12C634E109
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 15:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E88A2EC547;
	Thu, 13 Nov 2025 15:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ve9ULBAW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D472EC096
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 15:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763047840; cv=none; b=lVHbeOFzmiMQaK5U+NtKl05GT5XyyTg6Ey6BM2YUeEVWRXTqKKpZTUAdinV+yPjqweM6UkBl6EbbPwF/CS1WmaebHLhaF3yOUprhASJFCBe++g2b2nsQyHgC5LvpaqpEuPndy4Olm670sR7CGC1Yt7SPAnsMRB1Hz9X1DMueLNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763047840; c=relaxed/simple;
	bh=OhxaJq+CSaZtOEF9X/5SZSp4GJ9cxUnYJtT36FYVKX8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Qf2zU57JW/wnZBZHue3YGoXYYnAGbRS3haigWqLagnVor/+UTSaLS8ZfVN2v1VTL8F2zuSDPbTKBvSuPXRiDhUovjlhXGM8rvFinvVb/+2BAZy4lg8w20AjxjndVDfjJOR4GoIwuglZIZ6ElwixXCZEh0wtsSbxnyheSLXc4L7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ve9ULBAW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8D17C19424;
	Thu, 13 Nov 2025 15:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763047839;
	bh=OhxaJq+CSaZtOEF9X/5SZSp4GJ9cxUnYJtT36FYVKX8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ve9ULBAWRMkewjx06n5Xg90EPCMWOcAE0Uea9dnoOOvYeqO/WJPnFMnclFa/FTXSd
	 PPoyg4eMXmkbb+nkUp/r4fhKwiKb1hrHtXALymIfvclx3gvVv8/NaBQVUcDqzjwFhD
	 QvJqmRh4OPXkcdaNAR0u5ctxe1GOXTOwvxmxTX7D9cWHLbt9buyTmqjE/sIlQZD3DH
	 9XNBNB4wb7sAupXAkEan+CTm5vw3xhPa7Av0W+lmlnn5u5fRdnB/uXwgXmaDR1mwwA
	 4UiHUHQB11CEHQWpLN0E2pY0UVqOFAy9tbzlnAFXRYJeOCLaHa9tYhfkSCP+7rkFax
	 fW+S5JvmbXp2Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E753A54999;
	Thu, 13 Nov 2025 15:30:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/2] hsr: Send correct HSRv0 supervision frames
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176304780900.895229.13812119920616223673.git-patchwork-notify@kernel.org>
Date: Thu, 13 Nov 2025 15:30:09 +0000
References: <cover.1762876095.git.fmaurer@redhat.com>
In-Reply-To: <cover.1762876095.git.fmaurer@redhat.com>
To: Felix Maurer <fmaurer@redhat.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, liuhangbin@gmail.com,
 m-karicheri2@ti.com, arvid.brodin@alten.se, bigeasy@linutronix.de

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 11 Nov 2025 17:29:31 +0100 you wrote:
> Hangbin recently reported that the hsr selftests were failing and noted
> that the entries in the node table were not merged, i.e., had
> 00:00:00:00:00:00 as MacAddressB forever [1].
> 
> This failure only occured with HSRv0 because it was not sending
> supervision frames anymore. While debugging this I found that we were
> not really following the HSRv0 standard for the supervision frames we
> sent, so I additionally made a few changes to get closer to the standard
> and restore a more correct behavior we had a while ago.
> 
> [...]

Here is the summary with links:
  - [net,1/2] hsr: Fix supervision frame sending on HSRv0
    https://git.kernel.org/netdev/net/c/96a3a03abf3d
  - [net,2/2] hsr: Follow standard for HSRv0 supervision frames
    https://git.kernel.org/netdev/net/c/b2c26c82f7a9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



