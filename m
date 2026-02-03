Return-Path: <netdev+bounces-256308-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eKDhFCIAgmmYNgMAu9opvQ
	(envelope-from <netdev+bounces-256308-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 15:03:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 573F5DA502
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 15:03:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9320F304B5BD
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 14:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 256783A1A35;
	Tue,  3 Feb 2026 14:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="sYecWXBl"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011026.outbound.protection.outlook.com [52.101.65.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90121BBBE5;
	Tue,  3 Feb 2026 14:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770127352; cv=fail; b=DR9HB5Whrya3fxa5+rAaXE3GZaw5sb/4S3bK8/TIrvh6/ETHABOFAe2eIO2BkWUTajD/wnljQvMSAITN9IZ9kpYoEiOrZ8hGj5U4Mgg4s8t4txdm1Var1hDjTJxEJwNCTEOMWJ8pdNZCFGp1udTgCa0qTOUDtU6Tn8XR9INveyw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770127352; c=relaxed/simple;
	bh=keRvZSXdP2G6zbHdW+RJrT5OYflwieOi4sw57PDqoBw=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Gww+VKI+wgpJibF2cZRykAelIUzbirwZJpWsz0RUMeYgNLiwn6yhu8lPzLyv6tZVxhcLnzhaJIJ5/+BVh3ZedqfXExRO/ln24abpcjqEd+I8i95avug+trSYlJN7KieF1WNzmNIfmDcUC1ewc8e4VN5lgGnYOBK/rZjQQ3DRpSk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=sYecWXBl; arc=fail smtp.client-ip=52.101.65.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hvdHBpvaEiubVdGUlB4azDc3zdhMFp9os38P5h3RhT+3ZPsd87hceyGlzCADRnqSf7tsu5xeph9ZeY1TQCfoI+03uXVS6J3b1wDdFwd3hq45SGgUlld68WUTEJMKJOgy9pMkbcbgWJB/bppDjf75pMllUFUICcRnSdR1PfSfgrF4Kd90o/gX+5/JHnMFvQ+HwVtfEOwH/p3vq9CdXKBx/KomK/JKhpl4A//TtX/PV99AuhcaCVofHKCjUXRAtZtBhWMdmQu9+8mjiFavGz6aXjFc8/FspvRnE/pmkOqqeVKVs7OLweUYIO4mr2j+2GUKWuQnCP972lu1PmfT5Qxlmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=keRvZSXdP2G6zbHdW+RJrT5OYflwieOi4sw57PDqoBw=;
 b=PjWQXboX3Bx2ouUdMe2oOJ+QaDGTrnUllIVgzscOE+G/e8i1JiCKKBuU85tBvk7D9rBn7fsrmTZQ6jy5JJ+GvgTLkMuP6miwOVOVbevdyPQgd/eMd5q6UGdZt3kOxHJwOi4WuRPstCQS8/4zGgOLgrWW6BAGfNEC33KsS3Qc3JT5Z+MFgttpuSGIYbjOGRza0wIMpzLBsoEYAfGMTVKpm+m7IofdScdn2H906HIn0qnTuVQ3PuMMG0tBq3091Msu5kg+UrWVC/3cq9A3SBYwJbts3+a+qZ3Naz/ob4uIzaiooR8Kim+FIvFDJK7yr4CHsY98M/BJ9l5Njp9JotLCbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass action=none
 header.from=nokia-bell-labs.com; dkim=pass header.d=nokia-bell-labs.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=keRvZSXdP2G6zbHdW+RJrT5OYflwieOi4sw57PDqoBw=;
 b=sYecWXBlXNaJH2EM3+eZAYHFlWjAh/ZZ61kKYBMlm+g6SSKA4/gN7hqAGZLMtxL1wtb21dPIwo/jqqKQGXbohunTVpJoYYewQZzBJZpi3Z0ZEqi0XiDC9ztPxfYEzVp7pmt9DoxZ2dA7bUw7LbIwoRp/S5WGSYtLPsJk1DXJS/+c64YvKG7eACckCFwX9p3eHyXDkRsonvROiqY5bLP4K42qKDnIf7OV2gImTcl1E1dMrFl8Wb1yy6iAHmz0h45PTLm8soewxo3evAxQhNuwzAEi8OnJ4xX/22GPXVdP6IMD87Q0VoBlAwjvHJTlzckFMKoweHE6g6I9wP+Ds414Xw==
Received: from AS8PR07MB7973.eurprd07.prod.outlook.com (2603:10a6:20b:396::12)
 by AS8PR07MB7144.eurprd07.prod.outlook.com (2603:10a6:20b:25e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 14:02:24 +0000
Received: from AS8PR07MB7973.eurprd07.prod.outlook.com
 ([fe80::2572:d79:2e5f:7a3c]) by AS8PR07MB7973.eurprd07.prod.outlook.com
 ([fe80::2572:d79:2e5f:7a3c%6]) with mapi id 15.20.9564.010; Tue, 3 Feb 2026
 14:02:24 +0000
From: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>
To: Paolo Abeni <pabeni@redhat.com>, "edumazet@google.com"
	<edumazet@google.com>, "parav@nvidia.com" <parav@nvidia.com>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "corbet@lwn.net"
	<corbet@lwn.net>, "horms@kernel.org" <horms@kernel.org>, "dsahern@kernel.org"
	<dsahern@kernel.org>, "kuniyu@google.com" <kuniyu@google.com>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "dave.taht@gmail.com" <dave.taht@gmail.com>,
	"jhs@mojatatu.com" <jhs@mojatatu.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"stephen@networkplumber.org" <stephen@networkplumber.org>,
	"xiyou.wangcong@gmail.com" <xiyou.wangcong@gmail.com>, "jiri@resnulli.us"
	<jiri@resnulli.us>, "davem@davemloft.net" <davem@davemloft.net>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "donald.hunter@gmail.com"
	<donald.hunter@gmail.com>, "ast@fiberby.net" <ast@fiberby.net>,
	"liuhangbin@gmail.com" <liuhangbin@gmail.com>, "shuah@kernel.org"
	<shuah@kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "ij@kernel.org" <ij@kernel.org>,
	"ncardwell@google.com" <ncardwell@google.com>, "Koen De Schepper (Nokia)"
	<koen.de_schepper@nokia-bell-labs.com>, "g.white@cablelabs.com"
	<g.white@cablelabs.com>, "ingemar.s.johansson@ericsson.com"
	<ingemar.s.johansson@ericsson.com>, "mirja.kuehlewind@ericsson.com"
	<mirja.kuehlewind@ericsson.com>, "cheshire@apple.com" <cheshire@apple.com>,
	"rs.ietf@gmx.at" <rs.ietf@gmx.at>, "Jason_Livingood@comcast.com"
	<Jason_Livingood@comcast.com>, "vidhi_goel@apple.com" <vidhi_goel@apple.com>
Subject: RE: [PATCH v13 net-next 00/15] AccECN protocol case handling series
Thread-Topic: [PATCH v13 net-next 00/15] AccECN protocol case handling series
Thread-Index: AQHckwB9GaK6k4C2cESQkI7GR1+dbrVw8V4AgAASmxA=
Date: Tue, 3 Feb 2026 14:02:24 +0000
Message-ID:
 <AS8PR07MB797343EB84069170ACCFAE08A39BA@AS8PR07MB7973.eurprd07.prod.outlook.com>
References: <20260131222515.8485-1-chia-yu.chang@nokia-bell-labs.com>
 <7df9baf9-040f-41ae-b292-f3155842b5f4@redhat.com>
In-Reply-To: <7df9baf9-040f-41ae-b292-f3155842b5f4@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-bell-labs.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR07MB7973:EE_|AS8PR07MB7144:EE_
x-ms-office365-filtering-correlation-id: 5911f2a3-715f-4334-24d6-08de632cdb97
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700021|921020;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?oGsMRVNMmo3g4QxUtduAd0/70elcWQvlngpY+KQq/WyZkiQTm5RaQ3j/rq45?=
 =?us-ascii?Q?yF9F6GW6/8jrCB96fQIwk6RXNAn8sTOnB+zUOU5VtLKVlR1fvZvfVCbsxj7F?=
 =?us-ascii?Q?YpwfNGVdNGRT5AVd81NSREI5z6EsbOQgvESYQjd5eRgkkdcxD72wMOXtVtnW?=
 =?us-ascii?Q?Mr0lFwA9ABi9GwffPq9zDHhgUXxZeShl3NfxQPW1ctdxq7IMJgfSdUyLWg72?=
 =?us-ascii?Q?cYyXk047VZY4xn6D+kqEsxottw06tKIpW197AmIC7zGQ5W4YB+lSCcQ+2E6v?=
 =?us-ascii?Q?SrYY1M1W6NiDh4fYsJPQnxvgasUXDJDX8koFjiJeMMfbVKyqk/ayelQIuhHi?=
 =?us-ascii?Q?Ild+Gtzjw9lvgOX9lwXnK7QNIzQUrYweIRMYf/eDctc1/Lds4E4ycrx1dkny?=
 =?us-ascii?Q?tATRIqm5Ml7KZVEM7WLGGA4b5BLjDToJ5ukq8KKiHlRVhKTLj5IcweiJSPh2?=
 =?us-ascii?Q?MEOVsTjNGh5wIiDtp1uULsE+pjNvgRQK2fNiIB1oA53x56ZU480plOEXu+Nr?=
 =?us-ascii?Q?WjWF4A4p/ZQnqy6CE45TntjrNUVX0rwXEh1E+G/lTtmN7/DKaYbCAWv111JF?=
 =?us-ascii?Q?9yGppFx5MXosiv5HkvE9CmJKRgFUiwyXSoa+IV/FTj/SX1/qjmqpDeonyJh2?=
 =?us-ascii?Q?0IM44v85HtvIGyq2JPftjD6yG4J5kmgM0StvzbysAWfHES6iN81S92qGB/Dv?=
 =?us-ascii?Q?wy2pdordG+0mOp4E6W+3b0xLdHoTX8naO3SdQiF+aVsEq0zA93H0s/xmd51a?=
 =?us-ascii?Q?it2EaCEB9r3g9KVNFY4d416ZvCpW3SxqH7HwHVsM4V/faJSwdKeWi2q3wOL4?=
 =?us-ascii?Q?Csd9oPbKQ7idz0yLiHJuj+DWYkghkzczhAb58Q9NHCwgV1dVyZM/SHOpLWk2?=
 =?us-ascii?Q?836m68gzcal9VmHDtqauCIxxRHJBcuLnneJVgCeWD9/Yb2YwbfV3UoxoNWay?=
 =?us-ascii?Q?AtE3UWqljPEa2l3FqOHpxkQFJm6GMZwWK++r4NgkFrmSSrJRwvMcUNk66RCF?=
 =?us-ascii?Q?JhGIjtP3KEKlE867Zuf5acJK5AbF2dUxhRRyGS+/1/37Pvp87RjtALbl3gds?=
 =?us-ascii?Q?0QVAQUhi/FqmxKjsFhXJ7yzcbSmQqgg2E4kP/bLnbxRtwUalqLBi6VGLzwcs?=
 =?us-ascii?Q?SFgzjJg+O3FKyJ4m4+rG4n4JdBQNUueBpjk/UL2eBpUUTqYj5ZZQsHz74WDx?=
 =?us-ascii?Q?sgo8IafJ3J1pkcvBTthZp0gvDeTJabWL/zpS6xb6qvGSxnMBVinmnB8bPJjr?=
 =?us-ascii?Q?JCPPdtzUOlfzu4M+AnH78bnlAmO81nHg7mRBp1w8tr412qD+M8fJ6XyJcW8J?=
 =?us-ascii?Q?2YaHmjIeWhgCQaNtCuCP+rHtPBIJRdNxphmYHoKHK8r11hR78eoeY76TQveH?=
 =?us-ascii?Q?iZj8jk8IeGPaFiUEd8wD1p9s9EOwxizqOhwsrlu9gWm3AASdQYirIk5p1xfC?=
 =?us-ascii?Q?UD++BlNI23Aj1BbwaNw+Ae/rCTZUkIAecbuqh6sBD98/dqv64ne4a40rdAYy?=
 =?us-ascii?Q?7LwYnlpZch7aKEJuebm50tFogc+r/2J6v8MXBA7zCLz39IXiQQK2ncsMEWyJ?=
 =?us-ascii?Q?LqvixZrmRndO4nAtWvkpUQ9IBSscZsZ+rluNWgBNH6vN5Tp7cA6oHJKwqGXb?=
 =?us-ascii?Q?nbJrtQb5mWJPYLJE5GQUd9/LCfxHZAyJi+k9suZkAlkH?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR07MB7973.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?qtgr4R8OxhB0YM0DOhZgUXbU+ke0sLvFpGYuiXqkSs9hi61idi//0fCBXdvm?=
 =?us-ascii?Q?BRV/lL5nUj63op3It/aaGeqwGjt8tk6swk/nbwRhTWpviilwfUA8zOAIq+iY?=
 =?us-ascii?Q?eX4zuJRr4rNbqqcL7IGSfQpQRMnY1H21xsOc5g0VZwrDbc5U/UG/iPDOIAna?=
 =?us-ascii?Q?Tdkzcvav2m8ZBAcsXAQwM1KVncF36wAga/LnvLb1hKH/DF7v3mtizWsv6iV5?=
 =?us-ascii?Q?OvovNSvYL1MO13wEWC1CUYyKDuv72nIicZ7MeS7wEEjMMBNG+Wnsw0xZMl+3?=
 =?us-ascii?Q?qBxpyAkNkkDToCRAMDjR8AF6I+pPyKbxXt+z6YF2ryHqUF/7YQKOs99Qxlul?=
 =?us-ascii?Q?DsXsIfujNiVA+x6IOU2cMcEoVvsiQGil20tklBLqyafi94D4dy+C0cpLpXtL?=
 =?us-ascii?Q?2oJ8HOtjEz7zKt8SIjuxCzZkiFPncWnTs134sXSyl+yMHiRWDk3ug2tqP+YP?=
 =?us-ascii?Q?cCmUGPo/SlBvzP8x6oVcD3RQrAKfhT2h5KlPgXAlZTGuhiPbl1naEskkMItz?=
 =?us-ascii?Q?AKCPw+h0+Txmr8AQj8jtpj9ms/qH68HNHR270ijNdjql4NrrNuC0gwgmKJIC?=
 =?us-ascii?Q?cNnAIi1vLL6iwP7vngSuANe0H04P9xVUPNDV3GOZl21Qm7eJQo4XGxroBVt0?=
 =?us-ascii?Q?k5qnyeMb60Iu8F7+ir6byt6k5eMg3H7IyDF5U+lYsMu3CB+ytw4YIF8Szzo+?=
 =?us-ascii?Q?QwLaDHpF3IyaPK1kbToy3tZqY4PhwRXMPckjiw3VpQgJ5m44Ft4p9U7MKyt+?=
 =?us-ascii?Q?kagDjzyawL2nWvbyhJWKtU2Lx3EdVAbT9lZNxo6iIybUtqbNy9B+lVcXhncU?=
 =?us-ascii?Q?mzBioevT7/F10WAwWNDIs78qfG0VsHFmp7TVDLbcTXx3zrZ9NVXchdDmLCRF?=
 =?us-ascii?Q?nkoA5vYFanCRbW3GNNSDFkGSIcaICGEU7yJXkzcKJ0h+S+zIxPchk72uhGnc?=
 =?us-ascii?Q?IfGgGSIuo6jXroNa0jn6loPQ0pOXwbDMvqSCQVZ+IqCwr/naxxwkwc5ni/nq?=
 =?us-ascii?Q?HeoQlqep2Aq0BZQhRl2RuviY1M6DSc+68r/xUVSMiOBLJRf+8RwCeid/a+M3?=
 =?us-ascii?Q?vc5K2PY+RRh56c+kxN/beqGGY+aqzwkoZ+2OgcimQAR4HJdeaxu5OFK5I1eC?=
 =?us-ascii?Q?jhSnbqW5lERkbdyz6gixoCmAk4CQ1IA03ZZ2V30nMsw6hNaXkGWav9amU1R3?=
 =?us-ascii?Q?AUPC73v03AWLZ94ZZrfZjVpn0KILFb62mj/OTfx7Zld926rKWRjlO/Wuq+/9?=
 =?us-ascii?Q?ILT0IhLz84kvDpAzsh/Gh8ZUcjzHikFEofmQWPF5o1kpzF5XQxqIOI+kiuSQ?=
 =?us-ascii?Q?cAMiL5lE8tSi32KMMCMJapzzDePGCIXqK4zFGjWYJCurM4x0qYxKFOJMzkc0?=
 =?us-ascii?Q?tWIeQfAcK6ar+2a6tW1z+34reoqkf7gL/NpKM8Cd8yok0vDVeMcg1SgaCE5Q?=
 =?us-ascii?Q?p4wU8vSl0dV/THmfQr1O7pYK17CzRg619a9ieKAgI9Vuc1/MFUE4ReRDO+Y+?=
 =?us-ascii?Q?K4q7WOzXoXdiU7OmGqIDHW2P9U//5TTtC9zFw1dcxiweLm97Db8+0iIDNy0R?=
 =?us-ascii?Q?nIJdjuo0QTl8HuTA7a2AnvUfcW5N+gr3NIfgv5g21/C+3u5qAXukw4qlnOE9?=
 =?us-ascii?Q?nXzNJn+5WenhlWmtYQ92ng8VgW6PwBr5ISzAmdDQbOvnJkR+R4npeQC5SIeT?=
 =?us-ascii?Q?dWrQB3XUYJaqPJ4TrASbDzBGcpFhI1ejb+Iee8p+uACjneRW7oOsBeqMKWkE?=
 =?us-ascii?Q?yl9yyAQC+4+Enmnx4yws/b5+5WIkzEA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR07MB7973.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5911f2a3-715f-4334-24d6-08de632cdb97
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2026 14:02:24.6791
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TPAf/TEZwzu+REZRfyHCQCrx7D15c+DVKanIEQxFJhdecSfwWLg7qNaShwD/0SFW5dUlT9TAh0FEMAD3j1FiXsjhoN3OnadGG/uQeXPX8e3drfXNUlfMrwa9HmVF6ldD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB7144
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nokia-bell-labs.com,reject];
	R_DKIM_ALLOW(-0.20)[nokia-bell-labs.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256308-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[33];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[redhat.com,google.com,nvidia.com,vger.kernel.org,lwn.net,kernel.org,gmail.com,mojatatu.com,networkplumber.org,resnulli.us,davemloft.net,lunn.ch,fiberby.net,nokia-bell-labs.com,cablelabs.com,ericsson.com,apple.com,gmx.at,comcast.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chia-yu.chang@nokia-bell-labs.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nokia-bell-labs.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 573F5DA502
X-Rspamd-Action: no action

> -----Original Message-----
> From: Paolo Abeni <pabeni@redhat.com>=20
> Sent: Tuesday, February 3, 2026 1:51 PM
> To: Chia-Yu Chang (Nokia) <chia-yu.chang@nokia-bell-labs.com>; edumazet@g=
oogle.com; parav@nvidia.com; linux-doc@vger.kernel.org; corbet@lwn.net; hor=
ms@kernel.org; dsahern@kernel.org; kuniyu@google.com; bpf@vger.kernel.org; =
netdev@vger.kernel.org; dave.taht@gmail.com; jhs@mojatatu.com; kuba@kernel.=
org; stephen@networkplumber.org; xiyou.wangcong@gmail.com; jiri@resnulli.us=
; davem@davemloft.net; andrew+netdev@lunn.ch; donald.hunter@gmail.com; ast@=
fiberby.net; liuhangbin@gmail.com; shuah@kernel.org; linux-kselftest@vger.k=
ernel.org; ij@kernel.org; ncardwell@google.com; Koen De Schepper (Nokia) <k=
oen.de_schepper@nokia-bell-labs.com>; g.white@cablelabs.com; ingemar.s.joha=
nsson@ericsson.com; mirja.kuehlewind@ericsson.com; cheshire@apple.com; rs.i=
etf@gmx.at; Jason_Livingood@comcast.com; vidhi_goel@apple.com
> Subject: Re: [PATCH v13 net-next 00/15] AccECN protocol case handling ser=
ies
>=20
>=20
> CAUTION: This is an external email. Please be very careful when clicking =
links or opening attachments. See the URL nok.it/ext for additional informa=
tion.
>=20
>=20
>=20
> On 1/31/26 11:25 PM, chia-yu.chang@nokia-bell-labs.com wrote:
> > From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> >
> > Hello,
> >
> > Plesae find the v13 AccECN case handling patch series, which covers=20
> > several excpetional case handling of Accurate ECN spec (RFC9768), adds=
=20
> > new identifiers to be used by CC modules, adds ecn_delta into=20
> > rate_sample, and keeps the ACE counter for computation, etc.
> >
> > This patch series is part of the full AccECN patch series, which is at
> > https://eur03.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgit=
h
> > ub.com%2FL4STeam%2Flinux-net-next%2Fcommits%2Fupstream_l4steam%2F&data
> > =3D05%7C02%7Cchia-yu.chang%40nokia-bell-labs.com%7C28d9664ae2ba4bc908b0=
0
> > 8de6322d99f%7C5d4717519675428d917b70f44f9630b0%7C0%7C0%7C6390571985045
> > 13725%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAw
> > MCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdat
> > a=3DLE02CSf%2BwO3EhH844vnsvMN4ToH4FbvnmHNQH2GXKj4%3D&reserved=3D0
>=20
> Beside the just shared feedback, the AI reported a bunch of other stuff t=
hat are not relevant:
> - fixes tags, IMHO not needed since the touched features were just partia=
lly implemented before
> - uapi breakage, already ruled out as irrelevant since the iproute bits a=
re not there yet
> - pktdrill syntax, which is a little inconsistent but AFAICS correct.
>=20
> I'm not sure about the BIT() macro usage in uAPI, which is already a thin=
g in many uAPI exposed headers, but does not look correct. I guess it could=
 be handled with a follow-up, if needed.
>=20
> So the only feedback the could really require a new revision is WRT ECN f=
lags handling on retransmission - and I'm not 110% it needs a new
> revision: please double check it.
>=20
> Thanks,
>=20
> Paolo

Hi Paolo,

Based on another email, if it is suggested to clarify that commit in the co=
mmit message then I can also include other listed issues.

And I would include fixes to packetdrill syntax and fixed to BIT() - which =
might have an issue if someone took only the header without BIT macro.

So, please let me know then I can submit v14 with all three changes, thanks=
.

Chia-Yu

