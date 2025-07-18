Return-Path: <netdev+bounces-208071-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A40C3B0998A
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 04:01:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B4BDA45FC1
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 02:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65F7C1E572F;
	Fri, 18 Jul 2025 02:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VA7jfmh3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42191198A2F
	for <netdev@vger.kernel.org>; Fri, 18 Jul 2025 02:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752804011; cv=none; b=GL87B2hDygA7E4aqLRezH6Uvqjl2y7/emMJDFauS4e85JSY77lyxz7HJAvxeKTS5vIkKKLaGRnkpxmbUtarWnxy7Vu+mMZ1IDmudDETyzQo+7l/NFZtWO0QDzrhq3uCAisuI4k6ZrlhUsVMoQwyB1LQAil7GcOE8ezFCzhgDz5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752804011; c=relaxed/simple;
	bh=mTpjuTj688fP2fvbuR+8vslaikIDiXw9/dlv31CNkcE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SYWRc8NaYP00x6UbkhZAYe84uqgccHGFA+oWgdZW7kW5EL4GtHtLlrbSfITW//Net0WlmIeDKjLnjNy5RS1Og74pWTV0xxLt4wYjvDfCWCi8BEsxyCJyajwsiPxW1NmjzbE+hOhsrCXpv0oyKUZGM+W7Dktfi+bmhMZEea9HByE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VA7jfmh3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1943FC4AF09;
	Fri, 18 Jul 2025 02:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752804011;
	bh=mTpjuTj688fP2fvbuR+8vslaikIDiXw9/dlv31CNkcE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VA7jfmh3FaKieMwB1U5Pk/72g3u4ol+j/ptSIEr94R9ELg+bSiA/t3u0OQLI8YxOs
	 GUCxJ7DZkCAKDDKGYpRTCmsHMAm2uH+TkTxFdOGDNlCy3onPF/Ys/GKN2+Ol+KJ/2X
	 rlAXl74o04OAPBXA/nEQnvCOaeQbQ/p/VoTx2Uc/CUfwYmYvKJ2Wea8zECEh3IaU4k
	 vSJeAV9Z9DEOD3+phY0P4G7K3vJuiIclmYR7/aZ9ziUTrnre9qdf7goEabSB/gXNJp
	 VvupnMFuBlLpQSxZTzfxmdQV1YYo/mlPjg9A39SQyxuBYR70CZW9biYvQf5q8+oSp/
	 gDSvoL0rIKbRw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C40383BA3C;
	Fri, 18 Jul 2025 02:00:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] selftests/drivers/net: Support ipv6 for
 napi_id
 test
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175280403100.2141855.5442689978479424575.git-patchwork-notify@kernel.org>
Date: Fri, 18 Jul 2025 02:00:31 +0000
References: <20250717011913.1248816-1-1997cui@gmail.com>
In-Reply-To: <20250717011913.1248816-1-1997cui@gmail.com>
To: Tianyi Cui <1997cui@gmail.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 16 Jul 2025 18:19:13 -0700 you wrote:
> Add support for IPv6 environment for napi_id test.
> 
> Test Plan:
> 
>     ./run_kselftest.sh -t drivers/net:napi_id.py
>     TAP version 13
>     1..1
>     # timeout set to 45
>     # selftests: drivers/net: napi_id.py
>     # TAP version 13
>     # 1..1
>     # ok 1 napi_id.test_napi_id
>     # # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
>     ok 1 selftests: drivers/net: napi_id.py
> 
> [...]

Here is the summary with links:
  - [net-next,v2] selftests/drivers/net: Support ipv6 for napi_id test
    https://git.kernel.org/netdev/net-next/c/b6645645d0d0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



