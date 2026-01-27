Return-Path: <netdev+bounces-253696-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aO5NH/E6eGnZowEAu9opvQ
	(envelope-from <netdev+bounces-253696-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 05:11:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DF00A8FCF1
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 05:11:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DC1373014114
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 04:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5204431B10D;
	Tue, 27 Jan 2026 04:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="EBFvhUJQ"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC0E2745C;
	Tue, 27 Jan 2026 04:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769487081; cv=none; b=UPylaBr/6zAaJM1ipuYj0cqjkZW5YxGz/1GuRPxjZho0/ORX5R/Tuo/w8wS35OOdWeBAGDlZZyCKJHAWkb/PlCkkN9YNxqjdN+dA4P86G8977fc9Zi8FE587Iv3PA+lhhnhHL9Dximc9ZpdxPdRykiRY9wk7wvadHUMmu7GNnH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769487081; c=relaxed/simple;
	bh=VKuVDvA6tgKu+1kYZozi86OZbLedbs3Cw5Id7U851Fo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UdxkC3VIv2eq0ZTpQS2cfI5LyjJs1DM43rDK9ijXasCBUZpZECkdq4n1YqRBpvNXUjH7Yi34EdFEFLAYX/yXEbADxw9xrMMDgQLKRHCBjTbTX5bvyTsZqWxXPE6FD5GVcsRj/x6IhZm1JDcOrBA6EWPp/wU5RcqE4YE0Mk8XOVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=EBFvhUJQ; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60QNVRF3358942;
	Mon, 26 Jan 2026 20:10:58 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=JRiPwOWGV6LL7A4cyE27avyQV
	bftGgeBdi5FTU5TnLA=; b=EBFvhUJQtQYSxamoXsfzQ6y1lNj0WwpO0qT9PRk9P
	7qVgnJGhMYkJ0/Dg70gjqtgbN7cI76e71HMq8PJ2CzFqu9QpgGKPteXrqc3vcT16
	LQdq5UjcC81EsVZr9iXS/aMkVy3F+HHR3SpDJquEEMWTvce6Pa6AajhyGjYJpxYe
	2MViHLzuWHJ944yO17iMeAQ//7jXW+67X50n9p5hwmBCeSnv/oaBtf1RgW14UM2b
	n1Xfgs796b0cHfAKupU7RodFJWsYXLzYU0tnRG92Nve9SBVBYp6dkKD+jIjhfzDz
	rZ5XbmJfT696Fd5OW1B69BGomCok2zle1+m18/mkW4mgg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4bxj128ekj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Jan 2026 20:10:58 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 26 Jan 2026 20:11:12 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 26 Jan 2026 20:11:12 -0800
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 70DEF3F70A2;
	Mon, 26 Jan 2026 20:10:53 -0800 (PST)
Date: Tue, 27 Jan 2026 09:40:52 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Saeed Mahameed
	<saeedm@nvidia.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet
	<edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
        Simon Horman
	<horms@kernel.org>,
        Donald Hunter <donald.hunter@gmail.com>,
        Jiri Pirko
	<jiri@resnulli.us>, Chuck Lever <chuck.lever@oracle.com>,
        "Matthieu Baerts
 (NGI0)" <matttbe@kernel.org>,
        Carolina Jubran <cjubran@nvidia.com>
Subject: Re: [PATCH net-next v2] devlink: Implement devlink param multi
 attribute nested data values
Message-ID: <aXg6zLA6Wg6nHi_R@rkannoth-OptiPlex-7090>
References: <20260126023946.906893-1-rkannoth@marvell.com>
 <20260126171859.5097dfb5@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260126171859.5097dfb5@kernel.org>
X-Proofpoint-ORIG-GUID: qCkleji_c2YLqumLfxfnQzUXKUcCpaQI
X-Authority-Analysis: v=2.4 cv=WNByn3sR c=1 sm=1 tr=0 ts=69783ad2 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=kj9zAlcOel0A:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=mxaWZ58vQuy8MOE3FFIA:9 a=CjuIK1q_8ugA:10
 a=lhd_8Stf4_Oa5sg58ivl:22
X-Proofpoint-GUID: qCkleji_c2YLqumLfxfnQzUXKUcCpaQI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDAzMSBTYWx0ZWRfX3OzLZ0fhZJJW
 D2+cGQ1QUT0AAUCM4NJqcrGFSjR3ChxP94Brc01lZXJBHrIenvtRgt9Y+rTFYPTUefp5Zd3X30b
 ZJJ+FWw2W4MCnMUWIlxMtH7hUw/l+aSqFdM28JgnfGVJ+PCXWOZD9uvtEZkl9/scyYRcTiDmccw
 4Sgd1Pj5r/KKKjNSxlZkE7aykgsaIh4FOpou1dS5al0b0Uu9bZ8XtWRnnkZ86nnKDDz9cT5OTHg
 FkJ80fdv9w5q5lwfxkfos45BITohaIagXe48rHcc1f3coMqGuy+eLZmKcnmIwWYhRT06ZlIUmk+
 HHKaWxgfBOgI499KXpaebOdHnrFCS/6MPfE3kpE+2p7nUsYRCXD0OC41VBB5M1XGMIO3oylBjpj
 doBrkRzYbIyVe4yGZMRNMCURcnGSUAO8ekEU4MIRzY4Bl9ocDJZzZihOi9REkpS9+2rfjKZq1YT
 TpdmbTcCxbxFe9NMcug==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-27_01,2026-01-26_01,2025-10-01_01
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
	TAGGED_FROM(0.00)[bounces-253696-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[vger.kernel.org,nvidia.com,davemloft.net,google.com,redhat.com,kernel.org,gmail.com,resnulli.us,oracle.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[marvell.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: DF00A8FCF1
X-Rspamd-Action: no action

On 2026-01-27 at 06:48:59, Jakub Kicinski (kuba@kernel.org) wrote:
> On Mon, 26 Jan 2026 08:09:44 +0530 Ratheesh Kannoth wrote:
> > Devlink param value attribute is not defined since devlink is handling
> > the value validating and parsing internally, this allows us to implement
> > multi attribute values without breaking any policies.
> >
> > Devlink param multi-attribute values are considered to be dynamically
> > sized arrays of u32 values, by introducing a new devlink param type
> > DEVLINK_PARAM_TYPE_U32_ARRAY, driver and user space can set a variable
> > count of u32 values into the DEVLINK_ATTR_PARAM_VALUE_DATA attribute.
> >
> > Implement get/set parsing and add to the internal value structure passed
> > to drivers.
> >
> > This is useful for devices that need to configure a list of values for
> > a specific configuration.
>
> Could you respin this as a series with the first driver implementing
> a param of this type?  We can't merge an API without a user.
ACK. will make it part of https://patchwork.kernel.org/project/netdevbpf/list/?series=1047093 as
APIs needed by devlink are in this patch.
> --
> pw-bot: cr

