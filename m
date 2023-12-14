Return-Path: <netdev+bounces-57237-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D659A8127D9
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 07:20:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 145B31C21511
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 06:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77F09CA79;
	Thu, 14 Dec 2023 06:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uaLBXFBx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F22DD261;
	Thu, 14 Dec 2023 06:20:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DA8AFC433C9;
	Thu, 14 Dec 2023 06:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702534827;
	bh=gVzW956pE4WZPiafeYeaFLar70TRxqJHBI/nEbsghSk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uaLBXFBxTz4OYPv+IVw11RKr/ii1rs4cpxVdpItKOF0JGJtsBspzhnMX3ku7O9MXZ
	 xoezExqyTBP2b1AFiOmLlDr3kqt1PR9VK84jmyTeSNIPY53Q6uHkwq3Jmwp+SeGDzU
	 qWL4Hy9KWWXCOH9XrwV8XDZA1mxlrYwKTQVK+TGi5eJqERcwyxuVVhijRZwobSJ2fW
	 kZhWLxWc94R/WdDJAqXygSetBYKa2QzrsR3Ka34QbPeF4elE9ATrN02GrPGBM0MVVa
	 P6SsRVaJmzRauBaBC+t/bqtqPSKvmVLgqVhL+v+F8ksH+/ZtPn+P+AhWig6bMLV9JF
	 abWEG2kZgaNHw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C1115DD4EF9;
	Thu, 14 Dec 2023 06:20:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v9 0/8] Support symmetric-xor RSS hash
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170253482778.28524.4770397031071631009.git-patchwork-notify@kernel.org>
Date: Thu, 14 Dec 2023 06:20:27 +0000
References: <20231213003321.605376-1-ahmed.zaki@intel.com>
In-Reply-To: <20231213003321.605376-1-ahmed.zaki@intel.com>
To: Ahmed Zaki <ahmed.zaki@intel.com>
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org, corbet@lwn.net,
 jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 vladimir.oltean@nxp.com, andrew@lunn.ch, horms@kernel.org, mkubecek@suse.cz,
 willemdebruijn.kernel@gmail.com, gal@nvidia.com, alexander.duyck@gmail.com,
 ecree.xilinx@gmail.com, linux-doc@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 12 Dec 2023 17:33:13 -0700 you wrote:
> Patches 1 and 2 modify the get/set_rxh ethtool API to take a pointer to
> struct of parameters instead of individual params. This will allow future
> changes to the uAPI-shared struct ethtool_rxfh without changing the
> drivers' API.
> 
> Patch 3 adds the support at the Kernel level, allowing the user to set a
> symmetric-xor RSS hash for a netdevice via:
> 
> [...]

Here is the summary with links:
  - [net-next,v9,1/8] net: ethtool: pass a pointer to parameters to get/set_rxfh ethtool ops
    https://git.kernel.org/netdev/net-next/c/fb6e30a72539
  - [net-next,v9,2/8] net: ethtool: get rid of get/set_rxfh_context functions
    https://git.kernel.org/netdev/net-next/c/dcd8dbf9e734
  - [net-next,v9,3/8] net: ethtool: add support for symmetric-xor RSS hash
    https://git.kernel.org/netdev/net-next/c/13e59344fb9d
  - [net-next,v9,4/8] ice: fix ICE_AQ_VSI_Q_OPT_RSS_* register values
    https://git.kernel.org/netdev/net-next/c/20f73b60bb5c
  - [net-next,v9,5/8] ice: refactor RSS configuration
    https://git.kernel.org/netdev/net-next/c/dc6e44c9d6d6
  - [net-next,v9,6/8] ice: refactor the FD and RSS flow ID generation
    https://git.kernel.org/netdev/net-next/c/b1f5921a99ac
  - [net-next,v9,7/8] ice: enable symmetric-xor RSS for Toeplitz hash function
    https://git.kernel.org/netdev/net-next/c/352e9bf23813
  - [net-next,v9,8/8] iavf: enable symmetric-xor RSS for Toeplitz hash function
    https://git.kernel.org/netdev/net-next/c/4a3de3fb0eb6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



