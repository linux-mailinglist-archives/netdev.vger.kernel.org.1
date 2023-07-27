Return-Path: <netdev+bounces-21702-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BBFD764531
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 07:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BB6E1C214BB
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 05:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 121C41FBE;
	Thu, 27 Jul 2023 05:00:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943651FA0
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 05:00:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 07E5FC433C9;
	Thu, 27 Jul 2023 05:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690434020;
	bh=bz/ycI4oGS9bRmVVuXMmTPwI4myesbiM5Q3vRbb3WqE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BCkOZwMm7x9e1wydST6BP5Skrc0qwMvnM4HEMv2kRU/o87OgvqxZRll9uGKRqj+Ir
	 vPwUP7OTIjn18tl2Sflaq/+ySlK5d7LUEdw+eDpwFtoNNbfQ1peD1LErTl6+n3mlpQ
	 72TteqnOD1FIJeYIRMA8lRWmzZbW8vRDqiTc2iW5ckaHmD97WI2U6l1C8d7ZuqE+Fx
	 sxiNu7aE3943F/RShwD7FqZa22mRovf++pArj/j8ajKFQ22e+GtJ677GSpMkVQqCAi
	 stAiJ98Z7TKGm1QmrPcKtpRKhT2q/0EWT0Re3dsOeJiLTqDhRDx54fHRlpoT89w1uU
	 kzPNVfKiZXkEQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DB0ADC59A4C;
	Thu, 27 Jul 2023 05:00:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] splice, net: Fix splice_to_socket() for O_NONBLOCK socket
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169043401989.24382.16722066763021301341.git-patchwork-notify@kernel.org>
Date: Thu, 27 Jul 2023 05:00:19 +0000
References: <023c0e21e595e00b93903a813bc0bfb9a5d7e368.1690219914.git.jstancek@redhat.com>
In-Reply-To: <023c0e21e595e00b93903a813bc0bfb9a5d7e368.1690219914.git.jstancek@redhat.com>
To: Jan Stancek <jstancek@redhat.com>
Cc: dhowells@redhat.com, kuba@kernel.org, netdev@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 brauner@kernel.org, viro@zeniv.linux.org.uk

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 24 Jul 2023 19:39:04 +0200 you wrote:
> LTP sendfile07 [1], which expects sendfile() to return EAGAIN when
> transferring data from regular file to a "full" O_NONBLOCK socket,
> started failing after commit 2dc334f1a63a ("splice, net: Use
> sendmsg(MSG_SPLICE_PAGES) rather than ->sendpage()").
> sendfile() no longer immediately returns, but now blocks.
> 
> Removed sock_sendpage() handled this case by setting a MSG_DONTWAIT
> flag, fix new splice_to_socket() to do the same for O_NONBLOCK sockets.
> 
> [...]

Here is the summary with links:
  - [v2] splice, net: Fix splice_to_socket() for O_NONBLOCK socket
    https://git.kernel.org/netdev/net/c/0f0fa27b871b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



