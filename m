Return-Path: <netdev+bounces-302098-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kaC9LacEPmqk+ggAu9opvQ
	(envelope-from <netdev+bounces-302098-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 06:48:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 172D76CA2D1
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 06:48:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=marvell.com header.s=pfpt0220 header.b=J6TBqIY1;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302098-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302098-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=marvell.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DE9B8301AA63
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 04:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B40892F7EF3;
	Fri, 26 Jun 2026 04:48:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4532772E;
	Fri, 26 Jun 2026 04:48:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782449316; cv=none; b=m7klR1h2gU1MGqtuBByLGcLuAp2lq7JTPqQ/cw/53bsM5gKrmLEsS9dE1uBVGTKCA6UTwSoGqzaup1vgPjMrR8khrRfCyZhLk/IkE/EvOzXYjX3cxc+oD49KE/P92dMSsdzl2smchwdpzAZ+GsA/1Q1ocEoHAtxSJ4iax6GLrDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782449316; c=relaxed/simple;
	bh=Xv2a3w6Ll8RtXmAhxhCP9ToKcLYa6pTnkJWdX3st8jg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SKSeXTl5NL060eoTU09rY0/7QLJT5ydELHx3c2iPbmAE7K9xWpK0nSgRnIFtRdn66y3Jf8UIwnvN5DHjReMqzy4nh+RhUwUyx1+S5M8TT7fPT7oTRjtw5hXNKJPcBBX6+EUqNdm/7Seta1G7pjQ+Ycy+jhrZbYp3JFYtWDCojho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=J6TBqIY1; arc=none smtp.client-ip=67.231.156.173
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65Q2q31B3864146;
	Thu, 25 Jun 2026 21:48:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=oNh3ocUPEGAb3bIkyc7mADF
	UGostyvtlxgKRa4OAvOA=; b=J6TBqIY108onHkVnwnEZNxUesOaeCEdzkeESWpK
	zAXAHYP8QPMDYc7PQrfmuHF+8H9Ryxwvf1i8bucHQDNLtOA20xXp9kHHtmIN6D4Z
	SLtKxNd7ghepf+hBn3+V2I43MGjNroOJyDSNlGVCqfrOyJBvvDJpOZ2g66MJc3sc
	zGyLBYGfWTo2vO1MUmjlwuXn5yOmtYdkPxyVTIoB+gBrmZd/HM29rTwisJJaqSa2
	lWU4YyGysePS7wJZNDx6tUe+FvEP6MCugtaPirjVpow7TjSS20DSyM6rwCWoqCJ5
	tjpGZodOXdL6b50ALqHpjsrcIJdLDiz3ZiRJ2wI/iw+hbYQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4f166s2d3e-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jun 2026 21:48:27 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 25 Jun 2026 21:48:23 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 25 Jun 2026 21:48:23 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 25F073F7044;
	Thu, 25 Jun 2026 21:48:20 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
        "Ratheesh
 Kannoth" <rkannoth@marvell.com>
Subject: [PATCH net] MAINTAINERS: Update Marvell octeontx2 driver maintainers
Date: Fri, 26 Jun 2026 10:18:19 +0530
Message-ID: <20260626044819.3004811-1-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI2MDAzNSBTYWx0ZWRfX/kTs8aZa9Qx7
 /2nS9aKNDz0TGOHrMLbJ6unDgWRogy7di8X5Br5bk/VYi7NF21JwwaXlmFd1IDdtDDbFOPKLOgJ
 OyXoPnIC1YB5e/jOVcK84eoK1axMNIw=
X-Authority-Analysis: v=2.4 cv=SNNykuvH c=1 sm=1 tr=0 ts=6a3e049b cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8 a=VwQbUJbxAAAA:8
 a=L0Qivru8c1u7Oc0GlV4A:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: E0vj6UHTReDpCazNJDwdsbMFq2eV4675
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI2MDAzNSBTYWx0ZWRfXxKazGGPRQUJw
 BRFNlqerd5k8FFKqCTydP8Mmv+Zr95QOC2yloc0d6x9gn0XlAHyk+UEod9obhVxs3lklUTFomOr
 qrJcJSjNFA2e24D00ckK/5tVq/DRYApbGlfbmuo3VQ/NSF3J/7UJioRbfbA38qofxhgyZwXxRkm
 mVMEfx1NSsuriF+3wb8dE184zsB6fIMFzSqRAwYRf4c86lekDgFz8SHBguBxsJcrHocojTZN9K3
 MnQHdYD6I5GFM2mPCDgB9dnfO1ZCohloqholQ+1cETPBKzDoD7oSzGjy2i0EHxoWToCqKN+EXuC
 16lvz/zeNVvqptmbAaZiNm/2tgWBmOqXTlTBx+te5vt8SRV48FOuwF7SUrtC4uZee9BlK3Bkpll
 3EfkPWN/f4wgxH7NlIQJwdIK+1yJKPeFV5nN+MOFnTVgD7c88Uhj2fpLft80DPiGOsY0Rq2F3sA
 m3E9WUCt9LTCMJC065g==
X-Proofpoint-ORIG-GUID: E0vj6UHTReDpCazNJDwdsbMFq2eV4675
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-26_01,2026-06-24_01,2025-10-01_01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-302098-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:sgoutham@marvell.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:rkannoth@marvell.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[marvell.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp];
	RCPT_COUNT_SEVEN(0.00)[9];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 172D76CA2D1

Update the maintainer entries for the Marvell OcteonTX (RVU) drivers to
reflect recent organizational changes.

Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 MAINTAINERS | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4a290dc1284e..6fda185033e3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15608,8 +15608,8 @@ F:	drivers/net/ethernet/marvell/octeon_ep_vf
 MARVELL OCTEONTX2 PHYSICAL FUNCTION DRIVER
 M:	Sunil Goutham <sgoutham@marvell.com>
 M:	Geetha sowjanya <gakula@marvell.com>
+M:	Ratheesh Kannoth <rkannoth@marvell.com>
 M:	Subbaraya Sundeep <sbhatta@marvell.com>
-M:	hariprasad <hkelam@marvell.com>
 M:	Bharat Bhushan <bbhushan2@marvell.com>
 L:	netdev@vger.kernel.org
 S:	Maintained
@@ -15618,9 +15618,8 @@ F:	include/linux/soc/marvell/octeontx2/
 
 MARVELL OCTEONTX2 RVU ADMIN FUNCTION DRIVER
 M:	Sunil Goutham <sgoutham@marvell.com>
-M:	Linu Cherian <lcherian@marvell.com>
+M:	Ratheesh Kannoth <rkannoth@marvell.com>
 M:	Geetha sowjanya <gakula@marvell.com>
-M:	hariprasad <hkelam@marvell.com>
 M:	Subbaraya Sundeep <sbhatta@marvell.com>
 L:	netdev@vger.kernel.org
 S:	Maintained
@@ -15628,8 +15627,8 @@ F:	Documentation/networking/device_drivers/ethernet/marvell/octeontx2.rst
 F:	drivers/net/ethernet/marvell/octeontx2/af/
 
 MARVELL PEM PMU DRIVER
-M:	Linu Cherian <lcherian@marvell.com>
 M:	Gowthami Thiagarajan <gthiagarajan@marvell.com>
+M:	Geetha sowjanya <gakula@marvell.com>
 S:	Supported
 F:	drivers/perf/marvell_pem_pmu.c
 
-- 
2.43.0


