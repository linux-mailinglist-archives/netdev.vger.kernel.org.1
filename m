Return-Path: <netdev+bounces-294649-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bsLmK9/dH2qvrQAAu9opvQ
	(envelope-from <netdev+bounces-294649-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 09:55:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E39EF63569C
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 09:55:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=altera.com header.s=selector2 header.b=PGPzpYhr;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294649-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294649-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=altera.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0D71B3155E24
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 07:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFBE2403EB6;
	Wed,  3 Jun 2026 07:30:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011000.outbound.protection.outlook.com [52.101.62.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF5D4028C6;
	Wed,  3 Jun 2026 07:29:55 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780471803; cv=fail; b=JK//VTqXaabYENeExdaao+jSjn7TRjZ9NJ4wGdbP9pfriTosG7f6Pid8IBIO3dUFfQX00DI8Eo/ZNSxVwhpQLKu3K6QmUqtZo61uORRe/88w6dxy4ryxL0ufDaKsvOZdBQ2k0/U5+soePuLbfW8cN+6m6FQeqs2oFMPaDKcl4y0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780471803; c=relaxed/simple;
	bh=JrVliSlbeKptO9eKXjEV84rVZHJHw+RmXy/fQR5J7mY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nf3aHmKkbmKP9zG9dvAF0sObShLkibEbrLg8QjHnkr+WWFZ0v9nZU9J5UoXdTJge/8HrY2hchEo4gpW1KWXW+QVcMq3gU1qWUggSEkTdywHOb72/p2+Vw6NVzlVi+WT5BykOOMhG7P0OS7neoJ2VG0gwBKjt2Hpt4d2ZxW1KQJ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=PGPzpYhr; arc=fail smtp.client-ip=52.101.62.0
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jSHS6TCG9qwrxVSFH7LMIZ62NHarS+tqUiLmUBjKbmYohPpXkrubt4VZTDIgfjL3Law/yoSTfqGN30xmDULCfrKuoyqH1tmCTkuAG2FKAtzNOEcqlQ8diS77Wq9Df9lqw8lsBJPsY4+VUnmOYUEZwLL73WbM06ePtoFyghLXDmxAIKi22VuYGaLzTOK9KRVRFh2LH66FMXePeE9SwbvAIVnysMmGc+Zb7s1RSVoTbL4AMF0NcFD5ulyycWmFawkGX7PAM2xT3BvTxSy8dRQvnBtG+9WbwiYXEfNlt+4x946EV3UAdLsL0gd1Qyl8/30k6k3iObuuM5TUzRLLLThQKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xWeXD5b3Mu0UToFxdMygz4f9aecflESnL2RYK3Wz5FE=;
 b=OkyJD8RcFNOyI6amUBinMQFWp/Ang2SWabeEk5wOFIFxLuTqiMqABjt6tkKc/glZTzCxd/sc8GhIhZS7cvisy6Pr9tAWjo12ZdTezJTU3ctNqN8ugvWOrbEXIFCynhjPb13fOJu8EHCAWPOaX310UFrpOj1W/U49ZueuyNHtrTNZ2cV5rVixDud1tfi0ff+kcCfs+rlynMbVbkC4NqF4nzxIJOjFQpFoG3s5cFBfqNuhfXjLSmbDdrr0VPsXF/ciqOrRli6O2tSK/nR0XcC+ViQ4O4gtm6OOHP2sEmQ6jQpeLjyd4XEXelANHIVQz8w6cq4lbQ6Oaars13jotQvNkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xWeXD5b3Mu0UToFxdMygz4f9aecflESnL2RYK3Wz5FE=;
 b=PGPzpYhr5WjBDngRU2dzvnnUChoCy6F2NSQCoLgB4URT7AU9T+zFX3iTcCrgq8BnDZfwG6Os6e+P2fnSOI2Sp3SRayIxB2iae50XJbmCpj6J7LN2rYVWresGIjbyoAN25v66hODNJGD3jUQHsygojVDbWJZ6UAs74M19/VMaot1uZrV4CbGURWYHUthBdbOPKh69iyUHEwHJXuoDbK3kCHi68rjOOTVqGtSthEjDCRMWyMwo03/i/7axjXCp9o7TJup99nEGQmQsCZ8VU/NLV1EkY57ORE0jxrI6k0tVvo3Af+xrOnq7VYAInDz5DIMSI459x/e/HIHmSCNoTQ+C3A==
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com (2603:10b6:a03:432::18)
 by PH0PR03MB5813.namprd03.prod.outlook.com (2603:10b6:510:35::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Wed, 3 Jun 2026
 07:29:29 +0000
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775]) by SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775%6]) with mapi id 15.21.0071.011; Wed, 3 Jun 2026
 07:29:29 +0000
