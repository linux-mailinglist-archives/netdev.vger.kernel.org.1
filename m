Return-Path: <netdev+bounces-17735-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA78C752F04
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 03:56:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17648281FD2
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 01:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAB9B806;
	Fri, 14 Jul 2023 01:56:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D170D7F4
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 01:56:53 +0000 (UTC)
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2131.outbound.protection.outlook.com [40.107.215.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F282D4B;
	Thu, 13 Jul 2023 18:56:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fuHErwalyakFHfHboGFYm6qT229jmymc2QjY0XO7jut+2ms5SdpcGHSAEh98PgP5d/cIya+JPrgy0oUQYMm0CPOoDGy6cu8wGidvAispDEN51TCeageVsvzZyIg4zsA8DmMytYcsP8Q6pBVgpbAkkYHX+4ak2/MTAfL75noYyqR4FSxnI8aA6r9kRZctMD8Tp8VMC0D5dy/ICXMtK/yOZdU3qSsqqB5amxfq48sTVYWZUVRXlKFxeyAgl0XreiW5uy/P4TClA3h3w4I0mCrTVtXU8cWZnnMid2/ZzGzhZ/jkr67FJTjRc2wJFpSB1Sg+2rozuleAaza+7OOHzJyQJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8aaIgYB2UTMQBlUKnFvVCpE7myXM8EFp2WP6Ha0LNwA=;
 b=VcLuy0rgRcu9tddtFYPH/FXsY5+qN9Shb1uNwGcRMXRokTS1kDu6GlbUKyzQM0JK1kr9iILnVyFSZytEndF/Eel0trttEAYBkzvKQwJ6/pDOLfbVY/vOK0RGwHjoG39gbR0y1mEuuXYPdwCqHwAnpTL4GHeU8/AJA6U4gFpgjywnVXs45pT8xuYHG4AXYnOcvCTtvq4Rm7F/5GKxSw2tALP/VPyRPxlJ/JBtwaZB2u879F1UvfSdJGVwwdIaArcK/rQHNjqKH4J2ZmCKY2ATw/Rh2tlpW7CQI+8gnH81y+9cP21vpymCtni071BrmMd7P38sEgbEB/fz1RMuQp95fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8aaIgYB2UTMQBlUKnFvVCpE7myXM8EFp2WP6Ha0LNwA=;
 b=JSftEmtIejLWc3KYzmpRGauUQQA/hOWzZglOdwGeB5cb7V0pigDjrjHe6+r+4NlwmMqFE/OCu6YLHjAesb/J2Z9UlGDtb/DM994v1Y1gMSMVxM/da5nUtcDECMZxzq9JglFksUSPDgWYKMQvWA7d/szQqrKstBvm65j0ktW7a4I/spajL65gmpve1YV9ENVO6FEMRM7ZzzHPZL3+eRqyCdjl0iRxTWinlE306izV72NERkId4bOYl/p+o5SVUR+V886swsGxvh874HvBoOls9ATI029YAa9QXoo1jOC+gn5BJsXcjlJugusPhj9oucDzpp89kJ1vm1jvQpSXyy/VoA==
Received: from SG2PR06MB3743.apcprd06.prod.outlook.com (2603:1096:4:d0::18) by
 SEZPR06MB6532.apcprd06.prod.outlook.com (2603:1096:101:185::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.24; Fri, 14 Jul 2023 01:56:44 +0000
Received: from SG2PR06MB3743.apcprd06.prod.outlook.com
 ([fe80::2a86:a42:b60a:470c]) by SG2PR06MB3743.apcprd06.prod.outlook.com
 ([fe80::2a86:a42:b60a:470c%4]) with mapi id 15.20.6588.027; Fri, 14 Jul 2023
 01:56:44 +0000
From: =?gb2312?B?zfXD9y3I7bz+tdey47y8yvWyvw==?= <machel@vivo.com>
To: Jay Vosburgh <jay.vosburgh@canonical.com>
CC: Andy Gospodarek <andy@greyhouse.net>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Yufeng Mo
	<moyufeng@huawei.com>, Guangbin Huang <huangguangbin2@huawei.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	opensource.kernel <opensource.kernel@vivo.com>
Subject:
 =?gb2312?B?u9i4tDogW1BBVENIIG5ldCB2MV0gbmV0OmJvbmRpbmc6Rml4IGVycm9yIGNo?=
 =?gb2312?B?ZWNraW5nIGZvciBkZWJ1Z2ZzX2NyZWF0ZV9kaXIoKQ==?=
Thread-Topic: [PATCH net v1] net:bonding:Fix error checking for
 debugfs_create_dir()
Thread-Index: AQHZtTsuWo1KTHn7zkWG2SlUku1mrK+32LCAgACpGTA=
Date: Fri, 14 Jul 2023 01:56:44 +0000
Message-ID:
 <SG2PR06MB37437E7EEC1C5E104A432D0DBD34A@SG2PR06MB3743.apcprd06.prod.outlook.com>
References: <20230713033607.12804-1-machel@vivo.com> <24870.1689263355@famine>
In-Reply-To: <24870.1689263355@famine>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SG2PR06MB3743:EE_|SEZPR06MB6532:EE_
x-ms-office365-filtering-correlation-id: a0e37008-64b0-42cf-ea9d-08db840d9377
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 MbeGAMuIA3KaZFCl3SVjnmpSM36wqfSnj3xQRA8N+ptwrPe0+Df/di++YXZHdTGhjTP2BzF2mat7gwKVkWnYhp2ULS6VJqXLWsM+SCGgMCBkr0fygRdHbiuY3AgqmEAZZQzP5ASVYLQXcPhqX4hVSzjtX2UK+fFdBKz3GyaJReb5F3bQQT6YrORHR8Q6rVFzvUT6iKnw9bGy4dnMelRoFMcxqYXchdRfntT91/q2Q+xxxNIXtddKAchUZzc0pjr8TIPYOSq4XqgjLjhAB+YEZ+E4a9GSdV2LW7XgsCn5NWIdFkkBDwPAG3+ghukkmjoGUPXf/1Jdf3SbiBDIizAs3xWVjurMrPiUz/i1FcB8wxsLHbDL1i9A7jAdk6L0oVubCMWCEUUevsZ4wAkZbEluRVDqWICveJWQ3YcShg/uQj6HjXzL3qx8TL62/i8lLa5lEmagNOVr8fUjeludGdDNOTZD3nANpPopZfWlhO8nvb0VNOllrgFAGDfOGjqo5+P78M86AVmchPw7OrSr8816NedHqf5maxdoSsEwH8HFHXiIoNN4Y+xFKQKQ6GUsErmwUKn3LmrkwK0mB5M7hZNuLmcfvPn7VHny6Mi7uDc3pNNCNImDnguVsZDKsCvh43p3
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3743.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(376002)(346002)(136003)(366004)(451199021)(38100700002)(122000001)(38070700005)(478600001)(4326008)(71200400001)(7696005)(86362001)(6916009)(76116006)(54906003)(66556008)(66946007)(64756008)(66476007)(66446008)(966005)(33656002)(9686003)(316002)(41300700001)(186003)(83380400001)(224303003)(85182001)(2906002)(8936002)(107886003)(7416002)(55016003)(5660300002)(52536014)(26005)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?RksyRFBDUWEwMVNxOXNpL3NYa0lGVnVKV1djc0NIWkhoVXZrVnBWeVdiOXR0?=
 =?gb2312?B?T2ZRa2F1NTNyaEZRSWprcGdwNDJsUWRwVlpuSUl3T0dNM1BjWFhqdE5TemZn?=
 =?gb2312?B?di9EYmJTS0h3eTNYOXcwOUVmVnBLWjJWMzZwcHdaYTlhOVcvSkxoQmEvRG82?=
 =?gb2312?B?WnE5UjZodENUamwwNDd3RlltZ2pPSGNhUllYc1BIaFFtQk9idGQwdCtWcmw5?=
 =?gb2312?B?S0lIREJBa3BoZi9WcVFSWXl5RkNJcHp3djc4a0VDMmNNUjladHBsN3VlWXRT?=
 =?gb2312?B?bVh2Q0pvWjVBZDVWQ3RLNjRNT3YwT1h1MGFub0Zrci82UGR1ODc1SzVieHhZ?=
 =?gb2312?B?ZTJZWG15RXdXU3Mza20rVklLaHJjLzlaZXcxZWNIazBiTGdGdGxzUTZKN3R4?=
 =?gb2312?B?cHdZV3RQd01yVHlTMlpsOU54cWJMQkN4U1IwWEkzNHh3VHU4dVdkdmowMW5p?=
 =?gb2312?B?SEJ2RHlMREI0VlJzRVo3YTQ1a1NTS3BEclhUaDJ2dUpZYm9QOEJndHd5bEhE?=
 =?gb2312?B?M3p2cFZwVStaUEhBK1psdXlLeEtyMVNKQ3dOenFJWEswSGZnZE5SU3pRYlhY?=
 =?gb2312?B?cGZublpBUzE3c0ltWkVOdzhVVW5Vd2JYc0oyTlFpbG9jS3VsWUJEMEw5RzJS?=
 =?gb2312?B?SDRiVTZqdFdpalFnc2ZQOXFCWHJXaFErN0lubmthVUsvWmE2eDRJSUw5aWpy?=
 =?gb2312?B?VFJDSDF3Zi9JaGF3bXRTNVlBZlJvQzJIZ3BGSzV5WlpSaURoSWwvMnErV00r?=
 =?gb2312?B?d21CYTdyVUl5UDREWFlKTXNObzBYNmtGSmxTU0ZDSzZuMVNYR2NrOVZ4ZkU0?=
 =?gb2312?B?RDNJNmtqZ0RhR3IvWld5SjhxQmJXZHREK0dSVHB1dDBQN0xiSE5BelBNY3Yr?=
 =?gb2312?B?MVFXZlhXcVRvSVNOeUJmaVFobHZCc1NVMGIxcTVtdG81T2pJZXdTQUREenJW?=
 =?gb2312?B?Rjl5U0ViYWVCbnlRek8zdy9wempySGhVRk0rVnQzZmlRM1dGZUNJUlBXU3NL?=
 =?gb2312?B?SDAyRm5LSW1rT0tCMXNhbklSVktiYlF0ZlpvdXhCODU0bTVMQUs5aWVjOFRi?=
 =?gb2312?B?WmRMMGZXODZOK0NYeitSYWx1eEx6QnB0NzEydjAvcXUySElzUFVmM2RnSnE4?=
 =?gb2312?B?TFIxa3VPam01aFQrTTFwNklsOSt0R3NRMUhBY0RVNVp4UnhNUHZKOVJMTE9K?=
 =?gb2312?B?OFQyRUxOaXlzRVdVSEpXaURJaVM3OGd4MSt5RE9tcVFOdGVnU0NxKzR5RkdC?=
 =?gb2312?B?QWdqbE1kVlpJaXYrb0RERW5lejZpM2xDUWZIYlN4a1pUa29mSVRETXRxQ2E5?=
 =?gb2312?B?TlFOeVVveVE5OVE0Z2VOU3N2dzRtSzVQaHphL1haVlNiaU5neTlVS0pYOEZW?=
 =?gb2312?B?WXRrQlJvaHFtZFoxMHc3Y2hyblZ6ZGRxeEVyd3JwQWUyd0U0MG5UaWpNckgx?=
 =?gb2312?B?bDM2SWR4NzdzaFJvc25RbTNsVVhLalNrQmpnMjZocjU3Q0RBN3BGbEZzK1FF?=
 =?gb2312?B?RnJycWVXSFFVOWViR0h3a3Z3TmtlMEpFdk9OcHR5bS9kZndDMWlHOTlpTEU3?=
 =?gb2312?B?MXlhbU41TEhWb2RMTWw5eVo4VHdFdm1PVXJjblZrckhpZG5EL2ZZSFFPNW41?=
 =?gb2312?B?NHQ3QTZxa2tQeWt2eEc5WGFtc2xKK3pzcEl4QVhENlpmb2E5R1RjUHg1K2J5?=
 =?gb2312?B?V1BLV0hjTExKMUhSeUlpNk5qd1hBU3pFb3lSSWtsN2xsVTJFRDJkcU95MDhH?=
 =?gb2312?B?NittdlIvK3VxRGlMMWt4MktaOFBzNmdTK2tMeHpkbi9UN2IreFV3TUlZcWlu?=
 =?gb2312?B?ZzVXOHZ1NHBUSEJnNWhPVXlDWkdMQ00wT2hWZG5HS0FjSWxjcVhzeUdsOTBH?=
 =?gb2312?B?UWZXNHIzbkpaVTkrR05qWDJ4NXBxaExxYWN4M3IzbnQ5VDY2ek5id1FYZ1Nw?=
 =?gb2312?B?cDdiT2Rtd04vK2xMOG9MRllJdHAyOGZXazVJMjNOSmdxSmRaNzc0RFBLODhQ?=
 =?gb2312?B?d1RjdXBCcjdoK2Uzc2h0aHZtaWVOcm9EV2dINmdJUlRFemV5eEdaWE1aLzgy?=
 =?gb2312?B?WjlFUnltNGJ5RytHUkpZaFBZUlNlQmVVQXU5dWQ5a24wTThhdlpSVmdBMDh5?=
 =?gb2312?Q?I0So=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3743.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0e37008-64b0-42cf-ea9d-08db840d9377
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2023 01:56:44.6553
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fK/bh5FZHazYRStNCNLZuMMw+eT1LcP6xriE3emPOsEl7a136I9EJjNo2pZkji7hMs8QSFa/GGlBtW6pnCRyrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6532
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

SSB0aGluayB3ZSBjYW4gcmVtb3ZlIHRoZSBjaGVjayBvbiBpdCwgZG9uJ3QgeW91IGFncmVlPyBN
YXliZSBJIHNob3VsZCByZXN1Ym1pdCBhIG5ldyBwYXRjaA0KUmVnYXJkcw0KV2FuZyBNaW5nDQoN
Ci0tLS0t08q8/tStvP4tLS0tLQ0Kt6K8/sjLOiBKYXkgVm9zYnVyZ2ggPGpheS52b3NidXJnaEBj
YW5vbmljYWwuY29tPiANCreiy83KsbzkOiAyMDIzxOo31MIxM8jVIDIzOjQ5DQrK1bz+yMs6IM31
w/ctyO28/rXXsuO8vMr1sr8gPG1hY2hlbEB2aXZvLmNvbT4NCrOty806IEFuZHkgR29zcG9kYXJl
ayA8YW5keUBncmV5aG91c2UubmV0PjsgRGF2aWQgUy4gTWlsbGVyIDxkYXZlbUBkYXZlbWxvZnQu
bmV0PjsgRXJpYyBEdW1hemV0IDxlZHVtYXpldEBnb29nbGUuY29tPjsgSmFrdWIgS2ljaW5za2kg
PGt1YmFAa2VybmVsLm9yZz47IFBhb2xvIEFiZW5pIDxwYWJlbmlAcmVkaGF0LmNvbT47IFl1ZmVu
ZyBNbyA8bW95dWZlbmdAaHVhd2VpLmNvbT47IEd1YW5nYmluIEh1YW5nIDxodWFuZ2d1YW5nYmlu
MkBodWF3ZWkuY29tPjsgbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIu
a2VybmVsLm9yZzsgb3BlbnNvdXJjZS5rZXJuZWwgPG9wZW5zb3VyY2Uua2VybmVsQHZpdm8uY29t
Pg0K1vfM4jogUmU6IFtQQVRDSCBuZXQgdjFdIG5ldDpib25kaW5nOkZpeCBlcnJvciBjaGVja2lu
ZyBmb3IgZGVidWdmc19jcmVhdGVfZGlyKCkNCg0KWz8/Pz8/Pz8/PyBqYXkudm9zYnVyZ2hAY2Fu
b25pY2FsLmNvbSA/Pz8/Pz8/Pz8gaHR0cHM6Ly9ha2EubXMvTGVhcm5BYm91dFNlbmRlcklkZW50
aWZpY2F0aW9uPz8/Pz8/Pz8/Pz8/P10NCg0KV2FuZyBNaW5nIDxtYWNoZWxAdml2by5jb20+IHdy
b3RlOg0KDQo+VGhlIGRlYnVnZnNfY3JlYXRlX2RpcigpIGZ1bmN0aW9uIHJldHVybnMgZXJyb3Ig
cG9pbnRlcnMsIGl0IG5ldmVyIA0KPnJldHVybnMgTlVMTC4gTW9zdCBpbmNvcnJlY3QgZXJyb3Ig
Y2hlY2tzIHdlcmUgZml4ZWQsIGJ1dCB0aGUgb25lIGluIA0KPmJvbmRfY3JlYXRlX2RlYnVnZnMo
KSB3YXMgZm9yZ290dGVuLg0KPg0KPkZpeCB0aGUgcmVtYWluaW5nIGVycm9yIGNoZWNrLg0KPg0K
PlNpZ25lZC1vZmYtYnk6IFdhbmcgTWluZyA8bWFjaGVsQHZpdm8uY29tPg0KDQogICAgICAgIFNl
ZW1zIGZpbmUgdG8gbWU7IG5vdGUgdGhhdCBhbG1vc3Qgbm9ib2R5IHVzZXMgdGhpcyBhcyBib25k
aW5nIGRlYnVnZnMgaXMgaGlkZGVuIGJlaGluZCAhQ09ORklHX05FVF9OUy4NCg0KQWNrZWQtYnk6
IEpheSBWb3NidXJnaCA8amF5LnZvc2J1cmdoQGNhbm9uaWNhbC5jb20+DQoNCiAgICAgICAgLUoN
Cg0KPkZpeGVzOiA1MjMzMzUxMjcwMWIgKCJuZXQ6IGJvbmRpbmc6IHJlbW92ZSB1bm5lY2Vzc2Fy
eSBicmFjZXMiKQ0KPi0tLQ0KPiBkcml2ZXJzL25ldC9ib25kaW5nL2JvbmRfZGVidWdmcy5jIHwg
MiArLQ0KPiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4N
Cj5kaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvYm9uZGluZy9ib25kX2RlYnVnZnMuYyANCj5iL2Ry
aXZlcnMvbmV0L2JvbmRpbmcvYm9uZF9kZWJ1Z2ZzLmMNCj5pbmRleCA1OTQwOTQ1MjY2NDguLmQ0
YTgyZjI3NmU4NyAxMDA2NDQNCj4tLS0gYS9kcml2ZXJzL25ldC9ib25kaW5nL2JvbmRfZGVidWdm
cy5jDQo+KysrIGIvZHJpdmVycy9uZXQvYm9uZGluZy9ib25kX2RlYnVnZnMuYw0KPkBAIC04OCw3
ICs4OCw3IEBAIHZvaWQgYm9uZF9jcmVhdGVfZGVidWdmcyh2b2lkKSAgew0KPiAgICAgICBib25k
aW5nX2RlYnVnX3Jvb3QgPSBkZWJ1Z2ZzX2NyZWF0ZV9kaXIoImJvbmRpbmciLCBOVUxMKTsNCj4N
Cj4tICAgICAgaWYgKCFib25kaW5nX2RlYnVnX3Jvb3QpDQo+KyAgICAgIGlmIChJU19FUlIoYm9u
ZGluZ19kZWJ1Z19yb290KSkNCj4gICAgICAgICAgICAgICBwcl93YXJuKCJXYXJuaW5nOiBDYW5u
b3QgY3JlYXRlIGJvbmRpbmcgZGlyZWN0b3J5IGluIA0KPiBkZWJ1Z2ZzXG4iKTsgfQ0KPg0KPi0t
DQo+Mi4yNS4xDQo+DQo+DQo=

