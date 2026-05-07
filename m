Return-Path: <netdev+bounces-285264-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sA7hKHR2/Gm3QQAAu9opvQ
	(envelope-from <netdev+bounces-285264-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 13:24:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AE4424E76AF
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 13:24:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0D9C73009B35
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 11:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10B693932ED;
	Thu,  7 May 2026 11:15:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2116.outbound.protection.partner.outlook.cn [139.219.17.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E575F36212D;
	Thu,  7 May 2026 11:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778152537; cv=fail; b=csioSZauiNSISDkn+VJYy5JtxioxM0ouqPwLBm2cXLsgWBLWIH4dWTPnH9NeseNXvOC19tbnrkGxq1wA0TfiS4e233t5d2sc0d5cCiFxTcVReObyWKDukvG9ZRoANmyKUFA2+Nod4tgZ+TYwf6VSHmg8oJGvnPj+bp1a3Ewozw0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778152537; c=relaxed/simple;
	bh=0mu6UxoakgfMCFAA1LRdfrl4D/HveT1GAO/c3wow8rY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LBHXk5vzgytkBdjdgzh2og3tMNSrMm4nAP6xFQOgNnn2X7udD134CVHToUUJMO4epH/4/IWYQqjMzVBVEv9vyLYSjHEdcp+SOY4E7V5cT75McY0Q7T3dBa8ynsUz3+fhNDdI/bjXzpI2ca5A2xmc8w9DhNZ2YO5Ci2df1nmOGtY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R40vKZ5W1i9fcYYQs+TqHQwmeOkq3S7nStYszhvDdzproDF58Hd5myIHv5SERea5XS26S4NvSZtSt5JUHMDlFlJ4gUKItE9E6s7adsvpUq6Co+mH5YXeywCGsJRc2oDzKurSaeaTsNdXUZelDb9Pist+D4sGm6CyHaMUZ5NnUHL0vuwgY6X2WEGOhSjiHHP7KpfgxQKyZc7X24E2ifrZdDfqPH2TBuYtTCajllC+nTKmJXe/wA3WyobSOjDq2o7GD29a/najr+YOC8xy1SRAa+DgaqrtxQl53TCRLa0oMapgRvrAbJvt/zYiryf46SpdeVQeN2rTA5N8c4Kxfxa4xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hxJobuoN9Xxk6KUYNZ2BpZ/tx6UOqD4aMDKtmwQz0/o=;
 b=alCBUpVE2VQIM5LVOQ7l2YxZpaWsEUjJV8Iy2Bs+r6qVLaJPqXxGLQUVMgrvaUopVbuLXgp34u18vsr8UnDtBx0m4bdxBOFRzob7A+g8x04P+Fq22qSa+fXibAJqkw8vd7RTxRIhedpLhkmvoe9600kl4x5Q1ZCVqv0NKwCw7qCSfuhr3luDNkSdORFVNktPnqbmEC1MU/70Ff3IwtZZAKdfmwgdNep2IK3g2z2ZcipV03KY0EUDdqTCPAVOPDCKKpf+SQADC8K3oD1/uEPOLvpM+A+EDGcT+UZJJbPHdRVauNPC2FAjQW3EJHyafKOMotXUjmiIco3xcy64WMAwVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:18::12) by BJXPR01MB0870.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:14::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.17; Thu, 7 May
 2026 09:41:26 +0000
Received: from BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 ([fe80::e2de:92aa:4c1c:a829]) by
 BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn ([fe80::e2de:92aa:4c1c:a829%6])
 with mapi id 15.20.9846.025; Thu, 7 May 2026 09:41:26 +0000
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
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor@kernel.org>,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	devicetree@vger.kernel.org,
	Minda Chen <minda.chen@starfivetech.com>
Subject: [net-next v3 2/5] dt-bindings: net: starfive,jh7110-dwmac: Add jhb100 support
Date: Thu,  7 May 2026 17:41:12 +0800
Message-Id: <20260507094115.8355-3-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260507094115.8355-1-minda.chen@starfivetech.com>
References: <20260507094115.8355-1-minda.chen@starfivetech.com>
Content-Type: text/plain
X-ClientProxiedBy: SHXPR01CA0013.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1b::22) To BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:18::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BJXPR01MB0855:EE_|BJXPR01MB0870:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f17581b-77ca-4356-1a4f-08deac1ccf20
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|52116014|921020|38350700014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	pAw0lMVXKto9dBPD6NlaCHKfqGA0QTXAxevgt/kKPJzwNzPl94HcIcGe/BcXlzYIL6s4NN7N9ufF/cw+AxT89sApagLe/yG03uO1XvO5q2PC4y7XXKoGUHzC1hf3J8OV4qUuTU3X3A+Hup1Wu69jZLA4uzvmP86eLeSesUcOU5lGPBWCnaC8hdH+7qtBbbaYCdSE9Fm2avmPrYkgacWY+rnLn7449Zz2cKe6bml2lZO5lRIGhaL8sl+9S/iJNGngvakWWSmLOTC14D+6WPkSdo7wzwPzvuvmJRJbjH5T9ChM2o0STWqt/ZrJFkvbYr4RQbk8NNy0RItinJJZb+nth1+3m4l+Hf2k5oIAh3S5S8ovWkoNkYIXbIThqGnh8N6IBEEpJmZVSmdgt4FdKC52EJbnVeQf7MOxqZAyI7AkNLEWr+qtjDvrI4uEw5tcdquIBju+DCE8IBFzHl0xBvjLafIm2J9UwSs1RGlw7y+3vX+mJLkYeAOmxFlmzPygNNXF/DtF/dIPdOr90uKB9Bfvijyxsf4tefZpcvNgzBi2mTyD6VIkGOYjl1FSpi7tAfBGXJEzePmSpX6IFS+FsQJy/g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(52116014)(921020)(38350700014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2RZd0dj0snw65oy2qZDAfp3mrI+F3+HzmfVQIv2QqoHUoNCBDyiviGQ2mxQf?=
 =?us-ascii?Q?76vBMrfZY/akYRAk0fuHkYIexhmE8VToM0YFTPBirtEof72K9OZqPhjb70Z2?=
 =?us-ascii?Q?pbAp/lqcSDu2WdMS8qlONLW2pPcZiv1RDw+dhK3xZDnlVXSb79YjU2a06ufQ?=
 =?us-ascii?Q?MVewesLX5U0YQSAcratp+A/+oVphJUldeF3DrbHNTqQLSl4QeOSC08LqM4Kr?=
 =?us-ascii?Q?T7ONsGq9dyjG8Xtv7i4Eci6W10pghIn2dnNg3ad6wJeQUeAcoBL0kS1FetVh?=
 =?us-ascii?Q?lJ3+vycb0sPmchgeJfr/zJyyx+Vd8EK7nEP6KtutZQA/1KX+AS0bffO3rxlx?=
 =?us-ascii?Q?1Z7mh+d0MW70BkeZ2ARMcs3JSimin4OJFpq1MEuh65i7o7zpXwIK6BAK2ytn?=
 =?us-ascii?Q?CL1wRPCKjKXobG/9jwUo0kMHMsUJdtdnuUbomDTLyn1p+sZ2daMcqL0ENrbG?=
 =?us-ascii?Q?gtSLcSnCz97xrnSH/ZzJQqN/t1lB2gsmJFk/F8Ll09j4KTcQUE9NnZ9F8pY7?=
 =?us-ascii?Q?d/OzmRLzmkdrs+4Dt0gzEozA+xHOXQUEbaazxSF318xBSkBuekbduZNABeyH?=
 =?us-ascii?Q?ruY5xjIzOVjlSGB3iJwJsY1MoYgC4Zsc+GtSux2yQmNZ5N/31ReJX2OdA3UX?=
 =?us-ascii?Q?BxN4KBM2T0ymCVfgMbwnpBN5YW+DnYRDVyfzPiLqsaVcC/NTNMj/30kh9VK+?=
 =?us-ascii?Q?rALpaGmTmecL+Q41KBMeBcTyaiAWlDDr9FfaPNUrdxm1QvO76HuRAFPj9FAd?=
 =?us-ascii?Q?8k3gQft2zzkh1hx5iJgnP70BOXzqs9/aXIvN3B3L+lToTCun03rfl15//JnP?=
 =?us-ascii?Q?v7fNDuN7gTvqxxt6B2kT87Jfn18hRcX3FWmGujoIIJanwMOHHjR/iRGBVAZ1?=
 =?us-ascii?Q?REOrFgKA2aMOcd/q1zHU3ffn7NU9t+jgxdfgKw4NR+lk0ZRxL5DA/3tgwDnw?=
 =?us-ascii?Q?TRqY+USkptZt7zkMi9sOuA8HUdblDgAKIhi6dGkcrNZYDMBsjmiuXazsUIpV?=
 =?us-ascii?Q?ekT6TEXe841vR8h0ia38p11fVYcSyZOeS2mEBRJPI+v1bTdLmp0XHI+C376f?=
 =?us-ascii?Q?3IhS/yiz4/8f7oQovA+w5o0fEJBLWOf+fealxe+5CoPrPRviPnosSKuJs55I?=
 =?us-ascii?Q?b94DJxMhWcas42wPLiNn7m2N9qGgVvG3wjbHLb0cwxoK8ebEja/p5Ac12Wol?=
 =?us-ascii?Q?+inu7f3VeR1hrC6S7XcPewenzpbtkr0svDxOgJWHwAUU2WkO5tR/4L+jCOi8?=
 =?us-ascii?Q?/RA20cEzsBP1Qd1BqID1NmgrfnyVfaow3y0AoE62ex8maK9+2aGTW4DFT7Rp?=
 =?us-ascii?Q?fi5rua75gKEbTKG2PeN04xgEhL2wOWm6aCDbPrPdJ6pVaFp5QOlw12Aoh55u?=
 =?us-ascii?Q?CH2l8xQv5Mdr+AiBi2tI5SSwwaDdAf7ReiYihywdF2TFQI90H7Sb8pXjsyMi?=
 =?us-ascii?Q?mSyRFpPJDpBHRDUxuIR3ZRQSMbkBrT2FZQDmYVAnaIB/CbgOY4rQdO5M6p71?=
 =?us-ascii?Q?/LFRoaGEVX3MlXg2/rt8s+usDJeCaYJVtqpuY/n+EoYueUktVdDuQG7UE0WO?=
 =?us-ascii?Q?vf4Kct8ZOiKXE7ZvLYsYqxYO+1CZbwPd4o+MTV2iJt9DF00RL51nHf20twUX?=
 =?us-ascii?Q?pY4clccAZJ7hG5YdFyBD9cv9lPTISZFVqGQiOXaIBTpbG8L0RdzgQeMrbjmP?=
 =?us-ascii?Q?+eH/gVJzvDJ3vwPiXkmZdMeL05V3sjVtIgQIqPZA/5Y65J3hBmbDLNM1cYQb?=
 =?us-ascii?Q?J6H05vO6xx/a78g+W9I+w8nJj4IEB5w=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f17581b-77ca-4356-1a4f-08deac1ccf20
X-MS-Exchange-CrossTenant-AuthSource: BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 09:41:26.8440
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vs3T5D7DvKHTC9aNBXugzCwVVGQ/svzBt7qjmBjgNQY8fgPQcLyYpE7wcvIvdHdxYNBf4EA5c2gH9mouneGaXLENF5htdh9+8qabofLarGk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BJXPR01MB0870
X-Rspamd-Queue-Id: AE4424E76AF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [5.04 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[starfivetech.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[foss.st.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,canonical.com,vger.kernel.org];
	GREYLIST(0.00)[pass,body];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-285264-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.221];
	FROM_NEQ_ENVFROM(0.00)[minda.chen@starfivetech.com,netdev@vger.kernel.org];
	TAGGED_RCPT(0.00)[netdev,dt];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[starfivetech.com:email,starfivetech.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

The jhb100 GMAC still using Synopsys designware GMAC core.
hardware features are similar with jh7100.
Add jhb100 GMAC compatible and reset, interrupts features.
jhb100 dwmac has only one reset signal and one interrupt
line.

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
---
 .../bindings/net/starfive,jh7110-dwmac.yaml   | 51 ++++++++++++++-----
 1 file changed, 37 insertions(+), 14 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/starfive,jh7110-dwmac.yaml b/Documentation/devicetree/bindings/net/starfive,jh7110-dwmac.yaml
index 0d1962980f57..06aeaa0f6f00 100644
--- a/Documentation/devicetree/bindings/net/starfive,jh7110-dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/starfive,jh7110-dwmac.yaml
@@ -30,6 +30,10 @@ properties:
       - items:
           - const: starfive,jh7110-dwmac
           - const: snps,dwmac-5.20
+      - items:
+          - const: starfive,jhb100-dwmac
+          - const: starfive,jh7110-dwmac
+          - const: snps,dwmac-5.20
 
   reg:
     maxItems: 1
@@ -107,20 +111,39 @@ allOf:
           contains:
             const: starfive,jh7110-dwmac
     then:
-      properties:
-        interrupts:
-          minItems: 3
-          maxItems: 3
-
-        interrupt-names:
-          minItems: 3
-          maxItems: 3
-
-        resets:
-          minItems: 2
-
-        reset-names:
-          minItems: 2
+      if:
+        properties:
+          compatible:
+            contains:
+              const: starfive,jhb100-dwmac
+      then:
+        properties:
+          interrupts:
+            maxItems: 1
+
+          interrupt-names:
+            const: macirq
+
+          resets:
+            maxItems: 1
+
+          reset-names:
+            const: stmmaceth
+      else:
+        properties:
+          interrupts:
+            minItems: 3
+            maxItems: 3
+
+          interrupt-names:
+            minItems: 3
+            maxItems: 3
+
+          resets:
+            minItems: 2
+
+          reset-names:
+            minItems: 2
 
 unevaluatedProperties: false
 
-- 
2.17.1


