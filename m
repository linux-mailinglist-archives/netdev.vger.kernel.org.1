Return-Path: <netdev+bounces-104441-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DBE190C870
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 13:08:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3265283675
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 11:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44ED8158863;
	Tue, 18 Jun 2024 09:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k1WJjSHB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DDAF205B0F;
	Tue, 18 Jun 2024 09:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718704229; cv=none; b=YMTuXnQkTbUwkulwEGbqSONfZiKfS5LQDtV87RsBWVv5gh4RKg7wHOBbBt8dVFglhrvxj0t7VpwaCQlX5unH7qziv7ba/bGdqBlDDuQ19Kj2bo7wdfChu4Uzkgw/6ZgOGBzduwKNXG4qXrTqJSZ5y13Vw3gbqvtMzvnjmZfD7gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718704229; c=relaxed/simple;
	bh=elONcxsWULUdEDPQ4LFBA+PJ3wyTRG1kyjBDnlyR1uc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Um/06ZkYD7PIQhH9JadMDuyuMvq2BpxnDReMi+n09DR4iHX09SQWA3aDUIjDwPuSPBgfo031NjpKzSHQY63Q5gIvNKtlLZcjeRGCAJEjzexE1zMj5uEL0IxfmFC7zOBWPk/+NtDgyJ9jP8tQUz22NIY+EXTF1+6fXWDZF2UaqnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k1WJjSHB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9FA9DC4AF1D;
	Tue, 18 Jun 2024 09:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718704228;
	bh=elONcxsWULUdEDPQ4LFBA+PJ3wyTRG1kyjBDnlyR1uc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=k1WJjSHBe1oBJL7irtCrFkz+SBXSdY6qHHLQlMJvN4YoIxWE6FUL8NvW+lOWvrseu
	 YEwM85LCucEfHvZayjEy41XpYPCs+xshsJoHnCwaM5GGU5YxOZdGvGq7Mabb06sB7R
	 UjwytB2Q17NjVfq2qaWkdq+SFp5L6ST10OgZZEt0P9ptI8+1yU5Q0qbN2XL2Xnht2l
	 4Ui5Q9fod1P+/BBG0+NV27X/kty4D6KLpq/CFeOnpc8JSrLOHHfAE2/pnLxox30r/e
	 TMf7mOOKM/UFIalCB5D9OoGg3bPnhZGpTm8x2enb/esXYlK7sqto9FhKN24/XEzGck
	 Un8L2X4CrBhOA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8F1D1D2D0F8;
	Tue, 18 Jun 2024 09:50:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] qca_spi: Make interrupt remembering atomic
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171870422858.6440.11410226713577880340.git-patchwork-notify@kernel.org>
Date: Tue, 18 Jun 2024 09:50:28 +0000
References: <20240614145030.7781-1-wahrenst@gmx.net>
In-Reply-To: <20240614145030.7781-1-wahrenst@gmx.net>
To: Stefan Wahren <wahrenst@gmx.net>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, chf.fritz@googlemail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 14 Jun 2024 16:50:30 +0200 you wrote:
> The whole mechanism to remember occurred SPI interrupts is not atomic,
> which could lead to unexpected behavior. So fix this by using atomic bit
> operations instead.
> 
> Fixes: 291ab06ecf67 ("net: qualcomm: new Ethernet over SPI driver for QCA7000")
> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
> 
> [...]

Here is the summary with links:
  - qca_spi: Make interrupt remembering atomic
    https://git.kernel.org/netdev/net/c/2d7198278ece

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



