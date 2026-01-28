Return-Path: <netdev+bounces-254290-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sCoqI/seemlS2QEAu9opvQ
	(envelope-from <netdev+bounces-254290-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 15:36:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AF8CCA2DFC
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 15:36:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5C60E30152DD
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 14:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 202DB35771A;
	Wed, 28 Jan 2026 14:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="R8PmlBCc"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010048.outbound.protection.outlook.com [52.101.84.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A87135A930;
	Wed, 28 Jan 2026 14:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769610899; cv=fail; b=WKVlZLnSricdDvn0yuB2HLkf+SLmbTn3/6NxwaEG7hz0LWiUybW/Hx/k/cM6aSD7JlWnxRx7vaAlHAjtp0Mk/Ro/cA2wolp6MFiRCHxkMvGoDsAMgFUqZohr1HCru6PQ6ASHa8fEBGQqOjR1txfAbLtt5pJ74QPWVyPg7tFGOms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769610899; c=relaxed/simple;
	bh=UZKusTYGKBNsR+p1cWCQuxj0agzXS47OlVX+Rl3Uh6k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hl+FeBt3PhUvr+BM+71Vm2bSId25kmWapqsjqVv5VCvIZrEcDqEhZpg0nJd8QwCIanxbf/ERaNxJzIPX4HJSGnH95F6p9jvG4N2Wl1trnzxciOX+gKAsNEPsaA4vkD1Au1JspXM1Lb2e7yrpy8npgMf19ym/FzGifCsc2CoBeYk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=R8PmlBCc; arc=fail smtp.client-ip=52.101.84.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=suznxaIfpaORE4L7yvwthtmUsvaMmvJbXZpEzsfJy/eFC+Y8yAdPa7BREtbUfnvFvrK0ArM/sCYh8KIOxOAadi4WoVZKLxYxNX/7BIhu3EzbviZSoB2J8SVS1iQkO7i3KGgR6NxBdJKd5BGC1cUhux/969y1FiLlPzeD4lAaAUMunFcuT1flsPstn3a1lbS8ZQY2eo1kcAuYGS/vyjZKJMzMAEG6UVVW0y3q59Gc/9+xP3RtHl+tfRqSaNnxNXophda397yVZYCFn/zLNPLgZahOqYk3y3Hx9Wl92oGtHJz8fWAjnVl+7cW0o7WnHzCXBpmn+nTRUU+7zR77jFODWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=86eKZY8UsqJAg8PU+paZvLEf6RQnbBtPGl/dPqew/lM=;
 b=S6nwYGB1WMwqcNeXUynVtsRKuvIQeesy0OeLRFTgvAkaRQ2jFFdGpJjK8WY9ZDmc2aqkMpo3q0znnT6rWPlmbxGhBcSHfNEmb1pj1edsgkU2+ha6z22olUHuhPoQ3cs9WTrcGpPY7/ShQdkMibtqrxx/OPpuIR4YiMHi6H9WdmseRCZe5m4BC7YY1CUu1j3UeY+IP1YKzPSwbMdD4bLcQKP1E1wQDRMnc/3dx4uRCNWD59KY69sTtjuCDH3Ji5rhHCpTJv9WH/Q46LTM8YrtPQAp8hMPEW3BJPzaXA3D0LCUZ1fML2DWmiOPhyInivAs5NzavxVKotV0yqn/3Ov5RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.240) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=86eKZY8UsqJAg8PU+paZvLEf6RQnbBtPGl/dPqew/lM=;
 b=R8PmlBCcKVGA5yaO7kaStRcoCkbsluFiIqLGZiEfBliI8B64kwtr1lL79JFY5aYonFrW8Ob3t7III34uYlfkbcBVMwMIENfek54lXs/5ciBcFPOO6axmjLteoH2tYc3D5tHMDHi9hQBClWYOrtnJWcuHYDgpruuH6O6d2qBvgaknXjLnaDrgb+9XpeMdYCLC6WfWupb2OyvM2i2nMFYbfFC5gKfnZ2LXuxhahXzuJBfuu7E4U6RPdOVmHp9j4CxXLtNUtWNa5rmuB3e8iKYhIk74ewjvi8pLXFVkNmAimEf9H81SenpG6EJ4pgjQR1NVaBT6zA13rtzcJ5tC0IP/Pg==
Received: from PR1P264CA0012.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:19e::17)
 by DU4PR07MB11740.eurprd07.prod.outlook.com (2603:10a6:10:643::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Wed, 28 Jan
 2026 14:34:51 +0000
Received: from AM4PEPF00025F95.EURPRD83.prod.outlook.com
 (2603:10a6:102:19e:cafe::6e) by PR1P264CA0012.outlook.office365.com
 (2603:10a6:102:19e::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.7 via Frontend Transport; Wed,
 28 Jan 2026 14:34:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.240)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.240 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.240;
 helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.240) by
 AM4PEPF00025F95.mail.protection.outlook.com (10.167.16.4) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.0 via
 Frontend Transport; Wed, 28 Jan 2026 14:34:51 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id CBB272379A;
	Wed, 28 Jan 2026 16:34:49 +0200 (EET)
