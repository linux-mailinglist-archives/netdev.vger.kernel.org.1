Return-Path: <netdev+bounces-100782-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32E418FBF72
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 01:00:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B295D1F23118
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 23:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA59B1411EB;
	Tue,  4 Jun 2024 23:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vAvpfzdT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937FA137C37
	for <netdev@vger.kernel.org>; Tue,  4 Jun 2024 23:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717542029; cv=none; b=bUbUpcufxLXcMFSdd8pu2hEskp+ED8mSOJWFe19mzU4Rs8mNhsjL1spoUcGOjvHD+TGPqdLcHvFa3pPGD3TT7Er7bnamAoq0w0Qpvv+tajq0bWWarI2xBUeBkQGIyPZfO2WpuOF10m7ubQ3RsUZ07LqtXKGFfNGzwRPymhZxNGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717542029; c=relaxed/simple;
	bh=Kz2QJnKzTNpnZG8strgA81NjQ4YFYQ0leWMuCwNAJy0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Xw5Lp6nxpRO9wvw1hkdLIh5R81Z0IPg6jvE/rtv1TD+a+jdmE2K9TNQU4Ig9iCUQ4L2FBqPcz6fhWmcxA2xZVDJg+cLmEdllsSUTh4doLiKiL0FvHilrwkPm6d4a2JDWd82escssvDkJB2VgV5Rk18xuiiXI5h8rz6SMeRVeUlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vAvpfzdT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 295E8C3277B;
	Tue,  4 Jun 2024 23:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717542029;
	bh=Kz2QJnKzTNpnZG8strgA81NjQ4YFYQ0leWMuCwNAJy0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=vAvpfzdTWG/xDLKBfg0/23cWs4NMfhR6K1n7Ml03dbXWmZSaKNI78ZpOrEizwJ71C
	 o4zX+nrnP2MEzHL99pBRfMW7aC911FhDw76NOshxWcV7mgk4O7StTESb8vc9Y1nadq
	 OI6KxLsHB3M942WlrGzH2in+DIJA+mkAeyFl77SNJQjuYWuh20QlfxfOAr9KtNn3Rc
	 KU5Ef4/vlpcV4+bGjuI4KiquXmCE4xkKjj9vffXFAKnCU22oB4SaRfePwMIWZZ8adE
	 er+xC7IONm60WQRqwveBqGSQ/6B+q8xTdL1vH5n4hM+NfHsW0H+swzgXGabzi8oHMh
	 ww98Pc0zQZ4ng==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 16FC0DEFB90;
	Tue,  4 Jun 2024 23:00:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute-next v1 0/2] Add support for xfrm state direction
 attribute
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171754202909.16415.296238771283765271.git-patchwork-notify@kernel.org>
Date: Tue, 04 Jun 2024 23:00:29 +0000
References: <20240523151707.972161-1-chopps@labn.net>
In-Reply-To: <20240523151707.972161-1-chopps@labn.net>
To: Christian Hopps <chopps@labn.net>
Cc: netdev@vger.kernel.org, dsahern@gmail.com, devel@linux-ipsec.org,
 chopps@chopps.org

Hello:

This series was applied to iproute2/iproute2-next.git (main)
by David Ahern <dsahern@kernel.org>:

On Thu, 23 May 2024 11:17:05 -0400 you wrote:
> Summary of Changes:
> 
>   This patchset adds support for setting the new xfrm state direction
>   attribute.
> 
>   The change also takes into account the existing "offload" direction
>   atttribute. If the user is already setting the direction when
>   enabling offload then that direciton value is used, and the general
>   "dir in|out" need not additionally be specified.
> 
> [...]

Here is the summary with links:
  - [iproute-next,v1,1/2] xfrm: add SA direction attribute
    (no matching commit)
  - [iproute-next,v1,2/2] xfrm: document new SA direction option
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=7cf98ef28b61

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



