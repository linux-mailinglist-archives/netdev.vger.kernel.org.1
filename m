Return-Path: <netdev+bounces-23608-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D85376CB47
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 12:51:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB591281C9E
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 10:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DAEE5681;
	Wed,  2 Aug 2023 10:50:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC09453AD
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 10:50:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 77599C433CA;
	Wed,  2 Aug 2023 10:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690973422;
	bh=59ysNhABi4us3vvJSqXrfPwM766CiEebPgaHbS/7DnE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nUE5N91JoB3NaNaxWeJw8xClD/334A9y7TH9NqCnPyQI9xqBOKxZB/dbfqfOCvfz8
	 e0NAVAwvrva7I1HlF+f4KxdMrEG56AUPvHxtWF2PalOGAZRwaa7iQfsqng2BNbV2kT
	 QYZXvzwj/v/U/y2odtXOhQJ1w5SYRl9C1p3pyg8H8WNxbHdAYqS6bJiT04fUWkgKWq
	 3DixT/2ha7y9Nhz5tSyY1+VQ5bQgeFQTeHTJ8HTAXLD4VuF8FSV26WyBOEjGSLLnG0
	 n0TYJcOTtVzYckl75Vt/KyiBZ1MMoMhLcmFN8JzPMDgTUlfoplmE8Ig3/+4oCM2lIF
	 DFxI7Ddr5aHfg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5BC79C691E4;
	Wed,  2 Aug 2023 10:50:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: fman: Remove duplicated include in mac.c
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169097342237.23292.2254772671647186328.git-patchwork-notify@kernel.org>
Date: Wed, 02 Aug 2023 10:50:22 +0000
References: <20230802005639.88395-1-yang.lee@linux.alibaba.com>
In-Reply-To: <20230802005639.88395-1-yang.lee@linux.alibaba.com>
To: Yang Li <yang.lee@linux.alibaba.com>
Cc: madalin.bucur@nxp.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, sean.anderson@seco.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, abaci@linux.alibaba.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed,  2 Aug 2023 08:56:39 +0800 you wrote:
> ./drivers/net/ethernet/freescale/fman/mac.c: linux/of_platform.h is included more than once.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=6039
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: fman: Remove duplicated include in mac.c
    https://git.kernel.org/netdev/net-next/c/34093c9fa05d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



