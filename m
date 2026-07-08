Return-Path: <netdev+bounces-305786-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dPjeM/c8TmoEJgIAu9opvQ
	(envelope-from <netdev+bounces-305786-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 14:05:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FD317261F4
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 14:05:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b="KQupjZ7/";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305786-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305786-lists+netdev=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B5ECD3004C60
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 12:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB3A73ACA5E;
	Wed,  8 Jul 2026 12:01:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011033.outbound.protection.outlook.com [52.101.65.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6478E24BBFD
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 12:01:15 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783512076; cv=fail; b=jpvh2xAll0OEPbjVpUgd/QoS+igjD3mMGaSputhV/Tu4sFtpilFd+2JoMT+KB8XX5n9a7l8kr8ssHjLiZl5V53Nj6dz7lKKsXQnygj0eYx4LDNz04lJEoiQUp//Iec/73HkMespm61kv8vEnLdcBg1uLtHKhcbB9KgA5YYWFHR4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783512076; c=relaxed/simple;
	bh=+N5rC73xxvGeqdkQ/F+SqOWp3omFfGcjQrB2TRB6wTE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ulJTjCjy50J5Rr5pmv1wh+0w+6TkmL71yTaM3MTm/FU9z/tD+LZZ92dV9L+1MBCg24pTbvYUCgE5Q5c2eH69VJeKUJ8hcfG6fkiGjWfYPoBYsGrIJn9gailPbmfanQEqzd0Mq3Y1wXWWfgwVA4xumA1Xsmw+0/L556OPCtc1oAQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=KQupjZ7/; arc=fail smtp.client-ip=52.101.65.33
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MrExumqk5fhkte5RBSAMtJ3a+GGoXQ8JibEfIT94s8EDnX11lP46U5P9TcXYrH8SZRny0bBAhgt/Yu0H4tBBVpvUH5a8aR7u3l/0JJOK+RGT4NVifaV6GX8FsX0qGgbZVF8Y9pg/bGndq+w3duZlEJhkW3n/gV/LfB5/6ZreAqhJD5qm6SMxDkKLWsAd1s5DXI5/yOimVYx8u/OdtTCb/un+Xv6nH+SKyM2oHg+r0dCy0T8+lcfbd9ks3dl+w/LPuRyqMUDmH/By0rwjcnNOigrzu+7Sa+8NXwl+qZVBHd4B6F+1r9V0bQ3wQTO+ptpAYT8zm0QW6IMhdhM3Es1SOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+N5rC73xxvGeqdkQ/F+SqOWp3omFfGcjQrB2TRB6wTE=;
 b=L0ZGvMPCPZbhTAj7q485WnZADhhn3tb3hgvWbeO4ajQTeOblKtFsHcWvbIP+M2f9Z68if9W/KH6lr4iSrIrWv2FKTZAxnIf9R+G+7gY5bAa+fHnzHviSYrXMOrWbA8m9INUybufn9l4aTOv0Pcr/1S66qPp10tjL1brytPePW80hHX0pBzrVcHBapIi9f5CsMHA7vPpXIN7G4vi7KilA4ctaOZwbEP4lnFVnD4ELewrr8Nc7dBjV6p2OrLpW/8A2ttw1KVVWGN6G9lxjGk+QJTZYNsfqbjnHZeRcOL9GafQXNO+Ju5wbPkTv/lhgIRNzZFFaQSKCy5w/ShWQX5+9+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+N5rC73xxvGeqdkQ/F+SqOWp3omFfGcjQrB2TRB6wTE=;
 b=KQupjZ7/yqS16xd2hw/UUnRkqzPR/sGrgZDDhZ4novKtx0LB1QHYFGYB9UHmAbnhCRj59xUZipKXaqkESNrG+83rmfPrKihF1tDKPLOFWl0pp0fEj8Oy8Kq8ZhwjTi2oT92S4P0NlWqcCnCyYuvSHGi/ls3xmfevWvxgzSDIB0y4PmGHcQJBt8RoLmLJx0iV1cco+2n9UtyUX9QwhnbVIXjXv44MesRqT+MKphem6weXMPLfBw0c9c888ucifObyrI1I46Fs3j3F1bFxpuQOpEuyeY86RcSJrTIV3po5itJbvmSUzF9TVu5o5d/1+V7iiIgtTYJaxgjDNg0Q4IgGAg==
Received: from GV2PR04MB11739.eurprd04.prod.outlook.com
 (2603:10a6:150:2fc::18) by AM8PR04MB7300.eurprd04.prod.outlook.com
 (2603:10a6:20b:1c7::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.14; Wed, 8 Jul
 2026 12:01:11 +0000
Received: from GV2PR04MB11739.eurprd04.prod.outlook.com
 ([fe80::71c2:937b:d466:174a]) by GV2PR04MB11739.eurprd04.prod.outlook.com
 ([fe80::71c2:937b:d466:174a%6]) with mapi id 15.21.0181.008; Wed, 8 Jul 2026
 12:01:11 +0000
From: "Wei Fang (OSS)" <wei.fang@oss.nxp.com>
To: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>
CC: "imx@lists.linux.dev" <imx@lists.linux.dev>, "Frank.Li@kernel.org"
	<Frank.Li@kernel.org>, network dev <netdev@vger.kernel.org>
Subject: RE: [PATCH v4 net-next 12/14] net: enetc: remove redundant num_vsi
 field from enetc_port_caps
Thread-Topic: [PATCH v4 net-next 12/14] net: enetc: remove redundant num_vsi
 field from enetc_port_caps
Thread-Index: AQHdDe1U47P7Jwzd3EG/9+yHyVlwdbZjUT4AgAA10FA=
Date: Wed, 8 Jul 2026 12:01:11 +0000
Message-ID:
 <GV2PR04MB1173960329D56B00CF9CF2AF988FF2@GV2PR04MB11739.eurprd04.prod.outlook.com>
References: <20260707081834.710730-1-wei.fang@oss.nxp.com>
 <20260707081834.710730-13-wei.fang@oss.nxp.com>
 <20260708084830.90E5E1F00A3D@smtp.kernel.org>
In-Reply-To: <20260708084830.90E5E1F00A3D@smtp.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR04MB11739:EE_|AM8PR04MB7300:EE_
x-ms-office365-filtering-correlation-id: 1e55f52c-1c9a-4539-feea-08dedce89a33
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|19092799006|38070700021|56012099006|11063799006|4143699003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 PVzu+9tRGWZ6wz62o6e9HiThsUNk2bEAhy+vlxyKkHEwL8UmtKSKiDYZxMMb/W/M6zelTXZTe2mGhIAta+og4+V9aVWhq1CqBR4dMiEk2PaaYpsAv/R1IpYvTVcqE3qdawAwpmb8PK3LI0fxDIegOiMmUla4oGSler+PyxItJQIHPx/KucYKaQ2h80MrdXxXvbw3QXpoMIU8Db/1D0kt91pCVKC7gcS4mpCsW1Rs0tUyrhYYrm8iWjD0IapoXMaw8Idel8t4dw+/Grv+T/jAJUnYZMxPyUaD6Om8V8poYRGFTEvcLkOKcbj4D3Od6mKqzt8k010S1Cuq1h8eHBybFKFoA6ByzeLff9popj9iPiUCIb+btu/ll7rXWJoZuijp2e3jFyinfZ93KdeQig8fRGrsN2dJQ2jg69ZWwPtnfd51gqOxwbYhAzr1MQWvQoVPkKdmTSYzyXHhHHbp77qtN4BCSu02sq1mSdacJfcr8diV5BLM4PN0ETmXuuLd6qJsak4MWngWyL875xsDISp/ykzNU9KPhGuUyo5Bjm3GZNKLEqzTA/ehnnsC7josgM2yMrHU3fYW+ZIYUH8syzGq+AwhctXqfPvdonQKGQvrrSbpoN2AAyj9FeVSdwrpIZUAACpRal4/Xw7t8FXIXAxQCDMYw4t9NqdZtCu+QlwemH0fM0tsj/qLL9Y8M+FK/mmVh8sV4PcEsy1zTv6KcZkHhYWUQNLLtVV6p4z08y/c3CA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11739.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(19092799006)(38070700021)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Z1BhY2RqVWtHOElOTDVSYnBQOFpqSExBVVhQS21QL3RuaTdsVU1oSE1KZUx5?=
 =?utf-8?B?Qkc2TStrbFJBTXhiVVNPYTFpL0tyWjlwZnZNY3RtVndiQ1VrcjFEbHZPMStH?=
 =?utf-8?B?czFxRG4vcjR1QlZ6emRIRnZDSzZIRFdCWElRZmZ0eGU0b3dRZyt1ZjdnVDQ5?=
 =?utf-8?B?ZDRHdFprV2s1VElvUDlhMlZXUjF5SU5SZjdDQWtIaFJGQ2U2ckhtazdxRmY2?=
 =?utf-8?B?dnFSS0dZWkRNQXMreUlLZ3p0REZRckl4cVp0d3FTd291Uk03cFYyWlFsQnV6?=
 =?utf-8?B?b0xMakhOcXJucExWUFV6RjM2bGJtVng5RnlpQXRVRmRvY3IxMGM3Q3RLSDVk?=
 =?utf-8?B?U1J4Qnk5bzc5V2NaWW5NeTRsU3RXTmEyZGhhRnJONjYyTHUvUmN4SFJsc3hr?=
 =?utf-8?B?cWxtZW5VMVQwc1JHdlZ2NXhnUXp2Z3h0eDJ1UVZGeXg4Nm5mQk9Tb1BsdWtv?=
 =?utf-8?B?Z2xGeWlVNHBuVkNEMTV6a3BOS3FYME5iSkFVMzVqVDUvZ082VGdEZjhYVVhj?=
 =?utf-8?B?UHJvYjhrT2cwSzZESUszN2t3bUluSm9WdEdlczlTK2FuMnN0R05rM1c5ZU96?=
 =?utf-8?B?ajg2Kytmc1hJWTMyUFUrakkxdGVjellRS0xVcmZWeGkyVHhDN3dOY0s5bkVF?=
 =?utf-8?B?SzFaY0RMbGtMTzk2MUtKQ1dHSlVIQXMrK2lZdHFNRy9GYURzZ0dsRFJjYitK?=
 =?utf-8?B?aGIrQ0JWczdQRTZYNkNaUWJsZExQdFg0cDZnVFVVRWJnZlJrbTZtWHN5SjZq?=
 =?utf-8?B?SFdWSDFWS0xhZ0ZOS1lrWWhvYTZKeEFTUUgvNzdwS0ZPT2RUc2p0eUVleHd4?=
 =?utf-8?B?YmpuUTRUdFYrYkhtZE0weDZiSTlKeTYwczJNMTZxbVQzNUpzUXRZcHFSUTlK?=
 =?utf-8?B?d1llVEZCcXdmTzBFdVkxUFFrWUhWOG5wVXFabzUyem5kNGhPZk44ZG5aMFpS?=
 =?utf-8?B?aFBTOG8wVU5vbGRZYnNrL0RidnNZRXd1NCt6RWNQeCt1S3Rld2xvUFFqQ0JC?=
 =?utf-8?B?blBxblZabXF1Ry9DZlQwbjAzRlozQWl2SHpaY3RpdndONUMxRFpOZ0Q3MjZh?=
 =?utf-8?B?Z1pKY3Q1QXVPYWRoUE5rZkR3ZU1ab0RVeG5HcVllNDVkSGxzdEJnenppZUdx?=
 =?utf-8?B?VEFXL2xLQzgwREdBdjB0VGNYdFVoUnZodHNzczZ5Z1RJUlJjOVU0Ti92Z2M2?=
 =?utf-8?B?NFBXT2dpSjV2a2IrNSt2cEFNZ01rcTBjUWRYaWxGbWpVVkZ5U0F4c1FZcUM4?=
 =?utf-8?B?VWYyVUF5UFpHWmV6WVorOS9xSHphQy81aTJMNTBtc0U1Z3c2OWxEWGhZbDRZ?=
 =?utf-8?B?Y2E2ajJxOTV2RUdPeXd6QXFuVERPYUw5Ym1xdllZMUhkUVJrbGtwSEt3eTIz?=
 =?utf-8?B?bHdMdXVKYzhTYXVrRTdnSmJWenBWVXFYcStoRWI1UnBXYlRUS2ZTcFJtR1hy?=
 =?utf-8?B?VWdNTnRidURvbmNFNGNlSTZCd2xNMllaWml2ZDMxWHAzbHgvSjRUNCtUcStY?=
 =?utf-8?B?L1h2VmZnNGtZcnlDd0dPYVFUR2NhUzNNRXVrVlROSVBCY2tOZ1h5ZWNhQUNP?=
 =?utf-8?B?SE1zQ2g5aGFSVWlKb3hJY0VWV1NiKzF2WkZoekJuaTE1dDBvbm9tbG9jK3h3?=
 =?utf-8?B?ejhSbDNwOUtNc244dUFTajB3NHg4bmpualFLTXpOY2YvNGh3OVY5dmh3MGJQ?=
 =?utf-8?B?VmRjL1FZbTAxVWVxRkpqZks2SmdkbnRwNk8weWY0bGREZEV3dk1CazNWUms2?=
 =?utf-8?B?dnFhS3hRSkU5U2ZmUTlXM1JQZldYeDNKZHdNUWJFai9TeHpIZ0lQRlZISlgx?=
 =?utf-8?B?bElwWW9CamJCaElXRWRlMUVLcjJWQXhoaXV2WHIyQXZiOStYNGhvdmVpczMv?=
 =?utf-8?B?WmFDand6aDRZcVo3Tk1ER2srZzhza0t1ZTlDMmNIZ201aUlvaEpoUUFjbmk1?=
 =?utf-8?B?alR3R09pSFJHWmlhNnJlcUFUUVNsL0hucllKOTlmMkhocFJQTmVlSHpVUHNJ?=
 =?utf-8?B?V081S1Iyb0wxUWQrN09lWW1DNWZmNytyZXRReWI4d21pZlplUW5NbVhKMExG?=
 =?utf-8?B?Y1ZtYXYxMUlXOUgxakYxVEFGR0cyOHlpQ3djSGlGY2dFT1lCSUlYMHJxTEJa?=
 =?utf-8?B?THorbHhoT215d3lKOEYvWThOUzlrdjZvdkRoT0pmd2ZHNmdrVVhEb2g3TlVx?=
 =?utf-8?B?c1NBWW9aYWlIUUJlTHRvQTA0WnhnUnlvc2QrV1d3REkrOElDM3NnOEszbXZO?=
 =?utf-8?B?czlpVlEwUUVEcFg5dmNqQ3FMQXlBNFFUT0dFZ3IrUHR1RFhBK0V1MnZaeXlx?=
 =?utf-8?Q?A0puPM09nTxSoxXRP5?=
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
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11739.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e55f52c-1c9a-4539-feea-08dedce89a33
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2026 12:01:11.0602
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R73J36mNklYOZh4BOZbwExtap8hfL5myxyogEytK95k3ii5eIH57HPZ4msiHsYlmMQXK5xKuIhMFgueRSMXIuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7300
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.54 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
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
	TAGGED_FROM(0.00)[bounces-305786-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,GV2PR04MB11739.eurprd04.prod.outlook.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9FD317261F4

PiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9mcmVlc2NhbGUvZW5ldGMvZW5l
dGM0X3BmLmMNCj4gYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9mcmVlc2NhbGUvZW5ldGMvZW5ldGM0
X3BmLmMNCj4gPiBpbmRleCBjYWI3OWY4MWQ2ZmUwLi5mY2ZiYWJiMjlkMjJlIDEwMDY0NA0KPiA+
IC0tLSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVzY2FsZS9lbmV0Yy9lbmV0YzRfcGYuYw0K
PiA+ICsrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVzY2FsZS9lbmV0Yy9lbmV0YzRfcGYu
Yw0KPiBbIC4uLiBdDQo+ID4gQEAgLTI1NSwzNCArMjU0LDM1IEBAIHN0YXRpYyB2b2lkIGVuZXRj
NF9kZWZhdWx0X3JpbmdzX2FsbG9jYXRpb24oc3RydWN0DQo+IGVuZXRjX3BmICpwZikNCj4gPiAg
ew0KPiA+ICAJc3RydWN0IGVuZXRjX2h3ICpodyA9ICZwZi0+c2ktPmh3Ow0KPiA+ICAJdTMyIG51
bV9yeF9iZHIsIG51bV90eF9iZHIsIHZhbDsNCj4gPiArCWludCBudW1fdmZzID0gcGYtPnRvdGFs
X3ZmczsNCj4gPiAgCXUzMiB2Zl90eF9iZHIsIHZmX3J4X2JkcjsNCj4gPiAgCWludCBpLCByeF9y
ZW0sIHR4X3JlbTsNCj4gPg0KPiA+IC0JaWYgKHBmLT5jYXBzLm51bV9yeF9iZHIgPCBFTkVUQ19T
SV9NQVhfUklOR19OVU0gKw0KPiBwZi0+Y2Fwcy5udW1fdnNpKQ0KPiA+IC0JCW51bV9yeF9iZHIg
PSBwZi0+Y2Fwcy5udW1fcnhfYmRyIC0gcGYtPmNhcHMubnVtX3ZzaTsNCj4gPiArCWlmIChwZi0+
Y2Fwcy5udW1fcnhfYmRyIDwgRU5FVENfU0lfTUFYX1JJTkdfTlVNICsgbnVtX3ZmcykNCj4gPiAr
CQludW1fcnhfYmRyID0gcGYtPmNhcHMubnVtX3J4X2JkciAtIG51bV92ZnM7DQo+ID4gIAllbHNl
DQo+ID4gIAkJbnVtX3J4X2JkciA9IEVORVRDX1NJX01BWF9SSU5HX05VTTsNCj4gPg0KPiA+IC0J
aWYgKHBmLT5jYXBzLm51bV90eF9iZHIgPCBFTkVUQ19TSV9NQVhfUklOR19OVU0gKw0KPiBwZi0+
Y2Fwcy5udW1fdnNpKQ0KPiA+IC0JCW51bV90eF9iZHIgPSBwZi0+Y2Fwcy5udW1fdHhfYmRyIC0g
cGYtPmNhcHMubnVtX3ZzaTsNCj4gPiArCWlmIChwZi0+Y2Fwcy5udW1fdHhfYmRyIDwgRU5FVENf
U0lfTUFYX1JJTkdfTlVNICsgbnVtX3ZmcykNCj4gPiArCQludW1fdHhfYmRyID0gcGYtPmNhcHMu
bnVtX3R4X2JkciAtIG51bV92ZnM7DQo+ID4gIAllbHNlDQo+ID4gIAkJbnVtX3R4X2JkciA9IEVO
RVRDX1NJX01BWF9SSU5HX05VTTsNCj4gPg0KPiA+ICAJdmFsID0gZW5ldGM0X3BzaWNmZ3IwX3Zh
bF9jb25zdHJ1Y3QoZmFsc2UsIG51bV90eF9iZHIsIG51bV9yeF9iZHIpOw0KPiA+ICAJZW5ldGNf
cG9ydF93cihodywgRU5FVEM0X1BTSUNGR1IwKDApLCB2YWwpOw0KPiA+DQo+ID4gLQlpZiAoIXBm
LT5jYXBzLm51bV92c2kpDQo+ID4gKwlpZiAoIW51bV92ZnMpDQo+ID4gIAkJcmV0dXJuOw0KPiAN
Cj4gW1NldmVyaXR5OiBIaWdoXQ0KPiBJbiBlbmV0YzRfZGVmYXVsdF9yaW5nc19hbGxvY2F0aW9u
KCksIHdoZW4gbnVtX3ZmcyBpcyAwIChzdWNoIGFzIHdoZW4NCj4gQ09ORklHX1BDSV9JT1YgaXMg
ZGlzYWJsZWQpLCB0aGlzIHJldHVybnMgZWFybHkgd2l0aG91dCB6ZXJvaW5nIHRoZSByaW5nDQo+
IGFsbG9jYXRpb25zIGluIHRoZSBWU0lzJyBQU0lDRkdSMCByZWdpc3RlcnMuDQo+IA0KPiBCZWNh
dXNlIG51bV92ZnMgaXMgMCBpbnN0ZWFkIG9mIHRoZSB0cnVlIHBoeXNpY2FsIFZTSSBjb3VudCwg
dGhlIFBGIGlzDQo+IGFsbG9jYXRlZCB0aGUgbWF4aW11bSBwb3NzaWJsZSBoYXJkd2FyZSByaW5n
cy4NCj4gDQo+IElmIHRoZXNlIFZTSSByZWdpc3RlcnMgcmV0YWluIG5vbi16ZXJvIHZhbHVlcyAo
ZS5nLiwgZnJvbSBmaXJtd2FyZSBkZWZhdWx0cw0KPiBvciBhZnRlciBhIHdhcm0gcmVib290KSwg
d29uJ3QgdGhlIHN1bSBvZiBjb25maWd1cmVkIHJpbmdzIGFjcm9zcyB0aGUgUEYgYW5kDQo+IFZT
SXMgc3RyaWN0bHkgZXhjZWVkIHRoZSBwaHlzaWNhbCBoYXJkd2FyZSBjYXBhY2l0eT8NCj4gDQo+
IENvdWxkIHRoaXMgbGVhZCB0byBtZW1vcnkgY29ycnVwdGlvbiB3aXRoaW4gdGhlIEVORVRDIGRl
dmljZSdzIGludGVybmFsDQo+IFNSQU0gb3IgY2F1c2UgRE1BIGlzc3VlcyBkdWUgdG8gb3Zlcmxh
cHBpbmcgQkQgcmluZyBzdHJ1Y3R1cmVzPw0KDQpUaGUgUEYgcGVyZm9ybXMgUENJZSBGTFIgd2hl
biB0aGUgZHJpdmVyIHByb2JlcywgaXQgd2lsbCByZXNldCBhbGwgdGhlIHJlZ2lzdGVycy4NClRo
ZSBkZWZhdWx0IHZhbHVlcyBvZiBWU0lzJyBQU0lDRkdSMCByZWdpc3RlcnMgYXJlIDAuDQoNCg==

