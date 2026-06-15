Return-Path: <netdev+bounces-299333-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CsziH3acL2rmDAUAu9opvQ
	(envelope-from <netdev+bounces-299333-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 08:32:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D0215683D96
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 08:32:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=marvell.com header.s=pfpt0220 header.b=BNgF7ifa;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299333-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299333-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=marvell.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C6532300E3BC
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 06:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E7F3B2D18;
	Mon, 15 Jun 2026 06:31:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBAED3B19B6;
	Mon, 15 Jun 2026 06:31:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781505093; cv=none; b=GIVALVy165A+icGQlq29cd7PSr1HmRuEyNZlPVkNWCTpVJwAyvqrhbBW17pYMoDBb9GzQHb1PLb+s3Kyscro4A4sGaOb1JMNkzrpfSyufta6jX16YY99vRB1LHvy65ns3VXWcBgP6FHa6bhyhgqYMt5huZwrxLQ9JmxlQSKde+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781505093; c=relaxed/simple;
	bh=HdUtVP4U03r6hFt/mhZ0+qgOk5+eeHWfsach15VK63I=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HP9blnR1nzxxxoH7xQNwMeV4zC/tnFyLKAgzYnGIjpUYlGkn568ENaaIbynEyECYbV5ZOeaS8gsVwh5yI61EaNTC3+62ec93z/l5xz+Y2gkCZsu7ME5bbIQG6cRQpPdLJTC0JXthPBn8sTAv/1c3r4nTKDyCHDuIC+ptR4fKYU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=BNgF7ifa; arc=none smtp.client-ip=67.231.156.173
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65F6HJPx4184455;
	Sun, 14 Jun 2026 23:31:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=HdUtVP4U03r6hFt/mhZ0+qgOk
	5+eeHWfsach15VK63I=; b=BNgF7ifaniB8tO9rBT7qfq8y/AKh0rU1V85TzqrYz
	+GiGpbrzo6P6xb3r7Y1CAgvzVLWode1nskGMHKp4myU2OQ2Wx0B1uzLsTwknNdgH
	lJ/x9eTLUDsICjuibscEWpwZDZ1pgX/FmtbjlEZv29Chz7DO+hL8HRD1WRQY7LpB
	PgEJFico4vlIDIfm8eObpysW5ELuy4kn+zcFp4WInKlldBrKZY4EJIXvdLA1370t
	4lTCmdr1aQH4uxNbxmgpRFcagADXJGmDWHu371lWHTjyzJ6+ty1giKzjoIEm54Cv
	owpj9pMZYXM01ULeKgivoLvTXyUFuwQsJf1xoFodLPe2Q==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4es6qedry1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 14 Jun 2026 23:31:16 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 14 Jun 2026 23:31:16 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sun, 14 Jun 2026 23:31:16 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id BB1093F706A;
	Sun, 14 Jun 2026 23:31:11 -0700 (PDT)
Date: Mon, 15 Jun 2026 12:01:10 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
CC: <netdev@vger.kernel.org>, <sgoutham@marvell.com>, <gakula@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>, <bbhushan2@marvell.com>,
        <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <amakarov@marvell.com>,
        <tduszynski@marvell.com>, <linux-kernel@vger.kernel.org>,
        <jianhao.xu@seu.edu.cn>
Subject: Re: [PATCH net 0/2] octeontx2: quiesce stale mailbox IRQ state
 before request_irq()
Message-ID: <ai-cLqrb5JDaxqng@rkannoth-OptiPlex-7090>
References: <20260611160014.3202224-1-runyu.xiao@seu.edu.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260611160014.3202224-1-runyu.xiao@seu.edu.cn>
X-Proofpoint-GUID: 6CJJywh2rym2yram3Z2gs5Uj76_nPMrO
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDA2NyBTYWx0ZWRfX+cfSp6BQrgs5
 cYJvxnOr68feb158HF3JyxDyq081Hh+gKulYZnJGOUCcgL5EQtfdkDb39r2pwPPG5rxFY4yn9pc
 AWR6YZ4won8E3ImK199erZY2ZWo29F4=
X-Authority-Analysis: v=2.4 cv=TuXWQjXh c=1 sm=1 tr=0 ts=6a2f9c34 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8
 a=gsvKqhphM9sicTsUmusA:9 a=CjuIK1q_8ugA:10 a=zZCYzV9kfG8A:10
 a=OBjm3rFKGHvpk9ecZwUJ:22 a=4Pbm1F1Cy1QVNLGpYn_S:22
X-Proofpoint-ORIG-GUID: 6CJJywh2rym2yram3Z2gs5Uj76_nPMrO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDA2NyBTYWx0ZWRfX4rY01r2Di1iT
 5+eSktubXOsI7Fe7wjakoIvIEmW1sGJn/v5lho6fC2PE2XmxEfoa6EoWYwCgvtTykk28cADWePk
 kgAiNT1OAO1cjVhakiuBFwtLh09UHWC705ATtofaDWhv4j+aigwZjpW53swsHMIya2FvEbdCG74
 mZWBht295uW36q6h3fVoPFoC2p0w52i7EVGkXGa43j41CfgJ0mWGovJgiPE8QmZqFMrmRGbWxGH
 CPLMW/H/Udn9iDGpW8cVJLMD8YTXeYw/YfyPSd08e82bGUt5A+mx+b03OgQKsbSAcngK8zuQ/q/
 vbIoI7gQWaxrADDYztLObNbMiqrnR4+4i8ZWF7oRBxijiEbD0WNvkb6+olGdfawJXpL6sSNWDPj
 D89vqoozX9JyU+88quJtVS1huMWLB08Dhb1prDKSHL1eS2tGaBtGrAscNyy+IQ+9x/JJW/JHXHK
 /5plpSM9bJWAKj+lJ0A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_02,2026-06-12_03,2025-10-01_01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-299333-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:runyu.xiao@seu.edu.cn,m:netdev@vger.kernel.org,m:sgoutham@marvell.com,m:gakula@marvell.com,m:sbhatta@marvell.com,m:hkelam@marvell.com,m:bbhushan2@marvell.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:amakarov@marvell.com,m:tduszynski@marvell.com,m:linux-kernel@vger.kernel.org,m:jianhao.xu@seu.edu.cn,m:andrew@lunn.ch,s:lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,seu.edu.cn:email,marvell.com:dkim,marvell.com:email,marvell.com:from_mime,rkannoth-OptiPlex-7090:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D0215683D96

On 2026-06-11 at 21:30:12, Runyu Xiao (runyu.xiao@seu.edu.cn) wrote:
> Both OTX2 mailbox registration paths currently install their IRQ
> handlers before clearing stale local mailbox interrupt state, even
> though the code comments already say that the clear is needed first to
> avoid spurious interrupts.
>
> This issue was found by our static analysis tool and manually audited on
> Linux v6.18.21. Directed QEMU no-device validation further showed that
> the real PF and VF mailbox handlers are already reachable in that
> pre-clear window and can touch the same mailbox and workqueue carrier
> before local quiesce has completed.
>
> This series keeps the change minimal:
>
> - clear stale mailbox interrupt state before request_irq()
> - keep interrupt enabling after the handler is installed
>
> That closes the early-IRQ window without introducing a new
> enable-before-handler window.

Reviewed-by: Ratheesh Kannoth <rkannoth@marvell.com>

