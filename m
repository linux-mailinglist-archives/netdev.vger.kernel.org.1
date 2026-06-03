Return-Path: <netdev+bounces-294645-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GzNnF8TbH2obrQAAu9opvQ
	(envelope-from <netdev+bounces-294645-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 09:46:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C733C6355AE
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 09:46:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=altera.com header.s=selector2 header.b=N0mEjWpM;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294645-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294645-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=altera.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A070730D829F
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 07:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 935D540962D;
	Wed,  3 Jun 2026 07:29:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011000.outbound.protection.outlook.com [52.101.62.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A91E40242B;
	Wed,  3 Jun 2026 07:29:30 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780471772; cv=fail; b=XTeh3OCqvTUzrruTUhmP+yM+/e4CJ9EHXPXaUZF4CTP4cjMjY3OHYL4XC7c+O8GaWgOzUIqJGeEcXL0Ug3/vu6WZmTxrbJJO1P4LxibO7A78T5uupvwXlbgQeS4TRbRr19BXCCQtkjIpdvg3lFlXhmiDB+cvCrhFfnq7ShP6U+o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780471772; c=relaxed/simple;
	bh=j1tjeByXeIHinLjHoJARApYbtqw5FLZrQo/H1IVDTic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=azZh+L6gbx0+yQFrFyZpKJcosu34Q046qXcZi9xm564nCnsoB7JQCV3+IKHuP8kaYir87BTkvWfinrMajlwoDyzJbaBNxQFxE6j5A3yzKVVY4VTmrUn8MZRsAa9/4sGt6qU8M7VBNHvA57Av2yxDoDZ+DM3WR8nTsqmT5wsPO9o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=N0mEjWpM; arc=fail smtp.client-ip=52.101.62.0
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AYYLM2fpXz6JTrfH0KshgBjDKtUVpFlJ/OlkVBKtLzggWqJp/d0GzJNNGbhWpb4E6aBiV3te1BmXJXKOTl2RF38jqskQq36ehgEqeRpeIN4N6UW3qZXQ4LaeNnitNtJ1jkvlYG0AXcHzhVU7MFc49UJ6KkLVGfLpLE2QWw51R1PmtNo6WoxSg7TOhP0KGH/jEzrQAkcz/2vcE+6xwJPHjQmKzWpZ108RyFOj65C3CFgSTPs2AaPxxt/4eFtfh13eu8T+pMz+4IPp48MuqF0Ukc+RohVRAg6vLqnRaAlbWqdXkwJULUJCCvY018iqES+sMhwP/h/yIUppdkN4FsC5Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R6OgbckISqAtzhoezk8E1ClROdhN3BCX2f8lIC8DmhQ=;
 b=wobRbE0zGj1wZJ2Q4yJKNF4dJjjmux/gz3vM7klwz7lGefzjcUGs2ngkGice6AeDeh4erjQgWm2zOXvMmCIXIoup2YEfLOwaG6+lxy/YRD4oncHHKnw8nDlfXaLIEGY3iJlG2uDqzNrfHanD/fdikzsnNPOLi8wvRk/e7Tx2XAjjtqR1GWix3Ya5dR2fH2wff4f7bzEVc7kLWI3cigd4ze+du5XzSVzi4IuskwtClWlFk2jEWTWPm0uXuikeNnzLl9itpxBaH3GEvql3YAZj5xsXIoqKjwU6shpd0kV2vrnwg0bw3+9/DMpcuB74tuMdxF4cGUAYcYKB4CAROSy64A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R6OgbckISqAtzhoezk8E1ClROdhN3BCX2f8lIC8DmhQ=;
 b=N0mEjWpM4wiYapGAYVS88rR7eIq/1Ey9HFIImBbMGXc0XtEj6a5pNSsAfb3lmkMk9EnqII08VtushWaLzJgVNI6P6C/mSX7pSJvD109EWSqM/5p2X1YuPjb2TKpIi+cYRnAhIrYkbvL1Oo1LExuthwH9yGf1xwBjew3yaBu5OgmGedUqJQ0PxinKlk//PSves9GaDni2y1YNFTBLKYhNYZ4q3szGGVwzvAhSoB80qPiYOuFyXMBqa5edyu8Fp5WeRxxL28eervxGWd+ov7ZPsZ12NJNd+Pfw35IWNGL+9muyuGZK+UzjyVGjIZURWTutFvMGDmeBWAdI0v+PylGIlg==
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com (2603:10b6:a03:432::18)
 by PH0PR03MB5813.namprd03.prod.outlook.com (2603:10b6:510:35::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Wed, 3 Jun 2026
 07:29:28 +0000
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775]) by SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775%6]) with mapi id 15.21.0071.011; Wed, 3 Jun 2026
 07:29:28 +0000
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
Subject: [PATCH 1/4] net: stmmac: xgmac: fix l4 filter port overwrite on register update
Date: Wed,  3 Jun 2026 00:29:22 -0700
Message-ID: <20260603072925.27890-2-muhammad.nazim.amirul.nazle.asmade@altera.com>
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
X-MS-Office365-Filtering-Correlation-Id: f2aedf15-81e1-43a8-4544-08dec141d839
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|18002099003|22082099003|11063799006|56012099006|55112099003;
X-Microsoft-Antispam-Message-Info:
	lwJwGEk3RNCfIgEcO2tTksB3AXq5UeMgM+hKf4/C0oIojymD4JZY+V8je83jupmQVs2YhsfeZgjpy5/p4xaZQPgOsxakY80a6JW/0xeV0pvB48/Bh0Y85yrdi//6LnU2Ix+PHBlm/zmlUme89Zo2nNtLynqDVxCaGUC31aWPVxm8h1GS0lQnv2EQfUCBzo84rv18Qj0cTlToTviB66iPBMxOIs+MWofb1BLJaii+FJzTk72KIGUKGV07Efxgs/T1klfU9sUq9dYxdq63I0Csa3zCEIUEZyP0N0jkZw3Orb4ITq62+0fEexZXGLuGyFvGHIwbcN0VZ0B/h0Af1HswJKse1yXimbiRKUMfjkivKzxbf8UP54Px+OOmGVZKaD5/gfTxo8VwZrXCKUkbaAHj+nzlRMUKUCVn3J5BKzou7IisvmVZ28bjK2OxaxqbtaNT6l98eG/dVAXwe+q/aH4A7e7JWpCuRvU/BI/8cFY/8eayKWwO/7ktFMdC5Y/d4MPIT+ws494u9wwsxERT2DtWJjWBY/J3y2y/LDdvc+wFjHDo46m2y1NpAoFrsbTbwPfDB4xKVho1qLcihJkeXbuTqhHaQgUhzTel4MLShBgBfiqp3W6M0TzENTjPz+VCvM5g5p1DJ9skUwCtPNUzJSkyi0FsYQsYgfKXGGQ1q0/vlEmXLWOF/qQbgR/uKU0+EyIC
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6964.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(18002099003)(22082099003)(11063799006)(56012099006)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4IICnU+1+CXWp6YorzCGWExP73IQTumLyu+eejdr1bJfPet5KqXUX5tgMTBC?=
 =?us-ascii?Q?gfaqKN48mrV75bj9PqzmgF1z5UScpCHC9jkNJwcmEeb3dJVMDydm0i2M4Nev?=
 =?us-ascii?Q?rtpfIEaufFk5MIHMpcjHN5wDIEN60aAI/cLu/d9/UBtBOHtGKfbyCvB2BTmb?=
 =?us-ascii?Q?6m+Y5VQmX5487j02D72tmU1jD9lCVWZhmOlaUisZY6v3L7Pstmh0SRcpj4hb?=
 =?us-ascii?Q?PqMXekHMIFFJeIOUTUOoIJv8kXbue4DB3OZAfGq6occ3I3ZexSHZLimaLy40?=
 =?us-ascii?Q?+8bOye39U7eCcd6dQWITgiJebPkOE+UoAnakSxE1J0MFLnM3XPlgLc3n4CqL?=
 =?us-ascii?Q?gWEd7551rzszTyNu+dflK3U3dLoyC8kxqQdPX0oFoSEtGmUgR3OEpv5j6wv/?=
 =?us-ascii?Q?z4Bzq4EZeI7ILv51ffpbo5Zl9vLZM73sIzIvvgi3J8CnPgGYBhlnrOFFDqXT?=
 =?us-ascii?Q?txvdR5UwDLkhUxdv0pIx2k/0FxwViHP+xtLRYlO8VMohum9rKKkkVr9kideq?=
 =?us-ascii?Q?fXf5STsF84XEeQlYSf25+ivoLTCei99ATBAznLBmiiBYVoh1Xl2Uw2+rc5yh?=
 =?us-ascii?Q?tyXkt0jAHcQHoFFoXQ2KHGqSZyNgRYRlEHroFXn9i9RHXXv3larGPNXzKnVq?=
 =?us-ascii?Q?qq5ZlLxZCV+rG06VKQAB3gDEXSpj965nC6YcQTafX0mnEH+zP74p11PglY06?=
 =?us-ascii?Q?x0KkrO7tJacVWXV68HEs3W4KqiQGPJuB5+hlfIBdjEysSPcS4QFBhe+pUE/P?=
 =?us-ascii?Q?8DJ0emeHXtRJ30K/bNJJYhpkdUT/PRoJuMhHoufX02zp1iL2zXYQ856jvufZ?=
 =?us-ascii?Q?OO8KZofGQKHv4YGSpGBZINjW1vWon6asslp0v/8oUNtAzzrhIPy1qdp04ii5?=
 =?us-ascii?Q?apznG6hF2Em2ANw/rpAYLbZJ05p6VM0ghvbJbONHfv8ccmbcPvw0QvLsK3lk?=
 =?us-ascii?Q?BvihC1rwcBYdvJ4U3iogpJp3v4OzfEAYkOvnZM0rFT9BU+qKTxoTEyStQub9?=
 =?us-ascii?Q?ui3CxMLJcNK2qqv75QVeJLqxSCOdy6NCwCsxWUSA/qykl7SNqDEl0J+h3i6u?=
 =?us-ascii?Q?a48UH9gLz1sAysN6IRUr7QS9k9d0FByOTB8KG88yRIyDbEs3uddvvfnTV3Ab?=
 =?us-ascii?Q?LqZ58tqt9XcFFQBCmBv9yYiN51uBwFYWjN5GLoUPg6JneDAjLKmHcsQYIQeF?=
 =?us-ascii?Q?fQ8BmhlYnLDULaKFnQv75szT04IdmAkqgIVwT0sHkYqgnzvrtNKPPcK0hqEC?=
 =?us-ascii?Q?Z7lmC9LobMefaqxngriZw4yK3Bg9ZXvlBbTp5uTTNhgz34XpB3HqzcWLeRIr?=
 =?us-ascii?Q?N9oSNg3J+DSM08p5t/mkSgjN2DitCA4/hmG+VxAfifakAII4CmIr6IJKi0vB?=
 =?us-ascii?Q?hZz/4RBz0DieWoxZck5EQ25J6bCzYE5wZSZZ2VaU9G2Nf8sFg/2inwafeYL3?=
 =?us-ascii?Q?n+jMl5F9P5gisdACxHEb5/Lm+ZVvLDJtlqLImFLtFa4gVM9u6/GBn7XpPEyN?=
 =?us-ascii?Q?GRvz96K8VVK+FeF63yT/vx+Uv8qSNyQ87J20pSCjvDsNDiDEhLHuO/eR3+Ya?=
 =?us-ascii?Q?m4t8BrL5NEcefWL80thqqhYWt++EXQZaBekQIO1LbqH92gxF9GOzh1iA5V66?=
 =?us-ascii?Q?OUS0hGWZJYZwEF5g6HsaXEi5NytqeDTmTlwzk1Li5g+v3Dz/VaNRInOoi2EV?=
 =?us-ascii?Q?mlCYRMDHuRj7c/voapHy+jjmOjfYtkk2MrS1mzImyHUqWE9M7bjYWkiNLWtl?=
 =?us-ascii?Q?ZBf37NBlNV3bnO3HZ8FZMD7U9UvITZKrVq7ZX83lCpP6Almu22cdf+GbizF0?=
