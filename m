Return-Path: <netdev+bounces-109218-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE34927730
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 15:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC0E42858B7
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 13:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B7EC28373;
	Thu,  4 Jul 2024 13:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CHSu4LaN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646084C70;
	Thu,  4 Jul 2024 13:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720099830; cv=none; b=TdF/KrsrHtkJU/cEkcqbtmwph0ZaVQEAtvOc22UOnskXMzWx9a24htpViFzzIcH1tAtIK7aWkQxXYNUtQ8CkshI+Jh0doF7jCkZRjT1k7qdeOyjdSjlH4VoWZRDZ5qW51yi1ij+23EqOuvoJdGzQLqGEuXDHr3ODkU8Cu5yzWSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720099830; c=relaxed/simple;
	bh=oEEA/VHkH+uWWv466RtkE9FrCA6zYPpRID8sNfEaRpE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EXR89ZuUgrkKcoqiXHbJG8wfqb5PM91+8gtiRBwYOBcACWX+Xe+I61oE2wMl00gxDdS7SXdJXkhIIXsCMt8nNzyxVtJe+w1sRaRNvjLIP6BlAlA7CP248wNnhd48KfaAZkWp+nXN/9v2EhJzAUKMtjvn/DgdKcOgWTCeXTamoU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CHSu4LaN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DDEFFC4AF0A;
	Thu,  4 Jul 2024 13:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720099829;
	bh=oEEA/VHkH+uWWv466RtkE9FrCA6zYPpRID8sNfEaRpE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CHSu4LaNO9sEDAZj0jTu/an+1ZGmSjnPe9npjPeKWCtpgP7qudGYsU3ZxE/ghdJXq
	 TI2yrzw4J8mND+ELc4/6oXd+0SdL0mYmiLneSn7XbsVAw6XZUDA3OcITDGRYJV3HAB
	 n2xHyvMbWwJk60H+d4Nexw4+Ljn5Z/ekICRh9se3hI+KKIkTjA+AAFS2q7auZU4odB
	 j3NzmIcefkASZ322iSyL7T5R0j1/AneYdG55lu7YRul/o8IL4G3GqyUdecoeNFBJyS
	 PbTsHVCUdoB38T9IE8lK6l1Fbej5vXDBrMDRJKjBp7TNBsv4HK0mSUQpeAH1CoJXxu
	 7pr07gAkoL7rw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CDFBCC43331;
	Thu,  4 Jul 2024 13:30:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] inet_diag: Initialize pad field in struct
 inet_diag_req_v2
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172009982983.30398.11491339248404155106.git-patchwork-notify@kernel.org>
Date: Thu, 04 Jul 2024 13:30:29 +0000
References: <20240703091649.111773-1-syoshida@redhat.com>
In-Reply-To: <20240703091649.111773-1-syoshida@redhat.com>
To: Shigeru Yoshida <syoshida@redhat.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, syzkaller@googlegroups.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed,  3 Jul 2024 18:16:49 +0900 you wrote:
> KMSAN reported uninit-value access in raw_lookup() [1]. Diag for raw
> sockets uses the pad field in struct inet_diag_req_v2 for the
> underlying protocol. This field corresponds to the sdiag_raw_protocol
> field in struct inet_diag_req_raw.
> 
> inet_diag_get_exact_compat() converts inet_diag_req to
> inet_diag_req_v2, but leaves the pad field uninitialized. So the issue
> occurs when raw_lookup() accesses the sdiag_raw_protocol field.
> 
> [...]

Here is the summary with links:
  - [net] inet_diag: Initialize pad field in struct inet_diag_req_v2
    https://git.kernel.org/netdev/net/c/61cf1c739f08

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



