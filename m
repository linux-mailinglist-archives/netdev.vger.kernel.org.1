Return-Path: <netdev+bounces-12922-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E28E739710
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 07:53:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A52728186A
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 05:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63C875666;
	Thu, 22 Jun 2023 05:50:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CBB9522B
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 05:50:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9A483C433C0;
	Thu, 22 Jun 2023 05:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687413029;
	bh=ZJBDTdxoCUFzklQsIykbgqj0gcKDQuMJw2gc275O1rA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=If+9svqpC5kpJXtOXBDcnXn9UKBF1ZFz162Yu0YMVLkXKe9H7ydacHbNYGo5N2ijT
	 jPSZlMhAhvqN5xrJ0xEfC4A6NkJcuZaJjAS36bY5iU5B3/qT+U59p5TBY0cuYnwOPG
	 u+MwD0nvOJFxgSbJ5WXa0yfGjRcnJX1lp1pd3Ru2XCk2oIX14AWH+7sdtI3ghxQLoe
	 Vw777uNdiOpMD6i5ntVG9VtSTJjX6gHppcV9P6Ma92IZZ0GdpcpaUCzUvMizIlrNFI
	 s9V24Vrb8Meez6b20tS2syLvBIWu/ltSxnlykqNkdQyLhTkmsVz61zAEL8e6kAuzKm
	 yika2o/f0+F3g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6E2D5E4D027;
	Thu, 22 Jun 2023 05:50:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] inet: Cleanup on charging memory for newly
 accepted sockets
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168741302944.1197.12962837950149301693.git-patchwork-notify@kernel.org>
Date: Thu, 22 Jun 2023 05:50:29 +0000
References: <20230620092712.16217-1-wuyun.abel@bytedance.com>
In-Reply-To: <20230620092712.16217-1-wuyun.abel@bytedance.com>
To: Abel Wu <wuyun.abel@bytedance.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 20 Jun 2023 17:27:11 +0800 you wrote:
> If there is no net-memcg associated with the sock, don't bother
> calculating its memory usage for charge.
> 
> Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
> ---
>  net/ipv4/inet_connection_sock.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)

Here is the summary with links:
  - [net-next,v2] inet: Cleanup on charging memory for newly accepted sockets
    https://git.kernel.org/netdev/net-next/c/53bf91641ae1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



