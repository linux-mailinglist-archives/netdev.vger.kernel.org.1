Return-Path: <netdev+bounces-109392-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21E1B9283D3
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 10:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBF9F2897EE
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 08:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A132145A0E;
	Fri,  5 Jul 2024 08:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Is00ut/C"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4DE14533A;
	Fri,  5 Jul 2024 08:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720168834; cv=none; b=De+iKxN2nwII8fJ5FKV/7Od25B3ERQd35QpugXVXJmMCYktuHgRQ3OnGeX5D7IQuJCTs9e0MSZa59N9IIgsTMr99NJZitVaqnTUw+9hJHyIkiDkEGRoMitssXpVFjIc5r8zJ4cjnkbOp/tRZt25E94v6W5w0EywuUSPxBoMwW0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720168834; c=relaxed/simple;
	bh=OU3txpXlAr+kHFnOZsdCg4voKyQR5vbHID+NPrutMTE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=awaUCd0/er6bzoW2YutcirTqHMhrhxuM3wiY/73mDk1mO1t7WW8KaWoyjN4uNTDPgffHKpxg60xHhntXjdxXUx8U58WYkQC0grvynzjLmz7AViZ9vASlKy4qVnee1NstPoBD4CYJm5w8FGQnUtfmgZLbG7ho7sBIeZKr2P9SNQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Is00ut/C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A0A2EC4AF07;
	Fri,  5 Jul 2024 08:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720168833;
	bh=OU3txpXlAr+kHFnOZsdCg4voKyQR5vbHID+NPrutMTE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Is00ut/C/U0cgysRENfLJWYQvyyj8uAvLaUOF5+A3Q2iDk8Fsdt88NmoV9BOjrlmE
	 6llJBbjZDr5ZaSfXfu+gzUfChVH+bkO7/hRX526fYXOgDWFW+gn0w1KwLs7xvIA5/0
	 Q1MnI6Y/7t6SJ6ZxkmCC35jUJvbbKde35c/2mF+QzYFZdeFsu/McR7AHtq22Apn9Bh
	 /rPeVCed4Vw4bC9qHgD8iD7eMkUA8oWLze/KcUfKcr2usmnlPB2aZ5LzTOmp6zEvCE
	 dniUviqrS9tku3YGddOvOJnL1Pa+rm6xqRswNhIle1kO0S2Z/4f93PlipLmQjFW6ep
	 OZNot3Bnigj9g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 89DC0C43332;
	Fri,  5 Jul 2024 08:40:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4 00/10] net: pcs: xpcs: Add memory-mapped device
 support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172016883356.17061.13176667406325533525.git-patchwork-notify@kernel.org>
Date: Fri, 05 Jul 2024 08:40:33 +0000
References: <20240701182900.13402-1-fancer.lancer@gmail.com>
In-Reply-To: <20240701182900.13402-1-fancer.lancer@gmail.com>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com,
 olteanv@gmail.com, f.fainelli@gmail.com, maxime.chevallier@bootlin.com,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 quic_scheluve@quicinc.com, quic_abchauha@quicinc.com, ahalaney@redhat.com,
 jiawenwu@trustnetic.com, mengyuanlou@net-swift.com, tmaimon77@gmail.com,
 openbmc@lists.ozlabs.org, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon,  1 Jul 2024 21:28:31 +0300 you wrote:
> The main goal of this series is to extend the DW XPCS device support in
> the kernel. Particularly the patchset adds a support of the DW XPCS
> device with the MCI/APB3 IO interface registered as a platform device. In
> order to have them utilized by the DW XPCS core the fwnode-based DW XPCS
> descriptor creation procedure has been introduced. Finally the STMMAC
> driver has been altered to support the DW XPCS passed via the 'pcs-handle'
> property.
> 
> [...]

Here is the summary with links:
  - [net-next,v4,01/10] net: pcs: xpcs: Move native device ID macro to linux/pcs/pcs-xpcs.h
    https://git.kernel.org/netdev/net-next/c/f37bee950888
  - [net-next,v4,02/10] net: pcs: xpcs: Split up xpcs_create() body to sub-functions
    https://git.kernel.org/netdev/net-next/c/03b3be07c69a
  - [net-next,v4,03/10] net: pcs: xpcs: Convert xpcs_id to dw_xpcs_desc
    https://git.kernel.org/netdev/net-next/c/71b200b388ef
  - [net-next,v4,04/10] net: pcs: xpcs: Convert xpcs_compat to dw_xpcs_compat
    https://git.kernel.org/netdev/net-next/c/410232ab3c07
  - [net-next,v4,05/10] net: pcs: xpcs: Introduce DW XPCS info structure
    https://git.kernel.org/netdev/net-next/c/bcac735cf653
  - [net-next,v4,06/10] dt-bindings: net: Add Synopsys DW xPCS bindings
    https://git.kernel.org/netdev/net-next/c/664690eb08f7
  - [net-next,v4,07/10] net: pcs: xpcs: Add Synopsys DW xPCS platform device driver
    https://git.kernel.org/netdev/net-next/c/f6bb3e9d98c2
  - [net-next,v4,08/10] net: pcs: xpcs: Add fwnode-based descriptor creation method
    https://git.kernel.org/netdev/net-next/c/9cad7275463a
  - [net-next,v4,09/10] net: stmmac: Create DW XPCS device with particular address
    https://git.kernel.org/netdev/net-next/c/351066bad6ad
  - [net-next,v4,10/10] net: stmmac: Add DW XPCS specified via "pcs-handle" support
    https://git.kernel.org/netdev/net-next/c/357768c7e792

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



