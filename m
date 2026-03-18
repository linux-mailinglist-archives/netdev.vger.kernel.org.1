Return-Path: <netdev+bounces-268857-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4NBtE5UOumn+QwIAu9opvQ
	(envelope-from <netdev+bounces-268857-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 03:31:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 994072B534B
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 03:31:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4C370304BDB7
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 02:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8343423DEB6;
	Wed, 18 Mar 2026 02:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="UAqkQOhx"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A301C3BF7;
	Wed, 18 Mar 2026 02:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773801106; cv=none; b=CTxR6PO4UIdag0IKoi1zfyIOlx4osppfapdO3uTSWhwdNotM6yt7vvZgnjZTn0ubvMt0jhPiTAeq2MOLTXMJaAG0MWv/Dy29G061H3mscdmUN9tUdma9W2EOjB3gMQXAU4+R33KwZZ4uSuj696tqgwnXgyivfvZ9XuQLtodIdP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773801106; c=relaxed/simple;
	bh=Oih3J8DcyQAXN3iGZPfZ/7Y/qiTmB4x0XDntv7YpajU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gVtofkNu6VHRtgVtECX2KLVqoQTXgRAJ6KKFWxOZZgKwH8bUc0uHx+XHNg8/rlr/mYTDcdxMn0+lhiAs1mEKb9cDibMihBa1BAuJSqUomGiNNTI3XwdCvhOsSQ/aUSw4YIP3aeKAU7a/DcxnaqnMHl81+w9QKTPynoE5RiFTvPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=UAqkQOhx; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62HM56Ue3742362;
	Tue, 17 Mar 2026 19:31:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=RwMOX/uGLS7RRC0m4+rPm6n89
	pz1rKbhJgjOiSaW0/0=; b=UAqkQOhx0NI280CSE/gD5gFZ0S3M1xNPVm8v/6lGu
	+RxHKuHbm/QpMKdGuur51PbLeRRrdCLq2GhP1WFHdLcfZLs6uZHfWGIii2x3041R
	KAX8AQ4k6oIC36BZppHyigB7CsXGzt4a4nIR/LTjFQSviLHaN64RbunCAOHYZ23O
	QZVo0BOY52Mbk8gBvsb6aJzht60i6aaIjXycQ8y35Y5ozgbkUafcbLeXSjyZvRKQ
	2WqIzsMrMGh0tfL3f6FqXjbwolQUzfppG2Eslq/aHtg06Qr3FIn8oJPtSpvqgKF/
	e9UNgIR7o8hfLnmZA//dJHlEvmGhrEEllnNwQLezQOO5g==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4cx02r72nh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Mar 2026 19:31:18 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 17 Mar 2026 19:31:18 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 17 Mar 2026 19:31:18 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 828625B695A;
	Tue, 17 Mar 2026 19:31:13 -0700 (PDT)
Date: Wed, 18 Mar 2026 08:01:12 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: Jiri Pirko <jiri@resnulli.us>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
        <donald.hunter@gmail.com>, <chuck.lever@oracle.com>,
        <matttbe@kernel.org>, <cjubran@nvidia.com>, <shshitrit@nvidia.com>,
        Saeed Mahameed
	<saeedm@nvidia.com>
Subject: Re: [PATCH v4 net-next 2/5] devlink: Implement devlink param multi
 attribute nested data values
Message-ID: <aboOcPaBsu0NWxF-@rkannoth-OptiPlex-7090>
References: <20260312022754.2029595-1-rkannoth@marvell.com>
 <20260312022754.2029595-3-rkannoth@marvell.com>
 <f3l4lzzumqlkluikqv2a3fopzotgjnoadnbzqoc3wllgew62zy@jj2jaseglkop>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <f3l4lzzumqlkluikqv2a3fopzotgjnoadnbzqoc3wllgew62zy@jj2jaseglkop>
X-Proofpoint-ORIG-GUID: uhZOlaNrpEYej3mgA-lJJMA7Znm02cyq
X-Proofpoint-GUID: uhZOlaNrpEYej3mgA-lJJMA7Znm02cyq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE4MDAxOSBTYWx0ZWRfX40GP5C472eYO
 lSaUigoy9rMVVeGWuN0Xc1fzE8bN7VHAZLmyIWNcD5wg9AMo/ry1RvOPjNXRBrogPD5e5UlTQPj
 FdNk0mXhUVO6VPQHWlyW9SaZViYBzgsSBlv2xbV4NddRqXQj4VJlbaG6sVmc+FsqssFfxRgcwj+
 WwdHEud0tLVZUNa2J9RPPRTVX1PRUqmFmusBBECLFP38iOVeFtfMaC9VILnvZ/1m5tang7iDf9y
 krM62FaakKrsyWML08zPeVNmSnoiXqipzaiWYPVwxmhto1b/4KyCctbzbe9kKZ3WqtAya0zfmQc
 EsD6DyepmaFphUfV8qKw4egNjDHuVNM/nfiKKE/rHHTXsZkh+mflD/cjkPF4UnGBOVlAc5c7GSj
 v6qOyT11wdR2pz8vjXld/x/GRwFj2nZMqj8ite6i1yAVLlslrDMKFbZ91zCy0zmy/BqfgurPCf+
 i9VGNu+d/giA0gIa45g==
X-Authority-Analysis: v=2.4 cv=RvvI7SmK c=1 sm=1 tr=0 ts=69ba0e76 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=QXcCYyLzdtTjyudCfB6f:22 a=MzIZnlZOCKTN407RhG0A:9
 a=CjuIK1q_8ugA:10 a=RavaEpZ441rkxBNZXile:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_05,2026-03-17_02,2025-10-01_01
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
	TAGGED_FROM(0.00)[bounces-268857-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[vger.kernel.org,marvell.com,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,oracle.com,nvidia.com];
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
X-Rspamd-Queue-Id: 994072B534B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026-03-17 at 18:52:32, Jiri Pirko (jiri@resnulli.us) wrote:
> >+	case DEVLINK_PARAM_TYPE_U32_ARRAY:
> >+		cnt = 0;
> >+		nla_for_each_attr_type(param_data,
> >+				       DEVLINK_ATTR_PARAM_VALUE_DATA,
> >+				       genlmsg_data(info->genlhdr),
> >+				       genlmsg_len(info->genlhdr), rem) {
> >+			if (cnt >= __DEVLINK_PARAM_MAX_ARRAY_SIZE)
> >+				return -EMSGSIZE;
> >+
> >+			if (nla_len(param_data) != sizeof(u32))
> >+				return -EINVAL;
> >+
> >+			value->u32arr.val[cnt] = nla_get_u32(param_data);
>
> Now that we have UINT to be used everywhere for new netlink attributes,
> wouldn't it make sense to have rather UINT array?
We have U8, U16, U32, U64 param types in devlink. So declared as u32 array.
Let me know if you feel strongly about your opinion, will respin

enum devlink_param_type {
        DEVLINK_PARAM_TYPE_U8 = DEVLINK_VAR_ATTR_TYPE_U8,
        DEVLINK_PARAM_TYPE_U16 = DEVLINK_VAR_ATTR_TYPE_U16,
        DEVLINK_PARAM_TYPE_U32 = DEVLINK_VAR_ATTR_TYPE_U32,
        DEVLINK_PARAM_TYPE_U64 = DEVLINK_VAR_ATTR_TYPE_U64,
        DEVLINK_PARAM_TYPE_STRING = DEVLINK_VAR_ATTR_TYPE_STRING,
        DEVLINK_PARAM_TYPE_BOOL = DEVLINK_VAR_ATTR_TYPE_FLAG,
        DEVLINK_PARAM_TYPE_U32_ARRAY = DEVLINK_VAR_ATTR_TYPE_U32_ARRAY,
};

