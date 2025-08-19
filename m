Return-Path: <netdev+bounces-214798-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4CA6B2B552
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 02:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 460C51967E18
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 00:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 901401547F2;
	Tue, 19 Aug 2025 00:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZT7Qe8mH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6823C52F99;
	Tue, 19 Aug 2025 00:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755563402; cv=none; b=NgiqZmyLfyNQCimYGqXqBkS3C4q1bVLkyef5YxRJ86bgpuLeZSNanh9lB+Za1/tnzsHIGP1K3XsnWYTaEyIY7w09i6UcowOTrbj9Jzjcef/2t/jqHhdiWymNWKu/fFvLFYdrhcUIcVX4Bbye5ilP5DTE7W9b7Jt+43VXtNF50UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755563402; c=relaxed/simple;
	bh=RFt1dn+PPWlqIFCRc+D9+wR0+VBCkqQgtVq4RbxXDeg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lAPKozUdwy1QCKAtvTS7RzjU+AJ88TVwrtZBIk1UQ0CCejlNPYdZ36lGX1vYIq38W/fd9+OriQU+ewHrkOWMi8egY4fb2YpTqGhswkv/DVFfQ9G+yubpOmmyGJX+lnt6i46lt9cGGKs+qGz6dd+jfWwl3ZHowXRS33erK2pdbm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZT7Qe8mH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 164BBC4CEEB;
	Tue, 19 Aug 2025 00:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755563401;
	bh=RFt1dn+PPWlqIFCRc+D9+wR0+VBCkqQgtVq4RbxXDeg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZT7Qe8mHTaIsuuIRe1LorU83gdwWzIxbx9TvZE4nzjz8Z+qRj7CZewohEZ5+4OuA7
	 f0EYl5hKsq2/lpwCdqUOjGVnRMAR0IEAq3kcwqq6LdbI5trU4ApV59E47R2ZnM8MxA
	 TyaLpPhnygO1qD8iSvaGJseJ9GTWixevnGCvdVxjnpuxihRL2beIIVLBf41jhsw3i5
	 +eeCCy38SFjMiP0qkBYWT8TkZdjMecKdCSL95GUZUHpA1i7eW6z8C0d9Sak2/Y1TLP
	 7TR2TX4bNnJw1yNxbKEikMZjR7S16jvKsH/ip6eND5ViJiPYAbHFWFiHUJC2l6FiCJ
	 v1WrTRtJYIqlA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C12383BF4E;
	Tue, 19 Aug 2025 00:30:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] dt-bindings: net: realtek,rtl82xx: document
 wakeup-source property
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175556341073.2959470.10863501687650482434.git-patchwork-notify@kernel.org>
Date: Tue, 19 Aug 2025 00:30:10 +0000
References: <E1um9Xj-008kBx-72@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1um9Xj-008kBx-72@rmk-PC.armlinux.org.uk>
To: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, andrew+netdev@lunn.ch,
 conor+dt@kernel.org, davem@davemloft.net, devicetree@vger.kernel.org,
 edumazet@google.com, f.fainelli@gmail.com, kuba@kernel.org,
 jonathanh@nvidia.com, krzk+dt@kernel.org, netdev@vger.kernel.org,
 pabeni@redhat.com, robh@kernel.org, treding@nvidia.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 13 Aug 2025 12:21:19 +0100 you wrote:
> The RTL8211F PHY has two modes for a single INTB/PMEB pin:
> 
> 1. INTB mode, where it signals interrupts to the CPU, which can
>    include wake-on-LAN events.
> 2. PMEB mode, where it only signals a wake-on-LAN event, which
>    may either be a latched logic low until software manually
>    clears the WoL state, or pulsed mode.
> 
> [...]

Here is the summary with links:
  - [net-next] dt-bindings: net: realtek,rtl82xx: document wakeup-source property
    https://git.kernel.org/netdev/net-next/c/a510980e740c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



