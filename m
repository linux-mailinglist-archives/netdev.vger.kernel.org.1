Return-Path: <netdev+bounces-218439-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EABC9B3C761
	for <lists+netdev@lfdr.de>; Sat, 30 Aug 2025 04:20:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7AE73B4500
	for <lists+netdev@lfdr.de>; Sat, 30 Aug 2025 02:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36CD82522A8;
	Sat, 30 Aug 2025 02:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FF65KHzz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0062475C8;
	Sat, 30 Aug 2025 02:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756520410; cv=none; b=TTN00Tx+633U4Jw7O09kGLRHfd9U1lSp/JTJYm43fbT2J/5e1dO9nyvXCe4U2amY0ESLmi5Ng29rehXXONPQ4oS+ZtZW2vGj6WNFLrYQhdCnc3hdqSofXVNvJNqp0lnzrUtdJP61yGSIvVPAHdGwh2sPGVN5uUWF/ukbh1BjSIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756520410; c=relaxed/simple;
	bh=YdBad7ij/OPIxxccIiOfBZZoGOJmgzoqqZWegAgzOec=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Stfc+hJ2Db4jjfkczlaDNEwMxXXDAfi/9woPw+/eHOkHBg0qySfpLcNBsDhvW6DRXifSxb9qWW0LtPNr+KwF6Gm3tsW0kbQCFYLQc1ARItd77tXIaDuk7Qbm9M+Dc3zmMZrbWChFmIvAIEaEyWmDndXVA0q0dwNd9CRWYfHT83o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FF65KHzz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6A0EC4CEF0;
	Sat, 30 Aug 2025 02:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756520409;
	bh=YdBad7ij/OPIxxccIiOfBZZoGOJmgzoqqZWegAgzOec=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FF65KHzzIiaBSwhCi0D3V0ssIYFMo2B16rsPMqw1aQYXJRz3y9GA1pVSX1sDkU01m
	 LIwfgsIc4NXn7DeL6BkXBRmQhOvVB8BSXfnZRAjQd6SDLX5rsJs/assd3BGRY+FODX
	 55AqGXjTTICmEVXOs/nQlqQgeP9vRs3tp8ljL6n8conFXmeefhadjNf+WmUTbBQA25
	 cXICv4vilBuumFQuqFfoY87TOoMQEY5DeWg4egm2F8XnYi1oUStxKD8ydP3LBalXQi
	 Vswj7b9G4cCzNQ5XlU5XJFcnObJlFtFZXv7Pmn1qhWUxx2Toaurg0Cye387Ufb3Y5e
	 CG75Txoy4tlxA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADBD8383BF75;
	Sat, 30 Aug 2025 02:20:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] vsock/test: Remove redundant semicolons
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175652041623.2398246.9057051952121717092.git-patchwork-notify@kernel.org>
Date: Sat, 30 Aug 2025 02:20:16 +0000
References: <20250828083938.400872-1-liaoyuanhong@vivo.com>
In-Reply-To: <20250828083938.400872-1-liaoyuanhong@vivo.com>
To: Liao Yuanhong <liaoyuanhong@vivo.com>
Cc: sgarzare@redhat.com, virtualization@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 28 Aug 2025 16:39:38 +0800 you wrote:
> Remove unnecessary semicolons.
> 
> Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
> ---
> Changes in v2:
> 	- Remove fixes tag.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] vsock/test: Remove redundant semicolons
    https://git.kernel.org/netdev/net-next/c/2a63607bfda9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



