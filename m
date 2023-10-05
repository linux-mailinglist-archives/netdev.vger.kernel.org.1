Return-Path: <netdev+bounces-38146-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F21C67B9921
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 02:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id A8C20281B8C
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 00:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 273BC366;
	Thu,  5 Oct 2023 00:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oPHtVwjy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F273A7F;
	Thu,  5 Oct 2023 00:10:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6FC48C433C9;
	Thu,  5 Oct 2023 00:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696464626;
	bh=ZAyObxd3ELfiKp6Laq/5uFI4Zz0JhrXUcKzxBevzbw4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oPHtVwjyGDXalqOQVTKjg1HPa9A7C/5ETe91ML38o5p9jIh/bwMAA/YKXBbzxFE4J
	 ZYzuofWqvfEn4Aq/CRMJVXDsmysO3aZ6HnISDNVV4+5siPejW44NSef8lSTDRUSAFh
	 hdHfTI8UTWK1OyGFkYEvtxrQAUV4nYpSkOe+JDuM1LRD9xBRdxn+V4tfZhsxfxv4Il
	 m6Y07qY3HGJZvhlA88FH+1rP3M3X2hSdOKFZYeqAOJSmwQkn295vjAH2Z0e/NDGtjE
	 q0TNBVp37DmBeIwCKIkbdshRkxatAThLhiJpIwMaOCP855DsNnZgZYOBYdcrDwPahu
	 2LsDb84VX0tsw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4E96CC595D0;
	Thu,  5 Oct 2023 00:10:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/2] r8152: modify rx_bottom
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169646462631.25730.11600010674078336884.git-patchwork-notify@kernel.org>
Date: Thu, 05 Oct 2023 00:10:26 +0000
References: <20230926111714.9448-432-nic_swsd@realtek.com>
In-Reply-To: <20230926111714.9448-432-nic_swsd@realtek.com>
To: Hayes Wang <hayeswang@realtek.com>
Cc: kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
 nic_swsd@realtek.com, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org, edumazet@google.com, bjorn@mork.no,
 pabeni@redhat.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 26 Sep 2023 19:17:12 +0800 you wrote:
> v3:
> For patch #1, this patch is replaced. The new patch only break the loop,
> and keep that the driver would queue the rx packets.
> 
> For patch #2, modify the code depends on patch #1. For work_down < budget,
> napi_get_frags() and napi_gro_frags() would be used. For the others,
> nothing is changed.
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/2] r8152: break the loop when the budget is exhausted
    https://git.kernel.org/netdev/net-next/c/2cf51f931797
  - [net-next,v3,2/2] r8152: use napi_gro_frags
    https://git.kernel.org/netdev/net-next/c/788d30daa8f9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



