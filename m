Return-Path: <netdev+bounces-294588-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id H7oJAVvPH2rSqAAAu9opvQ
	(envelope-from <netdev+bounces-294588-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 08:53:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FE78634D81
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 08:53:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=marvell.com header.s=pfpt0220 header.b="fTXDD/Ll";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294588-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-294588-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=marvell.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 96CD93034570
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 06:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ACBB383C8F;
	Wed,  3 Jun 2026 06:47:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E92D394EB7;
	Wed,  3 Jun 2026 06:47:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780469237; cv=none; b=ZFFHYrLvJYW4YTAmOYJ8wjgbLhd8lB41fC3eLchdYm1U6/F1RYky5a9Bt0Dga8Vtk5lahMbBWqaNTGnKtoaUTqQc4uNS2vRV2abX+aXKvjHBm8jULs62baaUJAZ3mx4QI1flkK0qO+Lp+hJiSIN9qKbIxvAg1vueQioyHdtWLas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780469237; c=relaxed/simple;
	bh=rf4TRxXXIHwfr0whEkQvJP9l4WIi52NWic4YTYQdXY4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SlyNKOW5LWuJfUeI3mKems7x4Ci3YQgY2RvM5XXrtel4aJSIJuUFLfJNsZwdnGyqfoDFh0MjGsBgTQEB2k7d6SFCvRujcpdh5QNXhQT+9smnsqmoywr0WXVRi63yDKwRFyolaWlJFE1hPfxkNNIwxle0yQjHgO5cRk3bfsioVEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=fTXDD/Ll; arc=none smtp.client-ip=67.231.148.174
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 652NRcTi023755;
	Tue, 2 Jun 2026 23:47:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=SSH9jGWtAQuXPNg1qM8mHs9Qy
	Adyli1xUpWN+uGUl8s=; b=fTXDD/Llv7HLpNeNhW4BIwz+ikuIfc2opKPFpe1Ed
	qRGsRpeZrin02V965sbBcz5D34wTCb5bRpgC8JFbw/xn1T/96IRdmcSXGcCUFRB6
	l7cy5PnhjahvOLVPmoRI/LkIack3ECB9qa5Sk1LveEdWDEu2X4X6nBNllwo1975+
	sV+yjWVmb9AtfHtzafnHw7KZxt1LMTRtUOGooTDjmjq77ERZa2Kc03Os9cOGv+76
	Ms5Fc/3OwtBYgFv4MHSukLqorcnkRiX8qQJoTHFsKgg9fvqohWkxshF2271yIwHc
	BqNH5raIlHQl6nxXmMzC5bOLMqbQEynYpZ+TvZyWQQRAg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4ej8v99749-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jun 2026 23:47:05 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 2 Jun 2026 23:47:04 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 2 Jun 2026 23:47:04 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id DAABC3F708E;
	Tue,  2 Jun 2026 23:47:00 -0700 (PDT)
Date: Wed, 3 Jun 2026 12:16:59 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <donald.hunter@gmail.com>,
        <edumazet@google.com>, <horms@kernel.org>, <jiri@resnulli.us>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>
Subject: Re: [PATCH v18 net-next 6/8] octeontx2-af: npc: Support for custom
 KPU profile from filesystem
Message-ID: <ah_N4wG92USMu8Ps@rkannoth-OptiPlex-7090>
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
X-Proofpoint-ORIG-GUID: SUOu4fu6it78HCBFnH1uCMK2--1Pt2NA
X-Authority-Analysis: v=2.4 cv=JNQLdcKb c=1 sm=1 tr=0 ts=6a1fcde9 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=TtqV-g6YmW1Jfm2GSLaY:22 a=c92rfblmAAAA:8
 a=M5GUcnROAAAA:8 a=raM4nQVkOdsR6ebl1ugA:9 a=CjuIK1q_8ugA:10
 a=GvGzcOZaWPEFPQC_NcjD:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDA2MiBTYWx0ZWRfX0d7FLvUCYiDA
 P3lDij1BidrzObu+WkB75NTiENXsyTAzyKc3BeRYVwgSZ8OWRzGgZgghdtreoGoGaNYuvxanOLv
 xnrfVhVGj/3f+eNUXKxMifjVhFCndDaIXc4HPin7py404tlLiKXITZL2/SpC9NXR/xMkfgOdWde
 JW8aKz38RPlXOgNQpI6LHIlmgdjlscQDFDIbtPzYY4kJRmn8yhemdeYxa2B1FRiD0lclTcBi69u
 60aF3W+PYHmSuwmsZODXhC09qn08NH/rQ5uyJpA5EsLZvcCs0acarmq8FHZk4unxxiy3FREfN6g
 IiOU/AV94BnfbWLXDqYK5kwzcdDM3T2gj0WCTMiAyFpb0tchWUPw90X44rmNPotgNksTbYqno/3
 Zs+9/KAM/qi3IKhtnxIb2D22uUymaF0qStNHjRoy1iJFcV4zuqQiA+z2qlrBqq4YMPW5u0GdIex
 ZO8TB2n7T3IGtnPcLzg==
X-Proofpoint-GUID: SUOu4fu6it78HCBFnH1uCMK2--1Pt2NA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_02,2026-05-28_03,2025-10-01_01
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
	TAGGED_FROM(0.00)[bounces-294588-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,rkannoth-OptiPlex-7090:mid,marvell.com:dkim,marvell.com:from_mime,marvell.com:email,sashiko.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
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
X-Rspamd-Queue-Id: 4FE78634D81

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

https://sashiko.dev/#/patchset/20260602060359.1894952-1-rkannoth%40marvell.com says

> +static int npc_alloc_kpu_cam2_n_action2(struct rvu *rvu, int kpu_num,
>> +					int num_entries)
>> +{
>> +	struct npc_kpu_profile_adapter *adapter = &rvu->kpu;
>> +	struct npc_kpu_profile *kpu;
>> +
>> +	kpu = &adapter->kpu[kpu_num];
>> +
>> +	kpu->cam2 = devm_kcalloc(rvu->dev, num_entries,
>> +				 sizeof(*kpu->cam2), GFP_KERNEL);
>Does this code introduce a use-after-free risk?
No.

>The adapter's kpu pointer (profile->kpu) is set to the global static array
>npc_kpu_profiles in npc_prepare_default_kpu(). When this function is called,
>it allocates device-managed memory (devm_kcalloc) and stores the pointer
>into that globally shared array.
>If the device unbinds, the devres subsystem will automatically free this
>memory, leaving dangling pointers in the global array. A subsequent probe or
>concurrent access by another device could result in a use-after-free.
There is only one AF device per system.
When device binds, the structure which holds these pointers (global array) are also freed.

> +	struct npc_kpu_fwdata *fw_kpu;
>> +	int entries, entry, kpu;
>>
>> -	if (is_cn20k(rvu->pdev))
>> -		return npc_cn20k_apply_custom_kpu(rvu, profile);
>> +	fw = rvu->kpu_fwdata;
>> +
>> +	for (kpu = 0; kpu < fw->kpus; kpu++) {
>> +		if (rvu->kpu_fwdata_sz < hdr_sz + offset) {
>This is a pre-existing issue, but does this boundary check allow an
>out-of-bounds read?
Pre-existing issue, will post a patch to net tree, once this series is merged.

> +		return -EINVAL;
>> +
>> +	/* The firmware layout does dependent on the internal size of
>> +	 * ikpu_action_entries.
>> +	 */
>> +	memcpy((void *)profile->ikpu2, action, sizeof(ikpu_action_entries));
>> +	offset += sizeof(ikpu_action_entries);
>Will this logic break backward compatibility with existing firmware binaries?
>The firmware parsing offset is incremented by sizeof(ikpu_action_entries).
>Because ikpu_action_entries is a static kernel array whose size is determined
>by the number of supported port kinds (PKINDs), any future addition of a
>PKIND to the kernel will increase the array's size.
>This would misalign the parser's offset calculation for all existing
>firmware binaries on disk. Could this be made independent of the internal
>kernel structure size?
No, Since there is no field in this structure to indicate number of ikpu_action_entries, we
will keep same number of entries always.

>> +	const struct npc_mcam_kex *mkex;
>>  	u64 nibble_ena, rx_kex, tx_kex;
>>  	u64 *keyx_cfg, reg;
>>  	u8 intf;
>>
>> +	mkex_extr = rvu->kpu.mcam_kex_prfl.mkex_extr;
>> +	mkex = rvu->kpu.mcam_kex_prfl.mkex;
>> +
>>  	if (is_cn20k(rvu->pdev)) {
>> -		keyx_cfg = mkex_extr->keyx_cfg;
>> +		keyx_cfg = (u64 *)mkex_extr->keyx_cfg;
>This is a pre-existing issue, but does this explicit cast mask a potential
>kernel panic?
>By casting the const pointer mkex_extr->keyx_cfg to a non-const u64 *,
>the code allows mutating the underlying data later in this function
>(e.g., keyx_cfg[NIX_INTF_TX] = tx_kex).
>If the profile was loaded via the firmware database (fwdb), this memory
>is an __iomem region. A direct assignment to __iomem on ARM64 without
>using the appropriate I/O accessors (like writeq) can cause a synchronous
>external abort.
This is firmware loaded in memory (request_firmware_direct()), not iomem.

