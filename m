Return-Path: <netdev+bounces-199220-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3197DADF7AF
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 22:29:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF94C3BFFC1
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 20:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE20821A452;
	Wed, 18 Jun 2025 20:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fkZQs4Nw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96F11D63C2
	for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 20:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750278593; cv=none; b=Zn+8UcLkn4VR+WhhiBw/vEy1RIifrBkJF+Fp93wGe4Kj1gGqN+p8J8HTKDq3NgfDBAifLybvheJfX/UG++P1YIz9cTYOkEOhDHxr3pGgcl12CLfit7u8Ly1TlOIXBlXar/nPWlG5OjHrD3MRsmqlSn1U//e3VJMQ05IkGGgOmgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750278593; c=relaxed/simple;
	bh=hUXqrxbrUuQsx3aJdqIt2qpClM8NtY0AkLc2VAqeDA4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BLzclZ58527K3EPVCbrJwWlKa6mSL/P+q6mWmjw8qFxjn52QuXJQCSTu3ZQZz2/O6cONK3qUJqJanDOJ5aO6ExV+jrB4VgIPPgBpyx4DoRly5uewM5wleOk83gjBUJ2HRb7TOEin16Gm76Wq/P3alkg7AgnitzNkFffHk0y+Z68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fkZQs4Nw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C6AFC4CEE7;
	Wed, 18 Jun 2025 20:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750278593;
	bh=hUXqrxbrUuQsx3aJdqIt2qpClM8NtY0AkLc2VAqeDA4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fkZQs4NwKnODbLoMSeMo9T16ZcEpPa1e6JluhKxcBL/aK+GuyIu66uYYreODMWG07
	 IeGE6XFY644LjoiJFE0yMOWMMMOpKlePlZCgviYlWJ4y6Pj4KRyuCzzSvd4VPKi3rO
	 CTXeWqBZH+zuwrEgRY7Gm6miflJPniLpUakSKohSqVwYaK04K4sa2YsW2QASAIG6Ye
	 ygIh/IP8rGp12ssGm4hWOwMa2R3caxCyPJ1wm61du12B9JHVbmtgnhb/WkePE5wk7s
	 szf7UwiE94Jt9Ru7ijYisE7rdxfuHPFCeb2UZ06Ranioql9xZt9wVLblUE0TpJ1q+F
	 IJ8A/JTCQdvkA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE753806649;
	Wed, 18 Jun 2025 20:30:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/5] eth: migrate more drivers to new RXFH
 callbacks
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175027862148.246778.2859409211781478341.git-patchwork-notify@kernel.org>
Date: Wed, 18 Jun 2025 20:30:21 +0000
References: <20250617014848.436741-1-kuba@kernel.org>
In-Reply-To: <20250617014848.436741-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 madalin.bucur@nxp.com, ioana.ciornei@nxp.com, marcin.s.wojtas@gmail.com,
 bh74.an@samsung.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 16 Jun 2025 18:48:43 -0700 you wrote:
> Migrate a batch of drivers to the recently added dedicated
> .get_rxfh_fields and .set_rxfh_fields ethtool callbacks.
> 
> Jakub Kicinski (5):
>   eth: niu: migrate to new RXFH callbacks
>   eth: mvpp2: migrate to new RXFH callbacks
>   eth: dpaa: migrate to new RXFH callbacks
>   eth: dpaa2: migrate to new RXFH callbacks
>   eth: sxgbe: migrate to new RXFH callbacks
> 
> [...]

Here is the summary with links:
  - [net-next,1/5] eth: niu: migrate to new RXFH callbacks
    https://git.kernel.org/netdev/net-next/c/b82d92dd71cb
  - [net-next,2/5] eth: mvpp2: migrate to new RXFH callbacks
    https://git.kernel.org/netdev/net-next/c/b6f7e4fafe77
  - [net-next,3/5] eth: dpaa: migrate to new RXFH callbacks
    https://git.kernel.org/netdev/net-next/c/17da66f140c2
  - [net-next,4/5] eth: dpaa2: migrate to new RXFH callbacks
    https://git.kernel.org/netdev/net-next/c/20ffe3bbc2ce
  - [net-next,5/5] eth: sxgbe: migrate to new RXFH callbacks
    https://git.kernel.org/netdev/net-next/c/c2cd2f6125bd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



