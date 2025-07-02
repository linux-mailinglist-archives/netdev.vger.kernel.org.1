Return-Path: <netdev+bounces-203123-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E54C9AF089C
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 04:41:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B1364A3088
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 02:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81DCA1E378C;
	Wed,  2 Jul 2025 02:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AlbIf09e"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590211DE4C3;
	Wed,  2 Jul 2025 02:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751424007; cv=none; b=q3k9tL2hExOkCqqI9kV+Nn3Jn/ToGUNOrp6/M6BdNdjHM5GKHR/iWn2ZwZuCAEMShJbtKKQNlFkYKMVkkd/tEf/vPjadmQvjm/wpFMERJlKT1tWBwlUEeukj1z/aZv7n6G8HngAsflhEdU49ngu41qrtVoU5rAG6xWi32dhtY8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751424007; c=relaxed/simple;
	bh=LuPMVmY1zoLKin7oIVHbMOu5aFAfMAO+fp+KQYR2PQ0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Vz/KaGfoljACU6NWCcRgtSzV3kRi7QxbyY0N3MNRD0RMSB1sKeXmc11r1hKU1a1Eh/dwDLYlpWJ13Bq5puo+4BYZwBFNYDK99AUiNhYVnRu1OkR25pdNG6f9dTVCYBVJOu+DTK2j4BIE0wtfpkhSuptumJFXc/PVrT9DeWyL4Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AlbIf09e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 775B3C4CEF3;
	Wed,  2 Jul 2025 02:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751424005;
	bh=LuPMVmY1zoLKin7oIVHbMOu5aFAfMAO+fp+KQYR2PQ0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AlbIf09er5/8MJmIAjYyvz/vgwUkvclSBQoidMV4cy86SbVXnRIM+8LEWV+tmj452
	 LhIqIHUyNoV2BZVfdCpQyAmHygJzKCFgInPwl715Txv+bd6wGYsCmW2+1/xrqSjur5
	 4sQHHd3CbnTMSGcu8ScBrdpNfBYaMY47vNe82e+3zksxQ6f915ZBj73lEkYns3A5R8
	 DTKrWseOXhDN4+GCJHAXSchepfqn5dJ/xH62vw1ALO7RlsFJG9y17VwJM8AvZ7IVrD
	 M+ZNMvVCY8f7DbfbgxTpnIDhABKX7X6cpJC5dqPEE61jz5oLkzmgeDAJ+q/eGKIiG4
	 l6BoAxRazgwlA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70EAF383BA06;
	Wed,  2 Jul 2025 02:40:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: dsa: hellcreek: Constify struct devlink_region_ops
 and
 struct hellcreek_fdb_entry
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175142403000.183540.14644839018497989646.git-patchwork-notify@kernel.org>
Date: Wed, 02 Jul 2025 02:40:30 +0000
References: 
 <2f7e8dc30db18bade94999ac7ce79f333342e979.1751231174.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: 
 <2f7e8dc30db18bade94999ac7ce79f333342e979.1751231174.git.christophe.jaillet@wanadoo.fr>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: kurt@linutronix.de, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 richardcochran@gmail.com, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 29 Jun 2025 23:06:38 +0200 you wrote:
> 'struct devlink_region_ops' and 'struct hellcreek_fdb_entry' are not
> modified in this driver.
> 
> Constifying these structures moves some data to a read-only section, so
> increases overall security, especially when the structure holds some
> function pointers.
> 
> [...]

Here is the summary with links:
  - net: dsa: hellcreek: Constify struct devlink_region_ops and struct hellcreek_fdb_entry
    https://git.kernel.org/netdev/net-next/c/10c38949e0f5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



