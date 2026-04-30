Return-Path: <netdev+bounces-283018-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CP8fODLq82kA8wEAu9opvQ
	(envelope-from <netdev+bounces-283018-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 01:48:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B5F84A8F10
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 01:48:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C5D9430394FD
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 23:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BE733DA7F6;
	Thu, 30 Apr 2026 23:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lWYEWX3y"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527623D9043;
	Thu, 30 Apr 2026 23:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777592870; cv=none; b=S7537K/qGJlGakqA7v21PhiT522pG5ycwrzQEE+T1vQRM7L/qGY7RJ95xbMT4ffmu2Mi+nou+aJJnnHINqmxbHC81+4+AKIxtLtPVRGUmuelM4RxjkEmeeVThNQlni6vrbEe5Dceb3tyG00yf9Q48vT6/YA+RemRpI1Nr1oPGtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777592870; c=relaxed/simple;
	bh=T6ts7mA0XAR5h3T/YL22fMWEDsRUCmC5PvRIAGIucpE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RsyhvtEbabxoc+rqNe29uqvmn6vFJiVhzRYpHYH3ms11ESUEAhK/ryUOkYQ678L9JF7IpPdSDrlgHBJ4pWiOCsfZyjwTirVbGhV0m2JVhJpARvqeoV2n8Of8noawFwU+iyGhWqtSVf89/Fwe+ddxF2G/8LFR8uhM4q/tdaKh5mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lWYEWX3y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7590BC2BCB3;
	Thu, 30 Apr 2026 23:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777592870;
	bh=T6ts7mA0XAR5h3T/YL22fMWEDsRUCmC5PvRIAGIucpE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lWYEWX3yHCiI5D0w8C+FfByFqAm4u2SelbmjWMxO1xx5DekVaTG9aWrE+6wUuMHsR
	 FgO212ZZmTd2gaIUqKr4Cj01YIvLG0XykDcRqsYgFanGhVNzb/He/zrItmaY0BaGiK
	 3Wlf+rqyvFM5wl6zxoh9921faLNI+OH/3rGuThIrauNlDzN4rLL7xR7aGyASztgsZ7
	 DHz3/RH7HucjgvdUcPEXIffe43BuEHy+bzLBZZzog1n/STiYosulM2EVCFPTyfnsuM
	 E40S6rdwiK7QC8eG5KtbdpcsNARVEWDYZ2DYZXowhmSJFJv7QvVjs377GuZ8IX6gSn
	 mQRrtvhWuW9eg==
From: Jakub Kicinski <kuba@kernel.org>
To: illusion.wang@nebula-matrix.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	dimon.zhao@nebula-matrix.com,
	alvin.wang@nebula-matrix.com,
	sam.chen@nebula-matrix.com,
	netdev@vger.kernel.org,
	andrew+netdev@lunn.ch,
	corbet@lwn.net,
	linux-doc@vger.kernel.org,
	lorenzo@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	vadim.fedorenko@linux.dev,
	lukas.bulwahn@redhat.com,
	edumazet@google.com,
	enelsonmoore@gmail.com,
	skhan@linuxfoundation.org,
	hkallweit1@gmail.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v13 net-next 08/11] net/nebula-matrix: add vsi resource implementation
Date: Thu, 30 Apr 2026 16:47:48 -0700
Message-ID: <20260430234748.3074652-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260428114910.2616-9-illusion.wang@nebula-matrix.com>
References: <20260428114910.2616-9-illusion.wang@nebula-matrix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5B5F84A8F10
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-283018-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,nebula-matrix.com,vger.kernel.org,lunn.ch,lwn.net,redhat.com,linux.dev,google.com,gmail.com,linuxfoundation.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net/nebula-matrix: add vsi resource implementation

This patch adds the VSI resource implementation and chip initialization
for the DP, intf, and P4 register modules, covering sub-modules such as
dped, uped, dsch, ustore, dstore, dvn, uvn, and uqm. The new code
populates bitfield structs and writes them to MMIO registers via
nbl_hw_wr_regs().

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
> index aa5e91c2b278..747273217203 100644
> --- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c

