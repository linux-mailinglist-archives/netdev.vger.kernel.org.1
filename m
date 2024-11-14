Return-Path: <netdev+bounces-144683-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D82E29C81AC
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 05:01:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66E72B24B13
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 04:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14F0D1EF09F;
	Thu, 14 Nov 2024 04:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qd6H8emP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB32F1E7C2D;
	Thu, 14 Nov 2024 04:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731556824; cv=none; b=Ff4Z82Nw+MMiuD2fZ3nuIDVt7FbpKd/+MgybKhOhHNziOZjBxuNUdrhJtU+zQFzPDrA6CGGRDDBFX8tZ/kYRXgIYnqcjP2JO92lkfRawGbHkHIalRuk6kQAeLT2Lr13aN+7hHV3yIUOMyCAMkgoTBQ87x+nVnIG9TIsQIQBOqNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731556824; c=relaxed/simple;
	bh=dxG+tZGmTslz/2FRjwyEyEKxiE6ZqLCZM9Ew3pvwU9c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZKUeTgDOl39NLf75OPHCCQoyIaHPPYQ+sInoBe1l2p4j5LJ5nttWE9kbKr6RPkVoiEYu6wCZSvazZq0GUFI81/pKhDiKZmwhC9yiBE0fCqvW+SMt4hmo8demaUpT+P2egzPfakThAlMtipP+2nP8IGvwDPxBa6mE9wTe7ffg6Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qd6H8emP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B609FC4CED4;
	Thu, 14 Nov 2024 04:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731556823;
	bh=dxG+tZGmTslz/2FRjwyEyEKxiE6ZqLCZM9Ew3pvwU9c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Qd6H8emPGVKDEOS9IbzPIsrMVFd79t4uZwkxsDCYxG3DVQtQgQ4A2K8Cd9UlLT0nn
	 Oa7YvSlPiR5se/cLkjEvWrC/3oL7YBqPZr+uP9a7n64ODrF+LoZK1xnpBae2qmDipw
	 kDaEz45O6M3K5LrOUBJ8P9EnFZ/Hm4olNPnFMQcsQ89XH2xFMTOPmnD4qKsyRN114q
	 4q32WXlSwx8nCWjo+P1w5irHx7OfQ1SwXM3dBO1O0XVkHVu21xcRBUid3pWQgUN0v6
	 BUw7NVEkO+ceXgF+s9Hpw43zSJ9kxyWZlwEDvmqhsQPqEbQaAof2wNMS0QTZGtXsyC
	 hDRGXdhFwwgWw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70DEA3809A80;
	Thu, 14 Nov 2024 04:00:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] net: dsa: microchip: Add LAN9646 switch support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173155683423.1476954.5750362637790539049.git-patchwork-notify@kernel.org>
Date: Thu, 14 Nov 2024 04:00:34 +0000
References: <20241109015705.82685-1-Tristram.Ha@microchip.com>
In-Reply-To: <20241109015705.82685-1-Tristram.Ha@microchip.com>
To:  <Tristram.Ha@microchip.com>
Cc: woojung.huh@microchip.com, andrew@lunn.ch, olteanv@gmail.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 marex@denx.de, UNGLinuxDriver@microchip.com, devicetree@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 tristram.ha@microchip.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 8 Nov 2024 17:57:03 -0800 you wrote:
> From: Tristram Ha <tristram.ha@microchip.com>
> 
> This series of patches is to add LAN9646 switch support to the KSZ DSA
> driver.
> 
> Tristram Ha (2):
>   dt-bindings: net: dsa: microchip: Add LAN9646 switch support
>   net: dsa: microchip: Add LAN9646 switch support to KSZ DSA driver
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] dt-bindings: net: dsa: microchip: Add LAN9646 switch support
    https://git.kernel.org/netdev/net-next/c/3a371e10521d
  - [net-next,2/2] net: dsa: microchip: Add LAN9646 switch support to KSZ DSA driver
    https://git.kernel.org/netdev/net-next/c/16220cb315a0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



