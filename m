Return-Path: <netdev+bounces-296351-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YkzyEsopJmrPSwIAu9opvQ
	(envelope-from <netdev+bounces-296351-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 04:32:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 971E8652402
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 04:32:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=marvell.com header.s=pfpt0220 header.b=JqCmCtkr;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296351-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-296351-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=marvell.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 43450302BE92
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 02:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F202313E38;
	Mon,  8 Jun 2026 02:30:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C45318EC4;
	Mon,  8 Jun 2026 02:30:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780885839; cv=none; b=bP12jDjzT9wfW/unz35GwjIKa8De8KewwntAu8oRGQYsY56T88gpntTNniPHl3NwYZITK6/lQLw3Yuzjp8IUhTj7y6JRQYavEhRKu49ws9Hdm07MoLSgIctJ6+TQOkvVmXL1G8BGz9wXznE/PrTne1ce1bwggUmvL9HuZtIaqNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780885839; c=relaxed/simple;
	bh=VwEHt4lBW3Q8TILoTVFrCNJgdUa6Tm9lICTl+wSSH/s=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aRfs1h59T5inQk9lcSZf4cE6P25eu9fyV58pwuCyUEMZpBNGn91xGoqhjx3LM2/ZRkARtPDgeEpFje1HhhLCVN3WWcKX5UkS84H/cDuSPO+GyGfpH9BGwfISXtlZnTmTQU8IlaA/C8dzm+qRnNVKJ70sFOaRMWEqMVv1rRzwUY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=JqCmCtkr; arc=none smtp.client-ip=67.231.156.173
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6580G6TL938646;
	Sun, 7 Jun 2026 19:30:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=u
	QUza0dVKTk1JYfuEjtv9ZTgAoDFuIqzgdJxh9O/2wc=; b=JqCmCtkr11xCyPxhG
	alcevLMKHFx1txBoAy5EwwT0Sr3cuknLA3rjo0ou+5cJdPRmIUpjhWUoO+pog9sg
	f0mI/Ovr6LYe8Y2otpsCxZzSOMbK0tSwCqpIv8IFZvSiGhYnP9AasVTYpYhwipSu
	b9fRdV/W8lI2n5CuWFSkgfZmcPSoLMh92TXFrs4Tonrnt1NZOfoegnnYuOZ2IXqg
	6C7lsOV+DRsXz0veGtj/JERCejh3nWaACNfcTCz1WCkZgVqdxRhYEqlDl9ebUBt/
	VmA9K5qPJ9yrsLCT5jF1y00CUgzZXeiI6bmPKKc0gdk6R7CvNHLWWAjTM+mm4aMh
	qm4xg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4emk2ems6a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 07 Jun 2026 19:30:28 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 7 Jun 2026 19:30:28 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sun, 7 Jun 2026 19:30:27 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 9727B5B6932;
	Sun,  7 Jun 2026 19:30:24 -0700 (PDT)
Date: Mon, 8 Jun 2026 08:00:23 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <donald.hunter@gmail.com>,
        <edumazet@google.com>, <horms@kernel.org>, <jiri@resnulli.us>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>
Subject: Re: [PATCH v19 net-next 7/9] octeontx2-af: npc: Support for custom
 KPU profile from filesystem
Message-ID: <aiYpP6n7OjDQI7ak@rkannoth-OptiPlex-7090>
References: <20260605063245.3553861-1-rkannoth@marvell.com>
 <20260605063245.3553861-8-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260605063245.3553861-8-rkannoth@marvell.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDAxOSBTYWx0ZWRfX6EwmnzPCDEy+
 gq7l5IKbbDOvc6BC3u3Vc687xpx3seHDYcG4eekM6pES6l2toikLlXbxMtL4CYWjKa6IgrOJ7v9
 eUov8LMlIFREDnjYRmLZj6FSLy+uOkZ/L1jCi6teHhwLO7V0y7upmnJd+W4vdrhiddpu3pJKupF
 7N3aPY57oC0j4kmmbOpk4ajsKauoogfy/pa7U6VwlTlPViQENL8Zs1xw5CzJexIc0BEgTCasrQ1
 mJJUJjpqCE6PN6OwAcUn1q8+U0L9F97pPhbuzhukaBIS93zyb25fGs8JXyi6WBeKawruQv4KYM0
 7aTFJj4Ds7YTPw0zAXaU6/Ry7e0zIp3wFFNIkUP8r/o3N31SU1+VNOK7L1Jn/lnbLl0dbVszkSx
 eyHLpuHzEfL5W9Lnb7fZBQcX9KupGsiFoVqdnlui7FZFjhgX58flw1RxU+O5Rrlej48MgOr8ZE0
 n/IIZkeWcMCdYIU56rg==
X-Proofpoint-GUID: onr855pmfFEd2rzRB25n_xRYMizhxtmn
X-Authority-Analysis: v=2.4 cv=bJUm5v+Z c=1 sm=1 tr=0 ts=6a262944 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=QXcCYyLzdtTjyudCfB6f:22 a=9R54UkLUAAAA:8
 a=M5GUcnROAAAA:8 a=zFpz91DLgTSb5eYT8c0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=YTcpBFlVQWkNscrzJ_Dz:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: onr855pmfFEd2rzRB25n_xRYMizhxtmn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_01,2026-06-05_02,2025-10-01_01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,gmail.com,google.com,kernel.org,resnulli.us,redhat.com,marvell.com];
	TAGGED_FROM(0.00)[bounces-296351-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[rkannoth-OptiPlex-7090:mid,linux.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,marvell.com:dkim,marvell.com:from_mime,marvell.com:email,vger.kernel.org:from_smtp];
	FORGED_RECIPIENTS(0.00)[m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:donald.hunter@gmail.com,m:edumazet@google.com,m:horms@kernel.org,m:jiri@resnulli.us,m:kuba@kernel.org,m:pabeni@redhat.com,m:sgoutham@marvell.com,m:andrew@lunn.ch,m:donaldhunter@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[marvell.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
X-Rspamd-Queue-Id: 971E8652402

On 2026-06-05 at 12:02:43, Ratheesh Kannoth (rkannoth@marvell.com) wrote:
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

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260605063245.3553861-1-rkannoth%40marvell.com says

>> +	struct npc_kpu_profile_action *action2;
>> +	struct npc_kpu_profile_cam2 *cam2;
>>  };
>The on-disk difference between npc_kpu_profile_cam and
>npc_kpu_profile_cam2 is two extra trailing bytes (ptype, ptype_mask).
>Could a single normalized in-memory representation work, with the FS
>loader filling ptype/ptype_mask to zero when reading the legacy layout?
>Every consumer now has to dispatch through accessor helpers
>(npc_get_kpu_cam_nth_entry(), npc_get_num_kpu_cam_entries(),
>npc_get_ikpu_nth_entry(), ...) gated on profile->from_fs, and any new
>consumer that forgets the accessor reads the wrong table silently.
>The names cam2 / action2 / ikpu2 also do not carry semantic meaning on
>their own — would something tied to the format (for example
>cam_with_ptype) read more clearly?
>The from_fs flag also conflates two orthogonal concerns: where the bytes
>came from, and which on-disk schema they use. Is it intentional that the
>new extended format cannot be shipped through the FW-DB path, and that a
>legacy-format profile cannot be loaded from /lib/firmware/kpu/?
This is a new feature request for customer, prior to this we did not have support
for filesystem loading

> +		u8 ptype = kpucam2->ptype;
>> +		u8 pmask = kpucam2->ptype_mask;
>> +
>> +		*val |= FIELD_PREP(GENMASK_ULL(57, 56), ptype & pmask);
>> +		*mask |= FIELD_PREP(GENMASK_ULL(57, 56), ~ptype & pmask);
>> +	}
>The encoding writes ptype into bits [57:56] of the 64-bit CAM word, but
>struct npc_kpu_cam declares those bits as a reserved 8-bit field:
>    struct npc_kpu_cam {
>    #if defined(__BIG_ENDIAN_BITFIELD)
>        u64 rsvd_63_56     : 8;
>        u64 state          : 8;
>        ...
>Should the bitfield in npc_kpu_cam be extended with a named ptype member
>so the encoding is visible in the struct layout (and checkable by sparse)?
>ptype and ptype_mask in npc_kpu_profile_cam2 are u8 (8-bit), but only the
>low 2 bits land in the CAM word via GENMASK_ULL(57, 56); any user passing
>ptype with bits above bit 1 silently has those bits dropped. Is that
>intentional, and if so could the field width be enforced (range-checked
>on load) to surface bad firmware data?
>There is also no #define for the bit positions or for the constant 0x03
>that npc_parser_profile_init() pairs with NPC_AF_PKINDX_TYPE later in
>this patch — a symbolic name would make the relationship between the
>two writes clear.
This is customer specific and all these are intentional.

>that npc_parser_profile_init() pairs with NPC_AF_PKINDX_TYPE later in
>this patch — a symbolic name would make the relationship between the
>two writes clear.
>[ ... ]
>> +static int npc_apply_custom_kpu_from_fs(struct rvu *rvu,
>> +					struct npc_kpu_profile_adapter *profile)
>> +{
>> +	size_t hdr_sz = sizeof(struct npc_kpu_profile_fwdata), offset = 0;
>> +	const struct npc_kpu_profile_fwdata *fw;
>> +	struct npc_kpu_profile_action *action;
>> +	struct npc_kpu_profile_cam2 *cam2;
>> +	struct npc_kpu_fwdata *fw_kpu;
>> +	int entries, ret, entry, kpu;
>>
>>  	fw = rvu->kpu_fwdata;
>>
>> +	/* Binary blob contains ikpu actions entries at start of data[0] */
>> +	profile->ikpu2 = devm_kcalloc(rvu->dev, 1,
>> +				      sizeof(ikpu_action_entries),
>> +				      GFP_KERNEL);
>> +	if (!profile->ikpu2)
>> +		return -ENOMEM;
>> +
>> +	action = (struct npc_kpu_profile_action *)(fw->data + offset);
>> +
>> +	if (rvu->kpu_fwdata_sz < hdr_sz + sizeof(ikpu_action_entries))
>> +		return -EINVAL;
>Does the order here leave profile->ikpu2 charged to the device with
>uninitialized contents on the -EINVAL path?
>The devm_kcalloc() runs before the size check, and on error
>profile->from_fs is not set, so npc_get_ikpu_nth_entry() will not
>dereference ikpu2 today — but any future caller that consults
>profile->ikpu2 directly would see uninitialized memory at the right size.
>Could the validation move ahead of the allocation, with memcpy following
>both?

>
>> +	/* The firmware layout does dependent on the internal size of
>> +	 * ikpu_action_entries.
>> +	 */
>> +	memcpy((void *)profile->ikpu2, action, sizeof(ikpu_action_entries));
>> +	offset += sizeof(ikpu_action_entries);
>The fwdata header declares the KPU count via fw->kpus but does not
>declare an ikpu/pkind count for this leading region — its size is
>implicitly hardcoded to ARRAY_SIZE(ikpu_action_entries), an in-tree
>kernel array. The comment acknowledges this hidden ABI dependency.
>If ikpu_action_entries ever grows or shrinks in-tree, every previously
>distributed FS blob silently misaligns: the kernel reads the wrong
>number of bytes for ikpu actions, and all subsequent KPU CAM/action
>offsets are off. The size check
>"if (rvu->kpu_fwdata_sz < hdr_sz + sizeof(ikpu_action_entries))" only
>ensures there are enough bytes — it does not ensure the bytes actually
>represent ikpu actions of that exact count.
>Could the on-disk format carry an explicit length / pkind count for the
>ikpu region so the kernel can validate and reject mismatched blobs?
>
if  npc_apply_custom_kpu_from_fs() fails with above mentioned -EINVAL,
npc_prepare_default_kpu(rvu, profile) again intialize profile->ikpu2 to
static memory in npc_load_kpu_profile() function.

>profile->ikpu2 directly would see uninitialized memory at the right size.
>Could the validation move ahead of the allocation, with memcpy following
>both?
>> +	/* The firmware layout does dependent on the internal size of
>> +	 * ikpu_action_entries.
>> +	 */
>> +	memcpy((void *)profile->ikpu2, action, sizeof(ikpu_action_entries));
>> +	offset += sizeof(ikpu_action_entries);
>The fwdata header declares the KPU count via fw->kpus but does not
>declare an ikpu/pkind count for this leading region — its size is
>implicitly hardcoded to ARRAY_SIZE(ikpu_action_entries), an in-tree
>kernel array. The comment acknowledges this hidden ABI dependency.
>If ikpu_action_entries ever grows or shrinks in-tree, every previously
>distributed FS blob silently misaligns: the kernel reads the wrong
>number of bytes for ikpu actions, and all subsequent KPU CAM/action
>offsets are off. The size check
>"if (rvu->kpu_fwdata_sz < hdr_sz + sizeof(ikpu_action_entries))" only
>ensures there are enough bytes — it does not ensure the bytes actually
>represent ikpu actions of that exact count.
>Could the on-disk format carry an explicit length / pkind count for the
>ikpu region so the kernel can validate and reject mismatched blobs?

There is no field (currently) in structure to indicate number of ikpu_action_entries
in binary blob. So we keep the number same in all binary blob. We can't add the size
as it will break backward compatability.

> +	for (kpu = 0; kpu < fw->kpus; kpu++) {
>[ ... ]
>> +		fw_kpu = (struct npc_kpu_fwdata *)(fw->data + offset);
>> +		if (fw_kpu->entries <= 0) {
>> +			dev_warn(rvu->dev,
>> +				 "Invalid kpu entries on KPU%d\n", kpu);
>> +			return -EINVAL;
>> +		}
>> +
>> +		entries = min_t(int, fw_kpu->entries, rvu->hw->npc_kpu_entries);
>[ ... ]
>> +		cam2 = (struct npc_kpu_profile_cam2 *)fw_kpu->data;
>> +		offset += sizeof(*fw_kpu) + fw_kpu->entries * sizeof(*cam2);
>> +		action = (struct npc_kpu_profile_action *)(fw->data + offset);
>> +		offset += fw_kpu->entries * sizeof(*action);
>> +		if (rvu->kpu_fwdata_sz < hdr_sz + offset) {
>Could fw_kpu->entries get an upper bound check before being used in the
>offset arithmetic? The FW-DB sibling npc_apply_custom_kpu_from_fw()
>clamps via min_t(int, fw_kpu->entries, KPU_MAX_CST_ENT) before doing the
>arithmetic, while this path only clamps after. On a 64-bit size_t the
>post-arithmetic check correctly catches malformed blobs, but defensive
>symmetry with the FW-DB path would be nice.
OK. will add to net-next tree after this series is merged.

>[ ... ]
>> +	fw = rvu->kpu_fwdata;
>>  	if (le64_to_cpu(fw->signature) != KPU_SIGN) {
>>  		dev_warn(rvu->dev, "Invalid KPU profile signature %llx\n",
>>  			 fw->signature);
>Two distinct on-disk binary formats now share the same KPU_SIGN
>("kpuprof\0") signature and the same npc_kpu_profile_fwdata header.
>The FW-DB layout expects fwdata->data[0] to start directly with KPU
>entries; the new FS layout expects data[0] to start with
>sizeof(ikpu_action_entries) bytes of ikpu actions, then KPU entries
>encoded as npc_kpu_profile_cam2 (with ptype/ptype_mask) instead of
>npc_kpu_profile_cam.
>Nothing in npc_apply_custom_kpu() distinguishes the two; the choice is
>made by which load path is invoked (the from_fs argument). Is that a
>deliberate decision?
Yes. from_fs binary blob has npc_kpu_profile_cam2 format.

>If a user accidentally drops a FW-DB-format blob into /lib/firmware/kpu,
>the signature passes, npc_apply_custom_kpu_from_fs() memcpys the first
>sizeof(ikpu_action_entries) bytes (which are KPU CAM/action data in that
>layout) into profile->ikpu2, and npc_parser_profile_init() then programs
>those bytes into NPC pkind action registers via
>npc_config_kpuaction(rvu, blkaddr, npc_get_ikpu_nth_entry(rvu, idx),
>0, idx, true). The remaining KPU entries are read with the wrong layout
>(npc_kpu_profile_cam2 vs npc_kpu_profile_cam) on top.
>Could the blob carry a layout magic or version field independent of
>load source, and the loader reject mismatches?
User has to load correct FW to get requested feature. We will suggest customer
your suggestion to have different signatures.

> +	*fw_kpus = fw->kpus;
>The cn20k early return at the top of this function returns without
>writing *fw_kpus. Should that path also set *fw_kpus, or should the
>parameter be removed from cn20k call sites?
>Today npc_load_kpu_profile_from_fw() declares int fw_kpus = 0 and never
>reads it back, so the dead local hides the asymmetry. If cn20k is ever
>wired into the FS path the trailing
>"rvu->kpu.kpus = fw_kpus; profile->kpus = fw_kpus;" in
>npc_load_kpu_profile_from_fs() will silently zero kpus and disable KPU
>programming because *fw_kpus was never written.

Currently only cn10k has support for custom binary support from filesystem.

> +	int ret, fw_kpus = 0;
>> +	char path[512] = "kpu/";
>> +
>> +	if (strlen(kpu_profile) > sizeof(path) - strlen("kpu/") - 1) {
>> +		dev_err(rvu->dev, "kpu profile name is too big\n");
>> +		return -ENOSPC;
>> +	}
>> +
>> +	strcat(path, kpu_profile);
>rvu->kpu_pfl_name is char[KPU_NAME_LEN] (32 bytes), so strlen() of that
>buffer can never exceed sizeof(path) - 5 = 507. Is the strlen() check
>intended as defense-in-depth, or is a smaller path[KPU_NAME_LEN +
>sizeof("kpu/")] buffer (or snprintf(path, sizeof(path), "kpu/%.32s",
>kpu_profile)) preferable so the bound and intent line up?
We will add it in defensive pathset to net-next following this patchseries
is merged.

>> +	rvu->kpu.kpus = fw_kpus;
>> +	profile->kpus = fw_kpus;
>> +	profile->from_fs = true;
>> +	return 0;
>> +}
>The success path leaves rvu->kpu_fwdata_sz non-zero while
>rvu->kpu_fwdata has been set to NULL. The error path correctly zeroes
>both.
>npc_load_mkex_profile() and npc_cn20k_load_mkex_profile() consult
>kpu_fwdata_sz to decide whether to skip the FW-DB mkex lookup, so the
>asymmetry is harmless today, but any future consumer that uses
>kpu_fwdata_sz to gate a kpu_fwdata dereference will hit a NULL deref.
>Could kpu_fwdata_sz be cleared symmetrically on success?
This is intentional. We dont need to keep this symmetry.

>> +void npc_load_kpu_profile(struct rvu *rvu)
>> +{
>[ ... ]
>> +	/* Filesystem-based KPU loading is not supported on cn20k.
>> +	 * npc_prepare_default_kpu() was invoked earlier, but control
>> +	 * reached this point because the default profile was not selected.
>> +	 * No need to call it again.
>> +	 */
>> +	if (!is_cn20k(rvu->pdev)) {
>> +		if (!npc_load_kpu_profile_from_fs(rvu))
>> +			return;
>> +	}
>> +
>> +	/* First prepare default KPU, then we'll customize top entries. */
>> +	npc_prepare_default_kpu(rvu, profile);
>> +	if (!npc_load_kpu_profile_from_fw(rvu))
>> +		return;
>>
>>  	npc_prepare_default_kpu(rvu, profile);
>>  }
>The comment says "No need to call it again" but the very next executable
>line after the if (!is_cn20k(...)) block is exactly
>npc_prepare_default_kpu(rvu, profile). The second call is in fact needed
>on non-cn20k to reset state corrupted by a partial FS attempt before the
>FW path runs. Could the comment be reworded to reflect that?
>
This indicate that npc_prepare_default_kpu() called above, so we dont have to callit before
calling npc_load_kpu_profile_from_fs() in cn10k.

>[ ... ]
>>  	for (idx = 0; idx < num_kpus; idx++)
>>  		npc_program_kpu_profile(rvu, blkaddr, idx, &rvu->kpu.kpu[idx]);
>> +
>> +	if (profile->from_fs) {
>> +		rvu_write64(rvu, blkaddr, NPC_AF_PKINDX_TYPE(54), 0x03);
>> +		rvu_write64(rvu, blkaddr, NPC_AF_PKINDX_TYPE(58), 0x03);
>> +	}
>>  }
>A few questions about these two writes:
>The pkind indices 54 and 58 match npc.h enum values
>NPC_RX_CPT_HDR_PTP_PKIND = 54 and NPC_RX_CPT_HDR_PKIND = 58 — could
>those named constants be used here so the relationship is explicit?
>The constant 0x03 has no symbolic name in rvu_reg.h, and there is no
>#define for the bits in NPC_AF_PKINDX_TYPE. Could a named macro be added
>that documents what value is being programmed?
>The same function carefully bounds pkind iteration earlier with
>"num_pkinds = min_t(int, hw->npc_pkinds, num_pkinds);" but these two
>writes target indices 54 and 58 unconditionally. hw->npc_pkinds comes
>from NPC_AF_CONST1[19:12] and is silicon-dependent — should these be
>gated on hw->npc_pkinds >= 59 (or on the corresponding pkind being
>defined) to avoid writing undefined CSRs on a future variant?
>Finally, is it intentional that this hardware register configuration is
>chosen based on the load mechanism (from_fs) rather than profile
>content? Any future FS profile that does not expect pkinds 54 and 58 to
>be configured this way would silently misbehave. Could the writes be
>driven from the profile data itself?

This is very customer specific and intentional. I did not find any speific
names for these values as there are many values in npc_profie.h as well.

