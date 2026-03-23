Return-Path: <netdev+bounces-270337-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2Am4KdibwGnKJAQAu9opvQ
	(envelope-from <netdev+bounces-270337-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 02:48:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DEFA2EB9D9
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 02:48:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0342A30073F9
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 01:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C59921D7E41;
	Mon, 23 Mar 2026 01:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="a6WqiUlq"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F777404E;
	Mon, 23 Mar 2026 01:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774230484; cv=none; b=FqFQn/tAdZi8dKbCJzByssmASmxSEaFOh4GbilibB1gNnpHfIjxMGYfPbLdfqf50zGtV19ExPiJTDgOJA3HWZ+n3NWMM5gX4qqFRsaLJuDZB2UpRdIuBBjyUZdQ2hr3RIMkFFUP8MJWtYQPH6sFfRsiXO7azDXx6JwJBzHpWreY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774230484; c=relaxed/simple;
	bh=7cKapGqG3nyMko2Gs92JELEQTkfhd086sDMSo3g0YUI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gNi2W0GS/TmCHZYhn3/eBVkgYdDsvgWZR8nIXAHueceH3JlC7yrdAifPYdph5ZtKfhYHQrc3Qtd8LSkI/U311SkGcq0H7jI9kFenca/uUbv9znAOBM2voTHAYKBOpLnSSNfrG9uxiMd9GNT/GUJftqTzGx6rGh33AvE+p31gS8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=a6WqiUlq; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62N0RuTx1048434;
	Sun, 22 Mar 2026 18:47:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=qH0j0MXbXxbEiNoTOxh/Ej5UP
	D19u/0UQZt8gFSBbLk=; b=a6WqiUlqeUPKdGptKon7WeAkpo2oV1/ejssV3UxAi
	QHt8cOxAk53k6pUq6+LLSqiSW4AYdpj9uD+upw56A1QuCRXBzIKbMgtBqZPgAn45
	Iaa14OmUe24wNByiHeUsxX6e+s1xlCQp60TD+IiPPTWt+/OJlKXMhvf8AkRK031Z
	xNw6kD3/JW8IyB4Ato+czdZtGdNticNpRXbP2ZQe2htWbbTWSYYzhtXeYaHFaoC4
	Ku7wuNiT1c65LBqPkEmYKkQxAfXRNlDVsD7wJ7TTm8QWD3D6Hqc+rcwrLZaKgjcv
	6Y4f2ZLOTp3qL7HELN+RZ6svm/eMGG1QlQzmS9CE5p6Tg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4d1tugj4q6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 22 Mar 2026 18:47:40 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 22 Mar 2026 18:47:39 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sun, 22 Mar 2026 18:47:39 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 28A383F70A2;
	Sun, 22 Mar 2026 18:47:34 -0700 (PDT)
Date: Mon, 23 Mar 2026 07:17:33 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: Simon Horman <horms@kernel.org>
CC: <shshitrit@nvidia.com>, <cjubran@nvidia.com>, <netdev@vger.kernel.org>,
        <matttbe@kernel.org>, <edumazet@google.com>, <pabeni@redhat.com>,
        <saeedm@nvidia.com>, <sgoutham@marvell.com>, <davem@davemloft.net>,
        <donald.hunter@gmail.com>, <jiri@resnulli.us>,
        <chuck.lever@oracle.com>, <linux-kernel@vger.kernel.org>,
        <kuba@kernel.org>
Subject: Re: [PATCH v6 net-next 5/5] octeontx2-af: npc: Support for custom
 KPU profile from filesystem
Message-ID: <acCbtThJb-PA8tni@rkannoth-OptiPlex-7090>
References: <20260319055533.1720093-6-rkannoth@marvell.com>
 <20260320165432.98832-1-horms@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260320165432.98832-1-horms@kernel.org>
X-Proofpoint-ORIG-GUID: -mo4edJO03B_RClAKzZIVLLVujIy5O0z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDAxMiBTYWx0ZWRfX9CRgv7fTPwDW
 kTftN4g7SbFwFd/t4Cm6M9UjsnaCi8o4Cl0JApZQOUk6DGoF9JsWsD+TnRxQEbegn9GEo4aaZnb
 vXA6BbCPuUmR05ck4z74/p1i4A6Xkf/+Ip1CaL2Dd4QDdap/cTnjKPNR12kwECLTbmfANvBUU02
 yB9aQeLSHIMBJA8cPJhWTmEjEafZDz+LAXtKd3HezKdRl6pfqOQpZrNzI8BWlRh/yfxM1g84/Si
 W8kKp9IZShJkgVc2j4nV5e+oZvKYs3JHn7ppNkKko/3OHVt9M+wiYu6wkwOSOg6rxk5oYn0J/Rd
 7IE4Tm0ZwXKQHeeOje9Pp3BFSKp6m+zBB5PEHYEUGqipJJZtfz8fezOHIwNOXeETSiY7EgksVGv
 wOw/kSLqugxtBlXmtaV+UClTTTP01dI5HV1ACZycofmpOAgyseRxFZ1KRnXBe5aWEsDto2Ot5tf
 IKFMxtVGOqB2yphMU4g==
X-Proofpoint-GUID: -mo4edJO03B_RClAKzZIVLLVujIy5O0z
X-Authority-Analysis: v=2.4 cv=Pu6ergM3 c=1 sm=1 tr=0 ts=69c09bbc cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=QXcCYyLzdtTjyudCfB6f:22 a=VwQbUJbxAAAA:8
 a=_Go4_jeb2u-yDBX4-a4A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-22_07,2026-03-20_02,2025-10-01_01
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270337-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[nvidia.com,vger.kernel.org,kernel.org,google.com,redhat.com,marvell.com,davemloft.net,gmail.com,resnulli.us,oracle.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[marvell.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 0DEFA2EB9D9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026-03-20 at 22:24:32, Simon Horman (horms@kernel.org) wrote:
>
> > @@ -665,9 +675,15 @@ void npc_cn20k_parser_profile_init(struct rvu *rvu, int blkaddr)
> >  	num_pkinds = rvu->kpu.pkinds;
> >  	num_pkinds = min_t(int, hw->npc_pkinds, num_pkinds);
> >
> > -	for (idx = 0; idx < num_pkinds; idx++)
> > -		npc_config_kpmaction(rvu, blkaddr, &rvu->kpu.ikpu[idx],
> > +	/* Cn20k does not support Custom profile from filesystem */
> > +	for (idx = 0; idx < num_pkinds; idx++) {
> > +		act = npc_get_ikpu_nth_entry(rvu, idx);
> > +		if (!act)
> > +			continue;
> > +
> > +		npc_config_kpmaction(rvu, blkaddr, act,
> >  				     0, idx, true);
> > +	}
>
> When a filesystem-loaded profile is used on cn20k (from_fs=true),
> npc_get_ikpu_nth_entry() returns &profile->ikpu2[idx]:
>
> drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c:npc_get_ikpu_nth_entry() {
>     struct npc_kpu_profile_adapter *profile = &rvu->kpu;
>
>     if (profile->from_fs)
>         return &profile->ikpu2[idx];
>
>     return &profile->ikpu[n];
> }
>
> However, ikpu2 is never allocated for the cn20k path. The allocation
> happens inside npc_apply_custom_kpu() in the from_fs block:
>
> drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c:npc_apply_custom_kpu() {
>     if (is_cn20k(rvu->pdev))
>         return npc_cn20k_apply_custom_kpu(rvu, profile);
>     ...
>     if (from_fs) {
>         profile->ikpu2 = devm_kcalloc(rvu->dev, 1,
>                                       sizeof(ikpu_action_entries),
>                                       GFP_KERNEL);
>         ...
>     }
> }
>
> But this from_fs block is never reached for cn20k because the function
> returns early via npc_cn20k_apply_custom_kpu().
>
> Does this code dereference a NULL-offset pointer causing a kernel crash?
>
> The same issue appears to affect cam2 and action2 pointers which are
> allocated in npc_alloc_kpu_cam2_n_action2() but never called for cn20k.
>
> This was raised by Jakub Kicinski during v4 review on 2026-03-16.
This is false positive. from_fs is never set to "true" for cn20k. In npc_load_kpu_profile(), if soc is
cn20k, it skips "loading from filesystem" method. So npc_get_ikpu_nth_entry()
will never return ikpu2.

>
> > diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
> > index 8d260bcfbf38..8d8feb7742e8 100644
> > --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
> > +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
>
> [ ... ]
>
> > @@ -1730,32 +1835,89 @@ static int npc_apply_custom_kpu(struct rvu *rvu,
> >  		return -EINVAL;
> >  	}
> >
> > +	*fw_kpus = fw->kpus;
> > +
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
> > +		profile->ikpu2 = devm_kcalloc(rvu->dev, 1,
> > +					      sizeof(ikpu_action_entries),
> > +					      GFP_KERNEL);
> > +		if (!profile->ikpu2)
> > +			return -ENOMEM;
> > +
> > +		action = (struct npc_kpu_profile_action *)(fw->data + offset);
> > +
> > +		if (rvu->kpu_fwdata_sz < hdr_sz + sizeof(ikpu_action_entries))
> > +			return -ENOMEM;
> > +
> > +		memcpy((void *)profile->ikpu2, action, sizeof(ikpu_action_entries));
> > +		offset += sizeof(ikpu_action_entries);
> > +	}
> > +
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
> > +		profile->kpu[kpu].cam_entries2 = entries;
> > +		profile->kpu[kpu].action_entries2 = entries;
> > +		ret = npc_alloc_kpu_cam2_n_action2(rvu, kpu, entries);
> > +		if (ret) {
> > +			dev_warn(rvu->dev,
> > +				 "profile entry allocation failed for kpu=%d for %d entries\n",
> > +				 kpu, entries);
> > +			return -EINVAL;
> > +		}
> > +
> >  		for (entry = 0; entry < entries; entry++) {
> > -			profile->kpu[kpu].cam[entry] = cam[entry];
> > -			profile->kpu[kpu].action[entry] = action[entry];
> > +			profile->kpu[kpu].cam2[entry] = cam2[entry];
> > +			profile->kpu[kpu].action2[entry] = action[entry];
> >  		}
> >  	}
>
> Could this loop overflow and hang the kernel if firmware specifies more
> than 65535 entries?
>
> The loop variable 'entry' is declared as int at the top of the function,
> but in the from_fs path, 'entries' is read directly from the firmware
> blob:
>
>     entries = fw_kpu->entries;
>
> In the non-from_fs path, entries is capped:
>
>     entries = min(fw_kpu->entries, KPU_MAX_CST_ENT);
>
> But in the from_fs path there is no cap on entries. If a corrupt or
> malicious firmware file specifies fw_kpu->entries with a very large
> value, the loop could run for an extremely long time or cause other
> issues.
>
> The kernel should not rely on filesystem data being well-formed.
> Validation is needed for the from_fs case.
>
> This was raised by Simon Horman during v3 review on 2026-03-10. The
> author acknowledged this in v3 saying they would fix it in v5, but the
> issue persists in the current version.
ACK. Last AI review suggest is - either to use "int" as loop variable or do a capping
on the value. I did modify it to "int".

