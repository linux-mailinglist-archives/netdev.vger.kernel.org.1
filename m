Return-Path: <netdev+bounces-33540-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D98FA79E6C6
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 13:30:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA8891C20F7C
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 11:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41EDA1EA7B;
	Wed, 13 Sep 2023 11:30:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31B123A0
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 11:30:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 62B12C433C9;
	Wed, 13 Sep 2023 11:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694604626;
	bh=vGLdx5+miv3NaNp5Z9q4gW7vd3yb9KGxDb7lNKkksUo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TSl5dN2LZeaw5ofwWJ8612g0A1bu/lm98JFYKLW+ef7W3GyAYahUs4hN8ydaxgMky
	 wjpeb9ctJpU3GFRZUO2Q+DAG52DWqfJgMjlmoExdQPXi7dvu0YsnI7qHIMkh2R5x1n
	 DQRI2OGtAPiAs2g6mopa3AHerx0cDxmUHoNJMfbX+NnLNXI+hhfZS8mrFOkyajHsDr
	 x6ePXDAbbprYhZ2Z6eK5x68u9FBZmj5iHGh7kO4LctNa9HOqV/NdPtO5ICvUBS7KsW
	 5IY3Ik4n62UjRLO0ZDqQ9q8I6QcLEQSSPgIjDlEBItjCb6dLY2m4v8jnnIUVC/5VIW
	 fgWVAOdmZX0fg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 41202E1C281;
	Wed, 13 Sep 2023 11:30:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ixgbe: fix timestamp configuration code
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169460462626.4298.16639828880343505002.git-patchwork-notify@kernel.org>
Date: Wed, 13 Sep 2023 11:30:26 +0000
References: <20230911202814.147456-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20230911202814.147456-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, vadim.fedorenko@linux.dev,
 richardcochran@gmail.com, horms@kernel.org, himasekharx.reddy.pucha@intel.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 11 Sep 2023 13:28:14 -0700 you wrote:
> From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> 
> The commit in fixes introduced flags to control the status of hardware
> configuration while processing packets. At the same time another structure
> is used to provide configuration of timestamper to user-space applications.
> The way it was coded makes this structures go out of sync easily. The
> repro is easy for 82599 chips:
> 
> [...]

Here is the summary with links:
  - [net] ixgbe: fix timestamp configuration code
    https://git.kernel.org/netdev/net/c/3c44191dd76c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



