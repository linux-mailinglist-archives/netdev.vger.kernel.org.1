Return-Path: <netdev+bounces-297510-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0y60CLcdKWrEQwMAu9opvQ
	(envelope-from <netdev+bounces-297510-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 10:17:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B52B86670F1
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 10:17:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=starfivetech.com (policy=quarantine);
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297510-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297510-lists+netdev=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AD13B30707D2
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 07:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9901C386425;
	Wed, 10 Jun 2026 07:57:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2099.outbound.protection.partner.outlook.cn [139.219.17.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1010638E8D5;
	Wed, 10 Jun 2026 07:57:20 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781078245; cv=fail; b=SPT20HzKw/K+Sim47Vvi/ItLqQLw2mp1IkefpK+ry46RlL1T5VLSzfqon8+6nXmg9ZQk13Ut6JLLFzJaKLfe5Q1oAV3AUnzxPc2ZTBjeqRsWw7Z1pKV9c01eV0J5qXtNnFJOzjPO734tPI1ayQCSTECinQ7XiPHA8BP9CRYXsbA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781078245; c=relaxed/simple;
	bh=iIml7kccP5nuQ2uRojIlynpb7o6vFmD7IWmKuogVP70=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=P8up8jZfrlrD5DJRk7jIugyBDbiykfRXYgEde8pwTBATQdHI3fPfBWkuvUAiOK2fXSL7tUvdxIpikhUomGP8WDWriLmIowdeEp/cKZqoiNPqmvqht3yhEbNhl78MzV5eiTMsOjbDw5ekq5m0wYZfpw1JD6nCNNkfSAuhH9iSADw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.99
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kxFN7tjzAzEhImWILdPqsdbRUibYTAwp65aVSHgNcEDNI/0vbYg4FvuDsXrZTdVRq6ysT3ZsjHWgC6zbvv0o1yFCXraPcHgbDlBFAttIh7hQBp83fxq6tT0wjUrz4qP8wqAaSaRQbbIWO/tYg48Isaa66yez0i4tW+BxVQQDit6JyLVz8R75JqDldI7x+WK/Ysd5zZN71J9L8GAKqQaneyYdOndDEIAh3MM29o1XGLCydu9l5bcDP0y8jzcR4zLUd1WWEssRRj9qVgeUVxV4cMuwPg9lwGXQKwhweVOZoGml1CqSVAIh+l+P2nnZ8c+rgTxJnPyL90wAVBEPVN1RKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4JYXBn8J+9amx3bg18UuFn71laOFFp2Xdr4b1HpjFgY=;
 b=LZ1ev/I48sVjZD32qLbrN921EwRQ+H3UizHXKAkdtDTeWL/B0N0QZJ86023URk2ydKjTcPYPMawVfTiB/HJUkXT7i3pc17qmhId2uKR27gPq7tyrZqmPI1KLSuv5c6ztf8X6xFGNRqFIa9aFNWBBv874UssKD7Rak99p+iOvvq4zRLbDLVi9u5GV68ItRnYwOLrNkHP8EIkzr6lK1wpY3qzxTZQ/nsZ55MqOvVAndWsl76uadgFw8rek5JzwxdnR1GZpRpRPHxzLPH4DMWSuGfVF3XRNOgziqEZxDoa16uvX5KA3PCHOa39HH8noz7yiBb4CpS0M34vyHrcpyBqNlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0512.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1c::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.11; Wed, 10 Jun
 2026 07:24:30 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::9b99:12dc:a115:b90f]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::9b99:12dc:a115:b90f%3])
 with mapi id 15.21.0092.014; Wed, 10 Jun 2026 07:24:30 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor@kernel.org>,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	devicetree@vger.kernel.org,
	Minda Chen <minda.chen@starfivetech.com>
