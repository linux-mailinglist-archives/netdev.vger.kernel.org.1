Return-Path: <netdev+bounces-14809-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 741F4743F28
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 17:48:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2851E2810AB
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 15:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5260916437;
	Fri, 30 Jun 2023 15:48:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405CB16400
	for <netdev@vger.kernel.org>; Fri, 30 Jun 2023 15:48:21 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2073.outbound.protection.outlook.com [40.107.243.73])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D958B35B6
	for <netdev@vger.kernel.org>; Fri, 30 Jun 2023 08:48:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ky+I+deFw0M7Tt7C9AU96ToEe25yVTgX8ehYNWbgVjuyFE+qczJMfXSziNgZm6fyzbW4XoMk2n0O7FleggPQ1uGW0tUSfwOfnQjPUSaLYolUYpFbuedhwqZOPhISBeAJnPcotZwYCO2TOfmXEenqQXWaz3lu6PH6rrQRdv9QDGh/aGf46SoMdd/OOYko3Gw1evHreqnl22RlfjnkFSzF84nBefTqZ9iORUyQMqMG+JJ3ONLK9lxvmYMVOrLuYCiFDGn/yki312Fm+68TzxBLG+OwTPchI80lRiB88P+pSdtJOr+jANBg18ERzOOjAjTIXJu2FV0mVsDypNUwjFw44g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/lhXKgtGB6eai4+dVsUeSoB2VYu+fVWQRvQgp/vTLYo=;
 b=Yya8EfV/muv6C7NYXszHVdJoOTwtmrEg8bGGjsKL+59wR1fYvG3INqf8xJylU+1Dlz++QefdwZV69unyw7BSYHGJtRAIELgf9yLXkhdtLSv7QxflQikeebP7WJOzzvlDfgbkX6hZ66GYhm/uw7zObi2OpkX8XbiFzjsycQ24VL4Q7RvpDoP6tDz8SBWM1l1pMmyhAksrLW/eMxeZq+jFtVVuFB89arPbV+Xzjin+UNYd4ltB3eZeTDR0wD0V2iuJUaul0X4YLqHKxANZ9fbOK/YKIxP5MvHGDpFfOq1dNYHsrVEUnB0PxfVVkXvTo5yGUpHx5Jji3mr+kNu6A+vfNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=infinera.com; dmarc=pass action=none header.from=infinera.com;
 dkim=pass header.d=infinera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infinera.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/lhXKgtGB6eai4+dVsUeSoB2VYu+fVWQRvQgp/vTLYo=;
 b=Vg5w2Vj0geRbQionkckIdJcIvEvWjE24tllXg8lBNHxOoJBy7dBvnwVR1/NRurCpPmnMySUHm4gsWNCuv9fu+GXBRz1n5E4Ok+mf6fLKPDphZ3pUfVrmtnRe57sQFt5OOesf414ou2Gm8L8HpdoCapMpergDXnfiWVMuzslmeCFa3cOIi7zh43dNV/DR34Ju5O+1ljwoi8fAMyMp6Dv1xivFsVV/+C4FW139yjtWwKVFuIhUBTexxZG8tfRDZ5M3GmK6VF0/CaLlpyOiW5Ah9C6QmXkWzSYCcMTJoz1xMcOkkYPO8ogyanyPZAHdTcq8qxF+pnntt456ONGaOySE6g==
