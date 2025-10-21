Return-Path: <netdev+bounces-231046-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B169BF42FC
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 02:51:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25BE518A7F6D
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 00:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 311E51FBEAC;
	Tue, 21 Oct 2025 00:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gZaLFS+g"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3011F7910
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 00:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761007834; cv=none; b=L8OV5lSogMzy6eNdkqbmZ85hosKeJVOSBRq1AWHM/fbJ0jNXbS7oyjD4/G0mgG3d0XsKqrYzUvpeRqcdI8C7BWMZf/2urthB3rUc4qy5Mbz48Q59dfbtYC7ZdkTNPImjL4WZvrJSz+jk4CT5GO5V0i9ZW6PpvWiXNBEzZrcAsfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761007834; c=relaxed/simple;
	bh=vhoUiPsz/C4mLY2kyz3qBwjgQH1IBJuYYOZWxn1zjAY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fm5DlmGx9hYZghYROeM5P1uPrAmFEzV4jL4MlT/MztomICRAVbDX+EvBTy2a5x4pnJAGN1gUFf3y1GNgTe7O+LhvAgKHsmY4eJnZ3xPmMsj1OvL22su7PLB0HoLTA7t9Fq5cehOBNIHRHLvN+R3T3QMK9+gkZqyf19ldYaJJTK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gZaLFS+g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2231C4CEFB;
	Tue, 21 Oct 2025 00:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761007833;
	bh=vhoUiPsz/C4mLY2kyz3qBwjgQH1IBJuYYOZWxn1zjAY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gZaLFS+guLeYaC4dVOf969PscqInIsQOt1LaEDZPdrIqxyUSZgqo33uIC3vPoPtX8
	 xrt95RGQqikbUVtNfUnROqnbzoRM7XHoh+wsXnu0EkdhYLhVoytmoTeDf7czxZRqpa
	 L2YitiunrAS0fPDZNOH/z7HNO5J/NT6SyEhsJV/AeCwVpAxHl8RLHtKBcZhqsdq7dr
	 zOot/6dBLjLCSLy1LyFsSpLS0aDP9nx5Mr+phRjYm8bsmJmacjkEeOuggRkhufU1WU
	 PWzmNETPJF8X0+Ia9IEAZ/riIJF4ZYnLyuhDwbUHqVEQLh4SvY+05pc4DmqGGBiMOK
	 VNntg1OZU+y+g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAC133A4102D;
	Tue, 21 Oct 2025 00:50:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next] net: shrink napi_skb_cache_{put,get}() and
 napi_skb_cache_get_bulk()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176100781574.473459.6098759470685793248.git-patchwork-notify@kernel.org>
Date: Tue, 21 Oct 2025 00:50:15 +0000
References: <20251016182911.1132792-1-edumazet@google.com>
In-Reply-To: <20251016182911.1132792-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 kuniyu@google.com, netdev@vger.kernel.org, eric.dumazet@gmail.com,
 aleksander.lobakin@intel.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 16 Oct 2025 18:29:11 +0000 you wrote:
> Following loop in napi_skb_cache_put() is unrolled by the compiler
> even if CONFIG_KASAN is not enabled:
> 
> for (i = NAPI_SKB_CACHE_HALF; i < NAPI_SKB_CACHE_SIZE; i++)
> 	kasan_mempool_unpoison_object(nc->skb_cache[i],
> 				kmem_cache_size(net_hotdata.skbuff_cache));
> 
> [...]

Here is the summary with links:
  - [v2,net-next] net: shrink napi_skb_cache_{put,get}() and napi_skb_cache_get_bulk()
    https://git.kernel.org/netdev/net-next/c/a5cd3a60aa1d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



