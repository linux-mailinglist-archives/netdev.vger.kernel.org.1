Return-Path: <netdev+bounces-62558-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B093827D5B
	for <lists+netdev@lfdr.de>; Tue,  9 Jan 2024 04:30:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D4DF1C21956
	for <lists+netdev@lfdr.de>; Tue,  9 Jan 2024 03:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DCC06D6E0;
	Tue,  9 Jan 2024 03:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EzuwBdwT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F276103
	for <netdev@vger.kernel.org>; Tue,  9 Jan 2024 03:30:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 15626C43390;
	Tue,  9 Jan 2024 03:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704771025;
	bh=vTUT5gT93jfAwkNh0PhOb6di58dhiEka8Tg/ZSXZYL0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EzuwBdwTX0JO8nizaUX9grp5LpzKKf18BoIC4RrL5UnrAAOQn0mHDTPfwbVF0x2KT
	 Wn3EAYfFZJcfnUEjGtGFlZZDDHL4p8I1O+VQXe2bJhH9xkBAJFIVNEvdNyqg+NNt3w
	 2ctYiC+LwSfeuYGCs4iMDRtnRcTdiL0E8yRBLn5RYneFaImBEOi545ed7dbPv59STF
	 nCNOtkH7Rqr/2BASTq9rFGilJscN5c4WLjWXjS6KiIn9DkwtGarLGdMDQg8yJ5cGHN
	 oHkxP/UWRyaWyu/V2Ns6oTLJV2IrLk3md0sL4iSFQJ3xDaePQQsYOWWvAxUHlR558G
	 RL+TJKvZ2OOPg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F17BCDFC690;
	Tue,  9 Jan 2024 03:30:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] lan743x: remove redundant statement in
 lan743x_ethtool_get_eee
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170477102498.11770.3025352967118480440.git-patchwork-notify@kernel.org>
Date: Tue, 09 Jan 2024 03:30:24 +0000
References: <3340ff84-8d7a-404b-8268-732c7f281164@gmail.com>
In-Reply-To: <3340ff84-8d7a-404b-8268-732c7f281164@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: bryan.whitehead@microchip.com, UNGLinuxDriver@microchip.com,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, kuba@kernel.org,
 andrew@lunn.ch, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 5 Jan 2024 23:19:02 +0100 you wrote:
> eee_active is set by phy_ethtool_get_eee() already, using the same
> logic plus an additional check against link speed/duplex values.
> See genphy_c45_eee_is_active() for details.
> So we can remove this line.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net-next] lan743x: remove redundant statement in lan743x_ethtool_get_eee
    https://git.kernel.org/netdev/net-next/c/5733d139a674

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



