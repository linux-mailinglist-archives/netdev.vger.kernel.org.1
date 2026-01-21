Return-Path: <netdev+bounces-252039-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qA5WL6IpcWniewAAu9opvQ
	(envelope-from <netdev+bounces-252039-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 20:31:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8876E5C385
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 20:31:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7A63836746E
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 19:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8C913B8BB5;
	Wed, 21 Jan 2026 19:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="noY66glT"
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011034.outbound.protection.outlook.com [40.107.130.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9344A33033F;
	Wed, 21 Jan 2026 19:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769022499; cv=fail; b=BiwewKKF/gNw0TfGi1pT5L8QIZ6Tlf7+ck7ca6LWLL5LFbpjBDDdV6s0dkqdJSJ1cdrIpzxkzZzT0IkMJzkU/VqqsUv0hS8gcRkUQfgK82Up5g5pDMZLfk9IcmZ0EYkprZ0LT/bFkaziSXZjlQlkWr1pJfmQZZJVz0QPxiJvwGg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769022499; c=relaxed/simple;
	bh=UwFz6Glr7sQHUF0gUzpkTGvuhiWn+8NWbW7RGc3fZg4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kfp6O4TaqM7i5naIxO+lUv1XRS1+KgcXIfcDPzjaqZhvci+mloKUA97uq0V1/qLLIKNdnJ9wJj2mk9Kg5IOr08KOyu0xs7I2mVFlVw8UP3VB1RtQ2zuuTb0AzUmsrr2bI1J9J7GTmpUTfdDNprqNLT+9QFoh7Y4LY/xE0+uD2QY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=noY66glT; arc=fail smtp.client-ip=40.107.130.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qOMcmVdAiHNwoPAfA2skAub85VlcmmJfJfS0sOMLyoRoFkoPt3qqa2yA3cnjY1putmunMmMp7Ru5CzT+o6LowrcvqMvS+Px7fydAkQCyna3ZIVaSIV3ya2JyPEp3H3tML9aDPwZ19jwj6tnqO37x6O7ilo7Ye9YPzKwQG43E4ZtRhmqqulQnPWWGWwvHki3qbtxlAaDkigu9YWrIHK7wIQ3ULsdvpjjJiO5yoWyD60KNQNbg8ppt1bH9ww1rlcDcfFXFMSuqM8IE+GtbZyiuZxy1PS4bL37SQzRNvctSWynoDcYlEJx+LBbjbGpKvxzVF3MumRdGd3sdWCOC5MXsSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UwFz6Glr7sQHUF0gUzpkTGvuhiWn+8NWbW7RGc3fZg4=;
 b=SPvGX5I0ECneLj9c+GsECcD2DEeA6C46v3T9qZgtc/C1veZLn+m816DqWs4aDC+noOJjr0NbwpZDELETmkQuD+l8FugzhrrOsfmsxmcj9Fp+pNMmT98vM5BmF2g6HRZboYBeLDmBw0gNJR21CLpILVtO3VYdln8KSNVVGZ4hitTD6AYXe3aLEqaAB4NOVVVaDZzmJgnCaZiVJNmxP8mvcreDHB+fClhKinHNazHK/WUWprHfbEDP+xHf/cfnakoc2R+ZYvJf0DVBD3rj3nAhDZTmddMyUEv1lJC3f7Wb7UIc2G+4wKN1j4Y0hJ+5kzrv/EhVLWbguzS/FmVgb4kIQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass action=none
 header.from=nokia-bell-labs.com; dkim=pass header.d=nokia-bell-labs.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UwFz6Glr7sQHUF0gUzpkTGvuhiWn+8NWbW7RGc3fZg4=;
 b=noY66glTBAOVyteXKxBAb+hlP3qZvINJ6eX5tu+058jcd9g6x1xlGeydAdC5/PiKaKO7vA1UOFpc+qtCcwrQa0773w3mNbyuOuJtsUl/4UQANG9ytpPzVOv6Ulj6/z53Ta89xmbBXH8i1WksL1HMEnOpAZ4sUSQmcfrDREKW92XUX3Hf8UG6aNW4u9qHbM+A/OohvqhuKqcmd8kjlNjzriGEao2VOEMkHazAgBn4V/8elIk7++TWGTtHFmgeLMaZzQSrdOjRb/Bv94GHiob09Elwr9qjEkuF0aVePpbKAhZQFM8/hTFFjy6XbQ80qONIEbj4PKC2O9yGlMvZjhTSKg==
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com (2603:10a6:102:133::12)
 by AM9PR07MB7236.eurprd07.prod.outlook.com (2603:10a6:20b:2c3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 19:08:11 +0000
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56]) by PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56%2]) with mapi id 15.20.9520.005; Wed, 21 Jan 2026
 19:08:11 +0000
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
Subject: RE: [PATCH v10 net-next 13/15] tcp: accecn: add tcpi_ecn_mode and
 tcpi_option2 in tcp_info
