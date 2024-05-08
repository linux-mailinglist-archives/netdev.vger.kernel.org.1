Return-Path: <netdev+bounces-94516-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE1B58BFBD2
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 13:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98218283161
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 11:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2245481ADA;
	Wed,  8 May 2024 11:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bry7/Lq5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF6981AC1;
	Wed,  8 May 2024 11:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715167228; cv=none; b=IQaULi20EZtoDNFbBPU1cfxGxj1tXWXKGQ8nfWApWYUyQpETOpCw6Ca57ggH94/XeFYuDxifXywXORY1f+HBB2zE30EkKLr9nwNoBL92GqX5gQSgNdphwvM8HtbfKKP++V0dP2Cp1rgwHwv2uk2zcUjyGavNe1RVR+e9GG2CQFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715167228; c=relaxed/simple;
	bh=0+VwHpzGHkbuM7QaLfLHuaMbHW99UXIga61BE8FZoJk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=P9iYOi3BsqlAiLQR4NOe/wd2im/B5QMA5MBXc1ejyZ/Vf1jRMa5zbtqF5i5BJrgfxNQ/Pv74mt6ntGO5VRc5Ui3lWvpQbYtjC4O4SvglJbaJyIimILgAV/tFBAgJkG/38QAYDukgMXqtEDVbzlTVld21W0jVNxWsYFTTSkKGGjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bry7/Lq5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A3259C4DDE0;
	Wed,  8 May 2024 11:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715167227;
	bh=0+VwHpzGHkbuM7QaLfLHuaMbHW99UXIga61BE8FZoJk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Bry7/Lq5NCWL07rryDg8wZ2QRAC3Ixp8gdjgxm87wEVZ6BQN+aggWzQXe4YXWmtL4
	 EV6N0iFFFbdzX/RjIFMrkBedWvRceB7cgvLyU/aTLnsBjv5W37efcp7Z8/1mMuuA26
	 zFAlKg0boiko35vHcCOiIjm491MQUeJmlpIq0hr86beaXyINEJqGWDRGDe03vp2kcf
	 rbLtxIGIPmAAjaHdD1YsWHrsiSPknrunAE5dGk+Xq86pxPFKee+sj0YKz1+2bDDcz3
	 CrliY+jy+KSlHLreMrUyHLayJGA71iVtTxAEdssTLqkj+xyhLsenbWc61vdY6dA+Hr
	 +Ejdp3W3ygyTQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 97319C3275D;
	Wed,  8 May 2024 11:20:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4 1/1] net: bridge: switchdev: Improve error message
 for port_obj_add/del functions
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171516722761.3007.2031349363720650784.git-patchwork-notify@kernel.org>
Date: Wed, 08 May 2024 11:20:27 +0000
References: <20240506103205.1238139-1-o.rempel@pengutronix.de>
In-Reply-To: <20240506103205.1238139-1-o.rempel@pengutronix.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: jiri@resnulli.us, ivecera@redhat.com, davem@davemloft.net, andrew@lunn.ch,
 edumazet@google.com, f.fainelli@gmail.com, kuba@kernel.org,
 pabeni@redhat.com, olteanv@gmail.com, horms@kernel.org,
 kernel@pengutronix.de, linux-kernel@vger.kernel.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon,  6 May 2024 12:32:05 +0200 you wrote:
> Enhance the error reporting mechanism in the switchdev framework to
> provide more informative and user-friendly error messages.
> 
> Following feedback from users struggling to understand the implications
> of error messages like "failed (err=-28) to add object (id=2)", this
> update aims to clarify what operation failed and how this might impact
> the system or network.
> 
> [...]

Here is the summary with links:
  - [net-next,v4,1/1] net: bridge: switchdev: Improve error message for port_obj_add/del functions
    https://git.kernel.org/netdev/net-next/c/b7ffab29a8e4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



