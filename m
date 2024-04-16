Return-Path: <netdev+bounces-88237-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C73F58A669C
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 11:00:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 722D428421C
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 09:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A430584D27;
	Tue, 16 Apr 2024 09:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="djGqGdT+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E87D84D0A
	for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 09:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713258029; cv=none; b=oJR4lHpJAm0EMaIHWq6HBSkV43zk4ny1zZyzE+7zd24Dx/CpI0MP4WIACyTAIoPSGT918OqLbWAhXkD4vQZ6y5PgyNt+ZeM4cETRvPulBbsdQxQW/ixYKut0K4o0jPaOJOezhJnOWtQo+QaN4VAWUnH8FeJFGqoHQm0JyneMzwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713258029; c=relaxed/simple;
	bh=eUPa4CY0E38/VfEcdCp6Ey7k0LC2+x4LHXpqYO28Xnc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NmakdxL9/LLEa2E1WG9cWStSm+SPewrZa8j17W0Vnobdc7tn/dGSE2hRXr1uLv6IdXrmeUVSo6IxL/dNVUk9CD8KhoObcGeAP21ZJQpMKTRgVqPzFBwMcSQizcO9Z2kyn6KVrAKH7LORdJI02FUY+GnbzLJ3bb/JhMzegC1+dl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=djGqGdT+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 30BEFC32783;
	Tue, 16 Apr 2024 09:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713258029;
	bh=eUPa4CY0E38/VfEcdCp6Ey7k0LC2+x4LHXpqYO28Xnc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=djGqGdT+nHJz6UfUfN68OCvCP8wC/eN0VcV/lh+zwdFC9zeCR3EXtGMZH6f09pKJA
	 7w9+rFWrJuS+pzcaKZQBk0HPWSSgAU5tuR7a9k3UWcCgQtYZH0+Jdf+u9Pq4YfBEMb
	 z5czhZR2MROTRXo4YnxEUR7EJEZsb599QZJjzCR5vpPyyrFw4pg8ai1LSita9QYgHr
	 1+UD73gR2k3Po10zlq5zXJox7KGPeXWbdbtkhnU23kNW3mPOOryuwUQCzR84idLubH
	 hsYL/QKzjFv8brHW6isUtXMnxAuVzWAeIgqMguFT0urKiMFQnQd+DWg56epJsY/IHT
	 RhvynQfJVYVLw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1F75DC54BC9;
	Tue, 16 Apr 2024 09:00:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: dsa: sja1105: provide own phylink MAC
 operations
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171325802912.5697.524059242703515829.git-patchwork-notify@kernel.org>
Date: Tue, 16 Apr 2024 09:00:29 +0000
References: <E1rvIcT-006bQW-S3@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1rvIcT-006bQW-S3@rmk-PC.armlinux.org.uk>
To: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Cc: andrew@lunn.ch, olteanv@gmail.com, f.fainelli@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 12 Apr 2024 16:15:13 +0100 you wrote:
> Convert sja1105 to provide its own phylink MAC operations, thus
> avoiding the shim layer in DSA's port.c
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>  drivers/net/dsa/sja1105/sja1105_main.c | 38 ++++++++++++++++++--------
>  1 file changed, 27 insertions(+), 11 deletions(-)

Here is the summary with links:
  - [net-next] net: dsa: sja1105: provide own phylink MAC operations
    https://git.kernel.org/netdev/net-next/c/0be9a1e43a07

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



