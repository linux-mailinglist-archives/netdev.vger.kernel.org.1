Return-Path: <netdev+bounces-168726-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B179A40466
	for <lists+netdev@lfdr.de>; Sat, 22 Feb 2025 01:50:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8E457AD791
	for <lists+netdev@lfdr.de>; Sat, 22 Feb 2025 00:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1495F139CE3;
	Sat, 22 Feb 2025 00:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XiGsZULh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39B7139566
	for <netdev@vger.kernel.org>; Sat, 22 Feb 2025 00:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740185402; cv=none; b=pei8hl2lDzJFUAq78kJ50JRhQeX3neiO7yibMW4LTlTB/puM/mWdzyZlPZhMWre8YF+gOiNaRZSGrOxqhq9bEep9rVgV03OF6CGUxAE9uK962HRgOnAt6UfzMbRqVN3wQ8aA4OMVVKIzAprO0NSH7S2KW52e/nqQYHDOoDNXCJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740185402; c=relaxed/simple;
	bh=+ibkjtAYWHmYoHHUy70CHXn4SHDxaeEQGEC2ik1z2z4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Mata/2rXiWu10o70q/bMPLcnH0CaZ4eprHvTaa0JJTGTZ6Hw9UKnKc6qTw4P+BRBdv3PtnzcWTftJBm9JK1mDwZfB4g/agButAWP4GL4aU/RgVk+0mLkgJvvOx313NcdYTqsY52iaG+ugtl1TKGZ7TJEh2zCUTwf9MQ3uAbobuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XiGsZULh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4A82C4CED6;
	Sat, 22 Feb 2025 00:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740185401;
	bh=+ibkjtAYWHmYoHHUy70CHXn4SHDxaeEQGEC2ik1z2z4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XiGsZULh96czmYGepHJOIsF40VjiNPJoZkn3xGwhkuqj9n2++0hilS/PO3ZFRoZmG
	 jzvtdNc7WmfWQne+NRtCBnMH1m8NEZUqPVgLe51Ze92x6K2fdX7S0Z/+8a0xL+WlYJ
	 nWzzkBdD/7jewI0s44iI6AhTlY4Qs5cJALuGWcUc/d5Bdn2SwYwP5SxCl9GLxnpRXm
	 p2Dekey0qSiNwclliQVzUruE07R28AE9PzVw3GTy4mof9hfDPgRAnJlzIBxrH5ridk
	 zcMdzCeh9NbfTrtam9vpbHQG87R9WiRJ0OOJTAdsja9MbPA82UNrdfs69PZAw/sQy8
	 ioASjyF6NWJDw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD27380CEF6;
	Sat, 22 Feb 2025 00:50:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] MAINTAINERS: fix DWMAC S32 entry
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174018543249.2255625.2274774190416939347.git-patchwork-notify@kernel.org>
Date: Sat, 22 Feb 2025 00:50:32 +0000
References: <20250221005012.1051897-1-kuba@kernel.org>
In-Reply-To: <20250221005012.1051897-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 linux@armlinux.org.uk

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 20 Feb 2025 16:50:12 -0800 you wrote:
> Using L: with more than a bare email address causes getmaintainer.pl
> to be unable to parse the entry. Fix this by doing as other entries
> that use this email address and convert it to an R: entry.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> Commit message stolen from Russell:
> https://lore.kernel.org/E1tkJow-004Nfn-Cs@rmk-PC.armlinux.org.uk
> 
> [...]

Here is the summary with links:
  - [v2] MAINTAINERS: fix DWMAC S32 entry
    https://git.kernel.org/netdev/net/c/28b04731a38c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



