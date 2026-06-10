Return-Path: <netdev+bounces-297579-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id f+KCKh42KWqzSQMAu9opvQ
	(envelope-from <netdev+bounces-297579-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 12:02:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E3EB6668142
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 12:02:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=bUsoV3Wn;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297579-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297579-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 46DF430ACAEE
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 09:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 730883E92B7;
	Wed, 10 Jun 2026 09:47:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013063.outbound.protection.outlook.com [40.107.162.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F3A3ED109;
	Wed, 10 Jun 2026 09:47:08 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781084830; cv=fail; b=ZvX+Z/+J35/31rS/jKlkzFtyRBLYU4g1q85pdS3vEcPbHr4HTa+PpnL5oFdS/oy2cA8oKZEAuKdSbzaq05WKh8kGY6myZWB22N29OX4Sk0o9wwnZjIFgAOk9FLkLAtMbGJffhGyVNGOcpp8y38rd+9v/5ch8YwvyI+Nucj1ZNak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781084830; c=relaxed/simple;
	bh=wtu+UJ8i5slxBzKT2r1FaB/HnCeIE6hf8WVjVFA91g4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WB3oDJa8ixpYXEN2pIDewgOKV4yLCQBmwGf9a6difG+FdyBynFfiF/Y0lW0+CRDJ0sTULUt8cwYAR6jmQhwoWPAHnA9A8FCSZjjgg1FQtrHHhdjlluOsbyCPp50pHof9zwtHMf6stWxuhHYM0jkLBgM0JFcVoFJGes6/F7W6pXk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=bUsoV3Wn; arc=fail smtp.client-ip=40.107.162.63
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UGaRQedih4uG2rqRoTg/HaGc/qZiDMlZXkbJP2YcgykOoJ79hjhMc7qS6J8FqFWyqvPafb/8J6gJ2rtQi5JRh01+bLPLht4gd8cwGWvKjv1ruLQYXhtyTD71VgGOuSOGHKeVlIGeOYHfY0FGruWo0mlV8iYzBrz3XQN8Yco9RBpAYE8ke6AwuLg8JXoBwLUJthvQ9yDy1c8rDgGkGXdVgO8pvAEiUxp1u0GQ7nWNiFTWmx7J10FOJI19+aXtU51hOS8n2T6advT0QrwyVNIoSJVgrsdVealV+YAaFG2CbmXGZelKnr9rptoVSU7fAX6xxaa+f2JkVKUT0rewgeaoGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k92hQXg/MQg1d0QmyeU2n7SNI5wPz2CK1RbWdNVNaQE=;
 b=JTSF2U2obqVWFxs1M8f3E7U9gNp+qG0MxLDd3/GC81yOJfA0kKIBhX/For4krVrlfjk/MLN0jZo2/6/gjae+vkCoDQ3YIVhIYe3t/3dkS8Fl29dnwy5O45VcMSABKe+GPB1XkRCzAlNgCoiXYB6oMn6xoJDLyck1EA2B9eqVi8YHTH1nQLSuX6MAGrfzCX0WDlv8fK60nxOpA9ZV7GRNchf91SCcvpYuAOJpHFAzGanXoTxFWqbVXjGCOFeYRGW2HoQyL3Yt7VMNJuZlOcRGJxyZsJtrSan44GBQkFmFM/KyspKIVoallCWfyr56KGAnMi9lfuJGUu3r6m9FjC5yEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k92hQXg/MQg1d0QmyeU2n7SNI5wPz2CK1RbWdNVNaQE=;
 b=bUsoV3WnxWF2k3/Dal8JHwfKyLMzM2NyxBp1KNdAW2KmWURzn9QC1UlwohhX2zzER4Prh59qvZF/U2J8zc+t27W0fEh0b4UJTi54me/kfLMEgYaD+7nO+Xm29xNzTtaxdKfnz1y1Xr7fdX3y2YmjyzuKcDELtFPvp3LaYYEerCNpsHg6soDwxXjp60amCSWbN+b5qN0+EN1XkYz+n+aX7NzpPJ9M8SbOyuCDEid7Bi1npA47urPUN/pKYQN3QcHXONi5NogCOrcwm7jY9r3SUTQWP76r/J5+k+xcj5Ty7lNb9t+w/pj9Wa0/KYgkd1uAoVSpLTp71oG+F2K6jId+sw==
Received: from DBAPR04MB7207.eurprd04.prod.outlook.com (2603:10a6:10:1b2::17)
 by DU4PR04MB12129.eurprd04.prod.outlook.com (2603:10a6:10:643::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.11; Wed, 10 Jun
 2026 09:47:05 +0000
Received: from DBAPR04MB7207.eurprd04.prod.outlook.com
 ([fe80::761a:f8dc:80dc:5e14]) by DBAPR04MB7207.eurprd04.prod.outlook.com
 ([fe80::761a:f8dc:80dc:5e14%6]) with mapi id 15.21.0092.011; Wed, 10 Jun 2026
 09:47:05 +0000
From: wei.fang@oss.nxp.com
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	wei.fang@nxp.com
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 net-next 11/15] net: enetc: restore VF MAC promiscuous mode after FLR for ENETC v4
Date: Wed, 10 Jun 2026 17:18:40 +0800
Message-Id: <20260610091844.3423693-12-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260610091844.3423693-1-wei.fang@oss.nxp.com>
References: <20260610091844.3423693-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI3PR01CA0011.apcprd01.prod.exchangelabs.com
 (2603:1096:4:296::6) To DBAPR04MB7207.eurprd04.prod.outlook.com
 (2603:10a6:10:1b2::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBAPR04MB7207:EE_|DU4PR04MB12129:EE_
X-MS-Office365-Filtering-Correlation-Id: 6495e1be-2fab-4a84-9d59-08dec6d53b1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|19092799006|921020|6133799003|56012099006|11063799006|5023799004|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Te/od4zjPvZw9bEaYoi41Dm+O7oAzrf9WUdTXyOXSI/dGuWC2dg1rWH87w7kmZEQRr72Z4Xv5od4QM+XKQ8AWEtGbmBFvtrqwbI5E2Tu9FuRqC8IV/qmmHVeRyzz3x0qgeNP82wVM17TDhUQA+yHZ4GWylgnb+uAAOWD7mgchpXo6iUeB+C7ne0op5b9YkgLIVP0T+GGLY2EineVj94UKW6wxW1REcPEWCVLX8rhrjWROa2RPr/EATDZUOT8rohuuCpCwgWzvBZZCOEKCfhazxve3anZVWqmkoFsDEn5EySM/ZDEn4a1jrAsVoeWi2SaITOGfbWECKGJ1MHwkyMFT7raxp/PMRAJLEicAfzI/zNiU9eTlMtnAwri6Ev+jgt/Ea1vSPW3f6cMk3ndcOrKWwdq5WL6kK8AogkuAcsSlE4T8wfkZJpmyrQM4R05BxpG46d/yiMr5SgIVVSSueWyVaKNEl7Fgv8LkEe8KC2I1ujkSlwJgh0x0tkIUMTahEKS8BDFAoCWEX1LCmZACP+T3cSTjudALE96X7U0qLzNYcr+8cnWNzHN2O0AV7Ox9O15VSbxukJ3Ltxagz1LMnym443PYJwFOZXbIBpTOFo58xNdiITpGimGVL9TNYWQhhoG3sQ9c7VT8DW+UMvAgI8dEUPWbDnFC48DTaXah7yQyMStg1ntLeTA0faC5xZfY6YHicMQg2PrpBZKj5sMw2joiXsLADHGmpSbQ3d8vG5Wo9M=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBAPR04MB7207.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(19092799006)(921020)(6133799003)(56012099006)(11063799006)(5023799004)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Qq0nwttSPW1teRb1+6r1tJhyI42nVyOcI/FWuNo8LFa++Tr0i6EVK4LOBCPV?=
 =?us-ascii?Q?3pxgERWnYCaDndQvH+SismdKZ/NVV+b20w0hlauf1FK5+bh0aFmpE1SRDnbQ?=
 =?us-ascii?Q?7TS3FEfoISV6/2XdZPO8yJGl58Mwp29v4qlZH1y2tK3Xxb8lZvcFHp1JS86R?=
 =?us-ascii?Q?IjCDI6lWMLLL1mLQT+lbSYB3XBzNbwQsN6nf6KSc7hHwWaRy2+u0qnimEbaW?=
 =?us-ascii?Q?wWOFrmc+g+hfZXxwwiTpSUxqv63w1Q50YsWToM1OkcZWoTlHwaFOT0OZ375C?=
 =?us-ascii?Q?PqImQtosdYOu41xh7p/CRniVzPXGgJS9LwNo86fbB8DnYQU5+cpTQ6QOo01z?=
 =?us-ascii?Q?eszsmLB5fAgQFzZ7VATlKtri1kimfZ5O8UzYy7cVjc/W6sFMUxl8NW44wuaR?=
 =?us-ascii?Q?CYlBQRAGg19UZIy0Ts6kmIPgOxJHzUzDgOXQZSM6fXrWcbSYkzCrfGaM7uQ9?=
 =?us-ascii?Q?m2FfnBJPKTAu3tcQQID99p514UuMhkHQhQP43KO6ym0j28jMpc6jsFNmN3+x?=
 =?us-ascii?Q?jRtS/NPQLi9/YslF3wAsrlb4daJsdehvou44voeBcexztYDaXP50MHtKWzlg?=
 =?us-ascii?Q?H1vsjoQABC4PkPR9q/W/T86ZkfNx8iU7sfygV/fhNKZdf/OP6sCxDHm13Ptp?=
 =?us-ascii?Q?ldnc7mb0mPqy1kmy2EYIiOThjucNV8j+jJH/DAOH/5FP6XE2L1/FrzmICbpa?=
 =?us-ascii?Q?J3hk9H2KOpiI/W8KLCuUx5cot+OPC02/MfMCVg+hdmwG28ijotFUFxkUOFJI?=
 =?us-ascii?Q?SG/Tekk6gPmpesaUeOPewj7TVKbITG3MtAovJlKlCWWFL4x0tWZzvLBu+kiY?=
 =?us-ascii?Q?OMcPBBWFS+Ebvm93Q+on3FH1DpzuwBIsee9+YtFZ579rqm8j/y38baY9pJzD?=
 =?us-ascii?Q?7OMHtdE+QEjA1/P6r3LvUQd2+WP3ltUfKQuHYCKhUv8Wg6Fe3b43Mf+gW05h?=
 =?us-ascii?Q?++L2VspelHl9xDkj+yjOO6Ky1zKc3gvhlpJWJiKMXbp3aksJIrC4be/YiLcI?=
 =?us-ascii?Q?FR4saSGraDrVOhwiR/pq947IpPpjmyadTG4Xrq/ZKKCOLvsknxYglzEVCO7C?=
 =?us-ascii?Q?AtBE17a1ZMYMdwjULvwl6cBZsXD+SbBHHj96Egj47yxzwyDhjsQok7bSDtqi?=
 =?us-ascii?Q?uGvbOPEVt2qtrD4hIYM0G0FZW/ZEEXhYr9DsoyP7l261oygnPV42yWsMR9NL?=
 =?us-ascii?Q?f/gmbx+xFfoA/hcZ+hGPDNf/c27VRkixwM0MpGk7K+pWLzdFfiUC024H3H4T?=
 =?us-ascii?Q?pYo17OJudUXRHO8/I8WuKuoK2tpRMNf31VHEhvu9IzKt3He3Z2vvBbFeN6FC?=
 =?us-ascii?Q?V9MQDzMK+FkJM70QqBjnt9vsIMTFQaybuo76Xuk8QMnrHdF84sU16cCg7vgG?=
 =?us-ascii?Q?2nQjeYWXXSwKchn+SsKgXhhHKAJmlf96L7Pc/lkz8IClMg6FtDZ+h+4TBNJt?=
 =?us-ascii?Q?5PNyI0OwZiW0lld0fE/IjKWY3r5nilyOrNzG8pJmdR3VM02GVmZn3fLAp1dA?=
 =?us-ascii?Q?izCSH2F5+HhhIM3xRn8im2Wf0rGjJBXJ6O4EDDrQgHk/LZlxZUfsPAErW0uN?=
 =?us-ascii?Q?XnE5dMh1GTQ67yATQkvVqPEKExrmr8QX7MbDNFDzH6NT24XVGHV0TZfKy9mB?=
 =?us-ascii?Q?FwWHPSAcCkFqWfEHtKWy+szOoEcuRfoKxSuFwNrautQXKaZ2/27Z34q0U3/e?=
 =?us-ascii?Q?I45h3kBrSSheeJ8yHhAP/7UvOlubmaRb+hOSN2SzboAebW0pAkQ5zXP7SwYd?=
 =?us-ascii?Q?5oYkgcEiEuuu0VM1xFk+irf4s6EE/L5OzOgGkb6Qb+xqQCnBHHBv?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6495e1be-2fab-4a84-9d59-08dec6d53b1e
X-MS-Exchange-CrossTenant-AuthSource: DBAPR04MB7207.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 09:47:05.7007
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2GhCYjWFW/v1Q0mzfpOhFsCeh9sum4RaAy3B17vpfgGlI99I75kXvUqrVvOFAUkOJiYPoiNizV2nOX/rq8Hhn6iwZb9AMXwfrJol5KkIPyMbS/jR7vbVyLSRbBbVvrOR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB12129
X-Rspamd-Action: no action
X-Spamd-Result: default: False [3.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-297579-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:claudiu.manoil@nxp.com,m:vladimir.oltean@nxp.com,m:xiaoning.wang@nxp.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux@armlinux.org.uk,m:wei.fang@nxp.com,m:imx@lists.linux.dev,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[wei.fang@oss.nxp.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@oss.nxp.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,nxp.com:email,NXP1.onmicrosoft.com:dkim,oss.nxp.com:mid,oss.nxp.com:from_mime,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E3EB6668142

From: Wei Fang <wei.fang@nxp.com>

On ENETC v4, a PCIe VF Function Level Reset (FLR) resets
PSIPMMR[SIn_MAC_UP] and PSIPMMR[SIn_MAC_MP] bits, which control the
unicast and multicast promiscuous mode for the corresponding SI. The
reset (default) value of these bits enables promiscuous mode, meaning
that after a VF FLR, the SI is left in promiscuous mode regardless of
the configuration set by the PF driver prior to the reset.

This is a potential security vulnerability: a malicious VM could
deliberately trigger a VF FLR to force promiscuous mode on its SI,
allowing it to capture network traffic not destined for that VF.

To mitigate this, make the following changes:

- Add ENETC_VF_FLAG_UC_PROMISC and ENETC_VF_FLAG_MC_PROMISC to
  enetc_vf_flags to track the PF-managed promiscuous mode state for each
  VF.

- Update enetc_msg_set_vf_mac_promisc_mode() to keep these flags in sync
  whenever a VF requests a promiscuous mode change via messaging.

- Update enetc_pf_set_vf_trust() to clear both promisc flags when a VF
  is untrusted, so that a subsequent FLR cannot restore promiscuous mode
  that the PF has already revoked.

- Add a vf_flr_handler callback to enetc_pf_ops. The ENETC v4
  implementation re-applies the tracked UC/MC promiscuous mode settings
  to the hardware after each FLR, ensuring the hardware state matches
  the PF-managed policy rather than the insecure reset default.

- Add enetc_vf_flr_handler() in enetc_msg.c to detect FLR events via the
  PSIIDR register and dispatch to the vf_flr_handler callback. Invoke it
  at the start of enetc_msg_task() before processing VF messages.

- Enable FLR interrupts in PSIIER only when a vf_flr_handler callback is
  registered, keeping ENETC v1 behavior unchanged.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 .../net/ethernet/freescale/enetc/enetc4_pf.c  | 21 +++++++
 .../net/ethernet/freescale/enetc/enetc_hw.h   | 12 ++++
 .../net/ethernet/freescale/enetc/enetc_msg.c  | 59 ++++++++++++++++++-
 .../net/ethernet/freescale/enetc/enetc_pf.h   |  3 +
 .../freescale/enetc/enetc_pf_common.c         |  4 +-
 5 files changed, 95 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
index 39257d364d4e..6f7b4f4927e3 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
@@ -278,11 +278,32 @@ static void enetc4_pf_set_mac_filter(struct enetc_pf *pf, int type)
 		enetc4_pf_set_mac_hash_filter(pf, ENETC_MAC_FILTER_TYPE_MC);
 }
 
+static void enetc4_pf_vf_flr_handler(struct enetc_pf *pf, int vf_id)
+{
+	struct enetc_hw *hw = &pf->si->hw;
+	struct enetc_vf_state *vf_state;
+	bool uc_promisc, mc_promisc;
+
+	vf_state = &pf->vf_state[vf_id];
+	mutex_lock(&vf_state->lock);
+
+	uc_promisc = !!(vf_state->flags & ENETC_VF_FLAG_UC_PROMISC);
+	mc_promisc = !!(vf_state->flags & ENETC_VF_FLAG_MC_PROMISC);
+
+	mutex_lock(&pf->msg_lock);
+	enetc4_pf_set_si_mac_promisc(hw, vf_id + 1, UC, uc_promisc);
+	enetc4_pf_set_si_mac_promisc(hw, vf_id + 1, MC, mc_promisc);
+	mutex_unlock(&pf->msg_lock);
+
+	mutex_unlock(&vf_state->lock);
+}
+
 static const struct enetc_pf_ops enetc4_pf_ops = {
 	.set_si_primary_mac = enetc4_pf_set_si_primary_mac,
 	.get_si_primary_mac = enetc4_pf_get_si_primary_mac,
 	.set_si_mac_promisc = enetc4_pf_set_si_mac_promisc,
 	.set_si_mac_hash_filter = enetc4_pf_set_si_mac_hash_filter,
+	.vf_flr_handler = enetc4_pf_vf_flr_handler,
 };
 
 static int enetc4_pf_struct_init(struct enetc_si *si)
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_hw.h b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
index 7b66c5be1ccf..47de179e17c8 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_hw.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
@@ -110,6 +110,18 @@ static inline u32 enetc_vsi_set_msize(u32 size)
 
 #define ENETC_PSIIER	0xa00
 #define ENETC_PSIIDR	0xa08
+
+/* VF FLR interrupt mask, n is the active number of VFs.
+ * It is available for ENETC_PSIIER and ENETC_PSIIDR registers.
+ */
+#define ENETC_VFFLR_MASK(n)	\
+	({ typeof(n) _n = (n); (_n) ? GENMASK(16 + (_n), 17) : 0; })
+
+/* VF FLR interrupt bit, n is VF index. It is available
+ * for ENETC_PSIIER and ENETC_PSIIDR registers.
+ */
+#define ENETC_VFFLR_BIT(n)	BIT(17 + (n))
+
 #define ENETC_SITXIDR	0xa18
 #define ENETC_SIRXIDR	0xa28
 #define ENETC_SIMSIVR	0xa30
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_msg.c b/drivers/net/ethernet/freescale/enetc/enetc_msg.c
index fddc69cb4b90..e6ade6eeac32 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_msg.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_msg.c
@@ -30,6 +30,9 @@ static void enetc_enable_psiier_interrupts(struct enetc_pf *pf)
 	u32 psiier = ENETC_PSIMR_MASK(pf->num_vfs);
 	struct enetc_hw *hw = &pf->si->hw;
 
+	if (pf->ops->vf_flr_handler)
+		psiier |= ENETC_VFFLR_MASK(pf->num_vfs);
+
 	enetc_wr(hw, ENETC_PSIIER, psiier);
 }
 
@@ -220,11 +223,23 @@ static u16 enetc_msg_set_vf_mac_promisc_mode(struct enetc_pf *pf, int vf_id,
 
 	mutex_lock(&pf->msg_lock);
 
-	if (type & ENETC_MAC_FILTER_TYPE_UC)
+	if (type & ENETC_MAC_FILTER_TYPE_UC) {
+		if (promisc)
+			vf_state->flags |= ENETC_VF_FLAG_UC_PROMISC;
+		else
+			vf_state->flags &= ~ENETC_VF_FLAG_UC_PROMISC;
+
 		pf->ops->set_si_mac_promisc(hw, si_id, UC, promisc);
+	}
+
+	if (type & ENETC_MAC_FILTER_TYPE_MC) {
+		if (promisc)
+			vf_state->flags |= ENETC_VF_FLAG_MC_PROMISC;
+		else
+			vf_state->flags &= ~ENETC_VF_FLAG_MC_PROMISC;
 
-	if (type & ENETC_MAC_FILTER_TYPE_MC)
 		pf->ops->set_si_mac_promisc(hw, si_id, MC, promisc);
+	}
 
 	mutex_unlock(&pf->msg_lock);
 
@@ -589,6 +604,29 @@ static void enetc_msg_handle_rxmsg(struct enetc_pf *pf, int vf_id,
 	kfree(msg);
 }
 
+static void enetc_vf_flr_handler(struct enetc_pf *pf)
+{
+	u32 flr_mask = ENETC_VFFLR_MASK(pf->num_vfs);
+	struct enetc_hw *hw = &pf->si->hw;
+	u32 flr_status;
+
+	if (!pf->ops->vf_flr_handler)
+		return;
+
+	flr_status = enetc_rd(hw, ENETC_PSIIDR) & flr_mask;
+	if (!flr_status)
+		return;
+
+	for (int i = 0; i < pf->num_vfs; i++) {
+		if (!(ENETC_VFFLR_BIT(i) & flr_status))
+			continue;
+
+		/* Clear FLR interrupt status, W1C */
+		enetc_wr(hw, ENETC_PSIIDR, ENETC_VFFLR_BIT(i));
+		pf->ops->vf_flr_handler(pf, i);
+	}
+}
+
 static void enetc_msg_task(struct work_struct *work)
 {
 	struct enetc_si *si = container_of(work, struct enetc_si, msg_task);
@@ -597,6 +635,8 @@ static void enetc_msg_task(struct work_struct *work)
 	u32 mr_status, mr_mask;
 	int i;
 
+	enetc_vf_flr_handler(pf);
+
 	mr_mask = ENETC_PSIMR_MASK(pf->num_vfs);
 	mr_status = (enetc_rd(hw, ENETC_PSIMSGRR) & mr_mask) |
 		    (enetc_rd(hw, ENETC_PSIIDR) & mr_mask);
@@ -725,8 +765,21 @@ static void enetc_msg_psi_free(struct enetc_pf *pf)
 	/* PSIIER interrupts may be re-enabled by workqueue */
 	enetc_disable_psiier_interrupts(pf);
 
-	for (i = 0; i < pf->num_vfs; i++)
+	for (i = 0; i < pf->num_vfs; i++) {
+		struct enetc_vf_state *vf_state = &pf->vf_state[i];
+
 		enetc_msg_free_mbx(si, i);
+
+		/* VF may set these flags by mailbox messages, so need to
+		 * clear these flags when enetc_msg_psi_free() is called.
+		 * Flags set by PF are cleared, because these flags are
+		 * unrelated to whether SR-IOV is enabled or disabled.
+		 */
+		mutex_lock(&vf_state->lock);
+		vf_state->flags &= ~(ENETC_VF_FLAG_UC_PROMISC |
+				     ENETC_VF_FLAG_MC_PROMISC);
+		mutex_unlock(&vf_state->lock);
+	}
 }
 
 int enetc_sriov_configure(struct pci_dev *pdev, int num_vfs)
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.h b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
index 57591bd5afab..378ca4464538 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
@@ -10,6 +10,8 @@
 enum enetc_vf_flags {
 	ENETC_VF_FLAG_PF_SET_MAC	= BIT(0),
 	ENETC_VF_FLAG_TRUSTED		= BIT(1),
+	ENETC_VF_FLAG_UC_PROMISC	= BIT(2),
+	ENETC_VF_FLAG_MC_PROMISC	= BIT(3),
 };
 
 struct enetc_vf_state {
@@ -38,6 +40,7 @@ struct enetc_pf_ops {
 				   enum enetc_mac_addr_type type, bool en);
 	void (*set_si_mac_hash_filter)(struct enetc_hw *hw, int si,
 				       enum enetc_mac_addr_type type, u64 hash);
+	void (*vf_flr_handler)(struct enetc_pf *pf, int vf_id);
 };
 
 struct enetc_pf {
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
index f0ae69dcc59a..52e7d2d2149b 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
@@ -480,7 +480,9 @@ int enetc_pf_set_vf_trust(struct net_device *ndev, int vf, bool setting)
 	if (setting) {
 		vf_state->flags |= ENETC_VF_FLAG_TRUSTED;
 	} else {
-		vf_state->flags &= ~ENETC_VF_FLAG_TRUSTED;
+		vf_state->flags &= ~(ENETC_VF_FLAG_TRUSTED |
+				     ENETC_VF_FLAG_UC_PROMISC |
+				     ENETC_VF_FLAG_MC_PROMISC);
 
 		/* Clear unicast hash filter and disable MAC promiscuous modes
 		 * if the VF is untrusted.
-- 
2.34.1


