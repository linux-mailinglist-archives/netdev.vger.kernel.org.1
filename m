Return-Path: <netdev+bounces-41705-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 024C77CBBD9
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 09:01:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9657CB20F8D
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 07:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44ABF13AF8;
	Tue, 17 Oct 2023 07:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kWi8a7US"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09DFC2D8
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 07:01:39 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2089.outbound.protection.outlook.com [40.107.220.89])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33C75AB
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 00:01:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=akls2u5g5WfQqAgbA4JjdVq68SkmvT7BpdEtJh3d4i2935QgdjaNXDcq6hKFmFzXrifMJinK0j7HDiHI4kzZnKWPkN1Q4LaR9z9fwHNnOTjfAr13H61fDuf9FjueVRfv1LOK8gyAl0eiQP8A8zkkZpI1Ejb0GBICvEuwNZmvIAY/Qy5E8ocRVRMG5kA3V7rP+0bgrj+lVllrLz4A5wExHHhsXt9mX39uLDhPx0Xzm17bBuUNKQPDrDdDArEXzwGybdBaYE6xTzhVJmlIHijqJNiU4K1TV+v2XYwcUGPhiLdbQ5efkpLN6+wspqKlUwtj81P/2GVuiD/ffjHQjQ6PCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Chw10eC2qJ2SJTPhAO1k7vJCmkdyh/KX3nuT9ZSE44=;
 b=Vwk+xeO5bB5S4Dy4AFn5mw8pUmjqX3DnUA1jRLv6IYbHGi85F5erXyEI7skQgYx1w+YBXZLC/QgfAVZfWumpUd7ucu9wZYVE6FFkp3ddje4TfMMJA4NfW0xa2ocWW1xn89m3s2wODteWMDAObpellrcb4eDRtJ3pAX2Ujf+zsW6KYKXl8cm/nxAL3IxEFW0bDSPyZjYIl1LXhKUwO3vwLoxK9p3o+1xtE3Ply2WoGV1Tlxi2eYQVL4HAU38X11JtmqnMjC5IgApj8skHGEtPO8f8QmgIhL7sXzfwqILaX8nGlCBXHFvkaVRwrRhL+TM31OimjTHxRhxy7ygAGvEl+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Chw10eC2qJ2SJTPhAO1k7vJCmkdyh/KX3nuT9ZSE44=;
 b=kWi8a7US4khkKlT92gkPH1ivrXiDCKr+Xrhct+JY9J2/weI8xa79BG9xp2JHqa4Pota8jDRfTCxt8myxiiRmdKDKvD9w1Gut62yWXHtvGmjjvTGpFSvdBMxvRHRfnVuKuCmcZtdXbBjwy+QbPYvwz9viZCPdLh9EQ10j3TNadqGw39ve3soqXJWipohtMBHbiqTSOy7HcGAwNHl5u0SqupFNJc2ki+W1gozwooOlt71nuku/x9gIZEIoAXs4gcLQNBAgFUCvX01JYqb754GQ0fKre4b17ud/9bdE90k+ctn2x22baInvXyhI/WSDDlYta1t6WB6LqICqjfZZNnkbQA==
