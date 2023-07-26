Return-Path: <netdev+bounces-21154-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B31D762961
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 05:40:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAD3A281A95
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 03:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E07514400;
	Wed, 26 Jul 2023 03:40:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADAD915C9
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 03:40:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 08AFBC433C9;
	Wed, 26 Jul 2023 03:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690342820;
	bh=J0UZE5rNizJMX3aMH2P21L+Ldc6TotlebXOCVtAm2aY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LNi3wrNFAq9xATUmkYe28gsfQBvaswugpSVLVuYe3+j12HE4f1H5GmjBU+Ib/7Bu2
	 IEplFciP1UgGtpt/TeMKv005ai1ExfOia1oeSHoq00EYB4sjCETJuOAZbmdH/9yDQP
	 AY5OdcrZuAlDHNmQuimxealZ3NzCbVnX40qMVmZSu+GDx1KOfFPnUptzfQZWTF+sn3
	 zkvTqkE35wMVnd44ak02y4uBS+MB4Q8W9HyUllYiMO/8YTavTtHu0WDtLvAHNBjBIF
	 2dr8sVC7Gnj4D6lep4ct9OTA8WhJ4PdIq/ciVJzn4m5LM/R2yD1SXCxpJyuh5R0J2H
	 6KqvdMhGZSbIg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E5D4BC4166D;
	Wed, 26 Jul 2023 03:40:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 net 0/2] net: Fix error/warning by -fstrict-flex-arrays=3.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169034281993.309.4249258551367653856.git-patchwork-notify@kernel.org>
Date: Wed, 26 Jul 2023 03:40:19 +0000
References: <20230724213425.22920-1-kuniyu@amazon.com>
In-Reply-To: <20230724213425.22920-1-kuniyu@amazon.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, willemdebruijn.kernel@gmail.com, keescook@chromium.org,
 gustavoars@kernel.org, leitao@debian.org, kuni1840@gmail.com,
 netdev@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 24 Jul 2023 14:34:23 -0700 you wrote:
> df8fc4e934c1 ("kbuild: Enable -fstrict-flex-arrays=3") started applying
> strict rules for standard string functions (strlen(), memcpy(), etc.) if
> CONFIG_FORTIFY_SOURCE=y.
> 
> This series fixes two false positives caught by syzkaller.
> 
> 
> [...]

Here is the summary with links:
  - [v3,net,1/2] af_unix: Fix fortify_panic() in unix_bind_bsd().
    https://git.kernel.org/netdev/net/c/06d4c8a80836
  - [v3,net,2/2] af_packet: Fix warning of fortified memcpy() in packet_getname().
    https://git.kernel.org/netdev/net/c/a0ade8404c3b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