Thread-Topic: [PATCH v10 net-next 13/15] tcp: accecn: add tcpi_ecn_mode and
 tcpi_option2 in tcp_info
Thread-Index: AQHciuLQI+MPTznDZ0KHV7dDAnFI7LVctt2AgABEDBA=
Date: Wed, 21 Jan 2026 19:08:10 +0000
Message-ID:
 <PAXPR07MB7984C8522D24CC72E1C35D6DA396A@PAXPR07MB7984.eurprd07.prod.outlook.com>
References: <20260121143215.14717-1-chia-yu.chang@nokia-bell-labs.com>
 <20260121143215.14717-14-chia-yu.chang@nokia-bell-labs.com>
 <CANn89iK3DOU4DX4=S-C7cKy-57DemUjToYVpYMT926mjFmyajg@mail.gmail.com>
In-Reply-To:
 <CANn89iK3DOU4DX4=S-C7cKy-57DemUjToYVpYMT926mjFmyajg@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-bell-labs.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR07MB7984:EE_|AM9PR07MB7236:EE_
x-ms-office365-filtering-correlation-id: 85778a4b-5cac-41f1-bffe-08de59206b71
x-ld-processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?TVhjY2NPcUt6bVdjZkJKNTBkazNnaGU5a20yK1ZVQ2FvcEhkN3BnN0dKcHQr?=
 =?utf-8?B?MmVRenB1L0xJK2R5LzRLMTBrNjRJYTdLbEtNcTRWODk3RmdOVFIrNnErK0hR?=
 =?utf-8?B?Z09SMXZHNjJ3ZW9iZzExZk95N0hlMEoweDJKQ25jdDZqT3Rlc044SFptK28w?=
 =?utf-8?B?bWIvbGZxRjY0T1M1NUJuTFBxdy92YTV0RFp5Y1FFVEkzWUFhemJmWGdId012?=
 =?utf-8?B?WkZQenZ5NzB6ZE5Rc0lmWnVIVXlXRERLQjMvTS8ra2QwQUFFSDkxYmYxWGRo?=
 =?utf-8?B?aVYyYnVTYkM0THl2c3Vob283dmdzL0pYREN1NXpYWFY3Q290K0xkMHU2VmxK?=
 =?utf-8?B?VVF6MEJlbWxXYnpreWJ2SkNXSHQyenY1VW1Sc2tWZTJZVmMxc3FZbWtFd1Bj?=
 =?utf-8?B?MXFYQzk1bmRRWkYyUWk4TmJ1ZlVDZytlZlIvY2dXNGRUb3YwdWIzYlRHRVdu?=
 =?utf-8?B?dW9wb3NMVDFpRjFBMVRHbmVXN2UxY0t2OU5XbWtEU3VTK2xWOVhFKy9aOGFX?=
 =?utf-8?B?aFVRTkl6dnBwT3lHb3NzdFdieXI5aWI2dE9ZSi9iQno0U1NXbFMxeU5qalgz?=
 =?utf-8?B?V1YvVlpkVFRHUTFiZVZrTFRRdG9jVjVkVlZKbEdpNmpSTWdUWU1IcGV2OWdO?=
 =?utf-8?B?WEFvYXhpa2lPRTNlY0lORGhyM1g5ZUhQNE1VNGVteVhJNlBycHdaa0huU1B0?=
 =?utf-8?B?aDByN2hlSFRWN2hBZ3ZuSHpLNkZEWThLWkRRUUZjb1gvMjZPT2t0U2V5T1pF?=
 =?utf-8?B?WjlkMXVhbVQvb1dEUVdzTzkrRkdPZjlxOVNidW5KaXNCdDhhekU0Y0tlUzQ4?=
 =?utf-8?B?OEdBSUt1QXk3bElrVm4vZEZ3UDZYTE9XR2R0SjAvYWZsc0pna1g0UkVVSFFh?=
 =?utf-8?B?UWl2dXYvSEhnQS8vNWJ0bndjdlVmcWhVVWQwdjBVMjFvTzhkNmJvRC9mNGth?=
 =?utf-8?B?VlJJTE5rTG1PR1gyRlEvWHphSStDOTkwdldURkppYnFIZDVod01EUDJJNGZT?=
 =?utf-8?B?dVNKaUFxQjcwODczRUJha3VFY0pjU05xN1p5Z1RLS0wrL2p1Sm9pakxlbkRy?=
 =?utf-8?B?QS9udXYzWS9rL3pkZmgybnpHRTZWWW9xeE9MYm5lWndDeExzNXRGcXJsekpU?=
 =?utf-8?B?NURlNytCbTFKN1NxT0xQMzRrMExWY2c5WGsvZHArOTRLYVRRQ0hSS09VeUlP?=
 =?utf-8?B?SHc0dk10UWFmbFA5alNjbEUvYXgySXhQMWJUbHp2c2FwRlpqVkxMMFNNT09W?=
 =?utf-8?B?R0phTmxjYkRxU0FocUJ3VDFtQ1J5MEVOTnNKMHBkaGxvU3Z1RytFZ2lpcWJ3?=
 =?utf-8?B?U05NOFAxaGIrTDRxUlBlaFJrVmRsN0d6am5RUkE1RGh5aXF2Qko4bFhtKy9Z?=
 =?utf-8?B?d1RFS3V6VEp2QUhOWncwUXJ1NXhTOEZlazJ0eGx0UU1rQWpYNmJaYTJRZzE2?=
 =?utf-8?B?OTRWQWVuMW5UWGt6d1dtZkpveGt5Tm12UDBielYxa1dHbG9TMHpBSk1yMTU2?=
 =?utf-8?B?YTF4bGtaQS9xancwRTdnY1NjQVRqYmNvd3FiOTV5Z1hERVRtTjA2MndaL2VB?=
 =?utf-8?B?bk5GenNxTEh5bkgrREFCd2pIckJYdjBtS0g0ZXpmQ0RaSWpsMDhvb0FEY2cr?=
 =?utf-8?B?dXdvYlJVd21ERG9QdEVEZWhkLzNLc0VyWU5VaCtIa2pDdU5Pd3JKcEV0L0dE?=
 =?utf-8?B?M1NHWlNMWHljeG44R1pIcHhqdytXQUhJRjBtTjBxQTFhcWc2RGZQVjN5ZnQ4?=
 =?utf-8?B?bSs5NUdiZGdRZ2VGc3BGQ0hrelI4eGpQd1VsbGVIMDFORmxPMnkzZlRhN3dC?=
 =?utf-8?B?azRnUmZ1ZHRhbngraGxEK0pGTmlKZjFwclk0WVQ5aXZ3WHhZZ0ZDMVk4QzJv?=
 =?utf-8?B?dFdWVHZSNXRvNlZ2eWxKN2Iyb2cyWnkrWGV6V3dYd3pTTFVONVBuQWd6Z2Vz?=
 =?utf-8?B?cjg2THNTZ1BleEt1c0Jlc3MvL2ZtSkl6YmNmeCthTmZaeHJsaEJ6dFpnYkJ3?=
 =?utf-8?B?SFpyK0Q4a0FjZDVZeGZwZHlCNEIzSEZQSzJPSHMzcFdoazVvU0JrdmszKy9L?=
 =?utf-8?B?UEFCZXdrc3ZaWkZlSThrVnFEd3RUVlkvRDd6TTcySis0bWxRMUhVQ1QzdjVG?=
 =?utf-8?B?dEJCa2trYzRnQmhHL0t2Vm1qVUdqQ09ydGJ0S0NoT21KZXNwOUNsaEZyVHY3?=
 =?utf-8?Q?R/Q8ILtRDAcjM0Izo+C0NgI=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR07MB7984.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QzlZbGcrNkJGdlhocERITjRkWjF1TUtZK29SOHFVZ0RsOGJHK1dJME9YVGpD?=
 =?utf-8?B?SmpFdGUyc01WbDhWaEpDbWtRd3l4a3Nyd0x1ZS9SbW02ek1ic3JTQ1VRc3kx?=
 =?utf-8?B?NWt4Mlo2RFNhdDJHdUJDWVorR0lNRFBJVkxDT3o4TVRZS0xnVEFValVPQ1Vl?=
 =?utf-8?B?azRiZDBWak1zc1MybmM0RGNuRWNEY1VDcStnU1RaOFJ5RjVFL1hoemp0T2lp?=
 =?utf-8?B?b2hJcUdLU05XVEFVNDhSeWJuOGI2MUxid0FyZGlQZWFqbnJLd1pER01EV0po?=
 =?utf-8?B?bUJJSXljbWY5RDZlUHp6b1QvTkp4d1VlOGdzNjh6YXQ2RkFsazFqa0wvUzRT?=
 =?utf-8?B?c2NDQWFlVFNWKzZZS2FmQU5qQk5SUHR1NHBnd3ZGdFRpeThOdFhFNm9yajFu?=
 =?utf-8?B?YkxqU3k2UEFXUXNmOS9MQmplSVprclZCNnc2ZmEyZWo2SVM4ekZvWDhzcUxN?=
 =?utf-8?B?RW5qZWxSb3Q4VFhuc1FGZDF3cEUweHpDQWdSVDRJT3V6N01NaXVGcXp3V0VD?=
 =?utf-8?B?KzlsOFNIdnBkY2FXTzFGQjFWMVQxYTRDODdwaTFhVGhHMzRsbG9mNFg1YVJE?=
 =?utf-8?B?cVArSkFyaVc5OXNsTmh5dUdPMkJEMWYvWFI5QXUxWmdDcmNvTTcxOHgyVXZs?=
 =?utf-8?B?RVVWU0Y4THZqeTJCSjhPVW45emt4emJOSll4MXhZOTBjdzg2SnlyU1BYckFD?=
 =?utf-8?B?NkE1aGJpemp6UDRhNGdMK3ZLb2NEb1BabVhFbmpmbWRFTzRoSnkwRGZZZlhh?=
 =?utf-8?B?dHJ3SlNvWWdFVU9sU3VRd3NtQjFnODlsclR4QWplNTRhNUhndVhKV2VJSHpL?=
 =?utf-8?B?NVJPSGdpdko4K21qK2Vkd3RQc2E0WnI1cVV1b2FzYkVxaG5zR1cvU09VWkRX?=
 =?utf-8?B?M2F4ZE1TMW5GY21zblltTkRBR2VwaW5mckRTVHJLN0g4dDVkZnd6RGRYUEhP?=
 =?utf-8?B?VEZtZnRVQS82MXluUXNTcm14Z2gwa0cwSi9qalZ3cVN6Vmp3clNJalhWRGha?=
 =?utf-8?B?aTdXdThubWV4YWFKRGJVcGVYSU9tb1pPTWVQTzQ5NjJuQllGZXBlay9mVlJU?=
 =?utf-8?B?aGxGZWV0OXhkWFF2RFZGUTFkV1lQOEo0SE96a2VLcXlRMDQxamZXOUEydjBj?=
 =?utf-8?B?UG92R2MyWEtSamF5NiswbnBYalduR095dkJseHpwbU5NN0hPOXF3SHRhTmYr?=
 =?utf-8?B?eXA4L3ZWVGxGWEpiVWZPUmVCcklvNU5OZmJMaDkzbVZ1WktmUnlTTWxEV1FQ?=
 =?utf-8?B?djlvanU0WTlrSTMya0VLVnlVbnlMOGlPNDV2MWNIcnZxZTFRSTZQbi9EUnZR?=
 =?utf-8?B?NW1lRU40cjZkREpOV1diRnF0U0F4V08xclR6Z2FzbGluMlBXbkNpMEVQZTh5?=
 =?utf-8?B?SFVybEZ4aXlhK0R1bnZIbDRGU1laSUp0SWlqcVVzaDRTYkEyL1o3ZlB3Q3FO?=
 =?utf-8?B?WUs3eHFrZHZIVmh6TzIyWll5VGNUcmNVQWkxNW1teWc2cmluRnRYbGVyLzVm?=
 =?utf-8?B?cmp4Wi9UUEFIbDZjd1g4S2Y5ZllXU0xoWGpDbnJhTytzeUUwTlJ6d1RuRTU3?=
 =?utf-8?B?M0M0OTRRMWVOZzZaTHJGMm9CT3dTR21INTBBVTg0aW9aMHdIVDc2eXlHTjlT?=
 =?utf-8?B?QSt6ME9xS0ZrVnZmMW1ld3NpOEZ2RU9tV3lucFhPQjZoa0FOa3A4MmIxblMw?=
 =?utf-8?B?WkZuVFdCajVydmpMTldGR1JKN0hUQW1abjQ4aWRCTXJtZjl3NWpvZVFUdG9x?=
 =?utf-8?B?VGVMdFJJWjN3UFJpVkxJT3lXOVAybTYyNnFTcXhhbU1GWmpPeXBRTFRUd2ZT?=
 =?utf-8?B?MmNwWk5TbnIrMHZuNUExY3hOVlM0a0NSWjJvcmoyb3JpODBJU09WSlhVR1Fu?=
 =?utf-8?B?SzI2TzF0dWM3bkFHR0NzRlQvT1VYSjcxSWU2Vi82Mk8vVzZtMmRJTzE2VHhM?=
 =?utf-8?B?VDNwMkMxRisvODlEcnV1b0g1YmtWNEp3aTNOb0xIemJ4cmEyOFFhQ1JaS0ov?=
 =?utf-8?B?dC9wL0tsUlFvYlpTNWU0MTJDMmVIWkovalBUekhhR1ZSNEk4TE9wVWVSZUJP?=
 =?utf-8?B?cEhXZUFRVUt4TEVNUDU0NjJneFAyVklDbDMrd3lNUnRzbTZTa0RVaUd3OFFj?=
 =?utf-8?B?VExKWkUwM1RrbW4zS2FaSGVXQUhzaUxoWDVWc0tic3V2UjE4SG9oT0ZwM2ZT?=
 =?utf-8?B?TDFWQ3QwMHNSQ3g2TndyTXhGVlRiZTYvMitLeGZiOURheWpxampjNjZBUnJI?=
 =?utf-8?B?Kzlob0xjbHZJMU5TSDNBYy96RFZ0UUEza2hMUS81ZmNQaG82cCs3c2VINE01?=
 =?utf-8?B?Sm84SFpTVGlWRnF5VUgzZ3FzMWF2UkxkTW5GTnp3OVV6elI1NkREdzJyek50?=
 =?utf-8?Q?oQbUF84ezmhhEOFE=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 85778a4b-5cac-41f1-bffe-08de59206b71
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2026 19:08:10.9265
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NJdAmP/i3JXVASSmaRldzXvuKpAph7XsNA8t8R54Ky75O7g2iBAxaWbsyp3MIdgbcto/eXo1+oM4pPxXm0qQISoV7aJF9ItumXvGXhjZKlOJV9+0k3l71j7gcSsXZvVt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR07MB7236
X-Spamd-Result: default: False [1.64 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[nokia-bell-labs.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-252039-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 8876E5C385
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBFcmljIER1bWF6ZXQgPGVkdW1h
emV0QGdvb2dsZS5jb20+IA0KPiBTZW50OiBXZWRuZXNkYXksIEphbnVhcnkgMjEsIDIwMjYgMzo1
OCBQTQ0KPiBUbzogQ2hpYS1ZdSBDaGFuZyAoTm9raWEpIDxjaGlhLXl1LmNoYW5nQG5va2lhLWJl
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
dDogUmU6IFtQQVRDSCB2MTAgbmV0LW5leHQgMTMvMTVdIHRjcDogYWNjZWNuOiBhZGQgdGNwaV9l
Y25fbW9kZSBhbmQgdGNwaV9vcHRpb24yIGluIHRjcF9pbmZvDQo+IA0KPiANCj4gQ0FVVElPTjog
VGhpcyBpcyBhbiBleHRlcm5hbCBlbWFpbC4gUGxlYXNlIGJlIHZlcnkgY2FyZWZ1bCB3aGVuIGNs
aWNraW5nIGxpbmtzIG9yIG9wZW5pbmcgYXR0YWNobWVudHMuIFNlZSB0aGUgVVJMIG5vay5pdC9l
eHQgZm9yIGFkZGl0aW9uYWwgaW5mb3JtYXRpb24uDQo+IA0KPiANCj4gDQo+IE9uIFdlZCwgSmFu
IDIxLCAyMDI2IGF0IDM6M+KAr1BNIDxjaGlhLXl1LmNoYW5nQG5va2lhLWJlbGwtbGFicy5jb20+
IHdyb3RlOg0KPiA+DQo+ID4gRnJvbTogQ2hpYS1ZdSBDaGFuZyA8Y2hpYS15dS5jaGFuZ0Bub2tp
YS1iZWxsLWxhYnMuY29tPg0KPiA+DQo+ID4gQWRkIDItYml0IHRjcGlfZWNuX21vZGUgZmVpbGQg
d2l0aGluIHRjcF9pbmZvIHRvIGluZGljYXRlIHdoaWNoIEVDTiANCj4gPiBtb2RlIGlzIG5lZ290
aWF0ZWQ6IEVDTl9NT0RFX0RJU0FCTEVELCBFQ05fTU9ERV9SRkMzMTY4LCANCj4gPiBFQ05fTU9E
RV9BQ0NFQ04sIG9yIEVDTl9NT0RFX1BFTkRJTkcuIFRoaXMgaXMgZG9uZSBieSB1dGlsaXppbmcg
DQo+ID4gYXZhaWxhYmxlIGJpdHMgZnJvbSB0Y3BpX2FjY2Vjbl9vcHRfc2VlbiAocmVkdWNlZCBm
cm9tIDE2IGJpdHMgdG8gMiANCj4gPiBiaXRzKSBhbmQgdGNwaV9hY2NlY25fZmFpbF9tb2RlIChy
ZWR1Y2VkIGZyb20gMTYgYml0cyB0byA0IGJpdHMpLg0KPiA+DQo+ID4gQWxzbywgYW4gZXh0cmEg
MjQtYml0IHRjcGlfb3B0aW9uczIgZmllbGQgaXMgaWRlbnRpZmllZCB0byByZXByZXNlbnQgDQo+
ID4gbmV3ZXIgb3B0aW9ucyBhbmQgY29ubmVjdGlvbiBmZWF0dXJlcywgYXMgYWxsIDggYml0cyBv
ZiB0Y3BpX29wdGlvbnMgDQo+ID4gZmllbGQgaGF2ZSBiZWVuIHVzZWQuDQo+ID4NCj4gPiBTaWdu
ZWQtb2ZmLWJ5OiBDaGlhLVl1IENoYW5nIDxjaGlhLXl1LmNoYW5nQG5va2lhLWJlbGwtbGFicy5j
b20+DQo+ID4gQ28tZGV2ZWxvcGVkLWJ5OiBOZWFsIENhcmR3ZWxsIDxuY2FyZHdlbGxAZ29vZ2xl
LmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBOZWFsIENhcmR3ZWxsIDxuY2FyZHdlbGxAZ29vZ2xl
LmNvbT4NCj4gPiAtLS0NCj4gPg0KPiANCj4gICsNCj4gPiAgc3RydWN0IHRjcF9pbmZvIHsNCj4g
PiAgICAgICAgIF9fdTggICAgdGNwaV9zdGF0ZTsNCj4gPiAgICAgICAgIF9fdTggICAgdGNwaV9j
YV9zdGF0ZTsNCj4gPiBAQCAtMzE2LDE1ICszMzQsMTcgQEAgc3RydWN0IHRjcF9pbmZvIHsNCj4g
PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICogaW4gbWlsbGlzZWNv
bmRzLCBpbmNsdWRpbmcgYW55DQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAqIHVuZmluaXNoZWQgcmVjb3ZlcnkuDQo+ID4gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAqLw0KPiA+IC0gICAgICAgX191MzIgICB0Y3BpX3JlY2VpdmVk
X2NlOyAgICAvKiAjIG9mIENFIG1hcmtzIHJlY2VpdmVkICovDQo+ID4gKyAgICAgICBfX3UzMiAg
IHRjcGlfcmVjZWl2ZWRfY2U7ICAgIC8qICMgb2YgQ0UgbWFya2VkIHNlZ21lbnRzIHJlY2VpdmVk
ICovDQo+ID4gICAgICAgICBfX3UzMiAgIHRjcGlfZGVsaXZlcmVkX2UxX2J5dGVzOyAgLyogQWNj
dXJhdGUgRUNOIGJ5dGUgY291bnRlcnMgKi8NCj4gPiAgICAgICAgIF9fdTMyICAgdGNwaV9kZWxp
dmVyZWRfZTBfYnl0ZXM7DQo+ID4gICAgICAgICBfX3UzMiAgIHRjcGlfZGVsaXZlcmVkX2NlX2J5
dGVzOw0KPiA+ICAgICAgICAgX191MzIgICB0Y3BpX3JlY2VpdmVkX2UxX2J5dGVzOw0KPiA+ICAg
ICAgICAgX191MzIgICB0Y3BpX3JlY2VpdmVkX2UwX2J5dGVzOw0KPiA+ICAgICAgICAgX191MzIg
ICB0Y3BpX3JlY2VpdmVkX2NlX2J5dGVzOw0KPiA+IC0gICAgICAgX191MTYgICB0Y3BpX2FjY2Vj
bl9mYWlsX21vZGU7DQo+ID4gLSAgICAgICBfX3UxNiAgIHRjcGlfYWNjZWNuX29wdF9zZWVuOw0K
PiA+ICsgICAgICAgX191MzIgICB0Y3BpX2Vjbl9tb2RlOjIsDQo+ID4gKyAgICAgICAgICAgICAg
IHRjcGlfYWNjZWNuX29wdF9zZWVuOjIsDQo+ID4gKyAgICAgICAgICAgICAgIHRjcGlfYWNjZWNu
X2ZhaWxfbW9kZTo0LA0KPiA+ICsgICAgICAgICAgICAgICB0Y3BpX29wdGlvbnMyOjI0Ow0KPiA+
ICB9Ow0KPiANCj4gSSBndWVzcyB0aGlzIGlzIGZpbmUsIGlwcm91dGUyIGdvdCBubyBzdXBwb3J0
IHlldCBmb3IgdGNwaV9hY2NlY25fZmFpbF9tb2RlIC8gdGNwaV9hY2NlY25fb3B0X3NlZW4NCj4g
DQo+IFJldmlld2VkLWJ5OiBFcmljIER1bWF6ZXQgPGVkdW1hemV0QGdvb2dsZS5jb20+DQo+IA0K
PiBCVFcsIGFyZSB5b3UgcGxhbm5pbmcgdG8gcGF0Y2ggaXByb3V0ZTIgbWlzYy9zcyBzb29uID8N
Cg0KWWVzLCBhZnRlciB0aGVzZSBwYXRjaGVzIGFyZSBhY2NlcHRlZCBpbiBuZXQtbmV4dCwgd2Ug
cGxhbiB0byBwYXRjaCBuZXcgZmllbGRzIGludG8gaXByb3V0ZTItbmV4dCAmIHBhY2tldGRyaWxs
Lg0KDQpDaGlhLVl1DQo=

