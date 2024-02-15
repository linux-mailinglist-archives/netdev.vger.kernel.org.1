Return-Path: <netdev+bounces-72027-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4944E8563B0
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 13:52:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A0BEB24544
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 12:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7EDF12EBD8;
	Thu, 15 Feb 2024 12:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UGq+eH58"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44CB12EBC6
	for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 12:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708001428; cv=none; b=oo/xY5Tmy9Z4fysCBS9nrEDX3UgKRkS4VWuEseFbwvISx6fdjaRr9TKBvdxMV9kyrLbT8O73QwyTkm+2ecL7aPEyOzzKLKsyXeIp7Uji4HuOxfSFyyQ4Qn3XSOIESniwehmI886aSZ/bw1plgQNAORfo2W/IYJJoznUyH9r5l1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708001428; c=relaxed/simple;
	bh=lseFDQJM8qNvU3yj0wMReSBJVd1/JCzB82G2JnOLCuk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=agijzHKDf8ur4iCYm70P3sUaLY/K3EuIJ0lIA14I8oMY7KuPXeimm5CLiakCDbaytONayP1noMKIEQFCGQEcmi2fMIRIWpspwA5P3ORE0VLJZ7+jLQBXJBZVBvFl5OjOx8QikxLHvNwDB4VtmuIC4EUB4Z7VqJa/icGQHMa0yMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UGq+eH58; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0832EC43390;
	Thu, 15 Feb 2024 12:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708001428;
	bh=lseFDQJM8qNvU3yj0wMReSBJVd1/JCzB82G2JnOLCuk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UGq+eH58DPHsK6eR6iDYfdZObmWO/+yl7RgObrNvyK/rj7MX/XPHlkPmHtEBwfLvx
	 jD4+Y3Gr+/y5CTuVpBKVGWN1bUw+jcfma+gFSae8QG9lVQXpS8JFBKyLlvHuNy9yWT
	 GAQ9drF6y2puds5cr8WKVJ8QOoybbVRgVUq+nxV4yWgari1J95vHzLuXVy0/SPwiXo
	 2U3FykM2lODq58uDMRh7Ftbvyh56af+l03p5N1lzlrRuCAOSiyDlh0hRQ73n5+0I4o
	 h/M7d/f3hirhc+NW494+d5sbt1K8ICgvHSvNhrV5SFQBm+oKDJwFaXnwoGNzOHOY63
	 JyPwh7ScbcFJA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E53B5D8C97D;
	Thu, 15 Feb 2024 12:50:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] igc: Add support for LEDs on i225/i226
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170800142793.23237.9263271661945290312.git-patchwork-notify@kernel.org>
Date: Thu, 15 Feb 2024 12:50:27 +0000
References: <20240213184138.1483968-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20240213184138.1483968-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, kurt@linutronix.de,
 sasha.neftin@intel.com, andrew@lunn.ch, naamax.meir@linux.intel.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 13 Feb 2024 10:41:37 -0800 you wrote:
> From: Kurt Kanzenbach <kurt@linutronix.de>
> 
> Add support for LEDs on i225/i226. The LEDs can be controlled via sysfs
> from user space using the netdev trigger. The LEDs are named as
> igc-<bus><device>-<led> to be easily identified.
> 
> Offloading link speed and activity are supported. Other modes are simulated
> in software by using on/off. Tested on Intel i225.
> 
> [...]

Here is the summary with links:
  - [net-next] igc: Add support for LEDs on i225/i226
    https://git.kernel.org/netdev/net-next/c/ea578703b03d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



