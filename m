Return-Path: <netdev+bounces-12400-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0760D737512
	for <lists+netdev@lfdr.de>; Tue, 20 Jun 2023 21:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4DD11C20D6F
	for <lists+netdev@lfdr.de>; Tue, 20 Jun 2023 19:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C21CC17FE0;
	Tue, 20 Jun 2023 19:30:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8085717AD3
	for <netdev@vger.kernel.org>; Tue, 20 Jun 2023 19:30:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 12047C433C9;
	Tue, 20 Jun 2023 19:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687289421;
	bh=LdCourSXugFphSq7Z911ky6/IttVqubZe81OKxkbUOY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ki3HvOcpEK9oJWfwQKymkHaRYQ8+DooaaL9Pgisl7zOovrudfjPmu1BqXkj5OkkFx
	 SGzm/b5csGyLLktRxCGnzsIEQ+K0yynOGD08d5sq3JTBF7agGSMX29n2NKgcPJIT+V
	 ErgGlUuJD63ap8zwVE+BRhlkCP4SN1vcpdfk2vmNFDBGJF3WBDWJ16GG2S0VgaQ6EL
	 Mp9Er3H3lDXl5e+yoiOOxhbQSocR0p7Ae6EEPs4B6/kZ3tjGEkbCln+8tUX6UO3TMi
	 zyjoGbtdcagZ/86Ze/c0qvxGtU54qUcKJFJVdEGaJChXpkIXYbSxeQSXEDvLX//4qV
	 6z981tP6D47Ew==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E4C23E21EDF;
	Tue, 20 Jun 2023 19:30:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] be2net: Extend xmit workaround to BE3 chip
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168728942093.14216.17570770216519580284.git-patchwork-notify@kernel.org>
Date: Tue, 20 Jun 2023 19:30:20 +0000
References: <20230616164549.2863037-1-ross.lagerwall@citrix.com>
In-Reply-To: <20230616164549.2863037-1-ross.lagerwall@citrix.com>
To: Ross Lagerwall <ross.lagerwall@citrix.com>
Cc: netdev@vger.kernel.org, ajit.khaparde@broadcom.com,
 sriharsha.basavapatna@broadcom.com, somnath.kotur@broadcom.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 16 Jun 2023 17:45:49 +0100 you wrote:
> We have seen a bug where the NIC incorrectly changes the length in the
> IP header of a padded packet to include the padding bytes. The driver
> already has a workaround for this so do the workaround for this NIC too.
> This resolves the issue.
> 
> The NIC in question identifies itself as follows:
> 
> [...]

Here is the summary with links:
  - be2net: Extend xmit workaround to BE3 chip
    https://git.kernel.org/netdev/net/c/7580e0a78eb2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



