Return-Path: <netdev+bounces-223426-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E59EB591C8
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 11:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E47AE1892393
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 09:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C99286433;
	Tue, 16 Sep 2025 09:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QDSoRoCx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E7E1891AB;
	Tue, 16 Sep 2025 09:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758013824; cv=none; b=MDSiFIvW2atwqNyzGWw7044W7WEG0lUlYWdHgQ/hJTs0yScqf+1NsFQT271R45vn3ornTH2a/mZtF2ztW4M0iq+DHLqpKLx0dG6mky0khqTzwc/uEtkx1+LTS6xCMTxuXY4tDn40qxxNcQ/1hbNwvlRHpNNe0cMWvcR5BgRdKhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758013824; c=relaxed/simple;
	bh=kuJAKoB9pXWwUKKACzc17S2FgoaepkoZ3hJBpHeLLDg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pJ0gBV+7R+7yZXoQ0es7MIx6OT/Giz/YYKQqW0/Vpcz9DGzAh7YI4AiMM+dmDL7IHKwuIjuCcGiteu2VCqPNPnIE4wX7lgBxL7fniGJZurUxIFRzRZhfwbaRcgGPVUj6kxoPsjql5n8wbfPnHOIc2pmIhlNBscX5WABAxsUbtgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QDSoRoCx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4B68C4CEEB;
	Tue, 16 Sep 2025 09:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758013823;
	bh=kuJAKoB9pXWwUKKACzc17S2FgoaepkoZ3hJBpHeLLDg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QDSoRoCxBfKcnd1tAo4tGRMdxCoWeBCzzg9AZE5qxKAEFgApoUDbETYnbOoSnX08/
	 tLEVkKXrb0mB7ikPTGcKpxBiH3I67vqHOGM2EpFAp1yRpF08giwcEssnbpChK8mj6c
	 RXMw3ZRm8IDGnUDiRoPsuG4GIwM12GEQc5Z6eGGnvhb44vTcaWYdyUU++24VdRfPya
	 iTJRDi8nLBntLKGGeSabDPnCRBZH3S55d8JVgXMvYyS0K/I2kPSp7IuiIbA9F+tq0g
	 CY4KY0v9n5yv3P5n7X2mB0tWA/ccyAzTgqDeRo7PFcrkZ0GENfmpVdzsHenVXO3yi5
	 UwsZ/WGKOaLTg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33CCE39D0C1A;
	Tue, 16 Sep 2025 09:10:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v06 00/14] net: hinic3: Add a driver for Huawei
 3rd
 gen NIC - sw and hw initialization
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175801382500.673413.8933950320451913033.git-patchwork-notify@kernel.org>
Date: Tue, 16 Sep 2025 09:10:25 +0000
References: <cover.1757653621.git.zhuyikai1@h-partners.com>
In-Reply-To: <cover.1757653621.git.zhuyikai1@h-partners.com>
To: Fan Gong <gongfan1@huawei.com>
Cc: zhuyikai1@h-partners.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, andrew+netdev@lunn.ch,
 linux-doc@vger.kernel.org, corbet@lwn.net, helgaas@kernel.org,
 luosifu@huawei.com, guoxin09@huawei.com, shenchenyang1@hisilicon.com,
 zhoushuai28@huawei.com, wulike1@huawei.com, shijing34@huawei.com,
 luoyang82@h-partners.com, meny.yossefi@huawei.com, gur.stavi@huawei.com,
 lee@trager.us, mpe@ellerman.id.au, vadim.fedorenko@linux.dev,
 sumang@marvell.com, przemyslaw.kitszel@intel.com, jdamato@fastly.com,
 christophe.jaillet@wanadoo.fr

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 12 Sep 2025 14:28:17 +0800 you wrote:
> This is [3/3] part of hinic3 Ethernet driver initial submission.
> With this patch hinic3 becomes a functional Ethernet driver.
> 
> The driver parts contained in this patch:
> Memory allocation and initialization of the driver structures.
> Management interfaces initialization.
> HW capabilities probing, initialization and setup using management
> interfaces.
> Net device open/stop implementation and data queues initialization.
> Register VID:DID in PCI id_table.
> Fix netif_queue_set_napi usage.
> 
> [...]

Here is the summary with links:
  - [net-next,v06,01/14] hinic3: HW initialization
    https://git.kernel.org/netdev/net-next/c/cdb096c41b7d
  - [net-next,v06,02/14] hinic3: HW management interfaces
    https://git.kernel.org/netdev/net-next/c/8a1c655f55c8
  - [net-next,v06,03/14] hinic3: HW common function initialization
    https://git.kernel.org/netdev/net-next/c/069e42485e53
  - [net-next,v06,04/14] hinic3: HW capability initialization
    https://git.kernel.org/netdev/net-next/c/a0543a79359e
  - [net-next,v06,05/14] hinic3: Command Queue flush interfaces
    https://git.kernel.org/netdev/net-next/c/b92e6c734db8
  - [net-next,v06,06/14] hinic3: Nic_io initialization
    https://git.kernel.org/netdev/net-next/c/8133788d023f
  - [net-next,v06,07/14] hinic3: Queue pair endianness improvements
    https://git.kernel.org/netdev/net-next/c/6b822b658aaf
  - [net-next,v06,08/14] hinic3: Queue pair resource initialization
    https://git.kernel.org/netdev/net-next/c/73f37a7e1993
  - [net-next,v06,09/14] hinic3: Queue pair context initialization
    https://git.kernel.org/netdev/net-next/c/97dcb914a25b
  - [net-next,v06,10/14] hinic3: Tx & Rx configuration
    https://git.kernel.org/netdev/net-next/c/b83bb584bc97
  - [net-next,v06,11/14] hinic3: Add Rss function
    https://git.kernel.org/netdev/net-next/c/1f3838b84a63
  - [net-next,v06,12/14] hinic3: Add port management
    https://git.kernel.org/netdev/net-next/c/45f97ae93de2
  - [net-next,v06,13/14] hinic3: Fix missing napi->dev in netif_queue_set_napi
    https://git.kernel.org/netdev/net-next/c/4404f6af8108
  - [net-next,v06,14/14] hinic3: Fix code style (Missing a blank line before return)
    https://git.kernel.org/netdev/net-next/c/d5aeec592154

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



