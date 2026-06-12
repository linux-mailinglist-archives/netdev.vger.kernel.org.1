Return-Path: <netdev+bounces-298448-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id b1WSB9d8K2rg+QMAu9opvQ
	(envelope-from <netdev+bounces-298448-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 05:28:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 17EBA6766D4
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 05:28:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b="YlQpRG/T";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298448-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-298448-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 29D3B3004D84
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 03:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FCB33254AE;
	Fri, 12 Jun 2026 03:28:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013007.outbound.protection.outlook.com [40.107.162.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5D9339861
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 03:28:15 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781234897; cv=fail; b=FtH91lflSdoPtPcgUrMtezmx9YROOXp7FnLVzn4aYQp/UM5U2HE5OzsbPva/O/go/tFI7vh+2KfPDlEookPVOzFFsk6PmMBQHPWdqgsbGe2kNdclcOV159QRU5NUa2M2tcDo2M8hcyVt1oyGOK800QEkR58poaUPLajQY5xpHEo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781234897; c=relaxed/simple;
	bh=0e3/qPParh9UN+/Y0nxbAPg5zw0wUkA2JFEgf3wkoIg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YOCwBDe3GSZFY6GbeqK+wneCbxFtI7rJW+J5GnfKp6AKITOvWfL8drIpTUemlIU1YYa+5cjrm1gsL/k6QkOa/41NA7P8rnlZyUrQSM+u3iO7j/vyaIw8HuTdr1U+gMqRxcryCgWOIBoxIelRSj2FHh63fVvn1UkjHSzAhQQRTvg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=YlQpRG/T; arc=fail smtp.client-ip=40.107.162.7
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=unVOmxXXX0GCkLoXNcCtus/bWnYlLSYpQAW5E7Ok/1ILkDwzwEDZkBPPhQj9oEh/q2dt4sDgiT/MyZKodwq4ZjprMEQUH8ZK0KZ2Y1jaHr81/nPghGcl+tPxmqliSZphVU/m4+HqbPwIWhorIOwJnXx6JXMhrVRrzpAEUljcF4k2zZBmXenqk9NTDMwVRQBX+3c6QRnpQjQDoLU+hbuvEdaCZq+Gr0RY+TgFMRE1zntP7AaJ/2n8nKfNw1r+D6juiblq40m/0Z57NzC5ge6NxrpOmS1Y5Zwo8oN1X8rMxCEXPNvjlds4E/nC1+e59dNhMp99vDj1TWG90tc8pTOCKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0e3/qPParh9UN+/Y0nxbAPg5zw0wUkA2JFEgf3wkoIg=;
 b=ctVTbX98/CmjYnx0d7EI6xUQQe6W61whvDy+f+BLX0EZUcEfm0LMliOXRSNCOTNc1X9GX+jH/h6URpe/ee6h+pokXM4mVGFgitL/KRnuYIJUYvxsT+gKUI5KpqqMoymhR2Yk9bTx4JfyrdwozYbIRVbpBda5Z28rvH4Q2GXKbnggN8AFhkFG+/DsDI4uGaNMyR+iJsuoATym1znBUsIhI5y+4ZR4VYv0Ti+wRJOZSZ6xpcxO6ztE7rYV2bPbWauYRZwSPtOVULD/T2OYRNpoSsgDh+lCikcT8qSb2wvMKRdzwIxB1j5sxUxyLReWveWQHsvCl+80d7wuiyvBN9Hb2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0e3/qPParh9UN+/Y0nxbAPg5zw0wUkA2JFEgf3wkoIg=;
 b=YlQpRG/T6G9A93oaUD1DbuLbY/rGxDtCUBwd2e0O231rh9MeouXEJv58Nr5XaQryzqgE6DtbJGzbu+9aZCObpE/XFaSvM7hpwylawOC1g4wpIjbjco+uoLAgVh0MbDqJPH1ZQ29um37qjh7VthlO8FRcvpvIRYLG2QO4t6TJ1xBQqP05g3cS91eNaTQV+CkEN37jm+zjaqUzKnCAfaZcaVRtqZr2GLp1ZX6PMzSNCi41luTwVF2FwDJ8Cdtkb8dJXoapUogC0toASqiSeE2Cjbd+n0qUyz4Oc09HlmBrGkyeur4OVuu1WjIp4bPCPaD/inm2XRK4KNEl1SSZI586mA==
Received: from DU2PR04MB8629.eurprd04.prod.outlook.com (2603:10a6:10:2dc::6)
 by DB8PR04MB6938.eurprd04.prod.outlook.com (2603:10a6:10:117::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Fri, 12 Jun
 2026 03:28:09 +0000
Received: from DU2PR04MB8629.eurprd04.prod.outlook.com
 ([fe80::9d04:7526:a901:fe47]) by DU2PR04MB8629.eurprd04.prod.outlook.com
 ([fe80::9d04:7526:a901:fe47%6]) with mapi id 15.21.0113.013; Fri, 12 Jun 2026
 03:28:09 +0000
From: "Wei Fang (OSS)" <wei.fang@oss.nxp.com>
To: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>
CC: "imx@lists.linux.dev" <imx@lists.linux.dev>, "Frank.Li@kernel.org"
	<Frank.Li@kernel.org>, network dev <netdev@vger.kernel.org>
Subject: RE: [PATCH v2 net-next 04/15] net: enetc: add link speed message
 support to PF driver
Thread-Topic: [PATCH v2 net-next 04/15] net: enetc: add link speed message
 support to PF driver
Thread-Index: AQHc+L4AymIDCKMg802O1H2f1XvU3bY5HSqAgAEoUiA=
Date: Fri, 12 Jun 2026 03:28:09 +0000
Message-ID:
 <DU2PR04MB8629864749895D4C604DF26888182@DU2PR04MB8629.eurprd04.prod.outlook.com>
References: <20260610091844.3423693-5-wei.fang@oss.nxp.com>
 <20260611094734.43EBE1F00898@smtp.kernel.org>
In-Reply-To: <20260611094734.43EBE1F00898@smtp.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR04MB8629:EE_|DB8PR04MB6938:EE_
x-ms-office365-filtering-correlation-id: 5fa1eb08-02ca-42f7-2483-08dec832a058
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|23010399003|1800799024|366016|376014|11063799006|4143699003|56012099006|38070700021|18002099003|22082099003;
x-microsoft-antispam-message-info:
 YUS3QZa+5lY37aqGkW57DuYlwjl4lKdj7WKPSLu1Z04fUe+SrTCAD/m+2SNXUgifGkgltNZgjQKklG7UOZOg4nyZv+t8qDTkYX1b1/okWnfsmi+jyR4I/NPMcGWepTjLn/iqfepMyxc4Lk+HwPCb7rcE2AVQxkmlZND3/az02jTmn+xsV0dFG9Mj/Nf/+gz43ZlA5/v/1G7DG66yx+cqql1H1LeXEvgzRzrGjZXb3eAzysRk4BU7DlMtTumEqEaC8arQPtLw7cmgJO8Fe//0qtGWXOVJeuqDiQF7/jQZlRvChmlP71twUbYrSaX52hXyA+QIsY31KDoye0Znph9QYknCTdy9amw3cApzG259J/K9PP0R2yXwDvJ9A+OLGMNLatiH0Uttev5UtnXNqmOQiO2C6MjVamMLJx+V5AA52jRXd1BBua80t7hU3H856sXXa9Qo9KZ/55QQ59etX8xnUGuvU4rkwDHSTyHeAh9TKNL0Bcd94DC+zE0iagjXH4KnLVcyr2tR7ei6tZi/pS2gCsI59HQ2t6su7iQD8/OjLhOrjpj1+pIEr+w+Y/+zWGdId7egom7YywpHTC/wI1HIobfwe2uW09BeuQ5N5GeDds6tJcge+IXLUiWa5oBAatyqT76qVYkXX/+SuCbJmVwMrI+BBWFq+R0R+DvVhucV+tbcIfDFrUT7BOwntmBgr3MA2BkKHCqsI/OheOFXMFeiKTnrG++EMNPg62HLGVxJWaYUovCLuDwdEgRzbMymE77A
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8629.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(1800799024)(366016)(376014)(11063799006)(4143699003)(56012099006)(38070700021)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?b0QwTndrczVGSENBTHM2M2hxU28yWDJ6Sno1enFDOXNXT0FCSkRTd2QvMFVw?=
 =?utf-8?B?L1hpWHRCTmxKTkFDZnhyeFF6b2ZOT0w5Tm44UU93U3F2Yzg1eDM2OWxRWFh0?=
 =?utf-8?B?K0JXOSs0V3U5cm5Jd3duRld5Q1E5UGhueExDaGF6Y21qNGlqRzBDdUtNVUdh?=
 =?utf-8?B?WU5KNlliZVVuRUhZSkxKcjlTMXZiUGRoNHlaZVZrVDdISjBDVXBTT3FIK0Y5?=
 =?utf-8?B?TGhiNmFnQnhISU9GclpVRU5JdW8yVE1VdHdhdDZ4eGdTQjE1Rll3dlo2UzZh?=
 =?utf-8?B?QUdtVzlYMjJUdzVWZnJaVnBNeE1wT0Z0ZFRmbCtoYVhPbWhnRXFrZnRhRDR3?=
 =?utf-8?B?K2pNTFVxYlJsZVNHQ2d2d3VZWEpIQkoxNXdLclVydmhCRDh5eVBNc1dqMlMr?=
 =?utf-8?B?d1U5VURDdmNvQkNURXRaaFNKb05EK2NrY3BqREpibFFaaTJiWTZuazNsSkI4?=
 =?utf-8?B?Z3FsNlF4WDV0eGdRQkttTEdheTFMMjRyWDErK0dwUkNoZlJacU8wK2l0V3JZ?=
 =?utf-8?B?ZWR6Q0xNK2sxTTIxalRiY0taTUUrQ1Joa2dwa0NMU2l3aTVvMzFvbTY0OGpC?=
 =?utf-8?B?N2VyeHN0OWFKbzVFQWtncGxJNlRVR2x1RW16S2RBSmlzeXFUVlVjSjBzREpi?=
 =?utf-8?B?SWNCQU53alYxMDgvYkp4RWdGQnU5Y0UxQ2llRlVNbWRBT3RFWWNCeXdEZlRE?=
 =?utf-8?B?VXR1QThXVHEzb2NKTG9iQlQrd0ZtcHRZL09lS3Q1QlgwbUxWdHBkSzhreHJZ?=
 =?utf-8?B?WjNZK051eWRVUXlIVUlyY3UyeFpKTExieVljd1AyU1ZzUUJWRW14dFdjUFVk?=
 =?utf-8?B?VGkzUUJXUEVidmdtdjZ6N1hVZ1dnQ1FHK1pyMHl0a1VvdU44WmNhVi9EdUhq?=
 =?utf-8?B?N2FzVWJxM3R3OVZadzJpdUJQNTlPSzFEcWJIVDM4N1hNNEU0YmtTZ3J1T3pX?=
 =?utf-8?B?a0xTNERlSHVmc3VBYVBkeWdaVzhQZWJObCtUUUtKaStreVZSdnU1TDNwcDFo?=
 =?utf-8?B?ZGFlNUVtcWptaitXMVNqM3RBZ0pqYzBmSmVnNVlNL05PbHo4SE9jS204L3JK?=
 =?utf-8?B?Q1dxRUxOaTUvU29WYzY4MSt3aElmZlR5akZCTHdHL1lRQzVwMlMreXRrSHB0?=
 =?utf-8?B?VU0zbEM3Um83OE5aeXBWSndqUWNFQkJkYytXQVZwZFZ3dWJ1R00wNzFlTUhv?=
 =?utf-8?B?aWhnUm5QTVhtbWxoQXhLemxHdVJTaEl6bVhwU3RiRFBwRWdTOXV4Q0FFRHpW?=
 =?utf-8?B?ZzU0VitZRDNOM3NJNlgvdUVoVFNqb3BCQ3VDWWxoS0o1VTFpZ3RKd3dHRGxo?=
 =?utf-8?B?a1lCbHZZd0hyNTI4WC9WdThYVkNQRkEzd1ovMWp1emVsQmRmcFh0SEY2UlBC?=
 =?utf-8?B?YUhpMjRmRUhZSWU5WkVmMExURDAxUklsV1NabVVEd1RjWE9naStXaUpXN1Iy?=
 =?utf-8?B?ZFV5bUJYWlRneFhZblZOb0xyVEJ0TTlEZktiY3FDVVFYN2txLzZHUWZlQ1Rx?=
 =?utf-8?B?K2RDNTY5WERDOEh1blVXMzZyYXYvditYVjNDdDlnUEZRMnoza0ZpNTkwRDFi?=
 =?utf-8?B?ZWhRaGV2RVpiNGVJdzZUOTJOZG1EM3pTeERVYm5OeFN6NVQ1T3F6bnZkc0VO?=
 =?utf-8?B?cStUU1Y0M01CUnJRNktLRzk4UkxoOTlhbzE2MW5wS3U4SnlweTdhczdseUZU?=
 =?utf-8?B?ejFvM0ZiQmZnNkdnYWJ4L1lRTnM3MEhwYXA4VHZ3dzB1WWlKTk4zQUQ2RWRQ?=
 =?utf-8?B?MkNiUTBTZWdaaFdrV3hBdTg4WXhFRW1yd2FHNEpvaVNPMUtidHd0QStjNG5w?=
 =?utf-8?B?VEtJVWpFczBaZzhSTm9JWithVDhPbEY2WWxJY2x1bmxyWDV0cGYzRkMvdEpD?=
 =?utf-8?B?Ym9nOEgrQ1llWlJ2cFJmbnJwSTZ5WVJ1ekN0Mm41NDV6VWpONnltNkRBWU5y?=
 =?utf-8?B?eDI4WTllcC9YNVZ6ZjVQbnoySFVMR1JkY1FlY1hKVnhaZFRQcXJWWVFOamFS?=
 =?utf-8?B?aVlBK2drdW5SRlVSUHplTk4xMTFGNW42NXN5cjdFRGVzVUw2TXB6ODlENHFS?=
 =?utf-8?B?a0lnL05obS9YUi9kZ1RpbkpKY1hYaGEvMkx5Q0NPd1hFS0loZUdEdGhST001?=
 =?utf-8?B?R1IzMGlSc1YvcUZ0YjNKdUR4cmNQZmE2QitUTTRIS3Fxd3lKNzFKdFlhS2Ra?=
 =?utf-8?B?QUh1N2h3OTR2SUl1VUY3cFJzVFpzQ2ZsZDZtekpuZnh2cXM5OE5YTTJjbmo1?=
 =?utf-8?B?NTdNWlRSaU5HNWo2OTk1SjFxYWpwOXcrM2xsTXFvQVdMWkU3bldkUUk5QXd3?=
 =?utf-8?Q?dIBAWDhkc8m3b7ikM+?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fa1eb08-02ca-42f7-2483-08dec832a058
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2026 03:28:09.6727
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JDS6G8GaiCIwoE9/zyWv6F9QHtFFsAWeqg3KmjiBtZtSPi24teF0oINoSKlX+f6pNmI7M1DOo9Q58a+es+zy1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6938
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.54 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sashiko-reviews@lists.linux.dev,m:imx@lists.linux.dev,m:Frank.Li@kernel.org,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[wei.fang@oss.nxp.com,netdev@vger.kernel.org];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-298448-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,oss.nxp.com:from_mime,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,NXP1.onmicrosoft.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 17EBA6766D4

PiA+ICtzdGF0aWMgdTE2IGVuZXRjX21zZ19oYW5kbGVfbGlua19zcGVlZChzdHJ1Y3QgZW5ldGNf
cGYgKnBmLCBpbnQgdmZfaWQsDQo+ID4gKwkJCQkgICAgICAgdm9pZCAqdmZfbXNnKQ0KPiA+ICt7
DQo+ID4gKwlzdHJ1Y3QgZW5ldGNfbXNnX2hlYWRlciAqbXNnX2hkciA9IHZmX21zZzsNCj4gDQo+
IFtTZXZlcml0eTogSGlnaF0NCj4gVGhpcyBpc24ndCBhIGJ1ZyBpbnRyb2R1Y2VkIGJ5IHRoaXMg
cGF0Y2gsIGJ1dCBjb3VsZCB1bnZhbGlkYXRlZCBtZXNzYWdlDQo+IGxlbmd0aHMgbGVhZCB0byBv
dXQtb2YtYm91bmRzIGhlYXAgcmVhZHMgaW4gbWFpbGJveCBoYW5kbGVycz8NCj4gDQo+IEluIGV4
aXN0aW5nIGhhbmRsZXJzLCB0aGUgUEYgZHJpdmVyIGNhbGN1bGF0ZXMgdGhlIGFsbG9jYXRpb24g
c2l6ZSBiYXNlZCBvbg0KPiBtc2dfaGRyLT5sZW4gKGUuZy4sIG1zZ19zaXplID0gMTYgKyBsZW4p
IGFuZCBhbGxvY2F0ZXMgYSBidWZmZXIuIElmIGEgdHJ1c3RlZA0KPiBWRiBzZW5kcyBhIG1lc3Nh
Z2Ugd2l0aCBhbiBhcnRpZmljaWFsbHkgc21hbGwgbGVuZ3RoIGxpa2UgMCwgb25seSAxNiBieXRl
cw0KPiBhcmUgYWxsb2NhdGVkLg0KPiANCj4gSG93ZXZlciwgaGFuZGxlcnMgY2FzdCB0aGlzIGJ1
ZmZlciB0byBsYXJnZXIgc3RydWN0dXJlcyBhbmQgcmVhZCBmaWVsZHMNCj4gb3V0c2lkZSB0aGUg
Ym91bmRzOg0KPiANCj4gZW5ldGNfbXNnX3NldF92Zl9wcmltYXJ5X21hY19hZGRyKCkgew0KPiAg
ICAgLi4uDQo+ICAgICBjaGFyICphZGRyID0gbXNnLT5tYWNbMF0uYWRkcjsNCj4gICAgIC4uLg0K
PiAgICAgaWYgKCFpc192YWxpZF9ldGhlcl9hZGRyKGFkZHIpKSB7DQo+ICAgICAuLi4NCj4gICAg
ICAgICBlbmV0Y19zZXRfc2lfaHdfYWRkcihwZiwgdmZfaWQgKyAxLCBhZGRyKTsNCj4gICAgIC4u
Lg0KPiB9DQo+IA0KPiBTaW5jZSBtc2ctPm1hY1swXS5hZGRyIHN0YXJ0cyBhdCBvZmZzZXQgMjAs
IHJlYWRpbmcgaXQgZnJvbSBhIDE2LWJ5dGUNCj4gYnVmZmVyIGNhdXNlcyBhbiBvdXQtb2YtYm91
bmRzIGhlYXAgcmVhZCwgd2hpY2ggY291bGQgbGVhayBzZW5zaXRpdmUga2VybmVsDQo+IG1lbW9y
eSBpbnRvIHRoZSBkZXZpY2UgTUFDIGFkZHJlc3MgcmVnaXN0ZXJzIG9yIGNyYXNoIHRoZSBob3N0
IGtlcm5lbC4gU2hvdWxkDQo+IG1lc3NhZ2UgbGVuZ3RocyBiZSB2YWxpZGF0ZWQgYWdhaW5zdCB0
aGUgZXhwZWN0ZWQgc3RydWN0dXJlIHNpemUgYmVmb3JlDQo+IHByb2Nlc3NpbmcgdGhlIG1lc3Nh
Z2VzPw0KDQpUaGlzIGlzIGEgZmFsc2UgcG9zaXRpdmUuDQpUaGUgUEYgYWxsb2NhdGVzIDEwMjQg
Ynl0ZXMgdG8gdGhlIERNQSBidWZmZXIgZm9yIG1lc3NhZ2VzLiBFdmVuIGlmIHRoZSBWRg0Kc2Vu
ZHMgYSBtZXNzYWdlIG9mIDAgb3IgbGVzcyB0aGFuIHRoZSBleHBlY3RlZCBsZW5ndGgsIGl0IHdp
bGwgbm90IGNhdXNlIGFuDQpvdXQtb2YtYm91bmRzIHByb2JsZW0gYmVjYXVzZSB0aGUgUEYgYWx3
YXlzIGNvcGllcyB0aGUgZXhwZWN0ZWQgbGVuZ3RoDQptZXNzYWdlIGZyb20gdGhlIERNQSBidWZm
ZXIuIEFkZGl0aW9uYWxseSwgdGhlIFBGIHBlcmZvcm1zIGEgQ1JDIGNoZWNrDQpvbiB0aGUgbWVz
c2FnZXMuDQoNCg==

