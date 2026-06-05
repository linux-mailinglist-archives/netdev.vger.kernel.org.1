Return-Path: <netdev+bounces-295659-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id eGWjOvN1ImoHXwEAu9opvQ
	(envelope-from <netdev+bounces-295659-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 09:08:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E549645C8A
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 09:08:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=marvell.com header.s=pfpt0220 header.b=iUr9Wbos;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295659-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295659-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=marvell.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B06FF30ABE86
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 07:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F8E3FFAA4;
	Fri,  5 Jun 2026 07:01:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA82405C35;
	Fri,  5 Jun 2026 07:01:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780642905; cv=none; b=c+l3Kmjnwp6PaY8cED1lMndlarhGMyu/FosJlDx4VX3cKEBexbMVSQbpWKKQ/pOzxb7YYGy+fnSnZtz9NSt4gj8Frlhadt4lNMeDnjoaOeFEKuYB+1J5YwRZCld4myascAlpmvfnIKvZKqA5rldlHz64WcJSDcwOtt61/9h8F4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780642905; c=relaxed/simple;
	bh=O/+ZkA1rqT1OtfxrbKnXmuheVKw68QR1ymZno0iGDAY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CL4K9jCM/T+swpEISh0W68TOQZpIVdrQS/0Nr2uqsn5wvTWeKQqcxzyCCHEf3O8C4y47fQXfmkEQUEOhwS1i0SYHrOVZjcLPy1/vwN2PUjIzCV2Wr+QvUB1Z58vVzTW3r9MDFriffV1uLw7yexIG4Uw0urxnQ2k/aWhvWs1TnAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=iUr9Wbos; arc=none smtp.client-ip=67.231.156.173
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6554PZC8823235;
	Fri, 5 Jun 2026 00:01:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=O/+ZkA1rqT1OtfxrbKnXmuheV
	Kw68QR1ymZno0iGDAY=; b=iUr9WbosMJHyTX5/B31U5fTVcMK1y4Q1jfp20Imle
	dpmOrkk+sYSKHMOmEU1eizmQpccnZtVQsID8pjAaGIS7uIOz3grGVxyhezfFZwaP
	rzZ/392pfjkNPwCWL0+/tOxwea1bl0xzL7jzp1RgVhmYVhIp+g/aSoXKpphhQ6ls
	+IabfZvmztlY3fP6Oy5VibPJCqrRHumHb4H+cpeNuRN/EDJwjFoNYPNuTvn6hQnu
	pyU8aPqDLZZTFyUGejrFPVOkX7HF6hoMFWnGMOkXkOmjYm4rNoc/lPFdCsTeB2QP
	Fz7Pmm1xgWPsWdY+p1sCAQvjB9bI2LTz0Q9RSnNn1seaw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4ejgsp8aq8-17
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Jun 2026 00:01:35 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 5 Jun 2026 00:01:19 -0700
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 4 Jun 2026 22:01:37 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 4 Jun 2026 22:01:37 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id A3D203F707A;
	Thu,  4 Jun 2026 22:01:33 -0700 (PDT)
Date: Fri, 5 Jun 2026 10:31:32 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <donald.hunter@gmail.com>,
        <edumazet@google.com>, <horms@kernel.org>, <jiri@resnulli.us>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>
Subject: Re: [PATCH v19 net-next 0/9] octeontx2-af: npc: Enhancements.
Message-ID: <aiJYLODHW9WkZ8k5@rkannoth-OptiPlex-7090>
References: <20260605035030.3195141-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260605035030.3195141-1-rkannoth@marvell.com>
X-Proofpoint-ORIG-GUID: qs9y6n98legmmoeNbfiI5mNaNdjV2lZQ
X-Proofpoint-GUID: qs9y6n98legmmoeNbfiI5mNaNdjV2lZQ
X-Authority-Analysis: v=2.4 cv=FJkrAeos c=1 sm=1 tr=0 ts=6a22744f cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8
 a=55J0GqIfsF46N-Hq72kA:9 a=CjuIK1q_8ugA:10 a=ZXulRonScM0A:10
 a=OBjm3rFKGHvpk9ecZwUJ:22 a=Oh551-UHZqmTy8JkqTUo:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA1MDA2NCBTYWx0ZWRfX5c7Zs1NCR3cm
 d0zBGRF3QAYZbPeZnt+xYXCWjxKJZVpt6XvM7MMCMYj0PikB7ifWxOdKoDb5AoI66hOc0akeNC/
 aPtCBjje+UAsNJPC307yKNAiUc7B8FN3XRnJQuAuFtd0RBYST9AW3JPXCo3TUGcv0GVINsnicbP
 DV7OxOA3xEyUtyHAbnpOOXmqwuI+SpfaV+dQn/HK9F36T67AYT1tZHEOVBPvQzcSQJMiZw+LYjc
 FCAZjfSuAolK5U5U9+2Op/CeTGefOHTbZRwk4zv/6u0xRevbGFl7F5iYvwYj7S2AC+c8JPJu6dS
 2eN8bfy+kVgUtKdnBUuZGl3w2iYC3hFpcQCspqQp02zomhqh6uHzkQT26kTciOoQOkpsLwx+pkt
 e4ae3keH+UIdRZ0el4wUkZbQbijD0uNHdiYFTBWt0zZ1ofjAIM4MnIZOLrEbjxalZ3zM5GoHdtL
 HWU6vjXKKkqjmKo7GPg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-05_01,2026-05-28_03,2025-10-01_01
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
	TAGGED_FROM(0.00)[bounces-295659-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,marvell.com:dkim,marvell.com:from_mime,marvell.com:email,rkannoth-OptiPlex-7090:mid];
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
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4E549645C8A

On 2026-06-05 at 09:20:20, Ratheesh Kannoth (rkannoth@marvell.com) wrote:
> This series extends Marvell octeontx2-af support for CN20K NPC (MCAM
> debuggability, allocation policy, default-rule lifetime, optional KPU
> profiles from firmware files, X2/X4 MCAM keyword handling in flows and
> defaults, and dynamic CN20K NPC private state), adds a devlink mechanism
> for multi-value parameters, and moves devlink_nl_param_fill() temporaries
> to the heap so stack usage stays reasonable once union devlink_param_value
> grows (patch 3).

pw-bot: changes-requested

Disregarding this patch submission. I experienced an internal SMTP
error mid-way through running git send-email, which caused only a few patches to go through.

I apologize for the noise and will resend the complete series shortly.

