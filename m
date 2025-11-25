Return-Path: <netdev+bounces-241384-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C58D8C8346B
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 04:50:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 848EC3AEFD2
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 03:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B2EC27F18B;
	Tue, 25 Nov 2025 03:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H6FN2siT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE20264638;
	Tue, 25 Nov 2025 03:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764042648; cv=none; b=tn9HRKMNKJ+xYUzEHOWFX7C1OCT0PfmRuk4wtWyOO8cHpd1dQTKHccrq/yOfYss/P80HBfmLo6rABPZl2TM8YYsvgEUOdfiCANzsCK9wrsVKo+mwCmYe3kMC7lOkjpTvs1v79wCVNhZXRHJt8VshgY0E4jc/nKMOkfLOcJB8GiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764042648; c=relaxed/simple;
	bh=mJnQ87zpIiSUyhceEo9j8x2qEUBwXL9lZnJ0amalQqU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TNZNMl3q0l7XfhDtqU2iQhwfm5G1bzv6vk9cQrozX5G62VwmdVMI1gBHGWXRnc8HLVcahoQUxeaS1hBFG2uX5DqoLSz+yaykpv9Dg6QnSA1CsNYTDtMKNQE2VZWLci2jBgRTdctrVqlMi3IaQSTp1fMNJ7iACAD+EU4BhKd4QLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H6FN2siT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 356BAC116B1;
	Tue, 25 Nov 2025 03:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764042648;
	bh=mJnQ87zpIiSUyhceEo9j8x2qEUBwXL9lZnJ0amalQqU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=H6FN2siTjt80tIxH6nti7vFkU/rKqqnI8/RAWTjlkH9QsAWK0kUieZ5J1Fq8un6vz
	 NSvKOFahK8VQuhWSG83tElotEc91zFVGWNZoQ67NcpjB2RlZZSGavVI7mfsq+aHkeX
	 Fi7ifE7h9VoeR72pQoXSukKJwcgET3FH5pL6tbDcuUHuWdl+RfUma3Mh5Fo83Wqqfi
	 q9jFfGzqQf65o/Ep2Ul47Haz6QLURr15kfGB4sFiFRcJC/ujce3dt+ec7M5P84YEb/
	 e6HIDb8SfwERH9lesNHa97GWxwBWxDtjv1xVHc4WXRLv/E+iJZPaLyiB96k8uUq0nx
	 kH33cas9Edr/w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3440E3A8A3CC;
	Tue, 25 Nov 2025 03:50:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] net: marvell: modernize RX ring count
 ethtool
 callbacks
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176404261074.179191.13412681505599411375.git-patchwork-notify@kernel.org>
Date: Tue, 25 Nov 2025 03:50:10 +0000
References: <20251121-marvell-v1-0-8338f3e55a4c@debian.org>
In-Reply-To: <20251121-marvell-v1-0-8338f3e55a4c@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: marcin.s.wojtas@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux@armlinux.org.uk, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-team@meta.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 21 Nov 2025 09:02:34 -0800 you wrote:
> This series converts the Marvell mvneta and mvpp2 drivers to use the new
> .get_rx_ring_count ethtool operation, following the ongoing modernization
> of the ethtool API introduced in commit 84eaf4359c36 ("net: ethtool: add
> get_rx_ring_count callback to optimize RX ring queries").
> 
> The conversion simplifies the code by replacing the generic .get_rxnfc
> callback with the more specific .get_rx_ring_count callback for retrieving
> RX ring counts. For mvneta, this completely removes .get_rxnfc since it
> only handled ETHTOOL_GRXRINGS. For mvpp2, the GRXRINGS case is extracted
> while keeping other rxnfc handlers intact.
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] net: mvneta: convert to use .get_rx_ring_count
    https://git.kernel.org/netdev/net-next/c/737e14c5dce3
  - [net-next,2/2] net: mvpp2: extract GRXRINGS from .get_rxnfc
    https://git.kernel.org/netdev/net-next/c/20c20f05cf50

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



