Return-Path: <netdev+bounces-104309-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC86C90C19F
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 03:50:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46EBDB22AC9
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 01:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B86917740;
	Tue, 18 Jun 2024 01:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="odVU79oE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59540E56A;
	Tue, 18 Jun 2024 01:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718675429; cv=none; b=OOCqf6LKG6wz/3kUS/mR3rN+3gLwhoAnBayQAzFNyUJr2PAStvg8kjzjh+9pbPVVqLhgpA7Q3uE71wroh7Yruvqou5eC1t1dae2NMW293sRDVb9JOqTMWI/e+uRHf3HDZLWl8BTAK6Y7AhmioE/9tYofljsUETMWufml/ZZap3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718675429; c=relaxed/simple;
	bh=PKpDxjQLVo6wtTTfpFPstcUJb+vLoicNbbWQdJIWqpA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZXMvyR2auxm7hkMqH1IQG48AZKAGokB2x++yHMQzGGiBuRESbWh/fDmsNf69H42IvAM5cKNrfkWYJSGJfEG8ztn8EzKL2dIM1qjg344bWkTdbnp/XR/q+1rEJa/6LGadBpxNW/VEpjNT3qjDRefJ2rVw/ly7hJacTDEIXkGPOCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=odVU79oE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CA20FC3277B;
	Tue, 18 Jun 2024 01:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718675428;
	bh=PKpDxjQLVo6wtTTfpFPstcUJb+vLoicNbbWQdJIWqpA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=odVU79oEmB45LzpwjCapeOqmNg9zX7LApAqwKJ+TSKGx+DzO0GqzDJe/2sU9RM3XO
	 x7o9Vy+kX0gYMNLSa8zjIi9sY6WirU4SLrnjFUTSROn3vCnvnd9LDkBeO83WTOVmc5
	 W7LR+GVhJbrJIsgo3otgsKIAU9t1FX1VcPBkXnHQ+4A5B5EbtIKYPlP4J07zvkL1mF
	 Xp3vFFSPtfxmwO87761gt8cjkD/B14vP2thffGau10DYqpTYjzkJnfncRapN+X3jaQ
	 E8oGUMW72XXctEN9gu7KmpYtO2QaqnrrtieGF7wnRaOdvBXHqFJRY6+5DsqWROGEYj
	 Yqv2YnZv2785Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B8066C4166F;
	Tue, 18 Jun 2024 01:50:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v15 00/14] net: Make timestamping selectable
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171867542874.561.14086778565538344175.git-patchwork-notify@kernel.org>
Date: Tue, 18 Jun 2024 01:50:28 +0000
References: <20240612-feature_ptp_netnext-v15-0-b2a086257b63@bootlin.com>
In-Reply-To: <20240612-feature_ptp_netnext-v15-0-b2a086257b63@bootlin.com>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: florian.fainelli@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
 andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 richardcochran@gmail.com, radu-nicolae.pirea@oss.nxp.com,
 j.vosburgh@gmail.com, andy@greyhouse.net, nicolas.ferre@microchip.com,
 claudiu.beznea@tuxon.dev, willemdebruijn.kernel@gmail.com, corbet@lwn.net,
 horatiu.vultur@microchip.com, UNGLinuxDriver@microchip.com, horms@kernel.org,
 vladimir.oltean@nxp.com, thomas.petazzoni@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, maxime.chevallier@bootlin.com,
 rrameshbabu@nvidia.com, willemb@google.com, shannon.nelson@amd.com,
 wintera@linux.ibm.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 12 Jun 2024 17:04:00 +0200 you wrote:
> Up until now, there was no way to let the user select the hardware
> PTP provider at which time stamping occurs. The stack assumed that PHY time
> stamping is always preferred, but some MAC/PHY combinations were buggy.
> 
> This series updates the default MAC/PHY default timestamping and aims to
> allow the user to select the desired hwtstamp provider administratively.
> 
> [...]

Here is the summary with links:
  - [net-next,v15,01/14] net_tstamp: Add TIMESTAMPING SOFTWARE and HARDWARE mask
    (no matching commit)
  - [net-next,v15,02/14] net: Move dev_set_hwtstamp_phylib to net/core/dev.h
    https://git.kernel.org/netdev/net-next/c/efb459303dd5
  - [net-next,v15,03/14] net: Make dev_get_hwtstamp_phylib accessible
    (no matching commit)
  - [net-next,v15,04/14] net: Make net_hwtstamp_validate accessible
    (no matching commit)
  - [net-next,v15,05/14] net: Change the API of PHY default timestamp to MAC
    (no matching commit)
  - [net-next,v15,06/14] net: net_tstamp: Add unspec field to hwtstamp_source enumeration
    (no matching commit)
  - [net-next,v15,07/14] net: Add struct kernel_ethtool_ts_info
    (no matching commit)
  - [net-next,v15,08/14] ptp: Add phc source and helpers to register specific PTP clock or get information
    (no matching commit)
  - [net-next,v15,09/14] net: Add the possibility to support a selected hwtstamp in netdevice
    (no matching commit)
  - [net-next,v15,10/14] net: netdevsim: ptp_mock: Convert to netdev_ptp_clock_register
    (no matching commit)
  - [net-next,v15,11/14] net: macb: Convert to netdev_ptp_clock_register
    (no matching commit)
  - [net-next,v15,12/14] net: ptp: Move ptp_clock_index() to builtin symbol
    (no matching commit)
  - [net-next,v15,13/14] net: ethtool: tsinfo: Add support for hwtstamp provider and get/set hwtstamp config
    (no matching commit)
  - [net-next,v15,14/14] netlink: specs: tsinfo: Enhance netlink attributes and add a set command
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



