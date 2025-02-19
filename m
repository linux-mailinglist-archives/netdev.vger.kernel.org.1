Return-Path: <netdev+bounces-167593-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DD94A3AFB6
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 03:40:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20ECE188E62F
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 02:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18F20187553;
	Wed, 19 Feb 2025 02:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IJ3Obrke"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C5642A87;
	Wed, 19 Feb 2025 02:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739932801; cv=none; b=nBvwEyjTO2Fofy2tFg+5zqFgW1cs3L78tiW0T/SYa+Xy4n13arkYdFqcdvxXFtguFGzGGyAZ12stASep9CQVFYcyXuItiSWMAtJX6KWb+3263QGD7L1S3mJmZNDwzrVMy3ddDWcwY0MyPwR7ErdpmOONFQKh9HxP/yab4vb595Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739932801; c=relaxed/simple;
	bh=RNBnfQbcPyk0DjK9e2uSGqyoJkPgva5JS7gLsql0E0w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=J6B2F2shWIxWIfJlTcnhrIkaGc/29Cbd0kJP+QagdK6yVdthsm3xUh+y1ElO8OSN21bx6Jr/oLYLbaU1jxmzh916oaaArT4dwm/i47cNR5quGYQ2CCfwT/dosXDMRhYtTfkAFq95efeLRfgKwwN7dJ4VBemcXtVBq8ph/bJvioA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IJ3Obrke; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D70BC4CEE2;
	Wed, 19 Feb 2025 02:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739932800;
	bh=RNBnfQbcPyk0DjK9e2uSGqyoJkPgva5JS7gLsql0E0w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IJ3Obrkeuxq9xRjxhtPLSG+LWd8qRt/kxcp90nddOVJnCtTuyDDaPupZNt5G4JpTx
	 45SS5ZyEIIsuTSYHmYxyag0RyioXqkvr8/pJjujYpZMq2M7YHAOvfCe0Zy6sXSNiAH
	 3ITH6hf78p3YT81JBTYCcesywLecFztBPMC7UYNnclSH11MRbLImrBJoTN+fVZrSzO
	 gPpq5hvWFunNT9xMpRv/ArkC9kK2SJu7TYUG6PIzcT/3GkA7txjlk6dEEVGF9ogimG
	 3ZU0USdG5nzScuyu3hG9/lw2rca4ntbiHxz+1QWz14sbxVmNlp3UTmvQeCNSD+ZVBM
	 ExC0xm/pQKayw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD7B380AAE9;
	Wed, 19 Feb 2025 02:40:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: pse-pd: pd692x0: Fix power limit retrieval
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173993283078.110799.14750805778268266261.git-patchwork-notify@kernel.org>
Date: Wed, 19 Feb 2025 02:40:30 +0000
References: <20250217134812.1925345-1-kory.maincent@bootlin.com>
In-Reply-To: <20250217134812.1925345-1-kory.maincent@bootlin.com>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: kuba@kernel.org, o.rempel@pengutronix.de, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 17 Feb 2025 14:48:11 +0100 you wrote:
> Fix incorrect data offset read in the pd692x0_pi_get_pw_limit callback.
> The issue was previously unnoticed as it was only used by the regulator
> API and not thoroughly tested, since the PSE is mainly controlled via
> ethtool.
> 
> The function became actively used by ethtool after commit 3e9dbfec4998
> ("net: pse-pd: Split ethtool_get_status into multiple callbacks"),
> which led to the discovery of this issue.
> 
> [...]

Here is the summary with links:
  - [net] net: pse-pd: pd692x0: Fix power limit retrieval
    https://git.kernel.org/netdev/net/c/f6093c5ec74d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



