Return-Path: <netdev+bounces-180568-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DE90A81B2A
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 04:40:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B7A64A8055
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 02:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 811CF18A6CF;
	Wed,  9 Apr 2025 02:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vg98Lmv2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589DF16FF37;
	Wed,  9 Apr 2025 02:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744166412; cv=none; b=UQ5s1IiLdfyLNyQb/y6zWDQjsUC9tT+5qtMzFKmoKu3Lt/QJnOQpgZCj6aRy9kbocsQPIzxBuTqI50jzKSGoqYDKYi98Z9FjEzNmIU1cTBqvokBR9s3gDFUZbmwCNYSVBN8j/5H7anh80E+VrHBphFSyqcWmM6PirAIaS7wJAk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744166412; c=relaxed/simple;
	bh=bSzcio7IDj6Y0wwhWkJcBwAQlNfvv5mIiVbGYUzV1WA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tYksO+NsYDB710pl7g+TJky/a/MEMi77Nlt/lGNugmnCMT9AF3OLetyr4ggV1pFa2KGQPQdMBHNRoQljswqyj+odAMJVvkKp4L6Fdxuh2cELLUHaZHzMe2Wtfquoqt0ZbVg3etgutw53Ol3d+r5fHo6QPqQgR3jgP8At1lW8P0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vg98Lmv2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E817C4CEE5;
	Wed,  9 Apr 2025 02:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744166412;
	bh=bSzcio7IDj6Y0wwhWkJcBwAQlNfvv5mIiVbGYUzV1WA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Vg98Lmv2jF5zRnJz5XXwGn3xdhPsJrmRdU41lTYCvJ5iZyN6Ywf0PedE7F66AG+CE
	 U8qr0PJWARTcy18aESgKmkfu3Gg3Giq3PGpaWnQPGxk/f96s9O7kOReuB8S64v8Png
	 KRlgohc5yifaFA8NX6scdYGTWvlAwLHhf/mMPB60DuRx2uCY2KIRUCGCSSB/0N9TGK
	 OQsM9SZxfA+rib4WQuqtyKTtrebBIooUVtY6TCgbQZ0WeWgKWWFCWOJXf+rREoZ5MD
	 PXR/J69up98esRNanTp0J2eCXp/vjzNbtARV0EEHd951eCQQp+qATX1FRqQa+3hP8v
	 +p+t7KaCvYONg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE21A38111D4;
	Wed,  9 Apr 2025 02:40:50 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: Drop unused @sk of
 __skb_try_recv_from_queue()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174416644934.2289933.6913898922606163380.git-patchwork-notify@kernel.org>
Date: Wed, 09 Apr 2025 02:40:49 +0000
References: <20250407-cleanup-drop-param-sk-v1-1-cd076979afac@rbox.co>
In-Reply-To: <20250407-cleanup-drop-param-sk-v1-1-cd076979afac@rbox.co>
To: Michal Luczaj <mhal@rbox.co>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, willemdebruijn.kernel@gmail.com,
 dsahern@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 07 Apr 2025 21:01:02 +0200 you wrote:
> __skb_try_recv_from_queue() deals with a queue, @sk is never used.
> Remove sk from function parameters, adapt callers.
> 
> No functional change intended.
> 
> Signed-off-by: Michal Luczaj <mhal@rbox.co>
> 
> [...]

Here is the summary with links:
  - [net-next] net: Drop unused @sk of __skb_try_recv_from_queue()
    https://git.kernel.org/netdev/net-next/c/420aabef3ab5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



