Return-Path: <netdev+bounces-260715-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uAADJuVXnmkjUwQAu9opvQ
	(envelope-from <netdev+bounces-260715-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 03:01:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 407DB19062A
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 03:01:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E646130054FE
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 01:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3EE2252917;
	Wed, 25 Feb 2026 01:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="hVpCXyYJ"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45EC32505B2;
	Wed, 25 Feb 2026 01:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771984625; cv=none; b=uYoXYr2O7f56ENPJpyM4/rxWybeRZvGTNXrCw4dygIbIh34m1K8GApBIJmrusaXP7K1/vNfOyF/oDYSVH2GUYpEK/AnAv18r0uQgyjyTAB3DVXnAkd2aXQhbmXzoB7SCuIoXZgfgpGSSDNHXmfVTEz9l8xJ/37UmtQmSF9fz5XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771984625; c=relaxed/simple;
	bh=iX1vuBEHioUWth5SQ/gIG0ctnR9Imkegqk1Txkur6Bc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TIRd8ALEP9WH8GAqkGWbqg+op73xEM5FHNIb2TqEtQornXmkOIBYwobFTevl8XrQUR71oLs0qHOS+Zm1dSZR6yRBsKZOYyRlSivVjN6NTT0Wdt/sH7ZAK++0607nBehZrEnnD0E1+w5stGSiVtZHNL2G9mIDXYWFH1LWc19Ky7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=hVpCXyYJ; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61ONRoxM1176380;
	Tue, 24 Feb 2026 17:56:51 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=N8HjTjjDc4OOjtft1aCSlShXT
	lMLdH1wa8usCFRcCZk=; b=hVpCXyYJyDXXMZvUTobF6ZS2pR7pHYXs1zLJgik6r
	ISsbsUaAPrsI5Lwx2NPOEmOguWt9fZKKl9qWVts5N7+1WVUBoBBJ4FnPJRfHLpyU
	AwPAW69ZbO4Om56wyRn6aJerrS+wRLZUmJo9xEqSDH+v3OHhYrqPI9XV5EHY6Sv/
	JEIuFkTc2rgX9OkkOBx5NRg8Z4TLOQu1h4xZ/1czASUJUJu674ELH39POrTFfR3A
	RQbxKuVz92euXund1S91OAoRbUxSF7ebJG6tQ7b2gaasJw56++N4qJ6lhfScMoqe
	SeB8fxVHc++xixMiiYyeqRLwAkWihzYYQu0UQYG4039Cw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4chnp8r8x2-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Feb 2026 17:56:51 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 24 Feb 2026 17:56:51 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 24 Feb 2026 17:56:50 -0800
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 603D35C68EE;
	Tue, 24 Feb 2026 17:56:48 -0800 (PST)
Date: Wed, 25 Feb 2026 07:26:47 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <pabeni@redhat.com>, <andrew+netdev@lunn.ch>
Subject: Re: [PATCH net-next v9 00/13] NPC HW block support for cn20k
Message-ID: <aZ5W35hJWsU8btAN@rkannoth-OptiPlex-7090>
References: <20260224080009.4147301-1-rkannoth@marvell.com>
 <20260224103537.4eed8e8b@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260224103537.4eed8e8b@kernel.org>
X-Proofpoint-ORIG-GUID: nwYeR_hedoixjp4sLtHzxjk5PSyjICqD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI1MDAxNSBTYWx0ZWRfX1i8Pl6w8PGAB
 cdCvc5MQmaNjeTsosTvM3RYoIiqwnJ0eR3OGTDO0YP6o/Eq866wWuucofkcKCBDnZRvyqp2RbS9
 EGIGPEhH8Tq8G+ax10IbVo2HXEdZtoQJxYlpeCRwwrlmBTK+1Mdau7gjZqnLpyADiQYvaZAHUZL
 XzBvaxQOeLdzkuYVHqswYdXMOTsWmjJ8PaYwezI9S8Ba4F3/LjcFBtfbNaDhJRuGJGLevR8Zulz
 OxIxorqcN4k2BoCUU+NgHU3b9rcI15cEpAU/TOaoUE4WMYWRHdwcqtARHI+GmJZcLV0vBdAvEbS
 vOOsbGUrW4d5TERHNAuKyxEK+awxD5s9c4yTXFwz0eiYh9ZL8w93a42NsFCMIEWGeUN+NlhPVFF
 XVwIIe4wYIZWmnarO3eJ3B5ydlj6zltaRt+g62z988eOGffWk6z5HCcla1+vGu/Y27l0HGfvPcn
 z57Xw1zbaPVPEaEmeCg==
X-Authority-Analysis: v=2.4 cv=bNYb4f+Z c=1 sm=1 tr=0 ts=699e56e3 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=kj9zAlcOel0A:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=EAYMVhzMl8SCOHhVQcBL:22 a=VwQbUJbxAAAA:8
 a=M5GUcnROAAAA:8 a=WljHKSap0GIyhByar9MA:9 a=CjuIK1q_8ugA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22 a=lhd_8Stf4_Oa5sg58ivl:22
X-Proofpoint-GUID: nwYeR_hedoixjp4sLtHzxjk5PSyjICqD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-24_03,2026-02-23_03,2025-10-01_01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260715-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[marvell.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[marvell.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 407DB19062A
X-Rspamd-Action: no action

On 2026-02-25 at 00:05:37, Jakub Kicinski (kuba@kernel.org) wrote:
> On Tue, 24 Feb 2026 13:29:56 +0530 Ratheesh Kannoth wrote:
> > v8 -> v9: Addressed Jakub comments.
> > 	https://lore.kernel.org/netdev/20260204182428.05a77b13@kernel.org/
>
> v8 was 20 days ago. You replied to the review comments _today_ and then
> immediately posted v9. This is very frustrating, because corrections
> I suggested in the reply to v8 obviously can't be part of v9. Making v9
> pretty much useless. If you can't follow common sense rules of
> engagement with the community we will not merge any of your code.

I understand your frustration, and I apologize for posting v9 immediately
after replying to the v8 review comments.  My intention was to keep the
process moving forward, as new AI generated review comments are generated each time.
I had asked the same question in v7
(https://lore.kernel.org/netdev/20260129083339.264386-12-rkannoth@marvell.com/T/#m0681b88b55f80b0f58fc1e6e9be2220220111224).

But I see now that doing so prevented your latest suggestions from being incorporated and disrupted the expected
review workflow. That was not my intent. I appreciate the time and effort you put into reviewing the patches,
and I certainly do not want to undermine that process.

Going forward, I will wait for feedback after replying to review comments before posting a new version,
 to ensure that all suggested corrections are properly addressed. If there are additional changes you would like
included beyond what was already discussed, I am happy to incorporate them in the next revision.

Thank you again for the review and for your guidance on community expectations.

