Return-Path: <netdev+bounces-203122-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89800AF0899
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 04:40:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD8AD1C20B1A
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 02:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81E5C1E3DCD;
	Wed,  2 Jul 2025 02:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hd6g0ZP2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58FC61A073F;
	Wed,  2 Jul 2025 02:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751424007; cv=none; b=MQ9xI2QGFwOSmg/Xr4l+Bw3cmS3nIV6fQwn8MrZt9KBkQn/t4SAR5JEmS4LzMZxnbKE0bYur+4nJEUYQ5btiyyOrEhcxV6GxFST7Ud/WjHm6OW49uCKMWOT4H5jWU0+EzTCEI6lGRdvhDP24PiL5RNofV+nr49jo9nCYf6JSbbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751424007; c=relaxed/simple;
	bh=ROltbsMKiJ+DHPDuXyJyxXrxE9iVmGwQvi4xmN8uk58=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gacU9PNrq+w4mPqPbjIVciE8H6cJSBAa8JBnIBRIgWaghcFsgg+cTRG70dd2jMykuz+7y6qVa34yx6FYB22jYsL+cyBYQyPTeWeHpy1ydkBMVnZUVenS09m4jwZC8fdr6bcd8bB9ubEkRKX+bXxh5oVat2enVSnufOow5KCLtns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hd6g0ZP2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F11DEC4CEEB;
	Wed,  2 Jul 2025 02:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751424007;
	bh=ROltbsMKiJ+DHPDuXyJyxXrxE9iVmGwQvi4xmN8uk58=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Hd6g0ZP2cQlmn95MhthViR/t1dg9p9zjN2Pozlh474VgjY8J3jy/gbXcG/SIwlwCe
	 7GxCEgZNm29DW3HPAds+JQUJD0jaDi8KqYgO4jr5FgVd/uOXRQtl8k39ITqKLSSpZ3
	 g0hBePm7Vr+xPKw8bl1wiAU6YNJDT/KabUjb57Pqh/WdB3AtOB3gw5oed/7hcgzLYh
	 35PCPrsDDadbEr4yJqML/grMhUYw8akSCA3rXKHIl0SF7ipgI+ZIs5mKg+0KdVy43l
	 exO+RmbdYsBxZiZRk/BO56HKrXhld5s4dg8lAGuXAMhspU9IgdE0ycu6V+jDYIIQhe
	 PJGsa9fsxGk/g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE0E383BA06;
	Wed,  2 Jul 2025 02:40:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 1/2] net: dsa: mv88e6xxx: Constify struct
 devlink_region_ops and struct mv88e6xxx_region
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175142403149.183540.1885720242599940117.git-patchwork-notify@kernel.org>
Date: Wed, 02 Jul 2025 02:40:31 +0000
References: 
 <46040062161dda211580002f950a6d60433243dc.1751200453.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: 
 <46040062161dda211580002f950a6d60433243dc.1751200453.git.christophe.jaillet@wanadoo.fr>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 29 Jun 2025 14:35:49 +0200 you wrote:
> 'struct devlink_region_ops' and 'struct mv88e6xxx_region' are not modified
> in this driver.
> 
> Constifying these structures moves some data to a read-only section, so
> increases overall security, especially when the structure holds some
> function pointers.
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] net: dsa: mv88e6xxx: Constify struct devlink_region_ops and struct mv88e6xxx_region
    https://git.kernel.org/netdev/net-next/c/ff2d4cfdaf91
  - [net-next,2/2] net: dsa: mv88e6xxx: Use kcalloc()
    https://git.kernel.org/netdev/net-next/c/a63b5a0bb740

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



