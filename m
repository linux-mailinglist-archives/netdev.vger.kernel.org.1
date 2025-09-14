Return-Path: <netdev+bounces-222879-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE3A0B56C01
	for <lists+netdev@lfdr.de>; Sun, 14 Sep 2025 22:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEEE71765C6
	for <lists+netdev@lfdr.de>; Sun, 14 Sep 2025 20:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1374E2E7F11;
	Sun, 14 Sep 2025 20:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eDGh5wZQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE652E7BD8;
	Sun, 14 Sep 2025 20:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757880609; cv=none; b=UuZriOtX43zSTPosXHT6yJCqVWvSPXFD7tVHa2cLaOW4eZ03JjIIfTPGRByxOZMU3GTd8l1G5NpApBkL0XkDymDT/t6i8PUIdjpLLsFnJsccHyUs1MbKCkeLrBDv95isVXVtwuXRatJHVhB88UwCdoUw6a0XHPCvLgfvcg+N9SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757880609; c=relaxed/simple;
	bh=6BZs/51bPEyBaQZRYt3F9h8ENkgAbLGJal26aHGi6CI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=u+2mePI/gs3FREA31xBXkTxh5pAHCEcYterXEadCyqQcaqxsEqXG+pDk2/O36N7vn681J5wweFOBiiMGgs9jIMaW5+IXZKHuc4ybbXtIjiOBUbrFBM75WY4vfuUQVEaI3mJyrOfQQS5cn+Ke+h+d7uIaPLlZacyI1JUfpGPS/Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eDGh5wZQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B77F9C4CEF1;
	Sun, 14 Sep 2025 20:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757880608;
	bh=6BZs/51bPEyBaQZRYt3F9h8ENkgAbLGJal26aHGi6CI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eDGh5wZQMb4U9JGPbczoAaOmuJn16x1EkGZzMYOpXKG74BQiYPJ8xNcV0i4cyCgoK
	 0jIITLIcDC/2rYrP8E4hjkYx2js5Pztfek3umpzOQjlIVZ0Jt0sruJ+sdIzAHLFN3Q
	 SkHsoZvsuXN/zsyDypYXd8ytcwvIMDBwJ6Jr37VNwtDG1W1gl9y5FunVyA9nZsAHcp
	 smh0aUIhSxYEX1qJkkMqmjxbh27ocum0rXXzbBdN3AdrpCkHbU9eL6CidGWFPpO6No
	 irzgdQJkS8H4BLzfHFVWgj9xw+EBjSAHDGiT8H55I8iYN8S5zGu6jiVI6CpcxyGaIP
	 +OWWns4JAxyAQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADBD339B167D;
	Sun, 14 Sep 2025 20:10:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] rxrpc: Fix untrusted unsigned subtract
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175788061024.3540305.4709268954141059215.git-patchwork-notify@kernel.org>
Date: Sun, 14 Sep 2025 20:10:10 +0000
References: <2039268.1757631977@warthog.procyon.org.uk>
In-Reply-To: <2039268.1757631977@warthog.procyon.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: dan.carpenter@linaro.org, netdev@vger.kernel.org,
 marc.dionne@auristor.com, kuba@kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 12 Sep 2025 00:06:17 +0100 you wrote:
> Fix the following Smatch Smatch static checker warning:
> 
>    net/rxrpc/rxgk_app.c:65 rxgk_yfs_decode_ticket()
>    warn: untrusted unsigned subtract. 'ticket_len - 10 * 4'
> 
> by prechecking the length of what we're trying to extract in two places in
> the token and decoding for a response packet.
> 
> [...]

Here is the summary with links:
  - [net] rxrpc: Fix untrusted unsigned subtract
    https://git.kernel.org/netdev/net/c/2429a1976481

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