From: chia-yu.chang@nokia-bell-labs.com
To: pabeni@redhat.com,
	edumazet@google.com,
	parav@nvidia.com,
	linux-doc@vger.kernel.org,
	corbet@lwn.net,
	horms@kernel.org,
	dsahern@kernel.org,
	kuniyu@google.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	dave.taht@gmail.com,
	jhs@mojatatu.com,
	kuba@kernel.org,
	stephen@networkplumber.org,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	andrew+netdev@lunn.ch,
	donald.hunter@gmail.com,
	ast@fiberby.net,
	liuhangbin@gmail.com,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	ij@kernel.org,
	ncardwell@google.com,
	koen.de_schepper@nokia-bell-labs.com,
	g.white@cablelabs.com,
	ingemar.s.johansson@ericsson.com,
	mirja.kuehlewind@ericsson.com,
	cheshire@apple.com,
	rs.ietf@gmx.at,
	Jason_Livingood@comcast.com,
	vidhi_goel@apple.com
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH v12 net-next 06/15] tcp: accecn: handle unexpected AccECN negotiation feedback
Date: Wed, 28 Jan 2026 15:34:26 +0100
Message-Id: <20260128143435.15708-7-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260128143435.15708-1-chia-yu.chang@nokia-bell-labs.com>
References: <20260128143435.15708-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00025F95:EE_|DU4PR07MB11740:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 0277e79e-3c35-4e82-7c98-08de5e7a6568
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?F8M3Uc5bol2EwQ7pjl8ysB/ZAb3vfH78X/PpjPfcVmbXbdAMhdTWpQkQopda?=
 =?us-ascii?Q?hd1Ul5fn8mRUNZDqDjkl8NqhY197xq18crPmRnt0MyUiP1NFL05neghK+RqN?=
 =?us-ascii?Q?3kcBP/iK1vHFCGgtnXS5mRSTgV5Y9+HxjypwgkVQBvJeSaGo7pAXxrwRqNvz?=
 =?us-ascii?Q?QCkcy65/DZ7btjQ94t0+P0KIy4G6jf+SeSg9TlGKsxcod6bag22iGThIY/aG?=
 =?us-ascii?Q?bUvT7Ln3N4HVl37h48/TLYZzd0KM4dUDckl6CrcO2gqgVPb4K8fpRchV2vXO?=
 =?us-ascii?Q?I6P19J2BXUnWfCn8bPAq5Ny/oNLml3y+3PmNXlszqOIAYKVJQeCf0RHJRfQ9?=
 =?us-ascii?Q?lw4WTqcVqhnLPASK6DIIsBAa7JT2cRj/XHI0NA7v7jnHaXwK2wizT4b3Oy1n?=
 =?us-ascii?Q?1auqhZp+8BNa5oacjV0wn2JxWBoaD/ekfHmCCe46U3wxzeYBzIRnWifO7hLI?=
 =?us-ascii?Q?2d4MPg01amJFA6E5GMOYS6EWmWH2wCTl3Bvs/HQAKf95nqzcEQ7jZbs1OwX/?=
 =?us-ascii?Q?NjjWZh8OdhX+LMHAkMZ0/QdJTXCNP8T9/w7ddIYZYzyUTn/s//OQ1KzA3p0M?=
 =?us-ascii?Q?L0s9BN36DEhYZw0NEYQYozcNuG1yQWvOlxHBWlkvrRlC0UIgwqSog0yHS0Il?=
 =?us-ascii?Q?yg/g+TlvOyPzOzrpYbI2dkqVHnUxLFvCoJ6dE2L9QT/vho6qKtaRO4Vo9DoZ?=
 =?us-ascii?Q?nUGjztEYqgSTOBXuJeREkoAiODPdwvPNxKxaaX9hu808J8WKGm9KqdBQri9J?=
 =?us-ascii?Q?bZ+q9B33Eo5KreHryxxoqaH8Q436t/X2ctrYxU+aINZbIP28DjeQNhf7OuL2?=
 =?us-ascii?Q?wr6STowoQZvoXvwplQFdKBP2klw98WW4UP2lCCgq1Z5GGo48QdNLpYLZ1nC7?=
 =?us-ascii?Q?iCIjUjPE/RZ2NM/5n0ogLEE4fUUf7RrRFl0NwOzuJnsk7sj9gwIqbP/yWtpD?=
 =?us-ascii?Q?aMZAB/jCjq8QbEcjHWpLLD6u+hsgoFq9z9oO+fFzlwmYxTG9iOil+s6vPDHJ?=
 =?us-ascii?Q?+2Rz4rSVuXAQhOUV7rG+/jDjpUKlJQKgv0RolyLBtYk0sBXv/6aVzavHNrNb?=
 =?us-ascii?Q?52SKIhC6o+Lk2zKinCnlfcT1EtsBCVIVCMIYSHi4YB/tTr58kez449Cd3UsF?=
 =?us-ascii?Q?j25MepUjXPm7rUrGJqyuoBZVhdDGWj9xz6CL1y6T0XvuzFomtmUNnEbi6KJO?=
 =?us-ascii?Q?QDegFkhIK0lQjVv9ZJPbzlvpl2G+k3VdHlEr1YPocP6c0fTjqwXvit6KGD/o?=
 =?us-ascii?Q?A/gTPsKAHCZrpFb1S8TErbORS7a3e4wQGEYdLtLbDEUL45zZVTvhWcDwikny?=
 =?us-ascii?Q?rnCPMAPsHrloxhcF6DXeSMD6T6ozFlZrEHIkXGKVv2JZulKCXUMnZlCjczOI?=
 =?us-ascii?Q?o90AEJg4jadv2e9rvlDettowfanvl6RAVI4B9KtNbq/R3mtZk8VVPCV1h64w?=
 =?us-ascii?Q?hHa4W+w5FO/emqzOWLTrwn3wrJ51i/kq643seErJQKqc5ag0QwWAHsPDPw+D?=
 =?us-ascii?Q?5hwXiMQWLGVEmY5WKg9F3Jz8SAN0RmykGoPt/erelNOjMSCleOvjC4uS4iOR?=
 =?us-ascii?Q?qdnCdVRJt2WotQqSu+AFXnQwNT7jwF1+HpOjccKujRYMiD8VlgQ2t9yin9/g?=
 =?us-ascii?Q?d+Q4SlNJ9/1yfl9w5RFEiZUsIPY2k8vJNaPBvC/z5EauYLnuUkUtBeezdWuY?=
 =?us-ascii?Q?+aaJzSjLDBASJHuOE0O0MoD2NUQ=3D?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.240;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 quwg9AGMGl0KPe1hwHBlts8qXABqvW5Hs2TdSy7TBoq3YRMrzJslxUMzQ1AZsZfYEw6VFSV73ppmJOdRhJUAmjp7yDPf6+VT2DDrn67d6MtWmI39MdmGSwXgsJPLPdAYDbRTSjFkiTG3It4OqmlLcGMbkHKzPvElKg5/2P8SG8uGUiORoF6eluVgDZjQ1MNPCp0PzFxBreXJK/aRn1UpK/xhZNubI1W26HESze4CqFMN5Cv/xvIcvAvVT8jDxye+/LTpyq2HHK8hrfBMEbGVwoy0LaoJQH/fuTmolxZzmW/T3PkpY5HO/AE6ThUpyOE9LAvIhDGzh9PG80rJuC5XehV3Egerful5CS55czlyvTcrM07E5bkrJZlI6px+5F1RmQOWxlZNE5AOdnTVyoddLITwk3BvRkX+w53DixMvZmjIK6ujyLhb0sxgBwZmB0FJ
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 14:34:51.2854
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0277e79e-3c35-4e82-7c98-08de5e7a6568
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AM4PEPF00025F95.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR07MB11740
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nokia-bell-labs.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[nokia-bell-labs.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[34];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254290-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[redhat.com,google.com,nvidia.com,vger.kernel.org,lwn.net,kernel.org,gmail.com,mojatatu.com,networkplumber.org,resnulli.us,davemloft.net,lunn.ch,fiberby.net,nokia-bell-labs.com,cablelabs.com,ericsson.com,apple.com,gmx.at,comcast.com];
	DKIM_TRACE(0.00)[nokia-bell-labs.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nokia-bell-labs.com:email,nokia-bell-labs.com:dkim,nokia-bell-labs.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chia-yu.chang@nokia-bell-labs.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: AF8CCA2DFC
X-Rspamd-Action: no action

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

According to Sections 3.1.2 and 3.1.3 of AccECN spec (RFC9768).

In Section 3.1.2, it says an AccECN implementation has no need to
recognize or support the Server response labelled 'Nonce' or ECN-nonce
feedback more generally, as RFC 3540 has been reclassified as Historic.
AccECN is compatible with alternative ECN feedback integrity approaches
to the nonce. The SYN/ACK labelled 'Nonce' with (AE,CWR,ECE) = (1,0,1)
is reserved for future use. A TCP Client (A) that receives such a SYN/ACK
follows the procedure for forward compatibility given in Section 3.1.3.

Then in Section 3.1.3, it says if a TCP Client has sent a SYN requesting
AccECN feedback with (AE,CWR,ECE) = (1,1,1) then receives a SYN/ACK with
the currently reserved combination (AE,CWR,ECE) = (1,0,1) but it does not
have logic specific to such a combination, the Client MUST enable AccECN
mode as if the SYN/ACK onfirmed that the Server supported AccECN and as
if it fed back that the IP-ECN field on the SYN had arrived unchanged.

Fixes: 3cae34274c79 ("tcp: accecn: AccECN negotiation").
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>

---
v10:
- Update commie message with full texts from RFC.

v5:
- Add "Fixes" tag.

v3:
- Update commit message to fix old AccECN commits.
---
 include/net/tcp_ecn.h | 44 ++++++++++++++++++++++++++++++-------------
 1 file changed, 31 insertions(+), 13 deletions(-)

diff --git a/include/net/tcp_ecn.h b/include/net/tcp_ecn.h
index 2e1637edf1d3..a709fb1756eb 100644
--- a/include/net/tcp_ecn.h
+++ b/include/net/tcp_ecn.h
@@ -473,6 +473,26 @@ static inline u8 tcp_accecn_option_init(const struct sk_buff *skb,
 	return TCP_ACCECN_OPT_COUNTER_SEEN;
 }
 
+static inline void tcp_ecn_rcv_synack_accecn(struct sock *sk,
+					     const struct sk_buff *skb, u8 dsf)
+{
+	struct tcp_sock *tp = tcp_sk(sk);
+
+	tcp_ecn_mode_set(tp, TCP_ECN_MODE_ACCECN);
+	tp->syn_ect_rcv = dsf & INET_ECN_MASK;
+	/* Demand Accurate ECN option in response to the SYN on the SYN/ACK
+	 * and the TCP server will try to send one more packet with an AccECN
+	 * Option at a later point during the connection.
+	 */
+	if (tp->rx_opt.accecn &&
+	    tp->saw_accecn_opt < TCP_ACCECN_OPT_COUNTER_SEEN) {
+		u8 saw_opt = tcp_accecn_option_init(skb, tp->rx_opt.accecn);
+
+		tcp_accecn_saw_opt_fail_recv(tp, saw_opt);
+		tp->accecn_opt_demand = 2;
+	}
+}
+
 /* See Table 2 of the AccECN draft */
 static inline void tcp_ecn_rcv_synack(struct sock *sk, const struct sk_buff *skb,
 				      const struct tcphdr *th, u8 ip_dsfield)
@@ -495,13 +515,11 @@ static inline void tcp_ecn_rcv_synack(struct sock *sk, const struct sk_buff *skb
 		tcp_ecn_mode_set(tp, TCP_ECN_DISABLED);
 		break;
 	case 0x1:
-	case 0x5:
 		/* +========+========+============+=============+
 		 * | A      | B      |  SYN/ACK   |  Feedback   |
 		 * |        |        |    B->A    |  Mode of A  |
 		 * |        |        | AE CWR ECE |             |
 		 * +========+========+============+=============+
-		 * | AccECN | Nonce  | 1   0   1  | (Reserved)  |
 		 * | AccECN | ECN    | 0   0   1  | Classic ECN |
 		 * | Nonce  | AccECN | 0   0   1  | Classic ECN |
 		 * | ECN    | AccECN | 0   0   1  | Classic ECN |
@@ -509,20 +527,20 @@ static inline void tcp_ecn_rcv_synack(struct sock *sk, const struct sk_buff *skb
 		 */
 		if (tcp_ca_no_fallback_rfc3168(sk))
 			tcp_ecn_mode_set(tp, TCP_ECN_DISABLED);
-		else if (tcp_ecn_mode_pending(tp))
-			/* Downgrade from AccECN, or requested initially */
+		else
 			tcp_ecn_mode_set(tp, TCP_ECN_MODE_RFC3168);
 		break;
-	default:
-		tcp_ecn_mode_set(tp, TCP_ECN_MODE_ACCECN);
-		tp->syn_ect_rcv = ip_dsfield & INET_ECN_MASK;
-		if (tp->rx_opt.accecn &&
-		    tp->saw_accecn_opt < TCP_ACCECN_OPT_COUNTER_SEEN) {
-			u8 saw_opt = tcp_accecn_option_init(skb, tp->rx_opt.accecn);
-
-			tcp_accecn_saw_opt_fail_recv(tp, saw_opt);
-			tp->accecn_opt_demand = 2;
+	case 0x5:
+		if (tcp_ecn_mode_pending(tp)) {
+			tcp_ecn_rcv_synack_accecn(sk, skb, ip_dsfield);
+			if (INET_ECN_is_ce(ip_dsfield)) {
+				tp->received_ce++;
+				tp->received_ce_pending++;
+			}
 		}
+		break;
+	default:
+		tcp_ecn_rcv_synack_accecn(sk, skb, ip_dsfield);
 		if (INET_ECN_is_ce(ip_dsfield) &&
 		    tcp_accecn_validate_syn_feedback(sk, ace,
 						     tp->syn_ect_snt)) {
-- 
2.34.1


