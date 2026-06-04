Return-Path: <netdev+bounces-295037-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WTo7Kw7sIGom9gAAu9opvQ
	(envelope-from <netdev+bounces-295037-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 05:07:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E838163CA53
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 05:07:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=marvell.com header.s=pfpt0220 header.b=VUftr+Gi;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295037-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295037-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=marvell.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CAF2E3015C85
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 03:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CAD6343D91;
	Thu,  4 Jun 2026 03:07:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32BA45000;
	Thu,  4 Jun 2026 03:07:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780542440; cv=none; b=ggpsFmdFPLSUjNZRhkHmztJ2oTlST90RlcMl6LiCyM3YCUhOfPoykakOSQesEbrhCpInrdbLUoIFxF4mngm2+GhVOImD/oz4Pxq5tY4OQ5i1p3IPhCiLXpGEEP2ySHdx8SBvC6+Mj9AJkg2dTl4018ZOLvrKpGgW49Qt2CYoz3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780542440; c=relaxed/simple;
	bh=yEYmjYGBOe1WM/9ispk0aw+6Wi/+4c6urNBFXfYikpE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AMOE6fXtY5b04v895bpkcDuC4aV+2mTGnl5MkHZtuwBz+LH9iaSrRJEG/LXUuebMIaPw1HyTtLesSZ2e76W4HeBgEClPCPDPpA3QNNU3WmLgwNEOAbVM5BEfMSKjRPQsC5mCKaxZRq5X762BHhpRD4earr45thqHfbPKJH7rn24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=VUftr+Gi; arc=none smtp.client-ip=67.231.148.174
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 653JKsRC023755;
	Wed, 3 Jun 2026 20:07:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=tZbcFAIUFTEKSrUwRA2IGBdit
	I0cO/1cxcIrr3sTxAs=; b=VUftr+Gi1+aW3ibzSm+LaKPdfvP0sIgKiOI+ay5qw
	mr9CnXQvBY7FGi8zlnQK+XXMvh+4qjALQS+DAZmvfXoszy6g2Jn13IPH1xbiyfUC
	pLek+2d//1KuItJ9tW8qWDHBF3qxyNWOcEvPsJBFc03NhmVZNA9jltnQcBij8wxw
	RiH+6+J2xdjDJNgg4LQLsnJmb1pgyqT9MQrzZlLhj2K0mpKEwbXftHsH14IWH/wY
	m9EkL95tWjZLlfL7gBPi++s75YhWvsyuBIstbQ6MHXIpf7AtkimcDFfXZH7fY8R+
	QLtk7Ff2exRIrBGyI3d8E6dVmoRkEHO9VGhW0F3domcsw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4ej8v9cu1t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jun 2026 20:07:08 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 3 Jun 2026 20:07:07 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 3 Jun 2026 20:07:07 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id EE5F93F704E;
	Wed,  3 Jun 2026 20:07:03 -0700 (PDT)
Date: Thu, 4 Jun 2026 08:37:02 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <donald.hunter@gmail.com>,
        <edumazet@google.com>, <horms@kernel.org>, <jiri@resnulli.us>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>
Subject: Re: [PATCH v18 net-next 6/8] octeontx2-af: npc: Support for custom
 KPU profile from filesystem
Message-ID: <aiDr1lN-gtIKakgx@rkannoth-OptiPlex-7090>
References: <20260602060359.1894952-1-rkannoth@marvell.com>
 <20260602060359.1894952-7-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260602060359.1894952-7-rkannoth@marvell.com>
X-Proofpoint-ORIG-GUID: pIiV-z25rgjUKr6AiGi92BnXYnXDJj8B
X-Authority-Analysis: v=2.4 cv=JNQLdcKb c=1 sm=1 tr=0 ts=6a20ebdc cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=TtqV-g6YmW1Jfm2GSLaY:22 a=9R54UkLUAAAA:8
 a=M5GUcnROAAAA:8 a=V-g0x8o74AEDESTx1VsA:9 a=CjuIK1q_8ugA:10
 a=YTcpBFlVQWkNscrzJ_Dz:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDAyOCBTYWx0ZWRfX3313O3S3zZ7b
 rophRGN40CbkRoBhwDoYaeWoU0Yh9S5OnjMfXZ4vlB/gshrAUTTNxGIA+zMK7viPe8UYNa7xCLk
 bR5KQb8Mf//nfDNkOomWrmvGDY/DwfagyM6QUm9xp/78M762nNZ//zpu5I8ZNQhtCxkYt9H1g7P
 qzQ2tuXw5oSh8DSYidZh89ELE7nMbunMlmrAhOQG15vQmf7PMIw+LU/r7DGFL3R7SAoQUDYe0uf
 CjatCGt1DCs5Ke1NpJaDHnrZQUCEBp0bv+QrVujY7fEnalcWMUMJCD/BJvqTugcU3q2P3p88F4L
 aUNbG6tzrGq8rFzo3eUGMbn6xoovvapXk/sSOllKq9HqSlaAKi4rx8lorgoWu2JAyA8zdAXE8sx
 o3Y+qtqJ/tLCBTqF8boj/9bFT2NR3c5EAY8zeaoM/3jwQfK43figSs5xGuoZYAkt9USmp0A/HHf
 e3VF8BQAARFJ6DJSv/g==
X-Proofpoint-GUID: pIiV-z25rgjUKr6AiGi92BnXYnXDJj8B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_01,2026-05-28_03,2025-10-01_01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,gmail.com,google.com,kernel.org,resnulli.us,redhat.com,marvell.com];
	TAGGED_FROM(0.00)[bounces-295037-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:donald.hunter@gmail.com,m:edumazet@google.com,m:horms@kernel.org,m:jiri@resnulli.us,m:kuba@kernel.org,m:pabeni@redhat.com,m:sgoutham@marvell.com,m:andrew@lunn.ch,m:donaldhunter@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[marvell.com:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E838163CA53

On 2026-06-02 at 11:33:57, Ratheesh Kannoth (rkannoth@marvell.com) wrote:
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

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260602060359.1894952-1-rkannoth%40marvell.com says

>> -	for (idx = 0; idx < num_pkinds; idx++)
>> -		npc_config_kpmaction(rvu, blkaddr, &rvu->kpu.ikpu[idx],
>> +	/* Cn20k does not support Custom profile from filesystem */
>> +	for (idx = 0; idx < num_pkinds; idx++) {
>> +		act = npc_get_ikpu_nth_entry(rvu, idx);
>> +		if (!act)
>> +			continue;
>> +
>> +		npc_config_kpmaction(rvu, blkaddr, act,
>>  				     0, idx, true);
>> +	}
>Can act ever be NULL on this path?  npc_get_ikpu_nth_entry() returns
>either &profile->ikpu2[n] (when from_fs is true) or &profile->ikpu[n],
>neither of which can be NULL.  And as the comment above notes, cn20k
>does not take the from_fs path at all (it is gated by !is_cn20k() in
>npc_load_kpu_profile()), so ikpu always points at the static
>ikpu_action_entries[].
>If that is the case, the if (!act) continue check is dead.
I agree, but there is a plan to add it in future, so would like to keep this check

>> +	if (profile->from_fs) {
>> +		u8 ptype = kpucam2->ptype;
>> +		u8 pmask = kpucam2->ptype_mask;
>> +
>> +		*val |= FIELD_PREP(GENMASK_ULL(57, 56), ptype & pmask);
>> +		*mask |= FIELD_PREP(GENMASK_ULL(57, 56), ~ptype & pmask);
>> +	}
>The cast const struct npc_kpu_profile_cam2 *kpucam2 = (void *)kpucam is
>unconditional, but the function's parameter is typed as
>struct npc_kpu_profile_cam *.  The two structures differ in size
>(12 vs 14 bytes packed).
>The reads of kpucam2->ptype and kpucam2->ptype_mask are gated by
>profile->from_fs, but the gate relies on a cross-function invariant:
>the from_fs flag must imply that npc_get_kpu_cam_nth_entry() was used
>and returned a cam2-typed element.  There is no static assertion or
>runtime check tying these two together.
>Could a BUILD_BUG_ON ensuring
>offsetof(struct npc_kpu_profile_cam2, ptype) == sizeof(struct npc_kpu_profile_cam)
>be added so that a future layout change is caught at compile time?
>The bits that ptype/ptype_mask are written into are bits 57:56 of cam0
>and cam1, but struct npc_kpu_cam in npc.h still declares those bits as
>part of rsvd_63_56 : 8 in both endianness branches.  Should the cam
>struct be updated with an explicit ptype : 2 / rsvd_63_58 : 6 split (or
>similar) so the contract that those two reserved bits are now live is
>visible at the struct definition?
>Is there also a way to assert that the silicon variants on which the
>filesystem profile path runs (cn9k, cn10k) actually decode bits 57:56
>as ptype-match?

The rsvd_63_56 field in struct npc_kpu_cam remains intentionally generic because this shared structure header
is consumed across multiple legacy silicon generations where those bits are strictly reserved.
Modifying the base bitfield definition would break backward compatibility metrics for older targets.
The localized use of FIELD_PREP(GENMASK_ULL(57, 56), ...) inside the from_fs block serves as the explicit.

>> +		return -ENOMEM;
>> +
>> +	kpu->action2 = devm_kcalloc(rvu->dev, num_entries,
>> +				    sizeof(*kpu->action2), GFP_KERNEL);
>> +	if (!kpu->action2)
>> +		return -ENOMEM;
>> +
>> +	return 0;
>> +}
>Could this function be storing per-device devm allocations in
>module-global static state?
>adapter->kpu is set by npc_prepare_default_kpu() to npc_kpu_profiles
>from npc_profile.h, which is a static module-global array.
>kpu->cam2 and kpu->action2 are devm_kcalloc(rvu->dev, ...) so the
>underlying memory is freed at device release, but the pointers (and
>the cam_entries2/action_entries2 counters set in
>npc_apply_custom_kpu_from_fs()) remain in the static array.
>After unbind, would a subsequent rebind that uses the default profile
>or the from_fw path leave dangling pointers and non-zero
There is only one AF device per system.

> +static int npc_apply_custom_kpu_from_fw(struct rvu *rvu,
>> +					struct npc_kpu_profile_adapter *profile)
>>  {
>>  	size_t hdr_sz = sizeof(struct npc_kpu_profile_fwdata), offset = 0;
>> +	const struct npc_kpu_profile_fwdata *fw;
>>  	struct npc_kpu_profile_action *action;
>> -	struct npc_kpu_profile_fwdata *fw;
>>  	struct npc_kpu_profile_cam *cam;
>>  	struct npc_kpu_fwdata *fw_kpu;
>> -	int entries;
>> -	u16 kpu, entry;
>> +	int entries, entry, kpu;
>>
>> -	if (is_cn20k(rvu->pdev))
>> -		return npc_cn20k_apply_custom_kpu(rvu, profile);
>> +	fw = rvu->kpu_fwdata;
>> +
>> +	for (kpu = 0; kpu < fw->kpus; kpu++) {
>> +		if (rvu->kpu_fwdata_sz < hdr_sz + offset) {
>> +			dev_warn(rvu->dev,
>> +				 "Profile size mismatch on KPU%i parsing\n",
>> +				 kpu + 1);
>> +			return -EINVAL;
>> +		}
>> +
>> +		fw_kpu = (struct npc_kpu_fwdata *)(fw->data + offset);
>> +		if (fw_kpu->entries < 0) {
>Is the size check above missing sizeof(*fw_kpu)?  The check guards
>that offset is reachable, but the next statement reads fw_kpu->entries
>which is at fw->data + offset + 0..3.  When kpu_fwdata_sz equals
>hdr_sz + offset exactly, the read of fw_kpu->entries is past the end
>of the firmware buffer.
This is a prexisintg issue in the code, will fix it as part of patch to "net" tree
once this series is merged.

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
>Should the size validation happen before the devm allocation?  When
>kpu_fwdata_sz is too small the function returns -EINVAL with
>profile->ikpu2 already allocated and stored.  Devm reclaims at device
>release, but on every malformed-firmware probe a small buffer is left
>orphaned and reachable through profile->ikpu2 (with from_fs reset to
>false on the fallback path, so it is not currently dereferenced).

There is only one AF device per system and this loading of profiles is done during driver
init() time.

>> +
>> +	/* The firmware layout does dependent on the internal size of
>> +	 * ikpu_action_entries.
>> +	 */
>> +	memcpy((void *)profile->ikpu2, action, sizeof(ikpu_action_entries));
>> +	offset += sizeof(ikpu_action_entries);
>Is the firmware ABI here tied to a kernel-internal sizeof?
>ikpu_action_entries[] is a static array in npc_profile.h.  The
>filesystem blob has no field declaring how many ikpu entries it
>contains, so the offset advance depends on the kernel build.  If a
>future kernel adds a pkind to ikpu_action_entries, every existing
>filesystem blob will be silently misparsed (offset advances by the
>wrong amount, then cam entries are read from the wrong location)
>even though the major version check still passes.
We have support only for little endian. And ikpu_action_entries structure does not have a fieled
to hold "size" currently. we cant add it now as it would break backward compatability.

>>  		return npc_cn20k_apply_custom_kpu(rvu, profile);
>>
>>  	if (rvu->kpu_fwdata_sz < hdr_sz) {
>>  		dev_warn(rvu->dev, "Invalid KPU profile size\n");
>>  		return -EINVAL;
>>  	}
>> +
>> +	fw = rvu->kpu_fwdata;
>>  	if (le64_to_cpu(fw->signature) != KPU_SIGN) {
>>  		dev_warn(rvu->dev, "Invalid KPU profile signature %llx\n",
>>  			 fw->signature);
>The new filesystem-loaded blob and the existing fwdb blob share the
>same KPU_SIGN signature and the same struct npc_kpu_profile_fwdata
>header, but data[] has a different binary layout: the filesystem
>format prepends a sizeof(ikpu_action_entries) block of ikpu actions
>and uses npc_kpu_profile_cam2 (16 bytes packed) instead of
>npc_kpu_profile_cam (14 bytes packed).
>Dispatch is decided entirely by the loader path:
>	return from_fs ? npc_apply_custom_kpu_from_fs(rvu, profile) :
>		npc_apply_custom_kpu_from_fw(rvu, profile);
>with nothing in the file itself indicating which layout applies.
>If a fwdb-formatted blob is dropped into /lib/firmware/kpu/<name>,
>signature and version checks pass, then the parser silently
>misinterprets the bytes, programming arbitrary values plus enabled
>ptype-match bits into the KPU CAM and PKIND ACTION CSRs.
>Should the on-disk header carry a format/cam_format_version field, or
>should the cam2 layout use a distinct signature?
This is intentional as per customer requirement.

>> +
>>  	profile->custom = 1;
>> -	profile->name = fw->name;
>> +	profile->name = sfw->name;
>>  	profile->version = le64_to_cpu(fw->version);
>> -	profile->mcam_kex_prfl.mkex = &fw->mkex;
>> -	profile->lt_def = &fw->lt_def;
>If npc_load_kpu_profile_from_fs() runs first and fails, then
>npc_load_kpu_profile_from_fw() retries via npc_apply_custom_kpu()
>again, a second sfw is allocated and overwrites profile->name,
>profile->mcam_kex_prfl.mkex and profile->lt_def.  The first sfw is
>still tracked by devm but no longer referenced.
>Is one orphaned sfw per probe acceptable, or should the helper reuse
>the existing sfw on retry?
There is only one AF device per system

>> +	release_firmware(fw);
>> +	rvu->kpu_fwdata = NULL;
>> +
>> +	if (ret) {
>> +		rvu->kpu_fwdata_sz = 0;
>> +		dev_err(rvu->dev,
>> +			"Loading KPU profile from filesystem failed\n");
>> +		return ret;
>> +	}
>On the success path, kpu_fwdata is cleared but kpu_fwdata_sz is left
>non-zero.  On the failure path both are cleared.  Is the asymmetry
>intentional?
Yes.

>
>>  	for (idx = 0; idx < num_kpus; idx++)
>>  		npc_program_kpu_profile(rvu, blkaddr, idx, &rvu->kpu.kpu[idx]);
>> +
>> +	if (profile->from_fs) {
>> +		rvu_write64(rvu, blkaddr, NPC_AF_PKINDX_TYPE(54), 0x03);
>> +		rvu_write64(rvu, blkaddr, NPC_AF_PKINDX_TYPE(58), 0x03);
>> +	}
>>  }
>A few questions about these unconditional writes:
>PKIND indices 54 and 58 are hardcoded.  Other sites in the file clamp
>via min_t(int, hw->npc_pkinds, num_pkinds) before programming PKIND
>CSRs.  Is there a guarantee that hw->npc_pkinds is greater than 58 on
>all silicon variants that take this path?
>The value 0x03 has no comment explaining what it programs.  Could a
>brief comment or named constant be added?
>These writes are profile-specific (they encode knowledge of two
>particular PKINDs the customer's profile uses) but apply to any
>filesystem-loaded blob.  Should these settings be expressed in the
>firmware blob itself rather than hardcoded in the kernel?
>The commit message describes the change as programming the profile
>read from the file and does not mention these register writes.
This very much hw specific and intentional.

