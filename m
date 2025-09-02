Return-Path: <netdev+bounces-219342-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88391B4106B
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 01:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 645A917E574
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 23:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B583275B05;
	Tue,  2 Sep 2025 23:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qYXyRKLw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242552773FF;
	Tue,  2 Sep 2025 23:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756854004; cv=none; b=P4/wz+Re862F1c/squnyD9eyGyzDVKqLLxOHLbvIagbvfdJhvLcz/PqEhaNU9PUyThGIBNqixeul76GKPPcnE0Y3TJUeoxxmLkMA0W91boCaUwHzRms8n/LhLJ4mI9AwEPdQ6N3wy5PmmJIJ2g9pUNujTzTnKA0Vqo4PWOKNQ2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756854004; c=relaxed/simple;
	bh=6POer+wFwRBgcQxTdYCrvEXWPKLGl7/7by8ENje5Mtk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=slBlETJ4k+4J7LL1VWpnPFzEQWmewjpsJXI9PvEXuFavKca/0StzhCe1IHDlMcdgDXwCUwojVy1V2CHXxNTxEa//GN13gOz4kU2PcqQmWoJgl5efwBup8kSHPFaHulksvJxBJra5EI51S2j883gbJDCwbqUUSa+b4zDzEiSAcys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qYXyRKLw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9425FC4CEED;
	Tue,  2 Sep 2025 23:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756854003;
	bh=6POer+wFwRBgcQxTdYCrvEXWPKLGl7/7by8ENje5Mtk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qYXyRKLwbyKFF2x5GACKucgeGQfEbGNKjGvf70ygwgF1rO6i+KwbvYnxFUhbbpBnk
	 Y1QyyW2q2nLy16vlWo7xMzsIbtG1pe0iQ370F1Ibxvs4XVxOgqpkiWIIBspElJsQYH
	 BvsHDQosCONAKKD8He5Ca/8gzaDOWOAAMfjJkQd55W+FHuXc3WNk9yJDYxQkeWpWK7
	 Opj1b754tS0J2n+a+DfsXQvW9ziiI5vM2dRzoyu9ob+PgO5sk7DyNEEOtDPkSUBx7C
	 VlzlD37PN+kzrbYo1Jh7/t0TEkKe1AfgkHs8/HHHrlgexKeo9ZmqVcby8jEl/5Smoo
	 en5oyClkrXACA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33CB9383BF64;
	Tue,  2 Sep 2025 23:00:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: sfp: add quirk for FLYPRO copper SFP+ module
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175685400902.461360.6431148573901261673.git-patchwork-notify@kernel.org>
Date: Tue, 02 Sep 2025 23:00:09 +0000
References: <20250831105910.3174-1-olek2@wp.pl>
In-Reply-To: <20250831105910.3174-1-olek2@wp.pl>
To: Aleksander Jan Bajkowski <olek2@wp.pl>
Cc: linux@armlinux.org.uk, andrew@lunn.ch, hkallweit1@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 31 Aug 2025 12:59:07 +0200 you wrote:
> Add quirk for a copper SFP that identifies itself as "FLYPRO"
> "SFP-10GT-CS-30M". It uses RollBall protocol to talk to the PHY.
> 
> Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>
> ---
>  drivers/net/phy/sfp.c | 3 +++
>  1 file changed, 3 insertions(+)

Here is the summary with links:
  - net: sfp: add quirk for FLYPRO copper SFP+ module
    https://git.kernel.org/netdev/net/c/ddbf0e78a8b2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



