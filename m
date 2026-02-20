Return-Path: <netdev+bounces-259700-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sLSdDL5EmGm0EgMAu9opvQ
	(envelope-from <netdev+bounces-259700-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 12:25:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D0B6167467
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 12:25:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EECEC3009B36
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 11:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A94DE330311;
	Fri, 20 Feb 2026 11:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gehealthcare.com header.i=@gehealthcare.com header.b="LhopGbzU"
X-Original-To: netdev@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010014.outbound.protection.outlook.com [52.101.85.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA7830AAB3;
	Fri, 20 Feb 2026 11:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771586746; cv=fail; b=kWUgykZmNYULy7HYsSwQVN1fiBi5ng9PndKj1HDqEcQXxnPgNSGMhfG11XRNKxOudPohz8p3qTaR95iLQbgS/CgKf+kp22WG3q8OQKQtb8LI+kV8BwtggS8QIvhD51s/G5d6IkcaIbjKmxEqO5AHCNmNr3sADMyLDnOMVCZR8cY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771586746; c=relaxed/simple;
	bh=hh9CEB8ahZYwPAH0zlDB0wzTdaOfmZB6Li+aGp9JYaM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Q0BPeSN8ZZ0D/LisK5vCIvQaWU4fnKhIUKcgs8TWlryDIKnXpGypxeP65XB+lvDy9VUtG1EZoSqj+t9bqWGlWz0lMb6ANE+OmAT0X1Vif60dhd9oBjK6nqaFFi/I1YDwwKsg8JtiAd1VOV0klzNXB7TDG1QCrH/FfIs8L+Vy1dE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gehealthcare.com; spf=pass smtp.mailfrom=gehealthcare.com; dkim=pass (2048-bit key) header.d=gehealthcare.com header.i=@gehealthcare.com header.b=LhopGbzU; arc=fail smtp.client-ip=52.101.85.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gehealthcare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gehealthcare.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rIMStD+hrc80o8uyqCUWiqPqPCMXWiE4zV6Uu+WXqYU3SWB7v+mrQzu3FtAMqGCi1kmxfhuZyt2/8gI2rxe0cvBAHVEln9mJVcWWnEkVCSbzHfObqVmC92rgDYRGqE7s3UIb/Q3dqNaWO5X2afKNnMfXhlUqkKBVQQQqO9/LzvASnVqw6UumqZwbHh6yftu7vlQl97CTPIb3eupYuEq26KTaATGqP/NwYSsO2FBy+2BH0P210bYfpoHp2BJCti4JuoAf2SIf3jL87wpcrJztfFrRXX/r81YjBAd3ogQ5lbhtJ7dt0YkqUDSEN8pu5ZjKdlr52gfqJkRHfnAP8LyCDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xzakIiyORS+LjogTf/E3fou46lt9Zz9kFYIFKgugxso=;
 b=YMeIBgtXyKODFgLc7Uvi1NkZMXqyVakzpcongW3s5aSH3KttyScxxaRbO4JFMFAiAr7SBbhSvakcB3/qKfQyqX3SrAmJL4Et3i+ESmcROqX9W6KrqmaqGx6ImzLiWUA7n9NssYE9x2zQinOgWR8UOFBtrE4MiFRt1vX6m4TS4BK7nEQ4AwaSRR1kawChDN8mbNMI4jynckAMP47ru3QK0uOlotQuckixdBFhn/8tKsMnIE+CTdMtBkxBLt+O/6gti/uZhL5rjkGJRUtwW6YZ/rI6T3l52V0JHu56jrQQECfIP2+ixC8veQk5aD9fAwiWSMetkiFNdSbu4eX5Fos9Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 165.85.157.49) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=gehealthcare.com; dmarc=fail (p=quarantine sp=quarantine
 pct=100) action=quarantine header.from=gehealthcare.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gehealthcare.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xzakIiyORS+LjogTf/E3fou46lt9Zz9kFYIFKgugxso=;
 b=LhopGbzUQpOS67p5UJpAsN+aM1CioauFyP8DZ2t9zee0do7E1fcrGpDVihxSnHZlRvKbKXam2wdYwlhcpZF4Q1jzyI9LxYtyfn85VIBuDltcnw8zbOA9Nc1fbUDI7uxatamKj9X2wvTP73mhU+aWpDzVPtUcZaftMFgJWo5vxa6VvbCmKoEpmZZ3ja3mHK4DYK/SFrOK4gvnLjHu6z2XM2ar5c9mhIcTho87AAFgoqj5q9QTgqb0Vb+5EX7Z/dbW3taJrK27gmvJtJj9oktrST7lto+Q7+7LAO8E7mW/42QFnlX2VZB1JAad0p54S8+GovHjo8dKxpzugciMUZuTDQ==
Received: from DS7PR05CA0092.namprd05.prod.outlook.com (2603:10b6:8:56::10) by
 SA6PR22MB5931.namprd22.prod.outlook.com (2603:10b6:806:41f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.16; Fri, 20 Feb
 2026 11:25:41 +0000
Received: from CY4PEPF0000E9D6.namprd05.prod.outlook.com
 (2603:10b6:8:56:cafe::d8) by DS7PR05CA0092.outlook.office365.com
 (2603:10b6:8:56::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.17 via Frontend Transport; Fri,
 20 Feb 2026 11:25:40 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 165.85.157.49)
 smtp.mailfrom=gehealthcare.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=gehealthcare.com;
Received-SPF: Fail (protection.outlook.com: domain of gehealthcare.com does
 not designate 165.85.157.49 as permitted sender)
 receiver=protection.outlook.com; client-ip=165.85.157.49;
 helo=mkerelay1.compute.ge-healthcare.net;
Received: from mkerelay1.compute.ge-healthcare.net (165.85.157.49) by
 CY4PEPF0000E9D6.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Fri, 20 Feb 2026 11:25:41 +0000
Received: from zeus.fihel.lab.ge-healthcare.net (zoo13.fihel.lab.ge-healthcare.net [10.168.174.111])
	by builder1.fihel.lab.ge-healthcare.net (Postfix) with ESMTP id 6D9071A2CC;
	Fri, 20 Feb 2026 13:25:38 +0200 (EET)
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
Subject: [PATCH] nfc: nci: Fix zero-length proprietary OIDs
Date: Fri, 20 Feb 2026 13:25:35 +0200
Message-ID: <20260220112536.100017-1-ian.ray@gehealthcare.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D6:EE_|SA6PR22MB5931:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 6c3ae554-4c32-42a0-379f-08de7072c7cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qdtUjVWLLpjCKWdeZuyNoP62rGx5i/Qp9Aduq2gsQcH/ddikm0SnOyTsNqs2?=
 =?us-ascii?Q?FBLsML0TTd+FLB9/eZf7mL+0rtUrYqUtxWX8MTwFOj9qhuKeMAmqKomQo2F6?=
 =?us-ascii?Q?qGrhWXqblJ23R1/UMr3B1GuvTyX9ExBvlntJEeG3v+6c6G0bWiee9qWUUMUG?=
 =?us-ascii?Q?91vcbx7xgc/PZGVLft+uNroYqcFkMvLNFSEwXX0s4rw6IlNOH2DCS2tZ1Q44?=
 =?us-ascii?Q?UNLYzJuqhEr90zH+GRTsIno2ptuyKPO6zVRzNkSeHKz1+FqmIacKV6794F7H?=
 =?us-ascii?Q?GKZei1Q/aXbReF3fTyZhZktRzqXDBdR22RiGA2/qC06rlssGLk7iUD/Wct1t?=
 =?us-ascii?Q?/cksHTS0hWkR6xNlmzRRcpuqx+z9rMCQcPBgys0TgG/pkw0kLye32gxoT5z4?=
 =?us-ascii?Q?gwkKkW1i1w0KpW14YmRcWRgoLVqzPiP8r1VcaIvV6bLMpW7bKYoWRAuC83hk?=
 =?us-ascii?Q?lJ7ApvomAm4lPDe7qZg9O2erIup8XLRIsrPlaOzNMoTieivCHYDZYhutJFVy?=
 =?us-ascii?Q?uJUrFYHY7Y4tMzCHz6OjOEYVG+CFKSMJ+cULvvi9nlfqX30eGZ+y9wglAbm0?=
 =?us-ascii?Q?gvdfY7cTj8ffTpeFMWN/rN6XEZ86D/efNLeEIjyNv5MfpQT81n1lNtguZsDy?=
 =?us-ascii?Q?aO9sXaqDuKfBaErVwhUBVBoNX6UfFvq2BaNCyVV94LcBpuerwebPJ2VbgDN/?=
 =?us-ascii?Q?H9+wjcrg/+tO50xjJkc0wTwOK96hbGEbPDtvViIVOTh+sJ5c2B3AIHcu8GQo?=
 =?us-ascii?Q?tqJutoPjKL5H5soTgbsS/0qSI+ArRmtaCHY2I5KXfjMd5TlI5AvRR4hTuAWm?=
 =?us-ascii?Q?NUmJnfuV/EZtTt6R5RmkQDaAgqiDYqpKtonfcf96Zx5sNPIhirP1mK4+PHRj?=
 =?us-ascii?Q?e9iJ+hytvSw5h1mSqAnFerlQBb4kgOWR7CL5fMGYbcNMvRE6sCRZta2XFWQ/?=
 =?us-ascii?Q?niAiWFm9nzgXyNs3316YToc9IegmfEy0LEPh80KmSmILGBBAMR8f40J9rzBg?=
 =?us-ascii?Q?wA8YoxvjRKIywR55uTzQxCGkdlnBviUYrkTJPEvCG10brwiIoGfp5euxneqg?=
 =?us-ascii?Q?FYUToqcGPDJklhQCJh1jClmmZZFAW+NxK8v/gTrmh0qyXjTyWGZLjZNnxYVR?=
 =?us-ascii?Q?h+/S2qh+tM6w+BSKqAx4Sbz0VzEivmpCnwIUcVp2/RTth23EPbDt1Eh71TvA?=
 =?us-ascii?Q?OZNQoMJhy0eeEJ8pJo3D8kVNW6kxBHRHp6lPC4ObqNUYNrqvEAFzVikF73TN?=
 =?us-ascii?Q?VyDj2itIonmk8Jx8J6Eyxgzl8o9ont2LGt6Vflm6TgixLG6VX1B/PIDvMDlY?=
 =?us-ascii?Q?6VBlA+9Zt3UKULv03ebloZmpqfz6dA345nV9r7Zjvj6BfH53kmidRtSpJWPD?=
 =?us-ascii?Q?92LWZNeQOYmutDT5BZDWGkyFhrMBmIBDbnGA5LJXLAchhh58AaeUD1Ga+cRE?=
 =?us-ascii?Q?Jnv0OTLwu1Libu4nNwAr0XOufvoVlSjN+dTH9J6JK3ZLEoqjN6mdvcFNwRge?=
 =?us-ascii?Q?9+jrwYtuGd0TBiKm5mKEENlgUv/mXHFcr1lV06fdhlfEt8/l5rchl6SD9Hv6?=
 =?us-ascii?Q?Ys3CMsVkscD2KgDaIGzxXZE1RYgbcFKs4RKrj710hUq1Zfuzs82342geiEaA?=
 =?us-ascii?Q?lpoIFgCag1SUQfbV3u0oFzgf19xn8LVHm4tR6ByFFMzDgQ1gjdz1DmXNKiJE?=
 =?us-ascii?Q?Jh/wIg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.85.157.49;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mkerelay1.compute.ge-healthcare.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	G0bF6Bo2W6Waqh2E0nqL/91OzFj/vMPVIp5vFDmLBFezIcwiPI/+PxrdDXswikSb/LSv2juv6guHQj1hvP3venu/sJLi/1xsxoFkJtFQ/YoL0+4gSB7YCx4UlkApHu1Srq7przexyXEJBuWRbPP6QOxz0gmxU9vS9sxHpO5NDGKcyPOn45Eiq39sIFrnRvQtUPuKlaFZa0xTkT7FeK8UgUVNLryIZlTrd1swwev7XtjasnTgW8Qsq5XfCzjKPNkACRMPBzBzl8ILdJL71LukLIN8Ra/XBMAUQCJMHCzKHtWJ1AViyy/zSC3NjLIHkqOM87oE3zoAeR+hg7xcZT2it0OtU3uCbTaNX6mDkB8G1HB8SgADBg7Q3q7R7dy8q1SfuKZmr2iTp0UIXt4k1ljP7/kOoRSRgGOt3WDoz5QOk+aJFSum/I9qc5J2SgtMPO8r
X-OriginatorOrg: gehealthcare.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2026 11:25:41.1710
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c3ae554-4c32-42a0-379f-08de7072c7cf
X-MS-Exchange-CrossTenant-Id: 9a309606-d6ec-4188-a28a-298812b4bbbf
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=9a309606-d6ec-4188-a28a-298812b4bbbf;Ip=[165.85.157.49];Helo=[mkerelay1.compute.ge-healthcare.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-CY4PEPF0000E9D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR22MB5931
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
	TAGGED_FROM(0.00)[bounces-259700-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gehealthcare.com:mid,gehealthcare.com:dkim,gehealthcare.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gehealthcare.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ian.ray@gehealthcare.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 8D0B6167467
X-Rspamd-Action: no action

NCI NFC controllers may have proprietary OIDs with zero-length payload.
One example is [1], [2].

Allow a zero length payload in proprietary OIDs *only* - note that this
change does *not* impact standard OIDs (which must have non-zero length
due to the earlier uninit-value fix).

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

[1] drivers/nfc/nxp-nci/core.c
[2] NXP_NCI_RF_TXLDO_ERROR_NTF

Fixes: d24b03535e5e ("nfc: nci: Fix uninit-value in nci_dev_up and nci_ntf_packet")
Signed-off-by: Ian Ray <ian.ray@gehealthcare.com>
---
 net/nfc/nci/core.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/nfc/nci/core.c b/net/nfc/nci/core.c
index e419e020a70a..78da0fb9ef3f 100644
--- a/net/nfc/nci/core.c
+++ b/net/nfc/nci/core.c
@@ -1482,10 +1482,16 @@ static bool nci_valid_size(struct sk_buff *skb)
 	unsigned int hdr_size = NCI_CTRL_HDR_SIZE;
 
 	if (skb->len < hdr_size ||
-	    !nci_plen(skb->data) ||
 	    skb->len < hdr_size + nci_plen(skb->data)) {
 		return false;
 	}
+
+	/* Require non-zero length for standard OIDs (0x00 - 0x1F).
+	 * But allow zero length in the proprietary range (0x20 - 0x3F). */
+	if (!nci_plen(skb->data))
+		if (nci_opcode_oid(nci_opcode(skb->data)) <= 0x1F)
+			return false;
+
 	return true;
 }
 
-- 
2.49.0


