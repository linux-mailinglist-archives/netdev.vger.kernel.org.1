Return-Path: <netdev+bounces-43172-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A37D97D1A42
	for <lists+netdev@lfdr.de>; Sat, 21 Oct 2023 03:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 476522826FF
	for <lists+netdev@lfdr.de>; Sat, 21 Oct 2023 01:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 655BF657;
	Sat, 21 Oct 2023 01:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nu5c44zh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49471654
	for <netdev@vger.kernel.org>; Sat, 21 Oct 2023 01:20:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C3309C433C9;
	Sat, 21 Oct 2023 01:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697851222;
	bh=K+QqKg5XmpNKj22Pg+sw+LAJMCY310atdtuOddvhuls=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nu5c44zhTs/hfFz9S1wCvtVb9HF1xrWHCMbCTziknXG8jU9q7uMaZBnEVW74hQEF8
	 Y+GYI7UYNmNQaSBPYBE6LwGkvObcswdIC3AsVh2gkR9j2UOCT2k1wuFMIlAUBaPwdU
	 R+cV7c1eJ/Sk65TMV98p/taru8674bh9utPLg4BL3tq8dcouJJhCcaKLu0O3yNmlGL
	 y6NX2+zq7WrkmZW3HO0ZCF2ZegHdhlsyvJCwUHbFDBxKDULPEaeq0s0p8l+IP/k63n
	 wBboTkNwSr5ZyCzooMc4Q1hjOdgv8+O+IX0VVTHuXPAgMIuHQa2utwkzNP0BRNBJEO
	 Op4Hjeub8FR+g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A5807C595D7;
	Sat, 21 Oct 2023 01:20:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] igc: Fix ambiguity in the ethtool advertising
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169785122267.29089.10589419785434237648.git-patchwork-notify@kernel.org>
Date: Sat, 21 Oct 2023 01:20:22 +0000
References: <20231019203641.3661960-1-jacob.e.keller@intel.com>
In-Reply-To: <20231019203641.3661960-1-jacob.e.keller@intel.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 sasha.neftin@intel.com, dima.ruinskiy@intel.com, vitaly.lifshits@intel.com,
 naamax.meir@linux.intel.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 19 Oct 2023 13:36:41 -0700 you wrote:
> From: Sasha Neftin <sasha.neftin@intel.com>
> 
> The 'ethtool_convert_link_mode_to_legacy_u32' method does not allow us to
> advertise 2500M speed support and TP (twisted pair) properly. Convert to
> 'ethtool_link_ksettings_test_link_mode' to advertise supported speed and
> eliminate ambiguity.
> 
> [...]

Here is the summary with links:
  - [net] igc: Fix ambiguity in the ethtool advertising
    https://git.kernel.org/netdev/net/c/e7684d29efdf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



