Return-Path: <netdev+bounces-14311-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A76874017E
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 18:41:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E02782810A1
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 16:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 812D01307F;
	Tue, 27 Jun 2023 16:40:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27EFC13066
	for <netdev@vger.kernel.org>; Tue, 27 Jun 2023 16:40:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BA253C43397;
	Tue, 27 Jun 2023 16:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687884023;
	bh=PbkyuIVD6RQEoyWEDMK/0ZpQxw2fsmAvvIUXJqLTZqk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ViPPo0tTQrVz4P89e+OmJgob9ZBpLV1PbqrIBi8q2NVcfmjW7E/sFz7jMOsk+qa+d
	 wdQDWJlIwczFWeGR4aKFbPlpC6tU8opKTVFvBXI0INiRr++oZZQdraVe1UYCD4M9YX
	 nn+8Qt3FxE5jGtZ030cHXQQOaQwg2tgDlpa50FIRLDxcm9fK9M1BDGptfeTZn5qsyN
	 1PEgia3bxASUwDHFaCxt9pNIu6W40OVttwlDb42n2E1xjL8pyss/ZwUcVN95ATTWu1
	 WJ0JW7nQ52UtUarSFN63F8PqTD23gMLUGgg7X7T6fCsaUGGLsQtGCjg/O+UpC2Xeir
	 XhrCSc/DknjYQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 97363C6445B;
	Tue, 27 Jun 2023 16:40:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next] net: phy: mscc: fix packet loss due to RGMII
 delays
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168788402361.21860.15787851338716786080.git-patchwork-notify@kernel.org>
Date: Tue, 27 Jun 2023 16:40:23 +0000
References: <20230627134235.3453358-1-vladimir.oltean@nxp.com>
In-Reply-To: <20230627134235.3453358-1-vladimir.oltean@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
 harini.katakam@amd.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 27 Jun 2023 16:42:35 +0300 you wrote:
> Two deadly typos break RX and TX traffic on the VSC8502 PHY using RGMII
> if phy-mode = "rgmii-id" or "rgmii-txid", and no "tx-internal-delay-ps"
> override exists. The negative error code from phy_get_internal_delay()
> does not get overridden with the delay deduced from the phy-mode, and
> later gets committed to hardware. Also, the rx_delay gets overridden by
> what should have been the tx_delay.
> 
> [...]

Here is the summary with links:
  - [v2,net-next] net: phy: mscc: fix packet loss due to RGMII delays
    https://git.kernel.org/netdev/net-next/c/528a08bcd820

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



