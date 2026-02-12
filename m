Return-Path: <netdev+bounces-258448-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2HZEIbLEjWnT6gAAu9opvQ
	(envelope-from <netdev+bounces-258448-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 13:16:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 03EE212D59A
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 13:16:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D62A0303E380
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 12:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9824C2F547F;
	Thu, 12 Feb 2026 12:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="NJ/LLdIO"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480B727E7EB;
	Thu, 12 Feb 2026 12:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770898607; cv=none; b=Y+/Wjy1ZnFwYlAy/fC+YVsaJzS65bTA5IpuDnIvVj4ajCM5q7ZwZNXz1mcNr3g3SJelqjLHbIjJBoYnzD3PB/iwM7gyvmwlkkJD777HkkWpGFPoBvfP0hBPf7wEOrVcbaYFSIIalgWvT1rC2URl/Wq8Cx7w9g7BHO2zj6tZdfzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770898607; c=relaxed/simple;
	bh=0Rh0bLhpJYVjm+sYBU3bZkKCnJyuavvuEeRKrWUs71s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=p1xDYASA2yyJyzOwdKKlJGyuMwW7HCvNgPLDQY0q96n2mSrmjgFFM7xdQmN3iQVyy4zvf0EJg4iEv7rOYXS9ej9mGwEAq/JTGuQWTwYBQx5URWx/zbknHIvMVJtrNER/aLHvd2qyKWcwsh5ubDPPh9SDJVS0upuij2pa0eQfZ+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=NJ/LLdIO; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61C32bms3517710;
	Thu, 12 Feb 2026 04:16:39 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=RzhaTAObsypcppcWIWEOA3d
	QXdHn6Ri7c3it64jsnA8=; b=NJ/LLdIOTmwMxMs+ZQLyKtusxDWZKHm88e0RuYg
	c9kz2v+NSpiElF+UjtzPyl2ZwndlNIX1X90oxfcoDqM5VlgvaoX3pxwQ8HKSIbhJ
	0BAZBhKAXyMSKdCWd2mKYHjhPgIwwXy339puuH9pL3TCROiA8f/WCxlGQrOFxJIh
	FoPD4zhmkFf0TIMEvcgMCJYz/o9FArnoHAh9HDouT73QKdN2d9FErtedpI4KmtUb
	W5o97A0dtzacWj/xagaNapLJnlAKyypOZYbPaIca8wlYiQhnNirMpwLZjHWhvjrY
	LjoJ4IFbCaGB7K1m10hicTrvJudBLj0GZwjVF4iyf3IbAmw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4c8udm2xch-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Feb 2026 04:16:39 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 12 Feb 2026 04:16:55 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 12 Feb 2026 04:16:55 -0800
Received: from 101hsapphire1.sclab.marvell.com (unknown [10.111.168.47])
	by maili.marvell.com (Postfix) with ESMTP id D45C83F70DA;
	Thu, 12 Feb 2026 04:16:37 -0800 (PST)
From: Vimlesh Kumar <vimleshk@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sedara@marvell.com>, <srasheed@marvell.com>, <hgani@marvell.com>,
        "Vimlesh Kumar" <vimleshk@marvell.com>
Subject: [PATCH RESEND net v1 0/2] avoid compiler and IQ/OQ reordering
Date: Thu, 12 Feb 2026 12:16:30 +0000
Message-ID: <20260212121634.360252-1-vimleshk@marvell.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEyMDA5MCBTYWx0ZWRfX8vCITNG6wMj1
 QMkjcCRKqLI2Zwn7Fm4CXluwLok28lswzKO5krAyKbh4FCtDXj05Sm1wZUvo4yAR2TBqR38yTFM
 KKvIq1YL3FOwDTRG0bqnx0QrqbZ1uyVnv6bn+0Aqrc2U/65IY9DyzDUERHsbMLdubcgsvtLajBl
 xo/OT7HfQsEpLPWUInvzg6lPy90jHXEQt5en9dWqdqf71w904azIO8A2ImYQ3F7S6wPxG56ioms
 KuZvaKyv4rhp1AMVAyG5QOzImQdGlTBVy9BQQYQQMSumrNLWJAtDAap5uFD71fX7p+7SjV9pXgy
 ZIkM//5snFcKqjXen5XXHk4s6j+zc5QbXPKaP7dMbb/9/298+oLNzJbOlFkNUrMJ+2L1zey9t1n
 cwLI/9Lvs9O4S/qY0VUjZc350uOB0P4YKnPo7pQFKpHir7T8zZuMNWONkzJqeGuEdQ1MdN4d6kj
 NTS+1LE25YE+2fLKwGg==
X-Authority-Analysis: v=2.4 cv=bvZBxUai c=1 sm=1 tr=0 ts=698dc4a7 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8 a=UqCG9HQmAAAA:8
 a=LcfSQsnrkOK16RxlBc8A:9 a=zZCYzV9kfG8A:10
X-Proofpoint-GUID: ihK8hjrBwqVmQgdHezUm1wFqgUoem9Xx
X-Proofpoint-ORIG-GUID: ihK8hjrBwqVmQgdHezUm1wFqgUoem9Xx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-12_03,2026-02-12_01,2025-10-01_01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258448-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vimleshk@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,marvell.com:mid,marvell.com:dkim];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 03EE212D59A
X-Rspamd-Action: no action

Utilize READ_ONCE and WRITE_ONCE APIs to prevent compiler
optimization and reordering. Ensure IO queue OUT/IN_CNT
registers are flushed. Relocate IQ/OQ IN/OUT_CNTS updates
to occur before NAPI completion, and replace napi_complete
with napi_complete_done.

Resending based on discussion with reviewer.
https://lore.kernel.org/all/MN6PR18MB54667119674AC692ED7EF978D39FA@MN6PR18MB5466.namprd18.prod.outlook.com/

Vimlesh Kumar (2):
  octeon_ep: avoid compiler and IQ/OQ reordering
  octeon_ep_vf: avoid compiler and IQ/OQ reordering

 .../ethernet/marvell/octeon_ep/octep_main.c   | 40 +++++++++++++------
 .../net/ethernet/marvell/octeon_ep/octep_rx.c | 27 +++++++++----
 .../marvell/octeon_ep_vf/octep_vf_main.c      | 38 +++++++++++++-----
 .../marvell/octeon_ep_vf/octep_vf_rx.c        | 28 +++++++++----
 4 files changed, 95 insertions(+), 38 deletions(-)

-- 
2.47.3


