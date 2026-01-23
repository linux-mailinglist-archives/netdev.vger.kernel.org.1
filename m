Return-Path: <netdev+bounces-252781-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uHMRHcpQc2kDuwAAu9opvQ
	(envelope-from <netdev+bounces-252781-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 11:43:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EDCCD747AB
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 11:43:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 920B23034319
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 10:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE9EB3783BE;
	Fri, 23 Jan 2026 10:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="C2edX79/"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011010.outbound.protection.outlook.com [52.101.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1B437755A;
	Fri, 23 Jan 2026 10:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769164939; cv=fail; b=tsNNlzhgW3hin6/V/BnTFa8GMJmR9wqF+GqWGOQXnVIej+Hhz9L7OHlrIfyDfZY2tDEVLjKIP/LOkpDTnYxTjCcz1w+En63yQ0ONkjBA99AY44TXf2o5N4/L10mM4Mu6x7CzNGVgjC0cMEaNo8qUupZJPfUZKPfCul3sSFxvL0g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769164939; c=relaxed/simple;
	bh=Hk7bqxgCuSEgrRbt9udpt9XZO3xmSVTRRvuggNXzVQw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tDN+PEF/rNXi6pFdblD3MpGSJ78N81x+yus+QMQ1wepZn9bAUxtBVVMPMAu2lkiXS95a21svzyGQTQwSH+ThfN1AQHsxSPwItGPU+9Qu7ruT8X0NcxB9M76JK3d0sGKhKArpghCZj5K5DuSirdgJtJQpxtppWz7wois0I9S9mXA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=C2edX79/; arc=fail smtp.client-ip=52.101.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DWJqezV3AyDYueJWxSBMz8O1bLqZdapZ1wq1DkF+VrA+ziqGgD9y6NAy2JF4nOnf+CM/kR8BozMMvyx0BRSGqtlBL+ch3v/MG/H5EpOYH8tqDMchtQbDgCBLtUTQ4249UG/+c2DGawj/jfjoUqWb+me3M2w5xxCPs/9gocLcxrcShZxZFEOz85DZ3vw0PshMLzSgjAaGu5dl9sSB9iRi8ZaQm/fjMb+qZ2vCLet39VpA1QDv7DWBhVe/qVETeJuzeJedpQqCNZ9nfd3LlXLdrcp4T3Tmq4pxlCu//bz7IjI8ULDecE4oPDW0UV8tqEv/Ejx4HIxTRen9dgAsht+5jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hk7bqxgCuSEgrRbt9udpt9XZO3xmSVTRRvuggNXzVQw=;
 b=NcLc998QK14iGyYtZB+qM6SFw0Xwey0F29b4Qyc8yTy7yBd9PuxxBvN+SCnMpmr2681gB2jVPVWFLWoJS9gPG11tYQXIzKQvWgLxL86VOS1MEL01IWrWolQwLi2e8/HtOKiGHXfR+qbscJTMmAqXgGRvV0ohq95T4CJsPxgTUBF2FI+AF7I4+72nk0WJok2U2lteRDpDfwgMwHf8OAq1KtHtofVdISNepTC6kJ0h1vKFsMLBiZpR8ZlXn4ZC+6oYNbtOM7LXSXTAeoF6iWcwTC8416Sa8F4XSaf0eHbW8NFNnBNlEK8b8l0TDsaPPZ4iqc66UB0XHJ5SVGhLDMNBTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass action=none
 header.from=nokia-bell-labs.com; dkim=pass header.d=nokia-bell-labs.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hk7bqxgCuSEgrRbt9udpt9XZO3xmSVTRRvuggNXzVQw=;
 b=C2edX79/W6WAi1SJY33+ekPq4b570UgKsRh7ipVNQTEnpldtkLbPs3kaueCgnBRe72kVwxwVFKTB9uiWnYSAI8yv/abe+CTQ7aH8g5FQ69CtH7YXztSYhU/bRYN0mF8Lvj7FvghDxGvgGx1/fR2ACjQlrCcMixLxpxw9IjPQu1YeGAdn4R1ZtE2M3Oe99CcB2akz0qiNwumRYYUe7+C/apcCe/SBcevSih47Eqmr1s24j5IXMm0BPdEtnYrJIQx1ncO7wEnE7T3C6Wnmq1AJrZ4gycu3Hlwg4J++aaO7oDZU0FQNqUr/EK7bSoHUBeqQX6NqqNwcrpyTgsnqd+3TPA==
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com (2603:10a6:102:133::12)
 by GV2PR07MB11269.eurprd07.prod.outlook.com (2603:10a6:150:2d4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Fri, 23 Jan
 2026 10:42:13 +0000
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56]) by PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56%2]) with mapi id 15.20.9520.005; Fri, 23 Jan 2026
 10:42:13 +0000
From: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>
To: Eric Dumazet <edumazet@google.com>
CC: "pabeni@redhat.com" <pabeni@redhat.com>, "parav@nvidia.com"
	<parav@nvidia.com>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"corbet@lwn.net" <corbet@lwn.net>, "horms@kernel.org" <horms@kernel.org>,
	"dsahern@kernel.org" <dsahern@kernel.org>, "kuniyu@google.com"
	<kuniyu@google.com>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "dave.taht@gmail.com"
	<dave.taht@gmail.com>, "jhs@mojatatu.com" <jhs@mojatatu.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "stephen@networkplumber.org"
	<stephen@networkplumber.org>, "xiyou.wangcong@gmail.com"
	<xiyou.wangcong@gmail.com>, "jiri@resnulli.us" <jiri@resnulli.us>,
	"davem@davemloft.net" <davem@davemloft.net>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "donald.hunter@gmail.com" <donald.hunter@gmail.com>,
	"ast@fiberby.net" <ast@fiberby.net>, "liuhangbin@gmail.com"
	<liuhangbin@gmail.com>, "shuah@kernel.org" <shuah@kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"ij@kernel.org" <ij@kernel.org>, "ncardwell@google.com"
	<ncardwell@google.com>, "Koen De Schepper (Nokia)"
	<koen.de_schepper@nokia-bell-labs.com>, "g.white@cablelabs.com"
	<g.white@cablelabs.com>, "ingemar.s.johansson@ericsson.com"
	<ingemar.s.johansson@ericsson.com>, "mirja.kuehlewind@ericsson.com"
	<mirja.kuehlewind@ericsson.com>, cheshire <cheshire@apple.com>,
	"rs.ietf@gmx.at" <rs.ietf@gmx.at>, "Jason_Livingood@comcast.com"
	<Jason_Livingood@comcast.com>, Vidhi Goel <vidhi_goel@apple.com>
