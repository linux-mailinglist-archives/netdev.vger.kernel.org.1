Return-Path: <netdev+bounces-29963-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0ED9785612
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 12:50:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F20FD1C20A12
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 10:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59D6DA944;
	Wed, 23 Aug 2023 10:50:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092BB4C75
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 10:50:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7E29AC433C9;
	Wed, 23 Aug 2023 10:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692787822;
	bh=5Mes//D/y7x5YeJ2YfzmT66TD1rKTdHk6q4GAG7RlFA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dRuO2SXQDqJux1C3Xr/JcevXe/6R8pOGpy3mre0WFXDKTA1Qgr1t+yrsTDP7CjT4v
	 r/HgJ3pHOfw2J4NIUgC67GN61bdeQ4LgSFr8rIKrClafPtY7+vj4RuTGZ+KwZ/qeKF
	 5p+16gp6eCkifRackvxQ0TahT8T7ByDVQWHYP+/kNGkhnrDnVCbd0AUG6UU3919MYR
	 r/KNsZHq3L1fWHCJ+hsGOnYmr4Z7Sq6UD9aTl77yHKaWKVNgYGTvodgQJpAADMp8VJ
	 cJUyM9MjNLHx4WoaAiUmjFyIVKrTYH7IFCqwGF6wYofJYaaIdax2OjmXpGSNOkdbhu
	 JbW6njCCS/pJA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 62C40C395C5;
	Wed, 23 Aug 2023 10:50:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] i40e: fix potential NULL pointer dereferencing of pf->vf
 i40e_sync_vsi_filters()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169278782239.755.1103948738320997717.git-patchwork-notify@kernel.org>
Date: Wed, 23 Aug 2023 10:50:22 +0000
References: <20230822221653.2988800-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20230822221653.2988800-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, andrii.staikov@intel.com,
 aleksandr.loktionov@intel.com, rafal.romanowski@intel.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 22 Aug 2023 15:16:53 -0700 you wrote:
> From: Andrii Staikov <andrii.staikov@intel.com>
> 
> Add check for pf->vf not being NULL before dereferencing
> pf->vf[vsi->vf_id] in updating VSI filter sync.
> Add a similar check before dereferencing !pf->vf[vsi->vf_id].trusted
> in the condition for clearing promisc mode bit.
> 
> [...]

Here is the summary with links:
  - [net] i40e: fix potential NULL pointer dereferencing of pf->vf i40e_sync_vsi_filters()
    https://git.kernel.org/netdev/net/c/9525a3c38acc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



