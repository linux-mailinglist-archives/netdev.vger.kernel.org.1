Return-Path: <netdev+bounces-111206-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14DC19303CE
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 07:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B75A2283B1E
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 05:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F2711AAD7;
	Sat, 13 Jul 2024 05:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jlfqOHI8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190F619478
	for <netdev@vger.kernel.org>; Sat, 13 Jul 2024 05:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720849841; cv=none; b=b9RY6zvS6SdFfU7a1jIOqPWT71alEZ9doazdbD6/DVEyswgjWvl8GYzamAnDD/xmbHYpqXBQ5UqdCv2C8/S1wJKu35e1eI+hLlL0vWU58SJufAa5pbTx5NpL843CB9qHqyCBjV5rHnRq+RXWabYOXwkD30kc94INCvMvAtlqawA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720849841; c=relaxed/simple;
	bh=t8AMCXwaR/H8KlDPCS394CQozBy/R4WI1vaUfl0sd7o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QOKAZyOx2dXqJY1qLyUjTZVDc5G59Bbhjg700VcwneePM3iURtEAvOHd0vm9s0qu/sSbBnurMEv2MI4BfQDirDAFP9NegAp2ctzFbbwgP2skoJLb++IBoqJBbTLdk6XA72Bn3j2fok5oC9SBQPyk6wCTIK9OmoxfhcmxS+f7MwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jlfqOHI8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A5A56C4AF0B;
	Sat, 13 Jul 2024 05:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720849840;
	bh=t8AMCXwaR/H8KlDPCS394CQozBy/R4WI1vaUfl0sd7o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jlfqOHI8qgE9GlO31LRimZdqao9LQ4YnIUiTosL0OzR0vGDhEko6OrdU1QYO1MM4r
	 VKMH+JCUGund8grOug5LADSzuQ9bCWnNZPr1+gK62F6NHHofJCwzV03MtlobRWR6Bn
	 jJ2MpS8LSo+l59yfbgL764N2wiuCIOL5xGMiwcuKJc9m0R6u4p8B9u2hCFXaVK6fz6
	 e9NQZ/9XQpq11Dt4dVT8Y5YkEk3lGj3D5qyKH7nCUvDhL3z1rYRPAvUAX5N/sML0Zp
	 /IbePqX9SbARkuVnWqqFUOTH+XP0KrWUlh12NqzMPqB2KxhtqypPkd2qW537PkLbOV
	 57eOdp2xM30+w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8D2F6C43168;
	Sat, 13 Jul 2024 05:50:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 00/14][pull request] idpf: XDP chapter I: convert Rx
 to libeth
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172084984057.15436.1894949022957668951.git-patchwork-notify@kernel.org>
Date: Sat, 13 Jul 2024 05:50:40 +0000
References: <20240710203031.188081-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20240710203031.188081-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, aleksander.lobakin@intel.com,
 nex.sw.ncis.osdt.itp.upstreaming@intel.com, lihong.yang@intel.com,
 willemb@google.com, almasrymina@google.com

Hello:

This series was applied to netdev/net-next.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Wed, 10 Jul 2024 13:30:16 -0700 you wrote:
> Alexander Lobakin says:
> 
> XDP for idpf is currently 5 chapters:
> * convert Rx to libeth (this);
> * convert Tx and stats to libeth;
> * generic XDP and XSk code changes, libeth_xdp;
> * actual XDP for idpf via libeth_xdp;
> * XSk for idpf (^).
> 
> [...]

Here is the summary with links:
  - [net-next,01/14] cache: add __cacheline_group_{begin, end}_aligned() (+ couple more)
    https://git.kernel.org/netdev/net-next/c/2cb13dec8c5e
  - [net-next,02/14] page_pool: use __cacheline_group_{begin, end}_aligned()
    https://git.kernel.org/netdev/net-next/c/39daa09d34ad
  - [net-next,03/14] libeth: add cacheline / struct layout assertion helpers
    https://git.kernel.org/netdev/net-next/c/62c884256ea1
  - [net-next,04/14] idpf: stop using macros for accessing queue descriptors
    https://git.kernel.org/netdev/net-next/c/66c27e3b19d5
  - [net-next,05/14] idpf: split &idpf_queue into 4 strictly-typed queue structures
    https://git.kernel.org/netdev/net-next/c/e4891e4687c8
  - [net-next,06/14] idpf: avoid bloating &idpf_q_vector with big %NR_CPUS
    https://git.kernel.org/netdev/net-next/c/bf9bf7042a38
  - [net-next,07/14] idpf: strictly assert cachelines of queue and queue vector structures
    https://git.kernel.org/netdev/net-next/c/5a816aae2d46
  - [net-next,08/14] idpf: merge singleq and splitq &net_device_ops
    https://git.kernel.org/netdev/net-next/c/14f662b43bf8
  - [net-next,09/14] idpf: compile singleq code only under default-n CONFIG_IDPF_SINGLEQ
    https://git.kernel.org/netdev/net-next/c/f771314d6b75
  - [net-next,10/14] idpf: reuse libeth's definitions of parsed ptype structures
    https://git.kernel.org/netdev/net-next/c/1b1b26208515
  - [net-next,11/14] idpf: remove legacy Page Pool Ethtool stats
    https://git.kernel.org/netdev/net-next/c/4309363f1959
  - [net-next,12/14] libeth: support different types of buffers for Rx
    https://git.kernel.org/netdev/net-next/c/5aaac1aece4e
  - [net-next,13/14] idpf: convert header split mode to libeth + napi_build_skb()
    https://git.kernel.org/netdev/net-next/c/90912f9f4f2d
  - [net-next,14/14] idpf: use libeth Rx buffer management for payload buffer
    https://git.kernel.org/netdev/net-next/c/74d1412ac8f3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



