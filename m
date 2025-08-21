Return-Path: <netdev+bounces-215463-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 152E6B2EB60
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 04:42:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 841461C88F0D
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 02:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82816253F03;
	Thu, 21 Aug 2025 02:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MdmNoF3q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A86A252910
	for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 02:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755744024; cv=none; b=I8z9ZrcfPsKARPzxF2toYpZ7NW+x80HylS9h0z1Yev6HpROTp8Ol6j94Btsef8B6zGij5/E/n1yDtBzr7xK9Rts6jVb6wjwuCd++EoPOBq9j9Ifa4XSOcWrpifm9d4B7h1M5Sy5dFrKW+r6BjPqo6GfS8S2k8Ke8EfEHvnVwD/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755744024; c=relaxed/simple;
	bh=k6uBuR+BFsezZ+t3N5i7gC9dG1VhnDJnGYMxyVqrBbA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pQPxpugVUuIR2HxmWL5xl1fH8hBQw634xr+ABCOp5/NHA/Lsyws0W/udNIxAZFuMJmiCuJkm1dg5Sek6rOvy8mE4CAAOSdjTW8Fu6pz4VUJo52MfDBdlGiOI77D+Kj94TvxAJYhVkuCXexSYppTGe3AC+T/PB26oflfYXv6JG6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MdmNoF3q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE1DAC4CEE7;
	Thu, 21 Aug 2025 02:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755744023;
	bh=k6uBuR+BFsezZ+t3N5i7gC9dG1VhnDJnGYMxyVqrBbA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MdmNoF3q3pvy//ktFo1CQn5qTfqx0xYB/nCNWbSJwUwdsHZRPBwXdRVto/rMmJhMt
	 YXGoNnQ2eliv4187kgLkJVfg/ktXqHIN9pIprbQpToodPl2iOdlnGI7zKHKFkO0vSs
	 iKS/N8/sOn123xDMkG9kphHqIaxZLLY9K0ZzJiYvc0rnKVGItG9KYe/r5uVesdxnWg
	 SVOdYBJG9RF0AHSQWFdTAVmtTQKj+vaqmanlpzolCxdemhb0/Q9iG9ESUft3q1M3y8
	 f1luJVta97bQoSugx5eKGSjlBspoj6p3VWwbDnBapToaDV3NIdOYxPi9e9bK9AA3tS
	 QfwqLxYVOH84g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D96383BF4E;
	Thu, 21 Aug 2025 02:40:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/5] bnxt_en: Updates for net-next
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175574403298.482952.17915026779929048641.git-patchwork-notify@kernel.org>
Date: Thu, 21 Aug 2025 02:40:32 +0000
References: <20250819163919.104075-1-michael.chan@broadcom.com>
In-Reply-To: <20250819163919.104075-1-michael.chan@broadcom.com>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
 pavan.chebbi@broadcom.com, andrew.gospodarek@broadcom.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 19 Aug 2025 09:39:14 -0700 you wrote:
> The first patch is the FW interface update, followed by 3 patches to
> support the expanded pcie v2 structure for ethtool -d.  The last patch
> adds a Hyper-V PCI ID for the 5760X chips (Thor2).
> 
> v2: Update Changelog for patch #2
> 
> v1: https://lore.kernel.org/netdev/20250818004940.5663-1-michael.chan@broadcom.com/
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/5] bnxt_en: hsi: Update FW interface to 1.10.3.133
    https://git.kernel.org/netdev/net-next/c/5f8a4f34f6dc
  - [net-next,v2,2/5] bnxt_en: Refactor bnxt_get_regs()
    https://git.kernel.org/netdev/net-next/c/1cc174d33a1f
  - [net-next,v2,3/5] bnxt_en: Add pcie_stat_len to struct bp
    https://git.kernel.org/netdev/net-next/c/b530173d3c8a
  - [net-next,v2,4/5] bnxt_en: Add pcie_ctx_v2 support for ethtool -d
    https://git.kernel.org/netdev/net-next/c/5a4cf42322a0
  - [net-next,v2,5/5] bnxt_en: Add Hyper-V VF ID
    https://git.kernel.org/netdev/net-next/c/5be7cb805bd9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



