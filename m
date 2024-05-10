Return-Path: <netdev+bounces-95591-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 934FD8C2B8B
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 23:11:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4AFA1C20987
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 21:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FC325026E;
	Fri, 10 May 2024 21:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V6/+QXrE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E0543AD9;
	Fri, 10 May 2024 21:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715375474; cv=none; b=k80HPUOCw5t0rQxvZo4TQy1ZhGq83QKzD0DaVpA5XJ2/ztPf9O5CysBYWe+8VWIYF6h2MylUO481SZOdYsIJZm0j0wOS8SqPfKqV7eAcWewyNArYjgl9pjd3K74zeWtzknZEdD21GcxdP0mCyq+yul6WLjFn+uuaCfHAffTykEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715375474; c=relaxed/simple;
	bh=XFSNcPbHc9mO7iHUu/l69by+0WzhSlKJ2R1G9aQhLuc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pJuK2RsEm4b3CX4K43oWRDUb4zEoqscECFad4Jydl8yDtIUYJ5SmNHspDLn4ZhN6w5QeMlHjHT7Osw8E6Op3SJs/HjidbUQQDyRmLPv9lV0HQGF7AuiEy2wbb+axKclSZsNup+BuRlL7gfIwIgplpxsCeNK1rHMwL5Pb5PQxCA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V6/+QXrE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E1CE0C2BD11;
	Fri, 10 May 2024 21:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715375473;
	bh=XFSNcPbHc9mO7iHUu/l69by+0WzhSlKJ2R1G9aQhLuc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=V6/+QXrEscjYblyCUGped0rswaIDwubCsmL0+SeAk5xnRJSt25EpZ9UcdFSv7ccXt
	 lif/ZkPWZQxBW8MwNXwgvvkbcXjJfJN5s//SLUzwPTk1DRJtaVjALsOZ7Y6xDznguh
	 DFGgwe8YSPfwrAN9lZjXSMJzEqe/Ffvvr5asbOyGxM+6k+YjEYEEfZzOiZTdC0mZta
	 qpCCPTK1NL65j/LDCQTL4efAJJfFQBwWDGeKNrv74D0RtY3Cue8CBdHPnPGLueOS7U
	 vpZ+74E4nY2JqauLz7I9BOqPYC9iGsmzsOFzUBW1YkH67b/McztgREh5rkctdgh4Jk
	 bNJeHDsPpFRFw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CE5D2C395FD;
	Fri, 10 May 2024 21:11:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull request: bluetooth 2024-05-03
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171537547384.22334.14519844262885000157.git-patchwork-notify@kernel.org>
Date: Fri, 10 May 2024 21:11:13 +0000
References: <20240503171933.3851244-1-luiz.dentz@gmail.com>
In-Reply-To: <20240503171933.3851244-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This pull request was applied to bluetooth/bluetooth-next.git (master)
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
    https://git.kernel.org/bluetooth/bluetooth-next/c/f2d859045ec1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



