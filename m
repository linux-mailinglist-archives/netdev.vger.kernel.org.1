Return-Path: <netdev+bounces-35026-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 243977A67A3
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 17:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D376C2815BF
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 15:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C026D3B7A2;
	Tue, 19 Sep 2023 15:10:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89333B79B
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 15:10:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4CD17C433CA;
	Tue, 19 Sep 2023 15:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695136222;
	bh=R+7lr61Vl1YkW7K4vXO2TRTG8SQ4uiD+RRdnD1cChZo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MO3UMcdep46FJAfXPmaMdVzUW3hm5MhuFmKSOr9zx89cK01vBasgGMCYPuKvWOTRy
	 zs3LRNJ+aA1u2781T3VEFcLiE2ylcjpQSghsV6qJA/cHOak5eEHK72OpxzVIhvZ5rd
	 webua+lQkzrdRxvFvHX7wcPhgwGZf5jRqaDoQpi+FVQ6Bp/mZsX8OWpYQ7a5/Bi/VI
	 Ek0WZ+dMYA0Psdlj4UUbZOGuHdycB+WgzM4ReRsqKoRwJHhH8sc/pCmaqlC+PSL4cz
	 1mc54gU7UAQw/gKqR8UddoIseO8+cXEm9oZCXU5nS2uIC7BZ6znW3FpOk+328ylndH
	 L0cWdJ314gTUg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 31203E1F671;
	Tue, 19 Sep 2023 15:10:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: phy: fix regression with AX88772A PHY driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169513622219.19882.2570593848340378115.git-patchwork-notify@kernel.org>
Date: Tue, 19 Sep 2023 15:10:22 +0000
References: <E1qiEFs-007g7b-Lq@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1qiEFs-007g7b-Lq@rmk-PC.armlinux.org.uk>
To: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, m.szyprowski@samsung.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 florian.fainelli@broadcom.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 18 Sep 2023 14:25:36 +0100 you wrote:
> Marek reports that a deadlock occurs with the AX88772A PHY used on the
> ASIX USB network driver:
> 
> asix 1-1.4:1.0 (unnamed net_device) (uninitialized): PHY [usb-001:003:10] driver [Asix Electronics AX88772A] (irq=POLL)
> Asix Electronics AX88772A usb-001:003:10: attached PHY driver(mii_bus:phy_addr=usb-001:003:10, irq=POLL)
> asix 1-1.4:1.0 eth0: register 'asix' at usb-12110000.usb-1.4, ASIX AX88772 USB 2.0 Ethernet, a2:99:b6:cd:11:eb
> asix 1-1.4:1.0 eth0: configuring for phy/internal link mode
> 
> [...]

Here is the summary with links:
  - [net-next] net: phy: fix regression with AX88772A PHY driver
    https://git.kernel.org/netdev/net-next/c/6a23c555f7eb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



