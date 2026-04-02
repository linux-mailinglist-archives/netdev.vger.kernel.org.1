Return-Path: <netdev+bounces-274375-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UALsICj8zWlYkAYAu9opvQ
	(envelope-from <netdev+bounces-274375-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 07:18:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 98CDF383F1A
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 07:18:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9761C3009F08
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 05:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 746C330BF4E;
	Thu,  2 Apr 2026 05:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="PHnRTXDJ"
X-Original-To: netdev@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010004.outbound.protection.outlook.com [40.93.198.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD8279DA;
	Thu,  2 Apr 2026 05:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775107095; cv=fail; b=J1klfWnZc381eBTnFdcdME6gjWJJrl34zXNxFgU/P7DDm36RxV4+c9kroCue69w69q12OY78QEts7ipvBMIq6/jjQWR7PUuqO4ZoJd1Hkt0K4qyCDRjsSj0fqigGtU77M0rcGDyknFKeS5I/dn9L3c2g/WFyGRm6UpSTeKlVXLE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775107095; c=relaxed/simple;
	bh=IcZ9jFjP6L9zlF7NlKyYoT5Mw+yHxOSNixL15GVA7Ko=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pOhHXkMDge9uBIidxIisUBjWwaCpB3QwWMkpD2vSgIVPgC4jiNP9zc7NaHN+TpgLnoQEQ2ad5dT2EjmafpuzMvs30d8hW/Eg528ju6vOf+YCHqOTBW51dUQG3fudHCrJUTq2w8UivmOR+1XfzELWJ8tBvPpywyjozuXLVY/iSyA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=PHnRTXDJ; arc=fail smtp.client-ip=40.93.198.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k0hX0I/CbQ0LOvwwVM9rSANvTiUkIAD4HQng7NVWPDuJKGsbA8k++K/x0NR3uiYdtnlsszQ1hERdUI+pWroZ4Fas4VI1Fe3MsFHoiDolKIbrickjyZxGGljW36xrNIniK/tAM8T9Tz/iHxEsscLSHoxYcmF5Bli3wjXE8wl4xj2M/kwWobH8zhuF2WMWo3aOQBlVy3Xjn4UMa62pI079xJ1jx3zl9xrjg+o4slEHhhzQ1xB3Zn7bQUgkbkk1D7ESdN7ndOf2QksjulxAN0x6/48GwNJIxiO0wjQSTZ+SnRv+u6kcnDStcIhOBrIZCfGj58L/SMkAHZmqnQWJXLGYLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IcZ9jFjP6L9zlF7NlKyYoT5Mw+yHxOSNixL15GVA7Ko=;
 b=Uh5HVAZNc+g3MoHP1Snz088tXzY2KfgJtycLxja1EpF4k74rA7neSTVK4D28JNI02kD3l//SZKZW2Zrtjn7Pf6Bavz40YsftPE5BQ1ZoFyS/usAsehYqnkXCK7bak5sd/te/NV+7zgcUnCxhHzpaaLow2gKX68BdGGzlYYf4K62B8rwne+JJ7SD8/poVFBuvbGTIDxNE63vzIkAWax7QXWQARHaoUY/ff81MVEQjA6kTNz5tpWRKO0gz5+KeE0Z37cGsk44Sj0DnXvfDrSjDAV/5RbfHtxbulU6+4UL3wSw2USnhbi1tts2rGRokocrSUWHO2wkXYGNJfmoGIlZDfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IcZ9jFjP6L9zlF7NlKyYoT5Mw+yHxOSNixL15GVA7Ko=;
 b=PHnRTXDJ71sMd+5q+MLV1VsJtqTe4XD28/kt3vDTGsVg4oOtNO9kkDkVVCMUzcniGHpMQ//GHTGS8Tii5XicdVq94exs4gSdkNR38T7UoQjjsw6E3SgC+vEJ5c0CNtaReZhDDcYgpHxe+1hZepJmY3pd5YWIE90tO7xRNsy1CM5QgPUxLb2d0x5U8epXfZEcgfvC24yFy3lFdGzbGzdc8TeJp/+THxIsCFoIThaq+jL+Uoj73bbqU4At9kz/PMfSi/0LJ1v6DJkTpZZ0MDk9kI6QwBHraLIZRXU1s2N+ljKdopnNVpK+SDkkJdSSiHIbu8CZOpJjjyQj6u2qAjBDew==
Received: from SA1PR11MB8278.namprd11.prod.outlook.com (2603:10b6:806:25b::19)
 by PH0PR11MB5142.namprd11.prod.outlook.com (2603:10b6:510:39::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Thu, 2 Apr
 2026 05:18:11 +0000
Received: from SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::3a83:d243:3600:8ecf]) by SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::3a83:d243:3600:8ecf%4]) with mapi id 15.20.9769.014; Thu, 2 Apr 2026
 05:18:10 +0000
