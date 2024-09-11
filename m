Return-Path: <netdev+bounces-127179-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A04DA9747E4
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 03:40:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88F591C2559D
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 01:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFF4E34545;
	Wed, 11 Sep 2024 01:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="llIq+q8T"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1FD12EAE5;
	Wed, 11 Sep 2024 01:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726018833; cv=none; b=uI3dbKix2sxfiXxg2I02FVsYIW+kr7uefCQ3qPs06Xq7sFw9vzfiVNjXr+0GzbUCwAjYBaR4tzInEcWxKCFqb9HK164m3m4oCvfYBNE6IdilwKOs1A5kR3EPOapwkUjJEWyCQFVukGzWzkA6fUbI78HK0iWSOjI04goiSbipua8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726018833; c=relaxed/simple;
	bh=CPmIwVMrA23w91w/S8SnGol6OS/F32P7WNzGG20p7GI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ULgsQeFJZlyUEOqCCQqP4ECKN/H2UOq+FVm/WYPsOGGi/cCI7PT/4Z8Mq6DlYkoGFf5JpoCy5mt8z3ShGvMXdiGzPU7OzOby/iFUxDt+ZlO7vrFNBlgJsb2Zc/Z8xRvcdjT+9oSgt1YiAGd3gm18dNE9S8YHPjnYvuy3d4Pw0yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=llIq+q8T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 311D2C4CECE;
	Wed, 11 Sep 2024 01:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726018833;
	bh=CPmIwVMrA23w91w/S8SnGol6OS/F32P7WNzGG20p7GI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=llIq+q8Toj2SE3Q1okdhavjllS/3BsS8vQfiTjx+pXwVJK9CVAaEEB187jhnjgQCm
	 8H5uOhw78TvlK68gSQLtet1Rg3I+DOIJNrRVEm2kcUWg0nVvDkmjATHnZA9hvEAOJa
	 EEg6pStGS48lyHj/q0RQAEogt7a7HpHXPY811N7AAoyGrvaK9+9NNokyqjo8KAjvdw
	 +n1HHStCbefjaQwHzazDYKsiGysrE35qyBHJ0Z944Zm+kG0hU5nSEjigYpy7n0YEXA
	 2BaZZt7rrvnjmYPm0TgziEw7OB+tNZ50KfJBIwWLJgnxzPenDTJHD+W80uivYZ2KSl
	 YXTTFf1vMJKow==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70CA23822FA4;
	Wed, 11 Sep 2024 01:40:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH][next] r8169: Fix spelling mistake: "tx_underun" ->
 "tx_underrun"
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172601883400.456797.17068451130553757856.git-patchwork-notify@kernel.org>
Date: Wed, 11 Sep 2024 01:40:34 +0000
References: <20240909140021.64884-1-colin.i.king@gmail.com>
In-Reply-To: <20240909140021.64884-1-colin.i.king@gmail.com>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: hkallweit1@gmail.com, nic_swsd@realtek.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  9 Sep 2024 15:00:21 +0100 you wrote:
> There is a spelling mistake in the struct field tx_underun, rename
> it to tx_underrun.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/net/ethernet/realtek/r8169_main.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Here is the summary with links:
  - [next] r8169: Fix spelling mistake: "tx_underun" -> "tx_underrun"
    https://git.kernel.org/netdev/net-next/c/8df9439389a4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



