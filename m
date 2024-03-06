Return-Path: <netdev+bounces-77762-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D7D6872D75
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 04:20:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D39D1F24961
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 03:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC7361401B;
	Wed,  6 Mar 2024 03:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZDu+qv48"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B120134B6
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 03:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709695229; cv=none; b=gmQBsM+ic2Z8TO2oa9lXJs5XaLuTe1OtDgEFRxyrp2e1J6EV/1y+Tw00ePcMyIpxMF+PTxCw6cxRuKxbDhcGLt0R3500n+GRwsobKhQxU9iUYRzX9j9r0D8D51oY5BRwhESvKQJVeBg5it6nnZjeTkzphG3i6MiiAS+Y9vAfjQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709695229; c=relaxed/simple;
	bh=+1YeLy86yh1K5cPEy/vwITdq+fVaIyFpQhwTGxaR/Z0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dAvX3cNZP7MExG9Gw+alPufyZ98gzptqAMCjY5iQaNArHUon6cv5mpVrbzOn1iOSGBPFZrtCY9Qy+OOJ1VKrqsM6VTqb3ZcZigGgyxwrPdKnqkuws8MTK+nr1IgjITLHQjl4f+VkpF7rtNFHJqwqU9hb76j+LAQW88Vi/EtLhgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZDu+qv48; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 345C9C433B1;
	Wed,  6 Mar 2024 03:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709695229;
	bh=+1YeLy86yh1K5cPEy/vwITdq+fVaIyFpQhwTGxaR/Z0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZDu+qv48uA2FGIzDizHQhNam8gBRzvpY+SwVlRGEKDfLEaeQ2ypljMffYZ6fb5wRG
	 xtlf5dXdOGoe8XfXu7+ouKhxAJybaw+buoR9qwvPT6oNDRiyFDjpbj/UYGHOHBjz2U
	 YQlhjunp0AmiyqEOUhrmvv4ef+MpiSeEgXvbyYkNy/lT1mgUei5G/ctODia108N3EZ
	 B4brA43wYSLSjTgNklmFw64GasEAa28LGnKzAEW0LMQuVtgKzSwhdiNOEn/F9lN4xL
	 x7v9JrmBBtl/REUQTagmYZGySh4MepuyueedDlWH3c5U730+FqVDJWvnve0tMeYoUy
	 CyCmfJ8gvux+A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 21EB0D84BDE;
	Wed,  6 Mar 2024 03:20:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next] ethtool: ignore unused/unreliable fields in
 set_eee op
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170969522913.30303.10118184261588288842.git-patchwork-notify@kernel.org>
Date: Wed, 06 Mar 2024 03:20:29 +0000
References: <ad7ee11e-eb7a-4975-9122-547e13a161d8@gmail.com>
In-Reply-To: <ad7ee11e-eb7a-4975-9122-547e13a161d8@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: andrew@lunn.ch, linux@armlinux.org.uk, pabeni@redhat.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 2 Mar 2024 15:18:27 +0100 you wrote:
> This function is used with the set_eee() ethtool operation. Certain
> fields of struct ethtool_keee() are relevant only for the get_eee()
> operation. In addition, in case of the ioctl interface, we have no
> guarantee that userspace sends sane values in struct ethtool_eee.
> Therefore explicitly ignore all fields not needed for set_eee().
> This protects from drivers trying to use unchecked and unreliable
> data, relying on specific userspace behavior.
> 
> [...]

Here is the summary with links:
  - [v2,net-next] ethtool: ignore unused/unreliable fields in set_eee op
    https://git.kernel.org/netdev/net-next/c/344f7a465149

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



