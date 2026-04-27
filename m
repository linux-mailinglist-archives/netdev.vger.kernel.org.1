Return-Path: <netdev+bounces-281218-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6JmxCKzj7mkdzQAAu9opvQ
	(envelope-from <netdev+bounces-281218-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 06:18:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 719BC46D009
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 06:18:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F2EEE3002A15
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 04:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65F8F248166;
	Mon, 27 Apr 2026 04:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="ZeNXgSqd"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62EC8548EE;
	Mon, 27 Apr 2026 04:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777263529; cv=none; b=dImMPmqvUFgT4Pt6UeFRcAHIIyvdLYfrr61wHkM6P3MySN0REfNOjd2Rx/s21LL6NUU8BOQiWCdhQgH5aY5sIjUQHZMWPtiDks/q+zPGQz1ZnuQLmBYEUm5hhCdx2QPtm4RL0/G18EnvqX5x8Amg1MsHlE+5rzI2Qj6r5202KSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777263529; c=relaxed/simple;
	bh=3rAA3Zxju+5KeTsHbEm6mY+wJsR2id3oKVjGdsT/PXc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rd/TIdfLmJ25q5f1+GzSN1SUrQhIa7W/FnqQLUxOvS1BQ0jSU5l0xjfbutqfAQQ0wtGKv/ZAoFpHh2wPWxbykh9HJFy4aXAXKlSCJmzeXSk901eOlx95XZb6469z6FB7iq5U135Rmz00IJv/O2E17Hr6q/EA8cYagqCng5WwCJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=ZeNXgSqd; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63QLBGU43308879;
	Sun, 26 Apr 2026 21:18:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=69tL47aZXlZzP+a90nQXs3Ak+
	4YzqeBib7eqZY+T0ms=; b=ZeNXgSqdXELXd+p+27Tpf+gysMRXxqkI0pwyYS6IW
	bQIUquOzGsDVkX1ZSZJhjXIw72HWEHDCpzbRnZOvezSFZGcAiwRrACziC7GDb6uq
	rsQQ4paPIBa5BS01gmj3FHpH5Rbw12q9evh+hf7y317ZNdbxEKNY2ERgfcjd9w0f
	cm+Iws4dIphLwKxCZYb2mQpZTIvFjeDxD3BefRvrF4lohVbpeo7TL7JwnVSPIwNQ
	IcyKHIciBdq/6bZyEtqadGvzRpOHtw4aXpp4PAN72k/cFn1j0j+6nsq5BQSzd73b
	+HXk4kgQOOvXHX6+fHnlaYmM1mYqXUximnN7/kWXjc/qw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4dshv897mw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 26 Apr 2026 21:18:36 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 26 Apr 2026 21:18:35 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sun, 26 Apr 2026 21:18:35 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 479A43F7094;
	Sun, 26 Apr 2026 21:18:32 -0700 (PDT)
Date: Mon, 27 Apr 2026 09:48:31 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
        Suman Ghosh
	<sumang@marvell.com>
Subject: Re: [PATCH v3 net 11/11] octeontx2-af: npc: cn20k: Reject missing
 default-rule MCAM indices
Message-ID: <ae7jlymNEI95_pA0@rkannoth-OptiPlex-7090>
References: <20260423104317.2707923-1-rkannoth@marvell.com>
 <20260423104317.2707923-12-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260423104317.2707923-12-rkannoth@marvell.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDA0MiBTYWx0ZWRfXyq3NR82Jfjax
 VT/1IIwlVHKuUzKlDLLBYj3T7kvdR8rTo+F/ekisho0IPxAWcY1Qbzk0bmA4F7NegrhOSm1OzSd
 2E6FzQv0KnpoPCi4rQiH16pavDd2o6V20kzgUUrCqKuFbk3zaIdRcZxCOH7tMO33lX9ZFOSNobE
 +jX1c0oDRppY9aknPFUyT3sKry+hh0k1X4+4azGGMeT06JMUNv6Oxr4VPI1SwQzRhYQYOFdpMux
 khlGyIX2R+ETRouE5KrMqo3GhZBkMi4TsIX9sGyUDnr7ptGBbB5jDustEu1uQv50NLyrEMLwP9J
 gaPsIVtQVpcQIqUAw2q1G2Qjp5cEK23sJN6RBoUClOnXmRfFnKapQHRHY7DB3KoFIZ4aCel1i2K
 FCjE04coFg1cyf1JylDbYBVWOcoBrTo9gKIwrms6pvQ6nTNZDJTv5tzqi6a5bDverAzgk0KRVc0
 WNsFp+eFWHwvblAXh9w==
X-Proofpoint-GUID: Fc7l1DSzlQhgm7ZVxlcBeucHjgbHK4wA
X-Authority-Analysis: v=2.4 cv=ILgyzAvG c=1 sm=1 tr=0 ts=69eee39c cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=TtqV-g6YmW1Jfm2GSLaY:22 a=M5GUcnROAAAA:8
 a=Rnb2IiVPhaeNTfEEau8A:9 a=CjuIK1q_8ugA:10 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: Fc7l1DSzlQhgm7ZVxlcBeucHjgbHK4wA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_01,2026-04-21_02,2025-10-01_01
X-Rspamd-Queue-Id: 719BC46D009
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-281218-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,marvell.com:dkim,marvell.com:email];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[marvell.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]

