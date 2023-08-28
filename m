Return-Path: <netdev+bounces-31017-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB90778A8F9
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 11:31:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 959EB280E22
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 09:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B44F411C8E;
	Mon, 28 Aug 2023 09:30:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE10A611F
	for <netdev@vger.kernel.org>; Mon, 28 Aug 2023 09:30:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3E0E9C433C8;
	Mon, 28 Aug 2023 09:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693215029;
	bh=bYNjX9N2ukSGxl1mpAuKF+SDMRngqt4GM3shizKtvfg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZQavHvyCrr5mmh2YacjqvK2OWlTPaa7LwQ/edi6nbXDXVM35z1Vtsk58EKBOBaaPu
	 OZSIP2RxuO1MflPiCSRSydUN0N1HV1Xlqt71SJPDZpkgEUd+wsKw91Qp/seWv6xyUw
	 pgEPVUVMBs/P8HkCeTxd2uHX8A/qHuIoyZ6bOBZdRaE7A2gaKMPKByxROcoU7FkGE1
	 z2HhYPrkMnE8ZnvTfvN4FiSGpY2R/Z0A0An2KaFRmkU21fss1gsmDoUxQNZbcvPDoG
	 vDH32hy8re6UmYHo+Qac6U4OIymVb2JAYbSEe/uuqoO+FH8QKnWTOXSZEHsIJtHd8s
	 4zDSFjyfGAiLA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1C3B7C3959E;
	Mon, 28 Aug 2023 09:30:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next,v3] selftests: bonding: create directly devices in
 the target namespaces
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169321502911.13199.3114963814895556928.git-patchwork-notify@kernel.org>
Date: Mon, 28 Aug 2023 09:30:29 +0000
References: <20230826022330.3474899-1-shaozhengchao@huawei.com>
In-Reply-To: <20230826022330.3474899-1-shaozhengchao@huawei.com>
To: Zhengchao Shao <shaozhengchao@huawei.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, shuah@kernel.org,
 j.vosburgh@gmail.com, andy@greyhouse.net, weiyongjun1@huawei.com,
 yuehaibing@huawei.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by David S. Miller <davem@davemloft.net>:

On Sat, 26 Aug 2023 10:23:30 +0800 you wrote:
> If failed to set link1_1 to netns client, we should delete link1_1 in the
> cleanup path. But if set link1_1 to netns client successfully, delete
> link1_1 will report warning. So it will be safer creating directly the
> devices in the target namespaces.
> 
> Reported-by: Hangbin Liu <liuhangbin@gmail.com>
> Closes: https://lore.kernel.org/all/ZNyJx1HtXaUzOkNA@Laptop-X1/
> Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
> 
> [...]

Here is the summary with links:
  - [net-next,v3] selftests: bonding: create directly devices in the target namespaces
    https://git.kernel.org/bpf/bpf-next/c/bf68583624c5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



