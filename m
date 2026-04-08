Return-Path: <netdev+bounces-276365-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KB7MLiwY1mnwAwgAu9opvQ
	(envelope-from <netdev+bounces-276365-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 10:56:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6583E3B9646
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 10:56:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D7B9730413B3
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 08:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16EFE3A9018;
	Wed,  8 Apr 2026 08:44:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2103.outbound.protection.partner.outlook.cn [139.219.146.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A2D3A7F74;
	Wed,  8 Apr 2026 08:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775637887; cv=fail; b=TMmGltvzN0ZaFyVlxm9p5l4goivRusQ35HPPYiu15PQwHQL4m8EHM54Lu66I4EBX9GKkxt5ykEyi605oNby/80eEkeKc157eNvKefLjQtETI/Hsfp88k2h1PIQfvUAfCVwMIyAu3nkoz3xl0RgItLbWwoBai1Cpd/L8ZngOJvwo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775637887; c=relaxed/simple;
	bh=gGWc77kVBubvsONpOHRQ0vwJx2ui9h+GJ7IfhQ7oywE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cVUWvbPnGvHDrIwcxVu7vSga+DUU+hrMetRIuk6/sLziB7bA6jg7DaMcstC1qqz9ge6TtW1ZwLXVxFF9tIs6E6IUy70OkVfu5c9JPOdvM3EA9ihTulfG/9AyjD8n967KsjrGz6hFc06pb05/HuN+gjWSSLefu4FR37661lBesnk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bxzVJAKy39PSUOXtQzRtqxoLQRuTsQfw8sogKCWvU62QXa71bsX/dT1cMFSfXvWI+5tV/hTzh9ycUPl/R0A+77+rh94UQaB3mCMFyT2bRuZqWtl8/cd14ZUUplCyFwBI1PDCIvw9CEg5Y2GykTmApJUBh08/xNqcDBhF/OIaO4/pGJkE19hhUd0JodYbRmQNzmxfVQybUCYagS3BnT0y3BNaQwF58phvhL4sg9Eo/px8RZBVJzVaIEG88G4u4PAJAVDQpKS7towHpPvZ5YOMQGVntcjXLKVLKBSbE/uMdol+OlbTTa8tqn/SEsOr0hPwHN5waD3G4wBel956gpfa9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oXuuOMHHSfUu2UhzVV2gR81hJAVgoA4523Wl5PEofZ8=;
 b=Ap2wkSQhUoNjQ4CyJ2BEv1AyiVsa/hCXd3d3R/PIG5kb7QSY/umWT57RrbyH4BrHWqOz6UpO0l53buyN+Cz7iKEIhgYIhQy0vKqebCBGphZKSN6M252SRJ6FnZplWEsuChDKq2pH/k8tSPB6QoFKGIUOm0Q5m7ucSO4hzweWsBs7hz4Ji3karTJ8VxxUkNKUDnwzSavbLkyJn2zhUSrMLflrHbE48h59i1w29kZrYtkdvJ4A0zLELkzbVKFv5Uf05N97SRhnojt/OGJIo6ub0SjTPZnMuzkA74EbMEbgXrtS2Cwcnkw0oJ5py+efjRuIAkAg5MvOmxV5O9+O+MKZ4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0719.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:26::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Wed, 8 Apr
 2026 08:44:29 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::9b99:12dc:a115:b90f]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::9b99:12dc:a115:b90f%6])
 with mapi id 15.20.9723.018; Wed, 8 Apr 2026 08:44:29 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor@kernel.org>,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	devicetree@vger.kernel.org,
	Minda Chen <minda.chen@starfivetech.com>
