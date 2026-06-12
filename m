Return-Path: <netdev+bounces-298441-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id reY+Mg5vK2oW9gMAu9opvQ
	(envelope-from <netdev+bounces-298441-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 04:29:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F0D67648B
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 04:29:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=BMZs+FPq;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298441-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298441-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1C35930DF2A5
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 02:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D3CB3148A7;
	Fri, 12 Jun 2026 02:29:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013049.outbound.protection.outlook.com [40.107.162.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B72C2E7BD9
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 02:29:30 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781231372; cv=fail; b=aiwGwYrVE+4/i8f/RdKB15FFso/fb+oJBzk5+TZ78fMPSbK6PCutPUEoeNfzKVxQd78A42pv3QmqpwWRImoZPJYpgUzqXVCruE+tA0BQkmGMA02FEG1pcWl2M8YesNL5jPnGRGhqAZG8IWBqgnNWDWs3oCZ13C7f7+duwewzaYo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781231372; c=relaxed/simple;
	bh=j62QPZ3HFr+NYV+q3vo+gCQdrMhVI2NCvLgp1W8uGbw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tk8mjBuNumhghEBpD8XBYowExdCaq11lEC0m7rQIFstYd8/fYMFddvAa4/68+XstSIKse2RHiapCU8TgyK/h+x8IOMa0lu/+4C1rK1LI6M4Qji9xKKgWJAN3QkmxxAv9tfJkWyNbUUixrlNlDb/RHrTCHa7MIjCThZ/lNkF49rE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=BMZs+FPq; arc=fail smtp.client-ip=40.107.162.49
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=buWERC6fXf160krytoFHVQ1xdGYUuTauhf490j1+uB2TG6aeqR9bKoOBFe9+Q0KSDYIxWHHXKvx5kTAUuk8Qb6iqkFvppCan3zVnOfSceaapEoZ8Y7fEN+Up/nOBMIxJ9nKAkGhpSDa1Sfzaq/5IthvP6aXQzNW1Z63CP255t/Qv7djmnC3ElqVrpTcjrOpbMdwuB8ZQP6eLmIg+o806CAnWmnZFCz8ul7y6/SBtaHiSno3Gs3CZk18sN0om47BTfefc8+tD6jtrDYuMdK9atwVeM6Vvm4XhUio9nrbZH8no4JJf1+3z8W/A8SpueOvzhAqylvNr1tehXqcukwSL3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j62QPZ3HFr+NYV+q3vo+gCQdrMhVI2NCvLgp1W8uGbw=;
 b=thrql+p6C6G4CHawcm6R0MoITMol6NV7LzSUylF63Wj2YyiPt+P+FknlbjwtM3ePmdPjVswJHX/ciRk0rd0AzRpA7Xs3marqbroI2Bc6LZQaCaWCH9LBrBYRywbxkUM1pNC3HiQvEOGNfsrceTWxtd5/8gjumeHbh9p5+N9xaFTLPh1zTcKs38o7lJgquiUmQDHO8w4EcwH649hO4gnO9rwq/SWPBBRejlks2idrNahUPYBGCe1WHWcW8ji3eVFOpVawcykUWSkrOCBusCqT/94r1FUH3oj3xMwGSrdZXWs2MiD/VOzNDKAZ9HMS5rjg1/+gMlRk/ucod1LiqAKs5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j62QPZ3HFr+NYV+q3vo+gCQdrMhVI2NCvLgp1W8uGbw=;
 b=BMZs+FPq54atS+0kDZ0A40/ZTswkEWbpydHdbAjlXRn4UgWe82nAQBJCnI27HjRvV1D65b5h69PzkJZ3sRfRkzy+5aDYXakb3feYSpYh8lo7kIGxvyK/w4szQ4viU351S2x069WsmGnvucE4VBMkxL3Tn2cOdczaQVNziUrKhETv4n1LQd1c95nll17g+u42qrH20AjbMc9F954NuHUzC45hN2sY19y/HJ8mmv1QF0NfMFFO6+J9ViZmHSIvb83oDkX4ngKbAWPW4iymzeHOQGaoFNANTCf8ESV++nYWADQGxLnV6+FWNp8D5PhcRoLQ6qdvYmk0LWLfpczK9Lu18w==
Received: from DU2PR04MB8629.eurprd04.prod.outlook.com (2603:10a6:10:2dc::6)
 by AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.14; Fri, 12 Jun
 2026 02:29:26 +0000
Received: from DU2PR04MB8629.eurprd04.prod.outlook.com
 ([fe80::9d04:7526:a901:fe47]) by DU2PR04MB8629.eurprd04.prod.outlook.com
 ([fe80::9d04:7526:a901:fe47%6]) with mapi id 15.21.0113.013; Fri, 12 Jun 2026
 02:29:26 +0000
From: "Wei Fang (OSS)" <wei.fang@oss.nxp.com>
To: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>
CC: "Frank.Li@kernel.org" <Frank.Li@kernel.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, network dev <netdev@vger.kernel.org>
Subject: RE: [PATCH v5 net-next 5/9] net: dsa: netc: initialize the group
 bitmap of ETT and ECT
Thread-Topic: [PATCH v5 net-next 5/9] net: dsa: netc: initialize the group
 bitmap of ETT and ECT
Thread-Index: AQHc+Ue+Wx9OOMRDokWe7UmqSRcU5bY6L3oAgAAEhCA=
Date: Fri, 12 Jun 2026 02:29:26 +0000
Message-ID:
 <DU2PR04MB862906517C7D1D2BB82E134188182@DU2PR04MB8629.eurprd04.prod.outlook.com>
References: <20260611021458.2629145-6-wei.fang@oss.nxp.com>
 <20260612021313.0C5651F00A3F@smtp.kernel.org>
In-Reply-To: <20260612021313.0C5651F00A3F@smtp.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR04MB8629:EE_|AM9PR04MB8585:EE_
x-ms-office365-filtering-correlation-id: dfbf7600-3e3a-4fe8-db2b-08dec82a6c70
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|1800799024|366016|23010399003|376014|38070700021|18002099003|22082099003|6133799003|56012099006|11063799006|4143699003;
x-microsoft-antispam-message-info:
 D5QX9f8zCxcEFBSmW+9mtpXiwyeArr1E72/StVdW16hr+9jRLHoG8oMNahXZGtFoDwZAJuIYuIwnzdOlZ4++0B54GX0Gp47oA1TgF7KvAsGa4YnH42/Fiy71ZfUTu93vy9QCn1pcp54whQgnM6MLGuHQMvGWqaPhMmWXi6STlLUrvvsVTvPwa2IA9qVud/FS6odEH0X/iShjbaGzumuS0bCQs9r1zqdZtO0tzWvXTQsZtnDcTo1HqGnSLd+TnwkGnFZKT1TUT09n9T+HPSwOSvHaV3IIT+8GVJAACtmS8GB1oDKwYn+K6+EUw2cXFMJg1HJ+7+hCrDmzZmojbGpclVGwuAvZeBaGXXhWT0nrADOb0lJ8d0Vos+RPvr+S8nWP4rNG9LkUd9JXnxJu3Lhs3METjCWHZidWIsSX6JV+5vT+1jGWgH52bNp6juQl0oR3eD9955d4PJ9YmH7evaxoPR0gw4+D/IZA+YZ30ZG1va6b+MTucOK5MvOf9EScXPiFmyu9EoNcONUNTZ7t3fSK1FbnDHD5yj1Pn1pv7TG1xU59S51zvU9bgcsX9ijOLJsiviLn4nn+bLgJ4RlLJJEDgDLWGxaI9B98SsYyph4+iG9/YWo4GIWVd2nqGZr8zik0LSjNQ9zjnQPmMeMHGFdhq+Nvd6Jv7NTpT3MRIWv2PhsfPOkoUeNsmOkTE9aPPNpYJ/ePV9ziK0yIQXBgvCbV09z049XeOnpt4+qKT2d48GENgFNU7y+2+yIyCCkSlItA
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8629.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(23010399003)(376014)(38070700021)(18002099003)(22082099003)(6133799003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?L05oMnB5YkFXNnl4YUVBVjlib2ZvSjFNVkRzSlBzbnBNV0dTaVVUNzB2bTQ0?=
 =?utf-8?B?U1BNZGFoZEptMWIxUFpmWFdWdWE4cGF2cjlJU0p1dnpjNmFBbzF3RXBqR0NT?=
 =?utf-8?B?Wnc4UndrbWhqb0pSb0tzUlRjVURNYU5PakNDRzh2ZjMwVzk4TmhqSVh5ZTZx?=
 =?utf-8?B?SkdRUnBqN2ZFdW5Ua0pLNER3T2duOU16aVdRbTlHT3c1MERPb3ROcm53OWs5?=
 =?utf-8?B?bUp6MlFVb0YzN0Q3dldab2dYcWM2WFQ4SjgySGx1NGF1aDJYYjh6YUhlUHUr?=
 =?utf-8?B?bjRxTnlyRzBMRkdpUWpVbUtuTmxhdmlmcGpsOFZ3Qmd3bGQ4Z2ZzcVJEVHk0?=
 =?utf-8?B?TGpDczZNTGdqaW53UUlkbGk3NTVsZXdObWlrTk5WaWhIb3pDQXZYWkxOaEl1?=
 =?utf-8?B?ZGNhNVZkeHhVRnBEUlE0MzlVeXp6eDYvdXFxQnlJMm5SRmN4ZnA2U1pBMUNE?=
 =?utf-8?B?UlNDWDJ6YkVZbnZBMHZKWjlVQmRxajk5THFZS3FnRCtWb2pyeEE5SElOTjMr?=
 =?utf-8?B?UmVVU1g5dzdmRmpLVUVUb1hWaEJqWVA0aHBFOE9FWUJkMzVuNWROeEtsUHND?=
 =?utf-8?B?SE9KWFR5QksxcUg3b1VDbU0rUDNDOCtOTzRpcjlwayszMVZzZmxjM2xKTnZQ?=
 =?utf-8?B?VVNNdTd2TCthbG5qV1V0Tk5BMkgxckxaSmFBWSt5ZEFSUDdGZFltdjlEc0FP?=
 =?utf-8?B?dXE0V3JvWk4xb0Q4WDU3eDVYM0w5MGE2eHhNVDBaMExvV25ZV0R5VkZPNlha?=
 =?utf-8?B?R1lTTGJtWWJBSUhMbTFQMm9yUW10clBuRE9NeUlzUGN3MjM2bkJMdFdmWklZ?=
 =?utf-8?B?a1J3cWNaWVMrM1ljdzgwUHN6cUFpeDl6S1dyakU3VzJ3RmxncW5BYTlUaW9U?=
 =?utf-8?B?aGUwM2JEbnozZU9ORFlQMjNCOFB2eFNRTTZ6ZzdTREhPNGtWYkNFOGR0ZWhl?=
 =?utf-8?B?TzFYWmVoWXFDdzdhNC9lMklwS3h6ZEwycWZNN2wydW95YXNGbUhyZDRGZENy?=
 =?utf-8?B?MitOTktGN3RKS0tibFFTWElhb1lPeVZub1RkU3E1RkxOUy9CNkxxV0szendj?=
 =?utf-8?B?ZzZHUm5kTWFWckkvbExEVk00eHMwWjlBRWtRUFA4Y0g5ZW9aUktxOGlZVUhj?=
 =?utf-8?B?MVZSbTVPQjRMTTNsc1QrT2d4dGd0NnJzd3N2Yi8zRGxtY0cxdEZFVVpyVzRY?=
 =?utf-8?B?VlJPM0kwQUJWVTdWelZhUnhySXNQNTY0QXI3bTYzMzYweDMwc0k3TjhSWGJY?=
 =?utf-8?B?UkRzbmxBMmwzOFJIcnFMeGdtQWR6ZnJzOGZlMGROcENNVFB1SktqRHpDV045?=
 =?utf-8?B?Ny95eHgxbDcyaVlJY1VZcTdjQ05Memd4QUhoTlNydGd5M3JmNDFSTzNhZEp3?=
 =?utf-8?B?TzJIY1dBbFhHNzdHNWthdWhLanA3Z0RTdW9WQTdMaDllTXpzeXhmUE5PV0Iw?=
 =?utf-8?B?UDVraHZlOUtGYUJENjVSOXMxVE0rSHNsUEJubW9meW1KSjFFNjZYeU5BMDE3?=
 =?utf-8?B?MWNRZWc4emNwdk1EZVdFK2MwbEFOVlFiVGVDbjlnTnh5eGdZN25WRGp2YnU2?=
 =?utf-8?B?SEt1TUdsVTJKNmh3OGRwN1VRZWFxbWhCdGdsWWRaZjM3RitHVG8xTk9ydTJm?=
 =?utf-8?B?Rlo3bEh2M094VGVSSEkrNmJ3Si9wUXo4VWJtS2ZITHp2MTBvMmliVGs4NitS?=
 =?utf-8?B?Z3kySFRnNHRwZkRMNHdFZC8yY2phNmNoNVVIWWpmZnN4WFA3V0MrUGpmaDk3?=
 =?utf-8?B?TlhVbVUrNW81VXJUa1ZwMHNyT3ZISmhXNFFZN29IZXc5ZW8vWnc5YkNaeFpU?=
 =?utf-8?B?VlJWQnVHVFhjRUx6ZjJCODZwY1pKaHFSd0dmeW4wOEdGWENKRS8vditwUktE?=
 =?utf-8?B?ZFBXeWQ5YVREb09CUHcweGo4VkZ5SVAzMENZNjEwNWVtYlRQK0NmV2VEWUlR?=
 =?utf-8?B?QXUya3FoeExOem1BbGEvbTdFajBGVFBYL3NacmZNMGs3ampncEMyRCtoQWV5?=
 =?utf-8?B?anNSbEVoQS9BaE1yRi9LbHNrV1lKUjlreGhmbUVkbkZwcjA4QmkrbmpDL25y?=
 =?utf-8?B?L2g2cHRaSkRUZDZSanlDUEdObzQyeXJCYjVkZmloUVFsVlFpekQxcTRlN0NP?=
 =?utf-8?B?dnlwMnpHMDc1ZDVLdithdkdPQkl2UUlFMVZobTVhU0psK0ZVS0IvUWcyakw3?=
 =?utf-8?B?a2Zlb3R2cjY5cUdtQTdrVE1sSXVkQTZPRmNGbXBkQllVbnQxdW9SM09zVTR5?=
 =?utf-8?B?Y2pxQ3A5eEtkVHV1b0U5TmVtYUNXNkltak9aZFErMlBoNkc5SUxVOWtQZHda?=
 =?utf-8?Q?ltAr80CfcwuOkM4Kms?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8629.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfbf7600-3e3a-4fe8-db2b-08dec82a6c70
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2026 02:29:26.6491
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7o1YGPV6BLCp1GIw7CGhHfjUgBBprw9hvVo1BwFwRAxqi3ziwjfOWZb6Trk57ZL4dA7fK+Wibmn20UUI6zpizg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8585
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.54 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sashiko-reviews@lists.linux.dev,m:Frank.Li@kernel.org,m:imx@lists.linux.dev,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[wei.fang@oss.nxp.com,netdev@vger.kernel.org];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-298441-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@oss.nxp.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 39F0D67648B

PiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9kc2EvbmV0Yy9uZXRjX21haW4uYw0KPiBiL2Ry
aXZlcnMvbmV0L2RzYS9uZXRjL25ldGNfbWFpbi5jDQo+ID4gaW5kZXggZmE3ZGQzMDdjZTEzMC4u
ZDQ0NzVhZDdlZDZjMiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL25ldC9kc2EvbmV0Yy9uZXRj
X21haW4uYw0KPiA+ICsrKyBiL2RyaXZlcnMvbmV0L2RzYS9uZXRjL25ldGNfbWFpbi5jDQo+IFsg
Li4uIF0NCj4gPiArc3RhdGljIHUzMiBuZXRjX251bV9hdmFpbGFibGVfcG9ydHMoc3RydWN0IG5l
dGNfc3dpdGNoICpwcml2KQ0KPiA+ICt7DQo+ID4gKwlzdHJ1Y3QgZHNhX3BvcnQgKmRwOw0KPiA+
ICsJdTMyIG51bV9wb3J0cyA9IDA7DQo+ID4gKw0KPiA+ICsJZHNhX3N3aXRjaF9mb3JfZWFjaF9h
dmFpbGFibGVfcG9ydChkcCwgcHJpdi0+ZHMpDQo+ID4gKwkJbnVtX3BvcnRzKys7DQo+ID4gKw0K
PiA+ICsJcmV0dXJuIG51bV9wb3J0czsNCj4gPiArfQ0KPiA+ICsNCj4gPiArc3RhdGljIGludCBu
ZXRjX2luaXRfbnRtcF9iaXRtYXBfc2l6ZXMoc3RydWN0IG5ldGNfc3dpdGNoICpwcml2KQ0KPiA+
ICt7DQo+ID4gKwl1MzIgbnVtX3BvcnRzID0gbmV0Y19udW1fYXZhaWxhYmxlX3BvcnRzKHByaXYp
Ow0KPiA+ICsJc3RydWN0IG5ldGNfc3dpdGNoX3JlZ3MgKnJlZ3MgPSAmcHJpdi0+cmVnczsNCj4g
PiArCXN0cnVjdCBudG1wX3VzZXIgKm50bXAgPSAmcHJpdi0+bnRtcDsNCj4gPiArCXUzMiB2YWw7
DQo+ID4gKw0KPiA+ICsJaWYgKCFudW1fcG9ydHMpDQo+ID4gKwkJcmV0dXJuIC1FSU5WQUw7DQo+
ID4gKw0KPiA+ICsJdmFsID0gbmV0Y19iYXNlX3JkKHJlZ3MsIE5FVENfRVRUQ0FQUik7DQo+ID4g
KwludG1wLT5ldHRfYml0bWFwX3NpemUgPSBORVRDX0dFVF9OVU1fRU5UUklFUyh2YWwpIC8gbnVt
X3BvcnRzOw0KPiANCj4gW1NldmVyaXR5OiBIaWdoXQ0KPiBEb2VzIGNhbGN1bGF0aW5nIHRoZSBn
cm91cCBzaXplIGJhc2VkIG9uIHRoZSBudW1iZXIgb2YgYXZhaWxhYmxlIHBvcnRzIHJhdGhlcg0K
PiB0aGFuIHRoZSB0b3RhbCBwaHlzaWNhbCBoYXJkd2FyZSBwb3J0cyBjcmVhdGUgYW4gaXNzdWUg
aWYgc29tZSBwb3J0cyBhcmUNCj4gZGlzYWJsZWQ/DQo+IA0KPiBJZiBhIGJvYXJkIGhhcyBkaXNh
YmxlZCBwb3J0cywgdGhpcyB3aWxsIHByb2R1Y2UgYSBzbWFsbGVyIGdyb3VwIHNpemUuIFNpbmNl
DQo+IHRoZSBoYXJkd2FyZSBpbmhlcmVudGx5IHVzZXMgdGhlIHVuY29tcHJlc3NlZCBwaHlzaWNh
bCBwb3J0IElEIHRvIGluZGV4IGludG8NCj4gdGhlIEVUVC9FQ1QgZHVyaW5nIHBhY2tldCBlZ3Jl
c3MsIGNvdWxkIHRoaXMgbGVhZCB0byBjcm9zcy1ncm91cCB0YWJsZQ0KPiBvdmVybGFwPw0KPiAN
Cj4gRm9yIGV4YW1wbGUsIGlmIHBvcnQgMSBpcyBkaXNhYmxlZCBvbiBhIDQtcG9ydCBzd2l0Y2gs
IHRoZSBncm91cCBzaXplIGJlY29tZXMNCj4gMy4gSWYgc29mdHdhcmUgcHJvZ3JhbXMgcG9ydCAz
J3MgY29uZmlndXJhdGlvbiBhdCBiYXNlICsgMiwgYnV0IHRoZSBoYXJkd2FyZQ0KPiBhY2Nlc3Nl
cyBiYXNlICsgMyBvbiBwYWNrZXQgZWdyZXNzLCB3b24ndCB0aGlzIG92ZXJsYXAgd2l0aCB0aGUg
c3RhcnQgb2YgdGhlDQo+IG5leHQgZ3JvdXAsIHBvdGVudGlhbGx5IGFwcGx5aW5nIGluY29ycmVj
dCBlZ3Jlc3MgdHJlYXRtZW50cz8NCg0KVGhpcyBpcyBhIGZhbHNlIHBvc2l0aXZlLg0KDQpUbyBj
b25zZXJ2ZSBFZ3Jlc3MgVHJlYXRtZW50IHRhYmxlIGVudHJpZXMsIGFuIEVncmVzcyBUcmVhdG1l
bnQgZ3JvdXAgY2FuDQpvbWl0IHRhYmxlIGVudHJpZXMgZm9yIHBvcnRzIGZvciB3aGljaCB0aGVy
ZSBpcyBubyBzcGVjaWFsIHRyZWF0bWVudCBmb3IgdGhhdA0Kc2NvcGUgb2YgcGFja2V0cy4gVGhl
cmVmb3JlIHdpdGhpbiB0aGUgaGFyZHdhcmUsIGFuIEVncmVzcyBUcmVhdG1lbnQgZ3JvdXANCmlz
IGRldGVybWluZWQgYnkgYSBiYXNlIGluZGV4IChmaXJzdCBFZ3Jlc3MgVHJlYXRtZW50IHRhYmxl
IGVudHJ5IG9mIHRoZSBncm91cCkNCmFuZCBhbiBhcHBsaWNhYmlsaXR5IHBvcnQgYml0bWFwIChh
IGJpdG1hcCBjb3JyZXNwb25kaW5nIHRvIGFsbCBwb3J0cyBvZiB0aGUNCnN3aXRjaCkgd2hpY2gg
aW5kaWNhdGVzICh3aXRoIGEgMSkgd2hpY2ggcG9ydHMgaGF2ZSBFZ3Jlc3MgVHJlYXRtZW50IHRh
YmxlDQplbnRyaWVzLiBJbiBjdXJyZW50IGltcGxlbWVudGF0aW9uLCBvbmx5IHRoZSBhdmFpbGFi
bGUgcG9ydHMgd2lsbCBiZSBzZXQgaW4gdGhlDQpldGFfcG9ydF9iaXRtYXAuDQoNCj4gDQo+ID4g
KwlpZiAoIW50bXAtPmV0dF9iaXRtYXBfc2l6ZSkNCj4gPiArCQlyZXR1cm4gLUVJTlZBTDsNCj4g
PiArDQo+ID4gKwl2YWwgPSBuZXRjX2Jhc2VfcmQocmVncywgTkVUQ19FQ1RDQVBSKTsNCj4gPiAr
CW50bXAtPmVjdF9iaXRtYXBfc2l6ZSA9IE5FVENfR0VUX05VTV9FTlRSSUVTKHZhbCkgLyBudW1f
cG9ydHM7DQo+IA0KPiBbU2V2ZXJpdHk6IEhpZ2hdDQo+IFNpbWlsYXJseSwgd2lsbCB1c2luZyB0
aGUgYXZhaWxhYmxlIHBvcnRzIGNvdW50IGhlcmUgY2F1c2UgdGhlIHNhbWUgY3Jvc3MtZ3JvdXAN
Cj4gYm91bmRhcnkgb3ZlcmxhcCBpc3N1ZSBmb3IgdGhlIEVDVCBncm91cCBzaXplIGR1cmluZyBo
YXJkd2FyZSBhY2Nlc3Nlcz8NCg0KU2F2ZSBhcyBhYm92ZS4NCg0K

