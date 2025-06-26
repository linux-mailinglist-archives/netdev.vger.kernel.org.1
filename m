Return-Path: <netdev+bounces-201554-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 255C0AE9E03
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 14:59:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3D4F189210E
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 13:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 805312E1C60;
	Thu, 26 Jun 2025 12:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d/qqZ7dy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5195B1B4F0A;
	Thu, 26 Jun 2025 12:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750942784; cv=none; b=ur1AWeBA0NkOiyk0kAGztF2Cw//mDAZCACSbyl2zDPd5cz47jSWDFrwWjbUoifRlERs6aIaVNcyhzfGE3jKQzFdZE6lU9Fjl0NB8kfe0lG8w1l6RLpokHYlv/ofaPh4zdhMiOWum05wJV5ALPiv8dJeXFfrQY+B+yYpcaKEuhBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750942784; c=relaxed/simple;
	bh=IAXNpebqwGnH811nNw8L01SUPSZ3BgHcGCCaxklgrRE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Z1/6Ej9KCyl7+JZLtAaN3whUYSO6uHolu/ra2xZdNOmHjA2GP52mDFlPZvvJg89yoSBP6W+phzpzHZoqbTmeOGG4AqZZ7sMl6MHEBoDYgGkLjtAxu9eOKJxSFl5euppD0waGjeaK44/nW23eciiHw3zw6pYP/jAHdykO9GF24P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d/qqZ7dy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7669C4CEEB;
	Thu, 26 Jun 2025 12:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750942783;
	bh=IAXNpebqwGnH811nNw8L01SUPSZ3BgHcGCCaxklgrRE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=d/qqZ7dyCecxQKoEp5C35mf0tY4Xei9auWHqGsR+F9UrbkKr69tVvLudUDG4XxJ09
	 a5j1CYSj1xHNmcd0LbVblPMIKgRvy8tfKOy0xJzN9cHuat4mwXLEYVGZA1ISN1xecQ
	 s9SabDo+LhrpJg1ySV25ND1qwaGJD8hXKTTgELIBRjG0aVXT5MAr1w6j9TwHLbj3z8
	 M7E777DhFQny545XpEmMRd5hWi4lKZYEaUjq9AJrh8u4znu+tDflQ6+VXnHsKS7G/M
	 A6zti8w8PaQTBbMDTp9zckisrJcRDg6P1p7qDekkFhJNofeAkWFb1Do96sC2iIDzCY
	 VRQHpRth77i4w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D883A40FCB;
	Thu, 26 Jun 2025 13:00:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/3] Follow-up to RGMII mode clarification:
 am65-cpsw fix + checkpatch
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175094281025.1193227.2852193769422273929.git-patchwork-notify@kernel.org>
Date: Thu, 26 Jun 2025 13:00:10 +0000
References: <cover.1750756583.git.matthias.schiffer@ew.tq-group.com>
In-Reply-To: <cover.1750756583.git.matthias.schiffer@ew.tq-group.com>
To: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, apw@canonical.com, dwaipayanray1@gmail.com,
 lukas.bulwahn@gmail.com, joe@perches.com, corbet@lwn.net, nm@ti.com,
 vigneshr@ti.com, s-vadapalli@ti.com, rogerq@kernel.org, kristo@kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux@ew.tq-group.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 24 Jun 2025 12:53:31 +0200 you wrote:
> Following previous discussion [1] and the documentation update by
> Andrew [2]:
> 
> Fix up the mode to account for the fixed TX delay on the AM65 CPSW
> Ethernet controllers, similar to the way the icssg-prueth does it. For
> backwards compatibility, the "impossible" modes that claim to have a
> delay on the PCB are still accepted, but trigger a warning message.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/3] dt-bindings: net: ti: k3-am654-cpsw-nuss: update phy-mode in example
    https://git.kernel.org/netdev/net-next/c/9b357ea52523
  - [net-next,v2,2/3] net: ethernet: ti: am65-cpsw: fixup PHY mode for fixed RGMII TX delay
    https://git.kernel.org/netdev/net-next/c/ca13b249f291
  - [net-next,v2,3/3] checkpatch: check for comment explaining rgmii(|-rxid|-txid) PHY modes
    https://git.kernel.org/netdev/net-next/c/e02adac7c84b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



