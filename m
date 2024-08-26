Return-Path: <netdev+bounces-122050-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7960195FB44
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 23:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D0CE1F224E4
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 21:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D95CB13E41D;
	Mon, 26 Aug 2024 21:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ds85l8eh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31C713CA95
	for <netdev@vger.kernel.org>; Mon, 26 Aug 2024 21:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724706626; cv=none; b=pLPFNEAJiDQGYrKhbHUYehpmpPD8gA0LlijebMpJW0ETA2b6+J/HkwYLSayZKiGHqhXCHOZj6H+8I+5w1Sav6gYYKMZc5xFLrGgi+GkeBs8uxRG2LKe42KjhFNjvG3q8bstr39GYZu9H3k6H+/HJbMNssS8Cg3JbmddK2AsCZ0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724706626; c=relaxed/simple;
	bh=PQ5B3IZL/eKpv8c6kutHN1qjGtIvJpVUAIqzPWmAgJU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XDjUSklqLf1X3KUsa5VAQ/aj2DaH0h6gn+NaGztsmz2bRG93l0bBgMXtdInoGa26VdjK0h3B+dCmusbX5eQsqri7ZsJR8cX0p1bwsImend8IyeDk4XSqbM5Htc6s/ruVA2Z2h6zzNttKhC70GpK6uRwNIH50lUpr9uLImOgClpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ds85l8eh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D3BFC8B7A4;
	Mon, 26 Aug 2024 21:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724706626;
	bh=PQ5B3IZL/eKpv8c6kutHN1qjGtIvJpVUAIqzPWmAgJU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ds85l8ehidKCxvQd1B7QUdnynbJoAO8XzT2OamOnYuMEKdKMIFqE02Et8FULHOY/+
	 P8FZasf11J248/NFglsPteMs22ZYGcQVjMQbmejHOOH25LssmPzgrHEPsgfnXieDMw
	 KJFxsYOA5IisAYA1PH/Wk5VwqqvxkTWTwKOk+sySSveuod7kYlTJFVJNgdPYq/tkW5
	 eMHKOOaDxR+vVJP0y+TxMlvrFQjghe1IzFqFX/lHwjo9W0DpBVbCRJVsPMi0oRtvd/
	 KN9vGCU01HKp4mtYz0sqpCiice1QaNeQpvyVDLJuyz/a5tfshnwXNVcAVlvRDBESWL
	 ngAqGE6P7DMeg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70BCF3806651;
	Mon, 26 Aug 2024 21:10:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net/ipv4: fix macro definition
 sk_for_each_bound_bhash
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172470662624.127664.15586660530271760548.git-patchwork-notify@kernel.org>
Date: Mon, 26 Aug 2024 21:10:26 +0000
References: <20240823070453.3327832-1-lihongbo22@huawei.com>
In-Reply-To: <20240823070453.3327832-1-lihongbo22@huawei.com>
To: Hongbo Li <lihongbo22@huawei.com>
Cc: edumazet@google.com, davem@davemloft.net, dsahern@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 23 Aug 2024 15:04:53 +0800 you wrote:
> The macro sk_for_each_bound_bhash accepts a parameter
> __sk, but it was not used, rather the sk2 is directly
> used, so we replace the sk2 with __sk in macro.
> 
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
> ---
>  net/ipv4/inet_connection_sock.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [net-next] net/ipv4: fix macro definition sk_for_each_bound_bhash
    https://git.kernel.org/netdev/net-next/c/9ceebd7a2647

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



