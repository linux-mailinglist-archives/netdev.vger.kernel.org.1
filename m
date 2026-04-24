Return-Path: <netdev+bounces-280970-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CEpGOs0z62mxJwAAu9opvQ
	(envelope-from <netdev+bounces-280970-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 11:11:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C6F7645BF19
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 11:11:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 21E5D3019C93
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 09:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A55C367F54;
	Fri, 24 Apr 2026 09:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="YF/GEAet"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206B132938D;
	Fri, 24 Apr 2026 09:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777021880; cv=none; b=glpsuyctzGkCA4h3ubLaL6P4Rib3W7/h2bFHfNfhgs+MB6lnuxoBrsrnLa3ypp3ZPUZAocOi6fCjef7zVYEDxv0lIXukVhASPJRf49yeSMjB5jW51wts75Rub6+Laatt/YE5A1oAOQckprC0Pd96FkyH6lc4AbZEx+6s5nkkJhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777021880; c=relaxed/simple;
	bh=e2/6Y4o0/0GQDfsAmwo5hwKixf2rhYAf+/OcTxyzOPM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cJz7R7rGuiUk9wVH7qfXqbjZ5g/Qnwb+n6zNiZnelUWfsNU3By4ChujWOJyR/g5QM6AOfo2IlqJJnlqEYhIhZYiAgcLn+1GOZXU/H/prT6qjUPvfURI5LRXsW1AAWN2ntJDQm5vLN14oSnP9QLdNJzcBRxWZRSSsNS1EwVL3qJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=YF/GEAet; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63O1YuYY3626601;
	Fri, 24 Apr 2026 02:11:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=9AjLwKs4e7gqwG114JUYKLdkQ
	CZOL9Z1ZEiuBBHCBtA=; b=YF/GEAetIBo22nKIG5uyhjDh7jmlkX0XN39MTd5TK
	zPPllmCD2Fe6iqJDXOeCMEU0M4X1tfooZUJkapEkEF9plVLh7+9wbKPinq3/MOcY
	8NXWQX/Rnm2Tq02yH8KeylgA61+3xqwzZH8EXFJoFpnPcbH2uM/SQpA6K4gP+dbK
	PkZPSufNUua3oBtcnRPs9nTAIDtkm9U0/NbRs25nPw3hv/wAiLWJnylYX2yEvOk4
	mLRyidGD4SLAvQuhGcchTfdzGq0ZlCrPQW4utKVBUyHqBJOebieKalpoLT978oOL
	Q/saQIgMk1DEDhhwf4LKCR6q1u3n4md1trAhGKi9pRW3Q==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4dpeph0a59-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Apr 2026 02:11:10 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 24 Apr 2026 02:11:10 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Fri, 24 Apr 2026 02:11:10 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 57AD43F7081;
	Fri, 24 Apr 2026 02:11:07 -0700 (PDT)
Date: Fri, 24 Apr 2026 14:41:06 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>
Subject: Re: [PATCH v3 net 10/11] octeontx2-af: npc: cn20k: Tear down default
 MCAM rules explicitly on free
Message-ID: <aeszqmEhykr3XVvg@rkannoth-OptiPlex-7090>
References: <20260423104317.2707923-1-rkannoth@marvell.com>
 <20260423104317.2707923-11-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260423104317.2707923-11-rkannoth@marvell.com>
X-Proofpoint-ORIG-GUID: atatMUWn34bWfFlihK1zbUIaFIDyerjm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI0MDA4NSBTYWx0ZWRfX7RuU65W/2RBK
 SBqaPerZRmYlYFD3MCZnFhqcp6nHo9cp+F/aIw27cl7K36gwyO4V8U9bHm00gPOcVay6C/QedUs
 6t8Tn28Jggi/fs/dAMRFtZ9tWa32SYyXf6xzhKY69Nmdl9t+2ZmviqYeCpSWB1axGnwrmnib4eS
 K++x4bXsAO4S0ofnZVqdLp1c2IGfntdkZJVk9/ubaDKJvdge57UYS4enkIHNiW+nCsaSjjygUP9
 4ngakeO/q0jFXwkGTKrlKHnS4ERlxJQZjagfv3Ql64T58VhH4VqD4gF2D9mPb5d7BRyXrbCaAFO
 sl0oHjyNCeJQqWBzhT8D2w05LhfKVY8XfgawePcEVFgqxwZEc5DYCunj52WsknTlq0wosV/muhp
 SyakRqF5KRc3cmK5/1Hkv6HCIT2ddc2KniS+RivXTrOKlTLVnSYlmYNd9oqPumitmRgVZNsd8Uy
 hw6BMzk/+sCU/cEsx0g==
X-Proofpoint-GUID: atatMUWn34bWfFlihK1zbUIaFIDyerjm
X-Authority-Analysis: v=2.4 cv=SJBykuvH c=1 sm=1 tr=0 ts=69eb33ae cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=QXcCYyLzdtTjyudCfB6f:22 a=9R54UkLUAAAA:8
 a=M5GUcnROAAAA:8 a=2oQJcTl5x6ly4gfkbr8A:9 a=CjuIK1q_8ugA:10
 a=YTcpBFlVQWkNscrzJ_Dz:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Rspamd-Queue-Id: C6F7645BF19
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
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
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280970-lists,netdev=lfdr.de];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,marvell.com:dkim,marvell.com:email];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]

On 2026-04-23 at 16:13:16, Ratheesh Kannoth (rkannoth@marvell.com) wrote:
>
octeontx2-af: npc: cn20k: Tear down default MCAM rules explicitly on free

This patch changes npc_cn20k_dft_rules_free() to explicitly tear down
each default MCAM rule by clearing the bitmap, disabling the MCAM line,
and calling npc_cn20k_idx_free(), instead of using the "free all" path.
It also updates npc_mcam_free_all_entries() to skip bitmap clear and
idx_free for cn20k default-rule indices.

>> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
>> index 6d3166960a3f..54a25d9c5505 100644
>> --- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
>> +++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
>
>[ ... ]
>
>> @@ -4228,14 +4228,47 @@ void npc_cn20k_dft_rules_free(struct rvu *rvu, u16 pcifunc)
>>  	}
>>
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
>> +
>> +			/* Clear entries from mcam_rules, whose indexes are successfully freed
>> +			 * by npc_cn20k_idx_free().
>> +			 */
>> +			ptr[i] = USHRT_MAX;
>> +		}
>
>The comment says "Let us WARN and return" and the commit message says
>"WARN and stop so the box stays up for analysis," but after setting
>ptr[i] = USHRT_MAX, the loop continues processing remaining indices.
>Should the code break or return here to match the comment and commit
>message? Or if continuing is intentional, should the comment say
>"WARN and continue" instead?
AI review report: https://netdev-ai.bots.linux.dev/ai-review.html?id=9923f145-31df-46b0-84e8-b15f1e307ad2#patch-10
pw-bot: changes-requested

Will fix it by returning error code.

>

