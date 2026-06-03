Return-Path: <netdev+bounces-294648-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Z3E/CsjaH2q+rAAAu9opvQ
	(envelope-from <netdev+bounces-294648-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 09:42:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B27F63551F
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 09:41:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=altera.com header.s=selector2 header.b=eR9VB3Tr;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294648-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294648-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=altera.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 93C2A319114B
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 07:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E702F41C2FD;
	Wed,  3 Jun 2026 07:29:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011000.outbound.protection.outlook.com [52.101.62.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E391262A6;
	Wed,  3 Jun 2026 07:29:49 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780471795; cv=fail; b=b42VJs8jcxPUxgTwQHkbynjiBvSfHHli3gonG43ZxnmCK5AQC4mppr5F2AsySb4EK4O3mjM8xvo2QDXU/25VbPSOVpQHY31dKR6k505NrcauFMnO+7UcnrPwlLNWdrHUoysuYJ7cYdg1JInwhtW28U0zAGHghghAXfa6ctUNFF4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780471795; c=relaxed/simple;
	bh=v9dxslsTPqb3WtvX0rHFQRbfj3DDkbQiXwf6feW8Nbw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jkbgNNGyWT8vpxDhoKYFM6P5I6qC6G9jUpKLXk3ma1FxSZ/pN9VAemzKx2luXQgBtXJQkTIBW+BiSGvC0VhTv1LclCUphWgNKnQhycyWNU4/jvsja9okHnmakwpCRj0iNIYSRE2VevSmM3/90a32gCr469mhsksFsDXtn3EOiLo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=eR9VB3Tr; arc=fail smtp.client-ip=52.101.62.0
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o2491l9OsWUpKQTMK3KNcXuYo9uGhXypPBLaZ1XO/rFZV454ZtHY2JpN8Jx7Lt3CYASSJPqJM6Y/yq0iKrWaGspFUHzWdNJfzINjKBweaXDLS7ICF0VrQCsdHylxfcFeXyKKLaZWMpZsxMreuu66jrL7ygCI1A/kb0rR+SN67ptwaSg4vp5UK5T6h/Uo679dVn4BSEDeyCgFiDyMWjTSOEAwNgP08me7ckuwlZ8D8d0byzmxGARkd7VtKi2WZ7TWzEVBPmUMSAhFlWhtBbzNdP7RGRxt5HR7Osqw4+tr/LoRso22BEhdglSSDYwTXsDEXQDovQ1hjMIYPS41d/F+mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=flVCSC3XhnE/xZQW47yl0FUFr3syt3vux5Zpr+2qRc8=;
 b=vBNG2RSx43VymTzjhBA7C7glvI4ZR0YgWbkxP/nhZwja7vUikbfDKSJdccYIYGHn7bXLPcYcVmm4r58wLa4d489RXEg6zSDkwNeRwiMnAcFrJ728qX9lBJQUHiN4pwJ9+onZCrRaNzuesJF+dYHB5AT4M6o/jfxiTjjDdM4/BBvofvgjbEFVnIjTQmrLYPI4gfBxF2e9YpnTWIw4zc9WxT1jGi8ptu5e5gGuY3Uy+ouuke6glR/l0FvM/AxI7vxHeJdXIazT7enJyvXMugomiEv44KAZIHGnBojFKxn7+HNgcWwRGLdY+5S5XAmYZ5f6g+4H5I250ioAeA+gCTZ4hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=flVCSC3XhnE/xZQW47yl0FUFr3syt3vux5Zpr+2qRc8=;
 b=eR9VB3Tr36Dtl0Oxs6HM0cmDatTujBLmBW16QHcphypASC3PCThUNRV0fk1TMVpDn/DAhW0PKtxo8JXzrrIlcJSkjzrjTjitmS9t3N8M+C7j7Xl/rGZD5aYiHw/HB0ciQKvWfU1ozvdljoYM0u/Cj7Ie8ouIyiZPFWHPRQ5ebGQvkMwtbovVlAewxKAJ/H731bwvUnPT2/V4JVTtnYf3iXwX2pysjcGIuIJAz3sVJbMGrgIVM3C3PnWkjfxRwaLMEUYWuInDPPYQ4j72pm8YJhas6QJdTOZdTe1syyITkp2FSkKekxVLSpfYDTm0M6wzQEgp1xS4WsPnjtLAocM7zw==
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
Subject: [PATCH 3/4] net: stmmac: reset residual action in L3L4 filters on delete
Date: Wed,  3 Jun 2026 00:29:24 -0700
Message-ID: <20260603072925.27890-4-muhammad.nazim.amirul.nazle.asmade@altera.com>
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
X-MS-Office365-Filtering-Correlation-Id: 35b86286-bffe-40c7-5be7-08dec141d8eb
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|18002099003|22082099003|6133799003|11063799006|56012099006|55112099003;
X-Microsoft-Antispam-Message-Info:
	s3xGML7izTxK98WwnvydbSHAagj4GhlotUvebYsnk7iNjsPNrI6N4vRV/EUIl5crZVopGIID7CHAVwasrz3+u3fn5C7EvMtzJhD0X16ahDU4GXUIQurTazzD5HhAYJhUACGzq/vjIa5Gbb5g8MFDSOkNBvPyarhxea8Y3m/qi6IAZBweIWeLkxO9UxnSoyjVhtCcU56bBD6JpVDN11Z46Dkw680qB4QZbH3Q6fjQK7KlGf+gDqq7hmPZzUxCVRbSp9m9lxeWrNUFhEGoX26cQ9Qpvogf6M6SywotOOHlwTJBWOhI2acjycQMaBqU1tXx8J6+L4BxLs1J058F8K45i5n81cvzDKdKExBSt/gtZu0tkZ22Xjwhhwct/gZnHEFJzHppHICOP/szkOf2oPm1g3lGu1lQcX9Dpfdz7VBmiV1rI24zkcQHBssKdIOZJqad9TLEvFFNqDlElTwvhr/cbL/WvrrDKpFBYwnhBkwbvS+hcIfdYUnYEiTkO6bgTN6BJbnKyEb7tI9srzZgGGzm83yk1i5aMTG/Dmou9FK06jSHRfsFPuPBfQRU88d5X6UELNbO/Z/j8c9hrBYfleiZ87Up5wZ2xYvAJaOjCY9zZ/ENfIgobnZqrI0rIypV1bv1f4/PDIIT+IwbCrlYkd7Bea/YgqLXadoE0+/+HrbtV2Odb6zsGcXp5+a00fMTt1g7
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6964.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(18002099003)(22082099003)(6133799003)(11063799006)(56012099006)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jnxIdce8okcgKBTGPi1GAfUxdVdnfwA8qstx6JPGcXawrNDyZT0EJ4o6xs9H?=
 =?us-ascii?Q?uIQbIIkzCFUZDY+pqbEPZSFsVKqJHVl6dcuPndq+ypLA/X5B8CsG26M/HvK/?=
 =?us-ascii?Q?q+FKtQ1KLdWdxBHIcnKrVCTd8HjLDrwaxoZU0ANRsUDCc1z3+zJKc5rzjMNG?=
 =?us-ascii?Q?9OpldfJxTlz/FuvaCBVsg/ts5PRfZeb5+lLAnyqpxrG2MeSklIwNc+8OKXQf?=
 =?us-ascii?Q?DMF/74dsy+YNwI2cCLOoJ3NPL91KYmIFG45fPRmToXrK9W8YSKaHexVMaQrb?=
 =?us-ascii?Q?XKzo64t1YUcuWbPATBTfqsDtqnXTBNwsSTdP3MMObDCYLHnjNvZ29YI5hihR?=
 =?us-ascii?Q?akHOHUIIqjxabKMM152N0h+xf35HjPpQqLgliYx4ue+UqyIGqsrWWUBLskKU?=
 =?us-ascii?Q?4jwqgPLlGx3YMt+42fShVprahRKCRSaTYDgfZldXwvnw21V1pMi9qOVwTymk?=
 =?us-ascii?Q?9UBhQ6fYuAjHortqHtPVvpLyquTk6e3AhC2gcGOiBTaOpqg6ywRIj4cdzGLM?=
 =?us-ascii?Q?BkeRBE+BYj0kJxT2Uuiq5BMJGOngNdlTMEJCl0YBbe2D4PyjkSGs2aMMocfd?=
 =?us-ascii?Q?5UBFTLnHXVFTyfSlDx12acMEHrtzkCHwLPFUS6msXlZoU32wtHpAkWgVldSN?=
 =?us-ascii?Q?a2tyCRPgvrISbFzxMcVocszyccbbFcL3aZBGpANwhoEIHxsoMHbhKrLMSffv?=
 =?us-ascii?Q?UsyknpgQgDt9pml6E6ak5o9wmYRuHM8PV7Pf36WRIhwZIIE/DARglJvdhxGj?=
 =?us-ascii?Q?tU2bMLVEQ0qpqvnXors0pJqR25rQi/7v8hX46L8MpGoM4Bi6CM1wjbI/Jnns?=
 =?us-ascii?Q?W/gV0BFW33KcY7xiGg6nWDO3sqFxuwh+7/F/XkAvRaK9GQbjJN0+Il3poZqr?=
 =?us-ascii?Q?JrGILv/NOzgz4igvKn2l0TKdpEpxAiPXPUkb/susDC5FqaKkaKQ3TxSK1ln7?=
 =?us-ascii?Q?FRAD2+foglq39EQQDZMMRsvmfS9k2Yr3CyaaCox0FP4eMoQ4QwjY2khKPICx?=
 =?us-ascii?Q?vi9ytC4mfy7fRTRDa+X/2OVpcxatCut+op75UFk/TVca0FUC3BIzDCPIbsrT?=
 =?us-ascii?Q?2noLhfYJH/3ObVZGW9/k15e2KN5Hr3jyMxCeUeLWVtZijBX/av7GL8YRDmA+?=
 =?us-ascii?Q?jj5fUnJum5O3IZ6GFkmMIYxOqZe/ldpiDGAQQ761+tJudgpYZn8fI6P+Sd3N?=
 =?us-ascii?Q?RrJO6jJiyOuU8T4UW9R3DgsKHncipEC3mz36nDsJ93Y3ZMzcy6bQNS/i84k5?=
 =?us-ascii?Q?8SO8SYVzdRHOqV30MwJxOHy80m64NQ60EhpsFpURIREtE71JbEGePMG20A3o?=
 =?us-ascii?Q?lyc//iiCgmm5kgfQZIIEq8OGcsCoILGhs+9ns6EBQeLdAZxgtnDstF0avzgO?=
 =?us-ascii?Q?R2PYrvzQ6bGoX+3LJ1Ko2LOS3brgOUMrbZURwhlS/QtyNGsjg5jyQh6Tt+49?=
 =?us-ascii?Q?AXQmw8GO0rqHBw3UBo93nXi0wtttCAw5sQlJWfLhMQX0+nrZrNz75NcrXfxJ?=
 =?us-ascii?Q?gR3/t+t3ah7vcPkJmN1HWh5KoT7fZiQ3kGd2KK0M3nUnvAGKzUC1WNibqbqj?=
 =?us-ascii?Q?M7HAdRttVhTU8OixJztB4m47NugWYhPP6eKAIVZOCgwNsUVqZ/a0/jP6zJGs?=
 =?us-ascii?Q?birCxGsUUXpe7c64hPX5+xgkZTgBuri6oJBv0e6yxvNq5qTu1spWzBAChQxm?=
 =?us-ascii?Q?GzenmtPE+8hBAsttXPkK/9LLjUDjXaSztl2eZnGWJZ65kY3WC20Pyy4eoBpl?=
 =?us-ascii?Q?PWV0QN/K28Yw8m1aJIp9wR7sSYhosA/IwlX2qktHcrFDab3LnBuUYtsjNWGs?=
X-MS-Exchange-AntiSpam-MessageData-1: xF0B+hYEN2xZrA==
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35b86286-bffe-40c7-5be7-08dec141d8eb
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6964.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 07:29:29.1417
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mIbrclpLNyYD0ZWcbdjRNWnF8TyFYSLiZDvhpaLicwH6Oj0YuVYjHK8SBm55EsoCi7dtLBNdYgZbLU/hP6OQZHx4lNrpzkV1htyxF9tFfhEgSMk1wl3ukCvieXVrVjTskrOT3xXiwG9ITdkfbf1uEQ==
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
	TAGGED_FROM(0.00)[bounces-294648-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 8B27F63551F

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


