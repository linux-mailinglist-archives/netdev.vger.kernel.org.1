Return-Path: <netdev+bounces-297435-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dkOJIeHxKGodOAMAu9opvQ
	(envelope-from <netdev+bounces-297435-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 07:10:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 21757665DEC
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 07:10:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=marvell.com header.s=pfpt0220 header.b=kQ0fAZBd;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297435-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297435-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=marvell.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8EAD63016426
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 05:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15082370D5C;
	Wed, 10 Jun 2026 05:10:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E0F30C63B;
	Wed, 10 Jun 2026 05:10:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781068254; cv=none; b=aEGE+ZzxQZKn5KwFQJ2Hj8sIyNfxSEDpaLrSVymIIJ5J7r17Vaeih+0QHPFiuajxAds62vuTHVnDkVcvbhGWdbX9iC36SLYGmGUKS3RaYF8YvuvOZEFz7lzm2ftwL7E9bJ3JMIkJiDgo7nHuO8Euss+FesWqDQsXrwa6ToqxCps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781068254; c=relaxed/simple;
	bh=ksaRSIEGRqNuKkR6GNSxHMgPdXUtwHT+tYNBKfbVXog=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uyKgomM4E37RbC4kGFxlnAQAJ1K6RmIx9ICLgoylEL4qkwQ0VwtdR8Pd/GE9tLy3USD3DiIAJWuq5ehop3BOXzX9ngEM+r6lhUD48ladRp1tXb6jE+EtnjqxH9JQwBGcHFJMFonE6F5MNWlqvTzsUBUrIj+MbZnOllm3C0qblJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=kQ0fAZBd; arc=none smtp.client-ip=67.231.156.173
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65A3TVrS2550628;
	Tue, 9 Jun 2026 22:10:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=ONdJYD648I4Lsor1X/dqmnKnu
	8RJk9wqHgawJy7PcnI=; b=kQ0fAZBdrsm1PYJquZ4d5uYfil6fV1BcL4OuSHu44
	xQA4ykRbBd70Ks1KJCA7zmLInoGSv91jugPeHvGF4HSS2o2Sd+8vuI76vIlVApHL
	yoC/HP49EaF3pyU0yDPJ6fFJJrYKOyugLI7snbxPJ8/6rm7Mur8ZjYqp6dez+5KP
	KQ0lnEHwvWFZfeU2soIc4hWUMGjoqcojq/7E3xXUpE8Y/IZMveK/X4PGlTrneFZC
	hfo+a6LFp137b9AbBnUDno24O/hh/V4uR+7Bjo0oOMCfVKs0vsbCErXH8CxZanTQ
	nkG4aKS79IrQxgiDeyGPL0ozhrY6Ngc6IPyT0Xm1NMaAQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4eq02mr8sq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jun 2026 22:10:44 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 9 Jun 2026 22:10:43 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 9 Jun 2026 22:10:43 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id E4D0F3F708C;
	Tue,  9 Jun 2026 22:10:39 -0700 (PDT)
Date: Wed, 10 Jun 2026 10:40:38 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <donald.hunter@gmail.com>,
        <edumazet@google.com>, <horms@kernel.org>, <jiri@resnulli.us>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>
Subject: Re: [PATCH v20 net-next 5/9] octeontx2-af: npc: cn20k: add subbank
 search order control
Message-ID: <aijxzksHTt0kLt5J@rkannoth-OptiPlex-7090>
References: <20260609040453.711932-1-rkannoth@marvell.com>
 <20260609040453.711932-6-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260609040453.711932-6-rkannoth@marvell.com>
X-Authority-Analysis: v=2.4 cv=cuGrVV4i c=1 sm=1 tr=0 ts=6a28f1d4 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=QXcCYyLzdtTjyudCfB6f:22 a=9R54UkLUAAAA:8
 a=M5GUcnROAAAA:8 a=fMXJLkyFgcRvCBAknKgA:9 a=CjuIK1q_8ugA:10
 a=YTcpBFlVQWkNscrzJ_Dz:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: CllH9FuE_tMIQKFLcdVhW1Wa03xlOMoR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDA0NSBTYWx0ZWRfX7ga/DON0hHSn
 lO7bZqWRxkHZA7nB/syEkna46VveHzPV6L/IRq7XBFbujNd3rLEwP2o0UcoXVxcCZntB6qCg2gY
 wmawvPdeR7pAzfla7C8fcK/lo0foOjSHqZh0n/n7RqGX9hWP4GUB2LxMsBsEHpiAU2EosSnNUjk
 9U9XzNMxXspW2d5eRMpOozhE+rg2ABj7e55DMinLKaNJqkJgeSZQNii3zgH9HXsnEXSH9XPwJ9h
 ZRjqWGGGq/AL8EzCWKHiWlK10VEYXAxV3umyLoNIGmKl2VTSQ0FySZcmE2kGHGegV5VGEH3IDsd
 kMYBTPFjhz+oz3UHvmN7sSnZsM9D/qnILvmGV9sXY6cqp+0StOC6247WBr0xYjwO7t5dNyLIpRn
 THNLUhv4Vl9zaHnu29HTuLNNNT+uIHhf2ZmhCy4F0itc3ljMTy4uStN/VnO52qFoCLnSYgMz4lo
 1dmcUqcbk3C2YvlsT9g==
X-Proofpoint-ORIG-GUID: CllH9FuE_tMIQKFLcdVhW1Wa03xlOMoR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_01,2026-06-09_02,2025-10-01_01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,gmail.com,google.com,kernel.org,resnulli.us,redhat.com,marvell.com];
	TAGGED_FROM(0.00)[bounces-297435-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 21757665DEC

On 2026-06-09 at 09:34:49, Ratheesh Kannoth (rkannoth@marvell.com) wrote:
> CN20K NPC MCAM is split into 32 subbanks that are searched in a
> predefined order during allocation. Lower-numbered subbanks have
> higher priority than higher-numbered ones.
>
> Add a runtime "srch_order" to control the order in which
> subbanks are searched during MCAM allocation.
>
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260609040453.711932-1-rkannoth%40marvell.com says:
>> @@ -3906,6 +3906,122 @@ static void npc_unlock_all_subbank(void)
>>  		mutex_unlock(&npc_priv.sb[i].lock);
>>  }
>>
>> +int npc_cn20k_search_order_set(struct rvu *rvu,
>> +			       u64 narr[MAX_NUM_SUB_BANKS], int cnt)
>> +{
>[ ... ]
>> +	for (prio = 0; prio < cnt; prio++) {
>> +		sb_idx = narr[prio];
>> +		sb = &npc_priv.sb[sb_idx];
>[ ... ]
>> +		sb->arr_idx = prio;
>> +	}
>[ ... ]
>> +	for (int i = 0; i < cnt; i++)
>> +		subbank_srch_order[i] = (u32)narr[i];
>Do the get and set paths agree with init on what subbank_srch_order[]
>means?  The init path appears to treat the array as indexed by sb_idx
>with priority as the value:
>    /* npc_create_srch_order() */
>    for (int i = 0; i < cnt; i += 2) {
>        subbank_srch_order[i]     = cnt / 2 - val - 1;
>        subbank_srch_order[i + 1] = cnt / 2 + 1 + val;
>        val++;
>    }
>    subbank_srch_order[cnt - 1] = cnt / 2;
>    /* npc_subbank_init() */
>    sb->idx = idx;
>    sb->arr_idx = subbank_srch_order[idx];
>So initially subbank_srch_order[sb_idx] == priority (arr_idx).
>The new set helper, however, treats narr as indexed by priority with
>sb_idx as the value:
>    for (prio = 0; prio < cnt; prio++) {
>            sb_idx = narr[prio];
>            sb = &npc_priv.sb[sb_idx];
>            ...
>            sb->arr_idx = prio;
>    }
>    ...
>    for (int i = 0; i < cnt; i++)
>            subbank_srch_order[i] = (u32)narr[i];
>and the get helper returns subbank_srch_order verbatim.
>With cnt = 4 the round-trip then looks like:
>  after init:        subbank_srch_order = [1, 3, 0, 2]
>                     arr_idx[sb0..sb3]  = [1, 3, 0, 2]
>                     priority -> sb     = [2, 0, 3, 1]
>  user issues GET  -> [1, 3, 0, 2]  (validate accepts: distinct, < cnt)
>  user issues SET with the same array:
>                     arr_idx[sb0..sb3]  = [2, 0, 3, 1]
>                     priority -> sb     = [1, 3, 0, 2]
>That is, an unmodified GET -> SET echo silently inverts the runtime
>priority order of the MCAM subbanks.
>Should init be reworked so subbank_srch_order is indexed by priority
>(with npc_subbank_init() doing something like
>sb[subbank_srch_order[p]].arr_idx = p), or should set/get use the same
>indexing convention as init so a no-op round-trip is actually a no-op?
>> +	restrict_valid = false;
>> +
>> +	npc_unlock_all_subbank();
>> +	mutex_unlock(&mcam->lock);
>> +
>> +	return 0;
>[ ... ]
>> +}
>> +
>> +const u32 *npc_cn20k_search_order_get(bool *restricted_order, u32 *sz)
>> +{
>> +	*restricted_order = restrict_valid;
>> +	*sz = npc_priv.num_subbanks;
>> +	return subbank_srch_order;

There is due to bug in npc_subbank_init() (not introduced by this patch).
Will post a patch to "net" tree.

