Return-Path: <netdev+bounces-298433-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6cXzFxpoK2r68wMAu9opvQ
	(envelope-from <netdev+bounces-298433-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 03:59:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B592C676384
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 03:59:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=marvell.com header.s=pfpt0220 header.b=hVFasldr;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298433-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-298433-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=marvell.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4ED1F310430F
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 01:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA77C37475C;
	Fri, 12 Jun 2026 01:59:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97AA1390CB5;
	Fri, 12 Jun 2026 01:58:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781229544; cv=none; b=RaRRgazfkKf23R6O9E+Rcyka9eRW9PvgSJZqqQaC3XiSAk8haRQ1uqxicKomD6uROGnFynQcxVsAGv2wIeMZtDC+sCbzqDEASNPqHVFP0swgelgTGVrnEi+LHqNfFx8xmNDOmKlmCKmMqqisRPPHsyfBeJuyqPrn80JwLvN2d7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781229544; c=relaxed/simple;
	bh=r80u+YW3cu85ahmxppH8KvK+QfS4gD9mvYWJsSzYNs0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eaHykjZXW2/ic36GRC/n56VvSH1FBwJhjOOe9MFDVe2FuuiLkgrLun5Ng6OXrUUrOuGRRm/Pyg7LBlXXsib1B1cnDu9+nCtX8znSqDQTTGA+9LneF0YQlrwYKhjLeMpwwK12eLm7nlVeecGxb/pZLZNwKFaOQrBQUadOmJCr7JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=hVFasldr; arc=none smtp.client-ip=67.231.148.174
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65BMRwYf3176331;
	Thu, 11 Jun 2026 18:58:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=X
	agnC5SVk0w/j9z+GndtBhj2idrwZd4MyivZHhaTD20=; b=hVFasldrDdyoptDDE
	qO76I7NjrGKXwQDsQAIMFxzMSylST8S0eovjB/kTr7gYz49w2kaPeCpbBuLZdw47
	OLFZGKk1w07Sd3bRPh1uvmpxcmJRb27xjoFgF+9aoBm3x7dTBpQCbZ3Tfa0vdjC1
	5YebkLTgZrYCClp+My9aZi6kkUl6Pzhl9y+A4HhVYK3riG8NYceupKHNnwA/Vr9f
	djz98nwUnCVDpgvN4P0x4+nxb9slwfB2kCRjeefwAEhUFFSelZUVdkx6uoDD4329
	DjYvzwarg2Ci07BQtzU8hKjbV8jQWsoCTc2TN/u0XSiDt41eEXmPPg9p0BVrxKaO
	QAA9g==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4eqe5w5kwx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jun 2026 18:58:43 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 11 Jun 2026 18:58:42 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 11 Jun 2026 18:58:42 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id E6D3A3F704F;
	Thu, 11 Jun 2026 18:58:37 -0700 (PDT)
Date: Fri, 12 Jun 2026 07:28:36 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: =?utf-8?B?7LWc7Jyg7Zi4?= <dbgh9129@gmail.com>
CC: Jakub Kicinski <kuba@kernel.org>, Sunil Goutham <sgoutham@marvell.com>,
        Linu Cherian <lcherian@marvell.com>,
        Geetha sowjanya <gakula@marvell.com>, hariprasad <hkelam@marvell.com>,
        Subbaraya Sundeep <sbhatta@marvell.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S . Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Paolo Abeni
	<pabeni@redhat.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <nshettyj@marvell.com>
Subject: Re: [PATCH net-next v2] octeontx2-af: Fix PCI device reference leaks
 in debugfs
Message-ID: <aitnzFHczBlsY_O0@rkannoth-OptiPlex-7090>
References: <20260608165546.61347-1-dbgh9129@gmail.com>
 <20260610083544.0da95356@kernel.org>
 <aioblJqQctA_9U8y@rkannoth-OptiPlex-7090>
 <20260611104547.22cedb69@kernel.org>
 <CACrCO_UAjAdi3K7y0nHcSDoCXaZnZRCZ46b3u3vdfyWEY1GC9w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACrCO_UAjAdi3K7y0nHcSDoCXaZnZRCZ46b3u3vdfyWEY1GC9w@mail.gmail.com>
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEyMDAxNiBTYWx0ZWRfX5+uQb+n4nV8n
 uT4xd0NY6xjpactvFmamQsNygNKy9e035Nj/g4iv8bt5nTZN2hP/7dXz6v7MBhTw0WByP7KXu9Z
 WhuprIdX1cNmrFHoEMKazXdaiqe1VcH8rrosAiH+/xV7UI0BYNEJPA9LTyEpMbFq7Pjr6oJgflM
 XCVkVQeOF5MvbKTeFb0Zetwem6vV8dVjW0PcS1EBsS8ILY0H4z0XuVPLdjp8HuqBpoE9FYWo9w+
 6apky1K8ohil7z4PT4FE2B7xUb1q9xHu1Xpgn0hnfRdbgyfxLtaeuA9zUBs8Rs0Msp9cBk4Dlgu
 o37lqJu2m5TxfurANkuj8eln0dh0COqrZoZTP5pHM5v5YwUG2sIE3NH/WDsq7D+pM9DjEJwSIV+
 ZOAbph0gsnq51KNT+IHCbIT8KlThZvl/BTDnTRhpRrnnuJfCqRFTAIv9nBxi2HaPxkATcWpEaqc
 LnCLvDfFVJsEVrUL61g==
X-Authority-Analysis: v=2.4 cv=fv7sol4f c=1 sm=1 tr=0 ts=6a2b67d3 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=TtqV-g6YmW1Jfm2GSLaY:22 a=pGLkceISAAAA:8
 a=xhKp_B18MUUv4yhf7K4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEyMDAxNiBTYWx0ZWRfX/owtnBBSNk4r
 CJpgXNFbYqs/5j8ZSi7rCLcpBx2Iy5AiLo9bCeyTGxYQqwnaH7UgKOG3H4NhG+7w0LPo1jVXS6C
 fBqieTr8dezXEuY0o033L40cCc57Iuo=
X-Proofpoint-GUID: R-ALFvw4PGBVVdhiE8BhgKHyWlZax4QP
X-Proofpoint-ORIG-GUID: ffjXTIyMpU8eT--zUWUyvMs-n1rpLKhi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_05,2026-06-11_01,2025-10-01_01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,quarantine];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-298433-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_RECIPIENTS(0.00)[m:dbgh9129@gmail.com,m:kuba@kernel.org,m:sgoutham@marvell.com,m:lcherian@marvell.com,m:gakula@marvell.com,m:hkelam@marvell.com,m:sbhatta@marvell.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:nshettyj@marvell.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,marvell.com:dkim,marvell.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,rkannoth-OptiPlex-7090:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B592C676384

On 2026-06-12 at 00:33:50, 최유호 (dbgh9129@gmail.com) wrote:
> > Oh, that's much better, somehow I assumed that this dance is necessary
> > because we are accessing a different PCI device.
> >
> > Also, since you're actively working upstream and nobody else on the CC
> > list responded - should you perhaps be added to maintainers for this
> > driver so that you're CCed on patches?  (instead of one of the useless
> > ones)
>
> Thank you for reviewing this patch.
>
> If Marvell posts a cleanup patch for this issue, could you please include:
> Reported-by: Yuho Choi dbgh9129@gmail.com
> or otherwise mention this report?
> I will hold off on sending another revision for now.

Thank you for catching this issue and for posting the fix!

We currently have a large backlog of patches queued up to post upstream, so
there will likely be a bit of a delay if we handle the submission from our
side. If you have the bandwidth and would like to post this (passing rvu object to debugfs file)
yourself, please feel free—we will gladly help review and test it promptly.

Alternatively, if you prefer that Marvell takes it over and posts the
cleanup, we will definitely include your tag to ensure proper credit.

