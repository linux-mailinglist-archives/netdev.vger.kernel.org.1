Return-Path: <netdev+bounces-54273-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A7FD806667
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 06:00:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEBB41F216FE
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 05:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 657AAD292;
	Wed,  6 Dec 2023 05:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EIOrew1u"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476BE1FD2
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 05:00:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C786AC433C7;
	Wed,  6 Dec 2023 05:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701838828;
	bh=iUoZ4FwwHz2ZPlWkCNeXTXhBztehBpEjiViB87cRrlo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EIOrew1uiKMjgNYxBSxWlxx/amE0V2U3Y13+cDYjl1N41LJ6tJfRPLd6zwvU9KRz2
	 eNy22ZJ+OQ+9UezDWR3O3xHTM7IVpsLI5l+R3XgQfNE+aDYKiLJ8Lme9aa0c5Wo3QD
	 LGPTSX2rn6/3AfjnmGADZQP+Ar6gOKuNGDmwux6hJSYQzwP0sWWZtQGF3wHGUAzcch
	 B5KHR4Iy6HzmFv28k89MwZiGEqmTmh976Jgfb60sowaNUNhONnGQg3kM3ADzlQIRhb
	 wCBgZJrOv/vxIne6JU41WeH6OP3zlZX5TYL6YVPAHTf2ACnpABDTfR2gtOqRXW4zoZ
	 ljU/5FvBHGp8g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A7C4FC41671;
	Wed,  6 Dec 2023 05:00:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net-next 0/2] Reorganize remaining patch of networking
 struct cachelines
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170183882868.31476.13543190343798643962.git-patchwork-notify@kernel.org>
Date: Wed, 06 Dec 2023 05:00:28 +0000
References: <20231204201232.520025-1-lixiaoyan@google.com>
In-Reply-To: <20231204201232.520025-1-lixiaoyan@google.com>
To: Coco Li <lixiaoyan@google.com>
Cc: kuba@kernel.org, edumazet@google.com, ncardwell@google.com,
 mubashirq@google.com, pabeni@redhat.com, andrew@lunn.ch, corbet@lwn.net,
 dsahern@kernel.org, daniel@iogearbox.net, netdev@vger.kernel.org,
 wwchao@google.com, weiwan@google.com, pnemavat@google.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  4 Dec 2023 20:12:29 +0000 you wrote:
> Rebase patches to top-of-head in https://lwn.net/Articles/951321/ to
> ensure the results of the cacheline savings are still accurate.
> 
> Coco Li (2):
>   net-device: reorganize net_device fast path variables
>   tcp: reorganize tcp_sock fast path variables
> 
> [...]

Here is the summary with links:
  - [v1,net-next,1/2] net-device: reorganize net_device fast path variables
    https://git.kernel.org/netdev/net-next/c/43a71cd66b9c
  - [v1,net-next,2/2] tcp: reorganize tcp_sock fast path variables
    https://git.kernel.org/netdev/net-next/c/d5fed5addb2b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



