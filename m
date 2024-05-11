Return-Path: <netdev+bounces-95659-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9476F8C2F09
	for <lists+netdev@lfdr.de>; Sat, 11 May 2024 04:30:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FEBF2834BD
	for <lists+netdev@lfdr.de>; Sat, 11 May 2024 02:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3CF32D7A8;
	Sat, 11 May 2024 02:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="liY6R/Yn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2B31F932;
	Sat, 11 May 2024 02:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715394634; cv=none; b=HnN9Aozp167uwIZDhauT7yTtSWwaoVBC3SIWnDqoNUs0ZesLeDnJm7XOSdL2BMoc0b6EkR64L6nMjy0rDFLiAkd09haYVJrK1BxBUzdtbKluM9MoE87pYSOUkKTg6t1gc0WmE6CrBHXjDd6xqXDh5AaefmYnWnP/H37tUppyn3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715394634; c=relaxed/simple;
	bh=Jy5e/l4R8+rP+Y0tsCZq77IwV97Y2/tAMH0BUVFQ9EE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DSiRCaTUx1Sp3c7Te+8jmfble9WybOOCvgl0XXh5xUx2ursaSk772TUi/lOJQn34vOhleCbbWyhs6Efvjh94xdPcskQJwRqXXCm213N3+GtizARhw8SHu9zRb1T0R4hCakXABqO+neJel4q6kO3vvS1uAQQGY/NVBv/uvT8T5CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=liY6R/Yn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7B248C4AF11;
	Sat, 11 May 2024 02:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715394634;
	bh=Jy5e/l4R8+rP+Y0tsCZq77IwV97Y2/tAMH0BUVFQ9EE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=liY6R/YnpsQMNREGsffC50PDDai3APeuIdceNQTXWDG/CpnC+gpcT8Q3xS+9i0SaY
	 u8I38fqpguN2ZeTn2jajc86XpoElkG4x1V7AX1lvGaYLjIgcCYvwpLX5Ayhh3dj0YO
	 13Ml0UD1WrReSZSWEAkfBEb4sc/Dlh8z0lN/NrbrNO817Cyu29mIo2JnXbi2EXNv3I
	 dwXV7depNhbkEaT24vyaFr34WdJkq1zN5VvAKq9Q/+s4CVsERN1spm928cS0tasKqP
	 SxU0KY6oDpxxxI4X49H9WMZY5DszTKuao9OAJzIt0A/38B+iwqnqVzSo4gtV2AiY48
	 t0tdTtjpPrBxw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 724C2C54BA1;
	Sat, 11 May 2024 02:30:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH][next] net: dsa: microchip: Fix spellig mistake "configur" ->
 "configure"
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171539463446.29955.16064733624227057249.git-patchwork-notify@kernel.org>
Date: Sat, 11 May 2024 02:30:34 +0000
References: <20240509065023.3033397-1-colin.i.king@gmail.com>
In-Reply-To: <20240509065023.3033397-1-colin.i.king@gmail.com>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: woojung.huh@microchip.com, UNGLinuxDriver@microchip.com, andrew@lunn.ch,
 f.fainelli@gmail.com, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  9 May 2024 07:50:23 +0100 you wrote:
> There is a spelling mistake in a dev_err message. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/net/dsa/microchip/ksz_dcb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [next] net: dsa: microchip: Fix spellig mistake "configur" -> "configure"
    https://git.kernel.org/netdev/net-next/c/089507a67921

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



