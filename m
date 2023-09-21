Return-Path: <netdev+bounces-35402-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E827A94D1
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 15:30:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1736B20A03
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 13:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A8CDB660;
	Thu, 21 Sep 2023 13:30:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B47B641
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 13:30:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E02FDC4E69D;
	Thu, 21 Sep 2023 13:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695303023;
	bh=BShjIpWFgvjzflUn62NaxZ6MDAEEhkSaVZ7cY6t6rjA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=shhEZbcKGWeQhMG5HRq+S9IpMyvRM7wIhcISX5noLYk1op64ASw0TLhkS+87OPRQG
	 kKa0n2mOLdIR7yI0S774TCxfAMK58OLHYUDKGmHkQRSvcFsdTCVx6xIeTtMfky7XVK
	 GHMdBfahpRgUFZvH3KdY7Fu+A6S/Pwox/uUXEXsXNRCE0sUxoDCBPeU6WZ6x/RmlHh
	 rcPqo2NdNKbRem8E6QyOjgQgmFWFMWE+KxxH+FaMioiF74+PTSrqf1phWmMZG8ULAD
	 Od9AyD4TahLGB5CzA8EAdkAYYPIHJHvj9LpQpOiZtcWfdxJl3nEDLPegU/oFAPAmlG
	 imJ7aOgHDJVPw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C1D3DE11F40;
	Thu, 21 Sep 2023 13:30:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] netdev: Remove unneeded semicolon
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169530302378.11910.7112501445541140613.git-patchwork-notify@kernel.org>
Date: Thu, 21 Sep 2023 13:30:23 +0000
References: <20230919010305.120991-1-yang.lee@linux.alibaba.com>
In-Reply-To: <20230919010305.120991-1-yang.lee@linux.alibaba.com>
To: Yang Li <yang.lee@linux.alibaba.com>
Cc: arkadiusz.kubalewski@intel.com, jiri@resnulli.us, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, abaci@linux.alibaba.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 19 Sep 2023 09:03:05 +0800 you wrote:
> ./drivers/dpll/dpll_netlink.c:847:3-4: Unneeded semicolon
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=6605
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  drivers/dpll/dpll_netlink.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [net-next] netdev: Remove unneeded semicolon
    https://git.kernel.org/netdev/net-next/c/f20161cf5165

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



