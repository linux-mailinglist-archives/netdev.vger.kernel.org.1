Return-Path: <netdev+bounces-15935-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7598674A86B
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 03:25:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7F8628137F
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 01:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B79C410EE;
	Fri,  7 Jul 2023 01:25:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7177F
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 01:25:01 +0000 (UTC)
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2129.outbound.protection.outlook.com [40.107.117.129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E40FD113;
	Thu,  6 Jul 2023 18:24:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NhiCclIyEsCH18LEcwhoBqp+CI9dHoXsxtIf7MEi8pADSCINTAf2KUxMbZSpAAkyhpIp2xN/fFAyi8xoQSMNgyqeW86FIcA5LKo2jRlI6P94GWDeSrLV6gnM03R6BTRcLPai2f/6cDsxrfuLDVooEl3OkT6EYLoBOuUSRVzbclgW5BXv6MIF36fDEpIc1toQj3YAHA9UOIsphbY6b011mDf6/NPITbFwyVm2OqJhbcKtPKsIsmpyKQRdoEx537JrrmeXrDXs02pAhewa9MNwwUToP/AEfQuZZy30hu7h+F2KjrgUsZ8b/Sk7oEdCdj9JAJSR4+5/EZXxIlPWGlrFug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7+dsw1d43+hI5YMOND0kHNSyO8xGT0+8m3P0r8/5hQY=;
 b=D8iSL8Zw1W6BsrPnmq6xA8ihrrNAPLo8qNis04/I26Et31c3SFFCdO3xkAd7bOOHS1xbLeY9YQujtgD45pvjNqCU7tc/lN4YJxA6amrTvUQ0vPPr2L6psJoQDxonm+zeQc6R7hujm3O/zYKvC4h4mY5yDkHMdsEqUIuZ2XuERXWTH0Q5OPEP1iDi3c7SDllxxh0oHT6h8RtTAJp40geJMdQ8e/3X+nV9tKWixgQ/2YjJvU7zsnHe1QLB+ShkWbSfzU2JzPKPbRkL7ZYdmrLpgfwxCj2i01QOklaN+ROk1BAbpu6FJPZhUGlByYph7iZDtf2C3FMrGAYg+Txn0tElNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7+dsw1d43+hI5YMOND0kHNSyO8xGT0+8m3P0r8/5hQY=;
 b=BmfPASCR9aGc+P+YTN99H0Fu+piFONfprD2c60hapHZL4h3y4/K2ye5EHPZg4p5tTsKDqZud5W3aZRxTZ21Hi+n5mejn/gTC0EKZv35RvsbA7wL3q2a5BBD9lo+X/MwfrHtBJe3RDotPwttYi7XhSC9B4ZI6T5N0bB4Sxh93/gn0wUpPn/wxHiHGZLxDSRWQoh3G8Po0igsJgxnUp6TPO37Aw0uwWDBgOK5u8xyKkUPVvzxPOybVhg0K0aYrerhy07IkOqvkJdhdjs6hG5nKcIYgAMUNTRItD1Rii8Y41awLd4+guW0/R7JwnVB16JF3xEIxuUw3TRofAOZ7E1FyKw==
Received: from SG2PR06MB3743.apcprd06.prod.outlook.com (2603:1096:4:d0::18) by
 TYZPR06MB6240.apcprd06.prod.outlook.com (2603:1096:400:332::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6565.25; Fri, 7 Jul 2023 01:24:56 +0000
Received: from SG2PR06MB3743.apcprd06.prod.outlook.com
 ([fe80::2a86:a42:b60a:470c]) by SG2PR06MB3743.apcprd06.prod.outlook.com
 ([fe80::2a86:a42:b60a:470c%4]) with mapi id 15.20.6565.016; Fri, 7 Jul 2023
 01:24:56 +0000
From: =?utf-8?B?546L5piOLei9r+S7tuW6leWxguaKgOacr+mDqA==?= <machel@vivo.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
CC: Jon Maloy <jmaloy@redhat.com>, Ying Xue <ying.xue@windriver.com>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>, LKML <linux-kernel@vger.kernel.org>,
	opensource.kernel <opensource.kernel@vivo.com>, Jakub Kicinski
	<kuba@kernel.org>
Subject:
 =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggdjFdIG5ldDp0aXBjOlJlbW92ZSByZXBlYXRlZCBp?=
 =?utf-8?Q?nitialization?=
Thread-Topic: [PATCH v1] net:tipc:Remove repeated initialization
Thread-Index: AQHZsA+7c1MMyxJVAUGUN+gEE0pOvq+s4jeAgAAYKoCAAIjKIA==
Date: Fri, 7 Jul 2023 01:24:56 +0000
Message-ID:
 <SG2PR06MB3743FFC941CC9B242113A8A4BD2DA@SG2PR06MB3743.apcprd06.prod.outlook.com>
References: <20230706134226.9119-1-machel@vivo.com>
 <20230706084729.12ed5725@kernel.org>
 <a409e348-0d15-e7f6-5d97-1ebe8341027a@wanadoo.fr>
In-Reply-To: <a409e348-0d15-e7f6-5d97-1ebe8341027a@wanadoo.fr>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SG2PR06MB3743:EE_|TYZPR06MB6240:EE_
x-ms-office365-filtering-correlation-id: 250615eb-dedb-4c9f-7733-08db7e88f954
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 mXRxHrYoXeWo9YLUaRqI2pXCU1Z8J7NsLwLijiS3ueUXFsIYSXuwllVAsE6h63Z6kQKkhrbYsMwSfHTd+AREUpJvB1JaQDU4u6q8Yvb6AiJcq9bv9azAG7jDZbXK9GN7WnkFFkkplseH+vuHZ/aMOs0tKot5wSHt6VcaCTPJ7Q9gfOCPjBmYkf9RYQMsp4wwlOYsU31WcQQiA8JTj/P5K4lwcg72iiedsElFQ7p4RdzjjoNaQ4TWgOVVoR0P39cK8E2WoqZeBF/xqlYBqf3fm/iR4pv90m5I/x2ozuqXzw2eeXmySszj+ehFTJOFT2ex2QnMU0Z5RT4Kd5lO/+hu83hNZwIqzz/Zkq7CIoQhrnEjrNegS/gdpqFxeBVxnr5hywlDm4maBXu6854ZbmBbOqNg2PGegWW4F4vfjXD/SVs+A24yTprcrZ7XbBFlDNQyOtusBOO5ejy1tcopd9OAHOjBIe2qh2e1jmZXr4dBhE7onJ892VRd6mRjNyZRglL6kYRxmdQXx/F8kAbYpiwK39VzKuohoWa5LNm9oSfrOrCAWRgCoi5F+0NchMlWMmp07pfqFZ3vDPIL8/o6cuoj3EAHcELlz/Gm4E3GxDIsc4Q=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3743.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(396003)(39860400002)(366004)(346002)(451199021)(316002)(41300700001)(966005)(9686003)(26005)(6506007)(186003)(7696005)(478600001)(122000001)(54906003)(71200400001)(38100700002)(55016003)(66946007)(76116006)(66476007)(66556008)(6916009)(66446008)(64756008)(4326008)(7416002)(52536014)(86362001)(33656002)(224303003)(38070700005)(5660300002)(8936002)(85182001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UEM2TS9IQyt3ZHE4VlpUMTJrN3hXR1Z1L21qM2IzZ1pSMjgwOTJMU0U5TDRO?=
 =?utf-8?B?ajRLM203emdueDdxMW5Da1c0bjRCai9QTTQ0UHhvQUpSNC9zdHdnVmRsMnZF?=
 =?utf-8?B?RThJL0lZcEZ6UGl4UldzZEc4OUN5R3ZxVjgyQ3lkYm9UUzA2Y0NCRXBzQ3BR?=
 =?utf-8?B?dEpZNERNUkg3YnpuaUkrYlR5Q0YyU21TV3ZiYXNLNTUyNXcyZWJiK01KMm04?=
 =?utf-8?B?RjJwbHlOMmhKVjZta0hJOWlKSGhmd2tsSmVIYkUxeE0rVW9FbSt6ZEFrdyty?=
 =?utf-8?B?VFh3MFcrM0VDZGZrRms5eE5WZWVFcWFnTTFLenJLeWVPUVVHcVhaQUdzT2lN?=
 =?utf-8?B?M2tIVUFESlVYLzBrSUFnNFdld3IxQ0VhUjBieVlNc1NJWUZUWElpVHhJZHVn?=
 =?utf-8?B?ZEUzVWp2MExUYmM1N3E2anF2WTBmVnZKZG9MMk5SMWhjRmVkQldZdXkzVDNZ?=
 =?utf-8?B?VzhNWGVYU3R2ejFmTWFuNFVqaTA2TWFURk5DN1R4aVpqcDUxVUJTUksvUGds?=
 =?utf-8?B?Q0pISlQ0RDFIV3JhNXZwbWRyR2QzT2s5OWEwaGY5czhqUENWWCt5UUNFaVdB?=
 =?utf-8?B?N1MwR1huN0ZDei9yd3lHNGg0N3FWeFh0VDdpb3FNZlZicUx5ZzczbUh3Y2Qx?=
 =?utf-8?B?WmhiZVpOcmowSy9LbUEzckFsM3luZ2Qzd1RyRGZuNTA2SG1KSnFDQUNsZXhw?=
 =?utf-8?B?WmdmZjZBN0dPVmZrL2d1WmZ0OFIyTlVHODZTaHRqYWpFeEVuTnBmYlRpandt?=
 =?utf-8?B?R0g3K0diUmNCTFZoUFhqSFN3c3dka2p0V29RS3BxMTJnNURHWjRpVk1zenRD?=
 =?utf-8?B?VFVZT0xTKzBTeTExYk0vZ1RQbDRVT0U0MUx3bzlJN245Y2RoaFYyaGVZdi9H?=
 =?utf-8?B?MjJiZ2hyUncvbkxOTUpxZHdTZWJDd1BkQkJ6dkVocDR3Y05vWXYxMDY2TGRU?=
 =?utf-8?B?elpOWkpDbWpHTWtEd0Fxb01KaUlER2l3N2hrWld6MDJYS05UeXB2aS9mQ3FL?=
 =?utf-8?B?UUR6ejJVbHlnNUdaZjhlMVMwZWFHREJWRzFaV1RUNXVDUVdtdzRpbnRUTktu?=
 =?utf-8?B?c0RIdXNxaWpyWmhvTHBEN1ZNb2t4VzdOZGxzdTN1OEdqM2srcWZuWjdqN0VO?=
 =?utf-8?B?TnkyWGx6WUVQRmR4STY4dUNqZHlJT3ljSEwxM1hDM1ZXODBDR1NoSEIvRWFr?=
 =?utf-8?B?ZUZ5d1NKK3NreTYrd1NkQ3RGblM0azlIemlkM2UwZ1VQTFZSOXhaUlEwQ2VY?=
 =?utf-8?B?SjNxRXVMcWxIZCtWZVp4REp5aHowa202TzZRYWh0L25URzBoS3RQVjJ4VXZp?=
 =?utf-8?B?SDNLaWdNd2tRNk4zRy8yNFA4T09xOE9FL3BQeER1a0ZzaDZEV1JkOWlGUzgz?=
 =?utf-8?B?eURvMk9NV2RiMGlJSGxrR0FTMGJ6NndTcGVNd0dzVzZ0N1pDai90UXVGenNH?=
 =?utf-8?B?cGl6K0FoSk90UlFNNE1ERWVvS3MwL1lXVWJKank4KzZLV1BUd3padFBSbEZG?=
 =?utf-8?B?b0ZXeWtZREJSS2Z4SkZJKzVnRHNtYVd6SUc5ZUgrSTd5em5zcVJremlBV2dS?=
 =?utf-8?B?eHd2aFNkRHA4RnBjdUxRYlNEUm9SL3N1UlMwZDFKTmd4NFNpSjR3emJoN29P?=
 =?utf-8?B?Z0ZDL1pacjNxbTd1QWFDeWczbWpTZTJqSzUyclFNYkhuWXV6SkQ0OGtCZ3ZL?=
 =?utf-8?B?Rk1UblhTa0c1YnNnTEJEQzZkNVdESlBVUEVhM2dRRnRUbllBdkVEQXVMbllk?=
 =?utf-8?B?dWV5SnU4QTEySHRib293aG9mVFB0UG1neHl3VHg2YWViNC8yZEs2N1ZTUEpB?=
 =?utf-8?B?RmNqYjdZQUdQOHVHVzAwRkdENVgvR0t1dE5jbE5YUTdyL3FmaUpiS0UrVHFm?=
 =?utf-8?B?MUtNeDE3OHBNRlQxU2FOUWpwN3JwV3RQQmZPMzE5YkxVSjdjeFVlbjNHWDIr?=
 =?utf-8?B?b01hNGlqMUU2aWNrUWlhc1RLSDhPQkxDdllSUnl0Q1NUY3hOSUw5SnN1Y2hr?=
 =?utf-8?B?dUZBcEdxZVVTMEU5b2RlZzJ3eGpIMW16QzZBRVlKK1kxZjEyVjc2WW9DRzlT?=
 =?utf-8?B?TVFKbzRCTkxjVWlNQlh4MUNkMVJwY054OWVXODh4b2xtcXVEdHE2SW5CR0Zz?=
 =?utf-8?Q?2pKI=3D?=
Content-Type: text/plain; charset="utf-8"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 250615eb-dedb-4c9f-7733-08db7e88f954
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2023 01:24:56.6338
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JoC1EvyzKA59DACoowaOp2GETWtdKLKtuiFRE5K00BPRFRucQFnc8mwYFyac47u6fAsSCiW1KNR3I7qYbGzQqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6240
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

SGkgQ0oNCjogKQ0KU28gd2hhdCB5b3UncmUgc2F5aW5nIGlzIHRoZXJlJ3Mgbm8gcmVwZWF0IGlu
aXRpYWxpemF0aW9uIHByb2JsZW0gaGVyZS4NCg0KLS0tLS3pgq7ku7bljp/ku7YtLS0tLQ0K5Y+R
5Lu25Lq6OiBDaHJpc3RvcGhlIEpBSUxMRVQgPGNocmlzdG9waGUuamFpbGxldEB3YW5hZG9vLmZy
PiANCuWPkemAgeaXtumXtDogMjAyM+W5tDfmnIg35pelIDE6MTQNCuaUtuS7tuS6ujog546L5piO
Lei9r+S7tuW6leWxguaKgOacr+mDqCA8bWFjaGVsQHZpdm8uY29tPg0K5oqE6YCBOiBKb24gTWFs
b3kgPGptYWxveUByZWRoYXQuY29tPjsgWWluZyBYdWUgPHlpbmcueHVlQHdpbmRyaXZlci5jb20+
OyBEYXZpZCBTLiBNaWxsZXIgPGRhdmVtQGRhdmVtbG9mdC5uZXQ+OyBFcmljIER1bWF6ZXQgPGVk
dW1hemV0QGdvb2dsZS5jb20+OyBQYW9sbyBBYmVuaSA8cGFiZW5pQHJlZGhhdC5jb20+OyBuZXRk
ZXZAdmdlci5rZXJuZWwub3JnOyB0aXBjLWRpc2N1c3Npb25AbGlzdHMuc291cmNlZm9yZ2UubmV0
OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBvcGVuc291cmNlLmtlcm5lbCA8b3BlbnNv
dXJjZS5rZXJuZWxAdml2by5jb20+OyBKYWt1YiBLaWNpbnNraSA8a3ViYUBrZXJuZWwub3JnPg0K
5Li76aKYOiBSZTogW1BBVENIIHYxXSBuZXQ6dGlwYzpSZW1vdmUgcmVwZWF0ZWQgaW5pdGlhbGl6
YXRpb24NCg0KW+S9oOmAmuW4uOS4jeS8muaUtuWIsOadpeiHqiBjaHJpc3RvcGhlLmphaWxsZXRA
d2FuYWRvby5mciDnmoTnlLXlrZDpgq7ku7bjgILor7forr/pl64gaHR0cHM6Ly9ha2EubXMvTGVh
cm5BYm91dFNlbmRlcklkZW50aWZpY2F0aW9u77yM5Lul5LqG6Kej6L+Z5LiA54K55Li65LuA5LmI
5b6I6YeN6KaBXQ0KDQpMZSAwNi8wNy8yMDIzIMOgIDE3OjQ3LCBKYWt1YiBLaWNpbnNraSBhIMOp
Y3JpdCA6DQo+IE9uIFRodSwgIDYgSnVsIDIwMjMgMjE6NDI6MDkgKzA4MDAgV2FuZyBNaW5nIHdy
b3RlOg0KPj4gVGhlIG9yaWdpbmFsIGNvZGUgaW5pdGlhbGl6ZXMgJ3RtcCcgdHdpY2UsIHdoaWNo
IGNhdXNlcyBkdXBsaWNhdGUgDQo+PiBpbml0aWFsaXphdGlvbiBpc3N1ZS4NCj4+IFRvIGZpeCB0
aGlzLCB3ZSByZW1vdmUgdGhlIHNlY29uZCBpbml0aWFsaXphdGlvbiBvZiAndG1wJyBhbmQgdXNl
IA0KPj4gJ3BhcmVudCcgZGlyZWN0bHkgZm9yc3Vic2VxdWVudCBvcGVyYXRpb25zLg0KPj4NCj4+
IFNpZ25lZC1vZmYtYnk6IFdhbmcgTWluZyA8bWFjaGVsQHZpdm8uY29tPg0KPg0KPiBQbGVhc2Ug
c3RvcCBzZW5kaW5nIHRoZSAicmVtb3ZlIHJlcGVhdGVkIGluaXRpYWxpemF0aW9uIiBwYXRjaGVz
IHRvIA0KPiBuZXR3b3JraW5nLCB0aGFua3MuDQo+DQo+DQoNClRoZSBwYXRjaCBhbHNvIGxvb2tz
IGp1c3QgYm9ndXMsIGFzICdwYXJlbnQnIGlzIG5vdyBhbHdheXMgTlVMTCB3aGVuOg0KICAgIHJi
X2xpbmtfbm9kZSgmbS0+dHJlZV9ub2RlLCBwYXJlbnQsIG4pOw0KDQppcyBjYWxsZWQgYWZ0ZXIg
dGhlIHdoaWxlIGxvb3AuDQoNCkNKDQo=

