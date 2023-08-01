Return-Path: <netdev+bounces-23025-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C12076A6ED
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 04:25:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9C75281347
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 02:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C503E807;
	Tue,  1 Aug 2023 02:25:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A9B7E
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 02:25:38 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A2AB1BEB
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 19:25:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O1GOqtjREUiVwpCwNGCtb2mbOrEGUPxwgKOED7k+FQAXhpsEJKv6PoZa7VrOF5QDvBp/H7i3a1v94sO7sXg4cexjSjXkzZ+v+0QnE/HoO+Uy3/FNIv3yu7RXZbivHtE4HTehFVwiBu+2q+Io9eBmcAMwpfqQezEuz+wI3X21/Caz24eWyWNgH2rAh/6DZQ5W7/HTw6xMMra0ZilmtQW9n07JxpZK5Tbbs/rwsDc1GplyK6KFSrZdiYParb5/eYhZniMWpAUEATFWbTkJ5pkyds9TJAMFhEn3K3lt3oMdc74nA34YGRgWcuW3dNsYh70t/7+hhGKJSP3Vd/jJAX3RUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E5X1IOA73qs6p5niNQO+N9YGbgNzeyOKLsJxJXYLTB0=;
 b=mN4m6jfXltcxn9S77+1KIzFPH8vYzoV2cvbbaXFGHgoWUYExyFTAHbxvAz91FILHLvLIEKI0C5GohiEfSsTso4CrdKMAYow3NOer9zuBo0Frwx9izzHH40ax0Vggz5nmGy3kc+gZe1nXYd9cyqZvro+xkExsv/QLcsiW6HJPEG6WTE/okzUoUWJ8M9AqgQyKyLazmn6aUFhqqP59CTRMZRId2znsQAjq8AsqB2TkCmriozPU/ii2u//wpZycIMzQQ01TZgUz+vkPCibw1vgPQ9LK5So0/PoAQjvITL8Xg9dUgamAF3xL4iHB0FE+gXbzV1PkQugVXK1i9CSy7s8YhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E5X1IOA73qs6p5niNQO+N9YGbgNzeyOKLsJxJXYLTB0=;
 b=okWimUQjQ0MaczNBmkYkPdcFju+BW3YPNh/qogTJBP4TDeKxws8r3E1Az5FnfaK61+wZxPd0zaO/6dfylLFMsyDVR6zlzusjqV402RKaCOMEW94PWOTEkDc3E32krIT/s3IoM8gULwLPI7SI/cW18APZomL9uh1PgC5dpuJ2zFF+aIq4/bbUhymTNJCiZnOMedDZbCJkucM4SOHiBHvGo9tDx9uILBL+eD601Yud8wpbGXayRmBmbXZSgtUWbaaMD/ARzizRwOTX+LVJikhUplbfQojDqkDhF6kwaRMIvqyzAin4DrnQjuMJFZfGEmxxzJkGE/8zye54cI+cekT0Hw==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MW4PR12MB5626.namprd12.prod.outlook.com (2603:10b6:303:169::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.39; Tue, 1 Aug
 2023 02:25:35 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::c3cf:2236:234b:b664]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::c3cf:2236:234b:b664%4]) with mapi id 15.20.6631.043; Tue, 1 Aug 2023
 02:25:35 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Aurelien Aptel <aaptel@nvidia.com>, "sagi@grimberg.me" <sagi@grimberg.me>,
	Shai Malin <smalin@nvidia.com>
CC: "davem@davemloft.net" <davem@davemloft.net>, Boris Pismenny
	<borisp@nvidia.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"kuba@kernel.org" <kuba@kernel.org>, "aurelien.aptel@gmail.com"
	<aurelien.aptel@gmail.com>, "hch@lst.de" <hch@lst.de>, "axboe@fb.com"
	<axboe@fb.com>, "malin1024@gmail.com" <malin1024@gmail.com>, Or Gerlitz
	<ogerlitz@nvidia.com>, Yoray Zack <yorayz@nvidia.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Gal Shalom
	<galshalom@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>,
	"kbusch@kernel.org" <kbusch@kernel.org>
