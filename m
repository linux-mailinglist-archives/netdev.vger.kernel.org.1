Return-Path: <netdev+bounces-119522-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF6C29560B4
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 03:05:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E60BB216A6
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 01:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B697C14263;
	Mon, 19 Aug 2024 01:05:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902CEC125
	for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 01:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724029528; cv=none; b=hxeHLrCQE5r+lR6CIjKxj5thNGS+F2xPn5+B9eguOgjrldkkbhcU4qVlGYtmryt0+a9x4ird+SQlgsXl526FwAFgB49fqnX+fipPWyt23iceJofhIRcfw6AzLd99bnTFRbx97KOGdPXWBJkqpH7xtwqjdVxv3K1Vwbo7C29N5rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724029528; c=relaxed/simple;
	bh=k+ebDdHaclAH5unn6Y2FicpNFm3XOHGfQHosCFXDIDI=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Rn7dsKg+ucZIhZNP2BX+KvdrZNrAmMmFvk0X1QfVTAO84TvGn76EidGN4+MJmBG4wVIqPecg2QxxoxucBNHJ90U2yOrhquYr3jV92I3NavwQqhE98TiqrpacgV2eImac8G1VQSCxnDhoX2E5iD0R8Ha8IGEtEhoBGmwD52YfNZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4WnDsC6485z13PJc;
	Mon, 19 Aug 2024 09:04:47 +0800 (CST)
Received: from kwepemm000007.china.huawei.com (unknown [7.193.23.189])
	by mail.maildlp.com (Postfix) with ESMTPS id 9CC801800F2;
	Mon, 19 Aug 2024 09:05:23 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 19 Aug 2024 09:05:22 +0800
Message-ID: <fad57299-7a79-4073-8f83-410e32e28a48@huawei.com>
Date: Mon, 19 Aug 2024 09:05:22 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>
Subject: Re: [PATCH net-next] net: hns3: Use ARRAY_SIZE() to improve
 readability
To: Zhang Zekun <zhangzekun11@huawei.com>, <yisen.zhuang@huawei.com>,
	<salil.mehta@huawei.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>
References: <20240818052518.45489-1-zhangzekun11@huawei.com>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <20240818052518.45489-1-zhangzekun11@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm000007.china.huawei.com (7.193.23.189)

on 2024/8/18 13:25, Zhang Zekun wrote:
> There is a helper function ARRAY_SIZE() to help calculating the
> u32 array size, and we don't need to do it mannually. So, let's
> use ARRAY_SIZE() to calculate the array size, and improve the code
> readability.
>
> Signed-off-by: Zhang Zekun <zhangzekun11@huawei.com>

Reviewed-by: Jijie Shao<shaojijie@huawei.com>

	Jijie Shao

> ---
>   drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_regs.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_regs.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_regs.c
> index 65b9dcd38137..6db415d8b917 100644
> --- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_regs.c
> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_regs.c
> @@ -134,17 +134,17 @@ void hclgevf_get_regs(struct hnae3_handle *handle, u32 *version,
>   	reg += hclgevf_reg_get_header(reg);
>   
>   	/* fetching per-VF registers values from VF PCIe register space */
> -	reg_um = sizeof(cmdq_reg_addr_list) / sizeof(u32);
> +	reg_um = ARRAY_SIZE(cmdq_reg_addr_list);
>   	reg += hclgevf_reg_get_tlv(HCLGEVF_REG_TAG_CMDQ, reg_um, reg);
>   	for (i = 0; i < reg_um; i++)
>   		*reg++ = hclgevf_read_dev(&hdev->hw, cmdq_reg_addr_list[i]);
>   
> -	reg_um = sizeof(common_reg_addr_list) / sizeof(u32);
> +	reg_um = ARRAY_SIZE(common_reg_addr_list);
>   	reg += hclgevf_reg_get_tlv(HCLGEVF_REG_TAG_COMMON, reg_um, reg);
>   	for (i = 0; i < reg_um; i++)
>   		*reg++ = hclgevf_read_dev(&hdev->hw, common_reg_addr_list[i]);
>   
> -	reg_um = sizeof(ring_reg_addr_list) / sizeof(u32);
> +	reg_um = ARRAY_SIZE(ring_reg_addr_list);
>   	for (j = 0; j < hdev->num_tqps; j++) {
>   		reg += hclgevf_reg_get_tlv(HCLGEVF_REG_TAG_RING, reg_um, reg);
>   		for (i = 0; i < reg_um; i++)
> @@ -153,7 +153,7 @@ void hclgevf_get_regs(struct hnae3_handle *handle, u32 *version,
>   						  HCLGEVF_RING_REG_OFFSET * j);
>   	}
>   
> -	reg_um = sizeof(tqp_intr_reg_addr_list) / sizeof(u32);
> +	reg_um = ARRAY_SIZE(tqp_intr_reg_addr_list);
>   	for (j = 0; j < hdev->num_msi_used - 1; j++) {
>   		reg += hclgevf_reg_get_tlv(HCLGEVF_REG_TAG_TQP_INTR, reg_um, reg);
>   		for (i = 0; i < reg_um; i++)

