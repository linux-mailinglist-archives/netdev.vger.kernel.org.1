Return-Path: <netdev+bounces-242477-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4552EC909E5
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 03:24:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CF1A14E6719
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 02:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C989727F16C;
	Fri, 28 Nov 2025 02:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s+4gBL/L"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FBEF270EC3;
	Fri, 28 Nov 2025 02:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764296603; cv=none; b=k1W9f7KxQOr01byDbRxtAHS9fNJJ15iK+/mZXNWIpWw/DH9bCaSU9x+tIC3/MaDRSPLfkw+osHm/fVEh9DYgirW5Swcos3RIKgv3OKOIc2h8fCDa/ZVXJv5URG7O5uJy1JoenzGdtPh9cGC29OQoCXLM7lZnOivPgeN8Ozi8XcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764296603; c=relaxed/simple;
	bh=6B3CHlUuzxDtSLl651A0HLQ91JHS6EVhWQv6nD2EEy4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Dt5nvItZ8bCZS2LAkrBPdL3UmwkNMpTp/m4CufoVqVIGkUJFIHwU4RwlaUOZn+jRrDfo3T0RcSEhPHFqEqDcXgsGmTuRBz76Mkg3rh+ic+DCBBS/TJ8O7368DjGZz4ECMwQc3Wnh9xEQyOCZ2e/vTnyjBMETs5IC5a38m9QWPlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s+4gBL/L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FE9CC116B1;
	Fri, 28 Nov 2025 02:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764296603;
	bh=6B3CHlUuzxDtSLl651A0HLQ91JHS6EVhWQv6nD2EEy4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=s+4gBL/L9TMFweOEUcbHpR7Kt3DhiOcacDgNce6smnO8LT2EnFeUbSslOC/1TsTa6
	 J6VDpWQ3AGfs3DUWpyisskBXMD615FIPpe3WpLECgwly3ClQabf8oA63SFXPb3Dxd1
	 AtWu7ne4J5wZ4vnjFjQLe+JqX4YhZF7pGevWPj3I3oLyAJBtDbvY/KoQ/OPK49dX4Q
	 s4IxJwpQ9odt+a0HbzaBRwTCyUiWVovgGmG/oDtqd2DD61DX7pqB/hmRr7iTMRrhlM
	 y5hNIZnUSs2XHQ8dHr410ajAu9wSlHXr7x79v1gKkIoFVGR+4BY5tkXu4Z/gX3J5Wd
	 Fc3My/GqbJztg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B5A043808204;
	Fri, 28 Nov 2025 02:20:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/2] net: dsa: yt921x: Fix parsing MIB
 attributes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176429642552.114872.12820054287204575209.git-patchwork-notify@kernel.org>
Date: Fri, 28 Nov 2025 02:20:25 +0000
References: <20251126084024.2843851-1-mmyangfl@gmail.com>
In-Reply-To: <20251126084024.2843851-1-mmyangfl@gmail.com>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 26 Nov 2025 16:40:18 +0800 you wrote:
> v1: https://lore.kernel.org/r/20251118091237.2208994-1-mmyangfl@gmail.com
>   - reword commit message and add a fixes tag
>   - add #defines for each MIB location
> 
> David Yang (2):
>   net: dsa: yt921x: Fix parsing MIB attributes
>   net: dsa: yt921x: Use macros for MIB locations
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/2] net: dsa: yt921x: Fix parsing MIB attributes
    https://git.kernel.org/netdev/net-next/c/510026a39849
  - [net-next,v2,2/2] net: dsa: yt921x: Use macros for MIB locations
    https://git.kernel.org/netdev/net-next/c/fbce7b36c8c6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



