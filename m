Return-Path: <netdev+bounces-236541-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BBFAC3DBA2
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 00:01:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 79A1A4E9E62
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 23:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56A902DEA89;
	Thu,  6 Nov 2025 23:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MZwSUl8t"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E674286D72;
	Thu,  6 Nov 2025 23:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762470034; cv=none; b=N5HSEMpgb/ua/R4w7CReYjqCZaeu+rxHbyOeYGF58c/qh2DTMGs9fJbVKptTZcY6vRPpNAf3LhLzXE52KO94xkXeWh7joITVk/QD0PtpQHptDjKruDr4FIos+2UfDlVTDIO8qE1JJDgMBChaOFgncEQweD9pw86rxXS2BRleoz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762470034; c=relaxed/simple;
	bh=1+tQLJ3YphB8P4R7BOsJAVrrIDbqc79yf2h4PmbIieU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cmF3Lj7lUIGa7X+nXtX3vEYQHtxgbndKT+Ke6DsDqLEKhoa39Wla9KqM9iunWPMxiNR52E0oxRkfGhbAfdpa31Fng8E/0NXyD9V4zw0FjtlrKL/oxsIlbPXuoZnZARcKA0QNk6yHdsHStcGh/bJ1Ry6W7HahjBErXZukOu8qEqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MZwSUl8t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF97EC4CEF7;
	Thu,  6 Nov 2025 23:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762470033;
	bh=1+tQLJ3YphB8P4R7BOsJAVrrIDbqc79yf2h4PmbIieU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MZwSUl8tN56g40r1mMbPrmpto+iN8cOEPHRNXyImr9U1OhcePTWi5YqpwT2nEGETI
	 v/GJTfYQbz4VPi4VXVp5bb2YqEKCmQbmXwviFQ8P5n8c8pGNx+gWfVSIXR4vcKiNCW
	 +zE3RoB+ORvd8sE7F+MFBJE3aSQgzESpucgdSdvpWO7fuktwtaXB6k45tsz8owJ3iV
	 En+Iq4yB1JW+VEF3V5H3o4s/dwZ3DowqB5E+BREHHI83Ot04h8+8ppQZCAUOWvYD/f
	 uwELSyjx31tvEUYhcyB3xtxdyvGqgWMknk3puX5uyIyzophlC2XCH8G421fQ16kkoy
	 cQNhUOUy2DarQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AEB6D39EF96E;
	Thu,  6 Nov 2025 23:00:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] docs: netlink: Couple of intro-specs
 documentation
 fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176247000651.381420.7628735548729402537.git-patchwork-notify@kernel.org>
Date: Thu, 06 Nov 2025 23:00:06 +0000
References: <20251105192908.686458-1-gal@nvidia.com>
In-Reply-To: <20251105192908.686458-1-gal@nvidia.com>
To: Gal Pressman <gal@nvidia.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 donald.hunter@gmail.com, horms@kernel.org, corbet@lwn.net,
 linux-doc@vger.kernel.org, cjubran@nvidia.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 5 Nov 2025 21:29:08 +0200 you wrote:
> Fix typo "handul" to "handful" and remove outdated limitation
> stating only generic netlink is supported (we have netlink-raw).
> 
> Fixes: 01e47a372268 ("docs: netlink: add a starting guide for working with specs")
> Fixes: e46dd903efe3 ("tools/net/ynl: Add support for netlink-raw families")
> Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
> Signed-off-by: Gal Pressman <gal@nvidia.com>
> 
> [...]

Here is the summary with links:
  - [net-next] docs: netlink: Couple of intro-specs documentation fixes
    https://git.kernel.org/netdev/net/c/74d4432421a3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



