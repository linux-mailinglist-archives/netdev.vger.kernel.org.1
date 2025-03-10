Return-Path: <netdev+bounces-173648-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB33A5A51D
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 21:40:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1BCE172CF8
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 20:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC211DEFD4;
	Mon, 10 Mar 2025 20:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NUsShNgK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161DD1DED5B
	for <netdev@vger.kernel.org>; Mon, 10 Mar 2025 20:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741639207; cv=none; b=imMnSk/sUZ389A/sZbmDW5W0rEs91pxYNFIBcv0FAcw5rdiE6D/z0wmQ6WSLPnJJIVOdQADcXv6GjUmeDG6fV/GBwoQycLohnCz6huvq33t3olrQDPKmp8Zhip85q3YTSBRZhIUIbrlZ5WdDKqPgMJk6YSdH03KK5tNBYQSGUSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741639207; c=relaxed/simple;
	bh=p2nNgXkTjZEP7gHWVOXVNXl6GCe5Ko9k+Q0IoK0n7GI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CpfW+yEoARxc2uRdHabY+b5Qo4KGbWSQVanFBUcyWTvMi61ATi763xMTR9MDnPeHRnDaRunG3/KmPrcpYFDqzidjXP2ml4EKVQe54l55tU5dqqnzmluAYe8HYdXbmKF9v1NEIk1yecZeMsTqMryw93E5wNWvemsjk9biPs66gz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NUsShNgK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5DD9C4CEED;
	Mon, 10 Mar 2025 20:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741639206;
	bh=p2nNgXkTjZEP7gHWVOXVNXl6GCe5Ko9k+Q0IoK0n7GI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NUsShNgKBsEZyV09MOV9uLe17hHLQKyd7/u8+q8mfymD6mQ/KDM7RwfK7fxAFVZv1
	 zWpCG9sE6kniAOsY9p+mCtmP5c5Xw161c0Abqix4MbGT2ZUoJGAtMMdwpCB7Jk7KB8
	 KNQKsbqmNZhhRX5Lauk6RFNAk/4clRI7kCvcPDw460YHwpOrhejPmsn4ts2AaQ3IkA
	 cYzCMvwI4XbivrHH1oPCWRXzrXpLtet8w8UDFEm4q+ghsljAE3ZDT/jP45kJin/JMK
	 FooY4R8Hdhm3GfnAoqJfE2d7AlWf1cqVInv4dn6Nm2uSC6e++1pBeqm5JiTcJz7QTJ
	 c2+/b/sVlm0Fw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33EFE380AACB;
	Mon, 10 Mar 2025 20:40:42 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] r8169: increase max jumbo packet size on
 RTL8125/RTL8126
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174163924073.3688527.1735076938830596564.git-patchwork-notify@kernel.org>
Date: Mon, 10 Mar 2025 20:40:40 +0000
References: <396762ad-cc65-4e60-b01e-8847db89e98b@gmail.com>
In-Reply-To: <396762ad-cc65-4e60-b01e-8847db89e98b@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: nic_swsd@realtek.com, andrew+netdev@lunn.ch, pabeni@redhat.com,
 kuba@kernel.org, davem@davemloft.net, edumazet@google.com, horms@kernel.org,
 netdev@vger.kernel.org, rsalvaterra@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 7 Mar 2025 08:29:47 +0100 you wrote:
> Realtek confirmed that all RTL8125/RTL8126 chip versions support up to
> 16K jumbo packets. Reflect this in the driver.
> 
> Tested by Rui on RTL8125B with 12K jumbo packets.
> 
> Suggested-by: Rui Salvaterra <rsalvaterra@gmail.com>
> Tested-by: Rui Salvaterra <rsalvaterra@gmail.com>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net-next] r8169: increase max jumbo packet size on RTL8125/RTL8126
    https://git.kernel.org/netdev/net-next/c/473367a5ffe1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



