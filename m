Return-Path: <netdev+bounces-70066-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E654B84D7E8
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 03:40:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B20B7287299
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 02:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 374EC19470;
	Thu,  8 Feb 2024 02:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eYd3LNf/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6791D530
	for <netdev@vger.kernel.org>; Thu,  8 Feb 2024 02:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707360029; cv=none; b=sbwk4RZlJY4snk9DykkSPaapyJCW6QTkcI1KUbdOEm2aUGhQAR7X1jBWV+K6NZHenFkD6FHUBx0x6QMwukAMMsVS9SgeGXE/7oMM3qDCrZ8CXLZ2loAgh0gbaADa1dBCe6oD/20sxnynQbxU+IF7VaLS0L2sji/QwCHPZ+MQu6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707360029; c=relaxed/simple;
	bh=13RsciDe2oWNZJhoAJf7DPaXaXsCyyJwZhBZ2ebQSgg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dQdJM9gOhlIXOwFA1o1hTed2fu7Pi0XHOMtCwVGtXbbEteu1xUvIY2t7z2XG6EPVJHl9PXQf8GM2t08hsq5AKMUQydVIz7bfqNhb2eRDaLSllGv1m6zM7cFnvXIlvEAtctadckLNrJ/CApZKfXQMO6UupPeLtbvB41U1ksHWcq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eYd3LNf/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 93976C433F1;
	Thu,  8 Feb 2024 02:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707360028;
	bh=13RsciDe2oWNZJhoAJf7DPaXaXsCyyJwZhBZ2ebQSgg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eYd3LNf/nHSmcexvkKtRWDi/2Y2F6gESN+ajEG//EbS/2gk1LOMMzKM/1Vb+R+hm/
	 JBLF18CuWFp7KiEhPt+KZaWFVkMwEFhZDbYvQH5Nhy3dbwViqhHrzqgPkcO00FNv48
	 Lvi/ogRUP92D/9RHGgPOXdySMwqbfQdDCdFYwwnQ7zymCY+ZsLLVS3S5EKCI4DrB3E
	 Io1LRHIO+uPDg60ykDDLo13jLhDDtmduH6xlMm5hhF4ntdFcR7PdNKrVBe+KNyeQ02
	 JjbGTrtf1ulSf422fTvM4Xw5US6mDEOVmvOUE0enlLN3JmwJw61LXBMpGwowmiaYae
	 3+o7O1XmEGu0Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 74C3FD8C96F;
	Thu,  8 Feb 2024 02:40:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCHv5 net-next 0/4] selftests: bonding: use slowwait when waiting
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170736002846.13402.8232804423228560746.git-patchwork-notify@kernel.org>
Date: Thu, 08 Feb 2024 02:40:28 +0000
References: <20240205130048.282087-1-liuhangbin@gmail.com>
In-Reply-To: <20240205130048.282087-1-liuhangbin@gmail.com>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, j.vosburgh@gmail.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com, liali@redhat.com,
 przemyslaw.kitszel@intel.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  5 Feb 2024 21:00:44 +0800 you wrote:
> There are a lot waitings in bonding tests use sleep. Let's replace them with
> slowwait(added in the first patch). This could save much test time. e.g.
> 
> bond-break-lacpdu-tx.sh
>   before: 0m16.346s
>   after: 0m2.824s
> 
> [...]

Here is the summary with links:
  - [PATCHv5,net-next,1/4] selftests/net/forwarding: add slowwait functions
    https://git.kernel.org/netdev/net-next/c/c8f4b19d64b9
  - [PATCHv5,net-next,2/4] selftests: bonding: use tc filter to check if LACP was sent
    https://git.kernel.org/netdev/net-next/c/9150820c8830
  - [PATCHv5,net-next,3/4] selftests: bonding: reduce garp_test/arp_validate test time
    https://git.kernel.org/netdev/net-next/c/45bf79bc56c4
  - [PATCHv5,net-next,4/4] selftests: bonding: use slowwait instead of hard code sleep
    https://git.kernel.org/netdev/net-next/c/e1f0da9b90fb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



