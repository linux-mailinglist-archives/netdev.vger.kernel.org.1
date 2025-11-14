Return-Path: <netdev+bounces-238547-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF13C5AEAC
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 02:30:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8AE2534B225
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 01:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25B201BC41;
	Fri, 14 Nov 2025 01:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BxqGZCKj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFEB035CBB4;
	Fri, 14 Nov 2025 01:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763083839; cv=none; b=KJ6AoBnh2qCZ77gVY2sJIpcMZ8RYt+FoqZl9cSM/n5waC61Kxo7bz/yOLj7KQ92cgk/8sMu0OgelY5Mhg7mBJkbEze8VtvGn+T9kUGgl/LOUmfAJj8VHmqca7ZpAaNhYgtnn5fWulBV76dNhIbJfnPAa56Sp4Ew5zcrgkMuN9VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763083839; c=relaxed/simple;
	bh=CQRKLnND1CIrsuCBaJ8rXCVn4GtClN6rvCWa85Um1jg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PV7kRUxxhsT0qUMqpeWPQl2lKdZMLgB27izoU3loQ1Oob0mlGAIv7mE56bkVTAd3XPolFj2mGqwLVV+/ZRuLSyu0+bpMKC66xl9bhCy30HRbso4TJ1a3ubcgbv8qz7wFUJ3YsqjKK392v550z8o2oEBQMqSPUktboKt9Hs35hKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BxqGZCKj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 920BDC4CEF7;
	Fri, 14 Nov 2025 01:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763083838;
	bh=CQRKLnND1CIrsuCBaJ8rXCVn4GtClN6rvCWa85Um1jg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BxqGZCKjL49XMZrUaFc+wGEPZXogZzoFl07vj/Kr9TNTAQKz73eb0nd5Ed0TKaikX
	 BpPO/nY5gLvmv371NKrMaTwIys2NbeN6RuHl2BBs9dXn5Z2vjzwqX+A3ucmP0edFbI
	 yqxIG/Si+T7UPXcaEPPiwuEorrCXR6OiG5El9JEIeH2qMtywKHjph/Fk3cU5OpvTfb
	 ZG0HxLDlEzcr3O6KWWAVp4vzOsVevVKw/Nzne0AraO/kLksz7evKFlbkMf+LeH174j
	 yFhOWy8lgfJK6p5vayEqszLKq/wReuImZ1z2PFUaTTthNMxTf7Iw1Ekb5ZadxZ46Jh
	 fBmJSK0HX8KEw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADDB33A55F84;
	Fri, 14 Nov 2025 01:30:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] vxlan: Remove unused declarations eth_vni_hash()
 and
 fdb_head_index()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176308380751.1076537.8184205959467372889.git-patchwork-notify@kernel.org>
Date: Fri, 14 Nov 2025 01:30:07 +0000
References: <20251112092055.3546703-1-yuehaibing@huawei.com>
In-Reply-To: <20251112092055.3546703-1-yuehaibing@huawei.com>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, idosch@nvidia.com, razor@blackwall.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 12 Nov 2025 17:20:55 +0800 you wrote:
> Commit 1f763fa808e9 ("vxlan: Convert FDB table to rhashtable") removed the
> implementations but leave declarations.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> ---
>  drivers/net/vxlan/vxlan_private.h | 2 --
>  1 file changed, 2 deletions(-)

Here is the summary with links:
  - [net-next] vxlan: Remove unused declarations eth_vni_hash() and fdb_head_index()
    https://git.kernel.org/netdev/net-next/c/c3716126cf57

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



