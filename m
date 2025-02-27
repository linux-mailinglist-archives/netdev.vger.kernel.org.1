Return-Path: <netdev+bounces-170227-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 678C2A47E3B
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 13:50:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E1E83A3CB2
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 12:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 067CE22CBF4;
	Thu, 27 Feb 2025 12:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cSQH8kPn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06A8224246;
	Thu, 27 Feb 2025 12:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740660599; cv=none; b=OFRXgxDTtJHWwlEAwZzX9DiBMJxZsttUExhMHPtPMq3q9ubvwTmDZDI7hnqenEiPz3iRygKGoggB1nG2t8pgRiJLHN+XOWGfFv/Mh1gkQKcjhGKtGXBln0+uTavaJqQGnd6cOPyGma+eVYRhSA+32cgLhaSPC2jkTQWvzypIcCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740660599; c=relaxed/simple;
	bh=lcCAG0zJ+YM/7eU+3qkL571+VKtb7CvJLlvLTnG82WA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=D6N6K5K5DywB+ETqu+A+VKFPS78boh+s5cacLQcrMEJwkZOOk+xvC5rn81hb37zdF3p+Iry70EnwL+i5w/NUBRRNbhiFVDTI1C7gIf6uFWJ6TvDpwYaIMjxBuGtWuRGyOLG51gRLZuf1joiCyjIwamvBnXy5ZAJgvW9izcbbhPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cSQH8kPn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42F73C4CEDD;
	Thu, 27 Feb 2025 12:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740660599;
	bh=lcCAG0zJ+YM/7eU+3qkL571+VKtb7CvJLlvLTnG82WA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cSQH8kPnM8oCUU0NPKxtZZUbBozFHkOQccxj6deNcsALJhu66rA3RGKpJIaWHvAPZ
	 4Mzeb6rLXRwClsqjQ2QowamAcSvuTTl0FlrJ9EO2YTtd4uYPTDYLq28oGGT1s8yPuG
	 1V32pwo+AqEjRCu7poDF2omu4gSPXxNHu6kHjltrdM+Aem/aF85/oKLD7bLaXqtdox
	 kLZ66GZSrt9C6P1lc6ibrVtWjPqqxvVM4dfq5oBMbc6FQyOUEgX72fcR8k1KwNQPJL
	 DpnpZ14Ayjo1PxvHmn+ucW+p6QOrjAuUOcwINcjgsC/TfUZZJC1G8/irZyPNw0XjWQ
	 RE2AAjpL7ar5g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E60380AA7F;
	Thu, 27 Feb 2025 12:50:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/2] net: hisilicon: hns_mdio: remove incorrect ACPI_PTR
 annotation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174066063126.1416539.11160314303110298496.git-patchwork-notify@kernel.org>
Date: Thu, 27 Feb 2025 12:50:31 +0000
References: <20250225163341.4168238-1-arnd@kernel.org>
In-Reply-To: <20250225163341.4168238-1-arnd@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: shenjian15@huawei.com, salil.mehta@huawei.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 arnd@arndb.de, horms@kernel.org, u.kleine-koenig@baylibre.com,
 krzysztof.kozlowski@linaro.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 25 Feb 2025 17:33:32 +0100 you wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Building with W=1 shows a warning about hns_mdio_acpi_match being unused when
> CONFIG_ACPI is disabled:
> 
> drivers/net/ethernet/hisilicon/hns_mdio.c:631:36: error: unused variable 'hns_mdio_acpi_match' [-Werror,-Wunused-const-variable]
> 
> [...]

Here is the summary with links:
  - [1/2] net: hisilicon: hns_mdio: remove incorrect ACPI_PTR annotation
    https://git.kernel.org/netdev/net-next/c/9355f7277d69
  - [2/2] net: xgene-v2: remove incorrect ACPI_PTR annotation
    https://git.kernel.org/netdev/net-next/c/01358e8fe922

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



