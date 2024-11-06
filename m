Return-Path: <netdev+bounces-142179-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 574B29BDB50
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 02:41:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7D4BB22CC6
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 01:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F121218CC1E;
	Wed,  6 Nov 2024 01:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nncemYS2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3C318CC0D
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 01:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730857231; cv=none; b=OlqoBuDZOJyG23G0kf4Xt4X4h8RQsMHCsn6NSudDCBFtnHHnOkq8XnUwZpZc4V57oEF4Uoft1IgFrJ2D9jFl9gh4GDOdZSrNvRqzZV7i+p92uW9vt0c2eInoJR5QuS0ow81roogAbw5+xUaz4bjJmgOe3NN2y5Am7F6RFI3GEf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730857231; c=relaxed/simple;
	bh=5y4cwKr1p+HuDmB+HG8AicP/6MRCT6256+Zef4jWG1A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ETGXDqMH643Hz3bTTiqVhdJvvsZobuj2vhvZfMx2oKdKjZGdWdtd3nrcUn4vgczwNFS0H2SKwoPnbKq1F2TfPVOwmrLAe3LaSsyViL2E1NXuf/KMO++L5B1lOghJo0IkgVs+KN71zKyqcW/B6bHUfLpzyJIrC99QDE2w7FwQ7Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nncemYS2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A42F2C4CECF;
	Wed,  6 Nov 2024 01:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730857231;
	bh=5y4cwKr1p+HuDmB+HG8AicP/6MRCT6256+Zef4jWG1A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nncemYS2xHlQf6UaT5qPzLJKcDj3kSpAK0s5S263gROtSG44MXzrY0cP4mnVWcDJm
	 hL/x7GwHwC47+8MJm+fHI2OZ+lHPlPvZNL+s8HAbzsSORrjrII2E3UM3YFH5v1suFf
	 fYhPl1aVvhz0qjxz4uAi1Scn5NyCNso1E/Cthp3sdWtCeEarwr0VtO1TnCMCgXpuFa
	 eni2u4LunwsATM0edEKhR5+L9FiBXNzzkmcbmGy4EfmWJjxfWc9g7nubt7dwpi7tKR
	 XW+V++yLXuC9L4y1iiC7UkEOjAvJmUj6lvrAZC7DVHnkywwg43pyCfvF0aQhBSEbGV
	 dKfcHWgkaDr2Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE02D3809A80;
	Wed,  6 Nov 2024 01:40:41 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] netlink: typographical error in nlmsg_type constants
 definition
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173085724049.759302.4261489097136624290.git-patchwork-notify@kernel.org>
Date: Wed, 06 Nov 2024 01:40:40 +0000
References: <20241103223950.230300-1-mauricelambert434@gmail.com>
In-Reply-To: <20241103223950.230300-1-mauricelambert434@gmail.com>
To: Maurice Lambert <mauricelambert434@gmail.com>
Cc: netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun,  3 Nov 2024 23:39:50 +0100 you wrote:
> This commit fix a typographical error in netlink nlmsg_type constants definition in the include/uapi/linux/rtnetlink.h at line 177. The definition is RTM_NEWNVLAN RTM_NEWVLAN instead of RTM_NEWVLAN RTM_NEWVLAN.
> 
> Signed-off-by: Maurice Lambert <mauricelambert434@gmail.com>
> ---
>  include/uapi/linux/rtnetlink.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - netlink: typographical error in nlmsg_type constants definition
    https://git.kernel.org/netdev/net-next/c/84bfbfbbd32a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



