Return-Path: <netdev+bounces-232298-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFBEDC03F55
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 02:30:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6ABEF3B6F58
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 00:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27BF118DF9D;
	Fri, 24 Oct 2025 00:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p4OmMeXe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042E918A6A7
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 00:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761265829; cv=none; b=GTR+jBi3NXmww0oYjGZQ146EqdNJBRG3cHWobhWIPKlk0DFeSjTZTQJHji20F3r2RV4pfGIN01PQbNXcMcecw/UQrTfCuONtKvbmYiy6b+XFPNBfmlhUNCsHQ5PhDAvlUrbxAo/x7tO3GCvpwWlDj2AqVYE1kI9264QkzL1+VRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761265829; c=relaxed/simple;
	bh=IL31NnCzzZqbqIiX9Q/5Q5IvEscFeF0zSTzAPWrAkA4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=E3W6qur9PBx8WsK1JKeuVKtdkX7gD/MroCM90FJoXFAyLK2XHP+HjqTucFGJqfWn2OGfk3PhcM3+rC0c9fTLDfgriJv35kgHtRuVw3Wwrd+cLnaZPm++h5HPGqYfIS1925BZKHpLA15kITvxZQe0SDw8l/H989OQKENKv1lTrRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p4OmMeXe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C8CEC113D0;
	Fri, 24 Oct 2025 00:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761265828;
	bh=IL31NnCzzZqbqIiX9Q/5Q5IvEscFeF0zSTzAPWrAkA4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=p4OmMeXe56DC/0+vH2lbnoyXGuDofoHurZZoIgf0s/Jsu3W4uETm2rJrKloVn4Pxd
	 PSjC65v7FTVV4Mw0/quY2zU1pHtMHFR8vOu7arygz9NxZnheKHGAkXiVRkBYW2NHKm
	 HAYxrvi98fw9R8jDaXVepCUjbz78uNKcDXn6MhHSdQRvrPN5bxpE+oF4tMz5jlFPaE
	 wJCnt+2v7h90/AyDIKke4D8wH+NboQrnQ/h1zc+TUAmgQBHiNFyRIZTrRwEDIePuVg
	 xeDJWQGW0rf+kwWzeWinEcVaOvdyVrtkNzRK9Yb1jOtR8yNohEXHUtsXhzHXLpvg4Q
	 gzQm6HHU2nyFA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF843809A38;
	Fri, 24 Oct 2025 00:30:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: airoha: Remove code duplication in
 airoha_regs.h
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176126580849.3301171.1340317563476712267.git-patchwork-notify@kernel.org>
Date: Fri, 24 Oct 2025 00:30:08 +0000
References: <20251022-airoha-regs-cosmetics-v2-1-e0425b3f2c2c@kernel.org>
In-Reply-To: <20251022-airoha-regs-cosmetics-v2-1-e0425b3f2c2c@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, horms@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 22 Oct 2025 09:11:12 +0200 you wrote:
> This patch does not introduce any logical change, it just removes
> duplicated code in airoha_regs.h.
> Fix naming conventions in airoha_regs.h.
> 
> Reviewed-by: Simon Horman <horms@kernel.org>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: airoha: Remove code duplication in airoha_regs.h
    https://git.kernel.org/netdev/net-next/c/99ad2b6815f4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



