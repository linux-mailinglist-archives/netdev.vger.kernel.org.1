Return-Path: <netdev+bounces-47897-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6092B7EBC98
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 05:20:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10B79281469
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 04:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 797CDA5C;
	Wed, 15 Nov 2023 04:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XLDTTJYH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D87E4427
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 04:20:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CE216C433CA;
	Wed, 15 Nov 2023 04:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700022026;
	bh=+FtHROYsXTi5aU1BSHyrPv3+mX1lPvfvdCQsHET1Oa0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XLDTTJYH7Dq8hsZPnOHKhYgChJWppPEweZ9N+28+DGX5sMYPt+KRKrZIdr7qDZ9AC
	 F5UTTB3PcFQs5OFL4dYj7ktvv+vRO9maZLHeulldwOCgJqdTnjX2z1+NN7c/wbjSma
	 lJ2LXJfW4tP9S0TYxrWr4PdxzdhCG/4zj1SPv9nmBBucKC0DYK3glxaoBXbVZgjqce
	 XqoydOk1v3JLIgtIoNVtRJprarMIpaGrubJgsO0Su54ks8u7m9IUpVZ5qnasDHZsS/
	 gaADXnOHVLcjEWBxBbSza+k/2eVXXkpnwtz7vcSF3/1ipwQMQHTppYD41SAQLQhouT
	 58wHkdXELcHmQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B9AB3EA7DA2;
	Wed, 15 Nov 2023 04:20:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 00/15][pull request] Intel Wired LAN Driver Updates
 2023-11-13 (i40e)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170002202675.25123.8010747130253460504.git-patchwork-notify@kernel.org>
Date: Wed, 15 Nov 2023 04:20:26 +0000
References: <20231113231047.548659-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20231113231047.548659-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 13 Nov 2023 15:10:19 -0800 you wrote:
> This series contains updates to i40e driver only.
> 
> Justin Bronder increases number of allowable descriptors for XL710
> devices.
> 
> Su Hui adds error check, and unroll, for RSS configuration.
> 
> [...]

Here is the summary with links:
  - [net-next,01/15] i40e: increase max descriptors for XL710
    https://git.kernel.org/netdev/net-next/c/aa6908ca3bd1
  - [net-next,02/15] i40e: add an error code check in i40e_vsi_setup
    https://git.kernel.org/netdev/net-next/c/add35e623e77
  - [net-next,03/15] i40e: Change user notification of non-SFP module in i40e_get_module_info()
    https://git.kernel.org/netdev/net-next/c/2c0fa38a579f
  - [net-next,04/15] i40e: Remove unused flags
    https://git.kernel.org/netdev/net-next/c/e8fcf58f6109
  - [net-next,05/15] i40e: Remove _t suffix from enum type names
    https://git.kernel.org/netdev/net-next/c/addca9175e5f
  - [net-next,06/15] i40e: Use DECLARE_BITMAP for flags and hw_features fields in i40e_pf
    https://git.kernel.org/netdev/net-next/c/70756d0a4727
  - [net-next,07/15] i40e: Use DECLARE_BITMAP for flags field in i40e_hw
    https://git.kernel.org/netdev/net-next/c/d0b1314c8b33
  - [net-next,08/15] i40e: Consolidate hardware capabilities
    https://git.kernel.org/netdev/net-next/c/0e8b9fdd40fe
  - [net-next,09/15] i40e: Initialize hardware capabilities at single place
    https://git.kernel.org/netdev/net-next/c/8cc29564d227
  - [net-next,10/15] i40e: Move i40e_is_aq_api_ver_ge helper
    https://git.kernel.org/netdev/net-next/c/28c1726b2c9c
  - [net-next,11/15] i40e: Add other helpers to check version of running firmware and AQ API
    https://git.kernel.org/netdev/net-next/c/cf488e13221f
  - [net-next,12/15] i40e: Use helpers to check running FW and AQ API versions
    https://git.kernel.org/netdev/net-next/c/e329a8b9aac4
  - [net-next,13/15] i40e: Remove VF MAC types
    https://git.kernel.org/netdev/net-next/c/d8c6bee01caa
  - [net-next,14/15] i40e: Move inline helpers to i40e_prototype.h
    https://git.kernel.org/netdev/net-next/c/f699a4bfc862
  - [net-next,15/15] i40e: Delete unused i40e_mac_info fields
    https://git.kernel.org/netdev/net-next/c/3f06462b3eb8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



