Return-Path: <netdev+bounces-190765-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D471BAB8A63
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 17:16:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02DB49E3119
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 15:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61ACE20C492;
	Thu, 15 May 2025 15:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pH1yhpfb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DBBA42A82
	for <netdev@vger.kernel.org>; Thu, 15 May 2025 15:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747321796; cv=none; b=nkUle5GxEKgec5NipKSSkQHMvXIzOwkT6gAiNb0Z7E1B+7JzW80TXbuNNtlVNOlBEooaXhiEg2haS3W7Q033UWEHCYcysTAM6Q7tMap3ONXIvNtV3bwoQ6AvNXK0E7wjRYQx6MPz1GJ/qe9U4OCauIXMad69Je4zBYqg2mgH1pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747321796; c=relaxed/simple;
	bh=t883VBpicwCSdqSdAesit+/6+Jz9s+OLDldkgvqbjp8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uDx4I2URVwl39ISLpHQODnvDLLHLDHkgofI1zeLmSVG61xBgFeyGq2o2AF1KRNGfvmKa/hAWcElEqi69IGPu22F2kU9uB1068hENYFiEt0/TEXObMO8fzeJroRIE3GMiXvW+B5Yo7gZEKtv2y64yiaHPiS8F7X49AUA7o3VJ23k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pH1yhpfb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0105C4CEE7;
	Thu, 15 May 2025 15:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747321795;
	bh=t883VBpicwCSdqSdAesit+/6+Jz9s+OLDldkgvqbjp8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pH1yhpfbN9k69Z3zPAbdLKQFnj6hQs6kk9snF+DtzCPMsYZUPVqmRt6rlFXLGrmxp
	 Vjp2GKVKT7ffFRbdEghqc9bHMXPzy1ieM+QL/4nhXbLg4nylBoHpvPAOELnt23grZH
	 F/mWX4lasn8+SsaNaUvBKK8PxHwkMWDtFQQRl5VtBSLOw2kxI/xxTFiTEGtodNoT6o
	 WLeoQgOtNx7Ex1HxkiurDGUVmMWEaH/Bw+xwuy8nWQqaImJM3j1pas/aUPLJC7G+hq
	 rupQb20Kt3XRd6ZSgVV7PPW9rIFAxHULYaiUWW5d2D2LfQZw8PBTNuBSMcdcI0HiGD
	 loZN2kyUcRD9A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB0A63806659;
	Thu, 15 May 2025 15:10:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] tsnep: fix timestamping with a stacked DSA driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174732183151.3142925.5290378453132436424.git-patchwork-notify@kernel.org>
Date: Thu, 15 May 2025 15:10:31 +0000
References: <20250514195657.25874-1-gerhard@engleder-embedded.com>
In-Reply-To: <20250514195657.25874-1-gerhard@engleder-embedded.com>
To: Gerhard Engleder <gerhard@engleder-embedded.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch,
 vladimir.oltean@nxp.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 14 May 2025 21:56:57 +0200 you wrote:
> This driver is susceptible to a form of the bug explained in commit
> c26a2c2ddc01 ("gianfar: Fix TX timestamping with a stacked DSA driver")
> and in Documentation/networking/timestamping.rst section "Other caveats
> for MAC drivers", specifically it timestamps any skb which has
> SKBTX_HW_TSTAMP, and does not consider if timestamping has been enabled
> in adapter->hwtstamp_config.tx_type.
> 
> [...]

Here is the summary with links:
  - [net,v2] tsnep: fix timestamping with a stacked DSA driver
    https://git.kernel.org/netdev/net/c/b3ca9eef6646

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



