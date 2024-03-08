Return-Path: <netdev+bounces-78608-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14E45875DD7
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 07:00:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CE95B21A50
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 06:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 671DF32C9C;
	Fri,  8 Mar 2024 06:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BO3I75CE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437BF28E2B
	for <netdev@vger.kernel.org>; Fri,  8 Mar 2024 06:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709877638; cv=none; b=MDRATu6Hisi48wuL736ljczGNXBkgIa/ddXTyCh6/1jTIZIF8TBUg/LmifErdNYZslB8rVKUaxhGwByzCT2+KDtw0DlNkTzwEpZujK66TIeEfcVf5zWwZ1Dl7d+isl5y7r4S7OxxYQsfAmdc7QKthOWlhxpggJ2jMLRbv9/L58c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709877638; c=relaxed/simple;
	bh=3s/fjQ5DkQa/0EUFA1E0vpXY7ZPadMtPM8Kou3cbKwg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XnHZZDwO6Rg0YKah5D08gsBFq7W+Vydqu6B9fXm0reLwQSKzFzUVKZTNWBSQVZOrKojspE9GbeqnkBhC8KW+Z/PA3AOFpE2XIlp4sW8/X7IsaOTP85IeUFMqGZ1mF2QnKCVA/mlRX7dJEaSUuG55DloDE0MT99n1pfbNk6Mu0ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BO3I75CE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 115E8C43390;
	Fri,  8 Mar 2024 06:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709877638;
	bh=3s/fjQ5DkQa/0EUFA1E0vpXY7ZPadMtPM8Kou3cbKwg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BO3I75CEO0U79Q/TmOZEiREKLHvCBdr8Z2gdMMNqkeG+N6Q98Ch1X6PAUCkXNriwK
	 cEFUGBgznHDGoUnlcydNN6pdFzJiXPIjcvM6WINdgGh7shnIFI51MkoWi2CAprPsL3
	 4tdJHgMASZbeM4R/xBIsEI6gPuMM95YRjVJNBuNFpR1+v8Luf+QAvUn4mzoFy05YYT
	 nqMNSoQYOgAZ8+dtUgZKvNhmkHlqJWczeYKzEsEzPgGT2Gv1nDBIoJnxb9nq6nKMsi
	 doL4bNoImHKbchF2AEM163IwizQ3WJYYJ6Dc7MfBEJi9kv0uGGOd1GDsXB36/N0EWr
	 UqhHgXeI2mlKQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E6F7DD84BDA;
	Fri,  8 Mar 2024 06:00:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next 00/18] net: group together hot data
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170987763794.6902.14828523993086840984.git-patchwork-notify@kernel.org>
Date: Fri, 08 Mar 2024 06:00:37 +0000
References: <20240306160031.874438-1-edumazet@google.com>
In-Reply-To: <20240306160031.874438-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 dsahern@kernel.org, willemb@google.com, soheil@google.com,
 ncardwell@google.com, netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  6 Mar 2024 16:00:13 +0000 you wrote:
> While our recent structure reorganizations were focused
> on increasing max throughput, there is still an
> area where improvements are much needed.
> 
> In many cases, a cpu handles one packet at a time,
> instead of a nice batch.
> 
> [...]

Here is the summary with links:
  - [v2,net-next,01/18] net: introduce struct net_hotdata
    https://git.kernel.org/netdev/net-next/c/2658b5a8a4ee
  - [v2,net-next,02/18] net: move netdev_budget and netdev_budget to net_hotdata
    https://git.kernel.org/netdev/net-next/c/ae6e22f7b7f0
  - [v2,net-next,03/18] net: move netdev_tstamp_prequeue into net_hotdata
    https://git.kernel.org/netdev/net-next/c/f59b5416c396
  - [v2,net-next,04/18] net: move ptype_all into net_hotdata
    https://git.kernel.org/netdev/net-next/c/0b91fa4bfb1c
  - [v2,net-next,05/18] net: move netdev_max_backlog to net_hotdata
    https://git.kernel.org/netdev/net-next/c/edbc666cdcbf
  - [v2,net-next,06/18] net: move ip_packet_offload and ipv6_packet_offload to net_hotdata
    https://git.kernel.org/netdev/net-next/c/61a0be1a5342
  - [v2,net-next,07/18] net: move tcpv4_offload and tcpv6_offload to net_hotdata
    https://git.kernel.org/netdev/net-next/c/0139806eebd6
  - [v2,net-next,08/18] net: move dev_tx_weight to net_hotdata
    https://git.kernel.org/netdev/net-next/c/26722dc74bf0
  - [v2,net-next,09/18] net: move dev_rx_weight to net_hotdata
    https://git.kernel.org/netdev/net-next/c/71c0de9bac9c
  - [v2,net-next,10/18] net: move skbuff_cache(s) to net_hotdata
    https://git.kernel.org/netdev/net-next/c/aa70d2d16f28
  - [v2,net-next,11/18] udp: move udpv4_offload and udpv6_offload to net_hotdata
    https://git.kernel.org/netdev/net-next/c/6a55ca6b0122
  - [v2,net-next,12/18] ipv6: move tcpv6_protocol and udpv6_protocol to net_hotdata
    https://git.kernel.org/netdev/net-next/c/4ea0875b9d89
  - [v2,net-next,13/18] inet: move tcp_protocol and udp_protocol to net_hotdata
    https://git.kernel.org/netdev/net-next/c/571bf020be9c
  - [v2,net-next,14/18] inet: move inet_ehash_secret and udp_ehash_secret into net_hotdata
    https://git.kernel.org/netdev/net-next/c/6e0735723ab4
  - [v2,net-next,15/18] ipv6: move inet6_ehash_secret and udp6_ehash_secret into net_hotdata
    https://git.kernel.org/netdev/net-next/c/5af674bb90a0
  - [v2,net-next,16/18] ipv6: move tcp_ipv6_hash_secret and udp_ipv6_hash_secret to net_hotdata
    https://git.kernel.org/netdev/net-next/c/df51b8456415
  - [v2,net-next,17/18] net: introduce include/net/rps.h
    https://git.kernel.org/netdev/net-next/c/490a79faf95e
  - [v2,net-next,18/18] net: move rps_sock_flow_table to net_hotdata
    https://git.kernel.org/netdev/net-next/c/ce7f49ab7415

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



