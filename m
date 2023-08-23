Return-Path: <netdev+bounces-30160-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EBA17863F1
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 01:31:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 867A91C20D3A
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 23:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB772200D0;
	Wed, 23 Aug 2023 23:31:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8D51F17F
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 23:31:31 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2105.outbound.protection.outlook.com [40.107.7.105])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4F90E6D
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 16:31:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ODw7zVQoIOBY4iYyFWM2RI7Gyf0osUSAmRsLWPnHfKPsi3DDO3i4vWZBXgAY8Wln2wHBw3K3hAYz9M0Q05qNaW9uEHtVR5yakiDtIDIzuKv66AxoZ8iruxSYaRbIelncasFYfI14hAeMVpfFiaR1pqvt9+XvSotDgEBQMwvg3TTuYjMyqt0fh2tngD+f/Y4rGWvFHyVjSWPa+TIeAcHwNf4zb+bzQFrqU34nQMx/2ZB4bkYTLdEt2tAXc8065RDg+ocddeIl6G8xNwkjrp6aRYeGed+5bfjVjpHHbN/fZlvxm5wmOsq5OMcgxJLbs24oyfQVGEnwPgzxbNKmMu9zCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OiMMTKOkpw2Fi/nfonG4E1IPQ9sTD/TUYr+a+KL2UDw=;
 b=dgjGV3RLkvz9ITMKxnBAXqTbsw7fUDJqX8o/O/iAQPmfKvsmG+LlRo34Pymo8Qzwh/yt8aMQ0VcZDvhQ9H1P/sAegcfG8NC5I+b+40pB/Ke8fYE/RQxE7ujyjR5OFWVUjqUiXTJWVKgUpM7huWPXXpx98t9p04RsJLVFqALaiV6b/MRHoXwaP6kD0/tx3k7DzKK9LcYTfhp6bOB1VWlfOJXnoFQfKl/VWeODl9Uj4BYlQ2Xs0vqjKQni3Yn6YSexFz4xOZGxeX3l/Rv44pfwDK1bOPcf1GyQhu+XD3ZGNqEMRwM13+4JF+iMzFV2PrXW41ibodHchgGgee85Kd1kmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bridgetech.tv; dmarc=pass action=none
 header.from=bridgetech.tv; dkim=pass header.d=bridgetech.tv; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bridgetech.tv;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OiMMTKOkpw2Fi/nfonG4E1IPQ9sTD/TUYr+a+KL2UDw=;
 b=PydPKl9KwJHE6LjoW4plyGvEemDVq5UOxmqOLiCD//9xJTXicaFBri8ntjnrtPtuojFLY4dCypyUwlePC0HhUBb17VleWuqpYkQ/xl/mlfgH6WLm0OdDhkm6I/8P6XpesrA/HJJPCRKp/adnE1oamHfyYsIO5jdf4SIunjAQFEXgX0HOMELTmKg/i/rI9bt85V0krjAD07bQA9ffZJpuIw/o8T+p9i8U6JTBSG6gdpBh/YcRAqQoE8091ZZwswnNPA5nIzl5oWimACJ91XlKE51LouC9+M2oVVTZobeFQffZT0ydUzlYHMGUWZX8JVC2NB5Gg9rFWtlkiixdBFLhmg==
