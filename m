Return-Path: <netdev+bounces-39793-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D74147C47F5
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 04:50:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED89A1C20C31
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 02:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07CEA5665;
	Wed, 11 Oct 2023 02:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Imt8C45V"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFDE335501
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 02:50:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7BA98C433CB;
	Wed, 11 Oct 2023 02:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696992625;
	bh=itTc/LFP4l+5PcU7h13+eWub1jO9geqzwfGzYxqFdK8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Imt8C45VaqdLmiRnJsbPUwTAPlXgJrHgJYT+3YoVrbXVr3A5aCo84EreOZDzfQ/AF
	 unraQSYfze292Ep7STw1YcRHJWSq5ZX+VYBhtjOSXga6TeObvfbAY4cZ3yjP4aqYdt
	 1AkNlcASq80obYD9Q7LBTUn/ZCtFVqbgyDWDw/3veXy1rKyqzZ1HQGV76vstGrzS5V
	 XPDwR/CD/+UUdXy+C7Z0Wch4Sg4egIkeOEOisk0jWVmL9GA8Ummt6yARUs5uxp5CoN
	 SK8B2JP73xy36Dy2nZ9qW5yoIo9t1mIaTV1AaBAylzHVghjW2dqeOuNsaL4v+/gXAv
	 8ZSEg2W+aJE/A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6316EE11F43;
	Wed, 11 Oct 2023 02:50:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: nfc: fix races in nfc_llcp_sock_get() and
 nfc_llcp_sock_get_sn()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169699262540.24203.12622697332625844625.git-patchwork-notify@kernel.org>
Date: Wed, 11 Oct 2023 02:50:25 +0000
References: <20231009123110.3735515-1-edumazet@google.com>
In-Reply-To: <20231009123110.3735515-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, rootlab@huawei.com,
 krzysztof.kozlowski@linaro.org, w@1wt.eu

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  9 Oct 2023 12:31:10 +0000 you wrote:
> Sili Luo reported a race in nfc_llcp_sock_get(), leading to UAF.
> 
> Getting a reference on the socket found in a lookup while
> holding a lock should happen before releasing the lock.
> 
> nfc_llcp_sock_get_sn() has a similar problem.
> 
> [...]

Here is the summary with links:
  - [net] net: nfc: fix races in nfc_llcp_sock_get() and nfc_llcp_sock_get_sn()
    https://git.kernel.org/netdev/net/c/31c07dffafce

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



