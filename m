Return-Path: <netdev+bounces-303446-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jU0UJSiCRGoRwAoAu9opvQ
	(envelope-from <netdev+bounces-303446-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 04:57:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D29156E9551
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 04:57:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=marvell.com header.s=pfpt0220 header.b=ErNFT0Ge;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303446-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-303446-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=marvell.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8772F3016538
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 02:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7A533655CE;
	Wed,  1 Jul 2026 02:57:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A70223F40D;
	Wed,  1 Jul 2026 02:57:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782874661; cv=none; b=ooRNtJAQuxKUgieu51BsJ62PcjIOUtqK1VpQNFfhCx3RyvkjwwmXPavQdEG7dV+3vLhQQXuaBZSN3WK5EwiBLJlrEyxhy/OeUo6/XLwgY8XZmHpbhlZ1nfo0MtCX+hPGq1Kg8Mqj45rZGfZ3OB3IuSrBbbXrq36ynB9lwoh2q9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782874661; c=relaxed/simple;
	bh=cpjpEsTr5/ImWPHa8mM8mnQKftX2ybBjHIwWPf+wwQ8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S8iyBz1bdCL3L08QxTroHRF2Esf+/3+ZSCPb0g/uOztI9Ts5U3abr4rjQZh6iH6qhiRGrCqQL6cc6WUXqm5sPdr9hB31oJC+bJZfjlaWSa3FQ4YwHYro73yYfvwsQmzWF+Hsme37yO/zNt+Me93UF2EXUpbdNdTDbtNkngyUEHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=ErNFT0Ge; arc=none smtp.client-ip=67.231.148.174
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6612vTTq2207264;
	Tue, 30 Jun 2026 19:57:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=02C/nTbg6ij+BYQ3LQL7mddlx
	MN9zaXFiifyQPyd+CE=; b=ErNFT0Gewtj1FIwGIBGpEfdLdx9R5YCps8C4eiGH9
	0EKgpwf72asSI8uZyirzuWJlxEPLndvxla5S31QdALRhyHVlal2YK01PkCZc3tQd
	IctMyTtbutMPLVHiwtFI641TpYYqbnMV5+rdW1I75rWXAbUuQi2Fd43SoJRqh+ws
	u4Pq6hCXsnaao2FAUvUzgnccqKx1M2Tu9vKnYWPQT+W90bQb2Mve5g7x3cJSMEU7
	OR5Tru5nqO3Fz0yLGgM9czZIknRC1Iy7ZxbPZsYaWADuFd9yHdhqVN+8y6Lr/w6D
	MtUiIc476qWZ0d9OHK425Wv5CCkmkHdUE4HAL4JigPhVA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4f4cty39n3-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jun 2026 19:57:29 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 30 Jun 2026 19:57:12 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 30 Jun 2026 19:57:12 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id CB5EC3F7059;
	Tue, 30 Jun 2026 19:57:09 -0700 (PDT)
Date: Wed, 1 Jul 2026 08:27:08 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: David Ahern <dsahern@kernel.org>
CC: <stephen@networkplumber.org>, <kuba@kernel.org>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <andrew+netdev@lunn.ch>, <edumazet@google.com>, <pabeni@redhat.com>,
        <jiri@resnulli.us>
Subject: Re: [PATCH iproute2-next v2 2/2] devlink: support u64-array values
 in devlink param show/set
Message-ID: <akSCBN0N_7ug1-Fy@rkannoth-OptiPlex-7090>
References: <20260630015012.3728870-1-rkannoth@marvell.com>
 <20260630015012.3728870-3-rkannoth@marvell.com>
 <9d9cceae-3934-4dd6-ae8e-af995ae6b0ab@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <9d9cceae-3934-4dd6-ae8e-af995ae6b0ab@kernel.org>
X-Authority-Analysis: v=2.4 cv=etnvCIpX c=1 sm=1 tr=0 ts=6a448219 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=EAYMVhzMl8SCOHhVQcBL:22 a=VwQbUJbxAAAA:8
 a=hQjjm9jiOj-fDen75moA:9 a=CjuIK1q_8ugA:10 a=lhd_8Stf4_Oa5sg58ivl:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDAyOSBTYWx0ZWRfX7Q+xU2sRA1SA
 qGG3MPaOuEALueATh3caFV6xsYaggoMu1lRCkucqvfHhDzXdNEqI2b7yp158PV4pbf0Wnq2zRoh
 +I+NUXSqwk51/icqtq2+e9YQq5RmZh0=
X-Proofpoint-GUID: lPZwJLpwV6fXWgjvgdY_100PlrXg9JLs
X-Proofpoint-ORIG-GUID: lPZwJLpwV6fXWgjvgdY_100PlrXg9JLs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDAyOSBTYWx0ZWRfXxkvP7zoKa2o2
 MHszBCe4J/VGl6f4jhpB8ftiM8JroPJfv0UBbpdNQhwuMGqLmb5uxhxaJbmq/JEZT2uWX+8a4//
 vyaDSg5E6Xy97AXRYUgRi2nEqxGUOBzeGEzTFXgbxvq5enmUuo/SakL1y0MD01pZORWyOzdhS8K
 plQGVikYkkrKU1o347G6SZt9EdGXKC0wo51EzxwPLRk/IXILJ0wY3X236jBOoNtTKYeQtEjWHIg
 n3juygLjvLaK3TPdK4+6s2KCVs7S9dz+xAm9CaFjmP8TXXevWLSkncrTYYo7HNZ95CXtQMCRSSd
 IWAjsV5asEH483Kor4CPbLrR6z+te9BMxeZd5yAfcsVgttU1ckkTgETHCOyaZCsOWGM3U7He9bB
 iAbi3RR7BlrGtH4JpsoCPhFq1UWNFNfsmtxzBo/E9GmeBaT+JNs+cTR98oy7M2td2skUX3xcbfX
 SaY4Zd+TV1FL2AlT+xg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_01,2026-06-26_01,2025-10-01_01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303446-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[marvell.com:dkim,marvell.com:from_mime,rkannoth-OptiPlex-7090:mid,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	FORGED_SENDER(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:dsahern@kernel.org,m:stephen@networkplumber.org,m:kuba@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:edumazet@google.com,m:pabeni@redhat.com,m:jiri@resnulli.us,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D29156E9551

On 2026-06-30 at 20:06:17, David Ahern (dsahern@kernel.org) wrote:
> On 6/29/26 7:50 PM, Ratheesh Kannoth wrote:
> > --- a/devlink/devlink.c
> > +++ b/devlink/devlink.c
> > +{
> > +	struct devlink_param_u64_array new_arr = {};
> > +	char *copy, *token, *saveptr = NULL;
> > +	char delim[] = " ,";
> > +	uint64_t val;
> > +	int err;
> > +
> > +	copy = strdup(param_value);
> > +	if (!copy)
> > +		return -ENOMEM;
> > +
> > +	token = strtok_r(copy, delim, &saveptr);
> > +	while (token) {
> > +		if (new_arr.size >= DEVLINK_PARAM_MAX_ARRAY_SIZE) {
> > +			free(copy);
> > +			pr_err("Too many array elements (max %d)\n",
> > +			       DEVLINK_PARAM_MAX_ARRAY_SIZE);
> > +			return -EINVAL;
> > +		}
> > +		err = get_u64((__u64 *)&val, token, 10);
> > +		if (err) {
> > +			free(copy);
> > +			pr_err("Value \"%s\" is not a number or not within range\n",
> > +			       token);
> > +			return err;
> > +		}
> > +		new_arr.val[new_arr.size++] = val;
> > +		token = strtok_r(NULL, delim, &saveptr);
> > +	}
> > +	free(copy);
> > +
> > +	if (cur && param_value_u64_array_equal(&new_arr, cur))
> > +		return 1;
> > +
> > +	for (uint64_t i = 0; i < new_arr.size; i++)
> > +		mnl_attr_put_u64(nlh, DEVLINK_ATTR_PARAM_VALUE_DATA, new_arr.val[i]);
>
> Why can't this put be done in the loop above as the string is processed?

We need to complete parsing first to check if the new array is identical to the current one
(param_value_u64_array_equal()). If they match, the function returns early without populating
the Netlink attributes. This follows the coding std used for other data types in devlink.