Received: from BL1PR12MB5922.namprd12.prod.outlook.com (2603:10b6:208:399::5)
 by DM4PR12MB5359.namprd12.prod.outlook.com (2603:10b6:5:39e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Tue, 17 Oct
 2023 07:01:35 +0000
Received: from BL1PR12MB5922.namprd12.prod.outlook.com
 ([fe80::7ac4:7661:d912:94d4]) by BL1PR12MB5922.namprd12.prod.outlook.com
 ([fe80::7ac4:7661:d912:94d4%6]) with mapi id 15.20.6886.034; Tue, 17 Oct 2023
 07:01:35 +0000
From: Amit Cohen <amcohen@nvidia.com>
To: David Ahern <dsahern@gmail.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, mlxsw
	<mlxsw@nvidia.com>, "stephen@networkplumber.org"
	<stephen@networkplumber.org>, "razor@blackwall.org" <razor@blackwall.org>,
	Roopa Prabhu <roopa@nvidia.com>
Subject: RE: [PATCH iproute2] bridge: fdb: add an error print for unknown
 command
Thread-Topic: [PATCH iproute2] bridge: fdb: add an error print for unknown
 command
Thread-Index: AQHZ+2BLG+odwiI6VkCtD1QVbhA1orBHBnmAgAT3ePCAAKRagIAA9mUg
Date: Tue, 17 Oct 2023 07:01:35 +0000
Message-ID:
 <BL1PR12MB592232E86206F816DD1901AACBD6A@BL1PR12MB5922.namprd12.prod.outlook.com>
References: <20231010095750.2975206-1-amcohen@nvidia.com>
 <169716482325.8025.6745747640034207795.git-patchwork-notify@kernel.org>
 <BL1PR12MB5922484EDA55CD9363B0D673CBD7A@BL1PR12MB5922.namprd12.prod.outlook.com>
 <9c0d9c44-c32a-92c3-860f-e391468b8eed@gmail.com>
In-Reply-To: <9c0d9c44-c32a-92c3-860f-e391468b8eed@gmail.com>
Accept-Language: he-IL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5922:EE_|DM4PR12MB5359:EE_
x-ms-office365-filtering-correlation-id: 8f8a8604-71e8-4d0f-307d-08dbcedee6c7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 URvTVRhtWlFpvCl+RrOCM8NhxwehIbXxiFdgl19b4yZUP1yB5Hm2sw/Ev2WbLTL5oxC4yB5R5ocBd8mrZyqyGGTPiiob2hrWClbgdC568vYyXmthPHMUDHnFRSv5cbmh8wgYqL60t/LnV4TK0nmMBBQeDl1wyrpA+SA2x07avHFvgmXwvGtl/gYmsUtrQAFRKRCMXyACjtbZKchO59DmDrRUmtqvkbO3dEkVee1kqHcBPb2UFMUx7bPF3PpNKi3OmFyAR4sr3y5PsvHRLdC7+H9wF8bN4lv61qNAYcr5zS5DIZkkxjJarvHdB5U/k/d9abgTZMw/mY7S7gsQJbpTbd0kBaU44qyfHfj4pI861zMfbjMivo9PJT1ZOkN7E3Alqc1YpdhqzfUBzgIAWxxdG6sko3Yu4nnOmu/ahhx70biOfDTfy5KmvKn6aiBhAdAXDkNzckLc0ArCJNSPrHui8WfVu6GA7WBgK+HSdBWe6KnmOUSPg67Y7c9S/kmdlXmmLFT81VFP7bm7KjxTdGtc+HQSrNFlD9RElDQWhUcec1phDJFaET0OEa7/uu+WW7SqhpUZ9lOuVsn/dOSGROjeo6NBLIfWpI6O0ifMdCJMYaXnjKdBoxDPK55p8UJB0S1v
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5922.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(366004)(39860400002)(346002)(376002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(76116006)(478600001)(6916009)(66446008)(66476007)(54906003)(316002)(66946007)(66556008)(107886003)(26005)(7696005)(64756008)(6506007)(2906002)(9686003)(8936002)(5660300002)(8676002)(52536014)(4326008)(4744005)(41300700001)(71200400001)(33656002)(86362001)(38070700005)(122000001)(38100700002)(83380400001)(53546011)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TUVrYVN6NDllNWlCWm1yMmYxc2M5Tko1bk9LTTJRZkdTUnIrVUtsVktGdlZi?=
 =?utf-8?B?UmhTcW85bnAvcnBEMVo4eTlSWE8waFpHUHc4aWs1SnFtR2tnbm9nNy9uZjNN?=
 =?utf-8?B?WEc2UFhBQ1I4TFRwVzk0Y0JRU2M3QzRVVHpZakZqWDh1ZldhRTUvZXVDckZR?=
 =?utf-8?B?M1k4STlHRjRZOWR6R2prSll1ckN5aVpSYUtLakpESEVoOWpYelBmUkpVRW5y?=
 =?utf-8?B?NFlVVHhaQ01PKy9XcTBJTGJzNEpBQnZwRU4rUmlOK0VXUzhiTURhZmtZcTlq?=
 =?utf-8?B?aHloRU0wdldnb250b1dsOUcrSkJjSVhjU0RrU2xidEN6am1SRXhKV1BZUXd3?=
 =?utf-8?B?RHp3SVVLTEo2WWphS01TMUVLaTZwRUcwRzdycGNLc2VhRDlOaDdKUlhmUlNi?=
 =?utf-8?B?NDJiNXB4WE1sOUJVUVhxUTZPc1JvY2dQb2VrdWY3eXhjdnZXZXIxVG9BcExQ?=
 =?utf-8?B?S3RXK0d4S0JWRFU4dFBCRkdRNG42OEdvcEpza0RCbGdRV29pY1RROHJSYklm?=
 =?utf-8?B?ZTVRU0VqdFJSOElzLzBucnBzNi8rYzVmbDJPa01hREkreEN6K2ZrNE9JclRX?=
 =?utf-8?B?RTZqRDU3NU4wcDZQMG5GcDB6b3JKeWdRNUZlMG8zejZBU2ZTYzhTQ0J6dUlq?=
 =?utf-8?B?QWIvZEFKczlnSlhELzkvUXJrQ25SNXZTbFZkbHlpU0pqM0s2UHFoaUJPcjZB?=
 =?utf-8?B?Yk5rNkwvTG10YnoyUzJ2d21WOW9QbWNlc01oTDkrbldzS3ZROEk5bDlFVTdy?=
 =?utf-8?B?Q2p1SGJCdStXY0Jad1ZmMHc2WXdVc1h0V25XRTFiSkdmeXExWkFWV1pmRWFj?=
 =?utf-8?B?N2xndmhHbUozdnlYeWMxWTVIcTZwT3VtMmR5MWlPSTlLdldFUEMrWW01bTFy?=
 =?utf-8?B?anRkZmVEeUZBaWJ2Qm40eVRLZXA4K1RUc0hQVEV6UHlydjFNTkcyaUgwK3Jz?=
 =?utf-8?B?SG01N05sejRGbnVrOGo0akRjZ0J6bzJYa21xdlhiUnFmVEJOa1BKMG5aZHhp?=
 =?utf-8?B?d0ppQmhQU0pxK01EbFFsclBYeGxOM2hjWm5mVlZCSDcrWUNkR1J0MnZjMzAw?=
 =?utf-8?B?YmxlVm1ETkMrejNXYXFiTGRjRnBsclpZRDBJaTZpREQvNUUvdTU5MnhDclZ6?=
 =?utf-8?B?S3dkOVNJTlhEUVh6aDdVSTVpZ21XKytMdFMvb0hPMVk5SDBzSDVQS3pBQ0dv?=
 =?utf-8?B?NzdiUk9zV09wMTlURlYwRVEvQ2hYZlZwVlE5TEtOMmxGRkE2Tk5WdjRnWWdx?=
 =?utf-8?B?NGNtUGk2dnJMMXgrRHhJc0I4MWtKdzhqZGhOOVFqYzR6RmpPQjRlYTFSOE1m?=
 =?utf-8?B?NlpHU3B2dnhuZkY5WlJHUFdyYkdLSzRsQUM5V3EvOHM1UDczSllVbDZ3UDJW?=
 =?utf-8?B?OWlyb3FGVU9TdStpb0laQ2tnOFRXTGw5cDJNVFJrQUVVUzNCbFF0eE9hSUpk?=
 =?utf-8?B?QVlVOS9DdExrVTZVSHF2ZVMrZzNGd3k5ZFRSSnErT0h5M25OdW8rOFVVSGtv?=
 =?utf-8?B?dksvY1lkOHJiLzl0VXFxdkVjeFdZSW9xSEpuOXlJQzUzMUY5blQzVDEzQTQ2?=
 =?utf-8?B?Q08rS2EwelNrR204N2Y4L3F4SGFUSUVEWk5PbGZyMHZraldXbjNUd0RFNGlq?=
 =?utf-8?B?Rzd4VXZJZGZ2UGRhQU1seTlLVkFENnI1Vk1wdnNqUk45ZWVwaW1aQVR6Y05a?=
 =?utf-8?B?Y0ozYjRsUHZPcFc1eWxNcEpTbWlHZDNuZUNtYzB0U1pUK3UxdmwrQitqSzdx?=
 =?utf-8?B?bTdDS1dNT3I0VjRtYytVRWJYd3pqZDNtMkFOUlQyMUpoSHFhMURxVktqQzZo?=
 =?utf-8?B?Y3dOZWxFNHVNV1VTQWN5YUJkSmtpM09VSWxjWTAyazVOY0tBc0ZFdW9yZHpy?=
 =?utf-8?B?Q3JKVFk2akZiMG85NTI4TDlueEZqQXAyeDBvUnBteXBlQkQraGZvaVgrcE95?=
 =?utf-8?B?ZFJISGxFZFJXVmpqdHJ5QS9udzNQTmRET3dFUWJPOE9TamF4RDhJTGFlSWJM?=
 =?utf-8?B?enkrVllPZzJHb0NvNWhSQytBb3JKajBLWWpQSFIxU2NYM0x3NWl4QWx2VXFQ?=
 =?utf-8?B?WGZjTDhrbTl2a1VEUkQ1RFN3MUptVy96T0M0ZStVZUNXUHVBTWt6VndlMFh2?=
 =?utf-8?Q?bBMi6F1/2GbjVCBH8R8ey4YrS?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5922.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f8a8604-71e8-4d0f-307d-08dbcedee6c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2023 07:01:35.2707
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vut0J/O7s+OixsW5OHtRCfqWrQ3LTQHnw84dceVqg7fj1r3vqBiHTvVJag/R7Zn3QGwlWPNUvf6fbwVvYaoMug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5359
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGF2aWQgQWhlcm4gPGRz
YWhlcm5AZ21haWwuY29tPg0KPiBTZW50OiBNb25kYXksIDE2IE9jdG9iZXIgMjAyMyAxOToxOQ0K
PiBUbzogQW1pdCBDb2hlbiA8YW1jb2hlbkBudmlkaWEuY29tPg0KPiBDYzogbmV0ZGV2QHZnZXIu
a2VybmVsLm9yZzsgbWx4c3cgPG1seHN3QG52aWRpYS5jb20+Ow0KPiBzdGVwaGVuQG5ldHdvcmtw
bHVtYmVyLm9yZzsgcmF6b3JAYmxhY2t3YWxsLm9yZzsgUm9vcGEgUHJhYmh1DQo+IDxyb29wYUBu
dmlkaWEuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIGlwcm91dGUyXSBicmlkZ2U6IGZkYjog
YWRkIGFuIGVycm9yIHByaW50IGZvciB1bmtub3duDQo+IGNvbW1hbmQNCj4gDQo+IE9uIDEwLzE2
LzIzIDEyOjM2IEFNLCBBbWl0IENvaGVuIHdyb3RlOg0KPiA+IEhpIERhdmlkLA0KPiA+IENhbiB5
b3UgcGxlYXNlIG1lcmdlIGl0IHRvIGlwcm91dGUyLW5leHQ/DQo+ID4gSSB3YW50IHRvIHNlbmQg
cGF0Y2gtc2V0IHRvIGV4dGVuZCAiZmx1c2giIGNvbW1hbmQuDQo+ID4NCj4gDQo+IGRvbmUgLSBt
ZXJnZWQgbWFpbiBpbnRvIG5leHQNCg0KVGhhbmtzIQ0KDQo=

