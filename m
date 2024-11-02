Return-Path: <netdev+bounces-141149-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFC9B9B9C51
	for <lists+netdev@lfdr.de>; Sat,  2 Nov 2024 03:20:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 942A72818D3
	for <lists+netdev@lfdr.de>; Sat,  2 Nov 2024 02:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A38FF84D3E;
	Sat,  2 Nov 2024 02:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pbn5BRVU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71625249F9;
	Sat,  2 Nov 2024 02:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730514021; cv=none; b=Ng9qDTDFAZL/O+0aVDML7pStvlGdAOIQQFnall1TyIFVmy7hMFESjS2DIAdsQR4hv83zFiiTnN+BiIiD/Emty0Ae8C7V3kmNuWnI70FBuq01fnB8dQSzphZu98kQ5BLLbbQnE+oZmpB+Oh0vbqfzRIc0Bqne0XYBKiGC+yQ4TKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730514021; c=relaxed/simple;
	bh=UJhc1BEfXPgr74QkV2GxYzBCuO9egGha+1beHL+B8Xg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=U9P3+7Ik5MLyxeAgfU/m+DeZSHtqpTnUQf5RhWYzrrgVkEbJkXvMcqEXdBwlwYoW6MA32WqKt6My5lE4bvMFAJ0FVPzxpJSoHmajkCjFTewlXXQpvsv5OLGpiG17IBvZUhHr9qLz/S2m3FqEJChyz3VYiblay2InEl+ZpgVzJSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pbn5BRVU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FFF2C4CECD;
	Sat,  2 Nov 2024 02:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730514021;
	bh=UJhc1BEfXPgr74QkV2GxYzBCuO9egGha+1beHL+B8Xg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pbn5BRVUmvazhkNzSVfqivJI9waT3vL5iMAT/ZoJTlfrjXDu1HeQoWJwrdgqOJAmX
	 Wyyi+ucm5PpYidq9h7OaxDq6A7HLRsCins5rys2T7KrZ+5qN0c0YSEGqdjwspieoPG
	 18/VKwU43RxhCuKK+VBRQ4c3eBWjqu+8WkUiP7yak8OcEvPx4P+42wBeUR0DPJRa14
	 rt8lYtG0b3vbkl+bR0b4Yqa1BrKUdwJYPWS7+xqCC1NdGyVZhLyixSKcrWuJh717T6
	 YVqO57K5W7NgDIGwdCz57N/72XXttzuDt5pELeaXG+YpSkPSQc6Y7QFhGMzcZsopo1
	 iK2qRwEmcbn4g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C6F3AB8A90;
	Sat,  2 Nov 2024 02:20:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] dt-bindings: net: xlnx,axi-ethernet: Correct phy-mode
 property value
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173051402925.2895750.10291096132066734100.git-patchwork-notify@kernel.org>
Date: Sat, 02 Nov 2024 02:20:29 +0000
References: <20241028091214.2078726-1-suraj.gupta2@amd.com>
In-Reply-To: <20241028091214.2078726-1-suraj.gupta2@amd.com>
To: Suraj Gupta <suraj.gupta2@amd.com>
Cc: radhey.shyam.pandey@amd.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, git@amd.com,
 harini.katakam@amd.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 28 Oct 2024 14:42:14 +0530 you wrote:
> Correct phy-mode property value to 1000base-x.
> 
> Fixes: cbb1ca6d5f9a ("dt-bindings: net: xlnx,axi-ethernet: convert bindings document to yaml")
> Signed-off-by: Suraj Gupta <suraj.gupta2@amd.com>
> ---
>  Documentation/devicetree/bindings/net/xlnx,axi-ethernet.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [net] dt-bindings: net: xlnx,axi-ethernet: Correct phy-mode property value
    https://git.kernel.org/netdev/net/c/b2183187c5fd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



