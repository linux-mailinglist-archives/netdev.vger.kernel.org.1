Return-Path: <netdev+bounces-85260-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66EC4899EBC
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 15:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04BD61F2496D
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 13:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9967D16D9B0;
	Fri,  5 Apr 2024 13:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KBisNSgz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7210F16D4FF;
	Fri,  5 Apr 2024 13:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712325028; cv=none; b=Kq23ZUa4vLtXdTjbSmdg9N5eeKure4HEm6kTZ/O5TKjP7X1Uy9swJJ0/gbbr1lcjjLw0M981pbPsW6XQQj624J/Ltg5rcdFpg7kamzUUqF3rGwmxEOLQa4voZcKbuvotsDEnOJ+GsL21dIXoNUGL83JdaR+cefhxDHHPWVC8+cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712325028; c=relaxed/simple;
	bh=+Z1xiBAMcWrD/ptZInUXPYg88PiXraQGkgCm1Cbr3lM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aOSyaO/XgUr99TkfMso/9NmBe2UZPMjk3bK7uVHET1ms7uE27nqUNXQagyFGFkY7Ee1hpYpIzaDRH/l12c4O4rVZk77AHCC35khYtY386MboQCcntcZCUk17DP9MEbdMxzlpj4+slLFBiP7nM+uxn+yR+fFvmshXdjeamV3JlPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KBisNSgz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 470E3C43390;
	Fri,  5 Apr 2024 13:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712325028;
	bh=+Z1xiBAMcWrD/ptZInUXPYg88PiXraQGkgCm1Cbr3lM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KBisNSgzSx5U9UVsOhUt6BOH+a8T79wwc2bbLfG2BmFKy4I/YpKvA4JVe8gx8yrgd
	 U5yUULXPzIRpi7pgA7SqrFgS2kOWx+diRqlENq4HxpzhxtQp6tkqPVhVR6OCYByLIT
	 cpFYu73puhnahQwZdqZ8zq4chLc7R9UrVjshm431zLpu6nW72YGWuI7557GimJF0ey
	 7PV5mrt+8KyTFxJsrLKztQt89+5JT2ed/6AktoWagDHVSerTy94a7mLnpmzVlI9Pcr
	 eRLDEpYc+VhAx+e4etqQjf6wTdjL0/aLsbZkuDkxEJxoG/Oihh+ZrbAGMvQag5Ll/g
	 BNRmWJGFBwwRA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 37759D84BAC;
	Fri,  5 Apr 2024 13:50:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] MAINTAINERS: Update email address for Puranjay Mohan
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171232502822.18027.11657640946386616948.git-patchwork-notify@kernel.org>
Date: Fri, 05 Apr 2024 13:50:28 +0000
References: <20240405132337.71950-1-puranjay@kernel.org>
In-Reply-To: <20240405132337.71950-1-puranjay@kernel.org>
To: Puranjay Mohan <puranjay@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 bpf@vger.kernel.org, netdev@vger.kernel.org, bjorn@rivosinc.com,
 puranjay12@gmail.com

Hello:

This patch was applied to bpf/bpf.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Fri,  5 Apr 2024 13:23:37 +0000 you wrote:
> I would like to use the kernel.org address for kernel development from
> now on.
> 
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---
>  .mailmap    | 1 +
>  MAINTAINERS | 6 +++---
>  2 files changed, 4 insertions(+), 3 deletions(-)

Here is the summary with links:
  - [bpf] MAINTAINERS: Update email address for Puranjay Mohan
    https://git.kernel.org/bpf/bpf/c/cfddb048040b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



