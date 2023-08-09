Return-Path: <netdev+bounces-25687-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84B927752D2
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 08:22:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B40131C210FE
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 06:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23B6A469E;
	Wed,  9 Aug 2023 06:22:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1792E3C3F
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 06:22:55 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2084.outbound.protection.outlook.com [40.107.92.84])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6887A133
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 23:22:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LBE8dfqvudZK/e3RjmBG/YBN1xFNx2Lr5YWXPbFVHmlYAJDvaiZty+IL7QatuItIpxaiivpQ2XZErQd9aEzhSuV0sjC5I0ZyjkBw47zvjJ/ufD2FTAz4MS4DPKW8Zh8PEMX3ZO/wtkTNyOOT0okmge6tKQzmHtfMUsfuK7LMcN44LkMeC807DiksxEuvGLZirD6fnm7FPvt6MBocJjyxnYrYRgwMTYWl4nXXpyOc6F/m1ZxpeQ89IgbbMKIStTMEEPXGJP8k+6bky62HoTBn6bbC13NYJKuizZDEgmFPXUWmnIitlTOEZw04z0axdpRBuY0fZZhPysk+2jsHKK7h8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8xrfTYXMcg9HMX1DK3WiMAhEkK6xgreH0m132lyWA4I=;
 b=oPznnIHYaSr5aQ4Sas61CVZFfOSOuZbOZoQQtTbgHVwbEeEdEagw7uhbWjOABXsiVHGk3KCWelFr4sZvZ85tTl3v0Ii4w1cvp8hNFs5R0uvpJxsMEv8ubmwdriF0vo5TyT07jCdRgz7KG/JYeGcpWKSxVS5yOJP4BecOi1S1SV8cc2rYG0el+tuZPxMKus/GRmzfoRG0e9Lg/S1eUDpRpploo7RdPK5kM5g9YdOdKmbYj12PT3uC52WIVCgmfcDnLEoO5tb3SPu8ZzOuApSCbCHHeTVfmGWRmAIH16n+IKHHu9lMk1vLg3yDxgSnEL2Y2gn1wsfSg3EXSm6sEoaF0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8xrfTYXMcg9HMX1DK3WiMAhEkK6xgreH0m132lyWA4I=;
 b=LLtPFx6QeYCWtc8/G/uyvCNrJF49FdqnjPg8pdtn+Xe6IvHEwONkmc5jBfc+ucx7D2BHyOtGVG44UWFfvbYUjwZLIHgNIoNlHZFiB4GPU8ae33RAVGhgVW8nqGhhhM/0kez8AJt9FVdNWkUsCeWnjx2dU9YAGKATs1UTiexlqmb0bKBPfXoNO7q8rnTeG/GIqQe3tKDc/WncMB8+6YSGr8oU7BKy7Su4PzyAw0ErgZkb8G0CkzD9XF0Aek7SROOYmkzrxCQXeaJJk7AnL1+YAPgxsRehtPT/SFXpWsiZJQ9XSJbC+KIP/IKEG2YbclDm1eEbbxxaHTGZGOjwPrZkAg==
Received: from DM6PR12MB5565.namprd12.prod.outlook.com (2603:10b6:5:1b6::13)
 by BY1PR12MB8448.namprd12.prod.outlook.com (2603:10b6:a03:534::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44; Wed, 9 Aug
 2023 06:22:52 +0000
Received: from DM6PR12MB5565.namprd12.prod.outlook.com
 ([fe80::40dc:9f89:895c:8667]) by DM6PR12MB5565.namprd12.prod.outlook.com
 ([fe80::40dc:9f89:895c:8667%4]) with mapi id 15.20.6652.026; Wed, 9 Aug 2023
 06:22:51 +0000
From: Dragos Tatulea <dtatulea@nvidia.com>
To: "jasowang@redhat.com" <jasowang@redhat.com>, "mst@redhat.com"
	<mst@redhat.com>, "xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>
CC: "virtualization@lists.linux-foundation.org"
	<virtualization@lists.linux-foundation.org>, "edumazet@google.com"
	<edumazet@google.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net] virtio-net: set queues after driver_ok
