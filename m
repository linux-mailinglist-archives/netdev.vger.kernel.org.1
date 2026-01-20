Return-Path: <netdev+bounces-251462-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6BRZCdhpcGkVXwAAu9opvQ
	(envelope-from <netdev+bounces-251462-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 06:53:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BF17E51BD4
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 06:53:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1A6D0626C36
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 11:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E58542315F;
	Tue, 20 Jan 2026 11:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="EVKirYNt"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013019.outbound.protection.outlook.com [40.107.162.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A31D126BF7;
	Tue, 20 Jan 2026 11:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768909072; cv=fail; b=q3ZOaP1VAQD6Qb+35jyZm40GtNmf6hcsGmy9PAO+voMhbYuDTn8D5NA7URKb9aIPuG2J/56ka2H4hs4l/hsbxuNwfEe5ExsBASFfELHBoSPI1QFEEnefiQxsnEp1xdN9oDI6faAQKKuVoTqzbu91mIeBnbycYMt+QFyQcDTBR8U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768909072; c=relaxed/simple;
	bh=K8EmHKKFnC8WD4OZfSu9XfFBoGN2iS3BVCirEaWnBHg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=njmvN+bInewZOGSSrR6oQzMRKHVUq1fyB5Imv4hJMXK2kHv2Yn4rDgqmtEQFDAtBfOp2dqucylbh6z8xtFFmumi2EI1AGafavm1+YdWzZCLq8U9tu8fsjSnSVgsjziLNGtzxY20LiL9QdKDJFYmk3R7IbVjJnZC1a1l+5VYiWLo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=EVKirYNt; arc=fail smtp.client-ip=40.107.162.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QKYIei1r8w5ayPsjlC3bX8A6fOkZITLAJldkWXT7xaXxL0St3FpYFzfFd5bXNAKkYC2Px0JUmaTAHv9EHfdk8+jYTRqn67eAo/HoTP1phLWXgtxIkzZnl3yQFmbEM9J8FyI8PwGW1ZbL5sUSwJsNzY8SHgcEBGmhrIFhvqFmGgov0vUeKjqQYat/plZUtc7oL8htvCXm+C29Fo8O5lF3ZEis+31w0hS+X2lSDhet4/sIhhuVJNzWNKCNGDXk6A3ekVt7tEvHFOBs/G+yvm5oWehA/Q4/2bnMoyogzFDf4olGReBmlFpzDr3x21ZgDLDoPfBqRbsvDoxz3USeRjkrrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K8EmHKKFnC8WD4OZfSu9XfFBoGN2iS3BVCirEaWnBHg=;
 b=q7G5gb34R84gaWIeaLycILJ+rQfBe0sfgx5DE5CsTA8plDPe9N+r4MnSfnBqAVvxnsFuov08WcY3j9eXH3DmYHwSBjUFvKyjRxxEyNBneZNF0IiR6Q0B9zfzoy2tmhGKKmNbcj0QKyUphYeJqCtzpkhQQF8mlucNiuQy8qqadKpEvuVLyGnTUcuKGdSzGnSv6gEGbyHUYuU4Vm7inMoLO+KwuwH3ROKyBSog73XrXMBOzgWFLjxGuUI9tgiQxL8Enu8obW0GI1pzHS9jiUoSb+Me8gjv8DQG015e71kgui1PwLM6FlyPxzAwbSp8GTHkq8kChxuP7aKgY5BGZ5IoLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass action=none
 header.from=nokia-bell-labs.com; dkim=pass header.d=nokia-bell-labs.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K8EmHKKFnC8WD4OZfSu9XfFBoGN2iS3BVCirEaWnBHg=;
 b=EVKirYNtNnF7QY5sGAKoQVpqbmzwoAxxsTCU902aloH9NMFz3EPM+kErmoTl2Vkgpr+PyFOA8rri+VMFP5MbsynD0KM5ht8+x6I6rvro+2VHay29rBPsSFXewEaXGn8BCfJffOj5WItKlSRb860foEH3T7kbd9gEDUVWS3hHYHLqMmNqXbTQttsufG0Nl4V+LdKPhWtIkD7Uj7L/IYYk+JqvR2X0XC76dH9mBkRCh/MFQRR39BfHEKsM5+v20+YjePru+YUJiz98l5aSLyP7eMnmMnho4bXz+3eLTn1wWOhPEtJzTwvxCYrd7lSNlqE4PkDYYuF9bHSenuXYtbh8qw==
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com (2603:10a6:102:133::12)
 by AS8PR07MB7781.eurprd07.prod.outlook.com (2603:10a6:20b:350::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 11:37:41 +0000
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56]) by PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56%2]) with mapi id 15.20.9520.005; Tue, 20 Jan 2026
 11:37:41 +0000
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
Subject: RE: [PATCH v9 net-next 13/15] tcp: accecn: add tcpi_ecn_mode and
 tcpi_option2 in tcp_info
