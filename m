Return-Path: <netdev+bounces-21850-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC3F876509B
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 12:10:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A91A1C21523
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 10:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A0213AE5;
	Thu, 27 Jul 2023 10:10:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0969D107AD
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 10:10:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4E620C433C9;
	Thu, 27 Jul 2023 10:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690452621;
	bh=V8cRhjjMjy0S96MMHGyJjXFao2r6oszoTlft5F/lo94=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XAmD/75Akb6sePqlWJX10dhM6Y0Bw3xikdxF2TFxaWS7lvQQaroZudPo7y6p4KS8L
	 9ilRLPBmRIV8X0BM8ou/GAKTb3p8WVX6WU8vt08hXHjmjUDxR2s/BwnKWwFkWj6bM0
	 obF5xXe/Tg8fBQ6co2e1Ws/Ke9HlFK/KcrOPXLqotsFWA+U01ZRP/LxiNb4MopzKer
	 PiHK1JoTMI/Mdxb0V9iD7eNYmMa7fng0OlP8pPxrSImldse/Gw91W6s6z9E3TWc52z
	 OSgbUoFk3OZffrCMWwibOszCGpaGY9ytT40wTDiYRh+AjC5JlMhu6wxWYLKg9JMtyb
	 yeqmIFpGzvA8g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 347B2C595D0;
	Thu, 27 Jul 2023 10:10:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] tipc: stop tipc crypto on failure in tipc_node_create
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169045262121.6409.17871887881657519923.git-patchwork-notify@kernel.org>
Date: Thu, 27 Jul 2023 10:10:21 +0000
References: <20230725214628.25246-1-pchelkin@ispras.ru>
In-Reply-To: <20230725214628.25246-1-pchelkin@ispras.ru>
To: Fedor Pchelkin <pchelkin@ispras.ru>
Cc: jmaloy@redhat.com, ying.xue@windriver.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 lucien.xin@gmail.com, netdev@vger.kernel.org,
 tipc-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 khoroshilov@ispras.ru, lvc-project@linuxtesting.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 26 Jul 2023 00:46:25 +0300 you wrote:
> If tipc_link_bc_create() fails inside tipc_node_create() for a newly
> allocated tipc node then we should stop its tipc crypto and free the
> resources allocated with a call to tipc_crypto_start().
> 
> As the node ref is initialized to one to that point, just put the ref on
> tipc_link_bc_create() error case that would lead to tipc_node_free() be
> eventually executed and properly clean the node and its crypto resources.
> 
> [...]

Here is the summary with links:
  - [v2] tipc: stop tipc crypto on failure in tipc_node_create
    https://git.kernel.org/netdev/net/c/de52e17326c3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



