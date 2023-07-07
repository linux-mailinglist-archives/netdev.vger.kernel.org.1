Return-Path: <netdev+bounces-15934-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7970A74A868
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 03:22:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA6391C20EFB
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 01:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B55A910EE;
	Fri,  7 Jul 2023 01:21:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A027F
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 01:21:57 +0000 (UTC)
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2121.outbound.protection.outlook.com [40.107.255.121])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C5EB113;
	Thu,  6 Jul 2023 18:21:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ij4tDf/IGMPabcZo/S7SE+df7aaSUQPfN3qxTtiHD/xjiHHKEUYPuD/6DReYx8wdYvC/KL86I9uepKKdbxWUk2BVThTYGRW+KmjQbGPTuca38D2qQqbI+wm/pAt8aiNe7EXne7iU0+1NrzPQYLCeEfaiYzVZ1/BNSbuAYMKuP/1gyQW3r22P8gKySTIPXAN45+Tuh66FDvy0AzadrMOCexdAf1FTXsnya3CzDzWgUquIiDRlJ+oyP24F+g6RelsiwxiDnQEiRJctxSNpIqyFbj2cdQWhdVntxrFYBUHghe6ngVzcWbkSLJo+eTsGsPMXDFRqLqai33g/UMc68dxrTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fDG5zgbE7ReIWUqcsl7BKAyxpa9vW9FbC4vaB0Zxupc=;
 b=AvoYr5swmeVWkAaNzPzTNeFLHJ7wstyHDRrZ/g6s8R8debmJ6+59Vi+r1n5esoJNTw0O39NX3uD4CeVcDk8CYMfZ/HUHD3BiiCl869dZb75jNB+ffhYO37OC7/bWs1ZqJTusF4GvjMKqAjGUVT4Ei+u46ctzQYI4IWbhbelHt+ijC6wLnor5zOg9jAqMu3Ju9jieOtz3jfj4WTAZtVE09TjjC8vYwb7LoTh2ntky3b/uDZqacikvwF1kzzCEZNgeKb4JyzsYFEG8EWqwf21zJu5tPoQqT21hEXD6J6Ck+M7bV/W+u8OgS775829r9fzKjgC4PFq3r5lKYCNgAB8Sdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fDG5zgbE7ReIWUqcsl7BKAyxpa9vW9FbC4vaB0Zxupc=;
 b=SAD7OnQowasKIvRPxQYHNVtAJSA8BKbE+T0PIAFAkHNxozYW+vQWoz7epnpXF1cK1ceNInQpaKwx0t7b+zDIYZRxe8wikrmwPGGkwhJzvIGhDotG0RzE19Wp3i/T4LuhRdDp3axBeqPEfLnvqNtrhI6imDStw0B8EQ1j4Sx86slOKfxDfpZavJxCGUgpON2TOuPGfKWQF76bw9n+AnQ0i5q6+1WxQi6Q7EpPlbGHKRZw7U7daYSCJj0+F6xUe4je7PR6N0geQomu0HqIirTq5nR+VizHY7zn4WNedCpqSXgkhON9xHHzNiN6/o4YSvVIMZfc6mh1TmcOs/qRnipHiQ==
