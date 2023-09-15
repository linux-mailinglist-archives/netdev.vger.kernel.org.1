Return-Path: <netdev+bounces-34028-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E2627A1B33
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 11:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30D3A1C20CA0
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 09:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44CF3DDC6;
	Fri, 15 Sep 2023 09:50:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A5B3201
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 09:50:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5B022C433C9;
	Fri, 15 Sep 2023 09:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694771424;
	bh=kOv5h6M9IBBPBOEbFOESX2oFiirDMeu/tTGJC3nqupc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fnB6lu/ejYy1h6tKFXH58O9v83OrKB3zzsL2xpwtH2AsoHL0SiothuvwBCx3rETqc
	 aGBTO+8ATQh8GURevKpfEFE+iUZbV3YeaC2nDxEAaWcxe0FR/kPsag5W5972ULdTVO
	 KHIDSuJCdZ3cBUO0dxTISiRBrwyRk+3LGkLYNOVn1Valrw/+gp4XHqLDYtbWbgnwKD
	 XMVVSV1OhUG8pLyOTsNrCSj0PYQ6Yla6d6BfvH5LM2QlzusYQEPPBLJCetZUxQTf/f
	 FIdTnWfEyBwqvjjXgf62eIuve30UrvsK9QKGxyWFr37JNYjnL9TAfmOViz2lYOAN0N
	 hlQKvBEk4nxXw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 41607E22AF3;
	Fri, 15 Sep 2023 09:50:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v1 1/1] net/core: Fix ETH_P_1588 flow dissector
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169477142426.29246.17284843521729553592.git-patchwork-notify@kernel.org>
Date: Fri, 15 Sep 2023 09:50:24 +0000
References: <20230913063905.1414023-1-sasha.neftin@intel.com>
In-Reply-To: <20230913063905.1414023-1-sasha.neftin@intel.com>
To: Sasha Neftin <sasha.neftin@intel.com>
Cc: netdev@vger.kernel.org, eranbe@nvidia.com, tariqt@nvidia.com,
 kuba@kernel.org, anthony.l.nguyen@intel.com, vinicius.gomes@intel.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 13 Sep 2023 09:39:05 +0300 you wrote:
> When a PTP ethernet raw frame with a size of more than 256 bytes followed
> by a 0xff pattern is sent to __skb_flow_dissect, nhoff value calculation
> is wrong. For example: hdr->message_length takes the wrong value (0xffff)
> and it does not replicate real header length. In this case, 'nhoff' value
> was overridden and the PTP header was badly dissected. This leads to a
> kernel crash.
> 
> [...]

Here is the summary with links:
  - [net,v1,1/1] net/core: Fix ETH_P_1588 flow dissector
    https://git.kernel.org/netdev/net/c/75ad80ed88a1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



