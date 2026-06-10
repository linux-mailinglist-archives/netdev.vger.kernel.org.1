Return-Path: <netdev+bounces-297441-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id g3veKS/1KGrMOAMAu9opvQ
	(envelope-from <netdev+bounces-297441-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 07:25:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BCB78665ED5
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 07:25:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=marvell.com header.s=pfpt0220 header.b=LgMzbgJW;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297441-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297441-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=marvell.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 35C4C3023B8F
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 05:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D5B635F5E1;
	Wed, 10 Jun 2026 05:25:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADBA5194C95;
	Wed, 10 Jun 2026 05:24:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781069101; cv=none; b=Qu29fJXFp9Zj0f/HEWeAY1dEWgXDlJBeA2GCgPtIScmUxA/+ejkQ0td5F2u4Xorhr+gH1V9DFKzeJzKhB+GBwNs0frMk1bBImjLBkNHvXEySL7Dfl7JDwgSC7PCgIqAxHsE0EuN19C3uWtyMT/zDTY8M6X5MsIrkCxqtIYFe0VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781069101; c=relaxed/simple;
	bh=NxmzgZ0O/Q1v973dsGpZgTvu5udavPzSNvNEbPme9GE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dm2FYmO84WnkL/gvRE2s9rLqUdShh4TIaiATiO2Dbv+eFMmSC/5PX6FEqIduDyRY28kNQ6BLGq+LFwYXW+EGcJju9mF6Cm+8kE4ekaiPpDGUw9I8kGyUYyHWDqdqtPFZdQ2R06Yl3p1jizxLiT+glMhA4Wh3U4eJarmetJZDySc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=LgMzbgJW; arc=none smtp.client-ip=67.231.148.174
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65A1vOBJ2480503;
	Tue, 9 Jun 2026 22:24:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=CPVeaA/R2tgrjob0/Qc99Bo6g
	LwOfeEn36eZfdjEmgY=; b=LgMzbgJWvDW5aJz79N6SDTg6PBSGqeVxziOkKuL9K
	6zTeWexYuolQGWhNcXjW2TLH/H4s+/C+cyfQpzFHhxCXo23T1ZNgwE5JuVHnISGK
	qFjROFfOnoK0PP9IRxvGln5BBmM7Q27yyLpy2jmjClSKZUKCHIU1A6gUg0fohw9l
	PvdvbNUQU2aiks3fKwNeUCFQph5MNoBFaeTts0d0J9K2EakZk5hIfdDLADR7Ks+C
	fFyZY0VxJFoap1dPNnjsyROqYCL4DXDV6psDmqoFIUhBaSK1hv+rqyfHpU8Zy4Lq
	YIuEgnHzIXeHLjYAWGw/IIjn+rpJ9Bto2jLnHZb4PC+Qw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4epex1m866-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jun 2026 22:24:49 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 9 Jun 2026 22:24:48 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 9 Jun 2026 22:24:48 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 6104C3F708C;
	Tue,  9 Jun 2026 22:24:44 -0700 (PDT)
Date: Wed, 10 Jun 2026 10:54:43 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <donald.hunter@gmail.com>,
        <edumazet@google.com>, <horms@kernel.org>, <jiri@resnulli.us>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>
Subject: Re: [PATCH v20 net-next 7/9] octeontx2-af: npc: Support for custom
 KPU profile from filesystem
Message-ID: <aij1G1i3hTg8CZJ5@rkannoth-OptiPlex-7090>
References: <20260609040453.711932-1-rkannoth@marvell.com>
 <20260609040453.711932-8-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260609040453.711932-8-rkannoth@marvell.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDA0OCBTYWx0ZWRfX6SF7sMO3Eo3n
 w1KMVyYzGwPsNSwSnCk6wbm8zdSLvSjtTt8PxbbUC5BtrB5+Q2NrAVLtDA11LwtbX9vXL4i5ltS
 ZapW9xdB/NSwDVD4nHEaFzVKVM+wli+skZ4sQYZt1Y6qI66y9+75094TzhYLeuIwCwjw544pSZh
 4Q2d0QYIKn/vf//Lgnhol7CeHmoElMv/4cdlm1qbd9p6njn5O1Y71sU8Tg8E4m4HXaOsl6nII97
 z3ahb8QFXFnl4kDH85DGihfD3qbThPND+IuY1rch6aOghRIHSd3OijNLhuWXkMN1XeASKMgcJVL
 rkVF7dHabmdqhu9B8kj1umFY3DAUYH1agxdVxfyxazTRrJsTjdEZrCuj22Qc3nPG3QElVRhELV0
 pa50Jeo5/CZ0leeWclmso9+i4rbvNpd7EcPilXGEnd4QSuYMf55gPlPOdda3a9oqhg7MYpMHP/B
 8d95yUuuWa68Ip3n85Q==
X-Proofpoint-ORIG-GUID: PLbHMd9pWIZ-rt-wUhs4MeBc2s-glMm6
X-Authority-Analysis: v=2.4 cv=Aa2B2XXG c=1 sm=1 tr=0 ts=6a28f521 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=TtqV-g6YmW1Jfm2GSLaY:22 a=9R54UkLUAAAA:8
 a=M5GUcnROAAAA:8 a=cgfnWQVM4s1E-6Qd9ZAA:9 a=CjuIK1q_8ugA:10
 a=YTcpBFlVQWkNscrzJ_Dz:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: PLbHMd9pWIZ-rt-wUhs4MeBc2s-glMm6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_01,2026-06-09_02,2025-10-01_01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,gmail.com,google.com,kernel.org,resnulli.us,redhat.com,marvell.com];
	TAGGED_FROM(0.00)[bounces-297441-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[marvell.com:dkim,marvell.com:email,marvell.com:from_mime,linux.dev:url,vger.kernel.org:from_smtp,rkannoth-OptiPlex-7090:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	FORGED_RECIPIENTS(0.00)[m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:donald.hunter@gmail.com,m:edumazet@google.com,m:horms@kernel.org,m:jiri@resnulli.us,m:kuba@kernel.org,m:pabeni@redhat.com,m:sgoutham@marvell.com,m:andrew@lunn.ch,m:donaldhunter@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[marvell.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	MIME_TRACE(0.00)[0:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BCB78665ED5

On 2026-06-09 at 09:34:51, Ratheesh Kannoth (rkannoth@marvell.com) wrote:
> Flashing updated firmware on deployed devices is cumbersome. Provide a
> mechanism to load a custom KPU (Key Parse Unit) profile directly from
> the filesystem at module load time.
>
> When the rvu_af module is loaded with the kpu_profile parameter, the
> specified profile is read from /lib/firmware/kpu and programmed into
> the KPU registers. Add npc_kpu_profile_cam2 for the extended cam format
> used by filesystem-loaded profiles and support ptype/ptype_mask in
> npc_config_kpucam when profile->from_fs is set.
>
> Usage:
>   1. Copy the KPU profile file to /lib/firmware/kpu.
>   2. Build OCTEONTX2_AF as a module.
>   3. Load: insmod rvu_af.ko kpu_profile=<profile_name>
>
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260609040453.711932-1-rkannoth%40marvell.com says:

>  	cam0.dp2_data = ~kpucam->dp2 & kpucam->dp2_mask;
>>
>> +	if (profile->from_fs) {
>> +		u8 ptype = kpucam2->ptype;
>> +		u8 pmask = kpucam2->ptype_mask;
>> +
>> +		*val |= FIELD_PREP(GENMASK_ULL(57, 56), ptype & pmask);
>> +		*mask |= FIELD_PREP(GENMASK_ULL(57, 56), ~ptype & pmask);
>> +	}
>Bits [57:56] of this register fall inside the field that struct
>npc_kpu_cam currently declares as reserved:
>    struct npc_kpu_cam {
>    #if defined(__BIG_ENDIAN_BITFIELD)
>        u64 rsvd_63_56     : 8;
>        ...
>    #else
>        ...
>        u64 rsvd_63_56     : 8;
>    #endif
>    }
>The new code repurposes two of those reserved bits, gated only by the
>software flag profile->from_fs.  Is there a hardware capability
>indicator (chip revision, NPC_AF_CONST bit, etc.) that should also be
>consulted before driving these bits?  On silicon that does not
>implement the extended cam format, what behaviour do bits [57:56]
>exhibit?
>Should struct npc_kpu_cam be updated so the reserved field reflects
>the new ptype usage rather than leaving the kernel's hardware
>description and the runtime behaviour disagreeing?
Will update kernel's hw description as a patch to "net-next" once this
series is merged.

>> +		profile->kpu[kpu].cam_entries2 = entries;
>> +		profile->kpu[kpu].action_entries2 = entries;
>> +		ret = npc_alloc_kpu_cam2_n_action2(rvu, kpu, entries);
>> +		if (ret) {
>> +			dev_warn(rvu->dev,
>> +				 "profile entry allocation failed for kpu=%d for %d entries\n",
>> +				 kpu, entries);
>> +			return -EINVAL;
>> +		}
>Are cam_entries2 and action_entries2 being assigned in the wrong
>order with the allocation?  When npc_alloc_kpu_cam2_n_action2() fails
>(for example after cam2 succeeded but action2 returned -ENOMEM), the
>function returns -EINVAL but profile->kpu[kpu].cam_entries2 and
>action_entries2 stay at the entries value while cam2 / action2 may
>be partly NULL.
>profile->kpu aliases the file-scope npc_kpu_profiles[] array (set in
>npc_prepare_default_kpu()), so the inconsistent state persists in
>the static array even after the caller falls back to default.  The
>fallback path in npc_load_kpu_profile() calls npc_prepare_default_kpu()
>again, but that helper does not clear cam_entries2, action_entries2,
>cam2 or action2.
>Could the counts be set only after successful allocation, or zeroed
>on the error return?
cam_entries2 and action_entries2 are used only in case of loading from fs. So
it wont cause any issues.

> +static int npc_load_kpu_profile_from_fs(struct rvu *rvu)
>> +{
>> +	struct npc_kpu_profile_adapter *profile = &rvu->kpu;
>> +	const char *kpu_profile = rvu->kpu_pfl_name;
>> +	const struct firmware *fw = NULL;
>> +	int ret, fw_kpus = 0;
>> +	char path[512] = "kpu/";
>> +
>> +	if (strlen(kpu_profile) > sizeof(path) - strlen("kpu/") - 1) {
>> +		dev_err(rvu->dev, "kpu profile name is too big\n");
>> +		return -ENOSPC;
>> +	}
>> +
>> +	strcat(path, kpu_profile);
>> +
>> +	if (request_firmware_direct(&fw, path, rvu->dev))
>> +		return -ENOENT;
>> +
>> +	dev_info(rvu->dev, "Loading KPU profile from filesystem: %s\n",
>> +		 path);
>> +
>> +	rvu->kpu_fwdata = fw->data;
>> +	rvu->kpu_fwdata_sz = fw->size;
>> +
>> +	ret = npc_apply_custom_kpu(rvu, profile, true, &fw_kpus);
>> +	release_firmware(fw);
>> +	rvu->kpu_fwdata = NULL;
>> +
>> +	if (ret) {
>> +		rvu->kpu_fwdata_sz = 0;
>> +		dev_err(rvu->dev,
>> +			"Loading KPU profile from filesystem failed\n");
>> +		return ret;
>> +	}
>[Medium, Low]
>Is the change of the firmware search path a backwards-compatibility
>regression for existing users?
This was modified as part of review comment from Simon.

>On a separate note, on the success path this function leaves
>rvu->kpu_fwdata == NULL but rvu->kpu_fwdata_sz unchanged at fw->size
>(only the error path resets the size to 0).  rvu_npc_freemem() does
>kfree(rvu->kpu_fwdata) for the non-mmapped case, which assumes that
>field is either NULL or kmalloc'd memory; here rvu->kpu_fwdata is
>briefly aliased to fw->data (not kmalloc'd) before being NULLed.
>Should kpu_fwdata_sz be reset to 0 on success too, and should the
>firmware bytes be copied into kmalloc storage as the old code did to
>keep the pointer/size pair consistent?

This was intentional change. rvu->kpu_fwdata_sz is used later so we kept it
as such.

>> +				     npc_get_ikpu_nth_entry(rvu, idx),
>> +				     0, idx, true);
>>
>>  	/* Program KPU CAM and Action profiles */
>>  	num_kpus = rvu->kpu.kpus;
>> @@ -2068,6 +2348,11 @@ static void npc_parser_profile_init(struct rvu *rvu, int blkaddr)
>>
>>  	for (idx = 0; idx < num_kpus; idx++)
>>  		npc_program_kpu_profile(rvu, blkaddr, idx, &rvu->kpu.kpu[idx]);
>> +
>> +	if (profile->from_fs) {
>> +		rvu_write64(rvu, blkaddr, NPC_AF_PKINDX_TYPE(54), 0x03);
>> +		rvu_write64(rvu, blkaddr, NPC_AF_PKINDX_TYPE(58), 0x03);
>> +	}
>>  }
>Just above, the same function clamps PKIND iteration with an explicit
>comment about hardware capability:
>    /* First program IKPU profile i.e PKIND configs.
>     * Check HW max count to avoid configuring junk or
>     * writing to unsupported CSR addresses.
>     */
>    num_pkinds = rvu->kpu.pkinds;
>    num_pkinds = min_t(int, hw->npc_pkinds, num_pkinds);
>Do these new writes to NPC_AF_PKINDX_TYPE(54) and
>NPC_AF_PKINDX_TYPE(58) bypass that safeguard?  hw->npc_pkinds is read
>from NPC_AF_CONST1 at runtime and stored as u8, so 54/58 are not
>statically guaranteed to be valid on all silicon variants where this
>non-cn20k path runs.
>Could these be guarded with a check against hw->npc_pkinds, or
>expressed via a symbolic constant tied to a chip-revision check?
>Also, the values 54, 58, and 0x03 appear here without commentary or
>mention in the commit log.  Could a brief comment or named constant
>explain what these PKIND indices represent and what 0x03 selects, so
>the kernel-firmware contract is visible to readers?
This is very low level hw bits (similar to npc_profile.h)

