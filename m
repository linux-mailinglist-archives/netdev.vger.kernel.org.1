Return-Path: <netdev+bounces-163337-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 968F6A29F10
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 04:00:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30EFE168420
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 03:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 035C414A62A;
	Thu,  6 Feb 2025 03:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="umAjuGB3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFCEA1422AB;
	Thu,  6 Feb 2025 03:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738810804; cv=none; b=eEPy2ZYm0PeSedSnJicFdAD/XomCpVf57NRmGtB5WGvgoZH4UTGXbfi9zWkRp+9IYkNOVLOZYTBtPYyfOjUzQvsO25Cp819ak93vvuZEIcV9QkVkwo8hElvV4XhhTTs3Pz6JKQMyA+LYYxzHRcYd6cnT/wAkFHWdi5T4fgGFPFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738810804; c=relaxed/simple;
	bh=sxYYt5TyBojJ4Eg5chxiScDnJA84ifoHHotwNJRh9PA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dDphmCIqUg8hp8nySHDrvgbuYE8Hk8rNGkW1UqhWoacqDHdHLHuYpzXOURn3r2XGcxgCOUN29QFWjatcMRjmKjPLm1oRYE4WvQa8GRMOlI7VBZrvbotlznJX5cJ+VtZ/zwWaA242535qxcdAq76vES8D8JbeKwB9YeyF+xAuhgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=umAjuGB3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DE78C4CED1;
	Thu,  6 Feb 2025 03:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738810804;
	bh=sxYYt5TyBojJ4Eg5chxiScDnJA84ifoHHotwNJRh9PA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=umAjuGB3y0CqCpJPrEiHByo16UEUSDsq07I627KBWNhBCuToexbWuNd2SxndOuZED
	 OE3Nk89PxxMe6WGVB3OAEkc+wMlAYtyQ155MnWwYjpKFcySxQlsWgz7Zf0ydbvexvI
	 hMQq9emfnr9tJvtpt4a+RtapFJNfQ5m2gdd6ODOkfkG2jA0Fapu95L8/SBNpfgaXa6
	 EybRI4qlvOSHE9MGPMUSctILT0yedgb2XTuui9nQnQ5bZ2n4Np9tYk+orDu44WXv6g
	 lrQVXexJYWBfe8XIFnG/1iQpsZf0dpJTro7/HOmZuvtWxK0ozE3WKfAv85Ogd4mRid
	 8pM/qZrRvSk7g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB3FE380AAD0;
	Thu,  6 Feb 2025 03:00:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 0/2] rxrpc: Call state fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173881083155.983395.4207821504706909846.git-patchwork-notify@kernel.org>
Date: Thu, 06 Feb 2025 03:00:31 +0000
References: <20250204230558.712536-1-dhowells@redhat.com>
In-Reply-To: <20250204230558.712536-1-dhowells@redhat.com>
To: David Howells <dhowells@redhat.com>
Cc: netdev@vger.kernel.org, marc.dionne@auristor.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  4 Feb 2025 23:05:52 +0000 you wrote:
> Here some call state fixes for AF_RXRPC.
> 
>  (1) Fix the state of a call to not treat the challenge-response cycle as
>      part of an incoming call's state set.  The problem is that it makes
>      handling received of the final packet in the receive phase difficult
>      as that wants to change the call state - but security negotiations may
>      not yet be complete.
> 
> [...]

Here is the summary with links:
  - [net,v2,1/2] rxrpc: Fix call state set to not include the SERVER_SECURING state
    https://git.kernel.org/netdev/net/c/41b996ce83bf
  - [net,v2,2/2] rxrpc: Fix race in call state changing vs recvmsg()
    https://git.kernel.org/netdev/net/c/2d7b30aef34d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



