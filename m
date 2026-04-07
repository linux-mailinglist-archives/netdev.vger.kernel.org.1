Return-Path: <netdev+bounces-275911-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id FP7IJ2PI1Gk0xgcAu9opvQ
	(envelope-from <netdev+bounces-275911-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 11:03:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FB0C3ABB4B
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 11:03:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F0094300765F
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 09:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66D5830FC1D;
	Tue,  7 Apr 2026 09:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="xnIxApop"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012046.outbound.protection.outlook.com [52.101.66.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0F026F46F;
	Tue,  7 Apr 2026 09:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775552607; cv=fail; b=eCh/Mx04fq7FyR/dxvPCSBmSJAeb4zXcmlQYSWAk0LhgEdy9i7SayuRFs8eW0E8Y1vzlfbJ4WdRkgYFCysOYJYfsnwh1TbwQ1bfnFe22apiU1aB01NoEU69RfA42z835R9ps6ESPzQhMOdtkcbnyAGP+loGO/MTmDLYY7C7OysI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775552607; c=relaxed/simple;
	bh=ACk91BH1Fb4RH9p8lKOGDWWN9sucPmYCnRhfJ5Q0FFU=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Z+tUSbmntgJuR14Jb47cevSCjz5uoBoxbL4M99/dD2T7n8rnBbSusfi0xbGGctyXZz7OdCoAoe5jmsTnSMPaf394oaok2vywKR5qaTZAc5TppjONCUBepFzHr8d/1ve3i5MSPiUDajfVd0TNwQZrh/dR83EcOobFPy4QmeNlbeY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=xnIxApop; arc=fail smtp.client-ip=52.101.66.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=otSbbJoH8NQ9lDmfGbqKezJTMdvKK/2XU3M9WE11Gysz6tb043rVJezjwuiJswoX9QI/EQo+ukjk0cBCVwBJ5nH6nJ5pEqKvvM+2Q9vJgDO2Z+rZo/Pkr6nhgE8jpfHJpxMbojy9vxtReRnMCRFDZdwJyO3A6OqqyA6e5DhfpN3REIVDORY2n2FcZvJTrXOUYuHDXO8rIA6JQWGFDwTslnnI/eGBFgYwkU6tQkMoiMX8ZuQv55h9/v595K4UAOun1WbTi5Gy3jtFp2b5MaEyj4bHvputH2vdPqZp3rmv8UxBc5KUXHRi+YcCFmE5KzQ5OEBECDSro0KR+N35/KB9Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ACk91BH1Fb4RH9p8lKOGDWWN9sucPmYCnRhfJ5Q0FFU=;
 b=n+nAysWRXzm7MnivBiFKTbUGYiKLUEBD54xOsOgdmIAcLmoS94inIW9frzzRxr78f8BtR8yWQ3esG5htx8nr64akdX2tMbQIHk9db9EIvPNsQYvVz15qLOf7ChDHDfuttHCP48ZyqipzDrntqj/q+zEfklRYhJWFwMotGH0FZd4W6+kKPgbMq4aLc5bD1Wc1ITrHsNi6Cm4FNqq4c5j680gqQBzaoidST5kQTdq9zwUpU+s3rHDGjzvjji/WLBqupLyxZsxYd9fpXehfQQW2FGp2uiHHKBzRdhYbCjwR9ZhRSc6EimrYk55IPih+n6pIrBNvQwCNpq7Hnwc/YDLlDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ACk91BH1Fb4RH9p8lKOGDWWN9sucPmYCnRhfJ5Q0FFU=;
 b=xnIxApop9DliCIsho9kYQBqQL1YKwYjzvf6roPAbxkixGWGp36O9ZYi4xjzUVz6GWv4cu6O0C/4r9hmCc+v/NCxmjfG5hjxZ0V8JJ1+Y16UYXb7q3uJ1d+z2WzGqSymfjDlbxbwVMFirF2MO2vubj7xfjrWzRVd4UjJ6dS1U9Y3RJFIzPUQS0akOK03wxwrQyIAepw6dyQZUvzzGxv1UAY73Z5h/2TekrBQx+zyYplEdTmj8V68f/e8nJO8kKFc0LTAZmZoWpXTctaHPpI88waGIqgqncvLNGiCnlHmMQEer0yPKt1tD43bQLl42zqw/QFYzei6m8gpbRR5bNeSflQ==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by DU0PR10MB5801.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3a7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Tue, 7 Apr
 2026 09:03:22 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f%6]) with mapi id 15.20.9769.016; Tue, 7 Apr 2026
 09:03:21 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "daniel@makrotopia.org" <daniel@makrotopia.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] selftests: net: bridge_vlan_mcast: wait for h1 before
 querier check
