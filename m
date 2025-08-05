Return-Path: <netdev+bounces-211832-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 857F1B1BD01
	for <lists+netdev@lfdr.de>; Wed,  6 Aug 2025 01:20:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 339D41851E7
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 23:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 810992BE028;
	Tue,  5 Aug 2025 23:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W58rDV6M"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1F62BDC3F;
	Tue,  5 Aug 2025 23:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754436002; cv=none; b=igC7+LhQFfjpm6ccbEPJvLP4/yKUev4YVsFO37W50O+IYVEK3817qgNnL/nQVTntan4nutxAfltQ+ypGyloBg/UvuJCDEmLD3Vkkjc/9wZZ06OLqk4oP2tXS6BRxFnK9YW2pDWA5Bg1eQT7S8Uo4doXYff1czy53eHQhfXJbrYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754436002; c=relaxed/simple;
	bh=wvpbLAqIOfvBAJ6bqJ7WNNSzI/BDA8VuN7oo1gaFoWI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HOUUwLslCx9QlQy8P6HR3NTmLtG4Ip/1xO/pxZ12PjGKFQoA+8M8AQ5q58qjgkC7rTWgd/oDI6z/J1qBqr0EfJTRyR13N2O0lXCko+myTG2Ti6FiYlDuh842xIZKcueCjVYINtzd17Vp+uPxtBT9+wOFTJ3Hwfx1A/uk/DUtZWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W58rDV6M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E17EAC4CEF0;
	Tue,  5 Aug 2025 23:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754436001;
	bh=wvpbLAqIOfvBAJ6bqJ7WNNSzI/BDA8VuN7oo1gaFoWI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=W58rDV6MVusuPqs8SItigX7sIMr6Pfx3tqu7P7QJmvrXKPipkqPrbcGo5CVZpbIm6
	 UqActsGswlNLAlHZvFJMUwoIXnDHWsMJjKBmXG499Y7hZSm6AQbk23UOgrYvIl7diO
	 5OXuaZEg9m5zUMw0rc01UJ24zAuxoYpY9odmw6M0q5ZojydXI9+ETogVDtfqk12/XY
	 ZgH/EGfscyuRvEteSlmQOa7mmXVGh0R2PMLU+0ENMBUO2yQC9KdhOo8canXjTZkgAs
	 cM21Qx5jrnxJAUW9qxn6UPKjLaazj4VwD6Y/43BqcOJ4+8mIAzV//7cWyF+WQVSQNx
	 ujtd0ZmGIKnmA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33AE6383BF63;
	Tue,  5 Aug 2025 23:20:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/2] eth: fbnic: Fix drop stats support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175443601574.2197607.15706911174673052016.git-patchwork-notify@kernel.org>
Date: Tue, 05 Aug 2025 23:20:15 +0000
References: <20250802024636.679317-1-mohsin.bashr@gmail.com>
In-Reply-To: <20250802024636.679317-1-mohsin.bashr@gmail.com>
To: Mohsin Bashir <mohsin.bashr@gmail.com>
Cc: netdev@vger.kernel.org, alexanderduyck@fb.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, horms@kernel.org,
 kernel-team@meta.com, kuba@kernel.org, linux-kernel@vger.kernel.org,
 pabeni@redhat.com, sdf@fomichev.me, vadim.fedorenko@linux.dev

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  1 Aug 2025 19:46:34 -0700 you wrote:
> Fix hardware drop stats support on the TX path of fbnic by addressing two
> issues: ensure that tx_dropped stats are correctly copied to the
> rtnl_link_stats64 struct, and protect the copying of drop stats from
> fdb->hw_stats to the local variable with the hw_stats_lock to
> ensure consistency.
> 
> Mohsin Bashir (2):
>   eth: fbnic: Fix tx_dropped reporting
>   eth: fbnic: Lock the tx_dropped update
> 
> [...]

Here is the summary with links:
  - [net,1/2] eth: fbnic: Fix tx_dropped reporting
    https://git.kernel.org/netdev/net/c/2972395d8fad
  - [net,2/2] eth: fbnic: Lock the tx_dropped update
    https://git.kernel.org/netdev/net/c/53abd9c86fd0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



