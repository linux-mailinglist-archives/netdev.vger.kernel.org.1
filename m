Return-Path: <netdev+bounces-15616-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 437A3748B9D
	for <lists+netdev@lfdr.de>; Wed,  5 Jul 2023 20:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 000B92810D7
	for <lists+netdev@lfdr.de>; Wed,  5 Jul 2023 18:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46A5C14A8D;
	Wed,  5 Jul 2023 18:20:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5041428B
	for <netdev@vger.kernel.org>; Wed,  5 Jul 2023 18:20:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 08F3BC433C7;
	Wed,  5 Jul 2023 18:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688581221;
	bh=JamJjeCCkOl0qbFxmtmzV9hb2vvVrB1vx3JFpdV8h7Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=G8cOetNb+diIwOS8l11Vp7QJLP960UCtIQxIslSHQe+0L7f2naXT8OuKUAjCO2Hnd
	 Wve0WEmh2V7nKJq6nrH1io1U1jArvTWR/ZZD+cDUZLisRJ83PhdFySljdEqtO5gn3M
	 /gk6QwS2NIGNNHnyBdp0t+no1yeA2r/WGWgOF4/H80Z54auL1jm9FSkTyMk7YxdglN
	 G2UAWOJMveeDbLVsbNsAVTBV01mPYLK9YWf2V8joQO3qopGVm5ayctVL3eyt63z+pH
	 CKcieW+TjBBZs/0Qp9UKlTob7fSkBiK9nnbPZTp9e0/kbRRBh8JqX16rfeFIPWvWsb
	 nvKmnKN8+nctA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DF0B7C395C5;
	Wed,  5 Jul 2023 18:20:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] nfp: clean mc addresses in application firmware when
 closing port
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168858122090.23406.18329773090141093446.git-patchwork-notify@kernel.org>
Date: Wed, 05 Jul 2023 18:20:20 +0000
References: <20230705052818.7122-1-louis.peens@corigine.com>
In-Reply-To: <20230705052818.7122-1-louis.peens@corigine.com>
To: Louis Peens <louis.peens@corigine.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 jacob.e.keller@intel.com, simon.horman@corigine.com,
 yinjun.zhang@corigine.com, netdev@vger.kernel.org, stable@vger.kernel.org,
 oss-drivers@corigine.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  5 Jul 2023 07:28:18 +0200 you wrote:
> From: Yinjun Zhang <yinjun.zhang@corigine.com>
> 
> When moving devices from one namespace to another, mc addresses are
> cleaned in software while not removed from application firmware. Thus
> the mc addresses are remained and will cause resource leak.
> 
> Now use `__dev_mc_unsync` to clean mc addresses when closing port.
> 
> [...]

Here is the summary with links:
  - [net,v3] nfp: clean mc addresses in application firmware when closing port
    https://git.kernel.org/netdev/net/c/cc7eab25b1cf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



