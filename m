Return-Path: <netdev+bounces-272599-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qGrvDJmixmnrMQUAu9opvQ
	(envelope-from <netdev+bounces-272599-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 16:30:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DC096346C3B
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 16:30:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2DA763010748
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 15:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 533BF334C3B;
	Fri, 27 Mar 2026 15:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="TBbZrE1u"
X-Original-To: netdev@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013056.outbound.protection.outlook.com [40.107.201.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC6433260B;
	Fri, 27 Mar 2026 15:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774625333; cv=fail; b=TUCuD3Ia4A3kqaR8HPAqWyqMpkEQL3AuqCREQWstm0+VxHcs4nn0MuWv/Tkpzz9YfQf51Vdeze27aZltH8Y3BHmLsS55by3xihBlID5MVOUrsSjJJCMzWgeuBu8udHL4/vgBxyTCIWF3Lq4FruLG+uTjgG0VBfNcATou1rJtDT4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774625333; c=relaxed/simple;
	bh=B9cKZhk56J5p/8aFporitqAVGhVu2ku07GSI86/HRCQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sssZ6B2AaDN+XVwWePyVRbR32lSrMxJdIzz5h8JecIVV/vNpUUrUlJRwFPnqyb593/qixqWc1jp/ITKER6iGj03+9en8in7KLySZZtKBJPbvTb1SWX1a5e3JdL4p2tH+h581C8OCrg/d/xpdTUSzfyNshgr8yqOhbuV6Ucuh1tY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=TBbZrE1u; arc=fail smtp.client-ip=40.107.201.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cvp+YNqWyyS3tigVg3ZLAk7V+kNz+PhowsY7D54VGvQwOEK61boYV95DvOAe38BDfCIunRxcGZd7vP87n4o0Y97h6gRYhaq3uhI4pnMPW8SfwWjj4sQQAPp+VnuwUA85lDkLvw0kx9WlSf+unLws5oSaYs3TvIvuPvvtHZModHjhd7NqpNBO0i6oVKxw07Xl+BccciKvCM7/WLteksW3U1SQQ37l/G8Y50BBYca/mV4E1BUrxoLn5p3/GQNxznzsSrwWgW/R3y4eRNgsbBT0MDfENIBHZuIln+adHORMdzx6hkG+ptGUHldkTH1QqTZQh6bKN8AF9pco18Dj7DremQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wu5VehAT+9vqUyY2CfIoAPJhm3cBA4LwH87hAIaoRqo=;
 b=bsN99+iLOtGlzji/TC+Y3rcWtCaaJdCDxKqYxPpxknvOSl7tA/H3aju9BkxlpDpXrYLNDHifMLx5ZU2hVmNuFmUkUbpbt7QcIVwd0vJAXrrc3OE+LUNby1/HUzeq8tk9+qZTbCk/YVdKdrx4NpFGiIUS8a36svC5JDl1gYuy4yU36Qd1qqAQ9T1OTQlIm5vlbj6YM/954YnIBY2Bc6u/NOSOJLrxJvUuCDaTx5JT3NSAzGEfxKVd9T9BHwe61GsOHi/Bx4tFDPv53AmGp4MFSfr2gPSkE2jpepish98d9JTzoJ9818A4PjDeOg1WgMUY1F3HmL2jQANAOsqJW98gSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wu5VehAT+9vqUyY2CfIoAPJhm3cBA4LwH87hAIaoRqo=;
 b=TBbZrE1uTbiZT8QfQsXuR4taunUPSfcqeuSt1szDS1el+X97FkWGpZjdbpYBB9wqbhnTKy/3ip2cyqQMjkn2S2aFlPMhQflGjCOQX65AgBuKW0TV0VfT4TRS3HC1gV7FzvuVuxFRnPznvcSLa5TceYOxO1B1Voip5AEMKTwNc4/GU6xjMH13YtKOaXlLa/SQ19jFR+CxgDOZ1BmA/EPo229E7Y9WKth/J1K5XtRh6Q750eQxLD+TYCJj74/HweRhSSfrh3QYozqC39jnL3WXB8N2ud5mNHR2tY8l2sTUdshu6pqHlaAq5a8NUxefTmFwqMWrwO2veDGOSZlDu+eCCw==
Received: from CY5PR11MB6462.namprd11.prod.outlook.com (2603:10b6:930:32::10)
 by DSWPR11MB9559.namprd11.prod.outlook.com (2603:10b6:8:36d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.6; Fri, 27 Mar
 2026 15:28:48 +0000
Received: from CY5PR11MB6462.namprd11.prod.outlook.com
 ([fe80::10d1:11dd:5088:7559]) by CY5PR11MB6462.namprd11.prod.outlook.com
 ([fe80::10d1:11dd:5088:7559%5]) with mapi id 15.20.9769.004; Fri, 27 Mar 2026
 15:28:46 +0000
From: <Prathosh.Satish@microchip.com>
To: <ivecera@redhat.com>, <netdev@vger.kernel.org>
CC: <arkadiusz.kubalewski@intel.com>, <jiri@resnulli.us>,
	<mschmidt@redhat.com>, <poros@redhat.com>, <horms@kernel.org>,
	<vadim.fedorenko@linux.dev>, <linux-kernel@vger.kernel.org>,
	<conor+dt@kernel.org>, <krzk+dt@kernel.org>, <robh@kernel.org>,
	<devicetree@vger.kernel.org>, <pvaanane@redhat.com>
Subject: RE: [PATCH net-next 0/5] dpll: zl3073x: add ref-sync pair support
Thread-Topic: [PATCH net-next 0/5] dpll: zl3073x: add ref-sync pair support
Thread-Index: AQHct8ihyQ7RFW2LbEmExUq6DtYznrXCjQxQ
Date: Fri, 27 Mar 2026 15:28:45 +0000
Message-ID:
 <CY5PR11MB6462DDD97D531B854C5FE0E3EC57A@CY5PR11MB6462.namprd11.prod.outlook.com>
References: <20260319174826.7623-1-ivecera@redhat.com>
In-Reply-To: <20260319174826.7623-1-ivecera@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR11MB6462:EE_|DSWPR11MB9559:EE_
x-ms-office365-filtering-correlation-id: 59141b97-bca2-451c-db48-08de8c15896b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|22082099003|56012099003|18002099003|38070700021;
x-microsoft-antispam-message-info:
 kqsL98M+TgG9zOvRLSDClxRd1bEnWu4YyY5Hh3GPiwEnbPZp3XLkdsm0E72uQuXH4XT99sJaVjTY1KR+x2munT9ID8MMnb/qAPr12DzVPNcWkRLXxrXTMrZnplYx/s0Dv8w0Of/wY9iQCKI7bWDOHWr80joyCCFPTzwU4IrX52axB1+lFDzhBUh/QQgAQPaDTHjs9udWZBy7wmcpV140eCnbLuHPYpm3mKRa8F0/meJmeFmGKwHN8bnt/lhIKh4Au7AD8ZkcmVkivHu/aAmE0QnYREyk1ra1vdmjXesLK3XrsvXECnVc23Es56RIDHPfYPP7Ei7asJ+9p/dSjd8w567uD31iA+YjJwuEcaQSUylQtA1DQggvNRkpmhMsHLM0hj6tdhmAbmf8fx442oKdg/S5UEdTGRA0Ir9QzX4qM30dVjm7CNPO0D+5IjOa32C4jYgjv7V5KXYWfeQsW+iCV46G+taB7w9fyrCCxig3KS1SaIU9KdT+J+/WbGydyPLnGlCQPuAW0/gD5luMRtuVaOh1giCSabek9p96Op+zk3BrR/mvPKWzsxFZ+V9/UYT4MrP5RACbkRwz64gzeeh0LGqCalTy+sND++/gadw3dF6VXJ1iydLgE5gZoKqPlb3h7MsNrJ5jlidOiUazzDnE1Hy3LNOnRO2ddA6pnxvQGKQ7lAYnkgeXvmKoA76xz70IgP06xhNIbiJ/E0n88hIJGfUGn3qNcIhKyMEc+ftTXFLisfoAhYGEhQOzuQtFxlphtESoifgrx8tOEKsDwHkmr3Hp8npFCVJe78qSFjJYVgU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6462.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(22082099003)(56012099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?k/z6zmWufobtLu39QZnQiDOxHJ/d936HORVjDGM3/7gz6wYemQCYwBlezfz2?=
 =?us-ascii?Q?GG4o13OiLBjjKLB0aaedNdfl7qMEa2cg9XZhPHBVQ1ppaR7HMEpzAtFJMh4V?=
 =?us-ascii?Q?qrfU6113JERwirPZXuI+c281/u8A5vrRW1xUcGaAfFBLbZKnA9pGK0YhrpRq?=
 =?us-ascii?Q?BkZ4zYOLSFg7GGtwRpjqrqcYtpFaSN7RI3sQkRteo7XHPzPAkk8us1FXvNko?=
 =?us-ascii?Q?wUJt9qGWGJ045dIZ45Ap0UgQoYZbWnzBn/ygUKJqCandYQI6v+fpm6KlNTyz?=
 =?us-ascii?Q?XdHkyCR4R3v/8SuALl1b6vjcijd2uS1He8AXhfX3jXF7G4yvlQ9VwrH7dAHw?=
 =?us-ascii?Q?BFnb6Okcv+H7F4mAJzdDhU0vLgkmOaaT7PyzNytT/y8S+3RHeth+lZvRg+dY?=
 =?us-ascii?Q?ivwdvTsLrxHCam9y1k5uulTr7GjHFtbZvHcBcYDV/u08av4IqgBcsfYmxEPI?=
 =?us-ascii?Q?p0UuDaBsNO0ifYxnw8w+G1ZSxMZUcgliP9Nkaehw1wpVUxA5rBt3TXHsj5MJ?=
 =?us-ascii?Q?4q5Y8wcwTZZ2wPMIukx6ylrYdL6gBvqY+Ex1V2zxFhTdc+xcqytQJR3FEqLr?=
 =?us-ascii?Q?JMiWJ6/1vHZYhF3S90Z/f91HYeeoVNc1HT5W6i9akT8G+c0C6zhD8qxnXbor?=
 =?us-ascii?Q?YzLrgGRl8h7tLAf3axEa33BxF/NQsML9R/t3qS9Db+UM9+5tbjlSdd7f7UM0?=
 =?us-ascii?Q?CXf9mfuOUurAM1fbMV4ZfVETVToXn74k3FLugBUJI+GhQcE8n15dAUCvnUdA?=
 =?us-ascii?Q?rDh4cDLEuwRecB5DCUZAieI4Id0AKiwwptlS6UCt7ANlldmBHmTm2kZXEwAq?=
 =?us-ascii?Q?jSmIn/grRc993+g83ed9H9sVKG5X2ukiB78pL8FvQL5GZVtFSffj+NneS40F?=
 =?us-ascii?Q?KhHco+UP0Fh+CoumvVlCXxvWO0xSAyHYGqBg2wyl94C0QcrNO7GfIWqOnuYJ?=
 =?us-ascii?Q?DRoKQ00Ett5wp/8r1D3pehrj3tuA5eowZ/o1H5RKVPbJHiES5PdYHr35Wj2l?=
 =?us-ascii?Q?OH+pf7A0/tPR4Nc3IgprZ2tFBLAFPbpRkwjcjcz+T4fBM0M5l+ClG39kAJdf?=
 =?us-ascii?Q?GjJXR8H+n9R2iYz7seNoLdRDqVtR5tIKMzaSUsDY0MZUUZvRMwE30gA3L9TK?=
 =?us-ascii?Q?Xn5GPWzIowq2DW+qgepks/2BLeOlTB6GbX+bCDJZUwjCaTYZssMBS5/6JY92?=
 =?us-ascii?Q?bzJjU/KkYdOvA6CaH72DOXjqjTjp6SXel4AJVd2q6x9ePWBNVpLzQrC5pTjI?=
 =?us-ascii?Q?ThnVy+98GMCxY8dxWPwCboYDYPST4GXiN135r0sWq+zqc7zUIDZ8lxiToD1S?=
 =?us-ascii?Q?dkkxHnRg/zDkIwtW4tpltVrot8kfFPLl60oxfwRz3hvuLmFxVsbbstcu7NAd?=
 =?us-ascii?Q?2KhoFdR2xa7QRK6yym/RklvDNFxQSWcDuQujvjX8Ml4TBuA1JfZrZhSDRKcE?=
 =?us-ascii?Q?aKT3TehXuolanNph9X2urtBielE+qE4uFzd021D1yvzcddN5ruxp1YCcPoHf?=
 =?us-ascii?Q?V4Odr7z1v3be9cgkbaawOxy/fBTZGbL6OmE2uc7g5qYls+PehnMJD2V9dHck?=
 =?us-ascii?Q?t2P6RXAsDaOV2N+VeoDLRMMN6b9Y+JOHwOA7yc5l0GJEXu8fHBsnKiCbzHJr?=
 =?us-ascii?Q?TQXDg7NoRiS4ZhsHlzb6nv4B202ix2zafUmEF49GyARFpugC56uTpAKNFlcz?=
 =?us-ascii?Q?yPj4iiv3pJCT93fO48t6jLfCGn2FGS74ysu0IoqmiZJRDWq/jhzAKyn1RNAC?=
 =?us-ascii?Q?rUd2zP+w0A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6462.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59141b97-bca2-451c-db48-08de8c15896b
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2026 15:28:45.9683
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BqUOX0Zwsq80J4tcPLDpuOeeVV/BkbDwmZ15NwT5vjftsZV3QJJdcU1wOLs6ISRbQVals+XhvJthZjFUlv0AgDQ0R3mV6hijbhz3aa4361A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR11MB9559
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272599-lists,netdev=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[Prathosh.Satish@microchip.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[microchip.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:email,resnulli.us:email,CY5PR11MB6462.namprd11.prod.outlook.com:mid]
X-Rspamd-Queue-Id: DC096346C3B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Reviewed-by: prathosh.satish@microchip.com

-----Original Message-----
From: Ivan Vecera <ivecera@redhat.com>=20
Sent: Thursday, March 19, 2026 5:48 PM
To: netdev@vger.kernel.org
Cc: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>; Jiri Pirko <jiri=
@resnulli.us>; Michal Schmidt <mschmidt@redhat.com>; Petr Oros <poros@redha=
t.com>; Prathosh Satish - M66066 <Prathosh.Satish@microchip.com>; Simon Hor=
man <horms@kernel.org>; Vadim Fedorenko <vadim.fedorenko@linux.dev>; linux-=
kernel@vger.kernel.org; Conor Dooley <conor+dt@kernel.org>; Krzysztof Kozlo=
wski <krzk+dt@kernel.org>; Rob Herring <robh@kernel.org>; devicetree@vger.k=
ernel.org; Pasi Vaananen <pvaanane@redhat.com>
Subject: [PATCH net-next 0/5] dpll: zl3073x: add ref-sync pair support

EXTERNAL EMAIL: Do not click links or open attachments unless you know the =
content is safe

This series adds Reference-Sync pair support to the ZL3073x DPLL driver.
A Ref-Sync pair consists of a clock reference and a low-frequency sync sign=
al (e.g. 1 PPS) where the DPLL locks to the clock reference but phase-align=
s to the sync reference.

Patches 1-3 are preparatory cleanups and helper additions:
- Clean up esync get/set callbacks with early returns and use the
  zl3073x_out_is_ndiv() helper
- Convert open-coded clear-and-set bitfield patterns to FIELD_MODIFY()
- Add ref sync control and output clock type accessor helpers

Patch 4 adds the 'ref-sync-sources' phandle-array property to the dpll-pin =
device tree binding schema and updates the ZL3073x binding examples.

Patch 5 implements the driver support:
- ref_sync_get/set callbacks with frequency validation
- Automatic sync source exclusion from reference selection
- Device tree based ref-sync pair registration

Tested and verified on Microchip EDS2 (pcb8385) development board.

Ivan Vecera (5):
  dpll: zl3073x: clean up esync get/set and use zl3073x_out_is_ndiv()
  dpll: zl3073x: use FIELD_MODIFY() for clear-and-set patterns
  dpll: zl3073x: add ref sync and output clock type helpers
  dt-bindings: dpll: add ref-sync-sources property
  dpll: zl3073x: add ref-sync pair support

 .../devicetree/bindings/dpll/dpll-pin.yaml    |  11 +
 .../bindings/dpll/microchip,zl30731.yaml      |  30 +-
 drivers/dpll/zl3073x/chan.h                   |  17 +-
 drivers/dpll/zl3073x/core.c                   |   3 +-
 drivers/dpll/zl3073x/dpll.c                   | 295 ++++++++++++++----
 drivers/dpll/zl3073x/flash.c                  |   3 +-
 drivers/dpll/zl3073x/out.h                    |  22 ++
 drivers/dpll/zl3073x/ref.h                    |  46 +++
 drivers/dpll/zl3073x/regs.h                   |   2 +
 9 files changed, 348 insertions(+), 81 deletions(-)

--
2.52.0