X-MS-Exchange-AntiSpam-MessageData-1: 8A9mFxSYzotSCA==
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2aedf15-81e1-43a8-4544-08dec141d839
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6964.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 07:29:27.9291
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DNR4wzz1n9ZoVzO/+OhNXN+FmwByCgUVmILYX4wuuq3YRoSsmFw6VH35k7BYtthNPbfgTrguCGWuKKZDEzpd7dHxrM9+NyHLMAWoRY0cS8MBo982cc8qvxVsJQWa6xqysObW3uRk8WKBb8nn9APkZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB5813
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[altera.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[altera.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-294645-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,altera.com:mid,altera.com:dkim,altera.com:from_mime,altera.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C733C6355AE

From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>

The XGMAC_L4_ADDR register holds both source and destination port
match values. The current implementation overwrites the entire register
when configuring either port, so setting one silently erases the other.

Fix this by reading the register first, then masking and updating only
the relevant field before writing back.

Fixes: 425eabddaf0f ("net: stmmac: Implement L3/L4 Filters using TC Flower")
Signed-off-by: Rohan G Thomas <rohan.g.thomas@altera.com>
Signed-off-by: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
---
 .../ethernet/stmicro/stmmac/dwxgmac2_core.c   | 28 +++++++++++--------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
index f02b434bbd50..52054f31376d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
@@ -1370,36 +1370,40 @@ static int dwxgmac2_config_l4_filter(struct mac_device_info *hw, u32 filter_no,
 		value &= ~XGMAC_L4PEN0;
 	}
 
-	value &= ~(XGMAC_L4SPM0 | XGMAC_L4SPIM0);
-	value &= ~(XGMAC_L4DPM0 | XGMAC_L4DPIM0);
 	if (sa) {
 		value |= XGMAC_L4SPM0;
 		if (inv)
 			value |= XGMAC_L4SPIM0;
+		else
+			value &= ~XGMAC_L4SPIM0;
 	} else {
 		value |= XGMAC_L4DPM0;
 		if (inv)
 			value |= XGMAC_L4DPIM0;
+		else
+			value &= ~XGMAC_L4DPIM0;
 	}
 
 	ret = dwxgmac2_filter_write(hw, filter_no, XGMAC_L3L4_CTRL, value);
 	if (ret)
 		return ret;
 
-	if (sa) {
-		value = FIELD_PREP(XGMAC_L4SP0, match);
+	ret = dwxgmac2_filter_read(hw, filter_no, XGMAC_L4_ADDR, &value);
+	if (ret)
+		return ret;
 
-		ret = dwxgmac2_filter_write(hw, filter_no, XGMAC_L4_ADDR, value);
-		if (ret)
-			return ret;
+	if (sa) {
+		value &= ~XGMAC_L4SP0;
+		value |= FIELD_PREP(XGMAC_L4SP0, match);
 	} else {
-		value = FIELD_PREP(XGMAC_L4DP0, match);
-
-		ret = dwxgmac2_filter_write(hw, filter_no, XGMAC_L4_ADDR, value);
-		if (ret)
-			return ret;
+		value &= ~XGMAC_L4DP0;
+		value |= FIELD_PREP(XGMAC_L4DP0, match);
 	}
 
+	ret = dwxgmac2_filter_write(hw, filter_no, XGMAC_L4_ADDR, value);
+	if (ret)
+		return ret;
+
 	if (!en)
 		return dwxgmac2_filter_write(hw, filter_no, XGMAC_L3L4_CTRL, 0);
 
-- 
2.43.7


