Return-Path: <netdev+bounces-110584-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A05CB92D4A2
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 17:01:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6183A284379
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 15:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71B91191F8E;
	Wed, 10 Jul 2024 15:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sXBtIewG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A07A18EAD;
	Wed, 10 Jul 2024 15:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720623695; cv=none; b=m5/6bllfkKo+rjJc6EDcIanOk9y4lU/Qd/UKlFrbNaRRydJj/w32NBzzz4w5C9IJEPdQ3keZoY6Fa76DnFd9sOfE5VBDHk+BeZ0agyy7A5zh6lcYjICl0oUa3A2UaIk8hSGXmjfCZ+2FH8rasZn9LPpiyhc6RWC6OzzzXbVk9cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720623695; c=relaxed/simple;
	bh=qT1r1uYNhhmuCEJkmsxD+cxKG8VQYtBOSnWI9UqbXhQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=atJXVB40n6S9GELlcmvtpiL2O1hDnFwOCLaNCYyyAmvvmY8ABg0GEvMcdCwKCQR+sBCkXXm6xkp0lm42z66nkXJRHj95K8t02VFV0GBtMgV7lnVX6AVLuyhp5aW3IO1qz1Gbj1wJkDs84zUF1yMQWhhM2b2kHwdBPgMj3htU7NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sXBtIewG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C090CC32786;
	Wed, 10 Jul 2024 15:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720623694;
	bh=qT1r1uYNhhmuCEJkmsxD+cxKG8VQYtBOSnWI9UqbXhQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sXBtIewGFecjgD2NPGThga7qTv0/5e74vpkmdalmmqEjDGlaPZD36t6RMtr4DM2pD
	 zToolto24CgZS0tz1pwL5Nt4be2I4wjVumywj/SAuvqFBqj0xajzMMGlNz/kVgS0h2
	 r0LwQ2BvQVIgRcxagRqo+Fe+MAZaNpEN1kDW9qqHBAyv2odgh2HPNeoBQIAzD02bJx
	 FtIrPgITvq8lg9adJgo4DGBB34bwra13bf/PB+5/+/1zfKsu1mcHeR9VkMXyYWMnvs
	 izkpcDx6cHYqlDseuvkn0/HOKv7J7fCeMCU4QFhWdirJBhWpptWtUKXZYaQ/Ug15XZ
	 nBERI47hbxz+g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id ABA8AC433E9;
	Wed, 10 Jul 2024 15:01:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull request: bluetooth 2024-06-28
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172062369469.4438.10978343092945130568.git-patchwork-notify@kernel.org>
Date: Wed, 10 Jul 2024 15:01:34 +0000
References: <20240628184653.699252-1-luiz.dentz@gmail.com>
In-Reply-To: <20240628184653.699252-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This pull request was applied to bluetooth/bluetooth-next.git (master)
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
    https://git.kernel.org/bluetooth/bluetooth-next/c/42391445a863

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



