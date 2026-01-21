Return-Path: <netdev+bounces-252100-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OHEqLN1TcWkKCQAAu9opvQ
	(envelope-from <netdev+bounces-252100-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 23:31:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9659A5ED2B
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 23:31:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DB1293A4B9D
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 22:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E26B423A81;
	Wed, 21 Jan 2026 22:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="VFTwHWtL"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012065.outbound.protection.outlook.com [52.101.66.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23FEE331A4C;
	Wed, 21 Jan 2026 22:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769034706; cv=fail; b=ilvMpPUE49yODLvW6hLbK0mWdszQbW9O3SBT2BzWI3unT10+dBv2i7NFoPmysXnoAJ6oSFJVFjuZ3HMX2VPNOqFRvFzcqtN/p/oQJqLR4d8bJ3M8h2rFuEMBxPSRfwJvLHeemOIT0Y2Wt3qsreY5q8OKaVZmPaOB/TeLaieAMJA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769034706; c=relaxed/simple;
	bh=fOG/bZo6FPwV0x/u+uu23TkYx9hj2j3CNSbd18Q2HXM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nP4xb/56+EKoXFTdrsDRWZVsSkQyIIzAAuvXHfhr1dxj/wXoW8ArQNyKKPn9C/xknR+pYkNSkT8RFr88KYnlGb0j/4EhfTBvaVkXLk0JvM3VfULhRkrdRQInojtSVov9/zWdt9mwPsRhMewpPwKf3YGzTxGjnUhOReag2Q1ETzA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=VFTwHWtL; arc=fail smtp.client-ip=52.101.66.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J6bKsjwI2JtX/3HXxrBfgqdk7lC7R0zQKT+YtbEuj1zpuuFotuYAHhta59THWz3KRYBk4EZL+c3P2iMV8o+mPyiE+FeMREAmsBmDl6K5ey3ihHexp8WAwsC5SNYnD1a86JKjpsXIrpQgbrBzQAMQZMoJ84wU5aZgqND601wHrCgIMqnYgZcwVWThCNmwEbiPeI2Y3GxbZW26CzLmbabqX3Iv2zDiz+I3eb8U3zI4Ddvj2Mt3BqqFp918OUOy6/G9da2Xslw0GT0fAroFSdkVScoxhMhU/o8KFvMkIEufOQFPG3dlUYmEhIeeG4H0WjocGQOOdJvy+gF2QvGUXLvElA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fOG/bZo6FPwV0x/u+uu23TkYx9hj2j3CNSbd18Q2HXM=;
 b=emnBLOcgX1mpERP+CkJUHTnKVry/qfpqu+mgAA6KMT71MezpP+v8+M8JbqEtZTGE+/Kb5hEnP7e2qXOT/oWNKkKCeDZNRVdwob+5944m2hIOuWs1eotXYhvvlvQ1XjbyDXYul9lKTul184MaoSZ4G5RilyosoHZoS1/iaU0KEnFYNMqeqQjTg0FzwIRY+4nuEhsjIizUltJ3mZfl5ZYABIicnfquh5kPWQQwlJv0iu1NchQEEP31hu0qrz4qUAvUMwZHnIJTsAbPmlsNXhjWrrK9uy9e/v90w9Wqp1rS+LCliiurzDsCPjOHrERh0E4b12i7RkAtMquE6jbO6UT+xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass action=none
 header.from=nokia-bell-labs.com; dkim=pass header.d=nokia-bell-labs.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fOG/bZo6FPwV0x/u+uu23TkYx9hj2j3CNSbd18Q2HXM=;
 b=VFTwHWtLfxG8HwLhBg0FVCbQghKCf4dobW9/xNZ4tky1/EnUyD6G0f37L3ANcduNesb8Do1rpE/qaEb3L3/9wsISbViO/LmqWNmHTJIJDP26Rrl9g6aJ7cS0xabJQr5hwDyrDHKsZGcpuPW7pdhHa5ZpzpBDvM6VsSkwahfEaZHJsoE/+HR/2873eQgqJRaxoxl2C2MqP81EYTFopOyqqf5kdiHamYTmILKVG5G8kgbe+7ym6/My998QIda0gIaT6dpTO4/krhuKza82JhkeO4S1EU0wSEAL5/9W/twfrfUVWxmwtgtdWF8Lv55UnalLjcxLSoSxD92FZSqR60Lofw==
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com (2603:10a6:102:133::12)
 by AM9PR07MB7074.eurprd07.prod.outlook.com (2603:10a6:20b:2cd::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Wed, 21 Jan
 2026 22:31:36 +0000
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56]) by PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56%2]) with mapi id 15.20.9520.005; Wed, 21 Jan 2026
 22:31:36 +0000
