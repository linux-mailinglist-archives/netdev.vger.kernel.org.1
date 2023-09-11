Return-Path: <netdev+bounces-32925-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1C3779AB2A
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 22:20:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 108AE281322
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 20:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09E2415AE6;
	Mon, 11 Sep 2023 20:20:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D02B15AF0
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 20:20:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8F83EC433CC;
	Mon, 11 Sep 2023 20:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694463628;
	bh=/6boL5OvPgGQMj7fVM/E0w9tw38/mNOjDIHkGfDGg5U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SV27z0Us6CE7qvgYNHZTrncdrMrdHgaaPim/TIYX9fEZT36cJf2qSnFTphQ8BOC4E
	 /qT2O50iJQBzG+6adHB+WI4YMnwZwHgzSiMku3+oRfQtQ4m0dhL5SuFzwit9WZidS7
	 Hw5MqQv+/LOLZ/lgbShSstce/FoTrbl/QCsy/RHq109CeFASBGjq/iK+Lh9RQJf2db
	 p35CqBA/to6H0N8XB/X8B5wSdALIPX+kr5SFWBKGTpz1infh2vIaaW9HVes7ak1ljQ
	 m2knN09zlttmxo0Z3kjrcx+vulS2JQSw7+z0WbidYb4OQnMFLpy29cC40qYLbOseB+
	 PP9OWBK0G3UpQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 72759E1C282;
	Mon, 11 Sep 2023 20:20:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH V2 ethtool] hns3: add support dump registers for hns3 driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169446362845.25976.158160732211905683.git-patchwork-notify@kernel.org>
Date: Mon, 11 Sep 2023 20:20:28 +0000
References: <20230829065656.2725081-1-shaojijie@huawei.com>
In-Reply-To: <20230829065656.2725081-1-shaojijie@huawei.com>
To: Jijie Shao <shaojijie@huawei.com>
Cc: mkubecek@suse.cz, shenjian15@huawei.com, wangjie125@huawei.com,
 liuyonglong@huawei.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to ethtool/ethtool.git (master)
by Michal Kubecek <mkubecek@suse.cz>:

On Tue, 29 Aug 2023 14:56:56 +0800 you wrote:
> Add support pretty printer for the registers of hns3 driver.
> This printer supports PF and VF, and is compatible with hns3
> drivers of earlier versions.
> 
> Sample output:
> 
> $ ethtool -d eth1
> [cmdq_regs]
>   comm_nic_csq_baseaddr_l : 0x48168000
>   comm_nic_csq_baseaddr_h : 0x00000000
>   comm_nic_csq_depth      : 0x00000080
>   comm_nic_csq_tail       : 0x00000050
>   comm_nic_csq_head       : 0x00000050
>   comm_nic_crq_baseaddr_l : 0x48170000
>   comm_nic_crq_baseaddr_h : 0x00000000
>   comm_nic_crq_depth      : 0x00000080
>   comm_nic_crq_tail       : 0x00000000
>   comm_nic_crq_head       : 0x00000000
>   comm_vector0_cmdq_src   : 0x00000000
>   comm_cmdq_intr_sts      : 0x00000000
>   comm_cmdq_intr_en       : 0x00000002
>   comm_cmdq_intr_gen      : 0x00000000
> [common_regs]
>   misc_vector_base    : 0x00000001
>   pf_other_int        : 0x00000040
>   misc_reset_sts      : 0x00000000
>   misc_vector_int_sts : 0x00000000
>   global_reset        : 0x00000000
>   fun_rst_ing         : 0x00000000
>   gro_en              : 0x00000001
> ...
> 
> [...]

Here is the summary with links:
  - [V2,ethtool] hns3: add support dump registers for hns3 driver
    https://git.kernel.org/pub/scm/network/ethtool/ethtool.git/commit/?id=a1f71f85d02e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



