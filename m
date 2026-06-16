Return-Path: <netdev+bounces-299730-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fyluHRTRMGqPXgUAu9opvQ
	(envelope-from <netdev+bounces-299730-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 06:29:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D7DD968BE6C
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 06:29:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=altera.com header.s=selector2 header.b="gMM2F/YH";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299730-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299730-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=altera.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E113E3017F89
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 04:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 242E33C9438;
	Tue, 16 Jun 2026 04:29:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010066.outbound.protection.outlook.com [52.101.85.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56B23C8C52;
	Tue, 16 Jun 2026 04:29:04 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781584146; cv=fail; b=WaKuHAXQ5UiRQiz8ab9qVcrgqvG+b4vmw7Xim1n4bYV+6j/Dk3nmuTquakJVXs1jfixTpuSEbvi70XxC0SUzUyX6e2WsabQWukqSY4kB6W2Ra3KzzZfJHlRuvwtVEJBFkJlqAeUhUvj7B8PcGxe8jiakpW29d5cI2EvKb9TsqcY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781584146; c=relaxed/simple;
	bh=KRdcDjX9hqPiVuJsN2skmWcVNTBm3iRK4OODJ/ZJX3g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ImBerYS7s6q0MTM2gn+iSnGWk0bMA35Sjmx4lzf8Or2Df/RyFswkacD46+FQ5Rxe1scNWwdcuavpHMuViIJn8Gr5wW82l1cOql5kGF/eKzxt3QKLulHdDEDVwRHbQhmJfBpqfPH/NJI/zpKNEbwMHpLErcsBSk1/0A/gyufQWNo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=gMM2F/YH; arc=fail smtp.client-ip=52.101.85.66
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KvpKW7PADgE5ogyknnsl21qQH0qe4HxvMy4CHLW03uQz1uYcFPU7TZI0Bt/pFz0MgggkBJmaICaGMyogOGic89lSL1D+8ZeLhh9LGRg3lXz7bGdC3TU1quwDC9q8UiEeNAtffFRTcVy1T8Dqp04diphkY8QIS1E3xTfKOMDyu9DYLqNk4sQs2EcpIwp+fc0eQb1ehzDeCCBk+10LJRFXiO5GGiYsYIQKRWV+IN68so0e+T2kWXR7WPx8xcDC0UQj9LI8fx8UO2Cj5NGPtYRMlcZFRRnRmy93zegEMjPVMgjqsgJ6CaKXOG9wq3txhkE3Z3cD88P+d6B62RKcdpl1Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KRdcDjX9hqPiVuJsN2skmWcVNTBm3iRK4OODJ/ZJX3g=;
 b=nQGjOivmU4n0oVHiy8FlWn0Px17DhjQ5QwYJLVXSLAGZD9x30fpw/Ad6mkdF5WrmjQ0XtXYseQhAutcVUPNIzWXRLICyqKAr7BPRxFh/YaJhJAlv8lxej/7S8eq/d/geCjTckE2bFXIMp6t2rQ/rGJYjj+LPrNHKYfHMKc5R6deF8+JQ+0kdoePius7QQym6PSXOppa0w2MzZoW4SgqH+5VYvboUWutljmMZb9/uRaiiHFOeCxsYVXhQa3itMqyr4L4iqyJ+TCqcvDPeCDC6dLgzlP81SKfph8gEI9BTBul5Z0aP6KQkDEeem3QWenO83HQBxpy+f+ieofj/iHBQCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KRdcDjX9hqPiVuJsN2skmWcVNTBm3iRK4OODJ/ZJX3g=;
 b=gMM2F/YHxBGiBKkRRa6PMPp6MYwcpKLgld00Dxky+R18BQb/y58alrgRINu+UHsWNFqJIFxQZ1s2BP33X4wsFvWvmOiG6dvtYlnmJS2D+0Ph5FCra6MXgpvN6L7qB9rhI18TxE6OXL/n5cTcxrSmWlhutgDkmtGu8d7bBuvMuLUsTECohzdzwFMjPxcR9F4fRfttZcYR7d6uuiyKiQv0Tnvvqclip1uJqZZNozQOVsxtwDgwfsyrG1ACiS6qVF+8do0SabTEqY9AA8TaGE5owbxMl+u/2HdhA4Q+qZs4SEbF3YJuCtbRExZv3ENp77uzLT/yeHuxxuXQo7oo+5Dm2w==
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com (2603:10b6:a03:432::18)
 by PH0PR03MB6333.namprd03.prod.outlook.com (2603:10b6:510:be::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 04:29:02 +0000
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775]) by SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775%6]) with mapi id 15.21.0113.015; Tue, 16 Jun 2026
 04:29:02 +0000