[ ... ]

> +static void nbl_configure_dped_checksum(struct nbl_hw_mgt *hw_mgt)
> +{
> +	union dped_l4_ck_cmd_40_u l4_ck_cmd_40;
> +
> +	/* DPED dped_l4_ck_cmd_40 for sctp */
> +	nbl_hw_rd_regs(hw_mgt, NBL_DPED_L4_CK_CMD_40_ADDR, (u32 *)&l4_ck_cmd_40,
> +		       sizeof(l4_ck_cmd_40));
> +	l4_ck_cmd_40.info.en = 1;
> +	nbl_hw_wr_regs(hw_mgt, NBL_DPED_L4_CK_CMD_40_ADDR, (u32 *)&l4_ck_cmd_40,
> +		       sizeof(l4_ck_cmd_40));
> +}

Can this code produce a different bit pattern in the device register
depending on the host endianness?

The pattern used throughout the new init code is to populate C bitfield
structs and then cast them to u32 * and hand them to nbl_hw_wr_regs(),
which ultimately reaches writel(). The C standard leaves bitfield
placement within a storage unit implementation-defined, and GCC places
u32 f:N fields starting from the opposite end depending on the target
endianness. writel() performs a CPU-to-little-endian conversion on the
whole u32, so the register contents seen by the device differ between
little-endian and big-endian kernels compiled from the same source.

> +static void nbl_uped_init(struct nbl_hw_mgt *hw_mgt)
> +{
> +	struct ped_hw_edit_profile hw_edit;
> +
> +	nbl_hw_rd_regs(hw_mgt, NBL_UPED_HW_EDT_PROF_TABLE(NBL_DPED_V4_TCP_IDX),
> +		       (u32 *)&hw_edit, sizeof(hw_edit));
> +	hw_edit.l3_len = 0;
> +	nbl_hw_wr_regs(hw_mgt, NBL_UPED_HW_EDT_PROF_TABLE(NBL_DPED_V4_TCP_IDX),
> +		       (u32 *)&hw_edit, sizeof(hw_edit));
> +
> +	nbl_hw_rd_regs(hw_mgt, NBL_UPED_HW_EDT_PROF_TABLE(NBL_DPED_V6_TCP_IDX),
> +		       (u32 *)&hw_edit, sizeof(hw_edit));
> +	hw_edit.l3_len = 1;
> +	nbl_hw_wr_regs(hw_mgt, NBL_UPED_HW_EDT_PROF_TABLE(NBL_DPED_V6_TCP_IDX),
> +		       (u32 *)&hw_edit, sizeof(hw_edit));
> +}

[ ... ]

> +static void nbl_shaping_eth_init(struct nbl_hw_mgt *hw_mgt, u8 eth_id, u8 speed)
> +{
> +	struct nbl_shaping_dvn_dport dvn_dport = { 0 };
> +	struct nbl_shaping_dport dport = { 0 };
> +	u32 rate, half_rate;
> +
> +	if (speed == NBL_FW_PORT_SPEED_100G) {
> +		rate = NBL_SHAPING_DPORT_100G_RATE;
> +		half_rate = NBL_SHAPING_DPORT_HALF_100G_RATE;
> +	} else {
> +		rate = NBL_SHAPING_DPORT_25G_RATE;
> +		half_rate = NBL_SHAPING_DPORT_HALF_25G_RATE;
> +	}
> +
> +	dport.cir = rate;
> +	dport.pir = rate;
> +	dport.depth = max(dport.cir * 2, NBL_LR_LEONIS_NET_BUCKET_DEPTH);
> +	dport.cbs = dport.depth;
> +	dport.pbs = dport.depth;
> +	dport.valid = 1;
> +
> +	dvn_dport.cir = half_rate;
> +	dvn_dport.pir = rate;
> +	dvn_dport.depth = dport.depth;
> +	dvn_dport.cbs = dvn_dport.depth;
> +	dvn_dport.pbs = dvn_dport.depth;
> +	dvn_dport.valid = 1;
> +
> +	nbl_hw_wr_regs(hw_mgt, NBL_SHAPING_DPORT_REG(eth_id), (u32 *)&dport,
> +		       sizeof(dport));
> +	nbl_hw_wr_regs(hw_mgt, NBL_SHAPING_DVN_DPORT_REG(eth_id),
> +		       (u32 *)&dvn_dport, sizeof(dvn_dport));
> +}

