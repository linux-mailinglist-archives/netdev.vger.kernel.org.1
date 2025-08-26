Return-Path: <netdev+bounces-216962-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04997B369C2
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 16:30:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9298F5815E2
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 14:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F0A1356914;
	Tue, 26 Aug 2025 14:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VmEZTJ7K"
X-Original-To: netdev@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D422C0F60
	for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 14:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756217877; cv=none; b=RIeR3izpzQS5wZXKM7HcE4H5Z3bo1/upGAdtOikWPKFxfJ2mdpQn/NFObk2esDDYZSN/j6fMBXpfqOMg6WUL/fGZIRY6MBw9iTv/Q/TZrGKnpextvSYvvMryrnn0O8SAlILVyz421OvGbWGmOkDmZE9ZhzgEcLWQksuWdwxCJ3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756217877; c=relaxed/simple;
	bh=vAFqRkUVU9nLETZfB79IylLrMizQW+Ict1VoMM7PA8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cGnLWIYhxhaVTRhatl4Vq4sV+a6f/g1TlpNlkNJXPG80nsgPESy6eHYXwbgWocu4ACqe68Dpb9W9FxVdrW1oA8IjEdDxrPYukMDgDtuS51e4oNxBrG8wamcMNghwLMcOegJBG7DxAUKjo7DtwYQP2c99ouIViUCWe25dcDxjlnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VmEZTJ7K; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <66f3bae8-a386-4205-97b2-7c75bc2ac378@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756217872;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cfxa6V11+XKXn5kTcarhix2gi4YAWPXrw99RS4I7v7E=;
	b=VmEZTJ7KSXpFbz7WQgz0lsknA09EhZ1lQco7D88dCcQkDOqPgSmbxn+t9meYZf84jXZ/00
	m0oA21tzCPQZYk+EMz4QgaLTsXyLmtRrgYyAhsqOaj89s8AYhraz2jRSw/FrIKE1qohl2k
	8eLtRiRNVGyvPY1fPb1MOAJNpm892Yc=
Date: Tue, 26 Aug 2025 15:17:28 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v01 04/12] hinic3: HW capability initialization
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
References: <cover.1756195078.git.zhuyikai1@h-partners.com>
 <b0c4ffc4ed52ca0921dc029e6f2fc8459a5df933.1756195078.git.zhuyikai1@h-partners.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <b0c4ffc4ed52ca0921dc029e6f2fc8459a5df933.1756195078.git.zhuyikai1@h-partners.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 26/08/2025 10:05, Fan Gong wrote:
> Use mailbox to get device capability for initializing driver capability.
> 
> Co-developed-by: Xin Guo <guoxin09@huawei.com>
> Signed-off-by: Xin Guo <guoxin09@huawei.com>
> Co-developed-by: Zhu Yikai <zhuyikai1@h-partners.com>
> Signed-off-by: Zhu Yikai <zhuyikai1@h-partners.com>
> Signed-off-by: Fan Gong <gongfan1@huawei.com>
> ---
>   .../ethernet/huawei/hinic3/hinic3_hw_cfg.c    | 66 +++++++++++++++++++
>   .../ethernet/huawei/hinic3/hinic3_hw_cfg.h    |  1 +
>   .../ethernet/huawei/hinic3/hinic3_hw_intf.h   | 42 ++++++++++++
>   .../net/ethernet/huawei/hinic3/hinic3_hwdev.c |  6 ++
>   4 files changed, 115 insertions(+)
> 
> diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hw_cfg.c b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_cfg.c
> index e7ef450c4971..24b929690f64 100644
> --- a/drivers/net/ethernet/huawei/hinic3/hinic3_hw_cfg.c
> +++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_cfg.c
> @@ -8,6 +8,67 @@
>   #include "hinic3_hwif.h"
>   #include "hinic3_mbox.h"
>   
> +#define HINIC3_CFG_MAX_QP  256
> +
> +static void parse_pub_res_cap(struct hinic3_hwdev *hwdev,
> +			      struct hinic3_dev_cap *cap,
> +			      const struct cfg_cmd_dev_cap *dev_cap,
> +			      enum hinic3_func_type type)
> +{
> +	cap->port_id = dev_cap->port_id;
> +	cap->supp_svcs_bitmap = dev_cap->svc_cap_en;
> +}
> +
> +static void parse_l2nic_res_cap(struct hinic3_hwdev *hwdev,
> +				struct hinic3_dev_cap *cap,
> +				const struct cfg_cmd_dev_cap *dev_cap,
> +				enum hinic3_func_type type)
> +{
> +	struct hinic3_nic_service_cap *nic_svc_cap = &cap->nic_svc_cap;
> +
> +	nic_svc_cap->max_sqs = min(dev_cap->nic_max_sq_id + 1,
> +				   HINIC3_CFG_MAX_QP);
> +}
> +
> +static void parse_dev_cap(struct hinic3_hwdev *hwdev,
> +			  const struct cfg_cmd_dev_cap *dev_cap,
> +			  enum hinic3_func_type type)
> +{
> +	struct hinic3_dev_cap *cap = &hwdev->cfg_mgmt->cap;
> +
> +	/* Public resource */
> +	parse_pub_res_cap(hwdev, cap, dev_cap, type);
> +
> +	/* L2 NIC resource */
> +	if (hinic3_support_nic(hwdev))
> +		parse_l2nic_res_cap(hwdev, cap, dev_cap, type);
> +}

