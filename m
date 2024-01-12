Return-Path: <netdev+bounces-63177-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A94B682B8AF
	for <lists+netdev@lfdr.de>; Fri, 12 Jan 2024 01:40:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CA481F25B52
	for <lists+netdev@lfdr.de>; Fri, 12 Jan 2024 00:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 806ADEC6;
	Fri, 12 Jan 2024 00:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DuPDg6+e"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C4AA57
	for <netdev@vger.kernel.org>; Fri, 12 Jan 2024 00:40:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F03BDC433A6;
	Fri, 12 Jan 2024 00:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705020026;
	bh=UCuQkqF5m9w1hzGdUlatIKAYL638pkrCLE33RXhtKR0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DuPDg6+eEVD7ujL9wv1y+7/RcScbT9AVNUrsGSFVM3CvFprRi83rti1JXsOWipwjy
	 uSdi0/kEv1ouLfGynpKkMIYfZA3PpoE6yKm+BMKFV3lALi9L2eY8NQzEoQeSWc19/o
	 u9Jrvmcdl3J/Ol2FmVC5c/XRvdfEr1ffLs0OcIKpbm7cBuC4K4KiRf2HFlMaWrVQQJ
	 Z2TRq4qkhEuvMp57o5gaXvhF1DnjYSSK1I3DV380CIAmCrDsDNxmhNOUPGsO9D9PB3
	 DlZYUIcoM6h5bQXUqhB0VfzclppR7rSuQOMj6qdx32dQ0Wx8iIsCfiwIQJ8PGcHUD1
	 D/IZN3fT+A7Og==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D64E5D8C96E;
	Fri, 12 Jan 2024 00:40:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: dsa: fix netdev_priv() dereference before check on
 non-DSA netdevice events
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170502002587.17549.11621864290537732537.git-patchwork-notify@kernel.org>
Date: Fri, 12 Jan 2024 00:40:25 +0000
References: <20240110003354.2796778-1-vladimir.oltean@nxp.com>
In-Reply-To: <20240110003354.2796778-1-vladimir.oltean@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, andrew@lunn.ch, f.fainelli@gmail.com,
 dan.carpenter@oracle.com,
 syzbot+d81bcd883824180500c8@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 10 Jan 2024 02:33:54 +0200 you wrote:
> After the blamed commit, we started doing this dereference for every
> NETDEV_CHANGEUPPER and NETDEV_PRECHANGEUPPER event in the system.
> 
> static inline struct dsa_port *dsa_user_to_port(const struct net_device *dev)
> {
> 	struct dsa_user_priv *p = netdev_priv(dev);
> 
> [...]

Here is the summary with links:
  - [net] net: dsa: fix netdev_priv() dereference before check on non-DSA netdevice events
    https://git.kernel.org/netdev/net/c/844f104790bd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



