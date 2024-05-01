Return-Path: <netdev+bounces-92681-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ABB58B8400
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 03:40:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D36662842CA
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 01:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40847567D;
	Wed,  1 May 2024 01:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dEc31AVs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AABF4C83
	for <netdev@vger.kernel.org>; Wed,  1 May 2024 01:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714527632; cv=none; b=ByAVTCISh8qTezwJjy/5J1AUbO0Imbjn5A4TKyRLMsQE2IcZzdUdnSccBI60094dCq8x4UiBt67q9V/CqpwyQ6Mfz9nw4nYNOAWEfMxHZjDACFfGnheHCFVcf7OeJ/Zn+/lGqwosgY6JXdxR0+8JAjsnEGwNHOlFdbHCcFHKy58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714527632; c=relaxed/simple;
	bh=gUSG19bGgkLjIvt9Qgah/wnfi4OdeX+anHhqj9VS5xA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=A9Z32cOAsIvHilVBQkCI2eg/ksN6Lmb26rI/1crUZ0DVHrZ8GFu73rTgMf4gXu2RtOBUp47CeBVCcrvIdHXbVyamfAW/RDwuMu1F8ztDmno2ATZE7HozC9txGpgfJgHB0HHf2Kw27yV77OvDgazc2v9c5262abEoJgKVRkQDFbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dEc31AVs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A04A9C4AF1A;
	Wed,  1 May 2024 01:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714527631;
	bh=gUSG19bGgkLjIvt9Qgah/wnfi4OdeX+anHhqj9VS5xA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dEc31AVsE+N57WHIF2TS/u1JjksUEjiJxjfXVNodOK/AsjlIDT3OoIwVbvOtDzrtd
	 YxQbBrH/BpBqzAmjEag5H97hq7lNczjES4K64Zgbr1BY3A/ObpXgxqaGOrMj2MB7wA
	 yR1qRnBpJU7LXixj5KUvrP8VN9MkNRpNvTGpDBSAwb5cOqq5MhLmgBckFyT6JrvZwa
	 Dd1AU/RR12ykOy+aDnG/492s/XUX5MmaAgLaTho0QwnrCRyQVQcMmwV2SlpleJTT9N
	 zyoynnaqMunuKqEeo+C4YA8Y0bNRD0V3dqJ6L6gkpnkpZiXyO4YtGR8FpFOpSFivBt
	 +8bo6vpY0ZvHA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8D9B7C43619;
	Wed,  1 May 2024 01:40:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: dsa: mv88e6xxx: Fix number of databases for 88E6141
 / 88E6341
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171452763156.16260.11628576675451965507.git-patchwork-notify@kernel.org>
Date: Wed, 01 May 2024 01:40:31 +0000
References: <20240429133832.9547-1-kabel@kernel.org>
In-Reply-To: <20240429133832.9547-1-kabel@kernel.org>
To: =?utf-8?q?Marek_Beh=C3=BAn_=3Ckabel=40kernel=2Eorg=3E?=@codeaurora.org
Cc: netdev@vger.kernel.org, andrew@lunn.ch, f.fainelli@gmail.com,
 olteanv@gmail.com, edumazet@google.com, gregory.clement@bootlin.com,
 vivien.didelot@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 29 Apr 2024 15:38:32 +0200 you wrote:
> The Topaz family (88E6141 and 88E6341) only support 256 Forwarding
> Information Tables.
> 
> Fixes: a75961d0ebfd ("net: dsa: mv88e6xxx: Add support for ethernet switch 88E6341")
> Fixes: 1558727a1c1b ("net: dsa: mv88e6xxx: Add support for ethernet switch 88E6141")
> Signed-off-by: Marek Behún <kabel@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net] net: dsa: mv88e6xxx: Fix number of databases for 88E6141 / 88E6341
    https://git.kernel.org/netdev/net/c/b9a61c20179f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



