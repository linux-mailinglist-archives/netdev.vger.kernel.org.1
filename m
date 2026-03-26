Return-Path: <netdev+bounces-271878-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WFkjMIHaxGkq4gQAu9opvQ
	(envelope-from <netdev+bounces-271878-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 08:04:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 26ECB3302E2
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 08:04:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 99A5D30A77EA
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 07:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741523385BC;
	Thu, 26 Mar 2026 07:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="cadSueIs"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C5933D6C7;
	Thu, 26 Mar 2026 07:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774508461; cv=none; b=UiZ1G2cvHaz5+dYizDXj/c+mYMvSa9nUoTXYrawOf7X1exNNIpp87aOqifGSRyJfHvHMzrnpHySwXN1yvxLqOEDX9V6c1v0OCWcACq/tQ9pha1FhhQaSaJgWXRFl5GGCqBSAclBPmK4MnVksoZh0qjFOBdxLr0hFKGLnz2FZmuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774508461; c=relaxed/simple;
	bh=w28pNfBDG4Z68s0nlXT6h8IFyXvupvDjbdmIZ72WHOw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BYCkKGBJtiP4tKWC9F+B32axlSdOuiSByPsit7OGcRmPY5dI4ypk0J82sCMa2ZtpguMftuwMSL7cHhfKsvS1VOW0WGW+zr37rNAlRTN0RClhF7SPMKAzzwmfPGFs5Z79jmv0OAsYYZMpdiYax8cb5oPCNxQuWCOWl75V6sI+sr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=cadSueIs; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62PISfHk3460518;
	Thu, 26 Mar 2026 00:00:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=wHJFTGnWTTR7Yz76f4is6E4xI
	5jIOmbM58n2FiDd+p4=; b=cadSueIs9N+Lrc7duvAeHz4COIiT25TNStunqbz83
	yLPCY6Pc1oIaNh7blzP7AaXeTk7DnG5qB2hnAm79CPZfIOKnp8cutIQhz9vP5NWV
	O7EMQeVdiqWF+PzgvEUYPgFnQWfQKPF3iUY6L4ZEQqm4FBMqwLBw88KR8Jz7rjnQ
	iS6J7PcTC4C7VETn+hu+03duNFnnAd6ySzFhY0YjAaq4JS9dE8wK9rOvb6VU4gbX
	35fapxETv+bAExyhgCPGtJbxPQkQEbU75xg4DsvoFlKJghqpHe8kJKF6yIqaL50I
	YrmOH5FUnkP3e+ysclgFpcgGOTDPrt6rJxL+BneAPc3XA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4d4b7hb6uh-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Mar 2026 00:00:38 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 26 Mar 2026 00:00:35 -0700
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 26 Mar 2026 00:00:35 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 26 Mar 2026 00:00:35 -0700
Received: from kernel-ep2 (unknown [10.29.36.53])
	by maili.marvell.com (Postfix) with SMTP id BE49A3F7077;
	Thu, 26 Mar 2026 00:00:31 -0700 (PDT)
Date: Thu, 26 Mar 2026 12:30:30 +0530
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: Simon Horman <horms@kernel.org>
CC: <kuba@kernel.org>, <gakula@marvell.com>, <bbhushan2@marvell.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <davem@davemloft.net>, <andrew+netdev@lunn.ch>, <edumazet@google.com>,
        <pabeni@redhat.com>, <sgoutham@marvell.com>
Subject: Re: [net-next PATCH v2 4/4] octeontx2-pf: cn20k: Use unified Halo
 context
Message-ID: <20260326070030.GA1276961@kernel-ep2>
References: <1773920826-16985-5-git-send-email-sbhatta@marvell.com>
 <20260320165037.96305-1-horms@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260320165037.96305-1-horms@kernel.org>
X-Authority-Analysis: v=2.4 cv=b4q/I9Gx c=1 sm=1 tr=0 ts=69c4d996 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=qit2iCtTFQkLgVSMPQTB:22 a=9R54UkLUAAAA:8
 a=VwQbUJbxAAAA:8 a=hM8Av25v_7ZSUbZF0EwA:9 a=CjuIK1q_8ugA:10
 a=YTcpBFlVQWkNscrzJ_Dz:22
X-Proofpoint-ORIG-GUID: cfYzsdCj9b_rbahtQRhw92nV947suUmK
X-Proofpoint-GUID: cfYzsdCj9b_rbahtQRhw92nV947suUmK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDA1MSBTYWx0ZWRfX7CfhkEw1gY2I
 Y5+f17Y7e14WRE5tgNPkacajP4ylMVo7+U/8P8UtDTtk8fGAXfWCxtveKmMd42DQ8KQKUKzigya
 TRX7rVRW03cE1gayQgledQgOViYj5qRnstlc6IaoTqttdQ/41kiiRIsW2gF5uQu4dLXF0DwaOj3
 TemdAXGtFSW3uvQTGp3AHlJc3CsdfntqVqPyZKiLT3szKy5ubFdYGszQHbcFJAB3qncJeh7TPLD
 Q/U3AkplmLHvBmLMwTQvzZoum3ad1AyIyFb5DKJqltj7J4qMTkVxXEKyDA1gevPcKl0CO8G50Zg
 H4RapFxApmOE5PDEGxENfnN+++YqEd3zQqjPdRe//1HXfPL2gKlCpe+PD7Z2C1Eu8seayucJmEB
 rlXtspwuA/x5AnsUUn/DAe/qHokTXCHracZ/iH0i08NCoerT5A4Jhowpg2X9wEbXGvZ1lRCb+kD
 TlPhsZF6892y+3wXPsg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_02,2026-03-24_01,2025-10-01_01
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-271878-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,marvell.com:dkim,linux.dev:url];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[marvell.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sbhatta@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 26ECB3302E2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026-03-20 at 22:20:37, Simon Horman (horms@kernel.org) wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> 
> For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
> ---
> octeontx2-pf: cn20k: Use unified Halo context
> 
> Use unified Halo context present in CN20K hardware for
> octeontx2 netdevs instead of aura and pool contexts.
> 
> > diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/cn20k.c b/drivers/net/ethernet/marvell/octeontx2/nic/cn20k.c
> > --- a/drivers/net/ethernet/marvell/octeontx2/nic/cn20k.c
> > +++ b/drivers/net/ethernet/marvell/octeontx2/nic/cn20k.c
> 
> [ ... ]
> 
> > +int cn20k_npa_alloc_dpc(struct otx2_nic *nic)
> > +{
> > +	struct npa_cn20k_dpc_alloc_req *req;
> > +	struct npa_cn20k_dpc_alloc_rsp *rsp;
> > +	int err;
> > +
> > +	req = otx2_mbox_alloc_msg_npa_cn20k_dpc_alloc(&nic->mbox);
> > +	if (!req)
> > +		return -ENOMEM;
> > +
> > +	/* Count successful ALLOC requests only */
> > +	req->dpc_conf = 1ULL << 4;
> > +
> > +	err = otx2_sync_mbox_msg(&nic->mbox);
> > +	if (err)
> > +		return err;
> > +
> > +	rsp = (struct npa_cn20k_dpc_alloc_rsp *)otx2_mbox_get_rsp(&nic->mbox.mbox,
> > +								  0, &req->hdr);
> > +	if (IS_ERR(rsp))
> > +		return PTR_ERR(rsp);
> > +
> > +	nic->npa_dpc = rsp->cntr_id;
> > +
> > +	return 0;
> > +}
> 
> [ ... ]
> 
> > diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> > --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> > +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> > @@ -1651,6 +1651,9 @@ int otx2_init_hw_resources(struct otx2_nic *pf)
> >  	if (!is_otx2_lbkvf(pf->pdev))
> >  		otx2_nix_config_bp(pf, true);
> >
> > +	if (is_cn20k(pf->pdev))
> > +		cn20k_npa_alloc_dpc(pf);
>                 ^^^^^^^^^^^^^^^^^^^^^
> 
> Should the return value of cn20k_npa_alloc_dpc() be checked here?
> 
DPC counters are for debugging only we can proceed if counter was not
allocated.

> Looking at cn20k_npa_alloc_dpc(), it can return -ENOMEM or errors from
> otx2_sync_mbox_msg() or PTR_ERR() from otx2_mbox_get_rsp(). If the DPC
> counter allocation fails, pf->npa_dpc remains 0 (from struct
> zero-initialization).
> 
> Then cn20k_halo_aq_init() configures all NPA auras with
> aq->halo.op_dpc_set = pfvf->npa_dpc (= 0), referencing an unallocated
> DPC performance counter. On teardown, cn20k_npa_free_dpc() sends a mbox
> message to free counter ID 0, which was never allocated.
Agreed. Will add npa_dpc_valid flag and based on that only will use
pfvf->npa_dpc to fix this.

Thanks,
Sundeep
> 
> Every other error-returning mbox operation in this function checks the
> return value and jumps to an error label on failure. Should this follow
> the same pattern?
> 
> > +
> >  	/* Init Auras and pools used by NIX RQ, for free buffer ptrs */
> >  	err = otx2_rq_aura_pool_init(pf);
> >  	if (err) {
> 
> [ ... ]

