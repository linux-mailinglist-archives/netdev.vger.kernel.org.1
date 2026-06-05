Return-Path: <netdev+bounces-295707-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id V8dTNlx/ImpaYwEAu9opvQ
	(envelope-from <netdev+bounces-295707-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 09:48:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D56D6461E9
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 09:48:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=marvell.com header.s=pfpt0220 header.b=cVgw+qGB;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295707-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295707-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=marvell.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E85AE3030E90
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 07:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E092A47D931;
	Fri,  5 Jun 2026 07:38:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 341C847CC7C;
	Fri,  5 Jun 2026 07:38:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780645139; cv=none; b=GEi6x+uLHQ+gjAZ+XRA6Jrgtq/2gW0LrjiOLb9EACrF3C58F7or4KttQIMmCzr4DqB8wlt6B+UsyxOHu/4SN3bbvVmFBIfBWsdbL3hCRvHRvcfYDcr3I4/0hJk0sYcYf0qV6SuO+P5fa4R6mJjKbgvUGWtJXR85VR0fcbYwfSNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780645139; c=relaxed/simple;
	bh=CYz+zFVmVunjZ0IJwS7O81HYQNxtf78UxYVYME/3fSM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HQ+5N+sHko17VSK3mfRF1rJKah2DHd/h/53v0i+IifYMCGk4pmk2/uLzYc8OFM7sZdFPF3SlF31Z5LmR5knnp4AeQISAmRU5JmLSNBUGxBxG2fF23MY5V0JgIMlQT5rpPr2+EvhY2DfFSd/6J5WRY2Yd7SUH7ENBYRQoI1NgvW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=cVgw+qGB; arc=none smtp.client-ip=67.231.148.174
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 654LQMKU3892390;
	Fri, 5 Jun 2026 00:38:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=CYz+zFVmVunjZ0IJwS7O81HYQ
	Nxtf78UxYVYME/3fSM=; b=cVgw+qGBOR/YReuyTMCA+gQG7njndVARRVsxejek6
	jOHc4hnel9DSazg4apXe0dWbusiXp/yBP5NAdHi4nqmepKlFvChIULgBBn0re0v4
	0ByYF/KSyWM7vyKn4aDJ4BRmGGlK4cVnG3PRG+ev0P5EPIsKFf7nxVEjTdHPS5HG
	/lO9fsa+10qFzdj8bcmFHi7l82GfshlvnB7ihJukPnzYUcygylRd01qLRl33L7Md
	SIM7zjt8EuKlDBFmjhRx+3zhBzz6tskzdqkS+hkaTSK4sxM28qMkpRPj1WCnCouu
	r6zZ3gh4kqqojEl5+1ElQ5pb7n8jNV0abJn3FLy5FTh4w==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4ekh8x9h2y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Jun 2026 00:38:46 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 5 Jun 2026 00:38:45 -0700
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 5 Jun 2026 00:38:44 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Fri, 5 Jun 2026 00:38:44 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 9891A3F7074;
	Fri,  5 Jun 2026 00:38:40 -0700 (PDT)
Date: Fri, 5 Jun 2026 13:08:39 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <donald.hunter@gmail.com>,
        <edumazet@google.com>, <horms@kernel.org>, <jiri@resnulli.us>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>
Subject: Re: [PATCH v19 net-next 0/9] octeontx2-af: npc: Enhancements.
Message-ID: <aiJ8_-hd459l8Qea@rkannoth-OptiPlex-7090>
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
X-Proofpoint-ORIG-GUID: _EKqDtP6hzgr3QSqqqZBDXajRjZlJplE
X-Authority-Analysis: v=2.4 cv=DqNmPm/+ c=1 sm=1 tr=0 ts=6a227d06 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=EAYMVhzMl8SCOHhVQcBL:22 a=M5GUcnROAAAA:8
 a=7kmLdAY-aSTHbD8AGr4A:9 a=CjuIK1q_8ugA:10 a=ZXulRonScM0A:10
 a=OBjm3rFKGHvpk9ecZwUJ:22 a=Oh551-UHZqmTy8JkqTUo:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA1MDA3MiBTYWx0ZWRfX46103NKPTaSe
 natG0Jf/86sHbF8/WEp7P3GdRuoDM9Dx/JgC3nvf764iyqOiDqpWdH6LJLs09tgYBq2x0h4iqeq
 +TEHWPOBKpbCeVM5693jhDjRBrVZL0Fsm/ApluSmHx+HMh2DrVnrjqBwKIdk74h3SmqiUkj9Rdo
 gJAdAwYUNXqIpx0g1vBCn1rbZ71cOBdS7vs6M6QGKYZdIvmatZqEzy9CCel2nPKCwoHbsf2Tvoh
 7ABkdVddTgJhE8+Id6Vc/Ad9GTDRK1Ikl2VOUZp7kFEORuJ6Y0zmE+NbDTUOzUr0V5TRk4o02ps
 zIy3tbgm+aYmbcDvN699lxTrLJukS7ODppCa0S2LhEsQBcaXyjyADfGME5oj9yF8S7m4uhyluy+
 +3GUimTewqJj0QLO4FaaluMBAKTeHkl8koPL344zhK6o45P5YJqJZtw15nxeOGI+oESn8JN2pmv
 i599JbRApoB07DTfrYw==
X-Proofpoint-GUID: _EKqDtP6hzgr3QSqqqZBDXajRjZlJplE
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
	TAGGED_FROM(0.00)[bounces-295707-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 3D56D6461E9

On 2026-06-05 at 09:20:20, Ratheesh Kannoth (rkannoth@marvell.com) wrote:
> This series extends Marvell octeontx2-af support for CN20K NPC (MCAM
> debuggability, allocation policy, default-rule lifetime, optional KPU
> profiles from firmware files, X2/X4 MCAM keyword handling in flows and
> defaults, and dynamic CN20K NPC private state), adds a devlink mechanism
> for multi-value parameters, and moves devlink_nl_param_fill() temporaries
> to the heap so stack usage stays reasonable once union devlink_param_value
> grows (patch 3).
>A

Apologies. Mavell SMTP server had many issues which resulted delaying,requeing, resending
emails. Sorry for the noise. Please abandon this set as another patch (same patch) is
active.
pw-bot: changes-requested

