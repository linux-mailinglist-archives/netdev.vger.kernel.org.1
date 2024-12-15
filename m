Return-Path: <netdev+bounces-152024-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E0ED9F2646
	for <lists+netdev@lfdr.de>; Sun, 15 Dec 2024 22:30:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DAB01885A95
	for <lists+netdev@lfdr.de>; Sun, 15 Dec 2024 21:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5D6B1C07C0;
	Sun, 15 Dec 2024 21:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EyAt+9yL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906E81BD4FD
	for <netdev@vger.kernel.org>; Sun, 15 Dec 2024 21:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734298214; cv=none; b=axhkEKg2+c7Rysvofwbj0nMCFfLmQrec8cN2xnfadIfduzZHkhzomJks37TUE97wm/V3VpORkU8/gsXR4sZZvUwRMxbaLKJU3oN1kbdYfstRFsrG13NTPVDFBei/QkmcW1nUNxs5uBSR6rXEg/+moOq7/Fwl6p/z+gA8yJUZTKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734298214; c=relaxed/simple;
	bh=7RNQr5NlEYI1r/1Y48MtryHKbEyPQxR35cZTO3f698w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=N0C3nHVah1r1ZKOlqkll8loZBISYgkkwxzZi1/70cvrJDMPqE7P0r2w4JW/spE/DXh0ooeIGlBSjtlRxC+dTwSU1VHUobaNaq6w0ukl9dm1NnVvzUU0Qhyb86rWtFPPbmypzO6IsC6qKY4mimqQ+bsKsIWVwLy/IDaf/tEFYDNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EyAt+9yL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C3A7C4CED4;
	Sun, 15 Dec 2024 21:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734298214;
	bh=7RNQr5NlEYI1r/1Y48MtryHKbEyPQxR35cZTO3f698w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EyAt+9yLP2JgkXiJhopISWzdXMxaX1dmoolfsEwnd33swLQXyM6ryV8Fl1WXlG6Fy
	 5/kvjcZ2DrPWbnZM9F1re3+msJlZB8HsW71MMUnU2+Ck6mYbxq8QgdTq8XATcFa+s4
	 nrjWNkko/xZnUkdUA1jyByoaYM2TitX2XLerr2ikA5iJN/Pq+A0CcB51O3s7vK6KoX
	 Q/ya4jyr0cLW4GDpehB9l8HBaQgyfbcluHcxEOgxlSPXPm0bseXHyms1G81UV6OMbo
	 Sww4+r542stWfjJUi57b9s6Nv1NIfcBIS4h9+6Tv71Sp0rk0AKI/QLYOSAe1XwbRTb
	 ELWjnLcHs4VTw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33F583806656;
	Sun, 15 Dec 2024 21:30:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: mscc: ocelot: fix incorrect IFH SRC_PORT field in
 ocelot_ifh_set_basic()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173429823099.3585316.12907966837487758399.git-patchwork-notify@kernel.org>
Date: Sun, 15 Dec 2024 21:30:30 +0000
References: <20241212165546.879567-1-vladimir.oltean@nxp.com>
In-Reply-To: <20241212165546.879567-1-vladimir.oltean@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, andrew@lunn.ch, claudiu.manoil@nxp.com,
 alexandre.belloni@bootlin.com, UNGLinuxDriver@microchip.com,
 jacob.e.keller@intel.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 12 Dec 2024 18:55:45 +0200 you wrote:
> Packets injected by the CPU should have a SRC_PORT field equal to the
> CPU port module index in the Analyzer block (ocelot->num_phys_ports).
> 
> The blamed commit copied the ocelot_ifh_set_basic() call incorrectly
> from ocelot_xmit_common() in net/dsa/tag_ocelot.c. Instead of calling
> with "x", it calls with BIT_ULL(x), but the field is not a port mask,
> but rather a single port index.
> 
> [...]

Here is the summary with links:
  - [net] net: mscc: ocelot: fix incorrect IFH SRC_PORT field in ocelot_ifh_set_basic()
    https://git.kernel.org/netdev/net/c/2d5df3a680ff

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



