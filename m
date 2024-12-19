Return-Path: <netdev+bounces-153406-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E52449F7DB1
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 16:11:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 827C61896826
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 15:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33701225784;
	Thu, 19 Dec 2024 15:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s/A4zgU5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DBD2762EF
	for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 15:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734621017; cv=none; b=q21apkp1GDhuLEcbTjsMAq3VpCmtzuX0xdPJYH+fo7hkKkrOFyw4968OPHqjj1d/mI0hLNhy1RDuIHemHc7y/Yzx0IA47DcH7Q3nU5fBJLNLKJ+fJpjhd6V+ZJ9pUTSS+pTKO44ymbBPTHWM/FdvnPONt5/zxGk8trMbZPfkDlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734621017; c=relaxed/simple;
	bh=2T5jy9Y1fd+3jfFWxUzXY47dTVzmm11W52de+bB1JxY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ri0dCKk+VgUARF8Cg3XoMSurBsh4NmImAYgCj+GHp8lk0j+R02YbTauiMCYKEH5hE7l7qyIKljpERTtX1Z+Mit7EClcE3m+h5iK1+zRpYG+pzhh8FAk/4FgCEabvICDJW34PHVTz2zMKpCFP7TOztqaFkiRn33I5kc44IfL73WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s/A4zgU5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89D8AC4CECE;
	Thu, 19 Dec 2024 15:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734621016;
	bh=2T5jy9Y1fd+3jfFWxUzXY47dTVzmm11W52de+bB1JxY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=s/A4zgU53L2BLT5oKP31L6eLGkD8ahhFiAnUZWH4Xc8RRvQq0QouRUS4sgctLeY9M
	 4Ux9M6aI9Y0+4FkhrQL0JY2jS9pr5fqud9TzGlzBykSgh171mfupZz52VXRaXF/hFU
	 DVLkCk2hUyMmBHNQOkzTF35SsDweyxBQNX52YYSucgyAdPRe7bB/578djmmNpdRSxV
	 6lz1rNg4iAlH2oWHa3+4Gq9KcuHscNGronK3xUXkVR8UkYEJN8idzzrIQojqfd5db+
	 aATk/vZbw7tlpASLzUFKSzf8rEqIuDaic4DnS718KIX7c8X6eGsoMtY44BIthlOXCr
	 AWcgF7yLp2KTg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5BE243806656;
	Thu, 19 Dec 2024 15:10:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/9] net: fib_rules: Add flow label selector support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173462103426.2277223.283188198172132637.git-patchwork-notify@kernel.org>
Date: Thu, 19 Dec 2024 15:10:34 +0000
References: <20241216171201.274644-1-idosch@nvidia.com>
In-Reply-To: <20241216171201.274644-1-idosch@nvidia.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org,
 donald.hunter@gmail.com, horms@kernel.org, gnault@redhat.com,
 rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 petrm@nvidia.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 16 Dec 2024 19:11:52 +0200 you wrote:
> In some deployments users would like to encode path information into
> certain bits of the IPv6 flow label, the UDP source port and the DSCP
> and use this information to route packets accordingly.
> 
> Redirecting traffic to a routing table based on the flow label is not
> currently possible with Linux as FIB rules cannot match on it despite
> the flow label being available in the IPv6 flow key.
> 
> [...]

Here is the summary with links:
  - [net-next,1/9] net: fib_rules: Add flow label selector attributes
    https://git.kernel.org/netdev/net-next/c/d1d761b3012e
  - [net-next,2/9] ipv4: fib_rules: Reject flow label attributes
    https://git.kernel.org/netdev/net-next/c/f0c898d8c279
  - [net-next,3/9] ipv6: fib_rules: Add flow label support
    https://git.kernel.org/netdev/net-next/c/9aa77531a131
  - [net-next,4/9] net: fib_rules: Enable flow label selector usage
    https://git.kernel.org/netdev/net-next/c/4c25f3f05194
  - [net-next,5/9] netlink: specs: Add FIB rule flow label attributes
    https://git.kernel.org/netdev/net-next/c/c72004aac60a
  - [net-next,6/9] ipv6: Add flow label to route get requests
    https://git.kernel.org/netdev/net-next/c/ba4138032ae3
  - [net-next,7/9] netlink: specs: Add route flow label attribute
    https://git.kernel.org/netdev/net-next/c/d26b8267d9e0
  - [net-next,8/9] tracing: ipv6: Add flow label to fib6_table_lookup tracepoint
    https://git.kernel.org/netdev/net-next/c/002bf68a3b3e
  - [net-next,9/9] selftests: fib_rule_tests: Add flow label selector match tests
    https://git.kernel.org/netdev/net-next/c/5760711e198d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



