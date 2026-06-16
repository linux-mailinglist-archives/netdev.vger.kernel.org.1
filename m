Return-Path: <netdev+bounces-299727-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qO6LL7TQMGqBXgUAu9opvQ
	(envelope-from <netdev+bounces-299727-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 06:27:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B5B7D68BE3D
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 06:27:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=altera.com header.s=selector2 header.b=HRfEo+mX;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299727-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299727-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=altera.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 07CBF300B09C
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 04:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 113273CC7E4;
	Tue, 16 Jun 2026 04:27:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011023.outbound.protection.outlook.com [52.101.57.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8963CB2FC;
	Tue, 16 Jun 2026 04:27:03 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781584025; cv=fail; b=A/AbyZARrusT7a7BQOp7gIl2sjuzBEN7e3FmZ5y75MMtV4kPPr3czSxiwM5QcuJou8Gr8fSCMFtBuyyGI+4NpGVa7LkHRl0ysY30nl4EUe354tjcv9Z6i6EMLIOL719OP3/HiJcF0oONzy0G4B160Fz0vVW9puXyiHqtJ8Yh9mU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781584025; c=relaxed/simple;
	bh=puOrLbmmjXHZ5WFNunGVeEuTt9p5pHZcTS8jeegP6lQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DXslaRWRzJaWb2oZHgNkkr33+yxbJGLmMP3SVN0HBV16hKAsdLaxxtx7hBmgyPpEWL/JNQkpa0iZckOvXICe7qUzGK6xS/7nD5PcVTbnySz6D4hBQG4re9EXtgvFN/XxwIJh3fGIQ9lmHcYqAFEhqPTOOk/1ShvpXIks9ff9y8w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=HRfEo+mX; arc=fail smtp.client-ip=52.101.57.23
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KYsvFhtCZWuW2I4OiGPEoCjhgB4Jt/2V0bxHk8RLbdnhgXMRqzQZARBbBxx1Lp95+pRtqViT5BsgNWg820rAxsWT22ZB8P+LhiHO7Z8lf0Bcc3iTHkbRRtQciErW7h/8/NNmGYiHLTw5E6BQb5e1UFbSbuTDF2bTi4acef5IXFHKWl3/a0mVtOBdZmY081/DY3hWWTAicTdF0lXaQVLzHSRb+rMhMwDd7tgW7JDCtBR2NT7VWRg4/w5/fZAOzWgekQX32foFDLzsg8epw0zae1Ki4sydAh7ivXDfBdOh1Phk1iHMDhtUIf4fnYKDjPXZVwmc9uBe2RlU0olFYN/yCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KKtSciYlV8JovYOti5iISY/o1zGHOPNcY3PJ5Tj/A0A=;
 b=BwDo/pwmKZ0Op11C+f1Gudqyk5dowVi5NgREA9hgm1QfH7osPhId/DrBiGxT6my/Yo7MlZctyVwo56baSm/cvRCev12hlaNwGUt9VVbxtKHO5QNxawB0p80PpkOqyxZ3VY7NFxhbar1vCdjHRpexmzWSSwp2F030MXZhnadWyX67CdsJq3/Zuf5h2dt+PedkNvR+hAVrV6HabJDIdRPKneb1EImrZXAeIDzkb/DMRq4NUOa02NGHsAtJhsFvFAWDkogEnewBEeS7wTMo9uuIzYr1cNGWy0H9+w2H/7eIJsEhMYAV5AuEEbgmpmXLL1DxwVT0Z0qkWZz0LGL+EkmoUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KKtSciYlV8JovYOti5iISY/o1zGHOPNcY3PJ5Tj/A0A=;
 b=HRfEo+mXinur3z/X4LgTb28N+3EwlBJN7n4cu3jl+5hSwItqp18v1F/8PpwVkKgfD2ure7KmIemB7Rzw+szIEPRavHReUXFHpWkVwcSErHSlMapzUB3m2mvdRDZm8voDslx6Lzm3PeFfQMjoY/F/Hj/Tyw+oH4pUasLA2qNrlAT5CZOgKFbKAAT8dtwvcDkGRc9qYRij563lisowhvyO1i4nT7hAj39XVvggHtsiy+N14ou3kpSgjpacOYO136hUlLE6hbto/SwWryXl8/INjhWGZ97TIz5XB1bsU9QWINet+GVIN+qCec5X2vPoGMX4mmMhFzY579BoKmROpe3bUA==
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
Subject: [PATCH v3 2/3] net: stmmac: fix l3l4 filter rejecting unsupported offload requests
Date: Mon, 15 Jun 2026 21:26:54 -0700
Message-ID: <20260616042655.7782-3-muhammad.nazim.amirul.nazle.asmade@altera.com>
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
X-MS-Office365-Filtering-Correlation-Id: b06b4517-df02-4dd7-3443-08decb5f80c3
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|55112099003|3023799007|22082099003|18002099003|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	cgZIcFvDrXkLp54//VfuoLxgWwQmCFfXCmXTbRqE0+dORTMUo7HN+LNZXv3OUS9sGfx9/IiSuePYRgovMsmbG+d5QMgSOFj2NsMO5wqEQymX6jTOPCY69Qeilq2ul3D9go/cBP7evHfrD3K6HJziLPtAwFIfw80B0CDrIVkYO8UJLdkFxDPB9rV2E8T51B2FbDlG9/C3tyn+HchTA3s+4wrfN3xbrHJPh5bBkulASy/+zUZHAIOHnBD9eFDQ8CcN8AqSfAVBKhUXbSe99Ugof9ROBM1IIRh94h3vfAxW1yI4PmMSewWa8ZDDWnh/2TBeme+hLEw0C7o83kA7wwmVS+HSl1ZTCK4k2JbhNCJgV1GSN/IWqtZdtntl6K5WXW9OMgXaHTmZbHX7WcNPOuPfI31dVn9QzSrBy4E2UHJZoQSdmj3fwVnHZ5Ny3e4X4JBpkZUQeIlDhU8JprZgZWsXqUOGkS8RzZeGVwZ0ujz1bRivROPX+CH9r98bx1PKHqm4z7XGEzDJHJmBrHraUzEVJTmfW0lXQh1log+bU1rokyZ1YSUvJ7+J5tUCQddIbea/DDm9yli/exurhp0upwaZqZmAiVdF5Sq+veobHvoO1023bYHosh7LFIzntew8v/sM6/Y3O6GMw3cA4+xgqi5Tgm8r6aTW0pKGIjX2ZqfGC4g1K5YIWMYz1ccFEiFmsSoj
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6964.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(55112099003)(3023799007)(22082099003)(18002099003)(56012099006)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xKxs5yGuh4EwhZv/Dp87I55cXr2HLvFVZVK47B9Q3TYxayQV+aKaN5TZzZSY?=
 =?us-ascii?Q?roaoNMvPnXr/0vXyQbARcyRTtm8zKkPsijEZlMgqmOI37SQ2jjOf3G/GJNPn?=
 =?us-ascii?Q?L8pKWVqfXxa9M9Mp80wj0f1wkDo/TAUAtnQoBQJ1c+/Px/UK6V2t5x2g/t9t?=
 =?us-ascii?Q?J8igIfr9fCdBR7kP/Qa1M6KafoskXStWixhDrn0p2XNtqwHJTQoR3Ap737fD?=
 =?us-ascii?Q?LmCdG3rjajd6RW07N7rq+QM5T8ebvQu10VKV1GJOUt+11xyMZYAtwYUOmrg/?=
 =?us-ascii?Q?zmFaLHdo45c4e3KEEnd8DmXwXb7rz8UgHHlgrP0Kk8A4CnjGNHsMxyW+MOJt?=
 =?us-ascii?Q?oSxzJOfSe9LWddO46m0aGe2VuUrctk3f2sUEk31bwZ5JK9zB1wSaF1VgjEeU?=
 =?us-ascii?Q?YncVUwXZcVTSF4MmiLqfuFln2HyF+7/C4k1wmnji11TIQSPr7SDiDtgajMv+?=
 =?us-ascii?Q?+gcnj77yXdnqTSoHV/KqXnboGwmB6nCcDOKhYrcKoyLv1WK9MRl5iPUPkU2f?=
 =?us-ascii?Q?4U5wJOn/dm8Q4TDkO7trcQ09rBgr9licA9hiGCItOZYsJgCGqzYE00Trua8X?=
 =?us-ascii?Q?D6RMAMSSXjaZFX+ph73rZZBtZhI4OkKCGGn8S9Oxi+IMfsnAMb8KZdCZkq+B?=
 =?us-ascii?Q?dKE/24LPjAwP0XHml5zb6T/rT2WC0ztrNFjcGrt0Ao4HsyDPsw+t0+IB2fjR?=
 =?us-ascii?Q?YSG5eyHaeSKdCuspk2nORhhlz5bGPmrvDzZ/wdF+2AXBEC3bkS1rqQERGp2n?=
 =?us-ascii?Q?8NlCCxSnD8hysdpAzMq0a+MtAmnUbwauMRsSUF95kpbg39X4CkvcZ+iNKY8O?=
 =?us-ascii?Q?72kiJQtfEmiJRlM5mqhONcNv3ckopGv/q40u2aey4lxHIlJ5wbzJ18Bx6bx+?=
 =?us-ascii?Q?s0snN5byW+48XYuWIIGBbz2LGaH6Xa/Vt8I2LPCSVd/pb9n8OB9fwyPpFx9i?=
 =?us-ascii?Q?AQExZeg6waSNqScLMhlu/cwH1KtRAdgVvYYPTADKvQ2v4vVa/baR6swWfzH/?=
 =?us-ascii?Q?GVBq9zxm0VaAkg3mEKy3qzN6HXEsNdTtvQtWQbhbooRFhJsKRUHY8XYzcCPK?=
 =?us-ascii?Q?+NVE5fT3C+4upG7AqvKZ5AXyfQCaEhK6Bu0W8vn/sxDE6XIgCUJ8GFKfVt+W?=
 =?us-ascii?Q?WegThsHjyD76MdfmQy4oZNjVIGdGeZaJXS68Q3Q2m/j0nZxBmQxcz/zEGxTd?=
 =?us-ascii?Q?ExUSLX/pJiPvIdYdAdr9oExi0vuyixd3pQL8YqRb7im+pm+fMAPQd+kPowAk?=
 =?us-ascii?Q?QNQO+LBwnHIspF+AKO1CHtJT10FCzdkeyeJniBZ9j+NEA2aabDIt9OGSCArl?=
 =?us-ascii?Q?gAnJn94SpTzzmts3+/oGnyY92PniyXTF7iXt1CfJrTkYZm2Pc+x4xCAoMBTA?=
 =?us-ascii?Q?V2JArkbgeWPbcsPFbuBQHgp2PrgOzY/r/Fg9FLuQ2hPJhr8J8yTIBimGVMWZ?=
 =?us-ascii?Q?jjGBhJldnBE8P1AnJehvIxvA8CLQvBoWVHoVjS7zPk/PA5NVVCW0/TzgtvL7?=
 =?us-ascii?Q?3YysO4OyZiSGuCeA/V8aL6oaKjcAgHIMDGzqeURQW06nEPKs7ubk9g9XWUPn?=
 =?us-ascii?Q?ON8kbL8AWlBcLSSmLZccw4SHciHx3xZ6tUMlpx+t3Hs/TYbaJ4RPYtctP6Lm?=
 =?us-ascii?Q?g07JvFTixyLcYicBLM2pAaLpzlBbAY3f8/PZkps71PmQ2MiX/JBAEM+CDBna?=
 =?us-ascii?Q?7T40YGy9ARCzUYhti71SyKLDoDJpLKjDZn0QJt8v+LedaccRNQu7gM5HWBTF?=
 =?us-ascii?Q?C+RHxUfy4sEMPqlXuhdMYhYz6AHVnL6zYp0GGS0nP2wihD+2iiT/35qLNYyZ?=
X-MS-Exchange-AntiSpam-MessageData-1: RzvcObMMZdm/PQ==
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b06b4517-df02-4dd7-3443-08decb5f80c3
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6964.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 04:26:58.0095
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6AQHvPgXwy9xiaaUyw5fZMPQqKVMhXuLjMcd+qBgOT20xzIzlg9VFjKcPfkeSbiZZ7Nk+ggtc+QRr7kI9oke82YtJVrPyZ5jACozUr7nBX8ETQ9v7OxJZo0O9Uj64n0z/x9fW2qbauPXXCZQv5EdJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB6333
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[altera.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[altera.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299727-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,altera.com:dkim,altera.com:email,altera.com:mid,altera.com:from_mime,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B5B7D68BE3D

From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>

The basic flow parser in tc_add_basic_flow() does not validate match
keys before proceeding. Unsupported offload configurations such as
partial protocol masks, non-IPv4 network proto, or non-TCP/UDP transport
proto are silently accepted instead of returning -EOPNOTSUPP.

Add validation to return -EOPNOTSUPP early for:
- No network or transport proto present in the key
- Partial protocol mask (only full mask supported)
- Network proto is not IPv4
- Transport proto is not TCP or UDP

Each rejection includes an extack message so the user knows which part
of the match is unsupported.

Also propagate -EOPNOTSUPP from tc_add_basic_flow() in tc_add_flow()
by returning it directly rather than using break. The break was silently
discarding the error for FLOW_CLS_REPLACE operations where entry->in_use
is already true, causing tc_add_flow() to return 0 (success) for
unsupported replace requests.

Fixes: 425eabddaf0f ("net: stmmac: Implement L3/L4 Filters using TC Flower")
Signed-off-by: Rohan G Thomas <rohan.g.thomas@altera.com>
Signed-off-by: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
---
Changes in v3:
- Add extack messages to each -EOPNOTSUPP return so users know which
  part of the match is unsupported (Jakub Kicinski)
- Return -EOPNOTSUPP directly instead of break to avoid silently
  reporting success on unsupported FLOW_CLS_REPLACE (Sashiko review)
- Patches 1/3 and 3/3 are unchanged from v2

Changes in v2:
- No changes

---
 .../net/ethernet/stmicro/stmmac/stmmac_tc.c   | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
index d78652718599..14cabe76e53e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
@@ -446,6 +446,7 @@ static int tc_parse_flow_actions(struct stmmac_priv *priv,
 }
 
 #define ETHER_TYPE_FULL_MASK	cpu_to_be16(~0)
+#define IP_PROTO_FULL_MASK	0xFF
 
 static int tc_add_basic_flow(struct stmmac_priv *priv,
 			     struct flow_cls_offload *cls,
@@ -461,6 +462,33 @@ static int tc_add_basic_flow(struct stmmac_priv *priv,
 
 	flow_rule_match_basic(rule, &match);
 
+	/* Both network proto and transport proto not present in the key */
+	if (!match.mask || !(match.mask->n_proto || match.mask->ip_proto)) {
+		NL_SET_ERR_MSG_MOD(cls->common.extack,
+				   "filter must specify network or transport protocol");
+		return -EOPNOTSUPP;
+	}
+
+	/* If the proto is present in the key and is not full mask */
+	if ((match.mask->n_proto && match.mask->n_proto != ETHER_TYPE_FULL_MASK) ||
+	    (match.mask->ip_proto && match.mask->ip_proto != IP_PROTO_FULL_MASK)) {
+		NL_SET_ERR_MSG_MOD(cls->common.extack,
+				   "only full protocol mask is supported");
+		return -EOPNOTSUPP;
+	}
+
+	/* Network proto is present in the key and is not IPv4 */
+	if (match.mask->n_proto && match.key->n_proto != cpu_to_be16(ETH_P_IP)) {
+		NL_SET_ERR_MSG_MOD(cls->common.extack,
+				   "only IPv4 network protocol is supported");
+		return -EOPNOTSUPP;
+	}
+
+	/* Transport proto is present in the key and is not TCP or UDP */
+	if (match.mask->ip_proto &&
+	    match.key->ip_proto != IPPROTO_TCP &&
+	    match.key->ip_proto != IPPROTO_UDP) {
+		NL_SET_ERR_MSG_MOD(cls->common.extack,
+				   "only TCP and UDP transport protocols are supported");
+		return -EOPNOTSUPP;
+	}
+
 	entry->ip_proto = match.key->ip_proto;
 	return 0;
 }
@@ -598,11 +626,7 @@ static int tc_add_flow(struct stmmac_priv *priv,
 		ret = tc_flow_parsers[i].fn(priv, cls, entry);
 		if (!ret)
 			entry->in_use = true;
-		else if (ret == -EOPNOTSUPP)
-			/* The basic flow parser will return EOPNOTSUPP, if a
-			 * requested offload not fully supported by the hw. And
-			 * in that case fail early.
-			 */
-			break;
+		else if (ret == -EOPNOTSUPP)
+			return ret;
 	}
 
 	if (!entry->in_use)
-- 
2.43.7


