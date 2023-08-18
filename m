Return-Path: <netdev+bounces-28813-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4C7A780C5C
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 15:17:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B88F2822E9
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 13:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCF0D18AF9;
	Fri, 18 Aug 2023 13:17:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6BF717AC1
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 13:17:13 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2136.outbound.protection.outlook.com [40.107.20.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D7252723
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 06:17:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d/tITTz/zoC6BxQc1NxJVScIWOWrtzTbLgROx9lDXdY6+Zau5iI5AQ5EDayLMkRKTzsKz4ENDTkaWWRyFGVIhZYVPc+Nn8BLTXFQnr0wDVnTokP/XwTRGLeLg4cGWusqkDpwYNI0/Su2PKaB3bldb/JRa3JD82ZHEquQGJtXSNH5i2n5fyqtHWOjvoGfCz4vmFImrg/D5Gbncj1iID/ry/oj0bUlKKH20Q+vfD6aGHKayCnOxqoztjmb6zLV+uVVDPSYk6PCx71zcON1O6L+1D2f8M0vJ8RzvksRmWnpPqhY3BUTyfpYdKJ1rjedMmxBGtflB/myy7B41ujzwB+Qjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dSne9QnJUhq3IWIBIURtnvlSVKzRbgqPHWLAKSpCv8E=;
 b=dbtHJdZKq7A1Xw8a3S+fIaJbgYZXHzg/RJmnYhuQcO+lq8xmXoDD+NV7biG1XRuGf+XKYufl5fAkNQqWIQYhjj6feyZG689ULiH3LnwYYFGSMgHN9vmtUenzTAU4KmxFnnr3QrM2gMYykKAVFr7hgkJQ4uBuxN63gRxEJBb+5fcp6pT4OcKggnySA9s2dMLFzu3LAMKEsfxTvbSII/e3t86nOeiyJZ5T9x2nQBsOBIxQUH21/8fqAtsktrPrNHO6cB+81eaI0RoZOXPxvxOqUcUB2ysSaIuIDntMBijW2U23ngqVlRqpmzD9qqTf5ePcOMPGHq8lds4WjtbgYbzALw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=estab.onmicrosoft.com;
 s=selector2-estab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dSne9QnJUhq3IWIBIURtnvlSVKzRbgqPHWLAKSpCv8E=;
 b=CtH455PpPUEWQrnaL+4t7vPRYzLQ4wS37aIUQsdxqq9JXOv5GSOJY8uSlrb4ZtFVa9amwnWat1bKzCWtXB6Lw4g4cfKMXECe0EicrTLmv8ra+HT4XSV8MJDi8AithZS8VMjocWcWBrWbylxJ0l4yiT0888LSPBwMFuIkbRQZfIw=
Received: from DBBP189MB1433.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:1e7::15)
 by DB8P189MB0827.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:fc::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.30; Fri, 18 Aug
 2023 13:17:08 +0000
Received: from DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
 ([fe80::759b:94eb:c2e8:c670]) by DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
 ([fe80::759b:94eb:c2e8:c670%6]) with mapi id 15.20.6678.029; Fri, 18 Aug 2023
 13:17:08 +0000
From: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
To: Ido Schimmel <idosch@idosch.org>, "dsahern@gmail.com" <dsahern@gmail.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [Question]: TCP resets when using ECMP for load-balancing between
 multiple servers.
Thread-Topic: [Question]: TCP resets when using ECMP for load-balancing
 between multiple servers.
Thread-Index: AQHZz7ZFUs0IEyK82U29eJBQITrblq/us9eAgAEFOCA=
Date: Fri, 18 Aug 2023 13:17:08 +0000
Message-ID:
 <DBBP189MB14338FF989660CDBABE27F67951BA@DBBP189MB1433.EURP189.PROD.OUTLOOK.COM>
References: <20230815201048.1796-1-sriram.yagnaraman@est.tech>
 <ZN5NqZI2PGQ6W+a8@shredder>
