Return-Path: <netdev+bounces-49829-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA2567F39F9
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 00:00:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A63DE1C209F6
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 23:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FADA54BEC;
	Tue, 21 Nov 2023 23:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NRsqT/vR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23EB654BC3
	for <netdev@vger.kernel.org>; Tue, 21 Nov 2023 23:00:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9F07CC433C9;
	Tue, 21 Nov 2023 23:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700607626;
	bh=yL1v3msiAwzE9ADbsyTjtjQVBsaT20unlomJ+9sNcxk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NRsqT/vRVQme+23TL9gkkwSdwiOK5d702HxEtyCKZBoaOUTVsnAgCswxfBnzVNvM7
	 wbuo40VmteHOzpmqOL3AqReyeT03o1sqcf+lQElEXJZDgQFvaYWpCBrcJXOa99CW/h
	 za4B46iUtX0nEJdOZLxuYUySL21Xez2ynNQVBJqzedga6OIwUglSfgGUIR2zSzkR5Q
	 Hs3CnU/CGGPl8NuuChBHZQPqjSZK/PrvZGI8ZgXIPo9XsV8OrKYrGgrbtX2zUKdzyo
	 DW6eD+vTFjZOYjDOxlMZdHyChXST9Mz7dc5Ct9CcJcp4fL52KEShzK4lkUw5eGkK0F
	 /mlBimcbdAclg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 809A7EAA955;
	Tue, 21 Nov 2023 23:00:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 00/14] mlxsw: Preparations for support of CFF flood
 mode
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170060762652.18150.16560852194798105983.git-patchwork-notify@kernel.org>
Date: Tue, 21 Nov 2023 23:00:26 +0000
References: <cover.1700503643.git.petrm@nvidia.com>
In-Reply-To: <cover.1700503643.git.petrm@nvidia.com>
To: Petr Machata <petrm@nvidia.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, idosch@nvidia.com,
 amcohen@nvidia.com, mlxsw@nvidia.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 20 Nov 2023 19:25:17 +0100 you wrote:
> PGT is an in-HW table that maps addresses to sets of ports. Then when some
> HW process needs a set of ports as an argument, instead of embedding the
> actual set in the dynamic configuration, what gets configured is the
> address referencing the set. The HW then works with the appropriate PGT
> entry.
> 
> Among other allocations, the PGT currently contains two large blocks for
> bridge flooding: one for 802.1q and one for 802.1d. Within each of these
> blocks are three tables, for unknown-unicast, multicast and broadcast
> flooding:
> 
> [...]

Here is the summary with links:
  - [net-next,01/14] mlxsw: cmd: Add cmd_mbox.query_fw.cff_support
    https://git.kernel.org/netdev/net-next/c/8405d6626289
  - [net-next,02/14] mlxsw: cmd: Add MLXSW_CMD_MBOX_CONFIG_PROFILE_FLOOD_MODE_CFF
    https://git.kernel.org/netdev/net-next/c/50ee67789b82
  - [net-next,03/14] mlxsw: resources: Add max_cap_nve_flood_prf
    https://git.kernel.org/netdev/net-next/c/2d19da927719
  - [net-next,04/14] mlxsw: reg: Add Switch FID Flooding Profiles Register
    https://git.kernel.org/netdev/net-next/c/e1e4ce6c6d54
  - [net-next,05/14] mlxsw: reg: Mark SFGC & some SFMR fields as reserved in CFF mode
    https://git.kernel.org/netdev/net-next/c/7eb902954b62
  - [net-next,06/14] mlxsw: reg: Drop unnecessary writes from mlxsw_reg_sfmr_pack()
    https://git.kernel.org/netdev/net-next/c/642d6a2033d8
  - [net-next,07/14] mlxsw: reg: Extract flood-mode specific part of mlxsw_reg_sfmr_pack()
    https://git.kernel.org/netdev/net-next/c/446bc1e9dec6
  - [net-next,08/14] mlxsw: reg: Add to SFMR register the fields related to CFF flood mode
    https://git.kernel.org/netdev/net-next/c/6b10371c386c
  - [net-next,09/14] mlxsw: core, pci: Add plumbing related to CFF mode
    https://git.kernel.org/netdev/net-next/c/095915956867
  - [net-next,10/14] mlxsw: pci: Permit enabling CFF mode
    https://git.kernel.org/netdev/net-next/c/9aad19a363f6
  - [net-next,11/14] mlxsw: spectrum_fid: Drop unnecessary conditions
    https://git.kernel.org/netdev/net-next/c/b51c876c2297
  - [net-next,12/14] mlxsw: spectrum_fid: Extract SFMR packing into a helper
    https://git.kernel.org/netdev/net-next/c/2b7bccd1f167
  - [net-next,13/14] mlxsw: spectrum_router: Add a helper to get subport number from a RIF
    https://git.kernel.org/netdev/net-next/c/27851dfaa3d6
  - [net-next,14/14] mlxsw: spectrum_router: Call RIF setup before obtaining FID
    https://git.kernel.org/netdev/net-next/c/f7ebb4023765

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



