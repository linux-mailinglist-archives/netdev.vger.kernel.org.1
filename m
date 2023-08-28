Return-Path: <netdev+bounces-30981-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 126AA78A580
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 08:10:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E7061C20442
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 06:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DAB5A4D;
	Mon, 28 Aug 2023 06:10:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE46A2C
	for <netdev@vger.kernel.org>; Mon, 28 Aug 2023 06:10:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 044BEC433C8;
	Mon, 28 Aug 2023 06:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693203022;
	bh=YSD34U9HLx/wXNqtoDrWKl9l+3hnZR/njNrMuHDK4Rg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NQ0zuRmsuCh58l10aVKcXUf/DfSCCZ2FBphkCS0+oEpX0LkehiP8Z8/O43vCjgo5P
	 njbN1SteUI1PMQGLjlM73Ktx18oiR5o/GeY/yi3xen2WdVLUtbr2Wbsop1KeGc58tv
	 KsxJK6tfCSrDtkgFXiHNXM4TA18NFbRbsqaXzItC8k+cPzUEkawTzUbEsgvQBKhlGc
	 FLN51p5oMQPRzuJBWd1/AWDO2DIML+wBPy+WsqOKI4VMNzFZ7vgN4LU0GARy1KaBWy
	 /e8S1JKuJ1KV+wpF/7vGIzP7U/7RsO845anOJdV3LDPAuUra3TRBUFkVbQDQfaSFmQ
	 A9AXRhgaCGg2w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E1431E33081;
	Mon, 28 Aug 2023 06:10:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] igb: set max size RX buffer when store bad packet is
 enabled
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169320302191.19170.10006129327745919806.git-patchwork-notify@kernel.org>
Date: Mon, 28 Aug 2023 06:10:21 +0000
References: <20230824204619.1551135-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20230824204619.1551135-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, radoslawx.tyl@intel.com,
 greearb@candelatech.com, jesse.brandeburg@intel.com, stable@vger.kernel.org,
 manfred.rudigier@omicronenergy.com, arpanax.arland@intel.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 24 Aug 2023 13:46:19 -0700 you wrote:
> From: Radoslaw Tyl <radoslawx.tyl@intel.com>
> 
> Increase the RX buffer size to 3K when the SBP bit is on. The size of
> the RX buffer determines the number of pages allocated which may not
> be sufficient for receive frames larger than the set MTU size.
> 
> Cc: stable@vger.kernel.org
> Fixes: 89eaefb61dc9 ("igb: Support RX-ALL feature flag.")
> Reported-by: Manfred Rudigier <manfred.rudigier@omicronenergy.com>
> Signed-off-by: Radoslaw Tyl <radoslawx.tyl@intel.com>
> Tested-by: Arpana Arland <arpanax.arland@intel.com> (A Contingent worker at Intel)
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> 
> [...]

Here is the summary with links:
  - [net] igb: set max size RX buffer when store bad packet is enabled
    https://git.kernel.org/netdev/net/c/bb5ed01cd242

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



