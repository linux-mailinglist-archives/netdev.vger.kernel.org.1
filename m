Return-Path: <netdev+bounces-294568-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id I83XIpfHH2pSpwAAu9opvQ
	(envelope-from <netdev+bounces-294568-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 08:20:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E15A26349BC
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 08:20:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=marvell.com header.s=pfpt0220 header.b=USKN3yma;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294568-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294568-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=marvell.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 39812300A8D0
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 06:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB2AF391E7E;
	Wed,  3 Jun 2026 06:19:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4929937756F;
	Wed,  3 Jun 2026 06:19:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780467578; cv=none; b=HUlHLGP38iFzsxSs5uLkQPYDgwjNPHEc5mTir8TQjtDC3staeYFVHzQY0umRK14w8SAXUIfbZqZXYYWlgY2w4B0/4NDXSzw/SVRB2yJd6csuYWCtW/fOXWS6c3v5QriOQ5PxTMiJLWS9/vdXZlr66FioAhaKFz6fFo492pQhqco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780467578; c=relaxed/simple;
	bh=Qk6RLPFHb73KkSp4nO9sG4OSxeD6io+baGcGiwQBxRs=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Erh3dHdq6HfpHG4Kn53kxcQStEX4GugnP7dVmdMY//CUNB1v9pnhETqGOLUTf1PxW2Zho15szlZspWOZmTKt1jLyeWIwx9jzD8RZsXW7/T2TQIp1wgBeG4sh8hTT1GkuGQC0VsdOI8cyUBk9cx1YCMc87TUc65cILSC65dnTQAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=USKN3yma; arc=none smtp.client-ip=67.231.148.174
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 652NS6nf2882705;
	Tue, 2 Jun 2026 23:19:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=ObBG2Vg7QV5bpDf+q4JGIgKAm
	JZuaVv0vkY8p5Fqb/o=; b=USKN3yman0CbyKQorkTd2cymBGfZqDTY1BboZm5+D
	fdee/rnaAOn6xl2N2wUI2nyohueDQVvIjJrb7cjD8vnt9SeBaf4XI6u7VfC5I6xv
	Fef9ifpjWngTbwSnG85s92n5Bz9+LaA1dPpIgO9DASdk3paaRvc2mm+ourXWJHGK
	Qjk3gSrDAulbHyZIkDT+F7paL8HVlIxwMPaCqimO4AKopmgGNSV/yt6NOcjhZ/LO
	7oumxNj7EiYc/nAJH85NT7teA1VxrpozxkXOH7By5JGVsngwFTOasQE1bv8sxbRn
	Xa6ja5+hcBVOTvTnxk4oH+rsK5sttKlH8Ndsp+rz1F9fA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4ej8vf94g4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jun 2026 23:19:25 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 2 Jun 2026 23:19:24 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 2 Jun 2026 23:19:24 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id E24F73F708D;
	Tue,  2 Jun 2026 23:19:20 -0700 (PDT)
Date: Wed, 3 Jun 2026 11:49:19 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <donald.hunter@gmail.com>,
        <edumazet@google.com>, <horms@kernel.org>, <jiri@resnulli.us>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>
Subject: Re: [PATCH v18 net-next 1/8] octeontx2-af: npc: cn20k: debugfs
 enhancements
Message-ID: <ah_HZ56CUNPHO_sa@rkannoth-OptiPlex-7090>
References: <20260602060359.1894952-1-rkannoth@marvell.com>
 <20260602060359.1894952-2-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260602060359.1894952-2-rkannoth@marvell.com>
X-Proofpoint-ORIG-GUID: zTlUMzSI_Ay1TM1-nuzk5iVcCwN1jc-e
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDA1OCBTYWx0ZWRfX7vHDgmddQzv9
 EZ2sr3DtDCZXNKIYOzoQ0ZFD0SoFlwAcimpvYOuZ6ho1X6EOG49VIRHdUgaxGWnSwackkn34gbo
 dt2NkX5R8ndk5gkeW1RkU26Phi3t26nVCewiX42LpTwYUROTUGbxnUY4/aR6CHhZ9FHiRWOWwDw
 ULn1s+92715DrUL2nETrYzRUAolFRqVnfFLJY7GbANWzKG8qLNeomXrBerImenWHf/b0+ZCf1D4
 6RbwzU4lQA9HNeFaykzfmd216THGlecKrd7tfgu2dsHKoiSJqL0l1lUyaf6CmMticTlM3dCLktg
 SD0F/vEJZd1hgOSrVrh7yJ/SN0Qoe/+fyIFha+0tvq76jt7K5vMNH013PYFvH4VXiXdQv5bgHQV
 IVmiv0NQdZrNK4GiIlKLPmzF5vX4rw/By2oQVvgvSBpJkNzNOUMX/ng0QXdqJ1eFvEK8W68QWAv
 OtYDDSkIRtPt//SmPvA==
X-Authority-Analysis: v=2.4 cv=EtviaycA c=1 sm=1 tr=0 ts=6a1fc76d cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=EAYMVhzMl8SCOHhVQcBL:22 a=c92rfblmAAAA:8
 a=M5GUcnROAAAA:8 a=xmsM2g4GQtVOvpkoMKEA:9 a=CjuIK1q_8ugA:10
 a=GvGzcOZaWPEFPQC_NcjD:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: zTlUMzSI_Ay1TM1-nuzk5iVcCwN1jc-e
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,gmail.com,google.com,kernel.org,resnulli.us,redhat.com,marvell.com];
	TAGGED_FROM(0.00)[bounces-294568-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,marvell.com:dkim,marvell.com:from_mime,marvell.com:email];
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
X-Rspamd-Queue-Id: E15A26349BC

