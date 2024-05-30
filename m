Return-Path: <netdev+bounces-99353-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3F6A8D49AA
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 12:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AA48283503
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 10:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3339C15D5CB;
	Thu, 30 May 2024 10:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vL8NxlH8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F94415B153
	for <netdev@vger.kernel.org>; Thu, 30 May 2024 10:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717065032; cv=none; b=NRD9oz2YkaHdkNOik31eg5kqK6Z9X3bkV8HYigzwAPlt84+O7MTiVvOFewgtF4VvH3bWn0N+sTX1ihvQ/1YSXJ66ObgmWxEoIm+A9SNPKOFt5cIWUZg1nysW1lSgIejmI6z+R4sHdQFuj9yk8lDqR0JSDbJs/qIgUG8ZKdooqhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717065032; c=relaxed/simple;
	bh=9cxQ7mYy6GtUguRsJtTuz1AWdvFCzDHKm0MaQdq2ma8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tG3kfvV1esnyofPXmADa/uRvCgN97QxvTWa+OC3iqhg2eK2cNfAYxpXO8lkcA2KLtSGn/Sp2v4hNsd9fREi6IE3Exo4B0wNxRde9I2E1e5xe1uBndluAMaAebsE0r7grIv0RcVno+C1c0yk5FD7TlYFaAzlp/cNd7kqO+xx7BMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vL8NxlH8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7D7CFC3277B;
	Thu, 30 May 2024 10:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717065030;
	bh=9cxQ7mYy6GtUguRsJtTuz1AWdvFCzDHKm0MaQdq2ma8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=vL8NxlH8LBKDNaSds5rZwQXawJidnusAnCXHk94u03fgRcxp8WtjstYEwYhaM3FRI
	 UmY1+1vqyUrxxsghTNpoOx2hjTmLChweUVZSZOjtk5nDVwGa3th8nDosWLG09sBf2E
	 C2Al/PmoVRUeWYrNaywMVB1NmFQw8JGdqvU64+OyLp+W+zc70oWE94FE1bqC64Vojw
	 +ZV1/li0bWTkHUvY2wDayVAykLj3/f+SQRY81NTAj+Bk7xyVcS8NWPfHiBZAuPjYGO
	 SUgI3FI2FbTabpk24GR1cpYLFeyZ6jfkVKu81rMOMyzeicwFq9l55aF2PkDs2dYJx4
	 h+a2UmFeylw6Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6A977D84BCC;
	Thu, 30 May 2024 10:30:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] netdev: add qstat for csum complete
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171706503043.12381.6136944721721654074.git-patchwork-notify@kernel.org>
Date: Thu, 30 May 2024 10:30:30 +0000
References: <20240529163547.3693194-1-kuba@kernel.org>
In-Reply-To: <20240529163547.3693194-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, donald.hunter@gmail.com, sdf@google.com,
 amritha.nambiar@intel.com, hawk@kernel.org, sridhar.samudrala@intel.com,
 jdamato@fastly.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 29 May 2024 09:35:47 -0700 you wrote:
> Recent commit 0cfe71f45f42 ("netdev: add queue stats") added
> a lot of useful stats, but only those immediately needed by virtio.
> Presumably virtio does not support CHECKSUM_COMPLETE,
> so statistic for that form of checksumming wasn't included.
> Other drivers will definitely need it, in fact we expect it
> to be needed in net-next soon (mlx5). So let's add the definition
> of the counter for CHECKSUM_COMPLETE to uAPI in net already,
> so that the counters are in a more natural order (all subsequent
> counters have not been present in any released kernel, yet).
> 
> [...]

Here is the summary with links:
  - [net] netdev: add qstat for csum complete
    https://git.kernel.org/netdev/net/c/13c7c941e729

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



