Return-Path: <netdev+bounces-13256-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 997E073AEF1
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 05:10:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 543AC2818B2
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 03:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A431038C;
	Fri, 23 Jun 2023 03:10:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E399C7E0
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 03:10:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 767B9C433CD;
	Fri, 23 Jun 2023 03:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687489821;
	bh=iaaUecfmjsyxg1Xzi58aBuLGBUafPHjOTk7jbDJm+as=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Lefg7V6ja/xfjLwlV0+KupLDjkVgELyTJH2SSntVUryfymZJ8OJZFYF+5SXSyzPpA
	 970lPkmeWdz6XIS0QsRo16AzTMRmp+SAcTpOuTmjcqmVHpUkwE+MPuTaL/ebG78U7q
	 HM2sGDcWENJF5TRRL+GHqLXFioIN4bD0uQtTXQx7wDY1QT+QKa08QrUZmng4Yz2OHl
	 auUlvVNfnoYjCQf2tXTgrWEXQY8r6P2m0CW4cGykpcZ9nxzGwnuepERI0uLocbTnbW
	 /klR2FJYqUzQUtT1ewt35Sr/6l8d11nhVSVRPwUT2R8H/A768VQh7qjPJ1DYUjOqTX
	 2Lqs4EKuY3t+Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 598F7C395FF;
	Fri, 23 Jun 2023 03:10:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] can: isotp: isotp_sendmsg(): fix return error fix on TX
 path
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168748982135.10729.12075135784970212786.git-patchwork-notify@kernel.org>
Date: Fri, 23 Jun 2023 03:10:21 +0000
References: <20230622090122.574506-2-mkl@pengutronix.de>
In-Reply-To: <20230622090122.574506-2-mkl@pengutronix.de>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de, socketcan@hartkopp.net,
 carsten.schmidt-achim@t-online.de, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Marc Kleine-Budde <mkl@pengutronix.de>:

On Thu, 22 Jun 2023 11:01:22 +0200 you wrote:
> From: Oliver Hartkopp <socketcan@hartkopp.net>
> 
> With commit d674a8f123b4 ("can: isotp: isotp_sendmsg(): fix return
> error on FC timeout on TX path") the missing correct return value in
> the case of a protocol error was introduced.
> 
> But the way the error value has been read and sent to the user space
> does not follow the common scheme to clear the error after reading
> which is provided by the sock_error() function. This leads to an error
> report at the following write() attempt although everything should be
> working.
> 
> [...]

Here is the summary with links:
  - [net] can: isotp: isotp_sendmsg(): fix return error fix on TX path
    https://git.kernel.org/netdev/net/c/e38910c0072b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



