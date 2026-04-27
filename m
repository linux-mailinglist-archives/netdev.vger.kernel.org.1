Return-Path: <netdev+bounces-281306-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8D0xN3g372nV+QAAu9opvQ
	(envelope-from <netdev+bounces-281306-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 12:16:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 741F5470C18
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 12:16:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 244D7302B389
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 10:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F5683ACEE3;
	Mon, 27 Apr 2026 10:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Dy0tepxV"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C1C3002BD;
	Mon, 27 Apr 2026 10:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777284566; cv=none; b=dAI+4+zCb4B3hhyu5bRFkHwZ7oHJgjLHC2XAvbhLbX4eI/eNkRKzMFKPL15KZIM/uKcVq5gBA+owZpCt3B65jlFVZCAcSwHzoChht1+jFzuI5TaQ+Rbn9dyqN/nipaxN4b2b16tMBzFg8BeEvwkP+PuEQnB/Z/7sAhQlCrE4nOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777284566; c=relaxed/simple;
	bh=hKpLRYTpneHJZ0sBNkammuHv+QuWbC1HNXzw68ut9GU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qoPCniBcZgRtJ832R3CdiC8nPxrgL3hbQZj+fzb2R1LOPDmTeyP1lo9WmsM4rEkeH7PBFdJs0YHSIPYcjCQXZ9Bjt7yrZseIB6pGANfba1FnLoSRNXov4lKBR+eBIrRmeVeAWcRnVtiiIa/FaV94AR2Ycb9la1Oy2auc+/nMrcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Dy0tepxV; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63R8JCF84014671;
	Mon, 27 Apr 2026 03:09:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=aSWdA01rVmPK04+KpmrLw1ChZ
	lccSk+FmBkvz6GV5Es=; b=Dy0tepxV9QE2AlVoem6Lh2YOjDfYxQglPVNKtRqo3
	+c/oPrjiklKXvM2jdQL3BZD7ooZTIQftUD3RxdswFxbcD3oPxa2o8m21lRgw1HLD
	IBhJ2cUOepiihTZwfXBrXej/tFIgaO0rw80DGccq5EVIZSj6VanX0mYO3hImWT+C
	cykBzeVWTFvfwIq1dOEtS+66dxvoTeze9vexgO2jkGAPRSLZPIgN0EFs/AV0VsC3
	C/TObvm0iv/Qife2xtnZj/6zyEONxdaEPwxltYGLIhN+tqRwL1JKkB8/QuLqWPqk
	EuA3iSCfpV+aL97KbltwkJWY98dEGzEodzfK4rq871qbQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4dt45yr876-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Apr 2026 03:09:14 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 27 Apr 2026 03:09:13 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 27 Apr 2026 03:09:13 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id B2DC43F7048;
	Mon, 27 Apr 2026 03:09:10 -0700 (PDT)
Date: Mon, 27 Apr 2026 15:39:09 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>
Subject: Re: [PATCH v4 net 09/10] octeontx2-af: npc: cn20k: Tear down default
 MCAM rules explicitly on free
Message-ID: <ae81xaD0ZQuwmtvs@rkannoth-OptiPlex-7090>
References: <20260427063213.3937451-1-rkannoth@marvell.com>
 <20260427063213.3937451-10-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260427063213.3937451-10-rkannoth@marvell.com>
X-Proofpoint-ORIG-GUID: LdwmjrWXFBOHECmw3L23tpDiH_fwj5qy
X-Proofpoint-GUID: LdwmjrWXFBOHECmw3L23tpDiH_fwj5qy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDEwNCBTYWx0ZWRfX0pxcAkYkHQsi
 KOwiVeapg7akPGFO/Mr4rxXNfC2eeTnQntfIHo9aePdkZ0KBxjVxWfz1OmqUEPDrJQQYf111aw7
 JhkKXeUOr14EyNE7bEilqF/gQXK4zyOiq9vBxFEQBMoAuPp8MYOv0IBk+iYPw91k8HtV4L6evcd
 kdRX7uXAVcr2YyrcK56EkOP3D1sDyq4SF+1dYjtD1KTugsRZaD/G+FmE5OEJBArV4eIRp+QMKWx
 LP7XZtJoFqnF/rQWF/2sTl3ogdSfSVL7aMqLFQMZXUfYLEQnxuiYdRTZ5KrLa6eCCHf/TsPUsa2
 bO4xO27wgPG3KPzySQX6V+qJ8PCsZHxfSONlrWMK2lVBu1rP+HNiCOxNDEWOYMl+FEqSW3xFAFG
 UVz1uXd5b38O4nqS4YC03jTGo4X2XnI+jWKdatbgiiUt8Ta17AbMvZ2lDzZ1TUyIDSwFNn5qeOT
 ww+BrVoDoMkdpai9psQ==
X-Authority-Analysis: v=2.4 cv=VOTtWdPX c=1 sm=1 tr=0 ts=69ef35ca cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=qit2iCtTFQkLgVSMPQTB:22 a=M5GUcnROAAAA:8
 a=HlLh0snk75LuTVU1PbMA:9 a=CjuIK1q_8ugA:10 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_03,2026-04-21_02,2025-10-01_01
X-Rspamd-Queue-Id: 741F5470C18
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281306-lists,netdev=lfdr.de];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,marvell.com:dkim,marvell.com:email];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]