From: muhammad.nazim.amirul.nazle.asmade@altera.com
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	rmk+kernel@armlinux.org.uk,
	maxime.chevallier@bootlin.com,
	Jose.Abreu@synopsys.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] net: stmmac: xgmac: report L3/L4 filter match count in ethtool stats
Date: Wed,  3 Jun 2026 00:29:25 -0700
Message-ID: <20260603072925.27890-5-muhammad.nazim.amirul.nazle.asmade@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260603072925.27890-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
References: <20260603072925.27890-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR03CA0017.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::22) To SJ0PR03MB6964.namprd03.prod.outlook.com
 (2603:10b6:a03:432::18)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB6964:EE_|PH0PR03MB5813:EE_
X-MS-Office365-Filtering-Correlation-Id: fe6de8ba-5c7e-4c35-665b-08dec141d937
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|18002099003|22082099003|11063799006|56012099006|55112099003;
X-Microsoft-Antispam-Message-Info:
	25v0WN5UFaqXqzonHmsWsWXWBTxMkcDRRRSq7wnUJ+iDm7JD5/m4rO5Se8eM6VqrF83f4dBQDINrYirFFvfpLR60xSQsOK7y+dOZg5FLsxAsxduJK/RwUOGUKjg32/fA6RzLd5sAQzvwrw41xwwOcVcceZ/MSId2xjUK/OA4hwpsKuSMYhcTLIORIS97U1dz4p4i67zQoUE4b3Bv2FJgmebwR/VmUa2/4JCaZIt1MGo+EiNSaXD3HuHrWCSk87vlnNfADr5ANWfNCdBlp1NwPb1Izh+fypmhWanZJrL9Gge6l8kpI4vkEHIasczAqw2B59RbydRF3awutflo7KD0ETB71hNnvr1mZufTNJd2hROgAV7E7p7xcwGS4B7+OLXlScNzqdaVhk10oJkwF/vYmtYTQppK8MFA8NbMkJpU8W9c+UtZ0L6AdOirS7LEE8KMX8h3TVjRFK1VbNUOsHmufQJtzR3m41xNizyW6Tb1yCbl9wKpyvnD9YqgNtz9swcSVJlJNi0dGoHJVdaa9kmpY6u+8ZavA2KHdoXQal8n9pfaHT1ZYsmkF7BtjXz0zuiFFMtnokCgsZkw8ud7RLLlvthsZgahdf0sJsk8Ciffkb/JVyWCcOWCc4a/NDOoiIIMfeXrwpUAHOslK68WqOzmG12v9XXsTnVpNWiIt8oQBGH46QbvSlz7uGdY7lZy0wrm
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6964.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(18002099003)(22082099003)(11063799006)(56012099006)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cHKINirxwGs4Ukq/0ZGjx9gqTHMOcnol46f5tsp2YVgNb+9CD5qQeIrNiQqz?=
 =?us-ascii?Q?UVV+F35aspigmfc2lH/RWbxFURLYFiRDdL0EB9eU5XsNSl8BHHj7Q4BA075U?=
 =?us-ascii?Q?q282m83M/qMaQ/IvrNzHdMDGzd2FHKUuR/uFatWsyq0Qmo8vl3s4t+DNdasg?=
 =?us-ascii?Q?vb8a3rkzbsDCIji9oPl35K/W5FXY6okaVOg0/dihjwHDOCtdPxDbOASsKpQP?=
 =?us-ascii?Q?oTlZDXyXDgkVXWZXdDK1qX4kL2Ia3xk8T4/axc32TZTY47rVNbgslUR1ORC8?=
 =?us-ascii?Q?t0KdDbSKssa1I0twA9cWJLvzgKbAz/V0ysgWCOL+VePGvNacYx3VUUGpmDO9?=
 =?us-ascii?Q?PImbZSdc/GaeU5n+9cOMD0BWNPyNhfjgjp/5qxqojxGE4A9HzDOmcrSzHoAg?=
 =?us-ascii?Q?vTUXqVJBlaSIIgY2kmG76DAuaZC04yvkSNIw0kM5WQHY0ieO6tKdCBzn4C+Y?=
 =?us-ascii?Q?OFzKyl4d/1bTGpm/khVu45eg+hoFG0D1yaxv1YKeMToDpjs5o1ragCGGGH3G?=
 =?us-ascii?Q?vi1XTfyq8LnPWF0Ko5ROm7iA2k+lUWX4oxmOaBkteHqLWxRpoftiKv3lrxlZ?=
 =?us-ascii?Q?iPggWd9nWbocOLzp0XOp3RQ44jf37+QS32rxJRTP3p7GNcdB28NYEk7iTqyK?=
 =?us-ascii?Q?x1X2C0hfVIZRdde/zT3a9ponAcO7iV56cG1CaBd4cTX5KO1FEf7iEynTit83?=
 =?us-ascii?Q?wAbIu8dNp8qgP/P3XlsJbeyTVJfjdPZfo+//XlxWMIvu2ktd9teKf1FQpu5t?=
 =?us-ascii?Q?hpQ+z3kfmb/YNka+3Iegm14TdGeBIoxcE74lrDlAqHsCumcciU7ph7uTg7WH?=
 =?us-ascii?Q?NQ6md1QOqoIrUaatP1g18XU+ohHyrMH0mCMNbizmRQflYaMp6AGezHa0vECX?=
 =?us-ascii?Q?VYYq6b++nke30yQdDdhkx1RIkRCgF/0QaqwZlakauUeIWlQ8wC4l6DfvH1EO?=
 =?us-ascii?Q?aIn+35/OOSUTOKpyr3ju7jkpDQPTFrZocC6YwgGf30XDHMVeDecLZ0lcEHuz?=
 =?us-ascii?Q?eK4o6+VFJn6M1gSTiqHcI5d8OB0QbAZXoBVs3sJozXP/ZmJfQT72LhogAFjt?=
 =?us-ascii?Q?8zT1zjnxzfYM1ee/Ip03z0BPXv/tUeIZca+wNecnuqpB6x+y2a/BeJCbbqeG?=
 =?us-ascii?Q?RC2ExWnUgj3xxHm0lsXTBVbWXEfjiBXpfmDkxXzlWttkqBLkqEIYkGhk7Ssh?=
 =?us-ascii?Q?Rpy2tHyS5Z6aLH8LVwUmJ/y+uOmepNPTwiyXoCv9m5kXQOevt4YLKQbRlG9j?=
 =?us-ascii?Q?JS8T9kFoiFhTNEVvW3TJTs9Sti4FwQJTa8qAtKi2v2UpJvjCRyzvF+alWiRS?=
 =?us-ascii?Q?liE+epFzIPKzo2Al/nUMG0H57xzbjP3T3jmmZ/rtFrsQIRFSWobXfpijmEd4?=
 =?us-ascii?Q?Td8FPhf0ei8ZR3Dj2ONDuI7lYmvgWt8pvyUe2V4/UigZuso15xdbUXeK76OC?=
 =?us-ascii?Q?K1Xi3CaqR2xkcje0kxalbo01WZ6Tep1QWyDAz+wlA9/AbWTF5GWlo1zWv6Wb?=
 =?us-ascii?Q?IFv3ccGE9iGUhIjVR1J7UQ0vmVTP73RC2NnuQzzYQBv9tekPANOik7HdE/L4?=
 =?us-ascii?Q?QYubnXoEutijdVB/5wrM52YPM1FDlgsYyHnjE1A4yKpRl5en5M8YeQu1pVRs?=
 =?us-ascii?Q?FLfSf1tc3PqJqEL9bew3xibm7HkiYOAoz2HwEHl2LNYmbgfGWMT+OzzhODhu?=
 =?us-ascii?Q?kgZhVx0raENwUJO9v2x2gAab+j27zzoPRXKcxw30/qQlxRIV+zBwwEsVtcNK?=
 =?us-ascii?Q?Bwk9zPi1iMCcfXfwF6ssbuQAeZh50ffPdmt+MPAwhYLbtaCQe8Ry5jIn7xDT?=
