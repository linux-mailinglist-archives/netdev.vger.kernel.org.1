Return-Path: <netdev+bounces-293018-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ILV6D/49GWpVtAgAu9opvQ
	(envelope-from <netdev+bounces-293018-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 09:19:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 488015FE6B9
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 09:19:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DC4C43006912
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 07:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00906348C51;
	Fri, 29 May 2026 07:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="okdzM7So"
X-Original-To: netdev@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012040.outbound.protection.outlook.com [40.107.209.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDFD33263A;
	Fri, 29 May 2026 07:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780039059; cv=fail; b=PjOvZ709pkqJOiskSdbDPZpU8onD6CjSxy1cHjJ19N5eMuRRkQzC0uhBhPSz43ytP/H67wuRhUf4DMVRyKqxkJdxn+heat8gdvxEnlPsAZTxw3UMSSUNHSFSYMm6J2Vlzp13Y8oziXVLsavVqShAKaL7wEE+KQu/Mx786RlVH4Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780039059; c=relaxed/simple;
	bh=X4fkwr4VH0ebEpGSwawg1OJB0kCB9+7qGse6jQbhAjA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=givdp95uwS2Wojkm23j7rZRUupzBefxmq4I2yvYWQBmZAYfVTwz8LYm9BbVpGaeaLtN8FmR/d5v5Uu6eslm4emh7Yny53qbfGzec8S1F5F/n8VBM83TOCrsyxKMlxtoz3hUUmbtMuDNfm9RfSK124p5VwSo45i7ZsSU+mIK9HEg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=okdzM7So; arc=fail smtp.client-ip=40.107.209.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r1WHx+yBCGdtnnyqc2pBHkFyk0GtSFRVdP0H/gBy27lazoG5O60pWvqgq/fAV/Yrs+HI0PGLlcpPHfw2p05KoiXv1AWjXq0xBa/9wQEChgKQaUvNpYsqwrRgyaBo9eLghMy0VbUU/uZ41NfQ2fGV0UelClr4E76NvdL4u7NE1o2L6oo5ssAFYOt6oEHMb42BI47VS37pUaYzFEV6SfbE0NWKvUTazHyArfM1sOfl2vurKChDIkHtdbiE1heOV3kjCkwi6fUY8Owseng3LTUbaSnC3kN2GlBm15FdYJsu4wwFT3Ey9y/bxThNFDZd3CoPgU0l7i/H8y9zkeSoHh6YvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pQJAxYZ0D2HQTYXxDTW8lvhb4RSdQ2eArGopTyhC3F8=;
 b=lsMek90QTs0vDO9XPy8CG1KtRmYieVpPdKsFpGTkNJo+23XPUDC6nL1fm0Mr6gl/V6NuVOlXqeuEUEog2ON+4ueD4k06z2UMej4NZ90ISDBiNsDj1lUfD5PDrXcuCvYwgNk3eWeFBFEZKo5joO7H76X72FEdjFvzKtOt5azhxyYaaAf50qqdAqQoNvM+SLZ9DNEy9phuThPCI7yqgBasdiA6v5rsjYX3vvlzZGxfzp63EUoHgYphDJIWCMhPng+Wp6egOQZteeddbyiqr0XTo1HZa1WnwyuH9tMN0fyQumBQMAJfqYXV/b5mTtRGGpr8E2kTkG/TE5TOjRVy82URMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pQJAxYZ0D2HQTYXxDTW8lvhb4RSdQ2eArGopTyhC3F8=;
 b=okdzM7SozzXDHt/WU3nL0XfVk87rAwrXJ6PdI5V6moIoNpsBL290WU0QfL4O6CY4hd1UM6byXHMqM2HOJEOMp4bVoCOFQmhv6QzWOZJbd3HfV2dpuTCi6MJ1jkq8/MBrnQCv6xHN/BWQ/xMTr+y8iL/IxqkJ4n8s0OSmuo94OW3ocV5ZLF9KiFeXrMmf+dMsoSmTIPx+mLuo7QU6ysSeB0ih/oJ10PqYxFP/5Qlk2DuMepAztWA2f71gBw5+Y6xnkG2hsLAdlRDVYUT4lXQ1tp/TuuYiDQgEcKm8BpbQu2zdLvcvxp9gt3e/U99tmGngKYqlLc140jBerWnLNg3w4w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com (2603:10b6:a03:432::18)
 by BY5PR03MB5029.namprd03.prod.outlook.com (2603:10b6:a03:1e2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Fri, 29 May
 2026 07:17:35 +0000
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775]) by SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775%6]) with mapi id 15.21.0071.011; Fri, 29 May 2026
 07:17:35 +0000
From: muhammad.nazim.amirul.nazle.asmade@altera.com
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	rmk+kernel@armlinux.org.uk,
	maxime.chevallier@bootlin.com,
	Jose.Abreu@synopsys.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: stmmac: xgmac2: disable RBUE in default RX interrupt mask
Date: Fri, 29 May 2026 00:17:34 -0700
Message-ID: <20260529071734.27722-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0195.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::20) To SJ0PR03MB6964.namprd03.prod.outlook.com
 (2603:10b6:a03:432::18)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB6964:EE_|BY5PR03MB5029:EE_
