Return-Path: <netdev+bounces-45876-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 998FD7DFFF8
	for <lists+netdev@lfdr.de>; Fri,  3 Nov 2023 10:20:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34B3AB2136E
	for <lists+netdev@lfdr.de>; Fri,  3 Nov 2023 09:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D175111AB;
	Fri,  3 Nov 2023 09:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sqB2O09b"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B39B8C05
	for <netdev@vger.kernel.org>; Fri,  3 Nov 2023 09:20:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AD109C433CB;
	Fri,  3 Nov 2023 09:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699003223;
	bh=89TbsSiluHz4CNriX3OAzekwzCM5uTxxSUvf2oTXa34=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sqB2O09bxp2xTGfqpa2Q9qJPPULBI/7K6WKuSLhdxJKrPxI31or3SZlsGvKoJo/gj
	 5xxu5L76j/JxVLRDC2phsoGH5WQeNGwAYjkA3KHOvEWB5ie4mRAdl1PiPSXNWuReGr
	 Pp4uZzL8vDEKgRJbbjhKyG2phH2YCeR+Lw1587PYYnsT8e0/+5SEMjabOuoE0jEwLn
	 n1n4iufPu78h20j1ZCLQ9U/s7q8YxgK6khG7P+jyXlMyEMJwtdkAytRyCi9gFa47RP
	 B9aCBFs9OuaVFRNlDz2FfrbUddqh3x23kgPKNlE16sKufO0FTYi/D685q3khINa0v1
	 ZZaH7/HlwjBtw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 89DC0E00088;
	Fri,  3 Nov 2023 09:20:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] net: stmmac: xgmac: Enable support for multiple
 Flexible PPS outputs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169900322356.11636.3563922436510557327.git-patchwork-notify@kernel.org>
Date: Fri, 03 Nov 2023 09:20:23 +0000
References: <20231031022729.2347871-1-0x1207@gmail.com>
In-Reply-To: <20231031022729.2347871-1-0x1207@gmail.com>
To: Furong Xu <0x1207@gmail.com>
Cc: davem@davemloft.net, alexandre.torgue@foss.st.com, joabreu@synopsys.com,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, jpinto@synopsys.com, horms@kernel.org,
 fancer.lancer@gmail.com, jacob.e.keller@intel.com, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 xfr@outlook.com, rock.xu@nio.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 31 Oct 2023 10:27:29 +0800 you wrote:
> From XGMAC Core 3.20 and later, each Flexible PPS has individual PPSEN bit
> to select Fixed mode or Flexible mode. The PPSEN must be set, or it stays
> in Fixed PPS mode by default.
> XGMAC Core prior 3.20, only PPSEN0(bit 4) is writable. PPSEN{1,2,3} are
> read-only reserved, and they are already in Flexible mode by default, our
> new code always set PPSEN{1,2,3} do not make things worse ;-)
> 
> [...]

Here is the summary with links:
  - [net,v3] net: stmmac: xgmac: Enable support for multiple Flexible PPS outputs
    https://git.kernel.org/netdev/net/c/db456d90a4c1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