From: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>
To: Neal Cardwell <ncardwell@google.com>, Jakub Kicinski <kuba@kernel.org>
CC: "pabeni@redhat.com" <pabeni@redhat.com>, "edumazet@google.com"
	<edumazet@google.com>, "parav@nvidia.com" <parav@nvidia.com>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "corbet@lwn.net"
	<corbet@lwn.net>, "horms@kernel.org" <horms@kernel.org>, "dsahern@kernel.org"
	<dsahern@kernel.org>, "kuniyu@google.com" <kuniyu@google.com>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "dave.taht@gmail.com" <dave.taht@gmail.com>,
	"jhs@mojatatu.com" <jhs@mojatatu.com>, "stephen@networkplumber.org"
	<stephen@networkplumber.org>, "xiyou.wangcong@gmail.com"
	<xiyou.wangcong@gmail.com>, "jiri@resnulli.us" <jiri@resnulli.us>,
	"davem@davemloft.net" <davem@davemloft.net>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "donald.hunter@gmail.com" <donald.hunter@gmail.com>,
	"ast@fiberby.net" <ast@fiberby.net>, "liuhangbin@gmail.com"
	<liuhangbin@gmail.com>, "shuah@kernel.org" <shuah@kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"ij@kernel.org" <ij@kernel.org>, "Koen De Schepper (Nokia)"
	<koen.de_schepper@nokia-bell-labs.com>, "g.white@cablelabs.com"
	<g.white@cablelabs.com>, "ingemar.s.johansson@ericsson.com"
	<ingemar.s.johansson@ericsson.com>, "mirja.kuehlewind@ericsson.com"
	<mirja.kuehlewind@ericsson.com>, cheshire <cheshire@apple.com>,
	"rs.ietf@gmx.at" <rs.ietf@gmx.at>, "Jason_Livingood@comcast.com"
	<Jason_Livingood@comcast.com>, Vidhi Goel <vidhi_goel@apple.com>
Subject: RE: [PATCH v10 net-next 00/15] AccECN protocol case handling series
Thread-Topic: [PATCH v10 net-next 00/15] AccECN protocol case handling series
Thread-Index: AQHciuLDa2+JTybHxU+MWHu5EmzVXLVdGqkAgAADeICAAA7E8A==
Date: Wed, 21 Jan 2026 22:31:36 +0000
Message-ID:
 <PAXPR07MB7984E90DC4820F3D2506AC45A396A@PAXPR07MB7984.eurprd07.prod.outlook.com>
References: <20260121143215.14717-1-chia-yu.chang@nokia-bell-labs.com>
 <20260121125504.32ea788c@kernel.org>
 <CADVnQym58ujAwozxSgMNxcCBvTf5JVYrzEoDuBFTjheY-PoHHQ@mail.gmail.com>
In-Reply-To:
 <CADVnQym58ujAwozxSgMNxcCBvTf5JVYrzEoDuBFTjheY-PoHHQ@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-bell-labs.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR07MB7984:EE_|AM9PR07MB7074:EE_
