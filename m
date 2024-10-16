Return-Path: <netdev+bounces-136277-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63EF49A124C
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 21:06:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B1BC1F23C01
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 19:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 185C6216A2D;
	Wed, 16 Oct 2024 19:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bKrh36aN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56E3216A2C;
	Wed, 16 Oct 2024 19:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729105557; cv=none; b=CkTTOcbBVCNN3V4oWnlGqhipeHcdHPtHKtbo3AWLNs6B543mG9Nvw1arQHJtVN0DZw5I6LjoAwB1dr1qgSQaC7iB6jl3lW2Hj2tOeTGkJCt85FrCmeg1ahfZQnNPAaY+4kQHGcsv9yAbOlPIvRYOIzPk5dg6YKVXqP6oq/2OKcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729105557; c=relaxed/simple;
	bh=yjxkbriF4zNM9kMqtsAZUt5mOfPi6h8PCU4FZlX+Wj0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mDhOQgZDlHm/AKd4v9jZR25zZLQoXfpOFP5sHzfGlgD74Eh8pgVXRg7joCDyH6dp5gpN32z6pV6wLi5h4iNrKNmGkjc9Z0gytUnld4gYQ8XyKRtvDaznkn0AsU48giA5IrTtTSVfz3/ae1RczUCeG6IpX/sLmrrlMVIvY27fsTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bKrh36aN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 696BCC4CEC5;
	Wed, 16 Oct 2024 19:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729105556;
	bh=yjxkbriF4zNM9kMqtsAZUt5mOfPi6h8PCU4FZlX+Wj0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bKrh36aNSrZAJuNw8mFN7fG5JkN+f9i65KngQw+bz73AsX0hf3CF0/YrfTWx8Y2ZL
	 9p/psC0dCibYpKMvnM5rhXZEgPcVp2o58ERa272/uhLCUYhBXzWxZkQWFF5IK3ehmC
	 jkGZqCWnXItyMpDSF4CY8lCe/7nNNdLZEXotrff63YG1P+9kE6ZpTiD+Uct57/Bsy+
	 WYmjOZvscJaPCd3DhE90rjZyC2mUyQKEffGfaPBgG+ZDFIupuPtiapEwD+RnybmXeK
	 Rg/J9OXcaOCqnmtnOjQvvoBMVSIRT1Y8jWDWoGBie72Sorvf6islk7eTpNJ1Mn7V2q
	 OkC8RWk0xSOkg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAC433822D30;
	Wed, 16 Oct 2024 19:06:02 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull request: bluetooth 2024-10-04
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172910556148.1899946.6090629657997643714.git-patchwork-notify@kernel.org>
Date: Wed, 16 Oct 2024 19:06:01 +0000
References: <20241004210124.4010321-1-luiz.dentz@gmail.com>
In-Reply-To: <20241004210124.4010321-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This pull request was applied to bluetooth/bluetooth-next.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  4 Oct 2024 17:01:24 -0400 you wrote:
> The following changes since commit 500257db81d067c1ad5a202501a085a8ffea10f1:
> 
>   Merge branch 'ibmvnic-fix-for-send-scrq-direct' (2024-10-04 12:04:12 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2024-10-04
> 
> [...]

Here is the summary with links:
  - pull request: bluetooth 2024-10-04
    https://git.kernel.org/bluetooth/bluetooth-next/c/f61060fb29e5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



