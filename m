Return-Path: <netdev+bounces-22229-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 754957669E9
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 12:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F8C3281F50
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 10:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F0A5111B7;
	Fri, 28 Jul 2023 10:10:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2C711C83
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 10:10:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 578F5C433CB;
	Fri, 28 Jul 2023 10:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690539024;
	bh=CbBBv8mRdzcVCoGI44WGWAj9/t1+5aT4S6dEaE/k4OA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=atzw1lPXdRHUe1pzwZlusILa35h7ojpu8LCGrBt8ZQ5hrL5QheoLjZ/cQB7XysBqh
	 tayU1WjahRyg9DAJ6lcGRjsIcD7mfg7Z083hn+TjDpLTMJeFo8M1QCo5zY1t9+3SbL
	 fDCEMH/ovOu0Jj3v30ROX7Fu+V3eR64lK+42GMx+Iuy4nAH1Bn4yuh4kNeqmz5boep
	 ghj5rFUuSF+dpWb3eaPtuMWJFj8QsI+RWxFLjSLztiLYlkhNdHmvq2pavw3h4A8JrZ
	 TOeZhYY1zS35K084GW5e/hUKpltxVvd5g2B+6al/1kCTKs88Ea4HTDbcbTWhb2w6/i
	 QuPmwpqawGTzQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3CB9DE21EC9;
	Fri, 28 Jul 2023 10:10:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 00/10][pull request] ice: Implement support for
 SRIOV + LAG
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169053902424.13986.4347608263724820.git-patchwork-notify@kernel.org>
Date: Fri, 28 Jul 2023 10:10:24 +0000
References: <20230727195800.204461-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20230727195800.204461-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, david.m.ertman@intel.com,
 daniel.machon@microchip.com, simon.horman@corigine.com

Hello:

This series was applied to netdev/net-next.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Thu, 27 Jul 2023 12:57:50 -0700 you wrote:
> Dave Ertman says:
> 
> Implement support for SRIOV VF's on interfaces that are in an
> aggregate interface.
> 
> The first interface added into the aggregate will be flagged as
> the primary interface, and this primary interface will be
> responsible for managing the VF's resources.  VF's created on the
> primary are the only VFs that will be supported on the aggregate.
> Only Active-Backup mode will be supported and only aggregates whose
> primary interface is in switchdev mode will be supported.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,01/10] ice: Correctly initialize queue context values
    https://git.kernel.org/netdev/net-next/c/f3fbda3396f3
  - [net-next,v2,02/10] ice: Add driver support for firmware changes for LAG
    https://git.kernel.org/netdev/net-next/c/bb52f42acef6
  - [net-next,v2,03/10] ice: changes to the interface with the HW and FW for SRIOV_VF+LAG
    https://git.kernel.org/netdev/net-next/c/23ccae5ce15f
  - [net-next,v2,04/10] ice: implement lag netdev event handler
    https://git.kernel.org/netdev/net-next/c/41ccedf5ca8f
  - [net-next,v2,05/10] ice: process events created by lag netdev event handler
    https://git.kernel.org/netdev/net-next/c/ec5a6c5f79ed
  - [net-next,v2,06/10] ice: Flesh out implementation of support for SRIOV on bonded interface
    https://git.kernel.org/netdev/net-next/c/1e0f9881ef79
  - [net-next,v2,07/10] ice: support non-standard teardown of bond interface
    https://git.kernel.org/netdev/net-next/c/ba789fb45697
  - [net-next,v2,08/10] ice: enforce interface eligibility and add messaging for SRIOV LAG
    https://git.kernel.org/netdev/net-next/c/bf65da2eb279
  - [net-next,v2,09/10] ice: enforce no DCB config changing when in bond
    https://git.kernel.org/netdev/net-next/c/ab2ed5d77ab9
  - [net-next,v2,10/10] ice: update reset path for SRIOV LAG support
    https://git.kernel.org/netdev/net-next/c/3579aa86fb40

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



