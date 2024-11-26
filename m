Return-Path: <netdev+bounces-147393-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E7D39D95E9
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 12:00:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46611165365
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 11:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89E101CD214;
	Tue, 26 Nov 2024 11:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rD5CBA2q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EFFD176AC8;
	Tue, 26 Nov 2024 11:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732618818; cv=none; b=n7i8VlpQhkUNedRLatl+MH2BnIwySBWmeOqL0A6RSR/I+D5ktlgABbRZYF+Cu4g9if4P/Pw/3lIIyQqeFR5zftHM72XjzlDOcwb2KmvDUBndc4jqIm+FO2+cr6GXXKYagMLvqJjxeX8t9y756LRBcMYblkCTmv7Jq3fGQGX3g4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732618818; c=relaxed/simple;
	bh=V92YUkvAXia8psdFR+lnadoZZqWAXtUQq34kIuGjsSE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=A2HmxE/adLo8mzFzd4bfhxug+xyjMbqVtntXjdVbH0qkf56ob2YvkVMstHKWFqeFduensry2S0p4eH886GHsSdDZDiOvYzMwniuyYN5RSpYaZ1T1WK/L3QxVakDHcxpIsFmurv57Fa6xKRuwpILTcnfmC7Hw4VRlIOu5oJc6fHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rD5CBA2q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF7ABC4CECF;
	Tue, 26 Nov 2024 11:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732618817;
	bh=V92YUkvAXia8psdFR+lnadoZZqWAXtUQq34kIuGjsSE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rD5CBA2qITkDG0BSN8IOlzbNPRfhSjpCqmfN+gWmfHVIby4hQ+JLer4jPyNvQdalH
	 c4OfZggDCS7Llax9cwXYBA0vFZHJI4qmMb9bKYQIFxl5usubfGBiDxBMfhItmRaKqw
	 tPQqbb7OzvL0bXj66B9P2nxV92UcNpAuc53V+kZZhevEFxOmokJn6kMe4TasI7P4s4
	 xSPt7ltgTcKDKsvhRdt7/NJ3zUXqRYpp3nMN0FW9Ghi8+/S42sq7eW9m8dG7n3odAQ
	 ss+3Cq697yR9eG58iGnq5MUeMPdMmQNbCTAs8W3Eqhi8fqo2hNoSYhnNSrhg2c2+vc
	 AFaM2XWvpSxLQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EBA9D3809A00;
	Tue, 26 Nov 2024 11:00:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] marvell: pxa168_eth: fix call balance of pep->clk
 handling routines
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173261882976.349934.230932216858559305.git-patchwork-notify@kernel.org>
Date: Tue, 26 Nov 2024 11:00:29 +0000
References: <20241121200658.2203871-1-mordan@ispras.ru>
In-Reply-To: <20241121200658.2203871-1-mordan@ispras.ru>
To: Vitalii Mordan <mordan@ispras.ru>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, jacob.e.keller@intel.com,
 shannon.nelson@amd.com, sd@queasysnail.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, pchelkin@ispras.ru, khoroshilov@ispras.ru,
 mutilin@ispras.ru

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 21 Nov 2024 23:06:58 +0300 you wrote:
> If the clock pep->clk was not enabled in pxa168_eth_probe,
> it should not be disabled in any path.
> 
> Conversely, if it was enabled in pxa168_eth_probe, it must be disabled
> in all error paths to ensure proper cleanup.
> 
> Use the devm_clk_get_enabled helper function to ensure proper call balance
> for pep->clk.
> 
> [...]

Here is the summary with links:
  - [net] marvell: pxa168_eth: fix call balance of pep->clk handling routines
    https://git.kernel.org/netdev/net/c/b032ae57d4fe

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



