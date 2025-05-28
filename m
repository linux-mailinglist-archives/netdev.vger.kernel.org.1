Return-Path: <netdev+bounces-193795-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9327AAC5EB6
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 03:21:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CF2F4A48F6
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 01:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 035DD1DF98D;
	Wed, 28 May 2025 01:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RqHsfcCn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB25B1DF273;
	Wed, 28 May 2025 01:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748395213; cv=none; b=RfRxRRQDtvmfpSzZjzWjqshOJL1KBKuh/ydU+MjC/t7X/Qi/vuAPNziOqLvh26EsmX7DtZyS+mv9UE8nEXvW5MPHjwlpWloSjXp8xGUjOBEOhBEqRilrrZwEq8DO45MxFfQs+oCihkQK6lkKo0knEwlpS2smYZR3ktqclMqSZ5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748395213; c=relaxed/simple;
	bh=4akuqYwc5gwUE+TauisypdxpPSXLUqxOE5xlU7KwFKE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QZVPVW56GZi9gZdr8wCN4HCjVmjnwlLyBxaYZpeY1bXz5lRgP+RcmVvD8vpG75b6sGFX/XtgrW+SHj0zsHfxS6BEeLf/PAuQrvHYHZHxAsGPlecaEQTgtnxuvG/WtQ6nQMMM079PWc90lhooUfRY/l1tw3u44aZHo6rAKv6puW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RqHsfcCn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4980FC4CEED;
	Wed, 28 May 2025 01:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748395213;
	bh=4akuqYwc5gwUE+TauisypdxpPSXLUqxOE5xlU7KwFKE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RqHsfcCnt/NKntPgtHc3h5+Gn589IHlBXUqpmpSOr3fiOX4j8mwvMtOnt19WZagCM
	 hUtI/rz1Vv1nPfMfzY8vFu3j7LAlatJ9rNTNcE/YxkssVTh6Uf5JdZ4QyI+a6YVcTI
	 /vRMEzmb8eEPnueSeETxEjjrjxjVFmyM5cOzlXTgbap82fydiQp1G8mn/TE5q/pwrt
	 iCNSngB3JESqW4noLvMpiCWXlZW7BQSM9LKUP6hEC5l7Kh1m/pLWoaC+mjDX2beDPC
	 tj4hEn3wWMZ4NTLe4f6xExUvf+NyUW9u/SAexAGG5jVSpRxi+OZAjFkwM2ymOKvGj/
	 I5+Be5cT7NrXQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE004380AAE2;
	Wed, 28 May 2025 01:20:48 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] cxgb4: Constify struct thermal_zone_device_ops
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174839524724.1849945.14055765173341143853.git-patchwork-notify@kernel.org>
Date: Wed, 28 May 2025 01:20:47 +0000
References: <e6416e0d15ea27a55fe1fb4e349928ac7bae1b95.1748164843.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <e6416e0d15ea27a55fe1fb4e349928ac7bae1b95.1748164843.git.christophe.jaillet@wanadoo.fr>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: bharat@chelsio.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 25 May 2025 11:21:24 +0200 you wrote:
> 'struct thermal_zone_device_ops' are not modified in this driver.
> 
> Constifying these structures moves some data to a read-only section, so
> increases overall security, especially when the structure holds some
> function pointers.
> 
> On a x86_64, with allmodconfig:
> Before:
> ======
>    text	   data	    bss	    dec	    hex	filename
>    2912	   1064	      0	   3976	    f88	drivers/net/ethernet/chelsio/cxgb4/cxgb4_thermal.o
> 
> [...]

Here is the summary with links:
  - [net-next] cxgb4: Constify struct thermal_zone_device_ops
    https://git.kernel.org/netdev/net-next/c/08f8bad0255c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



