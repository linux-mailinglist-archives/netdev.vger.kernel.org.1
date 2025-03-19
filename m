Return-Path: <netdev+bounces-176252-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59A56A69833
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 19:40:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1E7E7AABB1
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 18:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DD3320B1F4;
	Wed, 19 Mar 2025 18:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DxM3jJkI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1CB0187FEC;
	Wed, 19 Mar 2025 18:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742409599; cv=none; b=TXvCQvVZsgPG9RmG2V0mXa/Tda3Ur7KBrZ1DNJDXuAE9X7NsGYk17Pd5gt5G/3UzE6/RsPSd90oUFMZxrb0e++Q41lA3t5XKj15LMOW0JY47lXoJxsteQhTuOl35g9/gJITBnsO6/WyGz1TXGAdtPpTIOCf+PMhih1TMa0YTrz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742409599; c=relaxed/simple;
	bh=ADlMtJwjQX2yIIUmswrpWLAyb4fE4uw/exy/gEEuVaE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=boRINR+xXDVZZqXZgw3H4vu479giryhHUxX+lXZQeumUsJBs/+k+YLOAxXw0yAnMVhGV538ikoYSLqsnK+6jbWkCr1u77beVoLu7PL+uaXoe5CKgOTZ8vqoVzHNPIF+NHBfg1XjUBIb/qbBcCK8nhglmPrcdQv01FTt2XTzqW2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DxM3jJkI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EEB9C4CEE4;
	Wed, 19 Mar 2025 18:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742409599;
	bh=ADlMtJwjQX2yIIUmswrpWLAyb4fE4uw/exy/gEEuVaE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DxM3jJkIjOfne9gXJK65QbmNBlvcHvKTDoRB/5gezIa+zO8pt+kCOrWt9oznpWA2F
	 pH8/cKJWIPld647NuAjfb1Usq0c94KGLoaEvHMWEiVjBg8OkdseYz6eyQA6FBtDaHf
	 6uQRldwyQBBo2LHS/0mhYWTUchwax+R33gnHTxgkyBOAAzmC9w1xuuEF4YmByCWzH9
	 Xj7yv0JOVreS7LCYyIdTrki60zJK7+a+CmEZ84zGj3ONPK14vaqD68KLo4aRYcbjUC
	 tsEyrRtALadSTqvGZ72Boe3N6QZPTuQQad9aT1rG0Ohxv7qfpdI4JIo2q2BS9h8vxW
	 47Viq/YFKhJcg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A29C380CFFE;
	Wed, 19 Mar 2025 18:40:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] net: macb: Add __nonstring annotations for unterminated
 strings
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174240963487.1149743.12928700103940851464.git-patchwork-notify@kernel.org>
Date: Wed, 19 Mar 2025 18:40:34 +0000
References: <20250312200700.make.521-kees@kernel.org>
In-Reply-To: <20250312200700.make.521-kees@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: nicolas.ferre@microchip.com, claudiu.beznea@tuxon.dev,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 12 Mar 2025 13:07:01 -0700 you wrote:
> When a character array without a terminating NUL character has a static
> initializer, GCC 15's -Wunterminated-string-initialization will only
> warn if the array lacks the "nonstring" attribute[1]. Mark the arrays
> with __nonstring to correctly identify the char array as "not a C string"
> and thereby eliminate the warning:
> 
> In file included from ../drivers/net/ethernet/cadence/macb_main.c:42:
> ../drivers/net/ethernet/cadence/macb.h:1070:35: warning: initializer-string for array of 'char' truncates NUL terminator but destination lacks 'nonstring' attribute (33 chars into 32 available) [-Wunterminated-string-initialization]
>  1070 |         GEM_STAT_TITLE(TX1519CNT, "tx_greater_than_1518_byte_frames"),
>       |                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ../drivers/net/ethernet/cadence/macb.h:1050:24: note: in definition of macro 'GEM_STAT_TITLE_BITS'
>  1050 |         .stat_string = title,                           \
>       |                        ^~~~~
> ../drivers/net/ethernet/cadence/macb.h:1070:9: note: in expansion of macro 'GEM_STAT_TITLE'
>  1070 |         GEM_STAT_TITLE(TX1519CNT, "tx_greater_than_1518_byte_frames"),
>       |         ^~~~~~~~~~~~~~
> ../drivers/net/ethernet/cadence/macb.h:1097:35: warning: initializer-string for array of 'char' truncates NUL terminator but destination lacks 'nonstring' attribute (33 chars into 32 available) [-Wunterminated-string-initialization]
>  1097 |         GEM_STAT_TITLE(RX1519CNT, "rx_greater_than_1518_byte_frames"),
>       |                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ../drivers/net/ethernet/cadence/macb.h:1050:24: note: in definition of macro 'GEM_STAT_TITLE_BITS'
>  1050 |         .stat_string = title,                           \
>       |                        ^~~~~
> ../drivers/net/ethernet/cadence/macb.h:1097:9: note: in expansion of macro 'GEM_STAT_TITLE'
>  1097 |         GEM_STAT_TITLE(RX1519CNT, "rx_greater_than_1518_byte_frames"),
>       |         ^~~~~~~~~~~~~~
> 
> [...]

Here is the summary with links:
  - [v3] net: macb: Add __nonstring annotations for unterminated strings
    https://git.kernel.org/netdev/net-next/c/3d97da0ee625

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



