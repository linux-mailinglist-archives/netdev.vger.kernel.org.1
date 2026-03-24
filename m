Return-Path: <netdev+bounces-270867-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EBnQOLcOwmlGZQQAu9opvQ
	(envelope-from <netdev+bounces-270867-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 05:10:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 59329301F3F
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 05:10:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 29E5F303748A
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 04:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E88F3A1E89;
	Tue, 24 Mar 2026 04:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Dnc43cwc"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA95239E7F;
	Tue, 24 Mar 2026 04:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774325429; cv=none; b=gzp2GeMMgbtOieQsdn0Io8IuHnz4EwFMv04daJ31rbc05pam9LTt7KrT+G1jqyL7yNQMhQWSRZyoXO6haqEm510BZCoLN3PMT4u/hVw25fud3zT7AeaaknENYTPNWtn2jc3fw+nGqAL1HDMprVZH4HVjz8MR6e6pjYNaHj3L6jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774325429; c=relaxed/simple;
	bh=B0GwGVcmsa+4F8559MXfhmcZ7FN93zkHNu6ud7GZUfc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TvNF8T3QC8dM3UZAQwQDLu7xNs6yFBWRhp4mpYv2Se6Nr/GfZquz/y96LqKGz/wgQRwKxW0WMdvnhaSDwyp1iXZ76Qvaws2D/9J9Nf6Bf5cDsFQOZOvTTVb8ySa38qYTlOVAmQmM3LE2Y5IQlKolcJUNj8O5qabBJK4Z5LEPKTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Dnc43cwc; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62NHYIU62011175;
	Mon, 23 Mar 2026 21:10:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=3kpfVh3K8SXRgSYPaWKxbT7mt
	jkU983DIWcnGdbqLTs=; b=Dnc43cwcbAvGg+EXH2CJ31zWh9i8QBN/Rnwo1koc0
	Bifxot7C/RrnPF5mCFYllbgZ9t+W96vVSpwO0T1oa+JHID2jsqzXYox9GWJkb8vA
	v35986r1ZtxEFMoC+hMu4w6nkKweS0G1C6mIk2jHGMGF8yN685YlhD4+ulxlvmhZ
	AvaTQ37v8dqdQDRA3hrLdcWnujk5XORKU4fwi2/Zd1RaZXEpJEEZB4UZ/y0vUsY5
	DVF8qv/ztN0GKeSBJNWCElLfAB8BQJ6x8VlOaodalMTZGBBQ4bqCHgxwsg9vhrlE
	q+obgev/du3rhQNlIBjwciz6lJRITdVGOBM3+NUaAITWg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4d2c3646xu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Mar 2026 21:10:04 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 23 Mar 2026 21:10:04 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 23 Mar 2026 21:10:04 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id F02EC5B6922;
	Mon, 23 Mar 2026 21:09:59 -0700 (PDT)
Date: Tue, 24 Mar 2026 09:39:58 +0530
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
Message-ID: <acIOloT6IX4RmEeZ@rkannoth-OptiPlex-7090>
References: <20260319055533.1720093-6-rkannoth@marvell.com>
 <20260320165432.98832-1-horms@kernel.org>
 <acCbtThJb-PA8tni@rkannoth-OptiPlex-7090>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <acCbtThJb-PA8tni@rkannoth-OptiPlex-7090>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDAzMiBTYWx0ZWRfX6yzmKF/YH3vk
 Kwz3jI9FvD3HeZn7RRWxFxbLQGxxi3w4axCaYi2tiMG5bEgsdWvkXF+s7bnWSFYpivTaveZBL1/
 qppeBenbY0MUVXE7JCjoQGhTnKgGNcx4DGvIgUYYxb4Ww5SqzoDYPlaZJEYv/6OMmYg/h3iqTX3
 32Si6FOPKZ7QGrU/qwHuMR7g8A57GEx1p51GgxRdXzeT5QgvmTIt6/Y5P55lXZUyVmxd0M+TVi2
 PV3zjBZNDpqYI8520sbyFUM60DEqxhWtLPEU0ufkNYnbuJmt6ULzlu6kYSx8bsunzEQqw9sLMzz
 LNKUhgfSsAG3NfTBS85fJbeQGeyQDgaB+a3aYzrPkadmy7OqEfVIQU7ZXl3/7+9MrUXj80KSB+0
 Jbh4Bp+mlocy853KEyefliH60YnYSpTUbXS1fOwesQ3LuKkA5wjP57nhLjSYBnAzXKalGL2hSho
 aserY+26/VCBnTcEc3w==
X-Proofpoint-ORIG-GUID: 9V-ZSLMg00T3qkjS354seKgsYW6Kparm
X-Proofpoint-GUID: 9V-ZSLMg00T3qkjS354seKgsYW6Kparm
X-Authority-Analysis: v=2.4 cv=SItPlevH c=1 sm=1 tr=0 ts=69c20e9c cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=qit2iCtTFQkLgVSMPQTB:22 a=9R54UkLUAAAA:8
 a=M5GUcnROAAAA:8 a=VwQbUJbxAAAA:8 a=S-9KcCoszCjkqHTTb5UA:9 a=CjuIK1q_8ugA:10
 a=YTcpBFlVQWkNscrzJ_Dz:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_01,2026-03-23_02,2025-10-01_01
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
	TAGGED_FROM(0.00)[bounces-270867-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[nvidia.com,vger.kernel.org,kernel.org,google.com,redhat.com,marvell.com,davemloft.net,gmail.com,resnulli.us,oracle.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,marvell.com:dkim,marvell.com:email,linux.dev:url];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 59329301F3F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026-03-23 at 07:17:33, Ratheesh Kannoth (rkannoth@marvell.com) wrote:
> On 2026-03-20 at 22:24:32, Simon Horman (horms@kernel.org) wrote:
> >
> > > @@ -665,9 +675,15 @@ void npc_cn20k_parser_profile_init(struct rvu *rvu, int blkaddr)
> > >  	num_pkinds = rvu->kpu.pkinds;
> > >  	num_pkinds = min_t(int, hw->npc_pkinds, num_pkinds);
> > >
> > > -	for (idx = 0; idx < num_pkinds; idx++)
> > > -		npc_config_kpmaction(rvu, blkaddr, &rvu->kpu.ikpu[idx],
> > > +	/* Cn20k does not support Custom profile from filesystem */
> > > +	for (idx = 0; idx < num_pkinds; idx++) {
> > > +		act = npc_get_ikpu_nth_entry(rvu, idx);
> > > +		if (!act)
> > > +			continue;
> > > +
> > > +		npc_config_kpmaction(rvu, blkaddr, act,
> > >  				     0, idx, true);
> > > +	}
> >
> > When a filesystem-loaded profile is used on cn20k (from_fs=true),
> > npc_get_ikpu_nth_entry() returns &profile->ikpu2[idx]:
> >
> > drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c:npc_get_ikpu_nth_entry() {
> >     struct npc_kpu_profile_adapter *profile = &rvu->kpu;
> >
> >     if (profile->from_fs)
> >         return &profile->ikpu2[idx];
> >
> >     return &profile->ikpu[n];
> > }
> >
> > However, ikpu2 is never allocated for the cn20k path. The allocation
> > happens inside npc_apply_custom_kpu() in the from_fs block:
> >
> > drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c:npc_apply_custom_kpu() {
> >     if (is_cn20k(rvu->pdev))
> >         return npc_cn20k_apply_custom_kpu(rvu, profile);
> >     ...
> >     if (from_fs) {
> >         profile->ikpu2 = devm_kcalloc(rvu->dev, 1,
> >                                       sizeof(ikpu_action_entries),
> >                                       GFP_KERNEL);
> >         ...
> >     }
> > }
> >
> > But this from_fs block is never reached for cn20k because the function
> > returns early via npc_cn20k_apply_custom_kpu().
> >
> > Does this code dereference a NULL-offset pointer causing a kernel crash?
> >
> > The same issue appears to affect cam2 and action2 pointers which are
> > allocated in npc_alloc_kpu_cam2_n_action2() but never called for cn20k.
> >
> > This was raised by Jakub Kicinski during v4 review on 2026-03-16.
> This is false positive. from_fs is never set to "true" for cn20k. In npc_load_kpu_profile(), if soc is
> cn20k, it skips "loading from filesystem" method. So npc_get_ikpu_nth_entry()
> will never return ikpu2.
>
> >
> > > diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
> > > index 8d260bcfbf38..8d8feb7742e8 100644
> > > --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
> > > +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
> >
> > [ ... ]
> >
> > > @@ -1730,32 +1835,89 @@ static int npc_apply_custom_kpu(struct rvu *rvu,
> > >  		return -EINVAL;
> > >  	}
> > >
> > > +	*fw_kpus = fw->kpus;
> > > +
> > > +	sfw = devm_kcalloc(rvu->dev, 1, sizeof(*sfw), GFP_KERNEL);
> > > +	if (!sfw)
> > > +		return -ENOMEM;
> > > +
> > > +	memcpy(sfw, fw, sizeof(*sfw));
> > > +
> > >  	profile->custom = 1;
> > > -	profile->name = fw->name;
> > > +	profile->name = sfw->name;
> > >  	profile->version = le64_to_cpu(fw->version);
> > > -	profile->mcam_kex_prfl.mkex = &fw->mkex;
> > > -	profile->lt_def = &fw->lt_def;
> > > +	profile->mcam_kex_prfl.mkex = &sfw->mkex;
> > > +	profile->lt_def = &sfw->lt_def;
> > > +
> > > +	/* Binary blob contains ikpu actions entries at start of data[0] */
> > > +	if (from_fs) {
> > > +		profile->ikpu2 = devm_kcalloc(rvu->dev, 1,
> > > +					      sizeof(ikpu_action_entries),
> > > +					      GFP_KERNEL);
> > > +		if (!profile->ikpu2)
> > > +			return -ENOMEM;
> > > +
> > > +		action = (struct npc_kpu_profile_action *)(fw->data + offset);
> > > +
> > > +		if (rvu->kpu_fwdata_sz < hdr_sz + sizeof(ikpu_action_entries))
> > > +			return -ENOMEM;
> > > +
> > > +		memcpy((void *)profile->ikpu2, action, sizeof(ikpu_action_entries));
> > > +		offset += sizeof(ikpu_action_entries);
> > > +	}
> > > +
> > >  	for (kpu = 0; kpu < fw->kpus; kpu++) {
> > >  		fw_kpu = (struct npc_kpu_fwdata *)(fw->data + offset);
> > > -		if (fw_kpu->entries > KPU_MAX_CST_ENT)
> > > -			dev_warn(rvu->dev,
> > > -				 "Too many custom entries on KPU%d: %d > %d\n",
> > > -				 kpu, fw_kpu->entries, KPU_MAX_CST_ENT);
> > > -		entries = min(fw_kpu->entries, KPU_MAX_CST_ENT);
> > > -		cam = (struct npc_kpu_profile_cam *)fw_kpu->data;
> > > -		offset += sizeof(*fw_kpu) + fw_kpu->entries * sizeof(*cam);
> > > +		if (!from_fs) {
> > > +			if (fw_kpu->entries > KPU_MAX_CST_ENT)
> > > +				dev_warn(rvu->dev,
> > > +					 "Too many custom entries on KPU%d: %d > %d\n",
> > > +					 kpu, fw_kpu->entries, KPU_MAX_CST_ENT);
> > > +			entries = min(fw_kpu->entries, KPU_MAX_CST_ENT);
> > > +			cam = (struct npc_kpu_profile_cam *)fw_kpu->data;
> > > +			offset += sizeof(*fw_kpu) + fw_kpu->entries * sizeof(*cam);
> > > +			action = (struct npc_kpu_profile_action *)(fw->data + offset);
> > > +			offset += fw_kpu->entries * sizeof(*action);
> > > +			if (rvu->kpu_fwdata_sz < hdr_sz + offset) {
> > > +				dev_warn(rvu->dev,
> > > +					 "Profile size mismatch on KPU%i parsing.\n",
> > > +					 kpu + 1);
> > > +				return -EINVAL;
> > > +			}
> > > +			for (entry = 0; entry < entries; entry++) {
> > > +				profile->kpu[kpu].cam[entry] = cam[entry];
> > > +				profile->kpu[kpu].action[entry] = action[entry];
> > > +			}
> > > +			continue;
> > > +		}
> > > +		entries = fw_kpu->entries;
> > > +		dev_info(rvu->dev,
> > > +			 "Loading %u entries on KPU%d\n", entries, kpu);
> > > +
> > > +		cam2 = (struct npc_kpu_profile_cam2 *)fw_kpu->data;
> > > +		offset += sizeof(*fw_kpu) + fw_kpu->entries * sizeof(*cam2);
> > >  		action = (struct npc_kpu_profile_action *)(fw->data + offset);
> > >  		offset += fw_kpu->entries * sizeof(*action);
> > >  		if (rvu->kpu_fwdata_sz < hdr_sz + offset) {
> > >  			dev_warn(rvu->dev,
> > > -				 "Profile size mismatch on KPU%i parsing.\n",
> > > +				 "profile size mismatch on kpu%i parsing.\n",
> > >  				 kpu + 1);
> > >  			return -EINVAL;
> > >  		}
> > > +
> > > +		profile->kpu[kpu].cam_entries2 = entries;
> > > +		profile->kpu[kpu].action_entries2 = entries;
> > > +		ret = npc_alloc_kpu_cam2_n_action2(rvu, kpu, entries);
> > > +		if (ret) {
> > > +			dev_warn(rvu->dev,
> > > +				 "profile entry allocation failed for kpu=%d for %d entries\n",
> > > +				 kpu, entries);
> > > +			return -EINVAL;
> > > +		}
> > > +
> > >  		for (entry = 0; entry < entries; entry++) {
> > > -			profile->kpu[kpu].cam[entry] = cam[entry];
> > > -			profile->kpu[kpu].action[entry] = action[entry];
> > > +			profile->kpu[kpu].cam2[entry] = cam2[entry];
> > > +			profile->kpu[kpu].action2[entry] = action[entry];
> > >  		}
> > >  	}
> >
> > Could this loop overflow and hang the kernel if firmware specifies more
> > than 65535 entries?
> >
> > The loop variable 'entry' is declared as int at the top of the function,
> > but in the from_fs path, 'entries' is read directly from the firmware
> > blob:
> >
> >     entries = fw_kpu->entries;
> >
> > In the non-from_fs path, entries is capped:
> >
> >     entries = min(fw_kpu->entries, KPU_MAX_CST_ENT);
> >
> > But in the from_fs path there is no cap on entries. If a corrupt or
> > malicious firmware file specifies fw_kpu->entries with a very large
> > value, the loop could run for an extremely long time or cause other
> > issues.
> >
> > The kernel should not rely on filesystem data being well-formed.
> > Validation is needed for the from_fs case.
> >
> > This was raised by Simon Horman during v3 review on 2026-03-10. The
> > author acknowledged this in v3 saying they would fix it in v5, but the
> > issue persists in the current version.
> ACK. Last AI review suggest is - either to use "int" as loop variable or do a capping
> on the value. I did modify it to "int".

Hi Simon,

I noticed that this concern has been raised again even after adding "CAPPING"
https://netdev-ai.bots.linux.dev/ai-review.html?id=c0bd3eea-bbc4-46ae-86da-c295d1100233

"If a corrupt or malicious firmware file in /lib/firmware/kpu specifies fw_kpu->entries with a very
large value that doesn't exceed rvu->hw->npc_kpu_entries, the loop could run for an extremely long time."

I would like to clarify that the following line in the code effectively caps the value of entries,
even in cases where the value read from the filesystem may be corrupted:

entries = min(fw_kpu->entries, rvu->hw->npc_kpu_entries);

Here, rvu->hw->npc_kpu_entries is derived from hardware registers and represents the
maximum limit supported by the hardware.

Please let me know if you see any gaps in this reasoning or if further safeguards are required.

