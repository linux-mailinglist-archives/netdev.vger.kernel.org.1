Return-Path: <netdev+bounces-38334-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ABA847BA735
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 19:00:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 87FC8281A80
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 17:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5337A374E9;
	Thu,  5 Oct 2023 17:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B1634198
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 17:00:15 +0000 (UTC)
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01on2138.outbound.protection.outlook.com [40.107.222.138])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED1C6D44
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 10:00:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SMgZ9ICEjqSOnaBIWts5hMTJIOLsc2VbM3jLodgP+mhooAGw+DyVwHtQ/MJ0fptgLeTUFBxlRm+X9H9rVvEqMnSsfHU4aMIoIEQEqMld9LvRSwipfaSQhh4U4g3yH4EBMMVUxUXQTSUkKmFlWoZq275H6RdP959LiIKJOKyU3rYZwbEXS3x61BncWXydWXHJFc46g/Vw1GWhV0/TaPI6qLuYzYUW4nW1hBAvTVE091szanAofZ48+JCXv+htvPFFsAAFhBY2/Vr008N3x8L9s1lqQpfubqTiIwCin3xKRzsJqGsF0HOWl7kBdpYnai3TM+t723a9de2GpAOJlZO3rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3rz0rl/9LeKhuBUHmyY9MM1X8rW1tCsPIg48+Gy15H4=;
 b=A7yuOFLb6XqIoJJ2efGvMDi93LzS7ULA9ADa//2lp5TCPbRPnQSfN0XDma4LTuFwlkLXCKmR9SrknJlaCvasNBpqnKpFL6dYv8EjjSRaP25y9vWnvdR0h+rtP28ZjQFMvSfY2B9+/PVtlGah/O5E/HLDK06+rtWt8gwV4PPesekjx4Nd+83BCQR9PqCRI9y7G8cJ9AR1m0JTf36ZjRusJU0yJwuJLNgfcBP5sL1Tg45nmSKdfooUwSpBsshl8gQ+dj6xR9WKbRJbo4HJNd2vxiOGCSTDiMHsU/WLUqOXGohJzBrZBHOWuCiVFM17oG6QBTH5h7iDbzazZo10AeFLpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=globalprospectinfo.onmicrosoft.com; dmarc=pass action=none
 header.from=globalprospectinfo.onmicrosoft.com; dkim=pass
 header.d=globalprospectinfo.onmicrosoft.com; arc=none
Received: from PN2P287MB0398.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:f2::11)
 by PN3P287MB1256.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:195::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.35; Thu, 5 Oct
 2023 17:00:08 +0000
Received: from PN2P287MB0398.INDP287.PROD.OUTLOOK.COM
 ([fe80::543e:619e:90c9:a8c]) by PN2P287MB0398.INDP287.PROD.OUTLOOK.COM
 ([fe80::543e:619e:90c9:a8c%4]) with mapi id 15.20.6838.033; Thu, 5 Oct 2023
 17:00:08 +0000
From: Ellie Madison <EllieMadison@globalprospectinfo.onmicrosoft.com>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: vger Construction Purchasing and Procurement List
Thread-Topic: vger Construction Purchasing and Procurement List
Thread-Index: AQHZ961lV3FLwM0YqE+QMjpqM9sQVA==
Date: Thu, 5 Oct 2023 17:00:08 +0000
Message-ID:
 <8256b5f5-999f-7005-da4a-56b12a45f7d7@globalprospectinfo.onmicrosoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none
 header.from=globalprospectinfo.onmicrosoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN2P287MB0398:EE_|PN3P287MB1256:EE_
