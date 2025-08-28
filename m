Return-Path: <netdev+bounces-217856-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA8EAB3A293
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 16:49:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D23F61C8356A
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 14:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FFA2314A93;
	Thu, 28 Aug 2025 14:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qtRzuUk6"
X-Original-To: netdev@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E44D314B66
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 14:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756392396; cv=none; b=I7gQ36c5dzAr42e+rFFJtDIKe4hMnuUzbZ7bRhHrmYH4HQ3Lhn2zHH1w/Lw2Xhi8K+0Vx9SNfRIQBCjXmltbnRa+KSozLGziyTelJgq9freEcXAEvG2Xa32AOVQiqsLzwrGD8FC24sx+BMNiAhbQ72TtBuymxUxuHMgJFmcmXEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756392396; c=relaxed/simple;
	bh=hHLO5dzMz3yvQHsv4K9Ci/hM3LzU39IIq7dBZIID1ds=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GI4AM1IEjtRRHUsRlf1q9v4DPnOOFbQG6yRIchtC9G7LKeuZsgAaaKJPBLVdWPiKbiSBteF1BnDjs2Sxi3sNQ9aOCi1801kWgfmLt/M5AEDFDbQYeY71exC59HjNWaUXOJ/PcAKqsNtA7M/345BCWfqYTr+YEmCpS3jTIqUrF6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qtRzuUk6; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <02dcf1f8-3ba4-4f79-897c-bf5a5007cc70@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756392379;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b8PthrC++MOSlrv7bkdtiRB5JHjJXN0lEZacyQBasz0=;
	b=qtRzuUk6IhZLglDYu/vReodTya+HHtrLBt3MnGXtLYy1EU8REo8m0ixf0vQA8eYYvWNEav
	IOROEaFmgntmIWYUN1BjoN29pKWVvA8xDo7p+J8wj0ZEJTGZUieYJKZpiEdUw5fMZVjH0K
	1F3KIB4Elw/VkLAdAqfOKgs19cMxLYY=
Date: Thu, 28 Aug 2025 15:46:13 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v02 01/14] hinic3: HW initialization
To: Fan Gong <gongfan1@huawei.com>, Zhu Yikai <zhuyikai1@h-partners.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
 Bjorn Helgaas <helgaas@kernel.org>, luosifu <luosifu@huawei.com>,
 Xin Guo <guoxin09@huawei.com>, Shen Chenyang <shenchenyang1@hisilicon.com>,
 Zhou Shuai <zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>,
 Shi Jing <shijing34@huawei.com>, Meny Yossefi <meny.yossefi@huawei.com>,
 Gur Stavi <gur.stavi@huawei.com>, Lee Trager <lee@trager.us>,
 Michael Ellerman <mpe@ellerman.id.au>, Suman Ghosh <sumang@marvell.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Joe Damato <jdamato@fastly.com>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>
References: <cover.1756378721.git.zhuyikai1@h-partners.com>
 <301829ef1f10086b0407164b4fe04adc9d05da04.1756378721.git.zhuyikai1@h-partners.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <301829ef1f10086b0407164b4fe04adc9d05da04.1756378721.git.zhuyikai1@h-partners.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 28/08/2025 13:10, Fan Gong wrote:
> Add the hardware resource data structures, functions for HW initialization,
> configuration and releasement.
> 
> Co-developed-by: Xin Guo <guoxin09@huawei.com>
> Signed-off-by: Xin Guo <guoxin09@huawei.com>
> Co-developed-by: Zhu Yikai <zhuyikai1@h-partners.com>
> Signed-off-by: Zhu Yikai <zhuyikai1@h-partners.com>
> Signed-off-by: Fan Gong <gongfan1@huawei.com>
> ---
>   .../net/ethernet/huawei/hinic3/hinic3_hwdev.c |  53 +++-
>   .../net/ethernet/huawei/hinic3/hinic3_hwif.c  | 227 ++++++++++++++++++
>   .../net/ethernet/huawei/hinic3/hinic3_hwif.h  |  13 +
>   .../net/ethernet/huawei/hinic3/hinic3_lld.c   |   3 +-
>   .../huawei/hinic3/hinic3_pci_id_tbl.h         |   9 +
>   5 files changed, 301 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.c b/drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.c
> index 6e8788a64925..5bd5745f4b96 100644
> --- a/drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.c
> +++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.c

[...]

> +/* Init attr struct from HW attr values. */
> +static void init_hwif_attr(struct hinic3_func_attr *attr, u32 attr0, u32 attr1,
> +			   u32 attr2, u32 attr3, u32 attr6)
> +{
> +	attr->func_global_idx = HINIC3_AF0_GET(attr0, FUNC_GLOBAL_IDX);
> +	attr->port_to_port_idx = HINIC3_AF0_GET(attr0, P2P_IDX);
> +	attr->pci_intf_idx = HINIC3_AF0_GET(attr0, PCI_INTF_IDX);
> +	attr->func_type = HINIC3_AF0_GET(attr0, FUNC_TYPE);
> +
> +	attr->num_aeqs = BIT(HINIC3_AF1_GET(attr1, AEQS_PER_FUNC));
> +	attr->num_ceqs = HINIC3_AF2_GET(attr2, CEQS_PER_FUNC);
> +	attr->num_irqs = HINIC3_AF2_GET(attr2, IRQS_PER_FUNC);
> +	if (attr->num_irqs > HINIC3_MAX_MSIX_ENTRY)
> +		attr->num_irqs = HINIC3_MAX_MSIX_ENTRY;
> +
> +	attr->num_sq = HINIC3_AF6_GET(attr6, FUNC_MAX_SQ);
> +	attr->msix_flex_en = HINIC3_AF6_GET(attr6, MSIX_FLEX_EN);
> +}
> +
> +/* Get device attributes from HW. */
> +static int get_hwif_attr(struct hinic3_hwdev *hwdev)
> +{
> +	u32 attr0, attr1, attr2, attr3, attr6;
> +	struct hinic3_hwif *hwif;
> +
> +	hwif = hwdev->hwif;
> +	attr0  = hinic3_hwif_read_reg(hwif, HINIC3_CSR_FUNC_ATTR0_ADDR);
> +	attr1  = hinic3_hwif_read_reg(hwif, HINIC3_CSR_FUNC_ATTR1_ADDR);
> +	attr2  = hinic3_hwif_read_reg(hwif, HINIC3_CSR_FUNC_ATTR2_ADDR);
> +	attr3  = hinic3_hwif_read_reg(hwif, HINIC3_CSR_FUNC_ATTR3_ADDR);
> +	attr6  = hinic3_hwif_read_reg(hwif, HINIC3_CSR_FUNC_ATTR6_ADDR);
> +	init_hwif_attr(&hwif->attr, attr0, attr1, attr2, attr3, attr6);

well, get_hwif_attr() name is misleading here, as the function doesn't
only read values, it also sets some of them. if there is no other users
of init function, it might be better to merge them.

> +
> +	return 0;

there is no way the function can return error - what's the reason to
have return value?



