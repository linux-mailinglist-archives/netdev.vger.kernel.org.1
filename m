Return-Path: <netdev+bounces-235344-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1761CC2ED89
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 02:43:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6D5974F26EA
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 01:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA2F4231829;
	Tue,  4 Nov 2025 01:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ObB97N3H"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE0122FE0A;
	Tue,  4 Nov 2025 01:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762220443; cv=none; b=Tly8AqpCb8+HQkRh+LXHUSnJrquENVFL8Qa+WZOJPgMr0HyZDzzKnYEGQtlSpVPn4vjaG6GQGN6Ha0HCfqjDhc2qzDvAqvZb81imboDICZYFQhEWw03q+meIWPsepdkVgwbd3pka3GPeQyNiOpTS44zCsuFtRJcC2w9YmLoqJFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762220443; c=relaxed/simple;
	bh=hLOl+nIyoL9YpIF2ua5v7KC49yNxnmSmLEI5ZrCaKFc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pP4u/VVN/E1Xz2q7xzaxECuXz2AI3AgSfJNlJV9ZAE9bnyaZMCddCFSI96PB8shk0i/kS4UintmS5QXhXHPT5xFzx/hSnhwlogcEj8l9VvRRRUupiwg7QBvg4F9G1E2KP59eVfTWVjm8QW7yGodNrYT5rU1Nu6KIl8N6I4RzdM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ObB97N3H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67F3DC4CEFD;
	Tue,  4 Nov 2025 01:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762220443;
	bh=hLOl+nIyoL9YpIF2ua5v7KC49yNxnmSmLEI5ZrCaKFc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ObB97N3HwireapfZhr8VJvNPleWkPGkmwUNnms1y1dHu2ThRp3qpqa5G2NF6ULO5w
	 G53Lysn7IsIG/u2sDuZbevMK95L4wlHfvtrU5effNZSFgKUGl1rw3stn6sxpwARV44
	 J4YIt23RHSrRw8ZnuSJP21Uf5nSXumCkqmqc6f1iGZCPE/WLMvMGfz7cY3eFuALsWJ
	 creCiWq5x/be52kQNiYOPHpBpe8o2KmFF1lKFN+mMIuPj2yt/CspD+C3OdDetM4DNZ
	 nt1fa6KUqQbIzLEqB0rjQFheMdpbjVET++CXi51/qAyBylBW05ochj/Me+Yc9koPwh
	 hx0CvJSbhZnMA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EADB83809A8A;
	Tue,  4 Nov 2025 01:40:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] net: spacemit: Check netif_running() in
 emac_set_pauseparam()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176222041749.2285814.8859925220463360389.git-patchwork-notify@kernel.org>
Date: Tue, 04 Nov 2025 01:40:17 +0000
References: <20251103-k1-ethernet-remove-fc-v3-1-2083770cd282@iscas.ac.cn>
In-Reply-To: <20251103-k1-ethernet-remove-fc-v3-1-2083770cd282@iscas.ac.cn>
To: Vivian Wang <wangruikang@iscas.ac.cn>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, dlan@gentoo.org,
 maxime.chevallier@bootlin.com, troy.mitchell@linux.spacemit.com,
 vadim.fedorenko@linux.dev, netdev@vger.kernel.org,
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 03 Nov 2025 10:02:49 +0800 you wrote:
> Currently, emac_set_pauseparam() will oops if userspace calls it while
> the interface is not up, because phydev is NULL, but it is still
> accessed in emac_set_fc() and emac_set_fc_autoneg().
> 
> Check for netif_running(dev) in emac_set_pauseparam() before proceeding.
> 
> Fixes: bfec6d7f2001 ("net: spacemit: Add K1 Ethernet MAC")
> Signed-off-by: Vivian Wang <wangruikang@iscas.ac.cn>
> 
> [...]

Here is the summary with links:
  - [net,v3] net: spacemit: Check netif_running() in emac_set_pauseparam()
    https://git.kernel.org/netdev/net/c/5556f23478e6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



