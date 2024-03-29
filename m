Return-Path: <netdev+bounces-83267-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 927BE8917F6
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 12:40:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 169EDB20B3F
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 11:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AE566A325;
	Fri, 29 Mar 2024 11:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uyQxH1Ue"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56FD85A0FB
	for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 11:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711712431; cv=none; b=e6LrBdiUxDws4vm6CUzagKbPppaX+B59aCMSKwvGMowqoSSs43sfIaSCsNOKD/zpjSsMwf59ibUkV5abPbKnDjjfBGgrI7LAlZtZ6MJ9rD/+fkMUlF15eWnLpkxtXWzQgUwjf65+1I9JCQ8CY0FhsqhvfUL2jEg3DarjW9H3C9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711712431; c=relaxed/simple;
	bh=yIHVj5QFIu06ebTETsM94QzH/xYvHdLLaAYo3KFLfvY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cKQ/HLi5YBIr2tgfnqciLrlCp53nWkwwYYzSGrLKo/Ib+JmQi04UEa3KPo6o4YiyHK+nslCmZaJlGHkLSJqj19kaDAzn/HAph6aPtmzLinqKY2HXulxluGaKJIozmGGBZxgVhxcH+FJfzKqkGaPvb0Ac5LGX9dHz9B7N8bJRsHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uyQxH1Ue; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7B534C433C7;
	Fri, 29 Mar 2024 11:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711712430;
	bh=yIHVj5QFIu06ebTETsM94QzH/xYvHdLLaAYo3KFLfvY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uyQxH1UeQJQ881nQbkQSlXnhj607Jrq/dfjPHZitEaKP7Rx7C6CZr7vC8q+k5IhSv
	 k1krX6CG9lr+luIeZ1ezOwP3+g/fjxkxKdBMy0q7RBmHwqjTQ9I6tacgsmAnVHjako
	 N7S/vWU1jjWi4HjZEt0crvBB6bDci1hpZMcFmKswwypx+vsztYikLjUBDr+UaQoJj+
	 24duZzvFul58/BD4Qvxl8jvr4R/bqerha8unuHGttNlxQRMfsud7/40hqux0jpjcv9
	 ukZj0oYuxTdb/zka44yxyRqqM3ryC/zxjAqs4Zm2W0WPW7/v32BjtvhdjbRzc94/4T
	 s1bxG/yNf4VgA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6D1F1D2D0EE;
	Fri, 29 Mar 2024 11:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v4 0/5] gro: various fixes related to UDP tunnels
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171171243044.24069.3118700921840357850.git-patchwork-notify@kernel.org>
Date: Fri, 29 Mar 2024 11:40:30 +0000
References: <20240326113403.397786-1-atenart@kernel.org>
In-Reply-To: <20240326113403.397786-1-atenart@kernel.org>
To: Antoine Tenart <atenart@kernel.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, steffen.klassert@secunet.com,
 willemdebruijn.kernel@gmail.com, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 26 Mar 2024 12:33:57 +0100 you wrote:
> Hello,
> 
> We found issues when a UDP tunnel endpoint is in a different netns than
> where UDP GRO happens. This kind of setup is actually quite diverse,
> from having one leg of the tunnel on a remove host, to having a tunnel
> between netns (eg. being bridged in another one or on the host). In our
> case that UDP tunnel was geneve.
> 
> [...]

Here is the summary with links:
  - [net,v4,1/5] udp: do not accept non-tunnel GSO skbs landing in a tunnel
    https://git.kernel.org/netdev/net/c/3d010c8031e3
  - [net,v4,2/5] gro: fix ownership transfer
    https://git.kernel.org/netdev/net/c/ed4cccef64c1
  - [net,v4,3/5] udp: do not transition UDP GRO fraglist partial checksums to unnecessary
    https://git.kernel.org/netdev/net/c/f0b8c3034556
  - [net,v4,4/5] udp: prevent local UDP tunnel packets from being GROed
    https://git.kernel.org/netdev/net/c/64235eabc4b5
  - [net,v4,5/5] selftests: net: gro fwd: update vxlan GRO test expectations
    https://git.kernel.org/netdev/net/c/0fb101be97ca

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