Thread-Topic: [PATCH net] virtio-net: set queues after driver_ok
Thread-Index: AQHZym9/pwpnrNSZ+EadL4G3GlCnWK/hfvgA
Date: Wed, 9 Aug 2023 06:22:51 +0000
Message-ID: <66687029c1235e56d9279800ceb026dca029c966.camel@nvidia.com>
References: <20230809031329.251362-1-jasowang@redhat.com>
In-Reply-To: <20230809031329.251362-1-jasowang@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB5565:EE_|BY1PR12MB8448:EE_
x-ms-office365-filtering-correlation-id: d36ee5ff-20b4-43aa-ae19-08db98a10f0f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 xkJyhJg1geZsN5FC/aRWAdPtvwUF5VGvw+4BPJShnLyDUxWZUgHw6KwdDnEEUcXtSxiDocxRD34uf2Npep8wTFzMGIM55qSDVA/BBjr4ag8R36QAtNgH/bsNSRYoIYI/MGcxqPecGpr8Q6/dVGXmVq7Ms0uZ+wwKADe9zVNT0E53YSD09MTH1gxrG5HJuSXL4e8HhcP4EYmCSCM68ebch8lyRooYrdu3HS3nv6TTx6i+UVhV4vXqc7xLXbF93EJL/VMMMRgg2W8EYDjn9dZkbNau+J+Eji95QFrzuj5s+kEO1FZpm8jle13F4k65NgV7SD/2E2ejMptoHnr+TaWg97DIAvWH6BfNUQwmci7q/GVR9NcaKwl8ix/oiabtHxq48cwvwV1juvjIX1p4M2CNNDILq0V5UaL5r/WvWVzUKwq2pkZ5OFuh/5aC8yhTEOTj9PeEYkBbWAF8gCiTDYThzNZLqmBmXuTKRW87rdnLSqR+inkCnKFr4sivcjdACUwiWUTnMr7pEKuPu28y8b8LThLe3II8Xi5WKYNBmJOS/lXgcaS+SsKjyi6YT8n2Diys4cmAkecqN2N/cAl4b8TNsENOIOGcumT/W+u1wGnaG/CmFb0i3DR30cIr/iRuHZHU
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB5565.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(346002)(366004)(136003)(396003)(451199021)(186006)(1800799006)(122000001)(4326008)(478600001)(6506007)(316002)(41300700001)(6512007)(6486002)(38100700002)(54906003)(110136005)(38070700005)(2906002)(71200400001)(86362001)(5660300002)(83380400001)(2616005)(8676002)(8936002)(36756003)(66476007)(66946007)(66446008)(66556008)(76116006)(64756008)(91956017);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VHhVUnJEY3hvajRaVnhFSG15aUtmOUlQQXQ5b2dkMWNNcU9oNGRDL1hmYXNt?=
 =?utf-8?B?UXlMa3kvMEtBMUw4Z00vMG4zQ1Mxb1ZDYy9ka1ZkY1VHcEJ5M0lUNnRzNUlV?=
 =?utf-8?B?ejNMKzcrVkpjL1M0ZUNMNTZ4emlPMlFKYUx6ZTl6cC9lUWw4MENSUUhVeU5N?=
 =?utf-8?B?VkJHdFdYVmFvZ0FTdmtaSTdBNnNXR1RoTWZXNlNwTVpFRDhBQ243ZDVnbmZL?=
 =?utf-8?B?ZGg3NkZqRnJMS2t1V0V4NDJqZWwwcndmRkhQOU1nQmlOQ2hjcUR5cmVTM2li?=
 =?utf-8?B?QVB0Tm12cE01SGpPRE54OE1rNnNtaUdiYTFGd29OOXAzM1R6NEtBa054WVBm?=
 =?utf-8?B?MHNvZi93WTkvVEFLOGwvZ2pST252dHk3S05vOUlqY1JmVXNxemx5RHZZR1lu?=
 =?utf-8?B?RTRka3dKWHI3NndNNnpUTiszZlIvV1V4cFFzTWdTY3J6WUh6cHNMdzFKTTA1?=
 =?utf-8?B?TWwxdXJOcUdMQmpLVHJ3RlB2Q05NNTd4R1JDQmtvRlo5djM5OFRUMmo4TTFr?=
 =?utf-8?B?d1lmOEdQMkhIdlNIOU5oV3lhdG5vd3FicXVCQm1yUkIxYzA3U3hHK0FteHJu?=
 =?utf-8?B?ckhqaGxlWjVrWitjOGxXR0hTUXpqeGI2R0o0WVhqeCtiU2FwdHdySHMxQVB0?=
 =?utf-8?B?VkpTWjRGS05BUlB0Y3owc083akJaeWwrdnlTNUdWbG95eGlpT3cwUzdzVHZZ?=
 =?utf-8?B?djFwU0IrRXdQYnQxYUk5dXZjd2ltTGVsNW93TUZ1TVY3bWcxYllWN1FBdi9o?=
 =?utf-8?B?MHFGaER5T2RDMWhvN0ZKUmJSK3dweE9nSmlORVlZQnRCcmE3elVpOGQ2djlG?=
 =?utf-8?B?cG14L1VCUzBsR05wc0pvTHhSU0NaNUF0enFQOUZqaDRmenFqQ0IyL0dvRW9U?=
 =?utf-8?B?Sk9LV1MzU3J4MFBvTUNsa1BMcGlhSmJ6MytVK0ovdTJib1llVGJwMkgxTlBT?=
 =?utf-8?B?S3ZWc1JBZW1HaGxXTldUZUFLUW5zMjU3ak1rSE5jKzFRY1pGS3l5Y08rcUlZ?=
 =?utf-8?B?RXg4L0tuY09oQWQ5eFdLTlBMb2pGTjRBRUJWaEU5KzVtMTV6UzBKZU9zYVVB?=
 =?utf-8?B?YTFqR2ZsZVBpRmo0VXF3eW1xTDV2UHFoaElyOGRkcjlycXpuazNNdE5UTTIr?=
 =?utf-8?B?UEJNZXFPV0dZeHQybFk2MUdjMk5LZm9BQWlDWGcvZlgxMXh2bnRMZHNqOENQ?=
 =?utf-8?B?Z3Z5QzNSZlNiK3IxZDF5dkdrVk1BS0F5a2s2UHdjY0JQcTRJdk91T0gwbnpU?=
 =?utf-8?B?dkVnNmw1SVhqK2xuRG9YTGJUSm9HbllmSDdIWnE0eDRKU3RyOEo2OUZvcXAz?=
 =?utf-8?B?VUk3YTZxMnZBSFZxdmlsUWswbVJENjRMekZWMkxQZmltcDQ5YnJiV0xhOVdh?=
 =?utf-8?B?ak5taDNxY1dzWVkzdlM2ZmlNOWVxSERwV0Z3U2lKRU9oY2k0UllLbDdEN1pH?=
 =?utf-8?B?Sk5WZGd2VUZCS0piSzY0WW1OT1grekI3VGNEb1NHMmZPNHN0Uk80b3dOekx5?=
 =?utf-8?B?VkxCQmozT2NIZVpxMDk5NmtyanhWK2VDSmJqZldldUJYZDhweUs2R2dKVVBs?=
 =?utf-8?B?VUpZenlVZ3NURGVkTVUwOXZqem1lV25GZXNSaitYb2ZxclZjZmhqdVE0YVpp?=
 =?utf-8?B?VU5CY3c1MW80Z0hlTzVHOWhVZWo4NjBzSFdiREJVWDJwbFhMSmtYYjg2bXBq?=
 =?utf-8?B?bkdvRjgxUDl1ait0UHdzWXp0ank0SS9TQ0k0RlVqaXI2RXBaUjE5bmZDMHI3?=
 =?utf-8?B?aGx2NUhnSHNDZnFlTEtXWlRoV1I0SnBuZnJIalozTW1Ib2RXWGVjeWtueDhC?=
 =?utf-8?B?ZFlPL0U5a3JRdlFHYnhtcHFLZTRBbVpQZVdlYjBrblZPWlRwcGxxSTFhUjl6?=
 =?utf-8?B?dm4veVpES1F0TEFSdHNYRkhnd1gwSnk5NWR0YWZadlEyMkdxT2l6d0ViWS9n?=
 =?utf-8?B?Sk5wMUM5MjBIT0w1UEpqbFNIaVlGN1BlR3FiUUpvVnk5dnY0d2ovMkdMcllr?=
 =?utf-8?B?enM4N1FVK2pSb1p1M2Vka3JhamFMMXpzSCt2ZW1QOUVWemFQWGZnNkYxR2Rr?=
 =?utf-8?B?R0dJV1Z1UGF1dDZkKzN0cWR6d0llUWdFWUhQR0RGdzRaVlU1NlVLNEJKVVBl?=
 =?utf-8?B?aFY1MHFJVDkvTm5TVU5PZ280cTdqOHFPUk42eVRqMXdIMlBCcktRVnpjVTll?=
 =?utf-8?Q?5TX6yI2SGaJh68OgKhdoctY3lP2EPjA2DMJI6F7xToAV?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AD6CA908443D9F4ABE55F8D6032C5B82@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5565.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d36ee5ff-20b4-43aa-ae19-08db98a10f0f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2023 06:22:51.2491
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vs1q6kFdVphg0s7NcoJryATk9Qc8zFrZ29i0jDVoC2hHjTKf+JigvNIGbaG6Y+ZPLOWYPBNpTukbjVLZfrI6yQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR12MB8448
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