From: "Nazle Asmade, Muhammad Nazim Amirul"
	<muhammad.nazim.amirul.nazle.asmade@altera.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "rmk+kernel@armlinux.org.uk"
	<rmk+kernel@armlinux.org.uk>, "maxime.chevallier@bootlin.com"
	<maxime.chevallier@bootlin.com>, "Jose.Abreu@synopsys.com"
	<Jose.Abreu@synopsys.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] net: stmmac: fix l3l4 filter rejecting unsupported
 offload requests
Thread-Topic: [PATCH v2 2/3] net: stmmac: fix l3l4 filter rejecting
 unsupported offload requests
Thread-Index: AQHc9Mne73T9oR4n7EayRBbsSOPflrY2+q4AgAmtEoA=
Date: Tue, 16 Jun 2026 04:29:02 +0000
Message-ID: <97b3283b-6936-4be8-9b8d-c6644906446f@altera.com>
References:
 <20260605090114.16028-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
 <20260605090114.16028-3-muhammad.nazim.amirul.nazle.asmade@altera.com>
 <20260609174318.3e34e62b@kernel.org>
In-Reply-To: <20260609174318.3e34e62b@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR03MB6964:EE_|PH0PR03MB6333:EE_
x-ms-office365-filtering-correlation-id: 7b8792f0-95d0-4126-23ab-08decb5fcb4b
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|55112099003|38070700021|4133799003|4143699003|22082099003|18002099003|56012099006|11063799006;
x-microsoft-antispam-message-info:
 StxCL8w8NlxmlMd9LgYIBrrERwVhYOksfYUK73ay9JPxrI+VFuMOc6olzNXYw8reQ7bIadkj85+/aF4z8x8tdBi3+zVr8qYcxzGztORF3nn+r68qj8XmDd8pSjKQMgjccHzVUSgrchqSAJWVpwDu+uQccI6+pr+/0I7lo3cV9yr5pQ9jHo/lkEn79aI0PHcNl7XSlV+b6ZzTz4RVC9PVtf9mNLFPOzLA+5C9plSHr3gUBd+/g8YMDGAYn7aY3n41dU9M4sgASDoNJeHnS+vVG0KudiZoz+MUOy5mBfnYAng3M3OmhCCsvqXPYxxEozr6TnToltn3uaVlWJCoTkztOihipceq7StlrwUNQyW4VIxbVFWP7Bkqewish+loOIaMOPaDyviNH37jmqka020UNrNlkVsMeoLH+GmiFLLg1TKMapoeHzwrUqPXA1s36TLelXfci1d3jNeM/FQHXO9Z/DS5zOvJkCl3FEP62CcasTlf9AeLesVT/09CnmZSWltFc+2WImAmetpGJfqyMO9ZsG1BaZV9ZRn9qSgHLtwvE80wlWq8sA+vPhmA+nJmYO/hKFa7bAtYRa5Z5/TaYEW+J0OcA5jUYlaAupgDkZcv6bkRz10XxVhB8eMY56fFZnWUtpdZDblnoP/+qDbVsrNBs43skd67wivMlRMZrB4u+Gqr/wR/mG/97BznZiuh5iB2
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6964.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(55112099003)(38070700021)(4133799003)(4143699003)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dXd3MWdxSVdiZDZqZE9pOUhDZTlkWGowcXdaNk9MbHB2dE9nTlhaUjFlYXc5?=
 =?utf-8?B?V1FrSHN5V05UOTY1dUJCaFAybGRJcWhPVHRZSHpyQ3ZxTFUzelY3SUN1Q3lx?=
 =?utf-8?B?KzlVRFpiYjFDeEp3LzFMTHNoOTJzVUhEdDM4SFdDN051dlBFRE9RT1FFWWpY?=
 =?utf-8?B?N3NoY1FXbnVZQkptR3V2Q080MGdqRm5HOTNkRC9uU2pDVGZSZEl3eXJ1UmVX?=
 =?utf-8?B?WTR3Z0VhRlVHMHM3dVo5c04rVG9kbEtOZ0Z1YUtOOFBiTndmVVNMbkl0TDRi?=
 =?utf-8?B?Zmh1RXk0TkptVGZpT3Fib1JBRjR0TW5ucjZZMGxqOFE5cVZlUEorVDVrM1Jn?=
 =?utf-8?B?NjQ0ZTdMQW01VlVqa29jVTNVSlV1VDhPYitlbXZ1KzROZlIzaHZZZFUwOEJa?=
 =?utf-8?B?NTlXYmxHajlIVFRPMFV2TlpObDZZcThld2MzSEpyWnVrV3pWK1llb3JWNVlC?=
 =?utf-8?B?T2pHb1ViOFhMYWZjdEFTUndxNGx1aGJFMC91Y3lEMHlqaFRxamNZdW1IdXJz?=
 =?utf-8?B?dE5WWDNEd0hBdHBMSlEwbmpQZXhXdlBneTJzbUsxNkdxVThadkhjTVR0RGRN?=
 =?utf-8?B?YWdmYm5OUEVjcFlTYVNWZXZFV2VQQzN6NHhkNWdBbStIUWp6UFNqQnpWcitL?=
 =?utf-8?B?bGViTmJ3UDFqRHV0TWxXK0UzbFNpei9uZkV1bjRXUng4TjNFMXJzZ2ZqTkRv?=
 =?utf-8?B?VHF2clgvQURYZysxNVRhdVoyWkhhYXRMVHhZQ3R1VGh5OXo0emt2RU0xQ0xa?=
 =?utf-8?B?UWVoVWhPT0lEOXBPcnQvN1hqRGcyU0tPK0hueTgwaDZEZk5jdVkyZGtHZGF1?=
 =?utf-8?B?WVVCcENQRU9LTzU2Ui91WlorU0tiU1F2THVSMjFKck8yczl4UjVQZGxJclFF?=
 =?utf-8?B?cjZKMllSTkdWZkR2bnM4RVY1WjRSRlZtSnA1Q2I2c2xrS0J1c3pGN0tzM1dr?=
 =?utf-8?B?VzV4L2doTHUyZStjRWdiMmpxaXFZakRQTURPWFFNckFmazAvNTVPZndvN0Z3?=
 =?utf-8?B?MUgxaFdVYTBIaEpzc3d3cHFIVTJsK2VoYTdEODM3RUs0UFNhanVTWkNvSDJR?=
 =?utf-8?B?b1p1ZjJ4MG9mWVQxYjlmZm15aXBSZVV0YURLb0loRzNaeTVEaU9pbUZlSnpW?=
 =?utf-8?B?d3ZyY3ZYVlR0TEUybHY4eTF5NnIzbmh5TU1pRWQ2T0JSZHp5anVNRUFCQ21V?=
 =?utf-8?B?L0xqci9ZT0RnTkpZc3ZZRGpDRGtkcWtIQU5XZkM0cW5MNTArNVVBcWh5ZmpX?=
 =?utf-8?B?YWpSZk4vVm80QXFvbzRHTnRTckpNNHNFSWh1c1IrdCtzc0ZWOWJUNTd1Mklm?=
 =?utf-8?B?dzN1bjQzSzd1aXc3a2Jpb3NIYUhENDloamkrTlpsV1lONWJ6cWtnUTBFeGd6?=
 =?utf-8?B?ejhnVkljbis1SWxNdEEwSWlYSDhueThiZEdTTkZEaHdDbndvaytzblc1VDN0?=
 =?utf-8?B?MU8ralFjUXdodjdCK2JHbmdMZFp1b1ovQmlVTmJLUUtnbXY1S2V0amVGbWpP?=
 =?utf-8?B?RmpQM1FTVFB6Z1l2REFORXJRVGs1TlN2eTZqOUdZZWJrTCtQM0ozR1NFYnZh?=
 =?utf-8?B?OTR3ZW4zVmk2ZUN3ZW91L2RpZkxhbkpKQUM3M3dOelhKZnlOK2pzcGNRMHpr?=
 =?utf-8?B?S2pIVFp0UklnakdhM0M2ZTZBSENXNTZ0L2IyOVpFcDVNSG13bGtoQUJVZ2VP?=
 =?utf-8?B?UUc3UElJSXFPaFRjVlpuOFM2RlMzQlFsc0JpeklHZ3lzNzYyUVZUeXRJanBl?=
 =?utf-8?B?cVUyZUhpU2Nza0xKdXpoTVMveGNobDRVK1J6TmUzcnNTOGVFS003MmdJaEl6?=
 =?utf-8?B?azM2Y1lZd3BybUxyS2I1UzdkVXVKaVdHdW0ySlp6Ulk5VzN1cCs3Z1lRczJo?=
 =?utf-8?B?MUFma0p2NVk2YjVrVm9DdTNZMGJGZXVLS1hOUGRTZ0NaM3oyWUQxZWIzczR2?=
 =?utf-8?B?UEMyR0FEWEViZU94RGRhNjNRU3JiNWdrc1NNRVE3emk3UXpRUGxFU0M3Tnpz?=
 =?utf-8?B?QnpLeEg5eHpxM2tiYVlqcXkzS2RpQk8xaW9IUGRNbFBFeUNHNU1zcm10S081?=
 =?utf-8?B?bDUydEphcWh1N24wWmlhbHRMSHpIVVFxZk1MemplUlpGQUVqelJVcStRUEZM?=
 =?utf-8?B?V1NWSG9QTFlKSy92ekxFTHUvalZvQVBLbGNnUmdYSEduUU5VV0dBSlRRaXRW?=
 =?utf-8?B?ZVFoREZialVwU3J5bFppSEZXVnlzaUM3UzhCNVpCeXNrRkZYRWpGdUNITnJ6?=
 =?utf-8?B?RzU0UlpNUjAybGlNQXdjNExtMEV4VlA5djJDem9rd0Z0NzJWc0Z4bnQwWWs3?=
 =?utf-8?B?U24ybGpTcW42ek5NNnRsNnFsSFpoWHBGY1EwMjJ4eC9sSmZPKzlXQVRUNjh0?=
 =?utf-8?Q?H+zxbH3PyS3wt7MTESPdUDhf8/FlmoCxqcY8Rr6Z1AYDv?=
