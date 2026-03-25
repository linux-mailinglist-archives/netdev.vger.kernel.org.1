Return-Path: <netdev+bounces-271355-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aO7KHy5Tw2mIqAQAu9opvQ
	(envelope-from <netdev+bounces-271355-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 04:14:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E86731F160
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 04:14:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 72820301CAB8
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 03:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DC0029E0F7;
	Wed, 25 Mar 2026 03:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="RlEVRPWc"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4345283CBF;
	Wed, 25 Mar 2026 03:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774408489; cv=none; b=f9xgC+V5rEPRe/q3D6Gd80e7tZPPUBjzGWpaEPmNLCBvoUyjZNJGQRxA7osmx1FXESoJ9X2f31r7+3EzRN6rAlSnQfdzP19R0a3uTrf7EvSUrwDM3CBf+G/tNJj5qNFFf8DdeRF/Vf8fbdXIhnk96l7N8+piPunJ4FzXWuv7i7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774408489; c=relaxed/simple;
	bh=q2jUgKzq6N9gnxKa7H7PHTnVwAOSHaD1bs6p4gG1X7I=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kZ8UZ7DIOCQpC91ID78uMVysqpnDJ50BLkLd2ZhgjS06thUKQcauShIHEaI2fjjZVX+oHOKH81rqqoAmhjkAHiBcyrLZCqZvZdP40f+2efhoFJOBAU+k/3HwEYSMgp3JmkSJB2WeHfEOs7dTws9PFvQdD934qmizOEncqbrZYbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=RlEVRPWc; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62OGl6tR1712971;
	Tue, 24 Mar 2026 20:14:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=lMog/NqL7nXyfm4D9X2Be/3Ab
	W5YVCW2z6HXAO9f3Co=; b=RlEVRPWcpgwV6syG7BzvasExReKr89i4St921uU4w
	fL9Pl/O0EW4AOtSLPwl4RZVnAdo+RqHLLiuslJPT1K8SVd90YynoVGYe6EhD+BlV
	+MFmyjLRJq9DaZvMP1jIit7ZoYpbmHjJASsD9LJ86iMRcPWCNtLA0b45AL6KZpdO
	/Y6f97ml2OTUvaITotW1XSFkWlO3eQLMWjvkRQWuRr99M+Du9eHYS/+0JRJRVgEJ
	2uxfIV+/qLYD6yxq1EyKaAFCDgLo6nbuco4imdtxc4zyOnRAXqgRbazyQWGTVdgz
	Ol0OeTQLC4RNFvyK9yc70GTGu+ucwnpkDvgUnPIMHVgYw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4d1tugrpms-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Mar 2026 20:14:38 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 24 Mar 2026 20:14:36 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 24 Mar 2026 20:14:36 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id D681D3F7076;
	Tue, 24 Mar 2026 20:14:31 -0700 (PDT)
Date: Wed, 25 Mar 2026 08:44:30 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: Simon Horman <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <donald.hunter@gmail.com>,
        <jiri@resnulli.us>, <chuck.lever@oracle.com>, <matttbe@kernel.org>,
        <cjubran@nvidia.com>, <shshitrit@nvidia.com>, <dtatulea@nvidia.com>,
        <tariqt@nvidia.com>
Subject: Re: [PATCH v7 net-next 5/5] octeontx2-af: npc: Support for custom
 KPU profile from filesystem
Message-ID: <acNTFn5pjllT6C2G@rkannoth-OptiPlex-7090>
References: <20260323035110.3908741-1-rkannoth@marvell.com>
 <20260323035110.3908741-6-rkannoth@marvell.com>
 <20260324163621.GC111839@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260324163621.GC111839@horms.kernel.org>
X-Proofpoint-ORIG-GUID: r50FfB6S4SzNNjXmlcSUuXgi0r3VgAyl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDAyMSBTYWx0ZWRfX8AEHnUaup7Z7
 99e/AcXgCYg5T8VTFk9n4ifgmaKZKL2obY/VbDSOYeC2UX/nIwKzCpc8gZq7BwBAG/EGyEIE/0P
 Llnz+CGEzuvMAmNX4MQUdhmqfYuLmnMnUpWfmwfIr7lNb7DiCUgXRv/3DzgF0K0M/GB7bA4kj7w
 3nITwycC5JD+osfWyemcTGsdC4s8NDfxYoc9+ylN4EaIJLsM9OgzK7GQrF1YOSyNiizR2yGkx2O
 27TXId7Mt+ww6wiN6sGQM6wH94VWuZYEcIXPtFtZu8L+91Sh27v/7ATUR0uzt7/fP3nYNbO9RRV
 PXHUMnSihXKJXVODwKmGVTpDF+nKkG6SncMiQ0q1QW+M+HXsD4EVfb1W7YriwQThiU42a/Cujrd
 fXRkHKnasD/AwqVwPu+hnsxwBfuTHIz0pjV1u7SBPBOFnkVp2a7Xaa4MtUobk+FU6l0jSAuLD82
 J7xCMWkPPIadhAldbcA==
X-Proofpoint-GUID: r50FfB6S4SzNNjXmlcSUuXgi0r3VgAyl
X-Authority-Analysis: v=2.4 cv=Pu6ergM3 c=1 sm=1 tr=0 ts=69c3531e cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=QXcCYyLzdtTjyudCfB6f:22 a=VwQbUJbxAAAA:8
 a=96nR_x2hB85wxcyK7YsA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_01,2026-03-24_01,2025-10-01_01
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-271355-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,marvell.com,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,resnulli.us,oracle.com,nvidia.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 7E86731F160
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026-03-24 at 22:06:21, Simon Horman (horms@kernel.org) wrote:
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
>
> Effectively the code below is the else arm of the condition above.
> I would suggest that moving the contents of both arms into helpers
> would lead to a cleaner implementation.
>
> > +
> > +		entries = min(fw_kpu->entries, rvu->hw->npc_kpu_entries);
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
>
> Perhaps it applies to the existing code as well. But I think
> the new code to handle parsing images read from the file system
> could benefit from bounds checking. Basically passing in the length
> of the firmware image as an argument and ensuring that data beyond
> that length isn't accessed.
This is already done in both arms of the code.

 		if (rvu->kpu_fwdata_sz < hdr_sz + offset) {
 			dev_warn(rvu->dev,
				 "Profile size mismatch on KPU%i parsing.\n",
				 "profile size mismatch on kpu%i parsing.\n",
 				 kpu + 1);
 			return -EINVAL;

>

