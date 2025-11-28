Return-Path: <netdev+bounces-242475-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 42DB8C909DF
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 03:23:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D760A4E5ACD
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 02:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01C6C27603C;
	Fri, 28 Nov 2025 02:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jaGJmJo8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23C6274B23
	for <netdev@vger.kernel.org>; Fri, 28 Nov 2025 02:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764296600; cv=none; b=Qx5w/1vvQl0+d09NFvKqy4chuOfXhc1V54PjN0h8TB906wwmJFpP7jRqjaBDvh6DiJDtBxE0+fQobrmIh2gWyhlbBifNKLE7tW2E4CK8RGqFFY0ca9sfwlcLWRZZN+7cAW5beiZGOGIlYVZpTj0eEHUTMg+F0XAxwkKDaPRZTo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764296600; c=relaxed/simple;
	bh=Y7Rj9wtd8sWCJzqqduCe2z9K5wHuTRLeIvZF3iJn/S4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TISyPxkz9buRZO2toAdUoFA633imBrugg4GyTJw/cOwsBPukrfzV2R0UnTOcVbCssa4iTOwwMXJQoq/6gpaUK84MjB9d2BEUVi+BD2VZmgWtfMJizaTEyNh7eBLinRE945IOQe/YdGaLkIdAfpRFDmvKes3NH4JNu6IkjlVxuek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jaGJmJo8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72FB2C4CEF8;
	Fri, 28 Nov 2025 02:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764296600;
	bh=Y7Rj9wtd8sWCJzqqduCe2z9K5wHuTRLeIvZF3iJn/S4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jaGJmJo8aLCFqLwjX/dHzKWEFErtFT/jnhcnEc10f8LrmAyVYfTQbtMUb0mNMr7KV
	 2XnZiRtVw5XTxWET/UXBQXGzVrrcl0pSqrpIgWUa8CUYzeDlGIFm28PR/WH+2sjMoy
	 RPwNQn3gyDRPxRrA6vxlOP6mMkgEVIwry96+oD4lKN6SqNljcn7HHjPn0vH5BUxq2J
	 /xGlMa7LnEO/+sHYyOHobkStGivaEWvPkjPzKXHObnL3ma3iqJj2EhtfNP4/MaufVW
	 cyv/mTlsZiX6DAskhWavJvQEthbdSAdBURMjWB1WKO2ctzBTi/aAbIqN4sFM6c3Nhr
	 8cjvVdU4yuRVg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F266A3808204;
	Fri, 28 Nov 2025 02:20:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: restore napi_consume_skb()'s NULL-handling
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176429642288.114872.14274888016390810107.git-patchwork-notify@kernel.org>
Date: Fri, 28 Nov 2025 02:20:22 +0000
References: <20251127014311.2145827-1-kuba@kernel.org>
In-Reply-To: <20251127014311.2145827-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 26 Nov 2025 17:43:11 -0800 you wrote:
> Commit e20dfbad8aab ("net: fix napi_consume_skb() with alien skbs")
> added a skb->cpu check to napi_consume_skb(), before the point where
> napi_consume_skb() validated skb is not NULL.
> 
> Add an explicit check to the early exit condition.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net-next] net: restore napi_consume_skb()'s NULL-handling
    https://git.kernel.org/netdev/net-next/c/4c03592689bc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



