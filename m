Return-Path: <netdev+bounces-96203-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84F6F8C4A4E
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 02:00:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 090D4B211D2
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 00:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6B5A22F0A;
	Tue, 14 May 2024 00:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cz2hietd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21FF14A96
	for <netdev@vger.kernel.org>; Tue, 14 May 2024 00:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715644846; cv=none; b=sk9jZ7gI9weqRLtEXmKHll0z6E7J1DJUcjCQ+uhpdN96i3cxHGD6MvT8cTVKcaqXsM7IIWPjFdPAugrYyHql6AahtyGuXKVVvsW2Yds4HDa1wzy+rtkAKobt6TUWk6uSn9DS9JH7tH5Miwx9gf0sJ0fACyTBfA3sVrhYUdOHqms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715644846; c=relaxed/simple;
	bh=X91azbeKnRLNGoL1k3s+Oo3uaK6vFeyu6Fhy9qWnzLE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=D0ihFDc2vqZfAmYJgOUvQ/DQBAFLIA/8WpRMGYutKejUTfPZq3cBR8MNYpOqJD/gSbZy6XIvnJsinGTtK0A4z1pN2vXLsbjqbMV+AN7xo0siRmLf/IjbcXuD5FjiWRCYzx+928v303CrBH9Izh1Y2+8HqLWRgHONe/mlrowvoOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cz2hietd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3A89AC32781;
	Tue, 14 May 2024 00:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715644846;
	bh=X91azbeKnRLNGoL1k3s+Oo3uaK6vFeyu6Fhy9qWnzLE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cz2hietdjMnS3MT55m4XtTV5LJqwoZYFV0yWV1l74T1aZskm7f0rrknAAFAu1oS4X
	 2iqxV3oWsJH9etLX0Xae7BAX+wAOUU+m0ubkgWESrsIB3nXEcTS05DuSlUJIrYI6uy
	 +tasMkXzvvnd0yBKjtEMimUlx/CzTw8PgQnrGN6pQawBQA1bpI+7aZRVhRmZ988kzn
	 2Aa/ppNidwm0J7ZFjo0qoTKNDeo0zRyAvpZLK4LF2QPBNjSfrB3Yvpy0I9nIYbSlnB
	 D0UnwvVxl5J4vwsn6Sz4sDTnZVEm+e7eapuKnThoU3j2ar1mmiQGh7SxDsSKMcsjB9
	 AFJ7gHBa2gxsw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2467FC43445;
	Tue, 14 May 2024 00:00:46 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: pcs: lynx: no need to read LPA in
 lynx_pcs_get_state_2500basex()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171564484614.4532.13527452299746917407.git-patchwork-notify@kernel.org>
Date: Tue, 14 May 2024 00:00:46 +0000
References: <20240513115345.2452799-1-vladimir.oltean@nxp.com>
In-Reply-To: <20240513115345.2452799-1-vladimir.oltean@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, ioana.ciornei@nxp.com, andrew@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 13 May 2024 14:53:45 +0300 you wrote:
> Nothing useful is done with the LPA variable in lynx_pcs_get_state_2500basex(),
> we can just remove the read.
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
>  drivers/net/pcs/pcs-lynx.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

Here is the summary with links:
  - [net-next] net: pcs: lynx: no need to read LPA in lynx_pcs_get_state_2500basex()
    https://git.kernel.org/netdev/net-next/c/afd29f36aaf7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



