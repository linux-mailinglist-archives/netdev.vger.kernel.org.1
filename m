Return-Path: <netdev+bounces-69108-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D110D849A95
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 13:40:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CECF281AEE
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 12:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07DBC1C6B8;
	Mon,  5 Feb 2024 12:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZGfGz25k"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88DF1C69F
	for <netdev@vger.kernel.org>; Mon,  5 Feb 2024 12:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707136830; cv=none; b=Gp0pMoGjJzdMcvnop4a5juvZU3iAaAxjPcG2NLucrJPSoOoaei7/iNXTNAT9ENGKXSGzauKCHQlbCTB6c4fTi4e0himTMhIgvzXxryeop/UbAJV/fvlsszVWCEBOFg5QeBZ7tM/Ms3wAdtJEg6vfAegrn73Wo8JynqHDuZdUGm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707136830; c=relaxed/simple;
	bh=A06eZAl7IghCEpPSiYue6wl1aProEoys1xR5upotnQk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ImN6MQusn/T6MMiT4VLXgMbVQCqdFxfORvCgL4uoYPhjdnnDSdWbb4x+m84tIyDs2Trc7gDn+MHFDT0yjIpHmsVvirLAdP5XpBdxUTc0C5kAEiUq1e3Jz34QlXo24EqjaXkqg1I9vD9WKPb685ODEV95Mc1FYnEQwLPQRL7iy04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZGfGz25k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 52DEEC43330;
	Mon,  5 Feb 2024 12:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707136830;
	bh=A06eZAl7IghCEpPSiYue6wl1aProEoys1xR5upotnQk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZGfGz25kLUxjzOJX8M+Ml8OaTipVBpELUVxYSjj7izYkkF39coUVAGIXHR0krRwSp
	 CfdyJpEM9w/Efn4zOrSUHMU11PGSWhKijCyGKwEBM3JDxxSui+LD6lbJMlSYXie/fR
	 7FhKuDj/vYuglqoHjYi95R8zHBoUd/OAlXbBni5nl88qNtyWmgnbaEXLtZZsVZc57f
	 vEHurSXeDLltOwq8vw7s7eJ0eTQnPAJi/Z9V0TqUvzt5daBvdQFfe2qwLDXT9MYI6k
	 /TQdi3ewBQgtnFXk7gMwnPJuXmPvn5sDg9cw0NPwjICley1bmJzep2ffWCU++7vCCL
	 fuSYcbSngBZsA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2DB71E2F2F1;
	Mon,  5 Feb 2024 12:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: dsa: reindent arguments of
 dsa_user_vlan_for_each()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170713683018.8022.3648864153566501617.git-patchwork-notify@kernel.org>
Date: Mon, 05 Feb 2024 12:40:30 +0000
References: <20240202162041.2313212-1-vladimir.oltean@nxp.com>
In-Reply-To: <20240202162041.2313212-1-vladimir.oltean@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, andrew@lunn.ch, f.fainelli@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri,  2 Feb 2024 18:20:41 +0200 you wrote:
> These got misaligned after commit 6ca80638b90c ("net: dsa: Use conduit
> and user terms").
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
>  net/dsa/user.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Here is the summary with links:
  - [net-next] net: dsa: reindent arguments of dsa_user_vlan_for_each()
    https://git.kernel.org/netdev/net-next/c/0cd216d769fb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



