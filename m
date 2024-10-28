Return-Path: <netdev+bounces-139708-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B312A9B3E2B
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 00:00:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 753BB282ECE
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 23:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A501CCEE6;
	Mon, 28 Oct 2024 23:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ViC3EG1l"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D58188CDC;
	Mon, 28 Oct 2024 23:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730156425; cv=none; b=sbDytxEJ/Yfrl+xQ484gUmJNYqjGPHySBlhvLM4xXepZSmQUbTvpF3Zj+rtqfWWr6Te1ZaR1xyVgXJtsBEwgOPqbLu/dL7H3F4KvtmQ2+kpfIc1h/oU4Ok/CtKtyFhWl6E0bsFM4Fc88jkYxwVRIVYdI5kwFjs/ybocEFFVpo9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730156425; c=relaxed/simple;
	bh=CDr4ELMyn9OTolcpMiUCK+CxqHERk5vYWT0PXeKjM9o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FN6oIVedhzAFnlQCU9+SE80CHdvpEjPutYcfqp1Y38tvqwhZ6Y33HbfQ50RqlyqSBnyD0aXVP/x5zeErtED+ZjoOhk3YleG/qTBBp/gnsTr0LoeNCApnxmN8CmM1OT9VFnXeoTy7knlfHP2RQTEjAUGRnjOs+Ga5izs/ij1CAnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ViC3EG1l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D98DC4CEC3;
	Mon, 28 Oct 2024 23:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730156424;
	bh=CDr4ELMyn9OTolcpMiUCK+CxqHERk5vYWT0PXeKjM9o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ViC3EG1lFiNLhF9YSxd3PqfOSLsA88kO/4/JXIwiZJ82OKIEHLwtd+dsNBmKi5hhN
	 QCN67HPsGtbezNTQYFkmJhi9bXhhHwCLrFwSp/9FeVEvFP46Ykp5YPprbcDfMkMXtq
	 yr2irfN85uik0guZbjSfjZRPBNtR+zAmzJvZZ8FMlAHF3N38Ac0rQVRbgu+PHx+Leq
	 641+d3woXg1gikQdM44yGnl6OPD+vUV+2kG+aCirQLytUzUdsLrJ3iaom1hNPS0jb7
	 VHOEpfCSsp/CcOlyNrJKOUNxv3GV2gQyvdkSb5c03+0CeIy9bs4ZqpRlqLbB9nMLx0
	 h3u9pXnsj319w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33FDE380AC1C;
	Mon, 28 Oct 2024 23:00:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] docs: networking: packet_mmap: replace dead links with
 archive.org links
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173015643203.206744.9313387806866726484.git-patchwork-notify@kernel.org>
Date: Mon, 28 Oct 2024 23:00:32 +0000
References: <20241021-packet_mmap_fix_link-v1-1-dffae4a174c0@outlook.com>
In-Reply-To: <20241021-packet_mmap_fix_link-v1-1-dffae4a174c0@outlook.com>
To: Levi Zim via B4 Relay <devnull+rsworktech.outlook.com@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, corbet@lwn.net, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 rsworktech@outlook.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 21 Oct 2024 21:55:49 +0800 you wrote:
> From: Levi Zim <rsworktech@outlook.com>
> 
> The original link returns 404 now. This commit replaces the dead google
> site link with archive.org link.
> 
> Signed-off-by: Levi Zim <rsworktech@outlook.com>
> 
> [...]

Here is the summary with links:
  - [net] docs: networking: packet_mmap: replace dead links with archive.org links
    https://git.kernel.org/netdev/net/c/b935252cc298

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



