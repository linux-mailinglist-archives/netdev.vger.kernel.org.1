Return-Path: <netdev+bounces-67242-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41AC0842725
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 15:50:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 752211C23F09
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 14:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C390F7CF08;
	Tue, 30 Jan 2024 14:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nwhjajbo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6F56D1AD
	for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 14:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706626227; cv=none; b=JvTdkRSZn1UlebcD5wwzmkDNvQazcG+fYkriAwAMbjEtGqLyIIh2ZYarNuN+UKIQEOWgxtqIaDz0p0v6tV9LY6Fzg3Tw1Yu9kgS13iW68vVn7sRe1WAOYY6IplSM+S52nilUR0hRqPwkyR4zbW67VPXe3ZHbqHinCCc+97Mw7CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706626227; c=relaxed/simple;
	bh=89ubCQ9eQUVsLimNXbPevD5UuYz+gONNhrsFjqQyBfw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QPhxgiGgR46Zclr5XQJL3y9qKzW5/RsAZ2+IrIu41YYDN+LtJuatUKfqRqmvKMtpUWUrNjWlbrqh0PrX0QnFF2y0Tqfp85WBJby76URy+JgMU/7if3kF/VOGpvCt8cW/SQi/pol+y2IQCozAqfcCk1IqvCy7JOIJOwhU9Kg48Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nwhjajbo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 27812C43390;
	Tue, 30 Jan 2024 14:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706626227;
	bh=89ubCQ9eQUVsLimNXbPevD5UuYz+gONNhrsFjqQyBfw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Nwhjajboyb445/tnGe1G9Nq3KOWdAkPT+Tn328xOEK1X2XyNchqfIYgYT5ILRkVpV
	 Be8ddcZg3Z+DTA5dzlBwl7q0SsgsaakedVcAgtdtMMVqygxzIZvebGGtpMprc/cDYB
	 bl6Pugf3qMwNbwTAlFVaqOJIWYGAN++7ipuPcJWumL6msQeinw1DzH650rjcaq/B4v
	 /J9wLMlBNDGA8QHhRQgA0HhPfyHHd3ND6Wth/S8jECOXnKkgEHY6DPGvomGVrKbFwR
	 BGQG/We54Yop6vP8W7GbtaQL5VavqOK7Hw1uQn5s6UvyMm0goc5ExxNtNKvLwNT5WW
	 b4sAyc/+0NCcQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 11822E3237E;
	Tue, 30 Jan 2024 14:50:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/6] mlxsw: Refactor reference counting code
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170662622706.18350.17407156373769387095.git-patchwork-notify@kernel.org>
Date: Tue, 30 Jan 2024 14:50:27 +0000
References: <cover.1706293430.git.petrm@nvidia.com>
In-Reply-To: <cover.1706293430.git.petrm@nvidia.com>
To: Petr Machata <petrm@nvidia.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, idosch@nvidia.com,
 amcohen@nvidia.com, mlxsw@nvidia.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 26 Jan 2024 19:58:25 +0100 you wrote:
> Amit Cohen writes:
> 
> This set converts all reference counters defined as 'unsigned int' to
> refcount_t type. The reference counting of LAGs can be simplified, so first
> refactor the related code and then change the type of the reference
> counter.
> 
> [...]

Here is the summary with links:
  - [net-next,1/6] mlxsw: spectrum: Change mlxsw_sp_upper to LAG structure
    https://git.kernel.org/netdev/net-next/c/6dce962c4cf9
  - [net-next,2/6] mlxsw: spectrum: Remove mlxsw_sp_lag_get()
    https://git.kernel.org/netdev/net-next/c/5a448905e37e
  - [net-next,3/6] mlxsw: spectrum: Query max_lag once
    https://git.kernel.org/netdev/net-next/c/c6ca2884ba04
  - [net-next,4/6] mlxsw: spectrum: Search for free LAD ID once
    https://git.kernel.org/netdev/net-next/c/8d8d33d4e38b
  - [net-next,5/6] mlxsw: spectrum: Refactor LAG create and destroy code
    https://git.kernel.org/netdev/net-next/c/be2f16a994f0
  - [net-next,6/6] mlxsw: Use refcount_t for reference counting
    https://git.kernel.org/netdev/net-next/c/1267f7223bec

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



