Return-Path: <netdev+bounces-248312-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 10BA5D06D42
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 03:15:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B98EC301AD1C
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 02:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6182026B764;
	Fri,  9 Jan 2026 02:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dkn338oy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F570218AAB
	for <netdev@vger.kernel.org>; Fri,  9 Jan 2026 02:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767924810; cv=none; b=dIpExYzqQj5ulw1sqoqawYou3LjGDSObv2SsuPXpnwfvGNdzkCZyiPKtQ9LfH7DH+tok5mtwsjC4IwZ0fxLhQR/zZmXlthmtuhpYM9YGUx3NsIItPz3spBqhI11i222rAUIotYpl6nRyVLy1Oi0VuzAPmci1FbNszxguu4GhTo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767924810; c=relaxed/simple;
	bh=TKGzGh3Hkmtygu0WuiAEsREPakUe2bFSBzXuSedxLyI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jQyKJFNO0xjQ/Svsa/WaEZTaTdyNuFwKreeA7b+J/6Gv5O6N3ZSyyHV6BDibh4MJnSkHH76WZ0gHlFT8+b5zwnfd2PcKdcCmg8l8+GEln/19lBkri57tqrB7Q4KQMP4qaa5qAYswvZ0AV5rgDTfgwS38v4naX5Dx2LTN37xeecA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dkn338oy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3D58C116C6;
	Fri,  9 Jan 2026 02:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767924809;
	bh=TKGzGh3Hkmtygu0WuiAEsREPakUe2bFSBzXuSedxLyI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Dkn338oyuW2rLy+b3kQi7jcCtlCoF9WZHqqkhX/h7l79Ycf4cPhjbCxTHODNWV7eU
	 Uckmf1gfbYIg6uf8smBIn6R0RwBbBIOb0rXmaTBtYI3N18zh8YAMuoA13luyXjR+TW
	 TYv4VUqEfO4O2DQRiB1cgGgZCPP/ihJ020Y322+MpAv5Zt4vTFHbNb26WwtOB5EazP
	 UnxWo+NOVy1GFDpV4ejXra95bXvyZblCa9USHrYRcnDiEDGazpDH7wpAlS7ahR9APv
	 XB5ZNH66oy/eD2lJF/SLkWozBW7L2d82+2fHnQAZvp7aygqlpXrvbThD+U1R4WrSd8
	 Q+eOXjdignGAA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3B76B3A8D145;
	Fri,  9 Jan 2026 02:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ipv4: ip_tunnel: spread netdev_lockdep_set_classes()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176792460604.3867254.6270809566545017500.git-patchwork-notify@kernel.org>
Date: Fri, 09 Jan 2026 02:10:06 +0000
References: <20260106172426.1760721-1-edumazet@google.com>
In-Reply-To: <20260106172426.1760721-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, eric.dumazet@gmail.com,
 syzbot+1240b33467289f5ab50b@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  6 Jan 2026 17:24:26 +0000 you wrote:
> Inspired by yet another syzbot report.
> 
> IPv6 tunnels call netdev_lockdep_set_classes() for each tunnel type,
> while IPv4 currently centralizes netdev_lockdep_set_classes() call from
> ip_tunnel_init().
> 
> Make ip_tunnel_init() a macro, so that we have different lockdep
> classes per tunnel type.
> 
> [...]

Here is the summary with links:
  - [net] ipv4: ip_tunnel: spread netdev_lockdep_set_classes()
    https://git.kernel.org/netdev/net/c/872ac785e768

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



