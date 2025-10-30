Return-Path: <netdev+bounces-234240-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 34679C1E0E9
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 02:51:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EA9914E5DE2
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 01:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D7122D9797;
	Thu, 30 Oct 2025 01:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bH3ISx6b"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA2621ABA2;
	Thu, 30 Oct 2025 01:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761789054; cv=none; b=Cjs3fWjuU8Vw97OEhIyt+t2V3fM/7zo+FmGGYcoc+K0eTkKQQ1zkeU+UBVKkD/SGjIb7zaJfdwJdZRKFDUkXXFORyUooJnQdKhPl/N4UAu9umYbgCnGrb737QvOkt6QHwweEm6rFFV8XUcWV3b+7UdHuZ/MtDIscOiYNmCcLoQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761789054; c=relaxed/simple;
	bh=IKUqTfkv9S0tIEz9qzJhcoUBVUV/t+c+iT11tcNwLgw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=biL4jircy4i1wy1IT9RiXVsM0+EIjyiHR7gUNykd70bVXeoICx9KPVN2g33i3BJxsJMW3xR/1v/V/pjH3w+egAqGeXknhdjPmTCfW81WWbmSY8H2StE1lX4gEZHKoS2wW/OnCPpHecNuriz8p2yqGdGJVtYWVqk47Ncj8f4bl0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bH3ISx6b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEA18C4CEF7;
	Thu, 30 Oct 2025 01:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761789054;
	bh=IKUqTfkv9S0tIEz9qzJhcoUBVUV/t+c+iT11tcNwLgw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bH3ISx6bHqa9wEqek7U4oE3gJNqAXCt9x2DdgTUbw35gVJ335CIRdXXVPzUNYJxW0
	 WSzpFFBQoAkmlzRHl+Suii3ih+U5QuKEUvzUClAlZSeCOvrIpJVQc8gDYFl7WWvaX3
	 XsJr9dCqx4/9J2veiwd9YMiGYDY3iHk1rgpTx3y/Bq50hZLI6liD3Yf8KpRR1phVoX
	 w745ReQL0QH6hUCV5PJQcO85vl2DcB4Xm0EZlDqQZYCzrDZ1n0whOAOq25XAEf4xp7
	 msS7xdrxjfvuiGrLkv0GHP28YFE0Qat4xglt9LyukCwM6HDDi6snvgaqsfkAOaoK8x
	 dTTazzS6TGWOA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33EB03A55ED9;
	Thu, 30 Oct 2025 01:50:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 net-next 0/6] net: enetc: Add i.MX94 ENETC support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176178903073.3280604.13344054625304001526.git-patchwork-notify@kernel.org>
Date: Thu, 30 Oct 2025 01:50:30 +0000
References: <20251029013900.407583-1-wei.fang@nxp.com>
In-Reply-To: <20251029013900.407583-1-wei.fang@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
 Frank.Li@nxp.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 richardcochran@gmail.com, imx@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 29 Oct 2025 09:38:54 +0800 you wrote:
> i.MX94 NETC has two kinds of ENETCs, one is the same as i.MX95, which
> can be used as a standalone network port. The other one is an internal
> ENETC, it connects to the CPU port of NETC switch through the pseudo
> MAC. Also, i.MX94 have multiple PTP Timers, which is different from
> i.MX95. Any PTP Timer can be bound to a specified standalone ENETC by
> the IERB ETBCR registers. Currently, this patch only add ENETC support
> and Timer support for i.MX94. The switch will be added by a separate
> patch set.
> 
> [...]

Here is the summary with links:
  - [v4,net-next,1/6] dt-bindings: net: netc-blk-ctrl: add compatible string for i.MX94 platforms
    https://git.kernel.org/netdev/net-next/c/3a85ec37bc11
  - [v4,net-next,2/6] dt-bindings: net: enetc: add compatible string for ENETC with pseduo MAC
    https://git.kernel.org/netdev/net-next/c/c4430f2ac047
  - [v4,net-next,3/6] net: enetc: add preliminary i.MX94 NETC blocks control support
    https://git.kernel.org/netdev/net-next/c/ba5d7d45ce8e
  - [v4,net-next,4/6] net: enetc: add ptp timer binding support for i.MX94
    https://git.kernel.org/netdev/net-next/c/1cd3f21c18c2
  - [v4,net-next,5/6] net: enetc: add basic support for the ENETC with pseudo MAC for i.MX94
    https://git.kernel.org/netdev/net-next/c/5175c1e4adca
  - [v4,net-next,6/6] net: enetc: add standalone ENETC support for i.MX94
    https://git.kernel.org/netdev/net-next/c/2d673b0e2f8d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



