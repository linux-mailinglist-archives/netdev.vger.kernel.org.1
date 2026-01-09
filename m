Return-Path: <netdev+bounces-248314-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 149AED06D3F
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 03:14:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 74380304C649
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 02:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 361D9279DC9;
	Fri,  9 Jan 2026 02:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mlpvy6DJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E582798F8;
	Fri,  9 Jan 2026 02:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767924817; cv=none; b=Y9RZHanLTPz9fevD2lt54F6TCGBYTKvf2t4kYHOAfpyT2RxOAEXWLBVv98Bd1KZ1joIqz3KZAZMvFJ8NQiHVav9AFJDUiZj6YZpvkXf1deeApkmNhzqIms3b1X92Gu2KeF7EBb1xtLoEghj3f5/Ki6HE9eqeH5N7hY6V2w5JhU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767924817; c=relaxed/simple;
	bh=qj9xUFZXqclaoay+Hlin0bk0PDdgLxrv7ayNzDmbrX8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BLoU7heRfhSWL2D5aIHMH6hsFlisl859v2GBN7ikTMnPy3+iMS2Byxx6BwBeg90zFmtQcJlcStMcEdbnmvMkIbxLxU9QIPvBFDqkojBA7wyvWg8o4st4Tf5S19dCK+PgU8/wVNdMb/2vjQcfjypex93ypre1hx95+hMmJEPOKUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mlpvy6DJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C277DC116D0;
	Fri,  9 Jan 2026 02:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767924816;
	bh=qj9xUFZXqclaoay+Hlin0bk0PDdgLxrv7ayNzDmbrX8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Mlpvy6DJzf2QACO3ll4P91WWYtyj4QxCl7PRqMirGHo5knOh22DtMR7pkb7QsIc+m
	 TgUigeqMqmtqv8KY+Nn5jGhMYNyI0xoGFaUJnWZhH9SvWFRl8O9F7TiFWUu3JdbrF4
	 hZyThRMKzEPsuIII8sfHUXkweb9lFyklw+D0Glws4brE9w+tSn+kC5zsPGQG+EDzvN
	 NUeOc8YCLQEvEhwtrtWj83Z0L/d6+pjVSjszvaJVVLD3nd3+wpMVEiEDr8BTtpnxaT
	 1hzzOK6VUjyBPTTwYTHhbPVjrQR0glDvQ5QEIIj3zVhAkpfWZxwvQ3OOoPf1TjZ778
	 NrLP0NHiGdQ1A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3B89F3A8D145;
	Fri,  9 Jan 2026 02:10:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/1] dt-bindings: net: dsa: microchip: Make pinctrl
 'reset'
 optional
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176792461277.3867254.18424170429868455235.git-patchwork-notify@kernel.org>
Date: Fri, 09 Jan 2026 02:10:12 +0000
References: <20260106143620.126212-1-Frank.Li@nxp.com>
In-Reply-To: <20260106143620.126212-1-Frank.Li@nxp.com>
To: Frank Li <Frank.Li@nxp.com>
Cc: woojung.huh@microchip.com, UNGLinuxDriver@microchip.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 marex@denx.de, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, m.felsch@pengutronix.de, imx@lists.linux.dev,
 shawnguo@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  6 Jan 2026 09:36:19 -0500 you wrote:
> Commit e469b87e0fb0d ("dt-bindings: net: dsa: microchip: Add strap
> description to set SPI mode") required both 'default' and 'reset' pinctrl
> states for all compatible devices. However, this requirement should be only
> applicable to KSZ8463.
> 
> Make the 'reset' pinctrl state optional for all other Microchip DSA
> devices while keeping it mandatory for KSZ8463.
> 
> [...]

Here is the summary with links:
  - [1/1] dt-bindings: net: dsa: microchip: Make pinctrl 'reset' optional
    https://git.kernel.org/netdev/net-next/c/f56bcc0425cb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



