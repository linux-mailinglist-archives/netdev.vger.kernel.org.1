Return-Path: <netdev+bounces-38708-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B91DC7BC2F2
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 01:31:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B819C1C20972
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 23:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEC7B47341;
	Fri,  6 Oct 2023 23:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tgM5uSEx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A048644487
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 23:31:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 14E3FC433C7;
	Fri,  6 Oct 2023 23:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696635064;
	bh=DdEPyzY8UjDo3W+qDn1Sz+TgpUNnKg0AUDgsg+eGL2g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tgM5uSEx4Ti/AJs122v49BsTP80Lmm1lC7aEk6gWjgBIPtUlcB0l4IP2iz27Vl1TC
	 bcJMu9GFUxcSWPcN/BAyUew9wBCqVrcasITrNYO9UEcOQzbHOTy/X7Jv06lBHTgHSZ
	 4RdSrZ3JnrJSFztutRapnbSWJxIoD1Av8pB5iLb2Ten9iWpQUU6BxaISR5i7R6Zevc
	 6SbfUTDzMlnz7Eu4aMnuoijrE0onLj/ltQz+FBGhoMM3ZZkLt7IfXPKRs0GDbsdbJd
	 M72+jG5aXw0aTU30MlZKSswQx2IjhIZnHAzug69lej281a0h5V+QqmfGE5CKIsVADz
	 NpNhbcSJXtMvQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EE4B4E632D2;
	Fri,  6 Oct 2023 23:31:03 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: wireless-next-2023-10-06
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169663506396.14259.17929866398775888739.git-patchwork-notify@kernel.org>
Date: Fri, 06 Oct 2023 23:31:03 +0000
References: <87jzrz6bvw.fsf@kernel.org>
In-Reply-To: <87jzrz6bvw.fsf@kernel.org>
To: Kalle Valo <kvalo@kernel.org>
Cc: netdev@vger.kernel.org, linux-wireless@vger.kernel.org

Hello:

This pull request was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 06 Oct 2023 17:53:07 +0300 you wrote:
> Hi,
> 
> here's a pull request to net-next tree, more info below. Please let me know if
> there are any problems.
> 
> Kalle
> 
> [...]

Here is the summary with links:
  - pull-request: wireless-next-2023-10-06
    https://git.kernel.org/netdev/net-next/c/a1fb841f9d18

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



