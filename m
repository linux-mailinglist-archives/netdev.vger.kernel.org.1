Return-Path: <netdev+bounces-44479-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FED77D839C
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 15:30:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8ADF6B20FF1
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 13:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF5BF2E3E1;
	Thu, 26 Oct 2023 13:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D+XU9HB7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E552DF87
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 13:30:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9C53DC433C8;
	Thu, 26 Oct 2023 13:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698327026;
	bh=pFp2YBd4VyYE7lA/RZtlxRg6vfQXE6WJqS+if9pEY+o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=D+XU9HB7BRRP6sB4v41mdsFp5k4taEv0LgLyGCvaxonqB1qfaV4Stj9rWh56IHVY1
	 +dkBvs0WvWSiT+999vUHAafREuhDEIprUTiS4CtnnC3UI2CK8BpEnGIqCKQp6hbN4w
	 oS/U2ugIHvB4Fin/OZOIAlxlcrgI92yAAskseClrUAs2B3srH3RPYGaMLTeUk5TXDj
	 tmIlkUABO0rklTeLT9Zqt8ez2c+ktzEC5Nu/Wf8sgsQ/pEUEUB8h2FHFAu7AOpMOy8
	 i7kPwPsWKEZux8FJfpYVrnNypAoJQJx7KTpEdmXyi2CoS44IE6QijOUJbmDKbrRw+O
	 iN8lLuLYxm6bQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7ADE2C3959F;
	Thu, 26 Oct 2023 13:30:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] bareudp: use ports to lookup route
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169832702649.29524.3769483651661946849.git-patchwork-notify@kernel.org>
Date: Thu, 26 Oct 2023 13:30:26 +0000
References: <20231025094441.417464-1-b.galvani@gmail.com>
In-Reply-To: <20231025094441.417464-1-b.galvani@gmail.com>
To: Beniamino Galvani <b.galvani@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org, gnault@redhat.com,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 25 Oct 2023 11:44:41 +0200 you wrote:
> The source and destination ports should be taken into account when
> determining the route destination; they can affect the result, for
> example in case there are routing rules defined.
> 
> Signed-off-by: Beniamino Galvani <b.galvani@gmail.com>
> ---
>  drivers/net/bareudp.c | 29 ++++++++++++++++-------------
>  1 file changed, 16 insertions(+), 13 deletions(-)

Here is the summary with links:
  - [net-next] bareudp: use ports to lookup route
    https://git.kernel.org/netdev/net-next/c/ef113733c288

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



