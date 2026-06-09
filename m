Return-Path: <netdev+bounces-296841-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vMhaDC9wJ2oEwwIAu9opvQ
	(envelope-from <netdev+bounces-296841-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 03:45:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A702E65BBC1
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 03:45:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=marvell.com header.s=pfpt0220 header.b=SKQw2D0t;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296841-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-296841-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=marvell.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 992223042919
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 01:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBED33438B3;
	Tue,  9 Jun 2026 01:44:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B399267B05;
	Tue,  9 Jun 2026 01:44:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780969453; cv=none; b=L4oIKEv+iYotG3yyFcf8XsGNgYanSlA37SP4v65c7yzofngvIMJsh7u8zu8gXyZMCs0KDwsslsXVG5qYKIMT9qXoRlDA1hN3mOH3dwglc7BN7ydtvVebUAdZVpL3ycf9AGFSHZe2DX7axUZs87qUOJCF+XVe1ZeROstNRZgyvZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780969453; c=relaxed/simple;
	bh=3WOUdQwQCaIlnq9y17oObsxGCLtwdiQv0gBbN0Iom3M=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PPN073Eyf4KOaIp9V9R3CMShNP56zGVVca2w2gJrt1X7stao6tL8KtaC8850SzxM+hTLZOKTyC1EKf7MAIhIkaRopsVB/5R/Gy77ZLVabvzFuC9npLz4Bwkt0zVoFkJocSCbQOC0sIqu4t+ceIVqY2f9SdNc5djoJJ2nwGRRxZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=SKQw2D0t; arc=none smtp.client-ip=67.231.148.174
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6590vUMp3620892;
	Mon, 8 Jun 2026 18:43:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=1
	9K4H9PbJeBE30bUkSmfqy95WxxAUQcF65lE5ZMinCY=; b=SKQw2D0t24q/iRW8U
	+dCRpnVmaTun90xl2MOnEqPh7jQ53nIrRhx+0J+2qwjljqp03JXh70SCU71Oj/ty
	TER1LpLng/2FmtifeXsMPhW2EIZDaIfCAeza5GGUi28V5GZkIDVpdi/yHaIhDZnH
	xkzkB8dzZ8ACucL7Fx4FdfJ+pVo0tOtljhtEI4M+PHxQpgcQvbPtXiFOh+/uvMkI
	Y8RPzcgRJG29T0XfM4P23pECNX06cjBCDPgpB5K6MQSYJpeehbLC+NWSFsgMAA9H
	Oep8A0gkfteMgYrRoTwS+tSB9UezfKKK2QxSUiyBt/DWW9GW6x3BpDZr1zsdP3LA
	P73AA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4en7t8xjg9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jun 2026 18:43:45 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 8 Jun 2026 18:43:44 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 8 Jun 2026 18:43:44 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id B025A3F7043;
	Mon,  8 Jun 2026 18:43:41 -0700 (PDT)
Date: Tue, 9 Jun 2026 07:13:40 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
        <donald.hunter@gmail.com>, <edumazet@google.com>, <horms@kernel.org>,
        <jiri@resnulli.us>, <pabeni@redhat.com>, <sgoutham@marvell.com>
Subject: Re: [PATCH v19 net-next 1/9] octeontx2-af: Enforce single RVU AF
 probe
Message-ID: <aidvzJEXmeS6Wuz7@rkannoth-OptiPlex-7090>
References: <20260605063245.3553861-1-rkannoth@marvell.com>
 <20260605063245.3553861-2-rkannoth@marvell.com>
 <20260608154014.1b7c8be1@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260608154014.1b7c8be1@kernel.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDAxMyBTYWx0ZWRfX6ic/4zVw8tlw
 UDkUH4qyi9e+FeEITB9edGBeWMVt3iKMhwagrjGi82k12kjUbRSNkFXE1GeB+DxXU55c16lqt82
 IgKuZk+DrWJRi1Ra5KDtIl6i6k7S+bFpSuj/1euk2xQP2kzco4pSH0j9YmZ8qbrhsC2WMDlBqS3
 /8M2nNsREnWoau/l10bLRcPeP7J9HOkoRw+HJHfPJ1zNVsUdtpqg/pyUlalKhRdL1sJzB9CHgKu
 CdnTzoL5J/3PAz8iKYbCmL1W8b8LlS+Wl0U7uApbLKAvV3cR4PY5l/FJOAkLjqxJiZ5b9zWO43b
 cs7IhuBUAvc8K+UivpO6CgGRVfN9yHRQZigRwNTh3RBDjIxrH7BaG6HFff1XmwGWSYpC1jwaJxV
 4pY2TDDblur/kCawQqrBGrfuKuvAaIYHCV+L3WDHkVZ3UiibaAfmhXlcrpPQT7TczfM7ySTopSa
 XifPsXKKn4N4NabHL9w==
X-Authority-Analysis: v=2.4 cv=evLvCIpX c=1 sm=1 tr=0 ts=6a276fd1 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=TtqV-g6YmW1Jfm2GSLaY:22 a=VwQbUJbxAAAA:8
 a=xvSNL58n3w7sZsUnzosA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=lhd_8Stf4_Oa5sg58ivl:22
X-Proofpoint-ORIG-GUID: -9K4ARjRORnvbvy9TPyETHcyGMgjkBEB
X-Proofpoint-GUID: -9K4ARjRORnvbvy9TPyETHcyGMgjkBEB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_06,2026-06-09_01,2025-10-01_01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-296841-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:donald.hunter@gmail.com,m:edumazet@google.com,m:horms@kernel.org,m:jiri@resnulli.us,m:pabeni@redhat.com,m:sgoutham@marvell.com,m:andrew@lunn.ch,m:donaldhunter@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,davemloft.net,gmail.com,google.com,kernel.org,resnulli.us,redhat.com,marvell.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[marvell.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A702E65BBC1

On 2026-06-09 at 04:10:14, Jakub Kicinski (kuba@kernel.org) wrote:
> On Fri, 5 Jun 2026 12:02:37 +0530 Ratheesh Kannoth wrote:
> > There is only one admin-function PCI device per system.
> > Reject any additional AF probe with -EBUSY so the driver model matches
> > hardware and automated reviewers can rely on a single bound instance.
>
> Could you point me to a PCI networking driver written in the last two
> decades which would have this sort of limitation?
>
> At the very least you need to explain in the commit message **why**
> correctly handling multiple devices in a system is beyond your
> abilities.

The comparison to a generic PCI networking driver isn't quite applicable
here. The RVU AF (Administrative Function) is not a standard NIC PF —
it is a system-level resource manager that owns a single, shared set of
AF registers across the entire RVU subsystem. The hardware spec is
explicit on this: "RVU has a single, common set of AF registers.

This is fundamentally different from a multi-port NIC where each PF is
an independent, symmetric instance. In the RVU model, there is exactly
one AF device per SoC, and all other PFs  communicate with it
via mailboxes rather than accessing AF registers directly. Allowing a
second AF probe would mean two driver instances racing to manage the
same global hardware state — provisioning LFs, configuring
NPC/NIX/NPA — with no hardware arbitration between them.

I'll update the commit message to make this hardware constraint
explicit: the single-instance guard is not a software limitation but a
direct reflection of the RVU architecture, where one AF device manages
all RVU functional blocks for the entire system.

