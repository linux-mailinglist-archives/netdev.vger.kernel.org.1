Return-Path: <netdev+bounces-203516-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9DFEAF6405
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 23:29:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8274D1C45609
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 21:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1083278768;
	Wed,  2 Jul 2025 21:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e+TuWppp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F381F03D9;
	Wed,  2 Jul 2025 21:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751491784; cv=none; b=XI+hIiwTxII4xuQEUmQConSwOC0I864mgNHw1fXmJDHvAPU0HCZvhnhm0Fur1WBsEp8vSqkrzNe35Puh3jKAUeJTc6HFUvcIdrl2NVnW6S03cqm26djm4Qdzvjs8EZI7qlWdwQdHk3i5xjFVjOiIuf9/Jd2eynse0soW4MVAYig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751491784; c=relaxed/simple;
	bh=fE62hdLk6to/S3vrqlzE6dTuyTkFSPn3RG8SWSrYAG8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JcDhfN9s2b9XI2MbJ66EaHZsWLHn6SXq5MQh7fV/NvXhMr/4JnmrfpAUpMkMblZJXXXi9/dfJYbIX3mJeXGpWmUMq7sfJM14QMqWCiWiKlW7j1udAzTuqJ5WhWQvTr8SrjBB9pQWVjwtsslXssSuZD1YmhqdAS05Ebnq2RZz/3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e+TuWppp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F017EC4CEE7;
	Wed,  2 Jul 2025 21:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751491784;
	bh=fE62hdLk6to/S3vrqlzE6dTuyTkFSPn3RG8SWSrYAG8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=e+TuWpppAqOInfDEJdwi2gUsj/uG/5bnzmNFEZvmsa8h0ix4gc+K+FrEhktLNoRfL
	 Fo5lEaliGlPt+OfUOQKVNGDAiF4SlIh16N9LCN4FpeJ3iQTy/vmMabWvOzg5CM8n/i
	 /706Z21I0uqLmjfZzdK+N2HLSEOKx0T0TsAx1tyf6xar/nzuM+jQiYWIodfonlna80
	 MdAqn1EtqKGvSgr0YunR2EuEOCdraKuaPri5rpYtahfMIJQX8rnXiscgEMU6jBVs94
	 W07n5Lso7IHs8BuXpTW57qV5/nZzOstuKUJVCq4umbNzPkgwM6cja7Sa799ZMFgy0s
	 MlnaTA+F81M5A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE4A1383B273;
	Wed,  2 Jul 2025 21:30:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] net: thunderbolt: Fix the parameter passing of
 tb_xdomain_enable_paths()/tb_xdomain_disable_paths()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175149180851.869841.2113483295411512857.git-patchwork-notify@kernel.org>
Date: Wed, 02 Jul 2025 21:30:08 +0000
References: <20250628094920.656658-1-zhangjianrong5@huawei.com>
In-Reply-To: <20250628094920.656658-1-zhangjianrong5@huawei.com>
To: zhangjianrong <zhangjianrong5@huawei.com>
Cc: michael.jamet@intel.com, mika.westerberg@linux.intel.com,
 YehezkelShB@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 guhengsheng@hisilicon.com, caiyadong@huawei.com, xuetao09@huawei.com,
 lixinghang1@huawei.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 28 Jun 2025 17:49:20 +0800 you wrote:
> According to the description of tb_xdomain_enable_paths(), the third
> parameter represents the transmit ring and the fifth parameter represents
> the receive ring. tb_xdomain_disable_paths() is the same case.
> 
> Fixes: ff7cd07f3064 ("net: thunderbolt: Enable DMA paths only after rings are enabled")
> Signed-off-by: zhangjianrong <zhangjianrong5@huawei.com>
> 
> [...]

Here is the summary with links:
  - [v2] net: thunderbolt: Fix the parameter passing of tb_xdomain_enable_paths()/tb_xdomain_disable_paths()
    https://git.kernel.org/netdev/net-next/c/8ec31cb17cd3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



