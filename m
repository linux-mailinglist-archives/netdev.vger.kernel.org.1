Return-Path: <netdev+bounces-272601-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iEsHIJekxmk4NQUAu9opvQ
	(envelope-from <netdev+bounces-272601-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 16:39:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CC35B346E10
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 16:39:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 58AFB30056E0
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 15:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4382B2BE05A;
	Fri, 27 Mar 2026 15:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="XknRnkeC"
X-Original-To: netdev@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010011.outbound.protection.outlook.com [52.101.61.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A56723EAB7;
	Fri, 27 Mar 2026 15:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774625642; cv=fail; b=NJVUbIO48kAaMeGRgVib26laVYqT3eebVW0TddscsONcCWqyhROP87gnVM4oS6oYrUykWLfhFZyh05UwucArcJcOxjQ8/PPIBnIYxCBa04thMccs38BwqANRJvvJk/laV2tU+XmI4Sc6fO5tjl73YjvpkH2yJNKwicYumh2Ci60=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774625642; c=relaxed/simple;
	bh=Dv5RlzeWyQyWlVpwlY2T8tn/T8XdTf7NCm+wzCIbPwE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tMGf8UKinNYJLtKzIEh1lLTLjOwQulF6J0/W+7JloX6wrveu6HlhJQtj4WC+SgZxf8Hm7S8q84holaqlnqpMSRMwoJl7J5pMJTlZIiXF3L14Bg9XiAkKjviL2FzMdCQknx6iBDxc/d4txnLYwwbugTG8dgZ9ykoNr90SI3YgluQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=XknRnkeC; arc=fail smtp.client-ip=52.101.61.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cm2y8tZbS/Be8e8sc9Kfq1K3EPItyDGBZ4ZW2Z5Pq9KMFgAVsL3MLHJiywkfAg2f6NAbyGsWAQk80P4gastMK2YOJVPodMATj8UBaJoSz/QzZw7MFNE5KxKD4q4Z1oRXKnr6X9PLlyqnq4v2R+tzRyhWOsojh1vjqTg0akaBRhln+tTm9I9X7yYl8YjZAtw5ApBou6Buk652jH7GI2XC75GSixs2o7AFgRb0qFPWIbJbRX+8Ek+vpQe4I1Z//4Hsls1oYn7DukTaXm146W/8wvI4noxhSjT18ExqrrhPd8BInc0XZ7wLrz0nz1m3umEy6lnUd4jEg5umivlZeWBGSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5EmNSVwJ2l3W3TE4uOry0QMRV8+uE2SEUDKx8fXJB8Y=;
 b=SuAJ/GwX8eqOou0kBNW+wgbHzlbfzEZptOMpXPgRRlS9I3pLwrG4qQRNC1iyiH3cNrOCeF3yrdoPsLkES8CcUtZkPw1hWI44WNzDCeda/Fhyhn/+01F7IkcgXB47giRwQ88ADZfmUcklYlJ39ULHGG2KVyIl2qO4Y72loZyVnL/yr9iG8ZRlLxNtyfm8unJIA4L56okXmTHzzlzdYGYu+DzEbqRfjOiGRWhUcAnwYE/ZqNFxpbXCbfKzbJChd43XVvJrPKQM2krZsZlmt1P6JDf+3A0PMEf0K4qCIArFrtHcY4ZoNr6yAR+tWcjd4n1R8oVLlHjXYIx/C+ROr8tsEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5EmNSVwJ2l3W3TE4uOry0QMRV8+uE2SEUDKx8fXJB8Y=;
 b=XknRnkeCLVMz6FrGNXfi0suv7dDM3w6BUXGbZC8ZEMLrfqQGaOSJ30PV7+7JNceVa9sUaKJAeaLdc3dyhc2jnFawoFugeNZepFMLKih1SU1jD8h+9G/NH9muOxKudyrSJxxkVdUWoL/E9bbI0WkGsM7JKgRYOHEO8jyvRayERK6yKwXGLSNCt/t24Xl+Sp8ZYfe95WVl1b1dUKEaeYshbgXeSWvghd0LmtjJXv8H1RoAoDbhy7xPRP4t1dqPRbkN7/08cRwjUmb/n/g0dRf3Iwxk2euks5RdrPPbhTEhDk9PuV82RD+UEJn2aN0ZKamwA3FKEEWQhSUiDxqlWY+hug==
Received: from CY5PR11MB6462.namprd11.prod.outlook.com (2603:10b6:930:32::10)
 by PH8PR11MB7990.namprd11.prod.outlook.com (2603:10b6:510:259::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.6; Fri, 27 Mar
 2026 15:33:57 +0000
Received: from CY5PR11MB6462.namprd11.prod.outlook.com
 ([fe80::10d1:11dd:5088:7559]) by CY5PR11MB6462.namprd11.prod.outlook.com
 ([fe80::10d1:11dd:5088:7559%5]) with mapi id 15.20.9769.004; Fri, 27 Mar 2026
 15:33:57 +0000
From: <Prathosh.Satish@microchip.com>
To: <ivecera@redhat.com>, <netdev@vger.kernel.org>
CC: <arkadiusz.kubalewski@intel.com>, <jiri@resnulli.us>,
	<mschmidt@redhat.com>, <poros@redhat.com>, <horms@kernel.org>,
	<vadim.fedorenko@linux.dev>, <linux-kernel@vger.kernel.org>,
	<conor+dt@kernel.org>, <krzk+dt@kernel.org>, <robh@kernel.org>,
	<devicetree@vger.kernel.org>, <pvaanane@redhat.com>
Subject: RE: [PATCH net-next 4/5] dt-bindings: dpll: add ref-sync-sources
 property
Thread-Topic: [PATCH net-next 4/5] dt-bindings: dpll: add ref-sync-sources
 property
Thread-Index: AQHct8iusP5L10C5tEuxlQvTr3plVrXCjofA
Date: Fri, 27 Mar 2026 15:33:56 +0000
Message-ID:
 <CY5PR11MB6462013101CF73610C80DB92EC57A@CY5PR11MB6462.namprd11.prod.outlook.com>
References: <20260319174826.7623-1-ivecera@redhat.com>
 <20260319174826.7623-5-ivecera@redhat.com>
In-Reply-To: <20260319174826.7623-5-ivecera@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR11MB6462:EE_|PH8PR11MB7990:EE_
x-ms-office365-filtering-correlation-id: 35b1d90a-f9c9-44d0-2808-08de8c1642cb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info:
 sOxw0xrIXvBM0mCOJan2ktQRFDgFXK4DnCk5DPyC+uTXLXcylQ8PoJrCeTSF4IE7LF5S+m1b0GT9xSTJRVlEZhBg4hUQ8AAI68Rvpjb+UH5NF3co4mpWzeVQUFcz5X22w/aRSAe2ZUD6TkfN4uKaIQdp2yDWN+//5uMUAhnA0gvkZtBAH96J71zk1Rnlt8jj4eMv9jtQXc9gCQdXcLRwanqq6L8DThRED9WTo/U8TSrgqEuijPkbaH718PJ3ZUA49i1sGqjHXLyRAI10DqRXOgVNr3sK1JzGHyJ+HfX6Qv5eSAiNy5FbFvD7MPxGoBRXH/aAap9lW5YUni75Nn7osDQEG04qKCZCoYtWZF+mob8FaEVSGfjJjWCxM9zJ87wN+RIaWOxD0u9XeSWTamrwlhaWiuVn8m6evBV1XZedvoLeRPYafQotr5og5xrdbK8zT7YEj4pijANg/YRugEosi4OwWZpVckyNCgqBHv5n3eYzGkR1yOX3RXoTTnean2wDqFsyElWiRMiQY4ShHNkljjVpYFp0G9WT7YI1DD9XMd8xd4zMkob4sDbscQyNDslvici6zG8UB+JBxITRYnWWnsT5/Pzh5NeJkjPVXo274W2zqQNLGcCsD3ttwUPNKj3YTQ1gqlSyXSUBTNDm7KvKFvKZqgBfs1cH32pxymWxFJQhymnGKGik6YoNaQdu7YtjI4JPn6w9AtcYz/en+y7Sl3n6E6YL8Eo+pqgPkGUDEBirZbZW12vwp3nVoPlmMdiK3TiEaePgCjM6czX7deVsuqp0o4n/W4Lciq/CO9Ob1vc=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6462.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700021)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?s05iX2UD0pfWeE5sIOlSi7WSfNP36rsZdNw6i0/MHs2RanWgTlsYR8hWZI7z?=
 =?us-ascii?Q?f8hapsQ2amDlcaukQUBRtNBIA4k+yR5Hn+4ELCuauOad0/tnGZGWn16qTan+?=
 =?us-ascii?Q?B9Lg1ZB45zBrCwFJgUjLlwdXD5ik+hn2dtkLmnFgrxApKoAMbBg7g/hDvTta?=
 =?us-ascii?Q?Xsqy6RNj9j2RZeGFJH9mA2bkmMQakQv13pFZd+BpIU81/W1czv4+QhnleLaM?=
 =?us-ascii?Q?WHEJTv9nxmfRCAwlhl1JJ+E2vu5Or+CC2DvdD1Mvn9zRhx/RwycThp3Anf/i?=
 =?us-ascii?Q?srLJSHQ6DSPgIaREshMOrYbTV36Y7F/VBAvlTGbXZvdfdjsHIN30a6nPzrrK?=
 =?us-ascii?Q?DKfTkl8dsOjFlyifzk9Xf9wyDBxsS4Fay7R9ckYtN0drKlhiYLrTheWz+RCG?=
 =?us-ascii?Q?JJBa2ZBzhlBCinIGApMGVL6WI1ZWzKJiJWxkMNJJ0PCdsokV+G7wGkzIA4yr?=
 =?us-ascii?Q?Z1rsxw6BQicn+QfcFdPxrKCZRUlxpemKY4+beNfxGJkt5BqZuI82Bo0SMoRm?=
 =?us-ascii?Q?XYSs8smwbmA/cfjx2N1+Sbf8XqTsg1/9nqgAQBDcnupNpShZQ4oTi8Ou8T0N?=
 =?us-ascii?Q?W0r/z0UWpXQP3B3UN1iXzGJx57xfxU1Ev/q3Za4CN+YTmJ3iU5nNPQzdvsds?=
 =?us-ascii?Q?3moYKH4kwJ4tTKr7Tq1t5CulL84Ol5hI40Qtogl04nIPccI/dvNffdkMzBxx?=
 =?us-ascii?Q?LkCJK6nxnGlsxQBxYxMoXtLzXCdY1gOAc4wa7OwlGCbXJfme1kyTjOyjBGmD?=
 =?us-ascii?Q?sX9dqWCSCJ+G9tCpycfh10B7WQfRaAwGmqYG/wfjyP4mLZvsoFWQMhWxTfxt?=
 =?us-ascii?Q?FLBN1I3XrRVEBj5VWkxJdiRhup8RI+5sDIdAhNo2Bcf9q+T12hLfkv0540io?=
 =?us-ascii?Q?9e0U5ePVC+UFcMhh9dxcGK6+807xL6zAJPQKT/YCQHx2S3hEzDJFmf+pbnbI?=
 =?us-ascii?Q?/AbH5fyzrLRqq92OmRzyAEi4VUkn5CowIGpkn2bOa/A1dejG509AhlHLBwVO?=
 =?us-ascii?Q?+QViAH9kz+AE6v0CrrGCNffE0Qa1c8QmuH9voU+3n4YTIXgv1acDRGwGEzCl?=
 =?us-ascii?Q?EcHthB72+gD5rveiKbt9FhB3cMXv5rBH6sHC7sH9VF7TFaKJVH1GbiA2zot7?=
 =?us-ascii?Q?CrlBln0VjnghNZdSUH5o1H6y2kRiOSOXuzOif85SDtYRL5vxDoPr5SJkx+Cm?=
 =?us-ascii?Q?6tu1yTB8UiUmSN/d2A0IA3HZhiWPNe4BhlpWRUJNYq3ykL7p8I3+FD9E5/UZ?=
 =?us-ascii?Q?JDm0GTl0G/yqDj+CgHULoC7QDlN/oyZeI0iOOSMQWG/TbGZHiI7xWpj/XseM?=
 =?us-ascii?Q?QndVkSjde7DZ1l97F20D5/J4SV7hcuS061qRFHeesqgU5SNPRq+uKQaUokw6?=
 =?us-ascii?Q?nB/f75oic45X+ZJEFYjBTax/qGlFzmnnsBelyF7PdbP9/HDXnakbEQtK+0ll?=
 =?us-ascii?Q?d8bCtVIqFFX83pQPykdShe0RHoYrcvXRwN/Ae00wy8i9t8kp0kr6EaoByxng?=
 =?us-ascii?Q?tbKOCDo3cPaefzzO1CBHajIm/rs0eAHMATQq9eJJIYLdgzLZQ1rZ4Vj8WpYb?=
 =?us-ascii?Q?72HjHSV5mAStxQRYMRvbVEMroTwvKUbuZqZkYen2ETLQF2oX4lzdwSV4CCbl?=
 =?us-ascii?Q?eg9Dj2HI8YPUIgOdFVMbRFOAsbP+uIe7+HF+yKEkN5m+Nn17GvkW5nMf0byo?=
 =?us-ascii?Q?LRkdrJX9MGfzGUv6XdI7TdYmuZp6Fnq/0wi5kEc/Faa87Zdh0woBsLDev3qv?=
 =?us-ascii?Q?h7+MTpZmeXU4lSI93XmBI0SK5iQYpn8=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 35b1d90a-f9c9-44d0-2808-08de8c1642cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2026 15:33:57.0453
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c1Ps12cab4LpbOdO1M7Z/nXWFhF9o6oCO/wPyDY7mviyV8+zy+zaV+c3ulmvn0ltfyYBH7ncJMx6GMCnSuUl308Yd8Nx+eyM9tODA4ERMHE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7990
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272601-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CC35B346E10
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
Subject: [PATCH net-next 4/5] dt-bindings: dpll: add ref-sync-sources prope=
rty

EXTERNAL EMAIL: Do not click links or open attachments unless you know the =
content is safe

Add ref-sync-sources phandle-array property to the dpll-pin schema allowing=
 board designers to declare which input pins can serve as sync sources in a=
 Reference-Sync pair.  A Ref-Sync pair consists of a clock reference and a =
low-frequency sync signal where the DPLL locks to the clock but phase-align=
s to the sync reference.

Update both examples in the Microchip ZL3073x binding to demonstrate the ne=
w property with a 1 PPS sync source paired to a clock source.

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 .../devicetree/bindings/dpll/dpll-pin.yaml    | 11 +++++++
 .../bindings/dpll/microchip,zl30731.yaml      | 30 ++++++++++++++-----
 2 files changed, 34 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/dpll/dpll-pin.yaml b/Documen=
tation/devicetree/bindings/dpll/dpll-pin.yaml
index 51db93b77306f..7084f102e274c 100644
--- a/Documentation/devicetree/bindings/dpll/dpll-pin.yaml
+++ b/Documentation/devicetree/bindings/dpll/dpll-pin.yaml
@@ -36,6 +36,17 @@ properties:
     description: String exposed as the pin board label
     $ref: /schemas/types.yaml#/definitions/string

+  ref-sync-sources:
+    description: |
+      List of phandles to input pins that can serve as the sync source
+      in a Reference-Sync pair with this pin acting as the clock source.
+      A Ref-Sync pair consists of a clock reference and a low-frequency
+      sync signal.  The DPLL locks to the clock reference but
+      phase-aligns to the sync reference.
+      Only valid for input pins.  Each referenced pin must be a
+      different input pin on the same device.
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+
   supported-frequencies-hz:
     description: List of supported frequencies for this pin, expressed in =
Hz.

diff --git a/Documentation/devicetree/bindings/dpll/microchip,zl30731.yaml =
b/Documentation/devicetree/bindings/dpll/microchip,zl30731.yaml
index 17747f754b845..fa5a8f8e390cd 100644
--- a/Documentation/devicetree/bindings/dpll/microchip,zl30731.yaml
+++ b/Documentation/devicetree/bindings/dpll/microchip,zl30731.yaml
@@ -52,11 +52,19 @@ examples:
           #address-cells =3D <1>;
           #size-cells =3D <0>;

-          pin@0 { /* REF0P */
+          sync0: pin@0 { /* REF0P - 1 PPS sync source */
             reg =3D <0>;
             connection-type =3D "ext";
-            label =3D "Input 0";
-            supported-frequencies-hz =3D /bits/ 64 <1 1000>;
+            label =3D "SMA1";
+            supported-frequencies-hz =3D /bits/ 64 <1>;
+          };
+
+          pin@1 { /* REF0N - clock source, can pair with sync0 */
+            reg =3D <1>;
+            connection-type =3D "ext";
+            label =3D "SMA2";
+            supported-frequencies-hz =3D /bits/ 64 <10000 10000000>;
+            ref-sync-sources =3D <&sync0>;
           };
         };

@@ -90,11 +98,19 @@ examples:
           #address-cells =3D <1>;
           #size-cells =3D <0>;

-          pin@0 { /* REF0P */
+          sync1: pin@0 { /* REF0P - 1 PPS sync source */
             reg =3D <0>;
-            connection-type =3D "ext";
-            label =3D "Input 0";
-            supported-frequencies-hz =3D /bits/ 64 <1 1000>;
+            connection-type =3D "gnss";
+            label =3D "GNSS_1PPS_IN";
+            supported-frequencies-hz =3D /bits/ 64 <1>;
+          };
+
+          pin@1 { /* REF0N - clock source */
+            reg =3D <1>;
+            connection-type =3D "gnss";
+            label =3D "GNSS_10M_IN";
+            supported-frequencies-hz =3D /bits/ 64 <10000000>;
+            ref-sync-sources =3D <&sync1>;
           };
         };

--
2.52.0


