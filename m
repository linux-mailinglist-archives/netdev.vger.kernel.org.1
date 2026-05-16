Return-Path: <netdev+bounces-288547-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CCTFGEbGB2pEHwMAu9opvQ
	(envelope-from <netdev+bounces-288547-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 03:20:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B251559BE3
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 03:20:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0D8743041A51
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 01:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F00D238C36;
	Sat, 16 May 2026 01:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nc0FQfKp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D18218845;
	Sat, 16 May 2026 01:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778894239; cv=none; b=fh6BtXH+9b/M6tThxUUDy0OkBLOEQ79wnE9ldsXJKD7SU/iI9rRtJUc+TA+845Q9CSCMaZFft3OOLXuOof3Fb2t24zKBi//XQM3y1NTMsg3Y4F3nx/j5cFEezBbw6v5dVH5dhgYqC2i6ff/PElpU0aiprhvZzTjDq78deMVk6to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778894239; c=relaxed/simple;
	bh=J0hQ09VIfns7rYVUIL6Mrv2XroRK7aiw1QMvaJhlXOY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CPRJO94oS9/EXUM9wlTFbOIcNkUh05hmdno0LCurti9TcExOJe09Gzf4fUoNqFYty9tUdwpQxSM1d3n8Ejzswv1xq7HdtdZfqjRiMUM+kxUILbNYJ0kzZ6KME3KWFth9fIUYVJQwQXbQa3YrdQElXe408uWd49/SCsUEcU6gQTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nc0FQfKp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AB64C2BCB0;
	Sat, 16 May 2026 01:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778894237;
	bh=J0hQ09VIfns7rYVUIL6Mrv2XroRK7aiw1QMvaJhlXOY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Nc0FQfKpxpqja6fbEBMC9Zhk3wYR8z/NbkuFexy2uf+BiR43qZTZTO+3DljOfh6rF
	 zIYHUkZN7t8UJDkzkRFIoLIYsAZGerym4/xaq1Z5qoqUr7eQMhfMVe9r4YV5xXJtTA
	 t+K1dTAC8n0w3MTlwG/OkBuX3uui1ugB1bF/lMNplk4kLUaVZIOVlZQZVYfds7p08b
	 glWdej1wGL7tW54xK1z/4Gzv0f9rwa9g9yYmxGpesHB3rhh//y/kgLeRnDGyWfPI/p
	 +OEqeSMK/5JOfCvpblLvl9eE4ZZVNY5LoF+6c5oU6enRVMMPNMNJ5XFFoURc/SmD2D
	 tgoeID8oxqdtQ==
From: Jakub Kicinski <kuba@kernel.org>
To: illusion.wang@nebula-matrix.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	dimon.zhao@nebula-matrix.com,
	alvin.wang@nebula-matrix.com,
	sam.chen@nebula-matrix.com,
	netdev@vger.kernel.org,
	andrew+netdev@lunn.ch,
	corbet@lwn.net,
	horms@kernel.org,
	linux-doc@vger.kernel.org,
	pabeni@redhat.com,
	vadim.fedorenko@linux.dev,
	lukas.bulwahn@redhat.com,
	edumazet@google.com,
	enelsonmoore@gmail.com,
	skhan@linuxfoundation.org,
	hkallweit1@gmail.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v14 net-next 06/11] net/nebula-matrix: add common resource implementation
Date: Fri, 15 May 2026 18:17:15 -0700
Message-ID: <20260516011715.1863956-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260513011649.4404-7-illusion.wang@nebula-matrix.com>
References: <20260513011649.4404-7-illusion.wang@nebula-matrix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0B251559BE3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,nebula-matrix.com,vger.kernel.org,lunn.ch,lwn.net,redhat.com,linux.dev,google.com,gmail.com,linuxfoundation.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-288547-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dw3.info:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mb_qinfo_map.info:url]
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net/nebula-matrix: add common resource implementation

