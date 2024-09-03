Return-Path: <netdev+bounces-124476-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91217969A5B
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 12:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A9DD1F23F4F
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 10:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F25F41A4E7C;
	Tue,  3 Sep 2024 10:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DiakuHCG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C879019F42A;
	Tue,  3 Sep 2024 10:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725360032; cv=none; b=mCrcbBOBXrdY7nxXHo0lOxJlsu8ogUUCaUGixmdPIoemqBXfvrpVsMi82lt8wgOZqgI0I4ZbUdN5LQGFW3BTkf0XIJdadGam+mHXx3SA8qio97gnZ3kazVx4SdQOjpyfDN23fY7DXNGEPXrhL2XY4QxxA0Zty6xViTamltLvQ14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725360032; c=relaxed/simple;
	bh=wp97o9aMEghfyByYdohbJIy/XpOlCP68IJYi+vOZEqI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZTKagCinr/+Kdx2+4s0aAKFHI7KeIqtMJFROeTyk0WA8Nnw/uakWgk+JG6/PNGXcPRKUQv1Ojkl6C+0PUk0RNPKJvBoV7gnyOD6jBWJzrgLrAfSzPnjD4tZ243Xdor0he8n8zC00ESEI0TS85gbl4VFm4TfhqqMl4jly7MM1iEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DiakuHCG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48379C4CEC4;
	Tue,  3 Sep 2024 10:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725360031;
	bh=wp97o9aMEghfyByYdohbJIy/XpOlCP68IJYi+vOZEqI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DiakuHCG9J1r6TsqGgooxvKRXhKrcnWfDvOmLCTq4i0gOmoMGXn+5UyPfhkrsgF4K
	 PaxW/8lSUIumMqAM266D7HBVAf3JDBW+af72TjaYjdReMLwXyAFsDuW4yYW7+6OIB6
	 PY4l/mG4kApcoEVj1X4lMQW8Ry79cZaHsXSrlhr/YXfJDzQ+SaQFTU6FG0x+/7w30Y
	 lY3BvMPLS6GSznvoAuuW8JSWCur/oum8M03TtZdAz0Rm0y5pex3U5X2apbEvXLIHZ+
	 E4woiCJTHqPbi5FptuVTd3jSfUCPzeGzDMwgWeTAfmAAzlo39be0mXFX6Q1ZtQpF3P
	 U0iKmY4uQwKag==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33ECB3805D82;
	Tue,  3 Sep 2024 10:40:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v5 0/5] netdev_features: start cleaning
 netdev_features_t up
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172536003201.249713.3183163361305744893.git-patchwork-notify@kernel.org>
Date: Tue, 03 Sep 2024 10:40:32 +0000
References: <20240829123340.789395-1-aleksander.lobakin@intel.com>
In-Reply-To: <20240829123340.789395-1-aleksander.lobakin@intel.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, xuanzhuo@linux.alibaba.com,
 andrew@lunn.ch, willemdebruijn.kernel@gmail.com,
 nex.sw.ncis.osdt.itp.upstreaming@intel.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 29 Aug 2024 14:33:35 +0200 you wrote:
> NETDEV_FEATURE_COUNT is currently 64, which means we can't add any new
> features as netdev_features_t is u64.
> As per several discussions, instead of converting netdev_features_t to
> a bitmap, which would mean A LOT of changes, we can try cleaning up
> netdev feature bits.
> There's a bunch of bits which don't really mean features, rather device
> attributes/properties that can't be changed via Ethtool in any of the
> drivers. Such attributes can be moved to netdev private flags without
> losing any functionality.
> 
> [...]

Here is the summary with links:
  - [net-next,v5,1/5] netdevice: convert private flags > BIT(31) to bitfields
    (no matching commit)
  - [net-next,v5,2/5] netdev_features: convert NETIF_F_LLTX to dev->lltx
    (no matching commit)
  - [net-next,v5,3/5] netdev_features: convert NETIF_F_NETNS_LOCAL to dev->netns_local
    (no matching commit)
  - [net-next,v5,4/5] netdev_features: convert NETIF_F_FCOE_MTU to dev->fcoe_mtu
    (no matching commit)
  - [net-next,v5,5/5] netdev_features: remove NETIF_F_ALL_FCOE
    https://git.kernel.org/netdev/net-next/c/a61fec1c87be

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



