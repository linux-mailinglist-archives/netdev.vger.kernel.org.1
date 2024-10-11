Return-Path: <netdev+bounces-134450-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E401C9999D4
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 03:50:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98FE01F221B2
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 01:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B092AE7F;
	Fri, 11 Oct 2024 01:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K8qB55Om"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153EA28689
	for <netdev@vger.kernel.org>; Fri, 11 Oct 2024 01:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728611429; cv=none; b=tjbeTAQwP6RorrfwBWmIrLbMk0PTolnxXaYHwxOp6GMc/30zhJY1jJyYP9yvoilJs7G8EIiU/TMQ+lAwUd7Ac4ovVSEVO27FbocLyqzNsaIzdWLNdnJ5aQZeO0ZHteDWbjmQOrXke6e13gYa/26G/B8+zn6AJGa2HopHujAPh9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728611429; c=relaxed/simple;
	bh=HPSqUW43CAtemnYXK1LsHtncwzDG6LFO5TH/osm+8hU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Gn9/7msJZDcvjLLK6cjaSW6C2/+Dy6EcE9E1FiJoaNKfvimIGcoP4YcLGy5aeFLE2ued5aptRbov5oLqQBKhRmV8RX79kZR2lXTOGp4OLMN30sfWejEhS967RUNKlnpQxiR88aba821z6lOKOEozRRsnuzpX8qYnDOZHnkESmls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K8qB55Om; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88ADEC4CEC6;
	Fri, 11 Oct 2024 01:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728611428;
	bh=HPSqUW43CAtemnYXK1LsHtncwzDG6LFO5TH/osm+8hU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=K8qB55OmRF7qY4/NF8vZS4Ld76D60XMizn4Z+Rm4C9gX5nAB030fqFO9HRn30RDM2
	 A7KLe1OTmpIxHz1f9mfq15WJ1yv1y5yLVNVIo6fZJFKWZvMdCXT6Dcg4wqtPItvC9i
	 rgndZ4aHUKXfE5VtkSLiWlr8N8I/KQm+YrQHGj2OyqOWdDrjxbA1Q4fU59lwn9DrOe
	 0vq+TZymCwwzAEq9g6OQdPFLpMa/Y023uVAb4LiqsaaBxK9HjxATonnvbkhLGtLuPg
	 l56vsCDgrub/qWWu6o8Fd1qSbf4E2Y18ujiN+UeNeodhP0UCW7WUnkv3wa6cG/QTXX
	 nOYtq732wT9Yg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B8C3803263;
	Fri, 11 Oct 2024 01:50:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] r8169: remove original workaround for RTL8125 broken
 rx issue
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172861143273.2243561.13042827051042193725.git-patchwork-notify@kernel.org>
Date: Fri, 11 Oct 2024 01:50:32 +0000
References: <382d8c88-cbce-400f-ad62-fda0181c7e38@gmail.com>
In-Reply-To: <382d8c88-cbce-400f-ad62-fda0181c7e38@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: nic_swsd@realtek.com, kuba@kernel.org, davem@davemloft.net,
 pabeni@redhat.com, edumazet@google.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 9 Oct 2024 07:48:05 +0200 you wrote:
> Now that we have b9c7ac4fe22c ("r8169: disable ALDPS per default for
> RTL8125"), the first attempt to fix the issue shouldn't be needed
> any longer. So let's effectively revert 621735f59064 ("r8169: fix
> rare issue with broken rx after link-down on RTL8125") and see
> whether anybody complains.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net-next] r8169: remove original workaround for RTL8125 broken rx issue
    https://git.kernel.org/netdev/net-next/c/854d71c555df

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



