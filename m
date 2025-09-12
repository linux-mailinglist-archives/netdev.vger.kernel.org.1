Return-Path: <netdev+bounces-222380-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3075CB5401A
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 04:01:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62BAD162785
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 02:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED3961F0E24;
	Fri, 12 Sep 2025 02:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SZ7/z2/z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E3214A4F9;
	Fri, 12 Sep 2025 02:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757642434; cv=none; b=Obje/X+wkZbWyS/gr8KAWRiuxAjO1RNtEPUf/XSM0DqgS8b2JGb6kXXX5mOWFt8+EoG3OdgYgOdOnSvTU1Sh8ySBBrkJrVu9D8XssOBItU3TuDq1hpwbOg0Tx0bvfUlWi5i/nH82RguXSHFRo568B3cbYYTsR5vUtDQalJDq0vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757642434; c=relaxed/simple;
	bh=lQHo9yakV1KI7t69pyyUhbVWNVWueTyKjGkrp5ga3RU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lORVOBtEWxAfbAFm1x5Re+2XYi8rw3X5hzBIV2PXOm/Fzx1R0CAJopiG+tdXEW0cb7KbFM9zfqm4tX1IFOUqt7qHekWZRzwf+VJZOzHUakHZMNd3LCnXm3g6I40NN/ciFPtEByZKymh2jCCMOYNISy3hDid9TXOMkHRNQx2LEFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SZ7/z2/z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5E83C4CEF0;
	Fri, 12 Sep 2025 02:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757642434;
	bh=lQHo9yakV1KI7t69pyyUhbVWNVWueTyKjGkrp5ga3RU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SZ7/z2/zkyFRBkp+Z7zfy8l5/SJcgtjwNLqRfRFV/JGkJT89tKcduedVwSjmNZYaz
	 DmU70W2I71bXzzYfhTgOzV3m1lIDSMhS2/tQ960SDXztrjBxrlrrFerWm16yLpnKEI
	 qDUhBqhtbzLj+gdQCUfGXVwM58WeOAWnPlvusVlAVxysu93QcZ3H0k5xVoBiyjIAgb
	 DgnLjrBeL0l0gVS056jnv5svqlcFwB+J0+uisgeFFmUGGi/3QGZMJyspK5GUUTFq3X
	 xQiUJr7L30YkQT2hCHJH4xOxpqQEn/wBzmNDwxZJIBoJVij0KOoK2pzfFFEo/DO8Nu
	 2vzI5Cq1MaCKw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D0D383BF69;
	Fri, 12 Sep 2025 02:00:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] eth: 8139too: Make 8139TOO_PIO depend on !NO_IOPORT_MAP
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175764243699.2373516.15007912984676092023.git-patchwork-notify@kernel.org>
Date: Fri, 12 Sep 2025 02:00:36 +0000
References: <20250907064349.3427600-1-daniel@thingy.jp>
In-Reply-To: <20250907064349.3427600-1-daniel@thingy.jp>
To: Daniel Palmer <daniel@thingy.jp>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun,  7 Sep 2025 15:43:49 +0900 you wrote:
> When 8139too is probing and 8139TOO_PIO=y it will call pci_iomap_range()
> and from there __pci_ioport_map() for the PCI IO space.
> If HAS_IOPORT_MAP=n and NO_GENERIC_PCI_IOPORT_MAP=n, like it is on my
> m68k config, __pci_ioport_map() becomes NULL, pci_iomap_range() will
> always fail and the driver will complain it couldn't map the PIO space
> and return an error.
> 
> [...]

Here is the summary with links:
  - eth: 8139too: Make 8139TOO_PIO depend on !NO_IOPORT_MAP
    https://git.kernel.org/netdev/net-next/c/43adad382e1f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



