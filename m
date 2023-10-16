Return-Path: <netdev+bounces-41433-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9639A7CAEF1
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 18:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 936E91C20ACB
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 16:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CB6B30D16;
	Mon, 16 Oct 2023 16:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WuQYN0K2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0C230D0C
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 16:20:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A3DE6C433CA;
	Mon, 16 Oct 2023 16:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697473227;
	bh=OmDX71W8pnHJvXkCucPAjaUIHG3N468/aXGQVHPVYXQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WuQYN0K2HpIwDAjzQiBVC5JrYoaVVtaLpuWb1pc+cdzeBkr+6x5S/jEu9XDMgt4rY
	 oKm+/HfdeAsovwP8ukPV9BWFziId+OCUwR1IlO/AYEn1kIMRPiaxszRwMciqUDl13n
	 HYdqJywsspuFeiLzrq82PQRmU/+WADdUUISr090Xg2J78wmFOGih6iA6y1ojqQmWDR
	 5nDzZIdcLht1DfVBZ3Phy9MLaFfMP2DkdDGOe822bB3s0dOmy8cbHMNMWd3jcFGrPK
	 OZzB8xOyIlTc9GRPcmlWBSaqtWVhQOdoBCt1HO6Xm7ll5CvrQLY7ApSFUWl0L3RTZX
	 8ZUoKpv9/JvRA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 89C14C04E32;
	Mon, 16 Oct 2023 16:20:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 iproute2-next 0/2] rdma: Support dumping SRQ resource in
 raw format
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169747322756.5359.10248022521412902967.git-patchwork-notify@kernel.org>
Date: Mon, 16 Oct 2023 16:20:27 +0000
References: <20231010075526.3860869-1-huangjunxian6@hisilicon.com>
In-Reply-To: <20231010075526.3860869-1-huangjunxian6@hisilicon.com>
To: Junxian Huang <huangjunxian6@hisilicon.com>
Cc: jgg@ziepe.ca, leon@kernel.org, dsahern@gmail.com,
 stephen@networkplumber.org, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linuxarm@huawei.com, linux-kernel@vger.kernel.org

Hello:

This series was applied to iproute2/iproute2-next.git (main)
by David Ahern <dsahern@kernel.org>:

On Tue, 10 Oct 2023 15:55:24 +0800 you wrote:
> This patchset adds support to dump SRQ resource in raw format with
> rdmatool. The corresponding kernel commit is aebf8145e11a
> ("RDMA/core: Add support to dump SRQ resource in RAW format")
> 
> v2 adds the missing change in res_srq_idx_parse_cb().
> 
> Junxian Huang (1):
>   rdma: Update uapi headers
> 
> [...]

Here is the summary with links:
  - [v2,iproute2-next,1/2] rdma: Update uapi headers
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=cd4315de422e
  - [v2,iproute2-next,2/2] rdma: Add support to dump SRQ resource in raw format
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=07bfa4482d49

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



