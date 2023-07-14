Return-Path: <netdev+bounces-17867-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC1937534F2
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 10:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC8F11C215BF
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 08:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77E09C8FD;
	Fri, 14 Jul 2023 08:20:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD553D2E7
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 08:20:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 339BFC433C9;
	Fri, 14 Jul 2023 08:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689322820;
	bh=T7/zTjGjpHMgiWXm1BGbK/me/hBFsG2ye/GyNLBpbCE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=B2mqiBQzBFy/EEn/WiR61n2LK0RZiQ2B4hSdpBXV/OBDOKFADLuwOCPNLPEV3alhb
	 utAatg/AT6lQU9FP47C9EkGsBOp0yLCoWA5k06Vx8svqmL/k5q8wrq3KVgkM2T+qn2
	 gaLVPtOr1lmb+WGDtyEbHFq+vsol0s4rAAVzObipSVo1x7+dFO8yalXHAIdYp7fSG1
	 61RcWAhPrKQIj89yejOXFRu1C+w4fPv5jAN20I2hT6F5X8Ioa+aNdSjA5nDtz1k1ij
	 drZAPBaYNGVMF6hG1ztYJAf2/mPc6yETcMF3MwRxmUtbdpqAHwTFoR5EuViZUKCfSh
	 LvJouLoNYTePQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1B42EE4508D;
	Fri, 14 Jul 2023 08:20:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v1] net: ethernet: Remove repeating expression
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168932282010.1632.8857195926955967765.git-patchwork-notify@kernel.org>
Date: Fri, 14 Jul 2023 08:20:20 +0000
References: <20230713121633.8190-1-machel@vivo.com>
In-Reply-To: <20230713121633.8190-1-machel@vivo.com>
To: =?utf-8?b?546L5piOLei9r+S7tuW6leWxguaKgOacr+mDqCA8bWFjaGVsQHZpdm8uY29tPg==?=@codeaurora.org
Cc: jiawenwu@trustnetic.com, mengyuanlou@net-swift.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 opensource.kernel@vivo.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 13 Jul 2023 20:16:03 +0800 you wrote:
> Identify issues that arise by using the tests/doublebitand.cocci
> semantic patch. Need to remove duplicate expression in if statement.
> 
> Signed-off-by: Wang Ming <machel@vivo.com>
> ---
>  drivers/net/ethernet/wangxun/libwx/wx_hw.c | 1 -
>  1 file changed, 1 deletion(-)

Here is the summary with links:
  - [net,v1] net: ethernet: Remove repeating expression
    https://git.kernel.org/netdev/net/c/a822551c51f0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



