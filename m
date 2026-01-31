Return-Path: <netdev+bounces-255518-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6J20OMSBfmlQaAIAu9opvQ
	(envelope-from <netdev+bounces-255518-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 23:27:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CDCCC42C2
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 23:27:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7B0D330564EB
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 22:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BFAB38A9C4;
	Sat, 31 Jan 2026 22:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="LIGhmIzC"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013071.outbound.protection.outlook.com [52.101.72.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A014838A9B5;
	Sat, 31 Jan 2026 22:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769898343; cv=fail; b=NNF1oIZAagnVCJ2B38xBzRuAyWWbngoRRBssUKKbH4PjY97jrVpBjDHnFQmTMgVENfEDWkL79+CvevCJzDArOUmNqf4izT2/EAXA/v9e2oNVXXEP9fyS6C1Ly/CrAHUn9OAi+Kpc3Bi9TF+PTACg8SK18CkA0tt2nESchGfxx0E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769898343; c=relaxed/simple;
	bh=s1XZncvgOh71GEK9Ajjd7vgKSOe7HtAgxYOsw3C+EyU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T09VK1/HAF1esuYyNI2K7PO0x2EcRxLEwEvwCp6CVejRt2dRe9OInnzpJN5HSDZ6O/mg6hi7lbTGUZMir4xyRI2WliYOX9QsEi/ycrkjiqx928SKKgAhyg0h7ICgARIfixwcOlpMRwAgd1xDo4qdevjvicxveFZOCwOjm8IA1zs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=LIGhmIzC; arc=fail smtp.client-ip=52.101.72.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nXaRhA6ujlxohUkRvc1Z5K5G7TF1SeL3FAjHTsj81HqLqFUp3rNqwGyuuetQI1q1mQZHMlceT//+tQ7JkSJjegI5BUHTMwOlS04QI71Ln1FUYHEhA/DSqyNjgzlyM/+jP1bPLkLC0G6F8ElX+SIWCkV/SBS+DCk9eEx9TsPlp5hy/PIH0jzHSxZjtqayeYDL/lV9waPLv+8gQ/i0PRqM8X2Hzaazu3iBTZRZRlYnht6XLB0WrWhSdwvEQ/HCsdvMK+fVzYMfBKaT4CnWihqaZj93I14wvjtGG/f+QQTmvEVrMN++FdNgRWukQcJF+ZjazKi+Kjd896kn7ZFIyxstCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kxBPhoiYPa8BwpPZJ4Xaf6UmBUZp3S4Xiety5iMn9dI=;
 b=QfWEDVjllfDeLSLk4hnEg/wdW2Ga9C8M/s+54z9ysycWGcIqtriQjyRgFBLxwUEyeq1gYebr13F9pllQ7k0OyP2smNrw5RA/pGA7WsGy95Rwb9kGdeGIJC6s77+ehKIJC1sgDESrfQI+21X2u+OywRJ5qxOObreaqjUZeKgUKL1bMhcx8eB/wfTb51HLPggXe/aJopopO8fm9rN1QOVBvChOSA64NmKrTBD38wqj/cK92/sJ5F3lm1DofIczd2xuwGRX+kKsBTm33JDKsAxqgL4QJ7QcqOmaeKUC0c7O9adsDW8Xr9KmM1jefvJzIu1NV3rtDyO4/hx3kmOhpdzbNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.240) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kxBPhoiYPa8BwpPZJ4Xaf6UmBUZp3S4Xiety5iMn9dI=;
 b=LIGhmIzCfqFSIsiUsqOE956fp9pt+cJIPiMyiWKVqaT8cgbXxgnq4nKaFWgRu+D50dOarhzyavf1WqjF5uEwIZlpNoQGBPUh4B3jDv48dOzMw9DcmiZ9O6U/6JEF7c0FwV1ll2KRA32hNjyV/+ym6kfHjdJkXYrxJGwd9zX1COZdfkYOD+LKGBGQo+R8eLp94QGOf7dM2ewcArhvCIIELFrRMTWXyekiGfDIFMXMQoFGLJiU5XIQvsA/6ggWstLzg3lpsAXchE+PgvlHbSBARKTXQ2GH9NvADxaZI/zRC++dCn8mQeI4D+JEFhMJ2wnVAOOvzRvc6eKLI4KVBjpkBw==
Received: from DU7PR01CA0047.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50e::24) by AM7PR07MB6786.eurprd07.prod.outlook.com
 (2603:10a6:20b:1b7::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.15; Sat, 31 Jan
 2026 22:25:37 +0000
Received: from DU2PEPF0001E9C1.eurprd03.prod.outlook.com
 (2603:10a6:10:50e:cafe::41) by DU7PR01CA0047.outlook.office365.com
 (2603:10a6:10:50e::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.12 via Frontend Transport; Sat,
 31 Jan 2026 22:25:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.240)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.240 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.240;
 helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.240) by
 DU2PEPF0001E9C1.mail.protection.outlook.com (10.167.8.70) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.3 via
 Frontend Transport; Sat, 31 Jan 2026 22:25:37 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id 8CCAA238DD;
	Sun,  1 Feb 2026 00:25:35 +0200 (EET)
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
Subject: [PATCH v13 net-next 03/15] selftests/net: gro: add self-test for TCP CWR flag
Date: Sat, 31 Jan 2026 23:25:03 +0100
Message-Id: <20260131222515.8485-4-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260131222515.8485-1-chia-yu.chang@nokia-bell-labs.com>
References: <20260131222515.8485-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF0001E9C1:EE_|AM7PR07MB6786:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: e666a511-d167-4acb-daec-08de6117a878
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|376014|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QZMtxzKDBonRM2WUMmjZTEgyX7mbErF7OCSxVszbeMPnqTZbtK+TMLiWplc7?=
 =?us-ascii?Q?gPKxVFLRnYBjj2H9ZpX2jFKhnGa8P6D1q0nvOR7IjV5w8rKgyMwa/V1F0plC?=
 =?us-ascii?Q?CvmPKdrkDgC5SQgOlXpAfbA8h6+6GSZhc++ptItGQQgh0f1mDC9+i/VNf6V5?=
 =?us-ascii?Q?EkC1rcFQVCAnp9dR5DecusErgzjiXPcJR+xExWhk+6U4d2PpGkMCUDRWqByn?=
 =?us-ascii?Q?ktVSj5tn3jKifOtAXpKCqVqIAWwZOAO0tmNIDDJqn2dfP26n5rItf/8D7Gzw?=
 =?us-ascii?Q?L0YLkPfrdW151zwABDGWlym6AFH/C33UaNuIOGGFwPMsHw3Cqy9o1ZjNdYCI?=
 =?us-ascii?Q?oQidbWF+ajHzaeTzNumybpcaogf1YU4qp7HOsYSypsV8RvgGzhXykRMuNSVG?=
 =?us-ascii?Q?TUtR9EVfUslki+qxHAPefVov/830Bckwbc9RK0jtrTTqlHi+b50ro8E0fqwt?=
 =?us-ascii?Q?8RtOsryEJ+v2B8p1uRow4cE9CjEUu6PrZagc+QEUF29qoZTJyuj+/5LoV8Mm?=
 =?us-ascii?Q?7do9lVeDz+4Qpf0e+emOakMYRpA+gLaGcw+uzu/5FanlX6MIS//eGMMPy49+?=
 =?us-ascii?Q?SRwYi58puagb/hEbPSwx2nIFuqM4yXUXlJJc5y0SD0r10K3aP8uMlc0ln6nM?=
 =?us-ascii?Q?aFf+dD2o395DUut5elvFkXjZJ1hTB49scYt1kac7l8QUbaVc0tEhMXAyEoV1?=
 =?us-ascii?Q?66RC5iPn6I0OInVmUQtUFur3umoBdjR1mAadX6fQ6GvjrJ+FApObIoLxs6oX?=
 =?us-ascii?Q?qWC1YGAzg05C5vxd07A4Kqsknh7bgkdmW+bEXq5Wfb3kZyfqAGXUw6bR+nBH?=
 =?us-ascii?Q?5fOqccgAJbF+iy9NIWSZ7tJKiBgSmJX3U7DJ0NYBzXiW4NfqopmpUIBoMHLB?=
 =?us-ascii?Q?Ijjcy/J62pjnpXSma2YUKfQ1tObiLOMWL08YfaXs3qPpW6v95izK6MNgM9pQ?=
 =?us-ascii?Q?DnKaqk0Y2kpL6xkLSBTNsMk2jWdjYJcx/vBUvBH/3JKWzOkssGUbEk3QZQwr?=
 =?us-ascii?Q?R9+72vFuB6EOTrnWck5hbho9DtKIahmOLTdhTEgoaLduKWOO4FXkhkqbEIrc?=
 =?us-ascii?Q?EmfoONsE0uwsXrqmk9Rp4HXMABJvTVK8rfTMl3BeDQPtvVAOcy2Qh8+XJ6xd?=
 =?us-ascii?Q?Nj8dmqFHLLrt0TzXktI6MddLrb/oyWYfk6b2fLq+/+3oAjawCPLTa9BndCdm?=
 =?us-ascii?Q?5AjGeXgajCR05aQTuEGoo9+xAq0Ae+74ezfMi9l87CQn8dRgzNRu+BTv28SB?=
 =?us-ascii?Q?7haYvf1Kd6pEgc/eMeCrmPJ7eqpZYt0DJFGTYs+1uPkJeFK3y3DzVBmPcx9w?=
 =?us-ascii?Q?fvFCcKL7uXv7KyFr1QDR/m4I0ZC/Nt06GowF9q/Gg1k8q1IpuP/mVGMdLkjP?=
 =?us-ascii?Q?Ltqwx6ADfeDG305V2PtUGqZnf1YEiuIPZRRvUoVk6lSEOGnKQnj0eJdL0tLH?=
 =?us-ascii?Q?LxQfnvPFSJk/4LroyQKOGPZqb3V973tsmw+AGPsT1p2FZEAcNYfiWMRLBTgn?=
 =?us-ascii?Q?F0Ya9Sto70CVum0AkSeEpdroaLxeofiCoIOBagovIPIU1A3oEv/WFGxOLnSH?=
 =?us-ascii?Q?gVHmuUzKjbD2eBgWMREchSCnBy26zozovMi9S1NjwI++JSjt3/BVliOAzrnP?=
 =?us-ascii?Q?M2iwu2mJP1pkEFmqfkg0VwwNw4GOTzJgVnp8a8Ewn152cB1X3CM9nwc3Xftd?=
 =?us-ascii?Q?1FJJAcptLAwQP7zMmDuhsaNZLHc=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.2.240;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(36860700013)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	4sJaoEZ1JXDpwKKik0JhMB1B5JBp49yDf4keMCytsvZtOg6Yxd/m1F00SQLL0hZBY2KJwaawnfeaceCgsGUNP4D2bNK6BZw1MM7LgvK0fG2HXyZ+8LpikPRodUEI9bx7/mc+pREHYKvOFXg918OPvvApGjqkecVvM8+h9akfbhMjlOfGRtb1U04HE/VuiXRYSWt0DQhofKlKpc4ejtOmHoEKTT92kOFyWVGB4iTSotCt3nkAP6EHVqsCUxXF5W0TGTqj/X+Cuu4uE696lZTFre6lghHKb2vN1BV0IFm4FLs9ZaZoPaHHVVK/ZhocxPiLlH6DfMlM4mPVM9QKdXmkbmLY2T9hEkK5m9tkWGe1sU1L+yUP3YY3uz+QjIFB+M4sp7fQGYvB2M1G/Vso/3wL2bxF8WU1WbxvpS0A5F/yTgyW/8GoB2iXiiDrM4qLFvhv
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2026 22:25:37.0998
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e666a511-d167-4acb-daec-08de6117a878
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DU2PEPF0001E9C1.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR07MB6786
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nokia-bell-labs.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[nokia-bell-labs.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[34];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255518-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[redhat.com,google.com,nvidia.com,vger.kernel.org,lwn.net,kernel.org,gmail.com,mojatatu.com,networkplumber.org,resnulli.us,davemloft.net,lunn.ch,fiberby.net,nokia-bell-labs.com,cablelabs.com,ericsson.com,apple.com,gmx.at,comcast.com];
	DKIM_TRACE(0.00)[nokia-bell-labs.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nokia-bell-labs.com:email,nokia-bell-labs.com:dkim,nokia-bell-labs.com:mid];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chia-yu.chang@nokia-bell-labs.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 8CDCCC42C2
X-Rspamd-Action: no action

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Currently, GRO does not flush packets when the CWR bit is set.
A corresponding self-test is being added, in which the CWR flag
is set for two consecutive packets, but the first packet with the
CWR flag set will not be flushed immediately.

+===================+==========+===============+===========+
|     Packet id     | CWR flag |    Payload    | Flushing? |
+===================+==========+===============+===========+
|         0         |     0    |  PAYLOAD_LEN  |     0     |
|        ...        |     0    |  PAYLOAD_LEN  |     1     |
+-------------------+----------+---------------+-----------+
| NUM_PACKETS/2 - 1 |     1    |  payload_len  |     0     |
|   NUM_PACKETS/2   |     1    |  payload_len  |     1     |
+-------------------+----------+---------------+-----------+
|        ...        |     0    |  PAYLOAD_LEN  |     0     |
|   NUM_PACKETS     |     0    |  PAYLOAD_LEN  |     1     |
+===================+==========+===============+===========+

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>

---
v9:
- Add missing comma

v8:
- Rebase to the latest tools/testing/selftests/drivers/net/gro.c

v7:
- Update comments
---
 tools/testing/selftests/drivers/net/gro.c  | 81 ++++++++++++++++------
 tools/testing/selftests/drivers/net/gro.py |  3 +-
 2 files changed, 60 insertions(+), 24 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/gro.c b/tools/testing/selftests/drivers/net/gro.c
index e76c618704cf..3c0745b68bfa 100644
--- a/tools/testing/selftests/drivers/net/gro.c
+++ b/tools/testing/selftests/drivers/net/gro.c
@@ -17,8 +17,8 @@
  *  Pure ACK does not coalesce.
  *
  * flags_*:
- *  No packets with PSH, SYN, URG, RST set will be coalesced.
- *   - flags_psh, flags_syn, flags_rst, flags_urg
+ *  No packets with PSH, SYN, URG, RST, CWR set will be coalesced.
+ *   - flags_psh, flags_syn, flags_rst, flags_urg, flags_cwr
  *
  * tcp_*:
  *  Packets with incorrect checksum, non-consecutive seqno and
@@ -360,32 +360,58 @@ static void create_packet(void *buf, int seq_offset, int ack_offset,
 	fill_datalinklayer(buf);
 }
 
-/* send one extra flag, not first and not last pkt */
-static void send_flags(int fd, struct sockaddr_ll *daddr, int psh, int syn,
-		       int rst, int urg)
+#ifndef TH_CWR
+#define TH_CWR 0x80
+#endif
+static void set_flags(struct tcphdr *tcph, int payload_len, int psh, int syn,
+		      int rst, int urg, int cwr)
 {
-	static char flag_buf[MAX_HDR_LEN + PAYLOAD_LEN];
-	static char buf[MAX_HDR_LEN + PAYLOAD_LEN];
-	int payload_len, pkt_size, flag, i;
-	struct tcphdr *tcph;
-
-	payload_len = PAYLOAD_LEN * psh;
-	pkt_size = total_hdr_len + payload_len;
-	flag = NUM_PACKETS / 2;
-
-	create_packet(flag_buf, flag * payload_len, 0, payload_len, 0);
-
-	tcph = (struct tcphdr *)(flag_buf + tcp_offset);
 	tcph->psh = psh;
 	tcph->syn = syn;
 	tcph->rst = rst;
 	tcph->urg = urg;
+	if (cwr)
+		tcph->th_flags |= TH_CWR;
+	else
+		tcph->th_flags &= ~TH_CWR;
 	tcph->check = 0;
 	tcph->check = tcp_checksum(tcph, payload_len);
+}
+
+/* send extra flags of the (NUM_PACKETS / 2) and (NUM_PACKETS / 2 - 1)
+ * pkts, not first and not last pkt
+ */
+static void send_flags(int fd, struct sockaddr_ll *daddr, int psh, int syn,
+		       int rst, int urg, int cwr)
+{
+	static char flag_buf[2][MAX_HDR_LEN + PAYLOAD_LEN];
+	static char buf[MAX_HDR_LEN + PAYLOAD_LEN];
+	int payload_len, pkt_size, i;
+	struct tcphdr *tcph;
+	int flag[2];
+
+	payload_len = PAYLOAD_LEN * (psh || cwr);
+	pkt_size = total_hdr_len + payload_len;
+	flag[0] = NUM_PACKETS / 2;
+	flag[1] = NUM_PACKETS / 2 - 1;
+
+	/* Create and configure packets with flags
+	 */
+	for (i = 0; i < 2; i++) {
+		if (flag[i] > 0) {
+			create_packet(flag_buf[i], flag[i] * payload_len, 0,
+				      payload_len, 0);
+			tcph = (struct tcphdr *)(flag_buf[i] + tcp_offset);
+			set_flags(tcph, payload_len, psh, syn, rst, urg, cwr);
+		}
+	}
 
 	for (i = 0; i < NUM_PACKETS + 1; i++) {
-		if (i == flag) {
-			write_packet(fd, flag_buf, pkt_size, daddr);
+		if (i == flag[0]) {
+			write_packet(fd, flag_buf[0], pkt_size, daddr);
+			continue;
+		} else if (i == flag[1] && cwr) {
+			write_packet(fd, flag_buf[1], pkt_size, daddr);
 			continue;
 		}
 		create_packet(buf, i * PAYLOAD_LEN, 0, PAYLOAD_LEN, 0);
@@ -1068,16 +1094,19 @@ static void gro_sender(void)
 
 	/* flags sub-tests */
 	} else if (strcmp(testname, "flags_psh") == 0) {
-		send_flags(txfd, &daddr, 1, 0, 0, 0);
+		send_flags(txfd, &daddr, 1, 0, 0, 0, 0);
 		write_packet(txfd, fin_pkt, total_hdr_len, &daddr);
 	} else if (strcmp(testname, "flags_syn") == 0) {
-		send_flags(txfd, &daddr, 0, 1, 0, 0);
+		send_flags(txfd, &daddr, 0, 1, 0, 0, 0);
 		write_packet(txfd, fin_pkt, total_hdr_len, &daddr);
 	} else if (strcmp(testname, "flags_rst") == 0) {
-		send_flags(txfd, &daddr, 0, 0, 1, 0);
+		send_flags(txfd, &daddr, 0, 0, 1, 0, 0);
 		write_packet(txfd, fin_pkt, total_hdr_len, &daddr);
 	} else if (strcmp(testname, "flags_urg") == 0) {
-		send_flags(txfd, &daddr, 0, 0, 0, 1);
+		send_flags(txfd, &daddr, 0, 0, 0, 1, 0);
+		write_packet(txfd, fin_pkt, total_hdr_len, &daddr);
+	} else if (strcmp(testname, "flags_cwr") == 0) {
+		send_flags(txfd, &daddr, 0, 0, 0, 0, 1);
 		write_packet(txfd, fin_pkt, total_hdr_len, &daddr);
 
 	/* tcp sub-tests */
@@ -1239,6 +1268,12 @@ static void gro_receiver(void)
 		correct_payload[2] = PAYLOAD_LEN * 2;
 		printf("urg flag ends coalescing: ");
 		check_recv_pkts(rxfd, correct_payload, 3);
+	} else if (strcmp(testname, "flags_cwr") == 0) {
+		correct_payload[0] = PAYLOAD_LEN;
+		correct_payload[1] = PAYLOAD_LEN * 2;
+		correct_payload[2] = PAYLOAD_LEN * 2;
+		printf("cwr flag ends coalescing: ");
+		check_recv_pkts(rxfd, correct_payload, 3);
 
 	/* tcp sub-tests */
 	} else if (strcmp(testname, "tcp_csum") == 0) {
diff --git a/tools/testing/selftests/drivers/net/gro.py b/tools/testing/selftests/drivers/net/gro.py
index 1bb8af571456..cbc1b19dbc91 100755
--- a/tools/testing/selftests/drivers/net/gro.py
+++ b/tools/testing/selftests/drivers/net/gro.py
@@ -17,6 +17,7 @@ Test cases:
   - flags_syn: Packets with SYN flag don't coalesce
   - flags_rst: Packets with RST flag don't coalesce
   - flags_urg: Packets with URG flag don't coalesce
+  - flags_cwr: Packets with CWR flag don't coalesce
   - tcp_csum: Packets with incorrect checksum don't coalesce
   - tcp_seq: Packets with non-consecutive seqno don't coalesce
   - tcp_ts: Packets with different timestamp options don't coalesce
@@ -191,7 +192,7 @@ def _gro_variants():
     common_tests = [
         "data_same", "data_lrg_sml", "data_sml_lrg",
         "ack",
-        "flags_psh", "flags_syn", "flags_rst", "flags_urg",
+        "flags_psh", "flags_syn", "flags_rst", "flags_urg", "flags_cwr",
         "tcp_csum", "tcp_seq", "tcp_ts", "tcp_opt",
         "ip_ecn", "ip_tos",
         "large_max", "large_rem",
-- 
2.34.1


