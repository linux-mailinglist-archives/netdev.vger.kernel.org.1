Return-Path: <netdev+bounces-43993-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 735C67D5C28
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 22:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23F80281AFE
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 20:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FEC03E47F;
	Tue, 24 Oct 2023 20:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NK+R+GBK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33BBD3E477
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 20:10:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 99FC5C433CB;
	Tue, 24 Oct 2023 20:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698178227;
	bh=Yd89YpvY02OQcJfs/E3uCkgXbsOGXDhxmyHcx/Wrs8s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NK+R+GBKCE2A7PgCh7Rb1Vy08IdvcaIxvfBo3N5XeM3yVmng66iDv1rmm72DnAFaA
	 gosWHEnBHD79bnqJTvyABCIkzMAT6uqmNOTbG4u4cVU0nfU8Ou5cFgt3mRGWf7Qine
	 s5pYQIuHsbDxAF6TQmoqQO9odWqmSV0nZS+L6u6afCDWf1JtI3fENkbn11FXxDfIfq
	 hg3PDRiXgbe5PXAkapmYbVNGVrq7FOC4eErXnyQeOT4a4qF5CxP9xJY5DDwGPB3n+h
	 wNSDRninbMw4AuQbPVFxiLzmj8l9dC/pirfLUdRyAlNPJG6xE5fjMBCWNVT3agJRGG
	 FE9hqgBc+g6Sw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7B967C3959F;
	Tue, 24 Oct 2023 20:10:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tsnep: Fix tsnep_request_irq() format-overflow
 warning
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169817822750.29692.18015497545388889511.git-patchwork-notify@kernel.org>
Date: Tue, 24 Oct 2023 20:10:27 +0000
References: <20231023183856.58373-1-gerhard@engleder-embedded.com>
In-Reply-To: <20231023183856.58373-1-gerhard@engleder-embedded.com>
To: Gerhard Engleder <gerhard@engleder-embedded.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, lkp@intel.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 23 Oct 2023 20:38:56 +0200 you wrote:
> Compiler warns about a possible format-overflow in tsnep_request_irq():
> drivers/net/ethernet/engleder/tsnep_main.c:884:55: warning: 'sprintf' may write a terminating nul past the end of the destination [-Wformat-overflow=]
>                          sprintf(queue->name, "%s-rx-%d", name,
>                                                        ^
> drivers/net/ethernet/engleder/tsnep_main.c:881:55: warning: 'sprintf' may write a terminating nul past the end of the destination [-Wformat-overflow=]
>                          sprintf(queue->name, "%s-tx-%d", name,
>                                                        ^
> drivers/net/ethernet/engleder/tsnep_main.c:878:49: warning: '-txrx-' directive writing 6 bytes into a region of size between 5 and 25 [-Wformat-overflow=]
>                          sprintf(queue->name, "%s-txrx-%d", name,
>                                                  ^~~~~~
> 
> [...]

Here is the summary with links:
  - [net-next] tsnep: Fix tsnep_request_irq() format-overflow warning
    https://git.kernel.org/netdev/net-next/c/00e984cb986b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



