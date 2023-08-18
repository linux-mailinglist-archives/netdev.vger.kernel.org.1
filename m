Return-Path: <netdev+bounces-28988-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02030781579
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 00:40:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33B44281D67
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 22:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69C6A17AB5;
	Fri, 18 Aug 2023 22:40:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0195FA2C
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 22:40:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4908DC433D9;
	Fri, 18 Aug 2023 22:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692398422;
	bh=WF3RNh7noqB7TKptg9a+/c1S23lERXjQplO4uiRSS9U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EQLTdS53QxR03TCFCS8LZzEhJpa9OK4KvsA6RE3e9Tf4QwlgJq30iPJ/b965I9Uhu
	 qhE3fOBoSUNfGEzGQ/K6IPtX0m9Gw/3WneIIRHmGeK4iKlz4PL4keaxo52IgKN5X8G
	 zTCZVSWD1sY02IsZg4O1xPraO8o7pQIxkCOTaTSmiJ1/JtOfMo2zRWDFP5hqtLz20S
	 dVGfY9LOzq7D3eOjB2e7WLvoYCYQweChDvCeJ0x8EU3pPRm/aov+7AtSLumdo/LO4M
	 8KyFpU138Y3VagF8JiutDwnMYTHSbXmMwCmRLOlJoufTbs9hTCfI2qqP+DAmIEAUE5
	 Z6CmbXPW1iz8A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 33F9CC395DC;
	Fri, 18 Aug 2023 22:40:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next] pds_core: remove redundant pci_clear_master()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169239842220.2718.13879276137492386926.git-patchwork-notify@kernel.org>
Date: Fri, 18 Aug 2023 22:40:22 +0000
References: <20230817025709.2023553-1-liaoyu15@huawei.com>
In-Reply-To: <20230817025709.2023553-1-liaoyu15@huawei.com>
To: Yu Liao <liaoyu15@huawei.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, leon@kernel.org, shannon.nelson@amd.com,
 liwei391@huawei.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 17 Aug 2023 10:57:09 +0800 you wrote:
> do_pci_disable_device() disable PCI bus-mastering as following:
> static void do_pci_disable_device(struct pci_dev *dev)
> {
> 		u16 pci_command;
> 
> 		pci_read_config_word(dev, PCI_COMMAND, &pci_command);
> 		if (pci_command & PCI_COMMAND_MASTER) {
> 				pci_command &= ~PCI_COMMAND_MASTER;
> 				pci_write_config_word(dev, PCI_COMMAND, pci_command);
> 		}
> 
> [...]

Here is the summary with links:
  - [v2,net-next] pds_core: remove redundant pci_clear_master()
    https://git.kernel.org/netdev/net-next/c/2f48b1d854e8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