The Resource layer processes the entries/data of various modules within
the processing chip to accomplish specific entry management operations,
this describes the module business capabilities of the chip and the data
it manages.
This patch provides the common part, including the conversion
relationships among vsi_id, func_id, eth_id, and pf_id.

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
> index b63c91e559af4..55d6ed70a9e60 100644
> --- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
[ ... ]
> @@ -148,6 +169,36 @@ static void nbl_hw_cfg_mailbox_qinfo(struct nbl_hw_mgt *hw_mgt, u16 func_id,
> +static void nbl_hw_cfg_mailbox_qinfo(struct nbl_hw_mgt *hw_mgt, u16 func_id,
> +				     u16 bus, u16 devid, u16 function)
> +{
> +	union nbl_mailbox_qinfo_map_table_u mb_qinfo_map;
> +
> +	memset(&mb_qinfo_map, 0, sizeof(mb_qinfo_map));
> +	mb_qinfo_map.info.function = function;
> +	mb_qinfo_map.info.devid = devid;
> +	mb_qinfo_map.info.bus = bus;

Since the memory layout of C bitfields within an integer is compiler-defined
and depends on the CPU's endianness, will assigning to bitfields in
mb_qinfo_map.info result in incorrect bits being written to the hardware
register on big-endian architectures?

Also, if the caller passes a function value that exceeds the width of the
function bitfield (which appears to be 3 bits based on standard PCIe), will
the value be silently truncated, causing multiple distinct PFs to map to the
same PCIe function?

> +	mb_qinfo_map.info.msix_idx_valid = 0;
> +	nbl_hw_wr_regs(hw_mgt, NBL_MAILBOX_QINFO_MAP_REG_ARR(func_id),
> +		       &mb_qinfo_map.data, sizeof(mb_qinfo_map));
> +}
> +
> +static void nbl_hw_get_board_info(struct nbl_hw_mgt *hw_mgt,
> +				  struct nbl_board_port_info *board_info)
> +{
> +	union nbl_fw_board_cfg_dw3 dw3 = { .info = { 0 } };
> +
> +	nbl_hw_read_mbx_regs(hw_mgt, NBL_FW_BOARD_DW3_OFFSET, &dw3.data,
> +			     sizeof(dw3));
> +	board_info->eth_num = dw3.info.port_num;

Similarly, does reading from the dw3.info bitfields cause incorrect values
to be extracted on big-endian architectures?

[ ... ]
> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c
> index 6885195c96ca8..7c366a1d5e489 100644
> --- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c
[ ... ]
> @@ -45,8 +48,164 @@ nbl_res_setup_ops(struct device *dev, struct nbl_resource_mgt *res_mgt)
> +static int nbl_res_ctrl_dev_setup_eth_info(struct nbl_resource_mgt *res_mgt)
> +{
[ ... ]
> +	eth_info->eth_num =
> +		(u8)hw_ops->get_fw_eth_num(res_mgt->hw_ops_tbl->priv);
> +	if (eth_info->eth_num > NBL_MAX_ETHERNET) {
> +		dev_warn(dev, "FW reports %u Ethernet ports, but only %u are supported\n",
> +			 eth_info->eth_num, NBL_MAX_ETHERNET);
> +		eth_info->eth_num = NBL_MAX_ETHERNET;
> +	}
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

If the firmware returns an eth_info->eth_num that is greater than the
number of set bits in eth_bitmap, could this lead to uninitialized elements
in the eth_id array being accessed later?

> +
> +	for (i = 0; i < res_mgt->resource_info->max_pf; i++) {
> +		/* Map PF index i to eth_id from eth_info->eth_id[i]
> +		 * if i < eth_num, otherwise map to eth_id 0
> +		 */
> +		if (i < eth_num) {
> +			eth_id = eth_info->eth_id[i];
> +			eth_info->pf_bitmap[eth_id] |= BIT(i);
> +		} else {
> +			eth_info->pf_bitmap[0] |= BIT(i);
> +		}
> +	}

If the eth_bitmap from the firmware does not have bit 0 set (meaning
physical port 0 is inactive), will excess PFs be mapped to a dead port here
instead of the first active physical port?

> +
> +	return 0;
> +}
> +
> +static int nbl_res_ctrl_dev_sriov_info_init(struct nbl_resource_mgt *res_mgt)
> +{
[ ... ]
> +	common->hw_bus = hw_ops->get_real_bus(p);
> +	for (func_id = 0; func_id < res_mgt->resource_info->max_pf; func_id++) {
> +		sriov_info = res_mgt->resource_info->sriov_info + func_id;
> +		sriov_info->bdf = PCI_DEVID(common->hw_bus,
> +					    PCI_DEVFN(common->devid, func_id));
> +	}
> +
> +	return 0;
> +}

Is there a potential mismatch in BDF tracking here if the base device function
(common->function) is not 0?

If the mailbox configuration layer expects the function to include
common->function, could this lead to inconsistent state between the
software and the hardware?