On 2026-04-27 at 12:02:12, Ratheesh Kannoth (rkannoth@marvell.com) wrote:
> npc_cn20k_dft_rules_free() used the NPC MCAM mbox "free all" path, which
> does not match how cn20k tracks default-rule MCAM slots indexes.
>
> Resolve the default-rule indices, then for each valid slot clear the
> bitmap entry, drop the PF/VF map, disable the MCAM line, clear the
> target function, and npc_cn20k_idx_free(). Remove any
> matching software mcam_rules nodes. On hard failure from idx_free, WARN
> and stop so the box stays up for analysis.
>
> In npc_mcam_free_all_entries(), prefetch the same default-rule indices
> and, on cn20k, skip bitmap clear and idx_free when the scanned entry is
> one of those reserved defaults (they are released by
> npc_cn20k_dft_rules_free). Still disable the entry and tear down counter
> mapping for every matching index.
>
> Fixes: 09d3b7a1403f ("octeontx2-af: npc: cn20k: Allocate default MCAM indexes")
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>

>>  free_rules:
>> +	blkaddr = rvu_get_blkaddr(rvu, BLKTYPE_NPC, 0);
>> +	if (blkaddr < 0)
>> +		return;
>> +	for (int i = 0; i < 4; i++) {
>> +		if (ptr[i] == USHRT_MAX)
>> +			continue;
>>
>> -	free_req.hdr.pcifunc = pcifunc;
>> -	free_req.all = 1;
>> -	rc = rvu_mbox_handler_npc_mcam_free_entry(rvu, &free_req, &rsp);
>> -	if (rc)
>> -		dev_err(rvu->dev,
>> -			"%s: Error deleting default entries (pcifunc=%#x\n",
>> -			__func__, pcifunc);
>> +		mutex_lock(&mcam->lock);
>> +		npc_mcam_clear_bit(mcam, ptr[i]);
>> +		mcam->entry2pfvf_map[ptr[i]] = NPC_MCAM_INVALID_MAP;
>> +		npc_cn20k_enable_mcam_entry(rvu, blkaddr, ptr[i], false);
>> +		mcam->entry2target_pffunc[ptr[i]] = 0x0;
>> +		mutex_unlock(&mcam->lock);
>> +
>> +		rc = npc_cn20k_idx_free(rvu, &ptr[i], 1);
>> +		if (rc) {
>> +			/* Non recoverable error. Let us WARN and return. Keep system alive to
>> +			 * enable debugging
>> +			 */
>> +			WARN(1, "%s Error deleting default entries (pcifunc=%#x) mcam_idx=%u\n",
>> +			     __func__, pcifunc, ptr[i]);
>> +			return;
>When npc_cn20k_idx_free() fails on some ptr[i], this path WARNs and
>returns from inside the per-entry loop.  At that point, the earlier
>block in npc_cn20k_dft_rules_free() has already xa_erase()d the
>xa_pf2dfl_rmap entries for all four default rule IDs for this pcifunc,
>so npc_cn20k_dft_rules_idx_get() on a retry would return -ESRCH and
>could not reclaim anything.
>Given that, could the remaining ptr[i+1..3] entries leak on this path?
>Their bitmap bits stay cleared only if they were processed before the
>failure, but any entries after i still have their bitmap slot allocated,
>entry2pfvf_map still referencing pcifunc, MCAM line still enabled,
>entry2target_pffunc still set, and the cn20k idx allocator still holding
>the slots.
No. This is a non recoverable error and no way we can recover and proceed. So this warning
and returning would enable the user to debug the system.

>> +		}
>> +	}
>> +
>> +	mutex_lock(&mcam->lock);
>> +	list_for_each_entry_safe(rule, tmp, &mcam->mcam_rules, list) {
>> +		for (int i = 0; i < 4; i++) {
>> +			if (ptr[i] != rule->entry)
>> +				continue;
>> +
>> +			list_del(&rule->list);
>> +			kfree(rule);
>> +			break;
>> +		}
>> +	}
>> +	mutex_unlock(&mcam->lock);
>>  }
>On the same error path, the list_for_each_entry_safe() walk over
>mcam->mcam_rules below is skipped entirely because of the early return,
>so rvu_npc_mcam_rule nodes for all four default indices (including the
>ones that were successfully torn down before the failure) stay on the
>list.
>The commit message says:
>    Resolve the default-rule indices, then for each valid slot clear the
>    bitmap entry, drop the PF/VF map, disable the MCAM line, clear the
>    target function, and npc_cn20k_idx_free(). Remove any
>    matching software mcam_rules nodes. On hard failure from idx_free, WARN
>    and stop so the box stays up for analysis.
>Is the "Remove any matching software mcam_rules nodes" step intended to
>also be skipped whenever idx_free() fails?  If not, would it make sense
>to move the mcam_rules cleanup ahead of the per-entry loop, or continue
>the loop best-effort and WARN once at the end, so the software list and
>the already-torn-down slots do not silently diverge on the error path?
No. mcam list will show more information in debugfs. I dont think, freeing 4 entries (in default entries)
would save us anything. So better to keep this way.

