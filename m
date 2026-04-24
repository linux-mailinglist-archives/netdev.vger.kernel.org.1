Return-Path: <netdev+bounces-280971-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IBvhEJc162nRJwAAu9opvQ
	(envelope-from <netdev+bounces-280971-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 11:19:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6503D45C0E5
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 11:19:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 710F03006380
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 09:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2BF3372B24;
	Fri, 24 Apr 2026 09:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="kgRUGpzz"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E9137DE81;
	Fri, 24 Apr 2026 09:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777022165; cv=none; b=ki6QvzMveXWnbjlr25+0EA0TgFQtxyQfKwx/oRCjixrznD8rrDs4culJR/yIfB/5NhOno8zjTgqJYP2n9foVgL0VJVSPyMlZUojOKwC06MRWPDd0alB6dtf/wiu3Q/QAz8XBRTOaNR8n2w8uy7LSdebxmUjhYAUb+rzmKG/+baU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777022165; c=relaxed/simple;
	bh=fWeeeVPtWnE0+HSYXdY4IxI/CPHOOJS8MLT16fJ27bk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=refn+d2BET/isYmGNQM1+f17wsuHP7qms2YeTdQrcy0Y21iUWcJZvU4WolLwwo181b3CZeCPhECsgHJwvcQTzOF2ef6fZvDIzMfatjPdehF0URWyD6uqP9hFSfvm2CtV2fb/Y7jGrKes5+am3hgWlyohiOqg7RVbv6pW7BxXXXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=kgRUGpzz; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63O6qK0p3306706;
	Fri, 24 Apr 2026 02:15:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=N+gMqrISiHyV5eYqXkr9AhRbq
	f6YcTWo2lJn31gHHak=; b=kgRUGpzzKCsGNCzPDW+f2M3X4TGz3n5D1r2RzeCXX
	jPtm/FQcBZIYr1B4JDRTYZ4bC9/NeN0qy7PadFL5tL28ZlNI7c56qQgR7wMwRzEL
	AjqaB6yVvqZ7P1PPi2iERTepLneAjmf440p7J49j1wKbk7D0hgTyvp7as2BB7dGq
	ox0UkPL0siSF/spldwfNZZ7hH4Zjq7MdmorRp75Y/jDCBQXBKxcyyQ86WOhWsPaP
	JLe8Wjv7m3RrXgnGg0pvqJWWabZQJWcJfQ1cBBvOaQIAgclTy14AtTKfv0RfZy45
	u90jl7YiU+8Q2FyNq8MGxdYAVeIFPh0hFGaqcQUxVlaXg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4dqpk2a3xp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Apr 2026 02:15:55 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 24 Apr 2026 02:15:54 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Fri, 24 Apr 2026 02:15:54 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id A86933F7071;
	Fri, 24 Apr 2026 02:15:51 -0700 (PDT)
Date: Fri, 24 Apr 2026 14:45:50 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
        Suman Ghosh
	<sumang@marvell.com>
Subject: Re: [PATCH v3 net 11/11] octeontx2-af: npc: cn20k: Reject missing
 default-rule MCAM indices
Message-ID: <aes0xm-2CtCdExMe@rkannoth-OptiPlex-7090>
References: <20260423104317.2707923-1-rkannoth@marvell.com>
 <20260423104317.2707923-12-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260423104317.2707923-12-rkannoth@marvell.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI0MDA4NSBTYWx0ZWRfX+IhxtaVXCc6y
 e0vlc2QCKGIMLlvbCTbdqFzCrBgl/iliDkRCmR2Z9Y9S3tu8EmlruPnP5CTmuwWDZgNWA/WJCo1
 4uHjcoLrfj5ngwwF9p93JeHgFLg5s+qYW4yu2/iiifG+dodhEsaZqq51Rd2VFmw+c7oL0Qg6FIg
 pa1NzANX9A4UY8igXpWFor8GM9Jra8+ZnVaNJ1uGTZqM+omLFL7zMHPYkMKfjwjSjH9VrxSFZCL
 Ub6Bcofi3T+0+wnxUuZNHASj1RdIV4Guy4yDLHQf2XPPe2BBklYzk8L5elad2dvhI5t8z27OFE5
 VLja0VjQod5pxkXSHQm7Lypr1B77pkGNzp3zdpGwHbEGKoksLYM1yAUjdn18OCdr+MQ2O6SUUYW
 ExHpDpLtyeuS9k98OPaOcL1G1dVHKrAyzrkwttHMKmHmwjoi4aPn+jFuhS8rkzlimt0YIlzfeXx
 CQx7yuN0QBgR4/V1ITA==
X-Authority-Analysis: v=2.4 cv=IPAyzAvG c=1 sm=1 tr=0 ts=69eb34cb cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=EAYMVhzMl8SCOHhVQcBL:22 a=9R54UkLUAAAA:8
 a=M5GUcnROAAAA:8 a=D3U6KnTYFKdaAklCq_8A:9 a=CjuIK1q_8ugA:10
 a=YTcpBFlVQWkNscrzJ_Dz:22 a=OBjm3rFKGHvpk9ecZwUJ:22 a=Oh551-UHZqmTy8JkqTUo:22
X-Proofpoint-ORIG-GUID: vOf1E6MaMovZSgudWAc-2CeYfof4wzDv
X-Proofpoint-GUID: vOf1E6MaMovZSgudWAc-2CeYfof4wzDv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Rspamd-Queue-Id: 6503D45C0E5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-280971-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[marvell.com:dkim,marvell.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:url];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[marvell.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]

On 2026-04-23 at 16:13:17, Ratheesh Kannoth (rkannoth@marvell.com) wrote:

>> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
>> index 5d349d131fdb..611cd7fce245 100644
>> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
>> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
>
>[ ... ]
>
>> @@ -3897,6 +4006,13 @@ int rvu_mbox_handler_npc_read_base_steer_rule(struct rvu *rvu,
>>  	/* Read the default ucast entry if there is no pkt steering rule */
>>  	index = npc_get_nixlf_mcam_index(mcam, pcifunc, nixlf,
>>  					 NIXLF_UCAST_ENTRY);
>> +	if (index < 0) {
>> +		dev_err(rvu->dev,
>> +			"%s: Error to get ucast entry for pcifunc=%#x\n",
>> +			__func__, pcifunc);
>> +		goto out;
>> +	}
>> +
>>  read_entry:
>>  	/* Read the mcam entry */
>>  	npc_read_mcam_entry(rvu, mcam, blkaddr, index, &rsp->entry, &intf,
>
>Does this 'goto out' leak mcam->lock?  Looking at the function entry,
>the lock is acquired before the for-loop:
>
>rvu_mbox_handler_npc_read_base_steer_rule() {
>    ...
>    mutex_lock(&mcam->lock);
>
>    for (idx = 0; idx < pfvf->def_ucast_rule.count; idx++) {
>        ...
>    }
>
>    /* Read the default ucast entry if there is no pkt steering rule */
>    index = npc_get_nixlf_mcam_index(...);
>    if (index < 0) {
>        goto out;
>    }
>
>and the 'out' label just returns without unlocking:
>
>out:
>    return rc;
>
>The nix_get_nixlf() failure path just before this does:
>
>    if (rc) {
>        mutex_unlock(&mcam->lock);
>        goto out;
>    }
>
>Should this new error path match that pattern?

AI review report: https://netdev-ai.bots.linux.dev/ai-review.html?id=9923f145-31df-46b0-84e8-b15f1e307ad2#patch-10
pw-bot: changes-requested

Will fix in next version.

