Return-Path: <netdev+bounces-224414-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56DFDB84626
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 13:40:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D97464815BD
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 11:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACE50304BD7;
	Thu, 18 Sep 2025 11:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m4abbSXn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE82303A05
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 11:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758195623; cv=none; b=q2o6p4rZ02cgz89ILY1WF4IckTgkwcnf2634Rd4COXLhGNn5fKFxofj4oZpSu5nkiOX2IHtTMxPmM0wvIbd6iNPNCmoqILZq26bB4Yg6YG7EbkbpYPRg6Wj/HYWJXEM8FSwP68uMj3CZRCKGjjC1gfmwR6sBBPu30Y+3PKf6NMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758195623; c=relaxed/simple;
	bh=4px8KpkcE/T8mVEgkCdY5hZO5CA6Ci5PI8ZfdyYXnsk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=t7Aut7wUDNBDk7WTKTnZJIhBxXZqY4IeQB9x2J7r7kSUuw1O+qd5YLiu4hho60H35foXDTlzXqXDUX325TWP63oB1W0eA8/l5Z2v3lp8a3ys36CdnKSz7DZTnvTDf8wboEDPopOnOJE+E73Tc4uqvJmDHJ452NRugMEkMqk3nm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m4abbSXn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18299C4CEE7;
	Thu, 18 Sep 2025 11:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758195623;
	bh=4px8KpkcE/T8mVEgkCdY5hZO5CA6Ci5PI8ZfdyYXnsk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=m4abbSXnmt3qMjAkJUVNSxNOclFwuQMdi+sNKxqPyN5sYxz6MmNiWoqlHST/jzKE7
	 M9ErSZ2UjJ5IdqUJ5ICaRxtO/WnYGMAuFU/P7Mc+csdCKpgPNKJVnGiM9mtBjSXXod
	 4iMT4vTS6y/7Dkw61VPixFhJubtzjq652Wpnunk8WYg1Ugy8rPFYpdUtMC8TVPZ/QH
	 Y/lluo0zsHsGTlQUPxKEQj80gofcuVfTMr7IOVW+kV0YyHogj6pixK5wLBGVst8g2E
	 xj8M/5GBmcPbJcgkHBbXLvJhnMYmmYipizwR13xKwfY6SQcLVYlqzf57/GH+Jjl2VT
	 CxaiR5vUIeuUA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7106439D0C28;
	Thu, 18 Sep 2025 11:40:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 00/10] bnxt_en: Updates for net-next
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175819562328.2380224.15389681717399142510.git-patchwork-notify@kernel.org>
Date: Thu, 18 Sep 2025 11:40:23 +0000
References: <20250917040839.1924698-1-michael.chan@broadcom.com>
In-Reply-To: <20250917040839.1924698-1-michael.chan@broadcom.com>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
 pavan.chebbi@broadcom.com, andrew.gospodarek@broadcom.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 16 Sep 2025 21:08:29 -0700 you wrote:
> This series includes some code clean-ups and optimizations.  New features
> include 2 new backing store memory types to collect FW logs for core
> dumps, dynamic SRIOV resource allocations for RoCE, and ethtool tunable
> for PFC watchdog.
> 
> v2: Drop patch #4.  The patch makes the code different from the original
> bnxt_hwrm_func_backing_store_cfg_v2() that allows instance_bmap to have
> bits that are not contiguous.  It is safer to keep the original code.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,01/10] bnxt_en: Drop redundant if block in bnxt_dl_flash_update()
    https://git.kernel.org/netdev/net-next/c/3b46a9e404ab
  - [net-next,v2,02/10] bnxt_en: Remove unnecessary VF check in bnxt_hwrm_nvm_req()
    https://git.kernel.org/netdev/net-next/c/e23c40d41b88
  - [net-next,v2,03/10] bnxt_en: Optimize bnxt_sriov_disable()
    https://git.kernel.org/netdev/net-next/c/21b6b8e8b344
  - [net-next,v2,04/10] bnxt_en: Improve bnxt_backing_store_cfg_v2()
    https://git.kernel.org/netdev/net-next/c/de6768750319
  - [net-next,v2,05/10] bnxt_en: Add fw log trace support for 5731X/5741X chips
    https://git.kernel.org/netdev/net-next/c/ba1aefee2e98
  - [net-next,v2,06/10] bnxt_en: Add err_qpc backing store handling
    https://git.kernel.org/netdev/net-next/c/6f115863f736
  - [net-next,v2,07/10] bnxt_en: Support for RoCE resources dynamically shared within VFs.
    https://git.kernel.org/netdev/net-next/c/48e619627832
  - [net-next,v2,08/10] bnxt_en: Use VLAN_ETH_HLEN when possible
    https://git.kernel.org/netdev/net-next/c/7ef55292dc2d
  - [net-next,v2,09/10] bnxt_en: Implement ethtool .get_tunable() for ETHTOOL_PFC_PREVENTION_TOUT
    https://git.kernel.org/netdev/net-next/c/6684b91d04b4
  - [net-next,v2,10/10] bnxt_en: Implement ethtool .set_tunable() for ETHTOOL_PFC_PREVENTION_TOUT
    https://git.kernel.org/netdev/net-next/c/fa18932afb29

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



