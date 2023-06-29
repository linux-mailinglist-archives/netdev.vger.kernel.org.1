Return-Path: <netdev+bounces-14680-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA416743113
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 01:26:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D34051C20A97
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 23:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CFEC10784;
	Thu, 29 Jun 2023 23:26:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE5D8489
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 23:26:26 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB2B43595
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 16:26:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LU/bUjZpxD8E8AtN8Spnpv1fdxqz3cXD2gq13iJ3wN7aJVru/VK381MI5I4U654ubWTIkEjHXkmwXh4cq0vdactFuPGlZdD10x+Yq3fhs4nHuBe2+WcB1CIMw1WVhLQE9GGxZs0FFYvbDugy2ZFAff+710vQJGjMcEKERxwD71U8XD5VSn2GR+wmyRsCe2XxfTE1hU+BXdnjFhSCZc9FCL8lCeVB0mmoqGruAOKxb/nLyXyH5aV0x+sXKk0Hg0hXVHxwSU9ajmnBNoDg7/sso3TQyO+yJBUHwpWEW4x5bA1nzNk65vaE/DPMTo2K0/WKvSVjjpleV1FyCty9AQCeiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qVJIhvI05sx5WyUEWy8wE11t/peN4zGQDfM5PLY+fYI=;
 b=nKLeKxLKDJSYoUa5k5QB9DzAVkyFHPirbk0CsN0nkDAqdAIuXVrH8C5u1GAZLYKvCsHmJVF4wqFZ6QNfP0UmCjXh1JNdeYmGJNMt8lBwSWt4pqG4abcUzHHK5ZriMMlsOIBsikLyCYb0hw5rWwkh+Z3GVsy+NokQkDgXrcbl2XguVkzrwoP4w5fK9c5VNlM+GcVx9upSbtojoj7W5FMIKoxxAV24LyVdMo6abnlayIgmGK4zc62WXR0b/3pbxj0mpjjR9h92Dqk/i+7vEgJgd1VEPXdQHG9DBEJ9NqD43X/Qbeo9bgnA+SCKp3wPNLuTK+6Lfw3lo5rljFNlQt2yYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qVJIhvI05sx5WyUEWy8wE11t/peN4zGQDfM5PLY+fYI=;
 b=bPJE08oy6ol4xPt1xyBpVBGmzS2q3e9OCO9jOh0Nik9h4jTbyBeworWWloSDioePMr4VkPt0ououBBXti5wMwHuDbVfGvJiRGx1n6iV1qpozUgoUj8aaK0GFnfb07Td+MfHXz5WUcrM77iRMA6xUGftv53nggalX7CbUZ0g1g4rAqOSGm/p3OrkadsN71i00N7MkFZYa2phogWLL4zBSX30QPNSYw5X65mrMFO9kyBNSWaiGb+nylv6UCabvsl+4r9bERNUYl8vKuF+prAj5Bt+7qw+xrvOXty/SwuP0nO8hz9fvgOajX9c2fUwSU9g+nPmD4NcnqTdZPbS2YuHPog==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by LV8PR12MB9111.namprd12.prod.outlook.com (2603:10b6:408:189::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Thu, 29 Jun
 2023 23:26:20 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::92c6:4b21:586d:dabc]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::92c6:4b21:586d:dabc%4]) with mapi id 15.20.6521.024; Thu, 29 Jun 2023
 23:26:20 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: David Howells <dhowells@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: Aurelien Aptel <aaptel@nvidia.com>, Sagi Grimberg <sagi@grimberg.me>,
	Willem de Bruijn <willemb@google.com>, Keith Busch <kbusch@kernel.org>, Jens
 Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>, Chaitanya Kulkarni
	<chaitanyak@nvidia.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Jens Axboe <axboe@kernel.dk>, Matthew Wilcox
	<willy@infradead.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
