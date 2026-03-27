Return-Path: <netdev+bounces-272607-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KK4+GGulxmk4NQUAu9opvQ
	(envelope-from <netdev+bounces-272607-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 16:42:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C1F29346ECB
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 16:42:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4ED4330DC6F0
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 15:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ED02309EE7;
	Fri, 27 Mar 2026 15:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="mqTEpMBV"
X-Original-To: netdev@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012000.outbound.protection.outlook.com [52.101.48.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E782DF156;
	Fri, 27 Mar 2026 15:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774625764; cv=fail; b=fI6Y0KEqGb50iJz7cUN152tVY8In0EwlRgNpp/6yRQkxjOzT3W0X1CKEBnRdU/LW5jfFTUjGO/YUNEJlugUhrlbsyooROz6cV0ehBEJKXhUVm8mbcV8MI2HDjy2me8/hV0YvnhMmBr3a3tX8yNzXq7owkY+b5hhcHGIzyWud/PA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774625764; c=relaxed/simple;
	bh=Z1gCEM5HKc3LxqWznIbJTjwBrf//ZIQkce0txOYp6j4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OYGQ5eeKnGi96ILpmVhcTeAlCfV+isyky2BB1MxEEP8Uyzd/oeD/WXnaP+D5jnBihspwVS+I/O8kwIbk3OGVno52drt2Rn6xPbSIbfa/dvtK/RfwxQLWDTF1OC4KZDV6WCHY4GXxwAYYXvwdZDc8s/TTMmP3hoTdc8xzHwlyay0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=mqTEpMBV; arc=fail smtp.client-ip=52.101.48.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V4YzP34GQ7/AX1MiGUEakD1w/ei/xQdHEefWI2T+LqxQvOkmRNvBt7wyVwVlYGa3hKPULIKjO63POSbZWhCufnnnp9BAH1gy8LXF8VGrTf7Tuvgz3boneGMcpLwkkASiHA1sDOuzA5l/54BUni744LXzVbwLQ4uqUtkuRoNTrKs6hC1u4tS8UD2QsY1wntXSugt8cp3CzoV7uHn+49u59K868li7g2TRtmGKm7I5HkGPj7+YPWtq9SuuFhAC8rSjAmL4LCDxmlh1Yc/jHSRITgpYyCMiul4q3kpu9bmkFFMEh/cw3WzEx+b9GeNC84QC3zUG+YkuQYPgYvvoZB2Kdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hIskjCEB3om1/KWnV1lYFwRxqJ1nzn6IyUKcDU+yeD0=;
 b=J/W+XhuSXHL1GbtvH5j/uMi+W04yuZRtwBBGqIUfug22U8owrWXvJJVGVqbsxwirFVij3VyAysSVpTVUEAUGidyf2GA0MPZ6eb5uqWq6ZVHFb7J8UDY2424fsU82ngpvuqV43dDDxPVYf9CoO+nQcsnJrzjBDOiUMKwqVW2QIYQh85VZRe4skbjefHWbsJ8Gn5ANyXvZTIbMxv5BeTo0fJoJElBf1U/Rt/RWpJpn1b95cW5nYujGZ3oaGW1fmnjUh/hn2w0Djh6K3g/D35lH3WDre+ORvYy7Y1R/Zy4GXT5aZdp5J/Es2M5MMRwy32KdiVLaS/2Uq8HE29dxJNgM5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hIskjCEB3om1/KWnV1lYFwRxqJ1nzn6IyUKcDU+yeD0=;
 b=mqTEpMBVMkN+gy9wttC4aZ6wCGwoZWbZVhdgOmdMy/mDSdo9Z5NZ8OVnWMZqRlk0GjNRmav2lIGfvu4kEFF5XLJaD8/+DSCfX2P1GhOXsk3E9607DQOW2DppvEyEv/TuZf4eJV0DUTrlNMX1FAEbrYp2K/QYTlvY9V6iE3jY5QdGoFIFx1wD/P2kuMX2VRSADByhVXmmZwX09ftrFZwUiX5fLexANS1fn9iF6MQtwX9N1hq6EJyAGBmrA8pqPueuvwS5fCUvHYTyxhEQPliG8ND+/GXRbEpQF/6bFDvsBaIgrLSa8bUCNWwIvofohK7AnvCo3/nBXHBNdEgxVo3QSw==
Received: from CY5PR11MB6462.namprd11.prod.outlook.com (2603:10b6:930:32::10)
 by PH8PR11MB7990.namprd11.prod.outlook.com (2603:10b6:510:259::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.6; Fri, 27 Mar
 2026 15:36:00 +0000
Received: from CY5PR11MB6462.namprd11.prod.outlook.com
 ([fe80::10d1:11dd:5088:7559]) by CY5PR11MB6462.namprd11.prod.outlook.com
 ([fe80::10d1:11dd:5088:7559%5]) with mapi id 15.20.9769.004; Fri, 27 Mar 2026
 15:36:00 +0000
From: <Prathosh.Satish@microchip.com>
To: <horms@kernel.org>, <ivecera@redhat.com>
CC: <devicetree@vger.kernel.org>, <vadim.fedorenko@linux.dev>,
	<jiri@resnulli.us>, <netdev@vger.kernel.org>, <pvaanane@redhat.com>,
	<arkadiusz.kubalewski@intel.com>, <robh@kernel.org>,
	<linux-kernel@vger.kernel.org>, <conor+dt@kernel.org>, <krzk+dt@kernel.org>,
	<mschmidt@redhat.com>, <poros@redhat.com>
Subject: RE: [PATCH net-next 1/5] dpll: zl3073x: clean up esync get/set and
 use zl3073x_out_is_ndiv()
Thread-Topic: [PATCH net-next 1/5] dpll: zl3073x: clean up esync get/set and
 use zl3073x_out_is_ndiv()
Thread-Index: AQHct8ijyZrubbgxEUCEz2iAjS7MRrW3q0WAgAAD9wCAAQO1AIAJ3Ekg
Date: Fri, 27 Mar 2026 15:35:59 +0000
Message-ID:
 <CY5PR11MB64627489F70490DF091A9FF3EC57A@CY5PR11MB6462.namprd11.prod.outlook.com>
References: <20260319174826.7623-2-ivecera@redhat.com>
 <20260320171725.112558-1-horms@kernel.org>
 <ffa7b3a5-a381-435e-b170-24341962b6d1@redhat.com>
 <20260321090108.GP74886@horms.kernel.org>
In-Reply-To: <20260321090108.GP74886@horms.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR11MB6462:EE_|PH8PR11MB7990:EE_
x-ms-office365-filtering-correlation-id: 4bc9fd6c-ef7c-4b1e-4049-08de8c168c0d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info:
 /hOh086VWuG6TpT/TjXrR5QM2PdcpBTgktFkvrv9e2qVgwboe2NuZvQWxj+bXnGCnN/Hz5ZAW3A3SFwWVuOW9Y+qF52Bw4D54s5eSp9ioNKNOlBPBTSJeDyHS2+79HCjgXs4hG4gMagaEyP9thQLMjx5L6drhcNaRbGCA376WEfQis14Z3uCKy+HoH/jR8Pvcf1Q0apda1CJmGF+7GYvw+axKFWYmRTeYwyF+oOhI+9Z3wsQ9zW6waVbzxUyCa96bIhDgYGYtilfzJyBr+t6mQW/dqwrxBo1ISSSJvK0er0iVFIIJRN0mGJRRDODgreDLN1IEqmEjoMGqEDmdPP8Sz6cnNlzXqAvftazxS2rpkGrDroF98Qd/RXN9FJWF0AY1BnqNZS3DiocZtdhaz5wdXvZwbnyA6+4rsRrTK/HlOZsU+fvPhUItTRr/Q6nUKRYqTt53dB7EIkkDwshkI+lyMJ3+nh5CmIdMixheYv/OeLmPdqQuCOAwMgjwJW7pmkbdf6Q3lzX+11HVSpXybtRSbXI7dhEtiRfY2D/jd5lfL+JYpbuapT1GgjLSU4XdB54SE1FTh0pg/ke/5+D07I+XROtS6t89Yq+N58wNk2yp8ZaExSg2ZGJSUMBdYiLkOP2TNNFM+/0qRMY6smksXvlZU30KFGHGpoG8mRVmn/02XXaQ54K5J4ei3V///EDMoZu1W9ynX9y+n0+29gdUWJ7WGBg7/nZTy+Uf02o0+yDTX4=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6462.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700021)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?YhJ+dx2SUFBmq9YDbA+u8OCqGfR2Bsd5DPA0d08jruM2KfGYVP6v+wzJnJo+?=
 =?us-ascii?Q?CIcakFzkDOY44YccEYSMd19iVMAhuEoGHF4tGQaFXMW7yMwXb3Sdum3YSnGw?=
 =?us-ascii?Q?yMe/kbrBcrd+wW5c3J5KseSIaZ05MGBEES5TEU28Puxv81IcvYG3fmdf4Red?=
 =?us-ascii?Q?onnk1oT1enMoAu4XcOs5oxfk0qG+yHexFucc0a4NeMTUUxv+aiEMrOp5C4jr?=
 =?us-ascii?Q?yPNwp9LEm7+re6+8J4k54NCf0fklHAEYfsKFvQJ1fthCDQ1NmqQJmnZg4mBU?=
 =?us-ascii?Q?Ke3zGFzzzMBTf3a/O6u9q1N/qEFRns3zRyELy7/D0NBI2RHYtOHNGCrKD/3R?=
 =?us-ascii?Q?nEEoP19SQY2V6emFDJ70gt3h7p3twqOtXxcAd6D5/ee9JJUsvHDhR5Uwyw5P?=
 =?us-ascii?Q?/Qb1x0uK4pCw1NLhjua8hGQDjbKLLHOSRll9rs8DTwxtxcuyWqkDPqHb/pTe?=
 =?us-ascii?Q?DBdstVk1EaFh6JpGZBEg1yLff4WxFck8WSRquO44MG7pxmOxLGUGYesYKeLb?=
 =?us-ascii?Q?RN4j+5LJY5NjMwE4AieXzbfOxx04jjO8IhxbIhEWwyVW3XcT7/jubRdg4+Xk?=
 =?us-ascii?Q?aalRmBzCXUwrp7vE+SNwFWxvdhEm8hLCl8M5cyvBo8ZKLNkyPGk31fnCuZG+?=
 =?us-ascii?Q?jaEWAFIukN+z4Z/yZuW1z2JljOKbvyxAIPdodcyBPCskwI3Mwr+g0xcHfvEA?=
 =?us-ascii?Q?t+jNQk0gvVvNqlz0xE5uL0wqBevzwjHbb+Lw0O9MIVuZBg0ZVSocddzTEJrg?=
 =?us-ascii?Q?39mLehXMhi7smF2WLTwnPkUfgLzrDK+SF1BHK+c4zuUNSAVkgUGc/XOY/tWa?=
 =?us-ascii?Q?D6QzAAyJ+ye72iLxvoWWXdJ9OAW539CQHQ+KW1lp+WyFs7c9jvfE3zoT51W4?=
 =?us-ascii?Q?o1pvGkhwqrDeeRht0axjYhaxbLajoFnbjrGEXgt2MKmHiCsEJnU4Iie+o70D?=
 =?us-ascii?Q?7KJFFX+WwGxKq0dmTb3CwK50kWzbQmRes0b+0mfUPucrrjqlmLDqVdC82SlX?=
 =?us-ascii?Q?53WKUVsdnKvCAc2TUUcWtykor5Zg0yeRO9I+gsd5p3J5RKCuQB2Jq0bDoyQ/?=
 =?us-ascii?Q?h9UYypYyEvlQ9aFbwr0qDFMTt458hYCwtN7lMIsrRoei/D6AAtG4eVzvt+un?=
 =?us-ascii?Q?/CUlW5FPv67qQVBq6AqZBHwFcRr5JMqhWc3YHVzj17Mx++bxCqhmkIhkFy/0?=
 =?us-ascii?Q?5H3Jl5xFVdxF5foFDojd61ylTpRmflot2eagKlPS3pfDW3zwHDJ7fqDnTp2D?=
 =?us-ascii?Q?ndPFDiWUCZWoHhqVytht6FQWc5r1qmPPywZyrutMOpCnXA/542m405bUyPtR?=
 =?us-ascii?Q?FmaoBVB6tgHWvlhcll19Y2QhKOXgPPpp0LSQJqqvYO45rO2wZUk+Vl3eD8Td?=
 =?us-ascii?Q?Cf5etAY2PuHs8NVhLMjo0bVxaA+MJfLQCa5jvFrHh05BFPiJYV+Gjs6hRqjr?=
 =?us-ascii?Q?fJ9ewqMdEO+4rSBwmL1jkWByHwX1rjU+GG+uVnCN4TNG/ZLs15s5uFAwiN9d?=
 =?us-ascii?Q?mWcb8yhaJPvP1sqgdtwP+ovCRK+w31clRJJVyhBytUUkHir5ZqobeHPncW+q?=
 =?us-ascii?Q?3RvPPG+w47AhdIxhaOMR+F1s5QI7sWUcIlVzBamsgzq7DQ3ZLV3khkopcxQH?=
 =?us-ascii?Q?9q813ZDZsuxiYwnpIwMp1PBIav+z5+hIUk7idiuDHRvNDKjr2ufp4Q2B2p6E?=
 =?us-ascii?Q?Icg50pgE5RLSutqnPooxCaVxTthr8V3sVYQ+iD5RuCV7odBYsgZ1G8kQpVUr?=
 =?us-ascii?Q?ejvFKoco3g=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bc9fd6c-ef7c-4b1e-4049-08de8c168c0d
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2026 15:35:59.9547
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EGhvIfPTSgVuX7ovfppiTUnhjyLOH3VY+4Nlz/CS1PSbUysuxfRenexFO2JsDCG2JQxzfn+wPXcA46zRABftQSt7Qte7yKebGMApxmLghGM=
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
	TAGGED_FROM(0.00)[bounces-272607-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[microchip.com:dkim,microchip.com:email,linux.dev:email,linux.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,CY5PR11MB6462.namprd11.prod.outlook.com:mid,intel.com:email,resnulli.us:email]
X-Rspamd-Queue-Id: C1F29346ECB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Reviewed-by: prathosh.satish@microchip.com

-----Original Message-----
From: Simon Horman <horms@kernel.org>=20
Sent: Saturday, March 21, 2026 9:01 AM
To: Ivan Vecera <ivecera@redhat.com>
Cc: devicetree@vger.kernel.org; vadim.fedorenko@linux.dev; jiri@resnulli.us=
; netdev@vger.kernel.org; pvaanane@redhat.com; arkadiusz.kubalewski@intel.c=
om; robh@kernel.org; linux-kernel@vger.kernel.org; conor+dt@kernel.org; krz=
k+dt@kernel.org; Prathosh Satish - M66066 <Prathosh.Satish@microchip.com>; =
mschmidt@redhat.com; poros@redhat.com
Subject: Re: [PATCH net-next 1/5] dpll: zl3073x: clean up esync get/set and=
 use zl3073x_out_is_ndiv()

EXTERNAL EMAIL: Do not click links or open attachments unless you know the =
content is safe

On Fri, Mar 20, 2026 at 06:31:36PM +0100, Ivan Vecera wrote:
> Hi Simon,
>
> On 3/20/26 6:17 PM, Simon Horman wrote:
> > This is an AI-generated review of your patch. The human sending this=20
> > email has considered the AI review valid, or at least plausible.
> >
> > For local reproduction steps see=20
> > https://netdev-ai.bots.linux.dev/ai-local.html
> > ---
> > dpll: zl3073x: clean up esync get/set and use zl3073x_out_is_ndiv()
> >
> > Return -EOPNOTSUPP early in esync_get callbacks when esync is not=20
> > supported instead of conditionally populating the range at the end.
> > This simplifies the control flow by removing the finish label/goto=20
> > in the output variant and the conditional range assignment in both=20
> > input and output variants.
> >
> > Replace open-coded N-div signal format switch statements with
> > zl3073x_out_is_ndiv() helper in esync_get, esync_set and=20
> > frequency_set callbacks.
> >
> > > diff --git a/drivers/dpll/zl3073x/dpll.c=20
> > > b/drivers/dpll/zl3073x/dpll.c index a29f606318f6..79ef62d69a32=20
> > > 100644
> > > --- a/drivers/dpll/zl3073x/dpll.c
> > > +++ b/drivers/dpll/zl3073x/dpll.c
> > > @@ -131,6 +131,12 @@ zl3073x_dpll_input_pin_esync_get(const struct dp=
ll_pin *dpll_pin,
> > >           ref_id =3D zl3073x_input_pin_ref_get(pin->id);
> > >           ref =3D zl3073x_ref_state_get(zldev, ref_id);
> > >
> > > + if (!pin->esync_control || zl3073x_ref_freq_get(ref) =3D=3D 1)
> > > +         return -EOPNOTSUPP;
> > > +
> > > + esync->range =3D esync_freq_ranges; range_num =3D=20
> > > + esync->ARRAY_SIZE(esync_freq_ranges);
> > > +
> > >           switch (FIELD_GET(ZL_REF_SYNC_CTRL_MODE, ref->sync_ctrl)) {
> > >           case ZL_REF_SYNC_CTRL_MODE_50_50_ESYNC_25_75:
> > >                   esync->freq =3D ref->esync_n_div =3D=3D=20
> > > ZL_REF_ESYNC_DIV_1HZ ? 1 : 0; @@ -142,17 +148,6 @@ zl3073x_dpll_input=
_pin_esync_get(const struct dpll_pin *dpll_pin,
> > >                   break;
> > >           }
> > >
> > > - /* If the pin supports esync control expose its range but only
> > > -  * if the current reference frequency is > 1 Hz.
> > > -  */
> > > - if (pin->esync_control && zl3073x_ref_freq_get(ref) > 1) {
> > > -         esync->range =3D esync_freq_ranges;
> > > -         esync->range_num =3D ARRAY_SIZE(esync_freq_ranges);
> > > - } else {
> > > -         esync->range =3D NULL;
> > > -         esync->range_num =3D 0;
> > > - }
> > > -
> > >           return 0;
> > >   }
> >
> > The refactoring changes the behavior when the reference frequency is 0 =
Hz.
> >
> > The old code checked 'zl3073x_ref_freq_get(ref) > 1' which excluded=20
> > both
> > freq=3D=3D0 and freq=3D=3D1 from having the esync range exposed. The ne=
w=20
> > code checks
> > 'zl3073x_ref_freq_get(ref) =3D=3D 1' which only excludes freq=3D=3D1.
> >
> > When freq=3D=3D0 (which can happen when freq_base, freq_mult, or=20
> > freq_ratio_m is 0), the old code would return 0 with=20
> > esync->range=3DNULL and
> > esync->range_num=3D0, while the new code returns 0 with=20
> > esync->range=3Desync_freq_ranges and esync->range_num=3D1.
> >
> > The removed comment documented the original intent: "if the current=20
> > reference frequency is > 1 Hz". Should the new check be 'zl3073x_ref_fr=
eq_get(ref) <=3D 1'
> > to preserve the original behavior for 0 Hz frequencies?
> >
> > >
> > > @@ -582,8 +577,8 @@ zl3073x_dpll_output_pin_esync_get(const struct dp=
ll_pin *dpll_pin,
> > >           struct zl3073x_dpll_pin *pin =3D pin_priv;
> > >           const struct zl3073x_synth *synth;
> > >           const struct zl3073x_out *out;
> > > + u32 synth_freq, out_freq;
> > >           u8 clock_type, out_id;
> > > - u32 synth_freq;
> > >
> > >           out_id =3D zl3073x_output_pin_out_get(pin->id);
> > >           out =3D zl3073x_out_state_get(zldev, out_id); @@ -592,17=20
> > > +587,19 @@ zl3073x_dpll_output_pin_esync_get(const struct dpll_pin *d=
pll_pin,
> > >            * for N-division is also used for the esync divider so bot=
h cannot
> > >            * be used.
> > >            */
> > > - switch (zl3073x_out_signal_format_get(out)) {
> > > - case ZL_OUTPUT_MODE_SIGNAL_FORMAT_2_NDIV:
> > > - case ZL_OUTPUT_MODE_SIGNAL_FORMAT_2_NDIV_INV:
> > > + if (zl3073x_out_is_ndiv(out))
> > >                   return -EOPNOTSUPP;
> > > - default:
> > > -         break;
> > > - }
> > >
> > >           /* Get attached synth frequency */
> > >           synth =3D zl3073x_synth_state_get(zldev, zl3073x_out_synth_=
get(out));
> > >           synth_freq =3D zl3073x_synth_freq_get(synth);
> > > + out_freq =3D synth_freq / out->div;
> > > +
> > > + if (!pin->esync_control || out_freq =3D=3D 1)
> > > +         return -EOPNOTSUPP;
> > > +
> > > + esync->range =3D esync_freq_ranges; range_num =3D=20
> > > + esync->ARRAY_SIZE(esync_freq_ranges);
> > >
> > >           clock_type =3D FIELD_GET(ZL_OUTPUT_MODE_CLOCK_TYPE, out->mo=
de);
> > >           if (clock_type !=3D ZL_OUTPUT_MODE_CLOCK_TYPE_ESYNC) { @@=20
> > > -610,11 +607,11 @@ zl3073x_dpll_output_pin_esync_get(const struct dpl=
l_pin *dpll_pin,
> > >                   esync->freq =3D 0;
> > >                   esync->pulse =3D 0;
> > >
> > > -         goto finish;
> > > +         return 0;
> > >           }
> > >
> > >           /* Compute esync frequency */
> > > - esync->freq =3D synth_freq / out->div / out->esync_n_period;
> > > + esync->freq =3D out_freq / out->esync_n_period;
> > >
> > >           /* By comparing the esync_pulse_width to the half of the pu=
lse width
> > >            * the esync pulse percentage can be determined.
> > > @@ -623,18 +620,6 @@ zl3073x_dpll_output_pin_esync_get(const struct d=
pll_pin *dpll_pin,
> > >            */
> > >           esync->pulse =3D (50 * out->esync_n_width) / out->div;
> > >
> > > -finish:
> > > - /* Set supported esync ranges if the pin supports esync control=20
> > > and
> > > -  * if the output frequency is > 1 Hz.
> > > -  */
> > > - if (pin->esync_control && (synth_freq / out->div) > 1) {
> > > -         esync->range =3D esync_freq_ranges;
> > > -         esync->range_num =3D ARRAY_SIZE(esync_freq_ranges);
> > > - } else {
> > > -         esync->range =3D NULL;
> > > -         esync->range_num =3D 0;
> > > - }
> > > -
> > >           return 0;
> > >   }
> >
> > Similar to the input variant, this changes the behavior for 0 Hz=20
> > output frequencies.
> >
> > The old code used '(synth_freq / out->div) > 1' to decide whether to=20
> > expose the esync range, which excluded both out_freq=3D=3D0 and=20
> > out_freq=3D=3D1. The new code uses 'out_freq =3D=3D 1' for the early=20
> > -EOPNOTSUPP return, only excluding out_freq=3D=3D1.
> >
> > When out_freq=3D=3D0 (which can happen when synth_freq is 0 or=20
> > synth_freq <
> > out->div), the old code returned 0 with esync->range=3DNULL and
> > esync->range_num=3D0, while the new code returns 0 with=20
> > esync->range=3Desync_freq_ranges and esync->range_num=3D1.
> >
> > The removed comment documented the intent: "if the output frequency=20
> > is > 1 Hz". Should this also use 'out_freq <=3D 1' to maintain=20
> > consistency with the original behavior?
> >
> > [ ... ]
> >
>
> The frequency for both input and output pins cannot be zero... Cannot=20
> be set to 0 and device never returns configured frequency to be 0.
>
> I can modify the lines to be:
>
> if (!pin->esync_control || out_freq <=3D 1)
>       return -EOPNOTSUPP;
>
> but it is needless - but let me know.

Thanks Ivan,

If it is needless then there is no need to handle it in the code.
Sorry for not understanding that before forwarding on the AI generated revi=
ew.