Thread-Topic: [PATCH v9 net-next 13/15] tcp: accecn: add tcpi_ecn_mode and
 tcpi_option2 in tcp_info
Thread-Index: AQHciXW+EzR6VjUDV0Gw6kc/N9piqLVa6fUAgAAFJOA=
Date: Tue, 20 Jan 2026 11:37:41 +0000
Message-ID:
 <PAXPR07MB7984BA30924000787013DD26A389A@PAXPR07MB7984.eurprd07.prod.outlook.com>
References: <20260119185852.11168-1-chia-yu.chang@nokia-bell-labs.com>
 <20260119185852.11168-14-chia-yu.chang@nokia-bell-labs.com>
 <CANn89iKhAs3rMWFdmM-rma1wS-Xd7mf9PBUQKL8YMKhB81Jkkw@mail.gmail.com>
In-Reply-To:
 <CANn89iKhAs3rMWFdmM-rma1wS-Xd7mf9PBUQKL8YMKhB81Jkkw@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-bell-labs.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR07MB7984:EE_|AS8PR07MB7781:EE_
x-ms-office365-filtering-correlation-id: b4933588-26ac-4325-ec01-08de58185222
x-ld-processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?L1dDajg3enAreENaRkx5a21JQi9mT243VFdqTVpJTGVYMHZmVnpJSHpUa1Br?=
 =?utf-8?B?bnlySWQ5cnkrR0NiaUxPaFVhWlp1UTdrU08rZ3FSRFpTV1J3S2ZEY2cxWFU2?=
 =?utf-8?B?UWJRVEpRemt1Vy9ubFpVekkyajZWekFEMnY2Z2pLUVFTZlNLVlBrMm9CWFZI?=
 =?utf-8?B?d1B3Tmk4RHM4OWlpQ3ZGV3Nnc0RNcWU0NWZ0TTM2SGg3andIL1VFUXdsRHhT?=
 =?utf-8?B?bU5wVUFJVHovNGF5S3dCRDM2cWdMaUttd1I0NWZtUmNVRW5mcnpPbnEyQWNV?=
 =?utf-8?B?NktNT3NHT0srRDVvV2JDeVZtUytFbVNRenVVeHBGVFluN2Ribkk1ZXR0N0lG?=
 =?utf-8?B?bEJUdnBoNXFjZTArMWNjQkhjNDZhaXkwS2l0bWNja0U0SEpNS2F5cElQam5I?=
 =?utf-8?B?V09xSFZrY1VXejIyMzRCNDR1dGtibGFpK05CajVESUpCYWJuVnJJS3g5UVRN?=
 =?utf-8?B?Q3ZaVE4yV2FvZlZ6cnJJaDhheHVzUDA0c0FBQmlaM1RMbEhuSFlXVm14YVFW?=
 =?utf-8?B?WHlGY0hOdExWZDIvalYxY05CeG9JZEJUYzhSdGJTUVZqTm9lNU9GRzlUVlZZ?=
 =?utf-8?B?ZDUvY0NFWHNHb1NhYVNxelY4L1puSVNiL0dTR2RYWWRFbkNTbzJTK3FOYlV3?=
 =?utf-8?B?bWFKYXdSaHg5Vnc5NEx5d2gyVWJCdlh3RUpNTXFqODEwalhKWDQ2WWJIK3Zz?=
 =?utf-8?B?aTZLR284dGtNTXdFdHJtYmIrMGZmL1hta25XQk9tdHhOcVZ3bEY1L1o3VE52?=
 =?utf-8?B?WmJXWDFQaTRlZ293SE5KdFFUWG1NYWJ4SlRxb3l5OVFhR2V2Vjl5QXRJTjVo?=
 =?utf-8?B?cDVxajY1SkFrNUlwVy96QXU2M2Vzbk9VTGd6bjByODdsVmxsTGREa2VkcVJk?=
 =?utf-8?B?ZUlaZ3hXb0ZNRW1TWEtFRmt2ZHY1dkRVdWRYa1dHZ0FGNmI2eldwbkxBREdi?=
 =?utf-8?B?TFJJZjBlM2VtOWJYaWlvRlJjNVNlL013OVN6MlJsbC91ZVV0YTA2WUNVK3k1?=
 =?utf-8?B?THZIWklSclNOeHJsbVFRMnlTS0FpVzIzZDlSNjJZODBDdnk1N0hQbmNNVVFS?=
 =?utf-8?B?SG9jbnRQeExRMzV6YUFjT1cyRm1yREVuZmQrVWNIZ1NjdEozQ2JjNVZEc3BC?=
 =?utf-8?B?VzRIY3EwNkUwdGVrN2ttKzhwcWJUZ0M5TFYxaGduUHh4Vk4wb3ZsT3JnMTQ5?=
 =?utf-8?B?UHBySjVvdDA1SnpLd3o3djRFVnZaS3dCaGc5SlhwVWJmMzRWMkZpWk5ucTJ3?=
 =?utf-8?B?azlUT3VMOFQzY28zWHRoTGxpeHpnaWdGcXBYTzdLcTdlRDVpUElNeVoxR1Fw?=
 =?utf-8?B?OGRScTJjNXZWTTVJQTJuMjRTTURONWwyMm1GZ2lqSTBxNW96N3I5L3FtNVl1?=
 =?utf-8?B?eG5JTFR5UHJHcnVRZzhVTXRpMXlKL1ZBY21RTm5NaXVLanlybXR1ekJFQmph?=
 =?utf-8?B?eUtmajJ4UzdmSWpjZzlzS0hsUzhLMnZUSmFnMU50djR4SGtMWUZMNUpqQU9y?=
 =?utf-8?B?ODNBY0NHWGQ3L2VQY0txK1hvV0FUcy9UNFZiS3B1enpsUElEKzQ5Z1A2N29T?=
 =?utf-8?B?QkhkUGJjT0NLS3RPaHdMbFVNVDRJUG9WakhTd25INzhLVU4vN2o4SzdXdWxT?=
 =?utf-8?B?bERjWkloYkR3YUdSQzZXTDVnWXR2cjdMcS94MC80TDNzdkx1WlZsWmVUZTB1?=
 =?utf-8?B?aVJJcS9lVDY3VHRuNEtDTk8zMno2L0tLdHF6dWFNdXNON3FNZHlzWS9tamdG?=
 =?utf-8?B?NWdOWW81cFhlemNQRXE4ajFmdUdZelJncUR1QkdSNHdhSS9TWS9tMFpjV0lT?=
 =?utf-8?B?V3RtYTRKZWNjd1lVeWltUlY0cWx5V0R3YXhJR2NpUldUVFVISUZLUmpSaTAx?=
 =?utf-8?B?RFJrWWg2anppRkM4dFVnbm5lSktYWm9IU3NhTHJzaGV3dkRIbXBYNlo4K2Rk?=
 =?utf-8?B?NWhmSHR1allQZWtacTR5LytxMFRLeE9pTTlBUTJSQ2oxQzlrQzVSdGVWK2oy?=
 =?utf-8?B?MUNtOGZsUFc1dDhCTU1EUzVEbG00WTgyY01YZFNVVmMzZXIybEhIanFrKzUy?=
 =?utf-8?B?eDZSSEZMV21zOGpRU1dIbTllUTd3dmxCKzhHNFA0dVhBVng3QWNaUU1ORjhD?=
 =?utf-8?B?NDhtUVl2NmdJdEY5T1FqeXlFOVpOYXhPeGlHU2Flc1YwbXhVRHpid3prekdU?=
 =?utf-8?Q?IF5Z+I6VZHxNXYgmWbp/WWA=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR07MB7984.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ekMxU0txTVpWUm80akhWVWFkNEJBSFZyTTFNcVllSW56WUZhYTRIUkpBSFgz?=
 =?utf-8?B?c0dQeUNmZmRrNWNlbTJtcEoyMUs5aEdHaFg1QWVTSzBmd1dVb29pUXgwK3pj?=
 =?utf-8?B?YTFnaXlkWHkrSmpPTUlRc1BHQzhWVWU3d3hib0cyVFE1Qk5wc3BxeWtXejNQ?=
 =?utf-8?B?RThKMkZwRmRWaTMybnB3cW9DWDhvRzQwOWFqaUFhVlAzalNyeEdVWWE0MGtN?=
 =?utf-8?B?Z0czVjd1MCtZSCtnUGFnZFEzSlhHZUpKN1VMeDV0V3JSa0tnUzlQT1dFS1Vw?=
 =?utf-8?B?aWxzMmZIZldmQ2ZSL0haTEFPZXU3bmVXOXJUU29Yc3hwRUt5RHhROEI0ZU94?=
 =?utf-8?B?MFRsaU9aQWNMaklMcXE3bVI3TXBVeXNibk4zRGhMcWFqL1hHaThvNDU3UVJs?=
 =?utf-8?B?Z1lsazBuSGtZSkV5Q2t1OHEva055STNVeTBONHozeHNZS2VpNHFyeTRRc0V3?=
 =?utf-8?B?S1RvN3pQTWttaGE3QVlZWXk3ZWgwaVBuZ0V3aWYxNXlaODFJcFNZd2R0aUZ2?=
 =?utf-8?B?MDYxUS9OSXVZSHFSU2krVGV0Q29yYW1sd2g3bFlXQS9VQmlCdmpPclVDQ1RJ?=
 =?utf-8?B?UkQwZDRjZk81SnhYdVRRVVR0V1dyQUdUYnhyWmRTTTdNbkNTY052Z05YVXp4?=
 =?utf-8?B?cGg4ZXdIR3QvSVcxTU5BVDVXckJaZUNxUlVEZ1Z2T3I4b25PS2NuRHZ5d1hz?=
 =?utf-8?B?dit2R1VxQXRCckczQVM0MjJ0Yk1leEtVUWVsd3MvUE1zcitzRG1oOXJldmN5?=
 =?utf-8?B?TVZnNEtUY0N4cTlTTTR4OVhPdWM5OFlxbW1LRlMrK0lOMDAxcVg3Y0loanBD?=
 =?utf-8?B?ekJYajFrQUx2SFAvekViZXpRMXBxYi81aVI5dkY5MWpnN2NMQ3JBZ2x2SkZp?=
 =?utf-8?B?Z1dkSXhWYUVjRUR3REVuNkZDM2lGKzIwa3VkWmh0TUhlVkFXckY5UzFUK0s2?=
 =?utf-8?B?VzNCTVFRbHplZXJ1QS8xY1ozQnE2Z3NHYkUwTE5OVElKNW0zYmVUcFZMTjhC?=
 =?utf-8?B?TjA2VWp5SFd0STA3VWRDUktBay84Q2pZTFFTdHd4Z2JXZ3hoUkg3VmJvN3pl?=
 =?utf-8?B?ZnZ6ZHVFZG1EMkdPK0hCSnJrWjh4RVZka3lLZ0kvMTgwVzZWMHdnNElJaEVG?=
 =?utf-8?B?TTVadkxjNDNkY1F0TFRBSG1SYk85dHI5d1VRNmlhaElsVUxNdzdJTHVNVFZS?=
 =?utf-8?B?c2FWSUhzakl6Z042cmpjTDZObjBIWWs0U2t5TlR2bVZxLzAzYVZJU1NhUG1C?=
 =?utf-8?B?bWdDS2Zic1FJTG5wZ1I3aTVsaWRSWFE1YlhKcTBDR1dEZ2xQWXk5NzdGYVBr?=
 =?utf-8?B?VHN4NjhIRWZ0Z1lmQVhYSStBY3ZtZDJoNzRXZUVvdS9LOFNZMEZZS1hHMllr?=
 =?utf-8?B?V0FuUWsvTVJVS3hiZVdRN2lERENrR3VXWXVOMmxZY203RFJPZ0pCRVNBYmlj?=
 =?utf-8?B?KzZKUXdNcGlmd2F6MFNONG9NOXdiYnhMVGFtTUVlWW5iamQ4ZklSemNIRnNr?=
 =?utf-8?B?QUhHRitVbDRhUnIzUGhreWJ2SU5KYm1oKzhFV3ZWdlZFQTlsK1VleVRrZjdV?=
 =?utf-8?B?SXFXYVlaODB0U0V6T1E1aW5BUGlrdGwvRUppNThvbk9Zc3YyWUs5RytzRWVP?=
 =?utf-8?B?T0JEVVRvZXNSK0ZiQ0dkRVlONTVnb0RNckxYTDh6V2x0WmJTU2tGd2JpQW9G?=
 =?utf-8?B?Z3ExUlBEZW5tTkMzUnlUWjZnV2FlY0VFVCtjZWk2NDVSVkppSWlubXJaVnAw?=
 =?utf-8?B?TThRUXV4U0RKV2Q3RmE1QXpCdEpyenJmdnVWN0xwTmdzdFNRTjJVeGd4dTNN?=
 =?utf-8?B?Q25hQXJ1eno1N0Q5d0I2UU8yc2RMZFRlNnNoZ293czNaYzZDOVhLZHFnWVg3?=
 =?utf-8?B?bklya3Vsek9wb0t0NGlNb21xYzBxVWE0V0NadWtHQ2VWdlByK0wydk5jNXl2?=
 =?utf-8?B?SStidk4wL1JkZTgxbWczMjBOQlNTTkt4TGsvTlJGK3BFaUJBOThmSHE4dmpi?=
 =?utf-8?B?d0pDb3hlM0I1QVNFazJRZC9wVmFGSEY1KzFIWmhUQ2I0aE9qd2FXc2JlSDFM?=
 =?utf-8?B?Q0Q2Ry9ZU0lyYlR2VGtveERTaE45cHhodFc0N044c3lNaUZjaVY1bEo1VmZL?=
 =?utf-8?B?R3JHbW1SV2N2MFUyRVNqcVZackdzcUdZMHpaZ2U0WWYvNXNwOEJjbTFsYmpF?=
 =?utf-8?B?ZzY2ZVlRL21MMDZGSnNibTAvWDVBbjFuUFd5OWZieGY1QzYzM1RBbFFRdHVs?=
 =?utf-8?B?RHNxNTdJM0dad2pjVXc3bGpLbGRGYXVoMmtDSThpaitnT0J5K0lZTmw5b0V5?=
 =?utf-8?B?ckZWTkxpSUpWTmhoNWdjWi9jaWtUQU5LRnN1UFhXKzlKSVVYMm5nR0ZYb2g1?=
 =?utf-8?Q?+FJIDXKktDiLmvKc=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b4933588-26ac-4325-ec01-08de58185222
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2026 11:37:41.3124
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pnRpk5KanmqenUe02NpYwKnwGZ19S5r4xIzc53PO9k8rmHYmI+LZe0wi4Szb/8aebWNnMsyVJDkABrzE/CcYWkGcvVRF7/54qp2k3mKVqFKV7tIEfwNvN+jasJq7zR7E
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB7781
X-Spamd-Result: default: False [1.64 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[nokia-bell-labs.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-251462-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,nvidia.com,vger.kernel.org,lwn.net,kernel.org,google.com,gmail.com,mojatatu.com,networkplumber.org,resnulli.us,davemloft.net,lunn.ch,fiberby.net,nokia-bell-labs.com,cablelabs.com,ericsson.com,apple.com,gmx.at,comcast.com];
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
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: BF17E51BD4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBFcmljIER1bWF6ZXQgPGVkdW1h
emV0QGdvb2dsZS5jb20+IA0KPiBTZW50OiBUdWVzZGF5LCBKYW51YXJ5IDIwLCAyMDI2IDEyOjE4
IFBNDQo+IFRvOiBDaGlhLVl1IENoYW5nIChOb2tpYSkgPGNoaWEteXUuY2hhbmdAbm9raWEtYmVs
bC1sYWJzLmNvbT4NCj4gQ2M6IHBhYmVuaUByZWRoYXQuY29tOyBwYXJhdkBudmlkaWEuY29tOyBs
aW51eC1kb2NAdmdlci5rZXJuZWwub3JnOyBjb3JiZXRAbHduLm5ldDsgaG9ybXNAa2VybmVsLm9y
ZzsgZHNhaGVybkBrZXJuZWwub3JnOyBrdW5peXVAZ29vZ2xlLmNvbTsgYnBmQHZnZXIua2VybmVs
Lm9yZzsgbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsgZGF2ZS50YWh0QGdtYWlsLmNvbTsgamhzQG1v
amF0YXR1LmNvbTsga3ViYUBrZXJuZWwub3JnOyBzdGVwaGVuQG5ldHdvcmtwbHVtYmVyLm9yZzsg
eGl5b3Uud2FuZ2NvbmdAZ21haWwuY29tOyBqaXJpQHJlc251bGxpLnVzOyBkYXZlbUBkYXZlbWxv
ZnQubmV0OyBhbmRyZXcrbmV0ZGV2QGx1bm4uY2g7IGRvbmFsZC5odW50ZXJAZ21haWwuY29tOyBh
c3RAZmliZXJieS5uZXQ7IGxpdWhhbmdiaW5AZ21haWwuY29tOyBzaHVhaEBrZXJuZWwub3JnOyBs
aW51eC1rc2VsZnRlc3RAdmdlci5rZXJuZWwub3JnOyBpakBrZXJuZWwub3JnOyBuY2FyZHdlbGxA
Z29vZ2xlLmNvbTsgS29lbiBEZSBTY2hlcHBlciAoTm9raWEpIDxrb2VuLmRlX3NjaGVwcGVyQG5v
a2lhLWJlbGwtbGFicy5jb20+OyBnLndoaXRlQGNhYmxlbGFicy5jb207IGluZ2VtYXIucy5qb2hh
bnNzb25AZXJpY3Nzb24uY29tOyBtaXJqYS5rdWVobGV3aW5kQGVyaWNzc29uLmNvbTsgY2hlc2hp
cmUgPGNoZXNoaXJlQGFwcGxlLmNvbT47IHJzLmlldGZAZ214LmF0OyBKYXNvbl9MaXZpbmdvb2RA
Y29tY2FzdC5jb207IFZpZGhpIEdvZWwgPHZpZGhpX2dvZWxAYXBwbGUuY29tPg0KPiBTdWJqZWN0
OiBSZTogW1BBVENIIHY5IG5ldC1uZXh0IDEzLzE1XSB0Y3A6IGFjY2VjbjogYWRkIHRjcGlfZWNu
X21vZGUgYW5kIHRjcGlfb3B0aW9uMiBpbiB0Y3BfaW5mbw0KPiANCj4gDQo+IENBVVRJT046IFRo
aXMgaXMgYW4gZXh0ZXJuYWwgZW1haWwuIFBsZWFzZSBiZSB2ZXJ5IGNhcmVmdWwgd2hlbiBjbGlj
a2luZyBsaW5rcyBvciBvcGVuaW5nIGF0dGFjaG1lbnRzLiBTZWUgdGhlIFVSTCBub2suaXQvZXh0
IGZvciBhZGRpdGlvbmFsIGluZm9ybWF0aW9uLg0KPiANCj4gDQo+IA0KPiBPbiBNb24sIEphbiAx
OSwgMjAyNiBhdCA3OjU54oCvUE0gPGNoaWEteXUuY2hhbmdAbm9raWEtYmVsbC1sYWJzLmNvbT4g
d3JvdGU6DQo+ID4NCj4gPiBGcm9tOiBDaGlhLVl1IENoYW5nIDxjaGlhLXl1LmNoYW5nQG5va2lh
LWJlbGwtbGFicy5jb20+DQo+ID4NCj4gPiBBZGQgMi1iaXQgdGNwaV9lY25fbW9kZSBmZWlsZCB3
aXRoaW4gdGNwX2luZm8gdG8gaW5kaWNhdGUgd2hpY2ggRUNOIA0KPiA+IG1vZGUgaXMgbmVnb3Rp
YXRlZDogRUNOX01PREVfRElTQUJMRUQsIEVDTl9NT0RFX1JGQzMxNjgsIA0KPiA+IEVDTl9NT0RF
X0FDQ0VDTiwgb3IgRUNOX01PREVfUEVORElORy4gVGhpcyBpcyBkb25lIGJ5IHV0aWxpemluZyAN
Cj4gPiBhdmFpbGFibGUgYml0cyBmcm9tIHRjcGlfYWNjZWNuX29wdF9zZWVuIChyZWR1Y2VkIGZy
b20gMTYgYml0cyB0byAyIA0KPiA+IGJpdHMpIGFuZCB0Y3BpX2FjY2Vjbl9mYWlsX21vZGUgKHJl
ZHVjZWQgZnJvbSAxNiBiaXRzIHRvIDQgYml0cykuDQo+ID4NCj4gPiBBbHNvLCBhbiBleHRyYSAy
NC1iaXQgdGNwaV9vcHRpb25zMiBmaWVsZCBpcyBpZGVudGlmaWVkIHRvIHJlcHJlc2VudCANCj4g
PiBuZXdlciBvcHRpb25zIGFuZCBjb25uZWN0aW9uIGZlYXR1cmVzLCBhcyBhbGwgOCBiaXRzIG9m
IHRjcGlfb3B0aW9ucyANCj4gPiBmaWVsZCBoYXZlIGJlZW4gdXNlZC4NCj4gPg0KPiA+IFNpZ25l
ZC1vZmYtYnk6IENoaWEtWXUgQ2hhbmcgPGNoaWEteXUuY2hhbmdAbm9raWEtYmVsbC1sYWJzLmNv
bT4NCj4gPiBDby1kZXZlbG9wZWQtYnk6IE5lYWwgQ2FyZHdlbGwgPG5jYXJkd2VsbEBnb29nbGUu
Y29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IE5lYWwgQ2FyZHdlbGwgPG5jYXJkd2VsbEBnb29nbGUu
Y29tPg0KPiANCj4gQXJlIHlvdSBzdXJlIE5lYWwgQ2FyZHdlbGwgcmVhbGx5IGlzIG9rIHdpdGgg
dGhpcyBwYXRjaCwgc2F3IGl0IGFuZCBnYXZlIGhpcyBTT0IgPw0KPiANCj4gPiAtLS0NCj4gDQo+
ID4gIHN0cnVjdCB0Y3BfaW5mbyB7DQo+ID4gICAgICAgICBfX3U4ICAgIHRjcGlfc3RhdGU7DQo+
ID4gICAgICAgICBfX3U4ICAgIHRjcGlfY2Ffc3RhdGU7DQo+ID4gQEAgLTMxNiwxNSArMzM0LDE3
IEBAIHN0cnVjdCB0Y3BfaW5mbyB7DQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAqIGluIG1pbGxpc2Vjb25kcywgaW5jbHVkaW5nIGFueQ0KPiA+ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKiB1bmZpbmlzaGVkIHJlY292ZXJ5Lg0K
PiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKi8NCj4gPiAtICAg
ICAgIF9fdTMyICAgdGNwaV9yZWNlaXZlZF9jZTsgICAgLyogIyBvZiBDRSBtYXJrcyByZWNlaXZl
ZCAqLw0KPiA+ICsgICAgICAgX191MzIgICB0Y3BpX2Vjbl9tb2RlOjIsDQo+ID4gKyAgICAgICAg
ICAgICAgIHRjcGlfYWNjZWNuX29wdF9zZWVuOjIsDQo+ID4gKyAgICAgICAgICAgICAgIHRjcGlf
YWNjZWNuX2ZhaWxfbW9kZTo0LA0KPiA+ICsgICAgICAgICAgICAgICB0Y3BpX29wdGlvbnMyOjI0
Ow0KPiA+ICsgICAgICAgX191MzIgICB0Y3BpX3JlY2VpdmVkX2NlOyAgICAvKiAjIG9mIENFIG1h
cmtlZCBzZWdtZW50cyByZWNlaXZlZCAqLw0KPiA+ICAgICAgICAgX191MzIgICB0Y3BpX2RlbGl2
ZXJlZF9lMV9ieXRlczsgIC8qIEFjY3VyYXRlIEVDTiBieXRlIGNvdW50ZXJzICovDQo+ID4gICAg
ICAgICBfX3UzMiAgIHRjcGlfZGVsaXZlcmVkX2UwX2J5dGVzOw0KPiA+ICAgICAgICAgX191MzIg
ICB0Y3BpX2RlbGl2ZXJlZF9jZV9ieXRlczsNCj4gPiAgICAgICAgIF9fdTMyICAgdGNwaV9yZWNl
aXZlZF9lMV9ieXRlczsNCj4gPiAgICAgICAgIF9fdTMyICAgdGNwaV9yZWNlaXZlZF9lMF9ieXRl
czsNCj4gPiAgICAgICAgIF9fdTMyICAgdGNwaV9yZWNlaXZlZF9jZV9ieXRlczsNCj4gPiAtICAg
ICAgIF9fdTE2ICAgdGNwaV9hY2NlY25fZmFpbF9tb2RlOw0KPiA+IC0gICAgICAgX191MTYgICB0
Y3BpX2FjY2Vjbl9vcHRfc2VlbjsNCj4gPiAgfTsNCj4gDQo+IHRjcF9pbmZvIGlzIEFCSS4NCj4g
DQo+IFdlIGNhbiBub3QgYWRkL3JlbW92ZSBmaWVsZHMgaW4gdGhlIG1pZGRsZS4NCj4gDQo+IFlv
dSBtdXN0IGFkZCBmaWVsZHMgYXQgdGhlIGVuZCBvZiBpdCBvbmx5Lg0KDQpTdXJlLCBJIHdpbGwg
dXBkYXRlIHRoaXMgaXMgdGhlIG5leHQgdmVyc2lvbiBhbmQgc3VibWl0IG5ldyBjb3JyZXNwb25k
aW5nIHBhdGNoIHRvIHBhY2tldGRyaWxsIChhZnRlciB0aGlzIHBhdGNoIGlzIGFjY2VwdGVkLikN
Cg0KQ2hpYS1ZdQ0K

