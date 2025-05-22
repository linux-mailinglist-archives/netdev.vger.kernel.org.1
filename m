Return-Path: <netdev+bounces-192517-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6496AC0324
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 05:49:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22F2B4A8023
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 03:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71EF412D1F1;
	Thu, 22 May 2025 03:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LmfuPfVO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1BB7DA73
	for <netdev@vger.kernel.org>; Thu, 22 May 2025 03:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747885794; cv=none; b=KsXH9YPv9FiwkY+/ZblZ2yZxbkGzPJIDYOwh2pzZGIAAraVJkDevD91TSwjzbS6V0PmigJozOHxzk4PlRRKewg+NghYyVNDcWkp0y+h3wKa0T6XOkNTB5QvbbqlabIb8FFL1usKzdReySgC1cve/2v7nmjOjYFY8rDg8PWPsFC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747885794; c=relaxed/simple;
	bh=HxuJ28tE6QJyk7j8oiBRw6OKZiT/H0p7Gk0T6I4vml8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qtLCcvygRCbHc4uvVqG0IrqxTkRICwJFnitdF+9DB9CSm+9KGc9VyMx3HAkhzyp2tBCtdZ/CrlM7zJwoJO01ILnDOgXHT+t6H1zGFVlv4tZRWXndb8qLH8Oolzlm3ukwJ/Cx2G0uzF+4wD3HTeQLnX103diEAjtIGLaci7J/BJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LmfuPfVO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2574CC4CEE4;
	Thu, 22 May 2025 03:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747885794;
	bh=HxuJ28tE6QJyk7j8oiBRw6OKZiT/H0p7Gk0T6I4vml8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LmfuPfVO1ULM02LqGqXeKcbyWyP7MgEej6fQ+k1SsAjYgjIB3ymUcDPyvOyTHQET2
	 BW2o+eSVK1ZDfSX12vhLJ4TAuzCDD1n/T7vPaQcJs4USOaZX9XsNa+JdcD740M/b4o
	 /BLGFewkZ4lWg4g+zS7dw4DFKy8lMcjkDU+bRMGiA3z7uezmb0fBSdtT4ITcoM78uL
	 zgvfq1mdCd2YtknJ20xXKXOTyt3N2NF8GqfYK9urPhz8aGlwKqvWo/V6mfAUQiOhX2
	 O6DPkjQOc9YmZZvNH6NfTix3j8ksMbuBSuf/9xUUvcdRJH6ZM0B/yQ4zF5drK8By3T
	 6U6YQ20dVYyvg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAFC0380AA7C;
	Thu, 22 May 2025 03:50:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] idpf: fix idpf_vport_splitq_napi_poll()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174788582976.2369658.8338626025769202622.git-patchwork-notify@kernel.org>
Date: Thu, 22 May 2025 03:50:29 +0000
References: <20250520124030.1983936-1-edumazet@google.com>
In-Reply-To: <20250520124030.1983936-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, willemb@google.com, netdev@vger.kernel.org,
 eric.dumazet@gmail.com, peternewman@google.com, joshua.a.hay@intel.com,
 alan.brady@intel.com, madhu.chittim@intel.com, phani.r.burra@intel.com,
 pavan.kumar.linga@intel.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 20 May 2025 12:40:30 +0000 you wrote:
> idpf_vport_splitq_napi_poll() can incorrectly return @budget
> after napi_complete_done() has been called.
> 
> This violates NAPI rules, because after napi_complete_done(),
> current thread lost napi ownership.
> 
> Move the test against POLL_MODE before the napi_complete_done().
> 
> [...]

Here is the summary with links:
  - [net] idpf: fix idpf_vport_splitq_napi_poll()
    https://git.kernel.org/netdev/net/c/407e0efdf8ba

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



