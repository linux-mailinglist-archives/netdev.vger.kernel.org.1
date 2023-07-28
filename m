Return-Path: <netdev+bounces-22209-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD9E576680A
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 11:01:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9870728269A
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 09:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E5261095F;
	Fri, 28 Jul 2023 09:00:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF7C107AE
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 09:00:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 15F80C433BC;
	Fri, 28 Jul 2023 09:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690534828;
	bh=OZLB1TlYuhOUluQEOXMdJljYbREOPCoaejaLskUJsro=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KP31QNIhYbIcx4YnOIeBngeqJ/TqKNaQlTPAkwUcsyvMASu+cpPZhgtiFJU+vtHSG
	 zCu/91fHASrD/iZSKBVWdQmg6n4GcOG5oHeYkdEYOmbtywJRgmON+lvhPc7tYkWitd
	 W8FvanvoUfpVGBbN5uNCm/VT9NqeuCAaUoJiKIiTHwyiuIPuT/d+Zpk8XaGE2/OEEL
	 jP3Rotg4WtxzPVDAJPLqd58HlXi8DEE0K3o+gIuZPCV5gyg/GvuH37ZFWoJdVFup75
	 AVRDnhgel8UI5FpvSsN/ngRSutZ3bzMrWqLzM40XtPB2KOoR0fqy3pS3ltGcGwT6Gl
	 UiHpQEjQ3cfug==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id ED0B2C39562;
	Fri, 28 Jul 2023 09:00:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next v2 0/2] rxfh with custom RSS fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169053482796.22021.4158483891713381939.git-patchwork-notify@kernel.org>
Date: Fri, 28 Jul 2023 09:00:27 +0000
References: <20230725205655.310165-1-jdamato@fastly.com>
In-Reply-To: <20230725205655.310165-1-jdamato@fastly.com>
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, saeedm@nvidia.com, tariqt@nvidia.com,
 ecree@solarflare.com, andrew@lunn.ch, kuba@kernel.org, davem@davemloft.net,
 leon@kernel.org, pabeni@redhat.com, arnd@arndb.de,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 25 Jul 2023 20:56:53 +0000 you wrote:
> Greetings:
> 
> Welcome to v2, now via net-next. No functional changes; only style
> changes (see the summary below).
> 
> While attempting to get the RX flow hash key for a custom RSS context on
> my mlx5 NIC, I got an error:
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/2] net: ethtool: Unify ETHTOOL_{G,S}RXFH rxnfc copy
    https://git.kernel.org/netdev/net-next/c/801b27e88046
  - [net-next,v2,2/2] net/mlx5: Fix flowhash key set/get for custom RSS
    https://git.kernel.org/netdev/net-next/c/0212e5d915a2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



