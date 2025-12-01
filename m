Return-Path: <netdev+bounces-243091-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BB0D3C9971D
	for <lists+netdev@lfdr.de>; Mon, 01 Dec 2025 23:53:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 64D634E2015
	for <lists+netdev@lfdr.de>; Mon,  1 Dec 2025 22:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A563D28689F;
	Mon,  1 Dec 2025 22:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eXSBH7DP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC6A1E7C03;
	Mon,  1 Dec 2025 22:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764629599; cv=none; b=jB9kWoj1eI/x1F53ma2bxVn6pXp+YD7opLcrv9tRakT7IS8BffzzOz7gu6NYmCuuTEC8UD6PnetGg2oikBmdnnv5DbN0lq9GqPQxoiRgtz8kcmvbl8V5sHdHj3egW9wLyTOYBNNm2t36P2Mi72YwuF4HChgslr2aiilRlUUvrSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764629599; c=relaxed/simple;
	bh=AdViVI7PUz40k2A4Reboa12HlfWFPApg1vFOeC4eUVA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kLwJ8eWveiSz3WbplyvgRJfYnrENRfKEy6t8YW2MTgi5o4EHbMP0TByC5cy8n6wOG901jBlHYzFVcHNRMVqQwkOd8HmvzaA0sZVjQTazULLScZA2SUMioIlu49QgHH6/Bn7VS1jyNKATirTdUDypiaP5nLt1uKNYXC6JhroYV2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eXSBH7DP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 592E7C4CEF1;
	Mon,  1 Dec 2025 22:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764629599;
	bh=AdViVI7PUz40k2A4Reboa12HlfWFPApg1vFOeC4eUVA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eXSBH7DPzAPMVA/WYIw1+e57ruhRd65MAcoI1iwFXw6liHgPbYRa3bOiMYvA0Qiww
	 7hvglF8dt+b8RVOLe8TEU/JQy/pR9GofEwdqWg4lS7MvE0ojW+Rw/XOzFwP7XLppH9
	 rooF59MZXbVNz/J9W66HK2Evr/CoOsoFvni5HllE/4UFnQFzrexja5v511FCGofvBi
	 E7OVFxrhnrPRxqgK3MK+e2ZTxPqckoPYIaDu9yzmuvRzIRgSzOhC7To282s8mNWa2G
	 +n1SltYtDdzbnyEzLp+YdMtp7puwTZ8I0W1mTl4IXdnjES4pkvcpCQkoggpc8o2Hr1
	 TuBl7MJdRmJlw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 786EA381196A;
	Mon,  1 Dec 2025 22:50:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/7] net: dsa: b53: fix ARL accesses for
 BCM5325/65 and allow VID 0
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176462941929.2581992.3926828060730665276.git-patchwork-notify@kernel.org>
Date: Mon, 01 Dec 2025 22:50:19 +0000
References: <20251128080625.27181-1-jonas.gorski@gmail.com>
In-Reply-To: <20251128080625.27181-1-jonas.gorski@gmail.com>
To: Jonas Gorski <jonas.gorski@gmail.com>
Cc: florian.fainelli@broadcom.com, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 noltari@gmail.com, f.fainelli@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 28 Nov 2025 09:06:18 +0100 you wrote:
> ARL entries on BCM5325 and BCM5365 were broken significantly in two
> ways:
> 
> - Entries for the CPU port were using the wrong port id, pointing to a
>   non existing port.
> - Setting the VLAN ID for entries was not done, adding them all to VLAN
>   0 instead.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/7] net: dsa: b53: fix VLAN_ID_IDX write size for BCM5325/65
    https://git.kernel.org/netdev/net-next/c/6f268e275c74
  - [net-next,v2,2/7] net: dsa: b53: fix extracting VID from entry for BCM5325/65
    https://git.kernel.org/netdev/net-next/c/9316012dd019
  - [net-next,v2,3/7] net: dsa: b53: use same ARL search result offset for BCM5325/65
    https://git.kernel.org/netdev/net-next/c/8e46aacea426
  - [net-next,v2,4/7] net: dsa: b53: fix CPU port unicast ARL entries for BCM5325/65
    https://git.kernel.org/netdev/net-next/c/85132103f700
  - [net-next,v2,5/7] net: dsa: b53: fix BCM5325/65 ARL entry multicast port masks
    https://git.kernel.org/netdev/net-next/c/3b08863469aa
  - [net-next,v2,6/7] net: dsa: b53: fix BCM5325/65 ARL entry VIDs
    https://git.kernel.org/netdev/net-next/c/d39514e6a2d1
  - [net-next,v2,7/7] net: dsa: b53: allow VID 0 for BCM5325/65
    https://git.kernel.org/netdev/net-next/c/0b2b27058692

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



