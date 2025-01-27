Return-Path: <netdev+bounces-161217-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F82FA200BF
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 23:40:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF8B93A7287
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 22:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5582C1DDA35;
	Mon, 27 Jan 2025 22:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kS0Bnk/v"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2832D1DDA20
	for <netdev@vger.kernel.org>; Mon, 27 Jan 2025 22:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738017612; cv=none; b=KYSFPBj4n4lUhLNLT9G6WxdD12X8UH1DwyC2N/iLc/NsMJBItF1c3RO78tQ0tE9ZMzbBEZ9t4ok/EJByob53ysEQI28X1jUj6v9g6SrYFOHw9UgYA63S0cM7YAny9nUE4Rx+alk7OhQ8DgQ+8TvFSc9F9tdrnvrjmgDpIooCwNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738017612; c=relaxed/simple;
	bh=3jHGRvHwDqjuRXNIabNP2xPZLH5kRUg46KhP/dXcIBs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GCIDTbsF1wNvG2ENz2P2dQFNILMA2+3pME/k+a9UvopTAclME892KcLMAbkPBKnQxnvE3RFupj24UGoRJAFIeH+IGbsBu+CxhiRqITot6uLOiCk9bYPmUYIsS4lOsWqonVbLwpK0AX/TeAIMRAro8ndNfqcjqxA3nnMz5OvQ0Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kS0Bnk/v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94E74C4CEE0;
	Mon, 27 Jan 2025 22:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738017611;
	bh=3jHGRvHwDqjuRXNIabNP2xPZLH5kRUg46KhP/dXcIBs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kS0Bnk/v1hIQDOrCAWnDzHbbMtM55YRyWPV8kPpqfPwV9yWJBf4W9sLnTVw34v18Y
	 XFjciCIvbojgw3N3V5UGwI/igMTkTDW2jawM/AsANKwXD+GADIfeqOS13bs6fPb9KF
	 XLUOqdAlGOw303wROgjSU8JM+TsiEB/y4KVFZkSh57pE9Jm6OJhXz+sGpLm+kbiPbV
	 F0wVYJpAKWP5S08YJYScFN9sXQx6b2LCFEhg1RZSdDMvTxJwItuO79yz1Lc3jNPHHq
	 ruwVgoPipvd01n6VdTtaNko0AWUZlHh6Cnwnr4o1voKIKCD+ofmb15RMN0HHlHn/jQ
	 KbUsAw916N/VA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 72397380AA63;
	Mon, 27 Jan 2025 22:40:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] tools: ynl: c: correct reverse decode of empty attrs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173801763699.3245248.7069448205474093297.git-patchwork-notify@kernel.org>
Date: Mon, 27 Jan 2025 22:40:36 +0000
References: <20250124012130.1121227-1-kuba@kernel.org>
In-Reply-To: <20250124012130.1121227-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 donald.hunter@gmail.com, nicolas.dichtel@6wind.com, willemb@google.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 23 Jan 2025 17:21:30 -0800 you wrote:
> netlink reports which attribute was incorrect by sending back
> an attribute offset. Offset points to the address of struct nlattr,
> but to interpret the type we also need the nesting path.
> Attribute IDs have different meaning in different nests
> of the same message.
> 
> Correct the condition for "is the offset within current attribute".
> ynl_attr_data_len() does not include the attribute header,
> so the end offset was off by 4 bytes.
> 
> [...]

Here is the summary with links:
  - [net] tools: ynl: c: correct reverse decode of empty attrs
    https://git.kernel.org/netdev/net/c/964417a5d4a0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



