Return-Path: <netdev+bounces-15459-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20D2C747AE4
	for <lists+netdev@lfdr.de>; Wed,  5 Jul 2023 03:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BA3C1C20A74
	for <lists+netdev@lfdr.de>; Wed,  5 Jul 2023 01:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 021197EF;
	Wed,  5 Jul 2023 01:20:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4D763C
	for <netdev@vger.kernel.org>; Wed,  5 Jul 2023 01:20:28 +0000 (UTC)
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2129.outbound.protection.outlook.com [40.107.255.129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E05DD10CF;
	Tue,  4 Jul 2023 18:20:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lPY6v2+5Qeuwxkuf7N6iHNa3wMNtRb6G+SOPregYiGSDIlbBZZFXvocAdQoDWL3oJ+973/6aqVRXfBcYd691K6uMl39JSqjUSELe/CO56EEFjNDo+58LR8H7smB9hV1jbtBjpsSit99xReWKVgH2x705hrmvMv5nK8TabJxEy32wIR+pQEOm7jYZOukeeABQXwepDhBVt58r+hqiaPCIC82OchF4VL/cGbTuc5G7fWJXssmIVt8PcsJVmsqwrUPWTdH/XkcNlv1HOH/3mZV9rX5N9V74J0cWAWvwCAdJ6r5YINIJyFdLPUmsfonzMlPvGM8b7bVGeRiPTfHLaZhCmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PV9TQaSpVPeibm9UlnYPYLTl3OdV724WdCHkC46DrkQ=;
 b=AkGnPT3yTMp0swCxLXafXm4tLXcmvd1JOYAsGAJH8VNofiLjs/s8Nw8qnggeU32a55bOAtzw8OMzJB1UByI32JnjsbPCdMbDIUQKvyNK8f/VMehqBpf2sv+RF0HLL8lWQZt5mxQCZ8S8nJCSK479eHDUTeANPrBMjI/Zvi9cemREqL9U85NvtyT7P41VxSNipiFgQdM4aVK0EYnhDpAba3uZ++XBdP1rAbiaHkDrSvCd55tewAr9qwgajBWlCWwVexiWkHi3DnWTt5eAhqeYKGkSf0Pg6otRBkDQDyo/0DR/RA9uhjxcA9k5VAncBYKE1ceobqK7s5DLlBd6jKb8eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PV9TQaSpVPeibm9UlnYPYLTl3OdV724WdCHkC46DrkQ=;
 b=dYtb1ZwCiWlg/4inptB6GZ2AyOMQkAjf9oGS0nYxt8xtjp7fSkTIy9p2/dw8pGkH3USkwpL73MuIbpJt6H7ud0hZ5PqRKSUxxnZg+RIzbr0qmb2p5234KyLzcuBXFs/YLawGseAA7krqw1iiF1nMet4nlcbuubUMdg+8B3yJuawzCSX2yccqRYtg1mBVyEHjZunVkgFG3+5LvdjyYjTi8DKYacBA6fdYVsYHyT04gtVWU8AThOLI0e7bFHLGT9mv/4Ouc6B6FEkwnHbqo+E5GCiJgxIPvLsdK61NM+UapfnWo4g0xtUumoULfIrv+7OUIC+GL5iChaGbIx4KrXKGjA==
Received: from SG2PR06MB3743.apcprd06.prod.outlook.com (2603:1096:4:d0::18) by
 SEYPR06MB6132.apcprd06.prod.outlook.com (2603:1096:101:dd::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6544.24; Wed, 5 Jul 2023 01:20:23 +0000
Received: from SG2PR06MB3743.apcprd06.prod.outlook.com
 ([fe80::7dfd:a3ed:33ca:9cc8]) by SG2PR06MB3743.apcprd06.prod.outlook.com
 ([fe80::7dfd:a3ed:33ca:9cc8%6]) with mapi id 15.20.6544.024; Wed, 5 Jul 2023
 01:20:23 +0000
From: =?gb2312?B?zfXD9y3I7bz+tdey47y8yvWyvw==?= <machel@vivo.com>
To: Simon Horman <simon.horman@corigine.com>
CC: Sunil Goutham <sgoutham@marvell.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, opensource.kernel
	<opensource.kernel@vivo.com>
Subject:
 =?gb2312?B?u9i4tDogW1BBVENIIHYxXSBuZXQ6dGh1bmRlcl9iZ3g6Rml4IHJlc291cmNl?=
 =?gb2312?B?IGxlYWtzIGluIGRldmljZV9mb3JfZWFjaF9jaGlsZF9ub2RlKCkgbG9vcHM=?=
Thread-Topic: [PATCH v1] net:thunder_bgx:Fix resource leaks in
 device_for_each_child_node() loops
Thread-Index: AQHZroHx9RfUdxaHXkuLRfcrmV6dGa+qD7qAgABQE5A=
Date: Wed, 5 Jul 2023 01:20:23 +0000
Message-ID:
 <SG2PR06MB37436071F353CBAE29BEC0DABD2FA@SG2PR06MB3743.apcprd06.prod.outlook.com>
References: <20230704141457.4844-1-machel@vivo.com>
 <ZKSBZW1a/f2H7H41@corigine.com>
In-Reply-To: <ZKSBZW1a/f2H7H41@corigine.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SG2PR06MB3743:EE_|SEYPR06MB6132:EE_
x-ms-office365-filtering-correlation-id: 0c9419d1-f0f0-455a-261a-08db7cf60191
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 UgKhNfgu/y9+QLnufem2jaDkgJxU30UP3ldOGzv9R8/7s3OYOc0j7KL+IPj5a9tfY6zgtVl9kAxp535gh4sbMgp/JdWZlU+ZEJgQND8as10oUfGGA6hH4/BmNCAhCvUtICQKpPe86LFwI3JeC8P2kOCF4o0V0he1zxbL3kR4GLyjVaDOYTaFa5huL8WcmEdLXNjDIGIGNIPFrbhJbXACsgDfbDYTmDpaaeXTs3o/rzNk0tNCxsRLH7alE4Pp3kD1RWkFdCt5jUUviclcpEkxdgYkLhSfVWdcVox6RQh1S4aeoLGrcEbsWEbzq9PUhHZOn1kFMTp7F2VUgvSCXSg534PMCYrfZohlsB9a8yov4QIHzTlZ4vVIgnvgwl6gjihJLOaoQp+4eleti//vBOA5U18pGIA/BMlpFijJk72G96QRuGhNfSgACyRYp+Yzpepf7YuSCTaUHV0rf25QByk3LooOwLaWgcWM4PId2VmpYfiPcYI+mAgMGcOCcHgL3n3XVyWCOtY9swKF8n1YJaOacQ6qftpFbOYl/FWGj8x3PuIf+gf4Ai3rxT7xPcEKwfk2bXxrEtA4RhvP2qoTpVJW97KYXWI+97yuFEBZUZ7Zs7o=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3743.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(39860400002)(396003)(376002)(346002)(451199021)(66556008)(64756008)(6506007)(76116006)(6916009)(66476007)(55016003)(4326008)(66946007)(66446008)(478600001)(41300700001)(107886003)(38100700002)(38070700005)(316002)(83380400001)(122000001)(52536014)(186003)(26005)(9686003)(54906003)(966005)(8936002)(224303003)(85182001)(2906002)(5660300002)(7696005)(86362001)(71200400001)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?aHVDWWpNTWlnTThlaEwxOHQ3N2FjN2dwd0JKcDFmbTVoU0xyQjBxOSs0ZmU2?=
 =?gb2312?B?Tlh1cU8zUUo0NWdsU2JUSURjVmRWVzM0WXZlN0NEcFRENkd4amRHUXJWRWRL?=
 =?gb2312?B?SmxCQTUzcnBqN1p3b1FQb3JtZFJLaEtnQVBNYnBYTjltU2hiTkNQQnBCUkRa?=
 =?gb2312?B?ZDJVbFBXbG5iQ0ZERG0rUlVXZWN0QzVWNDMzSDZTWk9ZM1FvN3FtMFViU0ll?=
 =?gb2312?B?MXhONGd1cW1IbllUU1JzbDR5YndQZ3MwQjF0QXBnZmxhZXZkVVZuZWhjUTk5?=
 =?gb2312?B?cXBQQXEzLzRORlhxYmJTeC8yQ3JJckkrNkd6RFBhYmxOQ3BjWjVUWEh5OEpN?=
 =?gb2312?B?NEtreEdyeUdxQnQwUlNTREFmNTJRenJrWXZMbXEyeXVwQWJkUWgrNUhUU1Zy?=
 =?gb2312?B?a2d2QVE5dTZHTnJYbmdOTHg0VkZlenhqVmllM2FPbloyZmkzQUs1R0swQkJR?=
 =?gb2312?B?b2FRRnZJNmpzcHNkcmdiMnAxcVliYUxGZEMwWDdpSE9XSFhKUGZTdVVIMXh2?=
 =?gb2312?B?MExKV3k2OGpCWm1kWG82WTlyN09SMXk2RFFaeHg4UWpzZHZvRm5obms3d2pR?=
 =?gb2312?B?MDRnaXpFVUVNNUJKb01LTFkveEhVRThmMTEwRU9SdkNwNWpibThiN0o0OFlw?=
 =?gb2312?B?cXVuSEFTTHo4QjM5bXFnMVZmNnl6MU5hQ1JScG5FMVNTZUVGUFlaTndiYW8z?=
 =?gb2312?B?NkNuQU5xQjVVVTZYdURwVU1ra2t2RjFJYURVTVN0d1F2MkgzaUJ6R3FaK1dT?=
 =?gb2312?B?eU9pRWozSngyemNFbUlnNFlRU2kybUNWM0dSZDFGVmxUZUYwckZrNTFPOWh4?=
 =?gb2312?B?U20yVjN3cnVnejZ1MUw1UVdZNXBiTXRLTEJyMXpndCtoR2VkWUVDcTF2QnZp?=
 =?gb2312?B?cnlQWTdnb1VFa28vVGlyYm5HWENFSWNVVkdPdFY5dXVpbWRZams2N0xLb2dC?=
 =?gb2312?B?V0R0TU1iSHp6UnZqS1VHcHlMSU15dVFXN1hSdW9tbk5xTnVGOGduYnFDYmNW?=
 =?gb2312?B?Q1ZqaFFCWkt3LzgrNmF0WWYxN2FkV3NGNXU2ZitLUjUyUGRINDNTeGtiTWpE?=
 =?gb2312?B?aGlleXMwMjUwQlNPOXhPNVZ5VUhRVTNZR2ZTdktMUWV5SEZrbm1NT2ViZ1JW?=
 =?gb2312?B?RjF2SVMraS9qTVZOb1cxc0tvWEw5ck9vcnBwQlVMcWFSSVU4UlF0UjRsRUlX?=
 =?gb2312?B?Yklaa0dyRVlGYXZXTHl1TDVaenNlSzU5MlBycXdkL21wYmdpaFpORWdUdzFy?=
 =?gb2312?B?Qzd6UkVGN1FZTFQwNG94aWNHc0pMQTRxK2ZiN0ROd0E4U2dUQWdUTTZUZGl0?=
 =?gb2312?B?Q05JWHl3QnFra3pkQ3JGMVlLdU94dGpxY1RLVGk4eFJtckdML0ZRTi9zU3pH?=
 =?gb2312?B?a1pRZlhScDRMQmpPdGY2YXB6aWkzaEFvMzlFbkt5SHFqRDZhVTNBMTl6US9P?=
 =?gb2312?B?aks2MTB3VVBlNVk4dGxvRUY5UlM4Q1hrMUM3czZTMmxaSUZDdk1CN1dyK3Y4?=
 =?gb2312?B?c0htR0RubnJ5Y3A1bVh3V3BDbUV6dTF0L1VoTUhZRFdBSklFdUR5R2psRXlH?=
 =?gb2312?B?Rkc2bmptTXB0V00ycmJBVjFjRXF3ekNLN05mek5BT3JnenRETFI5OGk0eUpm?=
 =?gb2312?B?RkgxMy9sVm9wOEhYeXI3MnZtU2F1NEd0bXhGSkZYNUhPbnMyUm56dEtYek5J?=
 =?gb2312?B?bUJJM1ViaWlrdHBIdmhEajBUakhiUFJVU3Brc29wZ3RSRzNseTU5djhVNjQz?=
 =?gb2312?B?UlRKK2FQeWpraW9tdkpyWFVJWFdIMmphZW1ra3hHUnVvSlZ6Rmcxc05DUUdC?=
 =?gb2312?B?dk1kRVk1ZWw5d0RldFpkNnlZNVViZU83MDEzc2YxelNXUTR5TnIwRHRKenlS?=
 =?gb2312?B?b216K3pnblFjRFJpSDBOV3M0Vy9ZL1Q5MjhpYzZySHVOWWZ2eHBGS0NZU3Qw?=
 =?gb2312?B?Kzg4dFNEVU42T2w1bTd6bW1ycDJZV1pNekhhY3NJanNMTEdlODk3TjRrR2Vm?=
 =?gb2312?B?Qk1hYy85TDlCQ1hxL0x5STVvR21CN3hQQTFXTHlvQ3krZENrNDd5TTZKOGow?=
 =?gb2312?B?clJsUDZyVXBha1hSWjZWRjArMFFaeithNDl1bkw2b0tiVVNpU0JUVjl3bHNP?=
 =?gb2312?Q?eliRjV6jKjgO05s4M+z5jSqLq?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c9419d1-f0f0-455a-261a-08db7cf60191
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2023 01:20:23.2899
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uRILX02Rk+8olQyKW3nSVn0umwfHD1iAUXgPjgWaGyYYdRXs3QyO4LdIouz/JoEC0/rv3CnBib/gUg/NSzVd7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6132
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

VGhhbmsgeW91Lk9rLCBJIHdpbGwgcmVwb3N0IFtQQVRDSCBuZXQgdjJdIG5ldDogdGh1bmRlcng6
Li4uIGluIDI0IGhvdXJzLiANCi0tLS0t08q8/tStvP4tLS0tLQ0Kt6K8/sjLOiBTaW1vbiBIb3Jt
YW4gPHNpbW9uLmhvcm1hbkBjb3JpZ2luZS5jb20+IA0Kt6LLzcqxvOQ6IDIwMjPE6jfUwjXI1SA0
OjMwDQrK1bz+yMs6IM31w/ctyO28/rXXsuO8vMr1sr8gPG1hY2hlbEB2aXZvLmNvbT4NCrOty806
IFN1bmlsIEdvdXRoYW0gPHNnb3V0aGFtQG1hcnZlbGwuY29tPjsgRGF2aWQgUy4gTWlsbGVyIDxk
YXZlbUBkYXZlbWxvZnQubmV0PjsgRXJpYyBEdW1hemV0IDxlZHVtYXpldEBnb29nbGUuY29tPjsg
SmFrdWIgS2ljaW5za2kgPGt1YmFAa2VybmVsLm9yZz47IFBhb2xvIEFiZW5pIDxwYWJlbmlAcmVk
aGF0LmNvbT47IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbmV0ZGV2QHZn
ZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgb3BlbnNvdXJjZS5r
ZXJuZWwgPG9wZW5zb3VyY2Uua2VybmVsQHZpdm8uY29tPg0K1vfM4jogUmU6IFtQQVRDSCB2MV0g
bmV0OnRodW5kZXJfYmd4OkZpeCByZXNvdXJjZSBsZWFrcyBpbiBkZXZpY2VfZm9yX2VhY2hfY2hp
bGRfbm9kZSgpIGxvb3BzDQoNCk9uIFR1ZSwgSnVsIDA0LCAyMDIzIGF0IDEwOjE0OjQ3UE0gKzA4
MDAsIFdhbmcgTWluZyB3cm90ZToNCj4gVGhlIGRldmljZV9mb3JfZWFjaF9jaGlsZF9ub2RlKCkg
bG9vcCBpbg0KPiBiZ3hfaW5pdF9vZl9waHkoKSBmdW5jdGlvbiBzaG91bGQgaGF2ZQ0KPiBmd25v
ZGVfaGFuZGxlX3B1dCgpIGJlZm9yZSBicmVhayB3aGljaCBjb3VsZCBhdm9pZCByZXNvdXJjZSBs
ZWFrcy4NCj4gVGhpcyBwYXRjaCBjb3VsZCBmaXggdGhpcyBidWcuDQoNCkhpIFdhbmcgTWluZywN
Cg0KSWYgdGhpcyBmaXhlcyBhIGJ1ZyB0aGVuIGl0IHByb2JhYmx5IHdhcnJhbnRzIGEgZml4ZXMg
dGFnLg0KQW5kIGl0IHNob3VsZCBhbHNvIHByb2JhYmx5IGJlIHRhcmdldGVkIGF0IHRoZSBuZXh0
IHRyZWU6DQoNCglbUEFUQ0ggbmV0IHYyXSAuLi4NCg0KSWYgc28sIHBsZWFzZSBhbGxvdyAyNGgg
dG8gZWxhcHNlIGJlZm9yZSBwb3N0aW5nIHYyLg0KDQpFbHNlIGl0IHNob3VsZCBiZSB0YXJnZXRl
ZCBhdCB0aGUgbmV0LW5leHQgdHJlZSwgYW5kIHBvc3RlZCBhZnRlciBuZXQtbmV4dCByZW9wZW5z
IGFmdGVyIEp1bHkgMTB0aDoNCg0KCVtQQVRDSCBuZXQtbmV4dCB2Ml0gLi4uDQoNCkFsc28sIGxv
b2tpbmcgYXQgZ2l0IGhpc3RvcnksIEkgdGhpbmsgYSBtb3JlIGFwcHJvcHJpYXRlIHN1YmplY3Qg
cHJlZml4IHdvdWxkIGJlICduZXQ6IHRodW5kZXJ4OiAnDQoNCglbUEFUQ0ggbmV0IHYyXSBuZXQ6
IHRodW5kZXJ4OiAuLi4NCg0KTGluazogaHR0cHM6Ly93d3cua2VybmVsLm9yZy9kb2MvaHRtbC9u
ZXh0L3Byb2Nlc3MvbWFpbnRhaW5lci1uZXRkZXYuaHRtbA0KDQo+IFNpZ25lZC1vZmYtYnk6IFdh
bmcgTWluZyA8bWFjaGVsQHZpdm8uY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvbmV0L2V0aGVybmV0
L2Nhdml1bS90aHVuZGVyL3RodW5kZXJfYmd4LmMgfCA1ICsrKystDQo+ICAxIGZpbGUgY2hhbmdl
ZCwgNCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9uZXQvZXRoZXJuZXQvY2F2aXVtL3RodW5kZXIvdGh1bmRlcl9iZ3guYyANCj4gYi9kcml2
ZXJzL25ldC9ldGhlcm5ldC9jYXZpdW0vdGh1bmRlci90aHVuZGVyX2JneC5jDQo+IGluZGV4IGEz
MTdmZWI4ZC4uZGFkMzJkMzZhIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9j
YXZpdW0vdGh1bmRlci90aHVuZGVyX2JneC5jDQo+ICsrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0
L2Nhdml1bS90aHVuZGVyL3RodW5kZXJfYmd4LmMNCj4gQEAgLTE0NzgsOCArMTQ3OCwxMCBAQCBz
dGF0aWMgaW50IGJneF9pbml0X29mX3BoeShzdHJ1Y3QgYmd4ICpiZ3gpDQo+ICAJCSAqIGNhbm5v
dCBoYW5kbGUgaXQsIHNvIGV4aXQgdGhlIGxvb3AuDQo+ICAJCSAqLw0KPiAgCQlub2RlID0gdG9f
b2Zfbm9kZShmd24pOw0KPiAtCQlpZiAoIW5vZGUpDQo+ICsJCWlmICghbm9kZSkgew0KPiArCQkJ
Zndub2RlX2hhbmRsZV9wdXQoZnduKTsNCj4gIAkJCWJyZWFrOw0KPiArCQl9DQo+ICANCj4gIAkJ
b2ZfZ2V0X21hY19hZGRyZXNzKG5vZGUsIGJneC0+bG1hY1tsbWFjXS5tYWMpOw0KPiAgDQo+IEBA
IC0xNTAzLDYgKzE1MDUsNyBAQCBzdGF0aWMgaW50IGJneF9pbml0X29mX3BoeShzdHJ1Y3QgYmd4
ICpiZ3gpDQo+ICAJCWxtYWMrKzsNCj4gIAkJaWYgKGxtYWMgPT0gYmd4LT5tYXhfbG1hYykgew0K
PiAgCQkJb2Zfbm9kZV9wdXQobm9kZSk7DQo+ICsJCQlmd25vZGVfaGFuZGxlX3B1dChmd24pOw0K
PiAgCQkJYnJlYWs7DQo+ICAJCX0NCj4gIAl9DQoNClNob3VsZCB0aGlzIGNoYW5nZSBhbHNvIGFw
cGx5IHRvIHRoZSAnZ290byBkZWZlcicgY2FzZSBpbiB0aGUgc2FtZSBsb29wPw0KSWYgc28sIHBl
cmhhcHMgYSBtb3JlIGlkaW9tYXRpYyBhcHByb2FjaCBvZiByZWxlYXNpbmcgcmVzb3VyY2VzIGlu
IGEgbGFkZGVyIG9mIGdvdG8gbGFiZWxzIGlzIGFwcHJvcHJpYXRlLiBTb21ldGhpbmcgbGlrZSB0
aGlzICh1bnRlc3RlZCEpOg0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvY2F2
aXVtL3RodW5kZXIvdGh1bmRlcl9iZ3guYyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2Nhdml1bS90
aHVuZGVyL3RodW5kZXJfYmd4LmMNCmluZGV4IGEzMTdmZWI4ZGVjYi4uMzA5MWM5NjEzNGU0IDEw
MDY0NA0KLS0tIGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvY2F2aXVtL3RodW5kZXIvdGh1bmRlcl9i
Z3guYw0KKysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvY2F2aXVtL3RodW5kZXIvdGh1bmRlcl9i
Z3guYw0KQEAgLTE0NjksNiArMTQ2OSw3IEBAIHN0YXRpYyBpbnQgYmd4X2luaXRfb2ZfcGh5KHN0
cnVjdCBiZ3ggKmJneCkNCiAJc3RydWN0IGZ3bm9kZV9oYW5kbGUgKmZ3bjsNCiAJc3RydWN0IGRl
dmljZV9ub2RlICpub2RlID0gTlVMTDsNCiAJdTggbG1hYyA9IDA7DQorCWludCBlcnIgPSAwOw0K
IA0KIAlkZXZpY2VfZm9yX2VhY2hfY2hpbGRfbm9kZSgmYmd4LT5wZGV2LT5kZXYsIGZ3bikgew0K
IAkJc3RydWN0IHBoeV9kZXZpY2UgKnBkOw0KQEAgLTE0NzksNyArMTQ4MCw3IEBAIHN0YXRpYyBp
bnQgYmd4X2luaXRfb2ZfcGh5KHN0cnVjdCBiZ3ggKmJneCkNCiAJCSAqLw0KIAkJbm9kZSA9IHRv
X29mX25vZGUoZnduKTsNCiAJCWlmICghbm9kZSkNCi0JCQlicmVhazsNCisJCQlnb3RvIG91dF9o
YW5kbGVfcHV0Ow0KIA0KIAkJb2ZfZ2V0X21hY19hZGRyZXNzKG5vZGUsIGJneC0+bG1hY1tsbWFj
XS5tYWMpOw0KIA0KQEAgLTE1MDEsMTAgKzE1MDIsOCBAQCBzdGF0aWMgaW50IGJneF9pbml0X29m
X3BoeShzdHJ1Y3QgYmd4ICpiZ3gpDQogCQl9DQogDQogCQlsbWFjKys7DQotCQlpZiAobG1hYyA9
PSBiZ3gtPm1heF9sbWFjKSB7DQotCQkJb2Zfbm9kZV9wdXQobm9kZSk7DQotCQkJYnJlYWs7DQot
CQl9DQorCQlpZiAobG1hYyA9PSBiZ3gtPm1heF9sbWFjKQ0KKwkJCWdvdG8gb3V0X25vZGVfcHV0
Ow0KIAl9DQogCXJldHVybiAwOw0KIA0KQEAgLTE1MTksOCArMTUxOCwxMiBAQCBzdGF0aWMgaW50
IGJneF9pbml0X29mX3BoeShzdHJ1Y3QgYmd4ICpiZ3gpDQogCQl9DQogCQlsbWFjLS07DQogCX0N
CisJZXJyID0gLUVQUk9CRV9ERUZFUjsNCitvdXRfbm9kZV9wdXQ6DQogCW9mX25vZGVfcHV0KG5v
ZGUpOw0KLQlyZXR1cm4gLUVQUk9CRV9ERUZFUjsNCitvdXRfaGFuZGxlX3B1dDoNCisJZndub2Rl
X2hhbmRsZV9wdXQoZnduKTsNCisJcmV0dXJuIGVycjsNCiB9DQogDQogI2Vsc2UNCg0KLS0NCnB3
LWJvdDogY2hhbmdlcy1yZXF1ZXN0ZWQNCg0K

