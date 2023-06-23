Return-Path: <netdev+bounces-13248-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D557273AEC9
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 04:51:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A55A1C20CB5
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 02:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 682F47FC;
	Fri, 23 Jun 2023 02:50:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44ED081A
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 02:50:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 93D72C43395;
	Fri, 23 Jun 2023 02:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687488626;
	bh=RYWIseovJkUE0huNESokXHr21wlELifchM8iOeOWkF0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ee29H9PIQYlUqNeAHZc/T/Al+WwoCwXXM3y/e66yRhsrlA5HFROEX7RB8Pu+d5RVq
	 M5pShpeGZwuEQlF2TY2BL4S29iOx+pf/of5ae5pFycs9015PbpAC2Q9o92eO20hLLK
	 pLjcYwPucoQoKWLNTZLStrb+iaHTm57RNKCEFE4H0UAjLU4Nuz7s0IM0uQvRnWFX8Q
	 SjNIrklY9AuV2DxkDXpReSwc2GC28yQ2C9zyZwSTsnwUQWcTAR12RzJJJPmaowk+g2
	 EkVazOMyYp9wG0pWfgLygEgV8Ewfa7caMJ2IruahUrxWuMI3NITVQwgiU8sEO4s342
	 0rn1jKJSLndfQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 75236C73FE1;
	Fri, 23 Jun 2023 02:50:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next,v2] net: txgbe: remove unused buffer in
 txgbe_calc_eeprom_checksum
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168748862647.32034.11429198935514942292.git-patchwork-notify@kernel.org>
Date: Fri, 23 Jun 2023 02:50:26 +0000
References: <20230620062519.1575298-1-shaozhengchao@huawei.com>
In-Reply-To: <20230620062519.1575298-1-shaozhengchao@huawei.com>
To: Zhengchao Shao <shaozhengchao@huawei.com>
Cc: netdev@vger.kernel.org, jiawenwu@trustnetic.com,
 mengyuanlou@net-swift.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, weiyongjun1@huawei.com,
 yuehaibing@huawei.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 20 Jun 2023 14:25:19 +0800 you wrote:
> Half a year passed since commit 049fe5365324c ("net: txgbe: Add operations
> to interact with firmware") was submitted, the buffer in
> txgbe_calc_eeprom_checksum was not used. So remove it and the related
> branch codes.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202306200242.FXsHokaJ-lkp@intel.com/
> Reviewed-by: Jiawen Wu <jiawenwu@trustnetic.com>
> Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: txgbe: remove unused buffer in txgbe_calc_eeprom_checksum
    https://git.kernel.org/netdev/net-next/c/2a441a3dbe84

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



