Return-Path: <netdev+bounces-215676-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E388B2FDD9
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 17:11:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1887064205D
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 15:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3FFA2F6194;
	Thu, 21 Aug 2025 15:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EhfYON2T"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4882E716A;
	Thu, 21 Aug 2025 15:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755788405; cv=none; b=lHPPGxgQfupxCuQ+PlYoP1UUSm079l56tJEmpEcWlg2p63ev6T52Hm4IEIn+R4TW0liBOtsd3bxwZ6mx/KNtqSmnrCYIuUj277b5vlgPM3h0CA38RrimL0YCPMgwtGVybUAN6AvxfznsfmqjuoIzTVjI2hkF6SsD4lcRGnUcidY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755788405; c=relaxed/simple;
	bh=wmGjbKJzF1CskCjy/nqXr4k75IK4LsALd4FCJijvRUo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PXh6j547YVQQWATjsSn6gl2Tbyn/BtZVug6EZpWYloOXMlBD7mTw8roRbb8XqobHJKIZFR0BY2J4OayrbWb6pmcm/XxYCumvQngmOV/rJaHbuPZE9q0lGX25I6TAqTwZUTsnNOATKr4oty8FSzcPGxUIxAUi5C+FkWF5aDvic1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EhfYON2T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7C8CC4CEF4;
	Thu, 21 Aug 2025 15:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755788405;
	bh=wmGjbKJzF1CskCjy/nqXr4k75IK4LsALd4FCJijvRUo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EhfYON2TvdZVmCjRiDQADenq81FCAA8v3JQZQw/0jC5slz2I2ZixC1VAkQDzi1u+D
	 zSNB8EEDLDywIqvLWwq3uomhHsHyJkLrAyr3wHUbJJv19fr7D2cMtVuUKva3RxqHtJ
	 VSnztmFFjzDxhlS1GmJGq4PqmAATL9OiLdIk0L1q+fEh3kuwt/q9En67HdsCbmZKtV
	 n2Vdxhrqu9JO4dgNXobJlD+8E91eba/Aqv/uXHrlgfreq3XA28mYdzX24Mf0jShkfW
	 V+wcM7uOEhd/ul57geqx3KdcrxAKoIRmLUVl4BZgjd8prwP4YZ111Ifbgdl3lmNemp
	 rwHXXTC4dbkKw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E3C383BF5C;
	Thu, 21 Aug 2025 15:00:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net PatchV2] Octeontx2-af: Skip overlap check for SPI field
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175578841101.1075387.4122901286206850392.git-patchwork-notify@kernel.org>
Date: Thu, 21 Aug 2025 15:00:11 +0000
References: <20250820063919.1463518-1-hkelam@marvell.com>
In-Reply-To: <20250820063919.1463518-1-hkelam@marvell.com>
To: Hariprasad Kelam <hkelam@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 sgoutham@marvell.com, lcherian@marvell.com, gakula@marvell.com,
 jerinj@marvell.com, sbhatta@marvell.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, rkannoth@marvell.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 20 Aug 2025 12:09:18 +0530 you wrote:
> Octeontx2/CN10K silicon supports generating a 256-bit key per packet.
> The specific fields to be extracted from a packet for key generation
> are configurable via a Key Extraction (MKEX) Profile.
> 
> The AF driver scans the configured extraction profile to ensure that
> fields from upper layers do not overwrite fields from lower layers in
> the key.
> 
> [...]

Here is the summary with links:
  - [net,PatchV2] Octeontx2-af: Skip overlap check for SPI field
    https://git.kernel.org/netdev/net/c/8c5d95988c34

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



