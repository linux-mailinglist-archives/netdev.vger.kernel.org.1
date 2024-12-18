Return-Path: <netdev+bounces-152871-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D57A49F61D4
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 10:34:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C7271896B0F
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 09:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ECC0199EBB;
	Wed, 18 Dec 2024 09:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F5XLtjuF"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968D91547FF;
	Wed, 18 Dec 2024 09:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734514336; cv=none; b=JfIdFdUZ2Ie8HZpaiZhpa1tWAKFLkXc10cw+s9Tj0zi5CHtgXRerupFTl8Hx0HiB3C5y905tyOAn6ymhbyKxA1kUyoHBpKQplV9/nKumNlYKCJZmF33sSAjk8bWKG15n2gXPAKsU1wIuaTzfLjKFtO2QO6u/ilB5TVQrsDVWViw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734514336; c=relaxed/simple;
	bh=0BHwrGK6MWavc8faxQG4PkgQjG5/SJe2jLaGOPWwlnU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YABYZZR7FcOyysJAB9qnvFK0Mrg4TiI1LeukB1R3Zs5zeWu0zQBSoSMkVeHBC7jKtSqmqq1ZPPsyuwWdw9gJOcMlF7kEEfVjqDkGCsSeXlu8VV+T7CyVCym1/t1IoQJSvgVGS0pnU1KLI4unQzTXlH2tSnAGVeLXTOAX1/oAV2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F5XLtjuF; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734514335; x=1766050335;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0BHwrGK6MWavc8faxQG4PkgQjG5/SJe2jLaGOPWwlnU=;
  b=F5XLtjuF9fV94b+pd6dG87hG7Gu8NLKv1soPIdGNNWEcOYXKNfauL/7l
   GkrZS2FQ7D/FoErNKtUpYmYL1PAf1mbUjq94yvkPC5hO3kX7gHbdymVnU
   9YbK12eaVpgXlOKsTtN9rD1xh1jcTO049nYl6zxQS1NzJMyXlkJD6tT1+
   skl/EnCR5evssbdIUGz6loRmVpWx2YO0CRrJMM0dHBmoMtKLSO3TEebeN
   dJQdrJYFFx4VyUbeU5o59B/ZNbLpqb/Wxx1kDZP581xHyIUFrstwFGHA+
   bLDwlDpSiJbXmlit6HsG4bB9zk5rAdt2slNnkH2KofwAwGTgg2HCoH/Fg
   w==;
X-CSE-ConnectionGUID: kbqMsFuaREy+FWippgyyFw==
X-CSE-MsgGUID: fte/KoYOSouu4GDxAP33vg==
X-IronPort-AV: E=McAfee;i="6700,10204,11289"; a="34265520"
X-IronPort-AV: E=Sophos;i="6.12,244,1728975600"; 
   d="scan'208";a="34265520"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2024 01:32:14 -0800
X-CSE-ConnectionGUID: S/t1ptD7QXmfffVp3d2T4A==
X-CSE-MsgGUID: WQmvdnBcSnSp955bZJrB3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="97652226"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2024 01:32:10 -0800
Date: Wed, 18 Dec 2024 10:29:03 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	shenjian15@huawei.com, wangpeiyang1@huawei.com,
	liuyonglong@huawei.com, chenhao418@huawei.com,
	jonathan.cameron@huawei.com, shameerali.kolothum.thodi@huawei.com,
	salil.mehta@huawei.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND V2 net 6/7] net: hns3: fixed hclge_fetch_pf_reg
 accesses bar space out of bounds issue
Message-ID: <Z2KV37WZL7cpPYKk@mev-dev.igk.intel.com>
References: <20241217010839.1742227-1-shaojijie@huawei.com>
 <20241217010839.1742227-7-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241217010839.1742227-7-shaojijie@huawei.com>

