Return-Path: <netdev+bounces-38341-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B6E7BA759
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 19:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id A267D281D36
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 17:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DACF38BC9;
	Thu,  5 Oct 2023 17:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bym4dprE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F48D374EC
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 17:10:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id ADDA5C433C7;
	Thu,  5 Oct 2023 17:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696525826;
	bh=36T1prB9ftYffh8WkVtwycerEJLsnnVP4/TkG8dwIHE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bym4dprECdnIy7C847dR/Wh32xRzSOMqPCZJLVb8BjqO39YutsknXnQa+s1DaHnta
	 mhvWOqR0pPcCq1HR/tvnkVNls9irDW/XE41Zd51UzdTV7O40/Q/tINrk/JX9RMK/gc
	 1+R1NjsuUBbajfPK+vUFhffV1X89yv0iOnxUCMoNaq6ePogu3yrde/4ILJXl8q/Nwm
	 u7bebBR1XeWmzDVuOY333mQuPeFEZM3HEJUvLSBSd2Gybwc8IvdPXjPeQmij8lAGkl
	 BKVBQyw3W3qCfarWZ1cvACfDt/S60uTNA5Df6pe9oq/sMjj1Fi75e2dfxP0Dyeqoiv
	 KyWjv2WioRFVg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 86D52E632D1;
	Thu,  5 Oct 2023 17:10:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2] ila: fix array overflow warning
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169652582654.14539.15332920646748657401.git-patchwork-notify@kernel.org>
Date: Thu, 05 Oct 2023 17:10:26 +0000
References: <20231004170258.25575-1-stephen@networkplumber.org>
In-Reply-To: <20231004170258.25575-1-stephen@networkplumber.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org

Hello:

This patch was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Wed,  4 Oct 2023 10:02:58 -0700 you wrote:
> Aliasing a 64 bit value seems to confuse Gcc 12.2.
> ipila.c:57:32: warning: ‘addr’ may be used uninitialized [-Wmaybe-uninitialized]
> 
> Use a union instead.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> 
> [...]

Here is the summary with links:
  - [iproute2] ila: fix array overflow warning
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=beb5d379e19f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



