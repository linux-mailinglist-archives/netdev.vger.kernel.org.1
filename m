Return-Path: <netdev+bounces-134332-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 03015998D16
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 18:18:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4AD1EB2A392
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 16:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E17A1CDFC3;
	Thu, 10 Oct 2024 16:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ubyGNQq1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD441CDFBF
	for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 16:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728576640; cv=none; b=IrgfnC3GIVa31Q2s2i1I+6lR1aphUUK0uFVbQ1gmz565ZoMOUwkQELp5cq/IpjemZ9iZySSWkHnD4l1WKOr/R+JQmVo1F18alkmXjZxHiPQtt1cForBWyVULceoRTN+9TZTyDeFxMjlOjwURc+EaM+jcdQs57m5hA1OHDf0wMVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728576640; c=relaxed/simple;
	bh=3j3BdPgK6Vd/vnSvVA35LlyZ2UhPlFthr12ffk6o9is=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hRkr/XDL8BszL5TmYpCgx0z9wK/IkKYKABBGpRE/TmdpkYnB1KSukT/Vj498cXeWbP1VPN5dwJs7YsNLvB07lRBWxGD9LascPtJZ/pdOH/LkS0s8fAYo5LilpZqfBNnBOVF1CrPZZS0qFJUQKzGCfqw4rTYuYERCl9CoUr4aZMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ubyGNQq1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9059CC4CEC5;
	Thu, 10 Oct 2024 16:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728576640;
	bh=3j3BdPgK6Vd/vnSvVA35LlyZ2UhPlFthr12ffk6o9is=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ubyGNQq1I2v0BQXSGgk6D6COJZZjh6wo2zDWaPuyMJUpIWyv7MvagP/L0mxAxRqCs
	 QP95BH0983imVR6JyToy2/rNIEFvO1laaPHuer8fwE72lZqXVZBVbp8eX8C6rGvzfy
	 fAAA9Z+IzT1hLhtVw2uNI6z0YxFgS1KItyIXG+wd/CrWV6QBsvGLlgi50WiISBjHRQ
	 YoMstZhvG1FP331rMbrnQqmO2VvkzM9N3JN2jVxhzQEn5Y1qpwXP1QefMicr1Jmhtf
	 WE5Qr2poGfRtqk+njRaoEE1iSr6Kc6MLXWw6jE4tdpulR9iXne3Zg0dLSglF/+Ncaf
	 0NPgk85JIz/0w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33AC33803263;
	Thu, 10 Oct 2024 16:10:46 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v9 net-next 00/15] net: introduce TX H/W shaping API
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172857664473.2081951.14668843585548257303.git-patchwork-notify@kernel.org>
Date: Thu, 10 Oct 2024 16:10:44 +0000
References: <cover.1728460186.git.pabeni@redhat.com>
In-Reply-To: <cover.1728460186.git.pabeni@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, jiri@resnulli.us,
 madhu.chittim@intel.com, sridhar.samudrala@intel.com, horms@kernel.org,
 john.fastabend@gmail.com, sgoutham@marvell.com, jhs@mojatatu.com,
 donald.hunter@gmail.com, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, intel-wired-lan@lists.osuosl.org,
 edumazet@google.com, stfomichev@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  9 Oct 2024 10:09:46 +0200 you wrote:
> We have a plurality of shaping-related drivers API, but none flexible
> enough to meet existing demand from vendors[1].
> 
> This series introduces new device APIs to configure in a flexible way
> TX H/W shaping. The new functionalities are exposed via a newly
> defined generic netlink interface and include introspection
> capabilities. Some self-tests are included, on top of a dummy
> netdevsim implementation. Finally a basic implementation for the iavf
> driver is provided.
> 
> [...]

Here is the summary with links:
  - [v9,net-next,01/15] genetlink: extend info user-storage to match NL cb ctx
    https://git.kernel.org/netdev/net-next/c/13d68a164303
  - [v9,net-next,02/15] netlink: spec: add shaper YAML spec
    https://git.kernel.org/netdev/net-next/c/04e65df94b31
  - [v9,net-next,03/15] net-shapers: implement NL get operation
    https://git.kernel.org/netdev/net-next/c/4b623f9f0f59
  - [v9,net-next,04/15] net-shapers: implement NL set and delete operations
    https://git.kernel.org/netdev/net-next/c/93954b40f6a4
  - [v9,net-next,05/15] net-shapers: implement NL group operation
    https://git.kernel.org/netdev/net-next/c/5d5d4700e75d
  - [v9,net-next,06/15] net-shapers: implement delete support for NODE scope shaper
    https://git.kernel.org/netdev/net-next/c/bf230c497d31
  - [v9,net-next,07/15] net-shapers: implement shaper cleanup on queue deletion
    https://git.kernel.org/netdev/net-next/c/ff7d4deb1f3e
  - [v9,net-next,08/15] netlink: spec: add shaper introspection support
    https://git.kernel.org/netdev/net-next/c/14bba9285aed
  - [v9,net-next,09/15] net: shaper: implement introspection support
    https://git.kernel.org/netdev/net-next/c/553ea9f1efd6
  - [v9,net-next,10/15] net-shapers: implement cap validation in the core
    https://git.kernel.org/netdev/net-next/c/ecd82cfee355
  - [v9,net-next,11/15] testing: net-drv: add basic shaper test
    https://git.kernel.org/netdev/net-next/c/b3ea416419c8
  - [v9,net-next,12/15] virtchnl: support queue rate limit and quanta size configuration
    https://git.kernel.org/netdev/net-next/c/608a5c05c39b
  - [v9,net-next,13/15] ice: Support VF queue rate limit and quanta size configuration
    https://git.kernel.org/netdev/net-next/c/015307754a19
  - [v9,net-next,14/15] iavf: Add net_shaper_ops support
    https://git.kernel.org/netdev/net-next/c/ef490bbb2267
  - [v9,net-next,15/15] iavf: add support to exchange qos capabilities
    https://git.kernel.org/netdev/net-next/c/4c1a457cb8b0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