Could you please prepend local functions with the scope (hinic3) to be
consistent with naming? Some of functions have pretty common name and
may potentially overlap with some core functions.

> +
> +static int get_cap_from_fw(struct hinic3_hwdev *hwdev,
> +			   enum hinic3_func_type type)
> +{
> +	struct mgmt_msg_params msg_params = {};
> +	struct cfg_cmd_dev_cap dev_cap = {};
> +	int err;
> +
> +	dev_cap.func_id = hinic3_global_func_id(hwdev);
> +
> +	mgmt_msg_params_init_default(&msg_params, &dev_cap, sizeof(dev_cap));
> +
> +	err = hinic3_send_mbox_to_mgmt(hwdev, MGMT_MOD_CFGM,
> +				       CFG_CMD_GET_DEV_CAP, &msg_params);
> +	if (err || dev_cap.head.status) {
> +		dev_err(hwdev->dev,
> +			"Failed to get capability from FW, err: %d, status: 0x%x\n",
> +			err, dev_cap.head.status);
> +		return -EIO;
> +	}
> +
> +	parse_dev_cap(hwdev, &dev_cap, type);
> +
> +	return 0;
> +}
> +
>   static int hinic3_init_irq_info(struct hinic3_hwdev *hwdev)
>   {
>   	struct hinic3_cfg_mgmt_info *cfg_mgmt = hwdev->cfg_mgmt;
> @@ -180,6 +241,11 @@ void hinic3_free_irq(struct hinic3_hwdev *hwdev, u32 irq_id)
>   	mutex_unlock(&irq_info->irq_mutex);
>   }
>   
> +int init_capability(struct hinic3_hwdev *hwdev)
> +{
> +	return get_cap_from_fw(hwdev, HINIC3_FUNC_TYPE_VF);
> +}
> +
>   bool hinic3_support_nic(struct hinic3_hwdev *hwdev)
>   {
>   	return hwdev->cfg_mgmt->cap.supp_svcs_bitmap &
> diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hw_cfg.h b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_cfg.h
> index 5978cbd56fb2..8900b40e3c42 100644
> --- a/drivers/net/ethernet/huawei/hinic3/hinic3_hw_cfg.h
> +++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_cfg.h
> @@ -49,6 +49,7 @@ int hinic3_alloc_irqs(struct hinic3_hwdev *hwdev, u16 num,
>   		      struct msix_entry *alloc_arr, u16 *act_num);
>   void hinic3_free_irq(struct hinic3_hwdev *hwdev, u32 irq_id);
>   
> +int init_capability(struct hinic3_hwdev *hwdev);

and especially non-static functions has to be prefixed with the
scope, please

>   bool hinic3_support_nic(struct hinic3_hwdev *hwdev);
>   u16 hinic3_func_max_qnum(struct hinic3_hwdev *hwdev);
>   u8 hinic3_physical_port_id(struct hinic3_hwdev *hwdev);

[...]

