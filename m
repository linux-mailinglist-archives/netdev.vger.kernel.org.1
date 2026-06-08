Return-Path: <netdev+bounces-296342-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id oO8pDCgnJmpdSwIAu9opvQ
	(envelope-from <netdev+bounces-296342-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 04:21:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E328652353
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 04:21:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=marvell.com header.s=pfpt0220 header.b=E2BoOfYI;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296342-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296342-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=marvell.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 496E430053DF
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 02:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B741F30DED0;
	Mon,  8 Jun 2026 02:21:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551D722576E;
	Mon,  8 Jun 2026 02:21:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780885274; cv=none; b=LdLqKQ8AqO5oVU54skD6LDhUvMccab0BsVHufPjdsAJ3ANVi7HqhBHnaIUusCZpjXrBPoF5Oqu3Q2VrKphBa1ZUPrxFGVIrvS2tBNx4JaxlGWwF9h/AcRgfy5Ox80ebC2MbhVCQB/hsbeGfC2OjKCvypfkWtDWDMOr5CAzsyUuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780885274; c=relaxed/simple;
	bh=v1mjy/HZfHz/ETnhs0Kzbs6R4qsUXNTXWVzlzjwsEG8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kAT4bF846rC78MCaDnC9v2+uM1EJXWORtnwwsIM1x1MzgQxT/1zstixHcCOv7/iEm7Xo0lIX5488y6r1ok2q5/ep5pFs0TIvByUM1aMzBmGi4AGw/cw87qb1mh938BMtHZXRtI26gqDkYlohm+cRybr8HCzl4BRAaXs4xkjL3lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=E2BoOfYI; arc=none smtp.client-ip=67.231.156.173
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6580EceW839064;
	Sun, 7 Jun 2026 19:21:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=n2Coyttklee0ZN+cSL7cYxPG7
	wXx0gZuBhNoAYux/RY=; b=E2BoOfYI1YSKGneF8YcWH3j6vCfwwdlMnpgmQuoPG
	7psQGlc7CvBHRc2jN1t0Ib/PITJxFyUKmMJukVwbsPebJwY7ZBZmejbowyBudbuB
	serDIFD9MCzg1sVTizG3x6NCsuGs6kVrD9KOzDHiZD2YrAR7dUnAPucGzfD+YYj+
	+p3IRdWsmMUSoBuAQ2GIs4Sc3nkKZSvp5oLD9Nmy4a/ILHu98sv0Ak4bHxul8wYi
	Za0N/0klKRXdfX8/xQK7kQwdpyfROe9Y6joh0iIHidE2xfDr2nQ3q5DSzI7oQdPI
	jG3XC1N6MTDdmj4igRPGTBqDthw0fQRNRR/v0MEUTfafA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4en4a5j9qy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 07 Jun 2026 19:21:04 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 7 Jun 2026 19:21:03 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sun, 7 Jun 2026 19:21:03 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 7EA135B6932;
	Sun,  7 Jun 2026 19:21:00 -0700 (PDT)
Date: Mon, 8 Jun 2026 07:50:59 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <donald.hunter@gmail.com>,
        <edumazet@google.com>, <horms@kernel.org>, <jiri@resnulli.us>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>
Subject: Re: [PATCH v19 net-next 2/9] octeontx2-af: npc: cn20k: debugfs
 enhancements
Message-ID: <aiYnC76F9472pXus@rkannoth-OptiPlex-7090>
References: <20260605063245.3553861-1-rkannoth@marvell.com>
 <20260605063245.3553861-3-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260605063245.3553861-3-rkannoth@marvell.com>
X-Authority-Analysis: v=2.4 cv=HpBG3UTS c=1 sm=1 tr=0 ts=6a262710 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=qit2iCtTFQkLgVSMPQTB:22 a=c92rfblmAAAA:8
 a=M5GUcnROAAAA:8 a=xYWY-QBHG2NFp7g9jwEA:9 a=CjuIK1q_8ugA:10
 a=GvGzcOZaWPEFPQC_NcjD:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: mnOev8CZj_Qkipy4pvPdWmrZiK7NRrP_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDAxOSBTYWx0ZWRfX81VbxgyXUmUu
 XfSw5jt2/21fvsj35PDjcb34K4D+Or4WBxQkeJvcNnHRsx/+swFT8BzCNFSOIZYgnkNkdiNTpdx
 ag6PMSgToX4Zy5DU6mtfL3WgwYLByfT9vHTeIrI4M3r9+b1/geZn64n0seLXKxI6LbZ/oMW8oui
 5Zt+hlemKlfFo04e1V/hFeJ2zNWwrt0+SFstActz7H7hHdkhkh/mrSHQUJo7ZKe7Y8Vaw1ZAiSX
 uXLhsJhgOCXP9qxZnLSkswp4+0RD36jqM8zGFpR4Bc6zjnhaKG/TLyisp/d3ze/rojPLVtkVZUJ
 oMINQQ4xwM0rLkHW0hB/nO2COxcdnQ7C0BH/doYIkgjq7o9bo/0Oj7sJIqyQR+IF9hUmbShknaq
 SBLYEzDE/oMrFOnNxGyFqySewYs5+uTUVyY3AMtAVcntL6I8sFmjXnK6MHyhefHlFQ8EXADUgzn
 He7/sNrzAGXIBlF5glQ==
X-Proofpoint-GUID: mnOev8CZj_Qkipy4pvPdWmrZiK7NRrP_
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,gmail.com,google.com,kernel.org,resnulli.us,redhat.com,marvell.com];
	TAGGED_FROM(0.00)[bounces-296342-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,marvell.com:dkim,marvell.com:from_mime,marvell.com:email,rkannoth-OptiPlex-7090:mid];
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
X-Rspamd-Queue-Id: 7E328652353

