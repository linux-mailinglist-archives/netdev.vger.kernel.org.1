Return-Path: <netdev+bounces-233355-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 90CD1C1274A
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 02:00:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 35646353D9F
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 01:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2A2643ABC;
	Tue, 28 Oct 2025 01:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g71DYwvb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892CE1758B;
	Tue, 28 Oct 2025 01:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761613231; cv=none; b=qD/mt+NtpyNdJT9u3GTj7VV4YvsNrYX05UTD/6ZptVyKRY0EDmvouOnVlV+G7Mug0g8VWxnfsFmvn8XNA81bYHDXetVQ6Dq949fjGgyvzIZfQ3P822lF41cSOi9dSsBoW2GURY1KNrcn3pUz+lrl/9cXi21vxEf14r1h8276Vnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761613231; c=relaxed/simple;
	bh=JYasUT6R0M0/CEBVrcwdnAMAkvZidxlsT5yaMHS/iC4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ecyIa08jYjkCk30nhndbEjKLOrzsbFK960vSXARnKc0g4+/Kx8Pnzdvq4Nd4cHv2Ag04BJCH74MGaTRRfgeB8zptO+qWKSnbwhXrUpNsb9SfDxYAN3wby1OLzoZzqOwjWMED7RHiSXeiIvc7pr5kAoLjeIIvXv+3azC+HlPJqNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g71DYwvb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10A41C4CEF1;
	Tue, 28 Oct 2025 01:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761613231;
	bh=JYasUT6R0M0/CEBVrcwdnAMAkvZidxlsT5yaMHS/iC4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=g71DYwvbZxkQqKq1AP84Sj6plhc5Qf3/sbyfp1dB1dTudN1Bibi48Lq7CUdNpmPjf
	 EbhPtSThRpm3azBOT1AxxqFlvagGRCPcqI+LLIuqnfZgmAKVm5bsdutyKA57AzYnK6
	 d10bHUYM0O6l5hYbFBq8apK/rfyb9FrvrFxRSftRxpVT715rlO82Izdh13mlTL3Nj9
	 46jCNskoDrY224NCO9MxFMbl71M7TNiB/az7f6K6uf4eG2CX/+EgLCS2m1Sj1p6+dG
	 chmdSCgJeJku+z9JBSiPAxPreaOdlf/Ez+1yE/dBKU2SLc/pWqE51VSzOVsOjESO+5
	 x7Wo7DlDv8I3g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5B87139D60B9;
	Tue, 28 Oct 2025 01:00:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/2] There are some bugfix for the HNS3 ethernet
 driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176161320925.1646308.11646874787193148592.git-patchwork-notify@kernel.org>
Date: Tue, 28 Oct 2025 01:00:09 +0000
References: <20251023131338.2642520-1-shaojijie@huawei.com>
In-Reply-To: <20251023131338.2642520-1-shaojijie@huawei.com>
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 shenjian15@huawei.com, liuyonglong@huawei.com, chenhao418@huawei.com,
 lantao5@huawei.com, huangdonghua3@h-partners.com,
 yangshuaisong@h-partners.com, jonathan.cameron@huawei.com,
 salil.mehta@huawei.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 23 Oct 2025 21:13:36 +0800 you wrote:
> This patchset includes 2 fixes:
> 1. Patch1 fixes an incorrect function return value.
> 2. Patch2 fixes the issue of lost reset concurrent protection after
>   seq_file reconstruction in debugfs.
> 
> Note: Compared to the previous version, this patchset has removed 2 patches
> and added 1 new patch, so it is being resent as V1.
> 
> [...]

Here is the summary with links:
  - [net,1/2] net: hns3: return error code when function fails
    https://git.kernel.org/netdev/net/c/03ca7c8c42be
  - [net,2/2] net: hns3: fix null pointer in debugfs issue
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



