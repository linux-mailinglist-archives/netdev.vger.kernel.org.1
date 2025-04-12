Return-Path: <netdev+bounces-181863-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D12DA86A5A
	for <lists+netdev@lfdr.de>; Sat, 12 Apr 2025 04:01:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 979FB1B83526
	for <lists+netdev@lfdr.de>; Sat, 12 Apr 2025 02:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A621D155743;
	Sat, 12 Apr 2025 02:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GIuYTGxU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820641547C3
	for <netdev@vger.kernel.org>; Sat, 12 Apr 2025 02:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744423256; cv=none; b=WtubCZ1C6qVre6BxuYEo0rEpT7GUGmOSB3mo4AWODSLMTUwnWr0b9BnR2giO4dytjgteKOUVr6Vn1aHq3tCyzoaMSdwm3Zl4HTdvD7voSO9yfWtwa0KiN5/eFd8sz6HoV9V2YrGOuR42zVJS+2XDj0dv8sUhWIez/jX2heSqISU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744423256; c=relaxed/simple;
	bh=Py2YzAinYihlDZefTkArwE4f2NqbpNZkE+sfGnUfW8w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tErPVEkhXSsQ1XqCjn7aT+Xu1PWrmSNB54fWjPUgwX9YghVSxIlnrUcFp5MQJmi8bgZb9Z4CVMBzTc8adyNIiBSA9LI+ieSxhjPmk9EFhWFPcey9edV/fbKy9gmF64UVMg6kFFxI/+LHHLA1bVO7su+oGqkXrQZIAlpSrH6iavY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GIuYTGxU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5893BC4CEE2;
	Sat, 12 Apr 2025 02:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744423256;
	bh=Py2YzAinYihlDZefTkArwE4f2NqbpNZkE+sfGnUfW8w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GIuYTGxUSUe27awQVqrQYKbnaUQhhujCXjRm2ZyQVkG91hsJRhg7ckgUsf2gcz2LN
	 tqoVSMLNFLeTzxsB2elyuk7I4M2qySGnkWRlzZjZuFID84a8qTm3P1P2MYK58TKPjP
	 5/oImG/ohp7yeoJBxELzfiaYDJo8WwjDYAJP69B2yn3HPrPgVm2VnVRlLaW0O5numY
	 DeS5e+oJqdIiey50vchOFBA0fxzaRuA1ByhYwjcJZOyXXiFmQ4uAgXpzGDdWLR9Xvi
	 PFJxQUixICNmCVU6j6Pnj0iHYKodIe9oU5gwdPR6CwKKRT9bx+8rGqo66fFLWJasow
	 MeQWbiY5OvLqg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33BC938111DD;
	Sat, 12 Apr 2025 02:01:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] ethtool: cmis_cdb: use correct rpl size in
 ethtool_cmis_module_poll()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174442329375.549857.9802596514513043619.git-patchwork-notify@kernel.org>
Date: Sat, 12 Apr 2025 02:01:33 +0000
References: <20250409173312.733012-1-michael.chan@broadcom.com>
In-Reply-To: <20250409173312.733012-1-michael.chan@broadcom.com>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, andrew@lunn.ch, horms@kernel.org,
 danieller@nvidia.com, damodharam.ammepalli@broadcom.com,
 andrew.gospodarek@broadcom.com, idosch@nvidia.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  9 Apr 2025 10:33:12 -0700 you wrote:
> From: Damodharam Ammepalli <damodharam.ammepalli@broadcom.com>
> 
> rpl is passed as a pointer to ethtool_cmis_module_poll(), so the correct
> size of rpl is sizeof(*rpl) which should be just 1 byte.  Using the
> pointer size instead can cause stack corruption:
> 
> Kernel panic - not syncing: stack-protector: Kernel stack is corrupted in: ethtool_cmis_wait_for_cond+0xf4/0x100
> CPU: 72 UID: 0 PID: 4440 Comm: kworker/72:2 Kdump: loaded Tainted: G           OE      6.11.0 #24
> Tainted: [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
> Hardware name: Dell Inc. PowerEdge R760/04GWWM, BIOS 1.6.6 09/20/2023
> Workqueue: events module_flash_fw_work
> Call Trace:
>  <TASK>
>  panic+0x339/0x360
>  ? ethtool_cmis_wait_for_cond+0xf4/0x100
>  ? __pfx_status_success+0x10/0x10
>  ? __pfx_status_fail+0x10/0x10
>  __stack_chk_fail+0x10/0x10
>  ethtool_cmis_wait_for_cond+0xf4/0x100
>  ethtool_cmis_cdb_execute_cmd+0x1fc/0x330
>  ? __pfx_status_fail+0x10/0x10
>  cmis_cdb_module_features_get+0x6d/0xd0
>  ethtool_cmis_cdb_init+0x8a/0xd0
>  ethtool_cmis_fw_update+0x46/0x1d0
>  module_flash_fw_work+0x17/0xa0
>  process_one_work+0x179/0x390
>  worker_thread+0x239/0x340
>  ? __pfx_worker_thread+0x10/0x10
>  kthread+0xcc/0x100
>  ? __pfx_kthread+0x10/0x10
>  ret_from_fork+0x2d/0x50
>  ? __pfx_kthread+0x10/0x10
>  ret_from_fork_asm+0x1a/0x30
>  </TASK>
> 
> [...]

Here is the summary with links:
  - [net,v2] ethtool: cmis_cdb: use correct rpl size in ethtool_cmis_module_poll()
    https://git.kernel.org/netdev/net/c/f3fdd4fba16c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



