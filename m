Return-Path: <netdev+bounces-182645-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75C8EA89788
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 11:10:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 217CD3A46C8
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 09:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03DAA27B50F;
	Tue, 15 Apr 2025 09:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VGKynCSL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC971C5F30;
	Tue, 15 Apr 2025 09:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744708195; cv=none; b=gyrT/DaCuRqXDej2shN+6JT56Git5Fym4KgFKAqJdMr40hYz1kIhbFBkMgIMOStURr77KH0HVh4taPHg2sHFOlCU2oNNRj7CUFG2MTwppXgZ31plS+RVRjOVVWLyRo2Ero7Bat3AECNqwoyfuelSRT9NkcqyprU/cyg2aItXeNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744708195; c=relaxed/simple;
	bh=QU0TDnCmOlC5at4GqseuNIx4V0NQRoTnucsnlynPrd4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pZVOdnCYS8AYIYpXIOBmYuo5jytoIkWNvGn/Cn/JeE6x4Sp5Z3NmunRw0L19Q4uwOlAbTnS+oGhteIYLUlkBFfEbWi1KBW76pUDVCLFqKPG0HUKUig33p3tTWRtnezR1q/f9IM4wZPuAQKRIheAbgbPi+AA7Eb0z0YXPD6hLNcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VGKynCSL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49863C4CEDD;
	Tue, 15 Apr 2025 09:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744708195;
	bh=QU0TDnCmOlC5at4GqseuNIx4V0NQRoTnucsnlynPrd4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VGKynCSL+JOplh35QC6l9uJ9gP/F4OXbsJ+sHvpKT5bSGhOyD/1PkQcfib47Lp3QX
	 +c4Glv9MbLc+WYYznoYQP6jCS5tvn79tYisMDac962cQRKhTjhhuJASJZWWw8BzE4d
	 oH7DGxbyH64qqW7rCNUi3ndP/dlHI3u4opc6jvVfW71E5ATqIE7rnw53nQz2WDRE40
	 zwqCQ79qiW35HC17RrPbtWr9sUyh7t/Htb/9KtoN0+DFlFclPilpLjCe+BEuES5y49
	 /5Mrt5s66oYJwPx5vSKkI1M9cgpCug0/PN/09hhFvjKVRRudZ22R9wYgxFET6FjiRA
	 Zvw2J5ilXUuWQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D7D3822D55;
	Tue, 15 Apr 2025 09:10:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: mdio: Add RTL9300 MDIO driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174470823327.2548774.7369464602426912158.git-patchwork-notify@kernel.org>
Date: Tue, 15 Apr 2025 09:10:33 +0000
References: <20250409231554.3943115-1-chris.packham@alliedtelesis.co.nz>
In-Reply-To: <20250409231554.3943115-1-chris.packham@alliedtelesis.co.nz>
To: Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 sander@svanheule.net, markus.stockhausen@gmx.de,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 10 Apr 2025 11:15:54 +1200 you wrote:
> Add a driver for the MDIO controller on the RTL9300 family of Ethernet
> switches with integrated SoC. There are 4 physical SMI interfaces on the
> RTL9300 however access is done using the switch ports. The driver takes
> the MDIO bus hierarchy from the DTS and uses this to configure the
> switch ports so they are associated with the correct PHY. This mapping
> is also used when dealing with software requests from phylib.
> 
> [...]

Here is the summary with links:
  - [net-next] net: mdio: Add RTL9300 MDIO driver
    https://git.kernel.org/netdev/net-next/c/24e31e474769

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



