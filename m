Return-Path: <netdev+bounces-31923-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79271791714
	for <lists+netdev@lfdr.de>; Mon,  4 Sep 2023 14:29:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25B5E280EF1
	for <lists+netdev@lfdr.de>; Mon,  4 Sep 2023 12:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E7568463;
	Mon,  4 Sep 2023 12:29:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C503D8B
	for <netdev@vger.kernel.org>; Mon,  4 Sep 2023 12:29:40 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2073.outbound.protection.outlook.com [40.107.8.73])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2EFD1A5
	for <netdev@vger.kernel.org>; Mon,  4 Sep 2023 05:29:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gp94TmM7kwwX2jiVnn1Inxhhc+KOGROx+KrLZGtk+GYwceXHtt9K8Xg0onS0EaOGjmFfQuepnOwjqp7lB/W03DX3JDA7X24oQZin2IBoFntSCJv8+0TEuoLF6BbVPnYl46u0ZuZRyNse6xjK9m78qw6n332IMxc7czpzKhuI7GsWZqOInYKApvQ1SYVctvej+Yi8VC4uvdXs4B6vx0fkNYUByugH/yVaPIdQ1J4mrN/bTKcT1IV49vqnE942Shxry+gnuH3/AMu6U9KdeHTbkECmo+0jM90lFZgvJWUP1A+qT97veelUKgWt51iLoB37EAzQmoVPHKGMUL9L9xg7MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DzDn+1oYejrWWmlRjb6s8yB2OLcbh4IjxIYuN07D3rQ=;
 b=M8fno6dmax4K7HAkREdEZ25tL+G1Rk+HxX4bXGSoZUvyKQZ+MpKr/Ddr7KeXO/0BielCeSUp5qyngBu/YSIqD8WyvZsclFDa51yMHOPdCOXKdwofJqQWlWzX1M5RmwVDOr186dimj5F/00IlhCY9ai0Py94UJMUkwE7okvzCHPWtaLIFRrqucXNfbW+lAMqbFjKtIJSRbPGPIebak0hdshs88W66h0X/eUQkdpDCxbGuUDpXLXTQzwD6TktG/Exvt7AEqTyj1lnFfUl/Xyrb56LDnluXZUQPLVR7CKuRvsrNBalwnCtVwsgjXFXf1OaIWnouQnjSoO3RMe+dlCFEGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ericsson.com; dmarc=pass action=none header.from=ericsson.com;
 dkim=pass header.d=ericsson.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DzDn+1oYejrWWmlRjb6s8yB2OLcbh4IjxIYuN07D3rQ=;
 b=TYeAMPCVWCXKk8O/Cgo0PNi6U6fu9WO2RfxtbukfkvFWQYTiMikq7Za/P3dsiwcSttayE5W9gwZiK+9MfmxXZbVFH9CDQIc+4fCRmQxN1BfHLyTA/bTDMCs/21KXby2+F5mMczcgC/GKkSj8aQQRW8BYETl8g7O+thOtvfpeTCM=
