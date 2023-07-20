Return-Path: <netdev+bounces-19339-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6BE275A50F
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 06:21:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93093281BFA
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 04:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B28F320FE;
	Thu, 20 Jul 2023 04:20:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4022920FF
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 04:20:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B5F48C43397;
	Thu, 20 Jul 2023 04:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689826821;
	bh=Bk2LPRHkkD9EX6U+/4vMPDW1uHR2jFXPcpGmyMAj8pg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=l2MMCIPpPCTZjWFpX5pqdy6eGbJwO70Vz4WwQ9zbXd4BFX8mMte3QdIopvHXrYAE3
	 OJZcKfcvaSypi038G3qCTRT/JGlfHpwp21LDLhpdc1WBZudaeVqQvA5jekzjsjJ2l4
	 DXYUPL/VhQxP9b45kjMtVuPYmrl9cRM/YcAH8lsuAqLhNz9Uqol1UqTNmoh5hxKkrs
	 MIGpulPw1aWRzwC3N+yyIdXaOxQIQLF+S1gsJSh8j7GeWdCFs7DV19cT41RnEkmTu4
	 v7zshqvjjUgswUmJMfB+90YqVLxVtBdu5xqK1AuEAjtsCD8B4Cq62uU0hs3T+ioW/H
	 THVSx6ditxaGg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9D317E21EFE;
	Thu, 20 Jul 2023 04:20:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next] udp: use indirect call wrapper for data ready()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168982682163.14645.16342033613372009667.git-patchwork-notify@kernel.org>
Date: Thu, 20 Jul 2023 04:20:21 +0000
References: <d47d53e6f8ee7a11228ca2f025d6243cc04b77f3.1689691004.git.pabeni@redhat.com>
In-Reply-To: <d47d53e6f8ee7a11228ca2f025d6243cc04b77f3.1689691004.git.pabeni@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, willemdebruijn.kernel@gmail.com,
 davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, kuba@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 18 Jul 2023 16:38:09 +0200 you wrote:
> In most cases UDP sockets use the default data ready callback.
> Leverage the indirect call wrapper for such callback to avoid an
> indirect call in fastpath.
> 
> The above gives small but measurable performance gain under UDP flood.
> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> 
> [...]

Here is the summary with links:
  - [v2,net-next] udp: use indirect call wrapper for data ready()
    https://git.kernel.org/netdev/net-next/c/0558e1674598

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



