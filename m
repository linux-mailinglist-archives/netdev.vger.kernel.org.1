Return-Path: <netdev+bounces-232334-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6916EC0425C
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 04:40:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27BD43AD417
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 02:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F8825F7A7;
	Fri, 24 Oct 2025 02:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GnCBXB8v"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50CAE1A9F90
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 02:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761273639; cv=none; b=rNaHuJIGZbxvZMszvuqbr8LOzcwU+T0+4BgDe71agg4RUcy6m+N/Up2bKCdxH+MGyN/qaVXxsrRSWmYxLDbVOIYnM8KDwW0RNuShW4Ofm0797WkUEo6hxFJcEwDnOsCr8fyHUJoDD0h1fyfiSutMSypjB67u70QU/H9+bXAc6eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761273639; c=relaxed/simple;
	bh=FAFQtjSvYfLaYuq38dEf6IIeOR0WewwEiGPFb9S97hs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LwwHQMvpRLo2yDY0KLVHWaSD7Qba8dhgYhW2y4YrjHE2LM621zA83FoniFJ6hMY1hum7pfqnj57ENjvSrNoGSN2R0P5BZfe/yihGLhG4GjyfoWORp31GCMa+TH6uwvm5Uji549Df/vMp14HwvRooJTmvNYeyLW4CBSVecqKeuJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GnCBXB8v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4A81C4CEE7;
	Fri, 24 Oct 2025 02:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761273638;
	bh=FAFQtjSvYfLaYuq38dEf6IIeOR0WewwEiGPFb9S97hs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GnCBXB8vuIYx0M+X0i8iKY1n0fkddwVsQ6QBrElvT6ewLNad8LPekWbTxoJo+ftWD
	 Dt1rjz0aRT+VOl5nSJBv1T7WGHTdSd038ALo0xgo6i4431ni7Hr4R+tof4XOOwUrWj
	 uEabNQSIxmTBlDdTKPiftyqm2RgCXrfrWk2Q+r6yaz1iibUiZC/CQxyK+QrwuubnLs
	 dmcHnsumSo+FRbvikY/lhEAyM4xCAFm1SFlj9xkGv9bNxCBptYKdhyvE5qn9ETq7n2
	 QE0XiNSCbMcUA4UnyXVcD9ghdJoeImVHWNsak8EdpmR5Ww0ePWhAmfM/dcEbtRmxB3
	 cR57SFH230Mng==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33EC33809A38;
	Fri, 24 Oct 2025 02:40:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tcp: Remove unnecessary null check in
 tcp_inbound_md5_hash()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176127361900.3327514.1259136362900975267.git-patchwork-notify@kernel.org>
Date: Fri, 24 Oct 2025 02:40:19 +0000
References: <20251022221209.19716-1-ebiggers@kernel.org>
In-Reply-To: <20251022221209.19716-1-ebiggers@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: netdev@vger.kernel.org, edumazet@google.com, ncardwell@google.com,
 kuniyu@google.com, davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, dsahern@kernel.org, 0x7f454c46@gmail.com,
 dan.carpenter@linaro.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 22 Oct 2025 15:12:09 -0700 you wrote:
> The 'if (!key && hash_location)' check in tcp_inbound_md5_hash() implies
> that hash_location might be null.  However, later code in the function
> dereferences hash_location anyway, without checking for null first.
> Fortunately, there is no real bug, since tcp_inbound_md5_hash() is
> called only with non-null values of hash_location.
> 
> Therefore, remove the unnecessary and misleading null check of
> hash_location.  This silences a Smatch static checker warning
> (https://lore.kernel.org/netdev/aPi4b6aWBbBR52P1@stanley.mountain/)
> 
> [...]

Here is the summary with links:
  - [net-next] tcp: Remove unnecessary null check in tcp_inbound_md5_hash()
    https://git.kernel.org/netdev/net-next/c/05774d7e4201

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



