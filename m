Return-Path: <netdev+bounces-152926-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 898B49F6576
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 13:01:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9CE716E660
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 12:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94D6619C569;
	Wed, 18 Dec 2024 12:01:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98691791F4;
	Wed, 18 Dec 2024 12:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734523277; cv=none; b=WxoZnv4y1beuFrY6iGYsmMFZaOQUSWi4uR49IAaZwd1mCInAiUsGfqO6ObXlCxkCRTbst1pFYDXXx3njwY4AfQP6hh7uMHtBn0lUXsh1LeEnOsdxX5Yi/rHkJUUPjnNQv2ih5jcmkyz7yJ4m1vvINwIlzvfe86YI5sQu/2joGhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734523277; c=relaxed/simple;
	bh=Yhew3BO//OLdbaQh+tpPO1alImO3BqxzpbQlzz5xlWY=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=rTgA25slN+lumYKbH9VA2MDa2IUZY/NV6zynny6YeqFSmQ/yiIsKnU67XOpP80Rz+vNJXpd1VlUj9KW0eAW5zy45SIqoVTD/EbaPPxu4uUyHmz84KZUWOsZuak7bruhasG2Ag2LaHagLeeyAsNoXc72/OtCuZtWJvkhSlUzK7cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4YCsfc0RDmz21njD;
	Wed, 18 Dec 2024 19:59:20 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 8357A1A016C;
	Wed, 18 Dec 2024 20:01:12 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 18 Dec 2024 20:01:11 +0800
Message-ID: <a11f655f-c6cf-4ddc-80a3-ff17f6720fe3@huawei.com>
Date: Wed, 18 Dec 2024 20:01:10 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 3/3] net: hisilicon: hns: Remove reset helpers
To: <linux@treblig.org>, <salil.mehta@huawei.com>, <shenjian15@huawei.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
References: <20241218005729.244987-1-linux@treblig.org>
 <20241218005729.244987-4-linux@treblig.org>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <20241218005729.244987-4-linux@treblig.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemk100013.china.huawei.com (7.202.194.61)


on 2024/12/18 8:57, linux@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
>
> With hns_dsaf_roce_reset() removed in a previous patch, the two
> helper member pointers, 'hns_dsaf_roce_srst',  and 'hns_dsaf_srst_chns'
> are now unread.
>
> Remove them, and the helper functions that they were initialised
> to, that is hns_dsaf_srst_chns(), hns_dsaf_srst_chns_acpi(),
> hns_dsaf_roce_srst() and hns_dsaf_roce_srst_acpi().

Thanks,
Reviewed-by: Jijie Shao<shaojijie@huawei.com>

