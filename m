Return-Path: <netdev+bounces-59211-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D44E819E10
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 12:30:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEC7828AD33
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 11:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27CC521374;
	Wed, 20 Dec 2023 11:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IIA68s/0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06EC91DFE7;
	Wed, 20 Dec 2023 11:30:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8006FC433CC;
	Wed, 20 Dec 2023 11:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703071823;
	bh=jGs8fvqIvPHxe9ticGgz2ZJC1iFH9Jgyqjbpp+xZufk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IIA68s/0NIXvoLtoZizGk86/lW0rKIpKMsIwqYnCJK/L75SVhRtrqfxk6C56+MXp2
	 LMI83I3e0BkiXBDUgaiNRIavxTl6x0iIS8cli9OaBgU4+PsnRpDGVSyocPJAnHa6b+
	 g4W/KXdQRPCR4jAi6vrzeQpUYaPjJ2kBhDzab4POqXCF+qTEPXVrofEiHOnlDwPCzP
	 Q+uvsiqcRF4DK24x2TWquCfI4uA05UxbLkzMuYA+t7DcRNes2vO55bZzIR2hVMR7SZ
	 jq40ATMGVYKkOE6sego0nALG1YT47sDrlcCY9Q511QS3aNY4E7mjHLPN+U1xlPDPY9
	 6g3KDdLFPmWoA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 675F6D8C983;
	Wed, 20 Dec 2023 11:30:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 1/1] net: stmmac: fix incorrect flag check in timestamp
 interrupt
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170307182341.15860.4221212163118330561.git-patchwork-notify@kernel.org>
Date: Wed, 20 Dec 2023 11:30:23 +0000
References: <1702885892-30369-1-git-send-email-jun.ann.lai@intel.com>
In-Reply-To: <1702885892-30369-1-git-send-email-jun.ann.lai@intel.com>
To: Lai Peter Jun Ann <jun.ann.lai@intel.com>
Cc: alexandre.torgue@foss.st.com, joabreu@synopsys.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 yoong.siang.song@intel.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 18 Dec 2023 15:51:32 +0800 you wrote:
> The driver should continue get the timestamp if STMMAC_FLAG_EXT_SNAPSHOT_EN
> flag is set.
> 
> Fixes: aa5513f5d95f ("net: stmmac: replace the ext_snapshot_en field with a flag")
> Cc: <stable@vger.kernel.org> # 6.6
> Signed-off-by: Song Yoong Siang <yoong.siang.song@intel.com>
> Signed-off-by: Lai Peter Jun Ann <jun.ann.lai@intel.com>
> 
> [...]

Here is the summary with links:
  - [net,v2,1/1] net: stmmac: fix incorrect flag check in timestamp interrupt
    https://git.kernel.org/netdev/net/c/bd7f77dae695

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



