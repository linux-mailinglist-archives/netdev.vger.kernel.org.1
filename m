Return-Path: <netdev+bounces-188519-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DF72AAD2D1
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 03:29:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6ADF31BA86C7
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 01:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7222E142E7C;
	Wed,  7 May 2025 01:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cFhjvI1T"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA1B13D8A4
	for <netdev@vger.kernel.org>; Wed,  7 May 2025 01:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746581394; cv=none; b=M2mlQ6l7VRJofFJXgacPAP+bjRNdJx2Yi//W9fwt4BdQmZSAPMpwwW3qfUmg3PNWG2w1GdB0kk9+pZ74fVZVFQAGtgGIfkAh+si59TtfTMqgThtszaX/FDG7lExfBXVz8rZX6i9WTzdjJ6cFYu5/J+dEALQN4w6Rmag8eyvcw4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746581394; c=relaxed/simple;
	bh=Mk5cFfrIe6TKz2XR0JKXuqQVykBBzrsNm2xgFuc3EKQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=haetMVC+S/d9rDfITaqBuOYdFJps86krFrIfKk+J6V+PVqi0Pk1T/NxIGocCITlZqWanMZq2tv1luYvNrtf8P8+DZcQzdl1Jvk+eX+I3YAgFVhPEPXRpDLNxlY8Sy3Mhmz8ZNO95AxoZFqVprmQpU4LkO5u4LArLHAGciMPnfMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cFhjvI1T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5B42C4CEEF;
	Wed,  7 May 2025 01:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746581393;
	bh=Mk5cFfrIe6TKz2XR0JKXuqQVykBBzrsNm2xgFuc3EKQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cFhjvI1TE2mCCrCjqK+PbWYPdtfXPiG0+LHDJuRZIkfaI7gLvfwOjJOtvjxfSnxkB
	 ck8yfPkAbZSFYsssUHMTM97ze6gMjUIzNWrbXYQVqn3ZeDKdFMhLJFEousoqsKxYGN
	 HNa7gXds0i52IysiQlGx89em2waw4rhRGCDlX7c6Sl4kUQxjXPUOkZPJsU+OrC8PyD
	 NQAfLXb8AIFO/55/a3hO8M1JN1RYEkeuWB63tCSwip2mYFw41IVD82SbAcrp+taTkW
	 Lq9T5ghXNXXFe9BEzQeB5/wpVcrjHEUuMhEIjCaLID7LdZw3s5s4qnlJ7xtal8f0P2
	 u1BhuVk6G+XJw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EACD2380664B;
	Wed,  7 May 2025 01:30:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/4] devlink: sanitize variable typed attributes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174658143279.1703446.8089871773110319316.git-patchwork-notify@kernel.org>
Date: Wed, 07 May 2025 01:30:32 +0000
References: <20250505114513.53370-1-jiri@resnulli.us>
In-Reply-To: <20250505114513.53370-1-jiri@resnulli.us>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, saeedm@nvidia.com, horms@kernel.org,
 donald.hunter@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  5 May 2025 13:45:09 +0200 you wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> This is continuation based on first two patches
> of https://lore.kernel.org/netdev/20250425214808.507732-1-saeed@kernel.org/
> 
> Better to take it as a separate patchset, as the rest of the original
> patchset is probably settled.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/4] tools: ynl-gen: allow noncontiguous enums
    https://git.kernel.org/netdev/net-next/c/37006af675e8
  - [net-next,v2,2/4] devlink: define enum for attr types of dynamic attributes
    https://git.kernel.org/netdev/net-next/c/429ac6211494
  - [net-next,v2,3/4] devlink: avoid param type value translations
    https://git.kernel.org/netdev/net-next/c/f9e78932eac6
  - [net-next,v2,4/4] devlink: use DEVLINK_VAR_ATTR_TYPE_* instead of NLA_* in fmsg
    https://git.kernel.org/netdev/net-next/c/88debb521f15

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



