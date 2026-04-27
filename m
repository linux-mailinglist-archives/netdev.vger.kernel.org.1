Return-Path: <netdev+bounces-281289-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WEBzEjE072mA9wAAu9opvQ
	(envelope-from <netdev+bounces-281289-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 12:02:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 25998470621
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 12:02:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BBBA630B51ED
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 09:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D933B3BEF;
	Mon, 27 Apr 2026 09:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="AUotH4Ws"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF22C3B3C1F;
	Mon, 27 Apr 2026 09:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777283811; cv=none; b=iuAoTCYexaoi1x5mBG+d3WxYK/nzhZoZR08BNerRxhcM1edEBCblNK/gjCg68/CKdW4eyE7WjK+75sa0paRLmJyaRBEAqW1gc3BKVeIHY9XVDXc50X5zsut4oeIhiTonzeT2r1xlxO7Pz6jnAFKOzoj15cJ8pkA3rGRnlzqg99k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777283811; c=relaxed/simple;
	bh=h9av3+eEEbItGLM42a3BDEWcQYL45D7LNvUeqiwxlQQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IeCnRk2QMQ9guyo50c2uEpnc5xnPiH8mIcXHi2BGHzGJEmTBhF5gi6q60PVIF6WE18i0tWP+A9L/4fmYqZYwJUQfyLaWmZHFb2xF8qkXoqPoDcNMZsa6zTrAQVG/Zu4igauGkCKC+jqCB2Lan9WMPr8Y7qvesej1Gil+g2pe+ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=AUotH4Ws; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63R8ILeP4012850;
	Mon, 27 Apr 2026 02:56:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=Vdn2UXJLn61Ff/sayM8YDuNE5
	D7KVAPM/yHTR5hADKQ=; b=AUotH4Ws+Z/h2Sdv0gY4KNjYMZQ/m+Tbwjkwi4ZRz
	UbLaSWudLDQejaLUbiKCGNTRfQBUNf7vv+1tR8Ffki9tuceIqJOsQ6C027BPd455
	VJNWzwXdBxPoJn3jBYTA0GRiqXoQH0sp5qJFzSs4oEF9vn5ksiQQ7zAAApfC3J4N
	1oPpBRsrwMX7tFuKavhKVCMz4owBXCB+BP0JSrN/yH97rnF7Y216YwF/M6ZacKnx
	/Tw67KGTeZXv12T/bOhnWwzfTvW9gKqksvqMs9Jplfne7e7U7UP3oy6r6RSGB4DF
	zoiVxXwBzLbTvbJzmYkf65Zpokcmy9I1ugsStxoLqaXbw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4dt45yr6pt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Apr 2026 02:56:41 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 27 Apr 2026 02:56:40 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 27 Apr 2026 02:56:40 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id D59F23F7051;
	Mon, 27 Apr 2026 02:56:36 -0700 (PDT)
Date: Mon, 27 Apr 2026 15:26:35 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
        "Dan
 Carpenter" <error27@gmail.com>, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH v4 net 03/10] octeontx2-af: npc: cn20k: Propagate errors
 in defrag MCAM alloc rollback
Message-ID: <ae8y0-w3KRGRME_B@rkannoth-OptiPlex-7090>
References: <20260427063213.3937451-1-rkannoth@marvell.com>
 <20260427063213.3937451-4-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260427063213.3937451-4-rkannoth@marvell.com>
X-Proofpoint-ORIG-GUID: Rwm31vCfWT7VUiaAKF84Ua8q2xDmf2fO
X-Proofpoint-GUID: Rwm31vCfWT7VUiaAKF84Ua8q2xDmf2fO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDEwNCBTYWx0ZWRfXy3rQxzSm9Oaw
 ncLEgeRw6Ge8QUgItl6EPGP62nyt7qMMTVU4H2/MYz9q63E6vKORg6NyyMS+/Yc8u/Kveu/lNtL
 n7pyo/HNknnrOYwkG9k7PGex1vkyqcaFTgWBeITtd8irwPKO05eqAolNQ/fLcPwxg4stZXpD6Du
 x44+l/ySufum3MeP7KvHXcon2X2qWyC+egjkWLN0eKp8cSjKzGsWIKQMapc1HUdJPtrUAvfVyXQ
 fGRccghrVPRQR1pLM8embuvh4bURTDi2AV42B0GMS/6AodfpQtTzVb1WKrINiS4FlHX1lAwKkwi
 JHavMWtIJ4i6lROnQGotdpEf9eyDJOXekzxoWibNc0Yy/hZmYBAsaaq/qONA3eNX7LIfuIuOocZ
 GW3zf17ipe56ilSrbRpCfOIJrOERWvdNOyXYeAHEly6Z982PCEMk3L/gcqdGlJkeL8iKwnBY9R/
 fD7LBTC70njN5F39Cjg==
X-Authority-Analysis: v=2.4 cv=VOTtWdPX c=1 sm=1 tr=0 ts=69ef32d9 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=qit2iCtTFQkLgVSMPQTB:22 a=M5GUcnROAAAA:8
 a=ERzkeGuozZUWcDxUr0cA:9 a=CjuIK1q_8ugA:10 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_02,2026-04-21_02,2025-10-01_01
X-Rspamd-Queue-Id: 25998470621
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
	FREEMAIL_CC(0.00)[marvell.com,davemloft.net,google.com,kernel.org,redhat.com,lunn.ch,gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[marvell.com:dkim,marvell.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281289-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]

On 2026-04-27 at 12:02:06, Ratheesh Kannoth (rkannoth@marvell.com) wrote:
> npc_defrag_alloc_free_slots() allocates MCAM indexes in up to two passes
> on bank0 then bank1.  On failure it rolls back by freeing entries already
> placed in save[].
>
> __npc_subbank_alloc() can return a negative errno while only part of the
> indexes are valid.  The rollback loop used rc for
> npc_mcam_idx_2_subbank_idx() as well, so a successful lookup stored zero
> in rc and a later __npc_subbank_free() failure could still end with
> return 0 when the allocation path had also left rc at zero
> (for example shortfall after zero return values from the alloc helpers).
>
> Jump to the rollback path immediately when either __npc_subbank_alloc()
> call fails, preserving its errno.  If both calls succeed but the total
> allocated count is still less than cnt, set rc to -ENOSPC before rollback.
> Use a separate err variable for npc_mcam_idx_2_subbank_idx() so a
> successful lookup no longer clears a non-zero rc from the allocation
> phase.
>

>> @@ -3533,13 +3535,14 @@ static int npc_defrag_alloc_free_slots(struct rvu *rvu,
>>  			__func__, cnt, alloc_cnt1, alloc_cnt2);
>>  		goto fail_free_alloc;
>>  	}
>> +
>>  	return 0;
>>
>>  fail_free_alloc:
>>  	for (i = 0; i < alloc_cnt1 + alloc_cnt2; i++) {
>> -		rc =  npc_mcam_idx_2_subbank_idx(rvu, save[i],
>> -						 &sb, &sb_off);
>> -		if (rc) {
>> +		err =  npc_mcam_idx_2_subbank_idx(rvu, save[i],
>> +						  &sb, &sb_off);
>> +		if (err) {
>>  			dev_err(rvu->dev,
>>  				"%s: Error to find subbank for mcam idx=%u\n",
>>  				__func__, save[i]);
>Does the diff implement what the commit message describes?
>The commit message states:
>    Jump to the rollback path immediately when either __npc_subbank_alloc()
>    call fails, preserving its errno.  If both calls succeed but the total
>    allocated count is still less than cnt, set rc to -ENOSPC before
>    rollback.
>Looking at npc_defrag_alloc_free_slots() after the patch applies, there
>is no early jump after the first __npc_subbank_alloc() call, and no
>assignment of rc = -ENOSPC before the goto:

ACK.
pw-bot: changes-requested

>> @@ -3533,13 +3535,14 @@ static int npc_defrag_alloc_free_slots(struct rvu *rvu,
>>  			__func__, cnt, alloc_cnt1, alloc_cnt2);
>>  		goto fail_free_alloc;
>>  	}
>> +
>>  	return 0;
>>
>>  fail_free_alloc:
>>  	for (i = 0; i < alloc_cnt1 + alloc_cnt2; i++) {
>> -		rc =  npc_mcam_idx_2_subbank_idx(rvu, save[i],
>> -						 &sb, &sb_off);
>> -		if (rc) {
>> +		err =  npc_mcam_idx_2_subbank_idx(rvu, save[i],
>> +						  &sb, &sb_off);
>> +		if (err) {
>>  			dev_err(rvu->dev,
>>  				"%s: Error to find subbank for mcam idx=%u\n",
>>  				__func__, save[i]);
>Does the diff implement what the commit message describes?
>The commit message states:
>    Jump to the rollback path immediately when either __npc_subbank_alloc()
>    call fails, preserving its errno.  If both calls succeed but the total
>    allocated count is still less than cnt, set rc to -ENOSPC before
>    rollback.
>Looking at npc_defrag_alloc_free_slots() after the patch applies, there
>is no early jump after the first __npc_subbank_alloc() call, and no
>assignment of rc = -ENOSPC before the goto:

ACK.

