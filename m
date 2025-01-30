Return-Path: <netdev+bounces-161672-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 882B8A23282
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 18:10:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BB36165189
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 17:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68FE51EEA4A;
	Thu, 30 Jan 2025 17:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YAmvJsUp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4495D2770C
	for <netdev@vger.kernel.org>; Thu, 30 Jan 2025 17:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738257011; cv=none; b=FnTdo8OZn60TK7QXtdKN4IUDrQOcogw3bCygi9jzu/zP0UxV25PVwjDf4Tl4LAATlmc+k/RoLiuaavWH++izJA2NhguS3yRgOY7ed/s12/fxICuFyTfy4L78BBDpIklJuGoobw0JxlTpenh2GtC549p22LOF+gaXxzray281zjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738257011; c=relaxed/simple;
	bh=dxy7bwTgYAfGxIMbggT4ZP/r3lVsE2vm10B5bDb0qWI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ITalUWcOHGnvBQDyR+nD7EPAyFy4hYvM1cwQTLPZYEYFK3tS118aB+QOt08ANiCIvzzWzqMb12L/oM8lRXMJzEK6gjDiHvVMkcVZ37pIF+KmZ+ZtG0pMz4NTO+VTB83tWdP2kMcwwFChRLJpE/QpmXMLKtrnNYoaaSFZJ3axqE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YAmvJsUp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3D90C4CEE2;
	Thu, 30 Jan 2025 17:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738257010;
	bh=dxy7bwTgYAfGxIMbggT4ZP/r3lVsE2vm10B5bDb0qWI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YAmvJsUp0+RTLIP9Bt6y3aPj6gxnVwY2BoFfe/+wVjBzaRWZnqY48qa0wBAn/qadr
	 OwkmgCpoOa1k2FbuNBm4t9O33Ud8In26+Z1Z7fIVnD4My4EukWZerD7r1qLxxclNeO
	 XWbVN41vFKAdvL6+YZgllnZ/+hgKwrlbu9r6e9tRd7tsAt/KKTNW3YUdSAtwyeHeQ6
	 y1Q2ijXKsgkaaS531pRXtlDLnWVQZPvub+NW4VtU3k/9iuMu5Z9AfPOsifeFSHhmRB
	 iJlIY0zhhQeIDz86g1jB+D2Boo5yaF8R2u1HqXJAl0dg7FlzXinfgiVvtrMHwZab3w
	 KZUQwQCVQJHSg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34273380AA66;
	Thu, 30 Jan 2025 17:10:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] MAINTAINERS: add Neal to TCP maintainers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173825703699.1021356.3545056072798156846.git-patchwork-notify@kernel.org>
Date: Thu, 30 Jan 2025 17:10:36 +0000
References: <20250129191332.2526140-1-kuba@kernel.org>
In-Reply-To: <20250129191332.2526140-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 ncardwell@google.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 29 Jan 2025 11:13:32 -0800 you wrote:
> Neal Cardwell has been indispensable in TCP reviews
> and investigations, especially protocol-related.
> Neal is also the author of packetdrill.
> 
> Reviewed-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net] MAINTAINERS: add Neal to TCP maintainers
    https://git.kernel.org/netdev/net/c/d7dda216ca49

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



