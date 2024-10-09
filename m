Return-Path: <netdev+bounces-133577-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60163996586
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 11:36:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DD881F213F6
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 09:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5973718E754;
	Wed,  9 Oct 2024 09:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WLRtnUtQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA3C18E743;
	Wed,  9 Oct 2024 09:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728466236; cv=none; b=Ld/jlMcrZr+MvcXzqgbd9ARoW4VkF5c7cpPwO/d+S55j+ww26OvzI0fruMX12llUIZuUdQPgwEgzSuNDK0bwnABmvQ8RT2LKMvoxtzlpmXh0o0c+VnzbslqguK9v3Z99bIKIxQ3zUqiLIAwj6s5c0uMuU6VCCvqz4i0P48GcoFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728466236; c=relaxed/simple;
	bh=w+hUd5UysMUV8lR+b6rc42MatMKSyrmK70nsbD1loHI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Bi/iTt3xZLrcwVAUjsK49nXjeRM2sIg1nFz26tF+RZVoOliGOxPjCtpGD4y+1fJ0fwchdVnCUXjB1zwew+eqHGoa3QsUiOpN+rXWMjY/62kNjmbnfC78gxL7axy/QHs44MDf4J1IgH0v2xUujV2vMB/Q/b21J0jt3bH1GDGYqK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WLRtnUtQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B696BC4CEC5;
	Wed,  9 Oct 2024 09:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728466235;
	bh=w+hUd5UysMUV8lR+b6rc42MatMKSyrmK70nsbD1loHI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WLRtnUtQAxhNrRil08XVBcn3LMbIuQI8ePTHg3X/r/nNsE4xmJO7lUoS1sYYbiguF
	 QAGGBcGsJPwfl4ti2r14PRLmE4Nxg72kG+TXIsPNotOAYijWxTzRWFh93jUfwYkE6i
	 NEZn7cpJMVdSp4RkiJ+TANqXitKkscYRAJyt992oNYJCF0yQCmBDlfDyzBLN9gZMh7
	 xdoid7VCbl0p5dAaBh2ksFev0vtV+c1wASallko5DMVM9LnLB+evUvERILQN/5o6y6
	 MSDT+g+IsLmiLNmDFTmKdS+ftW509Z29audVK7FuIDxrNEvg7NM4s+mAFIRWfKlMZy
	 XCKQa6G1LkGCw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33FE13812FDB;
	Wed,  9 Oct 2024 09:30:41 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH ethtool-next v2 0/2] Add support for new features in C33
 PSE
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172846624002.1190711.608859303082823097.git-patchwork-notify@kernel.org>
Date: Wed, 09 Oct 2024 09:30:40 +0000
References: <20241007-feature_poe_power_cap-v2-0-cbd1aa1064df@bootlin.com>
In-Reply-To: <20241007-feature_poe_power_cap-v2-0-cbd1aa1064df@bootlin.com>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: o.rempel@pengutronix.de, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, andrew@lunn.ch, mkubecek@suse.cz,
 kyle.swenson@est.tech, thomas.petazzoni@bootlin.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to ethtool/ethtool.git (master)
by Michal Kubecek <mkubecek@suse.cz>:

On Mon, 07 Oct 2024 14:18:48 +0200 you wrote:
> From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
> 
> This series adds support for several new features to the C33 PSE commands:
> - Get the Class negotiated between the Powered Device and the PSE
> - Get Extended state and substate
> - Get the Actual power
> - Configure the power limit
> - Get the Power limit ranges available
> 
> [...]

Here is the summary with links:
  - [ethtool-next,v2,1/2] ethtool: pse-pd: Expand C33 PSE with several new features
    https://git.kernel.org/pub/scm/network/ethtool/ethtool.git/commit/?id=2d451b165afa
  - [ethtool-next,v2,2/2] ethtool.8: Add documentation for new C33 PSE features
    https://git.kernel.org/pub/scm/network/ethtool/ethtool.git/commit/?id=f64d352479fd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



