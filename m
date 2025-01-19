Return-Path: <netdev+bounces-159593-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9612A15FD7
	for <lists+netdev@lfdr.de>; Sun, 19 Jan 2025 02:50:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18749165BE2
	for <lists+netdev@lfdr.de>; Sun, 19 Jan 2025 01:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B2F613F43A;
	Sun, 19 Jan 2025 01:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jaDtSouK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042D713CA9C;
	Sun, 19 Jan 2025 01:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737251417; cv=none; b=RjeIPKM/aqK+S+/1TWDuojoTVoEq2Jbmd7GUlk3hHh3K8o0MJiR2TmzyKnxhCU0I5BszhbgacAUioJz8j2FxxRXLz5mRR/HkatikOhn2prIzi8NANn445J/IkUhBmq2X70fexCaZDZoqU6dGuSXCx7P94DosaE2qAiJ9SSZ8818=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737251417; c=relaxed/simple;
	bh=ZNT6LV+sT6nI+XAMqrN3F7sGWpDonVfwvQizds0IPfI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GpTW2Dlr68Rk5d5G5NNSY3bxVOL6fp3p9uS7kE0Ug5fbT9BGiLuEDs6D78Yo2PuOyvQAzTPxGDnou7r5qWsqKxDPADCFaUJCdjcbBxjPDCmP3+mXusVgvr3Lm2OfFtR7aSfansIL6EfrKUYnYsjV/mqOkOb/qOr+TSPgdrjfrkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jaDtSouK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D124C4CED1;
	Sun, 19 Jan 2025 01:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737251415;
	bh=ZNT6LV+sT6nI+XAMqrN3F7sGWpDonVfwvQizds0IPfI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jaDtSouKGGUdzo5dDo/lQn9HvmpDaYjfVBPVlsOnsOc8zwxBccHE2xK75MhHT/aEI
	 oE/VHVcn6gXlyUwW8QUqojPPPoyQNAm+7aJ82bnUFQ7+jATouyHRKPzeLy2fAuuHkp
	 f8CG6RH09q6Ir/nvWutg+o8/vpulm11IfcIaaWMo1vKHXSM+7E5XwX0q5nu3iMBdi2
	 2g7HJyX0PXfSI1ArLYs5IJ3mKQg6TMlLgUhB5T2R0hdWi25TgpfZ/GNZtylQwhkks9
	 YRwd69MpHyaoJ0kApSvYdMtxxjF/HaZ4rZvwNJpH/JhyWmQPaRXkEpVTFEw25EYo1G
	 ySe/eYzy+tkNQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70BB6380AA62;
	Sun, 19 Jan 2025 01:50:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 1/1] nfc: mrvl: Don't use "proxy" headers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173725143898.2533015.8585732195943109098.git-patchwork-notify@kernel.org>
Date: Sun, 19 Jan 2025 01:50:38 +0000
References: <20250116153119.148097-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20250116153119.148097-1-andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: krzysztof.kozlowski@linaro.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, krzk@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 16 Jan 2025 17:30:37 +0200 you wrote:
> Update header inclusions to follow IWYU (Include What You Use)
> principle.
> 
> In this case replace of_gpio.h, which is subject to remove by the GPIOLIB
> subsystem, with the respective headers that are being used by the driver.
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/1] nfc: mrvl: Don't use "proxy" headers
    https://git.kernel.org/netdev/net-next/c/a26892ee1297

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



