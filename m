Return-Path: <netdev+bounces-149575-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02D449E646E
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 03:50:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7576F169C40
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 02:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E85DB170A11;
	Fri,  6 Dec 2024 02:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="StwyXFVo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF1D15534E
	for <netdev@vger.kernel.org>; Fri,  6 Dec 2024 02:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733453415; cv=none; b=WSO0FFa8pLQpmdm2zTxjTbBYubId36D/pJsBZmK1T+8ZedrXEKYEIE1yGEYrl9+XXdUuFhc1YXZHnwGjZcmHVWdANOWnwHoElZg4TC6PAu1SdlPfDOe3aBBinHIOG3I+2vTMg22R5fCi4ExGJ+5/ULLrAldoD1MDkBxdy5dZkZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733453415; c=relaxed/simple;
	bh=sXnijNJrqVTBektyw43E80qkvshBqy60uezbzdBy7ik=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=m6XEI1nz+VLx6JG9HFzAVfFElQkVq233DDGQ+2b7xyueyCresqKuMrh7FHgUh9xaUAZPAXCj72cwr9DjmFG/YejdQ8bkk1OQxVmlcCq+oEfOFRmvSIvRMIx6AbwH+02jmt36GvmcLj/2va2/wbzr1DJ/FFgMPwfXwgnTR5CfZFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=StwyXFVo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B64BC4CED1;
	Fri,  6 Dec 2024 02:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733453415;
	bh=sXnijNJrqVTBektyw43E80qkvshBqy60uezbzdBy7ik=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=StwyXFVoFMLeSd6cHqZ1jkIdJce5TU3L7+suMmC1VasC6h1ca6rjI539fQkJYwuuZ
	 JGYCDm5OYemsm81lFZ0vE9+Ay1+ityWEt0uJFyXZ2Ox9T7ECZxBB1rN9vc2Uu8tUP9
	 zWbtB9cV1fQJgAUiHXJjVRvCpsMMlrpr4bageT29FOHV0bKal0lh8ZGHUFWNdFEiu6
	 If74U0hsFvOWWmJZHdAq+/oICXZc/79CVYsmpqGFOm/wHIZmKZs/vM72nPR+qUKyyN
	 bSW8P0Ph0vS9tzzQRzJlXqCXhcQMt1ae7b781FsZN+fEAqT+nO+/uQsXMnz6mg6u1d
	 Hx8AvtrEJkvYA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34CFE380A953;
	Fri,  6 Dec 2024 02:50:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] net_sched: sch_sfq: reject limit of 1
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173345343001.2168521.15925898547780682340.git-patchwork-notify@kernel.org>
Date: Fri, 06 Dec 2024 02:50:30 +0000
References: <20241204030520.2084663-1-tavip@google.com>
In-Reply-To: <20241204030520.2084663-1-tavip@google.com>
To: Octavian Purdila <tavip@google.com>
Cc: jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, shuah@kernel.org, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  3 Dec 2024 19:05:18 -0800 you wrote:
> The implementation does not properly support limits of 1. Add an
> in-kernel check, in addition to existing iproute2 check, since other
> tools may be used for configuration.
> 
> This patch set also adds a selfcheck to test that a limit of 1 is
> rejected.
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] net_sched: sch_sfq: don't allow 1 packet limit
    https://git.kernel.org/netdev/net-next/c/10685681bafc
  - [net-next,2/2] selftests/tc-testing: sfq: test that kernel rejects limit of 1
    https://git.kernel.org/netdev/net-next/c/1e7e1f0e8be1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



