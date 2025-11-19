Return-Path: <netdev+bounces-239816-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 36C10C6C9F7
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 04:34:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 411854E5099
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 03:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 427F8284686;
	Wed, 19 Nov 2025 03:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nzNLCXx9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA3C1E47CC
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 03:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763523049; cv=none; b=WUgqcqCoxMWgCLp/JFm+mO0iqH7bY582IdPwdGtdi2jxylvPSRfuE2ZB8tt1T11zkVnZu1J8KAb0i774KUXlQgwev/M14FYjpvgDsJEM82gJMeeCK0gUvTOF7WY9jLKFYtXRYeoXOtFGwF1ld3ZHa3M8pQdRAYoY9rHWUroy/ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763523049; c=relaxed/simple;
	bh=jok1ik4kpAWkydLxNwrsBhlKqZcvyDF6/ke3Pbmg6G0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kwzNNetiedb6mh1VC2fd4q+cQlifHQOMNhD+seJ8o3X94t0CeNZfjus6t72Hb5oFZoCGXGa0zp0a8wRcNI4YpJbJiCv+Tzf8Ruv35QQhFrl5K6ikTOg3XWDeKHRMH0GrGriX5C0pdCEt/qKtCGsQsq2SDblEXS2cXzQpteXee0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nzNLCXx9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC5E4C19423;
	Wed, 19 Nov 2025 03:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763523044;
	bh=jok1ik4kpAWkydLxNwrsBhlKqZcvyDF6/ke3Pbmg6G0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nzNLCXx9U9Or7YpuElj3qSPFxNKhJvZtANs3cQtfWIBEZXCzfpzyfsRqAG5ItXEWY
	 VkRg8I20OhLAln+PdjDCN+m3sm0jwQVctnAiaD0JKmZ3j78gQHqIUdtkR7zT+hUsNj
	 AZ6dI8aAO82IomYgkPGWAaxIB1AsFTLGbGs2gyFzfTkZD5i67AwavLN5JkohupjJSm
	 EPIbLkP9/7HHTg+K6GFGnacOZQjY+st4QmZ/XWCGZChs0Mo7OofAg49sCxjcu2KXOk
	 Wyhf3XPJ+S4MNaZJSN1nFvKH1xS2QN0KZRhqgGCHIh4kwAzkA+DovpwbAuVi7qMYQj
	 trcDsXgpxgW/Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 344B0380A954;
	Wed, 19 Nov 2025 03:30:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net 0/2] af_unix: Fix SO_PEEK_OFF bug in
 unix_stream_read_generic().
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176352300975.209489.12309467398013047614.git-patchwork-notify@kernel.org>
Date: Wed, 19 Nov 2025 03:30:09 +0000
References: <20251117174740.3684604-1-kuniyu@google.com>
In-Reply-To: <20251117174740.3684604-1-kuniyu@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, aconole@bytheb.org, kuni1840@gmail.com,
 netdev@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 17 Nov 2025 17:47:09 +0000 you wrote:
> Miao Wang reported a bug of SO_PEEK_OFF on AF_UNIX SOCK_STREAM socket.
> 
> Patch 1 fixes the bug and Patch 2 adds a new selftest to cover the case.
> 
> 
> Kuniyuki Iwashima (2):
>   af_unix: Read sk_peek_offset() again after sleeping in
>     unix_stream_read_generic().
>   selftest: af_unix: Add test for SO_PEEK_OFF.
> 
> [...]

Here is the summary with links:
  - [v1,net,1/2] af_unix: Read sk_peek_offset() again after sleeping in unix_stream_read_generic().
    https://git.kernel.org/netdev/net/c/7bf3a476ce43
  - [v1,net,2/2] selftest: af_unix: Add test for SO_PEEK_OFF.
    https://git.kernel.org/netdev/net/c/e1bb28bf13f4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



