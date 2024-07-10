Return-Path: <netdev+bounces-110470-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE0FC92C847
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 04:10:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 419BB282C31
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 02:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 255D9B676;
	Wed, 10 Jul 2024 02:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J7p4RGKF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0D28F5D
	for <netdev@vger.kernel.org>; Wed, 10 Jul 2024 02:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720577433; cv=none; b=FcrsBBhe4v2khsm7TbdW443fY/xeLtb20h4FRPxFNCfqf1sk5jDlS2+BOskai8XP2KTYEI0FUkOcs09KGYFDJPYEQxtEX8UQEQ6RqEODe9Nhry2HiFBguRfhVlvDFIXH5jGH/ejA0/PFzIlZMxQLueUP/V/o+ZYRuK1a51/u8fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720577433; c=relaxed/simple;
	bh=ysA9mHBiaJC7if3QgdH72JAvNWAW1vUl+ada8gbBY7E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RaNOXQWApNl4ujGmeHxKtNK27Qhr44C7/B3hQiHYq7epAo3Eld2PVb/q7WPjsXVLqvb1gp8yqkjbnEN6HtucD0ZvFRVw37IR/2WNNoj15ho2SElGqwp6MHHzuATYweQgftXtCaEN8bKyowTKf5/HvKpSqjilrak5zO1CUW0XAHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J7p4RGKF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C79DBC4AF0C;
	Wed, 10 Jul 2024 02:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720577432;
	bh=ysA9mHBiaJC7if3QgdH72JAvNWAW1vUl+ada8gbBY7E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=J7p4RGKF44N3jtKGfZ0/ULDA7VoxexanepTxWK8matjRxNY70uI2d9FDJA0zrG14f
	 y3/sO4kpJaAXKchZs275gboyGGlzQEe6vaoYQfYFeYL7VCJC87cT1adfilpRQ5CDYg
	 Rm/RhnfkplA2HaACt36Jyo+/3S55YZqIwa5Ca+qoq566j2bt+XLeLT7Mr6vHsrlT+Y
	 Mm4G77voxSgbziQ65HqVU5do4bHw3ywhK3hsDwUIK6Hm5HRA0Xmw8RrKakmEfqlDY+
	 5wzJXPpp4S8FD02SIbJpLhtsK+TrqOxz12YvTPAISLJjH5iIRmAkhR2dh2FlNe93VV
	 tmqN6IG1WhdVg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B6627C4333B;
	Wed, 10 Jul 2024 02:10:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] netxen_nic: Use {low,upp}er_32_bits() helpers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172057743274.1917.12478548573311010300.git-patchwork-notify@kernel.org>
Date: Wed, 10 Jul 2024 02:10:32 +0000
References: <319d4a5313ac75f7bbbb6b230b6802b18075c3e0.1720430602.git.geert+renesas@glider.be>
In-Reply-To: <319d4a5313ac75f7bbbb6b230b6802b18075c3e0.1720430602.git.geert+renesas@glider.be>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: manishc@marvell.com, rahulv@marvell.com, GR-Linux-NIC-Dev@marvell.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  8 Jul 2024 11:25:14 +0200 you wrote:
> Use the existing {low,upp}er_32_bits() helpers instead of defining
> custom variants.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Compile-tested on 32 and 64 bit.
> 
> [...]

Here is the summary with links:
  - [net-next] netxen_nic: Use {low,upp}er_32_bits() helpers
    https://git.kernel.org/netdev/net-next/c/40ab9e0dc865

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



