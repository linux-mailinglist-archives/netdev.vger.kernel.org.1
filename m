Return-Path: <netdev+bounces-171622-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A355DA4DDEA
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 13:30:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 105B83A4CB3
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 12:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A26520299D;
	Tue,  4 Mar 2025 12:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TMo2Q3Ep"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624B8202976;
	Tue,  4 Mar 2025 12:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741091402; cv=none; b=sVRIdalGHjNMkcG/alsyn3eeamGZh4Jq76Zkb2RYylft/fxmyiVbkVx440yXtA6mgT42F4+As+LaphwGvyjLXP0vt9ecUxsId42StPkX1kpiFV8LeaBi6G4SGItIIePmbriXbxyaB6cr9DqPtDbFUvmuBIa974/rjVxIQ8Bu5jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741091402; c=relaxed/simple;
	bh=rJKGNfM/s8QAQjXFzZnxlWs2DFKcY9YmiOImWJPI/GQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UJ2wSjl8qFpqVUcl+Wl/l2fsO+/9Bw5Nq+fiknjvz8FJcp8QkQ9/0Ur1b9HKiG2xGpOGFsNkQGyMmAq1g7ULVTHxIYN9S20ncXzLZSw7vQzEpie3nTV+wA+lwmyKPj2UL/CQwGNVFBkm+KC7ZwsNYBhtsEbvPC3MZQWHguZOZ1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TMo2Q3Ep; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3EC3C4CEE5;
	Tue,  4 Mar 2025 12:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741091401;
	bh=rJKGNfM/s8QAQjXFzZnxlWs2DFKcY9YmiOImWJPI/GQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TMo2Q3EpOctKaoJW9GG7S6AMYjIDFGNjCQj4bJsSZCI9aqh/qYV4ejHAlDb9RLKnP
	 M1csSwvOvpyYuoLzNbdiOSskin8i1N64VgsfpIBdZmAAbz5+TRZLfil0G9953jUhUh
	 IFBtS/SB89C0+avIAkVA0DnGt0g5t9Bsk0D0NsgrRUIV2lK5TuG7+WKG7B7fyHSfcl
	 9n8w8hSOw7iZiEvXgMHZmcmUgNFVj73T4Zci4/koyKbeOkbKt4nDC/VRHbkEgdelGK
	 10XmL2sNZ9QGlY4ENh2ChRmU+IHBOqKWhqvmeYlTGseMDIoQQAwGaAdyzoqN/AOD5c
	 ewoyaowLH8P+w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE2D380AA7F;
	Tue,  4 Mar 2025 12:30:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v8 00/15] Introduce flowtable hw offloading in
 airoha_eth driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174109143450.124302.2708662777154071510.git-patchwork-notify@kernel.org>
Date: Tue, 04 Mar 2025 12:30:34 +0000
References: <20250228-airoha-en7581-flowtable-offload-v8-0-01dc1653f46e@kernel.org>
In-Reply-To: <20250228-airoha-en7581-flowtable-offload-v8-0-01dc1653f46e@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, nbd@nbd.name, sean.wang@mediatek.com,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 p.zabel@pengutronix.de, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, chester.a.unal@arinc9.com, daniel@makrotopia.org,
 dqfext@gmail.com, andrew@lunn.ch, olteanv@gmail.com, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 devicetree@vger.kernel.org, upstream@airoha.com, sayantan.nandy@airoha.com,
 ansuelsmth@gmail.com, krzysztof.kozlowski@linaro.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 28 Feb 2025 11:54:08 +0100 you wrote:
> Introduce netfilter flowtable integration in airoha_eth driver to
> offload 5-tuple flower rules learned by the PPE module if the user
> accelerates them using a nft configuration similar to the one reported
> below:
> 
> table inet filter {
> 	flowtable ft {
> 		hook ingress priority filter
> 		devices = { lan1, lan2, lan3, lan4, eth1 }
> 		flags offload;
> 	}
> 	chain forward {
> 		type filter hook forward priority filter; policy accept;
> 		meta l4proto { tcp, udp } flow add @ft
> 	}
> }
> 
> [...]

Here is the summary with links:
  - [net-next,v8,01/15] net: airoha: Move airoha_eth driver in a dedicated folder
    https://git.kernel.org/netdev/net-next/c/fb3dda82fd38
  - [net-next,v8,02/15] net: airoha: Move definitions in airoha_eth.h
    https://git.kernel.org/netdev/net-next/c/b38f4ff0ceac
  - [net-next,v8,03/15] net: airoha: Move reg/write utility routines in airoha_eth.h
    https://git.kernel.org/netdev/net-next/c/e0758a8694fb
  - [net-next,v8,04/15] net: airoha: Move register definitions in airoha_regs.h
    https://git.kernel.org/netdev/net-next/c/ec663d9a82bf
  - [net-next,v8,05/15] net: airoha: Move DSA tag in DMA descriptor
    https://git.kernel.org/netdev/net-next/c/af3cf757d5c9
  - [net-next,v8,06/15] net: dsa: mt7530: Enable Rx sptag for EN7581 SoC
    https://git.kernel.org/netdev/net-next/c/ab667db1e601
  - [net-next,v8,07/15] net: airoha: Enable support for multiple net_devices
    https://git.kernel.org/netdev/net-next/c/80369686737f
  - [net-next,v8,08/15] net: airoha: Move REG_GDM_FWD_CFG() initialization in airoha_dev_init()
    https://git.kernel.org/netdev/net-next/c/67fde5d58cd4
  - [net-next,v8,09/15] net: airoha: Rename airoha_set_gdm_port_fwd_cfg() in airoha_set_vip_for_gdm_port()
    https://git.kernel.org/netdev/net-next/c/c28b8375f6d0
  - [net-next,v8,10/15] dt-bindings: net: airoha: Add the NPU node for EN7581 SoC
    https://git.kernel.org/netdev/net-next/c/266f7a0f81c0
  - [net-next,v8,11/15] dt-bindings: net: airoha: Add airoha,npu phandle property
    https://git.kernel.org/netdev/net-next/c/9b1a0b72264c
  - [net-next,v8,12/15] net: airoha: Introduce Airoha NPU support
    https://git.kernel.org/netdev/net-next/c/23290c7bc190
  - [net-next,v8,13/15] net: airoha: Introduce flowtable offload support
    https://git.kernel.org/netdev/net-next/c/00a7678310fe
  - [net-next,v8,14/15] net: airoha: Add loopback support for GDM2
    https://git.kernel.org/netdev/net-next/c/9cd451d414f6
  - [net-next,v8,15/15] net: airoha: Introduce PPE debugfs support
    https://git.kernel.org/netdev/net-next/c/3fe15c640f38

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