Thread-Topic: [PATCH net] selftests: net: bridge_vlan_mcast: wait for h1
 before querier check
Thread-Index: AQHcxUNPjHfKyMJX+0Wq//pXkxyulbXTUDsA
Date: Tue, 7 Apr 2026 09:03:21 +0000
Message-ID: <f5bdb5485406fe2db0fb39bc89a5c67da1f81a10.camel@siemens.com>
References:
 <c830f130860fd2efae08bfb9e5b25fd028e58ce5.1775424423.git.daniel@makrotopia.org>
In-Reply-To:
 <c830f130860fd2efae08bfb9e5b25fd028e58ce5.1775424423.git.daniel@makrotopia.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.54.3 (3.54.3-2.fc41) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|DU0PR10MB5801:EE_
x-ms-office365-filtering-correlation-id: 2612652c-8635-434f-7211-08de94848485
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|55112099003|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info:
 nvb8H2uniRxlhh97/SDBdsXos2heOfocYHSX6fjciTC+I6aw6SBBsDq38XIUWMQvCX2qDja1OJlwtCI6dso9T82glw/Rr38xxKciGNEVdHBAScwYvgW5lHm+JRqbMoQmLIozI9XFCiShOgDJRj8pJaniOJTlORQzWUytNmstkFS2Ruk5yuCshr4VXb0S1Nru5cyoQhaWEqdSNmwL/RyjycTv2xigQeiNL9YTm7HXurD4vWzsJyYfownvYVcoki2gVmHjt32G7kZjEPxqpvdlINJsSp94ehx5MHnNTNVPB0gzOnLnMOM5BUokuWEram9CPktNPcnNp7fqEP4I+CflnHO30feEo9pSUPxZMzSn2aJ6H1JklFTNXrgkdzbNMlGJn8cumHzgHFKl6zabjFnPZMT+Rh52fLfCcHmbeEsVwvnM5P072TA7PXWoqN3eqn90ac+DfZlVHsuXxKHboFslKvQolByvuyLf0GpO8urPrcJ7tDeRe14aZRsJkBzpsWd1adaWfUmvJjEu9xsyAbfxFKHc7R3xKxcmdZiWcINfnONiv5fRv7IT+g+DthMhJ9xe6pxFcCIRVVd20c8CTVQz0WHUroi7Q+DBU3GitD9rKCQ5TXiAxXnPKaa0lEZotbYdJY/T1VlsjAAxk05vSVW+TUdBm6z6K+gX7LlHk8iVC5BRUN0nQCLUMdwWwostmSzz0q/Y+PisEirhFIyllX83EohB4r69cJA9rNrY4Y/hxpM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(55112099003)(38070700021)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QkRkK0FuZ1cyZ2RQanM1MzhkZVNkTXkvSUw4enBScm5MUnVZVUpybXVEQ0I4?=
 =?utf-8?B?VUJ3dVBxWm1qU0o5bml0TEVpTWNqOWF3cFJ1NGY4RDZzaU11M1NESWNrcEVD?=
 =?utf-8?B?cUVZTms5ZTVqSjBtQmhsQzIyQk81N2ovalN3b0tieXdCMUxPSmpjdmp2TlBM?=
 =?utf-8?B?bzl5UDh0RE43QlZKVk1VT09UWlpTbnhUbHJZanJYaHc4clZwVjVjM1lTZkdm?=
 =?utf-8?B?b25rbnpSSlJkWTAxZVdOSlRwbFMyRUlrNE00ZFpDRU80TlBsd1h6REN6NVh6?=
 =?utf-8?B?YStldXBKZksvWnNZMU1paWlXMzI0cDYwbEpydFBqeDQ2U1dXZXh2S2ZOdXlL?=
 =?utf-8?B?OGpqb2NpWFZ2Y0R2bWdOOTh3VXlHaW1BTDZNSUNLYWFFeGl5MUR1RXpra3ZB?=
 =?utf-8?B?ZDBQczVrWkUwRmFhNWlxc0dTK0FXU0xQcUZyOS9EV2lKOXE4ckR3MGV1L2kx?=
 =?utf-8?B?OElwZUxqRE5QRWMwbzVhTm9lT1JsQjlST0MxdThXc2RYU0RlZTlMNnF5cmRU?=
 =?utf-8?B?NVlPNzRiSklNVWE2bGlKd0p2bnJCaFRqcWRucHJ5NDVnTnMrNXRBQ2hsQVlZ?=
 =?utf-8?B?YzNtN1BHWUROZXdBTmhBZEd3ZjN6VWE5TFcwMHB4WjdTVm40QWttQ1JaMlVl?=
 =?utf-8?B?ZEh1Y0FpNmtjbTBkNkkwZjR0SHBVZnMyenZjeUNCcmdsR2J6NUxaaTIxb0Rq?=
 =?utf-8?B?SXUyZ2pORi9iUVpRa0ZvRWorOHE5bzMvUk9WeXlyS3c0VXhKOGE4Rmw0R1VO?=
 =?utf-8?B?UkNFeC8rVmZ5ZEdZanh6ZytoNzVrZjNFckZCRnZ0VHZNSXNxaHk5SG5xK2s2?=
 =?utf-8?B?dnpkalV2TVlRVU9oeEtnK1ZRckJDRE43MkNVUU9FN3dtNDU4aWpQakxoM3FV?=
 =?utf-8?B?L0V1MFppakY4UEJVWlZZaXVSSk52aDRrZTdxZXFOVVR4VEh3VzdvaGNQNTkx?=
 =?utf-8?B?ZlBkYVRFZ3dlbmlFdTJwbXZoR2hVSUtNS3FGU0pzMi90YlNQb3NicEtab3cx?=
 =?utf-8?B?M1VXaWRTNzgydVE0dk83b0FkKzhjS3RZTGVwZEV0dnVlLzJ2MllpeThjVzZn?=
 =?utf-8?B?NkI2ZGdTRmpDL1RsYWpQWjlVaElCa2xNZU9xN0RFTjlTcmpUSS9oZzV1SW1m?=
 =?utf-8?B?UVd3UjJaY21DSWpVU2tnL1YyckpXUEhuMm8xWlFyQ3lZRVpvemlCd0JLZnJK?=
 =?utf-8?B?YjZTdGRuVDZUZHMvUHpFNWExNlJMS1BIQTllNFk3RWlzcUVjVGpicHVIZGtC?=
 =?utf-8?B?eldHcmhvN1NwNGh4U3FuTm03bCtvVUdUWHczeE1qOFFnaUJHdHBRZzlaeVdR?=
 =?utf-8?B?bk13QnJiZkRicmtURnFyaGZKblhvNnFYSWhuL051S2tOME1BU0wxd1JuMllm?=
 =?utf-8?B?cmVnbUVrc0hwRWV2NjRNWW9hTmg0bzFKbExCcjl0ZENLelBPRFZvWmt5STRE?=
 =?utf-8?B?ZGgrS1FyTnFsaUJxMjVqL1l1dTFwbU1ESHdKc0xqVEQrYlNyeTVzcUVObTBB?=
 =?utf-8?B?a0ZlcUQ2OUU5WnhEcVkyUlBkZ0ZabzE4Nm9tc1FsNnpvc1BNVTNMWUZ2TTF4?=
 =?utf-8?B?U2pjN1RHVi96eDBTems4Q0Z1SWRYTUFrUFdLNGEzY2pMVEh3WWFpZ3MvQXpO?=
 =?utf-8?B?ejV0WTNWSlZYSG8vUEFQOFY5VDFQNldqRnlTOWY3bmduLzV1L1Q5Mmt1TDht?=
 =?utf-8?B?VE9YbXFqRk5KbEx5WlhMb0tCbklBb0VlYzVHS1AvV3NFVlc3RTFsNDdoenBo?=
 =?utf-8?B?Mkh1R0JCSlFQMndHRlQxdGpvT3RFdVI2Vk9wcC82dkRTRTMyZHU2MW90NU1n?=
 =?utf-8?B?b21vY242QUhQVFdSZXRxRE9rTWYwcUpJa2x2T3ZDcDUyWjRmT05XbGU5M2Vk?=
 =?utf-8?B?ZENVdmhNb3N6dlBiOGhVdTlHcGQ4TW9TQzl6Y3VHM3BmYnVzNjB0TDlyZGhP?=
 =?utf-8?B?VUlvaUpqa0NIcWlmK0VtQ01wZW9jSHhwRWFhTzBETnI1djRJNVpnQmJvSlJ2?=
 =?utf-8?B?ek9BUW9pRGV3Qy9uejVFWDNwVU9lUEk5L21xaGU4eEUySjBmUWdnSHFjV1VT?=
 =?utf-8?B?aHptb2FKWThTRUtWaXRnR0t0QTFrbDNlaHVycTl4ajdGcVEwVkdDQWZlUzFB?=
 =?utf-8?B?VkZOeHJ1WlQ5WUJnY2twU2lhWG1RZ3ZvTUpNWmYwNmhOeWkzRjBTZVFTOTFN?=
 =?utf-8?B?UFR1N2JuWkpZdU1YUVpVN1V5Y2hjemJMUjhQTGw3ZG5BOUFYQjFKTlhUOEZL?=
 =?utf-8?B?M0NieVQzYUVEQzh3VzVYMjY3eWRiTmRvb1NxaUkwNEZwYUxmbUdmSkVJUjAr?=
 =?utf-8?B?UTlvb3dEaFg4QlBmbkI2YkNMQnR6aCtpWFBCSWkzQTkvdkpZRy9XTGtFOFpr?=
 =?utf-8?Q?BXxppYIGt9LvjSr8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A195989CD8D47B42A2B004B6BC0A8275@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 2612652c-8635-434f-7211-08de94848485
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2026 09:03:21.2385
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iIUPvd5F/IJJIcmNiw/MCN4/BFVtxp7gZE2b0W/rhVeijq5NlX8v1YLVCcI1f4NJo7mp/iOW20It2TTHBB07/Q+vD57PoarWF2k2flQTVzM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5801
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[siemens.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[siemens.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	DKIM_TRACE(0.00)[siemens.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275911-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexander.sverdlin@siemens.com,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[makrotopia.org:email,siemens.com:dkim,siemens.com:mid,siemens.com:email,siemens.com:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0FB0C3ABB4B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

SGkgRGFuaWVsLA0KDQpPbiBTdW4sIDIwMjYtMDQtMDUgYXQgMjI6MjkgKzAxMDAsIERhbmllbCBH
b2xsZSB3cm90ZToNCj4gVGhlIHF1ZXJpZXItaW50ZXJ2YWwgdGVzdCBhZGRzIGgxIChjdXJyZW50
bHkgYSBzbGF2ZSBvZiB0aGUgVlJGIGNyZWF0ZWQNCj4gYnkgc2ltcGxlX2lmX2luaXQpIHRvIGEg
dGVtcG9yYXJ5IGJyaWRnZSBicjEgYWN0aW5nIGFzIGFuIG91dHNpZGUgSUdNUA0KPiBxdWVyaWVy
LiBUaGUga2VybmVsIFZSRiBkcml2ZXIgKGRyaXZlcnMvbmV0L3ZyZi5jKSBjYWxscyBjeWNsZV9u
ZXRkZXYoKQ0KPiBvbiBldmVyeSBzbGF2ZSBhZGQgYW5kIHJlbW92ZSwgdG9nZ2xpbmcgdGhlIGlu
dGVyZmFjZSBhZG1pbi1kb3duIHRoZW4gdXAuDQo+IFBoeWxpbmsgdGFrZXMgdGhlIFBIWSBkb3du
IGR1cmluZyB0aGUgYWRtaW4tZG93biBoYWxmIG9mIHRoYXQgY3ljbGUuDQo+IFNpbmNlIGgxIGFu
ZCBzd3AxIGFyZSBjYWJsZS1jb25uZWN0ZWQsIHN3cDEgYWxzbyBsb3NlcyBpdHMgbGluayBtYXkg
bmVlZA0KPiBzZXZlcmFsIHNlY29uZHMgdG8gcmUtbmVnb3RpYXRlLg0KPiANCj4gVXNlIHNldHVw
X3dhaXRfZGV2ICRoMSAwIHdoaWNoIHdhaXRzIGZvciBoMSB0byByZXR1cm4gdG8gVVAgc3RhdGUs
IHNvIHRoZQ0KPiB0ZXN0IGNhbiByZWx5IG9uIHRoZSBsaW5rIGJlaW5nIGJhY2sgdXAgYXQgdGhp
cyBwb2ludC4NCj4gDQo+IEZpeGVzOiA0ZDg2MTBlZThiZDc3ICgic2VsZnRlc3RzOiBuZXQ6IGJy
aWRnZTogYWRkIHZsYW4gbWNhc3RfcXVlcmllcl9pbnRlcnZhbCB0ZXN0cyIpDQo+IFNpZ25lZC1v
ZmYtYnk6IERhbmllbCBHb2xsZSA8ZGFuaWVsQG1ha3JvdG9waWEub3JnPg0KDQpSZXZpZXdlZC1i
eTogQWxleGFuZGVyIFN2ZXJkbGluIDxhbGV4YW5kZXIuc3ZlcmRsaW5Ac2llbWVucy5jb20+DQoN
Cj4gLS0tDQo+IMKgdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvbmV0L2ZvcndhcmRpbmcvYnJpZGdl
X3ZsYW5fbWNhc3Quc2ggfCAxICsNCj4gwqAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykN
Cj4gDQo+IGRpZmYgLS1naXQgYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9uZXQvZm9yd2FyZGlu
Zy9icmlkZ2Vfdmxhbl9tY2FzdC5zaCBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL25ldC9mb3J3
YXJkaW5nL2JyaWRnZV92bGFuX21jYXN0LnNoDQo+IGluZGV4IDcyZGZiZWFmNTZiOTIuLmU4MDMx
ZjY4MjAwYWQgMTAwNzU1DQo+IC0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL25ldC9mb3J3
YXJkaW5nL2JyaWRnZV92bGFuX21jYXN0LnNoDQo+ICsrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRl
c3RzL25ldC9mb3J3YXJkaW5nL2JyaWRnZV92bGFuX21jYXN0LnNoDQo+IEBAIC00MTQsNiArNDE0
LDcgQEAgdmxtY19xdWVyaWVyX2ludHZsX3Rlc3QoKQ0KPiDCoAlicmlkZ2UgdmxhbiBhZGQgdmlk
IDEwIGRldiBicjEgc2VsZiBwdmlkIHVudGFnZ2VkDQo+IMKgCWlwIGxpbmsgc2V0IGRldiAkaDEg
bWFzdGVyIGJyMQ0KPiDCoAlpcCBsaW5rIHNldCBkZXYgYnIxIHVwDQo+ICsJc2V0dXBfd2FpdF9k
ZXYgJGgxIDANCj4gwqAJYnJpZGdlIHZsYW4gYWRkIHZpZCAxMCBkZXYgJGgxIG1hc3Rlcg0KPiDC
oAlicmlkZ2UgdmxhbiBnbG9iYWwgc2V0IHZpZCAxMCBkZXYgYnIxIG1jYXN0X3Nub29waW5nIDEg
bWNhc3RfcXVlcmllciAxDQo+IMKgCXNsZWVwIDINCg0KLS0gDQpBbGV4YW5kZXIgU3ZlcmRsaW4N
ClNpZW1lbnMgQUcNCnd3dy5zaWVtZW5zLmNvbQ0K

