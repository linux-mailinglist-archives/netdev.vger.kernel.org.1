Return-Path: <netdev+bounces-279305-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yKkWOx8j4mlX1wAAu9opvQ
	(envelope-from <netdev+bounces-279305-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 14:10:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B49141B1C6
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 14:10:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 694A3305DF39
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 12:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED7C932720D;
	Fri, 17 Apr 2026 12:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="sHt2xyZu"
X-Original-To: netdev@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013000.outbound.protection.outlook.com [40.107.201.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FFFA198A17
	for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 12:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776427515; cv=fail; b=BJzH6VyMllxyfjC5j2dxLAAAykvkas7poUP8rk+XH0wMj9ftnm340M+WJTgD51xFOCn5OvzfUi6ftyDe4t+kWLgtVrTN1/+AsyB9NbWCEhAkAxufAU5/TJh46B4lmnTCg+JmvDR0/T5dytvMUx4O9AzhxBDXKCNTH30fzuNWKMw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776427515; c=relaxed/simple;
	bh=craUQBWFrwNc6OnV5jfzv7xrKZkCnPDGsZVy3IqNqq8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=owNNP3qRTa6atScwiADvCLSnaQZMXCPiDeFNXBJm7sSoNKs0GwLeiLWsG5IRo2SQy4oqGtxO71Nj1IsYZ0IgWSeFiEXrFZXDVnCw9QXTgdK62T9XQmMtnrh2gvFDTJTJGfcF+wEO0HDba5BvbAXowdP184qrClY60NvGsXeKXIA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=sHt2xyZu; arc=fail smtp.client-ip=40.107.201.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e8Be6+81gmQYk0Y1pGLyBA734yqwZZwFbhdf7mkfafRM6hjPn1IlKSxjOygM0ITwXp1VlgbqRY6uwCztpXSs8isNoshWYLurpA8/VQ2nvdpX6hVVd/IADm8ThxiBx9PpugC9eHR2RZyaEeF9nlfofRMUi5pBzINrpeHeawaLHv+OcrXx5xM9/TQ7jKkRe7hNu73O6CCKn5032B/2E8LhXQHvsfANlDdW6uVhIaLuJ8FGjjC6tHcO/M6lYQYdKDv6/flQHQJo7f+/pEWoW+/8N3tGILdQrY8MvNOUPyOAOlc0kHDXMzIDJh90GfHdqpWsWDacTpWY5T2XQIHaD41wLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=craUQBWFrwNc6OnV5jfzv7xrKZkCnPDGsZVy3IqNqq8=;
 b=bF7a5VuQ2+jDGKyd5ptiB92TdHfPZB7y7dIjtwnFUyNxT3Rr/iXUGSISR9ZfuqNupp+zvIroY43j20q2ub0nVSQZLCxG32bngKHweFISFqQWwJsxbPZqkIOjV2vRKRu2M8nkL2HHqA1xYS+dFjBGJn8xWe7mvOokM0tbNYbDrHlwVZefBWye6Yff87wZdSVro2z1+k5yDYTg16tKEOMOGhqXYFvGQE9hDbACZOACQUz5iFKWmFSxXcZd120hgOaYE0cjSpoeKlXIWlwCeXKpuRAnGTckOP9+BiJU/sEiVui9xcq84LXQNL4LcvdprUYkqrATNiuC70OhPU3LzOBVMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=craUQBWFrwNc6OnV5jfzv7xrKZkCnPDGsZVy3IqNqq8=;
 b=sHt2xyZucmXqLiDOu/KuKSK6UOTJ2KU334BJMIrX6e5i0xKZB3w6AY7kyqhzb6r3affqZcoyieMbCLB2tnUVbVrIwCMUKLt/iIn+WAWOjN6mr8AHIF8uqTN+MgZ3REPqtF+YLNK2mbkVF1HZWd/Rl+0VVrCuutMHZSlTh56oBlSK3kw15PfcEki0uQ4bGXtsmdNaxJjmthi3FrQu+sUOYGl98r/fNTX64GA0qudbWqHix3z1FDNVmKKdn4rQnkKF74nvETPQ1DHqf+rhM7wyIefZJ2emRmVFVR0L1draoF3SzqcSPLrfmd7vy0bq7klUSRyKnouvdIn/pDem/9RzQA==
Received: from SA1PR11MB8278.namprd11.prod.outlook.com (2603:10b6:806:25b::19)
 by SN7PR11MB7138.namprd11.prod.outlook.com (2603:10b6:806:2a1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 12:05:12 +0000
Received: from SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::3a83:d243:3600:8ecf]) by SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::3a83:d243:3600:8ecf%4]) with mapi id 15.20.9818.023; Fri, 17 Apr 2026
 12:05:12 +0000
