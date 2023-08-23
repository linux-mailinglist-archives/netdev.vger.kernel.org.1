Return-Path: <netdev+bounces-29827-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65414784DD0
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 02:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96A191C20BE4
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 00:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 958C57E2;
	Wed, 23 Aug 2023 00:30:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4899467
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 00:30:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AC19DC433C8;
	Wed, 23 Aug 2023 00:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692750624;
	bh=l0YbjJs5wyjixEzaeMbv0RgDnjIGBQnU9AsseY79hD4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=f1giVuoxrHY/ktKP1c147jNMzOu/o2edU6a3Fxk1qkP4+N0q1sBBeQSXFr2LYtNGL
	 pL0FKwjqbokdR981YMEeM1QcTS5EI/vYttRXVOmizZCe1n+NzyO3tJZzHnCp+FZfjK
	 WdlS1IV19GO3Oxf8Ox99MS6m9q2LE22uvHjZ1dKeQoTmuX8XNFVgqAGvAQ0r+RWBfq
	 HYMYeh+9D4DtN5SEcQ+sBXcuNjaZLLkqg5pu5tXj+HvvXdMB0W0jeL5lmDgF9G5ZXt
	 dqbYlX5Wx4E6ID4I941r0UC4Tp/3aqMRZ+H3q9es3qBABu/hnhBm0yLWeQeyaAe0My
	 8hCKQbZ1SXCKw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8420DE4EAF6;
	Wed, 23 Aug 2023 00:30:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/3][pull request] Intel Wired LAN Driver Updates
 2023-08-21 (ice)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169275062453.22438.487121524647202060.git-patchwork-notify@kernel.org>
Date: Wed, 23 Aug 2023 00:30:24 +0000
References: <20230821171633.2203505-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20230821171633.2203505-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Mon, 21 Aug 2023 10:16:30 -0700 you wrote:
> This series contains updates to ice driver only.
> 
> Jesse fixes an issue on calculating buffer size.
> 
> Petr Oros reverts a commit that does not fully resolve VF reset issues
> and implements one that provides a fuller fix.
> 
> [...]

Here is the summary with links:
  - [net,1/3] ice: fix receive buffer size miscalculation
    https://git.kernel.org/netdev/net/c/10083aef7840
  - [net,2/3] Revert "ice: Fix ice VF reset during iavf initialization"
    https://git.kernel.org/netdev/net/c/0ecff05e6c59
  - [net,3/3] ice: Fix NULL pointer deref during VF reset
    https://git.kernel.org/netdev/net/c/67f6317dfa60

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