On 2026-06-02 at 11:33:52, Ratheesh Kannoth (rkannoth@marvell.com) wrote:
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

https://sashiko.dev/#/patchset/20260602060359.1894952-1-rkannoth%40marvell.com
sashiko says

>> +			pf = 0xFFFF;
>> +			map = xa_load(&npc_priv->xa_idx2pf_map, mcam_idx);
>> +			if (map)
>> +				pf = xa_to_value(map);
>> +
>> +			delta = stats - dstats[bank][idx];
>> +
>> +			snprintf(buff, sizeof(buff), "%u\t%#04x\t%llu\n",
>> +				 mcam_idx, pf, delta);
>> +			seq_puts(s, buff);
>> +
>> +			dstats[bank][idx] = stats;
>Does this code allow an out-of-bounds array access?
No.

>In npc_priv_init() (shown below), integer division truncation allows
>a hardware-supplied bank_depth to exceed statically allocated array
>dimensions. Because remainders are truncated, a bank_depth value such
>as 8223 (with num_subbanks = 32) yields subbank_depth = 256.

npc_priv_init() do check against max limit for MAX_BANKDEPTH and bail out on
error.

>I noticed this was fixed later in the series in commit "octeontx2-af: npc:
>cn20k: Allocate npc_priv and dstats dynamically.", but this patch
>introduces a concrete buffer overflow.

These checks are in the current patch itself.

>+update_en_map:
>> +	if (enable)
>> +		set_bit(index, npc_priv.en_map);
>Can index exceed the bitmap size here?
>Due to the same integer division truncation issue mentioned above, index
>can exceed the expected bounds, causing set_bit() to write beyond the
>statically allocated 16384 bits of npc_priv.en_map.
No. "en_map" bitmap is defined with MAXimum size possible. Check against these max limits
are done during probe (in npc_priv_init()) and returns error.

>  	subbank_depth =	bank_depth / num_subbanks;
>> +	if (subbank_depth > MAX_SUBBANK_DEPTH) {
>This is a pre-existing issue, but can this integer division evaluate to 0?
>If hardware reports a banksize (which becomes bank_depth) less than
>num_subbanks (e.g., 16 vs 32), the integer division evaluates to 0.
Pre-existing issue, so not addressing here. We need to check agaist zero, wll post
as a seperate patch to "net" tree, - or may be a hardening series.

