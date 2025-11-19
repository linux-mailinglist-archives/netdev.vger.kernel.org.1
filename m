Return-Path: <netdev+bounces-239783-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DF5CAC6C6A4
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 03:40:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C8B264E58A4
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 02:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E344128B40E;
	Wed, 19 Nov 2025 02:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="njY+/VZf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE00828A72B
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 02:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763520048; cv=none; b=tWdwJvM3Ac4GRRQD68qjZlo+A1b/LBXvGjPad1txhAcTFRs/VbVwjXNDTs/CU0oVjqOTFOaBV0fyTjQOPz5XvswRlKPibWGlslSB9Xuf/t4zDwSZ73mR1B185BIB9PzsMyUBOc1DRsG7DLL+dIWxYv6y7jDyrprJCmRwxZ/mduU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763520048; c=relaxed/simple;
	bh=yxXYBd0xWdDeiInN/ja+xbwyqwV1lahWrWZIkYcLivU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CCzJN9ZTQAr7y2F9ug7BzxeuDbs1FwULS2/2khJJJtUvbSfl1iQix6hz0SeOr6qZIhhSSgzK2BNi+qfauCSxvK9Bz8OPHGl99qIFgBCbatryhrFJhQqM4XAQRQEayud8FobmOWXv5QuBdbduqsMqrzCfAkCtftc5CLtULozKmBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=njY+/VZf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8130C19422;
	Wed, 19 Nov 2025 02:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763520048;
	bh=yxXYBd0xWdDeiInN/ja+xbwyqwV1lahWrWZIkYcLivU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=njY+/VZfMATWIODpudLFXea+/oZ1Fe6Cw7LB3sfh6k0rui4Ab5G0XKpvAkdARy+jA
	 vlNivCU/HnUVuC40FC75f/p8QexCZ/oSqcxhYVuPOmXU5CSycPKl7jSeRiYwPeevPN
	 D8yPkc6Nj5cbQkAHhw2foMYYAdt3JKPu9lKtyQ4GdfLwmVQUn2uXG8ilH2x9Nk/1NN
	 OQfW+pPgBF0sIMCFc+UqIEH252KznRBnj/RT6y3yzY7hLxPJ1IRPXWYJJ01eIPJt/E
	 ozLffDB2ZJEIKrrGwrw+KBoGcVBndc8tkLB170iyvurSwKj1XcV8OknYyJCRnj8PpX
	 EpTa3blDYe/Og==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D47380A94C;
	Wed, 19 Nov 2025 02:40:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 net-next 0/3] net: expand napi_skb_cache use
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176352001300.191414.6471885013414829418.git-patchwork-notify@kernel.org>
Date: Wed, 19 Nov 2025 02:40:13 +0000
References: <20251116202717.1542829-1-edumazet@google.com>
In-Reply-To: <20251116202717.1542829-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 kuniyu@google.com, kerneljasonxing@gmail.com, netdev@vger.kernel.org,
 eric.dumazet@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 16 Nov 2025 20:27:14 +0000 you wrote:
> This is a followup of commit e20dfbad8aab ("net: fix napi_consume_skb()
> with alien skbs").
> 
> Now the per-cpu napi_skb_cache is populated from TX completion path,
> we can make use of this cache, especially for cpus not used
> from a driver NAPI poll (primary user of napi_cache).
> 
> [...]

Here is the summary with links:
  - [v3,net-next,1/3] net: add a new @alloc parameter to napi_skb_cache_get()
    https://git.kernel.org/netdev/net-next/c/dac023607568
  - [v3,net-next,2/3] net: __alloc_skb() cleanup
    https://git.kernel.org/netdev/net-next/c/294e63825966
  - [v3,net-next,3/3] net: use napi_skb_cache even in process context
    https://git.kernel.org/netdev/net-next/c/21664814b89e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



