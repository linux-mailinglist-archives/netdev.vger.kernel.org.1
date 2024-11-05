Return-Path: <netdev+bounces-141931-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2CDB9BCB22
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 12:00:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87D2328486F
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 11:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E0CB1D2F5C;
	Tue,  5 Nov 2024 11:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PeoKkFJV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E878C1D1745;
	Tue,  5 Nov 2024 11:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730804422; cv=none; b=aDDFSAIVVhF9PzsJWT+jk38cyH66oi39Oo1bhN4ku5ejfjbhZ9W0ZQvESwhmVSNWOGOhDc2Nofq0D6T/I0/a7PI/0Gq4+DgRpIoUhGDdnI4zQgqbK9wLBy3dPf2qHsgL4CSWISPECf3yqIPmE+CXOee2ap+8mrA5/Ak2R9gqKSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730804422; c=relaxed/simple;
	bh=qnLJsDPz4qQ0szKBbl5DeYGgdm97dMEAaPySnxknqXs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Eca0IY1AlxfJJi/VqXqRpC5fKPYnsF337gFLsZjZDiItEtMNNanPPOQARaC9ovNMnkMS2xHXnhBirGXp8RQuao9FAzKzmVNdM5i2bfm02YVg3wxZeCVWCbm3YKQpU2HGaiZtWykzZgRmIDzON0f0aqxz1E/nREFlqUIuqgVrI6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PeoKkFJV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 788BBC4CECF;
	Tue,  5 Nov 2024 11:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730804421;
	bh=qnLJsDPz4qQ0szKBbl5DeYGgdm97dMEAaPySnxknqXs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PeoKkFJVXx5LpmaSubhhBlHLO3+iD+Gq5Mo76/HTnKqnvdeyN6IDAlFLt2mMjsnIP
	 TBV5hnIWkB/l8Aiw7RXGnHV5uiy+dpB2HDvIQodTsSghlN/31rYlONDFozaBoknMGe
	 idHUANGF8bif4PKD4msomZdENjegQSTwZIcuvKsDwv+T/euL+yvTfHv5fsK2bAaoiG
	 ueqNVDuWR++Jb7JfC4U+ia74pgVkGSQI9ILaY5oe7nKD3o5BPtlfMLfyc4W59I+MNO
	 bGGy0hLGQyKNiQJsUh3P5U27FdoVF5Gfm5ET+v9bqvAymfddOBA4WKOo97D0YA3Xoq
	 kl0OnNV2B1bnw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71BEE3809A80;
	Tue,  5 Nov 2024 11:00:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v1 0/4] virtio_net: enable premapped mode by default
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173080443026.516155.16664764560911681358.git-patchwork-notify@kernel.org>
Date: Tue, 05 Nov 2024 11:00:30 +0000
References: <20241029084615.91049-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20241029084615.91049-1-xuanzhuo@linux.alibaba.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, mst@redhat.com, jasowang@redhat.com,
 eperezma@redhat.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 virtualization@lists.linux.dev

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 29 Oct 2024 16:46:11 +0800 you wrote:
> v1:
>     1. fix some small problems
>     2. remove commit "virtio_net: introduce vi->mode"
> 
> In the last linux version, we disabled this feature to fix the
> regress[1].
> 
> [...]

Here is the summary with links:
  - [net-next,v1,1/4] virtio-net: fix overflow inside virtnet_rq_alloc
    https://git.kernel.org/netdev/net-next/c/6aacd1484468
  - [net-next,v1,2/4] virtio_net: big mode skip the unmap check
    https://git.kernel.org/netdev/net-next/c/a33f3df85075
  - [net-next,v1,3/4] virtio_net: enable premapped mode for merge and small by default
    https://git.kernel.org/netdev/net-next/c/47008bb51c3e
  - [net-next,v1,4/4] virtio_net: rx remove premapped failover code
    https://git.kernel.org/netdev/net-next/c/fb22437c1ba3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



