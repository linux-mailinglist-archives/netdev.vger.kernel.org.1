Return-Path: <netdev+bounces-229951-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A7F8BE2A8D
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 12:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B52505069C8
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 10:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C44F8324B1D;
	Thu, 16 Oct 2025 10:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ovc7WHjf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97620323406;
	Thu, 16 Oct 2025 10:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760608823; cv=none; b=DFCckOIfFuHqtL3ntNLWrJmnyOyXk6CQyuRyzILET6+SNyvajqOhd/PnwzAHYvSxLIR+TTjXSm3SFnXDGC7Z//PLWPyU+9A7z9ZJmNuw/7DAxEv4ubyWsKbJYvUYBXfcvWREX+bsUNBdr7ycbbeshQWbV9MejDLszEhE5hQdmps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760608823; c=relaxed/simple;
	bh=zZzTGehl8RkLtLE90w5ehTnGUYhZ0q/XR0An8BOuubo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sqYX5WwEbyZc//WLrzBhWhKcG121C/yXw7uYMebrtmrcaCFSiYLTEaBNc9woBK0w8+8A1z/5zDQSkaa0NmkPkilwlDJN2sEXqDRRO8EbQTT4XCOrrVg82daAVKcG+7qW2h9kNYrAtmI65EKHB/D8gGBRic5g4JqgVdIe4po/ItU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ovc7WHjf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BDAAC4CEF1;
	Thu, 16 Oct 2025 10:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760608823;
	bh=zZzTGehl8RkLtLE90w5ehTnGUYhZ0q/XR0An8BOuubo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ovc7WHjf5o8SCOWaufEoO6z8VK5hAJB5P27XMNIfvG2ylwUnejg6Jvr12j9J2357v
	 7Icplv1jKplFfsDS9VHgvsHWsltPF0eNnI7ryAws2zP0Gp8nEj5hGlkfDia3vi0mgt
	 mxshHm4z6ajFdsNBbBMse6fC8hNY2tz1a3A1F+oEYP+c/x2PeS2MFhUbb1hPA9yYkd
	 S46Xfgfh9+AYDhfU7SoFXiHDeUD+J63pcVlVtX67oO5QLHXGBewCZm0goPKz7AQ/EA
	 krzKSmZtL2fQZTdEKFXfiPj8lIbfg2sCBPhbfWszV/GJzDx0VwoHC5XUx86clO4ZqO
	 TgaCHXxQFJ8Fg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE00A3822D5A;
	Thu, 16 Oct 2025 10:00:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] dt-bindings: net: Convert amd,xgbe-seattle-v1a
 to DT
 schema
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176060880751.1270689.8945701705596256519.git-patchwork-notify@kernel.org>
Date: Thu, 16 Oct 2025 10:00:07 +0000
References: <20251013213049.686797-2-robh@kernel.org>
In-Reply-To: <20251013213049.686797-2-robh@kernel.org>
To: Rob Herring (Arm) <robh@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, krzk+dt@kernel.org, conor+dt@kernel.org,
 richardcochran@gmail.com, Shyam-sundar.S-k@amd.com, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 13 Oct 2025 16:30:49 -0500 you wrote:
> Convert amd,xgbe-seattle-v1a binding to DT schema format. It's a
> straight-forward conversion.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  .../bindings/net/amd,xgbe-seattle-v1a.yaml    | 147 ++++++++++++++++++
>  .../devicetree/bindings/net/amd-xgbe.txt      |  76 ---------
>  2 files changed, 147 insertions(+), 76 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/net/amd,xgbe-seattle-v1a.yaml
>  delete mode 100644 Documentation/devicetree/bindings/net/amd-xgbe.txt

Here is the summary with links:
  - [net-next] dt-bindings: net: Convert amd,xgbe-seattle-v1a to DT schema
    https://git.kernel.org/netdev/net-next/c/00922eeaca3c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



