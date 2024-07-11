Return-Path: <netdev+bounces-110715-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 045AB92DE51
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 04:20:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D001B21CCB
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 02:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 826D2F9F0;
	Thu, 11 Jul 2024 02:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dxcj3vyU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D43E572;
	Thu, 11 Jul 2024 02:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720664433; cv=none; b=Qq0kTZqEKGrrYYq1dIskj17fDirC7hPWoCGj4VTWRyDQshvMD7JfLF+x14mGbkKG3YMPDvHpcHMuHDkLIb8WwDEo7u6pu8Xg+Lpvc71pUhmVW1lppulBslWpaGjlBD5082jJ6DNai8YA0YGaTULWkYk2M0Hsk0+cWhSnE7+HXzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720664433; c=relaxed/simple;
	bh=91a5G059o+c7SEd6rEUFbfqFaetOrMp/p5CAtHhbnww=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=W5dS/KO+gc3r5+fb5gehq0QdqlOUubl2+mQN4/c4kL163Q/KaU4/ArUobMt2TVADzpOodh+09kHpNyLx4Bl4K4L8+pdyBFXHe9NtsUijVltVSUlrX5edmCqv/hzD7RhCcAR8exP9yXcyT+cybrTySs0DbXYldantjj1Ne0Z3WVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dxcj3vyU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 01768C32781;
	Thu, 11 Jul 2024 02:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720664433;
	bh=91a5G059o+c7SEd6rEUFbfqFaetOrMp/p5CAtHhbnww=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dxcj3vyUM04aIJyPdBc4QckQKuS6m2FlisWvuZFo5GsQYTErFgTYbrqwDDGPrXwyj
	 +YyTcq9GH0rbISEhmfXILoK2q1VPPsL0gYwbGEKLykRWdHmSqO8LQX1qo6HaQViBI7
	 CjxKQdp3dBp7QgSbRZTxSEq57wPgWhD+M/UZTXYBAMcJZ5CRo1ae6pulPXToBJwUKY
	 jqDUrc2PTV9dJC2EhOY10JDy/olQ6pdkaqgcJb0bDrSQEBhZ+eATMaLyrbCsPfSmlt
	 0pwDtx/Lm8FddwwOYNNTkxrNn0fm4mcJZ1fVFGBrZePu8j4OjTu8y++Lozwa/q+2iz
	 jpHCgn3CQ26Sw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E9CA7DAE95B;
	Thu, 11 Jul 2024 02:20:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 1/1] dt-bindings: net: convert enetc to yaml
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172066443295.28307.4062455810710183011.git-patchwork-notify@kernel.org>
Date: Thu, 11 Jul 2024 02:20:32 +0000
References: <20240709214841.570154-1-Frank.Li@nxp.com>
In-Reply-To: <20240709214841.570154-1-Frank.Li@nxp.com>
To: Frank Li <Frank.Li@nxp.com>
Cc: robh@kernel.org, Frank.li@nxp.com, conor+dt@kernel.org,
 davem@davemloft.net, devicetree@vger.kernel.org, edumazet@google.com,
 imx@lists.linux.dev, krzk+dt@kernel.org, krzk@kernel.org, kuba@kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  9 Jul 2024 17:48:41 -0400 you wrote:
> Convert enetc device binding file to yaml. Split to 3 yaml files,
> 'fsl,enetc.yaml', 'fsl,enetc-mdio.yaml', 'fsl,enetc-ierb.yaml'.
> 
> Additional Changes:
> - Add pci<vendor id>,<production id> in compatible string.
> - Ref to common ethernet-controller.yaml and mdio.yaml.
> - Add Wei fang, Vladimir and Claudiu as maintainer.
> - Update ENETC description.
> - Remove fixed-link part.
> 
> [...]

Here is the summary with links:
  - [v3,1/1] dt-bindings: net: convert enetc to yaml
    https://git.kernel.org/netdev/net-next/c/d00ba1d734f7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



