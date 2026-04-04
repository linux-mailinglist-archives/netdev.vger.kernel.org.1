Return-Path: <netdev+bounces-275353-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aCWVI1no0GmeBwcAu9opvQ
	(envelope-from <netdev+bounces-275353-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 12:30:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8198339AC55
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 12:30:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4AB22300692B
	for <lists+netdev@lfdr.de>; Sat,  4 Apr 2026 10:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8890351C07;
	Sat,  4 Apr 2026 10:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="d5n+ojsf"
X-Original-To: netdev@vger.kernel.org
Received: from outbound.pv.icloud.com (p-west1-cluster6-host10-snip4-10.eps.apple.com [57.103.67.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1986273D77
	for <netdev@vger.kernel.org>; Sat,  4 Apr 2026 10:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.67.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775298642; cv=none; b=eV6A/GHc79dqIn/ft/QbdBREIzE4ZhY9UKGiO31HSujCIBPyzuhkDN1ud06HQKGrCQlaZ2OyuI67AfIkMM1SV3X+GQUxZfF7zqG1xPRtIHsW9/hfj6PrhOk2+gTZ0xI28JDwvQOrzsDn+0DbGH1qRK1/HUVYpyEIF0QZIa2Bu2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775298642; c=relaxed/simple;
	bh=uO0vylfqXi1EcSngQFnnTZqRcMUmiVc/BGETzLSZszM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AOnFa7mLe1nQ8qvCZxuB89Sjgeo+g/AESyw9j3p94sqKbVEkbYzKMR4V9grNOyxRhiuEKO9XQo2eJ40KE/40B+CsyBfxbU+OKB5Y15Y74NZnCd31b0xULNGNsPI/MuL8dRQnz/mbTGA1zg8QNVfuRW07ZVDfpks80Ao4tre3izc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=d5n+ojsf; arc=none smtp.client-ip=57.103.67.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-1a-100-percent-0 (Postfix) with ESMTPS id 3D1AF180010D;
	Sat, 04 Apr 2026 10:30:40 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1775298641; x=1777890641; bh=v8iSOSYKVyZ18y3wyP+oDU98Bany5SdsDLe5QovYIRk=; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme; b=d5n+ojsfZoVmBz4EH5R+nzMw7dWHKXC8GHoLOpnLU2N6FW1x489/7jwhKFlbmrSBxwImK4Jq9l1OjK802ykXsnz8k7U+c4jOZ+o9ffWo/WoKGgB/BYAS66kr5JMgfIqAi81FuZDvKeMZUPQbfYgcintDkGveYmCqxprZ7iN/FZavs3kAWj1/m8Jyk5LSj7A1YtlN9aJJ9+3Y+hvEcDa75sEuBxd+POE0llH64Gusvys/Dd06+olEBuZuM8mDBdCcG1/V8rhmFNV/Yo9rOFnMLqpGTP4ZEP+p0YV5TaKN6EnjRYD9vUkvml6FXQLEvJoPChmXuHLZN9MAohTnC7vrFg==
Received: from mainframe.tailfb0f7b.ts.net (unknown [17.56.9.36])
	by p00-icloudmta-asmtp-us-west-1a-100-percent-0 (Postfix) with ESMTPSA id 11AB51800135;
	Sat, 04 Apr 2026 10:30:37 +0000 (UTC)
From: =?UTF-8?q?Lek=C3=AB=20Hap=C3=A7iu?= <snowwlake@icloud.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	security@kernel.org,
	=?UTF-8?q?Lek=C3=AB=20Hap=C3=A7iu?= <framemain@outlook.com>
Subject: [PATCH] nfc: nci: fix OOB heap read in nci_core_init_rsp_packet_v1()
Date: Sat,  4 Apr 2026 12:30:16 +0200
Message-ID: <20260404103016.1292588-1-snowwlake@icloud.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA0MDA5NSBTYWx0ZWRfX/iG2KMukVWwO
 EReN4Y0irlMQXbg2QDsgroVx4d0/p9g4b7OkPyGwb1AfAEUWSJ8YVneZojWf5pqE8b5mKzotkeo
 a5YCNvdCyqbV0kySXwpvhqw2f0R/HDLAu2Wcq/S0ZTg7rzuTfhcN9UZMLNl/8DstZIkPkKRVfOk
 yZJukkxOV4gIRMpoEFnc1gncJNfuemdtri2Pa/cI1c8QfUcM5lyVc+IfcwGwEqljwlZ7K8u/QUb
 QpwuP273EfIhBTax7WMuNmtqw0MaAuV2Lpc8dMaL8gj+I5qizrf1IQeZHJoZKlWGfms/QXsVa/r
 34DCT80nPiDML4rGtV3m+Ai/bSI4G7E7w8JzgHF9L737El1bsK1wa24TGuFV7M=
X-Proofpoint-ORIG-GUID: cstqrVqpjEX5UzBhWbSt5DfvNfmVOB1q
X-Proofpoint-GUID: cstqrVqpjEX5UzBhWbSt5DfvNfmVOB1q
X-Authority-Info-Out: v=2.4 cv=J+mnLQnS c=1 sm=1 tr=0 ts=69d0e850
 cx=c_apl:c_pps:t_out a=azHRBMxVc17uSn+fyuI/eg==:117
 a=azHRBMxVc17uSn+fyuI/eg==:17 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=M51BFTxLslgA:10 a=x7bEGLp0ZPQA:10 a=LbuW6tbUWPcA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=UqCG9HQmAAAA:8 a=0lfIgeIhH33YQOLGX-0A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=JKcXVnpmuwdQ7RL0mgk_:22
 a=d4VnCkapGRcR46WWPyFy:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-03_07,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 phishscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0 adultscore=0
 mlxscore=0 suspectscore=0 mlxlogscore=999 clxscore=1011 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604040095
X-Spamd-Result: default: False [-0.33 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MIXED_CHARSET(0.83)[subject];
	DMARC_POLICY_ALLOW(-0.50)[icloud.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[icloud.com:s=1a1hai];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[icloud.com:+];
	TAGGED_FROM(0.00)[bounces-275353-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,google.com,redhat.com,outlook.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[snowwlake@icloud.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[icloud.com]
X-Rspamd-Queue-Id: 8198339AC55
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Lekë Hapçiu <framemain@outlook.com>

nci_core_init_rsp_packet_v1() uses the raw chip-supplied
num_supported_rf_interfaces byte to compute the rsp_2 pointer, but
the preceding min() already stores the capped value in
ndev->num_supported_rf_interfaces.  When a hostile chip returns
num_supported_rf_interfaces > 4 the memcpy is safe (capped) but rsp_2
lands past the end of the skb, and the fields copied out of it corrupt
nci_dev with data from adjacent kernel heap.

Use the already-capped ndev->num_supported_rf_interfaces for both the
length check and the pointer, making the relationship between the two
explicit.

Fixes: e8c0dacd9836 ("NFC: Update names and structs to NCI spec 1.0 d18")
Signed-off-by: Lekë Hapçiu <framemain@outlook.com>
---
v2: drop intermediate offset variable, check skb->len directly against
    ndev->num_supported_rf_interfaces + sizeof(*rsp_2) (Jakub Kicinski)

 net/nfc/nci/rsp.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/net/nfc/nci/rsp.c b/net/nfc/nci/rsp.c
index 9eeb86282..4aaf362b9 100644
--- a/net/nfc/nci/rsp.c
+++ b/net/nfc/nci/rsp.c
@@ -66,7 +66,16 @@ static u8 nci_core_init_rsp_packet_v1(struct nci_dev *ndev,
 	       rsp_1->supported_rf_interfaces,
 	       ndev->num_supported_rf_interfaces);
 
-	rsp_2 = (void *) (skb->data + 6 + rsp_1->num_supported_rf_interfaces);
+	if (skb->len < sizeof(*rsp_1) + ndev->num_supported_rf_interfaces +
+		       sizeof(*rsp_2)) {
+		pr_err("CORE_INIT_RSP too short: len=%u need=%zu\n",
+		       skb->len,
+		       sizeof(*rsp_1) + ndev->num_supported_rf_interfaces +
+		       sizeof(*rsp_2));
+		return NCI_STATUS_SYNTAX_ERROR;
+	}
+	rsp_2 = (void *)(skb->data + sizeof(*rsp_1) +
+			 ndev->num_supported_rf_interfaces);
 
 	ndev->max_logical_connections = rsp_2->max_logical_connections;
 	ndev->max_routing_table_size =
-- 
2.51.0