From: <Parthiban.Veerasooran@microchip.com>
To: <wahrenst@gmx.net>
CC: <netdev@vger.kernel.org>
Subject: Re: TODOs in oa_tc6
Thread-Topic: TODOs in oa_tc6
Thread-Index: AQHczDsV8CWFE2AnHEC7I7lkgutaLbXjLGuA
Date: Fri, 17 Apr 2026 12:05:12 +0000
Message-ID: <4b978687-20b0-4bbf-a5d3-3e6cc8f302d4@microchip.com>
References: <74f610a7-d9e1-41eb-ba1a-3d446a232769@gmx.net>
In-Reply-To: <74f610a7-d9e1-41eb-ba1a-3d446a232769@gmx.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB8278:EE_|SN7PR11MB7138:EE_
x-ms-office365-filtering-correlation-id: f8e1b35b-d8a5-49c8-a436-08de9c79941a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info:
 NFn2OsJdGkSXf8aYzHo3jUfgkGQs4bNNW3VjQl6IW2DQv+kSuYQrYCuzdf6QTc+1NzQInz1E9cw75Wb9epul+wmSQB7D8KD8BTzDjPNa3MecA7z1pSeWjXDznSTFWeIgShqDNmRG9zo9JytcPbjvVt80ZF5OZb2Xa8R0fVEYYHB9dxwMxUcvse4xzCksaBTDRFiZPtErfWVwObQyZtFpIL5c/lDYLKyWHyIpFYbT14a3LNSA4mMzmUPu+dONy6e0Bi1NlhTYYoufUPheE8RVD5n8rngTN/Gplacq43iK6CEZQJj3o6xU3vPnImRC2Mi8gKAqUT80ieOr4L7txWdQKiKrPhZT83vlNS0J6S+4Okq96xxxWQn5sn58duPag6nnA0x+P3Dwx119WuDfqUgy5d+bLlabzuO0mgeHQVOVNJuE8sq2HR/aMwZSJ+/+OY6HlWXWvwg/ri7O2Vw/EjhNqp7MKx6KykSf0B6fDfWnSLQqlB9gFvkQm8A7FXeavAwdvQ3fK7tcDwPPztzVFHp7gue+KeJR8yIZxmWrFXiHqEcO6JbO13qHz7OlAgL8EiLjeXekkrtrGGSo15wxpUYJDD3vKL3oimmLhpE01BPolfM75ec7G25C0iaMl96sy+5cvnUokCUAhMKthjssyU+qgXnQDVAv9Z56fzc4zpdbAZ74zjCW95MGhyXjC8hXOTz8e4x7D8p3fy+1p9U8LmrNsBJF+QnbTxIv0z/vCuBUF56GndC+lvLHnpC21TmqDNMhqiYaHOwgl7BYq2lV2WfsgjGBtOrbfGHy9D+aj/oRTpc=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8278.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bXJJQnhDaitsZUNLd0pFUjF4WWtTd2Z4MldEdlRtRk51eU0rSkhnRVpCVlJX?=
 =?utf-8?B?cmhCSWNhamtIUVR2SVZtaHFWSE9ZQld1TEhtZDFSV1VnZzJOYzJuNXhnNEpi?=
 =?utf-8?B?bnNHVmwrVFVUZzUxeHdmNVREUERsR0NwMTgrbUZKdXFCYll1bXdLY21qQTkw?=
 =?utf-8?B?SUZkd1VtMEhUS2l4dnNjaGk1S3o5RmUyNkFwbHpsYTMyZVFmL2FNVC92SzFZ?=
 =?utf-8?B?Y1FKdGx4U21zVktLdVR6ZHRBV3VVQ1JkVG5oRWlCbWtjWCtFMFlIWGRleWlQ?=
 =?utf-8?B?QUVEeEF3OW44VlpzSU1KOElQaENyM2srb0dvYkFJVnZyNVdxYkdCZ1c2aTZz?=
 =?utf-8?B?K0tnYnpleVNORy9KQytCS0I0bU0wQjdiRGZCMFB6VnZWVWxZZXlCdW1ET2JL?=
 =?utf-8?B?TUVNWUhPL1dEdkdMSUZKazFwMTlOWm9FOStFYk5RSFBxdUE4Z2tHQklUampU?=
 =?utf-8?B?NDhteWhmbTJ6VUxUWEt3VktVUVBMQU1SckJJQW4ybVgvM0NNRDF5Qzd0TVpR?=
 =?utf-8?B?MHBNV01vRm4vTFV2ZG9nWUJjSW9oeXNmNm5wV21yeW5NWjBuNjE3U1VOMWdj?=
 =?utf-8?B?NE9CZytIT1RSaFM5STQ0Z210NCs3VEFwT1lRZHNpellIS1Q3VVZQWHJIN3dV?=
 =?utf-8?B?L1YyZ2g3V2pxR3IvUnhFVk1obzNxRkdYRk9LNVB5bVZDYnNpVDlNdkd4SEds?=
 =?utf-8?B?R1YxbUNLZ0ZPR1pOSXNBTHZmN1lGTXJLaEdjYU9LVGMybSs2WWNBNkpnZk9P?=
 =?utf-8?B?a25ONXRmRkZIdG12N0ZkYXRBNEhJMVFXVEFTU2hFM3NqbDJ1bHA4WFlKdURD?=
 =?utf-8?B?bzFURm84V0krdk9CQ2F3SnNzOFlhclFnUFJhaG1FU0VSbis1dEdmbVE5d0M3?=
 =?utf-8?B?bUxFZDlpSEFRZTRjR1BzaTF0aWFlWXMyMTJYSnBCQnZabHlWK0pWVEt6Tk11?=
 =?utf-8?B?a3ZWTFl2VUVyM0JYYTJlTkdiNm0wZ09DWVhsWkloV1J4cUFIOEw4eG5pT2hi?=
 =?utf-8?B?VktCL2Z1S2dJYW9NRXU1RFNNSm9iVE1ubVNaNUJTaXp4TnQwckFLdS8ybzBI?=
 =?utf-8?B?aUJEZEJOL2xUTG5URnhYMzR1b1hJQ1RPbEdTM0VOVVdOYnlOVjErSitic0lD?=
 =?utf-8?B?TXhUTW96Vnlvc3NHb2FWdkpnWXJsVzhhRzJ5TEZqTmdZTHRZZDBoRlRpQ3Jw?=
 =?utf-8?B?ZDRNY3BRUmhhdWxLbnRwdkhOUmlNbXBTc3ZrUDFyZk9TNlR3YVVGaEZCalNM?=
 =?utf-8?B?aVh0RWYrbHhJcFE0ZU9iN1c0U1VYT2Zpdlkxelp0RWFSWUF6dEU0UFIrTkxC?=
 =?utf-8?B?aDVseEtydmlEcmM1aXVRTGxpbEdqckcyUlJGU3BWWFVFZ3ZxUFlGUzhxekhU?=
 =?utf-8?B?aHlzcWgrbUs5MFhLQ0dnaUx3RklLYWY2R3p3Q28wVWxZSlZPOEIrMFR0TlE0?=
 =?utf-8?B?UW1QTGRLelVZVitQWXRLdFhlamgwZ1pnQzRsZlByWUdwL2ZXZ3VPaUsvU2VP?=
 =?utf-8?B?UnM1L0E3aEtRR2VGYUR4NzZBNEtYRU42VDAvTU5wdG4vdzlhUm9ORHFwUk8x?=
 =?utf-8?B?T1lKNkxoK1BQcDloZ2I4VmROcDd0T0VrVExBU3BDT2U4VGNyL3kzUW1RRU9i?=
 =?utf-8?B?RytuNjN3ZEgxRUdVS2xnQnhOTng5Q3ByVmY4bjRWMlBrOWYzeVZvWmN2dGpo?=
 =?utf-8?B?eXgyMHppeGV0WTZlUitWMkxrTWpNd0FUVkxpYU82K2VnbjJpSXcvL0Y1Mkdz?=
 =?utf-8?B?UXNsYjBMdXpDeWwycXZmdUpMbWtDSW9YZlVqbEhTVTUvaElOQy9FdUo0b3VM?=
 =?utf-8?B?dWdiWHgvYWhLVjlMZXpPU3ZUY29UNHZ0TzBDNkpSUEZ5YUpnZ20yNjFyaHRO?=
 =?utf-8?B?VWhXS1pGOUJNOC9TOXFGVk96K0ZwWk95MzNRRXVPVlRmQ1NJRVRuYUlSaWdR?=
 =?utf-8?B?NTlaOUFuRXVaYXNDWXZ2Y2F4THZoVjZNQzk4aDRPSTVlajlRQVZTOEZJVTdC?=
 =?utf-8?B?aGxJd3dPckg5L3ZxL0tzRzZ4MEFScWNlR3Ayb2pkM2IveC8rVHI2NmhxN1JO?=
 =?utf-8?B?S3BMa3EyOTUwbm9rYUlCeHJ5T21KbllVMnVWMFdlUnh2UGI3NjN2ZGcwZUJV?=
 =?utf-8?B?eld6RWMvL1N5TXh4U095Sk90YWtRRGZ4Z0YwcGJEdWxoaHk2Y3AwYlZhdXRk?=
 =?utf-8?B?TGlMQ1dBVXYxYnUwZ2w1cHdVa28zaHVCT09FNm1uR3BTbS9DWS9HYlUyclBB?=
 =?utf-8?B?R1NwdFFsNDh3eW9aNlM0S2xQeGNmaFMxdkdXTzZ2SEhUSlpnM2dXZzU3WWpX?=
 =?utf-8?B?T0ZaU2EyK01kSER0Ny9sQ1ZMc3pTM3lWbEwyb0o4aG5SaElLNm1veTRoOElp?=
 =?utf-8?Q?amzFsrTw2N8T+URE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DB8491E728B8854EAA4A255396A079A9@namprd11.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f8e1b35b-d8a5-49c8-a436-08de9c79941a
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2026 12:05:12.2674
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W+TISC9sAwibk0qulzCFGVJDEObHKUGEIrNLuo6VrnB+8SmsDTJbVFxZ1hk6EkBnHZ7O9tvUVlBXE8tktCR6FYRVIxxtbM8vYWVzbMCe73syslINKf+1Ui6BhGNMerWK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7138
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-279305-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Parthiban.Veerasooran@microchip.com,netdev@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmx.net];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[microchip.com:+];
	FROM_NO_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,microchip.com:dkim,microchip.com:mid]
