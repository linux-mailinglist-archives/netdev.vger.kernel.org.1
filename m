Return-Path: <netdev+bounces-44784-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9022C7D9D2B
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 17:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DB7B1C20F7D
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 15:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B1A337C97;
	Fri, 27 Oct 2023 15:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K7WbKMHf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3BD374F8
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 15:40:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 03DD8C433C7;
	Fri, 27 Oct 2023 15:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698421224;
	bh=Xbjy7GzbGxP+D5+sC3optqF0NrXD5mQ/MsDKW2uKzG0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=K7WbKMHflLfCXGJWxs7FYqVLeSfIRUq2LeBC7JcexlG1ftVFuWS/cdEsOXxoiFqlR
	 jiDXb8pYhrmVuUSx1/BdWuZ08wv0W+nGeX/0pzNl0bh/yW0eM8bVo3cxSAwlBBSKRW
	 AAJgZpfmGmkCwkcuX9GjioPfywydKyKA4RTmMZYHG4wPMYhODGfBYSiEQfeC7OwAwJ
	 G8S6scg5IGYpTRWaVPIbr4t8Y267XQmwfKf7KRZPe5BtHdI5M4dk4mHdJt/klSXz91
	 iXzZZQu1RDg/63wYCYHR8VcxSz5UUSOKvBnfbiX+t58vAC7rXWPoNpu7NuP/EGcgW8
	 sS/WBJsdTVh8g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DD6D5C4316B;
	Fri, 27 Oct 2023 15:40:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: selftests: use ethtool_sprintf()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169842122389.18415.12372296072101239979.git-patchwork-notify@kernel.org>
Date: Fri, 27 Oct 2023 15:40:23 +0000
References: <20231026022916.566661-1-kuba@kernel.org>
In-Reply-To: <20231026022916.566661-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, o.rempel@pengutronix.de

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 25 Oct 2023 19:29:16 -0700 you wrote:
> During a W=1 build GCC 13.2 says:
> 
> net/core/selftests.c: In function ‘net_selftest_get_strings’:
> net/core/selftests.c:404:52: error: ‘%s’ directive output may be truncated writing up to 279 bytes into a region of size 28 [-Werror=format-truncation=]
>   404 |                 snprintf(p, ETH_GSTRING_LEN, "%2d. %s", i + 1,
>       |                                                    ^~
> net/core/selftests.c:404:17: note: ‘snprintf’ output between 5 and 284 bytes into a destination of size 32
>   404 |                 snprintf(p, ETH_GSTRING_LEN, "%2d. %s", i + 1,
>       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   405 |                          net_selftests[i].name);
>       |                          ~~~~~~~~~~~~~~~~~~~~~~
> 
> [...]

Here is the summary with links:
  - [net-next] net: selftests: use ethtool_sprintf()
    https://git.kernel.org/netdev/net-next/c/79fa29570bd3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



