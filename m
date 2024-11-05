Return-Path: <netdev+bounces-142135-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E449BD9E5
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 00:50:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C4C41C2205D
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 23:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E76BC216A1A;
	Tue,  5 Nov 2024 23:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DI/taHQG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C81216A08
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 23:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730850621; cv=none; b=BuZr44t6+1ALoNfdeu3MuBBKoap9bRyAIaljzwLqSu7M7Zz6RXwVFp7Jz4j8eRjwUq5ArITB7aJM/QMb94Gk8siFTFbxjHU/u31zfRuDLXFGrdoaja0yUKvrrye7YFoJSClH7ht5DTdED287y4nw+/VhOlhtkyfNLtGai9rGQVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730850621; c=relaxed/simple;
	bh=b6GYGeE1CJBDxC34oFNJHKKFZRi7xkrpcXSiTG9Tgsg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ntK4gFydQKB+r5NhvyP9yQ1zjPqTmFPBZoJGvOHyo4GK337UQM6N3XpCDZOPaVfEksUPBppySKp/sbcJABegaOe5sv2f1hgNtM3uqiofrDYR4+OnC3AX6F9aYw08e/ssphDqJn0zZBWOKEBlMSWFsCyM/tVXW2qTlxAUh2X2UlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DI/taHQG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 628ABC4CECF;
	Tue,  5 Nov 2024 23:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730850621;
	bh=b6GYGeE1CJBDxC34oFNJHKKFZRi7xkrpcXSiTG9Tgsg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DI/taHQGZRDWK/Eo1SSalrO01IhV0vpni9ClvJSSCY8fbdMAfhFtLpK2ZfgHoLgvw
	 jbG0ZUWbgyiNnqLVdLfSk3Ofw90rcUWDrpr0vsKCpEcjfgt9VFJ9aIJn0ywUa7PQ3w
	 TtCeU4ILqso23ShumL2MMjDyzJIQ4FjPgk1tou42laRnDGlqi7R7se7JHbIpuWZslU
	 nZ0cDINhaxx1KfNwpxquPgIOsiRZV4rAmq/MG4AxCEgH25fNHOz0zeN9iJ6xZoKDCk
	 w4Y36g7XqL7CZZ5mSJkYPRYWO7M9WBrJJJZV3PV4KwTlTxDm9Em3e3xHwS2NOsl64a
	 OM1j08HpgTUsA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7159B3809A80;
	Tue,  5 Nov 2024 23:50:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] mlx5_en: use read sequence for gettimex64
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173085063027.734112.10155035059393274729.git-patchwork-notify@kernel.org>
Date: Tue, 05 Nov 2024 23:50:30 +0000
References: <20241014170103.2473580-1-vadfed@meta.com>
In-Reply-To: <20241014170103.2473580-1-vadfed@meta.com>
To: Vadim Fedorenko <vadfed@meta.com>
Cc: saeedm@nvidia.com, leon@kernel.org, tariqt@nvidia.com,
 davem@davemloft.net, rrameshbabu@nvidia.com, vadim.fedorenko@linux.dev,
 kuba@kernel.org, edumazet@google.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 14 Oct 2024 10:01:03 -0700 you wrote:
> The gettimex64() doesn't modify values in timecounter, that's why there
> is no need to update sequence counter. Reduce the contention on sequence
> lock for multi-thread PHC reading use-case.
> 
> Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)

Here is the summary with links:
  - [net-next] mlx5_en: use read sequence for gettimex64
    https://git.kernel.org/netdev/net-next/c/0452a2d8b8b9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



