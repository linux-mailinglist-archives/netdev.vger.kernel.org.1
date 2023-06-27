Return-Path: <netdev+bounces-14312-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE6E74017F
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 18:41:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 006621C209BD
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 16:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D89D13087;
	Tue, 27 Jun 2023 16:40:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24ECB13065;
	Tue, 27 Jun 2023 16:40:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9D8F0C433C9;
	Tue, 27 Jun 2023 16:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687884023;
	bh=Mddr9IEnVSSEtvey/EPFRhLi4YnxlTkalZzmHZ6bmJ8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XGRGiORnH0FmaQ+kclMjYIsE8aiZt7Gs4g5WBNw+zT0ASSus8daZkKZirfbcgaoBv
	 HsuO0nskJhLaiZxylU7zlINMijGNLl9q7WEg/ms3Lh/IrCmjj2LVp6pXCXh1uqP4W3
	 kOcx2VCa4pIOSzcMTF35giAc72J/A42BnFN7K4h/MvLUE7JXaOanngW1cFFib+5J4v
	 8N2ABirViOcrN32FYcrvP15sAv/TezaSVGJHU9rgp1d1sCUFbyUbMRRUsWjqDMoEYN
	 HlJlhL0V9YgQDqvmqEWLdtvBli6Q5b70JaJ8QNh8cP8DiB/xBCXlUB+GXHpoI+1ee3
	 oj4CRUwtvenNQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7B046C64458;
	Tue, 27 Jun 2023 16:40:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 00/24] use vmalloc_array and vcalloc
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168788402349.21860.17350888958370358926.git-patchwork-notify@kernel.org>
Date: Tue, 27 Jun 2023 16:40:23 +0000
References: <20230627144339.144478-1-Julia.Lawall@inria.fr>
In-Reply-To: <20230627144339.144478-1-Julia.Lawall@inria.fr>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: linux-hyperv@vger.kernel.org, kernel-janitors@vger.kernel.org,
 keescook@chromium.org, christophe.jaillet@wanadoo.fr, kuba@kernel.org,
 kasan-dev@googlegroups.com, andreyknvl@gmail.com, dvyukov@google.com,
 iommu@lists.linux.dev, linux-tegra@vger.kernel.org, robin.murphy@arm.com,
 vdumpa@nvidia.com, virtualization@lists.linux-foundation.org,
 xuanzhuo@linux.alibaba.com, linux-scsi@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org, linux-media@vger.kernel.org,
 jstultz@google.com, Brian.Starkey@arm.com, labbott@redhat.com,
 lmark@codeaurora.org, benjamin.gaignard@collabora.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, shailend@google.com, linux-rdma@vger.kernel.org,
 mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
 linux-btrfs@vger.kernel.org, intel-gvt-dev@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, dave.hansen@linux.intel.com, hpa@zytor.com,
 linux-sgx@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 27 Jun 2023 16:43:15 +0200 you wrote:
> The functions vmalloc_array and vcalloc were introduced in
> 
> commit a8749a35c399 ("mm: vmalloc: introduce array allocation functions")
> 
> but are not used much yet.  This series introduces uses of
> these functions, to protect against multiplication overflows.
> 
> [...]

Here is the summary with links:
  - [v2,02/24] octeon_ep: use vmalloc_array and vcalloc
    https://git.kernel.org/netdev/net-next/c/32d462a5c3e5
  - [v2,04/24] gve: use vmalloc_array and vcalloc
    https://git.kernel.org/netdev/net-next/c/a13de901e8d5
  - [v2,09/24] pds_core: use vmalloc_array and vcalloc
    https://git.kernel.org/netdev/net-next/c/906a76cc7645
  - [v2,11/24] ionic: use vmalloc_array and vcalloc
    https://git.kernel.org/netdev/net-next/c/f712c8297e0a
  - [v2,18/24] net: enetc: use vmalloc_array and vcalloc
    https://git.kernel.org/netdev/net-next/c/fa87c54693ae
  - [v2,22/24] net: mana: use vmalloc_array and vcalloc
    https://git.kernel.org/netdev/net-next/c/e9c74f8b8a31

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