x-ms-office365-filtering-correlation-id: b2cee607-193d-4edf-10b9-08de593cd66c
x-ld-processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?NGtpMWw0ZHV0SW8yTlhaQ2RNODdQL1N6UjBXNm9XcXJMUGV6SlczbHlaSVN1?=
 =?utf-8?B?Rk04eEFrSWRIdmVTRktFVnc1TVMrMnF1cGxuRnNsVWFFUVczS2FpeFp2OFEw?=
 =?utf-8?B?blFIRm1aY1RCRjBScnlZMFZBVko5UTRUQVJPaHQ5b1k1U21TUlBIa0JzQitV?=
 =?utf-8?B?T1FwaG5ubDQrOFpoN09lTFdBVGRuU3J5akNwWmw1SnVsUy9jLzBBWGRMTjlK?=
 =?utf-8?B?NnpNTzdMZGExYTFQQVdIRkxFcTVYMlhOdTZpNEpQYjc4VmdNZ1dtelUvbUJD?=
 =?utf-8?B?WlRVQUlZTzNYSDUraEIrWUlxUXpMcWwzNTU4Snd3VzB3dGMzS1pXS2pCNlo2?=
 =?utf-8?B?ZWhSYlhXMXlmanRvUmVvamlqNFBpR3ZUeXd6WkxZdCtaeFQ5OHpNOWRtN1dT?=
 =?utf-8?B?ZXo0U29PVHBoU0tjaTNueVNWM0llN1dYdWM0TjNKbUljWSsrQkNUVm9haDM5?=
 =?utf-8?B?YU5DcjNuamtqeWF5dFd3SXZuell3WE9DTzZpR213RS81VFcvOVNTRVpZUHpo?=
 =?utf-8?B?T0tuTE9QYUFnZWplcmVkdXlNS1l4RjdIaUpmMk1kU0FvekQxMnJXTDBzempH?=
 =?utf-8?B?ZGxnRUwzZ0d4b09oL2E0M2I4VmQwWDFVZnZnZmVCcy9xSUwrdkRDS0oyemcx?=
 =?utf-8?B?dUM5M1FrazJ3UDh6S2h0YTBuN2pnSU9HV1Nub3U4K0NRMXhoOWgwSHJycHJo?=
 =?utf-8?B?dnVQKzlHcWY3a096WHFzbDI0Wk4rK0ZpSXBmV0NzVHgvVTFMZWRZTU1zMjdw?=
 =?utf-8?B?Tmwvanl4cjNhQng0bzBHbGxCOXVQaDh2b2VmM2cwSjRJQXR3RUlsR0RaZjlp?=
 =?utf-8?B?YjF1MTJtc2JjcnJseW83czdWZXYyNlhEdXRTdG9ETUVpUS9wdkh5RndTeHJ3?=
 =?utf-8?B?RVpSSVlBYlJaazA3aDN0eFBlTloxTit3NkoyZlBoVWJBTmx5c0FQT1B6bzQ5?=
 =?utf-8?B?MVY0dFdyV3dYOW9qbjZ5WUYxaGpVM3ZvdTRidHRzR3lrUjhXemlCTHYzU2NX?=
 =?utf-8?B?ckpjU1VVN0tKekZtYjN2TExZbEl0ZmNqamY3R2k4dVIxdFhxaWw2M1RWY0Ru?=
 =?utf-8?B?dTA4RVRLRW1tMDJsV09LNWdlKzNmTmdZTEtuOXMxVkJnQ1gxYVR0ei9zaE1C?=
 =?utf-8?B?RTRxellTR0FadkFHaG5UQ0dybll2TXZQT1VvUzYvZVlWSTV0MkpSRVd1T3p0?=
 =?utf-8?B?cjg2VVJMeEE4VjE3Y2lOaGNJdkJiRXkrSU1PTldJMENpODlITkIyMnFJQ0lM?=
 =?utf-8?B?UkQ0cVlMcXF5dDZZTkNvQ3p0bGpEc3J4OEZYNHdFektPNDlZeFpZcGZsNnYr?=
 =?utf-8?B?UmNvTjFMKzl0WTdGRkg5TldvS2FoeDVoL1ArYXhlRDZObTdQZ01ZRU1STmdP?=
 =?utf-8?B?WGM3VUplZ1NwSXdnbldzSTVlY3dTNDNnNjRhYWRYNGg3eTU5YVdHcUFLZUdq?=
 =?utf-8?B?UTVkMXNhRjQrS2ROVHpKVGxDaWZsUjZJKytRdnlvMGNPZ3VwUGNPSGVLMzhK?=
 =?utf-8?B?TUJyb1IvQlQ4ckZ4MU9hY0dObkVDK010emxMQ3VobHVHa0xoTVpURHFIYXVp?=
 =?utf-8?B?Vkphb3VCWVpualBmL3FESDg3TnBhUFg0aGJ1VWVud0FtVjFVaTk0Wkh4MGlO?=
 =?utf-8?B?S2tZTFlXUkpvdlE5VUxpMGRZU2djcTZiZGlINEVqckJBVUQ2dFdaRTdkZldG?=
 =?utf-8?B?S3J6dE1aK3ZCdG9aMDg2aVhUd3RVY3lWdFR4UWZHRjRHWnJWWnkxd3FIVDZP?=
 =?utf-8?B?c2pvWDRaYVhXZUxwZmJ4djE4QzFyL1I1WUloL0lkOEJWQ09oczRTL3Era0s4?=
 =?utf-8?B?b1pVK0hpSHVWM1Q2bHdUSEdlaGx2dXo0WmZ1cjZObDMwSjVmU2xaM3Z4eWR2?=
 =?utf-8?B?V2hBVUJiV3M0MTlCT2pTNkFrVUpCYmRiZUpYSE9wTjdrTUQ2OHQ3UHFpT3Qy?=
 =?utf-8?B?TzJCTTZMNmk5WHhYczBNaVlQRVVPOStPaGRQL0VRMFM3c05ycXBNOGo3by8x?=
 =?utf-8?B?UXJqUXJqNS9ndE9ua2RTZEd3N3dwVGtnN2RnK3d5WE5BVko3ODBLWlc2a21H?=
 =?utf-8?B?MDk5Z3dFdEUxK0xiam1YeTV5TG94Q2Y3RW01a1pPUDdST0N2bnowU3FMM3VC?=
 =?utf-8?B?allJU1RONVhPeVNvUXV3VlNFY1krU2kvQUZUb0llRHBGVTFuenlBWFdRSnds?=
 =?utf-8?Q?tBFpZTd1q15kfaLkFdplaLY=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR07MB7984.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OEF1bks0b0N6VGUwVHl6RFA1ekhpK3VqSS8zcFZVQTlTTU9GQTQ1bnJTSk9h?=
 =?utf-8?B?ZUN3L2txZmFIMmphZlNCVG41L1lvSFdmdWkyYmJueVNiWmpBSkZ4cFBrQzhW?=
 =?utf-8?B?L2lFWGswNWJvY2RmS090d1ZWdy9GZ2pkOFUvb3hLdUk2UWxaYUR0ZWJrekFH?=
 =?utf-8?B?SVRwNTlxZkNwZ1VaYndrKzVvU24zamNEZjRybkU5WTJGeDhIOHBkek5IMTFq?=
 =?utf-8?B?T3FiYkM5aGlGR05wMjJoM1FjSmRVNTFZMWFBVDVPZzJyelVLcGxQUTBmRG5l?=
 =?utf-8?B?SlA1MndvbkVDMXBFUllCbVByemxzUUxoK05jVExsa2VuLzRLdU4zbEE1MzZH?=
 =?utf-8?B?NGhJZ1RMa05HU2RzNDFzQ3hqRjh5M25tdFlJNFBlVUU0Tm9ORUd4ZENqZVpJ?=
 =?utf-8?B?SzgxUVc5ci9kZjZRNmI5djl2M0YrNzF2MXMyWWlaS1dOKzdrUGVPQVF5cG9F?=
 =?utf-8?B?djkyT3FhRzhFemYwUXlzZ3cyRG5XbFM4c1ZpN0lEZlVHRC80Nyt4Y2Y1RE53?=
 =?utf-8?B?VUJqaEU1c2NWZWMrbXMwWXlNNnY0N1F4RURkb1RhMnliYmE0SWN3Q2FFaEps?=
 =?utf-8?B?d0lOMUQrZDNjVlkrUFdMU1JxeDhZTnFIaFp5SmlSZEpVaUp2NUJDOVJhR01O?=
 =?utf-8?B?VFJPVnBVeWVxVjVhK3d4R1VVREdWQ29iM3NvRTk5d1ZpTWVza1NmdDNad0pv?=
 =?utf-8?B?RmUwM3dHZWkxUytLODhPbFZIVldXeXRpTnozd3BidlBmYVBEUEdrTWtXYUVN?=
 =?utf-8?B?VXcza3Y0YjY1NWtCbzBkeFJJakhEUmgyOHphM1d0YjBLSlh0cXRLT2xzbzJK?=
 =?utf-8?B?Y25mSGxHQzg4OU9UajB4bndXb2xQR1I1SlQ0dnF5NU9PMWU1Tmd5dURId3Fv?=
 =?utf-8?B?RlcwZzArVTN2RTJqenNSaXJtV1ZYTk5IRFhtczNnR2pGbCtmazVkcVJ0WUpP?=
 =?utf-8?B?SElFSk5YckEvYmtUKzd6aVFVblAwNEtCN21jTlNsVkkrZkJ3dnRPamZzaEpj?=
 =?utf-8?B?TnZOYkRMMEpvZjlDL0RBN3NBUzJKUEExMXUrdUVPcDJ2Q2pLRlpRYkhtTFpN?=
 =?utf-8?B?Mk1FT2VNd0F2VmNoUmY1TG1FNXlUZElkbUJBTVNYOUNKN1BsMzgrUTBxMzlD?=
 =?utf-8?B?YTc4ekFaU05wTityVGdjY0Rka2RQWnh4ZEVCVzFXa0JPY2dlOHN1a2trcjJs?=
 =?utf-8?B?VjNxWFhDMzk5M2Iyb0kyaWtvTjI4ckl3QnBDMHhNVFBqeURoZ2tCdTZ2aHQ2?=
 =?utf-8?B?Z0dzNHV3a1R6OHFpVkxXODRLNWVrL21NZGVqT1p1Mjdpc1p2U0lhUEd6cEtS?=
 =?utf-8?B?VTZPSVdwTnYwVWg2VnR4QjZycG95QWxwb1lVeUtUL25DaDgvS2x5VVFMTCsw?=
 =?utf-8?B?RTJmajVPSm5oQ1h6WENzZ3kvZlpSMmdySnhRRENSU0hOOEs3Nkh6NUNZWXY2?=
 =?utf-8?B?ZVg0Mi9aSC85U2VQZEVJRGoxMGRyVFFnL1g1WGR6OEtheXdzSGJWS0x6MzhL?=
 =?utf-8?B?dVJTTEFtLzR0VkVDb2RhaE9KTGtiRFY3TGtYSmFmZ3RCNWU2c2ZBMWFQWWRP?=
 =?utf-8?B?ZFJPbGhSL3o3STFpWmVDZ0EwaGJkL2libjdjb2tzWFZrNDlLdG9lNWQxOFRR?=
 =?utf-8?B?d25pM0dSdVpFUnJ3OEorUzF3dXNhRVpJdDhhVjZKRHJFem5vYi9SNXRqMVJQ?=
 =?utf-8?B?dGl4KzZhY2UvNHNTTjV6YmFLMnY4cFVwWUN3V1RGNnVQUEplNUNoWEo4eU84?=
 =?utf-8?B?eSthQnJZT2FYSTcyN1NYRTVLM0xFRzZxdzBzNjlQcGYrYXdGY0owNjdOY2ZF?=
 =?utf-8?B?eDlsTjNiVnluelNEQkZxaXkrRzQ2cDhBUU5qM1VhK015QXF1VEtRalZKb3hq?=
 =?utf-8?B?TktqWCs1SkZ2MFN3Wk5MOUlYQUluMis5eThGN3VWSS9PblRiZjlZeDZJaDM0?=
 =?utf-8?B?cE9ZaStRQllETnpMMVJlNWFGczZWUXQ4SFpSOXBoazJvUEs1c3RFT3ZOb0Nl?=
 =?utf-8?B?czJvYTRwUkIvOHdFMXoxSDFsQVBmdUg3cEsraUZ0WE5qcmJybWd1cVVKQU1U?=
 =?utf-8?B?RHpUdE05ZHBLTFNnemxacFFkckFXc2dMdXpYSS8zcDFFdjM4M3pmUE5YQ0l2?=
 =?utf-8?B?d2lVZG02TFRRdHhSSlVSZXFIR3pyUHg0RnpaL3NYRWYvalFraEtLcGJQcDVj?=
 =?utf-8?B?RitOVGdoV2NxSzdiS09GV0pJRVg5RnEza0VqWWZiNzJyekpuSFN2NFI1SXNm?=
 =?utf-8?B?bndNWHovVmpKQzZXa245ejZaZlhzTDQ1UlluTlpVNGtTU0NHdGZsTG43Y3Mw?=
 =?utf-8?B?Q3VHNWd4U05YSWdabVZTOXFmblNod1ZBUTAwSE96ZHpLNFRVc1d2a0wvLzlG?=
 =?utf-8?Q?QlIeDs3ObZYK+3VE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR07MB7984.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2cee607-193d-4edf-10b9-08de593cd66c
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2026 22:31:36.3428
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nWZ9xyNjlTL50kMKquNOmdtsTv6EIOL/TM51L7NgW68Po2asWVRR4dExjWUK1+2DlzmNKNQohtFPfuE3Si+OWR5I3Vg7JqTODXpsA9AVrYlDsosXzylh46wB0Xo932A9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR07MB7074
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.64 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[nokia-bell-labs.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-252100-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,google.com,nvidia.com,vger.kernel.org,lwn.net,kernel.org,gmail.com,mojatatu.com,networkplumber.org,resnulli.us,davemloft.net,lunn.ch,fiberby.net,nokia-bell-labs.com,cablelabs.com,ericsson.com,apple.com,gmx.at,comcast.com];
	RCPT_COUNT_TWELVE(0.00)[33];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[nokia-bell-labs.com,reject];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chia-yu.chang@nokia-bell-labs.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nokia-bell-labs.com:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_FIVE(0.00)[5];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: 9659A5ED2B
