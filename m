Return-Path: <netdev+bounces-282653-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4I4XOI3X8mnIugEAu9opvQ
	(envelope-from <netdev+bounces-282653-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 06:16:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C1A49D402
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 06:16:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3F65130022BC
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 04:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B38E3624C8;
	Thu, 30 Apr 2026 04:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="BJ1l8t84"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A513279917;
	Thu, 30 Apr 2026 04:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777522455; cv=none; b=HLkWSfAOkCz/GuAjnQ7ZBPqWSP7H+93eNcAwHb5Iug927Cyh9o2L1+jDK9CzDWps2NYfbmAjhg1Map+aIRVch0nhU4U56drTCoSe76ek7fXxk5TTOAFBe5loDhLToujTT96EI/PLVxKvzdsK3JumVFAdyVUJJByY5uu1eeG2riw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777522455; c=relaxed/simple;
	bh=RsG6ImG3HiZ3h/D5bkFeC5gjtFT/6+t2SeRN/s5aUMc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o1x8ZobMknZTF+Fkoh7DV0TYGm247wrQ7Ps73ZUtPXR4s8nGIcjY1YOmG4Z8LE6/GMDc5EuRDj7ADIk9ZISFOCVaexsjZNOh0sCvIBZsy/e3B9JF1KRzF2wp7v/WcJLm8RNSS/9CCgGoHmcFSHVQFg/byKwMRDsGVZOZa7UqOKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=BJ1l8t84; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63TL2R7M1642691;
	Wed, 29 Apr 2026 21:14:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=JoodDx2eLV3LTfj1ZyYkOKVMd
	dnYKfOokDkVN1ETxDg=; b=BJ1l8t84s4vC6hm68MOeoWpKDAxNGQ8QHK0u2k7YH
	GlZ/xr77M42i4L4fLWxixbKs+d/KpjdrXmf5li1QHrl7ERcUUK8CTeohW6j1Qd6t
	r04Jp8xWrnnp9Cxq3nOsLe+RDHvbdGqu/RUwgJ1KpKDJvOz9uyZsCQ3f0S3D2aHx
	eGnvZ+jgQhvHzDLX0iXNH20bt1EUveNJrseM0JoefUv5HOTkqTYjriK3n48oWdmj
	K+QvUgejyzycPvkp4VCiy+jSFBIX0bQj9mG7NZ+WzDoMBHaTkJITB2W3Jal55zAB
	nRM0Lod4kqHJU+yvbNJvyN/oHCx1uJ8NRKB15SDgQ5ang==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4duet8audb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Apr 2026 21:14:04 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 29 Apr 2026 21:14:03 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 29 Apr 2026 21:14:03 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id F1AF13F7062;
	Wed, 29 Apr 2026 21:13:58 -0700 (PDT)
Date: Thu, 30 Apr 2026 09:43:58 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>
Subject: Re: [PATCH v5 net 04/10] octeontx2-af: npc: cn20k: Fix target map
 and rule
Message-ID: <afLXBmDGKw7XmNB1@rkannoth-OptiPlex-7090>
References: <20260429022722.1110289-1-rkannoth@marvell.com>
 <20260429022722.1110289-5-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260429022722.1110289-5-rkannoth@marvell.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDAzOSBTYWx0ZWRfX99te0qr6Ej7d
 hirFtDFaEu0t+vh2EF65U4Gxl6AKyJJNl5cpryim+IB/5JFIplHO61PH+UryCso3iQuoFISKsSt
 knn80wpdlLMCJeDggZqSqgd5Rn+f1qfHybwvwaMhoBM0aRK1M5BrHfXcClipI7xR0OJtiNlD/Nm
 Egmm7PJ6ikR0Y8B4x+gKDAC1MbZ7nZmPedjfbLmhSgDgo7UVMI4aQs7vEC2B5cWkbb5hdyaLUnC
 lNn5cSZSJR4RJ5ObTz5UqvSTtoEOW1DqiTgM6YnWU8bhd3X+Dyu/IiPm5wLzsR05P7pr9sAXRf+
 AURRKQa/CcW4Dgl/BOWm7b4E+ly3S0XmPiWrg9iCRTSavMshU6auC0Z0dLZWVBxV1qF4KWEIixg
 Mu28eD6ooKKc+jZyt53/lWVlWkwM06c1SKXCjX/w+70YdddTe0oNd/DhtCVn/yglVoS3OLP52tO
 y05HXMam4oMMrEGzlCA==
X-Proofpoint-ORIG-GUID: YJa6zAcakpLBX-0ST4qkSwchA2zCydwm
X-Authority-Analysis: v=2.4 cv=NqDhtcdJ c=1 sm=1 tr=0 ts=69f2d70c cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=TtqV-g6YmW1Jfm2GSLaY:22 a=M5GUcnROAAAA:8
 a=SJ8jJlZPfyL0IpR26iEA:9 a=CjuIK1q_8ugA:10 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: YJa6zAcakpLBX-0ST4qkSwchA2zCydwm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_01,2026-04-28_01,2025-10-01_01
X-Rspamd-Queue-Id: 46C1A49D402
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282653-lists,netdev=lfdr.de];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,marvell.com:dkim,marvell.com:email];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]

