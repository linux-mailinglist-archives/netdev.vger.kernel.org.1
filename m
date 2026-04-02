Return-Path: <netdev+bounces-274437-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ACuKDiQyzmnIlQYAu9opvQ
	(envelope-from <netdev+bounces-274437-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 11:08:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 89C7F3867F8
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 11:08:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 33FA830125D3
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 09:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9907730E0DC;
	Thu,  2 Apr 2026 09:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ckz/j4Pf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B007F3FBA7
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 09:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775120707; cv=none; b=vGvqritbW1Lt+zbM9ynkQ3TnB3oCqiBv171OtOWM0sPYsn2J3nsHgcFRZiEnjyfghxvUOt7ZUQjfTlgwHoOXhircQAKxa/iIYRBzlLJoN5oSsCA/y1wdzL/NPhZTfNXXhou4LlYZjz5y46LZ+vmL8NUiKi09GO2r40tcyV4mQ5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775120707; c=relaxed/simple;
	bh=WiaB3zVRkUUQVv4UOzlJHq/vmT7ModqjGOWaO0b1Qqg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mMFHzVjAMdmnmWx2WAepzOT5W+xJbqhzfPYd+qdexvm9BIUkn6RJrYRHPYRmuyL+9NKpB0cfdnk6xUSWvSc/PVJ7Fes21mXgWn9U8+n9UJv5xlTcUViTLJjLG2q/wOnY1x1kF2lfwEee/8ufuI817R4X3Z2uqvcTYe8CLr+LZAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ckz/j4Pf; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2ba895adfeaso817936eec.0
        for <netdev@vger.kernel.org>; Thu, 02 Apr 2026 02:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775120705; x=1775725505; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d414RhizLHjN9Hx07kfHIITWZFpVVnfcsqLX3OJK7hI=;
        b=ckz/j4PfPD2gmDmB7WqJmvceQX8Tdc7eeZFrc8lJ/7CMhEa4ARIgl/BlB36RAdbmFg
         pWSeyRRNU3Ef/cO8dLIZb0aY+Qtk4ziiCxhpNkJ+TFMduhK6ucf5FYZgS5uvOS2wJlyV
         aIaeKKaLizrV/8X/QiOiwjidqDFDlEJebk9MjIStYzvAqQi0zp7LtUyp/eamqQDE7g6P
         w1qBSN30obL/SEw1O300sc5UjamWTlun5MLKprB495+kHjeAwby4UhpcsUburyt3gIQb
         XNBJ0DYyzuwgAJGvLVybwhHsxzSrUuIdNbIVkkGLj+q8w+QpghZqVNE+H15I55mGkrIW
         Y8Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775120705; x=1775725505;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d414RhizLHjN9Hx07kfHIITWZFpVVnfcsqLX3OJK7hI=;
        b=jbfPKJehORerZH4QSnFgmT2UOW95rb7MT2ioEqj4Dg9YzpuuJQFo/Pu2b7fqTyAndH
         g1Hc/4H6aULbXtKeqHw8BQA1S9C7sy2bwdswd/gXdynUMnqWPnrwJUErPW+RJ6Xnz+SG
         ra6ccsRPyllLOqXM1YS9HWuVFaF3o3yVVW0FUABeEWZA/QFY4AsH9rHd2wR93S7mlF5o
         UsLUzjeUqBP1bRCKwO33Vu9d7a+j98QI9ZQ0xcDVCLdXJF8WPRVzV2ZgPbYfNnp7iinQ
         uqp2704e7D4Qf6vg8u8q581+sBfdA0Lm/hWafbyeOZfBwgJmLGRO7/gSbSN8iSaWD/YW
         HdKw==
X-Forwarded-Encrypted: i=1; AJvYcCUoFQ0iZUNTG2JG4PsyKqBh2XmJKDsaVRbwGudRYrHCxqpanHS5zanShGW6hTxC2Yz3cnjuLnQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqIjVf52KgC4d9N7r5XdN8DqPhr320jJI8UZk88Nsj3rEHyBI5
	LO64W0f7dqMH7EQ7ykCvCL8J3j4J/1NnTYWQDdfZHMTWd/JE5Oge5vrh
X-Gm-Gg: AeBDiesaTKw32IkAY/V2luxLgWZ7UJn6RyOFYsWWjQvjdNXPVupO7XajGPE3VDrl++J
	ic8hPKpYPI6wa8XJWfcvob8ha2oGLVXlAIMRTKRFUlBDHSg5j3NcLoxLrLCL3Qpboj8sAuoBXJD
	O8RCZBp29jDbdt5MFHS7m+viuBO9AhVy7tFwGMLXop9F6WKouxy3AfzGlHFYgxjyZaas8M/KhRG
	rklPw36IBKxZ7bOXVcynIzsMmhWLOqtSdHXKfWs8bl+Niqi5+h+dSbGwKP263gCFeM9bSfTpC+I
	92R4cme4AX+4Ke0nNDMo+lQXDufVf/KsrvwdoPyjUmaaxx4HX+glFGtMRqP2Zf7Lo3kCtv4/i8B
	d96fUVjmu8EwW25EWGaw/8PevOpI/EphoGFzC3Qf7N4fQGmL8gn+gOyqtEwtzwG0bFvVA412Vu0
	qnzkho0FybUnzr81ZfRkoV5GXVKlMKAv/QIaV6AdtoRD+uknfT7gm0La9PA65vUvMkaU1vtGw=
X-Received: by 2002:a05:7300:2211:b0:2c8:1d56:340c with SMTP id 5a478bee46e88-2c932aaa6a7mr3474815eec.23.1775120704687;
        Thu, 02 Apr 2026 02:05:04 -0700 (PDT)
Received: from ?IPV6:2620:10d:c085:21cf::147f? ([2620:10d:c090:400::5:9571])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ca7c20c0c2sm2116548eec.17.2026.04.02.02.05.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Apr 2026 02:05:04 -0700 (PDT)
Message-ID: <8d43c17e-3372-4a26-9010-dea944d14ecb@gmail.com>
Date: Thu, 2 Apr 2026 02:05:02 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 net-next 06/11] net/nebula-matrix: add common resource
 implementation
