Return-Path: <netdev+bounces-297446-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id K6iXMJ73KGorOQMAu9opvQ
	(envelope-from <netdev+bounces-297446-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 07:35:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1749F665F7C
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 07:35:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=marvell.com header.s=pfpt0220 header.b=L20XeXTW;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297446-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297446-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=marvell.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D50CB3058822
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 05:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5518F278161;
	Wed, 10 Jun 2026 05:33:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F74F25EF9C;
	Wed, 10 Jun 2026 05:33:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781069613; cv=none; b=iNSsLpE9cZqlc1iv2oo6bJbM6W0ikB7tDvZbk642D4me5BRKJaaz7bTkLnF8ZpmvbcFzhoXzpCbOV6Hg3jU7fSVmuMvm1cFp2bmu5ZW1uJa/mfOj9wDvs5U+nde1xvOx81dquA7e8NubXXMHAGEt8qPYKaI1imuuLT7R5wAZgm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781069613; c=relaxed/simple;
	bh=glGS0N/fbM9bKyXKoiq+e2Xat20Ysf22iyQm7KEy9Y0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AqLwDelvajdbdPkTNtPgcNjbMmW2xX93r/W0uB7PqWO6QeF7byZ9LYFYD8/V2QmBQpGxdpcMXVEZa9WufwRK7q4oL7duM1Vca/lEdlaF+GlQzEkjwcduw6FcCaHRoJOoa86VO51XhfC5GUh8FX2n6ovIXyUvtNVWlVfyjjn0SJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=L20XeXTW; arc=none smtp.client-ip=67.231.148.174
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65A1vOar2480491;
	Tue, 9 Jun 2026 22:33:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=abo8MIl6AcrSt5xTzZxGw1LUt
	qIhlLpeB2G3TSM555c=; b=L20XeXTW1EFghSTV7fYiEWTVFCfmIAB6LU9P5OhtS
	2ZbB+NguZ6u2WHSQIqb4uLFb+kK1XO+bbQCNId926RfsggWbeBuXJqe8txdUMYC+
	9ocqu9y2kuQWgQzIx3uYzofpuTOgMsDkYeFG/ukbx9Ia05cyEBXHg1y2j6nyWsW2
	xchAlXuX/gsviAswN28oOMaZRvHJCGePEeZxTR1nyn8P4g4aTceY46KPod6byo2B
	frTablooIlwrOdfni4JGaTvyAjJv901jRc05wDAWeTHAK8SWNCnhDh5dj/mJgDnm
	rDSfebQFgpMNwsA+mWVwaMM+flwgJagq5/WGMZgSIS44g==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4epex1m8sh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jun 2026 22:33:21 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 9 Jun 2026 22:33:20 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 9 Jun 2026 22:33:20 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 7FF905B693C;
	Tue,  9 Jun 2026 22:33:17 -0700 (PDT)
Date: Wed, 10 Jun 2026 11:03:16 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <donald.hunter@gmail.com>,
        <edumazet@google.com>, <horms@kernel.org>, <jiri@resnulli.us>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>
Subject: Re: [PATCH v20 net-next 9/9] octeontx2-af: npc: cn20k: Allocate
 npc_priv and dstats dynamically.
Message-ID: <aij3HPN_y0j6nZ5k@rkannoth-OptiPlex-7090>
References: <20260609040453.711932-1-rkannoth@marvell.com>
 <20260609040453.711932-10-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260609040453.711932-10-rkannoth@marvell.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDA1MCBTYWx0ZWRfX5mP75wYbj254
 EcXu13LXeGlwJtkp4kTJlswxp89YjnGYM/OAyq1SWS5Ck5U+YsKjhxaGICSbWLk/rLFGuNRCpLO
 WrAwJgggU89yC6gth+Iy0pbdxbyqj1tAfq/xN+/lpwdpKiGekeqM23Zed1UkDp4sFPOJ5jXSSBA
 QFcEABlJRBDvRQH4ZmtJzUXB59C+w2x/jG6zL2/e1UOoL/bQIIp/uWok/VnutRmuI+dWleJUBVE
 KWvXDb+fOU1CXNjKa1oWkG9z2mK5NDetEi3oGaJJrDoVcExcJ7MhXeh86QHzcCudzXxbTqLy5SV
 +kocSZ6xAfGK5GNou0IfeCBZFbVqzeOIzkPJkGRCYClXsdG+Nnoy7v5P5chlB8MpJeeedvv3Lqm
 vob0SjIcWkrOZS165gI0VJ7Kiu+7NOTpY5aDKXL9ppWTDIyj8Zpf7sU0PaWR01jXhRBaSbvU23T
 axcqTx5Wf/jEVwyht8g==
X-Proofpoint-ORIG-GUID: ZfqGGg1ERAmLUg-RZy2wX6Y7YyqgmwXt
X-Authority-Analysis: v=2.4 cv=Aa2B2XXG c=1 sm=1 tr=0 ts=6a28f721 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=TtqV-g6YmW1Jfm2GSLaY:22 a=9R54UkLUAAAA:8
 a=M5GUcnROAAAA:8 a=I6v_eIbEzFDS9DFWy1EA:9 a=CjuIK1q_8ugA:10
 a=YTcpBFlVQWkNscrzJ_Dz:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: ZfqGGg1ERAmLUg-RZy2wX6Y7YyqgmwXt
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,gmail.com,google.com,kernel.org,resnulli.us,redhat.com,marvell.com];
	TAGGED_FROM(0.00)[bounces-297446-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,rkannoth-OptiPlex-7090:mid,marvell.com:dkim,marvell.com:email,marvell.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:url,npc_priv.sb:url];
	FORGED_RECIPIENTS(0.00)[m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:donald.hunter@gmail.com,m:edumazet@google.com,m:horms@kernel.org,m:jiri@resnulli.us,m:kuba@kernel.org,m:pabeni@redhat.com,m:sgoutham@marvell.com,m:andrew@lunn.ch,m:donaldhunter@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[marvell.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
X-Rspamd-Queue-Id: 1749F665F7C

On 2026-06-09 at 09:34:53, Ratheesh Kannoth (rkannoth@marvell.com) wrote:
> Replace the file-scope static npc_priv with a kcalloc'd struct filled
> from hardware bank/subbank geometry at init (num_banks is no longer a
> const compile-time constant; drop init_done and use a non-NULL
> npc_priv pointer for liveness). Thread npc_priv_get() / pointer access
> through the CN20K NPC code paths, extend teardown to kfree the root
> struct on failure and in npc_cn20k_deinit, and adjust MCAM section
> setup to use the discovered subbank count.
>
> Allocate MCAM debugfs dstats via devm_kzalloc instead of a static matrix,
> and use the allocated backing store consistently when computing deltas
> (including the counter rollover compare).
>
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260609040453.711932-1-rkannoth%40marvell.com says:

> -	kfree(npc_priv.xa_pf2idx_map);
>> +	kfree(npc_priv->xa_pf2idx_map);
>>  	/* No need to destroy mutex lock as it is
>>  	 * part of subbank structure
>>  	 */
>> -	kfree(npc_priv.sb);
>> +	kfree(npc_priv->sb);
>>  	kfree(subbank_srch_order);
>> -	bitmap_clear(npc_priv.en_map, 0, MAX_NUM_BANKS * MAX_NUM_SUB_BANKS *
>> +	bitmap_clear(npc_priv->en_map, 0, MAX_NUM_BANKS * MAX_NUM_SUB_BANKS *
>>  		     MAX_SUBBANK_DEPTH);
>> +	npc_defrag_list_clear();
>> +	kfree(npc_priv);
>> +	npc_priv = NULL;
>>  }
>Now that npc_priv is dynamically allocated, en_map is an embedded
>DECLARE_BITMAP inside the struct that is unconditionally kfree'd two
>lines later:
>	bitmap_clear(npc_priv->en_map, 0, MAX_NUM_BANKS * MAX_NUM_SUB_BANKS *
>		     MAX_SUBBANK_DEPTH);
>	npc_defrag_list_clear();
>	kfree(npc_priv);
>	npc_priv = NULL;
>Does this bitmap_clear still serve a purpose? Pre-patch it cleared
>state on a static struct that persisted across unbind/rebind, but with
>the dynamic allocation it can be removed.
Not needed. But kept as part of graceful shutdown.

