Return-Path: <netdev+bounces-140378-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E019F9B641F
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 14:30:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A517D280F3F
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 13:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28CC2185B62;
	Wed, 30 Oct 2024 13:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u+IwOavd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046DC3FB31
	for <netdev@vger.kernel.org>; Wed, 30 Oct 2024 13:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730295024; cv=none; b=TufF2Hrm5xOLTXLxkoy0AJWq3I1A2xbWPltHD6P2kF5/XIUcvh/feWBRNuFSkv1z1suG4mbxR0ftuCGCuEDF179jK7rsztIBSJhu5LwrntfqLqoQtJwib+dw7U90gUPgMEO0PO8R3Wuz0E4k9LBsLvw5qkL2czrw7aT0xjYQ0Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730295024; c=relaxed/simple;
	bh=5FU+KA+6AjhTqJNIr7MKN30PtAt4ZzxdGSckL24QthA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Z47JzmeesVBzYRL5h6QaPxLI+mkHP9mSlJTpknpeSPN2M+GsuJLG7ES42ExTHTnH6ri7Ao3jJ6pVS3XaHWTgvpBI0+wiiaJD7DsI33VcA5CskAyy0aXrnuoR+e6eDN9jW5qB/x8yeEGWcLP71PJ8KR8bwnzM+b/Rpxu+CHETZog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u+IwOavd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86D97C4CEE3;
	Wed, 30 Oct 2024 13:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730295023;
	bh=5FU+KA+6AjhTqJNIr7MKN30PtAt4ZzxdGSckL24QthA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=u+IwOavdtKxzcBDLXNmNhKS10SMKqM0K7k5jNpZ0c8iJgRovZOOI8I7yraXIjfQQS
	 uqFZ7R0c62WvDxfVyag7knhXTp1cepRefYXydDcbYZFo0u9C40+ntg8MMMFyP0O4Rb
	 VjRcL0kIS4ldjnPqXjoEkyOE2c5CD10xG3aYieJJi88c13C+WK9Ar/wCpu/upOIuDy
	 1xlMvQhxsldkt6wvUTOkJySmtZamGqjaYK8cocKoMT7Ass3i6LBudMuSXhFXdFQgz4
	 EW8h4t5C8OXqLxAVF44Ej7SsXqTCD0VnHgSnUvD8cngJvC/oRSYinvljd93fs1VXsP
	 5zSWQCneJks3Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 717B1380AC22;
	Wed, 30 Oct 2024 13:30:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/2] tcp: add tcp_warn_once() common helper
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173029503127.1339926.3838953903282931840.git-patchwork-notify@kernel.org>
Date: Wed, 30 Oct 2024 13:30:31 +0000
References: <20241023081452.9151-1-kerneljasonxing@gmail.com>
In-Reply-To: <20241023081452.9151-1-kerneljasonxing@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, netdev@vger.kernel.org,
 kernelxing@tencent.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 23 Oct 2024 16:14:50 +0800 you wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> Paolo Abeni suggested we can introduce a new helper to cover more cases
> in the future for better debug.
> 
> Jason Xing (2):
>   tcp: add a common helper to debug the underlying issue
>   tcp: add more warn of socket in tcp_send_loss_probe()
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/2] tcp: add a common helper to debug the underlying issue
    https://git.kernel.org/netdev/net-next/c/386c2b877b97
  - [net-next,v3,2/2] tcp: add more warn of socket in tcp_send_loss_probe()
    https://git.kernel.org/netdev/net-next/c/668d663989c7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



