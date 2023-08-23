Return-Path: <netdev+bounces-29971-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 703A478567C
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 13:10:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5742F1C20C2E
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 11:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCD98BA34;
	Wed, 23 Aug 2023 11:10:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EBFBBA33
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 11:10:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F2B55C433C9;
	Wed, 23 Aug 2023 11:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692789023;
	bh=JZMLtoGZ+80NOQTxvx12Ihg7NRf0n6uh28eG1/8kGCI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dIPlC9pdor1pQmh5bNVfqrv2LXmsLjnF3N5nszqVHwrBl8AHTD0zqunO88KxpvU6H
	 4XZZTwA3t1ujKOXZ1wo0VFL0EMfVB9ZXseq079koxC2R5U7ymjpNNPdhiRgjGJUMQw
	 Oy/I9QJmPeXRdmAWBQjqUtAcxK9MKfVJzwSnqalXLIBGQMwmIT6vRyM9o4HZfjp0/H
	 19AJ+kBNI2ksEe0fMTIAQ6aS0LtbCLyWQmv/VMwkcR1ZIIiSpQEabt0CiA3LY4cjNc
	 SSsC2rZwI/Fl/cek7MXTj88Aq8wmL7c3UFG26npaNrT/9Sqbx771gip7qqILnvv2td
	 CPSPec0/RmGkg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CBF20E4EAF6;
	Wed, 23 Aug 2023 11:10:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] ibmveth: Use dcbf rather than dcbfl
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169278902283.13629.38861112100077909.git-patchwork-notify@kernel.org>
Date: Wed, 23 Aug 2023 11:10:22 +0000
References: <20230823045139.738816-1-mpe@ellerman.id.au>
In-Reply-To: <20230823045139.738816-1-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 nnac123@linux.ibm.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 23 Aug 2023 14:51:39 +1000 you wrote:
> When building for power4, newer binutils don't recognise the "dcbfl"
> extended mnemonic.
> 
> dcbfl RA, RB is equivalent to dcbf RA, RB, 1.
> 
> Switch to "dcbf" to avoid the build error.
> 
> [...]

Here is the summary with links:
  - ibmveth: Use dcbf rather than dcbfl
    https://git.kernel.org/netdev/net/c/bfedba3b2c77

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



