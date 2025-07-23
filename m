Return-Path: <netdev+bounces-209395-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4919B0F7A9
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 17:59:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D79E2965604
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 15:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 934191F418F;
	Wed, 23 Jul 2025 15:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="clcv19b5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A5F1F3D54;
	Wed, 23 Jul 2025 15:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753286349; cv=none; b=QMR19NNhK6eCJ3h2wM1S2JeEHZ0HR5DijbfdESDJb59ffwc5siziDRk3CuN95coWj27UmaQEqrdYdc2Q98XBmxDsuuDQeIbsxuXAZKex4sva7Yk50ywp4+xcLXb+MHKVNDoSxsc+mVJLLIDfQL5eZY9k9mmBANzC5oPirOpaNIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753286349; c=relaxed/simple;
	bh=l5L+lEz1dNbThjL45OGEhpHZYEbWBADkvh3KY+K3ZnU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=REM20wvY0es/LdZG+kHmc1J6nwshRB4or6ONeYvQWSUAQam5KgSeJK81BfgZansZGG7S2om4XDx/gyUj4Ew05RJt0eikKQ8FOuzE0OLM5zfkT31jKABmN5CPKKheegmSmp4jlv5sk6nuw1rQmYDx6Vnkda+C7Y1LVdgL1PBwC2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=clcv19b5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01D03C4CEE7;
	Wed, 23 Jul 2025 15:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753286349;
	bh=l5L+lEz1dNbThjL45OGEhpHZYEbWBADkvh3KY+K3ZnU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=clcv19b5pzoVv7wydv9hmQlP0xAzUhE8NzZNIK7svu2xarRS/llEdBMrbt+g3Fqo1
	 6hpDJw7Ag8L6a908RMv5pcprf0uWPW/MN903PocRH7GJp7+Xu4Y18GjJdmVIwrWyi1
	 WoOkUPHsoaBqFpVn/ZEj+HAbd1mQwWwK8rhG4VSxyThHqUsLQPYt/PKt8iSZ/JGJRy
	 z7iPdWDa0KFp2NJXg/q5IKnD/ZSKr2Yy35SgXwKqqhUhBRZ/HsEMphJi2tW7nlozri
	 gj7eklvObBRvKiad/Q4FxzVnPQwddv+LLfFN2mdgoNgivhHZQMS2wC/iuZ1dmaAYAW
	 /aXQ24F65vGvQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70F21383BF4E;
	Wed, 23 Jul 2025 15:59:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3] net: replace ND_PRINTK with dynamic debug
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175328636724.1599213.15305193300784446965.git-patchwork-notify@kernel.org>
Date: Wed, 23 Jul 2025 15:59:27 +0000
References: <20250708033342.1627636-1-wangliang74@huawei.com>
In-Reply-To: <20250708033342.1627636-1-wangliang74@huawei.com>
To: Wang Liang <wangliang74@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, alex.aring@gmail.com,
 dsahern@kernel.org, yuehaibing@huawei.com, zhangchangzhong@huawei.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 8 Jul 2025 11:33:42 +0800 you wrote:
> ND_PRINTK with val > 1 only works when the ND_DEBUG was set in compilation
> phase. Replace it with dynamic debug. Convert ND_PRINTK with val <= 1 to
> net_{err,warn}_ratelimited, and convert the rest to net_dbg_ratelimited.
> 
> Suggested-by: Ido Schimmel <idosch@idosch.org>
> Signed-off-by: Wang Liang <wangliang74@huawei.com>
> 
> [...]

Here is the summary with links:
  - [net-next,v3] net: replace ND_PRINTK with dynamic debug
    https://git.kernel.org/bluetooth/bluetooth-next/c/96698d1898bc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



