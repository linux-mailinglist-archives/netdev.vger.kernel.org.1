Return-Path: <netdev+bounces-111003-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D5A092F3E0
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 04:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC83A1F22EC4
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 02:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 602F97464;
	Fri, 12 Jul 2024 02:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DgUUSEmc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3688F944D;
	Fri, 12 Jul 2024 02:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720749631; cv=none; b=ZFul6TKvyKYr8Oxv/9uCwtxVpgcJ3LsJcSck7C4i8li5E2Gq6I22XfeHaOa4i+9e2HuQtpPLyrLZWYFS46c76IuVBLn3UbEr53WkLrc7lHfmeP/7wztwqm/Rk5VXEyX4lbHTPYv4C3x+A3rGDvevV9NYnHILQDqjliTb/9I5Szs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720749631; c=relaxed/simple;
	bh=P7ZiPqUQRuQUGZBADPxksQyILhfLL+KQ0uuPbkyDzSU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qDx4kjJwrdWhG78M6w0Olb+zUhq+B86C1YeZJsRPwMATfAqXwJMYDiI5M5042MzvLxCwAwWd2KkajOT1fTasipFSOMpdv/WTfXWYmaNKrfwuR8K5n/PD6ZHfMnGR1f4q913TFM6WjwV3uqslHGAIeqpx+zdqggp/UPCKt+OEnTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DgUUSEmc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BF7AFC32782;
	Fri, 12 Jul 2024 02:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720749630;
	bh=P7ZiPqUQRuQUGZBADPxksQyILhfLL+KQ0uuPbkyDzSU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DgUUSEmcC8Kkvp4vaRPqgw0owwCUfK/pfCbC+ERpw4OsN9v/dvvwy1UsGEqDSAhzW
	 w+w2KgvRxlLYTu3Sx21MzUBSL8CTBKTj9mkH4gO8JOOGijiIipG3iVbl/9AzWAw6mP
	 cHAt16MgfF8duI/W8TRC2NMM8zgxy8O3fZkr8kdRD8y0ZH5BfEkmuVgawmrjsi2vcZ
	 l7jzsCkMlYHxnF6AQM7kldN/Z+bGHzueNBDRF7bZTbjnpq7DOt7sNu7VGhmn5cIjqP
	 7mKM6Lh8AjfWh+qKzGwIPfaODiqfhmae/tmNpqqijJMAT01L981J3MnvaSGjMugwSP
	 yAr4LM7JDHYeg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B401CC43468;
	Fri, 12 Jul 2024 02:00:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/3] netconsole: Fix potential race condition and
 improve code clarity
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172074963073.12733.5678346609956628519.git-patchwork-notify@kernel.org>
Date: Fri, 12 Jul 2024 02:00:30 +0000
References: <20240709144403.544099-1-leitao@debian.org>
In-Reply-To: <20240709144403.544099-1-leitao@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 thepacketgeek@gmail.com, riel@surriel.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  9 Jul 2024 07:43:58 -0700 you wrote:
> This patchset addresses a potential bug in netconsole where the netconsole
> target is cleaned up before it is disabled. This sequence could lead to a
> situation where an enabled target has an uninitialized netpoll structure,
> potentially causing undefined behavior.
> 
> The main goals of this patchset are:
> 
> [...]

Here is the summary with links:
  - [net-next,1/3] net: netconsole: Remove unnecessary cast from bool
    https://git.kernel.org/netdev/net-next/c/a9359e8b0065
  - [net-next,2/3] net: netconsole: Eliminate redundant setting of enabled field
    https://git.kernel.org/netdev/net-next/c/0066623d4008
  - [net-next,3/3] net: netconsole: Disable target before netpoll cleanup
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



