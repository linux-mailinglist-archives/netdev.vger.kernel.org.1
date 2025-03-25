Return-Path: <netdev+bounces-177549-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A39FA70879
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 18:50:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC7511898F0A
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 17:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DD84261589;
	Tue, 25 Mar 2025 17:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cPRQT6aG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06627823DE;
	Tue, 25 Mar 2025 17:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742924996; cv=none; b=n8Luft6APjGLA90piCqklsoism46AOvxKV8MDAAXfoWhLoQN6T0pvw1bsTbKTjtYE0WeIJo4kUqWGm4tauR0mELbVTmR5n2zsaGM2VBGsHHtAyFosQ+xujUHqj8RfbskkP2Qbu7PHA0Ci2tArfMIo4+UnwbmR5K3vpKIJ/P6iyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742924996; c=relaxed/simple;
	bh=fXNGoMVgA/lV4mzFQV328bKi6aGfnEXdGRIOPBHvYrQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ck2XXmBmQYjEjtFXf7xC4EWrstApHnOUefe44e8G3OiQZ1um2aNRQpGgUnXs8HO3MBBquGkvuum7N7chGuoA8q1j6AhgQ3y0U3b2R4CtBe4uiuyFlgjouKsZ2hHvrF8yFIziQi+he0PwImvHE5brP0+nPaAUrWSGDf/XKOT8Gqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cPRQT6aG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E99BC4CEE4;
	Tue, 25 Mar 2025 17:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742924994;
	bh=fXNGoMVgA/lV4mzFQV328bKi6aGfnEXdGRIOPBHvYrQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cPRQT6aGTvsTqdQb0C0lkQcvHfoZMj5bDIRJ4Qju4rBYtttmznNCGSr3dKPY5dj9o
	 zXSYSLHAw06RY7iG9j1oGN09ucYGb0CqJv3a2dRKIE8BVbxL+B6p0GCGt+OYBeqP7m
	 gAHgbOKOBxrQT2/Baiam5ZEBes8IfyKvvjmQHuIJuOZjJulHz4UMLMrG7iTlniVDdn
	 f5s+5mRGql0b+r/gqjgb4ulUHU7XZOqPhn8ehtr+rvxL6bXalpQhfhVj3T0ovzlFjT
	 EzDfx3jkEg/9D8DSjjmk7PU9IRvzzE/kPqaqoc5a4bVi2S8nyH3mfIm5GE04pvfiCk
	 2Z8lQGF5HUg2w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB0C7380CFE7;
	Tue, 25 Mar 2025 17:50:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v1 1/1] net: dsa: microchip: fix DCB apptrust
 configuration on KSZ88x3
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174292503077.665771.5935325950611276531.git-patchwork-notify@kernel.org>
Date: Tue, 25 Mar 2025 17:50:30 +0000
References: <20250321141044.2128973-1-o.rempel@pengutronix.de>
In-Reply-To: <20250321141044.2128973-1-o.rempel@pengutronix.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: davem@davemloft.net, andrew@lunn.ch, edumazet@google.com,
 f.fainelli@gmail.com, kuba@kernel.org, pabeni@redhat.com, olteanv@gmail.com,
 woojung.huh@microchip.com, arun.ramadoss@microchip.com,
 kernel@pengutronix.de, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 UNGLinuxDriver@microchip.com, san@skov.dk

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 21 Mar 2025 15:10:44 +0100 you wrote:
> Remove KSZ88x3-specific priority and apptrust configuration logic that was
> based on incorrect register access assumptions. Also fix the register
> offset for KSZ8_REG_PORT_1_CTRL_0 to align with get_port_addr() logic.
> 
> The KSZ88x3 switch family uses a different register layout compared to
> KSZ9477-compatible variants. Specifically, port control registers need
> offset adjustment through get_port_addr(), and do not match the datasheet
> values directly.
> 
> [...]

Here is the summary with links:
  - [net,v1,1/1] net: dsa: microchip: fix DCB apptrust configuration on KSZ88x3
    https://git.kernel.org/netdev/net/c/1ae1d705a112

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