Subject: Re: [PATCH net] nvme-tcp: Fix comma-related oops
Thread-Topic: [PATCH net] nvme-tcp: Fix comma-related oops
Thread-Index: AQHZqtNiVDA7aYUlK0meRBPKbShojK+ibJEA
Date: Thu, 29 Jun 2023 23:26:20 +0000
Message-ID: <93daa35c-3150-f14e-d9a4-1fa83a0bb506@nvidia.com>
References: <59062.1688075273@warthog.procyon.org.uk>
In-Reply-To: <59062.1688075273@warthog.procyon.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|LV8PR12MB9111:EE_
x-ms-office365-filtering-correlation-id: 4fdc2e22-2131-4420-c8c2-08db78f83efc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 qnLX9RPio+CHeBWGE9iMGdmWdyabs1bt/RVQDCgNsbjRPcty++2zvU8+t5N2I2kC//K9c/V57EBrNQs9sBs2kVXG1jyK6YDslXiRAPSsOtdd8QjYNeQRQglxGc3Iw5wxTyJ7XaWy5MdFG+OVHE7QauzmsYN1zz7ky7qeZhpFRKcWRI0UaVv+uTdryaZ0SxSSD0Ec8NByHKHA/jiZmkF0LFF++6PPdQNyQoj3hyiohCa83hT2ACsph4Jj3iawhkjxj2OElvvrFWPo1JMHrpuJP7e2MERLxGgxlwdmjgXQSzHuT+Nlw1wB2TrhXTpeETRDTkJ85UzQ6DvGa/Vub4rD303U3uuP+iuYbMDn9enN8vH37Pr2IK5O8xrLF/t1yE4+nV4FgULYED3Oia515aSMJ0tIyTrBXxv9IvGB7ugWRIQBji85tlo+3hGYwMYCmg/rBZVivr5EJ2VlpOqfhEhW8B39a2D70mEWuCfPSnDzzrJb0SC2HOqXp0jwGOyvVV3+LNMCs4eElbtgYLKMS33f/HNgH1qRdc7hjAb97Dn8+ueRmgJwOzHJQN1KhPycTY1aE7yVs1uCNjpGwlG3Nlh7DPI17mYtk4FRuGZJ/nkeMfpmSPsrhfgrzoFfh5g0Z9jY4a5e6hIRMKwMXGDnsmiuHehCjEzUqEgY60TujVgPPgn0N7LJAbnq0jYr0ebL7U+RbjMEsA8BYh6/pK7+3loEer9Ncm4GIjvs+F4jTKDWkeo=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(366004)(39860400002)(396003)(346002)(451199021)(6512007)(110136005)(966005)(6486002)(478600001)(186003)(2616005)(54906003)(83380400001)(53546011)(2906002)(71200400001)(6506007)(86362001)(41300700001)(7416002)(122000001)(36756003)(5660300002)(31696002)(66946007)(4326008)(66556008)(38070700005)(316002)(76116006)(91956017)(66476007)(8936002)(38100700002)(64756008)(66446008)(8676002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UnRDNXArSmVkdEhXN3hMWHBkWDUveVhIcy9oMUhvcjJWdHRLSFNwZFFNS2I2?=
 =?utf-8?B?UGVXK2I5aTZwdExiQTI3ZHhHbWlnVjIxNHFuc050dG8wWTNNWmUyVCtnRzBn?=
 =?utf-8?B?dUVmajBVNG82R2VWdStLRWhyM3NRNE9QUzNQYmVkbE5rS1MzdFo3UmxyVmdR?=
 =?utf-8?B?bmgxTXJWOXZ2eWx1K1hMdjlKVjJPY0ZFVGtXd0htV3FjOG9ZOU5pNDFYZFlU?=
 =?utf-8?B?V1J0eEI2OXIrai9WTUcwK1pRWktnRHROa24yckUxNTc3L0NuelRmS3NublRo?=
 =?utf-8?B?UzdZcU5NQ3hkRXV5dTlYbndIaXdTMWQrMS9jbXZGMVJJTCtpN2c5NEVqZ0E4?=
 =?utf-8?B?S0dULzNZcGxDVHZNNnlCRDdmZU9iRks4QVZ5QUZRWWZQVjNoSUNMWWxFcDFR?=
 =?utf-8?B?RE5VcU1vL013K0FFMVV6akl5U2NubXg1N1pOaVZRQ2lrSytLV0J2Q1JwczJY?=
 =?utf-8?B?dThqL3kramZwVFFYSTd6QXo5VDJYUmxZWnlpZzFaMWVoRm9HMTRDQWdPWDIw?=
 =?utf-8?B?RFo1VWJHdXRxWmNSdzF3ajVXSmlkcTczMmZwdjFKZktKVGt5RGgxb3NITVFP?=
 =?utf-8?B?dGlKSFBCcEpQMlpST3RXeDVHeUozTUNMSUkxNU5JcXhKbC9LUzRtZEphcWJN?=
 =?utf-8?B?bzZHQlBzbXF0aWNQUUdwL3VxQlZ1S21rSGRFL2dRMVRxYmdGWGJURldsdGFn?=
 =?utf-8?B?K2dzaDF3TDNIVUh3c1Z5T3VMcnVuNytJdmNNUnNtWVRkQjY1Sm8reVkzdVY0?=
 =?utf-8?B?UElsRFNWaGc1VUM2RW1YTytUVlhTSlhwK3ZYdTk4cjNoVThxcjM4dXk4VHAx?=
 =?utf-8?B?NEJ5MkJNWHVxSFBWSU05WXlmdWZidDBpTG9OS21XdUd3Z1R5NlBsSi8vT0pU?=
 =?utf-8?B?RTRPTmgweWQ1ZXFrSlQ4czBOWlViSUszRXpaYURUb0t6bm1FbXN0cWtITWNF?=
 =?utf-8?B?UlRLOC9CQnBYc2VjKy9uV0dVZFFpN3FkaVhNN3piY295dkRzUTU5aHp4d3VP?=
 =?utf-8?B?NHBhTlFpemdnVXdyeU13dzBpSm13Z2pBeEUvOHdMRGhlK3RJS2lNZXZMNllY?=
 =?utf-8?B?NzZmdUU0NDVpMStqbjAvZFRSbTQ2VVFOYmtUcWdnZmVPODlQWUt5cnBJWUxF?=
 =?utf-8?B?R05Md0VHc0FuWUQwNjR6SXczTmJXQjVkRE1QTjlvZFhhSTQyaG91djFaYTBn?=
 =?utf-8?B?ZktjR3NROVFiV0EwWUdrYWZ4ZHEvd1JmVVU3clhVK05pWEpyMko2RzJmVEtP?=
 =?utf-8?B?ZnZEc3ZlaEdkWkJIN3pnT1RMQi9OTmhjRzYrMVRqWTA5UTFiSElLbWhLcERC?=
 =?utf-8?B?eUdpT0lwMy9pWTlXTjBpSHdwM0RaTGpXaHpIVGZlOWNUS3JIdnV0dCsxTDhl?=
 =?utf-8?B?NGUxaU5WMkp6T3RMZUFuUVdpT29NRmF2VVV5NHA0MGI1UitKV3VXbkZDbVlZ?=
 =?utf-8?B?emJLeWxsOVJ5MmVNSkswZUhVc0NsMFdXN3EwRXNBSW9MU2g0RWdHVkJrVzhl?=
 =?utf-8?B?TXlBQ1l0VHo3bmZVZ2s1Rnp2Y2FBS1VzQW0xNEp6T0JPKzVCNE16REVnQzdi?=
 =?utf-8?B?NnlDMDFoMnNLSHdhRk9qREEySXN2ckhZWGsvdGpMQjdEeVdJWWd4OC80bCta?=
 =?utf-8?B?MTRtdWxuM1l0bnZnUDZUR2FiekxpRGs2ZFRtS1MyYS9pVVIzd1Q0K3gvcnZG?=
 =?utf-8?B?Wmp3cEpWZnRhTm9Qa2QzZnpzMVVlVmVzMTFRSEVVZmE4OWIyVWZqVXlaWVJZ?=
 =?utf-8?B?dUUybm9lam9mcDhqSG0zWTZtS1RkQUdRdlptWmF0bzRZeFRBaGZmd3QzYjgv?=
 =?utf-8?B?UGI2NCtnVThBb0VJS0w0ZmxFOXNXZVpxekhibVJaaFgyaWdhVXVuYXR6bFdM?=
 =?utf-8?B?ZWRIVGwzeStFaXV4M3ZMUW5mQVFnaXRQWnR1WFcxMjFVbVdFM2Q0elFGc3o3?=
 =?utf-8?B?VVI1K0JrY1NtK3NKVmJobWx1Yjhqb1crajk0MVZDWWRJL0drb3dvR0hld0ts?=
 =?utf-8?B?RTJMWmdGR21NdzBDaGtVR2w3aGxEYlJCQVo3akU2TGpJTUJRc0JKRHlwN1RL?=
 =?utf-8?B?b1VKRXNJbmY1dTd4bmJteVpKYVhoOGxiMmZBc3F2bTBPR3Q1ck5VQU04WXU4?=
 =?utf-8?B?TE1ISE5zT0lXVFJYZFFBaE9nTTNWdDdVUHlBNGIxWU93czE3R2d0SjZFeUFR?=
 =?utf-8?Q?V71+pXukPtoV4Q8IRFeG3/ZeJVb4KX+DVAHYegW6mksp?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5F68FFBF5A934945A76EF784BA4CBBFA@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fdc2e22-2131-4420-c8c2-08db78f83efc
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2023 23:26:20.6417
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k4GAei7cws05e27BeCYFpZXe805bRffRdR6Otjk+CTCx4vfvWGD7Xic3bfv3oN8uYqSEu8z0aRNBj/x0ImpuVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9111
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
	SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

