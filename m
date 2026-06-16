Return-Path: <netdev+bounces-299728-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lxViM1/RMGqYXgUAu9opvQ
	(envelope-from <netdev+bounces-299728-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 06:30:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DD9B68BE83
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 06:30:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=altera.com header.s=selector2 header.b=FFNbZ9+i;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299728-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-299728-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=altera.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 915623104750
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 04:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DF4E3CDBA9;
	Tue, 16 Jun 2026 04:27:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011023.outbound.protection.outlook.com [52.101.57.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35AED3CBE61;
	Tue, 16 Jun 2026 04:27:05 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781584026; cv=fail; b=bMa8WSGPKxt1KciqfmVz+mOldlaJc0t7ZwIY311xzaCy0sQwZ9Np6njr/gLbBjRRvCj+vsJmzP4Si61Y2zzMsIwxL7OOCculjFD44VvOloPsbJWhfpl/x9gaOrV8dcPddZiF8RcTzCrOe7UpWeYWzK+kijZp8QCHWAXCGk+LhXI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781584026; c=relaxed/simple;
	bh=v9dxslsTPqb3WtvX0rHFQRbfj3DDkbQiXwf6feW8Nbw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JDM47xsiIi6VEjd++whcmf+uQJ6opiS9qyd1DtZ1MwD65ptiES2aqtqtbwl1SHK3g1yLqeN9o8S7EtgKUBTDOYVkVnvFjTfuS8jU73B2/BwJgdtvuSLlHcgDNeuNyoG9ppJFlg/emrYeYGCvttVQshp8gY3m3qsBnXvs1cR7iso=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=FFNbZ9+i; arc=fail smtp.client-ip=52.101.57.23
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A9lAIeshbYPypuqYIMIkizcESp0nekPa2H1bB7x11A+gSGi5p16xSkv9EwN8mm0daJdVlun+F15hc5Q88Mt6DPwtQFUGhd6hKd3eiBwpnNqLdRdCvBItQLfBPYuIUUfk2AVkdn4LeQOWKYjZ5qGXVRULmVC2JRqGOo6IJYaeUGSBDcwbM3SNY2oJAR/RAiny3sKexalGNuseCpZSAX+mKxKNKQvUAVGFBRlihEr0JshjcxiKMqbGSvH5nTmODLdZi/ImiTVACco6ZXZJAjybjbx4zVvH8t4dma//efLGFOyOBmGMF63h4m8ohhnLYfVg8B3a6ISVKvy0r3gc2BLfNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=flVCSC3XhnE/xZQW47yl0FUFr3syt3vux5Zpr+2qRc8=;
 b=hi3nv1nYpH4+kxFUvq/75Z4kUmHck+R/e2JP6PuMp47r3Ay6UAM6u7QOKsgpBVcu2j2JeWs2tpF7lGU8Hfpub+Nj5MSgcN+GnuSOjilMKsXa88NJIHT6lEl4MRdrXfQcu7f5UpUM7lO+z+hZhhXD2GMj7CDsdjcvzlJ2X83M8ll+lEASRDTdrA5GheRl/7qmRizgi6H2NJTC/4Li790bfIp5Mst28e0y/jvrQvACaDL44oi03iYce5OqnTtXyIiHRJCYAJ+xXt+YEoHYOiBU8eXczPOkZFf2H9L95zvlanTW6LLo8dPRNqmW507b+YgAwyBkbKYSZBfD3QJZ9INSPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=flVCSC3XhnE/xZQW47yl0FUFr3syt3vux5Zpr+2qRc8=;
 b=FFNbZ9+i2sLa+CQH+GmwMYAH2H02aSyWakZMFjQWr+4zmVnWxji4yt17jeDJhnZxFk/NIhqlFJABfeYnMNjPnufHOSA/SY44xoGRjYLOE3IhzIdXqb0+H/w6+BQmc93+rxOIC5UBQfhGfnQCTjn1zDX8gX/3zrrUuwxIBaAEUzltzx43xGNbUR5+cycSTrY0UKsRXcNM85q+t+EFJHFIbJqDQR2dephh1GGXjaK87lKlTVI7D3xJQ8Kr4NP2CG+gkmf8Gdxya+TNVBa+o6TFk+knf8x8fguULA7lLvZNyD1R3A6bHXNjhq2MakuJLNbYcrmDxLSr7H6GvID7JT4YGA==
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com (2603:10b6:a03:432::18)
 by PH0PR03MB6333.namprd03.prod.outlook.com (2603:10b6:510:be::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 04:26:58 +0000
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775]) by SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775%6]) with mapi id 15.21.0113.015; Tue, 16 Jun 2026
 04:26:58 +0000
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
Subject: [PATCH v2 3/3] net: stmmac: reset residual action in L3L4 filters on delete
Date: Mon, 15 Jun 2026 21:26:55 -0700
Message-ID: <20260616042655.7782-4-muhammad.nazim.amirul.nazle.asmade@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260616042655.7782-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
References: <20260616042655.7782-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0013.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::18) To SJ0PR03MB6964.namprd03.prod.outlook.com
 (2603:10b6:a03:432::18)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB6964:EE_|PH0PR03MB6333:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ee186eb-a444-4239-bdba-08decb5f813f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|55112099003|22082099003|18002099003|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	ev3F8Ddriyn99ZWZd8Cte3L8WzrY6CxPdacmuqb94CztNwjpn5IgNeGEzh3pHM8D78rFf8ZL87NnqMwldmqGKy9HjF88P+sNTiJxZ0Js/7PAwmq5LoqwObU9cm3+3hJWwve4SysGDWvwfx4SiVSRZCJOEEWPYQcVQXtWvc+a5UX40DP4raO/9USkejKZaBeQIT2HMyib5bE5jxCeiag6c9mQw06kXS6teIfPEzEdWQz4WsRfPTWnxnMAOWETQNEQTdEfMamCLCnYiOvHPhOsFYoZlwbjjTOtbHtG91zXFgusykx1hBjJswGHrBSPLRsR9E2UylSut5TX0y8YIXyqhX2tRkiD1aDTPb4cZV5fdVZbZBBQnxz70uwF3U2rjCO3mctF+7+tJ8tUbILTo/C5ZhFjWuNMJ5N1KLpudu6KtZmUb3yoEmHoTp1z2J62S4w8l4Q6KkptEy4Nge8S/2gaGCYSG/DN4sWDuSpXfft8FXqzAeUzp+x28hRze5JfZPrRg13yip1xlHP+9lqnijxgTXjSZ6AJZ2FHtNIO2Jhq2GotjnzubXQ1v1obcmaBoRFywV5wcv7QNSdRozlF2oe9cdDnLWQqSrr6sf9sEcF2WgkfetFCsfV8rC3RcR4mB38HQ5hVfb+GEpmJOJOhUyS7f5HjDZqdPsVvVWIdYSWw7kFcpcdhUjID9Z2e7OA7A0VU
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6964.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(55112099003)(22082099003)(18002099003)(56012099006)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2RM2APNcZYrj9BF0IvST1WYg8VMjlrVij959+70VWx6ySrVip374rWU6wuxE?=
 =?us-ascii?Q?J4PB3fPKptPb4F4FR7f5oP0jL0CkhtcDGniSQnatCXSSrawNopVOXogD9PWx?=
 =?us-ascii?Q?fKa7kcgNPrR/jVkXOwfRwKEe9yk3dBhSrLcpvWvgf3mw99c7d8NzWvLR4rpw?=
 =?us-ascii?Q?DcAxTVhJCthgp9OzC7DndYR1dQe5EoqNB1ujqldkFpY8NnQeW+KSTca6gvjo?=
 =?us-ascii?Q?gX83sjwR14QPfFKD0zX6vvKzC3lOhwVCn5P2rS5bmBYp2b4zdIxF29FcHJcZ?=
 =?us-ascii?Q?jcbdgxgIav2KhkYbwVjdH+qxO7ycRcKeXc7dX0FjKP6TYyu2z4/jDpsAxsm+?=
 =?us-ascii?Q?WFUqyIQ+RI6I6V/loJ3E8X2nWb5yDaDGuAEsAo1zLrIlluJV1xRqgTWvEQa/?=
 =?us-ascii?Q?W3VkXyy0ElLGyJW2XkiHoSFNETVY+jWui6t+taLtAotww+ZqH7ay5dTNW8Pd?=
 =?us-ascii?Q?QTGADnOK+bRNDCl8KoUqbGpppQx9CNXCNidnh/5rDJCH/UNIAQu8HeJx4Kxf?=
 =?us-ascii?Q?6/sJ9a144Ohctx7bmvZ/E8zcDzAeeWETtThRTGGnu2H9bUQZfl7HlllfnPeK?=
 =?us-ascii?Q?aAm73smxQWxj5VCu2E29IGJ7QS51oAhr21YVMbOKJ2y48FiZROx0Y6gWmY9i?=
 =?us-ascii?Q?gdl+egnyYaZbJxTZlREEu2FEOU87purYdC1llsKe9O4NG2AmA5WSbq7/QHG7?=
 =?us-ascii?Q?gLeVraDLgRujfDG5MdkVZQACeakkL//LLvAWsLv2kzJn0Ya3J/gAVTNQeckH?=
 =?us-ascii?Q?ySUQo6clGsLLOMwTGwTBd0uTjYS9WIyB8x5/bz9jCsedWnGZ/a7Ou0BFHfNc?=
 =?us-ascii?Q?5326mmNQ2cSXfuggfLDt6pz5BgTRul7wGqJXuCfoqfH0AShTs6O9vZz0HKef?=
 =?us-ascii?Q?1lf1AP78BomLkb2OkqlTBRzaSTf5RQ6jqVjYywiJLhUwF2WTrxYyA4dGcX4E?=
 =?us-ascii?Q?Pk0CQ7AvN3sngRzwi+UjlrNfmNRT7ZmU91gVlK95zYmFj5hhYi+oXFbKq5WJ?=
 =?us-ascii?Q?PWVPj3fl5cAuzxTpIvz5y82ioXzo2eBktBXgp4hnUuxDRUgM/jd/AkCkUXfP?=
 =?us-ascii?Q?58/b5Ekz1UmqXO037qp4kkRucu6JGQE9xKYo+LA4XTAxntI4aJXHPTL7ZTx5?=
 =?us-ascii?Q?307AUcqLA6pQVizc0smMlAI1ForVOJ4VvZ1+gA9ieEaxfqiwE6YLtbknUXX9?=
 =?us-ascii?Q?BMgRGvRgpO2zWhmCfxrMblSyXXsnDrVFcp5wK49w7QFlGpX4b6HUhLACbNgm?=
 =?us-ascii?Q?SYV3K/hIY8gP4BXuIlIE2ROk29i/3PsX/Rm/rDSqi1GwbquXWitbGEdLPcT0?=
 =?us-ascii?Q?J1ZE1fxH77YgyZjficK+iUsI57jvRnZEhg6Wt06BKVDlB3C8gJc7hF/IvdPU?=
 =?us-ascii?Q?STV2QU09RSs4X7ulwcJqMjNwRyTJjCS+NZ2/576em48XgkoRZqmcxu4NtwP5?=
 =?us-ascii?Q?FgqUCcMxan41utDgSqCQf5PQQFxRyAbjda/GfS6ZHnwy2pc33SIGHAT9CXpt?=
 =?us-ascii?Q?av+4RQ7wsr9LavGxI4dN6oiLhhEol5PQAqpUyNb+cJGZPnZpuA/swkao9y8Y?=
 =?us-ascii?Q?clXj5qIxdb8yNs3r0wtXha4Qn14s+8I1Kp2MwRzCoO/p7hEDkO1b1gHLyOKN?=
 =?us-ascii?Q?Emyk1ZhDTSc8IL4xC+y6ITc2yXGnHvyNObZugL55Pp4IYQtRvSTmAIbdEbY8?=
 =?us-ascii?Q?F3TCHlxm0SAGcSedzIxNKmB3gB5nRVSjtPVdt/meA1U2VEPHT7KSNN1LpP9J?=
 =?us-ascii?Q?lEpB/aK+GoEUABur49TsUA/m8onBHVxGIwuL/yaRVRgPFdiRQEQyeGEUuyWQ?=
