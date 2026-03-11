Return-Path: <netdev+bounces-266442-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kL4zN3besGkuoAIAu9opvQ
	(envelope-from <netdev+bounces-266442-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 04:16:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5750825B54D
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 04:16:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 529FE30068D3
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 03:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D9252459EA;
	Wed, 11 Mar 2026 03:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="JuHK6XUX"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64078175A99;
	Wed, 11 Mar 2026 03:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773198963; cv=none; b=UlaHoMoSDeqsH2CCqWLT+4Cu3OG7sZUZaYg4G58EBHquOhb4tW5qjESypDNe7XiSpv1Ce/NHNQ/Bq7qiXoPPXNQGTbrihRiSicHEo2MVOsii627r/F29+nKBDHEsB4tvzEvRjrtg+0XimsAazCTdHzaxH8bN3cONXMi4u8psGBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773198963; c=relaxed/simple;
	bh=QPcJ8jZUH2sfb7hNjP7vTt9+OoV9t4CLiVPnXUfFiU8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C4XCiS7SVJoNpF5wgPeiKzeoHBuwFW6Bed9HKbHVpMBSXZJCBxShdIJORa9rNWVwMd5dP9Q8AfkQ+tOr5k8utdduUK6gCUi3nBtYwO6Z5O/MxgwR/mZ1InOAYBNIJ6fNfK2yniGrpOwkqoNKQz9LChCKfbnBVHk5DBW1RWw1vD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=JuHK6XUX; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62AIfwQH2703098;
	Tue, 10 Mar 2026 20:15:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=bE2FtQnyEkYE0v+wHyCSVWfNH
	J0RH1kxlWM7Q1PAZoc=; b=JuHK6XUX0S3MAS8/d55yJ3NLtb2FTY0iIlUzS0lYC
	0sKpckJI22slWk8jnuSyNGGitkjdyMGGEfDV4zblaFSMSLjMd/EOSfpaPvWd5Z84
	RfcQ3GG6u0Fs+VCd9sm8I6eM4BGXxfPDh84DmtOjF5h7MBAPkERW1dD8sIKOwY1q
	yLNM1kDPNl+SWVK6fQV3UwlxyovuB+a9NNz8A4jBIQfBgcvz8S0A8aVcXBgVepCL
	5T5mdLxAG+8MdduoRh8dk2QSk+R1vNs6egLOVx+PjSzxyc6TB9LMHLhng3rbZWtY
	bhsjS1pRMfNKxEzZQDWUZafH9BgOfC3stSQFNXvEW+gsQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4cte7r3bx9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Mar 2026 20:15:48 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 10 Mar 2026 20:15:47 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 10 Mar 2026 20:15:46 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 1C63A3F7075;
	Tue, 10 Mar 2026 20:15:41 -0700 (PDT)
Date: Wed, 11 Mar 2026 08:45:40 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: Simon Horman <horms@kernel.org>
CC: <cjubran@nvidia.com>, <matttbe@kernel.org>, <chuck.lever@oracle.com>,
        <shshitrit@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <sgoutham@marvell.com>, <jiri@resnulli.us>,
        <davem@davemloft.net>, <saeedm@nvidia.com>, <kuba@kernel.org>,
        <edumazet@google.com>, <pabeni@redhat.com>, <donald.hunter@gmail.com>
Subject: Re: [v3,net-next,5/5] octeontx2-af: Add support for loading custom
 KPU profile from filesystem
Message-ID: <abDeXLpMMxp7G1v3@rkannoth-OptiPlex-7090>
References: <20260309024619.898211-6-rkannoth@marvell.com>
 <20260310172100.890161-1-horms@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260310172100.890161-1-horms@kernel.org>
X-Proofpoint-GUID: WXAt5IGsay1BrMjFBgH16XdUBCMSmdZj
X-Authority-Analysis: v=2.4 cv=boxBxUai c=1 sm=1 tr=0 ts=69b0de64 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=EAYMVhzMl8SCOHhVQcBL:22 a=9R54UkLUAAAA:8
 a=VwQbUJbxAAAA:8 a=auikOzqnW37tgpLpNAgA:9 a=CjuIK1q_8ugA:10
 a=YTcpBFlVQWkNscrzJ_Dz:22
X-Proofpoint-ORIG-GUID: WXAt5IGsay1BrMjFBgH16XdUBCMSmdZj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDAyNSBTYWx0ZWRfX02E7BjX0mlNn
 azPKRidA2PQuoYvxxt18t8EWkN/hvttURcuBVeRN82xtBJ/O4BbC7VhfcaE0w5Hu7uQ8FPABUwH
 vnNVo9yGeU1rZBQ8bdoxfaNt2UnFtolqI584/cJR9gK+EJ3RFsm1ZzO+RO2p4ADy9X/sD4SX/wA
 KnAwJ2vB3KT8SNHqUCmuCDV1V3Mz/0wKk7Fm5P1LKds4y3Mxnt9KxiGt5CA0RWoSRZ1IDBmM7CE
 MUdRKirkLPKWfY5bOWaaYNiSovewMlwrmmMvWmTFkCuzT8RuHX1XeoUG8Ospr3WkIuuj/G3BcVq
 Gl0gTBYZnnSmyhMUvZelomw05YJIIVgQhZ3KZBW1FixlpZRWh9HqL0C6Z4Kzj6VZUhyZo3RoOHN
 n0z38iDcbP7TvSvfjaJK6nDtxf243jVlQw6WQzPjJgK7Bcuqy3oHFFQEdjZn1lxhNbI5nA3xV+C
 NPxusp3gNbGx7sqaYfg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_05,2026-03-09_02,2025-10-01_01
X-Rspamd-Queue-Id: 5750825B54D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-266442-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[nvidia.com,kernel.org,oracle.com,vger.kernel.org,marvell.com,resnulli.us,davemloft.net,google.com,redhat.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Action: no action

On 2026-03-10 at 22:51:00, Simon Horman (horms@kernel.org) wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
>
> For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
> ---
> octeontx2-af: Add support for loading custom KPU profile from filesystem
>
> This commit adds functionality to load custom KPU (Key Parse Unit)
> profiles from the filesystem at module load time, providing an
> alternative to flashing updated firmware on deployed devices.
>
> > diff --git a/drivers/net/ethernet/marvell/octeontx2/af/npc.h b/drivers/net/ethernet/marvell/octeontx2/af/npc.h
> > index cefc5d70f3e4..5928c4d3cc8b 100644
> > --- a/drivers/net/ethernet/marvell/octeontx2/af/npc.h
> > +++ b/drivers/net/ethernet/marvell/octeontx2/af/npc.h
>
> [ ... ]
>
> > @@ -290,6 +303,7 @@ struct npc_kpu_profile {
> >  	int action_entries;
> >  	struct npc_kpu_profile_cam *cam;
> >  	struct npc_kpu_profile_action *action;
> > +	struct npc_kpu_profile_cam2 *cam2;
> >  };
>
> [ ... ]
>
> > diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
> > index a466181cf908..1efc53b63b67 100644
> > --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
> > +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
>
> [ ... ]
>
> > @@ -553,8 +553,8 @@ struct npc_kpu_profile_adapter {
> >  	const char			*name;
> >  	u64				version;
> >  	const struct npc_lt_def_cfg	*lt_def;
> > -	const struct npc_kpu_profile_action	*ikpu; /* array[pkinds] */
> > -	const struct npc_kpu_profile	*kpu; /* array[kpus] */
> > +	struct npc_kpu_profile_action	*ikpu; /* array[pkinds] */
> > +	struct npc_kpu_profile	*kpu; /* array[kpus] */
>
> [ ... ]
>
> > @@ -564,6 +564,7 @@ struct npc_kpu_profile_adapter {
> >  	bool				custom;
> >  	size_t				pkinds;
> >  	size_t				kpus;
> > +	bool				from_fs;
> >  };
>
> [ ... ]
>
> > diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
> > index 352dc5f1d5b9..05aabe26f030 100644
> > --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
> > +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
>
> [ ... ]
>
> > @@ -1610,6 +1622,7 @@ u64 npc_enable_mask(int count)
> >  static void npc_program_kpu_profile(struct rvu *rvu, int blkaddr, int kpu,
> >  				    const struct npc_kpu_profile *profile)
> >  {
> > +	struct npc_kpu_profile_adapter *adapter = &rvu->kpu;
> >  	int entry, num_entries, max_entries;
> >  	u64 entry_mask;
> >
> > @@ -1621,10 +1634,15 @@ static void npc_program_kpu_profile(struct rvu *rvu, int blkaddr, int kpu,
> >
> >  	max_entries = rvu->hw->npc_kpu_entries;
> >
> > +	WARN(profile->cam_entries > max_entries,
> > +	     "KPU%u: err: hw max entries=%u, input entries=%u\n",
> > +	     kpu,  rvu->hw->npc_kpu_entries, profile->cam_entries);
> > +
> >  	/* Program CAM match entries for previous KPU extracted data */
> >  	num_entries = min_t(int, profile->cam_entries, max_entries);
> >  	for (entry = 0; entry < num_entries; entry++)
> >  		npc_config_kpucam(rvu, blkaddr,
> > +				  adapter->from_fs ? (void *)&profile->cam2[entry] :
> >  				  &profile->cam[entry], kpu, entry);
>
> Can this dereference NULL when from_fs is true for KPUs not covered by
> the filesystem firmware?
>
> Looking at the filesystem loading path in npc_apply_custom_kpu:
>
>     for (kpu = 0; kpu < fw->kpus; kpu++) {
>         ...
>         ret = npc_alloc_kpu_cam2_n_action(rvu, kpu, entries);
>         ...
>         for (entry = 0; entry < entries; entry++) {
>             profile->kpu[kpu].cam2[entry] = cam2[entry];
>             ...
>         }
>     }
>
> The code allocates cam2 and populates entries only for the first
> fw->kpus KPUs found in the firmware blob.
>
> However, npc_program_kpu_profile is later called for all KPUs in
> npc_parser_profile_init:
>
>     for (idx = 0; idx < num_kpus; idx++)
>         npc_program_kpu_profile(rvu, blkaddr, idx, &rvu->kpu.kpu[idx]);
>
> Since adapter->from_fs is a global flag (not per-KPU), when idx >=
> fw->kpus, profile->cam2 remains NULL (the default npc_kpu_profiles[]
> static initializer doesn't include cam2), causing &profile->cam2[entry]
> to compute an invalid pointer.
>
> Shouldn't there be a check to verify cam2 is non-NULL before
> dereferencing it, or allocate cam2 for all KPUs when from_fs is true?

The filsystem binary contains entries for all KPUs. So we can ignore this
case.

>
> >
> >  	/* Program this KPU's actions */
>
> [ ... ]
>
> > @@ -1678,26 +1696,50 @@ static void npc_prepare_default_kpu(struct rvu *rvu,
> >  	npc_cn20k_update_action_entries_n_flags(rvu, profile);
> >  }
> >
> > +static int npc_alloc_kpu_cam2_n_action(struct rvu *rvu, int kpu_num,
> > +				       int num_entries)
> > +{
> > +	struct npc_kpu_profile_adapter *adapter = &rvu->kpu;
> > +	struct npc_kpu_profile *kpu;
> > +
> > +	kpu = &adapter->kpu[kpu_num];
> > +
> > +	kpu->cam2 = devm_kcalloc(rvu->dev, num_entries,
> > +				 sizeof(*kpu->cam2), GFP_KERNEL);
> > +	if (!kpu->cam2)
> > +		return -ENOMEM;
> > +
> > +	kpu->action = devm_kcalloc(rvu->dev, num_entries,
> > +				   sizeof(*kpu->action), GFP_KERNEL);
> > +	if (!kpu->action)
> > +		return -ENOMEM;
> > +
> > +	return 0;
> > +}
>
> Can this permanently corrupt the default profile when the second
> allocation fails?
Expectation is to load the correct binary. Due to memory constraints, we decided
to skip rollback on errors. It is user responsibility to remove the corrupted FW
binary and reboot.

>
> The kpu pointer targets the static npc_kpu_profiles[] array (adapter->kpu
> starts as &npc_kpu_profiles[0]). When the first devm_kcalloc succeeds but
> the second fails:
>
>     kpu->cam2 = devm_kcalloc(...)  // succeeds, modifies static array
>     kpu->action = devm_kcalloc(...) // fails
>     return -ENOMEM;                 // kpu->action is now NULL in static array
>
> The caller in npc_apply_custom_kpu returns the error without restoring
> the original action pointer.
>
> Later, npc_parser_profile_init calls npc_program_kpu_profile for all
> KPUs, which calls npc_config_kpuaction with &profile->action[entry]
> where action is NULL, causing a crash when dereferencing the NULL pointer.
>
> Should the function restore the original pointers on allocation failure,
> or use a separate copy of the profile entries for filesystem loading?
Same as above.
>
> > +
> >  static int npc_apply_custom_kpu(struct rvu *rvu,
> > -				struct npc_kpu_profile_adapter *profile)
> > +				struct npc_kpu_profile_adapter *profile,
> > +				bool from_fs)
> >  {
> >  	size_t hdr_sz = sizeof(struct npc_kpu_profile_fwdata), offset = 0;
> >  	struct npc_kpu_profile_action *action;
> > +	struct npc_kpu_profile_fwdata *sfw;
> >  	struct npc_kpu_profile_fwdata *fw;
> > +	struct npc_kpu_profile_cam2 *cam2;
> >  	struct npc_kpu_profile_cam *cam;
> >  	struct npc_kpu_fwdata *fw_kpu;
> > -	int entries;
> > +	int entries, ret;
> >  	u16 kpu, entry;
>
> [ ... ]
>
> > @@ -1731,31 +1773,80 @@ static int npc_apply_custom_kpu(struct rvu *rvu,
> >  		return -EINVAL;
> >  	}
> >
> > +	sfw = devm_kcalloc(rvu->dev, 1, sizeof(*sfw), GFP_KERNEL);
> > +	if (!sfw)
> > +		return -ENOMEM;
> > +
> > +	memcpy(sfw, fw, sizeof(*sfw));
> > +
> >  	profile->custom = 1;
> > -	profile->name = fw->name;
> > +	profile->name = sfw->name;
> >  	profile->version = le64_to_cpu(fw->version);
> > -	profile->mcam_kex_prfl.mkex = &fw->mkex;
> > -	profile->lt_def = &fw->lt_def;
> > +	profile->mcam_kex_prfl.mkex = &sfw->mkex;
> > +	profile->lt_def = &sfw->lt_def;
> > +
> > +	/* Binary blob contains ikpu actions entries at start of data[0] */
> > +	if (from_fs) {
> > +		action = (struct npc_kpu_profile_action *)(fw->data + offset);
> > +
> > +		if (rvu->kpu_fwdata_sz < hdr_sz + sizeof(ikpu_action_entries))
> > +			return -ENOMEM;
> > +
> > +		memcpy((void *)profile->ikpu, action, sizeof(ikpu_action_entries));
> > +		offset += sizeof(ikpu_action_entries);
> > +	}
> >
> >  	for (kpu = 0; kpu < fw->kpus; kpu++) {
> >  		fw_kpu = (struct npc_kpu_fwdata *)(fw->data + offset);
> > -		if (fw_kpu->entries > KPU_MAX_CST_ENT)
> > -			dev_warn(rvu->dev,
> > -				 "Too many custom entries on KPU%d: %d > %d\n",
> > -				 kpu, fw_kpu->entries, KPU_MAX_CST_ENT);
> > -		entries = min(fw_kpu->entries, KPU_MAX_CST_ENT);
> > -		cam = (struct npc_kpu_profile_cam *)fw_kpu->data;
> > -		offset += sizeof(*fw_kpu) + fw_kpu->entries * sizeof(*cam);
> > +		if (!from_fs) {
> > +			if (fw_kpu->entries > KPU_MAX_CST_ENT)
> > +				dev_warn(rvu->dev,
> > +					 "Too many custom entries on KPU%d: %d > %d\n",
> > +					 kpu, fw_kpu->entries, KPU_MAX_CST_ENT);
> > +			entries = min(fw_kpu->entries, KPU_MAX_CST_ENT);
> > +			cam = (struct npc_kpu_profile_cam *)fw_kpu->data;
> > +			offset += sizeof(*fw_kpu) + fw_kpu->entries * sizeof(*cam);
> > +			action = (struct npc_kpu_profile_action *)(fw->data + offset);
> > +			offset += fw_kpu->entries * sizeof(*action);
> > +			if (rvu->kpu_fwdata_sz < hdr_sz + offset) {
> > +				dev_warn(rvu->dev,
> > +					 "Profile size mismatch on KPU%i parsing.\n",
> > +					 kpu + 1);
> > +				return -EINVAL;
> > +			}
> > +			for (entry = 0; entry < entries; entry++) {
> > +				profile->kpu[kpu].cam[entry] = cam[entry];
> > +				profile->kpu[kpu].action[entry] = action[entry];
> > +			}
> > +			continue;
> > +		}
> > +		entries = fw_kpu->entries;
> > +		dev_info(rvu->dev,
> > +			 "Loading %u entries on KPU%d\n", entries, kpu);
> > +
> > +		cam2 = (struct npc_kpu_profile_cam2 *)fw_kpu->data;
> > +		offset += sizeof(*fw_kpu) + fw_kpu->entries * sizeof(*cam2);
> >  		action = (struct npc_kpu_profile_action *)(fw->data + offset);
> >  		offset += fw_kpu->entries * sizeof(*action);
> >  		if (rvu->kpu_fwdata_sz < hdr_sz + offset) {
> >  			dev_warn(rvu->dev,
> > -				 "Profile size mismatch on KPU%i parsing.\n",
> > +				 "profile size mismatch on kpu%i parsing.\n",
> >  				 kpu + 1);
> >  			return -EINVAL;
> >  		}
> > +
> > +		profile->kpu[kpu].cam_entries = entries;
> > +		profile->kpu[kpu].action_entries = entries;
> > +		ret = npc_alloc_kpu_cam2_n_action(rvu, kpu, entries);
> > +		if (ret) {
> > +			dev_warn(rvu->dev,
> > +				 "profile entry allocation failed for kpu=%d for %d entries\n",
> > +				 kpu, entries);
> > +			return -EINVAL;
> > +		}
> > +
> >  		for (entry = 0; entry < entries; entry++) {
> > -			profile->kpu[kpu].cam[entry] = cam[entry];
> > +			profile->kpu[kpu].cam2[entry] = cam2[entry];
> >  			profile->kpu[kpu].action[entry] = action[entry];
> >  		}
>
> Could this loop overflow and hang the kernel if firmware specifies more
> than 65535 entries?
FW binary is prepared by marvell and tested before delivering to customers.
And the entries wont cross u16 limit

>
> The loop variable 'entry' is declared as u16:
>
>     u16 kpu, entry;
>
> while 'entries' is an int:
>
>     entries = fw_kpu->entries;
>
> In the from_fs path, 'entries' is read directly from the firmware blob
> without capping it (unlike the !from_fs path which uses
> min(fw_kpu->entries, KPU_MAX_CST_ENT)).
>
> If a corrupt or malicious firmware file specifies fw_kpu->entries >
> 65535, the u16 variable wraps around at 65536:
>
>     for (entry = 0; entry < entries; entry++)
>
> When entry reaches 65535, incrementing it produces 0, which is still
> less than entries, creating an infinite loop that hangs the kernel.
>
> Should the code either cap entries in the from_fs path or use an
> int-sized loop variable?
>
> >  	}
>
> [ ... ]

