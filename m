Return-Path: <netdev+bounces-230644-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C02BEC383
	for <lists+netdev@lfdr.de>; Sat, 18 Oct 2025 03:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 725963A347B
	for <lists+netdev@lfdr.de>; Sat, 18 Oct 2025 01:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B015126C17;
	Sat, 18 Oct 2025 01:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GlRSz5Py"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1959D7483;
	Sat, 18 Oct 2025 01:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760751036; cv=none; b=sSnbKZgZ+rBPjduQE696v99s6OVta8/5XBDJrf2dVms24C1bOVDgroNpXH9aEEBttnZi0rFWf66udxdz6pFWWz3wOv9jkfF/FpXuwhGpIrjvYXAuXfPdqy2joQlkk2Gmv2/wBi1x4g+KYPpepsIMEahJo72gP41g2qcXICFaZm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760751036; c=relaxed/simple;
	bh=yvXh8dFfVhycZCM8AlezE+Kqf0fr5Jvv71aDbDtE73U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=F4lmndUVI4XjVPdoZHIfioj9//Ia18QSpC/J/XL0lal1mtZTtL6FIDIiIFoYNGtFwOnEB0e7m+Iy1hbmP1nvuV/7vqEky7OZ/x6L6gE8mpELo/hDn36Mrog7LCf3sSVi7wr9hDIZLZCJ5iydb0evkfzl5cv2iEU1V7hOjl/EybM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GlRSz5Py; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F865C4CEE7;
	Sat, 18 Oct 2025 01:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760751035;
	bh=yvXh8dFfVhycZCM8AlezE+Kqf0fr5Jvv71aDbDtE73U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GlRSz5PyCdm3o2x5pcSEcZIDubHRc07LQtVacLRVlPrdclacFogSWJTCPwnUjzWGn
	 i+8HBgj+DQMff3FVIIqZ0lGG0SGbrGYF9CPs9snFNH1kVdwBz7Fr+GZO8DZhVD0E1F
	 QjHExCibl0kGoL2ct0xnbPvtpmtyAg3PopO2FTg+yLEKV/dkrBtpEPe/3Yp0du7Sce
	 KaXhL1p5r2R+FNimTq5yjMEaBSYfIWF729eFe2vDb+M/OherYOG2rS+8VSlQChSkaa
	 DVSaVg239cXbIW1NvZG/4u3GbllS0iN1M8D+Pddi5OXy9BxQ81RSX2sN+gTMHi04Zi
	 urXiULb7K1kTQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D4D39EFA60;
	Sat, 18 Oct 2025 01:30:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 00/11] net: dsa: lantiq_gswip: clean up and
 improve
 VLAN handling
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176075101901.2849208.2117673296114679336.git-patchwork-notify@kernel.org>
Date: Sat, 18 Oct 2025 01:30:19 +0000
References: <cover.1760566491.git.daniel@makrotopia.org>
In-Reply-To: <cover.1760566491.git.daniel@makrotopia.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: hauke@hauke-m.de, andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 andreas.schirm@siemens.com, lukas.stockmann@siemens.com,
 alexander.sverdlin@siemens.com, peter.christen@siemens.com,
 ajayaraman@maxlinear.com, bxu@maxlinear.com, lxu@maxlinear.com,
 jpovazanec@maxlinear.com, fchan@maxlinear.com, yweng@maxlinear.com,
 lrosu@maxlinear.com, john@phrozen.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 15 Oct 2025 23:31:51 +0100 you wrote:
> Hi all,
> 
> This series was developed by Vladimir Oltean to improve and clean up the
> VLAN handling logic in the Lantiq GSWIP DSA driver.
> 
> As Vladimir currently doesn't have the availability to take care of the
> submission process, we agreed that I would send the patches on his
> behalf.
> 
> [...]

Here is the summary with links:
  - [net-next,01/11] net: dsa: lantiq_gswip: support bridge FDB entries on the CPU port
    https://git.kernel.org/netdev/net-next/c/e29bbd73ad71
  - [net-next,02/11] net: dsa: lantiq_gswip: define VLAN ID 0 constant
    https://git.kernel.org/netdev/net-next/c/92790e6c11a8
  - [net-next,03/11] net: dsa: lantiq_gswip: remove duplicate assignment to vlan_mapping.val[0]
    https://git.kernel.org/netdev/net-next/c/8f5c71e44413
  - [net-next,04/11] net: dsa: lantiq_gswip: merge gswip_vlan_add_unaware() and gswip_vlan_add_aware()
    https://git.kernel.org/netdev/net-next/c/b92068755ee0
  - [net-next,05/11] net: dsa: lantiq_gswip: remove legacy configure_vlan_while_not_filtering option
    https://git.kernel.org/netdev/net-next/c/21c3237c60c3
  - [net-next,06/11] net: dsa: lantiq_gswip: permit dynamic changes to VLAN filtering state
    https://git.kernel.org/netdev/net-next/c/ab3ce58559d6
  - [net-next,07/11] net: dsa: lantiq_gswip: disallow changes to privately set up VID 0
    https://git.kernel.org/netdev/net-next/c/96a91e6eeb4d
  - [net-next,08/11] net: dsa: lantiq_gswip: remove vlan_aware and pvid arguments from gswip_vlan_remove()
    https://git.kernel.org/netdev/net-next/c/7ed1965f1010
  - [net-next,09/11] net: dsa: lantiq_gswip: put a more descriptive error print in gswip_vlan_remove()
    https://git.kernel.org/netdev/net-next/c/a57627626636
  - [net-next,10/11] net: dsa: lantiq_gswip: drop untagged on VLAN-aware bridge ports with no PVID
    https://git.kernel.org/netdev/net-next/c/3bb500caf656
  - [net-next,11/11] net: dsa: lantiq_gswip: treat VID 0 like the PVID
    https://git.kernel.org/netdev/net-next/c/1f89ed0ebf26

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



