Return-Path: <netdev+bounces-216179-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DD0FB325CB
	for <lists+netdev@lfdr.de>; Sat, 23 Aug 2025 02:30:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F6057A1C80
	for <lists+netdev@lfdr.de>; Sat, 23 Aug 2025 00:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64577126C17;
	Sat, 23 Aug 2025 00:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vm0w6zmE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B0084039;
	Sat, 23 Aug 2025 00:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755909018; cv=none; b=dph6yaOOnVlfxM6KmK2UzH29qgQTqVJRQaxG8VN6qDnnVJm5HrDoa7KGRu7b26IQ455dEDCqiDeMuo5Y2GWzJQi+2kW4HRF+yXEHh/Ndti0mPImjqWPp3xY0Puu8H/34Jm1zw7swJ26zAdocshpWyC3H3zbqCznb0OG6eF59ePU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755909018; c=relaxed/simple;
	bh=no0C1/fYg2V+PHJsLvgUy4LEvf9PptzBRjWhbdevvo4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Z9m8l5lvIiy7bn4CfZK99yXROZIUzX1cJYwhOVSIA2LiBDvF9tEbtG9W8+iJUhTTBDekzSdtEdDMo0myJq6qaGdxo3iaVzbZCIQvRGQjO3LdBnFbfZIm13RwgnbW8Vg4CNzI/go+gRlcOhRwxBQ+L6hs+X9dGjPojrrvvoHP1ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vm0w6zmE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6B3FC4CEED;
	Sat, 23 Aug 2025 00:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755909016;
	bh=no0C1/fYg2V+PHJsLvgUy4LEvf9PptzBRjWhbdevvo4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Vm0w6zmEIaqbtvFvK9/tLWA5WQMbmucZNpqt6QOwk3nGcua45PkR820SIrLemNfoi
	 AlFBi3KgzodK+rmaKulyCNm3wNvv4ZZGeL6vQI1iZa7CtSoxlngvJph7QuRNiIbIIb
	 Tv8PG53904CTwy7ADD8TdgPR8/CBcpXYXTWZiRPVV70wf2DHQmt/uzH9E++5yZ3fFL
	 jr38u0EV+uPOM90+cTlSNuXzDRHmq8R0P4lPMKeE4Dt4tGIMrB/wzRF51tZ02dNDVF
	 MvwqyZvGGctFQMvKD8f1SEKoQNLL3EE0fBXiuN4ha8oh4V4iN44hpTd8seiflYl049
	 AhCVOuSbuVyig==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF30383BF69;
	Sat, 23 Aug 2025 00:30:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v14 0/8] net: hinic3: Add a driver for Huawei 3rd
 gen
 NIC - management interfaces
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175590902523.2040371.14804037397876219083.git-patchwork-notify@kernel.org>
Date: Sat, 23 Aug 2025 00:30:25 +0000
References: <cover.1755673097.git.zhuyikai1@h-partners.com>
In-Reply-To: <cover.1755673097.git.zhuyikai1@h-partners.com>
To: Fan Gong <gongfan1@huawei.com>
Cc: zhuyikai1@h-partners.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, andrew+netdev@lunn.ch,
 linux-doc@vger.kernel.org, corbet@lwn.net, helgaas@kernel.org,
 luosifu@huawei.com, guoxin09@huawei.com, shenchenyang1@hisilicon.com,
 zhoushuai28@huawei.com, wulike1@huawei.com, shijing34@huawei.com,
 fuguiming@h-partners.com, meny.yossefi@huawei.com, gur.stavi@huawei.com,
 lee@trager.us, mpe@ellerman.id.au, vadim.fedorenko@linux.dev,
 sumang@marvell.com, przemyslaw.kitszel@intel.com, jdamato@fastly.com,
 christophe.jaillet@wanadoo.fr

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 20 Aug 2025 17:31:17 +0800 you wrote:
> This is the 2/3 patch of the patch-set described below.
> 
> The patch-set contains driver for Huawei's 3rd generation HiNIC
> Ethernet device that will be available in the future.
> 
> This is an SRIOV device, designed for data centers.
> Initially, the driver only supports VFs.
> 
> [...]

Here is the summary with links:
  - [net-next,v14,1/8] hinic3: Async Event Queue interfaces
    https://git.kernel.org/netdev/net-next/c/a4511307be86
  - [net-next,v14,2/8] hinic3: Complete Event Queue interfaces
    https://git.kernel.org/netdev/net-next/c/c4bbfd9b0d32
  - [net-next,v14,3/8] hinic3: Command Queue framework
    https://git.kernel.org/netdev/net-next/c/db03a1ced61c
  - [net-next,v14,4/8] hinic3: Command Queue interfaces
    https://git.kernel.org/netdev/net-next/c/16a6fce06757
  - [net-next,v14,5/8] hinic3: TX & RX Queue coalesce interfaces
    https://git.kernel.org/netdev/net-next/c/bef7c33c6754
  - [net-next,v14,6/8] hinic3: Mailbox framework
    https://git.kernel.org/netdev/net-next/c/2742e06e2d42
  - [net-next,v14,7/8] hinic3: Mailbox management interfaces
    https://git.kernel.org/netdev/net-next/c/a8255ea56aee
  - [net-next,v14,8/8] hinic3: Interrupt request configuration
    https://git.kernel.org/netdev/net-next/c/a5a90346bb12

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



