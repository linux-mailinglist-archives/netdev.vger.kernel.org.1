Return-Path: <netdev+bounces-45656-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AAA847DEC7F
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 06:51:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65D46281ABF
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 05:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49A6E5221;
	Thu,  2 Nov 2023 05:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b9HdS4eJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E39E442D
	for <netdev@vger.kernel.org>; Thu,  2 Nov 2023 05:51:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AAD8BC433CD;
	Thu,  2 Nov 2023 05:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698904287;
	bh=fvtzVEvpM+r/9FXChXvJSStKgLpd5sZnPv3/DnPjLuY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=b9HdS4eJTu0bUe1uiuDmCvSI9otRKopXjEldxn3KEIr6gOsNA/lmbrcKMcssphwUy
	 TYOCKZXB9cj6+Z8ULK+N5RYRNAfIWm21ac8vEeV78S8HEiOVdb8n8EWuiHD0c5l0NG
	 HxmEfopqYVnKF9qYuA4eC2DYSNc6MHcEpow7ZWzDEhOWtLkVIzQeB8bQZ5DneyS8Gv
	 tJf0BsKc4KO1WWwZjB9j3RJSXdUmjKVgnNTeQdgbj6rjfNb7ZP91VnsQIGenuM3DWN
	 rEvydeWJkiRsJBTvLm37+qHOdVAdX1DICaGKEa2AP7whOkuwFoKDq4JoxB3rlIag2L
	 7COZ6Niq9/ShA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 88644E00092;
	Thu,  2 Nov 2023 05:51:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] llc: verify mac len before reading mac header
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169890428755.30377.9096227406672373743.git-patchwork-notify@kernel.org>
Date: Thu, 02 Nov 2023 05:51:27 +0000
References: <20231025234251.3796495-1-willemdebruijn.kernel@gmail.com>
In-Reply-To: <20231025234251.3796495-1-willemdebruijn.kernel@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, stable@vger.kernel.org,
 willemb@google.com, syzbot+a8c7be6dee0de1b669cc@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 25 Oct 2023 19:42:38 -0400 you wrote:
> From: Willem de Bruijn <willemb@google.com>
> 
> LLC reads the mac header with eth_hdr without verifying that the skb
> has an Ethernet header.
> 
> Syzbot was able to enter llc_rcv on a tun device. Tun can insert
> packets without mac len and with user configurable skb->protocol
> (passing a tun_pi header when not configuring IFF_NO_PI).
> 
> [...]

Here is the summary with links:
  - [net,v2] llc: verify mac len before reading mac header
    https://git.kernel.org/netdev/net/c/7b3ba18703a6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



