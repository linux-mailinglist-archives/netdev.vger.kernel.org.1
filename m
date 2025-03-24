Return-Path: <netdev+bounces-177183-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D58AA6E34A
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 20:21:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CB6A172C33
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 19:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C42E1A0BED;
	Mon, 24 Mar 2025 19:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cwuNNqSo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57875194094
	for <netdev@vger.kernel.org>; Mon, 24 Mar 2025 19:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742844004; cv=none; b=SdrAWd3p5BKHZSHOp8YmX1KOh7UX376ctPGXzVwzoWb5Jqo03N58zs/a9BsYhSweXOHL2rrcWWrGcthInhqgQjAded2te2e/L/ccxC5SkgKzQWnUxPlAABWowOB6nMUo+OMoZKWdhSOo8ajciKf33IYH99rHkKuRzTKGzuVZCVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742844004; c=relaxed/simple;
	bh=8VH+rHxr5DYo26L3r4VtDiFflfFqr9FUZwWE4DliQFQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kYxvYm3EDla51PnFJptBH5WMPMcszAI2goEO8LPxLDUAwnG/V3xGfLful0bOtTNSLcD6M3HZAVYbIxTSeulUdonJqANk3tCZRW+o6Aec/GoFIlMnSh8Ljji5pE9WQgMUpNc7F++Lc6w8dn6q8bPapjCx/nhoXA+QgUl4IERbTRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cwuNNqSo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B369DC4CEEE;
	Mon, 24 Mar 2025 19:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742844003;
	bh=8VH+rHxr5DYo26L3r4VtDiFflfFqr9FUZwWE4DliQFQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cwuNNqSo84o8qwUrZvAY3jzVW5k6afx2b5KbnoKH3gwZ7X4go9l3ybLgrjxZnvdc5
	 mGLj8+4QvtYK+oAlQ8XBKP3pIb0CsDRoOA588S4HdqcGqQbo/QxCQrnqCD2PAAwLbA
	 Tzls9kPxP6GZsGQJqiuaMi+1RVZd9oy0HyrSnaf07ucdZ8n6RpkRNBMLVAE1hcS+Kl
	 ClgUIOFRN+G6fufnJXRNTXdw8kClol7SuEfEylKH9GU3HsNePsTeCKpkFqIZYDVQE5
	 aqYY3n76QNVVy/Ca1chgRm+iff0DpKg3dvKQdSZTA6c5VC2JDsttsgVH1dcxOBxeUC
	 QxPgL0g2R3enQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34361380664D;
	Mon, 24 Mar 2025 19:20:41 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net-next] tcp/dccp: Remove
 inet_connection_sock_af_ops.addr2sockaddr().
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174284403975.4140851.9941721777645997249.git-patchwork-notify@kernel.org>
Date: Mon, 24 Mar 2025 19:20:39 +0000
References: <20250318060112.3729-1-kuniyu@amazon.com>
In-Reply-To: <20250318060112.3729-1-kuniyu@amazon.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, ncardwell@google.com, dsahern@kernel.org,
 horms@kernel.org, kuni1840@gmail.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 17 Mar 2025 23:01:07 -0700 you wrote:
> inet_connection_sock_af_ops.addr2sockaddr() hasn't been used at all
> in the git era.
> 
>   $ git grep addr2sockaddr $(git rev-list HEAD | tail -n 1)
> 
> Let's remove it.
> 
> [...]

Here is the summary with links:
  - [v1,net-next] tcp/dccp: Remove inet_connection_sock_af_ops.addr2sockaddr().
    https://git.kernel.org/netdev/net-next/c/66034f78a558

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



