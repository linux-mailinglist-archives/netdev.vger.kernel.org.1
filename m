Return-Path: <netdev+bounces-272606-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MHb2Elalxmk4NQUAu9opvQ
	(envelope-from <netdev+bounces-272606-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 16:42:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AAB4F346EB5
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 16:42:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F17723091D3D
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 15:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 801CA3081D6;
	Fri, 27 Mar 2026 15:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="HYIlDdGH"
X-Original-To: netdev@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010002.outbound.protection.outlook.com [52.101.61.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2D92DF156;
	Fri, 27 Mar 2026 15:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774625745; cv=fail; b=qmvrZFwoM9PVn2nc6l9pDZR7+U18c6tX1/UmmGgMVt06Vv6Os4REoEmdiE/f6N8aKOoJVE1Ec19W6x3X3fXKxX1A+8I4l1aaHzJxxfCner0UONTc0NSh31sRN/AdQSS8QzPA9i5SgIYMTG1m9yCJzFTZVRPydwUtUt0kkCoq5Bo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774625745; c=relaxed/simple;
	bh=mSdM94IOKvG12w0tUcrW1gmy8TKZJ6E5azly5UQ/4lY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=e8knlRCLQRS7qPcjDCpgbR6hEO+Vhx2fFzQcTnMwZKxjHapDNa+zaZ4l5cUM+9iiZQR1ka41YthTxw6ArE+kinMSszNR4oPk5QjR+/KCCCZmXD9RL7tF0JTJ/g8hsoTNfX2Tzi1rMxRHREgYyvq8Sqze7lPjsxUsVebH5JaREbc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=HYIlDdGH; arc=fail smtp.client-ip=52.101.61.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AHwkL+knu79h/pWx6o2XNvvzW7DSJNwGTXKqYW5z76xTflVuFpuOi/0DnhpL70KOdCKaaqtSFE5bMmgaTnwJQ7FcUbD7g1Wzsy+MRLw22TpZ10v/Ly8yTA2/szrB1VQ6Y0mJZzpGX3nWO+JhFhdMo3PnhUTrYLBbNdUU6ogyTbNXeOjpiOzQEIB6NWJv2xXSygDY6M30OhDf933K9kHfOF6RAA4lRkfjZJPtRxKJRL/ChMLyLg9f7A0FVtRJARHAALT2BsvhyugKwJcZoQ2hdTfBjVnr3kTG0qiJfY+RbEQQEVbB/CU7Cq9McfSTtfqwxcs3xOYhIsmQCUPnSxZ1JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VsLDPRQuWnveMMc+04YzyMN04lQBExwFdn5NFqN53Yk=;
 b=TJU4cXLdWCGQuybEMlIR/XfVDdYxnbkIRVGTQKWD4XScK87/21eKG7etIypo+E289KnNsqR/M07sNSF01s4eaAPFIouKw/x6jmPCW05wCYtTFE79rz9bCl5Tn8IZ5upkZCc/ceQSeGYEKVAx3BQovW3fBUNayMih1s4kEmI3x5MuXFTtGXTRc4IXpI+SKouK7TQ4xLCPNiVivQQ/H+CtCzZMfae3MMxkZ+Q/hilvww0KMScwrjJrc065u6K7y2U4fhhm4D0Kx4yec59eQ6wgyi/U8jpkJCx9tO/7inByTkEVwhABgd/uMWOmj0ZekYOloLIB0djg1DevQ1xGZnULfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VsLDPRQuWnveMMc+04YzyMN04lQBExwFdn5NFqN53Yk=;
 b=HYIlDdGH8VZtzS+ZEVRE3U+9wKaLdndkYGs7o9rl2PfrcQexfCu//6OP4D86UX8gdWQwtK2p5VIwoc0wKAqSC0qZfoaq6GMQZUmEAZTOPPIX6eTiC5I+/E/VWHhwYHf6ltWzEWj4h7nXNpN42cnjlHWVNpsrZhkgUTXO9feEd5dKW5tKZSzp63opms2FCGcbbTH6R5CMVy8zaBXtFfBXoviMFwwpdQfFOGw8RNPdYmHwcOog2Xsj/56J6Nw4/JN0x9bGuvxk5yd9vY7Ye+IuuwO3KdtDWLTJKx8JRWS6UMxsyMUR9aWE7MhzPkJvGT7OwShjAIeYFdVYN5d3LeBtOQ==
Received: from CY5PR11MB6462.namprd11.prod.outlook.com (2603:10b6:930:32::10)
 by PH8PR11MB7990.namprd11.prod.outlook.com (2603:10b6:510:259::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.6; Fri, 27 Mar
 2026 15:35:40 +0000
Received: from CY5PR11MB6462.namprd11.prod.outlook.com
 ([fe80::10d1:11dd:5088:7559]) by CY5PR11MB6462.namprd11.prod.outlook.com
 ([fe80::10d1:11dd:5088:7559%5]) with mapi id 15.20.9769.004; Fri, 27 Mar 2026
 15:35:40 +0000
From: <Prathosh.Satish@microchip.com>
To: <ivecera@redhat.com>, <netdev@vger.kernel.org>
CC: <arkadiusz.kubalewski@intel.com>, <jiri@resnulli.us>,
	<mschmidt@redhat.com>, <poros@redhat.com>, <horms@kernel.org>,
	<vadim.fedorenko@linux.dev>, <linux-kernel@vger.kernel.org>,
	<conor+dt@kernel.org>, <krzk+dt@kernel.org>, <robh@kernel.org>,
	<devicetree@vger.kernel.org>, <pvaanane@redhat.com>
Subject: RE: [PATCH net-next 2/5] dpll: zl3073x: use FIELD_MODIFY() for
 clear-and-set patterns
Thread-Topic: [PATCH net-next 2/5] dpll: zl3073x: use FIELD_MODIFY() for
 clear-and-set patterns
Thread-Index: AQHct8iojHzy4j+M10abM/1ReuO74bXCjx7g
Date: Fri, 27 Mar 2026 15:35:39 +0000
Message-ID:
 <CY5PR11MB646215070FB6F16391909979EC57A@CY5PR11MB6462.namprd11.prod.outlook.com>
References: <20260319174826.7623-1-ivecera@redhat.com>
 <20260319174826.7623-3-ivecera@redhat.com>
In-Reply-To: <20260319174826.7623-3-ivecera@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR11MB6462:EE_|PH8PR11MB7990:EE_
x-ms-office365-filtering-correlation-id: 8b963a21-2ef1-47fc-2f56-08de8c168022
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info:
 TQBamX1/fhSz+Ntd3DtcOfq6IvtisZfxuWrd0xUe7vybcxHRdZ6gF8viWG0w2wMh+XnJkxTvlIbadh4XshEhYueFraGm1oGAvWKmJh4oysQf6F1x3wAV1QMGvRIKC3r5bwlbJCztuPuokAs7OEyVS1dNAtF7mDlsdvj5Qu8CIwemq1GlZJ7u3mid7hjnvi/iBk01bxuaB35aiV1Jz7jYmE4DIbMlm4X2Tx6pxbFB3Z9fdx4FeNvD0OYVrjQcPyUGTDSiVGhtxGSaVL0yY6MalOhPvbiOGhKWlvefL3lBXwefQWqbBQe2+jg5E+DY40hDzaIg5I50xpFB9vMQ0SlrCDGTmbG2d0xlW0kURYshRpmnj7FfeY19/6YQMVfGleCJhZDjUv2Ek/ZmM/L5VaqgsBnZp9yjDMOGxTrk4WY7CaEfm5ND0GH21+3FlME+9w7scywGj0winxovMDmtDPxBBfdPe2XFWEC00Q01DOyrU24WCSukruk+gC2RhlBgQXDUCWOfPN6VHgNG/I0soHFDYX95zgmGUC0OPsgpEuRcjPauPGDCeXWXHX27tgz7htb8/9B3Ql5u51scRSG/WaOtCJTODMFdkHxqHZpRLELs5Hi0IjnstviU0U03N3C3eh0sTFwuCIQ+4xoTSQoaO5iUypVnQ4TEOQTQibYGHKBFIrV+xdldAip7w+AX41KMooJeDomR059fzo1bXDnrX8ux+KGUqt6pBqc6C2VMj8sYgQIvmPACFdyxVAD9R9ypv6PsKrok4k8/hwIcsbxw9M1e4FV1rTYO5qPijyesRIdoA3A=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6462.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700021)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?BGHVnbpTrrh3fbL37RR6AOHkzkAZJVm2XhVqL8kDcwo/Q5pKur05nC1Za5Rw?=
 =?us-ascii?Q?Tce+lg7zRq0ycgacHCs6A+Vc2bdrhGNRmgceoTXNvTJc6Dj+otBRzOuiSX+y?=
 =?us-ascii?Q?3c5VzEkduA92D1jYStvtZO877pot8ajUOTJ7Vbydjg5rhKbbtq0/0QnQ/xtC?=
 =?us-ascii?Q?YCTw+rk8uo4JhihLfBFRJFd0UC4RrA3yOmArbwByKYXOIoQ+anaYyArAtSHc?=
 =?us-ascii?Q?YgvKjZx3gkg9II5tnDE23AmfN3hN2u8NpCto8nsBXLziP3BD0MVOY/xXsQLu?=
 =?us-ascii?Q?cZ2+tjPa6YzdAQivnLurcWSC+y3/Te12fo+abPAnF+/OHVVNW14Gti+Z1BgP?=
 =?us-ascii?Q?j0RFT78loVgISFCMTHbvkjp1nyZWVGQTgPdQ+IO+06NiBoUmkruO1OgWxj/E?=
 =?us-ascii?Q?MWH0qDvWLZXNIp4ieniAuVQCmylzD21bbuOH+nOvfARpZUwGmtlfss7bkq8P?=
 =?us-ascii?Q?7tPKI1qRw9j2O1l0BuyIylX4LD5oMxWyo7K12oxOUIJHars2rb3IAtHotcWR?=
 =?us-ascii?Q?0Zv80vAjVB1+xUVFwy7hS1zWYXRvT2l0QCgXxaAFVK1uAs8BeWhcZgP/6mU1?=
 =?us-ascii?Q?G1TRPDMxJ51bcuQcV8E1BcVLda3dc1P1qFINo+BsNXejXVcfAkHevyMh7aZS?=
 =?us-ascii?Q?7Ijqe0U3mpPjrX2/toyiI0zQncf0y7q7Qte2iBUWz2kLn+E90vXAXqylETeY?=
 =?us-ascii?Q?vLABjVLW7eKG+fsZigsiBviqI/Af9DtgbLFTO/+e9co0E9GXLpilzx/Hc7RU?=
 =?us-ascii?Q?KdgscA8tWcC7ots/1ECPEOF2YO+Xh+yRTlVvCz+DaCfHfQD1ybVGLGhpf53+?=
 =?us-ascii?Q?EtUUeAh5+fgRmJWgIGy/l/dsnli0ckyrAR5ZFSUs3gkKdSRGUEyJFn9wf5vJ?=
 =?us-ascii?Q?zX2ReEdL45TIMrd5DK185/miYtR4q3RLyRPFAKuB11t/+8ChrmXRbDwEXWOl?=
 =?us-ascii?Q?jq8K9+O7lKYnNcSOxJGW+ht+YKSxgKTxBkU4/f11DpkWXtrYSekfFKBYgX0p?=
 =?us-ascii?Q?ZsVyrQXHRsZX+VuY2gpUf5m1kJajIs5JmQou1bo1R4H85IFWty1ovyY6tTAo?=
 =?us-ascii?Q?kvsos2wMX8pU2JR7t/j9RztjaYAIKQ9SBepb/YXERDj1yuNwRzTYmRzNetbx?=
 =?us-ascii?Q?4qA9wivGDrR2HInDU4Jh9/0Rvzd3aLYV6NvRYKCG26PM/bnO5wyOpk88J0dt?=
 =?us-ascii?Q?zaBiLjLEY7VHDIegY8OzNjgmvwPGHl3vsVyUeuIA5OVNsfmrTup9BSKSw+mb?=
 =?us-ascii?Q?AwCCHb6geZE4+Jv63/mnL0C561xe9gvsges2UlrwaKQPYmvvcZokTKMFpnfg?=
 =?us-ascii?Q?jPJLqBwKOBHimfFhBaEUtnjefTS2BKOnjzOerAmN0jpZ1JRPFPMmYt1YEdAZ?=
 =?us-ascii?Q?yT7jqTjj4P0gYlQv52dgCffp6Hvcv7CkFJQYhWB2Zs/tT2Ql6GfwY/zZI0an?=
 =?us-ascii?Q?gJw+dNkqR/3YQObZNsQR88QtlqbaCf+DBABIlH6Dn1EVvvELKXRkyL4y6L57?=
 =?us-ascii?Q?uxDal4WjpP4hj/fuKidCUUVnH8snG5cPjzblyRMVitk1R93JkFZIT4JvWU9H?=
 =?us-ascii?Q?sjroJuFLiMrFgZtAjQyKVnNj9JpEcfsjpASTyAa2wSm2+Rz4FxkpmtIFEEzF?=
 =?us-ascii?Q?k6NRoj0dH2Iq6ZBTeCgvbw+lTnRJ9xH6zYF4WIDkLw8EM1WJeSeWtBZJ3XoH?=
 =?us-ascii?Q?eVxXdxW9bL8krdBnTqBr/C1zd8jCbhLIaksNUzOYxmO19V0zaHKu+Oa71Hc6?=
 =?us-ascii?Q?Ou+02rZcxQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b963a21-2ef1-47fc-2f56-08de8c168022
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2026 15:35:39.9186
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pY6DgwFpEmEy2SqOYL7rkmfynP/+/hCVail0xr84m2lAufMJdeMoc7p7/w7TF7zgum+s3MARRM/31xbMyg3P/ZDT8W8Z/yVqTNuIVzn2rwE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7990
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272606-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[microchip.com:dkim,microchip.com:email,linux.dev:email,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,CY5PR11MB6462.namprd11.prod.outlook.com:mid,resnulli.us:email]
X-Rspamd-Queue-Id: AAB4F346EB5
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
Subject: [PATCH net-next 2/5] dpll: zl3073x: use FIELD_MODIFY() for clear-a=
nd-set patterns

EXTERNAL EMAIL: Do not click links or open attachments unless you know the =
content is safe

Replace open-coded clear-and-set bitfield operations with FIELD_MODIFY().

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/dpll/zl3073x/chan.h  | 17 ++++++-----------  drivers/dpll/zl3073x/=
core.c  |  3 +--  drivers/dpll/zl3073x/flash.c |  3 +--
 3 files changed, 8 insertions(+), 15 deletions(-)

diff --git a/drivers/dpll/zl3073x/chan.h b/drivers/dpll/zl3073x/chan.h inde=
x e0f02d3432086..481da2133202b 100644
--- a/drivers/dpll/zl3073x/chan.h
+++ b/drivers/dpll/zl3073x/chan.h
@@ -66,8 +66,7 @@ static inline u8 zl3073x_chan_ref_get(const struct zl3073=
x_chan *chan)
  */
 static inline void zl3073x_chan_mode_set(struct zl3073x_chan *chan, u8 mod=
e)  {
-       chan->mode_refsel &=3D ~ZL_DPLL_MODE_REFSEL_MODE;
-       chan->mode_refsel |=3D FIELD_PREP(ZL_DPLL_MODE_REFSEL_MODE, mode);
+       FIELD_MODIFY(ZL_DPLL_MODE_REFSEL_MODE, &chan->mode_refsel,=20
+ mode);
 }

 /**
@@ -77,8 +76,7 @@ static inline void zl3073x_chan_mode_set(struct zl3073x_c=
han *chan, u8 mode)
  */
 static inline void zl3073x_chan_ref_set(struct zl3073x_chan *chan, u8 ref)=
  {
-       chan->mode_refsel &=3D ~ZL_DPLL_MODE_REFSEL_REF;
-       chan->mode_refsel |=3D FIELD_PREP(ZL_DPLL_MODE_REFSEL_REF, ref);
+       FIELD_MODIFY(ZL_DPLL_MODE_REFSEL_REF, &chan->mode_refsel, ref);
 }

 /**
@@ -110,13 +108,10 @@ zl3073x_chan_ref_prio_set(struct zl3073x_chan *chan, =
u8 ref, u8 prio)  {
        u8 *val =3D &chan->ref_prio[ref / 2];

-       if (!(ref & 1)) {
-               *val &=3D ~ZL_DPLL_REF_PRIO_REF_P;
-               *val |=3D FIELD_PREP(ZL_DPLL_REF_PRIO_REF_P, prio);
-       } else {
-               *val &=3D ~ZL_DPLL_REF_PRIO_REF_N;
-               *val |=3D FIELD_PREP(ZL_DPLL_REF_PRIO_REF_N, prio);
-       }
+       if (!(ref & 1))
+               FIELD_MODIFY(ZL_DPLL_REF_PRIO_REF_P, val, prio);
+       else
+               FIELD_MODIFY(ZL_DPLL_REF_PRIO_REF_N, val, prio);
 }

 /**
diff --git a/drivers/dpll/zl3073x/core.c b/drivers/dpll/zl3073x/core.c inde=
x 6363002d48d46..7eebfc1ad1019 100644
--- a/drivers/dpll/zl3073x/core.c
+++ b/drivers/dpll/zl3073x/core.c
@@ -743,8 +743,7 @@ int zl3073x_dev_phase_avg_factor_set(struct zl3073x_dev=
 *zldev, u8 factor)
        value =3D (factor + 1) & 0x0f;

        /* Update phase measurement control register */
-       dpll_meas_ctrl &=3D ~ZL_DPLL_MEAS_CTRL_AVG_FACTOR;
-       dpll_meas_ctrl |=3D FIELD_PREP(ZL_DPLL_MEAS_CTRL_AVG_FACTOR, value)=
;
+       FIELD_MODIFY(ZL_DPLL_MEAS_CTRL_AVG_FACTOR, &dpll_meas_ctrl,=20
+ value);
        rc =3D zl3073x_write_u8(zldev, ZL_REG_DPLL_MEAS_CTRL, dpll_meas_ctr=
l);
        if (rc)
                return rc;
diff --git a/drivers/dpll/zl3073x/flash.c b/drivers/dpll/zl3073x/flash.c in=
dex 83452a77e3e98..f85535c8ad246 100644
--- a/drivers/dpll/zl3073x/flash.c
+++ b/drivers/dpll/zl3073x/flash.c
@@ -194,8 +194,7 @@ zl3073x_flash_cmd_wait(struct zl3073x_dev *zldev, u32 o=
peration,
        if (rc)
                return rc;

-       value &=3D ~ZL_WRITE_FLASH_OP;
-       value |=3D FIELD_PREP(ZL_WRITE_FLASH_OP, operation);
+       FIELD_MODIFY(ZL_WRITE_FLASH_OP, &value, operation);

        rc =3D zl3073x_write_u8(zldev, ZL_REG_WRITE_FLASH, value);
        if (rc)
--
2.52.0


