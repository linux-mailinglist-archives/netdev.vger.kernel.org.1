Return-Path: <netdev+bounces-13761-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32C1B73CD4C
	for <lists+netdev@lfdr.de>; Sun, 25 Jun 2023 00:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0524E1C20841
	for <lists+netdev@lfdr.de>; Sat, 24 Jun 2023 22:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBEF7EAEB;
	Sat, 24 Jun 2023 22:40:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515FF2908
	for <netdev@vger.kernel.org>; Sat, 24 Jun 2023 22:40:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A0DA9C433C8;
	Sat, 24 Jun 2023 22:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687646424;
	bh=+zDIVy3A7ptcHOWOguXHNkp03+Oc1060XVZsvtNqooc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Gth89sq76mjs7JJ7a8U7B7+gsOBVbn49sCC1EPmeA1nFRqjXiG4YmmCr/VsunGpdX
	 gypv14gB+1g8UIhPdKJVVV54q6L9nniWxmtDXHOyPXTWLqm/uIR4jcxBv6NY1Rp4x6
	 nsqv/NKRKRk97ybIKEA2WGeJVV4LTVYmqjb6ieR+JGC+3CoXeXXaS6RGPHAuHm86cf
	 Mcopr/xVJrCmwZ0p1vTySXe2DPOdYqvmnlb+FSZw8Nli35tg2Eo6snQiWzgZSqB6kC
	 m0EkLwPbYCsz1D+0wRl0kHoR1nMipbxVOggjuZ+BDKOy0HKdeUQhCq032dxKrjaX9m
	 5gnoPxIw+1x6A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 85732E26D3E;
	Sat, 24 Jun 2023 22:40:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/6][pull request] Intel Wired LAN Driver Updates
 2023-06-22 (ice)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168764642454.414.14623675827804261424.git-patchwork-notify@kernel.org>
Date: Sat, 24 Jun 2023 22:40:24 +0000
References: <20230622183601.2406499-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20230622183601.2406499-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Thu, 22 Jun 2023 11:35:55 -0700 you wrote:
> This series contains updates to ice driver only.
> 
> Jake adds a slight wait on control queue send to reduce wait time for
> responses that occur within normal times.
> 
> Maciej allows for hot-swapping XDP programs.
> 
> [...]

Here is the summary with links:
  - [net-next,1/6] ice: reduce initial wait for control queue messages
    https://git.kernel.org/netdev/net-next/c/a734c43caa4d
  - [net-next,2/6] ice: allow hot-swapping XDP programs
    https://git.kernel.org/netdev/net-next/c/469748429ac8
  - [net-next,3/6] ice: clean up freeing SR-IOV VFs
    https://git.kernel.org/netdev/net-next/c/f98277479ad8
  - [net-next,4/6] ice: remove null checks before devm_kfree() calls
    https://git.kernel.org/netdev/net-next/c/ad667d626825
  - [net-next,5/6] ice: Remove managed memory usage in ice_get_fw_log_cfg()
    https://git.kernel.org/netdev/net-next/c/1dacc49782e6
  - [net-next,6/6] ice: use ice_down_up() where applicable
    https://git.kernel.org/netdev/net-next/c/b7a034572338

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



