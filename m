Return-Path: <netdev+bounces-261774-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SHhIGqVgoWmksQQAu9opvQ
	(envelope-from <netdev+bounces-261774-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 10:15:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DC3231B4FF4
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 10:15:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D9EBF3042266
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 09:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 929FA3B5302;
	Fri, 27 Feb 2026 09:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="dQzvBh04"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35FE431618B;
	Fri, 27 Feb 2026 09:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772183649; cv=none; b=pBsfgRIVAshJO9iQrO7pQtpyWIX4L9yrG3jvaDgppeQ5oKMoUSlXfA3yp15v3qhi9Lpp4nAMNomriyxxDgyW7Z+eeDfOJoC3fiDkNiGgqTL9f27Yf/ZUIb2N4/uAMaA8cXhM3UPvCMYoEeJo8F/7swT5XfwSWg9fvFNT+x4yeKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772183649; c=relaxed/simple;
	bh=BMG6qGN7IRwoVqvdgEweZ3TQtXKjf31Gd3QJrFV4IwE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=X7dx04faR9j+6spoyJqCti77xemlwRUZBt1Y8DeJxijxlqeoxJ3gkUs+o3jXNAzcTr4o0EQTnIwUHlJV59JZKt2z2axPBt8Yv2N0wSrlM5zRNiqwNQHtZ1pLnYDU5yXS3Db9chsTvtThidJe3a2vdU92s76escLvNnbkZNGVyd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=dQzvBh04; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61R7PE1K1539243;
	Fri, 27 Feb 2026 01:14:07 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=7xCgI2oE0Ap216YAVgMQgC4
	ZKLcPndectjaooxjQA+Q=; b=dQzvBh04nO/thhjHVfrmkdhb9NkbZXB+uThLcTI
	cOjbW5vnDOxZ8QcFflOVKWVgAD7i9LE5qzoBk85DDWoOzAy5s9+t/OcBFysdK/s5
	MNefg4JCLZ/GObo2VG0N7XPQyI3lscAo/dZOFyZFEzKMsEi0OWbXDw61z8ExB+8P
	a//0rGFviGr65DdaKW9fV3J+nUvF81iVDLip0gAPsA96AYcbom9QfGSBZqFd/0Le
	deZecMS3X+iVOVbaMNI0mXVnx7YqcrwUbhR7js3G4h2/528OFWuFtiH3pcDb0+lS
	nOU0riZYvRc8blrd6fpDnZ33nMwcI+wrvnMBQfMLDIJW7GQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4cjtnd9yw6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Feb 2026 01:14:07 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 27 Feb 2026 01:14:06 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Fri, 27 Feb 2026 01:14:06 -0800
Received: from 101hsapphire1.sclab.marvell.com (unknown [10.111.168.47])
	by maili.marvell.com (Postfix) with ESMTP id E01643F7096;
	Fri, 27 Feb 2026 01:14:05 -0800 (PST)
From: Vimlesh Kumar <vimleshk@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sedara@marvell.com>, <srasheed@marvell.com>, <hgani@marvell.com>,
        "Vimlesh Kumar" <vimleshk@marvell.com>
Subject: [PATCH net v2 0/4] avoid compiler and IQ/OQ reordering
Date: Fri, 27 Feb 2026 09:13:56 +0000
Message-ID: <20260227091402.1773833-1-vimleshk@marvell.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: t8FKLUNhwPhTaqxDJeV9FU8E3hBz-FDT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDA3OSBTYWx0ZWRfXwIHn447mEuYI
 OVWy48GxyvN3SuqufMWlcO6oT+Z/BAyDwPycrtlsWF+D7L1m3QKb3asTs7hIbDq9oMSQyjpGvLz
 fiYSKS8bGpPb5eQqWD8Jbq6Qlu2FMc4evFYrup4Gx6XqKO8Lr79dKYykGwJs/BarQ0uOrYKo+mO
 LnOvquRJIVBfrdxashi7QmIvwt3WSaJRI8aPLBibuHbNNgoc6jtDZJ8qqE1xS3J0DByabAw0hLo
 BC4z7HqJ03f3xKc9M1Xg3VyKb/HTT/IZeXxsbahQC1jaLlbsoK8YFjo+dRx7iUCRLUQb+MKI55a
 U8aZRdMQUgvJY7TndEDXLh0roTWslTZ5qYjcgkG1aJTcXmn7Qu2WtuHxh6Vjzb07muD+Usq6Mz1
 PK3SIATJkNysSJB/cxslrxWdpGZ7PXGRxW0vmj3YL0M4ZNQaNGPGyBKj26KlKegLeOe30eMOvAp
 +jY77T1sFnCov0sw30w==
X-Proofpoint-ORIG-GUID: t8FKLUNhwPhTaqxDJeV9FU8E3hBz-FDT
X-Authority-Analysis: v=2.4 cv=WYMBqkhX c=1 sm=1 tr=0 ts=69a1605f cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=VwQbUJbxAAAA:8 a=M5GUcnROAAAA:8
 a=LcfSQsnrkOK16RxlBc8A:9 a=zZCYzV9kfG8A:10 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_01,2026-02-26_01,2025-10-01_01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261774-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[marvell.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[vimleshk@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: DC3231B4FF4
X-Rspamd-Action: no action

Utilize READ_ONCE and WRITE_ONCE APIs to prevent compiler
optimization and reordering. Ensure IO queue OUT/IN_CNT
registers are flushed. Relocate IQ/OQ IN/OUT_CNTS updates
to occur before NAPI completion, and replace napi_complete
with napi_complete_done.

Vimlesh Kumar (4):
  octeon_ep: Relocate counter updates before NAPI
  octeon_ep: avoid compiler and IQ/OQ reordering
  octeon_ep_vf: Relocate counter updates before NAPI
  octeon_ep_vf: avoid compiler and IQ/OQ reordering

V1: https://lore.kernel.org/all/20260212121634.360252-1-vimleshk@marvell.com/ 

 .../ethernet/marvell/octeon_ep/octep_main.c   | 40 +++++++++++++------
 .../net/ethernet/marvell/octeon_ep/octep_rx.c | 27 +++++++++----
 .../marvell/octeon_ep_vf/octep_vf_main.c      | 38 +++++++++++++-----
 .../marvell/octeon_ep_vf/octep_vf_rx.c        | 28 +++++++++----
 4 files changed, 95 insertions(+), 38 deletions(-)

-- 
2.47.3