From: <Parthiban.Veerasooran@microchip.com>
To: <oneukum@suse.com>
CC: <netdev@vger.kernel.org>, <linux-usb@vger.kernel.org>,
	<piergiorgio.beruto@gmail.com>, <andrew@lunn.ch>, <hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <steve.glendinning@shawell.net>,
	<UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH net-next 3/3] net: usb: smsc95xx: suspend PHY during USB
 suspend
Thread-Topic: [PATCH net-next 3/3] net: usb: smsc95xx: suspend PHY during USB
 suspend
Thread-Index: AQHcwEsZPbqT+3/6KkKOeVqXzFK8F7XHV8sAgAIz64CAAOxwgIAAx3UA
Date: Thu, 2 Apr 2026 05:18:10 +0000
Message-ID: <fa2ec3d8-55ba-4244-aef6-be8bfade972f@microchip.com>
References: <20260330134222.67597-1-parthiban.veerasooran@microchip.com>
 <20260330134222.67597-4-parthiban.veerasooran@microchip.com>
 <1c660862-de30-428d-a772-8bee9b990a59@suse.com>
 <2e9bc390-c870-46a3-b673-c7cdb5187cc3@microchip.com>
 <8fe179bd-417d-4624-9e35-04c75978dfc8@suse.com>
In-Reply-To: <8fe179bd-417d-4624-9e35-04c75978dfc8@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB8278:EE_|PH0PR11MB5142:EE_
x-ms-office365-filtering-correlation-id: 871fa31a-ccdd-439f-8665-08de90773ba0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 eglGbj5yStDn/VO5RJfV7QrNPr7zGmwW8chPeabkSNz1gjVPomtrgwdMo9ghFQ4XtXKxzABwjvPopvgDbdRZtgeXVfrkuUhN3Yq4a4rRCrAwkTs7uMBMZxzcQQ0QgUJtYfaIcjFwsgM3lNj8i/4fDa2h/yITn3EnQkfDvhEz/DbEYdTrKFnxZF0dM8+0otznSVaY91Y08jkWBxWFnxdzwbwKutgss0m5OFmTf441nhkutxgcJCO7ouwgVQaWWuSYhpCntDG2u7MiMW7ASzjvsFuaD0ualnyV5k+7egyvT4/ar+GfEscQBQyCL32TMQ6w6LDG3vLmdjI82zaFUUNkxYm5kI7SjsQ7XgTJQ14D94YlWwyDaxOsFyfBT3fpDc7m41x79Sv81/rhewvVbVTTfWehw2Oc1BfKX64G04iQAM59+sWpbXXJEenFdq+jVDSYyYSU7T5oW6iYMH21rV6FrkrXz33z0Z+T6kKburfoJMh9ApMhUW8+irYG8Wz2Nptkx62fTi3oWxAUeAP4cDfDZMVZBfXk1pYBOCFFbc4SLaRDsrJ/t2sSWwiHYrMsuJEwab2bDMozSX+X7sXqXsWuMcrHS9q5eJK0eF6EDFXQURyUvr7305pE2ys0QuyZZMUOVtlegElyJV+NNNDTQPEa0NKNeG8tKBYq9zY2YcnUQagnkESFHdhKf4pvtJFga2CLUv/H63eexVLHh+AV9X0mDCUOJ0GheiYHRTBAt1M6E+dUupeIFij9BOaiZlCKgHNqDEdMgKDIUUf7oCuMRPY/zhHoqIi5/gkePRIetXQLnWM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8278.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OERFQWpnaWFXS0hVeXBTcGRDODNSUVpUSGpJQ1ZMUmhqcmQ1QzBaUUJmN1Y0?=
 =?utf-8?B?SlhtaTNPdHBDSGNieU8zc285NTBXWTBTZ2tLV3pZVFRDeWMzVC9ORUtwcU5X?=
 =?utf-8?B?NzFsUW1tY1dwNUQ4Nkh3elphd1NZTVA2NzNsanRHS2ZJbEtQbjJodU1DcXpu?=
 =?utf-8?B?emZ5eElvU0l1ZDN1NnZKanZRRGJ5a2NBcjR2YVIrVWF2MFUzUENuZlkveFF6?=
 =?utf-8?B?WWdvQXVsQ3dTeGZubUtDTkxtZFhaY1c2TjM3b2xGT0F0b3ZJUlFQTUZtRFcx?=
 =?utf-8?B?WTRqNHdGK0IvVHZRMTRHdkc4MVZob2NUZ2o3enZ5N0NIRGpENjJZNlZhck1t?=
 =?utf-8?B?RGdqSGg1Wi9vRENicTVET09zRjN1WlJpQXVvR1o0WFdmWXFqYTBjaHJBTUxp?=
 =?utf-8?B?N3FRcUsyYjZEbENJU2JhSUNuQVJPZ08zU1NYUkpLdXVXem5vakZNc0dkV2o2?=
 =?utf-8?B?bmdYaWlGdjU1SVA5dnJqeklkVzYxdmFzR2c1T0ZJL0ViK253WU1wUlhtRXQ0?=
 =?utf-8?B?U2pBSU44ZTNiUGpVWmhER09JRlBJYmZabmlkdDhGb1FEV2Y3NEZpTDQ5MFVJ?=
 =?utf-8?B?aFAxTDdsR29ZUEhBdEtJUzJ4Yi8zOXdtVFo1b0xsRVBtM1RrbDNpc1hhZzV4?=
 =?utf-8?B?UGVYcWVnanZKMmVMUlNPekNQZll4SWhSSlFKY1lPeGlFVlpEWi9WSXQ1aWxI?=
 =?utf-8?B?aENWK21uaU9EMkxLUkd4alU5RGRqeFpFYUJ4QlN5ZDZOMHpucGxta2dZbEFo?=
 =?utf-8?B?Ni85NkRLajRMdE1pM3lpYkQvQUhvSnBJSG9heENrRDJjd1V2ZWI1dHZqMDhE?=
 =?utf-8?B?dGFSVEVmTGtkc3Z1VDBmUGhYUmJ1TVh0V3ZhY1U4aFBwVFdBS2xsdDNETVZw?=
 =?utf-8?B?UklUT2pJSUZMdjlDK3VhUHFMVGcwaUtQRnlqWG9YK0YxMlVlMzJrUmlkOHo0?=
 =?utf-8?B?QlF5STJBaXJpMkpRQlRRRlJKYWhmeTRjNzVwR2FOUWVwazdidXNCWW5lMklW?=
 =?utf-8?B?MFptWU53Z2JmeEl4MlY2Umg4K3A1akwxaGdwUXpRVGQyNFJnU3ZTSC9sTXF5?=
 =?utf-8?B?STBodUxmbUVpN1FnVjVXeFZGSmNoVjhYRHhxYllReHNwcTg2TzRlSEkwWlBp?=
 =?utf-8?B?eEFrc2VpU0J5QjBrODIwQ2tqdUVFRWlpOFovaTQ3UFlNVFNmYnVJc0VGWHJF?=
 =?utf-8?B?dnBSdStieWhVR0trVnNCbWxrM2Ixb00zQmMrV3AvL24yTHJxZUhTaWpUd1hk?=
 =?utf-8?B?L0VldjFRcndtcmxXWnVZeWtSNTBLVWtHU1hVSERPVW1ZZGhidWdSNFNLMXNJ?=
 =?utf-8?B?WllrVExPVXJranA4a1A0MXZ5QWtvcTNSbkFqS2tsRkxQaHVBYmdQS3pxWS9r?=
 =?utf-8?B?eHBDYzhOdSs3NG1KT1RqYVRIcnpBWG90WGFqUVJTSVBmWmc0OFZJZllwektZ?=
 =?utf-8?B?YmdxQis4K0NNVUJ6c2xzeEcwOGEyYWdISXdMak5QaGphbUMxanJVSXcyN2NW?=
 =?utf-8?B?Q2VReHFpdVBVUVNWbmd5VkRmMzZINjVXOFp4WDNtRnFJN2Izb1hiL3pxRjk1?=
 =?utf-8?B?T2ZKSnJ6L1c0NDJsZDg5MklSY1ZrMDRFYUF2SG5veUlmdUFqUW9taytPbWVG?=
 =?utf-8?B?TVNNamw4RWVFUmg4OUZkbjl3RDBvUk54WEIxeU50NC9jdzJXNWc5TVlnUjVR?=
 =?utf-8?B?cDZsdEt4WHpjVlFrM1VWZnNmV0IzdCt2YVE1NGZnb1V3NUhldjkxK1VIMU5y?=
 =?utf-8?B?YTZNbVB4d0QyMGlaelpkZjFxOTcwNVNwazRBeUdwa2F4SjRHOWswdm5USW5W?=
 =?utf-8?B?WXRIaHhMRTNmdi8yL0pOVHFNMHV6WHNhYnV6Mm0vRWw0MjgzUkNnc1d5ZEpy?=
 =?utf-8?B?dS8yaWNUSjV5ckxLQ0ZKbUthRERDRHJyczBud0x4UitmL1N0UlBQeVE3RWhE?=
 =?utf-8?B?ZDJlcnZSTUNHbUZjbmszQzVSYWpXKy93cGJacUxOZFdwd09pNGlGU2JhT1lu?=
 =?utf-8?B?UVJHZFJsbkdrem42TG1COTZ0dmhnS3daaXZMS3Jvc0RUdGwyTjFGZmNGV3hr?=
 =?utf-8?B?RTB0V0xsT3NOVitiZmZnQk03TVlnUU50UHBiZ0xZMDkrVWpYUnNmdE1tZXhi?=
 =?utf-8?B?aFlJV3B0Rm1JNk5CWkhua2FlK0VvUUd4Q0VNR3FndEI2TkViM1NycEFtVVJL?=
 =?utf-8?B?MDY3SUVOeVJxN3FmK2gyZ09nVkhWUkZKdlhxcHFDa3duUmREcVZLKzQ3aW4w?=
 =?utf-8?B?WUNGY3NLQUxZRm43QkRrU2hXZDlKQU4zZjhxWVY3MEdGelpMQnZLMnNERWpv?=
 =?utf-8?B?R3Fjc05kUHh4Mkh6cEgzSXd1cW0vL0V2ZXlheWhtOEZVUWVBOTNMS1dpU0VU?=
 =?utf-8?Q?PI4atpSnLS3S8jlE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6ADEF61A7A54854BA2167AFC2C094923@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 871fa31a-ccdd-439f-8665-08de90773ba0
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2026 05:18:10.8952
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xnv2syMR9GppH7EwORU0aks2Slbnuh4/zO3scUNPnln7t8DmUDnZMyaDOu8vUqfF1scqOL4PuFGXZIzP4YUvhVMOyoNfPl6kBkWmL/+51U37xXMR7j7oWpDKAOJZVizJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5142
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-274375-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,lunn.ch,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,shawell.net,microchip.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Parthiban.Veerasooran@microchip.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[microchip.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 98CDF383F1A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

SGkgT2xpdmVyLA0KDQpPbiAwMS8wNC8yNiAxMDo1NCBwbSwgT2xpdmVyIE5ldWt1bSB3cm90ZToN
Cj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRz
IHVubGVzcyB5b3Uga25vdyANCj4gdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gSGksDQo+IA0K
PiBPbiAwMS4wNC4yNiAwNToxOCwgUGFydGhpYmFuLlZlZXJhc29vcmFuQG1pY3JvY2hpcC5jb20g
d3JvdGU6DQo+IA0KPj4gVGhhbmsgeW91IGZvciBwb2ludGluZyBpdCBvdXQuIEkgYWdyZWUgd2l0
aCB5b3UuIEkgZGlkbuKAmXQgbm90ZSBpdA0KPj4gZWFybGllciBzaW5jZSB0aGUgaXNzdWUgZGlk
IG5vdCBvY2N1ciBkdXJpbmcgbXkgdGVzdGluZy4gSSB3aWxsIG1vdmUgdGhlDQo+PiBwaHlfc3Vz
cGVuZCgpIHRvIHRoZSBhcHByb3ByaWF0ZSBwbGFjZS4NCj4gDQo+IFRoYW5rIHlvdS4NCj4gDQo+
Pj4gQW5kLCBhcyBhIHF1ZXN0aW9uIG9mIHByaW5jaXBsZTogV2h5IGRvIHlvdSBzdXNwZW5kIHRo
ZSBwaHkNCj4+PiBpbiBzdXNwZW5kKCksIGJ1dCB0YWtlIG5vIGFjdGlvbiBpbiByZXN1bWUoKT8N
Cj4+DQo+PiBJbiByZXN1bWUoKSwgSSBkaWQgbm90IGNhbGwgcGh5X3Jlc3VtZSgpIGJlY2F1c2Ug
dGhlIHJlc3VtZSBwYXRoIGFscmVhZHkNCj4+IGludm9rZXMgcGh5X2luaXRfaHcoKSwgd2hpY2gg
aW50ZXJuYWxseSBjYWxscw0KPj4gcGh5ZGV2LT5kcnYtPmNvbmZpZ19pbml0KCkuIFRoaXMgcmVp
bml0aWFsaXplcyBhbmQgcmVjb25maWd1cmVzIHRoZSBQSFkuDQo+IA0KPiBUaGFuayB5b3UgZm9y
IHRoZSBleHBsYW5hdGlvbi4gTWF5IEkgc3VnZ2VzdCB0aGF0IHlvdSBhZGQgYSBjb21tZW50DQo+
IHRvIHRoYXQgZWZmZWN0IHRvIHRoZSBkcml2ZXIgd2l0aCB5b3VyIHBhdGNoPyBUaGlzIG5lZWRz
IHRvIGJlIHBvaW50ZWQNCj4gb3V0LiBZb3VyIGNvZGUgYXMgc3VjaCBpcyBmaW5lLiBJdCBqdXN0
IG5lZWRzIGEgY29tbWVudC4NCg0KVGhhbmsgeW91IGZvciB0aGUgc3VnZ2VzdGlvbi4gSSBhZ3Jl
ZSBhbmQgSSdsbCBhZGQgYW4gZXhwbGFuYXRvcnkgDQpjb21tZW50IGluIHRoZSBkcml2ZXIgYW5k
IHVwZGF0ZSB0aGUgcGF0Y2ggYWNjb3JkaW5nbHkuDQoNCkJlc3QgcmVnYXJkcywNClBhcnRoaWJh
biBWDQo+IA0KPiAgwqDCoMKgwqDCoMKgIFJlZ2FyZHMNCj4gIMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgT2xpdmVyDQo+IA0KPiANCg0K

