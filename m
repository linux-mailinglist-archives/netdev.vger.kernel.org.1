Return-Path: <netdev+bounces-111532-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B9A93179C
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 17:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EF0F1F2198D
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 15:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADDC518F2E3;
	Mon, 15 Jul 2024 15:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HqQOR5Xj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8497AF9EC;
	Mon, 15 Jul 2024 15:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721057432; cv=none; b=uAd2HTOWhgAe4veYYSbnkUHlO/s2e24dhWCms/LqTHYxldsJ4nuDMCV8uVH9m/bV1y2VQGpQElQqrcq+DK/d2VEoDeWmRD51SFUBnCtabF2XfPuScggSYk1Ue7G80n2yrcaj7FYcxhLwCEBsQJNrAB5FrqJib7aKMMvmfqWUkl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721057432; c=relaxed/simple;
	bh=ZiiwK2OdrjEk+Z7gT8YtwhRBV9j0EHG0ohgQFGZxWdI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YlZ2lHq0CU8OcVkHjvvSqD4+HN/5jv+1XFCQYYRDRXZDZSsuOp7YZksq1VTVgv04OHNAWiuCDAVWg/aqRJTTy7FCsEwscJkn03GPI78n7Wkkddl29wSkKqFOblKLxPV4tYMwpXbEajQb5cC6UyJkOuEGoUozj2JrInphKLgnvlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HqQOR5Xj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 18DB8C4AF0E;
	Mon, 15 Jul 2024 15:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721057432;
	bh=ZiiwK2OdrjEk+Z7gT8YtwhRBV9j0EHG0ohgQFGZxWdI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HqQOR5XjJhPG1ef35CmVtQE/Wy6ETl4no9w3S8xjBHnZ9L5l3t/IvxDlhWlHYV94C
	 pzzdp9Hi5kxLnAh15XroQpCKBM+3BWJn4EnijS27DfSpweJNxKNicj6XLqMWn4Mazc
	 2U4aC4f1JYyTW49BvWeIAGU2GeqSIY4IKJ3vbcWO2DH/IHniB1SZ3dTNxrI8r2kdr6
	 dtTeXDz/i1hS/opWoSN6HJAzMjNWx5edcvgNhDsdjZ+NON0pW+zuQMXLo0lSL8c1hr
	 qDrGcb2M2Vq4wMJzuY13aNzIBMpWQqfIh9B0plM8/cKoKXLBAEYDgfkYwFqmGWVtId
	 fpR3V4VWa010Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 020B3C4332C;
	Mon, 15 Jul 2024 15:30:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v17 00/14] net: Make timestamping selectable
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172105743200.15319.6085031984447160159.git-patchwork-notify@kernel.org>
Date: Mon, 15 Jul 2024 15:30:32 +0000
References: <20240709-feature_ptp_netnext-v17-0-b5317f50df2a@bootlin.com>
In-Reply-To: <20240709-feature_ptp_netnext-v17-0-b5317f50df2a@bootlin.com>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: florian.fainelli@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
 andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 richardcochran@gmail.com, radu-nicolae.pirea@oss.nxp.com,
 j.vosburgh@gmail.com, andy@greyhouse.net, nicolas.ferre@microchip.com,
 claudiu.beznea@tuxon.dev, willemdebruijn.kernel@gmail.com, corbet@lwn.net,
 horatiu.vultur@microchip.com, UNGLinuxDriver@microchip.com, horms@kernel.org,
 vladimir.oltean@nxp.com, donald.hunter@gmail.com, danieller@nvidia.com,
 ecree.xilinx@gmail.com, thomas.petazzoni@bootlin.com,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, maxime.chevallier@bootlin.com,
 rrameshbabu@nvidia.com, willemb@google.com, shannon.nelson@amd.com,
 wintera@linux.ibm.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 09 Jul 2024 15:53:32 +0200 you wrote:
> Up until now, there was no way to let the user select the hardware
> PTP provider at which time stamping occurs. The stack assumed that PHY time
> stamping is always preferred, but some MAC/PHY combinations were buggy.
> 
> This series updates the default MAC/PHY default timestamping and aims to
> allow the user to select the desired hwtstamp provider administratively.
> 
> [...]

Here is the summary with links:
  - [net-next,v17,01/14] net_tstamp: Add TIMESTAMPING SOFTWARE and HARDWARE mask
    https://git.kernel.org/netdev/net-next/c/e50bfd6bb231
  - [net-next,v17,02/14] net: Make dev_get_hwtstamp_phylib accessible
    (no matching commit)
  - [net-next,v17,03/14] net: Make net_hwtstamp_validate accessible
    (no matching commit)
  - [net-next,v17,04/14] net: Change the API of PHY default timestamp to MAC
    (no matching commit)
  - [net-next,v17,05/14] net: net_tstamp: Add unspec field to hwtstamp_source enumeration
    https://git.kernel.org/netdev/net-next/c/bc5a07ed15a3
  - [net-next,v17,06/14] net: Add struct kernel_ethtool_ts_info
    https://git.kernel.org/netdev/net-next/c/2111375b85ad
  - [net-next,v17,07/14] ptp: Add phc source and helpers to register specific PTP clock or get information
    (no matching commit)
  - [net-next,v17,08/14] net: Add the possibility to support a selected hwtstamp in netdevice
    (no matching commit)
  - [net-next,v17,09/14] net: netdevsim: ptp_mock: Convert to netdev_ptp_clock_register
    (no matching commit)
  - [net-next,v17,10/14] net: macb: Convert to netdev_ptp_clock_register
    (no matching commit)
  - [net-next,v17,11/14] net: ptp: Move ptp_clock_index() to builtin symbol
    (no matching commit)
  - [net-next,v17,12/14] net: ethtool: tsinfo: Add support for reading tsinfo for a specific hwtstamp provider
    (no matching commit)
  - [net-next,v17,13/14] net: ethtool: Add support for tsconfig command to get/set hwtstamp config
    (no matching commit)
  - [net-next,v17,14/14] netlink: specs: Enhance tsinfo netlink attributes and add a tsconfig set command
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