x-ms-exchange-antispam-messagedata-1: Ag7twaQMU1IBOA==
Content-Type: text/plain; charset="utf-8"
Content-ID: <AECE87C723AF364D9FA14571DAC360CA@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6964.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b8792f0-95d0-4126-23ab-08decb5fcb4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2026 04:29:02.6070
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GDtSSvQxC8JvVYvmr8d/Zmnf2Ddx2F/PDc4L25hdr1/4/tH+fQiD+3Oy2LPF/vTjaiox+U+hUNVtYvbE0cCKZ104+e6o7BmnPuCo5VcA2CeNrpsKa4iIwVefwzalcZHafo/h0ZbH2UTQmZPmVGmAGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB6333
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[altera.com,reject];
	R_DKIM_ALLOW(-0.20)[altera.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-299730-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:rmk+kernel@armlinux.org.uk,m:maxime.chevallier@bootlin.com,m:Jose.Abreu@synopsys.com,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,m:rmk@armlinux.org.uk,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[muhammad.nazim.amirul.nazle.asmade@altera.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[muhammad.nazim.amirul.nazle.asmade@altera.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[altera.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev,kernel];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,altera.com:dkim,altera.com:email,altera.com:mid,altera.com:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D7DD968BE6C

T24gMTAvNi8yMDI2IDg6NDMgYW0sIEpha3ViIEtpY2luc2tpIHdyb3RlOg0KPiBPbiBGcmksICA1
IEp1biAyMDI2IDAyOjAxOjEzIC0wNzAwDQo+IG11aGFtbWFkLm5hemltLmFtaXJ1bC5uYXpsZS5h
c21hZGVAYWx0ZXJhLmNvbSB3cm90ZToNCj4+ICsgICAgLyogQm90aCBuZXR3b3JrIHByb3RvIGFu
ZCB0cmFuc3BvcnQgcHJvdG8gbm90IHByZXNlbnQgaW4gdGhlIGtleSAqLw0KPj4gKyAgICBpZiAo
IW1hdGNoLm1hc2sgfHwgIShtYXRjaC5tYXNrLT5uX3Byb3RvIHx8IG1hdGNoLm1hc2stPmlwX3By
b3RvKSkNCj4+ICsgICAgICAgICAgICByZXR1cm4gLUVPUE5PVFNVUFA7DQo+PiArDQo+PiArICAg
IC8qIElmIHRoZSBwcm90byBpcyBwcmVzZW50IGluIHRoZSBrZXkgYW5kIGlzIG5vdCBmdWxsIG1h
c2sgKi8NCj4+ICsgICAgaWYgKChtYXRjaC5tYXNrLT5uX3Byb3RvICYmIG1hdGNoLm1hc2stPm5f
cHJvdG8gIT0gRVRIRVJfVFlQRV9GVUxMX01BU0spIHx8DQo+PiArICAgICAgICAobWF0Y2gubWFz
ay0+aXBfcHJvdG8gJiYgbWF0Y2gubWFzay0+aXBfcHJvdG8gIT0gSVBfUFJPVE9fRlVMTF9NQVNL
KSkNCj4+ICsgICAgICAgICAgICByZXR1cm4gLUVPUE5PVFNVUFA7DQo+PiArDQo+PiArICAgIC8q
IE5ldHdvcmsgcHJvdG8gaXMgcHJlc2VudCBpbiB0aGUga2V5IGFuZCBpcyBub3QgSVB2NCAqLw0K
Pj4gKyAgICBpZiAobWF0Y2gubWFzay0+bl9wcm90byAmJiBtYXRjaC5rZXktPm5fcHJvdG8gIT0g
Y3B1X3RvX2JlMTYoRVRIX1BfSVApKQ0KPj4gKyAgICAgICAgICAgIHJldHVybiAtRU9QTk9UU1VQ
UDsNCj4+ICsNCj4+ICsgICAgLyogVHJhbnNwb3J0IHByb3RvIGlzIHByZXNlbnQgaW4gdGhlIGtl
eSBhbmQgaXMgbm90IFRDUCBvciBVRFAgKi8NCj4+ICsgICAgaWYgKG1hdGNoLm1hc2stPmlwX3By
b3RvICYmDQo+PiArICAgICAgICBtYXRjaC5rZXktPmlwX3Byb3RvICE9IElQUFJPVE9fVENQICYm
DQo+PiArICAgICAgICBtYXRjaC5rZXktPmlwX3Byb3RvICE9IElQUFJPVE9fVURQKQ0KPj4gKyAg
ICAgICAgICAgIHJldHVybiAtRU9QTk9UU1VQUDsNCj4NCj4gUGxlYXNlIGFkZCBleHRhY2sgbWVz
c2FnZXMgdG8gbGV0IHVzZXIga25vdyB3aGljaCBwYXJ0IG9mIHRoZSBtYXRjaCBpcw0KPiB1bnN1
cHBvcnRlZC4gRXh0YWNrIHBvaW50ZXIgaXMgc29tZXdoZXJlIGluc2lkZSBzdHJ1Y3QgZmxvd19j
bHNfb2ZmbG9hZA0KPg0KPiBGV0lXIFNhc2hpa28gcG9pbnRzIG91dCBhIGJ1bmNoIG9mIG90aGVy
IHBvdGVudGlhbCBpc3N1ZXMsIG5vdCBzdXJlIGlmDQo+IHRoZXkgbWF0dGVyDQo+IGh0dHBzOi8v
c2FzaGlrby5kZXYvIy9wYXRjaHNldC8yMDI2MDYwNTA5MDExNC4xNjAyOC0yLW11aGFtbWFkLm5h
emltLmFtaXJ1bC5uYXpsZS5hc21hZGVAYWx0ZXJhLmNvbQ0KSGkgSmFrdWIsDQpUaGFuayB5b3Ug
Zm9yIHRoZSByZXZpZXchIEFmdGVyIGdvaW5nIHRocm91Z2ggdGhlIFNoYXNoaWtvIHJldmlldywg
dGhlcmUNCmFyZSBzb21lIHRoYXQgdmFsaWQgYW5kIHJlbGF0ZWQuIEl0IHdhcyBxdWl0ZSBoZWxw
ZnVsISBIZXJlIGFyZSB0aGUNCmNoYW5nZXMgaW4gdjMgb2YgcGF0Y2ggMi8zOg0KMS4gQWRkZWQg
ZXh0YWNrIG1lc3NhZ2VzIHRvIGFsbCBmb3VyIC1FT1BOT1RTVVBQIHJldHVybiBwYXRocyBpbg0K
ICAgIHRjX2FkZF9iYXNpY19mbG93KCkgc28gdXNlcnMga25vdyBleGFjdGx5IHdoaWNoIHBhcnQg
b2YgdGhlIG1hdGNoDQogICAgaXMgdW5zdXBwb3J0ZWQuDQoyLiBGaXhlZCBhIGJ1ZyBpbiB2Mjog
dXNpbmcgYnJlYWsgd2hlbiAtRU9QTk9UU1VQUCB3YXMgcmV0dXJuZWQNCiAgICBzaWxlbnRseSBk
aXNjYXJkZWQgdGhlIGVycm9yIG9uIEZMT1dfQ0xTX1JFUExBQ0UgLSBlbnRyeS0+aW5fdXNlDQog
ICAgaXMgYWxyZWFkeSB0cnVlIG9uIHJlcGxhY2UsIHNvIHRjX2FkZF9mbG93KCkgd291bGQgZmFs
bCB0aHJvdWdoDQogICAgYW5kIHJldHVybiAwIChzdWNjZXNzKSBmb3IgYW4gdW5zdXBwb3J0ZWQg
cnVsZS4gRml4ZWQgYnkgcmV0dXJuaW5nDQogICAgcmV0IGRpcmVjdGx5IGluc3RlYWQuDQpQYXRj
aGVzIDEvMyBhbmQgMy8zIGFyZSB1bmNoYW5nZWQuDQoNClBvc3RlZCBwYXRjaCBzZXQgd2l0aCB0
aGUgdXBkYXRlcyBhYm92ZS4NCg0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjYwNjE2
MDQyNjU1Ljc3ODItMS1tdWhhbW1hZC5uYXppbS5hbWlydWwubmF6bGUuYXNtYWRlQGFsdGVyYS5j
b20vDQoNCg0KQlIsDQpOYXppbQ0K

