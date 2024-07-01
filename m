Return-Path: <netdev+bounces-108131-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2648C91DECA
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 14:12:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D34E41F21663
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 12:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CDB7143736;
	Mon,  1 Jul 2024 12:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tVrXAhKL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1061B84D02;
	Mon,  1 Jul 2024 12:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719835926; cv=none; b=rXfG0zLO8DCYVyePX+1k0FAslCLA0t96baH/pVaGP5QY3hsmSRdFA5WcBeLAuB4TTVyJiCmJd0uRmzs3/baSNvuvXAjJ4hGXelE+f9c78xdvx/xXVrdQYsOlsVS9yTOMGOD8KshwVkc+onm5H0BitqU8xoQJNjZYBUF8op9TfVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719835926; c=relaxed/simple;
	bh=v/ZSLjfAPS/k3EqJU/EfDNyBxElIymulR7YCiea6m8A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=q7etOk+J1iERFO63SCzFXWnpizBgp6upKKZoi4ty3lfvjBpfcKWVI44PKeqReQCAAFLXNiUTk+sXZEKBSRSy13aZi0TNnU1YrdBoHZECQ8l6UMOAJfKREg3B7J/6u//3MvZKqd+eEbtmtLywCDpciIBZWiQbh9Yrgvh72h3X5dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tVrXAhKL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 969ADC32786;
	Mon,  1 Jul 2024 12:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719835925;
	bh=v/ZSLjfAPS/k3EqJU/EfDNyBxElIymulR7YCiea6m8A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tVrXAhKLLWdQnHwk9YAtUVAw4Ul1EftyB/wJcPuE7NZAd7v0LhODiPkwN8su+Knap
	 xZzin8ubNpwVYuV4g7QZxyg3Fh2DdB7TCpz1v/xUdJyz2vTCMhUaArQgbMW0MMj0zA
	 mUPZYJYFaFExMik8NFSAUDM0egIY2NqD/OB3fIObsdB0UvRLRQtMNo9viqqQrTS2lD
	 KW4NMrIjOQl0qGCBl13qDZbpI5AZl/WdO0RdoxIRJboSJYN/XNikaabqxgHmlspC5o
	 dS6bBI9BX1vxt+aDeb7PVqB4eJoIMlk4NN+XePKtUsN1NJkf9s6YkBRUMh4uRG6QA+
	 iBNastY9zwBzA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 81CAEDE8E0D;
	Mon,  1 Jul 2024 12:12:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull request: bluetooth 2024-06-28
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171983592552.7896.9389465606018766381.git-patchwork-notify@kernel.org>
Date: Mon, 01 Jul 2024 12:12:05 +0000
References: <20240628184653.699252-1-luiz.dentz@gmail.com>
In-Reply-To: <20240628184653.699252-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 28 Jun 2024 14:46:53 -0400 you wrote:
> The following changes since commit dc6be0b73f4f55ab6d49fa55dbce299cf9fa2788:
> 
>   Merge tag 'ieee802154-for-net-2024-06-27' of git://git.kernel.org/pub/scm/linux/kernel/git/wpan/wpan into main (2024-06-28 13:10:12 +0100)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2024-06-28
> 
> [...]

Here is the summary with links:
  - pull request: bluetooth 2024-06-28
    https://git.kernel.org/netdev/net/c/42391445a863

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



