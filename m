Return-Path: <netdev+bounces-35688-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F5A7AA9F4
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 09:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id E563628318E
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 07:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E266179B6;
	Fri, 22 Sep 2023 07:20:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F300442D
	for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 07:20:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E2506C433C7;
	Fri, 22 Sep 2023 07:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695367223;
	bh=5hO3aI2VEexFfns3lA0Y+k0/kuTBVoUzUD98Od7nlTA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Atu0Tq/PtuTxuaHw/uaAPqCVh4WYpjYInukeDnGzB1Y3UcAojbBeir9m753InRXVY
	 mhPy3jKSxiTUXfphd7kR820Z1bOZ8vMlSEOdNYhwpgozXiUDTLhwQOyDjvKSnfunuA
	 4zCpA97fHtIlILwvKK3TNbkcSWpoiOgszB3SY1wJpZfDp5tgMljL3sdihe/tW5fWKz
	 dJjCQCeyQk6D+zAqmvin8RSmRxEet44wWBrTMqXXhAx6QQTRLDtU1q0PrufvNdHKfL
	 odYA25hDMnTeQi/tgw4LtJk+3meW/OzNsdBASw0pzsp8WahC2YGnKi3TtSXiDANHYF
	 igU/U0SDRFw6Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C3763E11F5C;
	Fri, 22 Sep 2023 07:20:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v5] drivers/net: process the result of hdlc_open() and add
 call of hdlc_close() in uhdlc_close()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169536722279.5471.17948488671485747315.git-patchwork-notify@kernel.org>
Date: Fri, 22 Sep 2023 07:20:22 +0000
References: <20230919142502.13898-1-adiupina@astralinux.ru>
In-Reply-To: <20230919142502.13898-1-adiupina@astralinux.ru>
To: Alexandra Diupina <adiupina@astralinux.ru>
Cc: qiang.zhao@nxp.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 19 Sep 2023 17:25:02 +0300 you wrote:
> Process the result of hdlc_open() and call uhdlc_close()
> in case of an error. It is necessary to pass the error
> code up the control flow, similar to a possible
> error in request_irq().
> Also add a hdlc_close() call to the uhdlc_close()
> because the comment to hdlc_close() says it must be called
> by the hardware driver when the HDLC device is being closed
> 
> [...]

Here is the summary with links:
  - [v5] drivers/net: process the result of hdlc_open() and add call of hdlc_close() in uhdlc_close()
    https://git.kernel.org/netdev/net/c/a59addacf899

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