Received: from SG2PR06MB3743.apcprd06.prod.outlook.com (2603:1096:4:d0::18) by
 TYZPR06MB6240.apcprd06.prod.outlook.com (2603:1096:400:332::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6565.25; Fri, 7 Jul 2023 01:21:52 +0000
Received: from SG2PR06MB3743.apcprd06.prod.outlook.com
 ([fe80::2a86:a42:b60a:470c]) by SG2PR06MB3743.apcprd06.prod.outlook.com
 ([fe80::2a86:a42:b60a:470c%4]) with mapi id 15.20.6565.016; Fri, 7 Jul 2023
 01:21:52 +0000
From: =?gb2312?B?zfXD9y3I7bz+tdey47y8yvWyvw==?= <machel@vivo.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Jon Maloy <jmaloy@redhat.com>, Ying Xue <ying.xue@windriver.com>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>, LKML <linux-kernel@vger.kernel.org>,
	opensource.kernel <opensource.kernel@vivo.com>
Subject:
 =?gb2312?B?u9i4tDogW1BBVENIIHYxXSBuZXQ6dGlwYzpSZW1vdmUgcmVwZWF0ZWQgaW5p?=
 =?gb2312?Q?tialization?=
Thread-Topic: [PATCH v1] net:tipc:Remove repeated initialization
Thread-Index: AQHZsA+7c1MMyxJVAUGUN+gEE0pOvq+s4jeAgACgC9A=
Date: Fri, 7 Jul 2023 01:21:52 +0000
Message-ID:
 <SG2PR06MB37437B48A4A7B0902222CDD9BD2DA@SG2PR06MB3743.apcprd06.prod.outlook.com>
References: <20230706134226.9119-1-machel@vivo.com>
 <20230706084729.12ed5725@kernel.org>
In-Reply-To: <20230706084729.12ed5725@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SG2PR06MB3743:EE_|TYZPR06MB6240:EE_
x-ms-office365-filtering-correlation-id: 4fdb2a48-92b6-44be-1f76-08db7e888b90
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 1TUy+D/mbnFM/FwsutrKAyp+bCMoZ3cAbbtNe1NkxG3VNEbVIV8MVYieoHQPuBdNeohWwxSgjzsrICxBXAT50EIG97hv4WIzO/dNBMXJV/lHYKtuND9OMn6TZVvAQAkEazOq5SUSLeZ4v86IIbaUyySOI4Vt43T6yEAXBM5iZZsdssUbrq3SbU7VrYjK+WCApbVM8Pgu3Wm9uXu4vzXXl8km4D9SGWS7n/6F1CLGvoyiO48p87SPwB4uW9jMThjhGx2VyOV9VTGCUPCNnRLCc2nDhF8M95tDUAqYu/qVFhq48c/xiF9NGG3CdkBCYdSt7UYlo0ifXc0oRjFxQq3p52y9Wg9v7r7dZ+lwHOUGuQCYRXIJp8J5tZEKLOivqE/7QLtLeAoG5Vj/nUwswEVc8dKDKSa/5MaMZVzeax4R+uchiCBAGnpV6ts51N9m2R5Jlpz9c9nyen7mOK7r4Eobarz8FVFj4jT0Qhh2+xIiirFsS1gvM4INVY8N3QC0EI+T4bW6Muw93TbyvfzgD9eWFiUxNcsXOK3y6WDlqZijSgL3DJ2stVoiLbAceCKlNJ+3CukLE21ESdrSKWt5TM1KY8arZWyDzTm48GCeTdobyZSw0W0j43dTfEonoAc8Tuh1
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3743.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(396003)(39860400002)(366004)(346002)(451199021)(107886003)(316002)(41300700001)(966005)(9686003)(26005)(6506007)(83380400001)(186003)(7696005)(478600001)(122000001)(54906003)(71200400001)(38100700002)(55016003)(66946007)(76116006)(66476007)(66556008)(6916009)(66446008)(64756008)(4326008)(52536014)(86362001)(33656002)(4744005)(224303003)(38070700005)(5660300002)(8936002)(85182001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?OU5FMkV2MEpRZm9OZGN3WEwxSnhoV3RWVkpZaTZLdkMzSXdJVUVjRHg2UW5v?=
 =?gb2312?B?VkVqZXY1dDVnWFRXdW5pVFVFb011QTZ6aVV5VDMzTFhOSnJndUR4eXVMcDZL?=
 =?gb2312?B?Z0txMmIyeUhxM0NkNDdMRlRQekFqT29NZGVvdnVLQVFNSlE4QnlaM0dTalNy?=
 =?gb2312?B?SVl3NWxrVy8yMkNPZWU0MThqK3FEejBYSUxxU3pRblRCQUJ3V0lWY0tjVk52?=
 =?gb2312?B?UGhZdi9wUEhZek1MQUM1dk5Ebk91U3RzMFhUdUhwSGV4ZTBlVk1zUkR4M1RB?=
 =?gb2312?B?MVB4b0RJOFY3OWUvYXBCVnhiZ1g4R1BlOURJd1RSN1JwYlpjOGw5N1htbm4v?=
 =?gb2312?B?L25qdkM5VllvSWtFMTFpSzQ2Y3NUQ3ZEeTRZd01QVVJScmVvN3BPc0w3WW1W?=
 =?gb2312?B?NVJyYXdwazUzVUR0QWZaTDQrbVhUY3RIN21CNm1hYmkwMlJqd1pSRWpMN1E3?=
 =?gb2312?B?d281OERhVzRvOEpaZFJYOXRUc2o0QnhkS0Z5SmhVb1VvZDdKTXRlbDVrUGth?=
 =?gb2312?B?NFlnVzFFZEdJTGlHRmlDUk4vemttSXNwY0lUbXZUaXhYZllycXV2RVo5azVV?=
 =?gb2312?B?dy9tSml1YjhJemtkb1BlL3JLbFU4R2lpM3R1N3ZIMEx5bkYwTzk3RW00UEkz?=
 =?gb2312?B?NDRHTzc5SXp5eGhGay9hOTkyZlJmZmlwaURKQVVveUdmdmNVengvakNOMXg5?=
 =?gb2312?B?U0d5VWRJVlErOW15eVdTc0dwTWN0azJIblpyQVhFWU95NjFMbm1xek9uYllS?=
 =?gb2312?B?YnFwMFZtTHVHZmozRGlKM3N0TEVtaHVMYlgzQ0lJTXozdk4reEtGcTBYL1dQ?=
 =?gb2312?B?UGxUeVlyRjhvQ0FXL1VmTXA2Z1VjZnFhUmpGN2pJNkdMVWdtSDYrODY0ZFNk?=
 =?gb2312?B?RmxOeTNHcEdOTWQvaGpTTVpTY3VWbzZwS1U3U2szRmdtWjJrcmQrOGJ2ZWVH?=
 =?gb2312?B?REIxWHBzemF6aUVZc2RTejdLcmlQWXgwK1V2YzEvc1pqNWV3eHJSZ20zeWZR?=
 =?gb2312?B?bm9jUHJodElTSkwyVlNaZUJ5cXVva1R0MVZwMmlJWUpSZmZDTlVIR3NLSDNi?=
 =?gb2312?B?ZzVXYksxSUlFT2tyb1R1ak9RNHNackJQK2RKR2g0SmEvbm95b2xzbDJNeGRL?=
 =?gb2312?B?UFZXbkkyWXh1bFBaemgzSm1ZekRDejBiVHRwejExTGVHWG1aYlgvVktPNmVs?=
 =?gb2312?B?TXdGUisxKzhiZ00vbDJQVTNvYkVISFJmb20xMi85VEt4ZFZiK2QyOUpRbDFY?=
 =?gb2312?B?SXdsa1lDQmtRQ1JWN0xZQXZvSjdidFFISC9QQTl1bHpHLzBocjRPUHY2MnQ4?=
 =?gb2312?B?V1BNRDRUUkUvNGl3RkprbXdJYUljRlVla0dqYlVvMTlnOEJmenVsZWtVSTF2?=
 =?gb2312?B?cE8wMXliODNyRnZjQ21WNFhvaUlxR3JzSTJLbFh1QlpjMzVQVU0rZ3FuaVdQ?=
 =?gb2312?B?S1EzWUovZUZBNXpqQjBlT2tEMW5xcEppZE1JZkVHUmNhTnZhUGxlNjdQdkpQ?=
 =?gb2312?B?TjVFaFdrcTRXM0NSOVFUZTVmaVhpazF6bWt5RDBCSldJakl3Sm5lbUgwVUFr?=
 =?gb2312?B?SUgwMVVDZWtFY2N0RGdKTWM0Qm4xdk00TEd2azRtNnhhSWxRN1ZtRmZMdU8y?=
 =?gb2312?B?bVdsaWFrTUhtTk5jdi9SZlF0djlFR3VPSjZEQVByZkJXb2YxZmwxRHBhK05E?=
 =?gb2312?B?VWxUMkdHbXgwTjF6OVJZZGhlZGxGV1dmQWxLYWdkdkZ6VHlhcHVlWjRmUWZS?=
 =?gb2312?B?a1JSTlZsYktzYm50Wk5DSCtMMDNYRmtsQWhoSXBqK1VTL0JhR3UyYS9vc1pl?=
 =?gb2312?B?cXZEd3o4dFdZQ0doTHpWcEtTT3pQcFBHazVGZlZrcGYrbDBpVDlmQ0VoMFdv?=
 =?gb2312?B?VjdhTWVKQ253REJKTm1pdmxHc2dyWCtiaFVxNDNKSDVZb0RYWnEzVGZIWHhi?=
 =?gb2312?B?dWYvcUwrdmpMckJ5SFgzWDVEZzVscFd6dHpoOVhna3FEaE1qWEd0WnoreWFx?=
 =?gb2312?B?NjN1UEdzMTRvcWtMQ1pPcFNtSHdXK2NnU1ZmZVBxU1RXTzBYUXVjWjFuTC9C?=
 =?gb2312?B?UkVvcWl2RzRNeGtaUWRtR0wzR0c3elNZK1czNExsbWU2TzUyM0xMMXQ4d0Uv?=
 =?gb2312?Q?yk2g=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fdb2a48-92b6-44be-1f76-08db7e888b90
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2023 01:21:52.4778
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LhFiDWgbMqYwrozw/z4VqWDtxaFkh2uW4xZmebbFVvffupj4vsfwdYOPUBo258laRq1e7BIfrwCGZhggTyn+pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6240
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

SGkgSmFrdWIgS2ljaW5za2kNCjogKQ0KSSB1bmRlcnN0YW5kLCBidXQgSSBhbSBjb25mdXNlZCBh
Ym91dCB3aGV0aGVyIG15IG1vZGlmaWNhdGlvbiBpcyB3cm9uZz8NCg0KLS0tLS3Tyrz+1K28/i0t
LS0tDQq3orz+yMs6IEpha3ViIEtpY2luc2tpIDxrdWJhQGtlcm5lbC5vcmc+IA0Kt6LLzcqxvOQ6
IDIwMjPE6jfUwjbI1SAyMzo0Nw0KytW8/sjLOiDN9cP3LcjtvP6117LjvLzK9bK/IDxtYWNoZWxA
dml2by5jb20+DQqzrcvNOiBKb24gTWFsb3kgPGptYWxveUByZWRoYXQuY29tPjsgWWluZyBYdWUg
PHlpbmcueHVlQHdpbmRyaXZlci5jb20+OyBEYXZpZCBTLiBNaWxsZXIgPGRhdmVtQGRhdmVtbG9m
dC5uZXQ+OyBFcmljIER1bWF6ZXQgPGVkdW1hemV0QGdvb2dsZS5jb20+OyBQYW9sbyBBYmVuaSA8
cGFiZW5pQHJlZGhhdC5jb20+OyBuZXRkZXZAdmdlci5rZXJuZWwub3JnOyB0aXBjLWRpc2N1c3Np
b25AbGlzdHMuc291cmNlZm9yZ2UubmV0OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBv
cGVuc291cmNlLmtlcm5lbCA8b3BlbnNvdXJjZS5rZXJuZWxAdml2by5jb20+DQrW98ziOiBSZTog
W1BBVENIIHYxXSBuZXQ6dGlwYzpSZW1vdmUgcmVwZWF0ZWQgaW5pdGlhbGl6YXRpb24NCg0KW1Nv
bWUgcGVvcGxlIHdobyByZWNlaXZlZCB0aGlzIG1lc3NhZ2UgZG9uJ3Qgb2Z0ZW4gZ2V0IGVtYWls
IGZyb20ga3ViYUBrZXJuZWwub3JnLiBMZWFybiB3aHkgdGhpcyBpcyBpbXBvcnRhbnQgYXQgaHR0
cHM6Ly9ha2EubXMvTGVhcm5BYm91dFNlbmRlcklkZW50aWZpY2F0aW9uIF0NCg0KT24gVGh1LCAg
NiBKdWwgMjAyMyAyMTo0MjowOSArMDgwMCBXYW5nIE1pbmcgd3JvdGU6DQo+IFRoZSBvcmlnaW5h
bCBjb2RlIGluaXRpYWxpemVzICd0bXAnIHR3aWNlLCB3aGljaCBjYXVzZXMgZHVwbGljYXRlIA0K
PiBpbml0aWFsaXphdGlvbiBpc3N1ZS4NCj4gVG8gZml4IHRoaXMsIHdlIHJlbW92ZSB0aGUgc2Vj
b25kIGluaXRpYWxpemF0aW9uIG9mICd0bXAnIGFuZCB1c2UgDQo+ICdwYXJlbnQnIGRpcmVjdGx5
IGZvcnN1YnNlcXVlbnQgb3BlcmF0aW9ucy4NCj4NCj4gU2lnbmVkLW9mZi1ieTogV2FuZyBNaW5n
IDxtYWNoZWxAdml2by5jb20+DQoNClBsZWFzZSBzdG9wIHNlbmRpbmcgdGhlICJyZW1vdmUgcmVw
ZWF0ZWQgaW5pdGlhbGl6YXRpb24iIHBhdGNoZXMgdG8gbmV0d29ya2luZywgdGhhbmtzLg0K