Received: from AS8PR08MB6808.eurprd08.prod.outlook.com (2603:10a6:20b:39c::6)
 by PAXPR08MB6605.eurprd08.prod.outlook.com (2603:10a6:102:153::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.25; Wed, 23 Aug
 2023 23:31:26 +0000
Received: from AS8PR08MB6808.eurprd08.prod.outlook.com
 ([fe80::326b:bfd0:6c48:c696]) by AS8PR08MB6808.eurprd08.prod.outlook.com
 ([fe80::326b:bfd0:6c48:c696%4]) with mapi id 15.20.6699.026; Wed, 23 Aug 2023
 23:31:26 +0000
From: Kenneth Klette Jonassen <kenneth.jonassen@bridgetech.tv>
To: Rahul Rameshbabu <rrameshbabu@nvidia.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Saeed Mahameed
	<saeed@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Richard Cochran
	<richardcochran@gmail.com>, David Miller <davem@davemloft.net>, Paolo Abeni
	<pabeni@redhat.com>, Vadim Fedorenko <vadfed@meta.com>
Subject: Re: [PATCH net] net/mlx5: Dynamic cyclecounter shift calculation for
 PTP free running clock
Thread-Topic: [PATCH net] net/mlx5: Dynamic cyclecounter shift calculation for
 PTP free running clock
Thread-Index: AQHZ1IQwAfG33icsL02KynIR6o/x1K/4isiA
Date: Wed, 23 Aug 2023 23:31:26 +0000
Message-ID: <B74120A4-4468-4106-AD73-D9936B06BA6E@bridgetech.tv>
References: <20230821230554.236210-1-rrameshbabu@nvidia.com>
In-Reply-To: <20230821230554.236210-1-rrameshbabu@nvidia.com>
Accept-Language: en-GB, nb-NO, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3731.600.7)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bridgetech.tv;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR08MB6808:EE_|PAXPR08MB6605:EE_
x-ms-office365-filtering-correlation-id: 8b73aedd-a3e6-4f86-e6e6-08dba43111e8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 vHAK/t8iuHsEFZkc6QrSP1OLGELTuShDud0IG9G4vkIIS+AVU1wh0NAc1/Wede8Y/EM3g09JYo/WPq7HCZjgxaQFQM+K++e28agGnTrUoqYpv9706a1dlndR4rAKxuUzmqgGhp9Z8Nk6rwVWpWVx3Zz8YULkOSXF4qqUo3xt478hVShzpKDHZZK34fZvsFCG49HIfCKhNtIeFJ3ufOn+Dmqamdv0bgb3ZjBU6SscmmQjX3xuz5UujLPlaQ3VAtA9eobHB5U4axkyYvdORckM9ObRFR5EmwP/aYbvSzjN+qmkYb1Ug9EnddHm7v4/2YJr4kGHOfbaXrKAc//FuBFZl3ZLN5WnrxAEB8tJ3zL4CtpWgGweZsXQNC05ZxtsIZDXdlvNnEtBEJtw8lt2er7EFzj5On9WDU//BvGjcPPahmQHaPVXSWtLbQvuCQ6UBKhdEEXnV2yIcWJDRxljhUErDdnp8vwDRpYzAe0JJ01kK+GQkCMIYvm7ht4ht+ba6a8VnfT/2vUzImz7NXL795FxjQwJ9CUqPF0x1k8v72NYP4AP9ZlTcCa1fN3uUDMnQAbylojnQatVKwDRNurUHjXf6SMND1exg4KPx5//CMjf7DmJE6dmhoCBN44SytIJ6G8zkQe9aH6yNPIjEH6opL8QYQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR08MB6808.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(39840400004)(136003)(346002)(396003)(1800799009)(186009)(451199024)(478600001)(6486002)(71200400001)(91956017)(6506007)(6512007)(76116006)(2616005)(2906002)(41300700001)(8936002)(4326008)(86362001)(64756008)(66446008)(54906003)(316002)(6916009)(5660300002)(53546011)(8676002)(66946007)(36756003)(33656002)(66476007)(66556008)(38100700002)(83380400001)(38070700005)(122000001)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VDZaZkpIdFpTbk0zSmI2eHRmN2ZaYTQrSklsMHVXaW5yVFBrMVJTYmhlTVBy?=
 =?utf-8?B?ZkxId2NYZE12TzVzVzZhaGFxMCtHTzFpMTdWbEQxRWRpb0llcmJIYXNYdUkz?=
 =?utf-8?B?N1gzdTRUY0grZWVHM0FRdTYxQ1d3TTZjTHQyT2w0M2lvNk9tVmFSZU44YjVx?=
 =?utf-8?B?L05oSk15Q2VPcHNVQWRYTWVnSUJFRzAxVEF6NnRtWjNtU3hxRjNDQmhlajZM?=
 =?utf-8?B?UGZ0cXprS1J0MXNoV2lqTFhKUFl2SHVMQ1Vxamh3SjhiWG8vaXVWSXgxUlc2?=
 =?utf-8?B?YVVjczMxRjhXRGlPWGpmMmxvZUFRSjFGSldlQ1NtYlgxcWdoaTZSK056b1Av?=
 =?utf-8?B?T2lLbHQ2eDYxZnROK3dPYklPd2h1cDAyckROSFlJYzJ3QWYvZEhTUVdNVE9O?=
 =?utf-8?B?NGc5ZUl4a2RRb2pUS1pPa1ljYnBwQ1lXWHczYTVRTEdkWlkwQUFLNnMzSEVQ?=
 =?utf-8?B?dUw4RnpWL1U1UmpWb0hqa3RiSHpJYnJWdGhEL3lzOFJUMVBLTHNIeWdLWmRZ?=
 =?utf-8?B?by9tbFZLM3dZd1ZTZm5kY0UvOEgvWWtzak9sM0huU0RLWUhDZk5LU2dsZTVN?=
 =?utf-8?B?UE5kYUtONUJieFc3ZmdaRTNVanJnMkYxMzNPRks4ckYxR1lRRm9WamN1MlR4?=
 =?utf-8?B?M3JXRm9VZWxVWHF2VE4vaFVmZ0lYTTVUODRnS21FV3lFcklGVmUwZTFXV0JY?=
 =?utf-8?B?RnpXV1JhN3Z4ZHhrcXpmZEtJSWJaUEhaZGQ0clJPS3RUTWdTQ1ZuR2Nhdldr?=
 =?utf-8?B?d0dZK2c1bG5FWkJndEd3Wjl5YUFqS3I1NnMxbVp4TjhUZzAxdkRvMFV1VmVD?=
 =?utf-8?B?TmxNMWg0RWFQSDVKK21yWmZPS1JYanFWYjUwR3BVa0dCb2trYmZhNE9OQXNo?=
 =?utf-8?B?bXN4SWg4NTdoVnFJdVozVWNkRUZxUE5xUGsyRE9zM2ZPSEtZZkswci9RS0tW?=
 =?utf-8?B?Z0ErRVVnS2J2M1ZnY01XaEFzcVdZMGl0RmVoOGlYMGZucDk4RFdCeVVqK1lx?=
 =?utf-8?B?Q0hUWW1UVzNIcVBTNlBSaVM0NU93Q3RKemE4YWtDK3pPT3MxNjlHMmFxOEd2?=
 =?utf-8?B?OUIxeHVIZ3V3eDZ4KytGK2x4K0hTMWtoZGI3U0NaeHZ2UnZCeHA3Q2dXMWlH?=
 =?utf-8?B?TGU2ZmVRN2V1aW4rbDE0dnRXSnpVMXU1UmxSakpxZElkOExsaHJIQmk0QmJz?=
 =?utf-8?B?WEtFUDZUUWsxVjFvZzFMcmVsdTNKNWYrMFNiSlMzU3hkRlRZckZLWDJ4NzMr?=
 =?utf-8?B?Nk95U0d5ZE9yYnBzVmRocjRPMlFHd3daaHlkSzhaV0Jad290VTRWS3U1eSt6?=
 =?utf-8?B?NDlEVWNVeW5XRW5SOWFJL0Ftc1hrVmZ6MjN5b2hab2FkQ2JmZXlwczFOcUg2?=
 =?utf-8?B?Vjc3UEhIVHZjRXVXS25rWnp5UmJBRkN3NkhHNjFQTXlEUzExVXRDT1QyeXFF?=
 =?utf-8?B?aUpEdHR3aDdqVmZNTXdDZmJmQ0Vqdlp0Nm1nVUtMMGJxUThLL3gyRjFQbW5V?=
 =?utf-8?B?OHVsMG12OGVXVkVlWkgxNjZFaFBqcXI4UTNiQ1dvUE80ZXVwUGdqQWJGbk5P?=
 =?utf-8?B?Um8yZlpxTGVwbFVBRmUxbGhib3BqQ3JrNjVkdFZadnpYeDFqZTZXMkRocC8v?=
 =?utf-8?B?SHVOaXVRTmQ5b3RTWmpKNm1LbEkza1p1TUNISXBmczdyWG1hZnFMQlhBR3Bx?=
 =?utf-8?B?K3N5eXdYOWZZTkw3b2xHU3A5V0o1ZHFxRVdzSWVXQTFpS1VqTzRyaFh6ek92?=
 =?utf-8?B?ekZYVUhTTDBHOUhmZHc2bS9zLzg1c0xubjR5ejRZNTZMOU42aTJLS1FMdjkx?=
 =?utf-8?B?Mk53VGpWNm1OSFArUkp5YXFjZUNnQlN4c0hSa3ZnSUxMNTlyTTJUclF6Rmd5?=
 =?utf-8?B?N3M0T2k0U0lXcFFCSWpWc1FnRWxoRkxPa1c4UHQ2bTNuQ3BmcWxpZEYrK2ZK?=
 =?utf-8?B?bjNlUDFWNEU5TnNFMzRNYUE5eVBGTG43eW83a3Y4OTlvb24vVWlieG16U3Vo?=
 =?utf-8?B?bW85S29vTkc5TER1QWh0SkFEUmQ2SmFqa2VmRVJ4bEJYZXo1eC9VNERidndj?=
 =?utf-8?B?ZWhlTVpYNG1XOWgxZlUxL0orNjd3RkFXQjY5c2pZM2U4S0RBZkxtdEFDcXlO?=
 =?utf-8?B?VHRybWl3WkJ3VHQwY0NHSzJHY0QxOUswNlhXNjBMcmZRVzhCWnN1cjFqRGl4?=
 =?utf-8?B?VlZKRFRtODhsOU1sOW5WWlF6YVdaMmRZRTNRZmxsK3Q5K1ZxOFR4eWQzWUZi?=
 =?utf-8?B?TVVHRm1UdVRMRjVGSFpwdUpvcTRRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7812998BB2F4124F9430B307E2B9B95C@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bridgetech.tv
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR08MB6808.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b73aedd-a3e6-4f86-e6e6-08dba43111e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2023 23:31:26.3722
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511b9776-65d2-4726-b5bc-af4fc772381e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QSPk72HusENe1HtrZICfGrByZ/RSDPJJ0MrUJ5XRQ3hK4XjUPlyuw5JXSW2F/oE/6X70ZZY9XrmGT2eSlB9na+ulXC0QKeQYD2EWoXIp214=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB6605
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

