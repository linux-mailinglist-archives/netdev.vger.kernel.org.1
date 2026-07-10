Return-Path: <netdev+bounces-306539-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VkbkM2XhUGpj7AIAu9opvQ
	(envelope-from <netdev+bounces-306539-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 14:11:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 329FB73A923
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 14:11:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=chelsio.com header.s=selector1 header.b=hz+EdIpA;
	dmarc=pass (policy=reject) header.from=chelsio.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306539-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306539-lists+netdev=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4E748306A7EE
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 12:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0AC83F44C4;
	Fri, 10 Jul 2026 12:03:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11020091.outbound.protection.outlook.com [40.93.198.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA55413249
	for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 12:03:31 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783685013; cv=fail; b=UTTSM4NI/eJ5gCtd2NyGBmifri02c2vqGj7Ctqu5n4gMvasezN3+2aUjNaXLI2MBfPOgMonW1Yk0RsLZjd80EHCCZNzglL/iBVIquIiNL3B+fOUMwodp2HOduozslwmVwD3ewdju1oJTwbRsxOck7yOPDj/EWfIJX+smWhG2vnc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783685013; c=relaxed/simple;
	bh=Il9q2g7KO+pYobYwSLOgkQTqUL+ZRqCkwW3NfMBNL1M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iSkJE/E3MNVABjQZ9u7BkPTPJRofqtQ20v3piADy5jFQE3RWGCVkjsb/hjIYWQAA0B0X1RpQoGlfYpBV8LguEjSJpXT69v2ZaU5x/PZtnfriYdaHy7ixwkQvhOV+Wy63AR+auZP4MDshpP42WT/1DyAWyBa3EMjJ6K2dYIjmhGY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=chelsio.com; spf=pass smtp.mailfrom=chelsio.com; dkim=pass (1024-bit key) header.d=chelsio.com header.i=@chelsio.com header.b=hz+EdIpA; arc=fail smtp.client-ip=40.93.198.91
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lh2wucw3ch21AlXqZnTr52WPyhDGw2asMNtSJophoFqslHj+H+RmAb35aiZaboSE5jeaCYKEPDlQ8x459jB8XjbZ/3sdfLhsxp+84mBNeHJ+/u2NDuRGVxHCU6nvujjvCi2CjxHOODMKyAprLNcc/R1vbYUG7yLS/1pesp+Ewy2bJRpSKjnUMgDJU6RoQAMcQOrY1LZNqX8YYvpPNr9SgDwq2dqIkoH3NNRNwi17YAqBjnbXCY0EVXC+joe1jpVpEIfd4XGZRfvweyE0PDL5eWJCIk/MaZNcrLChnuArTt2NJB36K1sCBKwWxGZY41ufew4gMDyk0yr3uF7K67lJOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zo1dUXuAUKgYleqRVuXwRGCOO1xyRbMWthl9CvDau00=;
 b=R/EyO7Xnec9t8l58nQwckN+BAMnMknXNtX+UFeA7fVrUB2W7H9DGLqPJAqY6CFYb5M4PHCcuo+Kbm4wO+RKpqSP779Ftoz0SA5lTrMsAzRTkpgf1UqdQpd6Ea6sRCOPnTU0Ij177OZuabJnZ2fJbAdcbLCn7pfDqHVUB2+albUxoO+Rcprx7S/e2pvUT+W/rKyMENOAZTPYSDZUEEwfHkvwMuUuU4WyyBxrYeeDLpV9xdvWmLreRkEXGW4uuTzR5BzuDZFRR2nrn0mRHB+I1HaQeAFEivbQEYO3Uaf7fC3oYFzH69vC2wZXPtkg8JgOgm9WTtJCZs6RBZZ/n14eN0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=chelsio.com; dmarc=pass action=none header.from=chelsio.com;
 dkim=pass header.d=chelsio.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chelsio.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zo1dUXuAUKgYleqRVuXwRGCOO1xyRbMWthl9CvDau00=;
 b=hz+EdIpALqMmNagFpfApG5UIxtwUAZL3ieQo7OrC1PcINlbx/lqjWx7mlEgeF2eSEiKiA049DooS3Ins2I+8xqONeJKMbfIbToFgGODAu4vG0M5jw3T1HwImVrcezntMCxT5uCiWgNU5ASBC9AYHj5fR1tV1HXtigwn4AUMby2M=
Received: from IA1PR12MB6188.namprd12.prod.outlook.com (2603:10b6:208:3e4::6)
 by SJ0PR12MB6904.namprd12.prod.outlook.com (2603:10b6:a03:483::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.18; Fri, 10 Jul
 2026 12:03:27 +0000
Received: from IA1PR12MB6188.namprd12.prod.outlook.com
 ([fe80::e933:4d1e:8759:e9a0]) by IA1PR12MB6188.namprd12.prod.outlook.com
 ([fe80::e933:4d1e:8759:e9a0%6]) with mapi id 15.21.0181.009; Fri, 10 Jul 2026
 12:03:26 +0000
From: Harsha Mahadeva <h.mahadeva@chelsio.com>
To: Paolo Abeni <pabeni@redhat.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "davem@davemloft.net"
	<davem@davemloft.net>, "kuba@kernel.org" <kuba@kernel.org>,
	"edumazet@google.com" <edumazet@google.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, Potnuri Bharat Teja <bharat@chelsio.com>
Subject: Re: [PATCH net v2] cxgb4: flower: fix 802.1ad VLAN TPID matching in
 tc flower filters
Thread-Topic: [PATCH net v2] cxgb4: flower: fix 802.1ad VLAN TPID matching in
 tc flower filters
Thread-Index: AQHdCd5BGQATcD2K/kKiqREETdqvHbZk/GQAgAGuyhw=
Date: Fri, 10 Jul 2026 12:03:25 +0000
Message-ID:
 <SJ1PR12MB6194334229FE44C480CB919B97FD2@SJ1PR12MB6194.namprd12.prod.outlook.com>
References: <20260702044955.20119-1-h.mahadeva@chelsio.com>
 <20260709094816.114720-1-pabeni@redhat.com>
In-Reply-To: <20260709094816.114720-1-pabeni@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB6188:EE_|SJ0PR12MB6904:EE_
x-ms-office365-filtering-correlation-id: 03bad1a4-ac09-47f2-7096-08dede7b3f86
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|22082099003|18002099003|56012099006|5023799004|4143699003|3023799007|38070700021|6133799003;
x-microsoft-antispam-message-info:
 Iw/2rHQ4QA24rieIiYkFgYwd/35+B2Kih86xajG7lT+MALFHfFBkEML62vuN9SyuoRvagsyh6fWMhJpYi/NnsPpeGg6lZ1ch4ZiOpSkAgBI2DFG1hr4LX75JlNPPQ2x1GK41lP+Mq7t7hRHQ+vB2YZ6V8Gwsd+ib9PFTHkUay+IsXoFgoMk+sF70XMr6QbZVxcirqdPl+kVt7GqdEpHxxq9spZyIS7Axnw2stCJpWn1QvIbnQeOhlMyapXFyRmlztEpsNAAjC8zGufhpSm94GVe3OYUbdr+aDgUM2dZXonAFWrKiI9xmx/Ca8vzYcHq0OrWwvCrzW95G4uJvjqagCdj21vV6q5PtnmgIXtnE6K2uP4sdKLv/d44fmlcwu/ofD6eBSypiFei9uKBafxGb+u4QO74WTsEDgWlVAucMFHB29XdyDEzaLkukcZhi8J2c4hjNuoLv3eWLTBsCyIQI7J2jYPSpJesvLKE1k17Tp9Czylvya3jP6pgcBm+YvoujEKzXtj9IJdWJDzvEkZdYBFmZ1R7r+mhgQqz3yA9xQmdEvIqlO2BWpikLQBZ3/4UT6BqS4E4ZeqamHEy4KlQxnVZKBSU5pDIYoGM0o96CvsxqTi3nTXGOM3UQw3IgTUkpYZ9/EJXQe5fGEhG4KBgk2AzJRB9gmzM9LtPomFlIqoA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6188.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(22082099003)(18002099003)(56012099006)(5023799004)(4143699003)(3023799007)(38070700021)(6133799003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?XG+ol5vkmLldrCAomf563AaN3Unwr3gSM86H2VDqlp7yXa4JXy9mnx3cl0?=
 =?iso-8859-1?Q?xqLAxPnRGEFSv+WMt3qALWoJLx90Flvz0MInK5yTwITRtI/Kx3h6zPy0Az?=
 =?iso-8859-1?Q?gqzDs/TaHza46CHDkNHxjg3/PVoIEP/9bkCWviA6OXsxu4YdM/cNoCHVvR?=
 =?iso-8859-1?Q?YgXgxGlmA3y3HJ7AChIjdktvbLFvMwM5fyT8S0+UptXz1HSPrc9Yd0sUpq?=
 =?iso-8859-1?Q?/5tmKZ2Gpu4a9/guut1ZnTpYZwgo5cRVh4Kc2tq8awEwwmxZkVEjL8gRmo?=
 =?iso-8859-1?Q?Qte+kTGwfrb9Nl9PE5OmVjySMeFvRYe30Z3yViz5YgrAMfTS7Q0fxfRMgI?=
 =?iso-8859-1?Q?KzD2ERh+YJf4Q2hA8/UAo9l6OFZBnq0WC/ju4IXrJiyjOCardv9KVPGcJ2?=
 =?iso-8859-1?Q?NhlLRXypUtDZ9tThNgfqLPyf56bIH48BxvrtId5iKOxB2vupodkZDjbfjB?=
 =?iso-8859-1?Q?fbIRTdAVqAiIeZr7uiHr8LKcgGtGCt5lasxSXwNbTZyXd41OMyle60QK9L?=
 =?iso-8859-1?Q?foQKBtVaEQdOCrV22bX+aMypJyRoAP2NUPufSnYYANDMuOLeCPoKH+V1BO?=
 =?iso-8859-1?Q?RYBfy9LxAq3RcypIU8O/NiSFZ9VSCvalVRnRgIABZihy/IpBD/pw2ChD02?=
 =?iso-8859-1?Q?BRuQSALWJh5A+/88quM3hEYbhRhlgG6LvzCFGAduNEG+zhHVP8/SXR6uYy?=
 =?iso-8859-1?Q?cxvkiUhQGQEJlfy6qt5ut44YDS1iCVSIV7xf1V59GL+Su5u3M5sg6kSbVn?=
 =?iso-8859-1?Q?bBFicN88Za0bVrdrPtfizZnHWF0mozyEGh7L2EaoYS0cznlS/0R0s271gx?=
 =?iso-8859-1?Q?xQMgluO5L5G2JP5btlD0uc4FkZadIdOJe9ug3vDgQzTHEi9IhY7weN4DG3?=
 =?iso-8859-1?Q?MA/HQdukxANY19QhlhnMCNHJXPy0sjRFwy2j3+CWlmvA4MJHsgdivNj0TU?=
 =?iso-8859-1?Q?J49wK1cjjxIoPwbu7yaMqJViimqv+WeznQ4vXi5YNXUxQPrDMizykS/8pK?=
 =?iso-8859-1?Q?1cthIHCaALKcDYOScbLA6yMwanwnIDKZFfqfu01/2lV5hSOVPtE5+p3XhA?=
 =?iso-8859-1?Q?vGjCz8jFYVqBgeODs4BWo0NqtODRNq6fiG5kn6LwbRriAOIuYw7bj2/+SX?=
 =?iso-8859-1?Q?hbQf6qNIPWFigkGVTUvCMPFDmEVGXg1Ncitq9qzfS1BIquje+9pflhXLUz?=
 =?iso-8859-1?Q?loVbq6fOGjO+PLo2Fp4NEAbETq9sKP0ufnc4cUJpjmlzvuZf+xDVCcFq8G?=
 =?iso-8859-1?Q?wGpp19/ThSTRXLm/50hlls1h4othF6Aijk1vVCvpXcGKNHe9/jeadwlAo4?=
 =?iso-8859-1?Q?O01F7MWcZFEVcInHv2JTRgY122lvjQ/+5OGY6TO6NPM5qEXQQ6+RzmAZez?=
 =?iso-8859-1?Q?k+lfoto+lN1sQKTebAIni39wtYMCf6WANdvLUXLPLuOEl6ziyCsR9q8k8M?=
 =?iso-8859-1?Q?CS0AbDMSrLBQj+Q9nyWuuIWwiP3h2uddc8lH6EH7fCA9PElamHUgQPvbxr?=
 =?iso-8859-1?Q?kE6uGc1usRjK8uSCWk6ddvgExEMsPNEdqLWi+1KMdtSwGqhdVidmIlqNVx?=
 =?iso-8859-1?Q?023f/ww88jsS41yzLrqNOKoN8dzQKGouCuQBR5HYJ2lHuMsFJV/0DNBNxb?=
 =?iso-8859-1?Q?Jt+6GyGfIoKSfxI/Qk4hlxY45mUiViW30FcCWP67IxCUCIbEUvoggNReKa?=
 =?iso-8859-1?Q?4N+e3S7wrKWFfRyRuOKHCLnt/cnMVPQns9wpkoANEhUUDmtLbXXIUKz48+?=
 =?iso-8859-1?Q?41c5PJlB97lEApFipHU+ekqHSPTO3VwlMPA3Pf+Fn5ILYruRC/oQCdyLP1?=
 =?iso-8859-1?Q?OIzXuZGoZw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: chelsio.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6188.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03bad1a4-ac09-47f2-7096-08dede7b3f86
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2026 12:03:25.9438
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 065db76d-a7ae-4c60-b78a-501e8fc17095
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cvUZAvAVlnDEAJg0rOpHZv761KSkz8+wJNLk+cwMth7Tn5r7+n5zuTeWLg2HdJXVXyBXNZZJaLCM+BO/mj2UL4P5DvXl8tKENyhQ+tMn/V4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6904
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[chelsio.com,reject];
	R_DKIM_ALLOW(-0.20)[chelsio.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-306539-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:kuba@kernel.org,m:edumazet@google.com,m:andrew+netdev@lunn.ch,m:bharat@chelsio.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER(0.00)[h.mahadeva@chelsio.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[h.mahadeva@chelsio.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[chelsio.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,linux.dev:url,chelsio.com:from_mime,chelsio.com:dkim,SJ1PR12MB6194.namprd12.prod.outlook.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 329FB73A923

On Thursday, July 07/09/26, 2026 at 15:18:16 +0530, Paolo Abeni wrote:=0A=
> From: AI Reviewer <ai@example.com>=0A=
> =0A=
> This is an AI-generated review of your patch. The human sending this=0A=
> email has considered the AI review valid, or at least plausible.=0A=
> Full review at: https://netdev-ai.bots.linux.dev/sashiko/=0A=
> ---=0A=
> cxgb4: flower: fix 802.1ad VLAN TPID matching in tc flower filters=0A=
> =0A=
> This patch adds an 802.1ad branch to cxgb4_process_flow_match() that=0A=
> programs a port-specific OVLAN register with ETH_P_8021AD, sets bit 0=0A=
> of the RX control register, clears bit 9 of TP_INGRESS_CONFIG, and=0A=
> populates the filter's outer-VLAN match fields.=0A=
> =0A=
> A few questions about the new code follow inline.=0A=
=0A=
Hi Paolo,=0A=
=0A=
Thank you for taking the time to review the patch. Please find my responses=
 inline below.=0A=
=0A=
> =0A=
> > diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_flower.c b/dri=
vers/net/ethernet/chelsio/cxgb4/cxgb4_tc_flower.c=0A=
> > index 3307e5042681..8c5cfa6982e7 100644=0A=
> > --- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_flower.c=0A=
> > +++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_flower.c=0A=
> > @@ -266,24 +267,48 @@ static void cxgb4_process_flow_match(struct net_d=
evice *dev,=0A=
> >  					       VLAN_PRIO_SHIFT);=0A=
> >  		vlan_tci_mask =3D match.mask->vlan_id | (match.mask->vlan_priority <=
<=0A=
> >  						     VLAN_PRIO_SHIFT);=0A=
> > -		fs->val.ivlan =3D vlan_tci;=0A=
> > -		fs->mask.ivlan =3D vlan_tci_mask;=0A=
> > -=0A=
> > -		fs->val.ivlan_vld =3D 1;=0A=
> > -		fs->mask.ivlan_vld =3D 1;=0A=
> > -=0A=
> > -		/* Chelsio adapters use ivlan_vld bit to match vlan packets=0A=
> > [ ... ]=0A=
> > -		if (fs->val.ethtype =3D=3D ETH_P_8021Q) {=0A=
> > -			fs->val.ethtype =3D 0;=0A=
> > -			fs->mask.ethtype =3D 0;=0A=
> > +=0A=
> > +		if (match.key->vlan_tpid =3D=3D cpu_to_be16(ETH_P_8021AD)) {=0A=
> =0A=
> [Medium]=0A=
> The gating condition consults only match.key->vlan_tpid and does not=0A=
> look at match.mask->vlan_tpid.  In tc-flower semantics a key value is=0A=
> only significant to the extent the mask covers it.=0A=
> =0A=
> If a rule sets key=3D0x88a8 with mask=3D0 (don't care about TPID), this=
=0A=
> branch is still entered and the adapter registers are still=0A=
> reprogrammed.  Should this test be gated on the mask as well, similar=0A=
> to how mlx5 and nfp consult the mask before honoring the key?=0A=
> =0A=
This programming is per port configuration rather than per-filter state. =
=0A=
The TPID value is used to configure the port's OVLAN parsing behavior, =0A=
and the corresponding hardware register uses a fixed mask of `0xffff` =0A=
regardless of the mask supplied in the tc-flower rule. As a result, the int=
ent =0A=
here is to select the port's outer VLAN TPID based on the requested TPID va=
lue,=0A=
rather than to honor per-rule TPID masking semantics.=0A=
> > +			struct adapter *adap =3D netdev2adap(dev);=0A=
> > +			u32 ovlan_reg, ctl_reg, val, port_id;=0A=
> > +=0A=
> > +			if (!adap) {=0A=
> > +				netdev_err(dev, "%s: adap not found\n", __func__);=0A=
> > +				return;=0A=
> > +			}=0A=
> =0A=
> [Low]=0A=
> netdev2adap() expands to netdev2pinfo(dev)->adapter and is not expected=
=0A=
> to return NULL for a netdev that tc-flower can bind to.  If the check=0A=
> ever did fire, cxgb4_process_flow_match() is void, so this early return=
=0A=
> also skips the trailing:=0A=
> =0A=
>     fs->val.iport =3D netdev2pinfo(dev)->port_id;=0A=
>     fs->mask.iport =3D ~0;=0A=
> =0A=
> and cxgb4_flow_rule_replace() would proceed to install a filter with=0A=
> iport=3D0 / iport_mask=3D0.  Should the check either be removed, or the=
=0A=
> function refactored to propagate an error?=0A=
=0A=
Yes , `netdev2adap()` is not expected to return `NULL` for a valid cxgb4 ne=
tdev. =0A=
I'll remove this check in the next revision=0A=
> =0A=
> > +=0A=
> > +			val =3D (0xffff << 16) | ETH_P_8021AD;=0A=
> =0A=
> [Low]=0A=
> The literal 0xffff has type int (signed), so 0xffff << 16 evaluates to=0A=
> a value that is not representable in a signed int.  Per C11 6.5.7 this=0A=
> is undefined behavior and UBSAN's shift sanitizer flags it.  Would=0A=
> 0xffffU << 16 (or a symbolic _V()/_M() macro) be preferable?=0A=
> =0A=
> The layout of MPS_PORT_RX_OVLAN0_A ([31:16]=3Dmask, [15:0]=3Dvalue) is al=
so=0A=
> not expressed through the driver's usual _S/_V/_F/_M helpers used by=0A=
> neighboring registers.  Could symbolic field macros be added?=0A=
=0A=
I'll switch to using an unsigned value and add symbolic field macros in the=
 next =0A=
revision to match the existing register definition style.=0A=
> =0A=
> > +			port_id =3D netdev2pinfo(dev)->port_id;=0A=
> > +			fs->val.ovlan =3D vlan_tci;=0A=
> > +			fs->mask.ovlan =3D vlan_tci_mask;=0A=
> > +			fs->val.ovlan_vld =3D 1;=0A=
> > +			fs->mask.ovlan_vld =3D 1;=0A=
> =0A=
> [High]=0A=
> Does this ovlan programming survive on adapters that have VNIC_F set in=
=0A=
> the cached ingress_config?  In cxgb4_filter.c, both __cxgb4_set_filter()=
=0A=
> and cxgb4_set_hash_filter() unconditionally do:=0A=
> =0A=
>     if (adap->params.tp.ingress_config & VNIC_F) {=0A=
>         fs->val.ovlan =3D (fs->val.pf << 13) | fs->val.vf;=0A=
>         fs->val.ovlan_vld =3D fs->val.pfvf_vld;=0A=
>         ...=0A=
>     }=0A=
> =0A=
> which overwrites the fs->val.ovlan / fs->val.ovlan_vld set here.=0A=
> validate_filter() also rejects with -EOPNOTSUPP when ovlan_vld is set=0A=
> together with VNIC_F, or when the filter mode does not include=0A=
> VNIC_ID_F.=0A=
> =0A=
> On adapters where VNIC_F is enabled, does this branch actually restore=0A=
> matching, or does it silently lose the VID (and, per the next comment,=0A=
> still mutate hardware before failing validation)?=0A=
=0A=
I'll address this issue by moving the register configuration to happen =0A=
after validate_filter() and install succeeds, rather than at cxgb4_process_=
flow_match() time =0A=
as it does now. That way, if validate_filter() rejects the filter including=
 the =0A=
-EOPNOTSUPP case you mentioned,  the hardware registers are never touched =
=0A=
in the first place, since we bail out before we get anywhere near programmi=
ng them=0A=
> =0A=
> > +			ovlan_reg =3D PORT_REG(port_id, MPS_PORT_RX_OVLAN0_A);=0A=
> > +			ctl_reg =3D PORT_REG(port_id, MPS_PORT_RX_CTL_A);=0A=
> > +			t4_write_reg(adap, ovlan_reg, val);=0A=
> =0A=
> [High]=0A=
> cxgb4_process_flow_match() is called from cxgb4_flow_rule_replace()=0A=
> before __cxgb4_set_filter() runs validate_filter() and the mailbox/L2T=0A=
> install.  Do these three writes need to be deferred until after=0A=
> validation and successful install, so that a filter rejected by=0A=
> validate_filter(), or one that fails allocation/mailbox/L2T setup,=0A=
> does not leave the port and adapter in a reconfigured state with no=0A=
> installed filter to justify it?=0A=
=0A=
will move the register writes to run after validate_filter() and successful=
 install, so =0A=
a filter that's rejected or fails allocation doesn't leave the port/adapter=
 reconfigured =0A=
with nothing installed to justify it=0A=
> =0A=
> Additionally, clear_filter() (cxgb4_filter.c) only tears down L2T/SMT/=0A=
> CLIP and memsets the filter entry.  It does not undo MPS_PORT_RX_OVLAN0,=
=0A=
> MPS_PORT_RX_CTL bit 0, or TP_INGRESS_CONFIG bit 9.  Is a corresponding=0A=
> teardown expected on filter delete/replace so that 'tc filter add' +=0A=
> 'tc filter del' does not leave OVLAN matching permanently enabled and=0A=
> TP_INGRESS_CONFIG bit 9 permanently cleared?=0A=
=0A=
Yes, this needs teardown handling. Since these are per-port registers rathe=
r than =0A=
per-filter state, we can't simply undo them on every individual filter dele=
te another 802.1ad =0A=
filter on the same port may still depend on that configuration. I'll add a =
per-port reference count =0A=
of installed 802.1ad/ovlan filters, incremented when one is installed and d=
ecremented in clear_filter() =0A=
when one is removed, and only restore MPS_PORT_RX_OVLAN0, MPS_PORT_RX_CTL b=
it 0 and =0A=
TP_INGRESS_CONFIG bit 9 to their original state once that count reaches zer=
o=0A=
> =0A=
> MPS_PORT_RX_OVLAN0_A is also hardcoded to slot 0 with ETH_P_8021AD as=0A=
> the TPID.  How is a second concurrent flow rule requesting a different=0A=
> outer TPID intended to be represented, given that installing it would=0A=
> clobber slot 0?=0A=
=0A=
Currently we only support ETH_P_8021AD as the outer TPID there's no intent=
=0A=
right now to support multiple outer TPIDs concurrently on the same port, si=
nce =0A=
only a single slot (MPS_PORT_RX_OVLAN0_A) is used. I'll add an explicit che=
ck =0A=
so that if a second flow rule requests a different outer TPID while one is =
already =0A=
active on the port, it's rejected  instead of silently clobbering slot 0=0A=
> =0A=
> > +			val =3D t4_read_reg(adap, ctl_reg);=0A=
> > +			t4_write_reg(adap, ctl_reg, val | 1);=0A=
> =0A=
> [High]=0A=
> This RMW on MPS_PORT_RX_CTL_A is unserialized.  If another context=0A=
> modifies other bits of the same register between the read and the=0A=
> write, that update is lost.  Is there a lock that should be held here=0A=
> (win0_lock or similar)?=0A=
> =0A=
> > +			t4_tp_wr_bits_indirect(adap, TP_INGRESS_CONFIG_A, 1U << 9, 0);=0A=
> =0A=
> [High, Medium, Medium]=0A=
> t4_tp_wr_bits_indirect() drives the TP_PIO_ADDR_A / TP_PIO_DATA_A=0A=
> indirect-register pair:=0A=
> =0A=
>     void t4_tp_wr_bits_indirect(struct adapter *adap, unsigned int addr,=
=0A=
>                                 unsigned int mask, unsigned int val)=0A=
>     {=0A=
>         t4_write_reg(adap, TP_PIO_ADDR_A, addr);=0A=
>         val |=3D t4_read_reg(adap, TP_PIO_DATA_A) & ~mask;=0A=
>         t4_write_reg(adap, TP_PIO_DATA_A, val);=0A=
>     }=0A=
> =0A=
> Before this patch the only in-tree caller was probe-time=0A=
> adap_init0_tweaks().  This patch adds a runtime, user-triggerable=0A=
> caller.=0A=
> =0A=
> Can a concurrent TP_PIO user (t4_tp_pio_read/t4_tp_pio_write when LDST=0A=
> is unavailable, register-dump code, or another tc-flower install on a=0A=
> different netdev of the same adapter) interleave between the ADDR=0A=
> write and the DATA read/write and cause the wrong TP register to be=0A=
> read or written?  What serializes the TP_PIO_ADDR_A/TP_PIO_DATA_A pair=0A=
> here?=0A=
=0A=
I will fix above in next revision .Will take locking around the MPS_PORT_RX=
_CTL_A RMW and =0A=
TP_PIO_ADDR_A/TP_PIO_DATA_A sequence in t4_tp_wr_bits_indirect(), so both a=
re =0A=
serialized against concurrent access=0A=
> =0A=
> Separately, the hardware bit is toggled but adap->params.tp.ingress_confi=
g=0A=
> is not updated.  That shadow is consulted throughout cxgb4_filter.c=0A=
> (validate_filter, __cxgb4_set_filter, cxgb4_set_hash_filter) and l2t.c=0A=
> to make VNIC_F / USE_ENC_IDX_F / ovlan-vs-pfvf decisions.  Should the=0A=
> shadow be kept in sync with the hardware write?=0A=
> =0A=
> Also, bit 9 of TP_INGRESS_CONFIG_A is written as the bare literal=0A=
> 1U << 9, while neighboring bits of the same register are exposed as=0A=
> _S/_V/_F macros in t4_regs.h (CSUM_HAS_PSEUDO_HDR_S=3D10, VNIC_S=3D11,=0A=
> USE_ENC_IDX_S=3D13).  What feature does bit 9 control, and could a=0A=
> symbolic name be introduced?  The commit message enumerates three=0A=
> actions (OVLAN register, RX control enable, filter fields) but does=0A=
> not mention this fourth adapter-wide write.=0A=
=0A=
Bit 9 is RM_OVLAN and when its unset, it stops hardware from stripping the =
outer =0A=
VLAN tag. I will add a symbolic _S/_F macro for it (replacing the bare 1U <=
< 9) and =0A=
call out this fourth write in the commit message, and will also update =0A=
adap->params.tp.ingress_config alongside the hardware write =0A=
> =0A=
> > +		} else {=0A=
> > +			fs->val.ivlan =3D vlan_tci;=0A=
> > +			fs->mask.ivlan =3D vlan_tci_mask;=0A=
> > +			fs->val.ivlan_vld =3D 1;=0A=
> > +			fs->mask.ivlan_vld =3D 1;=0A=
> > +=0A=
> > +			/* Chelsio adapters use ivlan_vld bit to match vlan packets=0A=
> > +			 * as 802.1Q. Also, when vlan tag is present in packets,=0A=
> > +			 * ethtype match is used then to match on ethtype of inner=0A=
> > +			 * header ie. the header following the vlan header.=0A=
> > +			 * So, set the ivlan_vld based on ethtype info supplied by=0A=
> > +			 * TC for vlan packets if its 802.1Q. And then reset the=0A=
> > +			 * ethtype value else, hw will try to match the supplied=0A=
> > +			 * ethtype value with ethtype of inner header.=0A=
> > +			 */=0A=
> > +=0A=
> > +			if (fs->val.ethtype =3D=3D ETH_P_8021Q) {=0A=
> > +				fs->val.ethtype =3D 0;=0A=
> > +				fs->mask.ethtype =3D 0;=0A=
> > +			}=0A=
> =0A=
> [High]=0A=
> The preserved comment states that the hardware ethtype field matches=0A=
> the ethtype after the outer VLAN tag (the inner header), and the=0A=
> 802.1Q branch resets fs->val.ethtype/fs->mask.ethtype to avoid a=0A=
> mismatch.=0A=
> =0A=
> The new 802.1ad branch above does not perform the equivalent reset.=0A=
> For a common rule such as:=0A=
> =0A=
>     tc filter add ... flower \=0A=
>         vlan_ethtype 0x88a8 vlan_id X ...=0A=
> =0A=
> FLOW_DISSECTOR_KEY_BASIC processing earlier in the same function has=0A=
> already set fs->val.ethtype =3D 0x88a8, but the ethtype field is matched=
=0A=
> against the inner header (which for real 802.1ad traffic is 0x8100 or=0A=
> an L3 protocol, never 0x88a8).  Should the 802.1ad branch clear=0A=
> fs->val.ethtype / fs->mask.ethtype the same way the 802.1Q branch=0A=
> does?=0A=
=0A=
The preserved comment applies to a single-tagged VLAN packet. I'll rework t=
he logic =0A=
to handle ethtype reset correctly for both the single-tagged and QinQ (802.=
1ad) cases=0A=
> =0A=
> >  		}=0A=
> >  	}=0A=
> >  =0A=
> > diff --git a/drivers/net/ethernet/chelsio/cxgb4/t4_regs.h b/drivers/net=
/ethernet/chelsio/cxgb4/t4_regs.h=0A=
> > index 695916ba0405..38c585f3b1ad 100644=0A=
> > --- a/drivers/net/ethernet/chelsio/cxgb4/t4_regs.h=0A=
> > +++ b/drivers/net/ethernet/chelsio/cxgb4/t4_regs.h=0A=
> > @@ -1921,6 +1921,9 @@=0A=
> >  #define MAC_PORT_PTP_SUM_LO_A 0x990=0A=
> >  #define MAC_PORT_PTP_SUM_HI_A 0x994=0A=
> >  =0A=
> > +#define MPS_PORT_RX_OVLAN0_A 0x120=0A=
> > +#define MPS_PORT_RX_CTL_A    0X100=0A=
> =0A=
> [Low]=0A=
> This isn't a bug, but the hex prefix on 0X100 is uppercase while the=0A=
> line above (and every neighboring macro) uses lowercase 0x.  Was that=0A=
> intentional?=0A=
=0A=
Its not intentional ,I will fix this in next revision.Thanks for flagging i=
t=0A=
> =0A=
> > +=0A=
> >  #define MPS_CMN_CTL_A	0x9000=0A=
> -- =0A=
> This is an AI-generated review.=0A=
> =0A=

