Return-Path: <netdev+bounces-208048-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0AC8B098A8
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 01:50:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEE73171934
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 23:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A75EB246BCD;
	Thu, 17 Jul 2025 23:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e74MPMOX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8341349641
	for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 23:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752796208; cv=none; b=tg0DbnVqN/8M4Z+kwlYcQ065nweOCezuYsR/0oyOH5a1EmlPZ3fz0DrxQYR3wwbHaPyuRQa/lqHwiYdmVE3MLkhbBgv95nJjyvKDaSmcjFJSU/rjyurKZ1My1fUUvd5uS1U7eFx3c1nFtQLWPNT6ufXDXQ8U/0E/mqLgen12RpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752796208; c=relaxed/simple;
	bh=bV+pyLTo5VKmtPGhd/HEY8o7hNh3RLH2qJuXOO6qiwU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=r7ioes02DlfmxLR+vEOx2WnkOE4UhZ3DOq90d9jGeHKedA7cWrPYMq5ElRkn0h/C6WqpvfuSh8dGNFD/NCYlrYqT8nr7DGeaef3z0C0eZwFrh2n61VPg6gt8HQ1RGUDx0X/2yNJIaWPOlj9kQjtTFjk8rjbEaPpRoP/rhEevlTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e74MPMOX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10625C4CEE3;
	Thu, 17 Jul 2025 23:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752796208;
	bh=bV+pyLTo5VKmtPGhd/HEY8o7hNh3RLH2qJuXOO6qiwU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=e74MPMOXTb5p38r6PuJzn3nC02qDkxwMRXZoPNshdEUjl0Ah3Qfh3xTzID4Ukmgeb
	 PC864xY1x+O7ipW0FhWpIVjDsBjYRcESSTU5ZrIzHyE6QzgnhHyi2rMuzRQr/VvZyC
	 dVARw4xR6HwXhNFyCEmgbaDLyKdUkHY+pmvd8iaEQ3Y0xE8S6UgmM+5FmdxfISofDm
	 GVmJN3XQu0w1yLWB1uweJO89VkGWmJOAuMdYtpMf62+dTeFVI7CbYi5WUtBujOLGyM
	 pdX++Gh7hWkEGRn46pMS2kK9Z+UvSEEGQqqEaO4rMsSdabPjRn+ux+PazDuO/spMoL
	 4al97alVdEpWg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B49383BA3C;
	Thu, 17 Jul 2025 23:50:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] selftests: net: prevent Python from buffering
 the
 output
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175279622774.2114222.15100786520447517807.git-patchwork-notify@kernel.org>
Date: Thu, 17 Jul 2025 23:50:27 +0000
References: <20250716205712.1787325-1-kuba@kernel.org>
In-Reply-To: <20250716205712.1787325-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, shuah@kernel.org,
 petrm@nvidia.com, sdf@fomichev.me

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 16 Jul 2025 13:57:12 -0700 you wrote:
> Make sure Python doesn't buffer the output, otherwise for some
> tests we may see false positive timeouts in NIPA. NIPA thinks that
> a machine has hung if the test doesn't print anything for 3min.
> This is also nice to heave for running the tests manually,
> especially in vng.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net-next] selftests: net: prevent Python from buffering the output
    https://git.kernel.org/netdev/net-next/c/797f080c463d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



