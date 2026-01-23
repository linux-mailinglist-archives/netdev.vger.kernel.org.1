Return-Path: <netdev+bounces-252764-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6I7qJWRJc2mHuQAAu9opvQ
	(envelope-from <netdev+bounces-252764-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 11:11:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4258874075
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 11:11:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EEFDD302346B
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 10:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C266437AA91;
	Fri, 23 Jan 2026 10:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="Yac5ezxt"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013000.outbound.protection.outlook.com [52.101.72.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36832D0635;
	Fri, 23 Jan 2026 10:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769162878; cv=fail; b=ZGxPxwbQk/YfgmAT5QwYso7Sz0WDkUFonqMCNCoW0GM1UB2mnFS+k8VtnlgGMNtacd+N1GBLDeAFgRQmWF23xtZIFc+nkfzB9GJSs2pKTkyB21M4QLmYmJrMS5ATMHQequBHdAOCbOcMiYTr3+BplBOlDsx8W5EQA0l6tW8XYQU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769162878; c=relaxed/simple;
	bh=UZKusTYGKBNsR+p1cWCQuxj0agzXS47OlVX+Rl3Uh6k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q0Gxf1SmhcsOEKYFQHLibHSgQtxUoHMIOZIHle1oWv2tw1JsFBRCQ7R6HGrA0W4H3VHELsrJU9gmHqYAp459UP5qE943HJWzf6SrDv6/x2RfR1/xIAqYY/euZPjay0q6AjhB4dP2kVjljfhkjtz6RFmRTo6HpKRnUz4JdKfwXy4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=Yac5ezxt; arc=fail smtp.client-ip=52.101.72.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q/HDzStQVxds25dzBmSQgT/lOXgNui+T1vApeCBUcyM2wg++7xu3hRezY6mNl0Gl9M1p4CMGC2+P5u0x4o+sI4+HMuWGYOum5pXxhq6wYtyS0/AhZWqqQMDxAKYTPDvmf6RpCgbb+7YEitxwdV7YadHbSMoV9sybgEfXomNDHMwkgse1h11timUkK8J3cbxxqAfNciRFN0JeUgiwmJaHADxJcPYBMCj1lkVl826LanIk5UGD6+lBe5QlS/sgp9S0Fl9u1/M++5+WdByo/eUddwmbKmrC1TIPHeVyTwUxVF0waY9BplZCmCBp3RRJSOrYFdVsb6fH/7MYLxWIkJCxPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=86eKZY8UsqJAg8PU+paZvLEf6RQnbBtPGl/dPqew/lM=;
 b=mvMDtv8/B+MWLXbdRmicRwLYGPExNEOzIjrtjfKiCfG1c374g2ZyanlpUozj5NON5Ocbfu3TY6zMVRI2XEbTy6t2iXeTGlqqkKr0CxA6S1a9C90g5BI37eo2rESl72H55VP+CAHo1DdUJIc5gYvwy7KlWIA6AD59oVKATpDzYcnXRnPFs9xqn4tlbCwIFsG+GD6eNfZRHiyHJpWmu+xG7qz5YjxvezkYQeurJvAc0JYB1fGXvdXsHow6oWo2z/4X3FLLSpDrIp1wbqsKwsH+PxfFEyk9D9b37yegxJZQTukbsBGpTH+yfsDHIyRuvWee+d0FC+Eg3c5uEO1fBLWeWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=86eKZY8UsqJAg8PU+paZvLEf6RQnbBtPGl/dPqew/lM=;
 b=Yac5ezxt1D9eG4HTvV0vaUzaezd8fatWKWn3t7/YzxHsip6VdMkpJEYeHSFm4OKMgWg/1blNsfsQAEs83oMMZDR47VVwnJcdgx2SOciXOJiMLjGkFV+0bTBQauKC7wovf/hHnROvjpvvXxO2k5UWQP9FoJOIGrBDEddCjj6Lz71b5ykZMARgzaaXSUMT1AQthh+i3PfM6nkZhDliC236fKANthzyjh7MQjlV9qa1FPxytowX1JaOU7BPBL59H/DtA8QeT+jmJFYa6DBvrGf7wcC2wzpxBwyPXLEd1wxfilsJRZBlG5O2Cl0KmKrqrrQGcxjea63NeWHQ7anGmSjVuA==
Received: from AS4P250CA0015.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:5df::14)
 by DU0PR07MB9116.eurprd07.prod.outlook.com (2603:10a6:10:404::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Fri, 23 Jan
 2026 10:07:36 +0000
Received: from AMS0EPF000001AC.eurprd05.prod.outlook.com
 (2603:10a6:20b:5df:cafe::ce) by AS4P250CA0015.outlook.office365.com
 (2603:10a6:20b:5df::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.12 via Frontend Transport; Fri,
 23 Jan 2026 10:07:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 AMS0EPF000001AC.mail.protection.outlook.com (10.167.16.152) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.3
 via Frontend Transport; Fri, 23 Jan 2026 10:07:36 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id 1132A1C0047;
	Fri, 23 Jan 2026 12:07:35 +0200 (EET)
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
Subject: [PATCH v11 net-next 06/15] tcp: accecn: handle unexpected AccECN negotiation feedback
Date: Fri, 23 Jan 2026 11:07:12 +0100
Message-Id: <20260123100721.42451-7-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260123100721.42451-1-chia-yu.chang@nokia-bell-labs.com>
References: <20260123100721.42451-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001AC:EE_|DU0PR07MB9116:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 6a33dd2d-62b5-4b8d-09b3-08de5a673bf6
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?2XTV9Ik0b4AauvNCHF2bEKwoFYEqdc3/wKbAniKVICcr3syfFlZRnDz4Jwbb?=
 =?us-ascii?Q?8/PsReN3McSWuSi87UT6bn6Nac+4ci3qoFpWTFW5Cgf55qdeutoQlNuYhdt2?=
 =?us-ascii?Q?8tydxbqc6d1O0BlBtTn8N79A9OKlY+bL6wAT7Ynl2VaYkT4PrFk3ktglCgTq?=
 =?us-ascii?Q?eAteIudSDHoUZhsiWmW96cm2y1KYji4j1GpYZmFDotgilfeGMVIJIoDsN62V?=
 =?us-ascii?Q?6XzQem57kmdGtJ8D4FWm64BGOY6y8N9XJqcnf0m/9bS8UoEOUPU9MLTATQa7?=
 =?us-ascii?Q?hTYeYMrCUIJFfcZ9GZ+kMzGo/OblMhbSJzytQk6e8kxzJX/AKOkaoSHJU/i/?=
 =?us-ascii?Q?Jjhlnygi3xIxl3+ToI5OAbu1+rl6OnhlCpwzHNmjA2USL3pPruOAhDS94uH5?=
 =?us-ascii?Q?QuyE4Ntk1Y1+FdfpcJi5+KpXg3OF4ahrQV7LkmH+ASWeL2BazUn6e+YrPU+A?=
 =?us-ascii?Q?zfLFt/7e6RNLr666p3zpttqHg80cS8v8qWYubjDhyRthPcQndo3Y9XneFkzK?=
 =?us-ascii?Q?DTZxvuADSBFiHsEcADmsSMGTM7Kuov26qBGryDGkspC7DVZ3pIeW2Y1Iyzgh?=
 =?us-ascii?Q?SnsUYY4PS5/Zb7xVUlKG93NaZ4GmAaqm6rnuQNFuaSQsvZ2Um2MfB2vIRgr1?=
 =?us-ascii?Q?T8CtKJLvEKI8hVaOcR1oba2akSxgLnwKJceIrhFZLiH6CW9dQGaz2hoYR6EL?=
 =?us-ascii?Q?gcEZpdgVANcUL+j5tkFuXMOA12gEPtN06Mmyr3MxgkwEAXUPQt/V4gp1LD1G?=
 =?us-ascii?Q?MlAmetSsuKs/HT4dkG2dLQUyaKMIacsrzawtrbgoYKs5vW8LMJxl3TZjyzBy?=
 =?us-ascii?Q?7WFGZr7sCGeVI1/M5sHeIxxvrrUW8D7CCrvHNUCfKhJT2sTqhVSs5vgOtGyB?=
 =?us-ascii?Q?oA6AIljiuEq7n7daHRts8JJQWArXNidvs9roABCnHP7AaTNGMQt6YTFVtjNS?=
 =?us-ascii?Q?Km8+RDXQFAA5H0fbJEWoJ3q+f2Bz610ckKFsOc6AbXYEvWHmWsnLsef/ABYU?=
 =?us-ascii?Q?ahtRKldhHG97MidWmxmrSmsyd6uD9exNbgmg8rp7fUvCfQxcYXBuRUDaVXM+?=
 =?us-ascii?Q?XKjKPxxma9xsW5mPRgLgsGIK0DEIbrgi7ZYDHIz7hpQMwuI25m9V8q0C9SMu?=
 =?us-ascii?Q?FHilzytKviER4nhVdIfmP9Eq29C1gQ+nZw+hyi/S0x7omgiZ/M8La4+0U4jE?=
 =?us-ascii?Q?8wYlOBrGBTQMWEVlx9pJMywo7TD9ft1ESZUmBDDtgMKQrq7voEHkUgSLALK4?=
 =?us-ascii?Q?jVtqs2tDEYNStFdublWDp0+tGQdjlQb8CQ+EzKUOJ+lCk7BcIWDKhuzis6gy?=
 =?us-ascii?Q?HLd3JLEguEWwS6eJoH6VkyF1Xpsk/0TkwOBwbyq7i8KAJETZcp4yIviqXwHt?=
 =?us-ascii?Q?x1rs9SBpu/V/RnbyFale60DSxeEK2sG/iFOXuIXkhrWstuhCcG6I8zlBUv7N?=
 =?us-ascii?Q?c2GUSj7QyDSsxlOG6HDL+O5XCAw42vf/5ctvsAggj01E/+Jk+DBOxxh5L50T?=
 =?us-ascii?Q?6m1/BbgNYSd9rQOhObwOXMYd0m4D+IPS3XJuHsZb40+rI9XdBGnb+sdii15E?=
 =?us-ascii?Q?XqT4hsWyBOy1pQBeVjGgzEn+ad40zuZnPnAq39t63GuezE1aP/c1t54g5cxj?=
 =?us-ascii?Q?CbRm5FQn8fOaIhPCoUEPZSMV9fkw9yrJ/Er7UXOt6AsTw6c5RKlQF+J7CZlu?=
 =?us-ascii?Q?iWDjeAcfBNEo2QEihsLcc++JtKc=3D?=
X-Forefront-Antispam-Report:
 CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 10:07:36.6363
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a33dd2d-62b5-4b8d-09b3-08de5a673bf6
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AMS0EPF000001AC.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR07MB9116
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nokia-bell-labs.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[nokia-bell-labs.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[34];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252764-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[redhat.com,google.com,nvidia.com,vger.kernel.org,lwn.net,kernel.org,gmail.com,mojatatu.com,networkplumber.org,resnulli.us,davemloft.net,lunn.ch,fiberby.net,nokia-bell-labs.com,cablelabs.com,ericsson.com,apple.com,gmx.at,comcast.com];
	DKIM_TRACE(0.00)[nokia-bell-labs.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nokia-bell-labs.com:email,nokia-bell-labs.com:dkim,nokia-bell-labs.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chia-yu.chang@nokia-bell-labs.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 4258874075
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


