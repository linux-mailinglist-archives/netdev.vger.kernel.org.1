Return-Path: <netdev+bounces-205046-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40353AFCF80
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 17:41:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63F411BC7EF3
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 15:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E81DB2E499C;
	Tue,  8 Jul 2025 15:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WMw3HmME"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08B82E427A;
	Tue,  8 Jul 2025 15:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751989194; cv=none; b=n1TuG06FxtsJxPQqKtclqFxNs3Ty17sxKdAAd3tTxIrOr0LmlvApTw4mRxSHUNW64VdKtX9XOhTKNzTcAOKNJIWk6PmMNRPQ+rJONkArtVq7gEeN0sSpZgyc/56wzMPG367NJUnhsuTnD7xu9ngdnlt4wHyQ47JSrWb82TkdK9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751989194; c=relaxed/simple;
	bh=WRj6h+msBgK9uzjAd03SXaKjgx/+5pdPCwswULem154=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lPFl8bL5CHGbgQqbQrA95yNT7Bsuk93I7LBS9W7Ia6lsKArWw4egZgjAUiuatVQ3r0M8tt6gGoa4d0DBl1bb1VVCbwSYW1EPY6vujF0+/CMOU39BXOk0JGiUa0otfkXnPkiA4b/uUshBSxi5ebrUGsyMx9yS3Is2bJs1sZCwnlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WMw3HmME; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 613ECC4CEED;
	Tue,  8 Jul 2025 15:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751989194;
	bh=WRj6h+msBgK9uzjAd03SXaKjgx/+5pdPCwswULem154=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WMw3HmMEFGw6ZqFzrcEo1IWTAoZ+NZEqYI/kSnjTzlC9HbzLlVuYX1ITGMhy6Nti4
	 fSH2xuR+P1u6XsA0L8sQQAfYjKsINVEMA3dKUcHXk1yiu5GoR0K0yZTSy8dNqiZTKI
	 rVltRyg7r1SKaEKY4Eg5HpyBlXyjk35Y89yFMd9spDuwsnB9hNBucNho++AJ+fGIYb
	 ojXvb5srRqhijLbxV+Z5zpfytB6yPhmtcKOzhZvbeSoKRHHfv3fdUAqFjCm1nJttC1
	 L4rTm4RdwOOBPwcKz5squilXnHX7i3Ah2DokJ8tZMyIiiYLRtE12aDkM3Xy4cSkGSv
	 EYSlKnSM4SZqg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70CAB380DBEE;
	Tue,  8 Jul 2025 15:40:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] gve: global: fix "for a while" typo
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175198921725.4109948.304921090988490119.git-patchwork-notify@kernel.org>
Date: Tue, 08 Jul 2025 15:40:17 +0000
References: 
 <5zsbhtyox3cvbntuvhigsn42uooescbvdhrat6s3d6rczznzg5@tarta.nabijaczleweli.xyz>
In-Reply-To: 
 <5zsbhtyox3cvbntuvhigsn42uooescbvdhrat6s3d6rczznzg5@tarta.nabijaczleweli.xyz>
To: =?utf-8?q?Ahelenia_Ziemia=C5=84ska_=3Cnabijaczleweli=40nabijaczleweli=2Exyz?=@codeaurora.org,
	=?utf-8?q?=3E?=@codeaurora.org
Cc: jeroendb@google.com, hramamurthy@google.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 3 Jul 2025 20:21:20 +0200 you wrote:
> Signed-off-by: Ahelenia Ziemiańska <nabijaczleweli@nabijaczleweli.xyz>
> ---
> v1: https://lore.kernel.org/lkml/h2ieddqja5jfrnuh3mvlxt6njrvp352t5rfzp2cvnrufop6tch@tarta.nabijaczleweli.xyz/t/#u
> 
>  drivers/net/ethernet/google/gve/gve_rx_dqo.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [v2] gve: global: fix "for a while" typo
    https://git.kernel.org/netdev/net-next/c/f142028e30ca

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



