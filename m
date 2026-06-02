Return-Path: <netdev+bounces-293997-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QLBsJedRHmpqigkAu9opvQ
	(envelope-from <netdev+bounces-293997-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 05:45:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 12D0D627DE8
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 05:45:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 820B7302C156
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 03:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11AFF3382DE;
	Tue,  2 Jun 2026 03:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="aehxblWR"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C240433A711;
	Tue,  2 Jun 2026 03:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780371903; cv=none; b=VjgXlX/AGPSkmCCzLyb14kf+05JsEZ/rgSjcJ2x/WmVfw+f4mTeFpcRk5oPEjXHTzx8EZKjB+Wi7oZcqAnB3P7+Y/+IX7IUDkYzzwsPXLhtbE3JTpivZO9dFVbGvxmsx2NpEAfQdgzK1opLIGOUawIFr0CYI48pNef2m+7k6qmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780371903; c=relaxed/simple;
	bh=HwpN8nGPHa9vZKd4QTPNieJp5izSBqN3t0ZCSo0JzM4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AzrnP9ngA43W1BwfyZbnY64oNHil8SKQDflAA4PTH5HiwKmh1maqsy3g/x094KyPFeWzoQIPL74j+vb+hrul+K+4Kdfovr7zjOBe6sFQ24jWlXyt5EyRMmbNvJGNtoa6BuyfQYowGzUbxH08WOQwEFKuma4SYWRFJKuRCFtpXt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=aehxblWR; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 651KS6Eo1231225;
	Mon, 1 Jun 2026 20:44:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=PuUJc8Sm0SYzpkmzrkULbTtEZ
	d2zM483fQ4/qp8SBH4=; b=aehxblWRq6qxMyBmV8RmqUZ8FCf0B0vY9yH8H8PPw
	0mAHN2Q0GsuJQDk1il7YLkHXD8SGYQi/rvWz+zxLMKnw8Rr0T8lNWtPD3buYaMtr
	E8U+KOwpss5cnBu2QW4u5CHwvBCaEu0fvM6WhtMcFJH8vEI2ceIHGp0Dv6Tyqwt+
	0eu/sbODkIK4cTjiKKCyfXwoxRbb+A7ast+bHfJ+ZVsLecEET1IUWmPuosfQL/je
	KaEUJ63QSERrAIKQ0c/mc9yMDTOSmUqj7Z+/Qk3+hlpgmi9VzGY61a9y5v9Xzzhu
	aPQrDLqYif4UNZZscws6ajrH+T/FsXbdldLj0mlVTEEoA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4ega3b6xbq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jun 2026 20:44:38 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 1 Jun 2026 20:44:37 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 1 Jun 2026 20:44:37 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id E820A3F7062;
	Mon,  1 Jun 2026 20:44:33 -0700 (PDT)
Date: Tue, 2 Jun 2026 09:14:32 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <donald.hunter@gmail.com>,
        <edumazet@google.com>, <horms@kernel.org>, <jiri@resnulli.us>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>,
        "Saeed
 Mahameed" <saeedm@nvidia.com>
Subject: Re: [PATCH v17 net-next 3/8] devlink: Implement devlink param multi
 attribute nested data values
Message-ID: <ah5RoH1QwQhTjATn@rkannoth-OptiPlex-7090>
References: <20260601025844.865865-1-rkannoth@marvell.com>
 <20260601025844.865865-4-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260601025844.865865-4-rkannoth@marvell.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDAzMCBTYWx0ZWRfX5zzLhNaY8emk
 D0faT4BjeJGwZ2eFfBb9ixFOmdimgK5xVykoV3LVAu4zApxS2/BPwC+FuZ27CrLoF56OgfhHVe8
 E8Jkb37fb0Hzu4La+VgDc81WJi/8JZovuGuai8lEkZ8OJ54gVwOA5ZoYuBBDMkmN72WNiB1CzYd
 SQ8I5tyeUOx2NzlCSdpohGch5sKi0YsZJgJYBzVnkAvfFOl1Ayv4sJr3JnQdhMqIs/TeGZzZPGR
 PpsfvU7C2sYkWKGqJZEZpuAyZ8aXY4jvXo9so97NTSc5K81q0UYV1OiLY9EHDH/eKuqSEI9H+d9
 zWYCW09MvWAmyXDWDYGOKegzh0XQyRWe39SUctLY05TRf4m0Zcu+aW26c4t5r6VXwRfAlCcOvvQ
 RoD3rR6w5kMi78LZEB/6ogeW00Zstw9Or8vkw8n/DXQleQpG4IgibGOjXpHOwvbRcX9zNoJa+Fd
 NGBXnLYGnzQWDRXJahg==
X-Authority-Analysis: v=2.4 cv=cLjQdFeN c=1 sm=1 tr=0 ts=6a1e51a6 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8
 a=Ikd4Dj_1AAAA:8 a=WgJX6ROffo85cpo7s7MA:9 a=CjuIK1q_8ugA:10 a=ZXulRonScM0A:10
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: 7psVBpbBLPaxDa25zjezEvbOJ_d_-7-P
X-Proofpoint-GUID: 7psVBpbBLPaxDa25zjezEvbOJ_d_-7-P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_07,2026-05-28_03,2025-10-01_01
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293997-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,gmail.com,google.com,kernel.org,resnulli.us,redhat.com,marvell.com,nvidia.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nvidia.com:email,marvell.com:email,marvell.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 12D0D627DE8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026-06-01 at 08:28:38, Ratheesh Kannoth (rkannoth@marvell.com) wrote:
> From: Saeed Mahameed <saeedm@nvidia.com>
>

> +	case DEVLINK_PARAM_TYPE_U64_ARRAY:
>> +		if (val->u64arr.size >= __DEVLINK_PARAM_MAX_ARRAY_SIZE)
>Does this code reject an array that is exactly __DEVLINK_PARAM_MAX_ARRAY_SIZE
>elements long?

ACK.
pw-bot: changes-requested