X-Rspamd-Queue-Id: 2B49141B1C6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

SGkgU3RlZmFuLA0KDQpPbiAxNC8wNC8yNiAxMTo0OCBwbSwgU3RlZmFuIFdhaHJlbiB3cm90ZToN
Cj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRz
IHVubGVzcyB5b3Uga25vdyANCj4gdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gSGVsbG8gUGFy
dGhpYmFuLA0KPiANCj4gdGhhbmsgeW91IGZvciB1cHN0cmVhbWluZyB0aGUgbGFuODY1eCBkcml2
ZXIuDQo+IA0KPiBXaGVuIGRvIHlvdSBwbGFuIHRvIGZpeCB0aGVzZSBvcGVuIFRPRE9zIGluIGV0
aGVybmV0L29hX3RjNj8NCg0KVGhhbmsgeW91IGZvciB5b3VyIHJldmlldyBhbmQgZm9yIHBvaW50
aW5nIHRoaXMgb3V0Lg0KDQpBdCB0aGUgbW9tZW50LCB3ZSB1bmZvcnR1bmF0ZWx5IGRvbuKAmXQg
aGF2ZSBjb25jcmV0ZSBwbGFucyB0byBhZGRyZXNzIHRoZSANClRPRE9zIGluIGV0aGVybmV0L29h
X3RjNiwgYXMgb3VyIHRlYW0gaXMgY3VycmVudGx5IGNvbW1pdHRlZCB0byBvdGhlciANCnByb2pl
Y3RzLiBUaGF0IHNhaWQsIHRoaXMgd29yayBpcyBpbiBteSBiYWNrbG9nLCBhbmQgSSBkbyBpbnRl
bmQgdG8gY29tZSANCmJhY2sgdG8gaXQgd2hlbiBiYW5kd2lkdGggYWxsb3dzLg0KDQpTb3JyeSBm
b3IgdGhlIGluY29udmVuaWVuY2UsIGFuZCB0aGFuayB5b3UgZm9yIHlvdXIgcGF0aWVuY2UgYW5k
IA0KdW5kZXJzdGFuZGluZy4NCg0KQmVzdCByZWdhcmRzLA0KUGFydGhpYmFuIFYNCj4gDQo+IEJl
c3QgcmVnYXJkcw0KDQo=

