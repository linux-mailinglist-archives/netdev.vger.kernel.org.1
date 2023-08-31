Return-Path: <netdev+bounces-31604-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 812A978F01A
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 17:19:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56C291C20B00
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 15:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE5A2125D4;
	Thu, 31 Aug 2023 15:19:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6B911CA4
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 15:19:13 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 639EFE7C
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 08:19:09 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37VBiIMr028631
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 08:19:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=YJEytgfU9ep63gFPBWd2YCeMTxieRkKbSopyBqZroVs=;
 b=dRhLH7ebEr5RJXPwi1Qhe57ysXBP14uKpx31Io7w7JzOHelMBMaCtBurvFcECddcGKNg
 cm+gEVlwk6AdreVfyoZJvl8KGI1ncRHDN1guMcg/pn1CfYmF2HNcmM2tXh4W+YdGeqzd
 HE6+ATTfOAlw4R4tEoPS7PN6exnkx6j2oCD100qyRJa15e5Odev9L0NDQuClaOw+eSoe
 j/gg+v/5aKBBaJlto3iknAjI0+OdKW+b5KA3udwA5Qqcuq61FCmWmNhoDQQD4cmgar2Y
 UZ+5rXtdHFQiLCrWmnRHqTibw90ATFB0uoSFLMzkpoly0SfXC6rLZRHZYl+0BxKNEkTg xg== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3st6y939t0-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 08:19:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dkao1JLt9oh0qSutdwBMS1cuaLQrrxNgPwqWrbRvoRb4mi0sLXJbaeahHFkm6PMb2rvbAppREMS8oOk2SUeRBgBQ8eC/I0eMaU/W5kV16DF84du1N1FbhwzK0MdPWmrHWbRoxLEkMuRMshBvgBza0YF2anzqkJMTEWU+UNpTysUd1YqDoAIcyiPLiJ4j5gBIbOf3p2y88+nRLJAbHfHoLDd3MdtUXnPmsqMxTfdYzY6LwS8sj1IxJsxUyAlw7Ax3Wqx4DjO5ej6od7KVZ2D4nyuBCcJk+5jD7uGPrDrbAjnMsQoyXTBkQxY3ZhbZvcDUgq8yd/w6QgVwOQOB0L2K7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YJEytgfU9ep63gFPBWd2YCeMTxieRkKbSopyBqZroVs=;
 b=aEi1ouhM/cco35sVDf60akqD8rujrOIZI8Wdy354zPBXeFMDr5P/JWTz0Bcp//ybxE3MMxim49GZoGtxTPQ7ci5eBs506bf/DcaqJw4tpqVHjD6KEuRoyo0rNLhPeoPx6TyWdML2HwSOoV2EmC3mTJ2Fd9nfbSpbFvsiwS4iOkgmFsQR1xSK0Yd/AJB3vkFjVtNTAJK1sq4Qx5kit88QV49Ud471Io9ICN7xeVd1UgnIOqqt1kMDdzYPLJap+Od97msZineCb9Dpf7t9Uf7/ozZvFmZqhx3zyYaBu99GryY2S0HHo0FJfImGfsOXD66Hddz5knXO/DXRFnjp1hWymg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from MW5PR15MB5121.namprd15.prod.outlook.com (2603:10b6:303:196::10)
 by SJ0PR15MB4648.namprd15.prod.outlook.com (2603:10b6:a03:37d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.21; Thu, 31 Aug
 2023 15:19:05 +0000
Received: from MW5PR15MB5121.namprd15.prod.outlook.com
 ([fe80::2470:7406:4045:c4fd]) by MW5PR15MB5121.namprd15.prod.outlook.com
 ([fe80::2470:7406:4045:c4fd%3]) with mapi id 15.20.6699.035; Thu, 31 Aug 2023
 15:19:05 +0000
From: Alexander Duyck <alexanderduyck@meta.com>
To: Yinjun Zhang <yinjun.zhang@corigine.com>,
        "mkubecek@suse.cz"
	<mkubecek@suse.cz>
CC: "oss-drivers@corigine.com" <oss-drivers@corigine.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        =?utf-8?B?TmlrbGFzIFPDtmRlcmx1bmQ=?= <niklas.soderlund@corigine.com>
Subject: RE: [PATCH ethtool] rxclass: fix a bug in rmgr when searching for
 empty slot
Thread-Topic: [PATCH ethtool] rxclass: fix a bug in rmgr when searching for
 empty slot
Thread-Index: AQHZ27LcynsscRIQl0iqmjxzA5tZk7AEfN5A
Date: Thu, 31 Aug 2023 15:19:05 +0000
Message-ID: 
 <MW5PR15MB5121C4AE6FF6E7EDB2F5D1DDA4E5A@MW5PR15MB5121.namprd15.prod.outlook.com>
References: <20230831022806.740733-1-yinjun.zhang@corigine.com>
In-Reply-To: <20230831022806.740733-1-yinjun.zhang@corigine.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR15MB5121:EE_|SJ0PR15MB4648:EE_
x-ms-office365-filtering-correlation-id: 9479895e-5a50-41e6-b06b-08dbaa359d63
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 Gi2cAEOCFxbTg/2dOQI3KanoX5k47X7v/sxSDQTv344OFC/eX7ko17mBaPliE2M8vv2baAVhmdqbYx6Bzv0adKVZzP+GD9l7gF5qxH8GV0tIy7ooOgp40853Sm2Lt6WvG7TrmTADKLkYQ65aO4ckbd4J0aiaht7gYmd5bi7/KFUV2MyegI+6N+P79keFv1SFxnUBnHBX+JEg1hOSRE7KHa0iKZIXHu97H5yO4b9JOOsBt5bT8awOeAggx80I+DvMjvZ+ISPncwCd/Lj1+dp8lOcL7f04PR9N4vritwcDQnSnAyJiH4fK6vd3ob2fbvA1iOqYxz/6u+yhc+bRgMJ2iX6fSZ8U4bxuOZPuZPGjJZcHA2yZACz26Cfsqm7JO4SSeBPQ9vmzulNh4lNPS4JWUAIC5yG+0QE3anWci0RBr3Ulg0eb6yR0ktkl0X8N5V/M7j0MH3Qv+mHNCPmHAVS3eTVCRZq442saebMIP8+j/3FFB3W5/NAnGO3EhRTyuiPqBMjRBNBbyx6MT6DVLrWEyZB9hurIhRfdpAn0NhPToiNgh/enK4Lc4wo8+lGDYuoVdMVDKxwQL9LLpX1XqMUKczldqohPs9N1ZZ1SCBHCuCtPJUKcJVlp4KfmsMehU2aIjEN4tSHzMBeMgf7EsdCxNw==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR15MB5121.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(366004)(136003)(396003)(39860400002)(1800799009)(186009)(451199024)(7696005)(6506007)(71200400001)(9686003)(53546011)(478600001)(83380400001)(66574015)(26005)(2906002)(64756008)(66476007)(41300700001)(54906003)(316002)(66556008)(76116006)(5660300002)(52536014)(110136005)(66446008)(66946007)(8676002)(4326008)(8936002)(55016003)(33656002)(86362001)(38100700002)(38070700005)(122000001)(51383001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?bng0ZG45WDZ5V3lNbVJONVBVOCtxOWY2d0U0ekY1MlBpeHhLd0xCeEl5cVJh?=
 =?utf-8?B?NmtlK3A2MHgwTWY5eEh5WEpyVmV2anJWd3dDRmNnNVNFcHZoL2x3cjJoV1Vu?=
 =?utf-8?B?YXZtK3dBWENoV1RJOTVDaHI0VkVpeGJMMm52OEVrU013dzE4TDJhK3lORFJM?=
 =?utf-8?B?WjVLV3F6S1JWSG1WUmxCd1piRzVuUGNNUjdkZWkwNk56T1dsZS9JMzhMMEVw?=
 =?utf-8?B?OTBmZ0NSUWxpanpGeEJqb2N3bklqNlhYbkp1aDFXSDhRWS9BRkZEekplakJR?=
 =?utf-8?B?MGU2WWw5NWRLZHN4UFI5RXAxNGVEemZyVEFqSzIyVFl0MGlzdEtLRHQvS2ZG?=
 =?utf-8?B?MTd3QVVrWk9yUGF1UVdvYjQ3ZXl0RjI0UTJCUjd1NFY2bmNQTUM4a3kvd3Ez?=
 =?utf-8?B?RDBZSjFadEZ5Z0RVSVRlaGFFRmdFSVJXYkxDd2hTWFdPZmt0TTFYRDJjRHYz?=
 =?utf-8?B?OXVyZXpoMkFpMVU1eDN0VzFLUHMzeWhCSTFhMmZrcTFGd0RHSkVqREo2QjJH?=
 =?utf-8?B?RHlyWWJLRS9BT0hwd08vWGlqdXdvVm93LzRUSXZoeUxhQUdnMmJ6OXF6dFQ0?=
 =?utf-8?B?YjJaM0ZnaWQzUEN0akFjNTMxL2FwOTRLL3lFUFU5ekgzOGxJMXFuNkVTcGJ4?=
 =?utf-8?B?aEpiNExxdkQ1cUpZL0Fycjd0bGdDeHZmYy9HT0tSUnozaHpSZ1gwNWRXK3Js?=
 =?utf-8?B?d0hlSWtWUWp0bUtMdStWZ1dmWk1HeWxGNDdkK2NQWm9zZkRsSUpDZkdDV3J3?=
 =?utf-8?B?NmNuUG1hNlNBN3NPODhsQlRxQW1VVHJLaS93bjNyTDc2dU5NTEhHUlZJV0sw?=
 =?utf-8?B?TGMyVDI1YkI2dkNMbjRFeVNKb3BwUXNGc1VXcTZDek05d3paZzZaamoycUdN?=
 =?utf-8?B?VU5yMUo2TGxxUVUyQ0pCaTQ0S1ZiZlkvMWM3aTQyZ08za3h4cTMvZVN4UlZN?=
 =?utf-8?B?cEZBOUFzRGd2ZkV0UUNDTEN3RlgwaDY1bnFIOUpXZU1XbUxwaTZsRDM1MVRL?=
 =?utf-8?B?aExzc0JTUCtTcnFsWkJrY2V2eGYyNCt4dWZvbXdKTCtESTdzVUcxdG9qNkZP?=
 =?utf-8?B?TFE5aVBKS0ZoOVQxUUorcXJQaTNGV3RmMURCWU5tWU1PclUrY2pFS0kveThY?=
 =?utf-8?B?UCtkZVV1VkVOMlI5Nk1RYVFhY1ZaQkVJYW9kWmN5SDVSUmQ2K2R1NlFBcExR?=
 =?utf-8?B?bEtlUDRCNDA5T2dwR2dEaTJDVkpSS2pMZ3JQSG5HNnkyM1ArdmM4K1ZvcmI1?=
 =?utf-8?B?bysvZEsrQ0FCWk8wK2ZURUlydXJZTTFvdzJ0aGN5eGVEQ2kyVDBMekprdDk2?=
 =?utf-8?B?NmZoSURWR2RWVjcxUDdmcHBtaWVvNkg0ZG52YWRnMEZuTFBaVFprMGE0WDQz?=
 =?utf-8?B?Y0VxU0UzNWthdXU4UGVWeWV0ckxMajdCNFdocGVFWVRGMW01ZUtHYXpOVHhC?=
 =?utf-8?B?NGdRZW1ndk5iNGZZTjgwdHBQUFkxZ0pEK1FiaEl4ME55M3NJUDl3MURzZXIr?=
 =?utf-8?B?OFY3ZGhaNEVvcDJPOCtjNHlheWV5aDg4Ykg1cldxQXNRMkQrQ0V5VGZWN2w3?=
 =?utf-8?B?Zjhrc29UVHVhU0ZCSDcxUXlBL2tuL3J3VlRtYVR0UlZLbk0vK0hGYW5JRlVi?=
 =?utf-8?B?YWdqcTRWY2JIN3p1eVROalpCQmtZc0oybEcrSHowOUR3V1c2cWI4SXlLT1Bw?=
 =?utf-8?B?aWhWWUtGMkhMcWVoYXNTMTdwYTVyMVk0MjQ4QUUvSWtabGhSMFJMdDBGdElD?=
 =?utf-8?B?UTZLbnlBaXN4WnR3cXh5VFVwUGtRVHpQdjlubUJDZk5lZjI0VllWTXFpUWZX?=
 =?utf-8?B?VzNVVTlHR3dPZWt2ZThhUVJqNXR4clFVUy9tRi9NRzBlK2pXRGM2elFiV2hx?=
 =?utf-8?B?MlhpNnIzV2pKUEVXU0R6Y1VWUmFOM1RGK0Vqbk5QWWh1QWdRWTUzSDM5TVNm?=
 =?utf-8?B?ajZmWU1kTDR2YlFKcnhiLzM4YVFJOGlEWkIycE1FZXRTMWtQQm9pWWFDNzNs?=
 =?utf-8?B?MmFXOU5yUnBlQnJSdGV6dWlFWVAzdWV0QTlQN20wUlNBMzdLQTExenp4WklF?=
 =?utf-8?B?MDRLMVdXUWRLTTZYVXQzTXA4aXlmeXllMEwrWXdFZHVVTGZ2WTJRTXJWeHhw?=
 =?utf-8?Q?TVlDJ6SB1R91Qmwtlc8m/uOn5?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR15MB5121.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9479895e-5a50-41e6-b06b-08dbaa359d63
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2023 15:19:05.3248
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OCWcov/gVQNSMkarGUAyzhSdow/ISWfNsspkHN96VU/weLB82NG1MnNuzcP5s7l4RM+73DlIAU3hUdT9XbAoyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4648
X-Proofpoint-GUID: Yaul4BH9VKkSiZhAifl94iE2MOMysdn0
X-Proofpoint-ORIG-GUID: Yaul4BH9VKkSiZhAifl94iE2MOMysdn0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-31_14,2023-08-31_01,2023-05-22_02
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBZaW5qdW4gWmhhbmcgPHlpbmp1
bi56aGFuZ0Bjb3JpZ2luZS5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgQXVndXN0IDMwLCAyMDIz
IDc6MjggUE0NCj4gVG86IG1rdWJlY2VrQHN1c2UuY3oNCj4gQ2M6IG9zcy1kcml2ZXJzQGNvcmln
aW5lLmNvbTsgbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsgWWluanVuIFpoYW5nDQo+IDx5aW5qdW4u
emhhbmdAY29yaWdpbmUuY29tPjsgQWxleGFuZGVyIER1eWNrDQo+IDxhbGV4YW5kZXJkdXlja0Bt
ZXRhLmNvbT47IE5pa2xhcyBTw7ZkZXJsdW5kDQo+IDxuaWtsYXMuc29kZXJsdW5kQGNvcmlnaW5l
LmNvbT4NCj4gU3ViamVjdDogW1BBVENIIGV0aHRvb2xdIHJ4Y2xhc3M6IGZpeCBhIGJ1ZyBpbiBy
bWdyIHdoZW4gc2VhcmNoaW5nIGZvciBlbXB0eQ0KPiBzbG90DQo+IA0KPiBXaGVuIHJldmVyc2Ug
c2VhcmNoaW5nIHRoZSBsaXN0IGluIHJtZ3IgZm9yIGEgZnJlZSBsb2NhdGlvbiB0aGUgbGFzdCBz
bG90IChmaXJzdA0KPiBzbG90IHNlYXJjaGVkKSBpbiB0aGUgbGlzdCBuZWVkcyBzcGVjaWFsIGNh
cmUgYXMgaXQgbWlnaHQgbm90IHNwYW4gdGhlIGZ1bGwgd29yZA0KPiBsZW5ndGguIFRoaXMgaXMg
ZG9uZSBieSBidWlsZGluZyBhIGJpdC1tYXNrIGNvdmVyaW5nIHRoZSBub3QtYWN0aXZlIHBhcnRz
IG9mIHRoZQ0KPiBsYXN0IHdvcmQgYW5kIHVzaW5nIHRoYXQgdG8ganVkZ2UgaWYgdGhlcmUgaXMg
YSBmcmVlIGxvY2F0aW9uIGluIHRoZSBsYXN0IHdvcmQgb3INCj4gbm90LiBPbmNlIHRoYXQgaXMg
a25vd24gc2VhcmNoaW5nIGluIHRoZSBsYXN0IHNsb3QsIG9yIHRvIHNraXAgaXQsIGNhbiBiZSBk
b25lIGJ5DQo+IHRoZSBzYW1lIGFsZ29yaXRobSBhcyBmb3IgdGhlIG90aGVyIHNsb3RzIGluIHRo
ZSBsaXN0Lg0KPiANCj4gVGhlcmUgaXMgYSBidWcgaW4gY3JlYXRpbmcgdGhlIGJpdC1tYXNrIGZv
ciB0aGUgbm9uLWFjdGl2ZSBwYXJ0cyBvZiB0aGUgbGFzdCBzbG90DQo+IHdoZXJlIHRoZSAwLWlu
ZGV4ZWQgbmF0dXJlIG9mIGJpdCBhZGRyZXNzaW5nIGlzIG5vdCB0YWtlbiBpbnRvIGFjY291bnQg
d2hlbg0KPiBzaGlmdGluZy4gVGhpcyBsZWFkcyB0byBhIG9uZS1vZmYgYnVnLCBmaXggaXQuDQo+
IA0KPiBGaXhlczogOGQ2M2Y3MmNjZGNiICgiQWRkIFJYIHBhY2tldCBjbGFzc2lmaWNhdGlvbiBp
bnRlcmZhY2UiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBZaW5qdW4gWmhhbmcgPHlpbmp1bi56aGFuZ0Bj
b3JpZ2luZS5jb20+DQo+IENjOiBBbGV4YW5kZXIgRHV5Y2sgPGFsZXhhbmRlcmR1eWNrQGZiLmNv
bT4NCj4gUmV2aWV3ZWQtYnk6IE5pa2xhcyBTw7ZkZXJsdW5kIDxuaWtsYXMuc29kZXJsdW5kQGNv
cmlnaW5lLmNvbT4NCj4gLS0tDQo+ICByeGNsYXNzLmMgfCAyICstDQo+ICAxIGZpbGUgY2hhbmdl
ZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9yeGNs
YXNzLmMgYi9yeGNsYXNzLmMNCj4gaW5kZXggNjZjZjAwYmE3NzI4Li5iMjQ3MWY4MDdkNWQgMTAw
NjQ0DQo+IC0tLSBhL3J4Y2xhc3MuYw0KPiArKysgYi9yeGNsYXNzLmMNCj4gQEAgLTQ0Niw3ICs0
NDYsNyBAQCBzdGF0aWMgaW50IHJtZ3JfZmluZF9lbXB0eV9zbG90KHN0cnVjdCBybWdyX2N0cmwN
Cj4gKnJtZ3IsDQo+ICAJICogSWYgbG9jIHJvbGxzIG92ZXIgaXQgc2hvdWxkIGJlIGdyZWF0ZXIg
dGhhbiBvciBlcXVhbCB0byBybWdyLT5zaXplDQo+ICAJICogYW5kIGFzIHN1Y2ggd2Uga25vdyB3
ZSBoYXZlIHJlYWNoZWQgdGhlIGVuZCBvZiB0aGUgbGlzdC4NCj4gIAkgKi8NCj4gLQlpZiAoIX4o
cm1nci0+c2xvdFtzbG90X251bV0gfCAofjFVTCA8PCBybWdyLT5zaXplICUNCj4gQklUU19QRVJf
TE9ORykpKSB7DQo+ICsJaWYgKCF+KHJtZ3ItPnNsb3Rbc2xvdF9udW1dIHwgKH4xVUwgPDwgKHJt
Z3ItPnNpemUgLSAxKSAlDQo+ICtCSVRTX1BFUl9MT05HKSkpIHsNCj4gIAkJbG9jIC09IDEgKyAo
bG9jICUgQklUU19QRVJfTE9ORyk7DQo+ICAJCXNsb3RfbnVtLS07DQo+ICAJfQ0KDQpSYXRoZXIg
dGhhbiB1c2UgInJtZ3ItPnNpemUgLSAxIiB5b3UgbWlnaHQganVzdCB1c2UgImxvYyIgdGhlcmUg
c2luY2UgaXQgaXMgdGhlIHNhbWUgdmFsdWUuIEl0IHdvdWxkIGFsc28gaGVscCB0byBtYWtlIGl0
IGEgYml0IG1vcmUgb2J2aW91cyB0aGF0ICJsb2MiIGhlcmUgcmVwcmVzZW50cyBudW1iZXIgb2Yg
Yml0cyBmcm9tIDAgaW4gdGhpcyBzbG90IGFuZCB0aGF0IHdlIGFyZSBhc3N1bWluZyAxIGJpdCB3
aWxsIGFsd2F5cyBiZSBpbiBwbGF5IHNpbmNlIHRoZSBtYXNrIGlzIH4xVUwgYW5kIG5vdCB+MFVM
Lg0K

