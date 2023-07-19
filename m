Return-Path: <netdev+bounces-18794-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79FE5758A8E
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 03:01:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 360812818FE
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 01:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B6FECA;
	Wed, 19 Jul 2023 01:00:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E4515C1
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 01:00:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 45A7FC43391;
	Wed, 19 Jul 2023 01:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689728423;
	bh=72O/TWpnlTh0mOCA4CEYUOrKWpfpjuQE6vUbcESsON4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NjuDqYbu5yBe9u05bi4eQ9BcvbIQReTCeuH+gU8KsjfigLfDy4oET4VO4vuOeNN7z
	 AtWXSx11iQYg2EHtCqB6kl3Tu7dVltZWwMgcVmCaFrpbqNbBqtNKaoUYJ5XE/MgAdc
	 rjDUW23FQVYeRYUSQcaM6JlX0UUlcH8RgkJW44p2/uVJj5TwJD6jFjhCouQoH8WQeu
	 7DKVxLopOKMRkn1ho3gLwdB4kAyuKT5lQg+jqEo4wIn+j5UwPLWAnJZ6ExOD3zdSKs
	 18sj5OJu9Kxt6sGVxeEHK+8R4wzs20UDGtofO88ILLxnYp/5X2uPW4ktQn485FS7IF
	 KVGUvy3wacT5Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 28A28C64458;
	Wed, 19 Jul 2023 01:00:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4] net: txgbe: change LAN reset mode
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168972842315.21294.3579061949063620403.git-patchwork-notify@kernel.org>
Date: Wed, 19 Jul 2023 01:00:23 +0000
References: <20230717021333.94181-1-jiawenwu@trustnetic.com>
In-Reply-To: <20230717021333.94181-1-jiawenwu@trustnetic.com>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, simon.horman@corigine.com,
 mengyuanlou@net-swift.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 17 Jul 2023 10:13:33 +0800 you wrote:
> The old way to do LAN reset is sending reset command to firmware. Once
> firmware performs reset, it reconfigures what it needs.
> 
> In the new firmware versions, veto bit is introduced for NCSI/LLDP to
> block PHY domain in LAN reset. At this point, writing register of LAN
> reset directly makes the same effect as the old way. And it does not
> reset MNG domain, so that veto bit does not change.
> 
> [...]

Here is the summary with links:
  - [net-next,v4] net: txgbe: change LAN reset mode
    https://git.kernel.org/netdev/net-next/c/9843814fc651

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



