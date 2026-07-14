Return-Path: <netdev+bounces-307346-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yqzoCbGmVWqbrQAAu9opvQ
	(envelope-from <netdev+bounces-307346-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 05:02:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B2E8750898
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 05:02:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=marvell.com header.s=pfpt0220 header.b=KTDz+vIM;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307346-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307346-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=marvell.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 95F2E3019C91
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 03:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2EA23859D3;
	Tue, 14 Jul 2026 03:02:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D61363C79;
	Tue, 14 Jul 2026 03:02:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783998125; cv=none; b=Dt7mN1lfaR+wYlfXJWcCYhX582PIJ8OY1Py7NzJkPlD+pq6578mYZa6wMK6f2I47VYEsC154oBEnGzoexgXk9sMojUiHULt4TBaZ1mTWjHthTHCOMmUViMX/ZYfz8NUn6xCgKNK0/F4D20QxFqoqxmVlucP07aHqQvmD+96QazQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783998125; c=relaxed/simple;
	bh=iphtxwI81/ReusPNWbjjIVdb6z7aD2/w/hPXYkymjLk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TY//dFxE5fdss1j7e5GKciCKxSeBkRY1wapAtQ3JYedye9lsbBePUk/Cxm6p7Pc+DyOSRoR5o/Eqk6Io9v+GoN24Fp4BXwDnmEvnDiSErLuYP2UfXXOZ49Pyr0sQF+UfbAfeTIZ7BD31bw0UtmkrDHyFKbzfuM/1nRVLJlIzYGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=KTDz+vIM; arc=none smtp.client-ip=67.231.156.173
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66DNmkp91677539;
	Mon, 13 Jul 2026 20:01:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=iphtxwI81/ReusPNWbjjIVdb6
	z7aD2/w/hPXYkymjLk=; b=KTDz+vIMgYv0HM06msaMyzbWBV07rdQVBFMMELZb1
	gCgIMyoAkWImyh+FuOnK+G9ZvVjRcfBTVDwre0maeyvIZ59edX3/3GfRsCYUwSgY
	LBbBSVdjCsPyID3rxyZNH19g3o4kR8dZZ3L5MALt8DK/b1IxyGecsWiAyVTq4RoO
	e+1iCuUxvFyVnQtmO5KqKCsvB/UkJZl2zrtUQRfN4b6DKnUF3wdMdncqrOhAZ14e
	LSq+Znzb3BWr0j2VbqAIjIOlYG795vbpm1SJ5hc3qlta9qB4J9pO4ZttWaOaO4MV
	oknctpTfgzvpn9yHIGGT1aFWGEDCBXsjwWSPkTSsvRFBg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4fc6k9mpd1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 20:01:53 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 13 Jul 2026 20:01:52 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 13 Jul 2026 20:01:52 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 5004C3F7045;
	Mon, 13 Jul 2026 20:01:49 -0700 (PDT)
Date: Tue, 14 Jul 2026 08:31:48 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>,
        Satha Rao
	<skoteshwar@marvell.com>
Subject: Re: [PATCH net-next] octeontx2-af: add new mbox to support sync
 cycle on rx path
Message-ID: <alWmnExX4qYMWQmu@rkannoth-OptiPlex-7090>
References: <20260714020723.1811237-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260714020723.1811237-1-rkannoth@marvell.com>
X-Proofpoint-ORIG-GUID: 0sKgBs15AtzWagAVzq67oF5RgYA6Edgr
X-Proofpoint-GUID: 0sKgBs15AtzWagAVzq67oF5RgYA6Edgr
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDAyOSBTYWx0ZWRfX3AvfaqNFmcDf
 V2Xf1ZPGoe0bBqaN2le69Lfqsw9xyR0dgmUC422xvPUXpJLyLIUIBXFOECv1FHupYaQbHFw6WpR
 yY1kuoodGQtpVk61EfrEO2brrLe088Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDAyOSBTYWx0ZWRfXw8NgRzoCA8ha
 VxFUMo3iHN3171soschLI6kQrOTyqjQ7fKoyCdsEE9M4BG5QOj5tA8C70SBJ/QN51HHdQEID6cG
 Rxg4FOEeFVBfb2QsxI0dFiQ0Iqm4Bgwtzk9doL0y8TTq5WrCLLJXiueR/srsrbPyG5HbfRxgupI
 f5VkhH9bH+qvCzRWwA6TeUudkkbGVCeg9ynMbISkH2oCHVNSRdXugCkYiDOLLQophwP/WbnC6H0
 AjS9bTR0I4S89pk+ppOTnL/ZZvsR+DA6hzDqoJYbsdXWuuM6LU2BFuk5pLbCwC5/9PzwS3C8rTD
 2kYuq1+b4J0U+hNObljCIztRx7fCN3jn03DunsA/unEgipY38VCAZyQyszCEnSCC8MmVAGLCgCr
 t72J6irqgO7766H8pb0g6SEOFp0TFmSn92XV8Uel1CVM7W2NApd+BapRnIHLGbXR6+Pz2FQdXBJ
 EMtBma1WilIvjAAFXKQ==
X-Authority-Analysis: v=2.4 cv=ULLt2ify c=1 sm=1 tr=0 ts=6a55a6a1 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=qit2iCtTFQkLgVSMPQTB:22 a=M5GUcnROAAAA:8
 a=0Ahe-tVRJ49jlj4yYy0A:9 a=CjuIK1q_8ugA:10 a=ZXulRonScM0A:10
 a=OBjm3rFKGHvpk9ecZwUJ:22 a=Oh551-UHZqmTy8JkqTUo:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_06,2026-07-10_01,2025-10-01_01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-307346-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:sgoutham@marvell.com,m:skoteshwar@marvell.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[marvell.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8B2E8750898

On 2026-07-14 at 07:37:23, Ratheesh Kannoth (rkannoth@marvell.com) wrote:
> From: Satha Rao <skoteshwar@marvell.com>
>
> sync ensures that all packets that were in flight are flushed out to
> memory. This can be used to assist in the tearing down of an active RQ.
>
> To complete disabling RQs or disabling SMQ and its SQs, LF software
> send mbox to AF to complete RX_SW_SYNC.
>
> Change-Id: Iaadf5e6b26a7920693fca9921b2050af0e8e2322
> Signed-off-by: Satha Rao <skoteshwar@marvell.com>
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>

Please ignore the previous submission. It accidentally included a Gerrit Change-Id
and caught a CI warning. I will resubmit a clean version.

"ERROR: Remove Gerrit Change-Id's before submitting upstream WARNING in CI."

pw-bot: changes-requested

