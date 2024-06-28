Return-Path: <netdev+bounces-107628-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DD2091BC15
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 12:00:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 577B61C22611
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 10:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7889F154420;
	Fri, 28 Jun 2024 10:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TqMknCVj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4228C46B9A;
	Fri, 28 Jun 2024 10:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719568835; cv=none; b=T1YDdbm4UYDuWzUPtcymeIMS62wobkfY1EjsOEdf7ZAKSPMe6KYcQtKoRtjq+42cDPaulDMcuDCgvoiZOeyBk9OrhZbodbggiJysZlfNfQ6/aEoW7jbXjulGbzFWFK9ZP0gxNIO0FutVndJnOnAybRSJ1EjfVJT7t2wHnuqanzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719568835; c=relaxed/simple;
	bh=8UYRdrbjDouh2qhlWxjBAxJ8E6JMHZqMchqcT9QVL+k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Qv7OgR2mg8dtkpa/mFBaKNCRmf/DaCU5NfvGbVXTnzHP+o4XFdAUjnNQAfcleLTBpMAZDJzOLLmhIE0AsXdp7oK4QnHvEdmDrhU1FZgTrBAkCmTDR1gtIqDnh2NJFeYwm9+bQH4LCOZgUsjxJEM2EZ0/j3Ab5zHZPcBkwxGLfWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TqMknCVj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B6A85C4AF0A;
	Fri, 28 Jun 2024 10:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719568834;
	bh=8UYRdrbjDouh2qhlWxjBAxJ8E6JMHZqMchqcT9QVL+k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TqMknCVjQLOovdnO4R/tOAs/Z7FmaIJH+RRPa3erTB+E97DQUhTZpgahoFMoQPa2o
	 MIjstNcnxH3L8F9b+xH7wKrTDziVdMrcoVt/3ipxW6SnweHdJXsZLBaWP1nRfMXphU
	 tmXb+g5uONhdG5/FhgYi5vLiTvAyBR1psUIv9TXs8sH9GfxWfVxn0aa0EcaV+EkPWf
	 24PXye+kA0BIP4tTuH+T362rqAuQZItmaGjKgmrvul6qw2Y+/07iQ3iHxQVBjA6P1t
	 eofAz80CtC2mIqKAPcaoy7RfFRW1ty+A4Yo62V2pzNdn2iBM6xGRDoZDob6zufpqwJ
	 sgoVyEsSTW9yw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A6CCFC43335;
	Fri, 28 Jun 2024 10:00:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v8 0/9] Add ability to flash modules' firmware
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171956883468.3919.7096273991570928378.git-patchwork-notify@kernel.org>
Date: Fri, 28 Jun 2024 10:00:34 +0000
References: <20240627140857.1398100-1-danieller@nvidia.com>
In-Reply-To: <20240627140857.1398100-1-danieller@nvidia.com>
To: Danielle Ratson <danieller@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, corbet@lwn.net, linux@armlinux.org.uk,
 sdf@google.com, kory.maincent@bootlin.com, maxime.chevallier@bootlin.com,
 vladimir.oltean@nxp.com, przemyslaw.kitszel@intel.com, ahmed.zaki@intel.com,
 richardcochran@gmail.com, shayagr@amazon.com, paul.greenwalt@intel.com,
 jiri@resnulli.us, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 mlxsw@nvidia.com, idosch@nvidia.com, petrm@nvidia.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 27 Jun 2024 17:08:47 +0300 you wrote:
> CMIS compliant modules such as QSFP-DD might be running a firmware that
> can be updated in a vendor-neutral way by exchanging messages between
> the host and the module as described in section 7.2.2 of revision
> 4.0 of the CMIS standard.
> 
> According to the CMIS standard, the firmware update process is done
> using a CDB commands sequence.
> 
> [...]

Here is the summary with links:
  - [net-next,v8,1/9] ethtool: Add ethtool operation to write to a transceiver module EEPROM
    https://git.kernel.org/netdev/net-next/c/69540b7987ef
  - [net-next,v8,2/9] mlxsw: Implement ethtool operation to write to a transceiver module EEPROM
    https://git.kernel.org/netdev/net-next/c/1983a8007032
  - [net-next,v8,3/9] ethtool: Add an interface for flashing transceiver modules' firmware
    https://git.kernel.org/netdev/net-next/c/46fb3ba95b93
  - [net-next,v8,4/9] ethtool: Add flashing transceiver modules' firmware notifications ability
    https://git.kernel.org/netdev/net-next/c/d7d4cfc4c97c
  - [net-next,v8,5/9] ethtool: Veto some operations during firmware flashing process
    https://git.kernel.org/netdev/net-next/c/31e0aa99dc02
  - [net-next,v8,6/9] net: sfp: Add more extended compliance codes
    https://git.kernel.org/netdev/net-next/c/e4f91936993c
  - [net-next,v8,7/9] ethtool: cmis_cdb: Add a layer for supporting CDB commands
    https://git.kernel.org/netdev/net-next/c/a39c84d79625
  - [net-next,v8,8/9] ethtool: cmis_fw_update: add a layer for supporting firmware update using CDB
    https://git.kernel.org/netdev/net-next/c/c4f78134d45c
  - [net-next,v8,9/9] ethtool: Add ability to flash transceiver modules' firmware
    https://git.kernel.org/netdev/net-next/c/32b4c8b53ee7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



