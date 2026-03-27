Return-Path: <netdev+bounces-272603-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eKAvCNSkxmk4NQUAu9opvQ
	(envelope-from <netdev+bounces-272603-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 16:40:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B4092346E36
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 16:40:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 88E5C3011759
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 15:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9AB92D7DFE;
	Fri, 27 Mar 2026 15:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ioH9Egjw"
X-Original-To: netdev@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010013.outbound.protection.outlook.com [40.93.198.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38EF54594A;
	Fri, 27 Mar 2026 15:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774625718; cv=fail; b=GnoSb3SjuKZLRFYLTGP0Lg/K7PzTNa8iBziGJT9XxRB6SdtKfgsoPzO1EYhk9LNFJQliB/6aMz6oHBHH1zlLB4vIt013bhkEC8XiXJCDaSVyUSM6rqTFT8RgXFP5glGF2ARkZ/qGfIyE+IExFFJ4JXFvhrZeSmjg9AnjHKzRcXE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774625718; c=relaxed/simple;
	bh=Jrp/2wp56x67hkVfNBaeKSMKdSDvbJ5thRxqGrKo4gY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ne8MDNs4ymYcwyO0jkgV580WxYllFWxTjCGEmbpTb7z5R37tCk70ex48jS+cmSbMjSH52EIVRSFsHpsf8LYMZ9GXN9TnEVXGBkrIX3LXrTGQ81M6tZbJsX/ZQy/tOSZ2JO0RfkFAcu6chDFvjZNfQNqfVdp1UcaKDVfoCm71+oY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ioH9Egjw; arc=fail smtp.client-ip=40.93.198.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qkf/l2MFRZX0nntt5gMLlVgYuK1QC6s0SrVJ4yW+btynLHUM3P5jW8N/wyhompSjKgm46/g2Vv1Yi79U+ePawHiFg2wIk5c8dz8saHG8edMUkKmcwWTkHyDr05HLyMF7ZvVRc91DtIW6yFjv9nSLmo+pFyludzf/z2rkQSV8Odq6+CcIOWVIfHUSn3SguNTUXskAM9GO0k7tI105R6YrkeCpYEjyKndUwd83Ve0tgRfAepa53F6A4RWWtIgL2ZyAFMMyk0xWJkP7pG2Cz1fl0kunqNx6hUy1Tv40uvM2QANmXuAvqGPqFr1HpEnJHL4+93496WCoy7y8sVpOAe3kYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aQbiiPZi5KjP8T7xmL5GdxJO6DzjSGXHq0YZkbY+9Hw=;
 b=giWPGaqoxf4RIRUONsAUbkVLdqEar2gXLn+/GyoE0XawkVmO2w+f8nsX34RhBT85EX1kFPrIvA9CH0XvYEN/fJFItYOM1PleyX/SH+6A/lj3NB6+2BAuKWVpTVBfN6XgeYrkibQ5p8eWlD3BcCGTyOOX8yFi/JmtQzjIPLwLP8YDEv7RYHCwZ+y7K8/MuWJtHiwRiIhpeXLqJDRR8n0tFe+aC74pLIIr2elohkOvjpBxryl1Wf1dz49j+2rkQu+Wfx9F7TlGb6zps4wc0E/Gk0z+WDQz6pkEHWPeDVkSSway0LL3ClbcrZPeySM4qyAs2ZUghu2YuMJrgdYNz7ek8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aQbiiPZi5KjP8T7xmL5GdxJO6DzjSGXHq0YZkbY+9Hw=;
 b=ioH9EgjwCP5UjkUeLOwczZYThN7se+KmsKBWFtn4SC2t2SK7tPrUhs8YOBCsmE4FBLLDrFMxUsuJGWJl0rhg7V7uxlvwTxRQaQYfgolffPYYn9cXWteJzM6Ezdb0KvLH1xlFzMfvEiiHCx8lJlxLHpquk17kzpRM7gPoIHFKhgjth4F/X+W7z7Fnxio+CsBzKyrQ3TyKeFayIiP4EzzCLWaaYeDIY/VV0wVOA4NqS48NfPkTtdLxmPDoOkgkMlAbvpIR8v6pMbPWsxriBwjqnvc377vvZ3EsksNiK7q9jdtZgmPL8gc0/XLPMe+rugGMYBv/6wM1ZIT0nd7C0KT7QA==
Received: from CY5PR11MB6462.namprd11.prod.outlook.com (2603:10b6:930:32::10)
 by PH8PR11MB7990.namprd11.prod.outlook.com (2603:10b6:510:259::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.6; Fri, 27 Mar
 2026 15:35:13 +0000
Received: from CY5PR11MB6462.namprd11.prod.outlook.com
 ([fe80::10d1:11dd:5088:7559]) by CY5PR11MB6462.namprd11.prod.outlook.com
 ([fe80::10d1:11dd:5088:7559%5]) with mapi id 15.20.9769.004; Fri, 27 Mar 2026
 15:35:13 +0000
From: <Prathosh.Satish@microchip.com>
To: <ivecera@redhat.com>, <netdev@vger.kernel.org>
CC: <arkadiusz.kubalewski@intel.com>, <jiri@resnulli.us>,
	<mschmidt@redhat.com>, <poros@redhat.com>, <horms@kernel.org>,
	<vadim.fedorenko@linux.dev>, <linux-kernel@vger.kernel.org>,
	<conor+dt@kernel.org>, <krzk+dt@kernel.org>, <robh@kernel.org>,
	<devicetree@vger.kernel.org>, <pvaanane@redhat.com>
Subject: RE: [PATCH net-next 3/5] dpll: zl3073x: add ref sync and output clock
 type helpers
Thread-Topic: [PATCH net-next 3/5] dpll: zl3073x: add ref sync and output
 clock type helpers
Thread-Index: AQHct8iob6AD3G/6r0Sa4cekTHbRzbXCjsPg
Date: Fri, 27 Mar 2026 15:35:13 +0000
Message-ID:
 <CY5PR11MB64621FF7F9F8E5EF85C7057EEC57A@CY5PR11MB6462.namprd11.prod.outlook.com>
References: <20260319174826.7623-1-ivecera@redhat.com>
 <20260319174826.7623-4-ivecera@redhat.com>
In-Reply-To: <20260319174826.7623-4-ivecera@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR11MB6462:EE_|PH8PR11MB7990:EE_
x-ms-office365-filtering-correlation-id: c6f12b82-c778-4f7d-8226-08de8c167032
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700021|22082099003|56012099003|18092099006|18002099003;
x-microsoft-antispam-message-info:
 70uR41iM7pWG5iaxyiifcp3cXg1mmpAtfF8yLuo+yCIsh8xYO2+V33dNBkOAWMwX1m1GIQ6qNkNvu01HAfBi0d1KDVYV/or3qrjeqbjmc2I197YsFY0uXzPn762gcTF9s/yxwrkTeNptW9VORdfnscKePjOV8aQ/EvHHPNWiW+l8nOs6jJu6WYJBgpt2zSxWtJGvbQ6qg1VkHP8sspiJnhTCn/RYkA2t8ykA9C+oGpJWlpR+EgsIK5KsrFS9LXZ2VL4dpuaE8cEXzJ/ztw79/HTUC1l+4dhXRB3GgIq9kwOzT79GNXRnX3mvxTiFLwjAlrXe3hOdwtF9bEwr7oaZspR9RevKVsbErgJGbl/VI4XpGCEBGf0WJcTRXnTCfF4f2T+m4lA9LUxjTW4Do6k/eFQjPTbJVM8S19h0pXHceaBwAbS2gzXKvtySdnFZkeklP3CriB5WpVHzG5aiarn9wdszDb0mZvfkXVczfI7Qfnyj2K12T+qQsXQAEh1/A/NnvZMBfgDsmevy2aPQiPJamlzqn+RRGh6aRE6gXvbwBqt/HBfb2A/4t5NcvxFw51l8cdsj0EM1iwtfvvOw1CDk+xK07PB8B3bJfU2K6tp50KA8S/TO1Q7ThhcPmLjdvtXq+V2qj50rv16pj9d6q2SA7XZop3z1/dqBevTm8zK7C/axDryS0pfOsf9j5kLDI7FWcswMD1t57O1c5bcSWcZmdKEMSMiSCRyjk5vnRR0R3B6uX0o/oE49v5CVPjzOG5M4mZhNtbXXNb7QBC1hg+lK7NAx3oAENFfhUWAYFt6KsWg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6462.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700021)(22082099003)(56012099003)(18092099006)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?DNsoP6mqsPUL8LC3up+5qfm8kC8u0apDtfDyS5qSzvh9o9bOgUyQi8NQCdi3?=
 =?us-ascii?Q?V0glrEgLvgBJLFGQ/7y6tLDRH6Ca/YDXTG9yg/csGHdUVmgnmcH3ajz8EF5h?=
 =?us-ascii?Q?foqRCA468zvDeWt6vEQJ4wuy6LyXWAIJ2eUp9kKg6WHBjZFo3O4ljGsU050T?=
 =?us-ascii?Q?YN4hBBMxb/17QqJPC2TVEOD96atNNtbiXLtgfvroBWrmZz2HhXtYOFJspYEC?=
 =?us-ascii?Q?YcU6rgFDlLV5+LW7wLnyM0k5+Y/synvoyqXig/BRZSYalTFGyu8HGyt+L670?=
 =?us-ascii?Q?PdNEjaYDhYh7RwdMWYBu6772qmhIkfGnxt1pA2FKWVjs7KgjlNYRZajENV5+?=
 =?us-ascii?Q?LVFtL2ujGJEBVZ1gTQN2eNIOD8/EGLppYh/K57yOxI3NVWUYc0/wUmldpyIJ?=
 =?us-ascii?Q?Ozh2rd7PlKOuQBd7dP14PjBBsEYjgG4/3UcjR6kxLnX1WuACCJfXQFL78Ytq?=
 =?us-ascii?Q?DzII/hXKNSE2mFLjOOYKrqQAn83mRDdRMc4EToITITpYBSrpWCjtDBi1UYjC?=
 =?us-ascii?Q?an2f9YQCJEMTlKuw/k4ewZNcW2nrsMXOv+NY1nM9ZfHE0fFAVrtfBI/hPZCt?=
 =?us-ascii?Q?21i45CdN1ZQ0XEC8WtY67FmRCqjKoUuHUOiLEOJRN+LNwtOVwGhKGFtpcckk?=
 =?us-ascii?Q?SQ8k+BcYp2M8UrNhEUGZvGyMYDhYhJqygYGrSO/KcZUT0HarP08PgnxpPIJ0?=
 =?us-ascii?Q?xzv7VVog2dQnNqVuOyG/h9FZcvhhzNTDGWk4UlaiXQ+VaCnhT4C13qEjHGM1?=
 =?us-ascii?Q?PQNYHcNxFfrGcyE/jGr4osWBWeVwMrGLT6dlUv3x9QJDcJnGN2TbLavn4T8p?=
 =?us-ascii?Q?u4pu+Bhm5BEcGFPwSCjjXjY6iWaLM6PkiZl2qyST9gSgnpGAsr9FnoeB8nJ5?=
 =?us-ascii?Q?83eaO7vBBhhVjsY1WWtdbG+8b/fJk4UDhgjYcQ/LVUN//rWu029kGIk3pt+4?=
 =?us-ascii?Q?jCe2pC8Z+vnT3Erwt8wQ9x8OgaoOdJwB0he+2CDftNNbqX3GY2bCFPnAbTkI?=
 =?us-ascii?Q?tTklWfoyR6ffE6ZYFTjTXnOeeNygpYVabvDDQRfYRGIzLtCK5Vc4OFCY22oA?=
 =?us-ascii?Q?M25Frikc0l5JitVpIcsaVCbEvDtNjF3QbJdWQoxLUqMQb9GGFDKAQzmIWnBF?=
 =?us-ascii?Q?LsWOgswVKJM5Gh0GsCBTYGAZf/G/kuc4T7C6CUjgFtSLa0T0xmQmlmjOOYin?=
 =?us-ascii?Q?hSWyUijw68/c5ug5yJg3Tk4bvkwMmPzvtCfZc8QZDHWHYr9MEfxog4a9hcj3?=
 =?us-ascii?Q?foYbMSu/j9hFwGrDtYsJGv89YArQwPqR78TrcqrCXpKZqYhAwcKgcuGpTewK?=
 =?us-ascii?Q?+l8AhNS2XH7RnSy1j/1Kis4+E1NQEOQmRza3lvhHNdoQ1CjXztBfqYEy+ADY?=
 =?us-ascii?Q?pXvp3vW+QxqieB5BpT4yiFoUKLG8oJbSgnAn645GwIgkIRo0whPcHa/456f7?=
 =?us-ascii?Q?HNW+Dvemd39nklJEbQP5m2+8hToTpvEPu7uRzbUBjxPjmNi+UCZ4i+maiXiV?=
 =?us-ascii?Q?EGXwp1trIWKBJx1F2L+6HdyMbRWFvTsnwVrEfgIZ8VXuXmI+3a19DX1OOcHX?=
 =?us-ascii?Q?AcEIjdSB3OPaReiNUGCeL0Heq78tV4lWYEdPYhVvtrMZE2vL46Ha2CMwUKwb?=
 =?us-ascii?Q?Fy4sZM0Y1x/sNGg++e7W3EvkziECX7110lmRgsfdZcEOJajUyeUZRr8F1DsL?=
 =?us-ascii?Q?LZYFSOcFKpVwRduQy0cf3q1Ciqpcbtt62sNWMA+bjrWj1W/wkUuR7ZWu9+eh?=
 =?us-ascii?Q?549tLMUIAAaraQt6h/9bM43mk5AFdfk=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c6f12b82-c778-4f7d-8226-08de8c167032
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2026 15:35:13.2429
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iCv57QDuTO7xJufsFA0hwFJgGw3QIcFfcXxAS6yDSol0/koQ3u7LjH9WiYSl7KfL75A8WPH12F3pv2IPDmjR0Fvmskl2Iqi/8zNH+Rg87/Y=
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
	TAGGED_FROM(0.00)[bounces-272603-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[CY5PR11MB6462.namprd11.prod.outlook.com:mid,linux.dev:email,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,resnulli.us:email,microchip.com:dkim,microchip.com:email]
X-Rspamd-Queue-Id: B4092346E36
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
Subject: [PATCH net-next 3/5] dpll: zl3073x: add ref sync and output clock =
type helpers

EXTERNAL EMAIL: Do not click links or open attachments unless you know the =
content is safe

Add ZL_REF_SYNC_CTRL_MODE_REFSYNC_PAIR and ZL_REF_SYNC_CTRL_PAIR register d=
efinitions.

Add inline helpers to get and set the sync control mode and sync pair field=
s of the reference sync control register:

  zl3073x_ref_sync_mode_get/set() - ZL_REF_SYNC_CTRL_MODE field
  zl3073x_ref_sync_pair_get/set() - ZL_REF_SYNC_CTRL_PAIR field

Add inline helpers to get and set the clock type field of the output mode r=
egister:

  zl3073x_out_clock_type_get/set() - ZL_OUTPUT_MODE_CLOCK_TYPE field

Convert existing esync callbacks to use the new helpers.

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/dpll/zl3073x/dpll.c | 24 ++++++++-----------  drivers/dpll/zl3073x=
/out.h  | 22 ++++++++++++++++++  drivers/dpll/zl3073x/ref.h  | 46 +++++++++=
++++++++++++++++++++++++++++
 drivers/dpll/zl3073x/regs.h |  2 ++
 4 files changed, 80 insertions(+), 14 deletions(-)

diff --git a/drivers/dpll/zl3073x/dpll.c b/drivers/dpll/zl3073x/dpll.c inde=
x 79ef62d69a32d..276f0a92db0b1 100644
--- a/drivers/dpll/zl3073x/dpll.c
+++ b/drivers/dpll/zl3073x/dpll.c
@@ -137,7 +137,7 @@ zl3073x_dpll_input_pin_esync_get(const struct dpll_pin =
*dpll_pin,
        esync->range =3D esync_freq_ranges;
        esync->range_num =3D ARRAY_SIZE(esync_freq_ranges);

-       switch (FIELD_GET(ZL_REF_SYNC_CTRL_MODE, ref->sync_ctrl)) {
+       switch (zl3073x_ref_sync_mode_get(ref)) {
        case ZL_REF_SYNC_CTRL_MODE_50_50_ESYNC_25_75:
                esync->freq =3D ref->esync_n_div =3D=3D ZL_REF_ESYNC_DIV_1H=
Z ? 1 : 0;
                esync->pulse =3D 25;
@@ -173,8 +173,7 @@ zl3073x_dpll_input_pin_esync_set(const struct dpll_pin =
*dpll_pin,
        else
                sync_mode =3D ZL_REF_SYNC_CTRL_MODE_50_50_ESYNC_25_75;

-       ref.sync_ctrl &=3D ~ZL_REF_SYNC_CTRL_MODE;
-       ref.sync_ctrl |=3D FIELD_PREP(ZL_REF_SYNC_CTRL_MODE, sync_mode);
+       zl3073x_ref_sync_mode_set(&ref, sync_mode);

        if (freq) {
                /* 1 Hz is only supported frequency now */ @@ -578,7 +577,7=
 @@ zl3073x_dpll_output_pin_esync_get(const struct dpll_pin *dpll_pin,
        const struct zl3073x_synth *synth;
        const struct zl3073x_out *out;
        u32 synth_freq, out_freq;
-       u8 clock_type, out_id;
+       u8 out_id;

        out_id =3D zl3073x_output_pin_out_get(pin->id);
        out =3D zl3073x_out_state_get(zldev, out_id); @@ -601,8 +600,7 @@ z=
l3073x_dpll_output_pin_esync_get(const struct dpll_pin *dpll_pin,
        esync->range =3D esync_freq_ranges;
        esync->range_num =3D ARRAY_SIZE(esync_freq_ranges);

-       clock_type =3D FIELD_GET(ZL_OUTPUT_MODE_CLOCK_TYPE, out->mode);
-       if (clock_type !=3D ZL_OUTPUT_MODE_CLOCK_TYPE_ESYNC) {
+       if (zl3073x_out_clock_type_get(out) !=3D=20
+ ZL_OUTPUT_MODE_CLOCK_TYPE_ESYNC) {
                /* No need to read esync data if it is not enabled */
                esync->freq =3D 0;
                esync->pulse =3D 0;
@@ -635,8 +633,8 @@ zl3073x_dpll_output_pin_esync_set(const struct dpll_pin=
 *dpll_pin,
        struct zl3073x_dpll_pin *pin =3D pin_priv;
        const struct zl3073x_synth *synth;
        struct zl3073x_out out;
-       u8 clock_type, out_id;
        u32 synth_freq;
+       u8 out_id;

        out_id =3D zl3073x_output_pin_out_get(pin->id);
        out =3D *zl3073x_out_state_get(zldev, out_id); @@ -648,15 +646,13 @=
@ zl3073x_dpll_output_pin_esync_set(const struct dpll_pin *dpll_pin,
        if (zl3073x_out_is_ndiv(&out))
                return -EOPNOTSUPP;

-       /* Select clock type */
+       /* Update clock type in output mode */
        if (freq)
-               clock_type =3D ZL_OUTPUT_MODE_CLOCK_TYPE_ESYNC;
+               zl3073x_out_clock_type_set(&out,
+                                         =20
+ ZL_OUTPUT_MODE_CLOCK_TYPE_ESYNC);
        else
-               clock_type =3D ZL_OUTPUT_MODE_CLOCK_TYPE_NORMAL;
-
-       /* Update clock type in output mode */
-       out.mode &=3D ~ZL_OUTPUT_MODE_CLOCK_TYPE;
-       out.mode |=3D FIELD_PREP(ZL_OUTPUT_MODE_CLOCK_TYPE, clock_type);
+               zl3073x_out_clock_type_set(&out,
+                                         =20
+ ZL_OUTPUT_MODE_CLOCK_TYPE_NORMAL);

        /* If esync is being disabled just write mailbox and finish */
        if (!freq)
diff --git a/drivers/dpll/zl3073x/out.h b/drivers/dpll/zl3073x/out.h index =
edf40432bba5f..660889c57bffa 100644
--- a/drivers/dpll/zl3073x/out.h
+++ b/drivers/dpll/zl3073x/out.h
@@ -42,6 +42,28 @@ const struct zl3073x_out *zl3073x_out_state_get(struct z=
l3073x_dev *zldev,  int zl3073x_out_state_set(struct zl3073x_dev *zldev, u8=
 index,
                          const struct zl3073x_out *out);

+/**
+ * zl3073x_out_clock_type_get - get output clock type
+ * @out: pointer to out state
+ *
+ * Return: clock type of given output (ZL_OUTPUT_MODE_CLOCK_TYPE_*)  */=20
+static inline u8 zl3073x_out_clock_type_get(const struct zl3073x_out=20
+*out) {
+       return FIELD_GET(ZL_OUTPUT_MODE_CLOCK_TYPE, out->mode); }
+
+/**
+ * zl3073x_out_clock_type_set - set output clock type
+ * @out: pointer to out state
+ * @type: clock type (ZL_OUTPUT_MODE_CLOCK_TYPE_*)  */ static inline=20
+void zl3073x_out_clock_type_set(struct zl3073x_out *out, u8 type) {
+       FIELD_MODIFY(ZL_OUTPUT_MODE_CLOCK_TYPE, &out->mode, type); }
+
 /**
  * zl3073x_out_signal_format_get - get output signal format
  * @out: pointer to out state
diff --git a/drivers/dpll/zl3073x/ref.h b/drivers/dpll/zl3073x/ref.h index =
06d8d4d97ea26..09fab97a71d7e 100644
--- a/drivers/dpll/zl3073x/ref.h
+++ b/drivers/dpll/zl3073x/ref.h
@@ -106,6 +106,52 @@ zl3073x_ref_freq_set(struct zl3073x_ref *ref, u32 freq=
)
        return 0;
 }

+/**
+ * zl3073x_ref_sync_mode_get - get sync control mode
+ * @ref: pointer to ref state
+ *
+ * Return: sync control mode (ZL_REF_SYNC_CTRL_MODE_*)  */ static=20
+inline u8 zl3073x_ref_sync_mode_get(const struct zl3073x_ref *ref) {
+       return FIELD_GET(ZL_REF_SYNC_CTRL_MODE, ref->sync_ctrl); }
+
+/**
+ * zl3073x_ref_sync_mode_set - set sync control mode
+ * @ref: pointer to ref state
+ * @mode: sync control mode (ZL_REF_SYNC_CTRL_MODE_*)  */ static inline=20
+void zl3073x_ref_sync_mode_set(struct zl3073x_ref *ref, u8 mode) {
+       FIELD_MODIFY(ZL_REF_SYNC_CTRL_MODE, &ref->sync_ctrl, mode); }
+
+/**
+ * zl3073x_ref_sync_pair_get - get sync pair reference index
+ * @ref: pointer to ref state
+ *
+ * Return: paired reference index
+ */
+static inline u8
+zl3073x_ref_sync_pair_get(const struct zl3073x_ref *ref) {
+       return FIELD_GET(ZL_REF_SYNC_CTRL_PAIR, ref->sync_ctrl); }
+
+/**
+ * zl3073x_ref_sync_pair_set - set sync pair reference index
+ * @ref: pointer to ref state
+ * @pair: paired reference index
+ */
+static inline void
+zl3073x_ref_sync_pair_set(struct zl3073x_ref *ref, u8 pair) {
+       FIELD_MODIFY(ZL_REF_SYNC_CTRL_PAIR, &ref->sync_ctrl, pair); }
+
 /**
  * zl3073x_ref_is_diff - check if the given input reference is differentia=
l
  * @ref: pointer to ref state
diff --git a/drivers/dpll/zl3073x/regs.h b/drivers/dpll/zl3073x/regs.h inde=
x 5ae50cb761a97..d425dc67250fe 100644
--- a/drivers/dpll/zl3073x/regs.h
+++ b/drivers/dpll/zl3073x/regs.h
@@ -213,7 +213,9 @@
 #define ZL_REG_REF_SYNC_CTRL                   ZL_REG(10, 0x2e, 1)
 #define ZL_REF_SYNC_CTRL_MODE                  GENMASK(2, 0)
 #define ZL_REF_SYNC_CTRL_MODE_REFSYNC_PAIR_OFF 0
+#define ZL_REF_SYNC_CTRL_MODE_REFSYNC_PAIR     1
 #define ZL_REF_SYNC_CTRL_MODE_50_50_ESYNC_25_75        2
+#define ZL_REF_SYNC_CTRL_PAIR                  GENMASK(7, 4)

 #define ZL_REG_REF_ESYNC_DIV                   ZL_REG(10, 0x30, 4)
 #define ZL_REF_ESYNC_DIV_1HZ                   0
--
2.52.0


