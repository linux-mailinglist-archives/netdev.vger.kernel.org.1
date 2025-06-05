Return-Path: <netdev+bounces-195227-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 075BDACEE3D
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 13:00:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3EAB1735DE
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 11:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B1D4219317;
	Thu,  5 Jun 2025 11:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EkWMlvlB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3678F2E659
	for <netdev@vger.kernel.org>; Thu,  5 Jun 2025 11:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749121200; cv=none; b=saSbhuk9r8/EDyZH8vUrDgUk+xEstuRr6LJ97GdavZeOyLMF2sky4j0IuBeZPPVbPR/2KG/hj8k4XMTGWKrE2VHXT7JE1xYOv9yBhcVwfg6BM4vt+maVZ5TgHoqwV4i+e+fXHl22AqTIwtasVAMm4ZV66rrumMcbxoBzBHUQSxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749121200; c=relaxed/simple;
	bh=eweQa1z6JJSvwWMRGmTlcen8SdDr760ML/31BbipALY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=X+2aGHHDzecr2szH4JnpCghULL3kSSXh4AnrahKbMNXsY5cqblv3ggjW9drt7aXYXp6Sp/DeqCqabTrNZMceCsO0RMCeAmiavWP1nHY3Xkbc7bCucE9BeLzQtfF6us8zVb0bNlosEeX2ztzDlbFOaJ2OuvE/LW/NzhozqAIg3JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EkWMlvlB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0785FC4CEE7;
	Thu,  5 Jun 2025 11:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749121200;
	bh=eweQa1z6JJSvwWMRGmTlcen8SdDr760ML/31BbipALY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EkWMlvlBPqx1V6Fchxp3NTqkgJ3meFpxypq3qKqEkrHRSCRAlaqtD5mjwi8GPd9id
	 7LxChABRctWN6TiQecAvN8on8LmAttQkBho5g7x/VzVJIELZmvR2/SzyygSoZ5uT8b
	 2IMGLPjOxmtwmRGmEGP9D7Pl7TOFDcH5YVc6cikXek2nwxyJtubkorJitXGMJ20Wdp
	 CxZ9zwjIVYK2nHy/qsA9TiE1zBoJu/yU8Ee6QIc5VVccgn0F2+5s8srg02lVq1eKnW
	 NQEsB9j+tuwgs6u+T61H8ZVyHvzd7KhyyhuqXLetjfIJVHRgMOt5ylhvbho43PYP9O
	 tMKDuJHtxzK3A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33CE138111D8;
	Thu,  5 Jun 2025 11:00:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/2] netlink: specs: rt-link: decode ip6gre
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174912123201.3027322.6365503905744814596.git-patchwork-notify@kernel.org>
Date: Thu, 05 Jun 2025 11:00:32 +0000
References: <20250603135357.502626-1-kuba@kernel.org>
In-Reply-To: <20250603135357.502626-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 donald.hunter@gmail.com, sdf@fomichev.me, willemb@google.com

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue,  3 Jun 2025 06:53:55 -0700 you wrote:
> Adding GRE tunnels to the .config for driver tests caused
> some unhappiness in YNL, as it can't decode all the link
> attrs on the system. Add ip6gre support to fix the tests.
> This is similar to commit 6ffdbb93a59c ("netlink: specs:
> rt_link: decode ip6tnl, vti and vti6 link attrs").
> 
> Jakub Kicinski (2):
>   netlink: specs: rt-link: add missing byte-order properties
>   netlink: specs: rt-link: decode ip6gre
> 
> [...]

Here is the summary with links:
  - [net,1/2] netlink: specs: rt-link: add missing byte-order properties
    https://git.kernel.org/netdev/net/c/de92258e3b22
  - [net,2/2] netlink: specs: rt-link: decode ip6gre
    https://git.kernel.org/netdev/net/c/8af7a919c52f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



