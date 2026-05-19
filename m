Return-Path: <netdev+bounces-289383-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KIYKBt85DGp8aQUAu9opvQ
	(envelope-from <netdev+bounces-289383-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 12:22:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 866FC57C21D
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 12:22:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3425630B198E
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 10:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E304B8DE6;
	Tue, 19 May 2026 10:15:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2094.outbound.protection.partner.outlook.cn [139.219.17.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D8E4A2E20;
	Tue, 19 May 2026 10:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779185719; cv=fail; b=V5gwHsOgD1kBgmRh+gFu8RmlWY2VSmr6p6CzS6OL2wLP/2cahO9T46REX1JkBxutldmUSGJ7dvkD+XbiOrUU08mkeWf595htgphRuyCIRrIPxzd9gZ3IjcFqyY87y9bo4twEzoH/UTlvWqTnJFynq4VmxJQ3gq+ZqQwtv6DQekQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779185719; c=relaxed/simple;
	bh=CDRer719KYGVwVtG52U+ad/PqaviuaMP3OV70A4F8xs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PQctUF1NEv8r9IuLVoKGDHwt1RmKBm+Sbcj66j/UOTYqSHPnoiUGQBVKwAkfuhh7+6vRfZjmBytHbTwEGREk5//B+IB5inciFpXONuALJU1WQ8dwfpwM9yvs5o1EEHfTtWd3BElxM6QyLK5Gb0QQ3vdBq2ZrYFOTA3KgPrBCbYI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g5jQoHMttqSGr9TJTGxu4UPg0ooJBc/cxkUC52r/5yvi2l4kF1+7eRHGaLnXZU/CMnwsd42bdJLlr6/rn5VtGC1LjyYKbcIeqNoXmtz8s0n5B+NuuFwEoeOqr7CVhqdb91E6JqG3IpHF+R1CE29RklYrRXx/gnbRDTh63Q1zYHZAYS6Fqhbk6Vib88HSCBJvbpJW4l7k0OgxqsPlLJvf8+bwLT8VG9Ip2kkCTGNdaq1gzlJolUesIVYo21NjJuDNLvRKO6fvRuUO99Dq8yriFMlBdGeocGRx8PbcDZ0h/0CtV35ypOTOP13pznfEDJmeUwFYpgT53KFHZstMBikR5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QSuTNxaOHK8IF2jEPBALgIgPSk7URmKKThqcy8k3090=;
 b=l7azWNpmRqZGDk4qSNO8Z643ZHDiZyMTINO28PLMk9zt1kjeZatlTVtk6qt+EX13G3WyDry0xrph/ouEOHEUwOWuSQmW1F6FkBGAhhfkH5Y6aK94uut6rbrefRjbsQ2l9FPuDgbuoMdOEAkNmeNYAeisgfaElm37Yws5ck5qouC/il5J1p4AokO8pWZC9Jrzu6f3B1RxVSQ0OGnfmLrEmOncE/7nsead4Wp8iNheXGSB/HNtlEqolscw4voL4iJ/qbrX/SdHFCm+4Cd0Gq5ticFL7Kap6mOkkB0zZaXZ6Z7shWj9k1heW5Ub1KGkDM+2qEoF1/4leqHDMQpFag6C4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0493.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1e::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Tue, 19 May
 2026 10:14:47 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::9b99:12dc:a115:b90f]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::9b99:12dc:a115:b90f%3])
 with mapi id 15.20.9891.021; Tue, 19 May 2026 10:14:47 +0000
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
Subject: [net-next v4 1/5] dt-bindings: net: starfive,jh7110-dwmac: Remove jh8100
Date: Tue, 19 May 2026 18:14:32 +0800
Message-Id: <20260519101436.111476-2-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260519101436.111476-1-minda.chen@starfivetech.com>
References: <20260519101436.111476-1-minda.chen@starfivetech.com>
Content-Type: text/plain
X-ClientProxiedBy: BJXPR01CA0056.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:12::23) To SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0863:EE_|SHXPR01MB0493:EE_
X-MS-Office365-Filtering-Correlation-Id: b96f248e-4cb9-450f-8271-08deb58f7465
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|7416014|1800799024|22082099003|18002099003|56012099003|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	j7WelhQlnxt8CkMmTmlKTQ/ghJnH0Ggz8Rz7RjXni2tciI0tGqE9+eNwVjGeCdVD46EH9OY4BxsoW2mqDcIrMH474VE/yk+i3l+J3VjwHCreiJicVCSXRrzek2C02B7dqRxKCZr+0Ulj2p/wwzfs40lygF51KcFr5HCRxrOeP7IQLbhvN22SO2OCXNwqQIfQA6DOdS4pxqVUf4iEWUxTlo7S2x/rTyncAyoGTjkYTmH5rzBqoCsuJhf9vj/yf1vQUlqE7cPDruCcCxlUJXQX7lgnz/zc9+tRYRBjQtSuDcmC1Mi8Vv69A+eIjr6F6KWPX70ycHdenAIyd5OJyUEHBjrf9+G+AxGq1jqCN6sZcMZjVc/RCMYLEp/IsCxIE9eYmk6mencGVpqV14I8aQliVU+dYe+sgNBZrOVz2vM4ZZ1buzB9E9ms00FHtOYmHGiWoDJQ6i0ISAMg+YjbeMWqsQaO7GQ0WAZCvVgp+lPvdi9lPyiVAN+sGbW9MC2hbmvS0cHd41RV0c4hS1JatTmpjrXM+oBzNpT+yUy3UIE0RhrUlPmLje6k4JKrIOA3qeDjtZAxq39mwjXf6zCKO6tfTg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(7416014)(1800799024)(22082099003)(18002099003)(56012099003)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ky29SXzH6Z53fFqLjEINbECKuW5W4F7DRo1V56ItD4oX9ypxwsi+jKG/EjVi?=
 =?us-ascii?Q?1yVtZ5na4Jfs3E/6myDKeDJLD/9hNHjItMJGwjZBD2nyVC20rwfFO0PVxSwZ?=
 =?us-ascii?Q?so21620VoJU8ClqHsjVmAfHEYj2azY4oiPhgbQLiCrNqrTQTpHbVqWhCiKLj?=
 =?us-ascii?Q?1MH++xaYqx+pEqez5UmfHwuePAcnJa2YQQ3uU7whRGfA0UB5FPRMCukD4kzI?=
 =?us-ascii?Q?LBbgrQicfcNGIYQeb5nSXQlVuhDG1jZT0Hhcydn3Xj3QsuW9+m3ks8h/hecO?=
 =?us-ascii?Q?gGaflyjFxhQ3B2dzkzO/09O7kiTTSC02vnFY8Je99lq3uk4w0N4ibpWQ5OtN?=
 =?us-ascii?Q?AXPLB6zfDngk+OYkjeUiODz2oWCzu+ZuuB14BnXyxn4hDfiVVHdrbwq/TPwl?=
 =?us-ascii?Q?brG0vC1/NB3P9mu1mbFhKEDXTFiUaRM4/EzTP3t8O6tPx3Ek3LD2XwJg2yPc?=
 =?us-ascii?Q?rLi4q9YAAoAO6vIsIC+UQw65WzQpLGUtc3vPDMDUUu2AS7t3HR7FkYQ5Gxep?=
 =?us-ascii?Q?WvajBgeuvmUzravigeT+Rb3BpYd8IkLNFSjZkv+rMyn7WDHV0QLleVQFSpBs?=
 =?us-ascii?Q?j4HnozAjxbkKImmidDEKkBa4vYpjOACSmo0tBa4xeLokBpxUPmP6rwQDZh8T?=
 =?us-ascii?Q?SSmsEd8QU//8Up5OICD/bOWDs37Mt3nQtvcRWFCdhvs0dLL1qiiZ42LHoLiF?=
 =?us-ascii?Q?ykqj4eOKE05GxsvXqcmuF8iAcwj8rH4Hdx0NP3f0B/O90JfuTx41iwuiMxYI?=
 =?us-ascii?Q?tmTBrPBe6vbEYnsfHNB5k7rfoCArq5cLQpzJXw2aiW6WFqaxUA/3dBR5fS4I?=
 =?us-ascii?Q?+TVAA5hgPOjmnDgJasRK5wmRzK5WnKz2tsqt8qF+dnbXk4rIwHcCk2NDcOjs?=
 =?us-ascii?Q?m8SqYa4Ycf6m7/JXqP0aDt16Cmccw2moP9mYX3qV13CKjWl87sunnAoSR/Tx?=
 =?us-ascii?Q?xcatEGqjYKYXnH/ri0Ca+PnB1YFwfxl5+84NaN8TvSrZFOR3vbR1Ju/ZYu1e?=
 =?us-ascii?Q?mpkm2G7xuzdoW1I4caKQla+fJLO96ZjQVwLnjKgh5iQP0sLnf9aLJ5wxmsZj?=
 =?us-ascii?Q?AdbFjVaSA77Q4JzErPz9bvNwKitilKiyQknBQB/LbwAVpTrLqbu8aYr27SSh?=
 =?us-ascii?Q?mBC7FzFAEzIgJrB7l1ag3TMGbu9x++CTDUgZAZcwYoxfHGSQAqEwbMUMzvH+?=
 =?us-ascii?Q?8f2MB6XYUpJKZX3wFZS0WblxZpTJRxIw4flda8vUk1zA5Oiw9gP9uWk4jxEC?=
 =?us-ascii?Q?foRWN0HuKsJ8EnmlZMqyvQm6DBeUUINL1ItPmJ4ZFEpSP68pPxFqhF7ib6tj?=
 =?us-ascii?Q?GVvJgTpxoB+u5KEcHOOHoNOkO/FFy4wQDJz/nfapjWooxU+YfWgrZUQtp/xg?=
 =?us-ascii?Q?ku350odjI4t7Z8TbNzgpFKZtkKiN/+UyCGLqa79CZVJAK9VQsQ6AQRp/vB7S?=
 =?us-ascii?Q?RGTOgQp6kokUjjJsx0Y3b/tFOPBPp/UYUoKt9yGpIKJlSboXX0ym21nEVlEj?=
 =?us-ascii?Q?nlwAqyn9szASXmTgUW6YTagE/xNjAdO49aycUI5NxWMbk7U+mPPjf+Giu4DX?=
 =?us-ascii?Q?c6FJLuQATt7XLJTOxT6hlYvSAyLog7t1XRM26dvcTI3krz6oSV64UM1q/YnI?=
 =?us-ascii?Q?5tcTy7dKXB5Gtp0tiSWrthIDibH36ZA6Bu7QnPgXNmekEeMpc2CwgzhX1f0Q?=
 =?us-ascii?Q?S/yWXYjCw5/7ovREkhywIoDBR0YS8QZmZ+b3Tq002I0elbzplmNUNT1n8jTj?=
 =?us-ascii?Q?Bzzs+tWLRQDo4VslYshNkwXv8X4z8C4=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b96f248e-4cb9-450f-8271-08deb58f7465
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 10:14:47.1976
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TVOvyzsilFa+HV+a9KdROQOok4+0uiA2p2Bo2LY304pyP45dpiUroAWFSWACbIfEmc0NWGIy8pPi/FjQY0YGk8Put+DgxqlvRdlldW4hoLU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0493
X-Spamd-Result: default: False [5.04 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[starfivetech.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[foss.st.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,canonical.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	GREYLIST(0.00)[pass,body];
	TAGGED_FROM(0.00)[bounces-289383-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[minda.chen@starfivetech.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	R_DKIM_NA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[starfivetech.com:mid,starfivetech.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,microchip.com:email,lunn.ch:email]
X-Rspamd-Queue-Id: 866FC57C21D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Remove jh8100 dt-bindings because do not support it now.
StarFive have stopped jh8100 developing and will not release
it outside.

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 .../bindings/net/starfive,jh7110-dwmac.yaml   | 28 ++++---------------
 1 file changed, 5 insertions(+), 23 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/starfive,jh7110-dwmac.yaml b/Documentation/devicetree/bindings/net/starfive,jh7110-dwmac.yaml
index 313a15331661..0d1962980f57 100644
--- a/Documentation/devicetree/bindings/net/starfive,jh7110-dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/starfive,jh7110-dwmac.yaml
@@ -30,10 +30,6 @@ properties:
       - items:
           - const: starfive,jh7110-dwmac
           - const: snps,dwmac-5.20
-      - items:
-          - const: starfive,jh8100-dwmac
-          - const: starfive,jh7110-dwmac
-          - const: snps,dwmac-5.20
 
   reg:
     maxItems: 1
@@ -120,25 +116,11 @@ allOf:
           minItems: 3
           maxItems: 3
 
-      if:
-        properties:
-          compatible:
-            contains:
-              const: starfive,jh8100-dwmac
-      then:
-        properties:
-          resets:
-            maxItems: 1
-
-          reset-names:
-            const: stmmaceth
-      else:
-        properties:
-          resets:
-            minItems: 2
-
-          reset-names:
-            minItems: 2
+        resets:
+          minItems: 2
+
+        reset-names:
+          minItems: 2
 
 unevaluatedProperties: false
 
-- 
2.17.1


