Return-Path: <netdev+bounces-254094-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sPi7E+yEeWnGxQEAu9opvQ
	(envelope-from <netdev+bounces-254094-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 04:39:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F649CC77
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 04:39:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E6B7D3013D4A
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 03:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A22D261B8C;
	Wed, 28 Jan 2026 03:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Id1LtZ6c"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D0361FFE;
	Wed, 28 Jan 2026 03:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769571516; cv=none; b=oc0CyHm76q0Qdwmvax7xnTiBN/Sk3jdIYUI8iMB9zlpYSmOJBqghSqCq9t+ioerb8LCjRsMAevVMR5x4E1PDVcOpj8W7oLQMHQxROqo1Kx6MKSfgiKAKTU5QPXJw1q7YjnM6cmX8eS8ZM2OtEqxBC673VFno4A9cIX682nNu/Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769571516; c=relaxed/simple;
	bh=x89dQJuBj6yhv/ec/9GW3UzUYTR7Aknsa67DHA6wCgg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m234wcoy+APK5nUKyXIsstL30ASV+SqdhuO6/QjoDUqV7OmgEE+5QliJypL2hYxHSD39RPhzf/MkjF6nXXYanDEzYFfRXcFIa0PWmLiPI0rybNuskjYUrZCcRetGRqvJNgb9IsFRe3Ampr06SpxzQl/LvDrerCRiPO6anwb3ups=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Id1LtZ6c; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60RDOkKm3054212;
	Tue, 27 Jan 2026 19:38:26 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=LMovnZ+0fPOAUFfocIOYHHNzq
	ce+woYDtg5FnSeZvqM=; b=Id1LtZ6cUqPEKdA+ILqPuH5EmWyUlPeNy/UtzRJB2
	fvdOSkb7DWrn228lW6GJ23UvZIJTnzykx3vwqfmEynavQ0nl23QJjZGKUz8hyUIc
	VaMhncOcKXsKVGzkTQMZDlN6BLr3GiPZLInqCOAs7Y+A8hbfaz4jHAzxHmPknCV7
	0TqKu0HVjTryR3COM6Yma6txrHjAfuoYLOrAp6w7qEP72kycgOz4X3+SV1z7GDNH
	GBGdLiIZPIeSpaF9kvJ9JW97pgMB2oii3i+KAgW5ZdyZHeVsixzir2L+0H9Xhc2g
	LRGd+uZVVtIHWlLTWKt5kqzpaGAwF7BvaFQwte1HCDl5g==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4bvxfjqhnp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Jan 2026 19:38:25 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 27 Jan 2026 19:38:25 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 27 Jan 2026 19:38:24 -0800
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 3E6FE3F70AD;
	Tue, 27 Jan 2026 19:38:21 -0800 (PST)
Date: Wed, 28 Jan 2026 09:08:20 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Jiri Pirko <jiri@resnulli.us>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>,
        "David S.
 Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>,
        Simon Horman <horms@kernel.org>,
        Donald Hunter
	<donald.hunter@gmail.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        "Matthieu
 Baerts (NGI0)" <matttbe@kernel.org>,
        Carolina Jubran <cjubran@nvidia.com>
Subject: Re: [PATCH net-next v2] devlink: Implement devlink param multi
 attribute nested data values
Message-ID: <aXmErN4xucEtMiEy@rkannoth-OptiPlex-7090>
References: <20260126023946.906893-1-rkannoth@marvell.com>
 <20260126171859.5097dfb5@kernel.org>
 <rsngz5ql5s54luv4mnjs733uogjjdxiylbbm4w4pcaefow45rm@memr4a27ycc2>
 <20260127100429.26dc5258@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260127100429.26dc5258@kernel.org>
X-Proofpoint-GUID: mifBJ2RZ5D6JfhmTanu7c_Uusr1ROu3n
X-Proofpoint-ORIG-GUID: mifBJ2RZ5D6JfhmTanu7c_Uusr1ROu3n
X-Authority-Analysis: v=2.4 cv=S9LUAYsP c=1 sm=1 tr=0 ts=697984b2 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=kj9zAlcOel0A:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=0CdMdCNyXBV3WdE3tmAA:9 a=CjuIK1q_8ugA:10
 a=lhd_8Stf4_Oa5sg58ivl:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI4MDAyNSBTYWx0ZWRfX0EniV+W+xf13
 rCdV8S6TTek+9m/OS2/Zal2OOEX13flRPCO7I1nzzp9Put9ssa7+1k5LbSnPJaDsBhIM5w2CWDC
 FxTJIS+rWXmhtfBjUbsgqxh3zYEbI0ojUD1w3EC7rnUwQt1oPNejYkHsDdBHBOg0FkeOKJpL939
 MGItyv7j5dd0xB/R3ppH3gH5tML5eo6a75aklrjORpjfEzoLTRUgk+17V0UHpzq1oPRoAfWggY+
 9RPNofQQ0o1r+B1S1jEqRc8VWw9nxAsqWzZh1rHnOhoAPS0f9SV1h9LCIgQtI6UlYG/3b7wyTYr
 W+81CRJ3XxZgd+xzEC+dkrXe8qNPJsU7yTebwCFDSNuY05us/DEdG0W3rADMG4ndjbbarCAQNBN
 /Hzan3LxhE748l5mi+tadMgSVRdYnysYJa3Bw5NuId5JEL8UbdN/MIom8cxGqifsWKNSTNbZqXL
 LujTc/otldHQn0LKWPg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_05,2026-01-27_03,2025-10-01_01
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254094-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,marvell.com:dkim];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[resnulli.us,vger.kernel.org,nvidia.com,davemloft.net,google.com,redhat.com,kernel.org,gmail.com,oracle.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: E3F649CC77
X-Rspamd-Action: no action

On 2026-01-27 at 23:34:29, Jakub Kicinski (kuba@kernel.org) wrote:
> On Tue, 27 Jan 2026 10:51:10 +0100 Jiri Pirko wrote:
> > Tue, Jan 27, 2026 at 02:18:59AM +0100, kuba@kernel.org wrote:
> > >On Mon, 26 Jan 2026 08:09:44 +0530 Ratheesh Kannoth wrote:
> > >> Devlink param value attribute is not defined since devlink is handling
> > >> the value validating and parsing internally, this allows us to implement
> > >> multi attribute values without breaking any policies.
> > >>
> > >> Devlink param multi-attribute values are considered to be dynamically
> > >> sized arrays of u32 values, by introducing a new devlink param type
> > >> DEVLINK_PARAM_TYPE_U32_ARRAY, driver and user space can set a variable
> > >> count of u32 values into the DEVLINK_ATTR_PARAM_VALUE_DATA attribute.
> > >>
> > >> Implement get/set parsing and add to the internal value structure passed
> > >> to drivers.
> > >>
> > >> This is useful for devices that need to configure a list of values for
> > >> a specific configuration.
> > >
> > >Could you respin this as a series with the first driver implementing
> > >a param of this type?  We can't merge an API without a user.
> >
> > I may be missed it, are you okay with cleanup helpers now (__free(kfree)
> > used here), or not yet? :)
>
> Of course not,
Will remove it. Thanks,

>I haven't looked at the patch at all.

