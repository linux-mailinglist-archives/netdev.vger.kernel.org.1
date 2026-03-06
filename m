Return-Path: <netdev+bounces-264835-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WPD7Lp3sqmlxYwEAu9opvQ
	(envelope-from <netdev+bounces-264835-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 16:02:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DAE7223563
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 16:02:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B6B333015DB6
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 15:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B38483A4513;
	Fri,  6 Mar 2026 15:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="l8Ek/R1M"
X-Original-To: netdev@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010002.outbound.protection.outlook.com [40.93.198.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE6234CFAC
	for <netdev@vger.kernel.org>; Fri,  6 Mar 2026 15:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772809369; cv=fail; b=lgeGff87VJi00sXIedoZAQNJBC1yVPNLyC16sHvuE1q4u91ytS+f2rdClXN/9s+l7ohes2czM9KUbZ333i3byxYQNOOFmLmZ/NisNPkVbmoq9VSJdhfOVx9iqM5b7SjRvC3RlxMHCVxhVvQHpJzFEU1yMVgWDURM5o9a5Y4auNs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772809369; c=relaxed/simple;
	bh=UCYk5KFfDoLf5Zan3a3OVKH7cdcXHPHi6syeGjPj8AA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=W7lrFeevgRzSJYcEJqgk1CEBDecGKZ3sd97dUikcw+1nDaYZqBSNjGy7mq36jYVGpCGME621XI2ZZL5AJ0lZkSFLqPFqo+j13X8YCli7846Nwjpyu/jGCRCd1KmFAwq/LgVR9O40otDqR/Q3A50wOikMgPEEh230kk6Ez+ccO94=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=l8Ek/R1M; arc=fail smtp.client-ip=40.93.198.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bOx97gq4CHZUpLjwC3FR2dZlRcJeJyQ52GQoG+KVpu9pthkmUstUSUjv3g7gvA5Ab+5imNYgMhZjXQJ3bUOHMdhCfAbPspIBETXICAPx7+M04ejEaJDs84LxKoNLt2Tz2dcOvQY7/6ZcbP+mrHW1vHl9F+zdxVASv1pzb6EbEiFtUwQr+bJF9gwVXGPXLmHI6TfrwfO3K60e0KtRDSncqqcpP+HSuUHR41/fumbnTCzqS3G0SQT2vVs8pod/eNT4QmPdoLzfPST/tDb/4ZZZjCq0ryoi8xx1j1MqNoDhTkst69ziFqilAGrzrqNtVehISVzf6X8vxFoxlfYCHlT1HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UCYk5KFfDoLf5Zan3a3OVKH7cdcXHPHi6syeGjPj8AA=;
 b=ijHNgKSSATRwHXQpSfhGpfh+TnM08+GKQS+23sqZHZ6Mpkd4EUX66rF6rFmkbox5Mz951ukex64l1YqKnc7XchC0pecRs8tJnfcYB4pZBd4f/A4oZRp+cFOeWiRPmixNlK5xU5VawRAF3yAZTDXoS9zjdoIRbFdZHyF1vM+LIwXK8ydhPgcVMXcaz6LMTa469vcqSUdH93qbCtZK7PET1wiwsvBhtGS0CM1S1Yda1fkq0NoISKevjHPs1jysuYtdA3TAb2Q37xaQ/8XQux79OXPQtSCDg9vKQyALTpNFpttkvywRJvVklRFjwrIYMtGm648ryZOBcqkPvCYL5nIz/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UCYk5KFfDoLf5Zan3a3OVKH7cdcXHPHi6syeGjPj8AA=;
 b=l8Ek/R1M0QazeBch3ZlOhPUv90d4nqY0NUdvwPiQrb93U98PWdK7V6nzRP+PQ9pSr1dSdTldZuoh5c/7KOJcMUeKap1jhkkavw8x72G47CKXTi3IZs3cAVcnIUzKJE7Cy75qKZ2Cc82V8Wkd/fnWy45FXPegO64/A3V/myNu3brVzK/hAak5YG2tQMq1zPb1WfAIVPd690/tBOAs4g1hZX8GXCtPs5YnmOLhgEmhFqKlGoSF58LI8t0fj/sX4qH5yYIyuGgSWtQjmU8QffRZVipDhczsmtRk7OifKiB/AZpdLqRFjvQ0GJVxizKStTvQ+EjnPhSZefGFBuBJNtoqdQ==
Received: from DS5PPF266051432.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::648) by IA1PR12MB7685.namprd12.prod.outlook.com
 (2603:10b6:208:423::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.5; Fri, 6 Mar
 2026 15:02:44 +0000
Received: from DS5PPF266051432.namprd12.prod.outlook.com
 ([fe80::40ba:2995:ae48:aaeb]) by DS5PPF266051432.namprd12.prod.outlook.com
 ([fe80::40ba:2995:ae48:aaeb%4]) with mapi id 15.20.9678.016; Fri, 6 Mar 2026
 15:02:44 +0000
From: Cosmin Ratiu <cratiu@nvidia.com>
To: "kuba@kernel.org" <kuba@kernel.org>, "sd@queasysnail.net"
	<sd@queasysnail.net>
CC: Dragos Tatulea <dtatulea@nvidia.com>, "edumazet@google.com"
	<edumazet@google.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "davem@davemloft.net" <davem@davemloft.net>
Subject: Re: [PATCH net-next v2 3/3] macsec: Support VLAN-filtering lower
 devices
Thread-Topic: [PATCH net-next v2 3/3] macsec: Support VLAN-filtering lower
 devices
Thread-Index: AQHcp8fnS2zJxnxaWEe1c6uYXbfH97WWo68AgAFXE4CACao/gA==
Date: Fri, 6 Mar 2026 15:02:44 +0000
Message-ID: <9a03ed54e1f265ebfea0d51bbd56c158e754152d.camel@nvidia.com>
References: <20260227090227.1552512-1-cratiu@nvidia.com>
	 <20260227090227.1552512-4-cratiu@nvidia.com>
	 <20260227065908.6dda892c@kernel.org> <aaLRB-KAUYbFVPao@krikkit>
In-Reply-To: <aaLRB-KAUYbFVPao@krikkit>
Reply-To: Cosmin Ratiu <cratiu@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS5PPF266051432:EE_|IA1PR12MB7685:EE_
x-ms-office365-filtering-correlation-id: 71090de7-71a2-4188-adfe-08de7b916bd2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info:
 rxeix0u5UzA9LFYEg4xlyu6rw9xTdP144HUlaQvI3phSfv9/3paMl09o2JDzpraPlqA2lfDAb8SHRmIchElyfaoGp9ps9QgLynErRsw+Yiktn4b+tPgSgjPMhkRasjPCBsfkxhsVarOtKPVdhykrGJ1NJCYMJA82Bsqiv/j9oeudni7RXf6tcAuG3zD1q56fX7v6ScelNvNzSXm+nqYywkjXD85ohIpFkVhiC6cl7WDvU9axtwOgcE5A1wjdWwlCgDBaYYFg6nVdtQB0hD2fAqq/eoOIM1gzXMD6W/gy1zWxNGX0eXycxIGW93vdJ6n+H043Vl3l4yuDP2iAl+5IvO1B7ur3I9INm6aFHdC9jIcmT3e4lwTDBeFOFsAoapo7YtQNNrrkFWzAWRP2gqiU4k5dY1yoahvUpSzhXXHlc11PvuN9XduoPlJDri+wG9NTv4Kq4KZUWCSsDtmOmn5q4CKUJ9DO/tPVkgsdsh6yjyBcnJWb/Fxf6rIVjPNlP35PdaZoJrq3NVHjUd0XPa7KR0SqqKjCF43GZ4nd6ejk3IiTqGntYZEs/ZZ9JsU4tNeGOmdLW5cpzbaGEobsaAYxbA8HAKuYw6eQo4bA37hJITCjUTbQtP/1/wNTY316N5uvoutStIaOt1lLcqEYuRtpWRfaSpGYY+oHQh7kbLzQiCiY4EnXZIcBKbcQ2BpMNzwsM2y2Ecml7/+TX1D7LuvKZd/llKjTqiFI6kVaMZwIJLJzjXCNduDF5QsNj1z0PTkodnDx6G7QL1Wa+qVa9+H14KCepkcum8sUqpsfFr60Rp0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS5PPF266051432.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Qm5aeTV3bGJnVUZnK1dwR29KZGJhTmhKa1VUUUtTUGZjeHBJdGFnSzZvR1FW?=
 =?utf-8?B?Q29YOFVvWEpxQy8zY0lHOElOM1dqTE1hTlVLWlkzZy9XWGhiRmxaUUhoU0Z4?=
 =?utf-8?B?VENsZ0pYY1Ewamo2cFkzN1pzZ2NhWXdzV21nRTU2c29aSmtWVzdNd3oyU2w2?=
 =?utf-8?B?SFRVK1hEM2x1bytWMnpIcG9Ib0I3cndnNG5BT3dSUzJzVTRXV3l4M2tLYjN1?=
 =?utf-8?B?YUcxeDVsenNheE1DbllielVUM0VXcU9UVFNDdUpNcDhyS3JJQlV5N2FWSlRa?=
 =?utf-8?B?Ui9OaWZ0NnUxek8xQ2xycnZuMmc4VWhFWlR4Y2hVZjNIbnJqVVorR0FrTmFC?=
 =?utf-8?B?aFJ1UlRNZjJzSE5tblJ0QVk1WDNyeEh2dFptMDdUWXRoN3BZYnNPZU5iODl3?=
 =?utf-8?B?QmZjSk03TFF3QUdqUXVBYm9welRCbFpudmhLem1IVDczdTdVMFhXNlNHNkph?=
 =?utf-8?B?NDNoQ01zblhqc3FlYllmL0NpeGZNWXpOUXR6dGZmQUFQYVFsMmlaRjhvckZr?=
 =?utf-8?B?Z3VEdlczNUIveHJkdHR2a3dsTXlhSEtSeWFTOUVVMVpJWkFxRDBpa2JlZXll?=
 =?utf-8?B?eUdLeXJVeVZVQkVhSzRRTmR2RXE1Q0Mzc3NpMklZUnkxaFRta3V2WTgzWUk3?=
 =?utf-8?B?SU9takU0Y3d2QVFhc1F2ckNaNjRCMm92elZ6c3BWUjlrZ3VCRWlvRXFwZ2JJ?=
 =?utf-8?B?MURmNXNPN2FvT2krSDhTcEhocS9EcHVwSndsaXN1c0JTelFpKzNOY1hZY1Zn?=
 =?utf-8?B?ZUhUeDhpZERxNitlR09OSDFWNVd1K3AxNGVha0hHU1dlQ0ZQV3E3VjNXSVQ1?=
 =?utf-8?B?VEVweFo5STFPNkpwRisvMFBWQlY5R2Y2SEtsZmJnb2theFJ2TjUxR0U0a0FK?=
 =?utf-8?B?d1RJR2ptbU82UjgzWEFQQTIvelFUeFJvWk95TW9CT2RralhlbmNOZ1R4a1gx?=
 =?utf-8?B?eFVGVHI0YVpQK3hjVWFiNW92MSt3NU1wRkMzeXIzbVUzOXBCTmFueWxQQ3FM?=
 =?utf-8?B?YU1HdUhlWU5RYWNsSzJ0MlZ3SlJCRG5tK1NKdTNpejdHYnp6ZFdEU0VyL0tZ?=
 =?utf-8?B?YThDWVZFUW9aTGx2ZU1FUEl2UWNCcXZrSVROSk1pYUlsYWxnMkREUDFEb0F2?=
 =?utf-8?B?c0pGcEpzTlNMbmpJSzBjREU1c05Lak01N0R4T2ExZlk0V3BUNHZYNTltVzNZ?=
 =?utf-8?B?b0s1bEJsU0tURHpPOWEzcEMvZ0dJdkZyL0ExU2UzeXNXM1VrUmIyY0JaNzFL?=
 =?utf-8?B?TEN1cUYxVjREMEUvcTIvRVpOK1Nka3dOR0ZLSm5NeERiZ21mZ1IxenZNSndn?=
 =?utf-8?B?L21OWDBIcXBEZU1kUFR1aHZoeExta25KMzFlR3dOeGZDZVkzYnRUa1ltcXRM?=
 =?utf-8?B?akllQzNDenNTMzRPVlg3NGNMMndpdGt6ZHhXeTJLVHI2YS9aUFpnVkk4aDVv?=
 =?utf-8?B?dmdMNXBpMnlTd0JlVmY5aTBMOW91L2Z3WHAxN0Q1S3Fkd2trM29oTlBGejJl?=
 =?utf-8?B?aUpCRnYzTUtMUllwMEE2MnpQNkVJQXNYOUhWcTY2dFFsTStDWmV6OFdjVCty?=
 =?utf-8?B?WFAwN095aXJ3UTVZWm91a1FaSUowM3NmZzcyczErMzVmZ3hXemw1UksvSndG?=
 =?utf-8?B?cndrSjlOeUQwazRVQmMrZmhNNWZ4OFRTT3gzeE93ZjF4eDFlK0NhSENvR2lq?=
 =?utf-8?B?blBUV0t4c2hFUStGc2NNMGhLU1p3SWl4dVliYjB6dnJ5cEY4SXR1d3N4V2FW?=
 =?utf-8?B?enh1elhGU0JMc2h6OEVlazdObGkxbW8wMExFck54RlF3OXoyWnpHS0c1SDFF?=
 =?utf-8?B?bEpaa2JHZXVyVysrempzTnZQQVh2Mm9hWjNsdjVwL1FSZDFDeTZ6MDlCRzhp?=
 =?utf-8?B?V0F6Nkg0WkdxTmRaRUhzMHJlbGh5amVIUWhZMXBKSGp5RVR3ZWpTNkc1N0Fv?=
 =?utf-8?B?a1RDZXA1RHlSenhJaFhaVGJKdFZCM0N3Zi9pdHZaOUpTZHluZ0dVcXBzZ21S?=
 =?utf-8?B?OCtxU2JaVUlycldBcTdLb2RqeGRUUjFpZy9qdjlHOVNBOGNPZ2IrSXVQcXJy?=
 =?utf-8?B?MGFTTjNBQmlGaGtqaGxGYVBNQ0VweHJxMmFacEdCeGRhbVJXSGk2TkZEMThv?=
 =?utf-8?B?UVE0YjkwY3NkZ1ljL2JNbkszV2E4ejVIcFFRWmZ6ODRGdlNWc0VBRy85SHN5?=
 =?utf-8?B?UVVsaXF0b3JPb1YxVE9TbGE3aVc3alNOU2JmQkpzdThwVDRMeWlWKzBwZHVp?=
 =?utf-8?B?dmxHeVhJekFRQ3VjMXlCSmhWbWZESnV6anppQ3Vsamd3eGNGcnRXN2dRTmdw?=
 =?utf-8?B?Q1Z4MjhTMlYwVzZ6WFE0MEM5ajJ4eTNvNXlyY2JqWEJaY0ZKYTVyUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <067A2A763C358D41AF4207FE7D9E38FD@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS5PPF266051432.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71090de7-71a2-4188-adfe-08de7b916bd2
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2026 15:02:44.2059
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vHRBrq+UhSyrjtXo0U+UsqJVH77s3TikohYvMCI9DhDCdHVRn4t1aXM3IXD3vb0JQ2c9t3Tm2JI8io+Jyobv1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7685
X-Rspamd-Queue-Id: 5DAE7223563
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-264835-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:replyto,nvidia.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[cratiu@nvidia.com];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[cratiu@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Action: no action

T24gU2F0LCAyMDI2LTAyLTI4IGF0IDEyOjI3ICswMTAwLCBTYWJyaW5hIER1YnJvY2Egd3JvdGU6
DQo+IDIwMjYtMDItMjcsIDA2OjU5OjA4IC0wODAwLCBKYWt1YiBLaWNpbnNraSB3cm90ZToNCj4g
PiBPbiBGcmksIDI3IEZlYiAyMDI2IDExOjAyOjI3ICswMjAwIENvc21pbiBSYXRpdSB3cm90ZToN
Cj4gPiA+IFZMQU4tZmlsdGVyaW5nIGlzIGRvbmUgdGhyb3VnaCB0d28gbmV0ZGV2IGZlYXR1cmVz
DQo+ID4gPiAoTkVUSUZfRl9IV19WTEFOX0NUQUdfRklMVEVSIGFuZCBORVRJRl9GX0hXX1ZMQU5f
U1RBR19GSUxURVIpIGFuZA0KPiA+ID4gdHdvDQo+ID4gPiBuZXRkZXYgb3BzIChuZG9fdmxhbl9y
eF9hZGRfdmlkIGFuZCBuZG9fdmxhbl9yeF9raWxsX3ZpZCkuDQo+ID4gPiANCj4gPiA+IEltcGxl
bWVudCB0aGVzZSBhbmQgYWR2ZXJ0aXNlIHRoZSBmZWF0dXJlcyBpZiB0aGUgbG93ZXIgZGV2aWNl
DQo+ID4gPiBzdXBwb3J0cw0KPiA+ID4gdGhlbS4gVGhpcyBhbGxvd3MgcHJvcGVyIFZMQU4gZmls
dGVyaW5nIHRvIHdvcmsgb24gdG9wIG9mIG1hY3NlYw0KPiA+ID4gZGV2aWNlcywgd2hlbiB0aGUg
bG93ZXIgZGV2aWNlIGlzIGNhcGFibGUgb2YgVkxBTiBmaWx0ZXJpbmcuDQo+ID4gPiBBcyBhIGNv
bmNyZXRlIGV4YW1wbGUsIGhhdmluZyB0aGlzIGNoYWluIG9mIGludGVyZmFjZXMgbm93IHdvcmtz
Og0KPiA+ID4gdmxhbl9maWx0ZXJpbmdfY2FwYWJsZV9kZXYoMSkgLT4gbWFjc2VjX2RldigyKSAt
Pg0KPiA+ID4gbWFjc2VjX3ZsYW5fZGV2KDMpDQo+ID4gPiANCj4gPiA+IEJlZm9yZSBjb21taXQg
WzFdIHRoaXMgdXNlZCB0byBhY2NpZGVudGFsbHkgd29yayBiZWNhdXNlIHRoZQ0KPiA+ID4gbWFj
c2VjDQo+IA0KPiBUaGUgZmlyc3Qgc3VibWlzc2lvbiB3YXMgZm9yIG5ldC1uZXh0LCB0aGVuIEph
a3ViIGFza2VkIHRvIG1ha2UgdGhpcw0KPiBhDQo+IGZpeCBmb3IgbmV0Og0KPiBodHRwczovL2xv
cmUua2VybmVsLm9yZy9uZXRkZXYvMjAyNjAxMDYxNzEwMjcuNTdhNzc1N2ZAa2VybmVsLm9yZy8N
Cj4gd2hpY2ggbWFrZXMgc2Vuc2UuDQo+IA0KPiBTbyAidjEiDQo+IGh0dHBzOi8vbG9yZS5rZXJu
ZWwub3JnL25ldGRldi8yMDI2MDEwNzEwNDcyMy4yNzUwNzI1LTEtY3JhdGl1QG52aWRpYS5jb20N
Cj4gd2FzIGZvciBuZXQsIGFuZCB3ZSBkaXNjdXNzZWQgbWFraW5nIGl0IGEgbmV0LW5leHQgcGF0
Y2ggYmVjYXVzZSB0aGUNCj4gY2hhbmdlcyB3ZXJlIGxvb2tpbmcgaW52YXNpdmUuIEJ1dCBpbiB0
aGUgZW5kIGJ5IHVzaW5nDQo+IHZsYW5fe2dldCxkcm9wfV9yeF8qX2ZpbHRlcl9pbmZvIGl0J3Mg
YSBwcmV0dHkgc2ltcGxlIHBhdGNoLCBzbyBJDQo+IHRoaW5rIHRoaXMgc2hvdWxkIHN0aWxsIGJl
IGZvciBuZXQ/DQoNCllvdSdyZSByaWdodC4gSSBlbmRlZCB1cCB0aGlua2luZyB0aGUgY29tcGxl
eGl0eSBpcyBoaWdoZXIgdGhhbiBhdmVyYWdlDQpmb3IgYSBuZXQgZml4LCBidXQgaXQncyBtb3N0
bHkgaW4gdGVzdCBpbmZyYS4gQXBvbG9naWVzIGZvciB0aGUgYmFjay0NCmFuZC1mb3J0aC4NCg0K
PiBbLi4uXQ0KPiA+ID4gQEAgLTI2MTYsNyArMjYxNiwxNyBAQCBzdGF0aWMgaW50IG1hY3NlY191
cGRhdGVfb2ZmbG9hZChzdHJ1Y3QNCj4gPiA+IG5ldF9kZXZpY2UgKmRldiwgZW51bSBtYWNzZWNf
b2ZmbG9hZCBvZmYNCj4gPiA+IMKgCWlmICghb3BzKQ0KPiA+ID4gwqAJCXJldHVybiAtRU9QTk9U
U1VQUDsNCj4gPiA+IA0KPiA+ID4gKwkvKiBSZW1vdmUgVkxBTiBmaWx0ZXJzIHdoZW4gZGlzYWJs
aW5nIG9mZmxvYWQuICovDQo+ID4gPiArCWlmIChvZmZsb2FkID09IE1BQ1NFQ19PRkZMT0FEX09G
Rikgew0KPiA+ID4gKwkJdmxhbl9kcm9wX3J4X2N0YWdfZmlsdGVyX2luZm8oZGV2KTsNCj4gPiA+
ICsJCXZsYW5fZHJvcF9yeF9zdGFnX2ZpbHRlcl9pbmZvKGRldik7DQo+ID4gPiArCX0NCj4gPiA+
IMKgCW1hY3NlYy0+b2ZmbG9hZCA9IG9mZmxvYWQ7DQo+ID4gPiArCS8qIEFkZCBWTEFOIGZpbHRl
cnMgd2hlbiBlbmFibGluZyBvZmZsb2FkLiAqLw0KPiA+ID4gKwlpZiAocHJldl9vZmZsb2FkID09
IE1BQ1NFQ19PRkZMT0FEX09GRikgew0KPiA+ID4gKwkJdmxhbl9nZXRfcnhfY3RhZ19maWx0ZXJf
aW5mbyhkZXYpOw0KPiA+ID4gKwkJdmxhbl9nZXRfcnhfc3RhZ19maWx0ZXJfaW5mbyhkZXYpOw0K
PiA+ID4gKwl9DQo+ID4gPiANCj4gPiA+IMKgCWN0eC5zZWN5ID0gJm1hY3NlYy0+c2VjeTsNCj4g
PiA+IMKgCXJldCA9IG9mZmxvYWQgPT0gTUFDU0VDX09GRkxPQURfT0ZGID8NCj4gPiA+IG1hY3Nl
Y19vZmZsb2FkKG9wcy0+bWRvX2RlbF9zZWN5LCAmY3R4KQ0KPiA+ID4gQEAgLTI2MzMsNiArMjY0
MywxMSBAQCBzdGF0aWMgaW50IG1hY3NlY191cGRhdGVfb2ZmbG9hZChzdHJ1Y3QNCj4gPiA+IG5l
dF9kZXZpY2UgKmRldiwgZW51bSBtYWNzZWNfb2ZmbG9hZCBvZmYNCj4gPiA+IA0KPiA+ID4gwqAJ
aWYgKHJldCkgew0KPiA+ID4gwqAJCW1hY3NlYy0+b2ZmbG9hZCA9IHByZXZfb2ZmbG9hZDsNCj4g
PiA+ICsJCWlmIChvZmZsb2FkID09IE1BQ1NFQ19PRkZMT0FEX09GRiAmJg0KPiA+ID4gcHJldl9v
ZmZsb2FkID09IE1BQ1NFQ19PRkZMT0FEX01BQykgew0KPiA+ID4gKwkJCXZsYW5fZ2V0X3J4X2N0
YWdfZmlsdGVyX2luZm8oZGV2KTsNCj4gPiA+ICsJCQl2bGFuX2dldF9yeF9zdGFnX2ZpbHRlcl9p
bmZvKGRldik7DQo+ID4gPiArCQl9DQo+ID4gPiArDQo+ID4gPiDCoAkJcmV0dXJuIHJldDsNCj4g
PiA+IMKgCX0NCj4gPiANCj4gPiBEb2VzIHRoZSBlcnJvciBwYXRoIHByb3Blcmx5IHJlc3RvcmUg
VkxBTiBmaWx0ZXIgc3RhdGUgd2hlbg0KPiA+IGVuYWJsaW5nIG9mZmxvYWQNCj4gPiBmYWlscz8g
V2hlbiBwcmV2X29mZmxvYWQgaXMgTUFDU0VDX09GRkxPQURfT0ZGIGFuZCB0aGUgY29kZSBjYWxs
cw0KPiA+IHZsYW5fZ2V0X3J4X2N0YWdfZmlsdGVyX2luZm8oZGV2KSBhbmQNCj4gPiB2bGFuX2dl
dF9yeF9zdGFnX2ZpbHRlcl9pbmZvKGRldikgdG8NCj4gPiBwdXNoIFZMQU4gZmlsdGVycyB0byB0
aGUgbG93ZXIgZGV2aWNlLCBidXQgdGhlbiBtYWNzZWNfb2ZmbG9hZCgpDQo+ID4gZmFpbHMgYW5k
DQo+ID4gcmV0dXJucyBhbiBlcnJvcjoNCj4gWy4uLl0NCj4gDQo+IExvb2tzIGxpa2UgaXQuIFNp
bmNlIHRoZSB2bGFuXypfZmlsdGVyX2luZm8gb3BzIGNhbid0IGZhaWwsIGp1c3QgbW92ZQ0KPiB0
aGVtIHVudGlsIGFmdGVyIHdlJ3ZlIGNhbGxlZCBtZG9fKl9zZWN5LCBhbmQgbWFjc2VjX3VwZGF0
ZV9vZmZsb2FkDQo+IGNhbid0IGZhaWwgYW55bW9yZT8NCg0KV2lsbCBkby4NCg0KQ29zbWluLg0K

