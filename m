Return-Path: <netdev+bounces-249588-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E2008D1B63B
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 22:27:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 95126303DA91
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 21:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C67CC316180;
	Tue, 13 Jan 2026 21:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VTZnmihq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44D8A945
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 21:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768339594; cv=none; b=MKniPmzHjVOwMVIGv3zKL/rj1yLEnLBo38v+WR7JqMpNGDzL9DEVjYE0xe6lCpJ+AMDt8MUSuHgT7eF6RCO02GAeOntY4/e0/RfBQ1NdtwGnjJN7isxh46mE5RCTdqfrZEAkXDAceCDm5jYW2s6m1E45Io2v9Agbg3z7OjetD5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768339594; c=relaxed/simple;
	bh=zEsMdZR3XVsKRKvRJ1tzkAT1sStQT9WpNo/09NvAHls=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BKt4haYd25Lm8TEXbDReTRmPmnRgOlfCuDkVlozx1WmGb4uSbp1H/Xv3dRZMwWwVucUDQUrxNUXy/uGNnf7PCNeRgXn3LU+uy0LO5xB4YtNU7k1FbIWLJia90JcxyhZVQU7zGE+2RBylhUXQdLcVTRQCi1Oh4P3fkqDDJiycysg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VTZnmihq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FADDC116C6;
	Tue, 13 Jan 2026 21:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768339594;
	bh=zEsMdZR3XVsKRKvRJ1tzkAT1sStQT9WpNo/09NvAHls=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VTZnmihq4wMe3YNApjXdQ1d6i/o6AClnNtn0YRsPPkwyevN9u6ObyFDzwLiuyAkHq
	 5fLKu19mvFEKiPTzyYmwrrRFl/qrHvA1lgVjPVRsCu6rvnEeS/bsNIQzn7nSNcZAUG
	 d0dPjBkaRrMX8GCOQ84XydmscVRViNz8z/oETc/T3x44CdHfKMnABQnaGkDgYLlo/5
	 mUiEsQC6OsI8QsoXQPMGLcDYnSNL2qnBxTH42VzsK9J2ZG+VYj7R327ccXBAiWhda/
	 v5uW+8piRg+pjLoUS63QNnvFQEISA5kGfI8xDv59EQz+UgHahQJ+UIC1IN+RhcYtHa
	 8w0l5pTiG5kcg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B634C3808200;
	Tue, 13 Jan 2026 21:23:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] selftests: net: reduce txtimestamp deschedule
 flakes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176833938727.2413578.6650630585471811597.git-patchwork-notify@kernel.org>
Date: Tue, 13 Jan 2026 21:23:07 +0000
References: <20260112163355.3510150-1-willemdebruijn.kernel@gmail.com>
In-Reply-To: <20260112163355.3510150-1-willemdebruijn.kernel@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org, willemb@google.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 12 Jan 2026 11:33:39 -0500 you wrote:
> From: Willem de Bruijn <willemb@google.com>
> 
> This test occasionally fails due to exceeding timing bounds, as
> run in continuous testing on netdev.bots:
> 
>   https://netdev.bots.linux.dev/contest.html?test=txtimestamp-sh
> 
> [...]

Here is the summary with links:
  - [net-next] selftests: net: reduce txtimestamp deschedule flakes
    https://git.kernel.org/netdev/net-next/c/c65182ef9df6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