Subject: Re: [PATCH v12 07/26] nvme-tcp: Add DDP offload control path
Thread-Topic: [PATCH v12 07/26] nvme-tcp: Add DDP offload control path
Thread-Index: AQHZtNxNA/xtp5K1mUmqPygHvione6/U1S0A
Date: Tue, 1 Aug 2023 02:25:34 +0000
Message-ID: <8a4ccb05-b9c5-fd45-69cb-c531fd017941@nvidia.com>
References: <20230712161513.134860-1-aaptel@nvidia.com>
 <20230712161513.134860-8-aaptel@nvidia.com>
In-Reply-To: <20230712161513.134860-8-aaptel@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|MW4PR12MB5626:EE_
x-ms-office365-filtering-correlation-id: 76a1bcca-a5de-4f34-9cc4-08db92369622
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 fUYDWHk/fCSNveyI1oeDNddkPuINsBoJuTuNm8bsRwZS93OvcJKmPghYIGSIMDIryTXr83A8JkNXw12lBeeLh2uySC8hvXW+nG2LQHJ2jCtyPHizv+7bezU7zq3YlrqFDIaXkXjzHJ9j315Fto1LRlAEcabKBXYsT90dMr9HnrYjtUi0Qrk46vba7TllCpuZCJX1KUYjtki5EFLQFTZI0sle6mYo1zmThmblG3DD+SK0fOrMuq9/Yk24s3n6/28W5yCOwmTCIx5GRVxacXUdcn7XtOqlcRD2Ldtlzy5wo7/UadWkqI9Ddikw9fzDkkTfpo2aVc8vPaqw8uVSUQx+gaKxPLlO+M3ogyAlp2vHHaJQTEzT9J098nhC3K1Cp094CuusmkZCRodh1/B2G5UuFEA687NUobz8L+/RY2c+/cBq7ZQpVJiW5DebuAef443FWPDS7am7QwxIY1qyBc3TljGTQqv/Rl1pzvLE+DQDbyCxnaQxUxdDHmTFWudoVPLkktYT0PhJxo4/mPkqlpCWbZxhivOw3nkKaI8qmf4vQZdx2oAlvSWs2JqvQlHfJhFFl/R5akBbGK6q/JBQLzEuZMxnmEThbweJAOF6PestNIvpzLe/bVPl2A7/VPldsnd8BsQqeDHKWDPBRxDRUVjBTXHsqoPOZnUt5ITZbHSyEB1DFW7yC+RAuIs9FfJrfNll
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(366004)(39860400002)(346002)(136003)(451199021)(6512007)(71200400001)(6486002)(186003)(36756003)(2616005)(83380400001)(86362001)(31696002)(38070700005)(122000001)(38100700002)(6506007)(26005)(53546011)(6636002)(66476007)(5660300002)(66556008)(4326008)(41300700001)(91956017)(8936002)(8676002)(31686004)(76116006)(66946007)(66446008)(7416002)(316002)(2906002)(478600001)(64756008)(110136005)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UCtHUlRpM3kwZVpqZHJtTzBtTFlrekNwc2Fma1pUVDRoVjJwU2Vnc3dxdVQw?=
 =?utf-8?B?WEZmYXVDMm1keU9YcFlYMHFPQ0gvSVZmUnlEdmMyVmdpQ0tyeU1NZ1dsY3BO?=
 =?utf-8?B?KzFmNmdZQ3pDU3Q3Y3ZmYmZabER1R1FScUF6N3BYUXZUWHVKcGNqdFdZUThr?=
 =?utf-8?B?MGFleDJ1Vy9qS1prQTdsdnBPYnlQUCs2S2dsRWVIQ28wQXQ3NnV5OVVCeE1j?=
 =?utf-8?B?ZStWZHlHM0JSMmpia1dOOEhYYVVQeEpVeTl0TVVJeU5ZSWUwVVp5TUpwTzZH?=
 =?utf-8?B?Z21ETlE4ay9SUG5MUG9oTzVuZGNYTDRGU3Q4WU91TjVFV2xRdkFKMjcwK1hj?=
 =?utf-8?B?MUVQLzdUaHdNdFowQTZGK3NOQUY2TVllZTh5UU5EZlBVUExmVHZrSnlZY3ow?=
 =?utf-8?B?d0YydFhRVFJpS3UxM2lKand2ZHU2aDJPV21vMjl4QzFaaVBMdEtFTzZrdWxY?=
 =?utf-8?B?Rmx6M1FiNUVUcVdKK09td0VDRGNWVGN1ZkVpMVRlUnJ3OHl3QXF0SnVEWmhw?=
 =?utf-8?B?SmI3MEwxbGtTV0YwanRLK3QyamEzYks1cXplYnVZQ2hjb1pPZTBLUlAyZUhC?=
 =?utf-8?B?MHR3R1lwYXh0Zmt2Wk1kNUtxM1BmSkF2OE9EMjJmUnBFbCszc0s1Nkxrd0tS?=
 =?utf-8?B?UkF3TjRwbU95NGx4RVdWZUMzUWllVVZxNEFTYmFXaTEyM0ExaWtqMHIwZ3dU?=
 =?utf-8?B?SXY3eHN5bExXdzJ5UFBRV04wZEdyMENiamZub1M3TjFmV3lpejIwdm5DS0Rn?=
 =?utf-8?B?YWJPV2lQdEhvYlZrRG1CekZveElaN3ova0JmeVJvdHUwc1JhODlyTWdhMEdC?=
 =?utf-8?B?RFcxeU9LcmpGVVE1UG1XS0xJZ1FtaEU2c280bE1mcVVOSitzQXV3SHJZRGx3?=
 =?utf-8?B?NmI5dU9RQlNsWDVsa3dyaS9WSnFVaXFYQkdxU2wzT0FpUWFYMmFhN2FKcDhJ?=
 =?utf-8?B?K3dYaWxPQWVtWXBNOSt6OUlzZVU1MkQwVGxnWTZXcm5LcHY4NjRrMldMbmdE?=
 =?utf-8?B?RXAwUTFhK1lJMFFvTUk1T054UENKVW9nRlYxbFFIRzhBWjYzbDZ0c1l3Vkll?=
 =?utf-8?B?b25ESktLVmtTNTVoZnBxSDFaZ0MyNnRPSVZ3Qzd1Sk96bHFkOFNwN1lQYitj?=
 =?utf-8?B?WWduTkxaeVFSUThETFlWUlBLeng2REc2OHhRajFoVm1sTGZPVmZvQWZvN2VQ?=
 =?utf-8?B?Wng1Rk1qL2UvWklLcVp0ZzBxUForL0dNbE1oaHRsc3d4eUd4Ymc1ZGRGNjRT?=
 =?utf-8?B?akcrWlR5R3pqSHpmamsrZW9MenoxZTRhZ3pSekRGOG84MEgvT3pkZnJoNTA2?=
 =?utf-8?B?K0FlZG9kcHRoNHNvS1JXdkoza1JXcmFDb1M5d2wwRCtTdlFXenU1Ymx1TU5X?=
 =?utf-8?B?Y0U4Q3hldG9EZ0ZVUFVHZm1nWTBuYnBKQmI1WXVIaEU0dm9zM0VTbVd0b0c1?=
 =?utf-8?B?U1Y4MVdTRGNpM1JEMzZ0WGsxeENRZFV4OC9MUG0xeUNETWVkRHUyWTA5MWJX?=
 =?utf-8?B?WEtPbmJnZ2xyZXI2cWwxNjFOUWVISzV4UThHV3ROMGRXTTQ1OFVySnZOSUVn?=
 =?utf-8?B?c0ZiM3pGODYrMy9vN1FxZ0NZUEtISDFmMGlSQWc5V0ZxOTdoa1BhNXM0eDhw?=
 =?utf-8?B?eTRrKzY5RHNJbUpVc0sxMW9oM0d2ZWFmQ3hRT0Qrd2FucmVnM0QxckV1Ny9w?=
 =?utf-8?B?VnMzVExhcmxib1IvbHBKOENHNTB3eUJ0Y1gxMVBjNE0wejNvSCtsaVZhdFBi?=
 =?utf-8?B?K0p3VE9ERVpPRG1FRTlCMUdvYUxzZnVOWTBrRXpGVFloYi96ZzRKdlFlZlhy?=
 =?utf-8?B?L2FRYzMzKzFaNkYzZTUySTUzUHRNNUxLUWhwQ0o4bzkrZy9kUWhodHdiSWJh?=
 =?utf-8?B?aHdFRXBNOWNIRWRVRjMwU0c5UEE4VmhvVjNkU3lwZ2wrb2FtRTlWMUhPZzUx?=
 =?utf-8?B?RlNkSjN0Qk5rcGFtZlFjei8yVjNzSHcwMkNUUndKOU83WDdSb1BwWmsxNFBY?=
 =?utf-8?B?eW5vbTRya1Bqb0tsMnRQcmpjUUFWemsrK0hnWkxab0x1MG5LbEpISm8wYW9C?=
 =?utf-8?B?MUsvWmRvNjNlKzFZREVCeWxIWjFlTEV1b2lWcmdObnNVc3NmVDc1V3QxdXZE?=
 =?utf-8?Q?jymgNWMwDSSZBsrjH9vNCPxQd?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CF88B9F9307DCE469E40F9E382E3605D@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 76a1bcca-a5de-4f34-9cc4-08db92369622
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2023 02:25:34.7517
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W3wDo4e3s8IQv5PyVoTfvnVxs9FvFjs6cH7vqhNulq0SsMoR59jndGe2y1QZ0XsJj949cNqZSZKyK7zB7RJveg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5626
X-Spam-Status: No, score=-0.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
	SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