The same pattern appears in nbl_shaping_eth_init(), nbl_dsch_qid_max_init(),
nbl_ustore_init(), nbl_dstore_init(), nbl_dvn_descreq_num_cfg(),
nbl_dvn_init(), nbl_uvn_init(), nbl_uqm_init(), and
nbl_configure_dped_checksum().

[ ... ]

> +static void nbl_dvn_descreq_num_cfg(struct nbl_hw_mgt *hw_mgt, u32 descreq_num)
> +{
> +	u32 split_ring_num = (descreq_num >> 16) & 0xffff;
> +	struct nbl_dvn_descreq_num_cfg num_cfg = { 0 };
> +	u32 packet_ring_num = descreq_num & 0xffff;
> +
> +	packet_ring_num =
> +		clamp(packet_ring_num, PACKET_RING_MIN, PACKET_RING_MAX);
> +	num_cfg.packed_l1_num =
> +		(packet_ring_num - PACKET_RING_BASE) / PACKET_RING_DIV;
> +
> +	split_ring_num = clamp(split_ring_num, SPLIT_RING_MIN,
> +			       SPLIT_RING_MAX);
> +	num_cfg.avring_cfg_num = split_ring_num > SPLIT_RING_MIN ?
> +					SPLIT_RING_CFG_16 :
> +					SPLIT_RING_CFG_8;
> +
> +	nbl_hw_wr_regs(hw_mgt, NBL_DVN_DESCREQ_NUM_CFG, (u32 *)&num_cfg,
> +		       sizeof(num_cfg));
> +}

Taking struct nbl_dvn_descreq_num_cfg as one example:

    struct nbl_dvn_descreq_num_cfg {
        u32 avring_cfg_num:1;
        u32 rsv0:3;
        u32 packed_l1_num:3;
        u32 rsv1:25;
    };

On a little-endian build, avring_cfg_num ends up in bit 0 of the u32 sent
to the device. On a big-endian build the same field ends up in bit 31 of
the u32 that writel() then byte-swaps to little-endian for the bus,
producing a different pattern at the device. The same concern applies to
struct uvn_desc_prefetch_init, struct uvn_dif_req_ro_flag,
struct dsch_vn_quanta, struct nbl_shaping_dport,
struct nbl_shaping_dvn_dport, struct dstore_disc_bp_th,
struct dstore_port_drop_th, struct dstore_d_dport_fc_th,
struct ustore_pkt_len, struct nbl_ustore_port_drop_th,
struct ped_hw_edit_profile, struct nbl_uqm_que_type, and
union dped_l4_ck_cmd_40_u.

[ ... ]

> +static void nbl_uvn_init(struct nbl_hw_mgt *hw_mgt)
> +{
> +	struct uvn_desc_prefetch_init prefetch_init = { 0 };
> +	struct uvn_desc_wr_timeout desc_wr_timeout = { 0 };
> +	struct uvn_dif_req_ro_flag flag = { 0 };
> +	struct uvn_queue_err_mask mask = { 0 };
[ ... ]
> +	nbl_hw_wr_regs(hw_mgt, NBL_UVN_DESC_PREFETCH_INIT,
> +		       (u32 *)&prefetch_init, sizeof(prefetch_init));
> +}

The driver Kconfig uses depends on PCI && (64BIT || COMPILE_TEST), which
permits ppc64be and s390x builds, and there is no BUILD_BUG_ON or
__LITTLE_ENDIAN_BITFIELD / __BIG_ENDIAN_BITFIELD guarding on any of these
structs.

Would it make sense to either add __LITTLE_ENDIAN_BITFIELD /
__BIG_ENDIAN_BITFIELD variants for each of these register-layout structs,
replace the bitfields with explicit u32 masks and shifts, or restrict the
Kconfig to little-endian hosts?