Subject: RE: [PATCH v10 net-next 12/15] tcp: accecn: detect loss ACK w/ AccECN
 option and add TCP_ACCECN_OPTION_PERSIST
Thread-Topic: [PATCH v10 net-next 12/15] tcp: accecn: detect loss ACK w/
 AccECN option and add TCP_ACCECN_OPTION_PERSIST
Thread-Index: AQHciuLQIT+K96o84EKrVnLGnyhsb7VctasAgALcaCA=
Date: Fri, 23 Jan 2026 10:42:12 +0000
Message-ID:
 <PAXPR07MB79842AAA7C66470975A353C3A394A@PAXPR07MB7984.eurprd07.prod.outlook.com>
References: <20260121143215.14717-1-chia-yu.chang@nokia-bell-labs.com>
 <20260121143215.14717-13-chia-yu.chang@nokia-bell-labs.com>
 <CANn89iLvMkeKG_VBrJi3vA5agDxc5+VLz_L3JNT0ALsRUF32xg@mail.gmail.com>
In-Reply-To:
 <CANn89iLvMkeKG_VBrJi3vA5agDxc5+VLz_L3JNT0ALsRUF32xg@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-bell-labs.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR07MB7984:EE_|GV2PR07MB11269:EE_
x-ms-office365-filtering-correlation-id: d6607888-5cfd-47f9-cb7d-08de5a6c117e
x-ld-processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?TU9EMitvMGtRa3VLZ1F2YnFsdkU3N05ITTl3UFVmbXVjamdvZi9tMk4vS0la?=
 =?utf-8?B?cmtqbWNwSnVnMzFaK1BiblJ3T0dieTg4ZHBDai9hcmdQY2o3TE1GVTEwNFUr?=
 =?utf-8?B?RVRHY0ExMVdDeUU4Vjg2YTVqTlJYYzNoYkt5YlRBZzNBbGdRUVk1eXU0WmFE?=
 =?utf-8?B?OExHOXVDZTBHSW1FVmt3OU4vWUhxYUhlK2pmMG5yWXZMMklnNEh1N1ptTno5?=
 =?utf-8?B?VEtQbWJPdlpPNjB0LzVFdWMrT0dBU2NXbnZUUHcyVmpCQk4wZjRoSFpsNndo?=
 =?utf-8?B?alpCaU1pM2o0WlJRZDRqc254UHpQdE1jcXlMY3NVdlh3N0RDYWJVMFA4Yy94?=
 =?utf-8?B?Q052TTVEaHB3YUEwSTNPQVdZeUh5SnpUUXBnbUhKcWtFTGd5UGNybWNyNTVL?=
 =?utf-8?B?cVZPWk82T3B2bXl3T0grSklBQWFWcjAyL0pmdGlBblR0NCttR2lLVCs5T2hu?=
 =?utf-8?B?NDZ5SW9HQUErOWFFblZhWkxDdE81TlJZTDRKZ3pxVjdmaTM4OHhUUUlrOWd1?=
 =?utf-8?B?S3hEMUVzbmdYeDBLQWoya093SlJlbjBiWERNeGF2citza081TkpjTlBzc2ZR?=
 =?utf-8?B?M2JvaWNQOGFrMzhNMFVxN015NjVxcmhtblUyRlN3eDhRRWlNU0pEV2NpTVht?=
 =?utf-8?B?MEhZU1MxWWdZV1dmTTlNeTgvNE1ueDlEOCtCdmlaVmVXNWYyRmhrUGJjcWRI?=
 =?utf-8?B?T3B1NFgrTUx4UzdWMEQ5OWhXclFsS0xKbXdjQ1JzRXdBaW8xNXZmaVhYNGpW?=
 =?utf-8?B?K1MxZmFFZnkyS2U0Z01JanFxeFptU2o1ZWpUcE5zUkJUT0ZLUnU4MGFObzk0?=
 =?utf-8?B?eXR2YW1QY2JLVm9TOE55Tzd3Q0x1ZWxoZ1JkZVZqRXlHZXVoTHNYWjhtRWsy?=
 =?utf-8?B?RXJOUWpHY2Y1NkJEY0hCOTk2SFNPZlU5cXZaVmxVQjRxSktGQnpCbmcyb0px?=
 =?utf-8?B?Y2YzUC9ma3ZLTUU3VkFkaUI5WURwaURFQWNoVHVxZ21FUDg2NHg4NWdkZWNz?=
 =?utf-8?B?dHg4MGxXQ1ZOL2RlNGhVdlZ1L3BmaUlLS3c0enBmVUU5VlVMMU9jWFBsRWlu?=
 =?utf-8?B?OEdIV1FYNHhJMnI3aTlxV3BvNHRjbjZlaHY5Y2NWakZsNUZIdlZBRkg4UEdt?=
 =?utf-8?B?emdqb2Fmc1ZJRUQvdUlySE9jcm9BUlZxaEQ5Sm5NMjBuRGhxcUpGZnVZSWQr?=
 =?utf-8?B?VW1aK1JTWWowOVp6T0x0QUpnbG1OYlVVT0JzaTJxTDdpRkNTbzAzWXpYMWxF?=
 =?utf-8?B?OEZWNFExY28ySGlNVWtGN3RkUHcyWDAwTVNXeHlqTXd4Y3JXRWZESTltQXkx?=
 =?utf-8?B?TmpUaTZiTk5vazFPVGdRQTN2QStyRXlrb1NaWnQ2YXRRS0orQ0FBRUNibTJ2?=
 =?utf-8?B?cUJLN3hPdGR0dGdRMVJKOG1XNTU4enJ3ZTNlSkhDbExtbGVOR3haZlV1OWNN?=
 =?utf-8?B?VXJ3TDhuUVJORkpGbU4xK0VMeGNJaEs3WkNFZWxOREZCNFFiZnJGZ1VPelRG?=
 =?utf-8?B?NnZwaFpZYVJHck5rbFo1RnpJZythNDVtb09ualpob0NocEdZaHdtNGcyTkx3?=
 =?utf-8?B?OVZrRTk1d3J3TjFZaUpBOXkxK1d4d2FWelp6dXAvRVVMYXhIakpQQnZjOVFy?=
 =?utf-8?B?SDFxM3M1NFJ6MTVYU2FvdkhRT0RoRVJwb3hFb0hrSURQZ0dDYzNFYk9VeHRF?=
 =?utf-8?B?TGdmQUpnU3VNaDdkaXFBRFJUUFFTTitkZ2I3OUhXd2U4S3hOYkY5SG9nOWJx?=
 =?utf-8?B?UlZ3eEVOZnBnaGVYNk56SGhXTUM1ZklLUnRyN1V3c2JFVHpWdXhicDcyYnds?=
 =?utf-8?B?OHc5UlpvSnN2ZFRLQUdBQUpFTjEvRCtXUTgzek1rVCs2NVF4U3o0VWxuWTFN?=
 =?utf-8?B?NDg3SlVRYVNQZThwckxycXhDL29KSUk0OUExOTdBUGpPclVCek9XcHVxVjNt?=
 =?utf-8?B?ODhkM3kwU0dGdldsZHgvUXp0T2gwWTJCUXZqQVgrUjZ3NTViS0FONEVpaDNl?=
 =?utf-8?B?SC9OVi9qSWh5N0dCb1hEeElWR1NhTEJDQkRQczBnUHhZTW9tMlRXMmpSVUtj?=
 =?utf-8?B?ZDh2ZEJXNjNzQm1ldjJiYW9ONFpSNGhURmU2cUJjWU14bVc0OGM4VTZPTkU2?=
 =?utf-8?B?R0FGWTYwYjJpc3oxMGNFd1JiV3NhZVhyWFdpWXN0RVVkdnR4M0NpSDRWTWtZ?=
 =?utf-8?Q?6/rnI6RpKI8T7ghqY0h3O6Y=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR07MB7984.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MFJFYU9Xd3JBVkk1ZjlzelVwY3NoZTFEbTRCNGt6ZTlXY0piMWZzVjc0Ukhw?=
 =?utf-8?B?YytBSWdJZ3B1U1FLaEl1Qlg1M0V0bk02WEpZckNjMTBOcERZSE1QbXZCcE55?=
 =?utf-8?B?SUlhd1NrSVFQVWd4MFloRkpISXhQSXhPSm5zQUwrNEZtVG1QTHBuN09naXdn?=
 =?utf-8?B?enNJSDB5Z2YwRUNKZ1ZlWmo3cXlpUmV4T1hBdndHc3BJVE9OWGg5ODQ2T0p3?=
 =?utf-8?B?NGJiTXJHSjkrMHpkTlpmTXRaeWRJbnRrYVZ6dnpId1pxT040YVVQTndSN205?=
 =?utf-8?B?K05ISHp6RmRTdkd3V2lseksyMUFzMW9lQVd0R3dMdW1jdnRRUkd2ekxGak05?=
 =?utf-8?B?ZXl5MkRqOFZmNGRrL0s4aWJOY0RCZTFUMjNFOFBkbkQzTmQ5SGw0TThSQXQ1?=
 =?utf-8?B?dnZreGFDZDl2QS9ocStnYW8zdlVJM0ZPRXBjWmxBdmU3YWdGNDgveEd2ZFhF?=
 =?utf-8?B?TDlDU1BYbHR0eWhXU0YyZmxqOHBoSUsxUzFVVHlOYWMrbFYxb291ZmliTkhF?=
 =?utf-8?B?VTRpWGkvQUpCb2YyUk1BNzBFRm9sSHAyMmFzVkcvZHk4b1BjWFpkWkFqeDkv?=
 =?utf-8?B?eWNtM0k2OWZtY01CRVgvNDVqeitXd3Y4VFR4blNWRXJaaElQMmN1VURtb2h1?=
 =?utf-8?B?SnR6WDlVVlA1N2ZWakpIc1VXVFNkNjJMTUhycWZmeGRCQXVzamhrb29YYWFr?=
 =?utf-8?B?S2JxLzhYTndFVDdLTllqcUtSUUZJZVJhWE1tQldUd1RUcjIxQnovODRTZEpr?=
 =?utf-8?B?c2NSbnltd29INEIvVXZrWDYyNjZQMVJyM1MxV1JlTXpEYjhxam9UbnJTT2FT?=
 =?utf-8?B?WmYwUnJpVHdURWdHTUcwN0VpVXJpbkYvcWhEQTluMEl3VU9iUFAzQ0haUWVi?=
 =?utf-8?B?YlE3Mll3TWRCRUY5YWt1WDYrUFNpY0xMNWxUSldsaHRSNk9vMXhvZDN1UXdv?=
 =?utf-8?B?R2dYbWRwckpjM1FkMXp5MTMvTmJUdktIOGpWdzN1WVdxdHU0NlpEaFFRdThQ?=
 =?utf-8?B?ZFo3dE8vNlhTVmV2bWFGdWlweVhIWGxhb2FnWjJSYVZRRkMrcU1MYlByblRk?=
 =?utf-8?B?MVFiMGNRNStOT1RWQmN6dmdhNlU4VWV1aHJldUR6ZmQzYW9GelNBMFozYXg4?=
 =?utf-8?B?OXF6U2V2VnZUaWpqVG5IZXUxOWJQcFVjcjdBQStQcHlDcWhORzlSNkZLaStI?=
 =?utf-8?B?MDl1VmpOZ2JQM2poQUZ5OStyYzJnSGZIZE85cUJ0c3U2OUUvNlExTU5CRTBK?=
 =?utf-8?B?YUFzb2NETERzUFVWVnppQ1hxUE5xS0ZReWZaaDJFYUJqV09DV1d5V2xKa2d3?=
 =?utf-8?B?N0ZUMUpxRzhIM1ZFOGwrRUxUaUlocXBadWt5R2dDT25wdzRMQ3k4RXVrcklo?=
 =?utf-8?B?ellrT2hHanZ6elRJMTZKQ3l6UDhFb2NqVGRZMmI3a2daYXdDelZEeUdnbS9w?=
 =?utf-8?B?QnBGTlA4S3VlbGFrbHVSSm9DcGJWY0lVU3pUVUVuUjJoTGwvWUI5L0crdDA4?=
 =?utf-8?B?QU1FenlVeWovMFhqMExLVWZubjhmZWlMN0hRMWI5Wk9WRW1FbmpvRkQwOG1U?=
 =?utf-8?B?MFQ4Nm0xOWZYRk5sWWIwcFZWdFRxaEttSEVKWmh1c2o5NXlHaTRreEdoYndu?=
 =?utf-8?B?b2JuTUc1THIyRUViUUlsVFF4VGRuUUloRDJGZzE0UnB4elNpSGljb3JyUXJt?=
 =?utf-8?B?ZHZGd05tYjE2aDVOeEJNL1RNWkNUTnBBckN4dHczYm81d1ZRWmltUnJ4Ylc4?=
 =?utf-8?B?Vkx1TDJnandOeFF0VnNHbWhCUnRhYmpMZzhVZml0eStuMTNVOW9hWUVuR2Rz?=
 =?utf-8?B?aTJEcXE4amsrTGl4MmFjRGcwUlhTc2J3dWVpUllFMG5ZMHc5WVBNSnNvTGdJ?=
 =?utf-8?B?ZzlSRHU5S0U2WDZZQ3RUbXVoMFdqa1ErcmExblZnZWZadUZJS3JTbFdLZDIy?=
 =?utf-8?B?OG54U0xqR2p6SlBxb0pxa1p4SzEzaVJzZytKTHBFNS9SMFBIQVM3aVBoYWNl?=
 =?utf-8?B?ZnpIaU83WUNlc2tpdyt3QXkxWlRYdkF1bGF3WitpQStYS1p1MTVWcncwMDdP?=
 =?utf-8?B?Y0hNRFpXYU9uV1A3Q2xteU9tQXd6MmYrbFU2MTQ5SnoxeFNNbjFTVU5HMm4w?=
 =?utf-8?B?TTlvSW1tY2g3RzZSSDRwZ3JRbWZ3NTM5VzYxdGhQVmR2SHEyMDU3a2xjYVJC?=
 =?utf-8?B?WUNXaENLcklzQWdSOTFMTWp0OUtIUUlDNTdIK3YzaXlxNUYzamkwWG9nMVhr?=
 =?utf-8?B?UytUSktZUWRaNXBYQy8vMVZIcFpCRzZTMHdaWkZicjhKOXgwY3lXY3Qya0JF?=
 =?utf-8?B?WFBDUW9aSnFlYjJCZGdHVFpORHAwRWdVMTM2T2pMSisyek84aU13bHYvUnEz?=
 =?utf-8?Q?5dTP1n89UcwtF3UM=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d6607888-5cfd-47f9-cb7d-08de5a6c117e
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2026 10:42:12.9236
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cVfTAaWzTZ4x6cqjIBKCGTa1KEDbVrO8ltp+IaAOJgMqP7oKmmkSP3QND5AbZOmvmQo7IGZtRF6yv9hWsbcvhr2ExRZD41MtssL2FFU3thVI/ngcmiScYm4BaYSfNMwn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR07MB11269
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nokia-bell-labs.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[nokia-bell-labs.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-252781-lists,netdev=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,nvidia.com,vger.kernel.org,lwn.net,kernel.org,google.com,gmail.com,mojatatu.com,networkplumber.org,resnulli.us,davemloft.net,lunn.ch,fiberby.net,nokia-bell-labs.com,cablelabs.com,ericsson.com,apple.com,gmx.at,comcast.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chia-yu.chang@nokia-bell-labs.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nokia-bell-labs.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EDCCD747AB
X-Rspamd-Action: no action

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBFcmljIER1bWF6ZXQgPGVkdW1h
emV0QGdvb2dsZS5jb20+IA0KPiBTZW50OiBXZWRuZXNkYXksIEphbnVhcnkgMjEsIDIwMjYgMzo1
NCBQTQ0KPiBUbzogQ2hpYS1ZdSBDaGFuZyAoTm9raWEpIDxjaGlhLXl1LmNoYW5nQG5va2lhLWJl
bGwtbGFicy5jb20+DQo+IENjOiBwYWJlbmlAcmVkaGF0LmNvbTsgcGFyYXZAbnZpZGlhLmNvbTsg
bGludXgtZG9jQHZnZXIua2VybmVsLm9yZzsgY29yYmV0QGx3bi5uZXQ7IGhvcm1zQGtlcm5lbC5v
cmc7IGRzYWhlcm5Aa2VybmVsLm9yZzsga3VuaXl1QGdvb2dsZS5jb207IGJwZkB2Z2VyLmtlcm5l
bC5vcmc7IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7IGRhdmUudGFodEBnbWFpbC5jb207IGpoc0Bt
b2phdGF0dS5jb207IGt1YmFAa2VybmVsLm9yZzsgc3RlcGhlbkBuZXR3b3JrcGx1bWJlci5vcmc7
IHhpeW91Lndhbmdjb25nQGdtYWlsLmNvbTsgamlyaUByZXNudWxsaS51czsgZGF2ZW1AZGF2ZW1s
b2Z0Lm5ldDsgYW5kcmV3K25ldGRldkBsdW5uLmNoOyBkb25hbGQuaHVudGVyQGdtYWlsLmNvbTsg
YXN0QGZpYmVyYnkubmV0OyBsaXVoYW5nYmluQGdtYWlsLmNvbTsgc2h1YWhAa2VybmVsLm9yZzsg
bGludXgta3NlbGZ0ZXN0QHZnZXIua2VybmVsLm9yZzsgaWpAa2VybmVsLm9yZzsgbmNhcmR3ZWxs
QGdvb2dsZS5jb207IEtvZW4gRGUgU2NoZXBwZXIgKE5va2lhKSA8a29lbi5kZV9zY2hlcHBlckBu
b2tpYS1iZWxsLWxhYnMuY29tPjsgZy53aGl0ZUBjYWJsZWxhYnMuY29tOyBpbmdlbWFyLnMuam9o
YW5zc29uQGVyaWNzc29uLmNvbTsgbWlyamEua3VlaGxld2luZEBlcmljc3Nvbi5jb207IGNoZXNo
aXJlIDxjaGVzaGlyZUBhcHBsZS5jb20+OyBycy5pZXRmQGdteC5hdDsgSmFzb25fTGl2aW5nb29k
QGNvbWNhc3QuY29tOyBWaWRoaSBHb2VsIDx2aWRoaV9nb2VsQGFwcGxlLmNvbT4NCj4gU3ViamVj
dDogUmU6IFtQQVRDSCB2MTAgbmV0LW5leHQgMTIvMTVdIHRjcDogYWNjZWNuOiBkZXRlY3QgbG9z
cyBBQ0sgdy8gQWNjRUNOIG9wdGlvbiBhbmQgYWRkIFRDUF9BQ0NFQ05fT1BUSU9OX1BFUlNJU1QN
Cj4gDQo+IA0KPiBDQVVUSU9OOiBUaGlzIGlzIGFuIGV4dGVybmFsIGVtYWlsLiBQbGVhc2UgYmUg
dmVyeSBjYXJlZnVsIHdoZW4gY2xpY2tpbmcgbGlua3Mgb3Igb3BlbmluZyBhdHRhY2htZW50cy4g
U2VlIHRoZSBVUkwgbm9rLml0L2V4dCBmb3IgYWRkaXRpb25hbCBpbmZvcm1hdGlvbi4NCj4gDQo+
IA0KPiANCj4gT24gV2VkLCBKYW4gMjEsIDIwMjYgYXQgMzozMuKAr1BNIDxjaGlhLXl1LmNoYW5n
QG5va2lhLWJlbGwtbGFicy5jb20+IHdyb3RlOg0KPiA+DQo+ID4gRnJvbTogQ2hpYS1ZdSBDaGFu
ZyA8Y2hpYS15dS5jaGFuZ0Bub2tpYS1iZWxsLWxhYnMuY29tPg0KPiA+DQo+ID4gRGV0ZWN0IHNw
dXJpb3VzIHJldHJhbnNtaXNzaW9uIG9mIGEgcHJldmlvdXNseSBzZW50IEFDSyBjYXJyeWluZyB0
aGUgDQo+ID4gQWNjRUNOIG9wdGlvbiBhZnRlciB0aGUgc2Vjb25kIHJldHJhbnNtaXNzaW9uLiBT
aW5jZSB0aGlzIG1pZ2h0IGJlIA0KPiA+IGNhdXNlZCBieSB0aGUgbWlkZGxlYm94IGRyb3BwaW5n
IEFDSyB3aXRoIG9wdGlvbnMgaXQgZG9lcyBub3QgDQo+ID4gcmVjb2duaXplLCBkaXNhYmxlIHRo
ZSBzZW5kaW5nIG9mIHRoZSBBY2NFQ04gb3B0aW9uIGluIGFsbCBzdWJzZXF1ZW50IA0KPiA+IEFD
S3MuIFRoaXMgcGF0Y2ggZm9sbG93cyBTZWN0aW9uIDMuMi4zLjIuMiBvZiBBY2NFQ04gc3BlYyAo
UkZDOTc2OCkuDQo+ID4NCj4gPiBBbHNvLCBhIG5ldyBBY2NFQ04gb3B0aW9uIHNlbmRpbmcgbW9k
ZSBpcyBhZGRlZCB0byB0Y3BfZWNuX29wdGlvbiBzeXNjdGw6DQo+ID4gKFRDUF9FQ05fT1BUSU9O
X1BFUlNJU1QpLCB3aGljaCBpZ25vcmVzIHRoZSBBY2NFQ04gZmFsbGJhY2sgcG9saWN5IGFuZCAN
Cj4gPiBwZXJzaXN0ZW50bHkgc2VuZHMgQWNjRUNOIG9wdGlvbiBvbmNlIGl0IGZpdHMgaW50byBU
Q1Agb3B0aW9uIHNwYWNlLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogQ2hpYS1ZdSBDaGFuZyA8
Y2hpYS15dS5jaGFuZ0Bub2tpYS1iZWxsLWxhYnMuY29tPg0KPiA+IEFja2VkLWJ5OiBQYW9sbyBB
YmVuaSA8cGFiZW5pQHJlZGhhdC5jb20+DQo+ID4NCj4gPiAtLS0NCj4gPiB2NToNCj4gPiAtIEFk
ZCBlbXB0eSBsaW5lIGJldHdlZW4gdmFyaWFibGUgZGVjbGFyYXRpb25zIGFuZCBjb2RlDQo+ID4g
LS0tDQo+ID4gIERvY3VtZW50YXRpb24vbmV0d29ya2luZy9pcC1zeXNjdGwucnN0IHwgIDQgKysr
LQ0KPiA+ICBpbmNsdWRlL2xpbnV4L3RjcC5oICAgICAgICAgICAgICAgICAgICB8ICAzICsrLQ0K
PiA+ICBpbmNsdWRlL25ldC90Y3BfZWNuLmggICAgICAgICAgICAgICAgICB8ICAyICsrDQo+ID4g
IG5ldC9pcHY0L3N5c2N0bF9uZXRfaXB2NC5jICAgICAgICAgICAgIHwgIDIgKy0NCj4gPiAgbmV0
L2lwdjQvdGNwX2lucHV0LmMgICAgICAgICAgICAgICAgICAgfCAxMCArKysrKysrKysrDQo+ID4g
IG5ldC9pcHY0L3RjcF9vdXRwdXQuYyAgICAgICAgICAgICAgICAgIHwgIDcgKysrKysrLQ0KPiA+
ICA2IGZpbGVzIGNoYW5nZWQsIDI0IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+ID4N
Cj4gPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9uZXR3b3JraW5nL2lwLXN5c2N0bC5yc3Qg
DQo+ID4gYi9Eb2N1bWVudGF0aW9uL25ldHdvcmtpbmcvaXAtc3lzY3RsLnJzdA0KPiA+IGluZGV4
IGJjOWEwMTYwNmRhZi4uMjhjN2U0ZjVlY2Y5IDEwMDY0NA0KPiA+IC0tLSBhL0RvY3VtZW50YXRp
b24vbmV0d29ya2luZy9pcC1zeXNjdGwucnN0DQo+ID4gKysrIGIvRG9jdW1lbnRhdGlvbi9uZXR3
b3JraW5nL2lwLXN5c2N0bC5yc3QNCj4gPiBAQCAtNDgyLDcgKzQ4Miw5IEBAIHRjcF9lY25fb3B0
aW9uIC0gSU5URUdFUg0KPiA+ICAgICAgICAgMSBTZW5kIEFjY0VDTiBvcHRpb24gc3BhcmluZ2x5
IGFjY29yZGluZyB0byB0aGUgbWluaW11bSBvcHRpb24NCj4gPiAgICAgICAgICAgcnVsZXMgb3V0
bGluZWQgaW4gZHJhZnQtaWV0Zi10Y3BtLWFjY3VyYXRlLWVjbi4NCj4gPiAgICAgICAgIDIgU2Vu
ZCBBY2NFQ04gb3B0aW9uIG9uIGV2ZXJ5IHBhY2tldCB3aGVuZXZlciBpdCBmaXRzIGludG8gVENQ
DQo+ID4gLSAgICAgICAgIG9wdGlvbiBzcGFjZS4NCj4gPiArICAgICAgICAgb3B0aW9uIHNwYWNl
IGV4Y2VwdCB3aGVuIEFjY0VDTiBmYWxsYmFjayBpcyB0cmlnZ2VyZWQuDQo+ID4gKyAgICAgICAz
IFNlbmQgQWNjRUNOIG9wdGlvbiBvbiBldmVyeSBwYWNrZXQgd2hlbmV2ZXIgaXQgZml0cyBpbnRv
IFRDUA0KPiA+ICsgICAgICAgICBvcHRpb24gc3BhY2UgZXZlbiB3aGVuIEFjY0VDTiBmYWxsYmFj
ayBpcyB0cmlnZ2VyZWQuDQo+ID4gICAgICAgICA9ID09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0KPiA+DQo+ID4gICAgICAgICBEZWZh
dWx0OiAyDQo+ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvdGNwLmggYi9pbmNsdWRlL2xp
bnV4L3RjcC5oIGluZGV4IA0KPiA+IDY4M2YzODM2Mjk3Ny4uMzJiMDMxZDA5Mjk0IDEwMDY0NA0K
PiA+IC0tLSBhL2luY2x1ZGUvbGludXgvdGNwLmgNCj4gPiArKysgYi9pbmNsdWRlL2xpbnV4L3Rj
cC5oDQo+ID4gQEAgLTI5NCw3ICsyOTQsOCBAQCBzdHJ1Y3QgdGNwX3NvY2sgew0KPiA+ICAgICAg
ICAgdTggICAgICBub25hZ2xlICAgICA6IDQsLyogRGlzYWJsZSBOYWdsZSBhbGdvcml0aG0/ICAg
ICAgICAgICAgICovDQo+ID4gICAgICAgICAgICAgICAgIHJhdGVfYXBwX2xpbWl0ZWQ6MTsgIC8q
IHJhdGVfe2RlbGl2ZXJlZCxpbnRlcnZhbF91c30gbGltaXRlZD8gKi8NCj4gPiAgICAgICAgIHU4
ICAgICAgcmVjZWl2ZWRfY2VfcGVuZGluZzo0LCAvKiBOb3QgeWV0IHRyYW5zbWl0IGNudCBvZiBy
ZWNlaXZlZF9jZSAqLw0KPiA+IC0gICAgICAgICAgICAgICB1bnVzZWQyOjQ7DQo+ID4gKyAgICAg
ICAgICAgICAgIGFjY2Vjbl9vcHRfc2VudDoxLC8qIFNlbnQgQWNjRUNOIG9wdGlvbiBpbiBwcmV2
aW91cyBBQ0sgKi8NCj4gPiArICAgICAgICAgICAgICAgdW51c2VkMjozOw0KPiA+ICAgICAgICAg
dTggICAgICBhY2NlY25fbWlubGVuOjIsLyogTWluaW11bSBsZW5ndGggb2YgQWNjRUNOIG9wdGlv
biBzZW50ICovDQo+ID4gICAgICAgICAgICAgICAgIGVzdF9lY25maWVsZDoyLC8qIEVDTiBmaWVs
ZCBmb3IgQWNjRUNOIGRlbGl2ZXJlZCBlc3RpbWF0ZXMgKi8NCj4gPiAgICAgICAgICAgICAgICAg
YWNjZWNuX29wdF9kZW1hbmQ6MiwvKiBEZW1hbmQgQWNjRUNOIG9wdGlvbiBmb3IgbiBuZXh0IA0K
PiA+IEFDS3MgKi8gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbmV0L3RjcF9lY24uaCBiL2luY2x1ZGUv
bmV0L3RjcF9lY24uaCANCj4gPiBpbmRleCBiZjdkM2Y5ZjIyYzcuLjQxYjU5M2VjZTFkZCAxMDA2
NDQNCj4gPiAtLS0gYS9pbmNsdWRlL25ldC90Y3BfZWNuLmgNCj4gPiArKysgYi9pbmNsdWRlL25l
dC90Y3BfZWNuLmgNCj4gPiBAQCAtMjksNiArMjksNyBAQCBlbnVtIHRjcF9hY2NlY25fb3B0aW9u
IHsNCj4gPiAgICAgICAgIFRDUF9BQ0NFQ05fT1BUSU9OX0RJU0FCTEVEID0gMCwNCj4gPiAgICAg
ICAgIFRDUF9BQ0NFQ05fT1BUSU9OX01JTklNVU0gPSAxLA0KPiA+ICAgICAgICAgVENQX0FDQ0VD
Tl9PUFRJT05fRlVMTCA9IDIsDQo+ID4gKyAgICAgICBUQ1BfQUNDRUNOX09QVElPTl9QRVJTSVNU
ID0gMywNCj4gPiAgfTsNCj4gPg0KPiA+ICAvKiBBcHBseSBlaXRoZXIgRUNUKDApIG9yIEVDVCgx
KSBiYXNlZCBvbiBUQ1BfQ09OR19FQ1RfMV9ORUdPVElBVElPTiANCj4gPiBmbGFnICovIEBAIC00
MTMsNiArNDE0LDcgQEAgc3RhdGljIGlubGluZSB2b2lkIHRjcF9hY2NlY25faW5pdF9jb3VudGVy
cyhzdHJ1Y3QgdGNwX3NvY2sgKnRwKQ0KPiA+ICAgICAgICAgdHAtPnJlY2VpdmVkX2NlX3BlbmRp
bmcgPSAwOw0KPiA+ICAgICAgICAgX190Y3BfYWNjZWNuX2luaXRfYnl0ZXNfY291bnRlcnModHAt
PnJlY2VpdmVkX2Vjbl9ieXRlcyk7DQo+ID4gICAgICAgICBfX3RjcF9hY2NlY25faW5pdF9ieXRl
c19jb3VudGVycyh0cC0+ZGVsaXZlcmVkX2Vjbl9ieXRlcyk7DQo+ID4gKyAgICAgICB0cC0+YWNj
ZWNuX29wdF9zZW50ID0gMDsNCj4gPiAgICAgICAgIHRwLT5hY2NlY25fbWlubGVuID0gMDsNCj4g
PiAgICAgICAgIHRwLT5hY2NlY25fb3B0X2RlbWFuZCA9IDA7DQo+ID4gICAgICAgICB0cC0+ZXN0
X2VjbmZpZWxkID0gMDsNCj4gPiBkaWZmIC0tZ2l0IGEvbmV0L2lwdjQvc3lzY3RsX25ldF9pcHY0
LmMgYi9uZXQvaXB2NC9zeXNjdGxfbmV0X2lwdjQuYyANCj4gPiBpbmRleCBhMWE1MGE1YzgwZGMu
LjM4NWI1Yjk4NmQyMyAxMDA2NDQNCj4gPiAtLS0gYS9uZXQvaXB2NC9zeXNjdGxfbmV0X2lwdjQu
Yw0KPiA+ICsrKyBiL25ldC9pcHY0L3N5c2N0bF9uZXRfaXB2NC5jDQo+ID4gQEAgLTc0OSw3ICs3
NDksNyBAQCBzdGF0aWMgc3RydWN0IGN0bF90YWJsZSBpcHY0X25ldF90YWJsZVtdID0gew0KPiA+
ICAgICAgICAgICAgICAgICAubW9kZSAgICAgICAgICAgPSAwNjQ0LA0KPiA+ICAgICAgICAgICAg
ICAgICAucHJvY19oYW5kbGVyICAgPSBwcm9jX2RvdTh2ZWNfbWlubWF4LA0KPiA+ICAgICAgICAg
ICAgICAgICAuZXh0cmExICAgICAgICAgPSBTWVNDVExfWkVSTywNCj4gPiAtICAgICAgICAgICAg
ICAgLmV4dHJhMiAgICAgICAgID0gU1lTQ1RMX1RXTywNCj4gPiArICAgICAgICAgICAgICAgLmV4
dHJhMiAgICAgICAgID0gU1lTQ1RMX1RIUkVFLA0KPiA+ICAgICAgICAgfSwNCj4gPiAgICAgICAg
IHsNCj4gPiAgICAgICAgICAgICAgICAgLnByb2NuYW1lICAgICAgID0gInRjcF9lY25fb3B0aW9u
X2JlYWNvbiIsDQo+ID4gZGlmZiAtLWdpdCBhL25ldC9pcHY0L3RjcF9pbnB1dC5jIGIvbmV0L2lw
djQvdGNwX2lucHV0LmMgaW5kZXggDQo+ID4gOGI3NzQwMTlhM2E2Li40NzJiZDU3OTEzYWUgMTAw
NjQ0DQo+ID4gLS0tIGEvbmV0L2lwdjQvdGNwX2lucHV0LmMNCj4gPiArKysgYi9uZXQvaXB2NC90
Y3BfaW5wdXQuYw0KPiA+IEBAIC00ODYzLDYgKzQ4NjMsOCBAQCBzdGF0aWMgdm9pZCB0Y3BfZHNh
Y2tfZXh0ZW5kKHN0cnVjdCBzb2NrICpzaywgDQo+ID4gdTMyIHNlcSwgdTMyIGVuZF9zZXEpDQo+
ID4NCj4gPiAgc3RhdGljIHZvaWQgdGNwX3Jjdl9zcHVyaW91c19yZXRyYW5zKHN0cnVjdCBzb2Nr
ICpzaywgY29uc3Qgc3RydWN0IA0KPiA+IHNrX2J1ZmYgKnNrYikgIHsNCj4gPiArICAgICAgIHN0
cnVjdCB0Y3Bfc29jayAqdHAgPSB0Y3Bfc2soc2spOw0KPiA+ICsNCj4gPiAgICAgICAgIC8qIFdo
ZW4gdGhlIEFDSyBwYXRoIGZhaWxzIG9yIGRyb3BzIG1vc3QgQUNLcywgdGhlIHNlbmRlciB3b3Vs
ZA0KPiA+ICAgICAgICAgICogdGltZW91dCBhbmQgc3B1cmlvdXNseSByZXRyYW5zbWl0IHRoZSBz
YW1lIHNlZ21lbnQgcmVwZWF0ZWRseS4NCj4gPiAgICAgICAgICAqIElmIGl0IHNlZW1zIG91ciBB
Q0tzIGFyZSBub3QgcmVhY2hpbmcgdGhlIG90aGVyIHNpZGUsIEBAIA0KPiA+IC00ODgyLDYgKzQ4
ODQsMTQgQEAgc3RhdGljIHZvaWQgdGNwX3Jjdl9zcHVyaW91c19yZXRyYW5zKHN0cnVjdCBzb2Nr
ICpzaywgY29uc3Qgc3RydWN0IHNrX2J1ZmYgKnNrYikNCj4gPiAgICAgICAgIC8qIFNhdmUgbGFz
dCBmbG93bGFiZWwgYWZ0ZXIgYSBzcHVyaW91cyByZXRyYW5zLiAqLw0KPiA+ICAgICAgICAgdGNw
X3NhdmVfbHJjdl9mbG93bGFiZWwoc2ssIHNrYik7ICAjZW5kaWYNCj4gPiArICAgICAgIC8qIENo
ZWNrIERTQUNLIGluZm8gdG8gZGV0ZWN0IHRoYXQgdGhlIHByZXZpb3VzIEFDSyBjYXJyeWluZyB0
aGUNCj4gPiArICAgICAgICAqIEFjY0VDTiBvcHRpb24gd2FzIGxvc3QgYWZ0ZXIgdGhlIHNlY29u
ZCByZXRyYW5zbWlzaW9uLCBhbmQgdGhlbg0KPiA+ICsgICAgICAgICogc3RvcCBzZW5kaW5nIEFj
Y0VDTiBvcHRpb24gaW4gYWxsIHN1YnNlcXVlbnQgQUNLcy4NCj4gPiArICAgICAgICAqLw0KPiA+
ICsgICAgICAgaWYgKHRjcF9lY25fbW9kZV9hY2NlY24odHApICYmDQo+ID4gKyAgICAgICAgICAg
VENQX1NLQl9DQihza2IpLT5zZXEgPT0gdHAtPmR1cGxpY2F0ZV9zYWNrWzBdLnN0YXJ0X3NlcSAm
Jg0KPiA+ICsgICAgICAgICAgIHRwLT5hY2NlY25fb3B0X3NlbnQpDQo+ID4gKyAgICAgICAgICAg
ICAgIHRjcF9hY2NlY25fZmFpbF9tb2RlX3NldCh0cCwgDQo+ID4gKyBUQ1BfQUNDRUNOX09QVF9G
QUlMX1NFTkQpOw0KPiA+ICB9DQo+IA0KPiB0Y3BfcmN2X3NwdXJpb3VzX3JldHJhbnMoKSBoYXMg
dHdvIGNhbGxlcnMuDQo+IA0KPiB0Y3Bfc2VuZF9kdXBhY2soKSBjaGVja2VkIGRzYWNrIGlzIGVu
YWJsZWQuDQo+IA0KPiB0Y3BfZGF0YV9xdWV1ZSgpIDogTm8gc3VjaCBjaGVjay4NCj4gDQo+IFNv
IEkgd29uZGVyIGlmIHRwLT5kdXBsaWNhdGVfc2Fja1swXS5zdGFydF9zZXEgY291bGQgY29udGFp
biBnYXJiYWdlID8NCj4gDQo+IFBlcmhhcHMgdGVzdCB0cC0+cnhfb3B0LmRzYWNrID8NCg0KSGkg
RXJpYywNCg0KTG9va3MgbGlrZSB0cC0+cnhfb3B0LmRzYWNrIGNvdWxkIGJlIGVyYXNlZCBpbiB0
Y3Bfb3V0cHV0LmMgYWZ0ZXIgc2VuZGluZyBvdXQgVENQIG9wdGlvbnMuDQpJbiB2MTEsICJhY2Nl
Y25fb3B0X3NlbnRfd19kc2FjayIgaXMgYWRkZWQgdG8gaWRlbnRpZnkgd2hldGhlciBBY2NFQ04g
b3B0aW9uIGlzIHNlbnQgdG9nZXRoZXIgd2l0aCBELVNBQ0suDQpBbmQgSSB0aGluayBpdCBjYW4g
YmUgdXNlZCB0byBqdXN0aWZ5IHdoZXRoZXIgZHVwbGljYXRlX3NhY2tbMF0uc3RhcnRfc2VxIGlu
Y2x1ZGVzIG9rIHZhbHVlIHRvIGJlIGNoZWNrZWQuDQoNClRoYW5rcy4NCkNoaWEtWXUNCg==

