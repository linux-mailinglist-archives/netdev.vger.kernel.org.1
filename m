Return-Path: <netdev+bounces-54272-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E59D1806666
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 06:00:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74933281EAB
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 05:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D38CA64;
	Wed,  6 Dec 2023 05:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="latEOZOw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C091108
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 05:00:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DD800C43391;
	Wed,  6 Dec 2023 05:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701838828;
	bh=4pxRTaVFxoiOaxvRP4+Z6ZPIhZNRWgbWVGl6SWfqsj4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=latEOZOwSrhw7cEjl3j9sAUfae2licnbpJoRMbJUrWyFdhQoxLMNpObLcSpH5kSBT
	 dV6Y20COuMxY+cvxDQc23ISPOxN++mPt/zaMJY9b9PAy5I1qvmnZJTXlD4YtDSHoMC
	 DlCe4DaFYW79RRXW7YSIEYtqOgn2cUtkfwGMNTVsUDy6R6SwA1mZLigG3oQsXWk9I+
	 D+d00bGVjHP/fikz8VtvxUJ1SagT+madvrw+NTcLcjggAtXWdh742/WKVuJ+ytmxJB
	 r7SCwyIURY46b16zIEQOwiBV+XEQ6+ZcyjENSNYdAR+I8aRMAjU3G9aOQGi5KYgUOe
	 HIGjuwHI/CJlQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BC0F6C1614E;
	Wed,  6 Dec 2023 05:00:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net-next] Documentations: fix net_cachelines documentation
 build warning
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170183882876.31476.9036346910069765189.git-patchwork-notify@kernel.org>
Date: Wed, 06 Dec 2023 05:00:28 +0000
References: <20231204220728.746134-1-lixiaoyan@google.com>
In-Reply-To: <20231204220728.746134-1-lixiaoyan@google.com>
To: Coco Li <lixiaoyan@google.com>
Cc: kuba@kernel.org, edumazet@google.com, ncardwell@google.com,
 mubashirq@google.com, pabeni@redhat.com, andrew@lunn.ch, corbet@lwn.net,
 dsahern@kernel.org, daniel@iogearbox.net, netdev@vger.kernel.org,
 wwchao@google.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  4 Dec 2023 22:07:28 +0000 you wrote:
> Original errors:
> Documentation/networking/net_cachelines/index.rst:3: WARNING: Explicit markup ends without a blank line; unexpected unindent.
> Documentation/networking/net_cachelines/inet_connection_sock.rst:3: WARNING: Explicit markup ends without a blank line; unexpected unindent.
> Documentation/networking/net_cachelines/inet_sock.rst:3: WARNING: Explicit markup ends without a blank line; unexpected unindent.
> Documentation/networking/net_cachelines/net_device.rst:3: WARNING: Explicit markup ends without a blank line; unexpected unindent.
> Documentation/networking/net_cachelines/netns_ipv4_sysctl.rst:3: WARNING: Explicit markup ends without a blank line; unexpected unindent.
> Documentation/networking/net_cachelines/snmp.rst:3: WARNING: Explicit markup ends without a blank line; unexpected unindent.
> Documentation/networking/net_cachelines/tcp_sock.rst:3: WARNING: Explicit markup ends without a blank line; unexpected unindent.
> 
> [...]

Here is the summary with links:
  - [v1,net-next] Documentations: fix net_cachelines documentation build warning
    https://git.kernel.org/netdev/net-next/c/19b707c3f23a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



