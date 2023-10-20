Return-Path: <netdev+bounces-43005-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 831AD7D0FC5
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 14:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19504B21384
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 12:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 006F58F5A;
	Fri, 20 Oct 2023 12:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jt066fzO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74071A700
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 12:40:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3956FC433C9;
	Fri, 20 Oct 2023 12:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697805624;
	bh=bvAlV8QrUy/y/VGC2EOuWJy9NvXaSRZz7dTsy1PshrA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Jt066fzOZPnCFTl8YCtPTRXL1VxgI+19npp9nBPVJn1i5abgPd+8A0+QTZFOXMlR2
	 ElCR4Uxz1BOkejkCvSVfUJQ0J2sMzUdv97Vae3Zg7PAFwH+w9DENIp8WMZWdmMw8C/
	 kjPIOGDCZLBkGX+pdvsseZy6hmr+FLjMbvt+TYdhlDBR7+CfcnVfZ8GakztGQnyYLC
	 r97JUznf9YprMKzBUT/yyTk5cRusiRSoSVvG4+zMjd2VYuwSh41A9GIZDAHFOIPAaD
	 bVkqmGYfWs0cH/YVEvS54G5F1opoQWAGIV38KO2CdVTSaB9kLr3uJE6qT1zMmStTcF
	 WhJzkMg9z/Kjg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1F04CC595CE;
	Fri, 20 Oct 2023 12:40:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] igb: Fix potential memory leak in
 igb_add_ethtool_nfc_entry
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169780562412.878.13293480622042284838.git-patchwork-notify@kernel.org>
Date: Fri, 20 Oct 2023 12:40:24 +0000
References: <20231019204035.3665021-1-jacob.e.keller@intel.com>
In-Reply-To: <20231019204035.3665021-1-jacob.e.keller@intel.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 mateusz.palczewski@intel.com, wojciech.drewek@intel.com,
 arpanax.arland@intel.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 19 Oct 2023 13:40:35 -0700 you wrote:
> From: Mateusz Palczewski <mateusz.palczewski@intel.com>
> 
> Add check for return of igb_update_ethtool_nfc_entry so that in case
> of any potential errors the memory alocated for input will be freed.
> 
> Fixes: 0e71def25281 ("igb: add support of RX network flow classification")
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Signed-off-by: Mateusz Palczewski <mateusz.palczewski@intel.com>
> Tested-by: Arpana Arland <arpanax.arland@intel.com> (A Contingent worker at Intel)
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> 
> [...]

Here is the summary with links:
  - [net] igb: Fix potential memory leak in igb_add_ethtool_nfc_entry
    https://git.kernel.org/netdev/net/c/8c0b48e01dab

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