Subject: [net-next v1 2/6] net: stmmac: Checking whether priv->phylink if NULL in NCSI case
Date: Wed, 10 Jun 2026 15:24:16 +0800
Message-Id: <20260610072420.64699-3-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260610072420.64699-1-minda.chen@starfivetech.com>
References: <20260610072420.64699-1-minda.chen@starfivetech.com>
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0003.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510::15) To SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0863:EE_|SHXPR01MB0512:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b4cb096-d926-4a85-745d-08dec6c14ff1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|23010399003|366016|1800799024|7416014|376014|52116014|22082099003|18002099003|38350700014|921020|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info:
 KdZjo5LtnpabcCzFJtUTOtufvQjbAXBDy+k+u7reDa927uXW6iRHEi8wOZv6itHYLMKigdhTMExUNj5YVz7vGDwagtzPjF2BMA8eeYRun86+ULDiL8FYk+31e+22NyljzN5N7XT4pcja1nXJ9wzsIde6at5DOje5R3+kiWrw0YqtrhX0zXoGVoen4Kp5nOBEz+DjWVAHZDnig0w74Iz7eJYFQ6A8/1lpHoudaTt0JFSN/raoZsTPmu9MOqCbboGw+RKfr0ii9ahJBQWLeEXwhi6CMe1BnGh7cpzaFRC3CG1gffo3IyzjFn7NCfWkrdqiK44xubYkBmrpsSEvaek1j+qPV5FP7ltB8rAkV3BLwbvr2aR5bXyFBwBDvFOvbRjQVoj2SoZhUuXyWdgZY9snsTB2RDFsY+dUGVDbBeLPHv+IjRGFplY2i+GNVWCc0gFf7uU6twd/jl7uQym3xrc/U4CAiqacBu5ygs2NM+6fsNnRVf6sE8M0Y7JYPGw2qDLIngSw96OyHCfSUK0qZN2Tb7a+7LByHS4oesIqnie+CBg1BQlYaXUfj8MjJ47NNiy8oHUSJCyJoIBsL88/Tn/ahw==
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(7416014)(376014)(52116014)(22082099003)(18002099003)(38350700014)(921020)(6133799003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?Jori/7QTcnKfvJQQEikkxF8gL2xGKolRr+JPDUTlx5ifb4SwWBM8+8PMGDOY?=
 =?us-ascii?Q?r3V5tqH0r6pBEmS8wwzLGpvucth8gf9Eiw7Exn2acgyUmZWvvSNkZsctE6Ec?=
 =?us-ascii?Q?CrdC7ERvcYY3d1IWLT8sBlqmACTi07mR9TvNxrDQkNl99A7lK6iw14IgLHFt?=
 =?us-ascii?Q?bsFWK8me5BbF8Rk+bSVIB+w5UpfZPXTVFYgzjH8EquJFrf1JBmaazx61M1kk?=
 =?us-ascii?Q?+6IIXcfjXOfylg66cxpUOaHrIznpugzV/sUmf9AOgK20z8kWl314rP7Emiq/?=
 =?us-ascii?Q?NNhKSMlLa0UPlvpq0eUcpkHV704NMoQAzI/Rx5ESzwMU0Ma2HzQCLvxVVlU+?=
 =?us-ascii?Q?Vri5gh+qr83/YNuTWvSIUFgbf/qiSuL14wHsct7+kroz9nLzgNKfqIO5DgAZ?=
 =?us-ascii?Q?4A51zCfRJ1XZhLKDt66aG6wvpLgRxP+UmEgqP25kok/tbH1IYrB1dUflsMuq?=
 =?us-ascii?Q?NHwzD/Cl4BsoaithId0MlmxUOWeMwmBlJcRWh3ZhMrP//AF4X4YGmpbfZys1?=
 =?us-ascii?Q?hxKvrJejUe7nQMys64R7VdHQ5/f4ouVpdoOqjqYqDD0nK5BS/v91xT2CrF0S?=
 =?us-ascii?Q?m7Cx+cDQKbVXeMyvOYSo5C7HDWOZdFmLgptad/yJV091r8YoZFOMTyPIwTqp?=
 =?us-ascii?Q?5ecA3BG9UqkHNQ6MXrFqyPHCQRG0osLMmyDAQBCW4g8xDvXzchCXAbZeLNC8?=
 =?us-ascii?Q?YxRs6njYfpZCPxcDGFi8MzB98Qq1Shw+vd906F+s5iR7qWsom1mvYaXJIoAa?=
 =?us-ascii?Q?x3+NWaGrH2dOjIqzWYMEs5u3QrnRzifcMb7DHRQ5C9qCpQA4n0BshL0us/ts?=
 =?us-ascii?Q?nulmlzMIpsqqjE39WEzRD8b1aLhbJvHRcRP7DaOjvcSAAGqGhnApwiTDnIFT?=
 =?us-ascii?Q?qsX1nh2p5yji26b9rJd+hcTQiRN3tuf68JpQ9defurUF5FxnFJYhCV1TrSkw?=
 =?us-ascii?Q?ktiQm3I3+B9GtHN7y8W6n762jyUAqaYceZr4oKLW/Sybi0eDxInIvnnp073p?=
 =?us-ascii?Q?lXrCL1NvO3mgvUUxvfh2oTEBbqs8uqUQCyrpZu1cU1azneY0bAOZO0AMkv1A?=
 =?us-ascii?Q?56UIQgt2PDPBJCQ9NbDm85sxmY5K6yC7wlQ20oBXvWrD9IY0jvGkOAbWQZEn?=
 =?us-ascii?Q?1mVOUbBms+hzEZTkJALx6WRVpnOYnp29WgqWMz58v7vplW4hZP06q+1PS8ow?=
 =?us-ascii?Q?4vfNqfiMNIo2aov7F1fPX4ZmXH02cBMb3N7LblR+arF2KjNAfhSLsmaejtdB?=
 =?us-ascii?Q?ZyiT5YkCQLtv22imstFkiXrMLLPimXpuMuMF6nFopw4yRHYJIX5SQit22Px1?=
 =?us-ascii?Q?5ufd9x1hwMFOiDGG4wJbIGo4FBHTYw0RztwaMdcxMC17EKs8MdTokwzG7HRC?=
 =?us-ascii?Q?Ta/XM5zAK9gXhKSrv7ITkQetkMlJtbPQH3JpFeuytv7CAXBQppM4pmvAdp5O?=
 =?us-ascii?Q?aOaVVwchskaGNv58s0in1hM3XzQMa7pkfPuNy62VZ1M1HcXltNgCHP9LNqoL?=
 =?us-ascii?Q?YziCongCnyJbQThUsL3eFGL0aqZD1jLitCrBO0MD9sbfU5QAu1Oz0i7a9RPu?=
 =?us-ascii?Q?AC1/pTWo1b7xzhIwSzgXDeFQCEytkmwtw76xheHeCda5+B5pBp2oS7vNx7AV?=
 =?us-ascii?Q?1Fkv36Sw6+sfpuSnLlU9oIcyCgTJs1/gygeTu1GpW22nlWFIPMz3p/hJH2uj?=
 =?us-ascii?Q?WQsZYnr8ajLqlpIE2p6QNLoxKd1rm7aYcXcwzplIn7o0S9XjpnSmuCipSWs6?=
 =?us-ascii?Q?zgVokH9pKZD4Qgax4iMhkR7ZCkmpdws=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b4cb096-d926-4a85-745d-08dec6c14ff1
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 07:24:30.6490
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /gsudee+9wqQXju32n6CrFYucgUKpMSghTGkDZeh/BgGgKIfsOCa172rVx2ArveK8WAMsjkli3pbiyKyJHvELuWmQmqcjnGU5jqHwUREasY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0512
X-Rspamd-Action: no action
X-Spamd-Result: default: False [5.04 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[starfivetech.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	GREYLIST(0.00)[pass,body];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,synopsys.com,gmail.com,armlinux.org.uk,st.com,foss.st.com,vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:joabreu@synopsys.com,m:mcoquelin.stm32@gmail.com,m:linux@armlinux.org.uk,m:peppe.cavallaro@st.com,m:alexandre.torgue@foss.st.com,m:robh+dt@kernel.org,m:krzk+dt@kernel.org,m:conor@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-stm32@st-md-mailman.stormreply.com,m:devicetree@vger.kernel.org,m:minda.chen@starfivetech.com,m:andrew@lunn.ch,m:mcoquelinstm32@gmail.com,m:robh@kernel.org,m:krzk@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[minda.chen@starfivetech.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-297510-lists,netdev=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[minda.chen@starfivetech.com,netdev@vger.kernel.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,starfivetech.com:email,starfivetech.com:mid,starfivetech.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B52B86670F1

In NCSI case, RMII do not connect mdio PHY, so the phylink is NULL,
and need to checking if phylink is NULL, So add stmmac phylink
wrapper function to checking whether phylink is NULL.

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
---
 .../net/ethernet/stmicro/stmmac/stmmac_main.c |  55 ++++-----
 .../ethernet/stmicro/stmmac/stmmac_phylink.h  | 106 ++++++++++++++++++
 2 files changed, 134 insertions(+), 27 deletions(-)
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/stmmac_phylink.h

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 35da51c26248..010802389772 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -38,7 +38,6 @@
 #include <linux/seq_file.h>
 #endif /* CONFIG_DEBUG_FS */
 #include <linux/net_tstamp.h>
-#include <linux/phylink.h>
 #include <linux/udp.h>
 #include <linux/bpf_trace.h>
 #include <net/devlink.h>
@@ -49,6 +48,7 @@
 #include "stmmac_fpe.h"
 #include "stmmac.h"
 #include "stmmac_pcs.h"
+#include "stmmac_phylink.h"
 #include "stmmac_xdp.h"
 #include <linux/reset.h>
 #include <linux/of_mdio.h>
@@ -1323,7 +1323,7 @@ static int stmmac_init_phy(struct net_device *dev)
 	u32 dev_flags = 0;
 	int ret;
 
-	if (!phylink_expects_phy(priv->phylink))
+	if (!stmmac_phylink_expects_phy(priv->phylink))
 		return 0;
 
 	if (priv->hw->xpcs &&
@@ -3655,7 +3655,7 @@ static int stmmac_hw_setup(struct net_device *dev)
 
 	/* Make sure RX clock is enabled */
 	if (priv->hw->phylink_pcs)
-		phylink_pcs_pre_init(priv->phylink, priv->hw->phylink_pcs);
+		stmmac_phylink_pcs_pre_init(priv->phylink, priv->hw->phylink_pcs);
 
 	/* Note that clk_rx_i must be running for reset to complete. This
 	 * clock may also be required when setting the MAC address.
@@ -3663,12 +3663,12 @@ static int stmmac_hw_setup(struct net_device *dev)
 	 * Block the receive clock stop for LPI mode at the PHY in case
 	 * the link is established with EEE mode active.
 	 */
-	phylink_rx_clk_stop_block(priv->phylink);
+	stmmac_phylink_rx_clk_stop_block(priv->phylink);
 
 	/* DMA initialization and SW reset */
 	ret = stmmac_init_dma_engine(priv);
 	if (ret < 0) {
-		phylink_rx_clk_stop_unblock(priv->phylink);
+		stmmac_phylink_rx_clk_stop_unblock(priv->phylink);
 		netdev_err(priv->dev, "%s: DMA engine initialization failed\n",
 			   __func__);
 		return ret;
@@ -3676,7 +3676,7 @@ static int stmmac_hw_setup(struct net_device *dev)
 
 	/* Copy the MAC addr into the HW  */
 	stmmac_set_umac_addr(priv, priv->hw, dev->dev_addr, 0);
-	phylink_rx_clk_stop_unblock(priv->phylink);
+	stmmac_phylink_rx_clk_stop_unblock(priv->phylink);
 
 	/* Initialize the MAC Core */
 	stmmac_core_init(priv, priv->hw, dev);
@@ -3752,9 +3752,9 @@ static int stmmac_hw_setup(struct net_device *dev)
 	/* Start the ball rolling... */
 	stmmac_start_all_dma(priv);
 
-	phylink_rx_clk_stop_block(priv->phylink);
+	stmmac_phylink_rx_clk_stop_block(priv->phylink);
 	stmmac_set_hw_vlan_mode(priv, priv->hw);
-	phylink_rx_clk_stop_unblock(priv->phylink);
+	stmmac_phylink_rx_clk_stop_unblock(priv->phylink);
 
 	return 0;
 }
@@ -4159,7 +4159,7 @@ static int __stmmac_open(struct net_device *dev,
 
 	stmmac_init_coalesce(priv);
 
-	phylink_start(priv->phylink);
+	stmmac_phylink_start(priv->phylink);
 
 	stmmac_vlan_restore(priv);
 
@@ -4174,7 +4174,7 @@ static int __stmmac_open(struct net_device *dev,
 	return 0;
 
 irq_error:
-	phylink_stop(priv->phylink);
+	stmmac_phylink_stop(priv->phylink);
 
 	for (chan = 0; chan < priv->plat->tx_queues_to_use; chan++)
 		hrtimer_cancel(&priv->dma_conf.tx_queue[chan].txtimer);
@@ -4219,14 +4219,14 @@ static int stmmac_open(struct net_device *dev)
 	kfree(dma_conf);
 
 	/* We may have called phylink_speed_down before */
-	phylink_speed_up(priv->phylink);
+	stmmac_phylink_speed_up(priv->phylink);
 
 	return ret;
 
 err_serdes:
 	stmmac_legacy_serdes_power_down(priv);
 err_disconnect_phy:
-	phylink_disconnect_phy(priv->phylink);
+	stmmac_phylink_disconnect_phy(priv->phylink);
 err_runtime_pm:
 	pm_runtime_put(priv->device);
 err_dma_resources:
@@ -4241,7 +4241,7 @@ static void __stmmac_release(struct net_device *dev)
 	u8 chan;
 
 	/* Stop and disconnect the PHY */
-	phylink_stop(priv->phylink);
+	stmmac_phylink_stop(priv->phylink);
 
 	stmmac_disable_all_queues(priv);
 
@@ -4280,12 +4280,12 @@ static int stmmac_release(struct net_device *dev)
 	 * to its slowest speed to save power.
 	 */
 	if (device_may_wakeup(priv->device))
-		phylink_speed_down(priv->phylink, false);
+		stmmac_phylink_speed_down(priv->phylink, false);
 
 	__stmmac_release(dev);
 
 	stmmac_legacy_serdes_power_down(priv);
-	phylink_disconnect_phy(priv->phylink);
+	stmmac_phylink_disconnect_phy(priv->phylink);
 	pm_runtime_put(priv->device);
 
 	return 0;
@@ -6209,9 +6209,9 @@ static int stmmac_set_features(struct net_device *netdev,
 	else
 		priv->hw->hw_vlan_en = false;
 
-	phylink_rx_clk_stop_block(priv->phylink);
+	stmmac_phylink_rx_clk_stop_block(priv->phylink);
 	stmmac_set_hw_vlan_mode(priv, priv->hw);
-	phylink_rx_clk_stop_unblock(priv->phylink);
+	stmmac_phylink_rx_clk_stop_unblock(priv->phylink);
 
 	return 0;
 }
@@ -6386,7 +6386,8 @@ static int stmmac_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
 	case SIOCGMIIPHY:
 	case SIOCGMIIREG:
 	case SIOCSMIIREG:
-		ret = phylink_mii_ioctl(priv->phylink, rq, cmd);
+		if (priv->phylink)
+			ret = phylink_mii_ioctl(priv->phylink, rq, cmd);
 		break;
 	default:
 		break;
@@ -6480,9 +6481,9 @@ static int stmmac_set_mac_address(struct net_device *ndev, void *addr)
 	if (ret)
 		goto set_mac_error;
 
-	phylink_rx_clk_stop_block(priv->phylink);
+	stmmac_phylink_rx_clk_stop_block(priv->phylink);
 	stmmac_set_umac_addr(priv, priv->hw, ndev->dev_addr, 0);
-	phylink_rx_clk_stop_unblock(priv->phylink);
+	stmmac_phylink_rx_clk_stop_unblock(priv->phylink);
 
 set_mac_error:
 	pm_runtime_put(priv->device);
@@ -8081,7 +8082,7 @@ static int __stmmac_dvr_probe(struct device *device,
 error_netdev_register:
 	stmmac_unregister_devlink(priv);
 error_devlink_setup:
-	phylink_destroy(priv->phylink);
+	stmmac_phylink_destroy(priv->phylink);
 error_phy_setup:
 	stmmac_pcs_clean(ndev);
 error_pcs_setup:
@@ -8147,7 +8148,7 @@ void stmmac_dvr_remove(struct device *dev)
 #endif
 	stmmac_unregister_devlink(priv);
 
-	phylink_destroy(priv->phylink);
+	stmmac_phylink_destroy(priv->phylink);
 	if (priv->plat->stmmac_rst)
 		reset_control_assert(priv->plat->stmmac_rst);
 	reset_control_assert(priv->plat->stmmac_ahb_rst);
@@ -8214,7 +8215,7 @@ int stmmac_suspend(struct device *dev)
 	mutex_unlock(&priv->lock);
 
 	rtnl_lock();
-	phylink_suspend(priv->phylink, !!priv->wolopts);
+	stmmac_phylink_suspend(priv->phylink, !!priv->wolopts);
 	rtnl_unlock();
 
 	if (stmmac_fpe_supported(priv))
@@ -8314,7 +8315,7 @@ int stmmac_resume(struct device *dev)
 	/* Prepare the PHY to resume, ensuring that its clocks which are
 	 * necessary for the MAC DMA reset to complete are running
 	 */
-	phylink_prepare_resume(priv->phylink);
+	stmmac_phylink_prepare_resume(priv->phylink);
 
 	mutex_lock(&priv->lock);
 
@@ -8335,9 +8336,9 @@ int stmmac_resume(struct device *dev)
 	stmmac_init_timestamping(priv);
 
 	stmmac_init_coalesce(priv);
-	phylink_rx_clk_stop_block(priv->phylink);
+	stmmac_phylink_rx_clk_stop_block(priv->phylink);
 	stmmac_set_rx_mode(ndev);
-	phylink_rx_clk_stop_unblock(priv->phylink);
+	stmmac_phylink_rx_clk_stop_unblock(priv->phylink);
 
 	stmmac_vlan_restore(priv);
 
@@ -8350,7 +8351,7 @@ int stmmac_resume(struct device *dev)
 	 * initialised because it may bring the link up immediately in a
 	 * workqueue thread, which will race with initialisation.
 	 */
-	phylink_resume(priv->phylink);
+	stmmac_phylink_resume(priv->phylink);
 	rtnl_unlock();
 
 	netif_device_attach(ndev);
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_phylink.h b/drivers/net/ethernet/stmicro/stmmac/stmmac_phylink.h
new file mode 100644
index 000000000000..046a3e91fb2a
--- /dev/null
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_phylink.h
@@ -0,0 +1,106 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2026, StarFive Corporation. */
+
+#ifndef _STMMAC_PHYLINK_H_
+#define _STMMAC_PHYLINK_H_
+
+#include <linux/phylink.h>
+
+#ifdef CONFIG_NET_NCSI
+static inline bool stmmac_phylink_expects_phy(struct phylink *link)
+{
+	if (link)
+		return phylink_expects_phy(link);
+
+	return false;
+}
+
+static inline int stmmac_phylink_pcs_pre_init(struct phylink *link, struct phylink_pcs *pcs)
+{
+	if (link)
+		return phylink_pcs_pre_init(link, pcs);
+
+	return 0;
+}
+
+static inline void stmmac_phylink_start(struct phylink *link)
+{
+	if (link)
+		phylink_start(link);
+}
+
+static inline void stmmac_phylink_stop(struct phylink *link)
+{
+	if (link)
+		phylink_stop(link);
+}
+
+static inline void stmmac_phylink_speed_up(struct phylink *link)
+{
+	if (link)
+		phylink_speed_up(link);
+}
+
+static inline void stmmac_phylink_speed_down(struct phylink *link, bool sync)
+{
+	if (link)
+		phylink_speed_down(link, sync);
+}
+
+static inline void stmmac_phylink_disconnect_phy(struct phylink *link)
+{
+	if (link)
+		phylink_disconnect_phy(link);
+}
+
+static inline void stmmac_phylink_destroy(struct phylink *link)
+{
+	if (link)
+		phylink_destroy(link);
+}
+
+static inline void stmmac_phylink_suspend(struct phylink *link, bool mac_wol)
+{
+	if (link)
+		phylink_suspend(link, mac_wol);
+}
+
+static inline void stmmac_phylink_prepare_resume(struct phylink *link)
+{
+	if (link)
+		phylink_prepare_resume(link);
+}
+
+static inline void stmmac_phylink_resume(struct phylink *link)
+{
+	if (link)
+		phylink_resume(link);
+}
+
+static inline void stmmac_phylink_rx_clk_stop_block(struct phylink *link)
+{
+	if (link)
+		phylink_rx_clk_stop_block(link);
+}
+
+static inline void stmmac_phylink_rx_clk_stop_unblock(struct phylink *link)
+{
+	if (link)
+		phylink_rx_clk_stop_unblock(link);
+}
+#else
+#define stmmac_phylink_expects_phy		phylink_expects_phy
+#define stmmac_phylink_pcs_pre_init		phylink_pcs_pre_init
+#define stmmac_phylink_start			phylink_start
+#define stmmac_phylink_stop			phylink_stop
+#define stmmac_phylink_speed_up			phylink_speed_up
+#define stmmac_phylink_speed_down		phylink_speed_down
+#define stmmac_phylink_disconnect_phy		phylink_disconnect_phy
+#define stmmac_phylink_destroy			phylink_destroy
+#define stmmac_phylink_suspend			phylink_suspend
+#define stmmac_phylink_prepare_resume		phylink_prepare_resume
+#define stmmac_phylink_resume			phylink_resume
+#define stmmac_phylink_rx_clk_stop_block	phylink_rx_clk_stop_block
+#define stmmac_phylink_rx_clk_stop_unblock	phylink_rx_clk_stop_unblock
+#endif /* NET_NCSI */
+#endif /* _STMMAC_PHYLINK_H_ */
-- 
2.17.1


