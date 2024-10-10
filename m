Return-Path: <netdev+bounces-134019-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3500997ABF
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 04:52:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB2571C2197C
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 02:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC7F3199FC8;
	Thu, 10 Oct 2024 02:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A9gKFu3k"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CAD199FC5
	for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 02:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728528637; cv=none; b=uh43xfzljbqaD28PUiWj3oywzr/D87/lD34qje8wFUlfcOd3kDgcYL8fY+PgBPdAlNzS6MbyqMfNSlv+EPskN8mJWqkmeWPHYHOqPhNkcLSsqG9TAHPnNWKhK4Iiz4lH2giIiVpsBNOCJ6VicI0Ql05bNQTUy85xfmp2liBuHCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728528637; c=relaxed/simple;
	bh=Jjo5Ww34UdYuFR9+yMdowifDaIwcyco/vTXfFwnF5gk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UFuXvt80mBGFQtSFeDwLxJDZDCce2N2ln/DIMspyXW/g8/LeztlzjJCTkiFWUTuD6anrF1FxQVnTtGTnadpX/I0wIbUwyta6ElpL4opesxIZuA5EkDwoZUZ8EbH7TBB5Qtoosg5ZBnAYhGEK2QkEV5EuQLVHJwUgjmSCDoXHkQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A9gKFu3k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3D58C4CEC3;
	Thu, 10 Oct 2024 02:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728528637;
	bh=Jjo5Ww34UdYuFR9+yMdowifDaIwcyco/vTXfFwnF5gk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=A9gKFu3kYLDeI8dldhXG0r16EY7YPYWAKcz72rpZi6Otp1cne2Fv3E1mxmmw4Iehx
	 zFax9ctxv4apkc3BO9MkuM551sc7kwOrXhftJ8421kTw9WzO6A8rV0Dpsiq5+WCk1o
	 F1WjchmIpVx876vqdxuKZKO9ShyVXXl2y2Qjf69wUlTwFdiwIA/IH9Y4bzgr41n5de
	 D3M+3Lzs5/F4iGbQ7NFFNZL4NwtTHGMUHiv2/jlR4dUdr819SZvvFcIRytuQ4t8kGe
	 mTZTEUTwLXcqbF/OPsJZKA0/W+r25Ane+0mbMKrNttqAAHN6V7IcAaW6Jx168Weur/
	 GVhbhdnbTIMwQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C533806644;
	Thu, 10 Oct 2024 02:50:43 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: airoha: Fix EGRESS_RATE_METER_EN_MASK
 definition
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172852864173.1545809.3295404172539567877.git-patchwork-notify@kernel.org>
Date: Thu, 10 Oct 2024 02:50:41 +0000
References: <20241009-airoha-fixes-v2-1-18af63ec19bf@kernel.org>
In-Reply-To: <20241009-airoha-fixes-v2-1-18af63ec19bf@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: nbd@nbd.name, sean.wang@mediatek.com, Mark-MC.Lee@mediatek.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 netdev@vger.kernel.org, jacob.e.keller@intel.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 09 Oct 2024 00:21:47 +0200 you wrote:
> Fix typo in EGRESS_RATE_METER_EN_MASK mask definition. This bus in not
> introducing any user visible problem since, even if we are setting
> EGRESS_RATE_METER_EN_MASK bit in REG_EGRESS_RATE_METER_CFG register,
> egress QoS metering is not supported yet since we are missing some other
> hw configurations (e.g token bucket rate, token bucket size).
> 
> Introduced by commit 23020f049327 ("net: airoha: Introduce ethernet support
> for EN7581 SoC")
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: airoha: Fix EGRESS_RATE_METER_EN_MASK definition
    https://git.kernel.org/netdev/net-next/c/2518b1196391

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



