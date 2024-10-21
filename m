Return-Path: <netdev+bounces-137420-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D2B9A62B5
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 12:25:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 888001F2256C
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 10:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 890B91E503D;
	Mon, 21 Oct 2024 10:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b="TuKUbFOm"
X-Original-To: netdev@vger.kernel.org
Received: from dispatch1-eu1.ppe-hosted.com (dispatch1-eu1.ppe-hosted.com [185.132.181.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E9F1E3776
	for <netdev@vger.kernel.org>; Mon, 21 Oct 2024 10:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.181.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729506285; cv=fail; b=pm5CrXTsxeXc5CTFbPzI1IuVS9xhrg7QEWaMw2iLNNFWC4pA3Tmcr0pvGKqQyqA2ydLMkwlrxebS9IS6ViH7EI741dhJCtIvjwihRTn8WtPmxbFKGy7Ad+6i89FK0AZ9geO7q9cjVpl98V0g9bn3szCKA9zu738y43dcQQdECdo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729506285; c=relaxed/simple;
	bh=0iT3+N5VaA0ZAaGrdpKMFu1FPkSiEZCcUdbu0jjJPBc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mIpY7ymVhn0tQMkDtoSh19iIhrY9xLAuLPHr7BtIAXqx8v3wAXM9hljQrVtEBbYEKF901Efu9s7v6TDQsszIzZ4TjJOV1dWLOpTb2PVrEhTsnGcsQ/FdQ9+ZvVmtywC7V7+gB+EoruoTht1Su3QPQupM9VklQ2m7JyzGBjx4n0w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com; spf=pass smtp.mailfrom=drivenets.com; dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b=TuKUbFOm; arc=fail smtp.client-ip=185.132.181.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drivenets.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05lp2111.outbound.protection.outlook.com [104.47.18.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1-eu1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 24FF374005C;
	Mon, 21 Oct 2024 10:24:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u3nhexkwuvqAjm6TAh9tQU4b5zPyi0V/zsW6HJvfBFurnT+hYp+ScPZVdxfZ8djuKlwNbaNODQ+7Bdr92FnTMbLyY+qTUViWXnqEpprCMb+rXJLevEkvPh7VK3u+7zsPH6H+S+necdwFMc/kq+IWr+TG3Xi/GYvObSdLBtcn/DLKPwGr9Gt9Q5ZKJFSswBPgw7YAaekrVRnU8tM4iX7wLbMb40L79Ez/tkg5YbYGEgr407WF5zHticUjnUpJwq55JXnMiM5X5NMzQKObY2+YqATulsDpjxd7+VK3gRsPQC7diqxxUPVCCubIN4y8HXSXyGWG6EnWXjUl++KlQDe3pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w0h10CUPRqmSVe4x9KonpneOcIGQy36PK4ZRYFfr49E=;
 b=afzVApa8rEwsbP7odgRzx3MrZiaTpI/b8f1EnVb1EQaXR6mMF9SCXw0RSMdVKX/V5Ox0KzXIB+TuA3V3U6qKspXR/xPJJVQ14gVczeIVLpLbIHs2pnYtFIBNzYctvZIEpUCXDKTt5s+Z2tSxZMNRI9ACqZMV8jSMxJa/IvcmQ/UrQ1nZp8o2vmy3BabQ+V9/Axw6UuVF3VgI2vjYV63gnTlcZfDz+6dmAtDoEhtKbUegVt8xUe9x+hLuhncwyQYTbbUrNJmq0WCq3PiSdr2cFiY2dh/gyjeFQ3KuZHSiOCmpe93XDY3Vcg1JjZYP51IN7+3kb33nmyRRvGhUQDxm3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=drivenets.com; dmarc=pass action=none
 header.from=drivenets.com; dkim=pass header.d=drivenets.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=drivenets.onmicrosoft.com; s=selector2-drivenets-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w0h10CUPRqmSVe4x9KonpneOcIGQy36PK4ZRYFfr49E=;
 b=TuKUbFOmD17pZDx2L2ZNMzkZ+PTN4Z6HRSNOpnisjBjYYCTSS7IJ7Td4bCa+uEErFawm4xWKZv/5XGlrP20DyUMPRCWpbHAJLWbAKnBo1mCHFsIiBLWeJWfp8yMX9FKJcVNFTaU6gqfJI4yFmGJPLNMlKXaN1fXKw61B3rxoetg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=drivenets.com;
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com (2603:10a6:10:11c::7)
 by DU0PR08MB9051.eurprd08.prod.outlook.com (2603:10a6:10:470::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 10:24:34 +0000
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com
 ([fe80::29dd:6773:4977:dc4e]) by DB8PR08MB5388.eurprd08.prod.outlook.com
 ([fe80::29dd:6773:4977:dc4e%5]) with mapi id 15.20.8069.027; Mon, 21 Oct 2024
 10:24:34 +0000
From: Gilad Naaman <gnaaman@drivenets.com>
To: netdev <netdev@vger.kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Gilad Naaman <gnaaman@drivenets.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>
Subject: [PATCH net-next v6 3/6] neighbour: Convert seq_file functions to use hlist
Date: Mon, 21 Oct 2024 10:20:55 +0000
Message-ID: <20241021102102.2560279-4-gnaaman@drivenets.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241021102102.2560279-1-gnaaman@drivenets.com>
References: <20241021102102.2560279-1-gnaaman@drivenets.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P302CA0010.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c2::18) To DB8PR08MB5388.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR08MB5388:EE_|DU0PR08MB9051:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b5af68c-1bfe-432b-54db-08dcf1ba8ea0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Nz0dfXXihYFG1uU7Eg2+V92HAzibUFUVLInF/0VyBQczCVdwr4M4VSojAjgG?=
 =?us-ascii?Q?N7e0cHv7EPaBZ4QsNIgJ5efnDdssRQg46JlafRp4zprT1WO5Lz5F8egtMPhA?=
 =?us-ascii?Q?QDpYW9WKiWsVGtVh4iAQljnu/qNPsvQl6X3SOhia3qaU8rgBqqdDlHEn2JBB?=
 =?us-ascii?Q?OQGn20zDnrKj7f4Rm8P7mE/eNrfTxOy2lEIGyTmbtZ/kQvUrJJnhHBdkH6ks?=
 =?us-ascii?Q?LZqHRLXDxxxiVrkhAuqsYszJOBvDgOFoTvNwCUk9pOsoT1nUl1Wt05tuqtbT?=
 =?us-ascii?Q?w+mB07OsdWy1Um5cMm3NDltfE/OkWGGMHkpG6rWITEznhyr+W9TOvhbVM2HI?=
 =?us-ascii?Q?xoDWp+6KTjCB5ZrRdzu085RO5I5i925zC6fPZ9OpkMAE5dMU1rSSqisELmqB?=
 =?us-ascii?Q?pI+LoDln8onWLokoPphGAOj7vnTxDwCeDlOnnAZ+NcHRCYt5JevBafRPY9JR?=
 =?us-ascii?Q?Mw4p2Q0jlyLCZPpMQnPtUnXTD8LXs6VyQcTw7Eli92XEvEehu6qTDGQeg3p3?=
 =?us-ascii?Q?wwst/+nHRJqK602PAFP8lyFPt7etN7+jTJ1eWAkrSstICfdQvVa17hYoh4ub?=
 =?us-ascii?Q?p/SazUIFjnwfF9nBo6GsfyXjhgNaAnC+NEnU6w1V2dgpPyt3EVTJPTkdeSPi?=
 =?us-ascii?Q?misdC6f/kl8Qex7OcIeBE4XCwkTwevIvTN8NFiX7cXr4h0ASRlr/KNydDkjB?=
 =?us-ascii?Q?ij1tbO7pEbX9qhAJ45JcwSAGb/HUUlkXK4Za7Lvq+9moZRYLpTGTxRWFtIO4?=
 =?us-ascii?Q?DLOxIB8U8aS8SOTVfOqqCXZZNwRHgvTSMwp5PduhiH8RXS5HVQNiOmNh2vks?=
 =?us-ascii?Q?64T+def2almHYBxGfTe0P14Z0w8T54fK6YoqNkKUk8umNcVBpMIpApIvgxUx?=
 =?us-ascii?Q?ud4FWXTxkrQ63sjVMAUzXUJDSlxXtMqOegg6O9kCzsZHMJiq6mtufaxq1lt6?=
 =?us-ascii?Q?L4uIHxxGwZdetORRcG1Li7efoVHwDwWoe4DCqzZtZAqTb6vld+jQXcnh+KF2?=
 =?us-ascii?Q?FIkNOqBR0sdHWyuNf8BBibM83rPV6OpNCM7du/iqBjuhTf+4rCkBUZUPCCbp?=
 =?us-ascii?Q?HE4Yw1pplHVc+ahiLNCUs3w91Oc4a+wU4T/wrJHsIHZ7ao6lL3q1LpfxVw9E?=
 =?us-ascii?Q?MIg6hNom+59mgN7Dv7F+Bp4VdTrBhX5CZ6PU8bo98jwIRyAlu8mXzutGVG40?=
 =?us-ascii?Q?UL3x2GUZ9TxgX9P5o2+I2mUzWh+9F0dJRv/9vGxqI8TT2iEm4tirAu2Jn+d0?=
 =?us-ascii?Q?P9HgLDF9jPzVJhsLETHnGEkXJ9NZTPrySyl49yEHHc3WRSeWrrWgEU3GL6Dr?=
 =?us-ascii?Q?BtE1/QL543qfimgmFFuIIcY+y4/pOuVTnWBedwLqE0jWDmbkR+wjI2t83/th?=
 =?us-ascii?Q?u0p0XYU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR08MB5388.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Xfond1wY7O5Skd9Hf8XoBywFooXIaC9lymANQQTsykYpqKP8WuCPLW0j5ESV?=
 =?us-ascii?Q?yrXfCOMXChf8OaTRNrv4okkDt2pIrTa2nXhbGSjigjAtpNWypTdhj3CqB4rG?=
 =?us-ascii?Q?hOWITJb/bdjmATt77mXT9dKR/A3ytXHQ62o1wqqSwTG9igmxYYwfAbMdVufQ?=
 =?us-ascii?Q?kuz53YSgtQv7cBFxwfewd3WCWBYuCPD0h/4pNUJLq5bVadxwWZD1/7XPai61?=
 =?us-ascii?Q?Ip/d/hE87eb2Pzd059ZWvo/uuimqjJbO1nNutJXaJpLoxLprpBsA6hVqXOCf?=
 =?us-ascii?Q?nG9zRdIyrvJUnyN4Idb5+uiMJsQ92ftuRR/ucIo3DJTRuPelY+mvKuJ8FQYN?=
 =?us-ascii?Q?cgPIJbMD2EQ27Oh235IhWgILGmu1lwnDOuxtCOSJb92/V6EIVyHqYy+jiMNz?=
 =?us-ascii?Q?2VL09b+GwNsLuyXzLAosvjW0Nd9GWVSm7aGuiFww3PL7eOHOy4uGkDhCHDDb?=
 =?us-ascii?Q?a2Hu6PebHbYehHm++JnQLxYuBnORcku7IKmtjYYJL2prFMZSqEGTZTAVfqvM?=
 =?us-ascii?Q?Gtk+GLPcDQKnEnZHB8BKGCh09YOiRBE28TEpCux6uhaQ/WYFBYBaJOFFQGOx?=
 =?us-ascii?Q?JdRfsrlyhzm5WNfJIlxLP5iR9iCTMbykbecUCUH4+B5EYeXBZV37sWutAZwg?=
 =?us-ascii?Q?7CCCfc7v+n8dqVPObfhTg/8Pb2dH4R1Heb/xEwcAe+biG47bNO7TnuPIVx9o?=
 =?us-ascii?Q?Ok/4hNDaD6X0Rw07qetMBkKpqhWKxy73pCWxLhpdy8MJvfiP4q5D/C+4+iRX?=
 =?us-ascii?Q?MSb01FCDc1sFF59DxZHboOJcOCC05HrzKDGAl3su3dqR9nn3UsNSwUuWS4GL?=
 =?us-ascii?Q?szuGivrE/42rM3AmpvJLXMqJHBbkRfguDB3pxljjXs3a4zWXYilp/6H6V0J+?=
 =?us-ascii?Q?K0h/Qr86Xyq82KLlAT9Hn2AhhQE3r2jHibOzpdzLlOPumgCKgfepBYgmInQs?=
 =?us-ascii?Q?kmK7pKMUfknRcUGYuLrK8ObAOatI1rQ4V5CbOTMYs681G3PXZWrvZNmrsfEf?=
 =?us-ascii?Q?0rM2bkPOpinUvoRFuxaWzp3gT7/7pU/RpeJ7cqpDukK3+MzqCkzZgJs+w5ri?=
 =?us-ascii?Q?X/X9tvmWAsnTPOrL6cyeiUFGdM7//ZIGOA0g85CtZ1k7wiMy+BMRlEXVARvi?=
 =?us-ascii?Q?yxn7B1hvsJNToyQ7pfSPZmTbiu1DGSoMQqtPElgFuvL7q2SWTfZp5M5u3YEi?=
 =?us-ascii?Q?6x2aOyAKh54Vyw2oebLGwQ8CC8IpxUvi2ey27Cju9GF316dCO94HIqxc7lCV?=
 =?us-ascii?Q?tJGhY861GEvSlhFTRxJHTOzAyntfdibvuaWW0LGnYFxLU2AKs+FRJyAwytcX?=
 =?us-ascii?Q?YRvONsP4TPTLiMh5Ldn8pAvoeDu4joK/RFQULQ7ljIgw5U99KaOUAn7Z6T2L?=
 =?us-ascii?Q?EasnqbRdligQfTZGw7KL3pVQGVgqKEwCzvz7z9iEzK8bj80gMK/B4LH85Ib+?=
 =?us-ascii?Q?FsQlbnh6rtW2fBDHySOmZEabF/0xYsThuJqAIaDzyHf765nRbRDKMSUJBB2z?=
 =?us-ascii?Q?We7IvoF2KxFpw7F0xlaiUf/K8WmFPISaGSwXE8sYMMdlAoJ5hNr5xPoUUBG1?=
 =?us-ascii?Q?Jz4+8DrxAenZBRO05/rHK/98d4lEXKWuZHtwmIc5ssxmn24kd8Cyc/wAZJbB?=
 =?us-ascii?Q?3g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	BrG8p3bEGfWN53Vwipv8hqW+IyNhlHs5WlFM6KfNt/ao3WZsDTETE+zl4Yf8oa2ymmYj7OynHzQPvOOJY1QbImRazhfrn3UyAjRy/wNRXGeOzFRrPag+k9VJ1b62VGYzw62ZmZlPjS5ycPXJFVx4bZTvVGXeDZlU4kp7UTWIb4h3IfB8O2wCatN4DbeG6UcaHw4IOrPLY+ZR+UiUqCUhyUyaIvC8UXvG1hfXdBTm9uAy7/BGI/J1S0QY6yK6uHLrtqdfz1EmTrVKeihatvdRCuc5mY0eby2hJSmwMiuAs2xDebZMi4Ko1/CaZtcm7bMt/hoZ7PBFt3fC9QBX4knF4Gw9a8d/14Z0GX9Y0oi/fCpGDsSX8EbHSFc3frfA1Q7haoKeZqIguQ+weqAKeXtgRjBzdUxOFsugg5ll6mCQasa2uwOiYr1NdH+CSSmgLSr2vcXg6CdnAj+t61Jz84zVGNRa20XwAWQ9WZOf5DwlRpVsHkzHR6Py5NlYGVvWMCXY7cLhQpJCH8DXJV+ie0T9jkp2wQaYYJ8WG9dw3RaIfgZCuWQ8GHsAbwfHuw37D7GzEPKbz2nAfAfYhMQrg6SW4wtBEWndDPpv2HtNccMYS2BgN4PJuRFPsHbgwUCjJqXj
X-OriginatorOrg: drivenets.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b5af68c-1bfe-432b-54db-08dcf1ba8ea0
X-MS-Exchange-CrossTenant-AuthSource: DB8PR08MB5388.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 10:24:34.0067
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 662f82da-cf45-4bdf-b295-33b083f5d229
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D+7Hujx/VqYBWCrXO9RE17fTEekwBj8bmnaOKsxp+JbKYW6wwlCqVQ7FZKXuj3Y5QZd7dwAQRR3bmGobAArDgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9051
X-MDID: 1729506275-g4RnBup4Cl9v
X-MDID-O:
 eu1;fra;1729506275;g4RnBup4Cl9v;<gnaaman@drivenets.com>;495c1e7a27a6c3e35a5fabc922783896
X-PPE-TRUSTED: V=1;DIR=OUT;

Convert seq_file-related neighbour functionality to use neighbour::hash
and the related for_each macro.

Signed-off-by: Gilad Naaman <gnaaman@drivenets.com>
---
 net/core/neighbour.c | 104 ++++++++++++++++++++-----------------------
 1 file changed, 48 insertions(+), 56 deletions(-)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 45c8df801dfb..e70693643d04 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -3226,43 +3226,53 @@ EXPORT_SYMBOL(neigh_xmit);
 
 #ifdef CONFIG_PROC_FS
 
-static struct neighbour *neigh_get_first(struct seq_file *seq)
+static struct neighbour *neigh_get_valid(struct seq_file *seq,
+					 struct neighbour *n,
+					 loff_t *pos)
 {
 	struct neigh_seq_state *state = seq->private;
 	struct net *net = seq_file_net(seq);
+
+	if (!net_eq(dev_net(n->dev), net))
+		return NULL;
+
+	if (state->neigh_sub_iter) {
+		loff_t fakep = 0;
+		void *v;
+
+		v = state->neigh_sub_iter(state, n, pos ? pos : &fakep);
+		if (!v)
+			return NULL;
+		if (pos)
+			return v;
+	}
+
+	if (!(state->flags & NEIGH_SEQ_SKIP_NOARP))
+		return n;
+
+	if (READ_ONCE(n->nud_state) & ~NUD_NOARP)
+		return n;
+
+	return NULL;
+}
+
+static struct neighbour *neigh_get_first(struct seq_file *seq)
+{
+	struct neigh_seq_state *state = seq->private;
 	struct neigh_hash_table *nht = state->nht;
-	struct neighbour *n = NULL;
-	int bucket;
+	struct neighbour *n, *tmp;
 
 	state->flags &= ~NEIGH_SEQ_IS_PNEIGH;
-	for (bucket = 0; bucket < (1 << nht->hash_shift); bucket++) {
-		n = rcu_dereference(nht->hash_buckets[bucket]);
-
-		while (n) {
-			if (!net_eq(dev_net(n->dev), net))
-				goto next;
-			if (state->neigh_sub_iter) {
-				loff_t fakep = 0;
-				void *v;
 
-				v = state->neigh_sub_iter(state, n, &fakep);
-				if (!v)
-					goto next;
-			}
-			if (!(state->flags & NEIGH_SEQ_SKIP_NOARP))
-				break;
-			if (READ_ONCE(n->nud_state) & ~NUD_NOARP)
-				break;
-next:
-			n = rcu_dereference(n->next);
+	while (++state->bucket < (1 << nht->hash_shift)) {
+		neigh_for_each_in_bucket(n, &nht->hash_heads[state->bucket]) {
+			tmp = neigh_get_valid(seq, n, NULL);
+			if (tmp)
+				return tmp;
 		}
-
-		if (n)
-			break;
 	}
-	state->bucket = bucket;
 
-	return n;
+	return NULL;
 }
 
 static struct neighbour *neigh_get_next(struct seq_file *seq,
@@ -3270,46 +3280,28 @@ static struct neighbour *neigh_get_next(struct seq_file *seq,
 					loff_t *pos)
 {
 	struct neigh_seq_state *state = seq->private;
-	struct net *net = seq_file_net(seq);
-	struct neigh_hash_table *nht = state->nht;
+	struct neighbour *tmp;
 
 	if (state->neigh_sub_iter) {
 		void *v = state->neigh_sub_iter(state, n, pos);
+
 		if (v)
 			return n;
 	}
-	n = rcu_dereference(n->next);
-
-	while (1) {
-		while (n) {
-			if (!net_eq(dev_net(n->dev), net))
-				goto next;
-			if (state->neigh_sub_iter) {
-				void *v = state->neigh_sub_iter(state, n, pos);
-				if (v)
-					return n;
-				goto next;
-			}
-			if (!(state->flags & NEIGH_SEQ_SKIP_NOARP))
-				break;
 
-			if (READ_ONCE(n->nud_state) & ~NUD_NOARP)
-				break;
-next:
-			n = rcu_dereference(n->next);
+	hlist_for_each_entry_continue(n, hash) {
+		tmp = neigh_get_valid(seq, n, pos);
+		if (tmp) {
+			n = tmp;
+			goto out;
 		}
-
-		if (n)
-			break;
-
-		if (++state->bucket >= (1 << nht->hash_shift))
-			break;
-
-		n = rcu_dereference(nht->hash_buckets[state->bucket]);
 	}
 
+	n = neigh_get_first(seq);
+out:
 	if (n && pos)
 		--(*pos);
+
 	return n;
 }
 
@@ -3412,7 +3404,7 @@ void *neigh_seq_start(struct seq_file *seq, loff_t *pos, struct neigh_table *tbl
 	struct neigh_seq_state *state = seq->private;
 
 	state->tbl = tbl;
-	state->bucket = 0;
+	state->bucket = -1;
 	state->flags = (neigh_seq_flags & ~NEIGH_SEQ_IS_PNEIGH);
 
 	rcu_read_lock();
-- 
2.46.0


