Return-Path: <netdev+bounces-190597-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F812AB7BB3
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 04:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9A0C1BA6719
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 02:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FAA8293B6F;
	Thu, 15 May 2025 02:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BnepMtQj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D912820A0;
	Thu, 15 May 2025 02:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747276803; cv=none; b=lBvSJPm8RDUOJ7NnY1li0Gbrq5ApA2TnleN3vp1GLuHn/iN6Zwdoqh6NHnGQGiJo5fX4PQOFOLBcHNgyBsJcwT0FRLDFEcT3FkpSyQwkfxx5gJvBC4lJWG+jBG9knSG3XAXhYXJ1bHKFuHYtzuhLTJkz+RbX21F83m59qw4vQI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747276803; c=relaxed/simple;
	bh=lrEamcmK20W/gtuxO3aHJagod68XsFUEPjGcfYzxcfI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=emAWEjETnO5pyeFnT+wc5krg8k6z1/lAcZpJjh4zRlyZJT1uEFf5P6rKfh2T61yB7r5Mcd3c2q0s7OzIoZw+gZ2hbP2hrn1KvF49jxZgnw23dbxgDa0nDggzbW/CdXM8YgeQCAfLKONVF5FO2eW/gUokNuQjwTmbF4CdgVnocUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BnepMtQj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8528C4CEE3;
	Thu, 15 May 2025 02:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747276801;
	bh=lrEamcmK20W/gtuxO3aHJagod68XsFUEPjGcfYzxcfI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BnepMtQjO9C84Nood7lwGeUpSiG055lgXjyxJj76jaoq4SSwM6/Ibq0uNIHHBJKuT
	 +CJZC3fS/qPJmhMjTTZms3ptrsExAYDrjS42BMzdlGeVBBXG8kGuxmexWtTj/52JFB
	 5H4kakn75HmqktEKlj80RIlfsBTXna7RjBM5iR8/Az07GhO61lDsbJpbXrOhBYfcuq
	 +26RNZujKIDJC3/dn1ZwFKNkJHqG9cPY+qJXJyOeCCBkMwTNGqm0ERUwGyei1Fn2an
	 EgSjhDzk9N8kAQcOcqMQKWr3+meF5mj5BoGN3EXUKbcE267J/9uI20kn3c57RHQtiB
	 RoGD9sjsgVa1g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33DBA380AA66;
	Thu, 15 May 2025 02:40:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: ethernet: mtk_eth_soc: fix typo for declaration
 MT7988 ESW capability
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174727683900.2587108.2642829871364981642.git-patchwork-notify@kernel.org>
Date: Thu, 15 May 2025 02:40:39 +0000
References: <b8b37f409d1280fad9c4d32521e6207f63cd3213.1747110258.git.daniel@makrotopia.org>
In-Reply-To: <b8b37f409d1280fad9c4d32521e6207f63cd3213.1747110258.git.daniel@makrotopia.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: nbd@nbd.name, sean.wang@mediatek.com, lorenzo@kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, linux@armlinux.org.uk,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 13 May 2025 05:27:30 +0100 you wrote:
> From: Bo-Cun Chen <bc-bocun.chen@mediatek.com>
> 
> Since MTK_ESW_BIT is a bit number rather than a bitmap, it causes
> MTK_HAS_CAPS to produce incorrect results. This leads to the ETH
> driver not declaring MAC capabilities correctly for the MT7988 ESW.
> 
> Fixes: 445eb6448ed3 ("net: ethernet: mtk_eth_soc: add basic support for MT7988 SoC")
> Signed-off-by: Bo-Cun Chen <bc-bocun.chen@mediatek.com>
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> 
> [...]

Here is the summary with links:
  - [net] net: ethernet: mtk_eth_soc: fix typo for declaration MT7988 ESW capability
    https://git.kernel.org/netdev/net/c/1bdea6fad6fb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



