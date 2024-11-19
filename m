Return-Path: <netdev+bounces-146104-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6442D9D1F0F
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 05:01:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2BB3B22B83
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 04:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E27156661;
	Tue, 19 Nov 2024 04:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KtijRZKK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AAE514B06A;
	Tue, 19 Nov 2024 04:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731988834; cv=none; b=ihAAUYwkm99xvIBb415pgXJKWgE2N9n90l4sFLr76Hii2o8sfkUfjydlejOdAwHFNVSWIdTYAJfuK7hudm3/40Jj95LYBj/CPwntBgTu5quEiD33iy57/MRuJyn0auat2vVgYxWJJRYb3OepeHxTvClZRE/gZXi+zdJNEJst2vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731988834; c=relaxed/simple;
	bh=oh+IX3k+C5979Zv7no9k810xDJ/vT/99kL2zrUcmP8E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Y4XyEoz9vKymMyrE6iZB9tFNgqguuT2AZakHJoFCWmetBkd3Tud7cMFJlVms4tKqJTxzbvli6FBzPFVpXKoDzh26/rXxCub4stuC2SMrgS0z2I49ouTjmNwBuZWCoF5KKhbChmC0jCadyEniSPuBtKV7qI2rxNxOYOlNew6Y85Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KtijRZKK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1287C4DDEB;
	Tue, 19 Nov 2024 04:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731988833;
	bh=oh+IX3k+C5979Zv7no9k810xDJ/vT/99kL2zrUcmP8E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KtijRZKKn0G6iqcSHsZMAPXxfcImh6EDFAQmQX1xQmrjA+CF61CbxyyQm/LypVBmt
	 Fp5hNHlNwzgC7evqVsFC3PgfveNK5DgVEQ2mj3LCHOK14aVm3OxCf/mNpJX6a2Wiie
	 xsW7m6O0BtOUoRjWkkSnkzNDr0f+Zal4pa6A0AP1mA6hQSx1/y/SlRc/xDxkiolPOV
	 90x+dDy13qJpn/+l2Xo3zt2ng6xMFRChjc4fY6fIjku+Wb6uaEhLxGm0ZoAMNCP0CH
	 JHT3nWx7kQpOBKpF1ZlmNgg3mV41aPojJ/ljTQ8hYN9xKWt7CEQZJHYj4tvy8VBEVQ
	 hLdVOIaniSiqQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70EC13809A80;
	Tue, 19 Nov 2024 04:00:46 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/3] UAPI: ethtool: Avoid flex-array in struct
 ethtool_link_settings
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173198884499.97799.13289755875116229867.git-patchwork-notify@kernel.org>
Date: Tue, 19 Nov 2024 04:00:44 +0000
References: <20241115204115.work.686-kees@kernel.org>
In-Reply-To: <20241115204115.work.686-kees@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: kuba@kernel.org, gustavoars@kernel.org, davem@davemloft.net,
 andrew@lunn.ch, kory.maincent@bootlin.com, michael.chan@broadcom.com,
 andrew+netdev@lunn.ch, edumazet@google.com, pabeni@redhat.com,
 bharat@chelsio.com, benve@cisco.com, satishkh@cisco.com, manishc@marvell.com,
 horms@kernel.org, ecree.xilinx@gmail.com, przemyslaw.kitszel@intel.com,
 hkallweit1@gmail.com, ahmed.zaki@intel.com, rrameshbabu@nvidia.com,
 idosch@nvidia.com, maxime.chevallier@bootlin.com, hayatake396@gmail.com,
 corbet@lwn.net, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-hardening@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 15 Nov 2024 12:43:02 -0800 you wrote:
> Hi,
> 
> This reverts the tagged struct group in struct ethtool_link_settings and
> instead just removes the flexible array member from Linux's view as it
> is entirely unused.
> 
> -Kees
> 
> [...]

Here is the summary with links:
  - [1/3] Revert "net: ethtool: Avoid thousands of -Wflex-array-member-not-at-end warnings"
    https://git.kernel.org/netdev/net-next/c/1cfb5e57886a
  - [2/3] Revert "UAPI: ethtool: Use __struct_group() in struct ethtool_link_settings"
    https://git.kernel.org/netdev/net-next/c/ebda123fe703
  - [3/3] UAPI: ethtool: Avoid flex-array in struct ethtool_link_settings
    https://git.kernel.org/netdev/net-next/c/96c677fca54a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



