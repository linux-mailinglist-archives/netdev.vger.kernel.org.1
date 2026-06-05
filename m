Return-Path: <netdev+bounces-295987-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uyoFEFtNI2rvoQEAu9opvQ
	(envelope-from <netdev+bounces-295987-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 00:27:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CEC1564BA32
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 00:27:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=hpe.com header.s=pps0720 header.b="Zf/X iCz";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295987-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-295987-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=hpe.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BAF58301BC33
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 22:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E3953B71BA;
	Fri,  5 Jun 2026 22:25:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8AA13C3C02;
	Fri,  5 Jun 2026 22:25:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780698354; cv=none; b=jbkXsJQN5FTSzfYKBIR/RJpPoCZ8W6BGp6cCEkiQ77FSPwhJ8s+maBfBUwiQp5Ij6SwZbDEGgPFoqF2NZvgzP7Sy9aJb0+64vrC+mafiFvr6fbPL1mui+ZnyGh8h/SQtXAbSWOz4kTFGFs8SR1XyfSftuGJTN9LDzNyS95TkcKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780698354; c=relaxed/simple;
	bh=hR9xslRbdiigPAZ5ZfCCV7KUc5lDvC+AACgfaWEYnWo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=T1y968t4zGM63nVr9uIwHMjNq1XTL3HV8BGK+BObaBT3x7T0uP1w9mqwBbfCpLUTELVIgWcv8q2mw3oifBkKFz0Sh3ONXlpD/p4yCjX6OQP8FqXUfYhUEMXR0JWzSIiFDl8g2w1Eiagal/F3og8hitqObzcOU0/ItIZ3b0Vn1Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=Zf/XiCzX; arc=none smtp.client-ip=148.163.143.35
Received: from pps.filterd (m0134423.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 655HZJq6408510;
	Fri, 5 Jun 2026 22:25:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-type:date:from:message-id:mime-version:subject:to; s=
	pps0720; bh=/ntOmGPECocOXVF+Qff9yChtuO6F1D0acS3zzuw89O8=; b=Zf/X
	iCzXJ0WIPVE96k76D4ShODhYfJbuuryGsYD8vZaNupNnIU65IRUFTtJ5hdZcWMx5
	W7R+/1+MEL+8G7TKup6aAJOrEHOti4cdpljLsIjWFqZGptu5xfbeqONAca07ennx
	840do9sv/ixmyepZP7cpH5J2aRzyWd0UByCA9nXChOBdJE5PlUMo3W9pr31tu4T6
	FKAlwNsI1il5swZg3si4ZzPvErUv7xkU5GJxgsxb0H+HBcZlfjTE+s51dRUtPFQB
	i7/M5SWPM7doaZ8VnZ96QWQbjf44rCWwj+dxCGJL/juGfg2WDwuD7XmICFQjbIof
	X/MOnvLu8BQiXgxyjQ==
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 4em305jtdt-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 05 Jun 2026 22:25:28 +0000 (GMT)
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14878.it.hpe.com (Postfix) with ESMTPS id 86C90132DA;
	Fri,  5 Jun 2026 22:25:27 +0000 (UTC)
Received: from HPE-5CG20646DK.localdomain (unknown [16.231.227.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTPS id 484B9801613;
	Fri,  5 Jun 2026 22:25:26 +0000 (UTC)
Date: Fri, 5 Jun 2026 17:25:24 -0500
From: Kyle Meyer <kyle.meyer@hpe.com>
To: michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
        andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] bnxt_en: Fix NULL pointer dereference
Message-ID: <aiNM1CY2-StPilxW@hpe.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-GUID: Yaytd8mKrkxs13hOSQTO17blgzicMqOy
X-Proofpoint-ORIG-GUID: Yaytd8mKrkxs13hOSQTO17blgzicMqOy
X-Authority-Analysis: v=2.4 cv=Qp9uG1yd c=1 sm=1 tr=0 ts=6a234cd8 cx=c_pps
 a=UObrlqRbTUrrdMEdGJ+KZA==:117 a=UObrlqRbTUrrdMEdGJ+KZA==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=gQcMVamqm3wCPoSYhaRC:22 a=g3u0LPWLDYfGfufhFw6-:22 a=VwQbUJbxAAAA:8
 a=MvuuwTCpAAAA:8 a=ubeRpN5ZeyW9BGWM014A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA1MDIyMSBTYWx0ZWRfXwm0AnEAt6oyV
 MdyzOPllGK2QHdEBei5TOsOxVQHQUysoI6ixzIFP15mSOUuw26D707CL1Gx3KsybVLD5DP3OT+J
 3C8hXYYEgf5rsyFnM79PNnHc4JZgR/tRCRkyVUJ18omxNZ59+I1kD7THrFE5gz23l5MIeXSGBLB
 1PjR3QMfN9H3+0Ni9DpyMmr9IROYF6mkhMC4BACii7XoUS6boRivbzazSjXNqMNhPJpTpQqdEAh
 JpxDNdM+4QaIZ5g28yXBBVpItksYUH83erbObjyUARZhGk6n9/JmHskhafyzCJdnO/xPqlJ5px9
 RVEUUMXuwoNmFvqbtZr9c3TAWasTbnqaxHnKraQW1GA0Fvo9TWg8lL8BlzILNJ72oq4nA7XRmj+
 8Go6V+xprQAWSrGJMPyBdrbkjuCEv6n0YNd4jj/330BHZr8aR3es3SwsVr1yQIC7ilZ7p520Lb9
 tj+Td8nGdv+cJ8fYahA==
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-05_04,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 phishscore=0 spamscore=0 impostorscore=0
 suspectscore=0 malwarescore=0 clxscore=1011 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606050221
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[hpe.com,reject];
	R_DKIM_ALLOW(-0.20)[hpe.com:s=pps0720];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,hpe.com:mid,hpe.com:dkim,hpe.com:from_mime,hpe.com:email];
	DKIM_TRACE(0.00)[hpe.com:+];
	TAGGED_FROM(0.00)[bounces-295987-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:michael.chan@broadcom.com,m:pavan.chebbi@broadcom.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[kyle.meyer@hpe.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kyle.meyer@hpe.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CEC1564BA32

PCIe errors detected by a Root Port or Downstream Port cause error
recovery services to run on all subordinate devices regardless of
administrative state.

The .error_detected() callback, bnxt_io_error_detected(), disables
and synchronizes IRQs via bnxt_disable_int_sync(), which calls
bnxt_cp_num_to_irq_num() to map completion rings to IRQs using
bp->bnapi.

Since bp->bnapi is allocated on NIC open and freed on NIC close, PCIe
error recovery on a closed NIC can dereference a NULL pointer.

Check if bp->bnapi is NULL before disabling and synchronizing IRQs.

Fixes: e5811b8c09df ("bnxt_en: Add IRQ remapping logic.")
Cc: stable@vger.kernel.org
Signed-off-by: Kyle Meyer <kyle.meyer@hpe.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 008c34cff7b4..ec38a0a40875 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -5748,7 +5748,7 @@ static void bnxt_disable_int_sync(struct bnxt *bp)
 {
 	int i;
 
-	if (!bp->irq_tbl)
+	if (!bp->irq_tbl || !bp->bnapi)
 		return;
 
 	atomic_inc(&bp->intr_sem);
-- 
2.51.0


