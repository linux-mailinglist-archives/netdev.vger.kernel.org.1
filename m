Return-Path: <netdev+bounces-93389-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 503E78BB7AC
	for <lists+netdev@lfdr.de>; Sat,  4 May 2024 00:42:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E672D1F25553
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 22:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BF0812FB13;
	Fri,  3 May 2024 22:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ke0vXvdV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315892C684;
	Fri,  3 May 2024 22:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714776030; cv=none; b=a9MCGrqC5LZPASURBkgco1bu+EhknKe1PcS+G27QelCSLTOEb5hsF4K1pzRQAsmF5O6AxpWbmCfmJyznsadO9VzHTSD/UsuiEaHZZLsitkFhW3QGleO1Ar15eqcunoylbIR4LhlhUcwg40VyRs737YNedfkzziRzKaJ4ovRqo7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714776030; c=relaxed/simple;
	bh=IBMbp08WiXcKFrMTK5xJclWKsUVz1FQk+WGXNnArHEs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=m4qNXAoBcO4GknG3HzCIgxExLH2QV6RfrSrLNtoO3ff47s0fJQgkv0TRcjyy09vMt5KWkOS1UEFCmgAEizy4FLcYwfdhZ5Kr0A093VxkhlmjNUe6O2/WhPeYWdDT/oc8NvrkFy+BqUtQYztXrHZUPOT6npXXzHolT+c8xhvdsYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ke0vXvdV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9376FC2BBFC;
	Fri,  3 May 2024 22:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714776029;
	bh=IBMbp08WiXcKFrMTK5xJclWKsUVz1FQk+WGXNnArHEs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ke0vXvdVmBI/KOFRvdEH+Ehd109jP7oBpHTvepGWW6491DrS1FSOYmbTQ6h39EYo2
	 ya86g99UlKli/JNH9WoWmRrprwM6kwaXi4v/9PAuTgZnIU7VImGCqe/Q78uWqOfYth
	 Gi8TTiK8G7KjaIH+Zlsr2RTcF8uzdvV1oKSYuVwJp+HxkSvApVl1CfsZUvEUg2uvo2
	 SHXFx/Aah7q+NpHRfVaEkZxZ8AU8CUpg0LWejsDFtm+3LsxiHAxnV3U3D3lAl7J8Hh
	 qSTczRfy4HzpgWrCFfdCGh4uUknR+nGUh61F8fi9B0wWFoQpmLWFZILIWwK0bx7zL8
	 0uk5yZh981y2g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 86CE2C433A2;
	Fri,  3 May 2024 22:40:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull request: bluetooth 2024-05-03
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171477602954.29342.15225253677754744763.git-patchwork-notify@kernel.org>
Date: Fri, 03 May 2024 22:40:29 +0000
References: <20240503171933.3851244-1-luiz.dentz@gmail.com>
In-Reply-To: <20240503171933.3851244-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  3 May 2024 13:19:33 -0400 you wrote:
> The following changes since commit f2db7230f73a80dbb179deab78f88a7947f0ab7e:
> 
>   tcp: Use refcount_inc_not_zero() in tcp_twsk_unique(). (2024-05-02 19:02:46 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2024-05-03
> 
> [...]

Here is the summary with links:
  - pull request: bluetooth 2024-05-03
    https://git.kernel.org/netdev/net/c/f2d859045ec1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



