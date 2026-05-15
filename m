Return-Path: <netdev+bounces-288381-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cF36BfhbB2oO0QIAu9opvQ
	(envelope-from <netdev+bounces-288381-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 19:46:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F3E555888
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 19:46:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4C38330E5CD6
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 16:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F31C33A9F5;
	Fri, 15 May 2026 16:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b="VagrKD3K"
X-Original-To: netdev@vger.kernel.org
Received: from usb-smtp-delivery-120.mimecast.com (usb-smtp-delivery-120.mimecast.com [170.10.151.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324F9318EDA
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 16:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.151.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778863466; cv=none; b=iT9FF5Fp+0AmsAhm/3GBC/bsbXWdzhRR4c/3wBcLxS4LfYBp1Qa8QnpohuAOKZU5AwwhC7OiPcebcuRQwzozX/zvUBBv5TTX9P2n5kWi8BS+7UgDEYcAyLOMCpBgIQcklVJuNzylEqqTHjVwS2K/57P525uBHXUxFffEQNSgX4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778863466; c=relaxed/simple;
	bh=nTA4w9903T4QV1b2oITcgF93kRRuEVxuKsctIgyhtg8=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=MVPk8E7rNv/cPdkPfiPs52vkepbtKbc3diLalbrtn8vWzeViX677ZAmc1sbplwISUSIGE7IODNnu3P/Z4UOWxoYI3Ods0sxF4oVfySpTX6exVROHL8UmxwRBKRYIjh7cHEtEQBhKSvLoiLevn05f0vKnkZjrL8sWXKwEtJOZi+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com; spf=pass smtp.mailfrom=onsemi.com; dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b=VagrKD3K; arc=none smtp.client-ip=170.10.151.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onsemi.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onsemi.com;
	s=mimecast20250127; t=1778863459;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nTA4w9903T4QV1b2oITcgF93kRRuEVxuKsctIgyhtg8=;
	b=VagrKD3KlMzgX6ONDlfvGiQVYB4SAoQkhyOG1SZMRZGm7fUcy2yuoUR6gDnSa40PxGidsY
	Av5tato5dj1Qq0lrsvYk0HOi2tzPUKQT3r5NHgonL3xkzGGeaA4nquMpG1/VEjXzLZwGXl
	kvwY3Thag0B1uIF/rzxGAEAKAzvENIDEsFqWgpewcJLIQH6QysjcA8NEZcqj6W7xiJ6iaH
	u+dRalVk1PzUV0LRyyQNUshTjZJymLOwYZYSnzADrrlPVV3HRwHqTLkf/itSsRK0oDE+b1
	Busseo+01yGpnbax6KMe2cI2KDW7FpRlmkYAYdcHa9BopPUAi5dAew+zHhWmNA==
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012065.outbound.protection.outlook.com [52.101.53.65]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id usb-mta-59-xoZIy9a5OaWNRsiePGCeeQ-2; Fri,
 15 May 2026 09:44:15 -0700
X-MC-Unique: xoZIy9a5OaWNRsiePGCeeQ-2
X-Mimecast-MFC-AGG-ID: xoZIy9a5OaWNRsiePGCeeQ_1778863451
Received: from CY8PR02MB9249.namprd02.prod.outlook.com (2603:10b6:930:9c::17)
 by SA1PR02MB8349.namprd02.prod.outlook.com (2603:10b6:806:1f6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.19; Fri, 15 May
 2026 16:44:08 +0000
Received: from CY8PR02MB9249.namprd02.prod.outlook.com
 ([fe80::e437:4ba8:6506:4cda]) by CY8PR02MB9249.namprd02.prod.outlook.com
 ([fe80::e437:4ba8:6506:4cda%3]) with mapi id 15.20.9913.009; Fri, 15 May 2026
 16:44:08 +0000
From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	"parthiban.veerasooran@microchip.com" <parthiban.veerasooran@microchip.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net 2/2] dt-bindings: net: updated interrupt type to be
 active low, level triggered
Thread-Topic: [PATCH net 2/2] dt-bindings: net: updated interrupt type to be
 active low, level triggered
Thread-Index: AdzkhZbrD+M8KZwKQJ6/PvOKyavj8wAAIF0AAACm2bA=
Date: Fri, 15 May 2026 16:44:08 +0000
Message-ID: <CY8PR02MB9249EC5981F40410B056D7FE83042@CY8PR02MB9249.namprd02.prod.outlook.com>
References: <CY8PR02MB924916514D414B698DEB9A1883042@CY8PR02MB9249.namprd02.prod.outlook.com>
 <ab821805-49dd-4b55-a77d-0f25e0247bff@kernel.org>
In-Reply-To: <ab821805-49dd-4b55-a77d-0f25e0247bff@kernel.org>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR02MB9249:EE_|SA1PR02MB8349:EE_
x-ms-office365-filtering-correlation-id: 71ae9901-ef1e-415a-3d5a-08deb2a12f38
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700021|921020|4143699003|11063799003|18002099003|56012099003|22082099003
x-microsoft-antispam-message-info: 6L7zrkv8Ao0cg21NLVDxFGxgfWFwHJDO8thThOOUtT2ouG/dfogvpLIEqX4btf9T/Q2TLKdG0pQPnGNVXxjjVWTGNYhBPcIa69H1p3stVO6f+ZQq9U/eix9+bvuAKpBudVPdsJiDITfgIqC/HAN0+SQrxKvSMC/YIDXC01QKxPp02w2XjOSBuTDBB5lylr868/Aq0m5ss/Si5eBBSWAA7y7uaHhFtkCfBQwKatvAcZZjpbsHMgtT/3OwVjEpOu0bXFPJpCwnf8wytjcd57b7iqNzp3lYIx1eHTaTB7jiN8UWlYepAs2/RauwXvZl6UfZUSemu93wQ9xKaNaNNEd9GoUrWawN0l09LVOU3zFj3k1l4JdrXdTA30QZER3zMFuWfcTADBdAf3YV5BnhSqzngKmejjdEYmgP/WAhhDPJ5n3GABVFo8/hXveRM7CpcWIPq0+dIQ3X8ewDJPTrqAvAYUzViAyicQXUo3oY2Sp1v3xtuY2bmmpfZlGTAjLw49skNa4BIusyy73/d5cG+3Tb7brxMYBHzIvolqtZl6XiDr0EVthUnkEN3WGX2PEdKEVxpZdM6ZpoUwnMcY23NY+vsfQ3AwyEG0KKSgVzYFBYl6kJq+UH1V75/v8DnOky86jgdDIUFieF1/GE2pLJczGVkb7ZxWycTWN26ul6BnoQa+NNziD/QriGZUVwfwdwz3/Ysk0lkI0GJTFHyKTBL5HXmkjhiJpy9qg6gOJAJu/ElLdP3RHNkJWoipy9/UCXVfqEYclgegAff/jo88rTpYRR6w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR02MB9249.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700021)(921020)(4143699003)(11063799003)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UENMT1haOVZvRmI1WWVUWS9Ja1A0eVk3RHRtTWEvQnpNT0F1dTdncklPVTRy?=
 =?utf-8?B?NXhrS3dZeVVzbHl2Mys2Q3JpL3Ewa2dXNW1DN0xXeGEzWUM4QzJQSkVNSTNw?=
 =?utf-8?B?anh1VExuaSs5Z1poKzZ3VUFBaUFFakFqYVNCL3lyTzVCSFhBZFdNTmloR2VX?=
 =?utf-8?B?YnBRaDZHNlcvaGtWaVRsNjFoREFMVmpCY1BKRk9LWC9RZ3NTYkNkSUFBTmZ2?=
 =?utf-8?B?YlcrTHZUVGF2R3dMeGxpNWpiQzFpamxyU1pWS0JrcEMxMWp5ZG10cGMrUTdu?=
 =?utf-8?B?WnpHWkViQytFL0VEMjV3RFZkcW5mMFp5Uk1rRVpkbU5jUXp1QWtBRTg2Wi83?=
 =?utf-8?B?d2pxQjZmMUJ2WG9NQS9KamkrSXFmRm9SeEFiY0svVlh4cUFHS21qR0prTGNJ?=
 =?utf-8?B?RG5jU2NFazVUb1Npeks0RUxJbXpoWXpRNFFHQUVxZXcwdG9IMmhlMHV2elBH?=
 =?utf-8?B?ckFaRzloRWhBeWkrSlVqTk1yRUN4WnhlNVZ3MjBJSkFWUlIwR3VuU3F5QTYv?=
 =?utf-8?B?ekxGOTFhQVlVNVZsWGI5RUFzRDYzNDd4Q0t1RmZLNlgvMXJWZzBJWUU1VVhX?=
 =?utf-8?B?NFJHYWZoWkplRDY2clpBYmdIN3BReG00STJxdWROQ3E2SGpXeExZVzFlK2x6?=
 =?utf-8?B?QnJ3TGlxZkx4dVVSUTU3bFFnZmllNm9hdnppOE1lYzBHUTA3N001R3RSNmh4?=
 =?utf-8?B?cTc4bVJJVXgyWFpycEhPdndBU1BhNmJoUHp3WFB4VUNwb0F3ZFFST050bEtz?=
 =?utf-8?B?Y0p4UUJvNE5uZmJoUG9wd0w1czA1T1l6QW9ZdmNJNEVsa2ZBeDlkUVUzOG1q?=
 =?utf-8?B?LzFpOWpmK0hOZ0xsVXFuWHVNOE5MMzN5ZVVlUVlPNlFERWhNdFE5MmF5eVFF?=
 =?utf-8?B?ZjdCbHpOcjhQQTdyUW5kakRkT25US0lxZFVJdGtxSzFpYlhKK0tGa1Z1b2hV?=
 =?utf-8?B?cjZmV3RwZUtuenorQjRMYlhvcFJvZDQwRVl6cjdkaVdKQmhpbnpSOFZuL3Jw?=
 =?utf-8?B?dnlPMXBrMkRSNWRSWUl0UlBldlFBbUpoUVdhSTAra2c5K3FDOW9UNHNqSFNj?=
 =?utf-8?B?UWh1bnh1TjRnbGJ0VWttQTAxcmJEamJ0Y1lnRmxFQnZZQ1pRR0p5amdvc0lB?=
 =?utf-8?B?by9HbE1ZQmJiMU9INkhOeTlNT210THdjN0JOdXFBUXlHY0Mxc2hGcC81WXFV?=
 =?utf-8?B?WlA3VDhBd1BxdS9mbkprTDcwUEErdEE1ejZVSXY2ZnhYMWt3cFk3UDI2YldD?=
 =?utf-8?B?bXIzSUFyczJFc0hOby9ZR0NNb1N4aUZGYksydGtRbkNBUXp3RTVBZ3l6YVd2?=
 =?utf-8?B?eFN1Qjg0TU9XWEpYdTlTNTlrc0FkK0FuL3R4dXIwK081NlZGYlVRYmNQVStu?=
 =?utf-8?B?cUQ5UVF2S2ZZQU5OeHVLTTlKSVI5b095amcxUFNXWXZYcjdXNFBQSjhHQThD?=
 =?utf-8?B?d25iTVJ1bzcwWmRKWk9DZXBLMW9naTZRNm96V0d5UDBqcmxqL1ZxYVJ2VEpx?=
 =?utf-8?B?b08wUTZMWEZDcklTdG8vZTJKS0JoTHNTamRCbTY3azJyV1lBNWdxSmVITHZG?=
 =?utf-8?B?MytwTTRYR05ncE9GY1dMWXcwTHE1VnJUTHNWT1lqNGRJUUl0UHNwVkMyRDJo?=
 =?utf-8?B?SGhnVGQzcGxnSDFkUHZZTzFxcFpWS3NqUFIvVjFoMUVLaXErVHhNUHd0dHNz?=
 =?utf-8?B?SGI1NWIwUDFIL2ZDMU1sUkZTMitjNnFvQVR3dUcvS1U3YTY2NUhmdGVvRURZ?=
 =?utf-8?B?Z1htTWV6WER3VzVRQ2lzRUxUaGJxam8vUGJoWEFPN1o4aXRneUwrMmR1RDcx?=
 =?utf-8?B?TXl1QnpyNW5RUi9KSm1FY2NQVCtnVjRrY1RQdHRwaDZVZzRIRjhURmVpUi92?=
 =?utf-8?B?TU1KbXhXOHBIQThZVzhPajg3dUhwejhHM2cvaXc1czdrSElBakM2VDl2WEJE?=
 =?utf-8?B?Yld1TDE1SlY2ZHlKNmlzcE9CbjMxNFNYbk1XUnpFcWlCd2wzekhjTkpCdTN5?=
 =?utf-8?B?V0JVMHBUVDJSa3pkVk4ybUlDY1N2SGltNWU4L0ltdnMwazFjU09NOEVNZ3Z6?=
 =?utf-8?B?ODdaelllTWhRbW1DaERGRjlXYThmbC9kSnNDa0dpZStGQ2tlc3lTbG1INDh5?=
 =?utf-8?B?MHF6UXVNUm53MVVwT2JXZjZjVjZLWTlzNjkxcHJ2b1duMFNOTkExRTB1Tmdj?=
 =?utf-8?B?UkZOYnpPb0Qyajh0UWV5ZE8wT3lQRXNzQ3NFd0QrSUhLTFByeCtWckpNc2lz?=
 =?utf-8?B?cTE2ZVRmakdJREhPNGk5L205ZXhjeHZHcmlLUTV2T09DWWQ3UmFFL2tpK3Q5?=
 =?utf-8?B?NnVwNjRQcTZHLzc2QThVN2paTEZaWkRKQzNMdCtPckhPS25FYTV5MDBYcms0?=
 =?utf-8?Q?OEa52OBx88qicYT4=3D?=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: xpVDtXLMWmcxjRHr2R0XYmW1vbq5Saz2iGVjQkzskgOoCEcR44IsvPSRJ40lspob2JiLA8si/riC2NxjgL+nJqxlTQ4RfUPDRobFcPFdpEWl0skRJaAaBsmsX8bEi8KhjtpXtaXE6A1bS3yfd//nItvdaDxzXLXsPSVkDqjxZH2FoBNLGvmLKr3653mza+1e/htpHQWNwNZUB3IazgROD0z6+g1iI3TmLQ0L0K70e75ZNOs6Sp9FEe4MXEIk2Rso62bjYdHrU2peavr0Tmxb5veF29XucUImW2ECorkG+YD/TYLaNX5HoIewDL8fmrm8yEoMi1iW8kjVS6BUcY5lbQ==
X-OriginatorOrg: onsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR02MB9249.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71ae9901-ef1e-415a-3d5a-08deb2a12f38
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2026 16:44:08.4409
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04e1674b-7af5-4d13-a082-64fc6e42384c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BRNU07iOlOKNM7+mjCFyozQLf/pIAw1ave9drOiGclcGyGFtbzgXA01tGOqPjYRu4yUYgA/MSM49ZcX71BCC/GBrpzzroP+53KvlxK4q2Bk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR02MB8349
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: TNPFSirNkNH-lXltGzgwGzRB3nQtfXkS3zZx7tMj3tg_1778863451
X-Mimecast-Originator: onsemi.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Rspamd-Queue-Id: A8F3E555888
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[onsemi.com,reject];
	R_DKIM_ALLOW(-0.20)[onsemi.com:s=mimecast20250127];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288381-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Selvamani.Rajagopal@onsemi.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[onsemi.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev,dt];
	NEURAL_HAM(-0.00)[-0.963];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[CY8PR02MB9249.namprd02.prod.outlook.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,onsemi.com:dkim]
X-Rspamd-Action: no action

PiANCj4gDQo+IFRoaXMgTWVzc2FnZSBJcyBGcm9tIGFuIEV4dGVybmFsIFNlbmRlcg0KPiBUaGlz
IG1lc3NhZ2UgY2FtZSBmcm9tIG91dHNpZGUgeW91ciBvcmdhbml6YXRpb24uDQo+IA0KPiBPbiAx
NS8wNS8yMDI2IDE4OjEzLCBTZWx2YW1hbmkgUmFqYWdvcGFsIHdyb3RlOg0KPiA+IEFjY29yZGlu
ZyB0byBPUEVOIEFsbGlhbmNlIDEwQkFTRS1UMXggTUFDUEhZIFNlcmlhbCBJbnRlcmZhY2UgKFRD
NikNCj4gPiBzcGVjaWZpY2F0aW9uLCBpbnRlcnJ1cHQgdHlwZSBpcyBhY3RpdmUgbG93LCBsZXZl
bCB0cmlnZ2VyZWQgaW50ZXJydXB0Lg0KPiA+DQo+ID4gRml4ZXM6IGFjNDliOTUwYmVhOSAoImR0
LWJpbmRpbmdzOiBuZXQ6IGFkZCBNaWNyb2NoaXAncyBMQU44NjVYIDEwQkFTRS1UMVMNCj4gTUFD
UEhZIikNCj4gDQo+IERyb3AsIHRoZXJlIGlzIG5vIGJ1ZyBoZXJlLiBUaGF0IGlzIG9ubHkgYW4g
ZXhhbXBsZS4gT3RoZXJ3aXNlIGV4cGxhaW4NCj4gaG93IGRvZXMgdGhpcyBidWcgYWZmZWN0IGFu
eXRoaW5nLg0KDQpDb3VwbGUgb2YgcmVhc29uczoNCjEpIEFncmVlLiBUaGlzIGlzIGp1c3QgYW4g
ZXhhbXBsZS4gVGhlIHJlYXNvbiBJIGNoYW5nZWQgdGhlIFlBTUwgZmlsZSBpcywgZHVlIHRvIHRo
ZSBjaGFuZ2UgaW4gY29ycmVzcG9uZGluZyB0aGUgc291cmNlIGNvZGUgY2hhbmdlIHBhdGNoIDEv
Mi4gSSB0aG91Z2h0IHRoaXMgZW50cnkgc2hvdWxkIG1hdGNoIHdpdGggd2hhdCBpcyB1c2VkIGlu
IHRoZSBzb3VyY2UgY29kZS4NCjIpIFdlIGhhdmUgb3VyIG93biBUQzYgY29tcGxpYW50IGRyaXZl
ciB0aGF0IGlzIHVuZGVyIHJldmlldyBuZXQtbmV4dCByZXBvIHRoYXQgaXMgZ29pbmcgdG8gaGF2
ZSB0aGVzZSBjaGFuZ2VzLiBXZSB3ZXJlIHRvbGQgdG8gc3VibWl0IHRoZSBmaXhlcyAoc3BlY2lm
aWNhbGx5IHBhdGNoIDEvMikgdG8gdGhlIGV4aXN0aW5nIGNvZGUgaW4gbmV0IHJlcG8sIG5vdCBu
ZXQtbmV4dCByZXBvLg0KDQo+IA0KPiBBbHNvLCBkaWQgeW91IGNvbnNpZGVyIHRoZSBib2FyZCBs
YXlvdXQ/DQoNCkkgYmVsaWV2ZSBzdGFuZGFyZCAoT1BFTiBBbGxpYW5jZSkgY2FsbHMgZm9yIGFj
dGl2ZSBsb3csIGxldmVsIHRyaWdnZXJlZCBpbnRlcnJ1cHQuIFRoYXQgaXMgdGhlIHJlYXNvbiBm
b3IgdGhlc2UgdHdvIHBhdGNoZXMuIA0KQlRXLCBKdXN0IHNhdyBBbmRyZXcncyByZXNwb25zZSBv
biB0aGlzLg0KDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0KDQo=


