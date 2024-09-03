Return-Path: <netdev+bounces-124752-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA3796AC38
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 00:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C66DE1F250BE
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 22:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E706A1D58BD;
	Tue,  3 Sep 2024 22:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nqipGKtu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14A91D58B5
	for <netdev@vger.kernel.org>; Tue,  3 Sep 2024 22:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725402637; cv=none; b=ixG5NOyOfI2ye3xc8Qg9SJYKGt5KbgM3ROSwcZexo918fSh9FQq1bpX03QHdeIPwYA5WtrDVuL+AzyXjITjvqE6Ye6a/o6NvAl+gi/KgLhhOY7nZSQfrAW1paRDm2YcxWn6ARm9Wm/1v5b8hto8cVbD8iUAidYxBnA9q8qo9wQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725402637; c=relaxed/simple;
	bh=osyOc9NZkfMUxgoz5GohTdMff5iwLJ7a+jnYozzG6k0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=REgT7cnK/72a4l1Qh0qjjDqVYtdWPF5f7UYs0bbWhnLkMlMVZyFt/aIT0Z99EDU75InygZ6bYcVzUUW98n5QNscPiFTFLKFp49NgMSbx+GbYZVYTjuHsWhX2HG89Qil0T5jfgcLBUcBCvfvDopdGkoJqfLlyQPaOZfdn6Nq8c7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nqipGKtu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32E8AC4CECB;
	Tue,  3 Sep 2024 22:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725402637;
	bh=osyOc9NZkfMUxgoz5GohTdMff5iwLJ7a+jnYozzG6k0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nqipGKtu+FPjLjNxTjyX83lc8BHUH/a3RAs1a9BkOkGDVSp6crOwe4JT/PbmzHGzF
	 hDbenijYWB64q1bIWMfApux/LS8GT2cUw2JrR36ix9s08rJZ4RJ4RxgXo5ogyDnyO3
	 gep82uHzuLzT/YosxyfmVsbjeezZcL/2052Jj69hnZveexH0lkVpRpDzV90G5DWO/t
	 6d8bGv66j1mIKejWHOp6O60Tpp/PqtU+mqzWUxZmYkGHeKNOdEyvcZZ3uvwY4XzaeW
	 IFq1kkIccIo2jdPzVaSzubPqPi9vJMON3UlX+FVwqZUK1YcQgaJL8atBiw+Rw28pxg
	 pg/7iEZXpJCvw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 0DA6E3806651;
	Tue,  3 Sep 2024 22:30:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 00/15] RX software timestamp for all
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172540263700.468499.16568483036752716889.git-patchwork-notify@kernel.org>
Date: Tue, 03 Sep 2024 22:30:37 +0000
References: <20240901112803.212753-1-gal@nvidia.com>
In-Reply-To: <20240901112803.212753-1-gal@nvidia.com>
To: Gal Pressman <gal@nvidia.com>
Cc: davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
 jv@jvosburgh.net, andy@greyhouse.net, mkl@pengutronix.de,
 mailhol.vincent@wanadoo.fr, Shyam-sundar.S-k@amd.com, skalluru@marvell.com,
 manishc@marvell.com, michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
 nicolas.ferre@microchip.com, claudiu.beznea@tuxon.dev, sgoutham@marvell.com,
 bharat@chelsio.com, benve@cisco.com, satishkh@cisco.com,
 claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, wei.fang@nxp.com,
 shenwei.wang@nxp.com, xiaoning.wang@nxp.com, dmichail@fungible.com,
 yisen.zhuang@huawei.com, salil.mehta@huawei.com, shaojijie@huawei.com,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 marcin.s.wojtas@gmail.com, linux@armlinux.org.uk, gakula@marvell.com,
 sbhatta@marvell.com, hkelam@marvell.com, idosch@nvidia.com, petrm@nvidia.com,
 bryan.whitehead@microchip.com, UNGLinuxDriver@microchip.com,
 horatiu.vultur@microchip.com, lars.povlsen@microchip.com,
 Steen.Hegelund@microchip.com, daniel.machon@microchip.com,
 alexandre.belloni@bootlin.com, shannon.nelson@amd.com, brett.creeley@amd.com,
 s.shtylyov@omp.ru, yoshihiro.shimoda.uh@renesas.com,
 niklas.soderlund@ragnatech.se, ecree.xilinx@gmail.com,
 habetsm.xilinx@gmail.com, alexandre.torgue@foss.st.com, joabreu@synopsys.com,
 mcoquelin.stm32@gmail.com, s-vadapalli@ti.com, rogerq@kernel.org,
 danishanwar@ti.com, linusw@kernel.org, kaloz@openwrt.org,
 richardcochran@gmail.com, willemdebruijn.kernel@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 1 Sep 2024 14:27:48 +0300 you wrote:
> All devices support SOF_TIMESTAMPING_RX_SOFTWARE by virtue of
> net_timestamp_check() being called in the device independent code.
> Following Willem's suggestion [1], make it so drivers do not have to
> handle SOF_TIMESTAMPING_RX_SOFTWARE and SOF_TIMESTAMPING_SOFTWARE, nor
> setting of the PHC index to -1.
> 
> All drivers will now report RX software timestamp as supported.
> The series is limited to 15 patches, I will submit other drivers in
> subsequent submissions.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,01/15] ethtool: RX software timestamp for all
    https://git.kernel.org/netdev/net-next/c/12d337339d9f
  - [net-next,v2,02/15] can: dev: Remove setting of RX software timestamp
    https://git.kernel.org/netdev/net-next/c/b5ed017a5658
  - [net-next,v2,03/15] can: peak_canfd: Remove setting of RX software timestamp
    https://git.kernel.org/netdev/net-next/c/583fee8210cb
  - [net-next,v2,04/15] can: peak_usb: Remove setting of RX software timestamp
    https://git.kernel.org/netdev/net-next/c/ab6ebf02f222
  - [net-next,v2,05/15] tsnep: Remove setting of RX software timestamp
    https://git.kernel.org/netdev/net-next/c/24186dc66b10
  - [net-next,v2,06/15] ionic: Remove setting of RX software timestamp
    https://git.kernel.org/netdev/net-next/c/e052114e14c2
  - [net-next,v2,07/15] ravb: Remove setting of RX software timestamp
    https://git.kernel.org/netdev/net-next/c/277901ee3a26
  - [net-next,v2,08/15] net: renesas: rswitch: Remove setting of RX software timestamp
    https://git.kernel.org/netdev/net-next/c/41ee62317087
  - [net-next,v2,09/15] net: ethernet: rtsn: Remove setting of RX software timestamp
    https://git.kernel.org/netdev/net-next/c/0f79953c0019
  - [net-next,v2,10/15] net: hns3: Remove setting of RX software timestamp
    https://git.kernel.org/netdev/net-next/c/c6a15576e60e
  - [net-next,v2,11/15] net: fec: Remove setting of RX software timestamp
    https://git.kernel.org/netdev/net-next/c/7d20c38d088e
  - [net-next,v2,12/15] net: enetc: Remove setting of RX software timestamp
    https://git.kernel.org/netdev/net-next/c/3dd261ca7f84
  - [net-next,v2,13/15] gianfar: Remove setting of RX software timestamp
    https://git.kernel.org/netdev/net-next/c/673ec22b1de8
  - [net-next,v2,14/15] octeontx2-pf: Remove setting of RX software timestamp
    https://git.kernel.org/netdev/net-next/c/eb87a1daf6fb
  - [net-next,v2,15/15] net: mvpp2: Remove setting of RX software timestamp
    https://git.kernel.org/netdev/net-next/c/406e862b4583

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



