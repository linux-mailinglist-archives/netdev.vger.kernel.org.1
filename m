Return-Path: <netdev+bounces-99612-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 395D28D579A
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 03:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B4FA1C23137
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 01:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C150C613D;
	Fri, 31 May 2024 01:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FScHotQF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A9917550;
	Fri, 31 May 2024 01:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717117831; cv=none; b=QV28Nd776QexsAaRl+kzCsiGXIJtoyxV0OLVu4lFyj4aAsEPLHGPND5RDZmf78PM/TuU0dwszCzvjHHb7BQ2D8E15GP40wXVdv7B68d9gU2/3qEYkey8bXcX3D1BLSkz6UiWYq3m+y8aMgQeyr3n6hlIuxFKerFzMNK4RK12mfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717117831; c=relaxed/simple;
	bh=fxth+aG3SpLE3tOZw13zdpURXXg8QNfDMSy5NiMGdug=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=R5KzatYIfgqaW4Jvc2LU7YGz1cDmT0oLZsjl0ATjAoqjalPfnaLR8EgXT5uX1FmK5ycZQ8Zpo/6UltiXYrDaKuy9qHXi0xmFgRYJDOERqK+1fiWWEZQ8b6JQ0MjbGwfz4WJE8x2wfgRezM+MIlp9V+Whm+BYunTC5BnwvNY4dy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FScHotQF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AB8F7C4AF07;
	Fri, 31 May 2024 01:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717117830;
	bh=fxth+aG3SpLE3tOZw13zdpURXXg8QNfDMSy5NiMGdug=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FScHotQF0IbnvjO3vptxkLb5WXI/zOuATBL/V4rNSWTHGZ9FRgJsN/qphEJncmeUB
	 /XIrOohxTKm7IuM5nXXNgAzScdIMw3jAu6Oc3ARx65l6/jIyHM4HnuC/gqJkeMAEij
	 o+x6Ab6PyCXYJS03wtOe3ts1TSuo7Y++BiThM6rzSk9/u6Kx0KYTPz7arIjOgDJGD1
	 4M3SxXfezvmEn1PLjNOZInzgBgB3gxr8kosAeoH4bJ9olIX+HIKY4RYILiXUyqMLDU
	 FEe6a75gvwrOA9DVEABG74Y9LhU8Zhbm/9dU+atfqLtK0gBtsF5R0CPd2G/uVPfSUR
	 FH0GHWO4xA2yA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9E488D84BCD;
	Fri, 31 May 2024 01:10:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] hns3: avoid linking objects into multiple modules
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171711783064.1907.10943552565811999041.git-patchwork-notify@kernel.org>
Date: Fri, 31 May 2024 01:10:30 +0000
References: <20240528161603.2443125-1-arnd@kernel.org>
In-Reply-To: <20240528161603.2443125-1-arnd@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: yisen.zhuang@huawei.com, salil.mehta@huawei.com, shaojijie@huawei.com,
 arnd@arndb.de, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, leon@kernel.org, masahiroy@kernel.org, lanhao@huawei.com,
 wangpeiyang1@huawei.com, wangjie125@huawei.com, michal.kubiak@intel.com,
 kalesh-anakkur.purayil@broadcom.com, huangguangbin2@huawei.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 28 May 2024 18:15:25 +0200 you wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Each object file contains information about which module it gets linked
> into, so linking the same file into multiple modules now causes a warning:
> 
> scripts/Makefile.build:254: drivers/net/ethernet/hisilicon/hns3/Makefile: hns3_common/hclge_comm_cmd.o is added to multiple modules: hclge hclgevf
> scripts/Makefile.build:254: drivers/net/ethernet/hisilicon/hns3/Makefile: hns3_common/hclge_comm_rss.o is added to multiple modules: hclge hclgevf
> scripts/Makefile.build:254: drivers/net/ethernet/hisilicon/hns3/Makefile: hns3_common/hclge_comm_tqp_stats.o is added to multiple modules: hclge hclgevf
> 
> [...]

Here is the summary with links:
  - hns3: avoid linking objects into multiple modules
    https://git.kernel.org/netdev/net-next/c/e3bbb994a7e0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



