Return-Path: <netdev+bounces-262738-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UH+mAr+8pWn8FQAAu9opvQ
	(envelope-from <netdev+bounces-262738-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 17:37:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E0621DCFF4
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 17:37:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EBD483074541
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 16:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB337410D26;
	Mon,  2 Mar 2026 16:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gehealthcare.com header.i=@gehealthcare.com header.b="M7DfS0JL"
X-Original-To: netdev@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010006.outbound.protection.outlook.com [40.93.198.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68DDB3FB043;
	Mon,  2 Mar 2026 16:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772469167; cv=fail; b=Et6YVjxf7iHVn/335mxexwjFnEOevOXE1c/oZxx3uS7q5GXtY6uz9LjHScUPgM74zGMLOk+0+GB7hQlmmR0zkGjQVrGYBbKWvfIo6Lgu7p+ksMHP0FbqI4hZZyf7w+e30mmUmDVH9pF2DJRdZ6v3yziRN2U16W93X1ZmHfeCmuk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772469167; c=relaxed/simple;
	bh=cjhZ3PDlaooCfhOWalvD2tWgW/Rc2l4ISmBaC+7cFdI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OjU0NanjFjMMSPz5xjTPVDIvscim++7PGgVNfkt8F8BN8wTa7w6X3pyWhOoqKNr7X7RG1q8UYDAUrkT+sokPYXMS+Iyn7/BY0ufZtZ8pBGag4fy/pueZq70qZW4IYHMDqiZu6vnmbu/YcRIllxP1JTVRwuSZchPd+/9QZiwSJ7k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gehealthcare.com; spf=pass smtp.mailfrom=gehealthcare.com; dkim=pass (2048-bit key) header.d=gehealthcare.com header.i=@gehealthcare.com header.b=M7DfS0JL; arc=fail smtp.client-ip=40.93.198.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gehealthcare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gehealthcare.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V3SKyrW9RfT/g/D7xDfD5QUrEOyTVFcABoA23gQzrGb03V8shS+xRv8Au1710MQJFyP9pd8PtqRq4/Tp4GOdw8TZX/BQpo1VQaMibOPEXhR1xd/NUMkKeo+AcJ1VWwzrLLaKtU11uUlklIV3c9ZXme3D+csb/ht6AY+yoS4FfKZSbST+jHiA0uTh/pxeMGQJkNiOJQOapWDtKdt6XDwCrN06si6Nc5GOresBvWYxA73LlNBQF1NGJRtXTRWoGZVDsth/cbfiWqUGl3GzanQQsJHTKip5rIuIQ24+oKX5xiNjDOBvUHlqEoOrJj71Hf9JaOMAcdQ7y6EgQqvq2+ppRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zNXjiBQZoCTaTvnglY61Zjd+Y9WxY3ru8VwTshf461M=;
 b=gc5Y7+u2yDVu9wR8SE5kSO21sSpBlJD2YzZbViNL9RIrm1o0AscI+OffqsJsNkQ5nhfScOpz1WvGWdt5pcg2QTilHKNEERAFjbxo0XQP80eaHvr9dBLcEl22rhzw/kjgkSO8HCy9JCSF0wr8JyDJWrMBUj/P6NB3lFkWqfWjgl5q5se2Nr1uCy6ElDJa9zjj9xbZ4c/P6XJ0Y38PLo/igo0zmHcn1oI5lGlPRpSp3Iyl2VGMTzGPh3Y4GO+0sJF6H2lKe/SUOLBx5eaTjU93ja3PJZvsWuab3dD9xgRQKQ1nSdrGWQ/GDwCYGCQS7KTGphkZ00V3zOUSSzPoA+PL9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 165.85.157.49) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=gehealthcare.com; dmarc=fail (p=quarantine sp=quarantine
 pct=100) action=quarantine header.from=gehealthcare.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gehealthcare.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zNXjiBQZoCTaTvnglY61Zjd+Y9WxY3ru8VwTshf461M=;
 b=M7DfS0JLG3PG7qZm2FU6t0S8h5S/Tdbz+iZWFOggOmYR4qiseCekDbtKei6Pt/ShBzynfFoSQ8KuhPdsC3EYpjRWJrpfAxXMqO5ohXPvmW4Jh3kNzk5o6maCwxsAgoFzFUKSJI9jjK/73Y+MKeSyg6r9XTa/THz/Cs6SG6MJigCHCOl5V9U0QMeacJRcRfxjDuuOfzlIFxNXeY1XbAK5y3dVyNNOF3aOGkR2Zm+SxcI4TAWJkI16i9HKqTHFbjaivl8edP2FXpbIR0J7YwDCMs/sGpZjOCIM5is91TyZZAu3SQpYWPMfhjgiiz6TFNmRMv3qBCcmxjH2qjnnc322Xw==
Received: from BN9PR03CA0557.namprd03.prod.outlook.com (2603:10b6:408:138::22)
 by CH3PR22MB4568.namprd22.prod.outlook.com (2603:10b6:610:168::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Mon, 2 Mar
 2026 16:32:43 +0000
Received: from BN2PEPF00004FBD.namprd04.prod.outlook.com
 (2603:10b6:408:138:cafe::55) by BN9PR03CA0557.outlook.office365.com
 (2603:10b6:408:138::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.19 via Frontend Transport; Mon,
 2 Mar 2026 16:32:40 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 165.85.157.49)
 smtp.mailfrom=gehealthcare.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=gehealthcare.com;
Received-SPF: Fail (protection.outlook.com: domain of gehealthcare.com does
 not designate 165.85.157.49 as permitted sender)
 receiver=protection.outlook.com; client-ip=165.85.157.49;
 helo=mkerelay2.compute.ge-healthcare.net;
Received: from mkerelay2.compute.ge-healthcare.net (165.85.157.49) by
 BN2PEPF00004FBD.mail.protection.outlook.com (10.167.243.183) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Mon, 2 Mar 2026 16:32:42 +0000
Received: from zeus.fihel.lab.ge-healthcare.net (zoo13.fihel.lab.ge-healthcare.net [10.168.174.111])
	by builder1.fihel.lab.ge-healthcare.net (Postfix) with ESMTP id F11ADD9C13;
	Mon,  2 Mar 2026 18:32:39 +0200 (EET)
From: Ian Ray <ian.ray@gehealthcare.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Jeremy Cline <jeremy@jcline.org>,
	Ryosuke Yasuoka <ryasuoka@redhat.com>
Cc: Ian Ray <ian.ray@gehealthcare.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH V2] net: nfc: nci: Fix zero-length proprietary notifications
Date: Mon,  2 Mar 2026 18:32:37 +0200
Message-ID: <20260302163238.140576-1-ian.ray@gehealthcare.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBD:EE_|CH3PR22MB4568:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: daebf02b-5509-4dcc-61af-08de78795431
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	Jd+3iY8PH1+D2uNrPUff4TmXUC54ZyHbRObJe+2FIz6g70rNz8qVUOKwTYI+IZlq2aZspXoCl3Syie8EVEjQGYgDwvUuw+0NCJ7m95E3M86aNk4C6NLAUQ7RL7YM3zJC4pcmrMJH1SoHUDpfSA0r0V1rxwEj0qfp0EZ4rfFOaC64OWQl5kp7yRWBvp3cl1oZ01gnMmBFkPeWRYTvobHB6roo0vIsyoqHdfD552VOtd8htqlL2kYr9LeScelZJs0hy5e/Nz37AakkcfoyNiPVWE59IFyO9HKG7VN4AZfPRScYKWf4j4BrReEbxv747f16iLnMrsNo4JdMwradtRAKUIqfIKHSXXSEUHIRtCewYlsroUuWI361VlkAKsM+uIEmU8/MVFLwsO9iCT/L7BDBP3C6QRmIycV6V8gIxPjJAEAhzl1U49QuRBH8Fs1gIgObAJxYDgfDRqzqg5snpZKpYKWPIG1QTQmYYNuu5PQrLhf1/enqtZk1flKGj2wJzv4Z8NdWb3ZgGm9NKpi6BDnS+55+S60sqPad5OcdXNoxHXnfHpQt7z7C0V6+cjpXnnhCOuBEhxdH3263GW0hbxHSGGgX5NTocIuC9FajlFfH7rGuvgmgHXsnk7MaZiyznu8NgjAmhfKDvYhgOaV0EIqWqNMTMfL2t4xviNYo5VhbZbl3XNRoZ00uLmO5rpUXWZOpcba8hZWh5y9c7KquAZ0iXBJNekOd5EuNJHB2/w461H26EYQmA0BEqaJKY8M4kUeR8QxhIpi8X8VqzK3kylGxhOi/ojv7ym2hZzlgWMwflloITy4aVF5EM+XWPa2uJeq0Kn1U2ag212F8ZvjQdcrKJg==
X-Forefront-Antispam-Report:
	CIP:165.85.157.49;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mkerelay2.compute.ge-healthcare.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	RpFqispeP+peCOyp9CT0CIJdEUo0Si/g3MHu2o5VBkdaXqSZngv/38MWnx3ZUc5Gs5/HAM+qLYhxoiR5La9eT/XDuu96KQFSwPjDc6FS8VYvokNWCHAUgS745Mb2LFZ9dXyyKPLRfgCmZENWKmmDRgpu18Zk/aLnghGvbRS7dAkQnVUS/0KQPwS5ULZ7qLSgJJ3OBF4pp4Tmsku8u5OJaxrN6mEoGhGfuPlcHdpM1DRxHUgV/2xZkzTnW+ynHv2mTTvmcMAqkmjq9fMVv+IvT8JVvMfHXiHj+LeRmBtPQzFUSbY4HNYj7WCYT9UgsN4Cd2T0Ivh7pWaz4o9IzDMJOuUQUCl1VmhcToYEcV8HRo5AAV74gksjaPHbsWPQrrVwPT6fQSCmW8vQ7z7o3tMT4J6c46Rn3TLtGtohiVk5mNzwZbEPCTrr+mCFcG7ry5H+
X-OriginatorOrg: gehealthcare.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 16:32:42.9563
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: daebf02b-5509-4dcc-61af-08de78795431
X-MS-Exchange-CrossTenant-Id: 9a309606-d6ec-4188-a28a-298812b4bbbf
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=9a309606-d6ec-4188-a28a-298812b4bbbf;Ip=[165.85.157.49];Helo=[mkerelay2.compute.ge-healthcare.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BN2PEPF00004FBD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR22MB4568
X-Rspamd-Queue-Id: 5E0621DCFF4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gehealthcare.com,quarantine];
	R_DKIM_ALLOW(-0.20)[gehealthcare.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262738-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gehealthcare.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ian.ray@gehealthcare.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

NCI NFC controllers may have proprietary OIDs with zero-length payload.
One example is: drivers/nfc/nxp-nci/core.c, NXP_NCI_RF_TXLDO_ERROR_NTF.

Allow a zero length payload in proprietary notifications *only*.

Before:

-- >8 --
kernel: nci: nci_recv_frame: len 3
-- >8 --

After:

-- >8 --
kernel: nci: nci_recv_frame: len 3
kernel: nci: nci_ntf_packet: NCI RX: MT=ntf, PBF=0, GID=0x1, OID=0x23, plen=0
kernel: nci: nci_ntf_packet: unknown ntf opcode 0x123
kernel: nfc nfc0: NFC: RF transmitter couldn't start. Bad power and/or configuration?
-- >8 --

After fixing the hardware:

-- >8 --
kernel: nci: nci_recv_frame: len 27
kernel: nci: nci_ntf_packet: NCI RX: MT=ntf, PBF=0, GID=0x1, OID=0x5, plen=24
kernel: nci: nci_rf_intf_activated_ntf_packet: rf_discovery_id 1
-- >8 --

Fixes: d24b03535e5e ("nfc: nci: Fix uninit-value in nci_dev_up and nci_ntf_packet")
Signed-off-by: Ian Ray <ian.ray@gehealthcare.com>
---
Changes since v1:
 - Limit to notifications only.
 - Rename subject from "Fix zero-length proprietary OIDs" to match scope.
 - Fixed the hardware (supply voltage) in order to fully test a successful poll. 
---
 net/nfc/nci/core.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/net/nfc/nci/core.c b/net/nfc/nci/core.c
index 6e9b76e2cc56..e95eef85971f 100644
--- a/net/nfc/nci/core.c
+++ b/net/nfc/nci/core.c
@@ -1482,10 +1482,20 @@ static bool nci_valid_size(struct sk_buff *skb)
 	unsigned int hdr_size = NCI_CTRL_HDR_SIZE;
 
 	if (skb->len < hdr_size ||
-	    !nci_plen(skb->data) ||
 	    skb->len < hdr_size + nci_plen(skb->data)) {
 		return false;
 	}
+
+	if (!nci_plen(skb->data)) {
+		/* Allow zero length in proprietary notifications (0x20 - 0x3F). */
+		if (nci_opcode_oid(nci_opcode(skb->data)) >= 0x20 &&
+		    nci_mt(skb->data) == NCI_MT_NTF_PKT)
+			return true;
+
+		/* Disallow zero length otherwise. */
+		return false;
+	}
+
 	return true;
 }
 
-- 
2.49.0