Subject: [net-next v1 v1 3/5] dt-bindings: net: starfive,jh7110-dwmac: Add JHB100 sgmii rx clk
Date: Wed,  8 Apr 2026 16:44:14 +0800
Message-Id: <20260408084416.29753-4-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260408084416.29753-1-minda.chen@starfivetech.com>
References: <20260408084416.29753-1-minda.chen@starfivetech.com>
Content-Type: text/plain
X-ClientProxiedBy: BJSPR01CA0012.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:c::24) To SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0863:EE_|SHXPR01MB0719:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c490310-6a4a-491e-ca91-08de954b0c22
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|52116014|376014|921020|56012099003|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	LJi8nXNHdW8kETlRdF9V3YyRRIslCAwcn99eCH/RWLYCjydBtd/QiQ2aP8MF7+VxL+uY08zdlQBTJp+yVln7C8sAW5VboLwe9SMb0iLUnAqntGorzonaz0FJOYpNokCcGEfWnaeQfOeD+UzwTzwGkmbnxx9iRyxazVBY0BttDH4bz2ygpjEwxxRZ+iPjeXcbHZ5gc6C551y8Tr3T63/n0L+IkkqQ4f4Cq1yHX23pcnxQ0i9tYaK1CuC6RORLxo3tQ17p/aklfPzczNTd4AJ+3Gdvzy5jXPqzaWNYzQg9yGIdWN2XST3yGhFdCWi3TeyLpv4qc/iF0VuIBD1+ilAN4pxCVvobi5ud2sXKpez9qfkg83ZfVN3gwVrQvkztttW9q3ppiZNXRb5Tc/aFTfaY6HGkqz0HiW53JIxcHEd+9Oe3zDhROd2zFzYzI1DVZ5UIqea3siDLPoL0v3sKIL4waRLRTThKKDDcz3YKnStsFaUmSzFqjt09fB98y2vM4wjf+AvTEC/WyD8qQPMdwM0WOy0q1Lz8O+GGu+ZV6Af4v4v3CK9xt2+ozaD0GGpZ2zFVoiokQBD5TPe0tSKV7v/9yoLiC3dD/aiDhplYTz5Fm/E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(52116014)(376014)(921020)(56012099003)(18002099003)(22082099003)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cac+75mQhusAuE6aDnbY7DvIWUT53/oGaLuyY666boa3BcnaLEyz6DpxVeov?=
 =?us-ascii?Q?p5+eW+hFtGgKEh5+OSobD6rIS5AM24vaLaFRwVAeDeyB5mHDYwKiiBY0IF+G?=
 =?us-ascii?Q?qfwho+aCVLEiq9OHSQreoe8qxKbh0V2kN1/9/E7dM7pu0b71rBKk1EnbxhnW?=
 =?us-ascii?Q?HEXNvxozdWe+Gih2Cnhj1dBuYoKSdHlxrsv3hJqinDnCPwGy+2GstP3NyZeq?=
 =?us-ascii?Q?gUlczVFBLp6lTDTf46i6Rl91hA2yfYXt/sTjZOf6xqtC0FwBdeWxC6D7P8eG?=
 =?us-ascii?Q?xOU0CV+hseHcyMVoU96BuH7E8CEAx3C1YODbBAp3pJrLlqps1KOM2lt0lM38?=
 =?us-ascii?Q?T+Sy+K8AXxujGQNXrHrXqnL/nng89PGEvGfB07CPNk4OmAL7EetSLiThUlvg?=
 =?us-ascii?Q?I5DbfE9D/gtySIGWZMl00ATdUPsXMQtQMokPwH6U09UOs3syx6r8wRntZU+M?=
 =?us-ascii?Q?1QSV6RYn1euNpBgTk1LY0CIpAVsspRsdAHXh68ovqVeiEaZMTXhNgsz1TdYf?=
 =?us-ascii?Q?jzzEWWXrGcUGWKN4GNOYAQKzWLyRJY2AGSmKoioO4MZ1m00kLcnSyRCwZgL8?=
 =?us-ascii?Q?9WbjlreWwA7ivAv62q8vzVb3IJDBFLuQLglbgdg9nMYQtYbEz2s3J8P2i+wQ?=
 =?us-ascii?Q?zxu64aJK3wxbhvbApqRzR8ZXMDgrkbg1XfMeOyqu4l3NBSGnPAd1HF7qczj1?=
 =?us-ascii?Q?QQMtxBHsi3HpAO9A0Rn9EJ2AE5SYDNk47Rat1P598PW4L9sPym8/Fs4Iesu0?=
 =?us-ascii?Q?8oUKQUUcZuKYRDuXUZ3YNjc9AOgAY8RskPVvEihwGG0IAMJzh1MpPXcDX4sO?=
 =?us-ascii?Q?s0yHXOXc4TJbCe50LhofpleHrtBGKVyrBeDjJqBB4vUmmoSuncwyknnKI0jB?=
 =?us-ascii?Q?s0xNFBn2lEahtYJXDt5tRWboHHjyPehqbJyYLPo7aarMalD2La94zBIHePrH?=
 =?us-ascii?Q?kSJUeXku3EkN5o+bfme1B80hCerhv7TV3tl73ySPAuCiORn0hy+/hftHp0gF?=
 =?us-ascii?Q?iYc2MLP+A4lwhOqpAYorH1FDtKmU66tg8ab6eXomnaxv7HRi6aijhtWsHlDh?=
 =?us-ascii?Q?jjJLrrzBLNt0D4kpmXe7zVOdlfeJNSGXjT0ku2bjW904YfixgKrp62zgRioB?=
 =?us-ascii?Q?QodQqA+Msz9kFdBI7exFRVG7H2quOlfPEde+TCOyAEMP5RysiQk0fEaedBHE?=
 =?us-ascii?Q?U8O+C7ftA+TZuL0sms+Pm2THVc+reWUIGSi/z6B76YfADndXmTMvlaBY+hj9?=
 =?us-ascii?Q?RdGCF6QcKsnBsFHG249lauh+dQDMIr6hAH17tJRBb0eTWJ8eP3O82KgtWJ2a?=
 =?us-ascii?Q?AQTXiYAHOuKjhSeRKPugvOhf+R4QEDnxLmMRq/5K/ig5CfvhUPTiYj+ejdZJ?=
 =?us-ascii?Q?GiWAKkH+u7Ni7VqU+U08oKAa0s75z+cBaqE6deK9V0+gMb0oS28Ew0qNBqQT?=
 =?us-ascii?Q?9mx2AOTyhBNc0131PMQ8c+Dqdc6SFHrCLEiRF3gv4sLtSY3DrwYJpBd/Fbyj?=
 =?us-ascii?Q?8nMWXHSqSuwNJOIojFSb5mBz63oYilUOJY8J59vTFSgwE/MJUjOnhCXPY2k0?=
 =?us-ascii?Q?SdahGpRcjijfJ1ejzAPoQDsLIytyy79GytrVvdaUNgYn/MnucVYWrj6SykPW?=
 =?us-ascii?Q?tytV4LWMmlaboCEB2Em0MF+T1VxEaOm5sGAhpYEBMwJVN9A8Xu1MDexNRJvR?=
 =?us-ascii?Q?BiM8gCegj8hh9o2xEiZ7mv44VqP8AyngMWXFHcC9PcjRj7WKfNptKJ0CfCuX?=
 =?us-ascii?Q?R7xDFNHAFU1pOxAgxosHKvWRCJHl4sU=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c490310-6a4a-491e-ca91-08de954b0c22
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 08:44:29.3291
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PFncX8EzwMCe0IMuQCygbMmAlhxpTUhjRDDxKEOobDIEpNp7kdLFXS+20uLXVmCdEGovGR3soDx+TGj3d6gnjsjD93Ys1O0FJ32QyLfVo0g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0719
X-Spamd-Result: default: False [5.04 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[starfivetech.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[foss.st.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,canonical.com,linaro.org,vger.kernel.org];
	GREYLIST(0.00)[pass,body];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-276365-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.545];
	FROM_NEQ_ENVFROM(0.00)[minda.chen@starfivetech.com,netdev@vger.kernel.org];
	TAGGED_RCPT(0.00)[netdev,dt];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[starfivetech.com:email,starfivetech.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6583E3B9646
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

JHB100 SGMII interface tx/rx mac clock is split and require to
set clock rate in 10M/100M/1000M speed. So dts need to add a
new rx clock in code, dts and dt binding doc.

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
---
 .../bindings/net/starfive,jh7110-dwmac.yaml   | 42 ++++++++++++++++---
 1 file changed, 36 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/starfive,jh7110-dwmac.yaml b/Documentation/devicetree/bindings/net/starfive,jh7110-dwmac.yaml
index edc246a71ce3..847d67a2c1d5 100644
--- a/Documentation/devicetree/bindings/net/starfive,jh7110-dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/starfive,jh7110-dwmac.yaml
@@ -39,20 +39,26 @@ properties:
     maxItems: 1
 
   clocks:
+    minItems: 5
     items:
       - description: GMAC main clock
       - description: GMAC AHB clock
       - description: PTP clock
       - description: TX clock
       - description: GTX clock
+      - description: SGMII RX clock
 
   clock-names:
-    items:
-      - const: stmmaceth
-      - const: pclk
-      - const: ptp_ref
-      - const: tx
-      - const: gtx
+    minItems: 5
+    maxItems: 6
+    contains:
+      enum:
+       - stmmaceth
+       - pclk
+       - ptp_ref
+       - tx
+       - gtx
+       - rx
 
   starfive,tx-use-rgmii-clk:
     description:
@@ -99,6 +105,14 @@ allOf:
           minItems: 2
           maxItems: 2
 
+        clocks:
+          minItems: 5
+          maxItems: 5
+
+        clock-names:
+          minItems: 5
+          maxItems: 5
+
         resets:
           maxItems: 1
 
@@ -120,6 +134,14 @@ allOf:
           minItems: 3
           maxItems: 3
 
+        clocks:
+          minItems: 5
+          maxItems: 5
+
+        clock-names:
+          minItems: 5
+          maxItems: 5
+
         resets:
           minItems: 2
 
@@ -139,6 +161,14 @@ allOf:
         interrupt-names:
           const: macirq
 
+        clocks:
+          minItems: 5
+          maxItems: 6
+
+        clock-names:
+          minItems: 5
+          maxItems: 6
+
         resets:
           maxItems: 1
 
-- 
2.17.1


