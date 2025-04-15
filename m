Return-Path: <netdev+bounces-182691-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1F3DA89B58
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 13:00:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E32A71785C8
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 11:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54B38284680;
	Tue, 15 Apr 2025 10:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S+8TH31b"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7BE2260C;
	Tue, 15 Apr 2025 10:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744714796; cv=none; b=O7h1+2n3/O/d3J6724V8MfyQJfOKPqzG+CI1RcoXjBvdT66EYSuFCyMdduKQxpP+qNZF0AoSt+s07DzK3DArR1cZWxGHWMSctA5OeHTEb3a3bKojdkbne2U7pCySg24YpmydmC97CzqdKYrYPtoUOZEL4VCLjUMwSS04i58wpdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744714796; c=relaxed/simple;
	bh=/SwxoZm7KffQwQcm64rmu15PgqiClZfE4G1P786RlWg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pukSsZZrLK4gLTRX/1K1TS15u28qnwnhsqVxv0j/aL9F4jqJnShVXIZR8p9GKVI6JB0bfLQ0Ku+/VhcTG1bli32AlMiwdLfZ0y2/tMkZJ3aASkhMd5E5/md4nOIhcZY4q1RqmTh/Ua+4RU2Dq/4ZJD7pBovK3cT8HHSfgpH4V6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S+8TH31b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D498C4CEDD;
	Tue, 15 Apr 2025 10:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744714795;
	bh=/SwxoZm7KffQwQcm64rmu15PgqiClZfE4G1P786RlWg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=S+8TH31bbgYVT+o+w43u5OJE1Ev1z6n0jcqfKDrcz7QSnZZM781T08zwJSxECRc58
	 C/2MIXTZu7sxzHx1ZFtQKAApiUxh6J9y9UJnLD+cPPY+ZHmD8CgaTIAxRbO4OLCmd4
	 YxEARDQzKrVOcmRUXXchqttfgbFygQp8KR6GmpABkN7+BJC4OHsYvGD6hn4XbOBmci
	 KZngaaOQO4+8FkCOeIkpbvrgqaf5omF2ulENTVc4MNm0asafOYxnth623cmqZZUp4K
	 eaJcu/n0fp7NLZCpz+kNiwc4FBKXBeBe0IGXFcB1ZhSs5yB6BOlPlVxND726KnJKPO
	 hWe1hITDMb/Kw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE8A03822D55;
	Tue, 15 Apr 2025 11:00:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next PATCH 0/6] net: dsa: mt7530: modernize MIB handling + fix
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174471483350.2586745.804728746309953080.git-patchwork-notify@kernel.org>
Date: Tue, 15 Apr 2025 11:00:33 +0000
References: <20250410163022.3695-1-ansuelsmth@gmail.com>
In-Reply-To: <20250410163022.3695-1-ansuelsmth@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: chester.a.unal@arinc9.com, daniel@makrotopia.org, dqfext@gmail.com,
 sean.wang@mediatek.com, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 10 Apr 2025 18:30:08 +0200 you wrote:
> This small series modernize MIB handling for MT7530 and also
> implement .get_stats64.
> 
> It was reported that kernel and Switch MIB desync in scenario where
> a packet is forwarded from a port to another. In such case, the
> forwarding is offloaded and the kernel is not aware of the
> transmitted packet. To handle this, read the counter directly
> from Switch registers.
> 
> [...]

Here is the summary with links:
  - [net-next,1/6] net: dsa: mt7530: generalize read port stats logic
    https://git.kernel.org/netdev/net-next/c/ee6a2db281a3
  - [net-next,2/6] net: dsa: mt7530: move pkt size and rx err MIB counter to rmon stats API
    https://git.kernel.org/netdev/net-next/c/33bc7af2b281
  - [net-next,3/6] net: dsa: mt7530: move pause MIB counter to eth_ctrl stats API
    https://git.kernel.org/netdev/net-next/c/e12989ab719c
  - [net-next,4/6] net: dsa: mt7530: move pkt stats and err MIB counter to eth_mac stats API
    https://git.kernel.org/netdev/net-next/c/dcf9eb6d33a2
  - [net-next,5/6] net: dsa: mt7530: move remaining MIB counter to define
    https://git.kernel.org/netdev/net-next/c/c3b904c6dd81
  - [net-next,6/6] net: dsa: mt7530: implement .get_stats64
    https://git.kernel.org/netdev/net-next/c/88c810f35ed5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



