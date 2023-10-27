Return-Path: <netdev+bounces-44713-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A73367D9517
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 12:20:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14195B20F9D
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 10:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52E44179A1;
	Fri, 27 Oct 2023 10:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RVk3/sIi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368D01802F
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 10:20:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 90170C433C9;
	Fri, 27 Oct 2023 10:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698402024;
	bh=T+3V1QPNWQUYBlU7Bsq22khHxGFNFrur7XQd590rXoM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RVk3/sIiGmoj19UD63rK9A/Liipt6WZ7nQRvTYjjUPMlNONrHvLbOeh1ww0EvhqME
	 fR44vLwFwb1b0dzcnCVvpJdL64T7tXkDSxghrsxb6GjdCqv483/9DBtHFQI84qLB4i
	 itWWLS6LTni1sMBtNBoVxyEG9HKCZO0KCLzg3y0UE+WdtWJnXxaELw6aS77hRxCum6
	 zul82YK/Nslnz5DFHsiHOeQIHjhbWw8fA+Ol/zJY+ANLboWavKBHSqg7ytbsgz3bqU
	 EypIcRM2yU7DwTUtbg4W24Lxt2IQd2Wk1UZzwP3uqRDq7DLUfKoL5av1I+4WEVtcIa
	 uqPummy4+KTNA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7697AC41620;
	Fri, 27 Oct 2023 10:20:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: bridge: fill in MODULE_DESCRIPTION()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169840202448.15376.8674341343569691359.git-patchwork-notify@kernel.org>
Date: Fri, 27 Oct 2023 10:20:24 +0000
References: <20231027100549.1695865-1-razor@blackwall.org>
In-Reply-To: <20231027100549.1695865-1-razor@blackwall.org>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, kuba@kernel.org,
 bridge@lists.linux-foundation.org, roopa@nvidia.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 27 Oct 2023 13:05:49 +0300 you wrote:
> Fill in bridge's module description.
> 
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
> ---
>  net/bridge/br.c | 1 +
>  1 file changed, 1 insertion(+)

Here is the summary with links:
  - [net-next] net: bridge: fill in MODULE_DESCRIPTION()
    https://git.kernel.org/netdev/net-next/c/6808918343a8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



