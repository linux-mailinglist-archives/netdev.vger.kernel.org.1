Return-Path: <netdev+bounces-150157-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 270669E93B0
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 13:20:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00C7A1655C3
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 12:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1090421E085;
	Mon,  9 Dec 2024 12:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hbGEhID+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D152D21B1A7;
	Mon,  9 Dec 2024 12:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733746821; cv=none; b=qIzZzeIlWHugap5jQZc5SwRR25/egGYUNPu+955WomBee9uZ0a8Jx9iDUT4pCruoHL3epN0UV3r7Jo2PGAY5j6C0LERCfNirTsxBpgW7o0hJoHoGAWbbO+Wnc2mTtc13sF1Ne+54aktNZRD081gaNC/2PUysqQmpLefRE8imbHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733746821; c=relaxed/simple;
	bh=ORVba51fgn5Y2cMstsQg19evQaiepuNOEBjuFVdtd6Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eGnfwlSiunzQqQv2TIh5p8ibIRM4N6Ts5YtxYAo2FE8MrISBpqmooXm4sqn+0VwEorM7qfSOT47aBbNHAG3+zHL5TQuNMpqXxRd1BeKRY8APdwsEJ39dkE+ncB+Xu9qVSRhwYjuRR2DQDDnT0yncSbbwXaaYEAPj7xfixUhH3Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hbGEhID+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37B86C4CED1;
	Mon,  9 Dec 2024 12:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733746818;
	bh=ORVba51fgn5Y2cMstsQg19evQaiepuNOEBjuFVdtd6Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hbGEhID+hZzHkSzqqaBGwT9QK5sAixadT4nGjt8xPEzDk0OOU5LHoe8QWbKUAE93W
	 a8k5sTLaG9HUkAULxKiiN306zbpA5bOFXnYKrisTmeC6W0qLb5lgMbFlHkxWMK2ptI
	 KBnGTcFy06l1ygdzOW0JCtXcnvopjEsKMxwIQT0fik56feWGOKDZEO6svBNpQyuDHI
	 mHLqSg4yn9WlcHLSPqp8CaZKpFuO3CYflTsS+o+aETB6LhZU8EBQCIgoiok5T0xh8n
	 qaIRzUExwTOXpgPh8EsvUEe8wS0+24QuAVvyUa7FSXrMQJGTTxdd3P+f8yLtv96sTw
	 O/w1C5ED0nInA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB20C380A95E;
	Mon,  9 Dec 2024 12:20:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next PATCH v10 0/8] cn10k-ipsec: Add outbound inline ipsec
 support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173374683375.15657.6178697475771459592.git-patchwork-notify@kernel.org>
Date: Mon, 09 Dec 2024 12:20:33 +0000
References: <20241204055659.1700459-1-bbhushan2@marvell.com>
In-Reply-To: <20241204055659.1700459-1-bbhushan2@marvell.com>
To: Bharat Bhushan <bbhushan2@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
 hkelam@marvell.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, jerinj@marvell.com, lcherian@marvell.com,
 ndabilpuram@marvell.com, andrew+netdev@lunn.ch, richardcochran@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 4 Dec 2024 11:26:51 +0530 you wrote:
> This patch series adds outbound inline ipsec support on Marvell
> cn10k series of platform. One crypto hardware logical function
> (cpt-lf) per netdev is required for inline ipsec outbound
> functionality. Software prepare and submit crypto hardware
> (CPT) instruction for outbound inline ipsec crypto mode offload.
> The CPT instruction have details for encryption and authentication
> Crypto hardware encrypt, authenticate and provide the ESP packet
> to network hardware logic to transmit ipsec packet.
> 
> [...]

Here is the summary with links:
  - [net-next,v10,1/8] octeontx2-pf: map skb data as device writeable
    https://git.kernel.org/netdev/net-next/c/195c3d463181
  - [net-next,v10,2/8] octeontx2-pf: Move skb fragment map/unmap to common code
    https://git.kernel.org/netdev/net-next/c/c460b7442a6b
  - [net-next,v10,3/8] octeontx2-af: Disable backpressure between CPT and NIX
    https://git.kernel.org/netdev/net-next/c/a7ef63dbd588
  - [net-next,v10,4/8] cn10k-ipsec: Init hardware for outbound ipsec crypto offload
    https://git.kernel.org/netdev/net-next/c/fe079ab05d49
  - [net-next,v10,5/8] cn10k-ipsec: Add SA add/del support for outb ipsec crypto offload
    https://git.kernel.org/netdev/net-next/c/c45211c23697
  - [net-next,v10,6/8] cn10k-ipsec: Process outbound ipsec crypto offload
    https://git.kernel.org/netdev/net-next/c/6a77a158848a
  - [net-next,v10,7/8] cn10k-ipsec: Allow ipsec crypto offload for skb with SA
    https://git.kernel.org/netdev/net-next/c/32188be805d0
  - [net-next,v10,8/8] cn10k-ipsec: Enable outbound ipsec crypto offload
    https://git.kernel.org/netdev/net-next/c/b3ae3dc3a30f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



