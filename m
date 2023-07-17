Return-Path: <netdev+bounces-18187-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5945C755B04
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 07:54:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41DE01C20A5F
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 05:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A1C16D19;
	Mon, 17 Jul 2023 05:54:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8444A15B4
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 05:54:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66070C433C8;
	Mon, 17 Jul 2023 05:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689573286;
	bh=yYhsTT28XBUnEe+NxFlVluHfifgm46GUjE65XLytZUM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vDqDTZ0f3Uwji5llR4koUFtLEeRiTpdGdrpt6ggtcD6n2Ivyy8hzth5HuirOgZ9E1
	 z+icHaGn58K5x8f/VUkmX3BEALbgFr+0Jl+5IpuYNRVjP1HJOs+KSsm8LWGG/BMc7b
	 Tuxi3TlNGEnOfhhGC8q3KAwG+Oe6vx/z+L5WEqSq/O55HWygvJX6/g+t4NChIkimCt
	 TMjJvrMn441E4BgJbEoJd0aO4Gp6kpwxc/0Sb7D0t7LV+xGLX6xOamcJXSRy8j2cx7
	 aOq4dcOreNh9240PDzJgZBgx8sXChorZ1A8SdGa4GbAzBo+ydQ50MZtN+0RSytZbn2
	 dzFTJ+BMqTrmQ==
Date: Mon, 17 Jul 2023 08:54:42 +0300
From: Leon Romanovsky <leon@kernel.org>
To: hanyu001@208suo.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] myri10ge: Prefer unsigned int to bare use of unsigned
Message-ID: <20230717055442.GE9461@unreal>
References: <tencent_3CB61C1D0FF3B148608B138A6CA1C3414B08@qq.com>
 <3854a4d7352831a6ae3732c0ef356f99@208suo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3854a4d7352831a6ae3732c0ef356f99@208suo.com>

On Mon, Jul 17, 2023 at 10:39:41AM +0800, hanyu001@208suo.com wrote:
> This patch fixes the checkpatch.pl warning:
> 
> ./drivers/net/ethernet/myricom/myri10ge/myri10ge.c:629: WARNING: Prefer
> 'unsigned int' to bare use of 'unsigned'
> 
> Signed-off-by: maqimei <2433033762@qq.com>
> ---
>  drivers/net/ethernet/myricom/myri10ge/myri10ge.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks for the patch, but unfortunately netdev doesn't take pure cleanup
patches.

Thanks

