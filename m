Return-Path: <netdev+bounces-22953-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DCC576A2C4
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 23:31:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E82A281621
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 21:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1CCD1DDF5;
	Mon, 31 Jul 2023 21:30:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF981E500
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 21:30:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B119BC433D9;
	Mon, 31 Jul 2023 21:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690839022;
	bh=6YUJdiqV/5NwOm1NQ17z3kytZTL+4qgxDgi1EMoRYOw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VOa9KNy4pOsd+g53Wzjdo433DGPKb9203eELGxHpyrXNsm/2x6RfBX4M83DufiMRo
	 1t6lcN9jfv98gJSXy+Z8nQFZywhJ56vDeXpmdO4DoDuWa/FSEPQ6UxBQrHy+gBTi6X
	 liZSoaL4j+9FblHNYBsXNCMKKXbF/Y6Dz/XYfsXOcR3bDP69NlFUutJxxmy4VlqC9X
	 nhWjKgERNWgtCJ9YP+w/a6/Jeht44tVmNRS699qP3vtwWwAUu4XbUGQFnPiMGGYJSK
	 YirAHHIL1V3bQlTUdm7rU+qHR30MH6MHXlpwdFfW3JSAOSRPcykNO/+2hlozXReIOR
	 +OvW0aUh5QZ5g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8B9D8C64458;
	Mon, 31 Jul 2023 21:30:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] bnxt: don't handle XDP in netpoll
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169083902256.31832.7103985201262014534.git-patchwork-notify@kernel.org>
Date: Mon, 31 Jul 2023 21:30:22 +0000
References: <20230728205020.2784844-1-kuba@kernel.org>
In-Reply-To: <20230728205020.2784844-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, gospo@broadcom.com, michael.chan@broadcom.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 28 Jul 2023 13:50:20 -0700 you wrote:
> Similarly to other recently fixed drivers make sure we don't
> try to access XDP or page pool APIs when NAPI budget is 0.
> NAPI budget of 0 may mean that we are in netpoll.
> 
> This may result in running software IRQs in hard IRQ context,
> leading to deadlocks or crashes.
> 
> [...]

Here is the summary with links:
  - [net,v2] bnxt: don't handle XDP in netpoll
    https://git.kernel.org/netdev/net/c/37b61cda9c16

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