On Tue, Dec 17, 2024 at 09:08:38AM +0800, Jijie Shao wrote:
> From: Hao Lan <lanhao@huawei.com>
> 
> The TQP BAR space is divided into two segments. TQPs 0-1023 and TQPs
> 1024-1279 are in different BAR space addresses. However,
> hclge_fetch_pf_reg does not distinguish the tqp space information when
> reading the tqp space information. When the number of TQPs is greater
> than 1024, access bar space overwriting occurs.
> The problem of different segments has been considered during the
> initialization of tqp.io_base. Therefore, tqp.io_base is directly used
> when the queue is read in hclge_fetch_pf_reg.
> 
> The error message:
> 
> Unable to handle kernel paging request at virtual address ffff800037200000
> pc : hclge_fetch_pf_reg+0x138/0x250 [hclge]
> lr : hclge_get_regs+0x84/0x1d0 [hclge]
> Call trace:
>  hclge_fetch_pf_reg+0x138/0x250 [hclge]
>  hclge_get_regs+0x84/0x1d0 [hclge]
>  hns3_get_regs+0x2c/0x50 [hns3]
>  ethtool_get_regs+0xf4/0x270
>  dev_ethtool+0x674/0x8a0
>  dev_ioctl+0x270/0x36c
>  sock_do_ioctl+0x110/0x2a0
>  sock_ioctl+0x2ac/0x530
>  __arm64_sys_ioctl+0xa8/0x100
>  invoke_syscall+0x4c/0x124
>  el0_svc_common.constprop.0+0x140/0x15c
>  do_el0_svc+0x30/0xd0
>  el0_svc+0x1c/0x2c
>  el0_sync_handler+0xb0/0xb4
>  el0_sync+0x168/0x180
> 
> Fixes: 939ccd107ffc ("net: hns3: move dump regs function to a separate file")
> Signed-off-by: Hao Lan <lanhao@huawei.com>
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
>  drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_regs.c  | 9 +++++----
>  .../net/ethernet/hisilicon/hns3/hns3vf/hclgevf_regs.c    | 9 +++++----
>  2 files changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_regs.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_regs.c
> index 43c1c18fa81f..8c057192aae6 100644
> --- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_regs.c
> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_regs.c
> @@ -510,9 +510,9 @@ static int hclge_get_dfx_reg(struct hclge_dev *hdev, void *data)
>  static int hclge_fetch_pf_reg(struct hclge_dev *hdev, void *data,
>  			      struct hnae3_knic_private_info *kinfo)
>  {
> -#define HCLGE_RING_REG_OFFSET		0x200
>  #define HCLGE_RING_INT_REG_OFFSET	0x4
>  
> +	struct hnae3_queue *tqp;
>  	int i, j, reg_num;
>  	int data_num_sum;
>  	u32 *reg = data;
> @@ -533,10 +533,11 @@ static int hclge_fetch_pf_reg(struct hclge_dev *hdev, void *data,
>  	reg_num = ARRAY_SIZE(ring_reg_addr_list);
>  	for (j = 0; j < kinfo->num_tqps; j++) {
You can define struct hnae3_queue *tqp here to limit the scope
(same in VF case).
>  		reg += hclge_reg_get_tlv(HCLGE_REG_TAG_RING, reg_num, reg);
> +		tqp = kinfo->tqp[j];
>  		for (i = 0; i < reg_num; i++)
> -			*reg++ = hclge_read_dev(&hdev->hw,
> -						ring_reg_addr_list[i] +
> -						HCLGE_RING_REG_OFFSET * j);
> +			*reg++ = readl_relaxed(tqp->io_base -
> +					       HCLGE_TQP_REG_OFFSET +
> +					       ring_reg_addr_list[i]);
>  	}
>  	data_num_sum += (reg_num + HCLGE_REG_TLV_SPACE) * kinfo->num_tqps;
>  
> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_regs.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_regs.c
> index 6db415d8b917..7d9d9dbc7560 100644
> --- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_regs.c
> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_regs.c
> @@ -123,10 +123,10 @@ int hclgevf_get_regs_len(struct hnae3_handle *handle)
>  void hclgevf_get_regs(struct hnae3_handle *handle, u32 *version,
>  		      void *data)
>  {
> -#define HCLGEVF_RING_REG_OFFSET		0x200
>  #define HCLGEVF_RING_INT_REG_OFFSET	0x4
>  
>  	struct hclgevf_dev *hdev = hclgevf_ae_get_hdev(handle);
> +	struct hnae3_queue *tqp;
>  	int i, j, reg_um;
>  	u32 *reg = data;
>  
> @@ -147,10 +147,11 @@ void hclgevf_get_regs(struct hnae3_handle *handle, u32 *version,
>  	reg_um = ARRAY_SIZE(ring_reg_addr_list);
>  	for (j = 0; j < hdev->num_tqps; j++) {
>  		reg += hclgevf_reg_get_tlv(HCLGEVF_REG_TAG_RING, reg_um, reg);
> +		tqp = &hdev->htqp[j].q;
>  		for (i = 0; i < reg_um; i++)
> -			*reg++ = hclgevf_read_dev(&hdev->hw,
> -						  ring_reg_addr_list[i] +
> -						  HCLGEVF_RING_REG_OFFSET * j);
> +			*reg++ = readl_relaxed(tqp->io_base -
> +					       HCLGEVF_TQP_REG_OFFSET +
> +					       ring_reg_addr_list[i]);
>  	}
>  
>  	reg_um = ARRAY_SIZE(tqp_intr_reg_addr_list);
> -- 
> 2.33.0