T24gNi8yOS8yMDIzIDI6NDcgUE0sIERhdmlkIEhvd2VsbHMgd3JvdGU6DQo+IEZpeCBhIGNvbW1h
IHRoYXQgc2hvdWxkIGJlIGEgc2VtaWNvbG9uLiAgVGhlIGNvbW1hIGlzIGF0IHRoZSBlbmQgb2Yg
YW4NCj4gaWYtYm9keSBhbmQgdGh1cyBtYWtlcyB0aGUgc3RhdGVtZW50IGFmdGVyIChhIGJ2ZWNf
c2V0X3BhZ2UoKSkgY29uZGl0aW9uYWwNCj4gdG9vLCByZXN1bHRpbmcgaW4gYW4gb29wcyBiZWNh
dXNlIHdlIGRpZG4ndCBmaWxsIG91dCB0aGUgYmlvX3ZlY1tdOg0KPiANCj4gICAgICBCVUc6IGtl
cm5lbCBOVUxMIHBvaW50ZXIgZGVyZWZlcmVuY2UsIGFkZHJlc3M6IDAwMDAwMDAwMDAwMDAwMDgN
Cj4gICAgICAjUEY6IHN1cGVydmlzb3IgcmVhZCBhY2Nlc3MgaW4ga2VybmVsIG1vZGUNCj4gICAg
ICAjUEY6IGVycm9yX2NvZGUoMHgwMDAwKSAtIG5vdC1wcmVzZW50IHBhZ2UNCj4gICAgICAuLi4N
Cj4gICAgICBXb3JrcXVldWU6IG52bWVfdGNwX3dxIG52bWVfdGNwX2lvX3dvcmsgW252bWVfdGNw
XQ0KPiAgICAgIFJJUDogMDAxMDpza2Jfc3BsaWNlX2Zyb21faXRlcisweGYxLzB4MzcwDQo+ICAg
ICAgLi4uDQo+ICAgICAgQ2FsbCBUcmFjZToNCj4gICAgICAgdGNwX3NlbmRtc2dfbG9ja2VkKzB4
M2E2LzB4ZGQwDQo+ICAgICAgIHRjcF9zZW5kbXNnKzB4MzEvMHg1MA0KPiAgICAgICBpbmV0X3Nl
bmRtc2crMHg0Ny8weDgwDQo+ICAgICAgIHNvY2tfc2VuZG1zZysweDk5LzB4YjANCj4gICAgICAg
bnZtZV90Y3BfdHJ5X3NlbmRfZGF0YSsweDE0OS8weDQ5MCBbbnZtZV90Y3BdDQo+ICAgICAgIG52
bWVfdGNwX3RyeV9zZW5kKzB4MWI3LzB4MzAwIFtudm1lX3RjcF0NCj4gICAgICAgbnZtZV90Y3Bf
aW9fd29yaysweDQwLzB4YzAgW252bWVfdGNwXQ0KPiAgICAgICBwcm9jZXNzX29uZV93b3JrKzB4
MjFjLzB4NDMwDQo+ICAgICAgIHdvcmtlcl90aHJlYWQrMHg1NC8weDNlMA0KPiAgICAgICBrdGhy
ZWFkKzB4ZjgvMHgxMzANCj4gDQo+IEZpeGVzOiA3NzY5ODg3ODE3YzMgKCJudm1lLXRjcDogVXNl
IHNlbmRtc2coTVNHX1NQTElDRV9QQUdFUykgcmF0aGVyIHRoZW4gc2VuZHBhZ2UiKQ0KPiBSZXBv
cnRlZC1ieTogQXVyZWxpZW4gQXB0ZWwgPGFhcHRlbEBudmlkaWEuY29tPg0KPiBMaW5rOiBodHRw
czovL2xvcmUua2VybmVsLm9yZy9yLzI1M210MGlsNDNvLmZzZkBtdHItdmRpLTEyNC5pLWRpZC1u
b3Qtc2V0LS1tYWlsLWhvc3QtYWRkcmVzcy0tc28tdGlja2xlLW1lLw0KPiBTaWduZWQtb2ZmLWJ5
OiBEYXZpZCBIb3dlbGxzIDxkaG93ZWxsc0ByZWRoYXQuY29tPg0KPiBjYzogU2FnaSBHcmltYmVy
ZyA8c2FnaUBncmltYmVyZy5tZT4NCj4gY2M6IFdpbGxlbSBkZSBCcnVpam4gPHdpbGxlbWJAZ29v
Z2xlLmNvbT4NCj4gY2M6IEtlaXRoIEJ1c2NoIDxrYnVzY2hAa2VybmVsLm9yZz4NCj4gY2M6IEpl
bnMgQXhib2UgPGF4Ym9lQGZiLmNvbT4NCj4gY2M6IENocmlzdG9waCBIZWxsd2lnIDxoY2hAbHN0
LmRlPg0KPiBjYzogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCj4gY2M6ICJE
YXZpZCBTLiBNaWxsZXIiIDxkYXZlbUBkYXZlbWxvZnQubmV0Pg0KPiBjYzogRXJpYyBEdW1hemV0
IDxlZHVtYXpldEBnb29nbGUuY29tPg0KPiBjYzogSmFrdWIgS2ljaW5za2kgPGt1YmFAa2VybmVs
Lm9yZz4NCj4gY2M6IFBhb2xvIEFiZW5pIDxwYWJlbmlAcmVkaGF0LmNvbT4NCj4gY2M6IEplbnMg
QXhib2UgPGF4Ym9lQGtlcm5lbC5kaz4NCj4gY2M6IEplbnMgQXhib2UgPGF4Ym9lQGtlcm5lbC5k
az4NCj4gY2M6IE1hdHRoZXcgV2lsY294IDx3aWxseUBpbmZyYWRlYWQub3JnPg0KPiBjYzogbGlu
dXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnDQo+IGNjOiBuZXRkZXZAdmdlci5rZXJuZWwub3Jn
DQo+IC0tLQ0KPg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlh
LmNvbT4NCg0KLWNrDQoNCg0K