X-MS-Exchange-AntiSpam-MessageData-1: oHrk1P9ftZMhVg==
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe6de8ba-5c7e-4c35-665b-08dec141d937
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6964.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 07:29:29.7080
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /RNFQ9ywwTer1ncvWgRIxHnTJh4eYtIitzoEmP+njZZV2vzL4QkZ6NVuZ8lqHideSCsV8qjtMfa0nCDiR2vIcqw3qlBcJIcKhG41KmEtIAIYYlEs2z90MANIYds+YbojhcRBIkrLvzD67LfM58LoDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB5813
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[altera.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[altera.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-294649-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[muhammad.nazim.amirul.nazle.asmade@altera.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:rmk+kernel@armlinux.org.uk,m:maxime.chevallier@bootlin.com,m:Jose.Abreu@synopsys.com,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,m:rmk@armlinux.org.uk,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[altera.com:+];
	FROM_NO_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[muhammad.nazim.amirul.nazle.asmade@altera.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,altera.com:mid,altera.com:dkim,altera.com:from_mime,altera.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E39EF63569C

From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>

Read the L3FM and L4FM bits from the RX descriptor status word (RDES2)
and increment the corresponding ethtool statistics counters. This allows
users to observe L3/L4 filter hit rates via ethtool -S.

Signed-off-by: Rohan G Thomas <rohan.g.thomas@altera.com>
Signed-off-by: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h       | 2 ++
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
index 51943705a2b0..95fdf3133208 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
@@ -429,6 +429,8 @@
 #define XGMAC_TDES3_VLTV		BIT(16)
 #define XGMAC_TDES3_VT			GENMASK(15, 0)
 #define XGMAC_TDES3_FL			GENMASK(14, 0)
+#define XGMAC_RDES2_L4FM		BIT(28)
+#define XGMAC_RDES2_L3FM		BIT(27)
 #define XGMAC_RDES2_HL			GENMASK(9, 0)
 #define XGMAC_RDES3_OWN			BIT(31)
 #define XGMAC_RDES3_CTXT		BIT(30)
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c
index b5f200a87484..6719ac6e395b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c
@@ -27,6 +27,7 @@ static int dwxgmac2_get_rx_status(struct stmmac_extra_stats *x,
 				  struct dma_desc *p)
 {
 	u32 rdes3 = le32_to_cpu(p->des3);
+	u32 rdes2 = le32_to_cpu(p->des2);
 
 	if (unlikely(rdes3 & XGMAC_RDES3_OWN))
 		return dma_own;
@@ -37,6 +38,11 @@ static int dwxgmac2_get_rx_status(struct stmmac_extra_stats *x,
 	if (unlikely((rdes3 & XGMAC_RDES3_ES) && (rdes3 & XGMAC_RDES3_LD)))
 		return discard_frame;
 
+	if (rdes2 & XGMAC_RDES2_L3FM)
+		x->l3_filter_match++;
+	if (rdes2 & XGMAC_RDES2_L4FM)
+		x->l4_filter_match++;
+
 	return good_frame;
 }
 
-- 
2.43.7


