Return-Path: <netdev+bounces-13247-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC5573AEC8
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 04:51:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEBE91C20E00
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 02:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02DFA17D3;
	Fri, 23 Jun 2023 02:50:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1062D801;
	Fri, 23 Jun 2023 02:50:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6FCC6C433C9;
	Fri, 23 Jun 2023 02:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687488626;
	bh=9EiFCNHJdUpB+XW1zu/aSkMUksAqJahEysCGpYwwpD4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mOVmqgTDkzxHjY/uKaDRNHHy7gKk4xXwchepy/RBKuwnGRuz8kKXVdUGZvFxDmzPz
	 8e28RgQQzGfDmaHmJ5CZIUCEHWy8MOIs+IGJq54kKbkqCmo8kcZfnlWHfCG/cpQ7t/
	 MQl6UoXAIgGTFsYgoL5gyRtlpZiGoohwjv+gRsfU/oCd7QyvEIMzl+kpunI8vRDcou
	 RExwmgEqUX0YrOnw+RosZ3PVJDdq13xLqhoxRRTw/6SK+Sa1GgONnFaEuv/177fnz4
	 7vybmUpQMpWQ80Qg4SZ4AcFQB/b9h8coL/lrQOZgmgniG12C6Si1Ql29RqDwSeNqzH
	 l+5pDpsclDNKw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 54D53C395F1;
	Fri, 23 Jun 2023 02:50:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/8] Fix comment typos about "transmit"
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168748862634.32034.1394302200661050543.git-patchwork-notify@kernel.org>
Date: Fri, 23 Jun 2023 02:50:26 +0000
References: <20230622012627.15050-1-shamrocklee@posteo.net>
In-Reply-To: <20230622012627.15050-1-shamrocklee@posteo.net>
To: Yueh-Shun Li <shamrocklee@posteo.net>
Cc: jgg@ziepe.ca, leon@kernel.org, anthony.l.nguyen@intel.com,
 davem@davemloft.net, kvalo@kernel.org, jejb@linux.ibm.com, kuba@kernel.org,
 pabeni@redhat.com, apw@canonical.com, joe@perches.com,
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
 linux-wireless@vger.kernel.org, linux-scsi@vger.kernel.org,
 mptcp@lists.linux.dev, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 22 Jun 2023 01:26:21 +0000 you wrote:
> Fix typos about "transmit" missing the first "s"
> found by searching with keyword "tram" in the first 7
> patches.
> 
> Add related patterns to "scripts/spelling.txt" in the
> last patch.
> 
> [...]

Here is the summary with links:
  - [1/8] RDMA/rxe: fix comment typo
    (no matching commit)
  - [2/8] i40e, xsk: fix comment typo
    https://git.kernel.org/netdev/net-next/c/b028813ac973
  - [3/8] zd1211rw: fix comment typo
    (no matching commit)
  - [4/8] scsi: fix comment typo
    (no matching commit)
  - [5/8] tcp: fix comment typo
    https://git.kernel.org/netdev/net-next/c/304b1875ba02
  - [6/8] net/tls: fix comment typo
    https://git.kernel.org/netdev/net-next/c/a0e128ef88e4
  - [7/8] selftests: mptcp: connect: fix comment typo
    (no matching commit)
  - [8/8] scripts/spelling.txt: Add "transmit" patterns
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