DQo+IE9uIDIyIEF1ZyAyMDIzLCBhdCAwMTowNSwgUmFodWwgUmFtZXNoYmFidSA8cnJhbWVzaGJh
YnVAbnZpZGlhLmNvbT4gd3JvdGU6DQoNCi4uLg0KDQo+ICtzdGF0aWMgdTMyIG1seDVfcHRwX3No
aWZ0X2NvbnN0YW50KHUzMiBkZXZfZnJlcV9raHopDQo+ICt7DQo+ICsgLyogT3B0aW1hbCBzaGlm
dCBjb25zdGFudCBsZWFkcyB0byBjb3JyZWN0aW9ucyBhYm92ZSBqdXN0IDEgc2NhbGVkIHBwbS4N
Cj4gKyAqDQo+ICsgKiBUd28gc2V0cyBvZiBlcXVhdGlvbnMgYXJlIG5lZWRlZCB0byBkZXJpdmUg
dGhlIG9wdGltYWwgc2hpZnQNCj4gKyAqIGNvbnN0YW50IGZvciB0aGUgY3ljbGVjb3VudGVyLg0K
DQpUaGlzIGlzIGVhc3kgdG8gZm9sbG93LCBzbyBJ4oCZbSBub3Qgc3VnZ2VzdGluZyB5b3UgY2hh
bmdlIGl0LiBCdXQgb3V0IG9mDQpjdXJpb3NpdHksIGhhdmUgeW91IGNvbnNpZGVyZWQgdXNpbmcg
dGhlIG1vcmUgZ2VuZXJpYw0KY2xvY2tzX2NhbGNfbXVsdF9zaGlmdCgpIHRvIGZpbmQgYSBzdWl0
YWJsZSBzaGlmdCB2YWx1ZT8NCg0KPiBAQCAtOTA5LDcgKzkzMSw3IEBAIHN0YXRpYyB2b2lkIG1s
eDVfdGltZWNvdW50ZXJfaW5pdChzdHJ1Y3QgbWx4NV9jb3JlX2RldiAqbWRldikNCj4gDQo+IGRl
dl9mcmVxID0gTUxYNV9DQVBfR0VOKG1kZXYsIGRldmljZV9mcmVxdWVuY3lfa2h6KTsNCj4gdGlt
ZXItPmN5Y2xlcy5yZWFkID0gcmVhZF9pbnRlcm5hbF90aW1lcjsNCj4gLSB0aW1lci0+Y3ljbGVz
LnNoaWZ0ID0gTUxYNV9DWUNMRVNfU0hJRlQ7DQo+ICsgdGltZXItPmN5Y2xlcy5zaGlmdCA9IG1s
eDVfcHRwX3NoaWZ0X2NvbnN0YW50KGRldl9mcmVxKTsNCj4gdGltZXItPmN5Y2xlcy5tdWx0ID0g
Y2xvY2tzb3VyY2Vfa2h6Mm11bHQoZGV2X2ZyZXEsDQo+ICB0aW1lci0+Y3ljbGVzLnNoaWZ0KTsN
Cj4gdGltZXItPm5vbWluYWxfY19tdWx0ID0gdGltZXItPmN5Y2xlcy5tdWx0Ow0KDQpUaGUgbWFz
ayBhc3NpZ25tZW50IG9uZSBsaW5lIGJlbG93IG5vbWluYWxfY19tdWx0IGNvdWxkIG5lZWQgdXBk
YXRpbmcNCnRvIG1hdGNoIHRoZSBuZXcgc2hpZnQsIGUuZy4sDQoNCiAgICAgICAgdGltZXItPmN5
Y2xlcy5tYXNrID0gQ0xPQ0tTT1VSQ0VfTUFTSyg2NCAtIHRpbWVyLT5jeWNsZXMuc2hpZnQpOw0K
DQo/DQoNCkl04oCZcyBjdXJyZW50bHkgZml4ZWQgdG8gNDEsIHdoaWNoICh2aWEgNjQtMjMgPSA0
MSkgbWF0Y2hlcyB0aGUNCmN5Y2xlY291bnRlciBiaXRzIHNoaWZ0ZWQgb3V0IGNvbnN0YW50IG9m
IDIzIGluIGtlcm5lbHMgdjYuMyBhbmQgYmVmb3JlLg0KDQoNCg==