On 2026-04-23 at 16:13:17, Ratheesh Kannoth (rkannoth@marvell.com) wrote:
> When cn20k default L2 rules are not installed,
> npc_cn20k_dft_rules_idx_get() leaves broadcast, multicast,
> promiscuous, and unicast slots at USHRT_MAX.
> npc_get_nixlf_mcam_index() previously returned that sentinel as a
> valid MCAM index, so callers could program hardware with an invalid
> index.
>
> Return -EINVAL from the cn20k branches of npc_get_nixlf_mcam_index()
> when the requested slot is still USHRT_MAX.  Harden cn20k NPC MCAM
> entry helpers to reject out-of-range indices before touching hardware.
>
> Drop the early bounds check in npc_enable_mcam_entry() for cn20k so
> invalid indices are validated inside npc_cn20k_enable_mcam_entry()
> instead of being silently ignored.
>
> In rvu_npc_update_flowkey_alg_idx(), treat negative MCAM indices like
> out-of-range values, and only update RSS actions for promiscuous and
> all-multi paths when the resolved index is non-negative.
>
> Cc: Suman Ghosh <sumang@marvell.com>
> Fixes: 6d1e70282f76 ("octeontx2-af: npc: cn20k: Use common APIs")
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
> ---
>  .../ethernet/marvell/octeontx2/af/cn20k/npc.c |  14 +-
>  .../ethernet/marvell/octeontx2/af/cn20k/npc.h |   1 +
>  .../ethernet/marvell/octeontx2/af/rvu_nix.c   |   3 +
>  .../ethernet/marvell/octeontx2/af/rvu_npc.c   | 138 +++++++++++++++++-
>  .../marvell/octeontx2/af/rvu_npc_fs.c         |  10 +-
>  .../marvell/octeontx2/af/rvu_npc_hash.c       |  19 ++-
>  .../marvell/octeontx2/nic/otx2_flows.c        |   1 +
>  7 files changed, 172 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
> index 54a25d9c5505..1b3f2421ea32 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
> @@ -808,6 +808,9 @@ npc_cn20k_enable_mcam_entry(struct rvu *rvu, int blkaddr,
>  	u64 cfg, hw_prio;
>  	u8 kw_type;
>
> +	if (index < 0 || index >= mcam->total_entries)
> +		return -EINVAL;
> +
>  	if (npc_mcam_idx_2_key_type(rvu, index, &kw_type))
>  		return -EINVAL;
>
> @@ -1056,6 +1059,9 @@ int npc_cn20k_config_mcam_entry(struct rvu *rvu, int blkaddr, int index,
>  	int kw = 0;
>  	u8 kw_type;
>
> +	if (index < 0 || index >= mcam->total_entries)
> +		return -EINVAL;
> +
>  	if (npc_mcam_idx_2_key_type(rvu, index, &kw_type))
>  		return -EINVAL;
>
> @@ -1148,6 +1154,9 @@ int npc_cn20k_copy_mcam_entry(struct rvu *rvu, int blkaddr, u16 src, u16 dest)
>  	int bank, i, sb, db;
>  	int dbank, sbank;
>
> +	if (src >= mcam->total_entries || dest >= mcam->total_entries)
> +		return -EINVAL;
> +
>  	dbank = npc_get_bank(mcam, dest);
>  	sbank = npc_get_bank(mcam, src);
>
> @@ -1213,6 +1222,9 @@ int npc_cn20k_read_mcam_entry(struct rvu *rvu, int blkaddr, u16 index,
>  	int kw = 0, bank;
>  	u8 kw_type;
>
> +	if (index >= mcam->total_entries)
> +		return -EINVAL;
> +
>  	if (npc_mcam_idx_2_key_type(rvu, index, &kw_type))
>  		return -EINVAL;
>
> @@ -4158,7 +4170,7 @@ int rvu_mbox_handler_npc_get_dft_rl_idxs(struct rvu *rvu, struct msg_req *req,
>  	return 0;
>  }
>
> -static bool npc_is_cgx_or_lbk(struct rvu *rvu, u16 pcifunc)
> +bool npc_is_cgx_or_lbk(struct rvu *rvu, u16 pcifunc)
>  {
>  	return is_pf_cgxmapped(rvu, rvu_get_pf(rvu->pdev, pcifunc)) ||
>  		is_lbk_vf(rvu, pcifunc);
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h
> index 2f761b97f91b..3d5eb952cc07 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h
> @@ -335,5 +335,6 @@ int npc_mcam_idx_2_key_type(struct rvu *rvu, u16 mcam_idx, u8 *key_type);
>  u16 npc_cn20k_vidx2idx(u16 index);
>  u16 npc_cn20k_idx2vidx(u16 idx);
>  int npc_cn20k_defrag(struct rvu *rvu);
> +bool npc_is_cgx_or_lbk(struct rvu *rvu, u16 pcifunc);
>
>  #endif /* NPC_CN20K_H */
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
> index ef5b081162eb..f977734ae712 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
> @@ -3577,6 +3577,9 @@ static int nix_update_mce_rule(struct rvu *rvu, u16 pcifunc,
>  	mcam_index = npc_get_nixlf_mcam_index(mcam,
>  					      pcifunc & ~RVU_PFVF_FUNC_MASK,
>  					      nixlf, type);
> +	if (mcam_index < 0)
> +		return -EINVAL;
> +
>  	err = nix_update_mce_list(rvu, pcifunc, mce_list,
>  				  mce_idx, mcam_index, add);
>  	return err;
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
> index 5d349d131fdb..611cd7fce245 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
> @@ -163,14 +163,35 @@ int npc_get_nixlf_mcam_index(struct npc_mcam *mcam,
>  		if (rc)
>  			return -EFAULT;
>
> +		if (is_lbk_vf(rvu, pcifunc)) {
> +			if (promisc == USHRT_MAX)
> +				return -EINVAL;
> +			return promisc;
> +		}
> +
> +		if (is_cgx_vf(rvu, pcifunc)) {
> +			if (ucast == USHRT_MAX)
> +				return -EINVAL;
> +
> +			return ucast;
> +		}
> +
>  		switch (type) {
>  		case NIXLF_BCAST_ENTRY:
> +			if (bcast == USHRT_MAX)
> +				return -EINVAL;
>  			return bcast;
>  		case NIXLF_ALLMULTI_ENTRY:
> +			if (mcast == USHRT_MAX)
> +				return -EINVAL;
>  			return mcast;
>  		case NIXLF_PROMISC_ENTRY:
> +			if (promisc == USHRT_MAX)
> +				return -EINVAL;
>  			return promisc;
>  		case NIXLF_UCAST_ENTRY:
> +			if (ucast == USHRT_MAX)
> +				return -EINVAL;
>  			return ucast;
>  		default:
>  			return -EINVAL;
> @@ -238,9 +259,6 @@ void npc_enable_mcam_entry(struct rvu *rvu, struct npc_mcam *mcam,
>  	int actbank = bank;
>
>  	if (is_cn20k(rvu->pdev)) {
> -		if (index < 0 || index >= mcam->banksize * mcam->banks)
> -			return;
> -
>  		if (npc_cn20k_enable_mcam_entry(rvu, blkaddr, index, enable))
>  			dev_err(rvu->dev, "Error to %s mcam %u entry\n",
>  				enable ? "enable" : "disable", index);
> @@ -434,6 +452,15 @@ static u64 npc_get_default_entry_action(struct rvu *rvu, struct npc_mcam *mcam,
>
>  	index = npc_get_nixlf_mcam_index(mcam, pf_func, nixlf,
>  					 NIXLF_UCAST_ENTRY);
> +
> +	if (index < 0) {
> +		dev_err(rvu->dev,
> +			"%s: failed to get ucast entry pcifunc:0x%x\n",
> +			__func__, pf_func);
> +		/* Action 0 is drop */
> +		return 0;
> +	}
> +
>  	bank = npc_get_bank(mcam, index);
>  	index &= (mcam->banksize - 1);
>
> @@ -700,6 +727,12 @@ void rvu_npc_install_ucast_entry(struct rvu *rvu, u16 pcifunc,
>
>  	index = npc_get_nixlf_mcam_index(mcam, pcifunc,
>  					 nixlf, NIXLF_UCAST_ENTRY);
> +	if (index < 0) {
> +		dev_err(rvu->dev,
> +			"%s: Error to get ucast entry for pcifunc=%#x\n",
> +			__func__, pcifunc);
> +		return;
> +	}
>
>  	/* Don't change the action if entry is already enabled
>  	 * Otherwise RSS action may get overwritten.
> @@ -755,11 +788,21 @@ void rvu_npc_install_promisc_entry(struct rvu *rvu, u16 pcifunc,
>  	index = npc_get_nixlf_mcam_index(mcam, pcifunc,
>  					 nixlf, NIXLF_PROMISC_ENTRY);
>
> +	/* In cn20k, default indexes are installed only for CGX mapped
> +	 * and lbk interfaces
> +	 */
>  	if (is_cgx_vf(rvu, pcifunc))
>  		index = npc_get_nixlf_mcam_index(mcam,
>  						 pcifunc & ~RVU_PFVF_FUNC_MASK,
>  						 nixlf, NIXLF_PROMISC_ENTRY);
>
> +	if (index < 0) {
> +		dev_err(rvu->dev,
> +			"%s: Error to get promisc entry for pcifunc=%#x\n",
> +			__func__, pcifunc);
> +		return;
> +	}
> +
>  	/* If the corresponding PF's ucast action is RSS,
>  	 * use the same action for promisc also
>  	 * Please note that for lbk(s) "index" and "ucast_idx"
> @@ -770,6 +813,12 @@ void rvu_npc_install_promisc_entry(struct rvu *rvu, u16 pcifunc,
>  	else
>  		ucast_idx = npc_get_nixlf_mcam_index(mcam, pcifunc,
>  						     nixlf, NIXLF_UCAST_ENTRY);
> +	if (ucast_idx < 0) {
> +		dev_err(rvu->dev,
> +			"%s: Error to get ucast/promisc entry for pcifunc=%#x\n",
> +			__func__, pcifunc);
> +		return;
> +	}
>
>  	if (is_mcam_entry_enabled(rvu, mcam, blkaddr, ucast_idx))
>  		*(u64 *)&action = npc_get_mcam_action(rvu, mcam,
> @@ -844,6 +893,14 @@ void rvu_npc_enable_promisc_entry(struct rvu *rvu, u16 pcifunc,
>
>  	index = npc_get_nixlf_mcam_index(mcam, pcifunc,
>  					 nixlf, NIXLF_PROMISC_ENTRY);
> +
> +	if (index < 0) {
> +		dev_err(rvu->dev,
> +			"%s: Error to get promisc entry for pcifunc=%#x\n",
> +			__func__, pcifunc);
> +		return;
> +	}
> +
>  	npc_enable_mcam_entry(rvu, mcam, blkaddr, index, enable);
>  }
>
> @@ -884,6 +941,12 @@ void rvu_npc_install_bcast_match_entry(struct rvu *rvu, u16 pcifunc,
>
>  	index = npc_get_nixlf_mcam_index(mcam, pcifunc,
>  					 nixlf, NIXLF_BCAST_ENTRY);
> +	if (index < 0) {
> +		dev_err(rvu->dev,
> +			"%s: Error to get bcast entry for pcifunc=%#x\n",
> +			__func__, pcifunc);
> +		return;
> +	}
>
>  	if (!hw->cap.nix_rx_multicast) {
>  		/* Early silicon doesn't support pkt replication,
> @@ -948,12 +1011,25 @@ void rvu_npc_install_allmulti_entry(struct rvu *rvu, u16 pcifunc, int nixlf,
>
>  	index = npc_get_nixlf_mcam_index(mcam, pcifunc,
>  					 nixlf, NIXLF_ALLMULTI_ENTRY);
> +	if (index < 0) {
> +		dev_err(rvu->dev,
> +			"%s: Error to get mcast entry for pcifunc=%#x\n",
> +			__func__, pcifunc);
> +		return;
> +	}
>
>  	/* If the corresponding PF's ucast action is RSS,
>  	 * use the same action for multicast entry also
>  	 */
>  	ucast_idx = npc_get_nixlf_mcam_index(mcam, pcifunc,
>  					     nixlf, NIXLF_UCAST_ENTRY);
> +	if (ucast_idx < 0) {
> +		dev_err(rvu->dev,
> +			"%s: Error to get ucast entry for pcifunc=%#x\n",
> +			__func__, pcifunc);
> +		return;
> +	}
> +
>  	if (is_mcam_entry_enabled(rvu, mcam, blkaddr, ucast_idx))
>  		*(u64 *)&action = npc_get_mcam_action(rvu, mcam,
>  							blkaddr, ucast_idx);
> @@ -1018,6 +1094,13 @@ void rvu_npc_enable_allmulti_entry(struct rvu *rvu, u16 pcifunc, int nixlf,
>
>  	index = npc_get_nixlf_mcam_index(mcam, pcifunc, nixlf,
>  					 NIXLF_ALLMULTI_ENTRY);
> +	if (index < 0) {
> +		dev_err(rvu->dev,
> +			"%s: Error to get mcast entry for pcifunc=%#x\n",
> +			__func__, pcifunc);
> +		return;
> +	}
> +
>  	npc_enable_mcam_entry(rvu, mcam, blkaddr, index, enable);
>  }
>
> @@ -1130,8 +1213,12 @@ void rvu_npc_update_flowkey_alg_idx(struct rvu *rvu, u16 pcifunc, int nixlf,
>  		index = mcam_index;
>  	}
>
> -	if (index >= mcam->total_entries)
> +	if (index < 0 || index >= mcam->total_entries) {
> +		dev_err(rvu->dev,
> +			"%s: Invalid mcam index, pcifunc=%#x\n",
> +			__func__, pcifunc);
>  		return;
> +	}
>
>  	bank = npc_get_bank(mcam, index);
>  	index &= (mcam->banksize - 1);
> @@ -1175,16 +1262,18 @@ void rvu_npc_update_flowkey_alg_idx(struct rvu *rvu, u16 pcifunc, int nixlf,
>  		/* If PF's promiscuous  entry is enabled,
>  		 * Set RSS action for that entry as well
>  		 */
> -		npc_update_rx_action_with_alg_idx(rvu, action, pfvf, index,
> -						  blkaddr, alg_idx);
> +		if (index >= 0)
> +			npc_update_rx_action_with_alg_idx(rvu, action, pfvf, index,
> +							  blkaddr, alg_idx);
>
>  		index = npc_get_nixlf_mcam_index(mcam, pcifunc,
>  						 nixlf, NIXLF_ALLMULTI_ENTRY);
>  		/* If PF's allmulti  entry is enabled,
>  		 * Set RSS action for that entry as well
>  		 */
> -		npc_update_rx_action_with_alg_idx(rvu, action, pfvf, index,
> -						  blkaddr, alg_idx);
> +		if (index >= 0)
> +			npc_update_rx_action_with_alg_idx(rvu, action, pfvf, index,
> +							  blkaddr, alg_idx);
>  	}
>  }
>
> @@ -1197,12 +1286,22 @@ void npc_enadis_default_mce_entry(struct rvu *rvu, u16 pcifunc,
>  	int index, blkaddr, mce_idx;
>  	struct rvu_pfvf *pfvf;
>
> +	/* multicast pkt replication is not enabled for AF's VFs & SDP links */
> +	if (is_lbk_vf(rvu, pcifunc) || is_sdp_pfvf(rvu, pcifunc))
> +		return;
> +
>  	blkaddr = rvu_get_blkaddr(rvu, BLKTYPE_NPC, 0);
>  	if (blkaddr < 0)
>  		return;
>
>  	index = npc_get_nixlf_mcam_index(mcam, pcifunc & ~RVU_PFVF_FUNC_MASK,
>  					 nixlf, type);
> +	if (index < 0) {
> +		dev_err(rvu->dev,
> +			"%s: Error to get entry for pcifunc=%#x, type=%u\n",
> +			__func__, pcifunc, type);
> +		return;
> +	}
>
>  	/* disable MCAM entry when packet replication is not supported by hw */
>  	if (!hw->cap.nix_rx_multicast && !is_vf(pcifunc)) {
> @@ -1231,6 +1330,10 @@ static void npc_enadis_default_entries(struct rvu *rvu, u16 pcifunc,
>  	struct npc_mcam *mcam = &rvu->hw->mcam;
>  	int index, blkaddr;
>
> +	/* only CGX or LBK interfaces have default entries */
> +	if (is_cn20k(rvu->pdev) && !npc_is_cgx_or_lbk(rvu, pcifunc))
> +		return;
> +
>  	blkaddr = rvu_get_blkaddr(rvu, BLKTYPE_NPC, 0);
>  	if (blkaddr < 0)
>  		return;
> @@ -1240,6 +1343,12 @@ static void npc_enadis_default_entries(struct rvu *rvu, u16 pcifunc,
>  				     pfvf->nix_rx_intf)) {
>  		index = npc_get_nixlf_mcam_index(mcam, pcifunc,
>  						 nixlf, NIXLF_UCAST_ENTRY);
> +		if (index < 0) {
> +			dev_err(rvu->dev,
> +				"%s: Error to get ucast entry for pcifunc=%#x\n",
> +				__func__, pcifunc);
> +			return;
> +		}
>  		npc_enable_mcam_entry(rvu, mcam, blkaddr, index, enable);
>  	}
>
> @@ -3897,6 +4006,13 @@ int rvu_mbox_handler_npc_read_base_steer_rule(struct rvu *rvu,
>  	/* Read the default ucast entry if there is no pkt steering rule */
>  	index = npc_get_nixlf_mcam_index(mcam, pcifunc, nixlf,
>  					 NIXLF_UCAST_ENTRY);
> +	if (index < 0) {
> +		dev_err(rvu->dev,
> +			"%s: Error to get ucast entry for pcifunc=%#x\n",
> +			__func__, pcifunc);
> +		goto out;
> +	}
> +
>  read_entry:
>  	/* Read the mcam entry */
>  	npc_read_mcam_entry(rvu, mcam, blkaddr, index, &rsp->entry, &intf,
> @@ -3970,6 +4086,12 @@ void rvu_npc_clear_ucast_entry(struct rvu *rvu, int pcifunc, int nixlf)
>
>  	ucast_idx = npc_get_nixlf_mcam_index(mcam, pcifunc,
>  					     nixlf, NIXLF_UCAST_ENTRY);
> +	if (ucast_idx < 0) {
> +		dev_err(rvu->dev,
> +			"%s: Error to get ucast entry for pcifunc=%#x\n",
> +			__func__, pcifunc);
> +		return;
> +	}
>
>  	npc_enable_mcam_entry(rvu, mcam, blkaddr, ucast_idx, false);
>
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
> index dd5d50d52964..d20eb0e47d7d 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
> @@ -1444,7 +1444,7 @@ static int npc_install_flow(struct rvu *rvu, int blkaddr, u16 target,
>  	struct msg_rsp write_rsp;
>  	struct mcam_entry *entry;
>  	bool new = false;
> -	u16 entry_index;
> +	int entry_index;
>  	int err;
>
>  	installed_features = req->features;
> @@ -1477,6 +1477,14 @@ static int npc_install_flow(struct rvu *rvu, int blkaddr, u16 target,
>  	if (req->default_rule) {
>  		entry_index = npc_get_nixlf_mcam_index(mcam, target, nixlf,
>  						       NIXLF_UCAST_ENTRY);
> +
> +		if (entry_index < 0) {
> +			dev_err(rvu->dev,
> +				"%s: Error to get ucast entry for target=%#x\n",
> +				__func__, target);
> +			return -EINVAL;
> +		}
> +
>  		enable = is_mcam_entry_enabled(rvu, mcam, blkaddr, entry_index);
>  	}
>
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.c
> index 03bb485a1aca..59c1a105faad 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.c
> @@ -1753,7 +1753,7 @@ int rvu_npc_exact_mac_addr_set(struct rvu *rvu, struct cgx_mac_addr_set_or_get *
>  	u32 seq_id = req->index;
>  	struct rvu_pfvf *pfvf;
>  	u8 cgx_id, lmac_id;
> -	u32 mcam_idx = -1;
> +	int mcam_idx = -1;
>  	int rc, nixlf;
>
>  	rvu_get_cgx_lmac_id(rvu->pf2cgxlmac_map[pf], &cgx_id, &lmac_id);
> @@ -1783,9 +1783,20 @@ int rvu_npc_exact_mac_addr_set(struct rvu *rvu, struct cgx_mac_addr_set_or_get *
>
>  	/* find mcam entry if exist */
>  	rc = nix_get_nixlf(rvu, req->hdr.pcifunc, &nixlf, NULL);
> -	if (!rc) {
> -		mcam_idx = npc_get_nixlf_mcam_index(&rvu->hw->mcam, req->hdr.pcifunc,
> -						    nixlf, NIXLF_UCAST_ENTRY);
> +	if (rc) {
> +		dev_err(rvu->dev,
> +			"%s: Error to get nixlf pcifunc=%#x\n",
> +			__func__, req->hdr.pcifunc);
> +		return LMAC_AF_ERR_PERM_DENIED;
> +	}
> +
> +	mcam_idx = npc_get_nixlf_mcam_index(&rvu->hw->mcam, req->hdr.pcifunc,
> +					    nixlf, NIXLF_UCAST_ENTRY);
> +	if (mcam_idx < 0) {
> +		dev_err(rvu->dev,
> +			"%s: Error to get ucast entry for pcifunc=%#x\n",
> +			__func__, req->hdr.pcifunc);
> +		return LMAC_AF_ERR_INVALID_PARAM;
>  	}
>
>  	rc = rvu_npc_exact_add_table_entry(rvu, cgx_id, lmac_id, req->mac_addr,
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
> index 5dd0591fed99..b2d777b5cb59 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
> @@ -340,6 +340,7 @@ int otx2_mcam_entry_init(struct otx2_nic *pfvf)
>  	req->kw_type = NPC_MCAM_KEY_X2;
>  	if (is_cn20k(pfvf->pdev) && kw_type == NPC_MCAM_KEY_X4) {
>  		req->kw_type = NPC_MCAM_KEY_X4;
> +		/* In X4 profile, x4_slots is equal to bank depth */
>  		ref &= (x4_slots - 1);
>  	}
>  	req->contig = false;
> --
> 2.43.0
>

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.c
>> index 03bb485a1aca18..59c1a105faad5f 100644
>> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.c
>> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.c
>[ ... ]
>> @@ -1783,9 +1783,20 @@ int rvu_npc_exact_mac_addr_set(struct rvu *rvu, struct cgx_mac_addr_set_or_get *
>>
>>  	/* find mcam entry if exist */
>>  	rc = nix_get_nixlf(rvu, req->hdr.pcifunc, &nixlf, NULL);
>> -	if (!rc) {
>> -		mcam_idx = npc_get_nixlf_mcam_index(&rvu->hw->mcam, req->hdr.pcifunc,
>> -						    nixlf, NIXLF_UCAST_ENTRY);
>> +	if (rc) {
>> +		dev_err(rvu->dev,
>> +			"%s: Error to get nixlf pcifunc=%#x\n",
>> +			__func__, req->hdr.pcifunc);
>> +		return LMAC_AF_ERR_PERM_DENIED;
>> +	}
>> +
>> +	mcam_idx = npc_get_nixlf_mcam_index(&rvu->hw->mcam, req->hdr.pcifunc,
>> +					    nixlf, NIXLF_UCAST_ENTRY);
>Does returning LMAC_AF_ERR_PERM_DENIED here prevent configuring the MAC address
>when the interface is down?
>Previously, if nix_get_nixlf() failed (which happens when the interface is
>down and no NIXLF is attached), the code simply skipped fetching the MCAM
>index and left mcam_idx as -1, but continued successfully to register the MAC
>address via rvu_npc_exact_add_table_entry().

ACK. Will revert this change. There is no issue even if mcam_idx is -1 when added to list

