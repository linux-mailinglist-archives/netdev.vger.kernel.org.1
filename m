Return-Path: <netdev+bounces-69463-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C09E84B58E
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 13:50:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4105E1F2234B
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 12:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C472312E1FB;
	Tue,  6 Feb 2024 12:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mlcXXzm/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1AE85677B
	for <netdev@vger.kernel.org>; Tue,  6 Feb 2024 12:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707223829; cv=none; b=Zh8V8YHigIsD6GPBq9Mdz7odWubGY897TLMRbm7Mw9s6fscpKA+qeYDSSZZhy9YwQ/Hy7pS3xdI7iRte+2fLDedEvrTo2xrlSCKK7Jh82zCLekXmkG+cQnBnN78h44S2NKMiEkGdg1/bKW8m6Kyk67ZXPmGLzZbUNLDuxbjjfUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707223829; c=relaxed/simple;
	bh=1xMjT4kp1Cy5IwCd+vRVaQLedfB7kCRIOK0zpY9+/do=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XMq1AfB8zGFOvR+Zsag8sjJwmK63wMiuDLmnHqZnlF9M/MDU5bAfR2xUQQOEiEtvVa6mznPygnM+MmcMKXckIha39LaNn174NLGcfGR9GkxnmOb685b79pV3SnUrXPQXAuUHP+1hNv8xTGxNYpDMNA6XdrdlYR+Zr4K9E7K0g1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mlcXXzm/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EAD3CC433C7;
	Tue,  6 Feb 2024 12:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707223829;
	bh=1xMjT4kp1Cy5IwCd+vRVaQLedfB7kCRIOK0zpY9+/do=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mlcXXzm/tALWSHPZ6PrkO9R3UHkU6Ne+wbtEAHOHTFH+BoyGeIG/a/EETtsEE4MNX
	 Yh8sGUZ0DPa11jwjdpzl6cpc04uVQA0NJUORvqsep59TEtvn5wXxj2/AHyyG8CA9pT
	 /gnS/LQj3YPAorzxhsbgPESosdoFdt6tOLb5evoI6XcDu2z7sbW9pJmnNEg5ZEdLmw
	 xS3AwTM8tQ8/XVQY+Hea4WeB42RL4moCz3O7T0sar88Fm4P/TQk6ZVpfNWbJlSU0A4
	 GfNC2zOEjW26SQNIy7n25mMTsw0QHXXyL65RFw7vv8Cb32nnfKR2+L4P4UUDr1/LcD
	 44MbsgMAx9Irg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CCDEAE2F31F;
	Tue,  6 Feb 2024 12:50:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tipc: rename the module name diag to tipc_diag
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170722382883.26756.15928242828849225010.git-patchwork-notify@kernel.org>
Date: Tue, 06 Feb 2024 12:50:28 +0000
References: <d909edeef072da1810bd5869fdbbfe84411efdb2.1706904669.git.lucien.xin@gmail.com>
In-Reply-To: <d909edeef072da1810bd5869fdbbfe84411efdb2.1706904669.git.lucien.xin@gmail.com>
To: Xin Long <lucien.xin@gmail.com>
Cc: netdev@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
 davem@davemloft.net, kuba@kernel.org, edumazet@google.com, pabeni@redhat.com,
 jmaloy@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri,  2 Feb 2024 15:11:09 -0500 you wrote:
> It is not appropriate for TIPC to use "diag" as its diag module name
> while the other protocols are using "$(protoname)_diag" like tcp_diag,
> udp_diag and sctp_diag etc.
> 
> So this patch is to rename diag.ko to tipc_diag.ko in tipc's Makefile.
> 
> Signed-off-by: Xin Long <lucien.xin@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net-next] tipc: rename the module name diag to tipc_diag
    https://git.kernel.org/netdev/net-next/c/06e6bc1b7aaf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



