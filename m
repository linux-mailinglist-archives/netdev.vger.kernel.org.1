Return-Path: <netdev+bounces-72012-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9642D8562B4
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 13:10:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51E75288AD6
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 12:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E33A212AAE4;
	Thu, 15 Feb 2024 12:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="avY/bRPX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF4312AAD0
	for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 12:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707999026; cv=none; b=XDf5+jkBIHjXpU3URQPUtpbjaAfXGCKVxGcQMxSVRhSydtTHgeQDhgvYjnOpn/e8jdNNgSHUAnCktbk2xQLNzAN+/IT3LJrY3ihAaftRvVNTxvKpRaGFWOjbdfRk8GxkQpz0paxvKp6gORLMdK9cXzjVC1+sneSJ+vsXpvR9IUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707999026; c=relaxed/simple;
	bh=Y0Uw5jdcLJdmzE7WCW5wOUflxjVeMcJAj/hKEv8WWCg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AQjBFAEQbVhYTa8MgPp5uhY9m5N7Asv7W2wYAx76zjKRF7BS+ceVM16e4TObN5YMyKHbKcYmvyzgTOAjdZt0C+k5jyeQrwqphgjuD5JuS9oa1NHO2w7rKc+81eukabEAg81ugedEi+x+bqJAnF+JidI7NXVNGaKw43v2cUV92HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=avY/bRPX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8F8B5C43390;
	Thu, 15 Feb 2024 12:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707999026;
	bh=Y0Uw5jdcLJdmzE7WCW5wOUflxjVeMcJAj/hKEv8WWCg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=avY/bRPX3mftjFwDNBsZAgGJQC+02Zes8jKY0Phly/1JPCgfFWrN6LTp0s3YH5L+v
	 GY0swygbV4PhCHJtXkJdLU+7o++S0z20k1Etc+Gyy7rvua0iSg2JwKuNzdaFAb+hJ/
	 XDsiluGzPL2MyXEGXkZq+UNRh9RJeA86C1P4/DrsjjhEISruWJrzpU/AdT5GYpW6Tz
	 MKSHZRaLAa/NDe7q7rLWAqBBPh3B47xC34Eg3tfmYl3a9rtzd+ABCkuajBaHFId+zP
	 h1kTtPcY1xYt+qL/jc+hQuRdEpnfXU/2yLkZyMhMLUoXWfQEhrZEPjfVN28hYI10xf
	 mBqe+VSeIRn5Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7313FD8C97D;
	Thu, 15 Feb 2024 12:10:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tcp: no need to use acceptable for conn_request
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170799902646.32063.8090026485678885122.git-patchwork-notify@kernel.org>
Date: Thu, 15 Feb 2024 12:10:26 +0000
References: <20240213131205.4309-1-kerneljasonxing@gmail.com>
In-Reply-To: <20240213131205.4309-1-kerneljasonxing@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, kuniyu@amazon.com,
 netdev@vger.kernel.org, kernelxing@tencent.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 13 Feb 2024 21:12:05 +0800 you wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> Since tcp_conn_request() always returns zero, there is no need to
> keep the dead code. Remove it then.
> 
> Link: https://lore.kernel.org/netdev/CANn89iJwx9b2dUGUKFSV3PF=kN5o+kxz3A_fHZZsOS4AnXhBNw@mail.gmail.com/
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> 
> [...]

Here is the summary with links:
  - [net-next] tcp: no need to use acceptable for conn_request
    https://git.kernel.org/netdev/net-next/c/d25f32722f50

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



