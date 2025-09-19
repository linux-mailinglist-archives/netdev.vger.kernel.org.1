Return-Path: <netdev+bounces-224791-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85225B8A36A
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 17:13:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15A8F620ECF
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 15:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDFD1314A7A;
	Fri, 19 Sep 2025 15:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RF/1/Jdj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92D73148B5
	for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 15:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758294623; cv=none; b=uw7WwhCi44CFnimUaUyiHIIIFj4tFHDL5h5moz8xmILa9KDv2cKoML96eT7YIUYXZIVZNWgpvJSOiLhUlgv9OlBrZbFcTkN5e6yviqzCvijwCHS1xeCPRtl++U1Tp//jG/KhoPymAyDk04oudLDMzaXvgF7mxrv3Iy3ylxqdSn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758294623; c=relaxed/simple;
	bh=CXdGM4YEwwMisgM1/je7dFBgxqsJWrbd8vdeGKr78Dc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Y9sc2Ie0gjdAagZzxD6HoggTsuok3U7vPkT5UUHbJJa9QXrs1Yo+iE83HFdiqxWaK09KPhJEQnGIf82CCXalOAIzg+MtjJymG3fl8FaGZLX0bj1D0t47M+nk7sBfak0r83bPdiZZVCvwGLey2WY3clPyQ42v8ReCHPlfZFiX9DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RF/1/Jdj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42EC3C4CEF0;
	Fri, 19 Sep 2025 15:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758294623;
	bh=CXdGM4YEwwMisgM1/je7dFBgxqsJWrbd8vdeGKr78Dc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RF/1/Jdji8jf5NY/Jx5LgM7MLKap7/zMYQ4fsPWYlTOTY/f5eYCTYF44fKltMGpr3
	 ZwToElaDtDgrPGSF7/lKXOJXN5YhnvGLzh3mC/0NUL8RELJwgRqdWWwiMhMKj5oW3/
	 lFzMjqqAZ4AXKHHfvpwfDO8Mp4WkuvgmeKXZXANhSChzqtJWaDs5b49CyoEyhyxnhE
	 NmTBhEphhYOdsyM74k3NKD54GWkZj6/Rw3BtN+Ga6efDUf38Q230Van8uUimKLIS4p
	 zY4YdGi9POeHKnw9LdKZ0Ai6GbzFDPw9uhUYS2lB+DiyxzpAh3BXSBbgAu41qvP/no
	 dbsqMHLGqDWYQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EACC839D0C20;
	Fri, 19 Sep 2025 15:10:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] wan: framer: pef2256: use %pe in print format
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175829462276.3344139.5613932929773168713.git-patchwork-notify@kernel.org>
Date: Fri, 19 Sep 2025 15:10:22 +0000
References: <20250918134637.2226614-1-kuba@kernel.org>
In-Reply-To: <20250918134637.2226614-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 herve.codina@bootlin.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 18 Sep 2025 06:46:37 -0700 you wrote:
> New cocci check complains:
> 
>   drivers/net/wan/framer/pef2256/pef2256.c:733:3-10: WARNING: Consider using %pe to print PTR_ERR()
> 
> Link: https://lore.kernel.org/1758192227-701925-1-git-send-email-tariqt@nvidia.com
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net-next] wan: framer: pef2256: use %pe in print format
    https://git.kernel.org/netdev/net-next/c/3fb4f35a75e8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