On 2026-06-05 at 12:02:38, Ratheesh Kannoth (rkannoth@marvell.com) wrote:
> Improve MCAM visibility and field debugging for CN20K NPC.
>
> - Extend "mcam_layout" to show enabled (+) or disabled state per entry
>   so status can be verified without parsing the full "mcam_entry" dump.
> - Add "dstats" debugfs entry: for enabled MCAM indices, print hit deltas
>   since the prior read by comparing hardware counters to a per-entry
>   software baseline and advancing that baseline after each read (hardware
>   counters are not cleared).
> - Add "mismatch" debugfs entry: lists MCAM entries that are enabled
>   but not explicitly allocated, helping diagnose allocation/field issues.
>
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>

https://sashiko.dev/#/patchset/20260605063245.3553861-1-rkannoth%40marvell.com says

>> +
>> +			snprintf(buff, sizeof(buff), "%u\t%#04x\t%llu\n",
>> +				 mcam_idx, pf, delta);
>> +			seq_puts(s, buff);
>> +
>> +			dstats[bank][idx] = stats;
>Does this loop read and write out-of-bounds of the dstats array if bank_depth
>is larger than expected? As discussed below in npc_priv_init(), bank_depth
>can bypass validation. If that happens, iterating up to bank_depth - 1 will
>exceed the fixed MAX_SUBBANK_DEPTH * MAX_NUM_SUB_BANKS array dimensions.

npc_priv_init() do check whether within limits during probe()

>Can stale baselines in dstats cause inaccurate delta calculations when MCAM
>entries are freed and reallocated?
>Can stale baselines in dstats cause inaccurate delta calculations when MCAM
>entries are freed and reallocated?

Yes. but it is OK as the dstats is used to debug field issues. First time
it may show wrong data, but second time ownwards, data will be correct as s/w baseline
array updates to the hw stats.

>While the reset logic attempts to handle this with:
>if (stats < dstats[bank][idx]) dstats[bank][idx] = 0;
>This reset will fail to trigger if a newly allocated entry accumulates hits
>greater than or equal to the stale baseline before the very first debugfs
>read. In this scenario, the stale baseline would be silently subtracted,
>drastically undercounting the statistics.

No. dstats[0][bank][idx] = stats line sets s/w array baseline to match hw
stats.

> @@ -842,6 +842,12 @@ npc_cn20k_enable_mcam_entry(struct rvu *rvu, int blkaddr,
>>  			    cfg);
>>  	}
>>
>> +update_en_map:
>> +	if (enable)
>> +		set_bit(index, npc_priv.en_map);
>> +	else
>> +		clear_bit(index, npc_priv.en_map);
>> +
>Can index exceed the bounds of the en_map bitmap?
>Because en_map is allocated for exactly MAX_NUM_BANKS * MAX_NUM_SUB_BANKS *
>MAX_SUBBANK_DEPTH (16384) bits, an index corresponding to an oversized
>bank_depth (as described in npc_priv_init() below) could cause set_bit() to
>silently corrupt adjacent fields in struct npc_priv_t.

No. We do check in npc_priv_init() (during probe()) against these macros (MAX_NUM_BANKS,
MAX_NUM_SUB_BANKS, MAX_SUBBANK_DEPTH). if the hw read values exceed these, probe()
itself will fail.

>>  	}
>>
>> -	npc_priv.num_subbanks = num_subbanks;
>> -
>>  	subbank_depth =	bank_depth / num_subbanks;
>> +	if (subbank_depth > MAX_SUBBANK_DEPTH) {
>> +		dev_err(rvu->dev,
>> +			"Invalid subbank depth %u\n",
>> +			subbank_depth);
>> +		return -EINVAL;
>> +	}
>>
>> +	npc_priv.num_subbanks = num_subbanks;
>>  	npc_priv.bank_depth = bank_depth;
>>  	npc_priv.subbank_depth = subbank_depth;
>Does integer division truncation allow an invalid bank_depth to bypass this
>check?
This is the case when hw read value is 0. Even though this case wont happen in hw,
we will post fix patch after this series to check agaist 0 and return err (during
probe())

>If the hardware-provided bank_depth is not an exact multiple of num_subbanks
>(for example, if bank_depth is 8223 and num_subbanks is 32), subbank_depth
>truncates to 256. This passes the MAX_SUBBANK_DEPTH check, allowing bank_depth
>to remain 8223. This oversized bank_depth then drives loops and calculations
>in other functions, leading to the out-of-bounds accesses in debugfs and the
>en_map bitmap operations highlighted above.
In all SoCs, bank_depth is an exact multiple of num_banks. We can add a check
in npc_priv_init() during probe() (as a hardening series to net-next after this
patch is merged)

