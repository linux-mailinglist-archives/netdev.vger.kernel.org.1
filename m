Return-Path: <netdev+bounces-99622-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 803A18D583C
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 03:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B93B2892A2
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 01:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6047BDF5B;
	Fri, 31 May 2024 01:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="psVe0hdm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF4717550
	for <netdev@vger.kernel.org>; Fri, 31 May 2024 01:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717119633; cv=none; b=YkVWhpmzxL2v8TMVAC9NZrXMgPnygIRFkMMj4bDz8A7J2gOZcJRjwv0vHyksncHMYRfUuGI6YiRXkQvkipDcYdgAha0+u1vKq0DYO6qxG0oIRPT2ucTPrNDn5wlDL2Pkrr/YzWioiYDPhcNelI40DwF1pThn1NPm/2SNotlSHtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717119633; c=relaxed/simple;
	bh=VKOc60I90X/dugTkbNmULut2FA8Ge149pb8+tDxQzoI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=U+9eKKjj6u2Q2oYUt4jZBJyEemGwPRvKYxmoRr+feuIERPcffyZDwm4bH+wMwy2kG2BexyQ20yhYbtlHpjk3UWbTWaTJ5hrCA/vIrEtn+ry8zzHwBoeSWIuoAUz3kHSSdd4rjqDFfltdYV/DwMKx2wDqYpgnYa72oKTPVOJsA6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=psVe0hdm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0F0C6C32789;
	Fri, 31 May 2024 01:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717119633;
	bh=VKOc60I90X/dugTkbNmULut2FA8Ge149pb8+tDxQzoI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=psVe0hdmUrhZ9Yuy5iKDwfoR05NxUsL8ljOAjExIwZ2MvF7kNVeN/wv+nsqVVYbr3
	 otEL9u05Yz82rZ/4mbpkQCxrCDuvE02Ny426usEKtRDhhcPyyTn4V4XwIpf6Fnh6f0
	 rF7z1mGByhiHwkXzDBsa34tdZB0pYeItxBktMbTQlXNNHo6PiSBfP6AZQkvo4TWdCH
	 grjakpW5CVv48njlCsyXxkkbMCUCN5zqfLIsG5hUS08EX5iP/ZMSyoF2OSlKRFqJOY
	 Cpier8/c2VmnjGkJVWQm4ygSXX7svGvl80Mc44e1q7WrVxTt4TyiwG0kQZUCpmQFFQ
	 nkLLjhKesrgmg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0279FCF21F3;
	Fri, 31 May 2024 01:40:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCHv2 net-next] ipv6: sr: restruct ifdefines
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171711963300.18580.9918782792276151812.git-patchwork-notify@kernel.org>
Date: Fri, 31 May 2024 01:40:33 +0000
References: <20240529040908.3472952-1-liuhangbin@gmail.com>
In-Reply-To: <20240529040908.3472952-1-liuhangbin@gmail.com>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 kovalev@altlinux.org, sd@queasysnail.net, gnault@redhat.com,
 horms@kernel.org, david.lebrun@uclouvain.be

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 29 May 2024 12:09:08 +0800 you wrote:
> There are too many ifdef in IPv6 segment routing code that may cause logic
> problems. like commit 160e9d275218 ("ipv6: sr: fix invalid unregister error
> path"). To avoid this, the init functions are redefined for both cases. The
> code could be more clear after all fidefs are removed.
> 
> Suggested-by: Simon Horman <horms@kernel.org>
> Suggested-by: David Ahern <dsahern@kernel.org>
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> 
> [...]

Here is the summary with links:
  - [PATCHv2,net-next] ipv6: sr: restruct ifdefines
    https://git.kernel.org/netdev/net-next/c/a79d8fe2ff8e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



