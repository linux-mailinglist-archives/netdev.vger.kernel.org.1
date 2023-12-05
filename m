Return-Path: <netdev+bounces-53738-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16EB48044E5
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 03:30:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7C501F21300
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 02:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 861CE63D9;
	Tue,  5 Dec 2023 02:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f4XhSOb0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF679460
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 02:30:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E39A4C433C7;
	Tue,  5 Dec 2023 02:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701743430;
	bh=Jp97KJ1Jgx0PDYUA5F4MSdkh5dAxQyd3fABaxZoj0QM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=f4XhSOb0ofyCwKKBaWePVqHo876E3XnF+MjiVqS37vHTe9lA2aim/A/5C1MvtV9y4
	 ckrbFcwVxDVvkXyFZyW1pPn5cWbWhPU5BLv4SaNsgTnxDYvyEKzoGymKeoX73sYXgm
	 39nW3nZYpch73ekY6GW0n8Xbq+ncQuW//eOIlK5lvWgpuJ71OtCeEDnK7kQl1rLO9/
	 qq6iqK4KtzIVYpVj5QSazJ/uCoFZ2UKZau1LCXrhOvu9y1CqaHKgzm3RZtUG50xdQ0
	 rnNjH+aNlTYZiCQjQ5hygI+l+D0jvSDoi0io77Zj9oVuyVUR02KG/fOYfnH1pQUJOW
	 pLx9qpd+ZbocA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C3B10DD4EF1;
	Tue,  5 Dec 2023 02:30:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next PATCH v11 00/11] Introduce queue and NAPI support in
 netdev-genl (Was: Introduce NAPI queues support)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170174342979.25370.14017245654233786781.git-patchwork-notify@kernel.org>
Date: Tue, 05 Dec 2023 02:30:29 +0000
References: <170147307026.5260.9300080745237900261.stgit@anambiarhost.jf.intel.com>
In-Reply-To: <170147307026.5260.9300080745237900261.stgit@anambiarhost.jf.intel.com>
To: Amritha Nambiar <amritha.nambiar@intel.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, ast@kernel.org, sdf@google.com, lorenzo@kernel.org,
 tariqt@nvidia.com, daniel@iogearbox.net, anthony.l.nguyen@intel.com,
 lucien.xin@gmail.com, michael.chan@broadcom.com, hawk@kernel.org,
 sridhar.samudrala@intel.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 01 Dec 2023 15:28:24 -0800 you wrote:
> Add the capability to export the following via netdev-genl interface:
> - queue information supported by the device
> - NAPI information supported by the device
> 
> Introduce support for associating queue and NAPI instance.
> Extend the netdev_genl generic netlink family for netdev
> with queue and NAPI data.
> 
> [...]

Here is the summary with links:
  - [net-next,v11,01/11] netdev-genl: spec: Extend netdev netlink spec in YAML for queue
    https://git.kernel.org/netdev/net-next/c/bc877956272f
  - [net-next,v11,02/11] net: Add queue and napi association
    https://git.kernel.org/netdev/net-next/c/2a502ff0c4e4
  - [net-next,v11,03/11] ice: Add support in the driver for associating queue with napi
    https://git.kernel.org/netdev/net-next/c/91fdbce7e8d6
  - [net-next,v11,04/11] netdev-genl: Add netlink framework functions for queue
    https://git.kernel.org/netdev/net-next/c/6b6171db7fc8
  - [net-next,v11,05/11] netdev-genl: spec: Extend netdev netlink spec in YAML for NAPI
    https://git.kernel.org/netdev/net-next/c/ff9991499fb5
  - [net-next,v11,06/11] netdev-genl: Add netlink framework functions for napi
    https://git.kernel.org/netdev/net-next/c/27f91aaf49b3
  - [net-next,v11,07/11] netdev-genl: spec: Add irq in netdev netlink YAML spec
    https://git.kernel.org/netdev/net-next/c/5a5131d66fe0
  - [net-next,v11,08/11] net: Add NAPI IRQ support
    https://git.kernel.org/netdev/net-next/c/26793bfb5d60
  - [net-next,v11,09/11] netdev-genl: spec: Add PID in netdev netlink YAML spec
    https://git.kernel.org/netdev/net-next/c/8481a249a0ea
  - [net-next,v11,10/11] netdev-genl: Add PID for the NAPI thread
    https://git.kernel.org/netdev/net-next/c/db4704f4e4df
  - [net-next,v11,11/11] eth: bnxt: link NAPI instances to queues and IRQs
    https://git.kernel.org/netdev/net-next/c/e3b57ffdb325

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



