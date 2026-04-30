Return-Path: <netdev+bounces-282656-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yIz7JyPY8mnIugEAu9opvQ
	(envelope-from <netdev+bounces-282656-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 06:18:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 353FD49D473
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 06:18:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4F4E1300694F
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 04:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4EA6278156;
	Thu, 30 Apr 2026 04:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="YtnXLyfI"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB620363082;
	Thu, 30 Apr 2026 04:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777522680; cv=none; b=o8UKC77nfPuq2sEUS5kUelhpS83d9PCIMjl1K1jln3KJ3uNeehrG1+6fVoBFh2GIoqLAXwr84EaK1NmNbCHheS+HuaScpxNXQrtArda6kabezUZlSV6g6A8TDvkro7U/n8g2kk3K3q4gnFgOYm9buIkc7SrpB+W4PW1oFrrN120=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777522680; c=relaxed/simple;
	bh=cSFysApwCEa8FMGVM3AeIOfzDZNVjlsXq40aCUF7i70=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E3R35vSaHsVxLq6iyZxji3efvUIPXFLbEQLnOW1bw73RoxlSRu8eueWo/MwJf9aYOAj2I3ZLTQcWeTpPXnxYluGkcH5Rrk/4OLIFT4uwt4S+W5tneDMfhKrUajzwc+0knfTPRCdo5+lhD8SBiLE9CiCkOxy77uei1Ztdxr3l98o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=YtnXLyfI; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63TLC6Xj1642493;
	Wed, 29 Apr 2026 21:17:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=m3p6aC+JuHTR/oYkTFEt4NMia
	TeB/vPEbaWZEy1oAws=; b=YtnXLyfIFEBImGeKDfBdVx3riKrKeJevmes1YI5pr
	mzoDniI1QMQRxqvqt0o/r7ygRmzlhOh8UqfGulpj2ZSzmabZ5GzoKWXWCBOFFkNc
	Ka3U51HCrBdw3rm4+viphsirFzN2NOMzD/p/FmdjDbqSsSgpcVuYWWiQ6jY5XUCm
	fUrBQWB6xqJjfZyQ9KNHtzdutGTopB0jMgVRzANTMtUq8VdjDIc0vWTw3+y2bXxb
	J4h/ogs+c+MDUoZWrghGLPELzqojPd+fzZk5rdLnPEKSQpIHQDOuVSf1e70rRPR0
	V/Tusa4d1kmHF3uRA4X3HbqSwecNiBnJTBVV6Fvu/sfGw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4duet8aupa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Apr 2026 21:17:19 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 29 Apr 2026 21:17:19 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 29 Apr 2026 21:17:18 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 86D753F7079;
	Wed, 29 Apr 2026 21:17:15 -0700 (PDT)
Date: Thu, 30 Apr 2026 09:47:14 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
        Suman Ghosh
	<sumang@marvell.com>
Subject: Re: [PATCH v5 net 10/10] octeontx2-af: npc: cn20k: Reject missing
 default-rule MCAM indices
Message-ID: <afLXyr7q5RX6flPH@rkannoth-OptiPlex-7090>
References: <20260429022722.1110289-1-rkannoth@marvell.com>
 <20260429022722.1110289-11-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260429022722.1110289-11-rkannoth@marvell.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDA0MCBTYWx0ZWRfX7xQcihbvrZR9
 dEeYZpouKqwqfmLEulKdYHDCeDjP0hn54gaq7DzQUclYxXKji7QYY5SIBP/Whn1sUP6jQHHo8cf
 zH4c5d991N2JfpU4pm8cbeWN5ngml1V63WgzgBsVEeAfNrcUg0Qyrqchwu1SZs1NGfBIPRNEyiT
 jQkiFPzGgFSGQFufGSCUPfF55pKzYkTo5MEywKLnpAg581PdodY4AdY7bNZ0AKBZ5+usPFiLCKI
 AaWgSLxIFzNHfH6qnHbPWrCJE8Wz7NxucoEg7T7RpLb1gMjZHJ/uAEMvv3lBQZuLWaaQa9rq7dH
 ZGrMFSGKXo9nJFV2sGyYLPq+q0YAwQ0L+MGyvBviDsoyPJYDJPJRPzbCNstwWlvlPA6GwDv7Qsg
 sko8CGwfqYjU1yRw7oVLb98sa0d0oOsnJOmL6GVUqu95SzsS1nPRCt6ArNqvz+emdr5ydN4FgpT
 JEh3wmObQQRVDjd/OWw==
X-Proofpoint-ORIG-GUID: L7yzo6fHuiL5i0tq3fySborrilfdR33A
X-Authority-Analysis: v=2.4 cv=NqDhtcdJ c=1 sm=1 tr=0 ts=69f2d7d0 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=TtqV-g6YmW1Jfm2GSLaY:22 a=M5GUcnROAAAA:8
 a=Lkl9sytwHSjNhrI-srIA:9 a=CjuIK1q_8ugA:10 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: L7yzo6fHuiL5i0tq3fySborrilfdR33A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_01,2026-04-28_01,2025-10-01_01
X-Rspamd-Queue-Id: 353FD49D473
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-282656-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[marvell.com:dkim,marvell.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[marvell.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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

On 2026-04-29 at 07:57:22, Ratheesh Kannoth (rkannoth@marvell.com) wrote:
> When cn20k default L2 rules are not installed,
> npc_cn20k_dft_rules_idx_get() leaves broadcast, multicast, promiscuous, and
> unicast slots at USHRT_MAX. npc_get_nixlf_mcam_index() previously returned
> that sentinel as a valid MCAM index, so callers could program hardware with
> an invalid index.
>
> Return -EINVAL from the cn20k branches of npc_get_nixlf_mcam_index() when
> the requested slot is still USHRT_MAX. Harden cn20k NPC MCAM entry helpers
> to reject out-of-range indices before touching hardware.
>
> Drop the early bounds check in npc_enable_mcam_entry() for cn20k so invalid
> indices are validated inside npc_cn20k_enable_mcam_entry() instead of being
> silently ignored.
>
> In rvu_npc_update_flowkey_alg_idx(), treat negative MCAM indices like
> out-of-range values, and only update RSS actions for promiscuous and
> all-multi paths when the resolved index is non-negative.
>

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
> index 5d349d131fdb..3c814d157ab9 100644
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
[ ... ]
> @@ -3897,6 +4006,12 @@ int rvu_mbox_handler_npc_read_base_steer_rule(struct rvu *rvu,
>  	/* Read the default ucast entry if there is no pkt steering rule */
>  	index = npc_get_nixlf_mcam_index(mcam, pcifunc, nixlf,
>  					 NIXLF_UCAST_ENTRY);
> +	if (index < 0) {
> +		mutex_unlock(&mcam->lock);
> +		rc = NIX_AF_ERR_AF_LF_INVALID;
> +		goto out;
> +	}
> +
>Could this change cause a regression in the cn20k-specific base steer rule
>handler?
>While this generic handler correctly returns an explicit error when
>npc_get_nixlf_mcam_index() returns a negative value, it looks like
>rvu_mbox_handler_npc_cn20k_read_base_steer_rule() in
>drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c was missed.
>In that function, rc is 0 from the preceding successful call to
>nix_get_nixlf():
This is not an issue introduced by this fix patch. I agree that this is an issue, but should
be addressed as another net patch as fix.

>While this generic handler correctly returns an explicit error when
>npc_get_nixlf_mcam_index() returns a negative value, it looks like
>rvu_mbox_handler_npc_cn20k_read_base_steer_rule() in
>drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c was missed.
>In that function, rc is 0 from the preceding successful call to
>nix_get_nixlf():
>drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c:
>rvu_mbox_handler_npc_cn20k_read_base_steer_rule() {
    ...
	rc = nix_get_nixlf(rvu, pcifunc, &nixlf, NULL);
	if (rc < 0) {
		mutex_unlock(&mcam->lock);
		goto out;
	}
	rl_type = rvu_npc_get_base_steer_rule_type(rvu, pcifunc);
	/* Read the default ucast entry if there is no pkt steering rule */
	index = npc_get_nixlf_mcam_index(mcam, pcifunc, nixlf, rl_type);
	if (index < 0) {
		mutex_unlock(&mcam->lock);
		goto out;
	}
    ...
out:
	return rc;
}
>Does this now silently return 0 (Success) instead of propagating the error
>when index < 0? This seems like it could leak an uninitialized or zeroed
>rsp->entry payload back to the VF.
This is not an issue introduced by this fix patch. I agree that this is an issue, but should
be addressed as another net patch as fix.

