Return-Path: <netdev+bounces-27761-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 240BF77D1C6
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 20:26:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D29732815B5
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 18:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B0F118022;
	Tue, 15 Aug 2023 18:26:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A1213AFD
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 18:26:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08A7CC433C8;
	Tue, 15 Aug 2023 18:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692123974;
	bh=RXo2zYGzVjDJRSgwfEUzYuflpd4HU3MVetl5DFGA8Ag=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P2mayUC/qT1h98UiCRjarr8KMmNhUzUrEaDoXksz8z2oBdWbxDumctzuQHpDoKvOJ
	 e/J0QVQ/zzQ4pLhDlb+7Cvuj4jDVb0bgm4CFA/bMYYrmoN3HGfI95UvxWXU6mQ7lZA
	 c3jx/H5VHAmsF+D8iXB6rtTCzold0DwnicFC/elqtBHpeUxUEih4knBLDdlKOi+vP3
	 ECxrQp7b4a/VGgYZLlEJQyVNPe1qTzvXiMz2WvGczpBt3siCMI4tD8S5LUdGFvKZRJ
	 dt0bIVBBx+3428OZuCbNRsunz+zdnuQz1lI0vEpFhNaiGzcIELFToR7KdCNz2tFxxq
	 1Wuu2MMD0Gghg==
Date: Tue, 15 Aug 2023 21:26:10 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: yisen.zhuang@huawei.com, salil.mehta@huawei.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	shenjian15@huawei.com, wangjie125@huawei.com,
	liuyonglong@huawei.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/4] net: hns3: Support tlv in regs data for
 HNS3 PF driver
Message-ID: <20230815182610.GQ22185@unreal>
References: <20230815060641.3551665-1-shaojijie@huawei.com>
 <20230815060641.3551665-3-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230815060641.3551665-3-shaojijie@huawei.com>

On Tue, Aug 15, 2023 at 02:06:39PM +0800, Jijie Shao wrote:
> The dump register function is being refactored.
> The second step in refactoring is to support tlv info in regs data for
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
>  .../hisilicon/hns3/hns3pf/hclge_regs.c        | 167 +++++++++++-------
>  1 file changed, 102 insertions(+), 65 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

