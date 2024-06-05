Return-Path: <netdev+bounces-101004-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2D188FCF3B
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 15:29:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DCDA1C219FC
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 13:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D053F1C53B5;
	Wed,  5 Jun 2024 12:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ch6eyEcl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6191ABE4D
	for <netdev@vger.kernel.org>; Wed,  5 Jun 2024 12:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717591831; cv=none; b=DMxF1OLi7DEsvx0ZgUSoqlBDzldk63CRsnOGZPzeeL6PbazSJaj36i8aMEX8YGX7zTLPtnQXwtgKTBWpM6fygsBtcHGCa5AMBxnTWjhpGeP/E6Lv9EoqgErY6a2abQmKhfSqOE3r9ET6RlhcrWu2d19VTND+j/T1j9z7r3qsMvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717591831; c=relaxed/simple;
	bh=rmYcYT25omKn7BnqJ3pv1NLklBv0JMgcuVbzfIWeb9k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IkicGIDubG6AXGbJoNqzQfFIjJInTwyyUYXn6YpPBLVqktMauJx9LliHy//U8zk37d0vJnnqrGsvkKZAOZTuwOFZB4Ko9L+irR4ldBfT1JW3+B5Pl8VVZrlrKpo2fDTYei+tLA/hcxoup6sx6yvWtBHx9O71xEu7rByrmUxZc64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ch6eyEcl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 55124C4AF07;
	Wed,  5 Jun 2024 12:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717591830;
	bh=rmYcYT25omKn7BnqJ3pv1NLklBv0JMgcuVbzfIWeb9k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ch6eyEclQ94id+uAjDOIhDg4HFgR97VM5yAme9b9AYiJuescOhQDAbq100UYVreRU
	 S4+vESeSLdESW97gO6OyIDiYgEKmU3aSYT+2jvg15Bre2XZ9gXb8gNDA8Eo/2KMKRv
	 LMN5v+Xo3CcZjtcfz1hsfSGEGFIHoc+QOlzmri3ffqhgi1EJpV0bUO9rDnMog+vROa
	 uUnkWVuXIUC+iyrT0vqQQwib9LbB8ILepa1izWcD6qY3AgVmDjdIRUbyFYAeADygLS
	 uE7KRGkjFHEMO1U4j4zRc9sijtt7jyG85/IsbTFQTpa8Hs4CuAajRW9LKIjCzVziz8
	 f9qfIRUgs3V0w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 43B8AD3E997;
	Wed,  5 Jun 2024 12:50:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/2] tcp: add sysctl_tcp_rto_min_us
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171759183027.5135.15471485198923065097.git-patchwork-notify@kernel.org>
Date: Wed, 05 Jun 2024 12:50:30 +0000
References: <20240603213054.3883725-1-yyd@google.com>
In-Reply-To: <20240603213054.3883725-1-yyd@google.com>
To: Kevin Yang <yyd@google.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 netdev@vger.kernel.org, ncardwell@google.com, ycheng@google.com,
 kerneljasonxing@gmail.com, pabeni@redhat.com, tonylu@linux.alibaba.com,
 horms@kernel.org, David.Laight@aculab.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon,  3 Jun 2024 21:30:52 +0000 you wrote:
> Adding a sysctl knob to allow user to specify a default
> rto_min at socket init time.
> 
> After this patch series, the rto_min will has multiple sources:
> route option has the highest precedence, followed by the
> TCP_BPF_RTO_MIN socket option, followed by this new
> tcp_rto_min_us sysctl.
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/2] tcp: derive delack_max with tcp_rto_min helper
    https://git.kernel.org/netdev/net-next/c/512bd0f9f926
  - [net-next,v3,2/2] tcp: add sysctl_tcp_rto_min_us
    https://git.kernel.org/netdev/net-next/c/f086edef71be

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



