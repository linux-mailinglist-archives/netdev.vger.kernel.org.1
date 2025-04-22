Return-Path: <netdev+bounces-184575-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6544EA963D1
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 11:15:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0656B188749A
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 09:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CD9025A645;
	Tue, 22 Apr 2025 09:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z1Cs5zna"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E6125A35D;
	Tue, 22 Apr 2025 09:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745313020; cv=none; b=OsG9HoI4WyvPL5SWOncl+AbXyOn+/W/iGV9X9AYWgt4pzrogGHSGaHnxSS0ZgCuMtICmteMYEQD73plMq1Q9eUWAgfcQ9vXHQpCPfP/++q/BsJLlJlNV2fUFjR9Ywe7ZwsOP1SGvTijDf7ATbxr9ERqD9AR0wza/nQ7bTsbWOAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745313020; c=relaxed/simple;
	bh=PUT42nkj9usmklJLJ4eRA+ccH4Iy+u8VjhnyxVvTqHQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=h//1IaJK6uGEf9GlcCjZ8njThQm4RtRov5f71F9E4hu91WQCkmKUOZqAYHRXBwj5vvHxHLLTY1b2muY4qh67D9YepSOZs2oMHKK3Y7eKFG1dwmmQz7B7nYl65rbgsmixBPeBuK0HrYuUyFNgrrUyz+/ibNR1+XdZjyYQX+1AE0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z1Cs5zna; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 808D8C4CEE9;
	Tue, 22 Apr 2025 09:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745313019;
	bh=PUT42nkj9usmklJLJ4eRA+ccH4Iy+u8VjhnyxVvTqHQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Z1Cs5znabA2xidBwGbGv1mLmiBxQFrFX9uqpN6d3sFrfXhhZLU6wyfCSeQe+sA/T4
	 sTytT6Flmsrup0Mv4hyM+atO115mMQ1ufEPiumC5WjySNAyl++c6RsgoQW24hvpm8D
	 lF47uuBSnIcrTAQl/MnqT4tSpjpGDB1DQIpOgUHHkLF5vHUR23AXeKPLEzpTq6bS8u
	 5wpHybmr7fwUNDM+leGM2fmVCGm8Zrrq2mMO9801xppnbhSeijG+3HQcXSYOiIT1j+
	 lgAt7hJ9XsfWG1G/sfuTuUT4ibbJ4FoSHRlt4l40ihHwHvA1MT0K2LXS03ieBZXOtj
	 OAJ3HcAfbM0fg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33A9F39D6546;
	Tue, 22 Apr 2025 09:10:59 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH][next] net: axienet: Fix spelling mistake "archecture" ->
 "architecture"
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174531305799.1477965.14224114982471679309.git-patchwork-notify@kernel.org>
Date: Tue, 22 Apr 2025 09:10:57 +0000
References: <20250418112447.533746-1-colin.i.king@gmail.com>
In-Reply-To: <20250418112447.533746-1-colin.i.king@gmail.com>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: radhey.shyam.pandey@amd.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 michal.simek@amd.com, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 18 Apr 2025 12:24:47 +0100 you wrote:
> There is a spelling mistake in a dev_error message. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [next] net: axienet: Fix spelling mistake "archecture" -> "architecture"
    https://git.kernel.org/netdev/net-next/c/61fde5110ee9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