On 2026-04-29 at 07:57:16, Ratheesh Kannoth (rkannoth@marvell.com) wrote:
> npc_defrag_move_vdx_to_free() disables, copies, and enables the MCAM entry
> at a new index but previously left entry2target_pffunc[] and the mcam_rules
> list still keyed to the old index. Copy the target PF association to the
> new slot, clear the old one, and retarget the rule entry so software state
> matches the relocated hardware context.
>
> Fixes: 645c6e3c1999 ("octeontx2-af: npc: cn20k: virtual index support")
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>

 @@ -3723,8 +3724,21 @@ int npc_defrag_move_vdx_to_free(struct rvu *rvu,
>  		mcam->entry2pfvf_map[new_midx] = pcifunc;
>  		/* Counter is not preserved */
>  		mcam->entry2cntr_map[new_midx] = new_midx;
> +		target_pf = mcam->entry2target_pffunc[old_midx];
>Is mcam->entry2target_pffunc always initialized before we read from it here?
>If it was allocated with kmalloc_array() during driver initialization and no
>target PF was explicitly configured for this MCAM entry, could this read
>uninitialized heap memory and copy it to the new index?

The npc_defrag_move_vdx_to_free function only operates on entries that are currently 'in-use' and
being relocated to optimize space. Because the target PF configuration is a prerequisite for an
entry to be considered active in the MCAM pipeline, these fields are guaranteed to be
populated by the time a defrag move is triggered.

> +		mcam->entry2target_pffunc[new_midx] = target_pf;
> +		mcam->entry2target_pffunc[old_midx] = NPC_MCAM_INVALID_MAP;
> +
>  		npc_mcam_set_bit(mcam, new_midx);
>
> +		/* Note: list order is not functionally required for mcam_rules */
> +		list_for_each_entry_safe(rule, tmp, &mcam->mcam_rules, list) {
> +			if (rule->entry != old_midx)
> +				continue;
> +
> +			rule->entry = new_midx;
>If npc_add_to_pf_maps() fails earlier in this loop, the function returns an
>error without updating these software tracking maps. At that failure point,
>the hardware rule at old_midx has already been disabled and its subbank marked
>as free via __npc_subbank_free().
>Since the hardware subbank is free, could the hardware allocation later
>assign old_midx to a completely new user while our mcam_rules list still
>points to it?

In this specific 'should-never-happen' scenario, attempting a graceful software rewind could mask a critical fault or lead to
further exceptions. My intention with this Smatch fix was to ensure smatch fix, is at least caught and logged rather than silently ignored.
I can address a full transactional rollback mechanism in a separate hardening series for net-next. But issue is gracefull rollback
 can also fail as it is kind of another defrag process. or may be we can copy to new entries but not free the existing entries, that would be a
enhancement request for net-next.

>If the old rule's owner later modifies or deletes it, could this cause a
>resource collision and inadvertently destroy the newly allocated rule?
No this wont happen, mbox messages are processed by AF driver sequentially. More than that
mcam->lock mutex is already acquired before all these operations.

