Return-Path: <netdev+bounces-92136-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACFE48B58BE
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 14:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6135E288929
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 12:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20C6C8487;
	Mon, 29 Apr 2024 12:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HjZkj8F/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1169C133
	for <netdev@vger.kernel.org>; Mon, 29 Apr 2024 12:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714394429; cv=none; b=QvfFTr2eSDq2F9ccAa7Xo+XGN9pQ219TqhT4XaM+rkRMNXpxDDPTqqd8NhOyOTfnqByEFFXfkYLh9L+vol+pDXob+rXgK5q6tT95WH3wdnU559LDvLa6iUCNQT7FjIfuWENyXRQVfUnWN/VRBC4XD+ZgJ4Xswcb0GOqkw3ULmZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714394429; c=relaxed/simple;
	bh=0qPBO91g3okjlcGeTKrTyKB3jOuDG/m84/3bFg8zl8k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=azXMP3cpc+98XhOX1Tp3MCm63cyGpKkRKVYw0gsYWjAAfLmpsWM8HR46I6w0dKLnVoZP5oSHbc1GrH7mbBCaVB8idg92ToSx0sK5kxvbss4ezFigWulP+dQp0RkZvUKYkbl8BTS4ak4XF47LrKyoiE+eFSXKPibOhWRpzuf/jUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HjZkj8F/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6755EC116B1;
	Mon, 29 Apr 2024 12:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714394428;
	bh=0qPBO91g3okjlcGeTKrTyKB3jOuDG/m84/3bFg8zl8k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HjZkj8F/y0E0sjBC+YZXP6UUYfTXjLREBu2rBP6gpT7pkjmUNZ9/d4a9zDCpiWRln
	 ujgVU9LnvZILIG3pqVWtt1FqX5uXNtn+yHPusXo3K8qkvfORPDwyVTr7tlHy39jcEL
	 9VdVJWcltIMJG/4cGPM04SrjRUhzFSeIaEEpB/Ej8GDWQezBTE8RTMDww7keMVHDvw
	 U9YRwxwJSf61BKunxeNqJHVP8nMCzKwlu+7jjx3uRBO4Bs2hySAXN6J2dgJPYVu5Eh
	 m2PbsBsrsT85ZbGy8nCCXhnfa9iVdqs/G+7L5MjaCT7fvwy7/ATTwd0lzLa+jqQQVz
	 FxkdC0cJfR6FQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5820BC54BAA;
	Mon, 29 Apr 2024 12:40:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/2] vxlan: Fix vxlan counters.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171439442835.25762.12780825413327777805.git-patchwork-notify@kernel.org>
Date: Mon, 29 Apr 2024 12:40:28 +0000
References: <cover.1714144439.git.gnault@redhat.com>
In-Reply-To: <cover.1714144439.git.gnault@redhat.com>
To: Guillaume Nault <gnault@redhat.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, idosch@nvidia.com,
 amcohen@nvidia.com, petrm@nvidia.com, razor@blackwall.org, jbenc@redhat.com,
 leitao@debian.org, roopa@nvidia.com, shemminger@vyatta.com

Hello:

This series was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 26 Apr 2024 17:27:15 +0200 you wrote:
> Like most virtual devices, vxlan needs special care when updating its
> netdevice counters. This is done in patch 1. Patch 2 just adds a
> missing VNI counter update (found while working on patch 1).
> 
> Guillaume Nault (2):
>   vxlan: Fix racy device stats updates.
>   vxlan: Add missing VNI filter counter update in arp_reduce().
> 
> [...]

Here is the summary with links:
  - [net,1/2] vxlan: Fix racy device stats updates.
    https://git.kernel.org/netdev/net/c/6dee402daba4
  - [net,2/2] vxlan: Add missing VNI filter counter update in arp_reduce().
    https://git.kernel.org/netdev/net/c/b22ea4ef4c34

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



