Return-Path: <netdev+bounces-189130-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CCB4AB08C8
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 05:20:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2D1B167ABB
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 03:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2655B221299;
	Fri,  9 May 2025 03:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lyi099k6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA28164A8F;
	Fri,  9 May 2025 03:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746760805; cv=none; b=b+yIc02INh6krbqeVEp7OeQGrj7KJYWk1VMndSQUrVLk+hcOHIc9YaftyYKXzTkmG2FFFTCyqvBjZcXgUPsfUyK3c0wRRl2G/AW8kAJ448NhiuYFrYbyKh/L621Qg9+WRXEwDJZsPpFcM4qUtmepWqkgpDVZWgg1sf7c0Y+uzuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746760805; c=relaxed/simple;
	bh=NY9f4q2kixUeTEknFQvFoV+AD+81IXXwblbM2CctxyA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PJaLjAN4k3++h89E+Y41DS4uiX8PGQpjddwpEiKQSk2cKt6/G8WjHBwfrpRmCCIh0mdCncnJ5qtLTrcNdQmcI+o/yR+iPhZPilu9aZKGBWe0bvjI0g6wo7Kl3s/q6TCNAIHCzZnNfRcHPpExjMhNK3V0j/riIe7Jo8JED2XtSvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lyi099k6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69C55C4CEE7;
	Fri,  9 May 2025 03:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746760804;
	bh=NY9f4q2kixUeTEknFQvFoV+AD+81IXXwblbM2CctxyA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lyi099k6fyh1ahKM/tIi2w1iD/oHFITWbewaXU85RAhs+2ImiRhUMBLcf1bBVf0Cg
	 IUDKwZdC220PhgWaq7heBSTYpoTXLtChkVBQDVdT3N0UMiRsFfifWyASo5x1ET2GWH
	 5TJUM319B4kyqdQ7xFGWDdlATCmBwMy2FnH7kZ02beNN9qepzcvadR1eI0h5jqExlj
	 gvS8iSfn1Fo06yiztqXMR531F175M5zkI5XoaE7PyjFTJvdoElQZr4P4t6Me+0ZXQY
	 OqVZk/Y2E8RLNk+gDJ99htcy2OYiD4iNe7FQ2Xg2fpwyiGAKmsEl6yQH/2GLY4K+Ov
	 Z0BlxGOkIyVwg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33BFF380AA7D;
	Fri,  9 May 2025 03:20:44 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v7 net-next 00/14] Add more features for ENETC v4 - round 2
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174676084300.3115683.12773669022927548558.git-patchwork-notify@kernel.org>
Date: Fri, 09 May 2025 03:20:43 +0000
References: <20250506080735.3444381-1-wei.fang@nxp.com>
In-Reply-To: <20250506080735.3444381-1-wei.fang@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, christophe.leroy@csgroup.eu,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, imx@lists.linux.dev,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 timur@kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  6 May 2025 16:07:21 +0800 you wrote:
> This patch set adds the following features.
> 1. Compared with ENETC v1, the formats of tables and command BD of ENETC
> v4 have changed significantly, and the two are not compatible. Therefore,
> in order to support the NETC Table Management Protocol (NTMP) v2.0, we
> introduced the netc-lib driver and added support for MAC address filter
> table and RSS table.
> 2. Add MAC filter and VLAN filter support for i.MX95 ENETC PF.
> 3. Add RSS support for i.MX95 ENETC PF.
> 4. Add loopback support for i.MX95 ENETC PF.
> 
> [...]

Here is the summary with links:
  - [v7,net-next,01/14] net: enetc: add initial netc-lib driver to support NTMP
    https://git.kernel.org/netdev/net-next/c/4701073c3deb
  - [v7,net-next,02/14] net: enetc: add command BD ring support for i.MX95 ENETC
    https://git.kernel.org/netdev/net-next/c/e3f4a0a8ddb4
  - [v7,net-next,03/14] net: enetc: move generic MAC filtering interfaces to enetc-core
    https://git.kernel.org/netdev/net-next/c/401dbdd1c23c
  - [v7,net-next,04/14] net: enetc: add MAC filtering for i.MX95 ENETC PF
    https://git.kernel.org/netdev/net-next/c/6c5bafba347b
  - [v7,net-next,05/14] net: enetc: add debugfs interface to dump MAC filter
    https://git.kernel.org/netdev/net-next/c/df6cb0958089
  - [v7,net-next,06/14] net: enetc: add set/get_rss_table() hooks to enetc_si_ops
    https://git.kernel.org/netdev/net-next/c/66b3fb001156
  - [v7,net-next,07/14] net: enetc: make enetc_set_rss_key() reusable
    https://git.kernel.org/netdev/net-next/c/7e1af4d6e4b4
  - [v7,net-next,08/14] net: enetc: add RSS support for i.MX95 ENETC PF
    https://git.kernel.org/netdev/net-next/c/2627e9873d69
  - [v7,net-next,09/14] net: enetc: change enetc_set_rss() to void type
    https://git.kernel.org/netdev/net-next/c/42fb12220ade
  - [v7,net-next,10/14] net: enetc: enable RSS feature by default
    https://git.kernel.org/netdev/net-next/c/2219281242fc
  - [v7,net-next,11/14] net: enetc: extract enetc_refresh_vlan_ht_filter()
    https://git.kernel.org/netdev/net-next/c/014e33e2d8e9
  - [v7,net-next,12/14] net: enetc: move generic VLAN hash filter functions to enetc_pf_common.c
    https://git.kernel.org/netdev/net-next/c/5d7f6f6836a1
  - [v7,net-next,13/14] net: enetc: add VLAN filtering support for i.MX95 ENETC PF
    https://git.kernel.org/netdev/net-next/c/f7d30ef6c1f7
  - [v7,net-next,14/14] net: enetc: add loopback support for i.MX95 ENETC PF
    https://git.kernel.org/netdev/net-next/c/932ce98041ff

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



