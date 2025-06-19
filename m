Return-Path: <netdev+bounces-199612-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB9E3AE0FB7
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 00:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BC6D3AC18E
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 22:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8753128CF43;
	Thu, 19 Jun 2025 22:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sVE7bvVi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613CE28C871
	for <netdev@vger.kernel.org>; Thu, 19 Jun 2025 22:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750373392; cv=none; b=iB3+2qZifBifP1QLDYrVpE/+c4SHTAdail+mH2vhH2HqAojCQm6Jw0IdXfZn+5+V/J1Azx6LRv/VqVBPF5/B0TAq1Lq2umtv+6jdjfomT+VZtsm4oiRvhYPFum6Dw5HSFQtpxUg647oqg1YlWCsozckVo9Wm9R89MRZyuDWDcS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750373392; c=relaxed/simple;
	bh=/ujSuQ6aA1LA/3pGEHy0VZ3XqFRGqJI54xgQQO4wu7U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TfMSVpdFbNQzRs0KVabA3nq0/guEOIjrHSKtECeeuVWqVizeRRa7JLlXs9wNz69vqyK6DPboyGCaBcX786x53llUrlz+YAmDiMeBatTqTVH51DM949HUF4d0YDtRLf8j1cjD4mRri6LN1NzE3mdpke4eFp8GD+/HMIFQcSLre6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sVE7bvVi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E47C3C4CEEE;
	Thu, 19 Jun 2025 22:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750373391;
	bh=/ujSuQ6aA1LA/3pGEHy0VZ3XqFRGqJI54xgQQO4wu7U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sVE7bvVi+Nxl+lPjzrmSd8BseVd7+ldlgacDgDrGOI1WbsFA39+KwsYnWOedoddUc
	 OO17a1Q9ba4icUV8PciUanGriLQxSFGy5LzUY35SLpOKMB/oZKzjVZqIcBfR+YV83x
	 v3xcsCow7+0Z/nIxDoPRvcVJCwjIebbYVZOmY9pxK3tRwVfD2jMBjvpmW4p6VpKOEX
	 vx1f5cJHXDM1W8OIqP2gVVsE+9CniUFNAfbR3535RbK9S8RB3Rgsa7FH2RtLzhw61a
	 pqiaduLjzVdDv/YCHFGCoGwfrMFA3FOFBsTW5qdX7GclotIbRqlyF8uzEDazK/v65z
	 k7wVyHr7rZgPw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3405D38111DD;
	Thu, 19 Jun 2025 22:50:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4] net: sfp: add quirk for Potron SFP+ XGSPON ONU Stick
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175037341974.1010622.15369374757582009991.git-patchwork-notify@kernel.org>
Date: Thu, 19 Jun 2025 22:50:19 +0000
References: <20250617180324.229487-1-macroalpha82@gmail.com>
In-Reply-To: <20250617180324.229487-1-macroalpha82@gmail.com>
To: Chris Morgan <macroalpha82@gmail.com>
Cc: netdev@vger.kernel.org, linux@armlinux.org.uk, andrew@lunn.ch,
 hkallweit1@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, macromorgan@hotmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 17 Jun 2025 13:03:24 -0500 you wrote:
> From: Chris Morgan <macromorgan@hotmail.com>
> 
> Add quirk for Potron SFP+ XGSPON ONU Stick (YV SFP+ONT-XGSPON).
> 
> This device uses pins 2 and 7 for UART communication, so disable
> TX_FAULT and LOS. Additionally as it is an embedded system in an
> SFP+ form factor provide it enough time to fully boot before we
> attempt to use it.
> 
> [...]

Here is the summary with links:
  - [v4] net: sfp: add quirk for Potron SFP+ XGSPON ONU Stick
    https://git.kernel.org/netdev/net-next/c/dfec1c14aece

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



