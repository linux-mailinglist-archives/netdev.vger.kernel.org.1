Return-Path: <netdev+bounces-61985-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74C398257C2
	for <lists+netdev@lfdr.de>; Fri,  5 Jan 2024 17:10:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C3062844D8
	for <lists+netdev@lfdr.de>; Fri,  5 Jan 2024 16:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B71BB2E832;
	Fri,  5 Jan 2024 16:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bs6BpWcu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E56F2E626
	for <netdev@vger.kernel.org>; Fri,  5 Jan 2024 16:10:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 37296C433C7;
	Fri,  5 Jan 2024 16:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704471027;
	bh=QkeSUuWXftMEYsE/YSKWHLqrVac70oH5siDevWtLdlE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Bs6BpWcuYQ6+ls3FmTQo62MThlI88hDqYBa2CdnPu4XEWawXLXqOAlJJUIkgl3Ffn
	 M3rPTkHojyR8JmlPd/rw6lNfP3AHfhkGvzO2qu6mpUQd00Gz0NTP1NA34FzBzPTbMn
	 tJCV5u8TdLDvpjlER7Oy9UdPSkGH1rqIy6zZuSmCQCVgYT9utH4Xyfaohbn8CpHsTL
	 SdLa7CWeicw8LM+WvpM3BCfcPK/hXDsac9fbeFrq/JiJci9NwfOe4pTpebKUNBCYKI
	 Xw1AQ679Du5+JiQzxPWWbUiPlxwmZoeB3ZAFmkIfA9RDxGWw1pp1j7DMqv5pG+YgRf
	 niFnzngK8Y5vg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1E284C41606;
	Fri,  5 Jan 2024 16:10:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: fill in MODULE_DESCRIPTION()s for CAIF
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170447102712.8824.18193395716634814314.git-patchwork-notify@kernel.org>
Date: Fri, 05 Jan 2024 16:10:27 +0000
References: <20240104144855.1320993-1-kuba@kernel.org>
In-Reply-To: <20240104144855.1320993-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, axboe@kernel.dk, kuniyu@amazon.com, dhowells@redhat.com,
 kbusch@kernel.org, syoshida@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  4 Jan 2024 06:48:55 -0800 you wrote:
> W=1 builds now warn if module is built without a MODULE_DESCRIPTION().
> Add descriptions to all the CAIF sub-modules.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: axboe@kernel.dk
> CC: kuniyu@amazon.com
> CC: dhowells@redhat.com
> CC: kbusch@kernel.org
> CC: syoshida@redhat.com
> 
> [...]

Here is the summary with links:
  - [net-next] net: fill in MODULE_DESCRIPTION()s for CAIF
    https://git.kernel.org/netdev/net-next/c/cb420106901a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



