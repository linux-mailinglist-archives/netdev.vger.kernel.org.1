Return-Path: <netdev+bounces-40087-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0EA67C5AC5
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 20:02:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B4A028235A
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 18:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17A4539954;
	Wed, 11 Oct 2023 18:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qiy0I6C+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB2B1095F
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 18:02:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 75B2CC433C7;
	Wed, 11 Oct 2023 18:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697047373;
	bh=yc8khHB/i6SI/e+iuFBVf1PpxwEFuG+Xr0rkVDLvirI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Qiy0I6C+3YuQuru4ozWZpYCdoqrIXc3FcRRtVralhnS06NhjjIxgOg/Z/E/S0vPkv
	 BvrJkNOyvkVJkAY7lq8X9b71msOkFCAitwSwXfKKLTIN4wkFYjgx08Ol7KzzhgvuTm
	 kXJSx65ul4C65RPo6a98SZdqjv5TW9NUR3fX1H7+r7eklgzidBGrYU6/WM11go28t+
	 c9fQtU+UAX65JtFrGVSYr4LMeLkeQCrzeOyLytWF7pUp+Mx9K3kbqH/nMLIfOovMPf
	 cjx0Zc2BKF0W8FblB3uO/d/7RL+3OhZ/uFBZa/+86BrDftl6YgeMqjQ2xu68B3ppD/
	 8yllECdYJwM8Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 55FF3C73FE9;
	Wed, 11 Oct 2023 18:02:53 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: bluetooth 2023-09-20
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <169704737334.29808.2754584340354527174.git-patchwork-notify@kernel.org>
Date: Wed, 11 Oct 2023 18:02:53 +0000
References: <20230920181344.571274-1-luiz.dentz@gmail.com>
In-Reply-To: <20230920181344.571274-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This pull request was applied to bluetooth/bluetooth-next.git (master)
by David S. Miller <davem@davemloft.net>:

On Wed, 20 Sep 2023 11:13:44 -0700 you wrote:
> The following changes since commit 4a0f07d71b0483cc08c03cefa7c85749e187c214:
> 
>   net/handshake: Fix memory leak in __sock_create() and sock_alloc_file() (2023-09-20 11:54:49 +0100)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2023-09-20
> 
> [...]

Here is the summary with links:
  - pull-request: bluetooth 2023-09-20
    https://git.kernel.org/bluetooth/bluetooth-next/c/c15cd642d437

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