X-MS-Office365-Filtering-Correlation-Id: 026b314c-3e6e-4308-c82e-08debd525b6c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|18002099003|55112099003|6133799003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	N2YzrW2xzN98W0QZrvrLrCnGdaki4IwKl73sNCjz7MB6BSzjQPvVWbP59l62k5zwHd3K1yWsydpGEySt8gQM5gbcL5Pz5YZ0ql91cleR8KrzNyViwazwPqofZTbmvb9F6tLedfh08GmDZwguG/90x0ZQRJBlTWb132NpdbhwXkM2lgJzGU/Q/knWYouOVoNxW4oz3Xp237fFLBMUBtTc8N67Ttx7UGc02SEd+GxbvGuyHMtLHuKX/xQQVy1ZvBsSOJNsf1RCBV21SN392Fg1uxfv49rajWbVTZHZLgatHUoRi8sI8QHJpU52MW7TyCx691T1mLUfj08q5zW9y0mY3X/6Xjk9A3NdRH8Dd3vl6cOCUwd1duza1Rq+Fu4IKf2E45u1LRfNFbhPfVWCnptAE8eUwmw4LjxLbhKTgglWq0JXa+o/tLGrIZOxLhBtJVHbXQB2ClQVcyyD0G8scBRH8kAcWML7pPl7F3S+hVqvgyKviYbNJrHamULg8VIOy5dz8PJy5VZZi7MsQ3qy8NoQFunt9L4dw00YTF/CqWIO1GbVQhx3vjZtf7G0h8XnFrI3flFzLJFjkl5B9kBDIsXnnajjKmLAzqfCHcBN9SLVEOK94vOj0LSyqgEVE3wWZP9KUZj+kG6McwVLm8Aw/daiqbMXDqZiQHQt3dgjBP2kUTpWEz22GQ9uNjQM0no+pL6c2ewLEe32rjMUkFz0uR0g1g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6964.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(18002099003)(55112099003)(6133799003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LVwmkCc0ea2/crGW+8uTkiynaMID+ZxH6x0oh0mKJP647vlVSNk1oEQmwywi?=
 =?us-ascii?Q?T30J4Ba7GrFbyRB1J/7SV7ymWsv3Z6iFXurIBXfeqrN1tGo6DVMOtGx3SkUS?=
 =?us-ascii?Q?bEZRdJd8YfoiuGQgLXHn4dzeg2DpdJRGVNXD97u+JvXrZePea+vbBnhi2V52?=
 =?us-ascii?Q?yT8IbfpH79aEFaF+x/qnKcGWX9Bv9xbKpRGxA08Vy/qhr6kSG9GJZBnwkOak?=
 =?us-ascii?Q?zA+wsKEI2jO0YZXxMp/Tb3zms37eT22nO2CD+poBLxC0vupf4M7l0aLHKFPD?=
 =?us-ascii?Q?Eo+v4xLSbeTK+WvZyXF8KEMFt/nv68uLvNVNlW+rwA8VfTk4Yg30oxnDCUbp?=
 =?us-ascii?Q?JYsWUYZCJQV/aUV/OfrcrOriO2JovLOpUWlrobWf3Wt54/D5kPoH+Els4JIr?=
 =?us-ascii?Q?sTZZkY9Fofz/TW7VeJQvQh4qwTr30pcBP+7eldV1Glv6G6xqpbUMPnjqzX9G?=
 =?us-ascii?Q?ODXKF9va5PMKf1kcvqaOa0aTMeAITj8WyKTWWeMXUG+u1bI6XD9Q7IPB3lyS?=
 =?us-ascii?Q?mckccB0DccGdSrW/vKDAE7GjY1CQiAjU1mkNzlZjIzmDR6WrtZAXhDB5QTBu?=
 =?us-ascii?Q?OXksldv7p6DDEJyRXbIZIkzF/2XnWhrEfbvjyDKBf/I1f3IFo36oYjIHaMm1?=
 =?us-ascii?Q?89UtBvIIhbunzcYScLXA4JivxGF6AhN5BZ9aW8SPqs3yTInBsTTgOPLWBuKt?=
 =?us-ascii?Q?8e+kdrOdKhBdYwEj7NR2q4DraNHkymCXeSEBuvd7+YF/feo0FcJZWs5+xIYI?=
 =?us-ascii?Q?/+fjMTeH0FfwD2LeYh8QZ0BcvcOerzQxJhRgF9qKlMHsKahJhAZGqPEfeXR0?=
 =?us-ascii?Q?mT8IjtfmhQkGGkwgBtQZPRpxiMGnmdfbPR/qkLesqWvqUK/78TrjsWbFeRwC?=
 =?us-ascii?Q?ObmJiJHdk5Nl23Hywm7wMGN9oYfEq5y7+Ggk/em/6BW4+L3oli2ihIFBiUp1?=
 =?us-ascii?Q?h3n3xSaNp2vIqiK5nVbAmzRsONTjweMfLEU6IXl9ZgpY4THZBUzL+jLJQj/b?=
 =?us-ascii?Q?bP2DP/uclW9nnRwtoRJUIZYeFBv3cJ7HoYIbUYQJjjUHFNmZjeHARqpccHfy?=
 =?us-ascii?Q?OqVZRlJFbtXVGfYaDNhTtJzPN+Z0P6YMdPgUpP3py5995D6eegTougn0A3zr?=
 =?us-ascii?Q?X1HmZ9pSmtX9GwHErUyQF5caCCCgPjUykCiU2DkKBqaJq6pKLr1JjGTMRnJ3?=
 =?us-ascii?Q?uaO2/Hkb4zvG0qsclkuVN9L/QivrddK99BKUKoHizyrENCBa6dcsHRxBvm2N?=
 =?us-ascii?Q?0MYM1sc/qMdGpXbU1Huey4zz8B8bqARCBrIw55tr5YaLgQZNlxA59S8JbQMB?=
 =?us-ascii?Q?2ypS/LOVD/F4SiZSpGffWJFJgn1X8egNYKvKM85OB3q6xho/6wtkmSU9JNuZ?=
 =?us-ascii?Q?/9/uruUSVr2V5LBh6IE6HmkE/8HmhISvFafrhGAAM1yC4E2lwK38KgvMccit?=
 =?us-ascii?Q?XmHZqr++psmMb+DzXTS/tCqj4wq0qQ/q+1u8DNVOgO3WrwrH6WS5o8Tk9Pyv?=
 =?us-ascii?Q?Uq0lX9F917xv9QyTl3KthcIwNjr4nwHT9hTNVHFY9LmoIDjkcWq4NGjEe7eP?=
 =?us-ascii?Q?+PjsFlCNWninEVVU6RXlfmLTsjQyeTcobRHiaIEqRbCyTGouiXJqzoswWwGE?=
 =?us-ascii?Q?1a7NOsOnoDLh4jEmAonqTJGk1+S/7vhnwPwXZYCxjq/3fJbRheF6W6tnkQzU?=
 =?us-ascii?Q?A/B+waAVcz9aX77N6tYeGDrLrA5CUlNnO8E2wUuHw1+Nl8Q7nri/lq8oTcig?=
 =?us-ascii?Q?c/L34EPt37tzDSkIkPlsywkWWcOE9OdrAfYR5Nz721q/cpT9NIb7jqISv7Qt?=
X-MS-Exchange-AntiSpam-MessageData-1: KqSsEPH7UhNZ0Q==
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 026b314c-3e6e-4308-c82e-08debd525b6c
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6964.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 07:17:35.3182
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aLxmPkvg4AgRPMUHBIJS8qiSkvxEL3SE61k55zMhDnV5cCP1fStDpYhhM4CglHdouI2RZAdu3xkC4D8SNqabVevhKnymYWLEc2Kh/mO6HLULvzj25+5p7VaoilxJoUE+Yrt9iYdVNnzw+vToOP0sqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR03MB5029
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[altera.com,reject];
	R_DKIM_ALLOW(-0.20)[altera.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,armlinux.org.uk,bootlin.com,synopsys.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293018-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[muhammad.nazim.amirul.nazle.asmade@altera.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[altera.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel];
	NEURAL_HAM(-0.00)[-0.999];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 488015FE6B9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>

Enabling the RX Buffer Unavailable (RBUE) interrupt is counterproductive
and can trigger a MAC interrupt storm under heavy RX pressure. When the
DMA runs out of RX descriptors it fires RBUE continuously until software
refills the ring.

However, RBUE is redundant: the normal RX completion interrupt (RIE)
already triggers NAPI, which processes completed descriptors and refills
the ring, causing the DMA to resume. The RBUE handler itself only sets
handle_rx - the same outcome as RIE.

Remove RBUE from XGMAC_DMA_INT_DEFAULT_EN and XGMAC_DMA_INT_DEFAULT_RX
to prevent the interrupt storm while keeping normal RX handling intact.

Fixes: d6ddfacd95c7 ("net: stmmac: Add DMA related callbacks for XGMAC2")
Signed-off-by: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
index 51943705a2b0..b5fdc253a2f2 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
@@ -379,9 +379,9 @@
 #define XGMAC_RIE			BIT(6)
 #define XGMAC_TBUE			BIT(2)
 #define XGMAC_TIE			BIT(0)
-#define XGMAC_DMA_INT_DEFAULT_EN	(XGMAC_NIE | XGMAC_AIE | XGMAC_RBUE | \
+#define XGMAC_DMA_INT_DEFAULT_EN	(XGMAC_NIE | XGMAC_AIE | \
 					XGMAC_RIE | XGMAC_TIE)
-#define XGMAC_DMA_INT_DEFAULT_RX	(XGMAC_RBUE | XGMAC_RIE)
+#define XGMAC_DMA_INT_DEFAULT_RX	(XGMAC_RIE)
 #define XGMAC_DMA_INT_DEFAULT_TX	(XGMAC_TIE)
 #define XGMAC_DMA_CH_Rx_WATCHDOG(x)	(0x0000313c + (0x80 * (x)))
 #define XGMAC_RWT			GENMASK(7, 0)
-- 
2.43.7