X-MS-Exchange-AntiSpam-MessageData-1: 2szm1855gqk7Iw==
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ee186eb-a444-4239-bdba-08decb5f813f
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6964.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 04:26:58.5701
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GahR8H597RWTGiKzfL2kPfBiLb4FLt4Wl+5TUgg5dCHa3bbMVKVv8nfr3L09NgRdpmELhXSRYuGoZCZG9ehzfTvhz1AuPf7LPiVksMvLCNCk/5D6+kZ0BH6j67H2KI15C7cIymm6M9Ow8hdehRoHuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB6333
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[altera.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[altera.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299728-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,altera.com:dkim,altera.com:email,altera.com:mid,altera.com:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2DD9B68BE83

From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>

When deleting an L3/L4 flower filter entry, the action field is not
reset. If a filter was previously configured with a drop action, that
action may persist and affect subsequent filter configurations
unintentionally.

Clear the action field when the filter entry is deleted.

Fixes: 425eabddaf0f ("net: stmmac: Implement L3/L4 Filters using TC Flower")
Signed-off-by: Rohan G Thomas <rohan.g.thomas@altera.com>
Signed-off-by: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
index 869f84756ca5..4f9758eeb86f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
@@ -653,6 +653,7 @@ static int tc_del_flow(struct stmmac_priv *priv,
 	entry->in_use = false;
 	entry->cookie = 0;
 	entry->is_l4 = false;
+	entry->action = 0;
 	return ret;
 }
 
-- 
2.43.7


