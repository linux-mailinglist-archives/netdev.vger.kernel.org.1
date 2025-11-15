Return-Path: <netdev+bounces-238830-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C6DACC5FE25
	for <lists+netdev@lfdr.de>; Sat, 15 Nov 2025 03:23:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2CA2D4EA5AD
	for <lists+netdev@lfdr.de>; Sat, 15 Nov 2025 02:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E18CC2288D5;
	Sat, 15 Nov 2025 02:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KXGMzj9C"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92D31DF273;
	Sat, 15 Nov 2025 02:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763173255; cv=none; b=TvRmx4DDuDDXZHpNaV/VpvtbKnRDHK7wFVzTDMz073iNtcyEgRGhz24jNBJmuhrAYxAJnjy0g6fz2n35pofV206R/kCMSJmrPV/9r16SSoeVKKalw6m2lHpvRHx6gDy76Omyf8UN+1FcjYwO1CNLeFqOue308KKgeV4yjavwODA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763173255; c=relaxed/simple;
	bh=3Vzr6Pt0NbBXXmH7E0ftKeDdei+KnDDF1zkjPTm169Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jy5Hp1ruv0D8VNAD6U/Z2kyUaNVW42a1hV7kvaEtU/inB8VRFfobAlHoS729rWhNncT8jhODHwyiHuwL5nP/RWclXMqCuT2+Td+N1ZtStbpONd86qGQ7vqjFwSPLLDdhR2aEyPxUGFnDU1hx+SY34HcWag9my4uKJ4adMaGa+JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KXGMzj9C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98B14C4CEFB;
	Sat, 15 Nov 2025 02:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763173255;
	bh=3Vzr6Pt0NbBXXmH7E0ftKeDdei+KnDDF1zkjPTm169Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KXGMzj9CRUjAL6jieYChehFMXATRpQXDvRy7wo8kKOrVP8Y1Tt4h4BTxO8HDePzuS
	 XVAV07rH1Xhn+xxdlS0XeAP8+J04vtlDmVYha2Bi9o+CBBG+JUtq7FiH3kynuGV9iK
	 AqYMQQl6pTVNX78goOT4MYrlN+dMQey3YrbsNMbFGjel5fG2f+hkPtu1YPH7qrmfWJ
	 vNfOXJ2yFvys/Met05KQu7ZJi0tQkayjDKYkt2tqHPT4WjhiOE08wiAT0/wKQZALkY
	 AQzjhnhDb48m2qSAoeYEV0IZdiR4tjXpM+N157aHre/CxjOEitJWZKpzm3GETXbNes
	 gVnlE7GGypDbQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C563A78A62;
	Sat, 15 Nov 2025 02:20:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: ixgbe: convert to use .get_rx_ring_count
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176317322399.1911668.4514971413823098969.git-patchwork-notify@kernel.org>
Date: Sat, 15 Nov 2025 02:20:23 +0000
References: <20251113-ixgbe_gxrings-v2-1-0ecf57808a78@debian.org>
In-Reply-To: <20251113-ixgbe_gxrings-v2-1-0ecf57808a78@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
 pmenzel@molgen.mpg.de, aleksandr.loktionov@intel.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 13 Nov 2025 06:23:29 -0800 you wrote:
> Convert the ixgbe driver to use the new .get_rx_ring_count ethtool
> operation for handling ETHTOOL_GRXRINGS command. This simplifies the
> code by extracting the ring count logic into a dedicated callback.
> 
> The new callback provides the same functionality in a more direct way,
> following the ongoing ethtool API modernization.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: ixgbe: convert to use .get_rx_ring_count
    https://git.kernel.org/netdev/net-next/c/f455d3f02d89

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