In-Reply-To: <ZN5NqZI2PGQ6W+a8@shredder>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DBBP189MB1433:EE_|DB8P189MB0827:EE_
x-ms-office365-filtering-correlation-id: 8095d806-0d6f-4ab7-daf2-08db9fed6cf9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 QxsetDRStL2vKlTBwbx53xhVkHej2Sorti/0Vyl6+Ah8fDRvrpnU/VX1t1EMw/XHTLOKBF/Y5i7nppNernQX+XlcLsC41YbC8jatS6vJ5HWDyo5J47SBl+51wq4wKpadUTFpJs2NdIIAWj3aDKFuZ13oa5AhZAcgSgRtfwKI/21WKT2q47humf4ZznoVCTYXf+pinrd+ZyPILr304R7GrhF6BMWvc8X/wbfE0YgiwK0TnWVg3xDMR5C6batVXxHuLxYcXGV6q2OY+1PHeCmL188qpoYa6kj9FST8W/WT9L3otmrA6s6TvPX/AMPu3D02qmBYm/sInJARZwTLqPVKwendE5YaqZf2hC/zDpviFdGpg76KOoY3eTrrkHN1nRTxsJmXhIdd+0bBdgKJJ33m9t9ca23YIexl93IltS0U0nhH/JB+z45xFXO8ZsudWwgFcDibXb6Zhf14RPiP+p+o4InfXVmiZ10QLU4hm7c7FMHmcQAypsKCoEp6SzfjG7tB8vpTF3KtmeuzWACLCQq2wtM17YunImsOwcXa68yaCkQ3/vj7+DnpQDI58T3pC0HUa/Tj3ywyPYc//hvJwssOmF4MenH06yzZMyuSXpQUNszewoom+LmB/I+oCSEfzj8V
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBP189MB1433.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(346002)(39840400004)(396003)(136003)(186009)(451199024)(1800799009)(33656002)(83380400001)(55016003)(316002)(66476007)(64756008)(66446008)(66556008)(66946007)(110136005)(26005)(2906002)(44832011)(6506007)(7696005)(53546011)(76116006)(9686003)(5660300002)(71200400001)(478600001)(4326008)(122000001)(38100700002)(38070700005)(86362001)(8676002)(8936002)(41300700001)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YkRtbHhvVFdzUFpGeGlIMVJlOGlMR3RhdkF3QVdmUk1EMG0vOWQwWXkrZ1Uy?=
 =?utf-8?B?Q1hoZ25SV3c3NVFVWW5rOTYzVVRBNFJBVjN0YnUxMU5tMWk5dWlQN3ppWmZm?=
 =?utf-8?B?WU1lbW0xSlRsM2czdG82SEpxUjBxOFNUa0xJSXlpM05vQjB3Nkh2bExUc2VJ?=
 =?utf-8?B?eGpvU2cySnEzeml4c09wall3RnA4NStzOTkzQVUvTUdBKzlCVllRV2dBSE52?=
 =?utf-8?B?QWI0RmQrZzJtNW9yMldmSmc0Q0krNi82U3FxaTRUdnlYQk55bUxvREVKTTBu?=
 =?utf-8?B?cE00Qi81OHJXcTI3OGU2YzBoM3JwRldldVFDZDJsVHN0M2Mrb3oydXFlTWww?=
 =?utf-8?B?RjJLVGdoTyttb1hIQ3gzNUxhaUVTaGM5cmRGRW5pc20yMm1rd201SjNBeDhx?=
 =?utf-8?B?R3VoTDh0L256Rkl6TlltRVplOUozM2NIUzRXcUREWnRCU25uQzZqdU96NmJv?=
 =?utf-8?B?aElSUEorN3QwVGk4YzhNVS9rRFpNVk1XQ0ZRcHpGRkd3eHlVYUU5ZENMRmQv?=
 =?utf-8?B?cUtSM1VqUGVHaHpOTlB0bTJITXZ6MGtCdnBRaUdibXZNN0JGMSt0M2dOekU5?=
 =?utf-8?B?SGlLQWY5WmxEUGlrL3FPdlltbk5aVmF5NXZGdzRYelB1SkdmR0dJUHhSektR?=
 =?utf-8?B?dDdVbFgzVi9paXdId3F0VkRLbFBwOUJzdnhWNVZlSTEzellEeG05VEJYbnlo?=
 =?utf-8?B?MGV3VHByOVpOWHY3QlJ2ZnphRUdVeE5FZ3ptRUFkcnhxUFZOYjZONDg2T1Jo?=
 =?utf-8?B?VUdhaTNyVkZWOThnT3YrZ2xyQ1JVSVMwZENVcTV4VVJlUG16WHprOEdHNUlB?=
 =?utf-8?B?VlJwNHVmQ29EWGFqbEhkSDduV25qbHlGUjFHSHpBTXNKaDJPcEVsWkpaOEh2?=
 =?utf-8?B?YVdscmxEM1grRkpYNFA0OWhDQmgyQ2c1ODB0c0EvYVdkbnFzUlFwaTRmMUxI?=
 =?utf-8?B?NU8vb0RUcWYxSEVxOXNiUjluTS8raFgvdFBiU3JNcUU1UDNXSkRKUEJzSVk2?=
 =?utf-8?B?bEd3ZVZvY01vK0xqL2RQRFo3SWtwQVA1ZzVMd3dFdmZCNnNpd3Y0UmEvREp0?=
 =?utf-8?B?OUNSSjYvSGpQTi9BUzZDZ1pxeHEveVplZ1BEZVBKMXZQSUJMS0lXT1VIREs4?=
 =?utf-8?B?WVhLdm5idjhvT0ZMN2lpdzBMd2Vua2x1YXA0ZGYrVi9IblgxdUZQZGp2a1h5?=
 =?utf-8?B?ckl1Nk9zdy9kaXh0bXFTNmE5MitFdWgwdHhXbncrZVBlVjhBalFiaGZ2emUy?=
 =?utf-8?B?Z2p4QjJjNHJVVzJqZmtkeXZxQmFUcFY4Zng3bDN0L1ZZbUNQMzZIU2JiSmN1?=
 =?utf-8?B?UnpldjJFRGlOQ0VON0E3R3pLcExNNTZjRGFUNEFKTi94TlpMN0NTRG9lS1g5?=
 =?utf-8?B?bWx0eE9uL2NWcGVJbzJ5bEg1dWZJUHlwY1FIRU9UbDI4QzN4SXBJaGhVY1lH?=
 =?utf-8?B?OG1PMjRqV0FiOFVDY1oreHI2YmlPNG1sWHY3YVZ2eGFjQkU2MWwzOFRRa2dh?=
 =?utf-8?B?NGEyU0JkSFVwNm5mQm1PL0ZtRCtMMUdZSDYwa0V1dG9ldWcyUnIwL0R5aXMv?=
 =?utf-8?B?blF2YThqeUhoL2F2NEZNVnZoL2ptZWwrRllvUzd0ZWw0T1oxTWlvb2Jlb0NZ?=
 =?utf-8?B?Y0hiVHZPN3g4dHpDQUdlVlFpcjJYa1FlM29tcUo4THJuMlZkTngwZUt4eDBu?=
 =?utf-8?B?RU0vYVB2WTdqMjV0bXd3eGlERkl3L0VqUWxRRFUzcGd2aFgvTS9DdUxzaERW?=
 =?utf-8?B?dlpTb1Ixelo4TThMSXN1N08ySUxyTjdjL2NEckdub1BwMENHL3RpR1ZLcW1o?=
 =?utf-8?B?VWd6MWFlUi9nTWZyWlV4ckVsbWpmNmg3K2NZcXM4ZnM2N3A0VU9aQTNERWtV?=
 =?utf-8?B?M2FnMm1oSkJtM0RacnFxOUdBaXZRU2xnWFNvR3lsZVVtT0VjZXNUdDRWTnFa?=
 =?utf-8?B?TndtSldObGU0YkNUTzZwSkE0aERMbmFJT29CRnFJdzhFQW9md3pWek9kSHow?=
 =?utf-8?B?Q0x2QjlMVVViMFVyc2xGQlpIbUcvRDE0VllOZEpXSWZyS2Jkc3RiNTlyeWpK?=
 =?utf-8?B?YW9MZ1lpV0FhU21mT3o1cTkyUnIvVFIzY0V6czh4MmVRU1Y0S25RamJJdnd1?=
 =?utf-8?Q?mrkupAQtZg23rcDG3Fwj19aOB?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 8095d806-0d6f-4ab7-daf2-08db9fed6cf9
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2023 13:17:08.6877
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0IDbM9SAQQC+fUx5NaRoqbNKG0jBDfIT+FWMH5sHrLRV6NB24PaxwbSMs5WqTlM6m264ISwc5vS3tjX+P6gzB5XuzTzG1iEwpIvTvyogAPw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8P189MB0827
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

SGkgSWRvLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IElkbyBTY2hp
bW1lbCA8aWRvc2NoQGlkb3NjaC5vcmc+DQo+IFNlbnQ6IFRodXJzZGF5LCAxNyBBdWd1c3QgMjAy
MyAxODo0MQ0KPiBUbzogU3JpcmFtIFlhZ25hcmFtYW4gPHNyaXJhbS55YWduYXJhbWFuQGVzdC50
ZWNoPjsgZHNhaGVybkBnbWFpbC5jb207DQo+IHBhYmVuaUByZWRoYXQuY29tDQo+IENjOiBuZXRk
ZXZAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUXVlc3Rpb25dOiBUQ1AgcmVzZXRz
IHdoZW4gdXNpbmcgRUNNUCBmb3IgbG9hZC1iYWxhbmNpbmcNCj4gYmV0d2VlbiBtdWx0aXBsZSBz
ZXJ2ZXJzLg0KPiANCj4gKyBEYXZpZCwgUGFvbG8NCj4gDQo+IE9uIFR1ZSwgQXVnIDE1LCAyMDIz
IGF0IDEwOjEwOjQ4UE0gKzAyMDAsIFNyaXJhbSBZYWduYXJhbWFuIHdyb3RlOg0KPiA+IEFsbCBw
YWNrZXRzIGluIHRoZSBzYW1lIGZsb3cgKEwzL0w0IGRlcGVuZGluZyBvbiBtdWx0aXBhdGggaGFz
aA0KPiA+IHBvbGljeSkgc2hvdWxkIGJlIGRpcmVjdGVkIHRvIHRoZSBzYW1lIHRhcmdldCwgYnV0
IGFmdGVyIFswXSB3ZSBzZWUNCj4gPiBzdHJheSBwYWNrZXRzIGRpcmVjdGVkIHRvd2FyZHMgb3Ro
ZXIgdGFyZ2V0cy4gVGhpcywgZm9yIGluc3RhbmNlLA0KPiA+IGNhdXNlcyBSU1QgdG8gYmUgc2Vu
dCBvbiBUQ1AgY29ubmVjdGlvbnMuIFRoaXMgaGFwcGVucyBvbiBhIHN0YXRpYw0KPiA+IHNldHVw
LCB3aXRoIG5vIGNoYW5nZXMgdG8gdGhlIG5leHRob3BzLCBzbyB0aGVyZSBpcyBubyBoYXNoIHNw
YWNlDQo+IHJlYXNzaWdubWVudC4NCj4gDQo+IFdoaWNoIG11bHRpcGF0aCBoYXNoIHBvbGljeSBh
cmUgeW91IHVzaW5nPyBJIGd1ZXNzIHRoZSBpc3N1ZSBpcyBtb3JlIHZpc2libGUNCj4gd2l0aCBM
NCBhcyBpcF9jYW5fdXNlX2hpbnQoKSBhdCBsZWFzdCBtYWtlcyBzdXJlIHRoZSBkZXN0aW5hdGlv
biBJUCBpcyB0aGUgc2FtZQ0KPiBiZWZvcmUgdXNpbmcgdGhlIGhpbnQuDQoNClllcywgSSBhbSB1
c2luZyBMNCBtdWx0aXBhdGggaGFzaCBwb2xpY3kuIEJ1dCBJIHRoaW5rIHRoZSBwcm9ibGVtIHdp
bGwgYmUgc2VlbiBldmVuIG9uIEwzLCBpZiB0aGUgc291cmNlIGFkZHJlc3NlcyBhcmUgZGlmZmVy
ZW50Lg0KIA0KPiANCj4gPg0KPiA+IElJVUMsIHJvdXRlIGhpbnRzIHdoZW4gdGhlIG5leHQgaG9w
IGlzIHBhcnQgb2YgYSBtdWx0aXBhdGggZ3JvdXANCj4gPiBjYXVzZXMgcGFja2V0cyBpbiB0aGUg
c2FtZSByZWNlaXZlIGJhdGNoIHRvIGJlIHNlbnQgdG8gdGhlIHNhbWUgbmV4dA0KPiA+IGhvcCBp
cnJlc3BlY3RpdmUgb2Ygd2hpY2ggbmV4dGhvcCB0aGUgbXVsdGlwYXRoIGhhc2ggcG9pbnRzIHRv
LiBJIGFtDQo+ID4gbm8gZXhwZXJ0IGluIHRoaXMgYXJlYSwgc28gcGxlYXNlIGxldCBtZSBrbm93
IGlmIHRoZXJlIGlzIGEgc2ltcGxlDQo+ID4gZXhwbGFuYXRpb24gb24gaG93IHRvIGZpeCB0aGlz
IHByb2JsZW0/DQo+ID4NCj4gPiBCZWxvdyBpcyBhIHBhdGNoIHdoaWNoIGhhcyBhIHNlbGZ0ZXN0
IHRoYXQgZGVzY3JpYmVzIHRoZSBwcm9ibGVtIHNldHVwDQo+ID4gYW5kIGEgaGFjayB0byBzb2x2
ZSB0aGUgcHJvYmxlbSBpbiBpcHY0LiBGb3IgaXB2NiwgSSBoYXZlIGp1c3QNCj4gPiBjb21tZW50
ZWQgb3V0IHRoZSBwYXJ0IHRoZSByZXR1cm5zIHRoZSByb3V0ZSBoaW50LCBqdXN0IGZvciB0ZXN0
aW5nLg0KPiANCj4gRGlkIHlvdSBjb25zaWRlciBtYXJraW5nIHRoZSBza2IgaW5zdGVhZCBvZiB0
aGUgcm91dGU/IFNvbWV0aGluZyBsaWtlIFsxXS4NCj4gQ29tcGlsZSB0ZXN0ZWQgb25seS4NCj4g
DQoNClRoYW5rIHlvdSBzbyBtdWNoIGZvciB0aGUgaWRlYS9jb2RlLiANCk5vLCBJIGRpZG4ndCB0
aGluayBvZiB0aGF0LiBJIHdpbGwgdHJ5IHlvdXIgcGF0Y2ggYW5kIGdldCBiYWNrIHdpdGggdGhl
IHJlc3VsdHMuIA0KDQo+IEFsc28sIGFyZSB5b3UgcG9zaXRpdmUgdGhhdCB5b3VyIHNlbGZ0ZXN0
IGZhaWxzIGJlZm9yZSB0aGUgcGF0Y2ggYW5kIHBhc3NlcyBhZnRlcj8NCj4gSXQgaXMgdXNpbmcg
VlJGcywgd2hpY2ggdXNlIEZJQiBydWxlcywgd2hpY2ggc2hvdWxkIGluIHR1cm4gZGlzYWJsZSB0
aGUgdXNlIG9mDQo+IGhpbnRzLiBJZiB0aGlzIGlzIGluZGVlZCB0aGUgY2FzZSwgdGhlbiB0cnkg
dXNpbmcgbmFtZXNwYWNlcyBpbnN0ZWFkLiBUaGVyZSBhcmUNCj4gdmFyaW91cyBleGFtcGxlcyBv
dXRzaWRlIG9mIHRoZSBmb3J3YXJkaW5nIGRpcmVjdG9yeS4NCg0KQWgsIG15IG1pc3Rha2UuIEkg
d3JvdGUgdGhlIHNlbGZ0ZXN0IHRvIGV4cGxhaW4gdGhlIHByb2JsZW0gYW5kIGRpZG4ndCB0ZXN0
IGl0IHRob3JvdWdobHksIHNvcnJ5IGFib3V0IHRoYXQuDQpJIHdpbGwgd3JpdGUgYSB0ZXN0IHdp
dGggbmFtZXNwYWNlcyBhbmQgc2VuZCBhIHByb3BlciBwYXRjaHNldCBmb3IgcmV2aWV3LiBUaGFu
a3Mgb25jZSBhZ2Fpbi4NCg0K

