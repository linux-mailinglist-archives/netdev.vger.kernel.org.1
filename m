Return-Path: <netdev+bounces-173150-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1699A57822
	for <lists+netdev@lfdr.de>; Sat,  8 Mar 2025 04:51:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 112CC3B6E03
	for <lists+netdev@lfdr.de>; Sat,  8 Mar 2025 03:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48E6A1AA1D5;
	Sat,  8 Mar 2025 03:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Msrd4WTy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF8917A2E5;
	Sat,  8 Mar 2025 03:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741405819; cv=none; b=AW+i4vxZP/XuCd4b69Xz9JMQU9NSeBF3iXNujXj+uk+SmjOb0u3OKV9JPOnYUcc9MyJqlUEwv2zSEwgmKuaZqTyPp7exkEw/v2jwyXWHG/7MR8Y02FxwtnmfGKwcKa/6ZmJOoI0mh7BdYoZ+rjhD9TP7DImpfIn8pvwP2BrGbBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741405819; c=relaxed/simple;
	bh=90XLQP1hM4lN1DT85WNI8TXL1Gf8VrJWS4VLcv9kReM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ltVoyvc8I5Hv1RLGmghvJlv2kQSb2Z4+gYQsIaA1hEUvB3eEe7mRD2H9/GDzdjzkqHKmuUpqatXt51Ofber8mb+1J7jEQdhKbhOJA8jvPodTNucCvSUOYr9isXms9FiBSKRedMH9FNdIu9cJP1ab7rv4vuqfDaFqJCoS/ENXl0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Msrd4WTy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9981EC4CEE0;
	Sat,  8 Mar 2025 03:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741405817;
	bh=90XLQP1hM4lN1DT85WNI8TXL1Gf8VrJWS4VLcv9kReM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Msrd4WTyjJYCVAm2trYa7zpd8T+d32HzKL9SB+a0MbE9kHIJ+hfG3Mv6OsoCbrC7r
	 vNyXksBxsxKNujo+vjsLr4gdm1kc+OF568RDSl3xl6zr6tGJEPH0IohvkQl8snFZ7D
	 zVafk/hWzpNBE01dyV6+hQ+adTYmoKKnNUvCkwwpI5exfZXxqDdKcQp4uYsDnN+knM
	 2qwV2BTiyp8tjDQAvoXZgqz77afEOIUt6KLrd+tDCxa30l1OsCWc49ewcy4cZ7jUg7
	 MTQnrYqlQlwOT9x225uYQrtKz4RI/LQgoodIQFRxEJpzqa6ce4BtnEFY+2ep1Oa785
	 gt16IGzGF/Smw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70AD8380CFFB;
	Sat,  8 Mar 2025 03:50:52 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: ethernet: Remove accidental duplication in Kconfig file
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174140585098.2568613.2283385624839221581.git-patchwork-notify@kernel.org>
Date: Sat, 08 Mar 2025 03:50:50 +0000
References: <20250306094753.63806-1-lukas.bulwahn@redhat.com>
In-Reply-To: <20250306094753.63806-1-lukas.bulwahn@redhat.com>
To: Lukas Bulwahn <lbulwahn@redhat.com>
Cc: lorenzo@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org, lukas.bulwahn@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  6 Mar 2025 10:47:53 +0100 you wrote:
> From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
> 
> Commit fb3dda82fd38 ("net: airoha: Move airoha_eth driver in a dedicated
> folder") accidentally added the line:
> 
>   source "drivers/net/ethernet/mellanox/Kconfig"
> 
> [...]

Here is the summary with links:
  - net: ethernet: Remove accidental duplication in Kconfig file
    https://git.kernel.org/netdev/net-next/c/e2537326e3b6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