>
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> ---
>   .../ethernet/hisilicon/hns/hns_dsaf_main.h    |  3 -
>   .../ethernet/hisilicon/hns/hns_dsaf_misc.c    | 67 -------------------
>   2 files changed, 70 deletions(-)
>
> diff --git a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.h b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.h
> index c90f41c75500..bb8267aafc43 100644
> --- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.h
> +++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.h
> @@ -307,9 +307,6 @@ struct dsaf_misc_op {
>   	void (*ge_srst)(struct dsaf_device *dsaf_dev, u32 port, bool dereset);
>   	void (*ppe_srst)(struct dsaf_device *dsaf_dev, u32 port, bool dereset);
>   	void (*ppe_comm_srst)(struct dsaf_device *dsaf_dev, bool dereset);
> -	void (*hns_dsaf_srst_chns)(struct dsaf_device *dsaf_dev, u32 msk,
> -				   bool dereset);
> -	void (*hns_dsaf_roce_srst)(struct dsaf_device *dsaf_dev, bool dereset);
>   
>   	phy_interface_t (*get_phy_if)(struct hns_mac_cb *mac_cb);
>   	int (*get_sfp_prsnt)(struct hns_mac_cb *mac_cb, int *sfp_prsnt);
> diff --git a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_misc.c b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_misc.c
> index 5df19c604d09..91391a49fcea 100644
> --- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_misc.c
> +++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_misc.c
> @@ -326,69 +326,6 @@ static void hns_dsaf_xge_srst_by_port_acpi(struct dsaf_device *dsaf_dev,
>   				   HNS_XGE_RESET_FUNC, port, dereset);
>   }
>   
> -/**
> - * hns_dsaf_srst_chns - reset dsaf channels
> - * @dsaf_dev: dsaf device struct pointer
> - * @msk: xbar channels mask value:
> - * @dereset: false - request reset , true - drop reset
> - *
> - * bit0-5 for xge0-5
> - * bit6-11 for ppe0-5
> - * bit12-17 for roce0-5
> - * bit18-19 for com/dfx
> - */
> -static void
> -hns_dsaf_srst_chns(struct dsaf_device *dsaf_dev, u32 msk, bool dereset)
> -{
> -	u32 reg_addr;
> -
> -	if (!dereset)
> -		reg_addr = DSAF_SUB_SC_DSAF_RESET_REQ_REG;
> -	else
> -		reg_addr = DSAF_SUB_SC_DSAF_RESET_DREQ_REG;
> -
> -	dsaf_write_sub(dsaf_dev, reg_addr, msk);
> -}
> -
> -/**
> - * hns_dsaf_srst_chns_acpi - reset dsaf channels
> - * @dsaf_dev: dsaf device struct pointer
> - * @msk: xbar channels mask value:
> - * @dereset: false - request reset , true - drop reset
> - *
> - * bit0-5 for xge0-5
> - * bit6-11 for ppe0-5
> - * bit12-17 for roce0-5
> - * bit18-19 for com/dfx
> - */
> -static void
> -hns_dsaf_srst_chns_acpi(struct dsaf_device *dsaf_dev, u32 msk, bool dereset)
> -{
> -	hns_dsaf_acpi_srst_by_port(dsaf_dev, HNS_OP_RESET_FUNC,
> -				   HNS_DSAF_CHN_RESET_FUNC,
> -				   msk, dereset);
> -}
> -
> -static void hns_dsaf_roce_srst(struct dsaf_device *dsaf_dev, bool dereset)
> -{
> -	if (!dereset) {
> -		dsaf_write_sub(dsaf_dev, DSAF_SUB_SC_ROCEE_RESET_REQ_REG, 1);
> -	} else {
> -		dsaf_write_sub(dsaf_dev,
> -			       DSAF_SUB_SC_ROCEE_CLK_DIS_REG, 1);
> -		dsaf_write_sub(dsaf_dev,
> -			       DSAF_SUB_SC_ROCEE_RESET_DREQ_REG, 1);
> -		msleep(20);
> -		dsaf_write_sub(dsaf_dev, DSAF_SUB_SC_ROCEE_CLK_EN_REG, 1);
> -	}
> -}
> -
> -static void hns_dsaf_roce_srst_acpi(struct dsaf_device *dsaf_dev, bool dereset)
> -{
> -	hns_dsaf_acpi_srst_by_port(dsaf_dev, HNS_OP_RESET_FUNC,
> -				   HNS_ROCE_RESET_FUNC, 0, dereset);
> -}
> -
>   static void hns_dsaf_ge_srst_by_port(struct dsaf_device *dsaf_dev, u32 port,
>   				     bool dereset)
>   {
> @@ -729,8 +666,6 @@ struct dsaf_misc_op *hns_misc_op_get(struct dsaf_device *dsaf_dev)
>   		misc_op->ge_srst = hns_dsaf_ge_srst_by_port;
>   		misc_op->ppe_srst = hns_ppe_srst_by_port;
>   		misc_op->ppe_comm_srst = hns_ppe_com_srst;
> -		misc_op->hns_dsaf_srst_chns = hns_dsaf_srst_chns;
> -		misc_op->hns_dsaf_roce_srst = hns_dsaf_roce_srst;
>   
>   		misc_op->get_phy_if = hns_mac_get_phy_if;
>   		misc_op->get_sfp_prsnt = hns_mac_get_sfp_prsnt;
> @@ -746,8 +681,6 @@ struct dsaf_misc_op *hns_misc_op_get(struct dsaf_device *dsaf_dev)
>   		misc_op->ge_srst = hns_dsaf_ge_srst_by_port_acpi;
>   		misc_op->ppe_srst = hns_ppe_srst_by_port_acpi;
>   		misc_op->ppe_comm_srst = hns_ppe_com_srst;
> -		misc_op->hns_dsaf_srst_chns = hns_dsaf_srst_chns_acpi;
> -		misc_op->hns_dsaf_roce_srst = hns_dsaf_roce_srst_acpi;
>   
>   		misc_op->get_phy_if = hns_mac_get_phy_if_acpi;
>   		misc_op->get_sfp_prsnt = hns_mac_get_sfp_prsnt_acpi;

