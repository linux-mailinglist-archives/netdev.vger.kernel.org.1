Return-Path: <netdev+bounces-211110-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49CC2B169E2
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 03:10:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FCD9580F88
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 01:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 445575579E;
	Thu, 31 Jul 2025 01:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NcJKI3io"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9A4EAFA;
	Thu, 31 Jul 2025 01:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753924199; cv=none; b=lYSVwWmXCznfJsOBMvOudKkgL1uychbTfz+qLsfrK4H/aMv+C/BzkEPRr5HQQDSZZRg7jJpF1WPfSG7r10ez4MCqQSW37PevGzv9b/Et+oDXJL3e9u95sn5+1nVYJPQoDoiNLix7+AZkrEWvDvRNDQhJ9wBuAMgHv61B8BEdVJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753924199; c=relaxed/simple;
	bh=3WR7F/oVIBRanLfousD7Dic2P4iKybud4GGp5TUNoC8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kgSbweNNXFRmtJBVGkbYwVf1y2rY1EM5zvZPk2G9Nsm9y9/ehAf8LA3AlmDzzbEPt2/m1I1+h+S47GtCs9ilZbpFGlp3JKPJ7Ou2JPX4IEV5PrI/AVgRj86WJsGvgFJzcLkCMESLd26HyDr+hAm1NAqIKzmfPmYApUgdJSGxLGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NcJKI3io; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 996CDC4CEEB;
	Thu, 31 Jul 2025 01:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753924198;
	bh=3WR7F/oVIBRanLfousD7Dic2P4iKybud4GGp5TUNoC8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NcJKI3ioL1i326+pO8Zbrd4ypHb+C0714KkoOnYPgRsIp+cHBQKYcbce3bAnWkvHJ
	 48AYG3Ail1FjN1GPZ54hTbg1dl/yv8q2KhgwsLqaEi3xrWq9H/tL2V3mzmxT4gN0jq
	 b4KgpOo7pgmHQZ6X2bXM3x75su+IZMaQcrepv4ZgBjNaAiMoecq5cde/XoHXmTpbhA
	 2pTrEMoyGI18u/p51qGnRJoFZ7FPPzQ5ADBD040e3fJuRQVbUn/0T1ZegUxAPBYe0C
	 VKDED9h4hnvpIDwm/DLABq4A4FAjgp+aXvw/IztnS6VEtASmvNsEzROTU5a9sY+Edk
	 RXGD/MS74omGQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADC62383BF5F;
	Thu, 31 Jul 2025 01:10:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/5] net: ethernet: fix device leaks
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175392421450.2566045.3872310659280887613.git-patchwork-notify@kernel.org>
Date: Thu, 31 Jul 2025 01:10:14 +0000
References: <20250725171213.880-1-johan@kernel.org>
In-Reply-To: <20250725171213.880-1-johan@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, madalin.bucur@nxp.com,
 claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, wei.fang@nxp.com,
 xiaoning.wang@nxp.com, nbd@nbd.name, sean.wang@mediatek.com,
 lorenzo@kernel.org, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, danishanwar@ti.com,
 rogerq@kernel.org, richardcochran@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 25 Jul 2025 19:12:08 +0200 you wrote:
> This series fixes devices leaks stemming from failure to drop the
> reference taken by of_find_device_by_node().
> 
> Johan
> 
> 
> Johan Hovold (5):
>   net: dpaa: fix device leak when querying time stamp info
>   net: enetc: fix device and OF node leak at probe
>   net: gianfar: fix device leak when querying time stamp info
>   net: mtk_eth_soc: fix device leak at probe
>   net: ti: icss-iep: fix device and OF node leaks at probe
> 
> [...]

Here is the summary with links:
  - [1/5] net: dpaa: fix device leak when querying time stamp info
    https://git.kernel.org/netdev/net/c/3fa840230f53
  - [2/5] net: enetc: fix device and OF node leak at probe
    https://git.kernel.org/netdev/net/c/70458f8a6b44
  - [3/5] net: gianfar: fix device leak when querying time stamp info
    https://git.kernel.org/netdev/net/c/da717540acd3
  - [4/5] net: mtk_eth_soc: fix device leak at probe
    https://git.kernel.org/netdev/net/c/3e13274ca875
  - [5/5] net: ti: icss-iep: fix device and OF node leaks at probe
    https://git.kernel.org/netdev/net/c/e05c54974a05

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



