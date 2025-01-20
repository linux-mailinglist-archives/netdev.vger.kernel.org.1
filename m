Return-Path: <netdev+bounces-159766-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71275A16C60
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 13:30:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 927E03A4CE2
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 12:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38D9C1DFE16;
	Mon, 20 Jan 2025 12:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WVVw3nE7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A8619CC1C
	for <netdev@vger.kernel.org>; Mon, 20 Jan 2025 12:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737376213; cv=none; b=jztaWgTPdCHTuZVBKnfdxvjL+hiSiw0DOmHUMacWEpSzmHGYC7yhPwGvO1tJ6KQa5+cyWrsddPOfpt6vOSrODIeDxLYt+RsyQh3h5wjyDyhxmEctTzzKEGRAcCnAue72pGzbooRF4KcsWdTr8uYgArVAWoqBbeuTWtfmjce2arE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737376213; c=relaxed/simple;
	bh=s1Wjs3Lq9r/e/JAv2KeTTFjPf8NT74E2pTzuY2BshG4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QPrnI5gM0OoR+malb4HAxVw1z4CQovv9lVJD3UYKx0xXhteBiweYi+iAxoBpLFpquZ8aHbqonlMmHKcPqgwnFhfQzqj+9x2Josi4gjcEBu/VvRkLr79sDjafunSQjvyxws0qDEiCd+jFeNUIh0XGVRPJE6BTMzvNjvutOtvrrnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WVVw3nE7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A047C4CEDD;
	Mon, 20 Jan 2025 12:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737376212;
	bh=s1Wjs3Lq9r/e/JAv2KeTTFjPf8NT74E2pTzuY2BshG4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WVVw3nE7XA1pPyPXpwmYTo5hns0GOEosCZ1ZxJ6Q6B/CfwoB/vdjbnrSuRdSUdKQ2
	 VAR4iCFlV08df1myQR6HOVIajEhQamnCuyfJwlAcZyTERz3q6rv24ikpIxgwHLit3d
	 Le2JQJ133z3BDnHNymMNUm5grS0tbjVR0LRH7/ccDYEl/lnrDiSMrAOtgyass++7EE
	 m2f26NCbpa+0AKC52rGU69DRMtozoDJ5kpj9JpTvHlnWKTCz8PJC8ZPjXPsnXT87QF
	 sc1eQhtH1wTmZts10IFITUPdaYMc9SJzQJ+VXjus4gqWh0v+7bs1q3bSru8RcZj62Z
	 IXtzKeezIYgYg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADCA5380AA62;
	Mon, 20 Jan 2025 12:30:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: macsec: Add endianness annotations in salt
 struct
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173737623625.3511965.11257724664135933100.git-patchwork-notify@kernel.org>
Date: Mon, 20 Jan 2025 12:30:36 +0000
References: <20250117112228.90948-1-anezbeda@redhat.com>
In-Reply-To: <20250117112228.90948-1-anezbeda@redhat.com>
To: Ales Nezbeda <anezbeda@redhat.com>
Cc: netdev@vger.kernel.org, sd@queasysnail.net, mayflowerera@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 17 Jan 2025 12:22:28 +0100 you wrote:
> This change resolves warning produced by sparse tool as currently
> there is a mismatch between normal generic type in salt and endian
> annotated type in macsec driver code. Endian annotated types should
> be used here.
> 
> Sparse output:
> warning: restricted ssci_t degrades to integer
> warning: incorrect type in assignment (different base types)
>     expected restricted ssci_t [usertype] ssci
>     got unsigned int
> warning: restricted __be64 degrades to integer
> warning: incorrect type in assignment (different base types)
>     expected restricted __be64 [usertype] pn
>     got unsigned long long
> 
> [...]

Here is the summary with links:
  - [net-next] net: macsec: Add endianness annotations in salt struct
    https://git.kernel.org/netdev/net-next/c/457bb7970a0f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



