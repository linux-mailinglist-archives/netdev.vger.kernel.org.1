Return-Path: <netdev+bounces-224376-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A5DB843A1
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 12:50:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2BE9188A46F
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 10:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1D0122256F;
	Thu, 18 Sep 2025 10:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jtapozoj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD78D18A6DB
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 10:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758192628; cv=none; b=EMOn5G0M7dA5ykPJAfW2AZjlBHXlltW8qUmrnsiKF7uALLM2Y0jjeAxQn0rd/bbT36244tGeEqY1Nc50oNzgCzW2fG4u363Qu0Zvl4oDvr5D+g0O50xu1eTN6cTH+XZIP+xB/AU2Hb0An6jFFNitaup2uGZbwzuBBCl2Jbm4Q58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758192628; c=relaxed/simple;
	bh=LoeZVzw/EXTCA8W4YzMrdoY6JwmoREE2/YLWojCoED8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sMoJV7Xew6NiHfd2N2VD5ShVW4QkxPPKE4+MOORrOJvrHNAotIFMHulGA7GAXQkO2a3PoawdvlYGAirKXS4vMgxYZ/mde0BikZn+bNaRj7V9V9i+aYIh2ZQM8+Y9rPPrrhOnRJvfdZwNo3lz12LANoyt4C3XBWusW5lPhWU1RUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jtapozoj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5159BC4CEE7;
	Thu, 18 Sep 2025 10:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758192628;
	bh=LoeZVzw/EXTCA8W4YzMrdoY6JwmoREE2/YLWojCoED8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jtapozojXdVWzA56LUCuMPiD6zE4lbrFDLJX+iA2i3lK/WsZPGEEzYaAFis5EyZz/
	 2SyopKW+wOST4MmfOGqNkoUPAepC1og4+fY6EVvHMkXRWPfgwM5r4N70Xr2II+5MNt
	 VT5iGZktt2XvdsMV158s+23wfeoHOq5AM2zqFAPegeLEsfieWaDC37k6OuDQZZ/7FQ
	 lCEN23WuOuEiLKaQ5BfOCVluThqcuBMBKVUEkZ1mjHMJMqTvd/cVDHH4cnUbyOHaT6
	 pbKfuegzqRm9SivWePNPqqBrqY+twPaYHxa+VfmK22QpfRBPopH5Df27at2fxP/kze
	 p7WhU/f+QYq9A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE3D39D0C28;
	Thu, 18 Sep 2025 10:50:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v13 00/19] add basic PSP encryption for TCP
 connections
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175819262850.2365733.8295832390159298825.git-patchwork-notify@kernel.org>
Date: Thu, 18 Sep 2025 10:50:28 +0000
References: <20250917000954.859376-1-daniel.zahka@gmail.com>
In-Reply-To: <20250917000954.859376-1-daniel.zahka@gmail.com>
To: Daniel Zahka <daniel.zahka@gmail.com>
Cc: donald.hunter@gmail.com, kuba@kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
 andrew+netdev@lunn.ch, saeedm@nvidia.com, leon@kernel.org, tariqt@nvidia.com,
 borisp@nvidia.com, kuniyu@google.com, willemb@google.com, dsahern@kernel.org,
 ncardwell@google.com, phaddad@nvidia.com, raeds@nvidia.com,
 jianbol@nvidia.com, dtatulea@nvidia.com, rrameshbabu@nvidia.com,
 sdf@fomichev.me, toke@redhat.com, aleksander.lobakin@intel.com,
 kiran.kella@broadcom.com, jacob.e.keller@intel.com, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 16 Sep 2025 17:09:27 -0700 you wrote:
> This is v13 of the PSP RFC [1] posted by Jakub Kicinski one year
> ago. General developments since v1 include a fork of packetdrill [2]
> with support for PSP added, as well as some test cases, and an
> implementation of PSP key exchange and connection upgrade [3]
> integrated into the fbthrift RPC library. Both [2] and [3] have been
> tested on server platforms with PSP-capable CX7 NICs. Below is the
> cover letter from the original RFC:
> 
> [...]

Here is the summary with links:
  - [net-next,v13,01/19] psp: add documentation
    https://git.kernel.org/netdev/net-next/c/a9266275fd7b
  - [net-next,v13,02/19] psp: base PSP device support
    https://git.kernel.org/netdev/net-next/c/00c94ca2b99e
  - [net-next,v13,03/19] net: modify core data structures for PSP datapath support
    https://git.kernel.org/netdev/net-next/c/ed8a507b7483
  - [net-next,v13,04/19] tcp: add datapath logic for PSP with inline key exchange
    https://git.kernel.org/netdev/net-next/c/659a2899a57d
  - [net-next,v13,05/19] psp: add op for rotation of device key
    https://git.kernel.org/netdev/net-next/c/117f02a49b77
  - [net-next,v13,06/19] net: move sk_validate_xmit_skb() to net/core/dev.c
    https://git.kernel.org/netdev/net-next/c/8c511c1df380
  - [net-next,v13,07/19] net: tcp: allow tcp_timewait_sock to validate skbs before handing to device
    https://git.kernel.org/netdev/net-next/c/0917bb139eed
  - [net-next,v13,08/19] net: psp: add socket security association code
    https://git.kernel.org/netdev/net-next/c/6b46ca260e22
  - [net-next,v13,09/19] net: psp: update the TCP MSS to reflect PSP packet overhead
    https://git.kernel.org/netdev/net-next/c/e97269257fe4
  - [net-next,v13,10/19] psp: track generations of device key
    https://git.kernel.org/netdev/net-next/c/e78851058b35
  - [net-next,v13,11/19] net/mlx5e: Support PSP offload functionality
    https://git.kernel.org/netdev/net-next/c/89ee2d92f66c
  - [net-next,v13,12/19] net/mlx5e: Implement PSP operations .assoc_add and .assoc_del
    https://git.kernel.org/netdev/net-next/c/af2196f49480
  - [net-next,v13,13/19] psp: provide encapsulation helper for drivers
    https://git.kernel.org/netdev/net-next/c/fc724515741a
  - [net-next,v13,14/19] net/mlx5e: Implement PSP Tx data path
    https://git.kernel.org/netdev/net-next/c/e5a1861a298e
  - [net-next,v13,15/19] net/mlx5e: Add PSP steering in local NIC RX
    https://git.kernel.org/netdev/net-next/c/9536fbe10c9d
  - [net-next,v13,16/19] net/mlx5e: Configure PSP Rx flow steering rules
    https://git.kernel.org/netdev/net-next/c/2b6e450bfde7
  - [net-next,v13,17/19] psp: provide decapsulation and receive helper for drivers
    https://git.kernel.org/netdev/net-next/c/0eddb8023cee
  - [net-next,v13,18/19] net/mlx5e: Add Rx data path offload
    https://git.kernel.org/netdev/net-next/c/29d7f433fcec
  - [net-next,v13,19/19] net/mlx5e: Implement PSP key_rotate operation
    https://git.kernel.org/netdev/net-next/c/411d9d33c8a2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



