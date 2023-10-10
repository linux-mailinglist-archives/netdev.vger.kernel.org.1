Return-Path: <netdev+bounces-39493-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C0047BF793
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 11:40:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A26721C20B18
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 09:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8088E17733;
	Tue, 10 Oct 2023 09:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QVRXkPWU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D75B171DB
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 09:40:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 25D84C433CA;
	Tue, 10 Oct 2023 09:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696930824;
	bh=d5GXNWwoNDXNq9hUxuk9GxPSEE/IHXHFL6VyvMeDIvo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QVRXkPWUzCFltimaLELy7wuruoL5hw4jf0oeZnlyvltelKamaJzsHlxuhfO8n6eZN
	 tEJ4FPG6ayQGR9Dyk0ox5mUgGJLOJTBOPOsADgsuTm3gYbmJabiWg9aStcy5jphIgY
	 E4YY/UTsDWqxTPThOdSYVTDvGN3vLVM4qPFu2HESvpvmBX1/rcGvKubX49vYUOZEI0
	 NIi/n7xzRHlGWoPx+Gm+sws/ZV38kyj4t+NUJ/RpiqXL3cusMT6rmjoBWE1rw3bKIX
	 p2CJaaY1nbU+xI39k/HCSIKy9jPOz+TwXgExHnDnMEB7hUGOUNzAIfFe+U7bdQlgXh
	 9/1AIPvdJRYMQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 09E68C595C5;
	Tue, 10 Oct 2023 09:40:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] ixgbe: fix crash with empty VF macvlan list
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169693082403.5800.6981451364289759108.git-patchwork-notify@kernel.org>
Date: Tue, 10 Oct 2023 09:40:24 +0000
References: <ZSADNdIw8zFx1xw2@kadam>
In-Reply-To: <ZSADNdIw8zFx1xw2@kadam>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: jesse.brandeburg@intel.com, horms@kernel.org, anthony.l.nguyen@intel.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 jeffrey.t.kirsher@intel.com, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, kernel-janitors@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 6 Oct 2023 15:53:09 +0300 you wrote:
> The adapter->vf_mvs.l list needs to be initialized even if the list is
> empty.  Otherwise it will lead to crashes.
> 
> Fixes: a1cbb15c1397 ("ixgbe: Add macvlan support for VF")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
> v2: Use the correct fixes tag.  Thanks, Simon.
> 
> [...]

Here is the summary with links:
  - [net,v2] ixgbe: fix crash with empty VF macvlan list
    https://git.kernel.org/netdev/net/c/7b5add9af567

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