T24gVHVlLCAyMDIzLTA4LTA4IGF0IDIzOjEzIC0wNDAwLCBKYXNvbiBXYW5nIHdyb3RlOg0KPiBD
b21taXQgMjUyNjYxMjhmZTE2ICgidmlydGlvLW5ldDogZml4IHJhY2UgYmV0d2VlbiBzZXQgcXVl
dWVzIGFuZA0KPiBwcm9iZSIpIHRyaWVzIHRvIGZpeCB0aGUgcmFjZSBiZXR3ZWVuIHNldCBxdWV1
ZXMgYW5kIHByb2JlIGJ5IGNhbGxpbmcNCj4gX3ZpcnRuZXRfc2V0X3F1ZXVlcygpIGJlZm9yZSBE
UklWRVJfT0sgaXMgc2V0LiBUaGlzIHZpb2xhdGVzIHZpcnRpbw0KPiBzcGVjLiBGaXhpbmcgdGhp
cyBieSBzZXR0aW5nIHF1ZXVlcyBhZnRlciB2aXJ0aW9fZGV2aWNlX3JlYWR5KCkuDQo+IA0KPiBG
aXhlczogMjUyNjYxMjhmZTE2ICgidmlydGlvLW5ldDogZml4IHJhY2UgYmV0d2VlbiBzZXQgcXVl
dWVzIGFuZCBwcm9iZSIpDQo+IFJlcG9ydGVkLWJ5OiBEcmFnb3MgVGF0dWxlYSA8ZHRhdHVsZWFA
bnZpZGlhLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0
LmNvbT4NCj4gLS0tDQo+IFRoZSBwYXRjaCBpcyBuZWVkZWQgZm9yIC1zdGFibGUuDQo+IC0tLQ0K
PiDCoGRyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYyB8IDQgKystLQ0KPiDCoDEgZmlsZSBjaGFuZ2Vk
LCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9uZXQvdmlydGlvX25ldC5jIGIvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jDQo+IGluZGV4
IDEyNzBjOGQyMzQ2My4uZmYwMzkyMWU0NmRmIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC92
aXJ0aW9fbmV0LmMNCj4gKysrIGIvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jDQo+IEBAIC00MjE5
LDggKzQyMTksNiBAQCBzdGF0aWMgaW50IHZpcnRuZXRfcHJvYmUoc3RydWN0IHZpcnRpb19kZXZp
Y2UgKnZkZXYpDQo+IMKgwqDCoMKgwqDCoMKgwqBpZiAodmktPmhhc19yc3MgfHwgdmktPmhhc19y
c3NfaGFzaF9yZXBvcnQpDQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgdmlydG5l
dF9pbml0X2RlZmF1bHRfcnNzKHZpKTsNCj4gwqANCj4gLcKgwqDCoMKgwqDCoMKgX3ZpcnRuZXRf
c2V0X3F1ZXVlcyh2aSwgdmktPmN1cnJfcXVldWVfcGFpcnMpOw0KPiAtDQo+IMKgwqDCoMKgwqDC
oMKgwqAvKiBzZXJpYWxpemUgbmV0ZGV2IHJlZ2lzdGVyICsgdmlydGlvX2RldmljZV9yZWFkeSgp
IHdpdGggbmRvX29wZW4oKQ0KPiAqLw0KPiDCoMKgwqDCoMKgwqDCoMKgcnRubF9sb2NrKCk7DQo+
IMKgDQo+IEBAIC00MjMzLDYgKzQyMzEsOCBAQCBzdGF0aWMgaW50IHZpcnRuZXRfcHJvYmUoc3Ry
dWN0IHZpcnRpb19kZXZpY2UgKnZkZXYpDQo+IMKgDQo+IMKgwqDCoMKgwqDCoMKgwqB2aXJ0aW9f
ZGV2aWNlX3JlYWR5KHZkZXYpOw0KPiDCoA0KPiArwqDCoMKgwqDCoMKgwqBfdmlydG5ldF9zZXRf
cXVldWVzKHZpLCB2aS0+Y3Vycl9xdWV1ZV9wYWlycyk7DQo+ICsNCj4gwqDCoMKgwqDCoMKgwqDC
oC8qIGEgcmFuZG9tIE1BQyBhZGRyZXNzIGhhcyBiZWVuIGFzc2lnbmVkLCBub3RpZnkgdGhlIGRl
dmljZS4NCj4gwqDCoMKgwqDCoMKgwqDCoCAqIFdlIGRvbid0IGZhaWwgcHJvYmUgaWYgVklSVElP
X05FVF9GX0NUUkxfTUFDX0FERFIgaXMgbm90IHRoZXJlDQo+IMKgwqDCoMKgwqDCoMKgwqAgKiBi
ZWNhdXNlIG1hbnkgZGV2aWNlcyB3b3JrIGZpbmUgd2l0aG91dCBnZXR0aW5nIE1BQyBleHBsaWNp
dGx5DQoNClRoYW5rcyBmb3IgdGhlIHF1aWNrIGZpeC4gRG9lc24ndCB0aGlzIGZpeCB0aG91Z2gg
YnJpbmcgYmFjayB0aGUgb3JpZ2luYWwgcmFjZQ0KdGhhdCB3YXMgZml4ZWQgaW4gY29tbWl0IDI1
MjY2MTI4ZmUxNiAoInZpcnRpby1uZXQ6IGZpeCByYWNlIGJldHdlZW4gc2V0IHF1ZXVlcw0KYW5k
IHByb2JlIik/IE9yIGlzIGJlaW5nIHVuZGVyIHRoZSBzYW1lIHJudGxfbG9jayBzZXNzaW9uIGFz
IHJlZ2lzdGVyX25ldGRldg0KZW5vdWdoIHRvIGF2b2lkIHRoZSByYWNlPw0KDQpUaGFua3MsDQpE
cmFnb3MNCg==

