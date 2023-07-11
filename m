Return-Path: <netdev+bounces-16739-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC8074E9A2
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 11:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5A9F281484
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 09:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9BE3174F8;
	Tue, 11 Jul 2023 09:00:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD4D17723
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 09:00:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BBF1BC433C8;
	Tue, 11 Jul 2023 09:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689066020;
	bh=RCLjMFeBr3MHz6ulYH079oF/FbTASlDlAGn68crW1L8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=D7zado8ilp1SxdOt0GztgsUQhZnkedIPhx6PriO3SCdX8DAL7qyy8xdvmmeNttMTW
	 cSkCy+yRKqqD7BCj/HO9R5bHmmMG2SuOgQnSq1SCkomVDxbM+Kj9+LaQjLK0QnYd6S
	 QgISuTTyIVEhw8lzozQALT5DydMU7HAircLl97317AF97E1niGCyWitP8aPZzkGYRv
	 l+1BLYYBNWNl2p+URdguknEFqQx/qkPSJP8j6f7yFo0u+qHVK5fGr2EYYKtlOqcSgG
	 XXAeYOiCHq/zvNPthQpdpS2bCTQFu4i4Hpyla7YfnkeKdW5RVeO6h00CsJqCN9qP8S
	 5MJL+dwVso3OQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9F714E52BEF;
	Tue, 11 Jul 2023 09:00:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: dsa: Removed unneeded of_node_put in
 felix_parse_ports_node
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168906602064.21384.13815055106752556798.git-patchwork-notify@kernel.org>
Date: Tue, 11 Jul 2023 09:00:20 +0000
References: <20230710031859.36784-1-luhongfei@vivo.com>
In-Reply-To: <20230710031859.36784-1-luhongfei@vivo.com>
To: Lu Hongfei <luhongfei@vivo.com>
Cc: vladimir.oltean@nxp.com, claudiu.manoil@nxp.com,
 alexandre.belloni@bootlin.com, UNGLinuxDriver@microchip.com, andrew@lunn.ch,
 f.fainelli@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, opensource.kernel@vivo.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 10 Jul 2023 11:18:59 +0800 you wrote:
> Remove unnecessary of_node_put from the continue path to prevent
> child node from being released twice, which could avoid resource
> leak or other unexpected issues.
> 
> Signed-off-by: Lu Hongfei <luhongfei@vivo.com>
> ---
>  drivers/net/dsa/ocelot/felix.c | 1 -
>  1 file changed, 1 deletion(-)

Here is the summary with links:
  - net: dsa: Removed unneeded of_node_put in felix_parse_ports_node
    https://git.kernel.org/netdev/net/c/04499f28b40b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



