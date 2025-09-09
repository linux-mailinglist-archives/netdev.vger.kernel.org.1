Return-Path: <netdev+bounces-221052-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2D26B49F64
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 04:50:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A7A218948F9
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 02:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89F70256C70;
	Tue,  9 Sep 2025 02:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pXtrPV8x"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61009254AE1;
	Tue,  9 Sep 2025 02:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757386205; cv=none; b=JxUMSTq1AS3TOWWfgGwVxkHbAPB0b2P0rhAmPBiKsmfoGBcg5yS/EbuWZGUeyoQPnABSCOaaX5yPF/oG5DTbQFY6KblC+Jlpj0mJUpLlsI6uM56cogDkhuxVeZxJ1vViyler8nXF0BDMqAl+BIErphloEjMf1WxImQggWitz/xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757386205; c=relaxed/simple;
	bh=X9h8gsf1ObUnt8Gd4B/3MJGHnV1nvndom2USKmP1z50=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TO33TMn1zQQbuHFM0MiYsb9lTUHI6IBgZDlAg5az5A0ZzYAmF8DiK2C14xBlz8wYVcweUoQKnVfviaf/5p24Cu9mxuOTfBjDx7cUcp/ijvuVuGAU0Vod0f1Z8QSMezGNvF3XQtjWwtwcPlanq1qnO5mTbtK5xrIwf5eIA0nIrWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pXtrPV8x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE0ABC4CEF5;
	Tue,  9 Sep 2025 02:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757386204;
	bh=X9h8gsf1ObUnt8Gd4B/3MJGHnV1nvndom2USKmP1z50=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pXtrPV8xsfnamcdKo3lIl43xgKV+5eNABN2KgCSZL3zVW5qVmipxA08I8BPdw5ERj
	 NFE6Kq1e5CO+vHCZms1/pI4QqXAUED8fHDTF75TbOicfLCH+S+qA24JtniluP13gEP
	 GI3oR3YOtlXod9KNf2VhA+FdVl38OZYolDhnxypZc3ZlxqtSOia+ONxyG8Xk3XTs+L
	 bR5uq6HvHqX9OsaUUl6+EE08sDIX/SbnnmX4+gikepwoZhp1Cj7Wwd88fuxzCUfplB
	 +3pzSZLf3InT1CM7yvlQsFbUBVRJk83wnqFErVIMU91Lo/S9VcqrwnPQZ4FS1XtrJv
	 zMtuHKxbgN7FQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 8A800383BF69;
	Tue,  9 Sep 2025 02:50:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: bridge: Bounce invalid boolopts
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175738620849.122970.5467761237713333709.git-patchwork-notify@kernel.org>
Date: Tue, 09 Sep 2025 02:50:08 +0000
References: 
 <e6fdca3b5a8d54183fbda075daffef38bdd7ddce.1757070067.git.petrm@nvidia.com>
In-Reply-To: 
 <e6fdca3b5a8d54183fbda075daffef38bdd7ddce.1757070067.git.petrm@nvidia.com>
To: Petr Machata <petrm@nvidia.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, horms@kernel.org, andrew@lunn.ch,
 razor@blackwall.org, idosch@nvidia.com, bridge@lists.linux.dev,
 mlxsw@nvidia.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 5 Sep 2025 13:12:33 +0200 you wrote:
> The bridge driver currently tolerates options that it does not recognize.
> Instead, it should bounce them.
> 
> Fixes: a428afe82f98 ("net: bridge: add support for user-controlled bool options")
> Signed-off-by: Petr Machata <petrm@nvidia.com>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> 
> [...]

Here is the summary with links:
  - [net] net: bridge: Bounce invalid boolopts
    https://git.kernel.org/netdev/net/c/8625f5748fea

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



