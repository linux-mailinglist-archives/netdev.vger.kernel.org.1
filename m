Return-Path: <netdev+bounces-45672-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 686DD7DEF14
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 10:40:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21A7B2819F0
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 09:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A874811C91;
	Thu,  2 Nov 2023 09:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k7BwknFG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F956FBD
	for <netdev@vger.kernel.org>; Thu,  2 Nov 2023 09:40:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E99E2C433C9;
	Thu,  2 Nov 2023 09:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698918024;
	bh=7UEs7fJ1ZxH7Ku2sKGa7TMrZJ/vd/dBfaI1oaM2315s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=k7BwknFGCRgcRPzOdGQVSurloOYmp58TDksCUTH7gDeEj7sGs8u/2+VPyUTY0gDYx
	 yY2bIiOxqb08VyLyXZzMn98mgF4znfbXjWOnTr54+jZjrT8WYupnJsK8ZTketXmB4c
	 ZiHQoNR3PwWU0QYImkWNpW80MbizjiqjzW1ppGs/bkNAiCnLZz8q0zWvtM3hbX5WUW
	 I0Aq6E9tYZMeUs2jLngJaevFmJzfLe3WcH2OFvOXv8VfhMh838kMzqPVNrLR8OVmOD
	 BM+Uc6yU1rZgGTERYPl5wvGZ/iUSnbIo6QegCdALEfktPOgf+kQqGC1KOZPbPnSRIU
	 xisUa3LP+ueFw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CC98AC4316B;
	Thu,  2 Nov 2023 09:40:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] inet: shrink struct flowi_common
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169891802383.16011.17304879305279564451.git-patchwork-notify@kernel.org>
Date: Thu, 02 Nov 2023 09:40:23 +0000
References: <20231025141037.3448203-1-edumazet@google.com>
In-Reply-To: <20231025141037.3448203-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, wenxu@ucloud.cn

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 25 Oct 2023 14:10:37 +0000 you wrote:
> I am looking at syzbot reports triggering kernel stack overflows
> involving a cascade of ipvlan devices.
> 
> We can save 8 bytes in struct flowi_common.
> 
> This patch alone will not fix the issue, but is a start.
> 
> [...]

Here is the summary with links:
  - [net] inet: shrink struct flowi_common
    https://git.kernel.org/netdev/net/c/1726483b79a7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



