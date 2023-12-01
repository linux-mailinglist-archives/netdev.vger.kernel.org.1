Return-Path: <netdev+bounces-52894-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29012800937
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 12:00:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57D7F1C20757
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 11:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0070120B3E;
	Fri,  1 Dec 2023 11:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jFIl4xpG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5144208A8;
	Fri,  1 Dec 2023 11:00:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A2BE5C433CA;
	Fri,  1 Dec 2023 11:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701428425;
	bh=lDz8O3kEJRuixW9zKX5JW7qIlAHXaOgJ6uYeYOFOs58=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jFIl4xpGaY0jY17aAExWUdyHLl1BkrPFLilm8AFqAAJSmgoFqM9dYGWkHmx+IKkVg
	 xeNZKHTZIZiH9XiRWAPJ2rDr27WtjMF49+iRdhhJh7cRQe1hgMRw2DHrtuqfLV2wxD
	 5WUCZXHVDAEQNvPaMUVQicMOIVemeXFRPm3dRpwSZYPU0tLE0xG8S+d16Cc5G+V7R9
	 I4RMtOs2NSQxNJ+nUYJk6EjR2OShXspACMq4PxOLGZQsOP/S2jww91SSghLfV6d07g
	 H3yEQ6SSod/J7+R/1JfOV+PVfv6pgTmlBlJpzYTMl6D0WBCQwfGBP+bOXXha5ruEfH
	 Y+ksQl2GLWR6w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 83F03C59A4C;
	Fri,  1 Dec 2023 11:00:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] octeon_ep: Fix error code in probe()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170142842553.7076.7768114131648140649.git-patchwork-notify@kernel.org>
Date: Fri, 01 Dec 2023 11:00:25 +0000
References: <cd2c5d69-b515-4933-9443-0a8f1b7fc599@moroto.mountain>
In-Reply-To: <cd2c5d69-b515-4933-9443-0a8f1b7fc599@moroto.mountain>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: srasheed@marvell.com, vburru@marvell.com, sedara@marvell.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 28 Nov 2023 16:13:19 +0300 you wrote:
> Set the error code if octep_ctrl_net_get_mtu() fails.  Currently the code
> returns success.
> 
> Fixes: 0a5f8534e398 ("octeon_ep: get max rx packet length from firmware")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/net/ethernet/marvell/octeon_ep/octep_main.c | 1 +
>  1 file changed, 1 insertion(+)

Here is the summary with links:
  - [net-next] octeon_ep: Fix error code in probe()
    https://git.kernel.org/netdev/net-next/c/0cd523ee8642

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



