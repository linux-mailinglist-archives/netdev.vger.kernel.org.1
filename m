Return-Path: <netdev+bounces-288550-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UFb3B7TFB2pEHwMAu9opvQ
	(envelope-from <netdev+bounces-288550-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 03:17:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BA862559B80
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 03:17:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 867D2300B1DE
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 01:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EAA4256C8B;
	Sat, 16 May 2026 01:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HbHBMvtM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567D11C5D5E;
	Sat, 16 May 2026 01:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778894245; cv=none; b=Skx4cJuqYa+MY/2iiRLx4NABQ7ZYtLqZDYQbjVYAyGSCM6ZTMy1mLe/i+ssqTesxQUMG46GTjgx6XN3CgG+HliXRt9RVC81FVjpZPZTfJBnJX0BIdfzsyjbG0fU4RosDfNmd0nKbVh17+RKLSDcROfZmfH196zYDW1MCG7nwG88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778894245; c=relaxed/simple;
	bh=8yDHqGxl+qyVxwHez1bbdQpXnQG+hkdL3xsVyD7IUQg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nD84zSgzYWgHYvN5g/T7AmvAYa+Dgvm2Tcqqewbfun+qo5peT5/dOiRh+gylyA21kfmqM2MMENRh5T2zkYDgfDQRo1FqQV8a53Sus9JP9tRr/DK8JoCqSiT9Ri4C63MWojzPX3HAgPrvFlDgjkZw5zstKXPBz6An3M3DaH5r/FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HbHBMvtM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD507C2BCB7;
	Sat, 16 May 2026 01:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778894240;
	bh=8yDHqGxl+qyVxwHez1bbdQpXnQG+hkdL3xsVyD7IUQg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HbHBMvtM0ESG+uYxWw18iL9MvaFH/sSE5D0ryCxaBwh0IZSSFV1dvEmgPZFcm8l8k
	 C3cnUfbObHPpHi8xWzBFiwRg1Ayq9vhCmyxGIkghxEfGrBcxnE/X313Wrmkjg16l87
	 tOXzc7DFM/2LFTFgaMONxeyK3bB62EzWK0kAtVBjJdrLdayKaaMwy9sySqKDOf3mpb
	 XP2JbUj+/Ymq3xTEKBPf2q1RAWjMit7V+9lNuEztMZejbZBNe/3bg0KwEGvGdC0iKP
	 a1Z01h+5iywYKbBIiSIHVnXrAwVP0228JEaa5ZZN6Ywq7xs/u+BmDb0flKJvb5Qn9G
	 131BMIOjKJUvw==
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
Subject: Re: [PATCH v14 net-next 08/11] net/nebula-matrix: add vsi resource implementation
Date: Fri, 15 May 2026 18:17:19 -0700
Message-ID: <20260516011719.1864020-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260513011649.4404-9-illusion.wang@nebula-matrix.com>
References: <20260513011649.4404-9-illusion.wang@nebula-matrix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: BA862559B80
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,nebula-matrix.com,vger.kernel.org,lunn.ch,lwn.net,redhat.com,linux.dev,google.com,gmail.com,linuxfoundation.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-288550-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net/nebula-matrix: add vsi resource implementation

This commit introduces the hardware initialization sequence for the DP module,
the intf module, and P4 registers. It sets up various submodules including
dped, uped, shaping, ustore, and dstore.

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
> index 612d6c9812b01..feb8d1f6fc239 100644
> --- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
[ ... ]
> @@ -64,6 +65,409 @@ static void nbl_hw_wr_regs(struct nbl_hw_mgt *hw_mgt, u64 reg, const u32 *data,
[ ... ]
> +static void nbl_uped_init(struct nbl_hw_mgt *hw_mgt)
> +{
> +	union ped_hw_edit_profile_u hw_edit;
> +
> +	nbl_hw_rd_regs(hw_mgt, NBL_UPED_HW_EDT_PROF_TABLE(NBL_DPED_V4_TCP_IDX),
> +		       &hw_edit.data, sizeof(hw_edit));

This isn't a bug, but since data is an array (u32 data[8]), does taking its
address yield a pointer to an array (u32 (*)[8]) rather than a u32 * as
expected by nbl_hw_rd_regs()? Should the address-of operator be omitted?

> +	hw_edit.info.l3_len = 0;
> +	nbl_hw_wr_regs(hw_mgt, NBL_UPED_HW_EDT_PROF_TABLE(NBL_DPED_V4_TCP_IDX),
> +		       &hw_edit.data, sizeof(hw_edit));
[ ... ]
> +static void nbl_shaping_eth_init(struct nbl_hw_mgt *hw_mgt, u8 eth_id, u8 speed)
> +{
> +	union nbl_shaping_dvn_dport_u dvn_dport = { 0 };
> +	union nbl_shaping_dport_u dport = { 0 };
> +	u32 rate, half_rate;
> +	u32 depth;
> +
> +	switch (speed) {
> +	case NBL_FW_PORT_SPEED_100G:
> +		rate = 100000;
> +		break;
> +	case NBL_FW_PORT_SPEED_50G:
> +		rate = 50000;
> +		break;
> +	case NBL_FW_PORT_SPEED_25G:
> +		rate = 25000;
> +		break;
> +	case NBL_FW_PORT_SPEED_10G:
> +		rate = 10000;
> +		break;
> +	default:
> +		dev_err(hw_mgt->common->dev, "Unsupported port speed %u for eth%u\n",
> +			speed, eth_id);
> +		break;
> +	}
> +
> +	half_rate = rate / 2;

If the default case is hit, rate remains uninitialized. Could this result in
writing uninitialized stack memory to hardware registers via half_rate?

> +	depth =  max(rate * 2, NBL_LR_LEONIS_NET_BUCKET_DEPTH);
> +	dport.info.low |= FIELD_PREP(DPORT_CIR_MASK, rate);
[ ... ]
> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.h
> index 7eef749eeb69f..75bb8b715f35a 100644
> --- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.h
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.h
[ ... ]
> @@ -258,6 +259,15 @@ union dsch_vn_quanta_u {
>  
>  #define DEFAULT_DVN_DESC_WR_MERGE_TIMEOUT_MAX	0x3FF
>  
> +#define PACKET_RING_MIN 8U
> +#define PACKET_RING_MAX 32U
> +#define SPLIT_RING_MIN 8U
> +#define SPLIT_RING_MAX 16U
> +#define PACKET_RING_BASE 8U
> +#define PACKET_RING_DIV 4U
> +#define SPLIT_RING_CFG_8 0U
> +#define SPLIT_RING_CFG_16 1U
> +
>  union nbl_dvn_descreq_num_cfg_u {
>  	struct nbl_dvn_descreq_num_cfg {
>  		u32 avring_cfg_num:1; /* spilit ring descreq_num 0:8,1:16 */

Is it safe to use C bitfields for hardware register layouts here? The memory
layout of bitfields is compiler-dependent and varies with architecture
endianness, which could result in incorrect bits being written to the device on
big-endian systems.

