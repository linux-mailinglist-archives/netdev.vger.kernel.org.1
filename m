Return-Path: <netdev+bounces-141421-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 524E19BADA3
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 09:05:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 763691C2125B
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 08:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D2F1AB6F1;
	Mon,  4 Nov 2024 08:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b="oC7tIOIv"
X-Original-To: netdev@vger.kernel.org
Received: from dispatch1-eu1.ppe-hosted.com (dispatch1-eu1.ppe-hosted.com [185.183.29.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDFEB1AAE2E
	for <netdev@vger.kernel.org>; Mon,  4 Nov 2024 08:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.29.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730707513; cv=fail; b=O07ra0mrPLs9W683W0WFCHSUV0mFQhhaY4yn1BkCFwAwzlHKJyhhCBkscnX9pb52M4kBLDCAydz1jf9C/3SqgWejOU3qQRAahxe7KluoSYJqKTdN4fY9cNlEB9DX28ggcf1jpfNiAMPh6cE8q+jKSSQzb/bCnlfKlq9jsvK/Q/M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730707513; c=relaxed/simple;
	bh=3tGlXzP8AknKUxI6+OusgQ77cEMUNblclCtU+i0BzMo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Z0B2osjP9Mf/KNNoXG7ZRwON8kETqhrJgXEY8QY/OITqWIiGlFt2vAXJppJ10CR2XbPT1eRIrqyUpAVkLpQILMKLLLUa+KxPHkgF27G/BsrfFP9aabqg+gWJUQJrDpx0FHiRmIo879DRwW788fFXmjxPrIIA84TlZ0EkWavVhSE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com; spf=pass smtp.mailfrom=drivenets.com; dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b=oC7tIOIv; arc=fail smtp.client-ip=185.183.29.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drivenets.com
Received: from dispatch1-eu1.ppe-hosted.com (ip6-localhost [127.0.0.1])
	by dispatch1-eu1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 7B20F8106A
	for <netdev@vger.kernel.org>; Mon,  4 Nov 2024 08:05:10 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05lp2176.outbound.protection.outlook.com [104.47.17.176])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-eu1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 9F996480060;
	Mon,  4 Nov 2024 08:05:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BAsJXHGADd81V9PvhAwhrJAPSYQGk13aYl9ff2HDHo6+0Dc3k/V1RVHJigkJPowy1FABIPRJRmwrR6VDOIUhvW+aKsRjKMTFO3t9z+XEIUJDFc6zZ0+fvzpg9Htrhm9k95lUZR40c1RhU8x3DdQK6qXb8mi+Sn26JfJGv3zuImexZKtl4C4bHK+meZfjqiip9iZ4K4sgKOJxl8v3CGFb6R99M145FuQEo3GqtUOgOtKaiaJpsvw+nHseiw4fxn4kS8OXuYOrxgQiKxTbDhUfl6e8h8JVJsV17mtEgEvEbxpYoOXbj8KtLnWWLkqD4d9xC3YGBv36NlaivSJko2WpKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0R/gdCQ4BA0TNUb+9Z/fotfYm04ri4mNE+iAoddXxZ0=;
 b=YUm2z2MegOuPguMXXqrWSDXM0BRW/m/HhupkfTsaQ0HaQbfgyOrMqyEbmANXhJYzZu4Hl4gYzcE/xPRjs4CA6wkup8pLZS3Sfg+vb8WnHpccq+VkDOvnZKU7zeqCJNAahOJ5Kb+8hbOuq+H38nLct/LrdYWMx4Y57AxA3whcWGksOOaWOZzrPZvzUjkTBGmm4NaxaGG+O8b+gOm+Czz7aAXdOSQj+NXICzpPHHoxPEIjPsLETrw7d8gVhGNChh2pyXP4/rSTNeef8WFRpv0ou40dvHnLN6cOJS14iigICKWroB5p1zu1v5rcUOGDYMfrt8IbyY+j37zCrMUnrRgeCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=drivenets.com; dmarc=pass action=none
 header.from=drivenets.com; dkim=pass header.d=drivenets.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=drivenets.onmicrosoft.com; s=selector2-drivenets-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0R/gdCQ4BA0TNUb+9Z/fotfYm04ri4mNE+iAoddXxZ0=;
 b=oC7tIOIvY0okSBY2v6lXmIEhQRVtm9YFfgtM8SSvxBstIXpc3cY/YlV1iTUcmuclfHYUspKzhI1/sv6wwvNOmegffECBNzB4Ghmh42HdU/GtqA356YP7LuU02f95qJ0aKZ0/eHV2pc6q6Tt6vp5/E1OYTYLAaE33BbUtDY3UZjs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=drivenets.com;
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com (2603:10a6:10:11c::7)
 by AM8PR08MB5553.eurprd08.prod.outlook.com (2603:10a6:20b:1da::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Mon, 4 Nov
 2024 08:05:00 +0000
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com
 ([fe80::29dd:6773:4977:dc4e]) by DB8PR08MB5388.eurprd08.prod.outlook.com
 ([fe80::29dd:6773:4977:dc4e%6]) with mapi id 15.20.8114.028; Mon, 4 Nov 2024
 08:05:00 +0000
From: Gilad Naaman <gnaaman@drivenets.com>
To: netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Gilad Naaman <gnaaman@drivenets.com>
Subject: [PATCH net-next v8 5/6] neighbour: Remove bare neighbour::next pointer
Date: Mon,  4 Nov 2024 08:04:33 +0000
Message-ID: <20241104080437.103-6-gnaaman@drivenets.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241104080437.103-1-gnaaman@drivenets.com>
References: <20241104080437.103-1-gnaaman@drivenets.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0206.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a5::13) To DB8PR08MB5388.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR08MB5388:EE_|AM8PR08MB5553:EE_
X-MS-Office365-Filtering-Correlation-Id: 0da494a8-edf0-4764-c3ae-08dcfca7612e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QjiJZ8QJvOdgsIHSRJIe9+qn4sWkNTGoyBYtks9osO0S6Blvqqzi9Ik3ZZkn?=
 =?us-ascii?Q?JbHkp6vNUi76i+wisKgWWocnt/CT2rrgxVeIjknkqSoskZIJNaW2iEfn1xqW?=
 =?us-ascii?Q?SfDJQgHBJt6LC8XIMJr0aBFDdJMvFtC6OAskToUmZH3rk4iBs6fmWHlT0NVD?=
 =?us-ascii?Q?n6aDg9sG8aQvQAZcxUwg6LPjXQHQnrlvtIRMNJRBZv5jguds0KPQVLinx7T0?=
 =?us-ascii?Q?hjPpKkbUdLHTYkCVlY5gFimHL5W6Ck+ms5TV+KzLfc564dSWzque1hqBJ8Gj?=
 =?us-ascii?Q?CKAEcHVBBpoTdY5SHCyKmQNtJ5NTGjzkPspzEzRh6dgm4qbnzNg9ykNBxmfu?=
 =?us-ascii?Q?nljlY4yFKrLYrQmvzjAqN071EyXhHDFV9QHnGNZbbiKG2wtoBsQkKnBq0VZI?=
 =?us-ascii?Q?iJzkTXWuMVRFzqOK1RKvn552eqelCPl56l7VtX1QhkPbFLEyxMcZDNTj88Za?=
 =?us-ascii?Q?YGT7qqyjTSw/auemc4bDKDI6QHvkmKnyGQ1sQ3DHvyyZkmbR82gAbb0asSYB?=
 =?us-ascii?Q?MPXgUsYLQxZ2ZKGDsHMxKJBoCRFDFUISNJdpN+Cfgo8YN7SNJiwborEJrGWL?=
 =?us-ascii?Q?0fSYB/+uDe1c9Y0ZQ25/nqnrg3wFJSgth77pcvgP7kUF1ThT0sCrvhOhJLTG?=
 =?us-ascii?Q?s208YZxNobJLYV3PyuQsy2XQlXsTDs89T+QEg6FeL/XpR8kOg6pzGi4osy+5?=
 =?us-ascii?Q?jkMF4C1tUjAZl5ZM1yjVTe003l0Lu2CcmTjB5GOQQwQdVjXg54VleLeujibD?=
 =?us-ascii?Q?O/d1zwL6f2o5YM/ta8PSmsHQA7XhlbzGFOVCllRaPo50/lzQIN7lff4rQZ9g?=
 =?us-ascii?Q?KZuGX8f0Zi3G1HZrTTXBOWybrOJNRkssmpfaG4hlI3WLDF5jOYOF7zB0nvu2?=
 =?us-ascii?Q?7uMqBOWcri62mOE7xyOA61XyR0KI/U82WHbEZ7Dgx1KTyM+EAoYMqktsEaOl?=
 =?us-ascii?Q?pv4nRoq6eN0Xn+6kHMxVnyMh/CyyQkWgxd3qMsVhuOJUc3QV0AmtNF1Q5uk7?=
 =?us-ascii?Q?VGoGfgVIN0bp1so0lf6mlT8KC0seWbR/Uv4aF06ilGIUwLEUKUyN6RBIVrNH?=
 =?us-ascii?Q?5WOqlroVGJMtjZVw5NH6OH8i6Q/6CUAoWPc/V0maWtsNksNJBYBBcJCmpn1I?=
 =?us-ascii?Q?gIErf0zBGAHTJccTT5/iIvF6XxRjX+qU05C8KlFik3+r4peIfmHCuXxHV5OX?=
 =?us-ascii?Q?uA2+LAtRQPmrLQ/haan3LtVsOUNMu+y/LQtGnM9jgwAZ0J75sewSDa/NGgCz?=
 =?us-ascii?Q?yb213V0/14FfY+NGYiWWrIUtipqMdgtzo/K7hcfqxzRCsug9hrfoJSL+deiW?=
 =?us-ascii?Q?MVlwn0dEsFj/FjPgpMfPn/2jZp2wwOzu9q2YmHKhZuCG46GLymKptQt7SLoL?=
 =?us-ascii?Q?KaN0MOY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR08MB5388.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+f4pGIc81ZPw1GIrZEkY7q3HvZsIJfSkaxWwrvjPo4B43r9ZcIJQGhHtgi2C?=
 =?us-ascii?Q?nhPEzaEYaamepN+DyHzdPWIanF9aPB4VmggwNfhXrrKb1lTEZbfWsHncemG1?=
 =?us-ascii?Q?/TYViueU9KAIXrc9s/OUsp8J3OJIMmc649tIi4yqMjHKeTXXhcVYw3H42iE7?=
 =?us-ascii?Q?Rd8HJTLr9MWowLJ4H/i5P0HcK9VaVMtHi63xbsw/c/RUvErogeDJeCmN48+O?=
 =?us-ascii?Q?3CKF4oUHvlSRX+LN4mxEHUHoi+xY2XrBYQNK7QniI3DsC4jVCgYqYskyNLTZ?=
 =?us-ascii?Q?r7v85+/XGNAeJ26xfnAbghb+pWxjQdCjOSkiRwVSWbnphgVdhyDhKED5qwH9?=
 =?us-ascii?Q?dVlBaTmNdN+t61k45m8NJAPhDFJzhIAQ4hfG2095EWkQT6hLFSa6qMSXSn/q?=
 =?us-ascii?Q?lrx/OvwLHUP1gukiSP8GiBBpUnUDJdHArCksK1qUuL7DXLwZV2HqFT8OtRFo?=
 =?us-ascii?Q?wun4s5YjfgkGTk4GTvg9x+rbQs9maGYGuC+NPPNu89bRIiXhXooWGHa0d5bF?=
 =?us-ascii?Q?leDpZaq4b2zYXEEtu9CDOO7hqqZDTIu6fic81RrYvn3V8NzTPJoR6/TzwjBv?=
 =?us-ascii?Q?xyw3wmifDN753IGnHgwkwswCOdSXZklYA6iO6KJ5Wi/GO+cCGS/zMdYnm1ny?=
 =?us-ascii?Q?g3Y4OGIo80cjXAys7Q/LKXST2QTl6TrXLonOWnxR6BlHc2O0YRxOG+hy2ayB?=
 =?us-ascii?Q?04YmHpqvamS42imJK3GwfTj3n1G45m6xq0i+cC7d2g//zyyZP95KI4K+zdWB?=
 =?us-ascii?Q?eGgcmyior2LE0ghKmEqO3Mlea9IlOCwozaO8mibD2Vceu29bwW7Wubq5tKyA?=
 =?us-ascii?Q?ukK2bTMPOAx5mp3g6zEtfQtuPJtlgVERxk7KdQYQu2oVbTDieqPlehHFgZ50?=
 =?us-ascii?Q?zXgqILrgAQA/y1GRRTjYS40wNb5Yp/IRfCQN5iOYlEYPR6lXOipD387ffDUQ?=
 =?us-ascii?Q?XhRCWbNB3Azr4jIGYzqt1j5PjLMN3wOIM9pk4BDfTiG8rrFselAZkb9mDsY/?=
 =?us-ascii?Q?JAkdPDs+A9dm9g8FQfwoEMyl5xMEzxd4ND+hi2e5brM4rIA5fICxSCdpa9yh?=
 =?us-ascii?Q?g44mKX1KrwFjlGNu7f3wMFh5DOp/YXxZS+BJpLp2tCxwEmVFqswxLtyUKzoI?=
 =?us-ascii?Q?hofICTz5FMoVcPxl+TX+nrVYkC0JuJtn2JFM6KBia04sn1KBgjHq9g3kNEdB?=
 =?us-ascii?Q?zIh+h2E5nQpkNEYSCuDA8zJJ5mmyKPp6nlNg59ga1sVFU70vBAL1wCMJ4pcr?=
 =?us-ascii?Q?JV+pJ42XgXe6uKcnpEUlF4nhPCM9c+1cI8HysCW2H+mUzJDo+Fztr4MsiK9m?=
 =?us-ascii?Q?dw0MySBi8HMWz3WLlQlOeF69C2Scdiv7bIQ3RX9eeIOmgwjr6jlGsgWR8D5c?=
 =?us-ascii?Q?9PCT/BmbXPftHYXmL9iJDftY3wd2jcytp2OS8Ne7D2AS7NmPVoo2CrkFnbrC?=
 =?us-ascii?Q?fwLl21ajH4CMFkRL0hGAi0DnTXYt3Ol0fddCRgIHS/syB0HVULGwBMX0DYJ6?=
 =?us-ascii?Q?RwP6xqI4sW0eFcZPTzJqPzT4SYEl/72O/OZF937Z5fhNCUchcaZ2GD0mJdFs?=
 =?us-ascii?Q?o4+xFjthJQb1oPNQb5JkEKI+fNidr4ue4ULdDFEs1Lh8/MsIWLDjdvCGFqzP?=
 =?us-ascii?Q?mw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ZE1JmxYsTWgIucXFNGezpZTYRpHL7JOzd+5b9W/c2ZbtrJYC73CPjps5diEAoZwT5uqHcTDMKZJ/GOWBigrH7lBFrOxOUHw5kDN30KYqVN4hpyBp/Jcd2aLu5ywQ40TzZkjFSzI0g9wTc23F4/iyIScEJXQBxNNpEoLtd0KLdvPg6IxLPKbWBPU+LG8fpM0GGETbN76uCoUjxyGu5bie6ajWGJaLmKQUls/lsmM6O/nty4MwXp7jlzZdKk+N2SVQPfRrcvYDHy0yRhaOOyRyCIfI7bTWY58g9+Nz2UIIODML1DrI/KCVFOEVq/7oZ6JBATQBuJgzkxGewe8BzvFyjYTucPCM0u26gGqMJfe0I3RVufqiLeRkZrRhvs7CrrVh8T3IDxNUh2GcXLbMYEhh8neMaMKBV9aNKX5RGjkQW3JQwHybaxn5uE2NE0a3RD5qq6hoSDtyhoaLEyU0VJv3ipYz60neAwdDLa6NofG9gnodzrhPT/Inr/OKCdtMIkOpecue6ObdFl0EQTfPsy9Mcv3l2PFoTC7TcG91M4hMsmmN0ePy+7H/m5Nrcrt8D5WzkaamGiXGVv9pcaSG5W+Mq7ghx9DiLhwRO2Ts4G1MjBje2tYV8j4IYruVIFaOdOMy
X-OriginatorOrg: drivenets.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0da494a8-edf0-4764-c3ae-08dcfca7612e
X-MS-Exchange-CrossTenant-AuthSource: DB8PR08MB5388.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2024 08:05:00.1706
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 662f82da-cf45-4bdf-b295-33b083f5d229
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aRJq16c181h3PQgPle1//WijA6j67kJBcWnsj+mfWM+U5wq66E+9tMKlBa7uxZDDzbLUcuD3HN+oehTIFSWwXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB5553
X-MDID: 1730707502-783C_4kWdLEp
X-MDID-O:
 eu1;ams;1730707502;783C_4kWdLEp;<gnaaman@drivenets.com>;495c1e7a27a6c3e35a5fabc922783896
X-PPE-TRUSTED: V=1;DIR=OUT;

Remove the now-unused neighbour::next pointer, leaving struct neighbour
solely with the hlist_node implementation.

Signed-off-by: Gilad Naaman <gnaaman@drivenets.com>
---
 include/net/neighbour.h |  4 +-
 net/core/neighbour.c    | 90 +++++------------------------------------
 net/ipv4/arp.c          |  2 +-
 3 files changed, 12 insertions(+), 84 deletions(-)

diff --git a/include/net/neighbour.h b/include/net/neighbour.h
index 68b1970d9045..0244fbd22a1f 100644
--- a/include/net/neighbour.h
+++ b/include/net/neighbour.h
@@ -135,7 +135,6 @@ struct neigh_statistics {
 #define NEIGH_CACHE_STAT_INC(tbl, field) this_cpu_inc((tbl)->stats->field)
 
 struct neighbour {
-	struct neighbour __rcu	*next;
 	struct hlist_node	hash;
 	struct neigh_table	*tbl;
 	struct neigh_parms	*parms;
@@ -191,7 +190,6 @@ struct pneigh_entry {
 #define NEIGH_NUM_HASH_RND	4
 
 struct neigh_hash_table {
-	struct neighbour __rcu	**hash_buckets;
 	struct hlist_head	*hash_heads;
 	unsigned int		hash_shift;
 	__u32			hash_rnd[NEIGH_NUM_HASH_RND];
@@ -352,7 +350,7 @@ int __neigh_event_send(struct neighbour *neigh, struct sk_buff *skb,
 int neigh_update(struct neighbour *neigh, const u8 *lladdr, u8 new, u32 flags,
 		 u32 nlmsg_pid);
 void __neigh_set_probe_once(struct neighbour *neigh);
-bool neigh_remove_one(struct neighbour *ndel, struct neigh_table *tbl);
+bool neigh_remove_one(struct neighbour *ndel);
 void neigh_changeaddr(struct neigh_table *tbl, struct net_device *dev);
 int neigh_ifdown(struct neigh_table *tbl, struct net_device *dev);
 int neigh_carrier_down(struct neigh_table *tbl, struct net_device *dev);
diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index f7119380d983..a379b80a22c5 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -204,18 +204,12 @@ static void neigh_update_flags(struct neighbour *neigh, u32 flags, int *notify,
 	}
 }
 
-static bool neigh_del(struct neighbour *n, struct neighbour __rcu **np,
-		      struct neigh_table *tbl)
+bool neigh_remove_one(struct neighbour *n)
 {
 	bool retval = false;
 
 	write_lock(&n->lock);
 	if (refcount_read(&n->refcnt) == 1) {
-		struct neighbour *neigh;
-
-		neigh = rcu_dereference_protected(n->next,
-						  lockdep_is_held(&tbl->lock));
-		rcu_assign_pointer(*np, neigh);
 		hlist_del_rcu(&n->hash);
 		neigh_mark_dead(n);
 		retval = true;
@@ -226,29 +220,6 @@ static bool neigh_del(struct neighbour *n, struct neighbour __rcu **np,
 	return retval;
 }
 
-bool neigh_remove_one(struct neighbour *ndel, struct neigh_table *tbl)
-{
-	struct neigh_hash_table *nht;
-	void *pkey = ndel->primary_key;
-	u32 hash_val;
-	struct neighbour *n;
-	struct neighbour __rcu **np;
-
-	nht = rcu_dereference_protected(tbl->nht,
-					lockdep_is_held(&tbl->lock));
-	hash_val = tbl->hash(pkey, ndel->dev, nht->hash_rnd);
-	hash_val = hash_val >> (32 - nht->hash_shift);
-
-	np = &nht->hash_buckets[hash_val];
-	while ((n = rcu_dereference_protected(*np,
-					      lockdep_is_held(&tbl->lock)))) {
-		if (n == ndel)
-			return neigh_del(n, np, tbl);
-		np = &n->next;
-	}
-	return false;
-}
-
 static int neigh_forced_gc(struct neigh_table *tbl)
 {
 	int max_clean = atomic_read(&tbl->gc_entries) -
@@ -276,7 +247,7 @@ static int neigh_forced_gc(struct neigh_table *tbl)
 				remove = true;
 			write_unlock(&n->lock);
 
-			if (remove && neigh_remove_one(n, tbl))
+			if (remove && neigh_remove_one(n))
 				shrunk++;
 			if (shrunk >= max_clean)
 				break;
@@ -387,22 +358,15 @@ static void neigh_flush_dev(struct neigh_table *tbl, struct net_device *dev,
 					lockdep_is_held(&tbl->lock));
 
 	for (i = 0; i < (1 << nht->hash_shift); i++) {
-		struct neighbour __rcu **np = &nht->hash_buckets[i];
 		struct hlist_node *tmp;
 		struct neighbour *n;
 
 		neigh_for_each_in_bucket_safe(n, tmp, &nht->hash_heads[i]) {
-			if (dev && n->dev != dev) {
-				np = &n->next;
+			if (dev && n->dev != dev)
 				continue;
-			}
-			if (skip_perm && n->nud_state & NUD_PERMANENT) {
-				np = &n->next;
+			if (skip_perm && n->nud_state & NUD_PERMANENT)
 				continue;
-			}
-			rcu_assign_pointer(*np,
-				   rcu_dereference_protected(n->next,
-						lockdep_is_held(&tbl->lock)));
+
 			hlist_del_rcu(&n->hash);
 			write_lock(&n->lock);
 			neigh_del_timer(n);
@@ -531,9 +495,7 @@ static void neigh_get_hash_rnd(u32 *x)
 
 static struct neigh_hash_table *neigh_hash_alloc(unsigned int shift)
 {
-	size_t hash_heads_size = (1 << shift) * sizeof(struct hlist_head);
-	size_t size = (1 << shift) * sizeof(struct neighbour *);
-	struct neighbour __rcu **buckets;
+	size_t size = (1 << shift) * sizeof(struct hlist_head);
 	struct hlist_head *hash_heads;
 	struct neigh_hash_table *ret;
 	int i;
@@ -542,18 +504,11 @@ static struct neigh_hash_table *neigh_hash_alloc(unsigned int shift)
 	if (!ret)
 		return NULL;
 
-	buckets = kvzalloc(size, GFP_ATOMIC);
-	if (!buckets) {
-		kfree(ret);
-		return NULL;
-	}
-	hash_heads = kvzalloc(hash_heads_size, GFP_ATOMIC);
+	hash_heads = kvzalloc(size, GFP_ATOMIC);
 	if (!hash_heads) {
-		kvfree(buckets);
 		kfree(ret);
 		return NULL;
 	}
-	ret->hash_buckets = buckets;
 	ret->hash_heads = hash_heads;
 	ret->hash_shift = shift;
 	for (i = 0; i < NEIGH_NUM_HASH_RND; i++)
@@ -567,7 +522,6 @@ static void neigh_hash_free_rcu(struct rcu_head *head)
 						    struct neigh_hash_table,
 						    rcu);
 
-	kvfree(nht->hash_buckets);
 	kvfree(nht->hash_heads);
 	kfree(nht);
 }
@@ -596,11 +550,6 @@ static struct neigh_hash_table *neigh_hash_grow(struct neigh_table *tbl,
 
 			hash >>= (32 - new_nht->hash_shift);
 
-			rcu_assign_pointer(n->next,
-					   rcu_dereference_protected(
-						new_nht->hash_buckets[hash],
-						lockdep_is_held(&tbl->lock)));
-			rcu_assign_pointer(new_nht->hash_buckets[hash], n);
 			hlist_del_rcu(&n->hash);
 			hlist_add_head_rcu(&n->hash, &new_nht->hash_heads[hash]);
 		}
@@ -705,10 +654,6 @@ ___neigh_create(struct neigh_table *tbl, const void *pkey,
 		list_add_tail(&n->managed_list, &n->tbl->managed_list);
 	if (want_ref)
 		neigh_hold(n);
-	rcu_assign_pointer(n->next,
-			   rcu_dereference_protected(nht->hash_buckets[hash_val],
-						     lockdep_is_held(&tbl->lock)));
-	rcu_assign_pointer(nht->hash_buckets[hash_val], n);
 	hlist_add_head_rcu(&n->hash, &nht->hash_heads[hash_val]);
 	write_unlock_bh(&tbl->lock);
 	neigh_dbg(2, "neigh %p is created\n", n);
@@ -942,7 +887,6 @@ static void neigh_periodic_work(struct work_struct *work)
 {
 	struct neigh_table *tbl = container_of(work, struct neigh_table, gc_work.work);
 	struct neigh_hash_table *nht;
-	struct neighbour __rcu **np;
 	struct hlist_node *tmp;
 	struct neighbour *n;
 	unsigned int i;
@@ -970,8 +914,6 @@ static void neigh_periodic_work(struct work_struct *work)
 		goto out;
 
 	for (i = 0 ; i < (1 << nht->hash_shift); i++) {
-		np = &nht->hash_buckets[i];
-
 		neigh_for_each_in_bucket_safe(n, tmp, &nht->hash_heads[i]) {
 			unsigned int state;
 
@@ -981,7 +923,7 @@ static void neigh_periodic_work(struct work_struct *work)
 			if ((state & (NUD_PERMANENT | NUD_IN_TIMER)) ||
 			    (n->flags & NTF_EXT_LEARNED)) {
 				write_unlock(&n->lock);
-				goto next_elt;
+				continue;
 			}
 
 			if (time_before(n->used, n->confirmed) &&
@@ -992,9 +934,6 @@ static void neigh_periodic_work(struct work_struct *work)
 			    (state == NUD_FAILED ||
 			     !time_in_range_open(jiffies, n->used,
 						 n->used + NEIGH_VAR(n->parms, GC_STALETIME)))) {
-				rcu_assign_pointer(*np,
-					rcu_dereference_protected(n->next,
-						lockdep_is_held(&tbl->lock)));
 				hlist_del_rcu(&n->hash);
 				neigh_mark_dead(n);
 				write_unlock(&n->lock);
@@ -1002,9 +941,6 @@ static void neigh_periodic_work(struct work_struct *work)
 				continue;
 			}
 			write_unlock(&n->lock);
-
-next_elt:
-			np = &n->next;
 		}
 		/*
 		 * It's fine to release lock here, even if hash table
@@ -1951,7 +1887,7 @@ static int neigh_delete(struct sk_buff *skb, struct nlmsghdr *nlh,
 			     NETLINK_CB(skb).portid, extack);
 	write_lock_bh(&tbl->lock);
 	neigh_release(neigh);
-	neigh_remove_one(neigh, tbl);
+	neigh_remove_one(neigh);
 	write_unlock_bh(&tbl->lock);
 
 out:
@@ -3108,24 +3044,18 @@ void __neigh_for_each_release(struct neigh_table *tbl,
 	nht = rcu_dereference_protected(tbl->nht,
 					lockdep_is_held(&tbl->lock));
 	for (chain = 0; chain < (1 << nht->hash_shift); chain++) {
-		struct neighbour __rcu **np;
 		struct hlist_node *tmp;
 		struct neighbour *n;
 
-		np = &nht->hash_buckets[chain];
 		neigh_for_each_in_bucket_safe(n, tmp, &nht->hash_heads[chain]) {
 			int release;
 
 			write_lock(&n->lock);
 			release = cb(n);
 			if (release) {
-				rcu_assign_pointer(*np,
-					rcu_dereference_protected(n->next,
-						lockdep_is_held(&tbl->lock)));
 				hlist_del_rcu(&n->hash);
 				neigh_mark_dead(n);
-			} else
-				np = &n->next;
+			}
 			write_unlock(&n->lock);
 			if (release)
 				neigh_cleanup_and_release(n);
diff --git a/net/ipv4/arp.c b/net/ipv4/arp.c
index 11c1519b3699..cb9a7ed8abd3 100644
--- a/net/ipv4/arp.c
+++ b/net/ipv4/arp.c
@@ -1215,7 +1215,7 @@ int arp_invalidate(struct net_device *dev, __be32 ip, bool force)
 					   NEIGH_UPDATE_F_ADMIN, 0);
 		write_lock_bh(&tbl->lock);
 		neigh_release(neigh);
-		neigh_remove_one(neigh, tbl);
+		neigh_remove_one(neigh);
 		write_unlock_bh(&tbl->lock);
 	}
 
-- 
2.34.1


