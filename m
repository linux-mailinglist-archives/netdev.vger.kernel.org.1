Return-Path: <netdev+bounces-303923-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id AIezObvVRWqlFwsAu9opvQ
	(envelope-from <netdev+bounces-303923-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 05:06:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E45D6F3294
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 05:06:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=marvell.com header.s=pfpt0220 header.b=NP9vCBEQ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303923-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303923-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=marvell.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C71893008D47
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 03:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21A0A30FC34;
	Thu,  2 Jul 2026 03:06:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927C930FF05;
	Thu,  2 Jul 2026 03:06:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782961591; cv=none; b=SwH7OXT7HB+fp8NPBwO3LxZlP5206ksvkhJllKyng1/2eI8tUDzeYqCLtBLX0e2XdfcZ2EYtqUxS8qyvrthsNSjb3PQa1dDS+wKVyMN49zzoA+X5S17rl8wLPQJcbSb9SRonXvrnA59j8LR+ekjnXddYSmDdDx1Doi+HRdv7qUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782961591; c=relaxed/simple;
	bh=xt4qVwr6XDiIDaCb3cxs0+7HgAl5ToKSOwDrl9pM634=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cz8dSX6JqO3voZs3hamRQVdrTNGOUX11U2GqEgQghTJq6vf8X3Rv572Y2xgWNBcFliN7VzeMVW54fAlKZP21j5opPYCCIWyfCs6stC3hMCGA7q2vBv2ZgK5drIf/waNYLcVSEky4y4a4+pRc/aXaALt5OtRq83qHU6Qa+u+tY4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=NP9vCBEQ; arc=none smtp.client-ip=67.231.156.173
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6621MiMC601526;
	Wed, 1 Jul 2026 20:06:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=g1dQ29x48FzEtlZ3y+XQL8Cwa
	K8/EhOUuToe0Rt3J84=; b=NP9vCBEQuQs+ROp8y+xAtaSD1RwWjRXWouOIaj+aU
	PyTme9CAMeB5Ma00KVlQUcCaUQgflfpBgKlFWEAuskGeD8MH+Ng6I1k/uwmiJiFD
	QFHkp75xABlhaM0NHWTIc1Vj7Uzx0n+t7hYzrlylqoBtrfNiwpZQGqmWFz8Kka90
	zTJPCFkOKtoQBFqHtmKuQnqm3zf8hpsWvs/+bf3yShboAWfJkQKGVWB76BRU0ols
	1bKZqytFFiOuUzmpXGukSCZ9biXJ9XKwTtbeHrwE6ea2WFV4QrYSZv7TJZw1Znkd
	Eg6EEZg3g1ZTdkJz7FU7GJOYlbdkECBiT3LT69l1MSBWA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4f50g3kja4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jul 2026 20:06:22 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 1 Jul 2026 20:06:21 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 1 Jul 2026 20:06:21 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 5AAA23F7091;
	Wed,  1 Jul 2026 20:06:18 -0700 (PDT)
Date: Thu, 2 Jul 2026 08:36:17 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: David Ahern <dsahern@kernel.org>
CC: <stephen@networkplumber.org>, <kuba@kernel.org>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <andrew+netdev@lunn.ch>, <edumazet@google.com>, <pabeni@redhat.com>,
        <jiri@resnulli.us>
Subject: Re: [PATCH iproute2-next v3 2/2] devlink: support u64-array values
 in devlink param show/set
Message-ID: <akXVqVB4y4gN6Jbb@rkannoth-OptiPlex-7090>
References: <20260701031359.839221-1-rkannoth@marvell.com>
 <20260701031359.839221-3-rkannoth@marvell.com>
 <6c59d8f0-9a70-46d1-bf70-1e69c1869fb5@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6c59d8f0-9a70-46d1-bf70-1e69c1869fb5@kernel.org>
X-Authority-Analysis: v=2.4 cv=Gf4nWwXL c=1 sm=1 tr=0 ts=6a45d5ae cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=QXcCYyLzdtTjyudCfB6f:22 a=VwQbUJbxAAAA:8
 a=XH6R7allbje8br_4yIEA:9 a=CjuIK1q_8ugA:10 a=ZXulRonScM0A:10
 a=lhd_8Stf4_Oa5sg58ivl:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDAyOCBTYWx0ZWRfX65PonTim3yxC
 qkINdIEDV+o5a3NDdqnmqv1tG4vHKfwSsa8Ko8J2bcn4HRuLy2Mj9OTqmP4LILbEkw8xJ2vKX7u
 wY4LKH2w6bRRJqqwOwWegiIHt55sl+QYrnYNYNYlBU5eRIKTQD5CONzEmOdUXcW/sUElqrUVALE
 /MPrs0gRSo9eh3huvepbZz7K4pi+dnZGpu8Q1pi8NXfHBQxh+ig5VoknTS7NKzpaFLfaSTBNqtB
 I1gLDHCX/0DufSIUSxYHgSXwtgl2Iz1ihkEEOAb3CT22Dvc3Y7cxk92ngIJNWtLlDbJz84Hy6wS
 NEUexYbNRE3uEU7iO11p5t7X5qBJJQdGyz15YktfOwO23IaFSD4+NF3UJm4GmSnmLsrDfnvFnfy
 Xo8iZEF5W0550iD6GRkjBfaOal8GeMyNzBpHFkprrt3dcxQjlCICNSS6YnRq312HAN7KwY0GGZe
 7UQr72CNjN5oXCaerkA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDAyOCBTYWx0ZWRfX5F/PKibxwAU6
 WUEPrSwdN6bY1S1ZC3Q+a2UepwGwXv5q+4/Lc8IzvAhMPykWHQ68RvknAvjSkbSV/KB4JFn/+Fk
 4z2o/nKyAq1XnrWcVsh8N+J8kRl7XII=
X-Proofpoint-GUID: yj03Cwq_lelr9MLqabwK7RjWCfY_gcTn
X-Proofpoint-ORIG-GUID: yj03Cwq_lelr9MLqabwK7RjWCfY_gcTn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303923-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,rkannoth-OptiPlex-7090:mid,marvell.com:dkim,marvell.com:from_mime,vger.kernel.org:from_smtp];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7E45D6F3294

On 2026-07-02 at 05:23:33, David Ahern (dsahern@kernel.org) wrote:
> On 6/30/26 9:13 PM, Ratheesh Kannoth wrote:
> > Add support for DEVLINK_VAR_ATTR_TYPE_U64_ARRAY parameters that carry
> > multiple DEVLINK_ATTR_PARAM_VALUE_DATA attributes. Parse and display
> > u64 array values in param show, and accept space- or comma-separated
> > u64 values in devlink and port param set commands.
> >
> >   - Show search order
> >
> >   devlink dev param show pci/0002:01:00.0 name npc_srch_order
> >   pci/0002:01:00.0:
> >     name npc_srch_order type driver-specific
> >       values:
> >         cmode runtime value  value  0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31
>
> "value value"? Is that correct or a typo in the commit message?
>
> You are dumping it as a string which for json is wrong -- it should be
> an array.
>
Will address in v4.
pw-bot: changes-requested