T24gNy8xMi8yMyAwOToxNCwgQXVyZWxpZW4gQXB0ZWwgd3JvdGU6DQo+IEZyb206IEJvcmlzIFBp
c21lbm55IDxib3Jpc3BAbnZpZGlhLmNvbT4NCj4NCj4gVGhpcyBjb21taXQgaW50cm9kdWNlcyBk
aXJlY3QgZGF0YSBwbGFjZW1lbnQgb2ZmbG9hZCB0byBOVk1FDQo+IFRDUC4gVGhlcmUgaXMgYSBj
b250ZXh0IHBlciBxdWV1ZSwgd2hpY2ggaXMgZXN0YWJsaXNoZWQgYWZ0ZXIgdGhlDQo+IGhhbmRz
aGFrZSB1c2luZyB0aGUgc2tfYWRkL2RlbCBORE9zLg0KPg0KPiBBZGRpdGlvbmFsbHksIGEgcmVz
eW5jaHJvbml6YXRpb24gcm91dGluZSBpcyB1c2VkIHRvIGFzc2lzdA0KPiBoYXJkd2FyZSByZWNv
dmVyeSBmcm9tIFRDUCBPT08sIGFuZCBjb250aW51ZSB0aGUgb2ZmbG9hZC4NCj4gUmVzeW5jaHJv
bml6YXRpb24gb3BlcmF0ZXMgYXMgZm9sbG93czoNCj4NCj4gMS4gVENQIE9PTyBjYXVzZXMgdGhl
IE5JQyBIVyB0byBzdG9wIHRoZSBvZmZsb2FkDQo+DQo+IDIuIE5JQyBIVyBpZGVudGlmaWVzIGEg
UERVIGhlYWRlciBhdCBzb21lIFRDUCBzZXF1ZW5jZSBudW1iZXIsDQo+IGFuZCBhc2tzIE5WTWUt
VENQIHRvIGNvbmZpcm0gaXQuDQo+IFRoaXMgcmVxdWVzdCBpcyBkZWxpdmVyZWQgZnJvbSB0aGUg
TklDIGRyaXZlciB0byBOVk1lLVRDUCBieSBmaXJzdA0KPiBmaW5kaW5nIHRoZSBzb2NrZXQgZm9y
IHRoZSBwYWNrZXQgdGhhdCB0cmlnZ2VyZWQgdGhlIHJlcXVlc3QsIGFuZA0KPiB0aGVuIGZpbmRp
bmcgdGhlIG52bWVfdGNwX3F1ZXVlIHRoYXQgaXMgdXNlZCBieSB0aGlzIHJvdXRpbmUuDQo+IEZp
bmFsbHksIHRoZSByZXF1ZXN0IGlzIHJlY29yZGVkIGluIHRoZSBudm1lX3RjcF9xdWV1ZS4NCj4N
Cj4gMy4gV2hlbiBOVk1lLVRDUCBvYnNlcnZlcyB0aGUgcmVxdWVzdGVkIFRDUCBzZXF1ZW5jZSwg
aXQgd2lsbCBjb21wYXJlDQo+IGl0IHdpdGggdGhlIFBEVSBoZWFkZXIgVENQIHNlcXVlbmNlLCBh
bmQgcmVwb3J0IHRoZSByZXN1bHQgdG8gdGhlDQo+IE5JQyBkcml2ZXIgKHJlc3luYyksIHdoaWNo
IHdpbGwgdXBkYXRlIHRoZSBIVywgYW5kIHJlc3VtZSBvZmZsb2FkDQo+IHdoZW4gYWxsIGlzIHN1
Y2Nlc3NmdWwuDQo+DQo+IFNvbWUgSFcgaW1wbGVtZW50YXRpb24gc3VjaCBhcyBDb25uZWN0WC03
IGFzc3VtZSBsaW5lYXIgQ0NJRCAoMC4uLk4tMQ0KPiBmb3IgcXVldWUgb2Ygc2l6ZSBOKSB3aGVy
ZSB0aGUgbGludXggbnZtZSBkcml2ZXIgdXNlcyBwYXJ0IG9mIHRoZSAxNg0KPiBiaXQgQ0NJRCBm
b3IgZ2VuZXJhdGlvbiBjb3VudGVyLiBUbyBhZGRyZXNzIHRoYXQsIHdlIHVzZSB0aGUgZXhpc3Rp
bmcNCj4gcXVpcmsgaW4gdGhlIG52bWUgbGF5ZXIgd2hlbiB0aGUgSFcgZHJpdmVyIGFkdmVydGlz
ZXMgaWYgdGhlIGRldmljZSBpcw0KPiBub3Qgc3VwcG9ydHMgdGhlIGZ1bGwgMTYgYml0IENDSUQg
cmFuZ2UuDQo+DQo+IEZ1cnRoZXJtb3JlLCB3ZSBsZXQgdGhlIG9mZmxvYWRpbmcgZHJpdmVyIGFk
dmVydGlzZSB3aGF0IGlzIHRoZSBtYXggaHcNCj4gc2VjdG9ycy9zZWdtZW50cyB2aWEgdWxwX2Rk
cF9saW1pdHMuDQo+DQo+IEEgZm9sbG93LXVwIHBhdGNoIGludHJvZHVjZXMgdGhlIGRhdGEtcGF0
aCBjaGFuZ2VzIHJlcXVpcmVkIGZvciB0aGlzDQo+IG9mZmxvYWQuDQo+DQo+IFNvY2tldCBvcGVy
YXRpb25zIG5lZWQgYSBuZXRkZXYgcmVmZXJlbmNlLiBUaGlzIHJlZmVyZW5jZSBpcw0KPiBkcm9w
cGVkIG9uIE5FVERFVl9HT0lOR19ET1dOIGV2ZW50cyB0byBhbGxvdyB0aGUgZGV2aWNlIHRvIGdv
IGRvd24gaW4NCj4gYSBmb2xsb3ctdXAgcGF0Y2guDQo+DQo+IFNpZ25lZC1vZmYtYnk6IEJvcmlz
IFBpc21lbm55IDxib3Jpc3BAbnZpZGlhLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogQmVuIEJlbi1J
c2hheSA8YmVuaXNoYXlAbnZpZGlhLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogT3IgR2VybGl0eiA8
b2dlcmxpdHpAbnZpZGlhLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogWW9yYXkgWmFjayA8eW9yYXl6
QG52aWRpYS5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IFNoYWkgTWFsaW4gPHNtYWxpbkBudmlkaWEu
Y29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBBdXJlbGllbiBBcHRlbCA8YWFwdGVsQG52aWRpYS5jb20+
DQo+IFJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0KPiAt
LS0NCg0KRm9yIE5WTWUgcmVsYXRlZCBjb2RlIDotDQoNCk9mZmxvYWQgZmVhdHVyZSBpcyBjb25m
aWd1cmFibGUgYW5kIG1heWJlIG5vdCBiZSB0dXJuZWQgb24gaW4gdGhlIGFic2VuY2UNCm9mIHRo
ZSBIL1cuIEluIG9yZGVyIHRvIGtlZXAgdGhlIG52bWUvaG9zdC90Y3AuYyBmaWxlIHNtYWxsIHRv
IG9ubHkgaGFuZGxlDQpjb3JlIHJlbGF0ZWQgZnVuY3Rpb25hbGl0eSwgSSB3b25kZXIgaWYgd2Ug
c2hvdWxkIHRvIG1vdmUgdGNwLW9mZmxvYWQgY29kZQ0KaW50byBpdCdzIG93biBmaWxlIHNheSBu
dm1lL2hvc3QvdGNwLW9mZmxvYWQuYyA/DQoNCi1jaw0KDQoNCg==

