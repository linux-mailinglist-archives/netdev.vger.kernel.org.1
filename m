Return-Path: <netdev+bounces-168727-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDFFBA40467
	for <lists+netdev@lfdr.de>; Sat, 22 Feb 2025 01:50:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA3D3703A79
	for <lists+netdev@lfdr.de>; Sat, 22 Feb 2025 00:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFF44481C4;
	Sat, 22 Feb 2025 00:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q2xvk7nW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961962B2CF;
	Sat, 22 Feb 2025 00:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740185405; cv=none; b=kCzwBQdghJItUI23yeIAJpqRa00hL4Ki2U0wDT17tK5pawBbspK+NC3aC0CmcniESgI4G9uouiEsoS01PrWiYhqDf3dZg4Au6BQxjkXlcQwMQgYOryp4fhD5FKl1nk8QtFZ0M5hrdXFUAeji5tp7x8UD6EkgupTNTyTAx6Nqpis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740185405; c=relaxed/simple;
	bh=baXcTKjEO7sKNWcG1Zsism7vfRhxCCduimn3iJvzLC8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cuPNjqvtAH2MxQLay+9l6X/ZA0A6xnOdfsRXUSKaVeCGCGIDaOaeD07/jKC89msI2EJe/KwFYf6++5fcPeuPvVo53LC7CDmE8E7x2Gaw7IwjHllEm/IHyw2k17IjqlZ0uIJb0zg2iNnN4jNupf7bHhlyajgL2x70PfqjnPRrQDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q2xvk7nW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07EC5C4CED6;
	Sat, 22 Feb 2025 00:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740185405;
	bh=baXcTKjEO7sKNWcG1Zsism7vfRhxCCduimn3iJvzLC8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=q2xvk7nWGfNHZwrxLgcEHDo2tvfhYDyCbn2Pz9wf/hye3OYCq6r9SZLXh/G0YNLUK
	 MIH6KBuiaXmyXan6p6YNkulQ9O2BNy/t2pny7pTxkXB6qDBSAZWfVK/ZNUejCy19Lj
	 dz4C6VCpIaM3YG2csNVHTaCQshXenx/xP0tl3aiFOFau1ZgoLG2wSiRJi9tfaN7ijG
	 oy4MEywfd+6dX9OohmPfapLOiT2zRR52968eyLZVwQfkiMWlpdRqKdEJukHeaFF9ru
	 P6w+gNmojOkMKKCUobHjjIWkYEzEmg71ictdAarORkqgpIjBTgbmM5nKZ8FBnTm6lX
	 k12P+tzbSJBTw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33F76380CEF6;
	Sat, 22 Feb 2025 00:50:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: cadence: macb: Implement BQL
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174018543574.2255625.12227184252402684174.git-patchwork-notify@kernel.org>
Date: Sat, 22 Feb 2025 00:50:35 +0000
References: <20250220164257.96859-1-sean.anderson@linux.dev>
In-Reply-To: <20250220164257.96859-1-sean.anderson@linux.dev>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: nicolas.ferre@microchip.com, claudiu.beznea@tuxon.dev,
 netdev@vger.kernel.org, edumazet@google.com, kuba@kernel.org,
 andrew+netdev@lunn.ch, linux-kernel@vger.kernel.org, davem@davemloft.net,
 pabeni@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 20 Feb 2025 11:42:57 -0500 you wrote:
> Implement byte queue limits to allow queuing disciplines to account for
> packets enqueued in the ring buffer but not yet transmitted. There are a
> separate set of transmit functions for AT91 that I haven't touched since
> I don't have hardware to test on.
> 
> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: cadence: macb: Implement BQL
    https://git.kernel.org/netdev/net-next/c/e6a532185daa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