Received: from VI1PR07MB4080.eurprd07.prod.outlook.com (2603:10a6:803:29::11)
 by AM9PR07MB7155.eurprd07.prod.outlook.com (2603:10a6:20b:2d1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.32; Mon, 4 Sep
 2023 12:29:36 +0000
Received: from VI1PR07MB4080.eurprd07.prod.outlook.com
 ([fe80::60a1:ad65:dbb6:89d1]) by VI1PR07MB4080.eurprd07.prod.outlook.com
 ([fe80::60a1:ad65:dbb6:89d1%6]) with mapi id 15.20.6745.030; Mon, 4 Sep 2023
 12:29:36 +0000
From: Ferenc Fejes <ferenc.fejes@ericsson.com>
To: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"vinicius.gomes@intel.com" <vinicius.gomes@intel.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"jesse.brandeburg@intel.com" <jesse.brandeburg@intel.com>,
	"sasha.neftin@intel.com" <sasha.neftin@intel.com>,
	"anthony.l.nguyen@intel.com" <anthony.l.nguyen@intel.com>
CC: "hawk@kernel.org" <hawk@kernel.org>
Subject: Re: BUG(?): igc link up and XDP program init fails
Thread-Topic: BUG(?): igc link up and XDP program init fails
Thread-Index: AQHZ1pDnT3XCDiBRvUOy/mSJk2l2Pq/7oYGAgA8ISoA=
Date: Mon, 4 Sep 2023 12:29:35 +0000
Message-ID: <723778e997db9704b130bb7d85d517ced4f6332a.camel@ericsson.com>
References: <0caf33cf6adb3a5bf137eeaa20e89b167c9986d5.camel@ericsson.com>
	 <87ttsmohoe.fsf@intel.com>
In-Reply-To: <87ttsmohoe.fsf@intel.com>
Accept-Language: hu-HU, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ericsson.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI1PR07MB4080:EE_|AM9PR07MB7155:EE_
x-ms-office365-filtering-correlation-id: b1ad1284-f883-4ecc-e89f-08dbad42999a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 3ZAPoBtVp5bNbr4t4HmLRwJ850ZyHysHUE85Uy56orL40Y3ad1hiFL/qCKEllWn1gnIXPi5JX9wAugEg+QTE3Fqw9GzYYGCyexiahHfJW+g+tVkHv7Ox9RNaLIYuZuqxCk7DKphdzTb0t+2QrCl58fyTm8+VEWdz/a8knDm2CyAntrGzHaHLi+JYZwF4TpMT5VQZAOuIgqYKZPxmlZZyi2kkcW1YTFJDfyLHhLeGdqCNSzYMJyRw8paIr20ZRd1xfKiaqd8frEK4z6qD74fLgKS+D92YqRdxifglRfMvUnRaJYkqx2XmH27JNKqC6XT/DdWltiwIU32bxz7NWf+Luid98Lcv4J3fntelpC2Wni+OHQPy7o8yv+RGyOenVeeHlc2wJ+EtzRfRzN7Rzkjq7QRPlOtXxXW0BogatvdXeibkH09CwR0uJiyQTsWQA/gYryzYn7KifZZ39A2El7o9rSxP+0uuBEeaCkQtn/79Xv1FQhW8eA9zsqKcHedyLjZB0f4Ugp8YbqSCFLnNoZSOzMOp6Z22j8czgZRFEijknA2PA1SEvONi7PZE83dRMZZSa88LM5e9tAlSoHSkb38Fsrwf7CTQGBppJMcd+qvzOwZ7XHuNXNTA7aXKdfUtLBH6qUyenKtLx9otuNmv4Iu2nr6zlSaK1zhePQqBkp14c+I=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR07MB4080.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(39860400002)(366004)(376002)(136003)(186009)(1800799009)(451199024)(122000001)(478600001)(71200400001)(110136005)(91956017)(66476007)(66556008)(76116006)(66946007)(66446008)(26005)(2616005)(64756008)(6506007)(6486002)(6512007)(2906002)(8676002)(4326008)(8936002)(316002)(5660300002)(44832011)(86362001)(36756003)(82960400001)(38070700005)(38100700002)(41300700001)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Q0xWT2NZT1NxbWt3UURjdUtlN244dHpDSkcrVW51ZEhScTB2U0xib25RRVpR?=
 =?utf-8?B?WmFxUXo2OXVZYkFjMGtQU3NXMmE5T1FXSGtIcUE0anF6c3JXc1RoQVA3cUU5?=
 =?utf-8?B?SEVyVWJQMFZlWUc2Y25RZk8vQUE3NGFhdVIxZFZMYXpaS0VoU3lqSmUvQVBi?=
 =?utf-8?B?QWRNazVGZEQ5UjNnNGxTVE94L1VwUXpmaWtmM3BzM0RycU1uOEcwbGpOdXJv?=
 =?utf-8?B?eW94dFBhOFQyQ25YUmwrcEpTeVp4b1E0b255QXRFbFFxUUpkdGh1UGpFZWYv?=
 =?utf-8?B?dFNudDRpdzlLM0xJejJqNzUvbVVqZEVCditHUVBTcytjaE5vajRrMGQvYWtX?=
 =?utf-8?B?bGVvK3U1RE05M2dJNGUvdmpad3RIck0zQkFSZkQ3a2M1UEtjN2sweWF3ZFN3?=
 =?utf-8?B?NkJjdEZEc2lad3RVNm55eGhBTElOWnZCa0IzcFVQTm83VXBhbEk4Q01YcVgr?=
 =?utf-8?B?M2xLQ292T0J1YTkwMHJZa2x3QWRseldjOFQrRGtJZ2dldjZXYnl0RmNSeHZY?=
 =?utf-8?B?YjZpMm0wR0F6SWRBUDhESDY2L3djem8rUmwydmI0MHJJMmtoQmZJQUhQNFZk?=
 =?utf-8?B?R3U2K3BxZUFjNFVkZHBaSG1hZ0NzWFBtOVN0aitQR0JwalQ2S0gwQ3pXd3ZI?=
 =?utf-8?B?bkp2R0xXbkhCOFVUTUtobXcra2ZhRkgyQWxQUkxYcmlVa2VMZDhFcFlodnVs?=
 =?utf-8?B?ak9rUmhBeXpoVXA1SG9xWjdkZDhRUmliVVpjZ3dtMjN2V0RTNFlHd29SVVNH?=
 =?utf-8?B?UFNtQndCWi9EN2VTVS9SWjBvYXBJaWR2T0cvaGNnWnFERlhVM2pSUUlNbGZu?=
 =?utf-8?B?enlHY3hraGJZNEhSaXZJTGpHdHYzN2tDbSt0cTc5TEE2dHN6aVJtMVVDV2Rw?=
 =?utf-8?B?T2R1Zk1kVnlSTDlXYUMyNmx0Y1dLSjI0TnRpTzZGcXBGZ1puUzQxQ1N6ZnBO?=
 =?utf-8?B?NjQ2Ujl6SWExaGJsS0huUlpBTERNQlU2SmhIeGQ5T3RYRlFQOUV6dGl6SVcr?=
 =?utf-8?B?V3hzTzc2RW1DTkZoQ2taeTJsRGdLNE9RNkhZNGpjdG1NNzhQN2p3Q2Y4dktC?=
 =?utf-8?B?eGwxQ3ViM1JxNUh1TGZ2bFAyclBXZW9qWTNxbVVjNFFMbG9jUW1PTHRpTnhy?=
 =?utf-8?B?dStHN3d0amNvS3RNWS84ZGtPbVBxSzZWUXl2WmovNldxODQyeGp4amYrTmpv?=
 =?utf-8?B?c1lOTnNVSjVEckhRQzJkaUtQd0xic282azJSMWxmb2x0cmF1S1l3cmIxcTY5?=
 =?utf-8?B?VitFdWhoRWxaR2ZETjlMcWdFSnJLbElvZ0ZyQ2hEV3ZONVNsd0tuR0lnRS81?=
 =?utf-8?B?M1lSRVJzSDVUS2NLM0JiK05wKzNrOVMxdUoxL1dldnJhb1NUVTlPeVRhbHht?=
 =?utf-8?B?dmFiamJvaFhaOCtEU3F3dE5nSFlIbTh6QWttS3dOa2pzM0h4SnlJMkYrYjRj?=
 =?utf-8?B?RmFFL1h4VkYvV1UrVWFVOUVmbjExdnludlUzNmxxT2dqOEpmNGVQYmxWYktJ?=
 =?utf-8?B?aTlPN0NYOXFUMGF3TGRQWFY2M2ZSS1IvYmEwNGY1WlA5VzRqY01uNWI2VDJa?=
 =?utf-8?B?RGh6OHJSQ0FtalJMblVYUTF2a21YZFRUa1VxNVpKWVQ3b09ZZTJOaTJyamxP?=
 =?utf-8?B?YlJRQkJBSDM0eXlOQ1dlMHBRbTF5TEM5R2xpcHlPZWtWNTlTZ2tvemVJL0hP?=
 =?utf-8?B?eTZXb20wNkFVTGlGcFlWRjlWelYyQTVsSDB0SjdBMFlIQUpBZHJ4UCtxTGhr?=
 =?utf-8?B?QU1YdWNsN3l2K1l5SThZZkhMQ0JjZ2lCM2JmUkVwV2ZhOTFlWUxuZWo0VldB?=
 =?utf-8?B?RTJlbGFlOGpUU2MwWFU1YlUwM2tGdkgzWXR0VGNzMkJwa1lqS21VdzFZc1NF?=
 =?utf-8?B?OWNOTzJWRW1IU1pwZ2xkc3B3NGtIM1V2NEc5dkw4MUkrYWhkS215VG83M04v?=
 =?utf-8?B?RHVtQXJFanJhdTFRcWFkSnlsWjArR3V4QWZPL0JYUFpWZWxUaWdVQ3lHK2lB?=
 =?utf-8?B?L3h2WDhnblMzYkV4eHNVbFgxd0hUVUk1U3dndHlGajVjaDNCYVlTbmlKa3da?=
 =?utf-8?B?dUJYZlpCbnRwS0RSMktydlRBajVXTUd0WVhHWkZDUWJ3UnQ1WEZXYVc4R3d1?=
 =?utf-8?B?aDV0VzQ0SWZub01jSE9PTUY1bTY2dW9uNjdzbHNjY1B2dEc0Nnl0a3lNUnFO?=
 =?utf-8?B?aXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FD446B696BF37B459D108AE0138AEA20@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR07MB4080.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1ad1284-f883-4ecc-e89f-08dbad42999a
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2023 12:29:35.9130
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0OXMebRlaj+2BJLB8NWFuygZRxoE5Nj3BNKZaKu8xk5FJaJjCjZqZph7RkFMRPYTM4zwcMsFfakJcv53RyvY95tw0YY7K2HGa3pQukHN6oM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR07MB7155
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

SGkgVmluaWNpdXMhDQoNClNvcnJ5IGZvciB0aGUgZGVsYXkuDQoNCk9uIEZyaSwgMjAyMy0wOC0y
NSBhdCAxNTo1NiAtMDcwMCwgVmluaWNpdXMgQ29zdGEgR29tZXMgd3JvdGU6DQo+IEhpIEZlcmVu
YywNCj4gDQo+IEZlcmVuYyBGZWplcyA8ZmVyZW5jLmZlamVzQGVyaWNzc29uLmNvbT4gd3JpdGVz
Og0KPiANCj4gPiBEZWFyIGlnYyBNYWludGFpbmVycyENCj4gPiANCj4gPiBJIG5vdGljZWQgdGhh
dCBpcCBsaW5rIHNldCBkZXYgdXAgZmFpbHMgd2l0aCBpZ2MgKEludGVsIGkyMjUpDQo+ID4gZHJp
dmVyDQo+ID4gd2hlbiBYRFAgcHJvZ3JhbSBpcyBhdHRhY2hlZCB0byBpdC4gTW9yZSBwcmVjaXNl
bHksIG9ubHkgd2hlbiB3ZQ0KPiA+IGhhdmUNCj4gPiBpbmNvbWluZyB0cmFmZmljIGFuZCB0aGUg
aW5jb21pbmcgcGFja2V0IHJhdGUgaXMgdG9vIGZhc3QgKGxpa2UgMTAwDQo+ID4gcGFja2V0cyBw
ZXItc2VjKS4NCj4gPiANCj4gPiBJIGRvbid0IGhhdmUgYSB2ZXJ5IHNtYXJ0IHJlcHJvZHVjZXIs
IHNvIDQgaTIyNSBjYXJkcyBhcmUgbmVlZGVkIHRvDQo+ID4gdHJpZ2dlciBpdC4gTXkgc2V0dXAg
KGVucDNzMCBhbmQgZW5wNHMwIGRpcmVjdGx5IGNvbm5lY3RlZCB3aXRoIGENCj4gPiBjYWJsZSwg
c2ltaWxhcmx5IGVucDZzMCBhbmQgZW5wN3MwKS4NCj4gPiANCj4gPiB2ZXRoMCAtLS0tPiB2ZXRo
MSAtLXJlZGlyLS0tPiBlbnAzczAgfn5+fn5+fiBlbnA0czANCj4gPiAJCQnCoCB8DQo+ID4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKy0+IGVucDZz
MCB+fn5+fn5+IGVucDdzMA0KPiA+IA0KPiA+IGlwIGxpbmsgYWRkIGRldiB0eXBlIHZldGgNCj4g
PiBpcCBuZWkgY2hhbmdlIDEuMi4zLjQgbGxhZGRyIGFhOmFhOmFhOmFhOmFhOmFhIGRldiB2ZXRo
MA0KPiA+IHhkcC1iZW5jaCByZWRpcmVjdC1tdWx0aSB2ZXRoMSBlbnAzczAgZW5wNnMwCSNpbiB0
ZXJtaW5hbCAxDQo+ID4geGRwZHVtcCAtaSBlbnA0czAJCQkJI2luIHRlcm1pbmFsIDINCj4gPiBw
aW5nIC1JIHZldGgwIDEuMi4zLjQgLWkgMC41ICNzbG93IHBhY2tldCByYXRlwqAgI2luIHRlcm1p
bmFsIDMNCj4gPiANCj4gDQo+IEkgd2FzIGp1c3QgYWJsZSB0byByZXByb2R1Y2UgdGhpcyBpc3N1
ZSwgd2l0aCBhIGRpZmZlcmVudCBzZXR1cDogDQo+IA0KPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgU3lzdGVtIEHCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDCoCBTeXN0ZW0g
QsKgwqAgfCANCj4gdmV0aDAgLS0tLT4gdmV0aDEgLS1yZWRpci0tLT4gImVucDNzMCIgfn5+fn5+
fiAiZW5wNHMwIg0KPiANCj4gQW5kIHJ1bm5pbmcgeGRwLWJlbmNoIGxpa2UgdGhpczoNCj4gDQo+
ICQgeGRwLWJlbmNoIHJlZGlyZWN0LW11bHRpIHZldGgxIGVucDNzMA0KPiANCj4gQWxzbyBJIGFt
IHJ1bm5pbmcgYSBkaWZmZXJlbnQgdHJhZmZpYyBnZW5lcmF0b3IuDQoNClRoYW5rIHlvdSBmb3Ig
dGhlIHNpbXBsaXN0aWMgcmVwcm9kdWNlciBhbmQgdGhlIHBhdGNoIHdpdGggdGhlIGZpeCENCg0K
SSBjb25maXJtIHlvdXIgcGF0Y2ggcG9zdGVkIGluIHRoaXMgdGhyZWFkIHNvbHZlIHRoZSBpc3N1
ZS4NCg0KSSB0ZXN0ZWQgd2l0aCB5b3VyIHJlcHJvZHVjZXIsIG15IHJlcHJvZHVjZXIgYW5kIG15
IG9yaWdpbmFsIHByb3RvdHlwZQ0KY29kZSB3aGljaCB0cmlnZ2VyZWQgdGhlIGJ1ZyBmaXJzdCB0
aW1lIC0gYWxsIG9mIHRoZW0gd29ya3MuIEkgdGVzdGVkDQp3aXRoIDEwMGsgcHBzIGFuZCBzdGls
bCBPSy4NCg0KDQo+IA0KPiA+IE5vdyBpbiBhIHNlcGFyYXRlIHRlcm1pbmFsIGRvIGEgImlwIGxp
bmsgc2V0IGRldiBlbnA0czAgZG93biIgYW5kDQo+ID4gImlwDQo+ID4gbGluayBzZXQgZGV2IGVu
cDRzMCB1cCIuIEFmdGVyIGEgd2hpbGUsIHhkcGR1bXAgd2lsbCBzZWUgdGhlDQo+ID4gaW5jb21p
bmcNCj4gPiBwYWNrZXRzLg0KPiA+IA0KPiANCj4gSXQgc2VlbXMgdGhhdCBhbnl0aGluZyB0aGF0
IHRyaWdnZXJzIGEgcmVzZXQgb2YgdGhlIGFkYXB0ZXIgd291bGQNCj4gdHJpZ2dlciB0aGUgYnVn
OiBJIGFtIGFibGUgdG8gdHJpZ2dlciB0aGUgYnVnIHdoZW4gSSBydW4gJ3hkcC1iZW5jaCcNCj4g
bGFzdCAoYWZ0ZXIgInBpbmciL3RyYWZmaWMgZ2VuZXJhdG9yKSwgbm8gbmVlZCBmb3IgJ2xpbmsg
ZG93bi9saW5rDQo+IHVwJy4NCj4gDQo+ID4gTm93IGluIHRlcm1pbmFsIDMsIGNoYW5nZSB0aGUg
cGluZyB0byBhIGZhc3RlciByYXRlOg0KPiA+IHBpbmcgLUkgdmV0aDAgMS4yLjMuNCAtaSAwLjAx
DQo+ID4gDQo+ID4gQW5kIGRvIHRoZSBpcCBsaW5rIGRvd24vdXAgYWdhaW4uIEluIG15IHNldHVw
LCBJIG5vIGxvbmdlciBzZWUNCj4gPiBpbmNvbWluZw0KPiA+IHBhY2tldHMuIFdpdGggYnBmdHJh
Y2UgSSBzZWUgdGhlIGRyaXZlciBrZWVwIHRyeWluZyB0byBpbml0aWFsaXplDQo+ID4gaXRzZWxm
IGluIGFuIGVuZGxlc3MgbG9vcC4NCj4gPiANCj4gPiBOb3cgc3RvcCB0aGUgcGluZywgd2FpdCBh
Ym91dCA0LTUgc2Vjb25kcywgYW5kIHN0YXJ0IHRoZSBwaW5nDQo+ID4gYWdhaW4uDQo+ID4gVGhp
cyBpcyBlbm91Z2ggdGltZSBmb3IgdGhlIGRyaXZlciB0byBpbml0aWFsaXplIHByb3Blcmx5LCBh
bmQNCj4gPiBwYWNrZXRzDQo+ID4gYXJlIHZpc2libGUgaW4geGRwZHVtcCBhZ2Fpbi4NCj4gPiAN
Cj4gPiBJZiBhbnlvbmUgaGFzIGFuIGlkZWEgd2hhdCBpcyB3cm9uZyB3aXRoIG15IHNldHVwIEkg
d291bGQgYmUgaGFwcHkNCj4gPiB0bw0KPiA+IGhlYXIgaXQsIGFuZCBJIGNhbiBoZWxwIHdpdGgg
dGVzdGluZyBmaXhlcyBpZiB0aGlzIGlzIGluZGVlZCBhIGJ1Zy4NCj4gPiBJIGhhdmUgcmVwbGlj
YXRlZCB0aGUgc2V0dXAgd2l0aCB2ZXRocyBhbmQgaXQgbG9va3MgZmluZS4NCj4gPiANCj4gDQo+
IEkgZG9uJ3QgdGhpbmsgdGhlcmUncyBhbnl0aGluZyB3cm9uZyB3aXRoIHlvdXIgc2V0dXAuDQo+
IA0KPiBJIGFtIGNvbnNpZGVyaW5nIHRoaXMgYSBidWcsIEkgZG9uJ3QgaGF2ZSBhbnkgcGF0Y2hl
cyBmcm9tIHRoZSB0b3Agb2YNCj4gbXkNCj4gaGVhZCBmb3IgeW91IHRvIHRyeSwgYnV0IHRha2lu
ZyBhIGxvb2suDQo+IA0KPiBBbnl3YXksIHRoYW5rcyBmb3IgdGhlIHJlcG9ydC4NCg0KRmVlbCBm
cmVlIGFwcGx5IFRlc3RlZC1ieTogRmVyZW5jIEZlamVzIDxmZXJlbmMuZmVqZXNAZXJpY3Nzb24u
Y29tPg0KaW4gY2FzZSBvZiBzdWJtaXR0aW5nIGl0IHRvIG5ldC4NCg0KPiANCj4gDQo+IENoZWVy
cywNCg0KQmVzdCwNCkZlcmVuYw0KDQo=

