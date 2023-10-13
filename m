Return-Path: <netdev+bounces-40639-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B40E7C818E
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 11:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2588282C7F
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 09:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD9B410A22;
	Fri, 13 Oct 2023 09:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="csMI5MLK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED0410A16
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 09:10:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0C5D0C43397;
	Fri, 13 Oct 2023 09:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697188231;
	bh=fNgj8+qjVsxjuL11aoLC+nDRAOAPyyV629SPtwAT8vo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=csMI5MLKLYDyjzx4ajKhBPgilE4taTjp+n16Fv9u4u8jtYoIkIGMSns8+uQV1ygFo
	 gtiYhBKaWpXzC1Jhah2Pq9rjeiOfIREGHiYeYTtDzvwchagNRNgB1d0Nw7Prwy5Mvo
	 kgoJhOWhhnr4Oin58NoR0oO1xSpPbTV/CFmnacBxjYrI7U47VqS/begKcWUMzWdxpZ
	 JkS/YiguI2Wp0n51J+FGjC90we13Y0FCjAtf6+6Sxg/ZF41//RGnsP46K0FodPKEcO
	 hq+BL9IW4sZ4zLfzPrlXYrtk4UzdhpPjZzJbNAfmy4WBDMJnmgxxPnPY+hi0HX2JRo
	 noB1ALRqf6bdA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DE81DE1F66D;
	Fri, 13 Oct 2023 09:10:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: ethernet: wiznet: Use
 spi_get_device_match_data()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169718823090.32613.4699597021374127801.git-patchwork-notify@kernel.org>
Date: Fri, 13 Oct 2023 09:10:30 +0000
References: <20231009172923.2457844-5-robh@kernel.org>
In-Reply-To: <20231009172923.2457844-5-robh@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon,  9 Oct 2023 12:29:00 -0500 you wrote:
> Use preferred spi_get_device_match_data() instead of of_match_device() and
> spi_get_device_id() to get the driver match data. With this, adjust the
> includes to explicitly include the correct headers.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/net/ethernet/wiznet/w5100-spi.c | 12 ++----------
>  1 file changed, 2 insertions(+), 10 deletions(-)

Here is the summary with links:
  - [net-next] net: ethernet: wiznet: Use spi_get_device_match_data()
    https://git.kernel.org/netdev/net-next/c/13266ad9e52e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



