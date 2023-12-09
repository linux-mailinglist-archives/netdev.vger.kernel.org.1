Return-Path: <netdev+bounces-55501-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BA5080B0E5
	for <lists+netdev@lfdr.de>; Sat,  9 Dec 2023 01:20:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99B0F1C20B51
	for <lists+netdev@lfdr.de>; Sat,  9 Dec 2023 00:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 049F762B;
	Sat,  9 Dec 2023 00:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kaztp95a"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6427386
	for <netdev@vger.kernel.org>; Sat,  9 Dec 2023 00:20:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 43626C433C9;
	Sat,  9 Dec 2023 00:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702081229;
	bh=JUpRHMdkb4y7BJvcT7lF2H+EfHcoSe7p6Xwoi54/epk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kaztp95a0TeWk6y5yOaOUtQxL4OebMGzT4nkLyOowrQQ5nAmi3srYPEWhfyZfVYie
	 XD/OdPoxwQCZrTshUFavcZYMMh/1EwFADD2rwoLidJN1zoRAvEKgrdC8a6kPb4tbZ5
	 tmjybdkthakoM3H65G/j23rEphZ72Nvbj9tdV+TKdUd2REpKAdc8TC2h8CJ5t2+9gD
	 /BZ6REELfmw6QnX396aNEzHXHQG/fINeS/kTAtMpwNAPeJFxeBn4kXR8xoHdN3krMw
	 hv472llEWU/Y7IWGRJgR5QUBO9MHO7wPhQ+qYwCI9Xms/GQSPFuciXOfjkvJ8Z11o6
	 f9JtSS0HreAgA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 29DB2C04E32;
	Sat,  9 Dec 2023 00:20:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH V3 0/3] qca_spi: collection of major fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170208122916.21357.8920685426589017304.git-patchwork-notify@kernel.org>
Date: Sat, 09 Dec 2023 00:20:29 +0000
References: <20231206141222.52029-1-wahrenst@gmx.net>
In-Reply-To: <20231206141222.52029-1-wahrenst@gmx.net>
To: Stefan Wahren <wahrenst@gmx.net>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  6 Dec 2023 15:12:19 +0100 you wrote:
> This series contains a collection of major fixes for the qca_spi driver,
> which has been recently discovered.
> 
> Changes in V3:
> - Avoid race condition in qcaspi_set_ringparam() as reported by Jakub and
>   move all traffic handling within qcaspi_spi_thread
> - use netif_tx_disable instead of netif_stop_queue
> 
> [...]

Here is the summary with links:
  - [V3,1/3] qca_debug: Prevent crash on TX ring changes
    https://git.kernel.org/netdev/net/c/f4e6064c97c0
  - [V3,2/3] qca_debug: Fix ethtool -G iface tx behavior
    https://git.kernel.org/netdev/net/c/96a7e861d9e0
  - [V3,3/3] qca_spi: Fix reset behavior
    https://git.kernel.org/netdev/net/c/1057812d146d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