X-Rspamd-Action: no action

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBOZWFsIENhcmR3ZWxsIDxuY2Fy
ZHdlbGxAZ29vZ2xlLmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBKYW51YXJ5IDIxLCAyMDI2IDEw
OjA3IFBNDQo+IFRvOiBKYWt1YiBLaWNpbnNraSA8a3ViYUBrZXJuZWwub3JnPg0KPiBDYzogQ2hp
YS1ZdSBDaGFuZyAoTm9raWEpIDxjaGlhLXl1LmNoYW5nQG5va2lhLWJlbGwtbGFicy5jb20+OyBw
YWJlbmlAcmVkaGF0LmNvbTsgZWR1bWF6ZXRAZ29vZ2xlLmNvbTsgcGFyYXZAbnZpZGlhLmNvbTsg
bGludXgtZG9jQHZnZXIua2VybmVsLm9yZzsgY29yYmV0QGx3bi5uZXQ7IGhvcm1zQGtlcm5lbC5v
cmc7IGRzYWhlcm5Aa2VybmVsLm9yZzsga3VuaXl1QGdvb2dsZS5jb207IGJwZkB2Z2VyLmtlcm5l
bC5vcmc7IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7IGRhdmUudGFodEBnbWFpbC5jb207IGpoc0Bt
b2phdGF0dS5jb207IHN0ZXBoZW5AbmV0d29ya3BsdW1iZXIub3JnOyB4aXlvdS53YW5nY29uZ0Bn
bWFpbC5jb207IGppcmlAcmVzbnVsbGkudXM7IGRhdmVtQGRhdmVtbG9mdC5uZXQ7IGFuZHJldytu
ZXRkZXZAbHVubi5jaDsgZG9uYWxkLmh1bnRlckBnbWFpbC5jb207IGFzdEBmaWJlcmJ5Lm5ldDsg
bGl1aGFuZ2JpbkBnbWFpbC5jb207IHNodWFoQGtlcm5lbC5vcmc7IGxpbnV4LWtzZWxmdGVzdEB2
Z2VyLmtlcm5lbC5vcmc7IGlqQGtlcm5lbC5vcmc7IEtvZW4gRGUgU2NoZXBwZXIgKE5va2lhKSA8
a29lbi5kZV9zY2hlcHBlckBub2tpYS1iZWxsLWxhYnMuY29tPjsgZy53aGl0ZUBjYWJsZWxhYnMu
Y29tOyBpbmdlbWFyLnMuam9oYW5zc29uQGVyaWNzc29uLmNvbTsgbWlyamEua3VlaGxld2luZEBl
cmljc3Nvbi5jb207IGNoZXNoaXJlIDxjaGVzaGlyZUBhcHBsZS5jb20+OyBycy5pZXRmQGdteC5h
dDsgSmFzb25fTGl2aW5nb29kQGNvbWNhc3QuY29tOyBWaWRoaSBHb2VsIDx2aWRoaV9nb2VsQGFw
cGxlLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MTAgbmV0LW5leHQgMDAvMTVdIEFjY0VD
TiBwcm90b2NvbCBjYXNlIGhhbmRsaW5nIHNlcmllcw0KPg0KPg0KPiBDQVVUSU9OOiBUaGlzIGlz
IGFuIGV4dGVybmFsIGVtYWlsLiBQbGVhc2UgYmUgdmVyeSBjYXJlZnVsIHdoZW4gY2xpY2tpbmcg
bGlua3Mgb3Igb3BlbmluZyBhdHRhY2htZW50cy4gU2VlIHRoZSBVUkwgbm9rLml0L2V4dCBmb3Ig
YWRkaXRpb25hbCBpbmZvcm1hdGlvbi4NCj4NCj4NCj4NCj4gT24gV2VkLCBKYW4gMjEsIDIwMjYg
YXQgMzo1NeKAr1BNIEpha3ViIEtpY2luc2tpIDxrdWJhQGtlcm5lbC5vcmc+IHdyb3RlOg0KPiA+
DQo+ID4gT24gV2VkLCAyMSBKYW4gMjAyNiAxNTozMjowMCArMDEwMCBjaGlhLXl1LmNoYW5nQG5v
a2lhLWJlbGwtbGFicy5jb20NCj4gPiB3cm90ZToNCj4gPiA+IEZyb206IENoaWEtWXUgQ2hhbmcg
PGNoaWEteXUuY2hhbmdAbm9raWEtYmVsbC1sYWJzLmNvbT4NCj4gPiA+DQo+ID4gPiBIZWxsbywN
Cj4gPiA+DQo+ID4gPiBQbGVzYWUgZmluZCB0aGUgdjEwIEFjY0VDTiBjYXNlIGhhbmRsaW5nIHBh
dGNoIHNlcmllcywgd2hpY2ggY292ZXJzDQo+ID4gPiBzZXZlcmFsIGV4Y3BldGlvbmFsIGNhc2Ug
aGFuZGxpbmcgb2YgQWNjdXJhdGUgRUNOIHNwZWMgKFJGQzk3NjgpLA0KPiA+ID4gYWRkcyBuZXcg
aWRlbnRpZmllcnMgdG8gYmUgdXNlZCBieSBDQyBtb2R1bGVzLCBhZGRzIGVjbl9kZWx0YSBpbnRv
DQo+ID4gPiByYXRlX3NhbXBsZSwgYW5kIGtlZXBzIHRoZSBBQ0UgY291bnRlciBmb3IgY29tcHV0
YXRpb24sIGV0Yy4NCj4gPg0KPiA+IExvb2tzIGxpa2Ugd2Ugd2VudCBpbiB0aGUgd3JvbmcgZGly
ZWN0aW9ucywgbXVsdGlwbGUgdGVzdHMgYXJlIGZhaWxpbmcNCj4gPiBub3c6DQo+ID4NCj4gPiBo
dHRwczovL25ldGQvDQo+ID4gZXYuYm90cy5saW51eC5kZXYlMkZjb250ZXN0Lmh0bWwlM0ZicmFu
Y2glM0RuZXQtbmV4dC0yMDI2LTAxLTIxLS0xOC0wMA0KPiA+ICUyNmV4ZWN1dG9yJTNEdm1rc2Z0
LXBhY2tldGRyaWxsJTI2cHctbiUzRDAlMjZwYXNzJTNEMCZkYXRhPTA1JTdDMDIlN0MNCj4gPiBj
aGlhLXl1LmNoYW5nJTQwbm9raWEtYmVsbC1sYWJzLmNvbSU3QzFjMjdlZmY5ZjUyMjRmNzY0NzE1
MDhkZTU5MzEyMTUxDQo+ID4gJTdDNWQ0NzE3NTE5Njc1NDI4ZDkxN2I3MGY0NGY5NjMwYjAlN0Mw
JTdDMCU3QzYzOTA0NjI2NDcwNzkzMDE2MyU3Q1Vuaw0KPiA+IG5vd24lN0NUV0ZwYkdac2IzZDhl
eUpGYlhCMGVVMWhjR2tpT25SeWRXVXNJbFlpT2lJd0xqQXVNREF3TUNJc0lsQWlPaUoNCj4gPiBY
YVc0ek1pSXNJa0ZPSWpvaVRXRnBiQ0lzSWxkVUlqb3lmUSUzRCUzRCU3QzAlN0MlN0MlN0Mmc2Rh
dGE9dk93VXJvOG8wDQo+ID4gdCUyRnVaWWglMkJScUQ2S3E0Y1BqWVdGZEFNSU9pY1JzMFpSTEUl
M0QmcmVzZXJ2ZWQ9MA0KPg0KPiBMb29rcyBsaWtlIHRoZSBmaXJzdCB0d28gYXJlIGZhaWxpbmcg
YmVjYXVzZSB0aGUgdjEwIHNlcmllcyBoYXMgYSBkaWZmZXJlbnQgbGF5b3V0IGZvciB0Y3BfaW5m
byB0aGFuIHdoYXQgcGFja2V0ZHJpbGwgY3VycmVudGx5IGV4cGVjdHM6DQo+DQo+IGh0dHBzOi8v
bmV0ZGV2LWN0cmwuYm90cy5saW51eC5kZXYvbG9ncy92bWtzZnQvcGFja2V0ZHJpbGwvcmVzdWx0
cy80ODM2NDEvMzAtdGNwLWFjY2Vjbi1kZWxpdmVyZWQtdXBkYXRlcy1wa3Qvc3Rkb3V0DQo+IGh0
dHBzOi8vbmV0ZGV2LWN0cmwuYm90cy5saW51eC5kZXYvbG9ncy92bWtzZnQvcGFja2V0ZHJpbGwv
cmVzdWx0cy80ODM2NDEvNTgtdGNwLWFjY2Vjbi1kZWxpdmVyZWQtZmFsc2VvdmVyZmxvdy1kZXRl
Y3QtcGt0L3N0ZG91dA0KPg0KPiBDaGlhLVl1LCBjYW4geW91IHBsZWFzZSBwb3N0IGEgcGF0Y2gg
Zm9yIHBhY2tldGRyaWxsIHRvIG1ha2UgaXQgZXhwZWN0IHRoZSBuZXcgbGF5b3V0IGZyb20gdGhl
IHYxMCBzZXJpZXM/DQo+DQo+IEZvciB0aGUgdGhpcmQgb25lOg0KPiBodHRwczovL25ldGRldi1j
dHJsLmJvdHMubGludXguZGV2L2xvZ3Mvdm1rc2Z0L3BhY2tldGRyaWxsL3Jlc3VsdHMvNDgzNjQx
LzY5LXRjcC1hY2NlY24tY2xpZW50LWFjY2Vjbi1vcHRpb25zLWxvc3QtcGt0L3N0ZG91dA0KPg0K
PiAuLi4gaXQgbG9va3MgbGlrZSB0aGUgdGVzdCBsaW5lIHRoYXQgc2F5czoNCj4NCj4gKy4wMDIg
Li4uIDAuMDUyIGNvbm5lY3QoNCwgLi4uLCAuLi4pID0gMA0KPg0KPiBuZWVkcyB0byBiZSBjaGFu
Z2VkIHRvOg0KPg0KPiArLjAwMiAuLi4gMC4xMDIgY29ubmVjdCg0LCAuLi4sIC4uLikgPSAwDQo+
DQo+IEl0IHNlZW1zIGxpa2UgcnVubmluZyB0aGUgdGVzdHMgYmVmb3JlIGVtYWlsaW5nIHRoZSBw
YXRjaGVzIHNob3VsZCBoYXZlIGNhdWdodCB0aGVzZSAzIGlzc3Vlcz8NCj4NCj4gQ2hpYS1ZdSwg
Y2FuIHlvdSBwbGVhc2UgbWFrZSBzdXJlIHlvdSBydW4gYWxsIHRoZSBBY2NFQ04gcGFja2V0ZHJp
bGwgdGVzdHMgd2l0aCB0aGUgbGF0ZXN0IGtlcm5lbCBhbmQgbGF0ZXN0IHBhY2tldGRyaWxsIGJp
bmFyeSB5b3UgYXJlIHByb3Bvc2luZywgYmVmb3JlIHBvc3RpbmcgYSB2MTEga2VybmVsIHBhdGNo
IHNlcmllcyBhbmQgcGFja2V0ZHJpbGwgcGF0Y2g/DQo+DQo+IFRoYW5rcywNCj4gbmVhbA0KDQpI
aSBOZWFsLA0KDQpTb3JyeSBmb3IgbXkgbWlzcywgSSBvbmx5IHBhdGNoZWQgbXkgbG9jYWwgcGFj
a2V0ZHJpbGwuDQoNClNvLCBvbmUgbmV3IHBhdGNoIGZvciB0Y3BpIHRvIHBhY2tldGRyaWxsIGp1
c3Qgc2VudCBvdXQgdG8gdGhlIG1haWxpbmcgbGlzdC4NCg0KSSB3aWxsIHN1Ym1pdCB2MTEga2Vy
bmVsIHBhdGNoIGFmdGVyIGZpeGluZyBvbmUgaXNzdWUgcmFpc2VkIGJ5IEVyaWMsIGFuZCBkb2lu
ZyB0aGUgcGFja2V0ZHJpbGwgcnVuIGJlZm9yZSBzZW5kaW5nIHRoZW0gb3V0Lg0KDQpDaGlhLVl1
DQo=

