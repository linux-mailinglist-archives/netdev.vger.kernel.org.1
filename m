Return-Path: <netdev+bounces-192518-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B239AAC0327
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 05:50:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F2241B66DE2
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 03:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E940F178CF8;
	Thu, 22 May 2025 03:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jHCFo+N/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BECE5178372;
	Thu, 22 May 2025 03:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747885809; cv=none; b=Gc4y5fETorQ356vYdAjxeWk1xzVNsw37LmSC4nFOzqoA+A7l9oQ3C/Pnbf6rR6gkHO+JQwaimEfyIQ1OoTxRd9p2aEjnfAN0NCpKeM5SEl/OSZyWZDxgRjLlLwe1SnHKCjOFZPWHY6gY/1C89M5NkhFChtPWYtAdxh1rAnMpJcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747885809; c=relaxed/simple;
	bh=GpMCBjr+80UXi5ii0UN+PxANa+Il8Uwb++7u39HnEA8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YADBQRlJwgMz9P3HMwtVGF4CBHZSO8A0kF9rsuY3BxhT0r36jV4AF78iSMdGuWPL+MiHhOEiPqghow+17ApiE7Bde4geyB3H24Q4sXn3lXCeQb96J31WYoR0FCQeGgmbOKOU7tlsOM5ldJYsECkJ93EHg2Gz0TVzBUAnQPaMlWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jHCFo+N/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20ED8C4CEE4;
	Thu, 22 May 2025 03:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747885809;
	bh=GpMCBjr+80UXi5ii0UN+PxANa+Il8Uwb++7u39HnEA8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jHCFo+N/szYNJJEugSvgpo3TEuhaEWM3AYZFO+b7ZtPo5RTEMJS7f6Tr6T5oq7DJQ
	 eoJyFDyfO/wOm/zztV3KzIiEX9rrqt5wlZEHVawIQ2yUsb/8LoWVSJ1Bex17r09Pxi
	 AhxzIxSEAJlxBf1zjtPaB9K4B8G7xb07SOOzIVCW4UfRdWJIUGfUM8en3u4aWKKCqO
	 HzKY8VEN2bfoA9GNGR+Wklkot5rCLtcZ9e4t1ohPSKssoSvhpG/0Nc0TYGUm8B5OAo
	 izRlSAby2c5Up2cTdVYEi2kPRTyJcpfk74wPyTY0nHtk6e8ZPLEV4M7dh+HTu9/BwT
	 zGJB9n56GDdIQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB0A6380AA7C;
	Thu, 22 May 2025 03:50:45 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] emulex/benet: correct command version selection in
 be_cmd_get_stats()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174788584449.2369658.17188848797464910270.git-patchwork-notify@kernel.org>
Date: Thu, 22 May 2025 03:50:44 +0000
References: <20250519141731.691136-1-alok.a.tiwari@oracle.com>
In-Reply-To: <20250519141731.691136-1-alok.a.tiwari@oracle.com>
To: ALOK TIWARI <alok.a.tiwari@oracle.com>
Cc: ajit.khaparde@broadcom.com, sriharsha.basavapatna@broadcom.com,
 somnath.kotur@broadcom.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, darren.kenny@oracle.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 19 May 2025 07:17:19 -0700 you wrote:
> Logic here always sets hdr->version to 2 if it is not a BE3 or Lancer chip,
> even if it is BE2. Use 'else if' to prevent multiple assignments, setting
> version 0 for BE2, version 1 for BE3 and Lancer, and version 2 for others.
> Fixes potential incorrect version setting when BE2_chip and
> BE3_chip/lancer_chip checks could both be true.
> 
> Fixes: 61000861e860 ("be2net: Call version 2 of GET_STATS ioctl for Skyhawk-R")
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
> 
> [...]

Here is the summary with links:
  - emulex/benet: correct command version selection in be_cmd_get_stats()
    https://git.kernel.org/netdev/net-next/c/edb888d29748

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



