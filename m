Return-Path: <netdev+bounces-41078-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC6587C991F
	for <lists+netdev@lfdr.de>; Sun, 15 Oct 2023 15:30:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3930BB20BC0
	for <lists+netdev@lfdr.de>; Sun, 15 Oct 2023 13:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01FA66FDA;
	Sun, 15 Oct 2023 13:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ttpHrBQf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFBF46FCE
	for <netdev@vger.kernel.org>; Sun, 15 Oct 2023 13:30:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3464BC433C9;
	Sun, 15 Oct 2023 13:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697376624;
	bh=fJxSvmydPin3eOhFUJi7ztaVhE2TM0vuz5ZflHFrdD0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ttpHrBQfojVW1Q/o0wTmDtxKuauKyrL8bNtZ63bZz/s4NrLCyvedq6a4/njJzXJQv
	 iOLJd4nFKVy9uWWDO6H2a1fRk4wStccHynxtxMXU7DgOi6vDrwyQUeYswOki1cXvcB
	 uzz/HmGEFpwLc+JecV9tGskdyeORApgXF0qt6vWMgAuOvuKXWAAZP/8k8Gfs5XavQR
	 /Mzc14NZaIfzJAgLDKMY4AVx5xkxmDu98/zK3roZbzBALOnPUKhLZ/mxkNTKRr2Wuw
	 IkYAowRQoj51StQXEX1tuywg9BM1Ri08QvJ20raGMmCvq58I7UCLdRh+2lL2Whv/Op
	 OANlIEuT34lbg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1A86AC691EF;
	Sun, 15 Oct 2023 13:30:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] sfc: support conntrack NAT offload
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169737662410.24568.17382832877055092106.git-patchwork-notify@kernel.org>
Date: Sun, 15 Oct 2023 13:30:24 +0000
References: <cover.1696974554.git.ecree.xilinx@gmail.com>
In-Reply-To: <cover.1696974554.git.ecree.xilinx@gmail.com>
To:  <edward.cree@amd.com>
Cc: linux-net-drivers@amd.com, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, ecree.xilinx@gmail.com,
 netdev@vger.kernel.org, habetsm.xilinx@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 10 Oct 2023 22:51:58 +0100 you wrote:
> From: Edward Cree <ecree.xilinx@gmail.com>
> 
> The EF100 MAE supports performing NAT (and NPT) on packets which match in
>  the conntrack table.  This series adds that capability to the driver.
> 
> Edward Cree (2):
>   sfc: parse mangle actions (NAT) in conntrack entries
>   sfc: support offloading ct(nat) action in RHS rules
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] sfc: parse mangle actions (NAT) in conntrack entries
    https://git.kernel.org/netdev/net-next/c/38f9a08a3e6a
  - [net-next,2/2] sfc: support offloading ct(nat) action in RHS rules
    https://git.kernel.org/netdev/net-next/c/0c7fe3b3720e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



