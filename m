Return-Path: <netdev+bounces-159598-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE8F5A15FE0
	for <lists+netdev@lfdr.de>; Sun, 19 Jan 2025 03:00:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 462F81886113
	for <lists+netdev@lfdr.de>; Sun, 19 Jan 2025 02:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE11016426;
	Sun, 19 Jan 2025 02:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ui7mxqUj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B431E10A1F;
	Sun, 19 Jan 2025 02:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737252008; cv=none; b=CK4+WkN4JihAa6rI+SgtSRRbAksPgexYspVsdpnEFrd2oIswxgG+Opg5pH2MZiWWvLyBTjnX/wA8A3xRRLZqZoRPjQMu1SBRNzKNmucyEYfvABwp48vC0fdfWyopc8u95sEIqhhlkXg1V0udFeffQj4vBR++bduK4SQ+cDeQTrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737252008; c=relaxed/simple;
	bh=+n5A+adYUWHUgmPqrXfi3ypk6IXHNcvByLLZ4M+C6x0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LhizMQOahTK5RXnvMrD+mTiGB8LOIvhbEchkoh+sGqWAVKWbslQFq4F1jFamKQW6iFqm7C2fCmuJ041Ramiyzriw6a5kqxdvH0j+ceFyGjEkIaIWgktqmqKg6S073j5zrH78igktg0HjOlQyoyrTumZxrwTWZVVlAx5k+++i5es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ui7mxqUj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22BB8C4CED1;
	Sun, 19 Jan 2025 02:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737252008;
	bh=+n5A+adYUWHUgmPqrXfi3ypk6IXHNcvByLLZ4M+C6x0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ui7mxqUjxV2DZk+2gPQc5Mk6rPsUdCj0jLWbuD52Ne5/Nanl05UdqTtp027QY8vOm
	 RVj21NsZeaPXRZrPdLNgwkh17+K+J4+QwWTuXlfgUFYTrJBDaO+K/q54RwM7OSKFZz
	 o9uKi5wB2BQSK6Q5G4EiBo82P200Aw/cClosTtrkHfxtqi+fywAKkTpPisjCtnEfG7
	 ETmuFe33knnDTqnvtc58rq3wOmXqqYfCu7Kr7aBix7BosZ/i+B+qmg26Pg4aeER7Gp
	 K+wQK3tacXsin4s1GAP8wE6+eEvTGVMHArVIBZaZUC0FGk97X3R96Ms49qge4AKZuj
	 f+ukEUl0COapA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB137380AA62;
	Sun, 19 Jan 2025 02:00:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v9 0/4] Fix race conditions in ndo_get_stats64
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173725203157.2534672.4603874852141843862.git-patchwork-notify@kernel.org>
Date: Sun, 19 Jan 2025 02:00:31 +0000
References: <20250117094653.2588578-1-srasheed@marvell.com>
In-Reply-To: <20250117094653.2588578-1-srasheed@marvell.com>
To: Shinas Rasheed <srasheed@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, hgani@marvell.com,
 sedara@marvell.com, vimleshk@marvell.com, thaller@redhat.com,
 wizhao@redhat.com, kheib@redhat.com, konguyen@redhat.com, horms@kernel.org,
 einstein.xue@synaxg.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 17 Jan 2025 01:46:49 -0800 you wrote:
> Fix race conditions in ndo_get_stats64 by storing tx/rx stats
> locally and not availing per queue resources which could be torn
> down during interface stop. Also remove stats fetch from
> firmware which is currently unnecessary
> 
> Changes:
> V9:
>   - Iterate over OCTEP_MAX_QUEUES or OCTEP_VF_MAX_QUEUES in the
>     respective ndo_get_stats64() function, rather than just the active
>     queues.
>   - Update commit messages of 1/4 and 3/4 to reflect reordering.
> 
> [...]

Here is the summary with links:
  - [net,v9,1/4] octeon_ep: remove firmware stats fetch in ndo_get_stats64
    https://git.kernel.org/netdev/net/c/1f64255bb76c
  - [net,v9,2/4] octeon_ep: update tx/rx stats locally for persistence
    https://git.kernel.org/netdev/net/c/10fad79846e4
  - [net,v9,3/4] octeon_ep_vf: remove firmware stats fetch in ndo_get_stats64
    https://git.kernel.org/netdev/net/c/cc0e510cc89f
  - [net,v9,4/4] octeon_ep_vf: update tx/rx stats locally for persistence
    https://git.kernel.org/netdev/net/c/f84039939512

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



