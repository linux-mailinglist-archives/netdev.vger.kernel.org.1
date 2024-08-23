Return-Path: <netdev+bounces-121499-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C49D395D6FE
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 22:08:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60B30B2080E
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 20:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69FA71A0701;
	Fri, 23 Aug 2024 20:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hXQDqrSy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351321A01A6;
	Fri, 23 Aug 2024 20:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724443320; cv=none; b=T+8AwhsprP/HeanNFY1xGzVag9iW7QOgY8G5PiX0eVrB5Oas5i+RG3FkRN3dA9MwJ4dkFNmRJDuwuYQr6GmYeImoji4v1ZmeK7JFYyVrpHutzG+7tUnRa3E8ghDs/C8fR+/30ASb5/iYeVhTZthcmhwxXz142eGIk88sV/doB+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724443320; c=relaxed/simple;
	bh=aSWACHlXzLHKkcmfzNOd5WUEhgM4CMKEnL54qohj+2g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fhpxgB6NTWWhsVFt/alYe56s9ghE7OIXofjxwP2XAumR4+CKPcN7s1V0OOkpAJa3CH7yVgXejedf2LgoTwV0HGFxF/ietiEr83BbpvmXpIwSx4U0x1qaqYocmXn78dGqBJxuUegFuZbAp7Xf28cYqxxfgJBb00BY+YPzhp8rVb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hXQDqrSy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6137C32786;
	Fri, 23 Aug 2024 20:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724443319;
	bh=aSWACHlXzLHKkcmfzNOd5WUEhgM4CMKEnL54qohj+2g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hXQDqrSy1doTWV+Bih5K+RuoLl0W3CknnsF3LzwQeggo7ZwCGOnVsA+nAGVAWpJMJ
	 D1TTilf5XyC4U1Um0c8CCtcwbbh0rb068yDPlFVSEmx9TVWiJvOYMMgkby4fJKmN/U
	 21aS8Nm/qL7xBnL0eCxv6aLmMw7U2SJ34gr3mwp21yLiD9/Vwmmwdx3B0NECTKbRsV
	 WKdz9kiXg1/mXt4YkUv/rJo3pnpOK/SfLAiVL5qjCRCRNST8MNNrKARB+w354RZHbM
	 Z9XihpXqF0OY8QgQBkDDNClosaKMKhiXQUS4Ai79AjgIUW6fGrrZqUDBGnJ4JHy3dp
	 p5SJitm2tnuMg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE17C3804C86;
	Fri, 23 Aug 2024 20:02:00 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull request: bluetooth 2024-09-15
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172444331929.3068205.4809543576405834132.git-patchwork-notify@kernel.org>
Date: Fri, 23 Aug 2024 20:01:59 +0000
References: <20240815171950.1082068-1-luiz.dentz@gmail.com>
In-Reply-To: <20240815171950.1082068-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This pull request was applied to bluetooth/bluetooth-next.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 15 Aug 2024 13:19:50 -0400 you wrote:
> The following changes since commit 9c5af2d7dfe18e3a36f85fad8204cd2442ecd82b:
> 
>   Merge tag 'nf-24-08-15' of git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf (2024-08-15 13:25:06 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2024-08-15
> 
> [...]

Here is the summary with links:
  - pull request: bluetooth 2024-09-15
    https://git.kernel.org/bluetooth/bluetooth-next/c/2d7423040b7c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