x-ms-office365-filtering-correlation-id: 679ce0db-9b54-4d8d-0733-08dbc5c487f0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 SecihqfeJ4R66PL7+8QaMw+Z3InJTNs/A8zel4gPPMfyw2d1q8wNmHgDigKy1ntSZ6O8ERX0UJAQr1/HpEtSgU2UCwXYoa94QRiejae3VrJq7AqrPNVEc+gSyUdX0j5wstyrB5A+xxMq4TwR7ftaObvwBbPEegF4i+2PA4yNMVT/GUqGWrC2Q18oktf8RvkSYbSxXsVRVdVkLFDgBe84SSA5bUPknfnoRjQnkjXijf9KLxAV2giwmz5r2+Sp3xA98dWcrpYOXflUI9zVb3WtgD7OX4HeMNhhYSSNOKENffIXCDO4bzS8XA/c81qUCHsFX1/CmodbM42h9zTGf5XT/L9Yi/0UCq1mHY1IqtVrfcFRUkCU8En0qpSWcW7sQlhPTKVEMn86DFaRZ2/c+lZDH+j0RRjt3Dr8TWYkZ+ltaDMu0b7RghjG4CpgHz5zalYawvJL/mCSHZ9/vHu4zxIycikA/jn1tuHdJCF2ZD73RwIpcwrwODtWJT+SS1uZM562qwd9iM93VVNs6O28g8BCfi8YbKvzBiBX3AztdTaKy6kImghZNTX+tNGmR0Kl8+QQOD3EJ/JRfVjkBf/3qMFq8Po0x432UXPVJa9v1PatLOAyUIcNMaPZXmV5CFREFQVYkxI6+pdfOpATua2yr1Zkp6FnQuFPiVFngiR62AqbepOMx1wksJLP1+gArGR1k4bKAbu98sL1bDvOlvpdG4NdFSEeonkg1dizRArRWNrbJjpknzk5O2kJEksw2B/jjKZa
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN2P287MB0398.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(366004)(376002)(136003)(346002)(396003)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(66446008)(2616005)(6506007)(53546011)(71200400001)(478600001)(6486002)(83380400001)(6512007)(91956017)(41300700001)(2906002)(8676002)(76116006)(316002)(66946007)(6916009)(66556008)(64756008)(66476007)(5660300002)(8936002)(26005)(86362001)(38070700005)(38100700002)(122000001)(31696002)(66899024)(31686004)(13220200019)(437434003)(581174003)(45980500001)(6396002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MnVqYzhINFhMZTB3NkRzNFBtelVRajFjdHF0Zy9VNzBPUEpmWFdFVFdTbE1R?=
 =?utf-8?B?VnNVeDVLMjVHWWtyUW9VMnBiMzRTUGgyZ0pCRXprRVVOOUF4c0IrQ2xBZ0Ro?=
 =?utf-8?B?NVNTZktMbnk0N2Flbmd4NDJCd3h4VnR4SWVSeklaUjdXakNTZjN0OUREMzFZ?=
 =?utf-8?B?OWVOYnkrMWxxdUZPdlZPdkw2NVVDbzRPTnZPQzZLeDl3QVVGZXRXa0wydDBJ?=
 =?utf-8?B?WnMraVVGYTB5WmVNL0tsczVKNFE3NjU4b3VWWjhLNnFRRlJtWHlrelZoM0Zj?=
 =?utf-8?B?Wk90dWtkVkpWL1hPYUFoZ3pzaXJLUFN2b29HdDVLTHJjZ2tQakRFeG4ydDdP?=
 =?utf-8?B?MFNpV3dReXBaMktJaXowRFZ4c1kvMWNTRXNVNE9xMDVFSUN4N2VUV1MwNXpR?=
 =?utf-8?B?SnpJN0dYeE43WDlubTJtSGxzM1BHNkF3c1ZQVmU5STlJUWFYTEgweVNjbVJp?=
 =?utf-8?B?T3NDZ21GLzN5Vnc0dklwdGttaTFvM1BvWTRvaDlrVlBJSFV6OTdpMnppRVNS?=
 =?utf-8?B?N1hFLy9sc0pFOGNUa3ZLYko1ZjUxZVZPYkRVdGVqTUdkSmQ1QTltQTVVRW1a?=
 =?utf-8?B?SnV1WVBEN2ZZeVpPV2NPRjNTS21Db1d0bHNLbnJtZXhoekpGL3kwY0Y3MDc5?=
 =?utf-8?B?RjZCdGhtTnlCREpIdm1hbVh4eEpNWnJ1N0RXOEVwV2VsWnpRUmgzUEkvZTVl?=
 =?utf-8?B?eFd5MkQ2UEpOKzNYMWNwTUtJQ3FnbUxQYTA0c081S2JaeGM3NTA1TTVzSFpH?=
 =?utf-8?B?Ym1KZ2RMN255blNPYnoxN1o5c2xEVWJzTXRQbWVMNDEvN0lieWZpV2VncWZw?=
 =?utf-8?B?MC85V0ZIQjB6VWtSMlU4eU1iOGdJQVNRSUZDV1UwUWRBNHhaT2lvWTkwRFhx?=
 =?utf-8?B?V3YwQjFmU3N2d0tuL203QTFacnZvOUE3M3ZuWGM1OUJVeTE3UmNUOENRN1M3?=
 =?utf-8?B?NXNyakVrdEw2Qiszc21WLzlaa3RwL3JvTG5lTUQxQkFyMVFaMERzd3NxT3M0?=
 =?utf-8?B?ay9JUTQ1dUVCdCtoYzBUV2IwQWN6Q0EwWHpkVkJBdk1CQ2VLN0FIeTd6Tjh3?=
 =?utf-8?B?RHA3bXF1Yng1eW4xV1IvWFNIZHZCUmszaHExRzJ3UEdZdXdoV1dKamVHVVlm?=
 =?utf-8?B?UWo2MHRxenAzYVhPNmV3bXg1aXV2Y0JOdytDc0FneEZEMisvVTFDMkhiZ1FP?=
 =?utf-8?B?TlhvK2pla3haNFljMlhlRmVvMEZqbnYvNHVQcTNDNmhWS1B5Y01BQmcrRm1v?=
 =?utf-8?B?S3dyYWxTUFlrR3paTzdrZVEzMlBlb3BlWklKanVaV2lvL3Z0Z0pzMHFQdXF6?=
 =?utf-8?B?S0lOS2dmYWk1dGtiODdKbGdBZkpOOXRvSDhjdTVyQ1Bha3dZNEI1UUhPUFV4?=
 =?utf-8?B?T1RDMGFaT0tzK0RJVFU2dFM1Y3hPa0RNdVVYMThKWTFBYnVFNUhrTUszM3Jj?=
 =?utf-8?B?enRNYUlqSkZkcVlWQndvbkJwNU5uc2FKTnUraE9yZnpzUWd4SElxOS9aWXlY?=
 =?utf-8?B?bTRpTUhpYkNsb0dCSG5GWWVPd0Q0ajdWeHFrYktsaUdHQm1kTVgzcW5xVjcw?=
 =?utf-8?B?MmlHbktNenUzKzdyNzZYOHg2WG5KSmU2YWNRUHpGUlIzS1dHelJlUGFxTlZH?=
 =?utf-8?B?SGFvc3Z0UGRmVHdPWEhGQU5yeTIyT1ZYaUNCcC9aeGhVYnlJYlQxM2FjQkg4?=
 =?utf-8?B?clF0eFp6cTZUbFl3N2V6WDV3Zzc1MXlLR0c0UUNaaDJpUndzUTJEZWUyVk10?=
 =?utf-8?B?L3craVhjd2s4SXhrZ2tTQkFRSURqaDg0VzNVSmwwUmVZNnlqcmVORlB4ckxn?=
 =?utf-8?B?N0E0czVsRGNvUllMY2o4eWE1ME51UUlpejdHZmtXcW0xQ3Vxelk3Zlk2aWZr?=
 =?utf-8?B?RjEvdE03NHR0YThKdXB1MEd6VU9VMUJ5SFBLQUdKanEzNzJnVHlrMkdIUUFP?=
 =?utf-8?B?TE1nYTB3L0ZvN2prdmpkSE9DRmszekVHZm5pYzZ4U3VpMFh1RU0vdkRVb29o?=
 =?utf-8?B?ZTMvZ2w0RTk5cWVqMFozdzJqMC82Q1BLL3RjejFjMHphVDYveWUvTmh1NE00?=
 =?utf-8?B?UHBUUlAxamh5akpCRmZrLzFQdCs3VVlZa2JYYVpXQ0RFVU04K1NsRnZoMzRF?=
 =?utf-8?B?UzNhU1VQWTVIV3ZmeVVadkhoY0owRVEwbm9lS0JtUFF3NlRmV0hXc1hGOGlz?=
 =?utf-8?Q?+G5wGmEfmzF4yPyOwcAXz5U5BezYrZzPNPT9DYzrd7SQ?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <207A458AE77C964F958CF2CEBBF3444B@INDP287.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: globalprospectinfo.onmicrosoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN2P287MB0398.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 679ce0db-9b54-4d8d-0733-08dbc5c487f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2023 17:00:08.7548
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: db40464e-9457-4711-afa4-9dcb114e15d9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n1IwN2GQ3XOUyznNzrxynur6ayEyyZRfjn7Zk+h/AgXU+N0QQU6AbaPpEEEbpDZp5tVHu0mcemX/IXWxDECEOK3MwKJcf8NP3AaJ44dY4HBdgQvdOfoCUFvvTOQ6VytN6p9cHSAjB2EICq3PWERB/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3P287MB1256
X-Spam-Status: No, score=0.3 required=5.0 tests=BAYES_50,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

SGksDQoNCkp1c3Qgd2FudGVkIHRvIG1ha2Ugc3VyZSB5b3UgcmVjZWl2ZWQgbXkgbGFzdCBlbWFp
bCByZWdhcmRpbmcgYSANCmN1c3RvbWl6ZWQgbGlzdCBvZiBDb25zdHJ1Y3Rpb24gbWFuYWdlcnMs
IFB1cmNoYXNpbmcgYW5kIFByb2N1cmVtZW50IA0KbWFuYWdlcnMsIE1haW50ZW5hbmNlIE1hbmFn
ZXJzLCBIVkFDIGNvbnRyYWN0b3JzLCBBcmNoaXRlY3RzIGV0Yy4gSeKAmW0gDQpsb29raW5nIHRv
IGZpbmQgdGhlIHJpZ2h0IHBlcnNvbiB3aG8gbG9va3MgYWZ0ZXIgeW91ciBtYXJrZXRpbmcgYW5k
IGxlYWQgDQpnZW5lcmF0aW9uLg0KDQpXZSBoZWxwIGNvbXBhbmllcyBncm93IHNhbGVzIHJldmVu
dWUgd2l0aCBvdXIgaGlnaGx5IHRhcmdldGVkIGVtYWlsIA0KbGlzdHMgZGlyZWN0bHkgc291cmNl
ZC4NCg0KUGxlYXNlIGxldCB1cyBrbm93IHlvdXIgdGFyZ2V0IGluZHVzdHJpZXMgYW5kIGpvYiB0
aXRsZXMgc28gd2UgY2FuIHNlbmQgDQp5b3UgdGhlIG51bWJlcnMgb2YgY29udGFjdHMuDQoNClJl
Z2FyZHMsDQpFbGxpZQ0KDQpFbGxpZSBNYWRpc29ufCBNYXJrZXRpbmcgQ29uc3VsdGFudA0KDQoN
Ck9uIDI3LTAyLTIwMjMgMTE6NDMsIEVsbGllIE1hZGlzb24gd3JvdGU6DQoNCkhpLA0KDQpXb3Vs
ZCB5b3UgYmUgaW50ZXJlc3RlZCBpbiBhY3F1aXJpbmcgYW4gdXBkYXRlZCBlbWFpbC9jb250YWN0
IGRhdGFiYXNlIA0KZm9yIHlvdXIgbWFya2V0aW5nIGFuZCBzYWxlcyBjYW1wYWlnbnM/DQoNCiDC
oMKgwqDCoMKgwqDCoCBDb25zdHJ1Y3Rpb24gbWFuYWdlcnMNCiDCoMKgwqDCoMKgwqDCoCBQdXJj
aGFzaW5nIGFuZCBQcm9jdXJlbWVudCBtYW5hZ2Vycw0KIMKgwqDCoMKgwqDCoMKgIE1haW50ZW5h
bmNlIE1hbmFnZXJzDQogwqDCoMKgwqDCoMKgwqAgRmFjaWxpdGllcywgSFZBQyBjb250cmFjdG9y
cw0KIMKgwqDCoMKgwqDCoMKgIEJ1aWxkaW5nIE1hbmFnZXJzDQogwqDCoMKgwqDCoMKgwqAgQ29u
c3RydWN0aW9uIG1hbmFnZXJzDQogwqDCoMKgwqDCoMKgwqAgQXJjaGl0ZWN0cw0KIMKgwqDCoMKg
wqDCoMKgIENvbnN0cnVjdGlvbiBTdXBlcmludGVuZGVudA0KIMKgwqDCoMKgwqDCoMKgIFByb2pl
Y3QvY29uc3RydWN0aW9uIG9wZXJhdGlvbnMNCg0KV2UgY2FuIHN1cHBseSBjb250YWN0cyBvZiB2
YXJpb3VzIGpvYiByb2xlcyBmcm9tIHNldmVyYWwgaGllcmFyY2hpZXMgLSANCmZvciBleDogQyBT
dWl0LCBWUHMsIERpcmVjdG9ycywgTWFuYWdlcnMsIGFuZCBzdGFmZuKApg0KDQpJbmR1c3RyaWVz
Og0KSW5mb3JtYXRpb24gVGVjaG5vbG9neSB8RmluYW5jZSB8QWR2ZXJ0aXNpbmcgJiBNYXJrZXRp
bmcgfENvbnN0cnVjdGlvbiANCmFuZCBSZWFsIGVzdGF0ZSB8Q2hhcml0eSBhbmQgTkdP4oCZcyB8
RWR1Y2F0aW9uIHxQdWJsaXNoaW5nIHxSZXRhaWwgfCANCkNvbnN1bWVyIHwgTWFudWZhY3R1cmlu
ZyB8R292ZXJubWVudCAmIHB1YmxpYyBhZ2VuY2llcyB8RWxlY3Ryb25pY3MgYW5kIA0KVGVsZWNv
bW11bmljYXRpb25zIHxJbmR1c3RyeSBhc3NvY2lhdGlvbnMgfEhlYWx0aGNhcmUgfCBIb3NwaXRh
bGl0eSANCnxMZWdhbCBTZXJ2aWNlcyB8Rm9vZCAmIEJldmVyYWdlcyB8TWVkaWEgJiBFbnRlcnRh
aW5tZW50IHxFbmVyZ3kgYW5kIA0KY2hlbWljYWxzIHxBZXJvc3BhY2UgYW5kIERlZmVuc2UgfFRy
YW5zcG9ydGF0aW9uIGFuZCBMb2dpc3RpY3MgRVRDLg0KDQpXZSB3b3VsZCBiZSBoYXBweSB0byBj
dXN0b21pemUgeW91ciBsaXN0IGFjY29yZGluZ2x5IGZvciBhbnkgb3RoZXIgDQpyZXF1aXJlbWVu
dHMgdGhhdCB5b3UgaGF2ZS4NCg0KQXBwcmVjaWF0ZSB5b3VyIHJlc3BvbnNlLg0KDQoNClJlZ2Fy
ZHMsDQpFbGxpZQ0KDQpFbGxpZSBNYWRpc29ufCBNYXJrZXRpbmcgQ29uc3VsdGFudA0KDQpSZXBs
eSBvbmx5IG9wdC1vdXQgaW4gdGhlIHN1YmplY3QgbGluZSB0byByZW1vdmUgZnJvbSB0aGUgbWFp
bGluZyBsaXN0Lg0KDQo=