To: "illusion.wang" <illusion.wang@nebula-matrix.com>,
 dimon.zhao@nebula-matrix.com, alvin.wang@nebula-matrix.com,
 sam.chen@nebula-matrix.com, netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch, corbet@lwn.net, kuba@kernel.org,
 linux-doc@vger.kernel.org, lorenzo@kernel.org, pabeni@redhat.com,
 horms@kernel.org, vadim.fedorenko@linux.dev, lukas.bulwahn@redhat.com,
 edumazet@google.com, enelsonmoore@gmail.com, skhan@linuxfoundation.org,
 hkallweit1@gmail.com, jani.nikula@intel.com,
 open list <linux-kernel@vger.kernel.org>
References: <20260401022318.28550-1-illusion.wang@nebula-matrix.com>
 <20260401022318.28550-7-illusion.wang@nebula-matrix.com>
Content-Language: en-US
From: Mohsin Bashir <mohsin.bashr@gmail.com>
In-Reply-To: <20260401022318.28550-7-illusion.wang@nebula-matrix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,lwn.net,kernel.org,vger.kernel.org,redhat.com,linux.dev,google.com,gmail.com,linuxfoundation.org,intel.com];
	TAGGED_FROM(0.00)[bounces-274437-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mohsinbashr@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 89C7F3867F8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 3/31/26 7:23 PM, illusion.wang wrote:
> The Resource layer processes the entries/data of various modules within
> the processing chip to accomplish specific entry management operations,
> this describes the module business capabilities of the chip and the data
> it manages.
> The resource layer comprises the following sub-modules: common,
> interrupt, and vsi(txrx,queue not contained this time)
> 
> This patch provides the common part, including the conversion
> relationships among vsi_id, func_id, eth_id, and pf_id. These
> relationships may be utilized in the upper layer or the resource layer.
> 
> Signed-off-by: illusion.wang <illusion.wang@nebula-matrix.com>
> ---
>   .../net/ethernet/nebula-matrix/nbl/Makefile   |   1 +
>   .../nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c  |  55 ++++++
>   .../nbl_hw_leonis/nbl_resource_leonis.c       | 157 ++++++++++++++++++
>   .../nebula-matrix/nbl/nbl_hw/nbl_resource.c   | 110 ++++++++++++
>   .../nebula-matrix/nbl/nbl_hw/nbl_resource.h   |  52 ++++++
>   .../nbl/nbl_include/nbl_def_common.h          |  15 ++
>   .../nbl/nbl_include/nbl_def_resource.h        |  16 ++
>   .../nbl/nbl_include/nbl_include.h             |   8 +
>   8 files changed, 414 insertions(+)
>   create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.c
> 
> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/Makefile b/drivers/net/ethernet/nebula-matrix/nbl/Makefile
> index c9bc060732e7..b03c20f9988e 100644
> --- a/drivers/net/ethernet/nebula-matrix/nbl/Makefile
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/Makefile
> @@ -8,6 +8,7 @@ nbl-objs +=       nbl_common/nbl_common.o \
>   				nbl_hw/nbl_hw_leonis/nbl_hw_leonis.o \
>   				nbl_hw/nbl_hw_leonis/nbl_resource_leonis.o \
>   				nbl_hw/nbl_hw_leonis/nbl_hw_leonis_regs.o \
> +				nbl_hw/nbl_resource.o \
>   				nbl_core/nbl_dispatch.o \
>   				nbl_core/nbl_dev.o \
>   				nbl_main.o
> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
> index 83a4dc584f48..4ef0d5989a76 100644
> --- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
> @@ -9,6 +9,18 @@
>   #include <linux/spinlock.h>
>   #include "nbl_hw_leonis.h"
>   
> +static void nbl_hw_read_mbx_regs(struct nbl_hw_mgt *hw_mgt, u64 reg,
> +				 u32 *data, u32 len)
> +{
> +	u32 i;
> +
> +	if (len % 4)
> +		return;
> +
> +	for (i = 0; i < len / 4; i++)
> +		data[i] = nbl_mbx_rd32(hw_mgt, reg + i * sizeof(u32));
> +}
> +
>   static void nbl_hw_write_mbx_regs(struct nbl_hw_mgt *hw_mgt, u64 reg,
>   				  const u32 *data, u32 len)
>   {
> @@ -130,6 +142,14 @@ static u32 nbl_hw_get_host_pf_mask(struct nbl_hw_mgt *hw_mgt)
>   	return data;
>   }
>   
> +static u32 nbl_hw_get_real_bus(struct nbl_hw_mgt *hw_mgt)
> +{
> +	u32 data;
> +
> +	data = nbl_hw_rd32(hw_mgt, NBL_PCIE_HOST_TL_CFG_BUSDEV);
> +	return data >> 5;
> +}
> +
>   static void nbl_hw_cfg_mailbox_qinfo(struct nbl_hw_mgt *hw_mgt, u16 func_id,
>   				     u16 bus, u16 devid, u16 function)
>   {
> @@ -144,6 +164,36 @@ static void nbl_hw_cfg_mailbox_qinfo(struct nbl_hw_mgt *hw_mgt, u16 func_id,
>   		       (u32 *)&mb_qinfo_map, sizeof(mb_qinfo_map));
>   }
>   
> +static void nbl_hw_get_board_info(struct nbl_hw_mgt *hw_mgt,
> +				  struct nbl_board_port_info *board_info)
> +{
> +	union nbl_fw_board_cfg_dw3 dw3 = { .info = { 0 } };
> +
> +	nbl_hw_read_mbx_regs(hw_mgt, NBL_FW_BOARD_DW3_OFFSET, (u32 *)&dw3,
> +			     sizeof(dw3));
> +	board_info->eth_num = dw3.info.port_num;
> +	board_info->eth_speed = dw3.info.port_speed;
> +	board_info->p4_version = dw3.info.p4_version;
> +}
> +
> +static u32 nbl_hw_get_fw_eth_num(struct nbl_hw_mgt *hw_mgt)
> +{
> +	union nbl_fw_board_cfg_dw3 dw3 = { .info = { 0 } };
> +
> +	nbl_hw_read_mbx_regs(hw_mgt, NBL_FW_BOARD_DW3_OFFSET, (u32 *)&dw3,
> +			     sizeof(dw3));
> +	return dw3.info.port_num;
> +}
> +
> +static u32 nbl_hw_get_fw_eth_map(struct nbl_hw_mgt *hw_mgt)
> +{
> +	union nbl_fw_board_cfg_dw6 dw6 = { .info = { 0 } };
> +
> +	nbl_hw_read_mbx_regs(hw_mgt, NBL_FW_BOARD_DW6_OFFSET, (u32 *)&dw6,
> +			     sizeof(dw6));
> +	return dw6.info.eth_bitmap;
> +}
> +
>   static struct nbl_hw_ops hw_ops = {
>   	.update_mailbox_queue_tail_ptr = nbl_hw_update_mailbox_queue_tail_ptr,
>   	.config_mailbox_rxq = nbl_hw_config_mailbox_rxq,
> @@ -151,8 +201,13 @@ static struct nbl_hw_ops hw_ops = {
>   	.stop_mailbox_rxq = nbl_hw_stop_mailbox_rxq,
>   	.stop_mailbox_txq = nbl_hw_stop_mailbox_txq,
>   	.get_host_pf_mask = nbl_hw_get_host_pf_mask,
> +	.get_real_bus = nbl_hw_get_real_bus,
> +
>   	.cfg_mailbox_qinfo = nbl_hw_cfg_mailbox_qinfo,
>   
> +	.get_fw_eth_num = nbl_hw_get_fw_eth_num,
> +	.get_fw_eth_map = nbl_hw_get_fw_eth_map,
> +	.get_board_info = nbl_hw_get_board_info,
>   };
>   
>   /* Structure starts here, adding an op should not modify anything below */
> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c
> index 355f7ea66b88..00569aa3459a 100644
> --- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c
> @@ -4,9 +4,12 @@
>    */
>   #include <linux/device.h>
>   #include <linux/pci.h>
> +#include <linux/bits.h>
>   #include "nbl_resource_leonis.h"
>   
>   static struct nbl_resource_ops res_ops = {
> +	.get_vsi_id = nbl_res_func_id_to_vsi_id,
> +	.get_eth_id = nbl_res_get_eth_id,
>   };
>   
>   static struct nbl_resource_mgt *
> @@ -45,8 +48,162 @@ nbl_res_setup_ops(struct device *dev, struct nbl_resource_mgt *res_mgt)
>   	return res_ops_tbl;
>   }
>   
> +static int nbl_res_ctrl_dev_setup_eth_info(struct nbl_resource_mgt *res_mgt)
> +{
> +	struct nbl_hw_ops *hw_ops = res_mgt->hw_ops_tbl->ops;
> +	struct device *dev = res_mgt->common->dev;
> +	struct nbl_eth_info *eth_info;
> +	u32 eth_bitmap, eth_id;
> +	u32 eth_num = 0;
> +	int i;
> +
> +	eth_info = devm_kzalloc(dev, sizeof(*eth_info), GFP_KERNEL);
> +	if (!eth_info)
> +		return -ENOMEM;
> +
> +	res_mgt->resource_info->eth_info = eth_info;
> +
> +	eth_info->eth_num =
> +		(u8)hw_ops->get_fw_eth_num(res_mgt->hw_ops_tbl->priv);
> +	eth_bitmap = hw_ops->get_fw_eth_map(res_mgt->hw_ops_tbl->priv);
> +	/* for 2 eth port board, the eth_id is 0, 2 */
> +	for (i = 0; i < NBL_MAX_ETHERNET; i++) {
> +		if ((1 << i) & eth_bitmap) {
> +			set_bit(i, eth_info->eth_bitmap);
> +			eth_info->eth_id[eth_num] = i;
> +			eth_info->logic_eth_id[i] = eth_num;
> +			eth_num++;
> +		}
> +	}
> +
> +	for (i = 0; i < res_mgt->resource_info->max_pf; i++) {
> +		/* if pf_id < eth_num, the pf relate corresponding eth_id*/

nit: /* if pf_id < eth_num, the pf relate corresponding eth_id */

> +		if (i < eth_num) {
> +			eth_id = eth_info->eth_id[i];
> +			eth_info->pf_bitmap[eth_id] |= BIT(i);
> +		}
> +		/* if pf_id >= eth_num, the pf relate eth 0*/
> +		else
> +			eth_info->pf_bitmap[0] |= BIT(i);
> +	}
> +
> +	return 0;
> +}
> +
> +static int nbl_res_ctrl_dev_sriov_info_init(struct nbl_resource_mgt *res_mgt)
> +{
> +	struct nbl_hw_ops *hw_ops = res_mgt->hw_ops_tbl->ops;
> +	struct nbl_hw_mgt *p = res_mgt->hw_ops_tbl->priv;
> +	struct nbl_common_info *common = res_mgt->common;
> +	struct nbl_sriov_info *sriov_info;
> +	struct device *dev = common->dev;
> +	u16 func_id, function;
> +
> +	sriov_info = devm_kcalloc(dev, res_mgt->resource_info->max_pf,
> +				  sizeof(*sriov_info), GFP_KERNEL);
> +	if (!sriov_info)
> +		return -ENOMEM;
> +
> +	res_mgt->resource_info->sriov_info = sriov_info;
> +
> +	for (func_id = 0; func_id < res_mgt->resource_info->max_pf; func_id++) {
> +		sriov_info = res_mgt->resource_info->sriov_info + func_id;
> +		function = common->function + func_id;
> +
> +		common->hw_bus = (u8)hw_ops->get_real_bus(p);

Why do we have to write to common->hw_bus in a loop? Can we do it once 
outside the loop?

> +		sriov_info->bdf = PCI_DEVID(common->hw_bus,
> +					    PCI_DEVFN(common->devid, function));
> +	}

nit: space here

> +	return 0;
> +}
> +
> +static int nbl_res_ctrl_dev_vsi_info_init(struct nbl_resource_mgt *res_mgt)
> +{
> +	struct nbl_eth_info *eth_info = res_mgt->resource_info->eth_info;
> +	struct nbl_common_info *common = res_mgt->common;
> +	struct device *dev = common->dev;
> +	struct nbl_vsi_info *vsi_info;
> +	int i;
> +
> +	vsi_info = devm_kcalloc(dev, res_mgt->resource_info->max_pf,
> +				sizeof(*vsi_info), GFP_KERNEL);
> +	if (!vsi_info)
> +		return -ENOMEM;
> +
> +	res_mgt->resource_info->vsi_info = vsi_info;
> +	/*
> +	 * case 1 two port(2pf)
> +	 * pf0,pf1(NBL_VSI_SERV_PF_DATA_TYPE) vsi is 0,512
> +
> +	 * case 2 four port(4pf)
> +	 * pf0,pf1,pf2,pf3(NBL_VSI_SERV_PF_DATA_TYPE) vsi is 0,256,512,768
> +
> +	 */
> +
> +	vsi_info->num = eth_info->eth_num;
> +	for (i = 0; i < vsi_info->num; i++) {
> +		vsi_info->serv_info[i][NBL_VSI_SERV_PF_DATA_TYPE].base_id =
> +			i * NBL_VSI_ID_GAP(vsi_info->num);
> +		vsi_info->serv_info[i][NBL_VSI_SERV_PF_DATA_TYPE].num = 1;
> +	}

nit: space here

> +	return 0;
> +}
> +
> +static int nbl_res_init_pf_num(struct nbl_resource_mgt *res_mgt)
> +{
> +	struct nbl_hw_ops *hw_ops = res_mgt->hw_ops_tbl->ops;
> +	u32 pf_num = 0;
> +	u32 pf_mask;
> +	int i;
> +
> +	pf_mask = hw_ops->get_host_pf_mask(res_mgt->hw_ops_tbl->priv);
> +	for (i = 0; i < NBL_MAX_PF; i++) {
> +		if (!(pf_mask & (1 << i)))
> +			pf_num++;
> +		else
> +			break;
> +	}
> +
> +	res_mgt->resource_info->max_pf = pf_num;
> +
> +	if (!pf_num)
> +		return -1;

Can we have an appropriate error code here instead of raw number? How 
about -EINVAL?

> +
> +	return 0;
> +}
> +
> +static void nbl_res_init_board_info(struct nbl_resource_mgt *res_mgt)
> +{
> +	struct nbl_hw_ops *hw_ops = res_mgt->hw_ops_tbl->ops;
> +
> +	hw_ops->get_board_info(res_mgt->hw_ops_tbl->priv,
> +			       &res_mgt->resource_info->board_info);
> +}
> +
>   static int nbl_res_start(struct nbl_resource_mgt *res_mgt)
>   {
> +	struct nbl_common_info *common = res_mgt->common;
> +	int ret = 0;
> +
> +	if (common->has_ctrl) {
> +		nbl_res_init_board_info(res_mgt);
> +
> +		ret = nbl_res_init_pf_num(res_mgt);
> +		if (ret)
> +			return ret;
> +
> +		ret = nbl_res_ctrl_dev_sriov_info_init(res_mgt);
> +		if (ret)
> +			return ret;
> +
> +		ret = nbl_res_ctrl_dev_setup_eth_info(res_mgt);
> +		if (ret)
> +			return ret;
> +
> +		ret = nbl_res_ctrl_dev_vsi_info_init(res_mgt);
> +		if (ret)
> +			return ret;
> +	}
>   	return 0;
>   }
>   
> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.c
> new file mode 100644
> index 000000000000..2afec802b0e3
> --- /dev/null
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.c
> @@ -0,0 +1,110 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2025 Nebula Matrix Limited.
> + */
> +
> +#include <linux/pci.h>
> +#include "nbl_resource.h"
> +
> +u16 nbl_res_pfid_to_vsi_id(struct nbl_resource_mgt *res_mgt, int pfid, u16 type)
> +{
> +	struct nbl_vsi_info *vsi_info = res_mgt->resource_info->vsi_info;
> +	enum nbl_vsi_serv_type dst_type = NBL_VSI_SERV_PF_DATA_TYPE;
> +	struct nbl_common_info *common = res_mgt->common;
> +	u16 vsi_id = U16_MAX;
> +	u32 diff;
> +
> +	diff = nbl_common_pf_id_subtraction_mgtpf_id(common, pfid);
> +	if (diff == U32_MAX)
> +		return vsi_id;
> +
> +	if (diff < vsi_info->num) {
> +		nbl_res_pf_dev_vsi_type_to_hw_vsi_type(type, &dst_type);
> +		vsi_id = vsi_info->serv_info[diff][dst_type].base_id;
> +	}
> +	if (vsi_id == U16_MAX)
> +		pr_err("convert pfid %d to vsi_id(%d) failed!\n", pfid, type);
> +	return vsi_id;
> +}
> +
> +u16 nbl_res_func_id_to_vsi_id(struct nbl_resource_mgt *res_mgt, u16 func_id,
> +			      u16 type)
> +{
> +	int pfid = func_id;
> +
> +	return nbl_res_pfid_to_vsi_id(res_mgt, pfid, type);
> +}
> +
> +int nbl_res_vsi_id_to_pf_id(struct nbl_resource_mgt *res_mgt, u16 vsi_id)
> +{
> +	struct nbl_vsi_info *vsi_info = res_mgt->resource_info->vsi_info;
> +	struct nbl_common_info *common = res_mgt->common;
> +	bool vsi_find = false;
> +	u32 pf_id = U32_MAX;
> +	int i, j;
> +
> +	for (i = 0; i < vsi_info->num; i++) {
> +		for (j = 0; j < NBL_VSI_SERV_MAX_TYPE; j++)
> +			if (vsi_id >= vsi_info->serv_info[i][j].base_id &&
> +			    (vsi_id < vsi_info->serv_info[i][j].base_id +
> +					      vsi_info->serv_info[i][j].num)) {
> +				vsi_find = true;
> +				break;
> +			}
> +
> +		if (vsi_find)
> +			break;
> +	}
> +
> +	if (vsi_find) {
> +		if (j == NBL_VSI_SERV_PF_DATA_TYPE)
> +			pf_id = i + common->mgt_pf;
> +	}
> +
> +	return pf_id;

So we have a possible case of returning U32_MAX when the return type is int.
> +}
> +
> +int nbl_res_func_id_to_bdf(struct nbl_resource_mgt *res_mgt, u16 func_id,
> +			   u8 *bus, u8 *dev, u8 *function)
> +{
> +	struct nbl_common_info *common = res_mgt->common;
> +	struct nbl_sriov_info *sriov_info;
> +	int pfid = func_id;
> +	u8 pf_bus, devfn;
> +	u32 diff;
> +
> +	diff = nbl_common_pf_id_subtraction_mgtpf_id(common, pfid);
> +	if (diff == U32_MAX)
> +		return U32_MAX;
> +	sriov_info = res_mgt->resource_info->sriov_info + diff;
> +	pf_bus = PCI_BUS_NUM(sriov_info->bdf);
> +	devfn = sriov_info->bdf & 0xff;
> +	*bus = pf_bus;
> +	*dev = PCI_SLOT(devfn);
> +	*function = PCI_FUNC(devfn);

nit: space here

> +	return 0;
> +}
> +
> +void nbl_res_get_eth_id(struct nbl_resource_mgt *res_mgt, u16 vsi_id,
> +			u8 *eth_mode, u8 *eth_id, u8 *logic_eth_id)
> +{
> +	struct nbl_eth_info *eth_info = res_mgt->resource_info->eth_info;
> +	u16 pf_id = nbl_res_vsi_id_to_pf_id(res_mgt, vsi_id);
> +
> +	*eth_mode = eth_info->eth_num;
> +	if (pf_id < eth_info->eth_num) {
> +		*eth_id = eth_info->eth_id[pf_id];
> +		*logic_eth_id = pf_id;
> +	} else {
> +		/* if pf_id >= eth_num, use eth_id 0 */

Perhaps we can elaborate this a little more

> +		*eth_id = eth_info->eth_id[0];
> +		*logic_eth_id = 0;
> +	}
> +}
> +
> +void nbl_res_pf_dev_vsi_type_to_hw_vsi_type(u16 src_type,
> +					    enum nbl_vsi_serv_type *dst_type)
> +{
> +	if (src_type == NBL_VSI_DATA)
> +		*dst_type = NBL_VSI_SERV_PF_DATA_TYPE;
> +}
> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.h
> index e08b6237da32..51b5b958cde8 100644
> --- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.h
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.h
> @@ -16,7 +16,48 @@
>   #include "../nbl_include/nbl_def_common.h"
>   #include "../nbl_core.h"
>   
> +struct nbl_resource_mgt;
> +
> +/* --------- INFO ---------- */
> +struct nbl_sriov_info {
> +	unsigned int bdf;
> +};
> +
> +struct nbl_eth_info {
> +	DECLARE_BITMAP(eth_bitmap, NBL_MAX_ETHERNET);
> +	u8 pf_bitmap[NBL_MAX_ETHERNET];
> +	u8 eth_num;
> +	u8 resv[3];
> +	u8 eth_id[NBL_MAX_PF];
> +	u8 logic_eth_id[NBL_MAX_PF];
> +};
> +
> +enum nbl_vsi_serv_type {
> +	NBL_VSI_SERV_PF_DATA_TYPE,
> +	NBL_VSI_SERV_MAX_TYPE,
> +};
> +
> +struct nbl_vsi_serv_info {
> +	u16 base_id;
> +	u16 num;
> +};
> +
> +struct nbl_vsi_info {
> +	u16 num;
> +	struct nbl_vsi_serv_info serv_info[NBL_MAX_ETHERNET]
> +					  [NBL_VSI_SERV_MAX_TYPE];
> +};
> +
>   struct nbl_resource_info {
> +	/* ctrl-dev owned pfs */
> +	DECLARE_BITMAP(func_bitmap, NBL_MAX_FUNC);
> +	struct nbl_sriov_info *sriov_info;
> +	struct nbl_eth_info *eth_info;
> +	struct nbl_vsi_info *vsi_info;
> +	u32 base_qid;
> +	u32 max_vf_num;
> +	u8 max_pf;
> +	struct nbl_board_port_info board_info;
>   };
>   
>   struct nbl_resource_mgt {
> @@ -27,4 +68,15 @@ struct nbl_resource_mgt {
>   	struct nbl_interrupt_mgt *intr_mgt;
>   };
>   
> +int nbl_res_vsi_id_to_pf_id(struct nbl_resource_mgt *res_mgt, u16 vsi_id);
> +u16 nbl_res_pfid_to_vsi_id(struct nbl_resource_mgt *res_mgt, int pfid,
> +			   u16 type);
> +u16 nbl_res_func_id_to_vsi_id(struct nbl_resource_mgt *res_mgt, u16 func_id,
> +			      u16 type);
> +int nbl_res_func_id_to_bdf(struct nbl_resource_mgt *res_mgt, u16 func_id,
> +			   u8 *bus, u8 *dev, u8 *function);
> +void nbl_res_get_eth_id(struct nbl_resource_mgt *res_mgt, u16 vsi_id,
> +			u8 *eth_mode, u8 *eth_id, u8 *logic_eth_id);
> +void nbl_res_pf_dev_vsi_type_to_hw_vsi_type(u16 src_type,
> +					    enum nbl_vsi_serv_type *dst_type);
>   #endif
> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_common.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_common.h
> index 5c532247c852..04ffc1918a46 100644
> --- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_common.h
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_common.h
> @@ -12,6 +12,21 @@
>   #include "nbl_include.h"
>   
>   struct nbl_hash_tbl_mgt;
> +#define NBL_TWO_ETHERNET_PORT			2
> +#define NBL_FOUR_ETHERNET_PORT			4
> +#define NBL_DEFAULT_VSI_ID_GAP			1024
> +#define NBL_TWO_ETHERNET_VSI_ID_GAP		512
> +#define NBL_FOUR_ETHERNET_VSI_ID_GAP		256
> +
> +#define NBL_VSI_ID_GAP(m)					\
> +	({							\
> +		typeof(m) _m = (m);				\
> +		_m == NBL_FOUR_ETHERNET_PORT ?			\
> +			NBL_FOUR_ETHERNET_VSI_ID_GAP :		\
> +			(_m == NBL_TWO_ETHERNET_PORT ?		\
> +				 NBL_TWO_ETHERNET_VSI_ID_GAP :	\
> +				 NBL_DEFAULT_VSI_ID_GAP);	\
> +	})
>   
>   struct nbl_common_info {
>   	struct pci_dev *pdev;
> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_resource.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_resource.h
> index 16add7e25eae..249b8f633cee 100644
> --- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_resource.h
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_resource.h
> @@ -6,9 +6,25 @@
>   #ifndef _NBL_DEF_RESOURCE_H_
>   #define _NBL_DEF_RESOURCE_H_
>   
> +#include <linux/types.h>
> +
>   struct nbl_resource_mgt;
>   struct nbl_adapter;
> +
>   struct nbl_resource_ops {
> +	int (*init_chip_module)(struct nbl_resource_mgt *res_mgt);
> +	void (*deinit_chip_module)(struct nbl_resource_mgt *res_mgt);
> +
> +	int (*configure_msix_map)(struct nbl_resource_mgt *res_mgt, u16 func_id,
> +				  u16 num_net_msix, u16 num_others_msix,
> +				  bool net_msix_mask_en);
> +	int (*destroy_msix_map)(struct nbl_resource_mgt *res_mgt, u16 func_id);
> +	int (*enable_mailbox_irq)(struct nbl_resource_mgt *res_mgt, u16 func_id,
> +				  u16 vector_id, bool enable_msix);
> +	u16 (*get_vsi_id)(struct nbl_resource_mgt *res_mgt, u16 func_id,
> +			  u16 type);
> +	void (*get_eth_id)(struct nbl_resource_mgt *res_mgt, u16 vsi_id,
> +			   u8 *eth_mode, u8 *eth_id, u8 *logic_eth_id);
>   };
>   
>   struct nbl_resource_ops_tbl {
> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
> index a01c32f57d84..6a0bf5e8ca32 100644
> --- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
> @@ -17,11 +17,19 @@
>   		((_id) == (max) ? 0 : (_id) + 1);	\
>   	})
>   
> +#define NBL_MAX_FUNC					520
> +#define NBL_MAX_ETHERNET				4
> +
>   enum nbl_product_type {
>   	NBL_LEONIS_TYPE,
>   	NBL_PRODUCT_MAX,
>   };
>   
> +enum {
> +	NBL_VSI_DATA = 0,
> +	NBL_VSI_MAX,
> +};
> +
>   struct nbl_func_caps {
>   	u32 has_ctrl:1;
>   	u32 has_net:1;


