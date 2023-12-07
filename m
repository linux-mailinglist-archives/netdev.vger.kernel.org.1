Return-Path: <netdev+bounces-54936-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C64E7808F9B
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 19:10:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8115B28163C
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 18:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E6E14D10E;
	Thu,  7 Dec 2023 18:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WUxYdcpk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9094CE1E
	for <netdev@vger.kernel.org>; Thu,  7 Dec 2023 18:10:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E8395C433CD;
	Thu,  7 Dec 2023 18:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701972643;
	bh=J26BJwKNieXZxRG53pLKpiymkMsc2re9G9HyP22wRBQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WUxYdcpkHFr+GxiCWQiNl1IXsvD5loVkqUMd7lIbf5UEZPK5FkrI8ffGosanHf07u
	 IlzY0/r0hUK9kvaRqPxrh23R5scDJC3cffVep2jeTBCctVtCua5/IwLQBdTWJy/LRf
	 LJl+qyTVUe0urQZKmcoQEVwYT8/XxSrLicsaMsY+gLuejee8tHN8JMk93pFhQ27ZKi
	 qHVPpxuPqUash9NTsH+wA0KYm6mt6/UOVEvegADo3rlJdXQugHMx6c9GstvAn+g/Kr
	 DKPnSH7A0nsiT8mVUseAYtl3svPAxEHkkcNzD0Uv+Yavjo8JqAeOM4kSJTOzWyaPc9
	 60U5shA6f0X+w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D3DCAC40C5E;
	Thu,  7 Dec 2023 18:10:42 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: wangxun: fix changing mac failed when running
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170197264286.15422.2253458440493242642.git-patchwork-notify@kernel.org>
Date: Thu, 07 Dec 2023 18:10:42 +0000
References: <20231206095044.17844-1-duanqiangwen@net-swift.com>
In-Reply-To: <20231206095044.17844-1-duanqiangwen@net-swift.com>
To: duanqiangwen <duanqiangwen@net-swift.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, mengyuanlou@net-swift.com,
 jiawenwu@trustnetic.com, davem@davemloft.net, andrew@lunn.ch,
 bhelgaas@google.com, maciej.fijalkowski@intel.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  6 Dec 2023 17:50:44 +0800 you wrote:
> in some bonding mode, service need to change mac when
> netif is running. Wangxun netdev add IFF_LIVE_ADDR_CHANGE
> priv_flag to support it.
> 
> Fixes: 79625f45ca73 ("net: wangxun: Move MAC address handling to libwx")
> 
> Signed-off-by: duanqiangwen <duanqiangwen@net-swift.com>
> 
> [...]

Here is the summary with links:
  - [net] net: wangxun: fix changing mac failed when running
    https://git.kernel.org/netdev/net-next/c/87e839c82cc3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



