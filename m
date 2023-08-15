Return-Path: <netdev+bounces-27762-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30A4A77D1C8
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 20:26:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 622231C20E17
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 18:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D2118030;
	Tue, 15 Aug 2023 18:26:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C3E17ACA
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 18:26:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5233FC433C8;
	Tue, 15 Aug 2023 18:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692123983;
	bh=p+TzmT/E7cNgjIPEMoOKL8P17OHBULu+kPazD0IWDAE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OwuByQoGDbVgdFeMlsyO4cu1F4HcXCJLBrQbBfbIsUj+0mY+W78uDhXsKGB7X1X7X
	 nuNJlC3SpdrYQVvLgjHsZ4HIFO15Gq9P4pzxs/JeRTYOGha/awAJS2LTFJAiutodQ4
	 j4Dg4ipilE94GoVUtigmDk1NTNHL/tjAQD2Ghu2JGLL8Lf4rkHf1M86dzqq7/wYD3F
	 BHdZAl1xNkm2YkvmBvqxLMsDWDGm0e9voCQ5Ff2s2g5dG5STquHeE4+Bvcpz0bOTIO
	 SfCCaA2m9HdPTPrTn6Ww8UewjHyp9UYWuT9BALHZzX0YFUB4VPeP8mQQxiMv7SX9tA
	 HQrA1Eg+cIshQ==
Date: Tue, 15 Aug 2023 21:26:19 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: yisen.zhuang@huawei.com, salil.mehta@huawei.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	shenjian15@huawei.com, wangjie125@huawei.com,
	liuyonglong@huawei.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 3/4] net: hns3: Support tlv in regs data for
 HNS3 VF driver
Message-ID: <20230815182619.GR22185@unreal>
References: <20230815060641.3551665-1-shaojijie@huawei.com>
 <20230815060641.3551665-4-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230815060641.3551665-4-shaojijie@huawei.com>

On Tue, Aug 15, 2023 at 02:06:40PM +0800, Jijie Shao wrote:
> The dump register function is being refactored.
> The third step in refactoring is to support tlv info in regs data for
> HNS3 PF driver.
> 
> Currently, if we use "ethtool -d" to dump regs value,
> the output is as follows:
>   offset1: 00 01 02 03 04 05 ...
>   offset2：10 11 12 13 14 15 ...
>   ......
> 
> We can't get the value of a register directly.
> 
> This patch deletes the original separator information and
> add tag_len_value information in regs data.
> ethtool can parse register data in key-value format by -d command.
> 
> a patch will be added to the ethtool to parse regs data
> in the following format:
>   reg1 : value2
>   reg2 : value2
>   ......
> 
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
> ---
>  .../hisilicon/hns3/hns3vf/hclgevf_regs.c      | 85 +++++++++++++------
>  1 file changed, 61 insertions(+), 24 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

