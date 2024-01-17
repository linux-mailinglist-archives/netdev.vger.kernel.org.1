Return-Path: <netdev+bounces-63946-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB2683040C
	for <lists+netdev@lfdr.de>; Wed, 17 Jan 2024 12:00:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 896D9283E8D
	for <lists+netdev@lfdr.de>; Wed, 17 Jan 2024 11:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 204DB1C2BB;
	Wed, 17 Jan 2024 11:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tiNlaX6k"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECFA71CF8C;
	Wed, 17 Jan 2024 11:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705489225; cv=none; b=TD+yG7qL+4wSI1yfFngC34bmEH1/F4XXnCIiLhykIO/Q9haYDtoqSBosPCyxsS4LOK0rvs+BFMNK316kGODcU/Vh86y9reHueL301amVXrG2VJj0DzzOPIKgs+97uG/rkvBQ7+5ymn7fh7KrgsvBk1xZz0AKQ5/3g0/oZET+5WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705489225; c=relaxed/simple;
	bh=o4K/jR2EQHBMBfl5VUPqywEU7RGN7eeH77w25GKdEhQ=;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=i94kk5+/cZeooBqyJdAR4Vkd5HwDvAotieFppBaXFcLdPIQLmrMWGiITW19SSXyk1UgdfmfbA8lzQala2ZA0Hqv5TdveOPbv+Q+QrsFF5+j/GYOEPI3H8ucTXi1tC5SsWBPZtRC1r5vnoprIWlFxVimN9t+A5bO2+uXWhfO5K2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tiNlaX6k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8A08BC433F1;
	Wed, 17 Jan 2024 11:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705489224;
	bh=o4K/jR2EQHBMBfl5VUPqywEU7RGN7eeH77w25GKdEhQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tiNlaX6k22gjICvNrUi5nZsPC1qWR7AaVCr5+Um+XcNjwMdMJzA/udMCaxfYCzAtE
	 gC4tYi5au2u0d1vHOgVzPSYywFUzXRqIYa30yfRiXviQ613KA8ElIF73IMSNq4fpAa
	 gabFH0TpdEbWJCrSbHYAkh/XHUMvpTLNmlegCKk9mAoyULRc89rO+T2EdN96kAl4lV
	 y9htvvrUeDO18Wqv74e7QzRkuDqh8SddqWHIve957LfU8flyX5dWZA5ScfPQnnUQqo
	 AyodrlGCZsV1gaWKiDcaR7BZp+/j1b9TpGWjbYGIow9HnRUxNI7fS8pRL6YIvnkY5x
	 huiNCOO3fgjRw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 72894D8C97C;
	Wed, 17 Jan 2024 11:00:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] mptcp: relax check on MPC passive fallback
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170548922446.14327.612515051886234172.git-patchwork-notify@kernel.org>
Date: Wed, 17 Jan 2024 11:00:24 +0000
References: <ddfc9eec6981880271d0293d05369b3385fb9e86.1705425136.git.pabeni@redhat.com>
In-Reply-To: <ddfc9eec6981880271d0293d05369b3385fb9e86.1705425136.git.pabeni@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, matttbe@kernel.org, martineau@kernel.org,
 geliang.tang@linux.dev, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, horms@kernel.org, mptcp@lists.linux.dev

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 16 Jan 2024 18:18:47 +0100 you wrote:
> While testing the blamed commit below, I was able to miss (!)
> packetdrill failures in the fastopen test-cases.
> 
> On passive fastopen the child socket is created by incoming TCP MPC syn,
> allow for both MPC_SYN and MPC_ACK header.
> 
> Fixes: 724b00c12957 ("mptcp: refine opt_mp_capable determination")
> Reviewed-by: Matthieu Baerts <matttbe@kernel.org>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> 
> [...]

Here is the summary with links:
  - [net] mptcp: relax check on MPC passive fallback
    https://git.kernel.org/netdev/net/c/c0f5aec28edf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



