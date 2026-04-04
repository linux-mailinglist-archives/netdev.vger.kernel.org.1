Return-Path: <netdev+bounces-275400-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8HqoHvVR0WmhHgcAu9opvQ
	(envelope-from <netdev+bounces-275400-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 20:01:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E828B39C00D
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 20:01:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A2293300A53F
	for <lists+netdev@lfdr.de>; Sat,  4 Apr 2026 18:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89CC029AAEA;
	Sat,  4 Apr 2026 18:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="EsdqI0AK"
X-Original-To: netdev@vger.kernel.org
Received: from outbound.qs.icloud.com (qs-2007l-snip4-11.eps.apple.com [57.103.84.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ABE0264617
	for <netdev@vger.kernel.org>; Sat,  4 Apr 2026 18:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.84.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775325681; cv=none; b=NV4TwifW4RTbLDY3FBX1dhpjIsbRGQcujVzp7n4cI5mnHREyb0/dBhtM8ssF3k8wZF7ONPm03MO1Ql7NMvCnK4tnMmA+Q7dcU9VsycBlUrfGbNdt+iBjWBUzOP1tOfjrxbnGYWUZCY1ecIn1RCaNnJfLo+iwXr4S+muDZUMcG08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775325681; c=relaxed/simple;
	bh=lD9gaMjBGvXHlWHM00X3qUwyDwEUamhQxaHCLKcB7jI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kXu4yoAwUmUdBRP19UxBrkSI6jRMn2aqc6INy8SPLDdDDlOV3aytt5jVL75DsrDiuRy1iNIyRLxtvIABo6tyvjmmeUmkaeZ7IBnY2hje6JajPA29iWKrJ2rlOeHD+BK5mIO7iQ60+dBya+PYTWKIR0LnGPD/h8pKMn0UutBXoEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=EsdqI0AK; arc=none smtp.client-ip=57.103.84.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-east-2d-60-percent-4 (Postfix) with ESMTPS id A7BBE180013F;
	Sat, 04 Apr 2026 18:01:16 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1775325679; x=1777917679; bh=0I1Is+uRm41TlYXJPEwsLEXw5wFOFW+Wto5j/ARTTDc=; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme; b=EsdqI0AKTlq3QkkFufLTaCtaVGBqy7aeKE/Mzr1rCpaaU1O0V3OGK5O5XUmsbf7ZNYMkUqLA/+ax4TjVoiMmC/QP4xGWcc2VEboL1eWJtfiYPv1bOxRXX+279Kj8xjjLz0orJXh0qgEKZZIU2ScOqT9tNUmwJkKt0mJHCvDUjm8HSfrzk0qYrD5LTCgVCxIwnEG0Z+HnVibJf7/OE0m5k51k2XEhhaBf2hGASzBYeYT4IM9usC4CvWi5+IOIx/iCxYfvj3YQxLxXNRz2rsME2HtHreNDlzAv8HzQPNLzput8waxjaevTyNs6bmGmgW+J2uAyoSQEvJaib5boLUEnwA==
Received: from mainframe.tailfb0f7b.ts.net (unknown [17.57.155.37])
	by p00-icloudmta-asmtp-us-east-2d-60-percent-4 (Postfix) with ESMTPSA id AD16918000A0;
	Sat, 04 Apr 2026 18:01:14 +0000 (UTC)
From: =?UTF-8?q?Lek=C3=AB=20Hap=C3=A7iu?= <snowwlake@icloud.com>
To: netdev@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	linux-nfc@lists.01.org,
	davem@davemloft.net,
	kuba@kernel.org,
	=?UTF-8?q?Lek=C3=AB=20Hap=C3=A7iu?= <framemain@outlook.com>
Subject: [PATCH] nfc: nci: fix OOB heap read in nci_core_init_rsp_packet_v2()
Date: Sat,  4 Apr 2026 20:00:49 +0200
Message-ID: <20260404180049.1304711-1-snowwlake@icloud.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA0MDE3MSBTYWx0ZWRfX7r28LsTMXjGj
 /edCZyPtAJ3tNJEC/ho2ILsDZNCOVtWhmSijBVm7tUfJM3HvmM5/CzfBOH4ahcic5zzgL4aNNi/
 Je548hQTOgPq5b9a9hzvEHosqJWZKXOlbjHrdOfRs07xGcPaxqtpj/tcW8W5zratTQum7gADz4/
 /FB7m4hdjkgk+/sYthz9froUpI57KH3A2CUAo4JQFZjALQuOdnDNwlm6SssYv3rwFEtmpB6JNNN
 VEQZpUS6uDOTC8xgSr5aFI8DphHUkyW19B0GePNJ67pImCIbOOO7Qjbii18LtGOZO/TGMCZjs8T
 xJEbVTcrc2u6waNtox4X/Y4SZb1FKOSrfguCHsGcz2PpWus5Flt/Hxf4faL5MU=
X-Proofpoint-ORIG-GUID: DpHCJmCuE6oO2rbsMIMQjPQ3mx_jpFfi
X-Authority-Info-Out: v=2.4 cv=FP0WBuos c=1 sm=1 tr=0 ts=69d151ed
 cx=c_apl:c_pps:t_out a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=M51BFTxLslgA:10 a=x7bEGLp0ZPQA:10 a=LbuW6tbUWPcA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=UqCG9HQmAAAA:8 a=Dy0kGaICG5QvVYTBcgQA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=JKcXVnpmuwdQ7RL0mgk_:22
 a=d4VnCkapGRcR46WWPyFy:22
X-Proofpoint-GUID: DpHCJmCuE6oO2rbsMIMQjPQ3mx_jpFfi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-04_02,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 mlxscore=0 bulkscore=0
 clxscore=1011 mlxlogscore=999 adultscore=0 spamscore=0 malwarescore=0
 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.22.0-2601150000 definitions=main-2604040171
X-Spamd-Result: default: False [-0.33 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MIXED_CHARSET(0.83)[subject];
	DMARC_POLICY_ALLOW(-0.50)[icloud.com,quarantine];
	R_DKIM_ALLOW(-0.20)[icloud.com:s=1a1hai];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-275400-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.01.org,davemloft.net,kernel.org,outlook.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[icloud.com];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[snowwlake@icloud.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[icloud.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[outlook.com:email,icloud.com:dkim,icloud.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E828B39C00D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Lekë Hapçiu <framemain@outlook.com>

nci_core_init_rsp_packet_v2() walks the chip-supplied
supported_rf_interfaces[] flexible array using a plain pointer
with no bounds check.  Each iteration advances supported_rf_interface
by (1 + 1 + rf_extension_cnt) bytes, where rf_extension_cnt comes
directly from the chip.  A hostile NCI v2 chip can set
rf_extension_cnt=255 per entry and num_supported_rf_interfaces=4,
driving the pointer up to ~1028 bytes past the end of the skb into
adjacent kernel heap.

Add two guards per loop iteration:
 - check that at least 2 bytes remain before reading the interface
   byte and extension count byte;
 - check that sufficient bytes remain for the declared extension
   block before advancing over it.

Also add an upfront sizeof(*rsp) check so that accessing the fixed
header fields (nfcc_features, max_logical_connections, ...) is safe
before the loop is reached.

Fixes: bcd684aace34 ("net/nfc/nci: Support NCI 2.x initial sequence")
Signed-off-by: Lekë Hapçiu <framemain@outlook.com>
---
 net/nfc/nci/rsp.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/net/nfc/nci/rsp.c b/net/nfc/nci/rsp.c
index 4aaf362b9..ecd360b59 100644
--- a/net/nfc/nci/rsp.c
+++ b/net/nfc/nci/rsp.c
@@ -96,10 +96,17 @@ static u8 nci_core_init_rsp_packet_v2(struct nci_dev *ndev,
 				      const struct sk_buff *skb)
 {
 	const struct nci_core_init_rsp_nci_ver2 *rsp = (void *)skb->data;
-	const u8 *supported_rf_interface = rsp->supported_rf_interfaces;
+	const u8 *supported_rf_interface;
+	const u8 *end = skb->data + skb->len;
 	u8 rf_interface_idx = 0;
 	u8 rf_extension_cnt = 0;
 
+	if (skb->len < sizeof(*rsp)) {
+		pr_err("CORE_INIT_RSP v2 too short: len=%u need=%zu\n",
+		       skb->len, sizeof(*rsp));
+		return NCI_STATUS_SYNTAX_ERROR;
+	}
+
 	pr_debug("status %x\n", rsp->status);
 
 	if (rsp->status != NCI_STATUS_OK)
@@ -112,11 +119,22 @@ static u8 nci_core_init_rsp_packet_v2(struct nci_dev *ndev,
 		min((int)ndev->num_supported_rf_interfaces,
 		    NCI_MAX_SUPPORTED_RF_INTERFACES);
 
+	supported_rf_interface = rsp->supported_rf_interfaces;
 	while (rf_interface_idx < ndev->num_supported_rf_interfaces) {
+		if (supported_rf_interface + 2 > end) {
+			pr_err("CORE_INIT_RSP v2 truncated at rf_interface %d\n",
+			       rf_interface_idx);
+			return NCI_STATUS_SYNTAX_ERROR;
+		}
 		ndev->supported_rf_interfaces[rf_interface_idx++] = *supported_rf_interface++;
 
 		/* skip rf extension parameters */
 		rf_extension_cnt = *supported_rf_interface++;
+		if (supported_rf_interface + rf_extension_cnt > end) {
+			pr_err("CORE_INIT_RSP v2 rf_extension overflow at idx %d\n",
+			       rf_interface_idx - 1);
+			return NCI_STATUS_SYNTAX_ERROR;
+		}
 		supported_rf_interface += rf_extension_cnt;
 	}
 
-- 
2.51.0


