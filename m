Return-Path: <netdev+bounces-60876-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 226D3821BC5
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 13:40:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 493EA1C21602
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 12:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 585B3F505;
	Tue,  2 Jan 2024 12:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EeTOcYM0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF52F4F7
	for <netdev@vger.kernel.org>; Tue,  2 Jan 2024 12:40:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B211EC433C7;
	Tue,  2 Jan 2024 12:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704199225;
	bh=j3oYsOyYnYX9dvi44F11vbGEbnF1DLGwLNaTKr62YRk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EeTOcYM0C3TVig/XcupV61ozJkv4qf6qYtPvTS0q6Y5wdMDrH2p6EEBovcxxO0GZz
	 0+pid6xpZrTVhWNoeZP5vaYOUDS4CnrvHazuOxzaxXiGHs9InuWTyhWG2CAIZbB3CY
	 YUebW/CZiZRfFnNCmfJz9s12eHf1Y1EKGYWjMq24riIdavkbTOeK/7Pr9Mc5tdF+2J
	 YKwHmzzI1UZFGZrm9qB3pTFYqr52KrW5w3leedJccBdWSMf+0uD60msM4VCeF3nav7
	 QBiwytKVuTD2KlcrbF5KmCUYCv44ezfb9lM/GVWRjv0ClvxFyMoD70vD+AUW8uN9Qw
	 4sGdj8N8j3I9g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 97E9DC395C5;
	Tue,  2 Jan 2024 12:40:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net-device: move gso_partial_features to
 net_device_read_tx
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170419922560.22517.12019488602499924964.git-patchwork-notify@kernel.org>
Date: Tue, 02 Jan 2024 12:40:25 +0000
References: <20231221140747.1171134-1-edumazet@google.com>
In-Reply-To: <20231221140747.1171134-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 willemb@google.com, netdev@vger.kernel.org, eric.dumazet@gmail.com,
 lixiaoyan@google.com, dsahern@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 21 Dec 2023 14:07:47 +0000 you wrote:
> dev->gso_partial_features is read from tx fast path for GSO packets.
> 
> Move it to appropriate section to avoid a cache line miss.
> 
> Fixes: 43a71cd66b9c ("net-device: reorganize net_device fast path variables")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Coco Li <lixiaoyan@google.com>
> Cc: David Ahern <dsahern@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net-next] net-device: move gso_partial_features to net_device_read_tx
    https://git.kernel.org/netdev/net-next/c/993498e537af

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



