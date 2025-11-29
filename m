Return-Path: <netdev+bounces-242662-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD637C937C3
	for <lists+netdev@lfdr.de>; Sat, 29 Nov 2025 05:03:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99B6F3A98A1
	for <lists+netdev@lfdr.de>; Sat, 29 Nov 2025 04:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8342D1EE7B7;
	Sat, 29 Nov 2025 04:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iUO6gEK8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5D13C17
	for <netdev@vger.kernel.org>; Sat, 29 Nov 2025 04:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764388991; cv=none; b=G9UxDM7qGEbO3s8XVx4/Nfj7JFEyTu9mDFz462ipsZ5Pnj5lisoCMMmpQW7z/LZUjLTYpS1v38zMSZV2GMagcraM5pWPXCaW7JBHP1GoYwxMTvkLL+0/VP8sYL7G3+ZMclN1NgIf0CBdQZIqo95cbPz1/lWhB0d/cZcgh5OK61Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764388991; c=relaxed/simple;
	bh=4S31z0xBDs/RgGCpfUZeuBWF6Syx+n0tLhqRAEuQ+k4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UphsIXycgdY7pFxnmkf13HO7i+UZMxl0uC8KVQ3oiN9u6eq+CblvC/7ZUtcuPpVaQFVa+B7z6Jm2A5q8h62re75ropyRcvZ0IOGliHpdYopO2b95LIcP95rRDM40rQGw4vx9lHXb5YTYAkBmh6446D63I+glutEHtJ8rBF+8zMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iUO6gEK8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E07D0C4CEFB;
	Sat, 29 Nov 2025 04:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764388990;
	bh=4S31z0xBDs/RgGCpfUZeuBWF6Syx+n0tLhqRAEuQ+k4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=iUO6gEK8sbz1o2UH099T/MJp6+FJppHGvO/rYKtqaBLSR2nA6XPQVlvvOAA9u4WlB
	 rVxBX8BMQnliUGURqMSFwDmZYzDx78M+LwYT+1Qa1uc472fbWyleJ+Mnlywuq+2aQK
	 z0p10Iz3URxA80sMNomSKr3lMU4XMkwZa0gAp6fG6cOHG6gGshQv1pyleiwlylq0c1
	 fQOIzLNi6eK9pBhneOIiUixDq8O0TWw5N+5lpPDL+9R/KxzpnlZOhvkfd1u0eW/3D5
	 K8pwKJPBiNCm/oKYQsil8UfYegAJKz43oZp//mLFbCH9U0VTCHidGWPVH0CsUSIV3H
	 p5QLGSmr0Nx1A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B591B380692B;
	Sat, 29 Nov 2025 04:00:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v1 0/4] tools: ynl: add schema checking
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176438881254.889338.1213232869745501312.git-patchwork-notify@kernel.org>
Date: Sat, 29 Nov 2025 04:00:12 +0000
References: <20251127123502.89142-1-donald.hunter@gmail.com>
In-Reply-To: <20251127123502.89142-1-donald.hunter@gmail.com>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, andrew@lunn.ch, matttbe@kernel.org,
 chuck.lever@oracle.com, fw@strlen.de, one-d-wide@protonmail.com,
 kory.maincent@bootlin.com, gal@nvidia.com, o.rempel@pengutronix.de,
 sdf@fomichev.me, jstancek@redhat.com, liuhangbin@gmail.com, noren@nvidia.com,
 netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 27 Nov 2025 12:34:58 +0000 you wrote:
> Add schema checking and yaml linting for the YNL specs.
> 
> Patch 1 adds a schema_check make target using a pyynl --validate option
> Patch 2 adds a lint make target using yamllint
> Patches 3,4 fix issues reported by make -C tools/net/ynl lint schema_check
> 
> Donald Hunter (4):
>   tools: ynl: add schema checking
>   tools: ynl: add a lint makefile target
>   ynl: fix a yamllint warning in ethtool spec
>   ynl: fix schema check errors
> 
> [...]

Here is the summary with links:
  - [net-next,v1,1/4] tools: ynl: add schema checking
    https://git.kernel.org/netdev/net-next/c/362d051c90b6
  - [net-next,v1,2/4] tools: ynl: add a lint makefile target
    https://git.kernel.org/netdev/net-next/c/129dc6075a15
  - [net-next,v1,3/4] ynl: fix a yamllint warning in ethtool spec
    https://git.kernel.org/netdev/net-next/c/acce9d7200e2
  - [net-next,v1,4/4] ynl: fix schema check errors
    https://git.kernel.org/netdev/net-next/c/1adc241f3940

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



