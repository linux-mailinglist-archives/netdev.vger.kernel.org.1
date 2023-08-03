Return-Path: <netdev+bounces-23862-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3152676DE3E
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 04:31:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF04C281895
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 02:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0B5D63C6;
	Thu,  3 Aug 2023 02:30:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630F78C1F
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 02:30:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CC985C43395;
	Thu,  3 Aug 2023 02:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691029824;
	bh=1tXn2Hign4wBHTrHUxsrq//6Ua89+kPe7rNCpYytokw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Cn/Fc8o2J0LUoQnUW0AuriYsycUd335vcoIWUtC8ypbQBz+Qqd3w+vNdbeKXJRzSa
	 SJS+y62w8VqFfoN8PJiCj961JEPXPUcDlO/KF6ARNAgrm/cW253upsLaSqqPIStrYp
	 BUnzcwqHGqcrv6189iZ5rHFjRoU8lP4gtXjh8a/YMopBzCCwxJF/e/5UJc4FFu/DxQ
	 PrczuI0DAnVdKAqb5e3izlrmfZfJ/bycJoqjEKhOmLx18DhOaK8OY13CeqkPRMeU6h
	 ODg6uiT8e8ibzkGkcmdjizjzP/FtqYG/CrwrOcyZJC2m7029AhvsBHxPfPucVbFPIl
	 ca0JmgOmNYc3A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A7CA7E96ABD;
	Thu,  3 Aug 2023 02:30:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v9 net-next 00/12] Introduce ndo_hwtstamp_get() and
 ndo_hwtstamp_set()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169102982468.22584.9783879980852698698.git-patchwork-notify@kernel.org>
Date: Thu, 03 Aug 2023 02:30:24 +0000
References: <20230801142824.1772134-1-vladimir.oltean@nxp.com>
In-Reply-To: <20230801142824.1772134-1-vladimir.oltean@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, andrew@lunn.ch, f.fainelli@gmail.com,
 glipus@gmail.com, horatiu.vultur@microchip.com, kory.maincent@bootlin.com,
 maxime.chevallier@bootlin.com, richardcochran@gmail.com,
 vadim.fedorenko@linux.dev, gerhard@engleder-embedded.com,
 liuhangbin@gmail.com, linux@armlinux.org.uk, hkallweit1@gmail.com,
 jacob.e.keller@intel.com, j.vosburgh@gmail.com, andy@greyhouse.net,
 wei.fang@nxp.com, shenwei.wang@nxp.com, xiaoning.wang@nxp.com,
 linux-imx@nxp.com, UNGLinuxDriver@microchip.com, lars.povlsen@microchip.com,
 Steen.Hegelund@microchip.com, daniel.machon@microchip.com,
 simon.horman@corigine.com, casper.casan@gmail.com, sorganov@gmail.com,
 mkubecek@suse.cz, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  1 Aug 2023 17:28:12 +0300 you wrote:
> Based on previous RFCs from Maxim Georgiev:
> https://lore.kernel.org/netdev/20230502043150.17097-1-glipus@gmail.com/
> 
> this series attempts to introduce new API for the hardware timestamping
> control path (SIOCGHWTSTAMP and SIOCSHWTSTAMP handling).
> 
> I don't have any board with phylib hardware timestamping, so I would
> appreciate testing (especially on lan966x, the most intricate
> conversion). I was, however, able to test netdev level timestamping,
> because I also have some more unsubmitted conversions in progress:
> 
> [...]

Here is the summary with links:
  - [v9,net-next,01/12] net: add NDOs for configuring hardware timestamping
    https://git.kernel.org/netdev/net-next/c/66f7223039c0
  - [v9,net-next,02/12] net: add hwtstamping helpers for stackable net devices
    https://git.kernel.org/netdev/net-next/c/e47d01fea663
  - [v9,net-next,03/12] net: vlan: convert to ndo_hwtstamp_get() / ndo_hwtstamp_set()
    https://git.kernel.org/netdev/net-next/c/65c9fde15a65
  - [v9,net-next,04/12] net: macvlan: convert to ndo_hwtstamp_get() / ndo_hwtstamp_set()
    https://git.kernel.org/netdev/net-next/c/0bca3f7f9acd
  - [v9,net-next,05/12] net: bonding: convert to ndo_hwtstamp_get() / ndo_hwtstamp_set()
    https://git.kernel.org/netdev/net-next/c/c0dabeb4c666
  - [v9,net-next,06/12] net: fec: convert to ndo_hwtstamp_get() and ndo_hwtstamp_set()
    https://git.kernel.org/netdev/net-next/c/ef5eb9c5ce45
  - [v9,net-next,07/12] net: fec: delete fec_ptp_disable_hwts()
    https://git.kernel.org/netdev/net-next/c/547b006d1922
  - [v9,net-next,08/12] net: sparx5: convert to ndo_hwtstamp_get() and ndo_hwtstamp_set()
    https://git.kernel.org/netdev/net-next/c/7bdde44463b2
  - [v9,net-next,09/12] net: lan966x: convert to ndo_hwtstamp_get() and ndo_hwtstamp_set()
    https://git.kernel.org/netdev/net-next/c/54e1ed69c40a
  - [v9,net-next,10/12] net: transfer rtnl_lock() requirement from ethtool_set_ethtool_phy_ops() to caller
    https://git.kernel.org/netdev/net-next/c/70ef7d87f62a
  - [v9,net-next,11/12] net: phy: provide phylib stubs for hardware timestamping operations
    https://git.kernel.org/netdev/net-next/c/60495b6622ca
  - [v9,net-next,12/12] net: remove phy_has_hwtstamp() -> phy_mii_ioctl() decision from converted drivers
    https://git.kernel.org/netdev/net-next/c/fd770e856e22

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



