Return-Path: <netdev+bounces-237639-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 66917C4E45D
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 15:01:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 542734ECE7D
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 14:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C792F26B0B7;
	Tue, 11 Nov 2025 14:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZiO7Kd72"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9299B263F4E
	for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 14:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762869636; cv=none; b=kzjyPVYhcJfNyGX4FU62jwAqzFCuOz42On1WWRzYHqBqMPTHxonZ29NT7UYtJne4fmS2SwBEXB6Ba4PRxqgk11aH6jtDGGV8oc+xtOKws949+ZJGJ8S9+LowXxGAI+SHP65xh5bfomHNkGzTSpmho4VPqO7RFfZtDN1SYIdEraE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762869636; c=relaxed/simple;
	bh=1Qa1ZAA6zzzvEOkWPzOCtCBq2f9WrShm6f4rNgT8fIg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qw5kfkMHJp9a+70pi98Uv7cVNrU+QdJAl93cru7XpjKjLEjcunGMbrpf6hpxB/8rWYagF16ttBFaQmk+pWzcQ2H/G7HByAiuTtZwpx91lOCkQAeYQa+KNxls5s4FJEQaIO3+IAuLsw3WtkPGv8s4nVdtshRA197dl05ZFb61a9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZiO7Kd72; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66FEAC4CEFB;
	Tue, 11 Nov 2025 14:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762869636;
	bh=1Qa1ZAA6zzzvEOkWPzOCtCBq2f9WrShm6f4rNgT8fIg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZiO7Kd720NBpkq8S/jdvCmHIFrRrY7wDeTK/CIPRqsd8W2K/XgjcN/wLb6U1N3Orb
	 vp6pwjLrXx/7ePjWfaz6/3o2nuM8upB2HkW3QrQ2TqDVM/FugjjV3d5l/pJRB3lupZ
	 KyUcxNok4MFehU45+/uKQJclaZ6Q1DPBXNkCCfEP5eWVCTlL2Sz8aZhERaBglHTzWI
	 f27GzDaMnw968sLkdZYwM+ECeugeT96UNpKF9OAglJVklbilV4IbfgHIPeQMFzAIam
	 +DMZiUh4ldbP0VEj+PJqszG1iVYhASXaWq7lFunbE3dgHq8qlF5jld/NZ/sO12SG3f
	 fJdcuxABhbs7w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB692380CFFB;
	Tue, 11 Nov 2025 14:00:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net] af_unix: Initialise scc_index in unix_add_edge().
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176286960676.3450646.10810052695828320098.git-patchwork-notify@kernel.org>
Date: Tue, 11 Nov 2025 14:00:06 +0000
References: <20251109025233.3659187-1-kuniyu@google.com>
In-Reply-To: <20251109025233.3659187-1-kuniyu@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, kuni1840@gmail.com,
 netdev@vger.kernel.org, quanglex97@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sun,  9 Nov 2025 02:52:22 +0000 you wrote:
> Quang Le reported that the AF_UNIX GC could garbage-collect a
> receive queue of an alive in-flight socket, with a nice repro.
> 
> The repro consists of three stages.
> 
>   1)
>     1-a. Create a single cyclic reference with many sockets
>     1-b. close() all sockets
>     1-c. Trigger GC
> 
> [...]

Here is the summary with links:
  - [v1,net] af_unix: Initialise scc_index in unix_add_edge().
    https://git.kernel.org/netdev/net/c/60e6489f8e3b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