Received: from CO1PR10MB4612.namprd10.prod.outlook.com (2603:10b6:303:9b::22)
 by PH7PR10MB7087.namprd10.prod.outlook.com (2603:10b6:510:27f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.19; Fri, 30 Jun
 2023 15:48:15 +0000
Received: from CO1PR10MB4612.namprd10.prod.outlook.com
 ([fe80::d9e:97af:8334:3a9d]) by CO1PR10MB4612.namprd10.prod.outlook.com
 ([fe80::d9e:97af:8334:3a9d%6]) with mapi id 15.20.6544.012; Fri, 30 Jun 2023
 15:48:15 +0000
From: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Disable TX path on eth I/F from driver?
Thread-Topic: Disable TX path on eth I/F from driver?
Thread-Index: AQHZq2pIQeoSRMiWDkmOhwIk0qU4jg==
Date: Fri, 30 Jun 2023 15:48:15 +0000
Message-ID: <e267c94aad6f2a7f0427832d13afc60e6bcd5c6e.camel@infinera.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.48.3 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=infinera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR10MB4612:EE_|PH7PR10MB7087:EE_
x-ms-office365-filtering-correlation-id: 2ffa2cac-5c6e-4378-ec2d-08db79816aec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 7j1XoQZFK7ws2tuIU67I1FyNzwvd0ms+dOzr+oKKSqrMzeMGjovnlvSEAQj/5tPw2PW1p6EzkWCJzb3Wy3quEzdjniS1/t1L5vwVzymHcMfEZeyKjYeJ76JsgZ2BFeXHabGZWdOgpghL18P3ERq+VcMhwOxLppg1pQNQGkHt2u8eeblgT4mSXeqSuljrKg4VAyI+F6mYY50loetN6eftJckFHyC356mj7OnOwi+y/BTC1rfHfJegttH8KF0RpaNFAlsMfPK4XHXqjlmMepT3sZXpXPmynWBPqfCcVUBm3mETlFhMQp0H1xjp2lYuM1luazN6CGzlDCcBSVcINI3cY5iNn+x4wJm3HGWgaxhzY5pLI9bRQTX4qfAF0ns1aAmdrIlvqPn96IrdeQxzyfy6sDSWwYZh1Ksaibxw+s62PvIRJXJsR/+hePhI2FzMcBEFj0Ia90fZQYohKfY9s0MzS0PJBaSMtqBoQuapuTEt7ZA0XPEBKBxlF1cY5TQdtuYOygYn3Ng+x4gDOcCdJWL4/hu+0MS2gIS5YmmwVEbDc076snMmia0WxdNiO0I6DoRiBNvzO7ikDLXCzSfTlBbhhaxhUFR/rMrish8ivjygXmytN/KvauDKrX5vcGun7OjD
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4612.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(376002)(39860400002)(396003)(366004)(451199021)(71200400001)(8676002)(8936002)(5660300002)(36756003)(478600001)(6916009)(91956017)(6486002)(64756008)(66556008)(66446008)(66476007)(76116006)(66946007)(316002)(41300700001)(6512007)(38100700002)(122000001)(186003)(2616005)(4744005)(6506007)(83380400001)(38070700005)(86362001)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WVlCZWRFSk5pWVErQzR4Z1pDanRjTzJ3QXZlcElXU1g2c3dibUxGbWtPRGg5?=
 =?utf-8?B?QTZRSTlOVUJ3WWtwYU1kN1p2aGJSd2pRUGFwczVOOVFGbDZGV0RJbnpLNkd5?=
 =?utf-8?B?MXZ2bFZvUzJGNVF6K3pLYkoxUW01ZXN0UzBDY1F6SFBzbUN4Zzl3cE05Yk00?=
 =?utf-8?B?NStMakNhdHpuMDdYcHFLajVWNzExbC9wYnBwQ21zblF5amNVTWpxS2xyOGUy?=
 =?utf-8?B?TFpJc0NaL3FnaGovOVJOZTU3QlllUUxtTVhZVVBGTFplTU1ucXcyckwrZXli?=
 =?utf-8?B?TkFScHl2YUtyZ1doVzZ2Z2ZaSjNyc3ltSnNBcmFNRzZzK1MvakovZGl2VlM5?=
 =?utf-8?B?YW5zWFpNVEVnblVGbkVIVjhkSFBvZEgrUG5KcWozU0UxTU5DOGhhdUZvcllo?=
 =?utf-8?B?WUpFWDROcU9NZmk0V1FROUFNd2VpOUMwa0R5NnFOSUtucW1LVDkydU1LbDNG?=
 =?utf-8?B?ekxRS1kxdlZSQ01PTnhwNnVkWWZ4Tzl1SzdIMjI0bXRCYUcySDRGc1lzVlZ5?=
 =?utf-8?B?R00zOE93eTk5MzVMQWR6a2Z2VHowcnpVd2ExellTMHB3bm1TeHJYa1FVeXZB?=
 =?utf-8?B?RXZpUXc4OXdLTFZLUmY2VVgvaTNqQXZjK1haejVnMWp4ck5KejNMSkx1dzkv?=
 =?utf-8?B?TjBiSm02NVdnQXpMemFrZzQyWFhuWGh3UGk4ajhlUitUMjVETHJBNnRaUXpR?=
 =?utf-8?B?eGVQSWtpNGxJRmpFclcvU2EzTGlkU2lqZUlzaC93Z0FScXJZSUZ5SnZRQzda?=
 =?utf-8?B?ZGZZUHl1U2lCK0hDNVlzSDJQMkxlazNPMm1jS2NPOWx2ODFnOVo4SktNaGMw?=
 =?utf-8?B?Qi8xbmFPcndDM0lpbmpOOG1qRXFBcEhhWEFPUEt6ZFp0NFV6a3dkV1FtbHhH?=
 =?utf-8?B?MkdVdWZCei9pUHltUDhvVjBjWEtQQktyOGpjeU1jTlBWc1N4K3FYQ3BFZ3Ew?=
 =?utf-8?B?cG1IU3RoZjVCemVkZForK3o3ZGVQYW5CVnBjcEdtUXFjQzkvOS9nWnNLZEsw?=
 =?utf-8?B?TU03bTQ2c1pYaVNWd1FkVTV3OVU4Y2FjdStSUkVRT1NqMHBxZjlqenVsRWN1?=
 =?utf-8?B?TUF5VmphTXY0cFFPWEVScDYyQUpsMlMwcTRpeXJsVTQvWnFwN0h3MTBpWFNM?=
 =?utf-8?B?U29uSUxMNXoweUErQXM0WGtFQ3FHdk95SFBEU3VUdktPMmRWRTEvVnlRUDZQ?=
 =?utf-8?B?Zmo0Ukt2TWxYcFRmemg0Q01FVUQ0VlJKZklHYmpIL08vQ0hUNGpySWdnYkRa?=
 =?utf-8?B?MGJqbW1jMC9uZEJPTUpzd1VMckhJZENrcnJqUzV4V29Ob0NsdmZ2dktxVXRP?=
 =?utf-8?B?S1V3UVQ2RFErVENadmc0M0R3bTlrWVROUWpOVUswTXdaem0vdFhQSkN1Mkxs?=
 =?utf-8?B?ZWNGUjg3RWphcUE1T0xQUGk1MWtjQTVxazFSdGt1VVhoZ3JmSFNrNkNEOTVQ?=
 =?utf-8?B?YkIxalBxTDdxWWM2ckdDUWgraHc0bGpUR1ZuenJ0YVUrRms5RnRpdjU0WU9H?=
 =?utf-8?B?aXhZaWpzS0hOY2tNeEdSSFVWeStVYm1CbzR4TW9Scjh6RU5yQjUwU2ZVbE85?=
 =?utf-8?B?V296RjVQVFMvZDdieE5HVEthQWNTVXdKWE9Ed1JHTlZ4eU5OOFhyRG5RaFE0?=
 =?utf-8?B?SE5kUEluUFhybWJ0QlFaeUEyOUErTXVCVE5xNG1WMnBtMGQyMVJyRHlJLy94?=
 =?utf-8?B?ZVZDTis2UUpGdU9YaUhvV1ZXeHpUV2dObm5ZSWtCb0NkTG9YdTMybTZpRXBz?=
 =?utf-8?B?TTlDQUlCeDJxbUNFUzBhamlsWml0MldGUDJjdGF5OVd3MVB0cVJjRXBsR1V2?=
 =?utf-8?B?ay9qRkVQZWpWTk1UWTJxRU90a09FeVpoNzhlVnpydFVvUHczYTVlTk0zRS8w?=
 =?utf-8?B?YnBuRFVVRTZwTzJTNlBwa3FPNDFhYXVrS0FzT1JhYy9tdlk2Mjh3Qmd3bWY4?=
 =?utf-8?B?aWNyQ09XaTNIcEVkblZNM29LVEEzR3QxUDBhSDliV2ZocXo2Ym9qeGs3YW5V?=
 =?utf-8?B?cDM0eTk2Nm0wZ1dFVXpGQ1c0dzBHVUFwRkc0Q2tyWVRveUNYV3NBekgzUTd3?=
 =?utf-8?B?WVpTYU8zN1ZEdHl3NDJ3ZjhOYW9jb3pqMEtOVUw4Y3lpVGNNTUx5ZzMyT3NR?=
 =?utf-8?B?cjdwRG95RitKaWowL1lka1gwbUhDRnp0dG9zemEydyt3cDYrTmZmNnJPclhE?=
 =?utf-8?Q?lvkTCNI3Qedg2q8PZdQuiIqTA4p2aemt5/ELAsekDlms?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <63DE08700CC1C94082A18F515AE9B904@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: infinera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4612.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ffa2cac-5c6e-4378-ec2d-08db79816aec
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2023 15:48:15.4591
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 285643de-5f5b-4b03-a153-0ae2dc8aaf77
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y4u7trbq1xjTC1TOGQ/xHScbc9HgHrp6I9XT4CgpaLsYx2AJkVMs4Rpp89XyY9IDGEqCPMwAJkZEvs0rtrNOyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7087
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

V2UgaGF2ZSBhIGZldyBldGggSS9GIHRoYXQgaXMgZm9yIG1vbml0b3Jpbmcgb25seSwgaWYgYW55
IFRYIG9uZSBnZXRzOg0KTkVUREVWIFdBVENIRE9HOiB0cmFwMCAoeHItY2NpcCk6IHRyYW5zbWl0
IHF1ZXVlIDAgdGltZWQgb3V0DQpbICAgNTUuOTAzMDc0XSBXQVJOSU5HOiBDUFU6IDAgUElEOiAw
IGF0IG5ldC9zY2hlZC9zY2hfZ2VuZXJpYy5jOjQ3NyBkZXZfd2F0Y2hkb2crMHgxMzgvMHgxNjAN
ClsgICA1NS45MTEzODBdIENQVTogMCBQSUQ6IDAgQ29tbTogc3dhcHBlci8wIE5vdCB0YWludGVk
IDUuMTUuMTA5LTAwMTYxLWcxMjY4YWUyNWMzMDItZGlydHkgIzcNCjxsb25nIHRyYWNlIHNuaXBw
ZWQ+DQoNCkkgd291bGQgbGlrZSB0bywgZnJvbSB3aXRoaW4gdGhlIGRyaXZlciwgZGlzYWJsZSB0
aGUgVFggcGF0aCBzbyB0aGUgSVAgc3RhY2sgY2Fubm90IFRYIGFueQ0KcGtncyBidXQgY2Fubm90
IGZpbmQgYSB3YXkgdG8gZG8gc28uDQpJcyB0aGVyZSBhIHdheSh0byBhdCBsZWFzdCBhdmlkIHRo
ZSBORVRERVYgV0FUQ0hET0cgbXNnKSBkaXNhYmxlIFRYPw0KT24ga2VybmVsIDUuMTUNCg0KIEpv
Y2tlDQo=

