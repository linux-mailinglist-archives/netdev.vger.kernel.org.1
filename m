Return-Path: <netdev+bounces-199961-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8B20AE28E0
	for <lists+netdev@lfdr.de>; Sat, 21 Jun 2025 13:39:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5736C189C780
	for <lists+netdev@lfdr.de>; Sat, 21 Jun 2025 11:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D5A1F2C34;
	Sat, 21 Jun 2025 11:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RclHItHm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4254718B0F
	for <netdev@vger.kernel.org>; Sat, 21 Jun 2025 11:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750505979; cv=none; b=XdlyVXiOtdysKM6IUrrd3M6KZnSbt7VOAYo1YlILwTf9FF25SEl89xuXgGjw7gjZ0ZJ8JQw72oqpK9N+OI6syPPBrd/NsW0EI7XpGh5jfH+8Osf2gjTuLm8+xDziISoioRPDE3zT74xPoYxhsKwyY13NeRS9eFw3Hkt3IwmHlqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750505979; c=relaxed/simple;
	bh=op74wWQW5h0N86BKIK7Ry5XPsi7d7tkPs94otQvRe7Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NGlMIIAb2ynP24yAsG5v/rkMVZesCb9liPo72v1Y8d7rRlyAIT1KURYIaoRUjyZnwPDuSj+w7JmK0JalE/JDbqZwpSmksmdi2j8YZWdHVArj8p7flkvDVSm2pLcZ+u00a7s7MVY8P371LGjReaXqexJL0l934rJJGqq+QLd/1g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RclHItHm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DCE1C4CEE7;
	Sat, 21 Jun 2025 11:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750505979;
	bh=op74wWQW5h0N86BKIK7Ry5XPsi7d7tkPs94otQvRe7Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RclHItHm4Ls/FPJkrR90IFO6VurWFcR6ulgO1VS4k4tHUwymw3CykIe2X/V4clYCY
	 x0jD61BtD9CRks0aGszqEJ/UzGnT/l0rftGmxEAFNCNNs8nm9StbrNRhwKYETC1Kf5
	 QodpvKjM/O6OUy116HU5pccvDYxFH7qvBZ+pw87N0rIuQTa6qoWo1N0Y+NrLWAYyX2
	 7mKLgjupnaXnkyxnyLy51rZkW2TBe3sKUyM4KyttrgvhnwNSM76eaB8R9WJMiZ/479
	 20jbJNKeAQW0Y/6+ogDuBqcNED25P8q4FKEjq83ux8+2y6JmAUhKu1Tdg2+AD8b1jC
	 sje6QRjJr2r4w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAEDB38111DD;
	Sat, 21 Jun 2025 11:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next PATCH] octeontx2-af: Fix rvu_mbox_init return path
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175050600679.1847893.3598363436669480632.git-patchwork-notify@kernel.org>
Date: Sat, 21 Jun 2025 11:40:06 +0000
References: <1750255036-23802-1-git-send-email-sbhatta@marvell.com>
In-Reply-To: <1750255036-23802-1-git-send-email-sbhatta@marvell.com>
To: Subbaraya Sundeep <sbhatta@marvell.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, sgoutham@marvell.com,
 lcherian@marvell.com, gakula@marvell.com, jerinj@marvell.com,
 hkelam@marvell.com, saikrishnag@marvell.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 18 Jun 2025 19:27:16 +0530 you wrote:
> rvu_mbox_init function makes use of error path for
> freeing memory which are local to the function in
> both success and failure conditions. This is unusual hence
> fix it by returning zero on success. With new cn20k code this
> is freeing valid memory in success case also.
> 
> Fixes: e53ee4acb220 ("octeontx2-af: CN20k basic mbox operations and structures")
> Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
> 
> [...]

Here is the summary with links:
  - [net-next] octeontx2-af: Fix rvu_mbox_init return path
    https://git.kernel.org/netdev/net-next/c/0289c51f889e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



