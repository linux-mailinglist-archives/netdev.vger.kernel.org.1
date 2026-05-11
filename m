Return-Path: <netdev+bounces-286783-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qJ4hH4oeAmocoAEAu9opvQ
	(envelope-from <netdev+bounces-286783-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 20:23:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C387B514509
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 20:23:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 617FF30AE3E9
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 18:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D21FD43E9CD;
	Mon, 11 May 2026 18:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b="cA2gBBNR"
X-Original-To: netdev@vger.kernel.org
Received: from usb-smtp-delivery-120.mimecast.com (usb-smtp-delivery-120.mimecast.com [170.10.151.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E0447CC7F
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 18:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.151.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778523601; cv=none; b=Ye3jSNPnRvdD6Q8MO61uI90QTZWhIiArxk0NoJl8zAykWFAbrfq4BMC7f16o/hWtrBlsaj4F7CbC9eNtrt735EXUw48Cf+PN87ER8ldcH5Q83fXLS8kGjSx46lUoabh0FUlumTSpNcVKA/T8P783XREx2tVbobNBMwHSK/PMmJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778523601; c=relaxed/simple;
	bh=imwdPLyWVfU666u6+151CQWjHENHS4FAour/5FsNrGo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tA6t9ojTbDvfyy87Hq0oK4IIr8a6CfGDN9cu7vyG8LeVMQBclLWWmzFf1fcaZT8TGMW6dRVltaruUaU0BNj7XfIRh+XICT5K7MlnwA5r+IpeOheCdp6iSN0ndOKdt7J2lI4WWDuVrEt7GizJUvVX5uBcTLKfFmBApT5lDCjYrgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com; spf=pass smtp.mailfrom=onsemi.com; dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b=cA2gBBNR; arc=none smtp.client-ip=170.10.151.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onsemi.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onsemi.com;
	s=mimecast20250127; t=1778523597;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=gwi4NkLOqaelWi4giu5jiX0ceWKQk6TzuiG/YFiRfZE=;
	b=cA2gBBNRLReiIrrcBDsbuC39HK9Fc6H2Zq9CMR+fb9H/y7FLOh4i+VAyGAaIs7FaBdAx41
	tTQngy9WRLOm+TsgkVvfCk2hKISZPclskOS25/5BivbDf+GuGAnMjZBliEz+kQ3nqVoQmh
	kMw90/sQ5a3vAOt/WPt8vriG3Evh3a+8jpCZNObklD5QFbF0t2EpA/EakL2ZnJoT6xhziS
	N9/YpPOMO5YxXq2dgAoqiR0I9r1DmAvDfLmxsavRaA3PB7MuosOLHqEwup/dmFc50JY2Mt
	BKVegv6/pw1+RJMr3NDpwieS/cZDyUjpgDdCkrYKLTvYVPlAKmrhH4F4e9V8VA==
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012069.outbound.protection.outlook.com [52.101.53.69]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id usb-mta-23-jmTbdsihOlaQC3VAriI_jA-1; Mon,
 11 May 2026 11:19:52 -0700
X-MC-Unique: jmTbdsihOlaQC3VAriI_jA-1
X-Mimecast-MFC-AGG-ID: jmTbdsihOlaQC3VAriI_jA_1778523587
Received: from CY8PR02MB9249.namprd02.prod.outlook.com (2603:10b6:930:9c::17)
 by CO6PR02MB8786.namprd02.prod.outlook.com (2603:10b6:303:141::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 18:19:43 +0000
Received: from CY8PR02MB9249.namprd02.prod.outlook.com
 ([fe80::e437:4ba8:6506:4cda]) by CY8PR02MB9249.namprd02.prod.outlook.com
 ([fe80::e437:4ba8:6506:4cda%3]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 18:19:43 +0000
From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
To: Piergiorgio Beruto <Pier.Beruto@onsemi.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v2 8/9] onsemi: s2500: Add driver support for TS2500
 MAC-PHY
Thread-Topic: [PATCH net-next v2 8/9] onsemi: s2500: Add driver support for
 TS2500 MAC-PHY
Thread-Index: AdzhcbEAp6Owv179R1mImunkqBeYBA==
Date: Mon, 11 May 2026 18:19:43 +0000
Message-ID: <CY8PR02MB924948C0BB8611D5A2618D3283382@CY8PR02MB9249.namprd02.prod.outlook.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR02MB9249:EE_|CO6PR02MB8786:EE_
x-ms-office365-filtering-correlation-id: b5fccb8f-9cb9-4feb-d413-08deaf89e015
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|56012099003|18002099003|18092099006|38070700021|21026099003|21046099003|3023799003|11063799003
x-microsoft-antispam-message-info: OZB3NAB349A3MWmc/fWeDs0zB2a2UkrPINsgDqnazjG8a8HmKCJIAomcsPUsbDKyjq/U9Tpnydk8WP12Q07+sHDQe3dhzMCHIO1efNwHoR2RKlrBgApPWncXX0Lz7wpiDL0/IYgqw5Af2a+EFpY4RPYYTuH/paA+S3SvAT09Pq1B3lT0HT9lCrtYvXgK8JyaVihhR/jL8AMlcEpo9SOsgMm4iHut1lCvMygUf9DLe8dSJRhHUTyR9VJAbKf1WfL1izEPyZX5ohTcDjIRM8R02oOTvM5Wq92gUuAK2Bf0CAkxD+OcUQj9WVLd4aedI60dbepaUi8VCH0ZlsakPxNAKkj0Pks8e51ldEe9sKNYLiT+dQyVZ+VG8ewmOaEe8DNlMFUtJcSYKLhGr+Bf13GBeqRPaBZX4UyoiNJmew89mcnp0zNW8X4g/1tl93fXUwc45/h7HkcowCoRDa1wvBRoWgKoPD0bo+EnahyGDqtVHr+JJ9wkmysqnLXmINXwt+H4iNtqNBJ9YQhUfXLJMufyY6gWcNX2hUJb8BbbGv6Ilj4ayQsTKOkuA6n3sRKld+9iyXDoYx9n9g3H3+j3NjYQqoOUsNR2QIIUgjPswqK2sxesSw8zRDvKKEc1PlnVEusRT7JJq3Bc5s86l/Y9eKjT93Hd/avPcSfk9Z3q/OdxOEA3vfXAxGAIvzHe30ctB0vRs71TwTcMQyzHRZm83C5kyA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR02MB9249.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(18002099003)(18092099006)(38070700021)(21026099003)(21046099003)(3023799003)(11063799003);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EDl0IucyoRdmPWSH+QkAs8PC9AZgdx5ZpP5425AxXmRlanu0s1M3y+TocFtA?=
 =?us-ascii?Q?TTewPll/y4OyI0KvODej4xZiL17ncaxJ4HF+tYmKOe7hCSRcS/Mmma5S2cmu?=
 =?us-ascii?Q?9x+V7nYGkYbzE3qFzBwDEoW/gJqpblyIXnYg5YfUK2Y4ZI9PdL1Ct+bjpP/a?=
 =?us-ascii?Q?o4YwZ9ejz7aTZhCMjVGByTMPebIAZbhWJwkvIf01mTqsPlLl9piMI2mX89c8?=
 =?us-ascii?Q?XjqRmmZsDY4dWyels+QN+jiAcxftx9KHwnoT6STNmGReznIFwcQB5gyS3Hrm?=
 =?us-ascii?Q?OXLHaW9Xb2Cx8TLRtdbc4QC1tC0q3EghcaIxmFulujlzPeJfpiD4IgAMLRMT?=
 =?us-ascii?Q?/7KbQihuUSTkTbl63rEJNk8rBb5ZTTlZyQOl4yx+surE05lI108LdI2Ga/Bf?=
 =?us-ascii?Q?uF1R9+PN6lCq8zNznjkxmhalEa4k3xwkLXYMCyM4xolsJqeId4oqUXKvNduS?=
 =?us-ascii?Q?V0bQbApedRDjuv7jOjPDiqWOaACOi5zxza36PrLjC8tq9FNt6DxVzzUZHME1?=
 =?us-ascii?Q?pAwSPqm5RGJDpGs2ACFquXLxe0icVjgCcCLC850NtiX672qSgdKgp8lxnQvH?=
 =?us-ascii?Q?dTgYbz8cp9BQb+2W2tzMl3tllxEsfqbP4xNqACVwkPrC7BbPrF+Y4Y2+5ntD?=
 =?us-ascii?Q?opyak7HJQQUg0TmJOCl72YRPfods3F2iXobi2BDlmo8tKFyW7zJtP3dh540y?=
 =?us-ascii?Q?FlgXD1oIjy7KxCliLeu5K5TbACXVnNtRYj9ZvqBqy0BMhuNUX2et73dEIbWz?=
 =?us-ascii?Q?JAS7blMK8Am04YxyEdw1v1K0voa8Bnk+gSuVRL3ZlffxlpDVS4Xgc914cCmb?=
 =?us-ascii?Q?wMgl0yZ6JBsjeodNfAS+gId9zrUjdJAhCCMB4o6qeKqKnbqMrTqOileq3dHJ?=
 =?us-ascii?Q?sM+6wAK0IfvSBQviLNKu5ZEgidlxlxg9okKMQB+qYxKexJtcZxT9P882mecr?=
 =?us-ascii?Q?z0AFz220uUSydl2AkO/bgSw1bx9j+yWjV6fPjiijejKaBqBZw4eEbepQmMTs?=
 =?us-ascii?Q?25DXwIPUT7TPo4DsNMd1/eEk3tBWtHNN+T+4BY7oh9jcd6Gg/RoVPTUAV9AY?=
 =?us-ascii?Q?ZnzddAEY0c/9tc1jSQ/iYIuQ6X6y8xxtq6eU8+e9cqkjQTTpL5/WIdzL27KR?=
 =?us-ascii?Q?dPxvK1Hst97XkMOs4PSgINHl/aJaK0ME5YXEc2L9xR0AKe7M/orQY77fRrUk?=
 =?us-ascii?Q?N0EEQjUAdxU0I/PjiFtWRnwhNdJVYABnr5+ifTVjbX3gsWCZfXdzXa1RGXac?=
 =?us-ascii?Q?2Px6ZM3x4LhM0yRJtU07vNnZyDIs5E2FNiXWwks+3zLcPYkp3Y70KNlANFft?=
 =?us-ascii?Q?ysyHcnQW1oq0wyU5zlsIIgoVl37l8VZIEz/4r2tLeltcA2qCqXszXY2x1ovV?=
 =?us-ascii?Q?sZFP6ZO1UEOg0C63Fijc23SJlzM7lpcMxOpnRzW6huIgV0+BH62GC8vzBVf6?=
 =?us-ascii?Q?p/D+SnYAr7t+X03odX3dmUrLUeZNCFnuwsgTqVSM2EAZXQ1v6EqoQvzq5Mw/?=
 =?us-ascii?Q?qM116DAktVXNlwIbLeMNqr2OU4lQ7rpTJFbhiwjuQ70DXLwfu9yNhlnmGPTK?=
 =?us-ascii?Q?8LvxclsrQPooFisjzhx/RzbsQp3FAOvfPUzCfbROo0YUcnJ6Z45PICqz9N6Q?=
 =?us-ascii?Q?lIWEcknd76BblH68/Wdze05cxnye9FF26/TSdDY20eGfsp/hKX0FeXBXu56i?=
 =?us-ascii?Q?CAZzQPT4BsZYOseKFBzayhrnf5m4sKruoVjpzquq9trV1l80yQeGPmMbFAhH?=
 =?us-ascii?Q?2JPRF7Z5Qefmf2gerwc5DZ9ciZbInNw=3D?=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: KG6wLUkxxbyaRjOxbdwd6sfo8vHXAnaoUNg/TF02IB31IzBSYLbNkoiVKKufXlA59siy2/ef9nD/Z64VDwdib61ohZBUNKkQg+SJdtGrdyTMOEdJw7v0PVGabXeHs/CW6hYPE7cd2/L7PjXMxw6k7qqXCtXZqlIXju49B61EC4mqt/803xv0ZrOfG2NHa2e/yVErCFrlcPeTu1WN3xKKnzkGtTVlhELgm4hJXgOeKoDA6USLrQ19McIac8TIxeZJrDPvZ3/sfVhLQbQP7KTcyGNftiZWO5aBPBM7mXc1n8uZDAQkBrdg6YAvcJit1KxWaX6PVh2Ihg5i3ggMKzP4JQ==
X-OriginatorOrg: onsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR02MB9249.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5fccb8f-9cb9-4feb-d413-08deaf89e015
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2026 18:19:43.7722
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04e1674b-7af5-4d13-a082-64fc6e42384c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RjxcgdS1s71fH2y0llh1FJSsEsZzyDL9i5r+PA4kMAl62HSBvSAJin+EulMjzR9kKk5euF5358HifsKwiFD2y5i7+CDRwLNhobz9lE0pnno=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR02MB8786
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: TMJrEHWL7emQ-grSQSrCBsXJzX5MYRqH68iGNKp3lo4_1778523587
X-Mimecast-Originator: onsemi.com
Content-Language: en-US
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: C387B514509
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[onsemi.com,reject];
	R_DKIM_ALLOW(-0.20)[onsemi.com:s=mimecast20250127];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286783-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[onsemi.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Selvamani.Rajagopal@onsemi.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[onsemi.com:email,onsemi.com:url,onsemi.com:dkim,CY8PR02MB9249.namprd02.prod.outlook.com:mid,linaro.org:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,trustedfirmware.org:email]
X-Rspamd-Action: no action

Support for onsemi's S2500, 802.3 cg compliant Ethernet
transceiver with integrated MAC-PHY. Works with
Open Alliance TC6 framework.

Updated MAINTAINERS file

Signed-off-by: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
---
 MAINTAINERS                                   |   7 +
 drivers/net/ethernet/Kconfig                  |   1 +
 drivers/net/ethernet/Makefile                 |   1 +
 drivers/net/ethernet/onsemi/Kconfig           |  21 +
 drivers/net/ethernet/onsemi/Makefile          |   7 +
 drivers/net/ethernet/onsemi/s2500/Kconfig     |  21 +
 drivers/net/ethernet/onsemi/s2500/Makefile    |   7 +
 .../net/ethernet/onsemi/s2500/s2500_ethtool.c | 674 +++++++++++++++++
 .../net/ethernet/onsemi/s2500/s2500_hw_def.h  | 255 +++++++
 .../net/ethernet/onsemi/s2500/s2500_main.c    | 698 ++++++++++++++++++
 drivers/net/ethernet/onsemi/s2500/s2500_ptp.c | 247 +++++++
 11 files changed, 1939 insertions(+)
 create mode 100644 drivers/net/ethernet/onsemi/Kconfig
 create mode 100644 drivers/net/ethernet/onsemi/Makefile
 create mode 100644 drivers/net/ethernet/onsemi/s2500/Kconfig
 create mode 100644 drivers/net/ethernet/onsemi/s2500/Makefile
 create mode 100644 drivers/net/ethernet/onsemi/s2500/s2500_ethtool.c
 create mode 100644 drivers/net/ethernet/onsemi/s2500/s2500_hw_def.h
 create mode 100644 drivers/net/ethernet/onsemi/s2500/s2500_main.c
 create mode 100644 drivers/net/ethernet/onsemi/s2500/s2500_ptp.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 6ed1e1e5f..f75269202 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19947,6 +19947,13 @@ S:=09Supported
 W:=09http://www.onsemi.com
 F:=09drivers/net/phy/ncn*
=20
+ONSEMI S2500 10BASE-T1S MACPHY ETHERNET DRIVER
+M:=09Piergiorgio Beruto <pier.beruto@onsemi.com>
+M:=09Selva Rajagopal <selvamani.rajagopal@onsemi.com>
+L:=09netdev@vger.kernel.org
+S:=09Maintained
+F:=09drivers/net/ethernet/onsemi/s2500/s2500_*
+
 OP-TEE DRIVER
 M:=09Jens Wiklander <jens.wiklander@linaro.org>
 L:=09op-tee@lists.trustedfirmware.org (moderated for non-subscribers)
diff --git a/drivers/net/ethernet/Kconfig b/drivers/net/ethernet/Kconfig
index b8f70e2a1..a42656120 100644
--- a/drivers/net/ethernet/Kconfig
+++ b/drivers/net/ethernet/Kconfig
@@ -134,6 +134,7 @@ source "drivers/net/ethernet/8390/Kconfig"
 source "drivers/net/ethernet/nvidia/Kconfig"
 source "drivers/net/ethernet/nxp/Kconfig"
 source "drivers/net/ethernet/oki-semi/Kconfig"
+source "drivers/net/ethernet/onsemi/Kconfig"
=20
 config ETHOC
 =09tristate "OpenCores 10/100 Mbps Ethernet MAC support"
diff --git a/drivers/net/ethernet/Makefile b/drivers/net/ethernet/Makefile
index 57344fec6..38527c249 100644
--- a/drivers/net/ethernet/Makefile
+++ b/drivers/net/ethernet/Makefile
@@ -71,6 +71,7 @@ obj-$(CONFIG_NET_VENDOR_NI) +=3D ni/
 obj-$(CONFIG_NET_VENDOR_NVIDIA) +=3D nvidia/
 obj-$(CONFIG_LPC_ENET) +=3D nxp/
 obj-$(CONFIG_NET_VENDOR_OKI) +=3D oki-semi/
+obj-$(CONFIG_NET_VENDOR_ONSEMI) +=3D onsemi/
 obj-$(CONFIG_ETHOC) +=3D ethoc.o
 obj-$(CONFIG_NET_VENDOR_PASEMI) +=3D pasemi/
 obj-$(CONFIG_NET_VENDOR_QLOGIC) +=3D qlogic/
diff --git a/drivers/net/ethernet/onsemi/Kconfig b/drivers/net/ethernet/ons=
emi/Kconfig
new file mode 100644
index 000000000..8dd3a3f07
--- /dev/null
+++ b/drivers/net/ethernet/onsemi/Kconfig
@@ -0,0 +1,21 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# onsemi network device configuration
+#
+
+config NET_VENDOR_ONSEMI
+=09bool "onsemi network devices"
+=09help
+=09  If you have a network card belonging to this class, say Y.
+
+=09  Note that the answer to this question doesn't directly affect the
+=09  kernel: saying N will just cause the configurator to skip all
+=09  the questions about onsemi ethernet devices. If you say Y, you
+          will be asked for your specific card in the following questions.
+
+if NET_VENDOR_ONSEMI
+
+source "drivers/net/ethernet/onsemi/s2500/Kconfig"
+
+endif # NET_VENDOR_ONSEMI
+
diff --git a/drivers/net/ethernet/onsemi/Makefile b/drivers/net/ethernet/on=
semi/Makefile
new file mode 100644
index 000000000..f3d4eb154
--- /dev/null
+++ b/drivers/net/ethernet/onsemi/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Makefile for the onsemi network device drivers.
+#
+
+obj-$(CONFIG_S2500_MACPHY) +=3D s2500/
+
diff --git a/drivers/net/ethernet/onsemi/s2500/Kconfig b/drivers/net/ethern=
et/onsemi/s2500/Kconfig
new file mode 100644
index 000000000..22b0afad7
--- /dev/null
+++ b/drivers/net/ethernet/onsemi/s2500/Kconfig
@@ -0,0 +1,21 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# onsemi S2500 Driver Support
+#
+
+if NET_VENDOR_ONSEMI
+
+config S2500_MACPHY
+=09tristate "S2500 support"
+=09depends on SPI
+=09select NCN26000_PHY
+=09select OA_TC6
+=09help
+=09  Support for the onsemi TS2500 MACPHY Ethernet chip.
+          It works under the framework that conform to OPEN Alliance
+          10BASE-T1x Serial Interface specification.
+
+          To compile this driver as a module, choose M here. The module wi=
ll be
+          called s2500.
+
+endif # NET_VENDOR_ONSEMI
diff --git a/drivers/net/ethernet/onsemi/s2500/Makefile b/drivers/net/ether=
net/onsemi/s2500/Makefile
new file mode 100644
index 000000000..61ec705cd
--- /dev/null
+++ b/drivers/net/ethernet/onsemi/s2500/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Makefile for the onsemi network device drivers.
+#
+obj-$(CONFIG_S2500_MACPHY) :=3D s2500.o
+s2500-objs :=3D s2500_main.o s2500_ethtool.o s2500_ptp.o
+
diff --git a/drivers/net/ethernet/onsemi/s2500/s2500_ethtool.c b/drivers/ne=
t/ethernet/onsemi/s2500/s2500_ethtool.c
new file mode 100644
index 000000000..892b0f632
--- /dev/null
+++ b/drivers/net/ethernet/onsemi/s2500/s2500_ethtool.c
@@ -0,0 +1,674 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright 2026 Semiconductor Components Industries, LLC ("onsemi").
+ * onsemi's S2500 10BASE-T1S MAC-PHY driver
+ */
+
+#include "s2500_hw_def.h"
+#include <linux/ethtool.h>
+#include <linux/completion.h>
+#include <linux/mii.h>
+#include <linux/phy.h>
+
+#define S2500_NUM_REGS=09=09=0938
+#define S2500_REGDUMP_LEN=09=09(sizeof(u32) * (S2500_NUM_REGS * 2))
+
+#define S2500_LB_ETH_P=09=09=090x88B5
+#define S2500_LB_PAYLOAD_LEN=09=0964
+#define S2500_LB_DATA_SIGNATURE=09=090xC0DEFADE
+#define S2500_LB_DATA_PATTERN=09=090xA5
+#define S2500_LB_TEST_DATA_OFFSET=098
+#define S2500_LB_TEST_FRAMES=09=0920
+#define S2500_LB_PASS_PERCENT=09=0990
+#define S2500_LB_CAPTURE_TIMEOUT_MS=09500
+#define S2500_LB_FRAME_GAP_US=09=091000
+
+struct s2500_lb_counters {
+=09u32 tx_frames;
+=09u32 rx_frames;
+};
+
+struct s2500_lb_capture {
+=09struct net_device *ndev;
+=09struct completion done;
+=09const char *test_name;
+=09struct packet_type pt;
+=09u32 expected_frames;
+=09u32 received_frames;
+=09u32 expected_seq;
+=09u32 payload_len;
+=09/* Protect the callback */
+=09spinlock_t lock;
+=09bool failed;
+};
+
+static u32 phy_addr_list[S2500_NUM_REGS] =3D {
+=09(0x4 << 16) | 0x8000,
+=09(0x4 << 16) | 0x8001,
+=09(0x4 << 16) | 0x8002,
+=09(0x4 << 16) | 0x8003,
+=09(0x4 << 16) | 0x8004,
+=09(0x4 << 16) | 0x8007,
+=09(0x4 << 16) | 0xCC01,
+=09(0x4 << 16) | 0xCC02,
+=09(0x4 << 16) | 0xCC03,
+=09(0x4 << 16) | 0xCC04,
+=09(0x4 << 16) | 0xCD00,
+=09(0x4 << 16) | 0xCD01,
+=09(0x4 << 16) | 0xCD02,
+=09(0x4 << 16) | 0xD000,
+=09(0x4 << 16) | 0xD001,
+=09(0x4 << 16) | 0xD100,
+=09(0x4 << 16) | 0xD101,
+=09(0xC << 16) | 0x10,
+=09(0xC << 16) | 0x11,
+=09(0xC << 16) | 0x12,
+=09(0xC << 16) | 0x1000,
+=09(0xC << 16) | 0x1001,
+=09(0xC << 16) | 0x1002,
+=09(0xC << 16) | 0x1003,
+=09(0xC << 16) | 0x1005,
+=09(0xC << 16) | 0x1010,
+=09(0xC << 16) | 0x1011,
+=09(0xC << 16) | 0x1012,
+=09(0xC << 16) | 0x1013,
+=09(0xC << 16) | 0x1014,
+=09(0xC << 16) | 0x1015,
+=09(0xC << 16) | 0x1016,
+=09(0xC << 16) | 0x1017,
+=09(0xC << 16) | 0x1018,
+=09(0xC << 16) | 0x1019,
+=09(0xC << 16) | 0x101A,
+=09(0xC << 16) | 0x101B,
+=09(0xC << 16) | 0x101C,
+};
+
+static const char s2500_stat_strings[][ETH_GSTRING_LEN] =3D {
+=09"tx-bytes-ok",
+=09"tx-frames",
+=09"tx-broadcast-frames",
+=09"tx-multicast-frames",
+=09"tx-64-frames",
+=09"tx-65-127-frames",
+=09"tx-128-255-frames",
+=09"tx-256-511-frames",
+=09"tx-512-1023-frames",
+=09"tx-1024-1518-frames",
+=09"tx-underrun-errors",
+=09"tx-single-collision",
+=09"tx-multiple-collision",
+=09"tx-excessive-collision",
+=09"tx-deferred-frames",
+=09"tx-carrier-sense-errors",
+=09"rx-bytes-ok",
+=09"rx-frames",
+=09"rx-broadcast-frames",
+=09"rx-multicast-frames",
+=09"rx-64-frames",
+=09"rx-65-127-frames",
+=09"rx-128-255-frames",
+=09"rx-256-511-frames",
+=09"rx-512-1023-frames",
+=09"rx-1024-1518-frames",
+=09"rx-runt",
+=09"rx-too-long-frames",
+=09"rx-crc-errors",
+=09"rx-symbol-errors",
+=09"rx-alignment-errors",
+=09"rx-busy-drop-frames",
+=09"rx-mismatch-drop-frames",
+=09"ts_frames",
+};
+
+#define S2500_STATS_LEN ARRAY_SIZE(s2500_stat_strings)
+static_assert(S2500_STATS_LEN =3D=3D S2500_STATS_NUM);
+
+#define S2500_TESTS_LEN 2
+
+static const char s2500_test_strings[][ETH_GSTRING_LEN] =3D {
+=09"MAC loopback",
+=09"PHY loopback",
+};
+
+#define STAT_REG_OFFSET(x) ((S2500_REG_MAC_ST##x) - \
+=09=09=09   S2500_REG_MAC_FIRST_STAT)
+
+static void s2500_update_mac_stats(struct s2500_info *priv)
+{
+=09u64 *data =3D priv->stats_data;
+=09u32 *regs, *rptr;
+=09int ret;
+
+=09regs =3D kmalloc_array(S2500_NUMBER_OF_STAT_REGS, sizeof(u32), GFP_KERN=
EL);
+=09if (!regs)
+=09=09return;
+
+=09ret =3D oa_tc6_read_registers(priv->tc6, S2500_REG_MAC_STOCTECTSTXL,
+=09=09=09=09    regs, S2500_NUMBER_OF_STAT_REGS);
+=09if (ret)
+=09=09goto out;
+
+=09rptr =3D regs;
+
+=09/* TX bytes is a 64-bit register that spans over two 32-bit regs
+=09 * note: HW does auto-freeze when reading LSB and un-freeze on MSB
+=09 */
+=09*(data++) +=3D ((u64)*rptr) | (((u64)*(rptr + 1)) << 32);
+
+=09/* run until the next 64-bit register */
+=09for (rptr +=3D 2; (rptr - regs) < STAT_REG_OFFSET(OCTECTSRXL); ++rptr)
+=09=09*(data++) +=3D *rptr;
+
+=09/* RX bytes is a 64-bit register that spans over two 32-bit regs
+=09 * note: HW does auto-freeze when reading LSB and un-freeze on MSB
+=09 */
+=09*(data++) +=3D ((u64)*rptr) | (((u64)*(rptr + 1)) << 32);
+
+=09for (rptr +=3D 2; (rptr - regs) < S2500_NUMBER_OF_STAT_REGS; ++rptr)
+=09=09*(data++) +=3D *rptr;
+=09priv->stats_data[S2500_STATS_NUM - 1] =3D priv->ts_frames;
+out:
+=09kfree(regs);
+}
+
+static void s2500_get_drvinfo(struct net_device *ndev,
+=09=09=09      struct ethtool_drvinfo *info)
+{
+=09strscpy(info->driver, DRV_NAME, sizeof(info->driver));
+=09strscpy(info->bus_info, dev_name(&ndev->dev), sizeof(info->bus_info));
+=09strscpy(info->version, DRV_VERSION, sizeof(info->version));
+}
+
+static int s2500_ethtool_set_link_ksettings(struct net_device *ndev,
+=09=09=09=09=09    const struct ethtool_link_ksettings *cmd)
+{
+=09phy_ethtool_ksettings_set(ndev->phydev, cmd);
+=09return 0;
+}
+
+static int s2500_ethtool_get_link_ksettings(struct net_device *ndev,
+=09=09=09=09=09    struct ethtool_link_ksettings *cmd)
+{
+=09phy_ethtool_ksettings_get(ndev->phydev, cmd);
+=09return 0;
+}
+
+static int s2500_get_sset_count(struct net_device *ndev, int sset)
+{
+=09if (sset =3D=3D ETH_SS_STATS)
+=09=09return S2500_STATS_LEN;
+=09else if (sset =3D=3D ETH_SS_TEST)
+=09=09return S2500_TESTS_LEN;
+=09else
+=09=09return -EOPNOTSUPP;
+}
+
+static void s2500_get_strings(struct net_device *ndev, u32 stringset,
+=09=09=09      u8 *buf)
+{
+=09if (stringset =3D=3D ETH_SS_STATS)
+=09=09memcpy(buf, s2500_stat_strings,
+=09=09       S2500_STATS_LEN * ETH_GSTRING_LEN);
+=09else if (stringset =3D=3D ETH_SS_TEST)
+=09=09memcpy(buf, s2500_test_strings,
+=09=09       S2500_TESTS_LEN * ETH_GSTRING_LEN);
+}
+
+static void s2500_get_ethtool_stats(struct net_device *ndev,
+=09=09=09=09    struct ethtool_stats *stats, u64 *data)
+{
+=09struct s2500_info *priv =3D netdev_priv(ndev);
+
+=09s2500_update_mac_stats(priv);
+=09memcpy(data, priv->stats_data, sizeof(priv->stats_data));
+}
+
+static int s2500_get_ts_info(struct net_device *ndev,
+=09=09=09     struct kernel_ethtool_ts_info *ts_info)
+{
+=09struct s2500_info *priv =3D netdev_priv(ndev);
+
+=09if (!priv->ptp_clock)
+=09=09return ethtool_op_get_ts_info(ndev, ts_info);
+
+=09ts_info->so_timestamping =3D SOF_TIMESTAMPING_RAW_HARDWARE |
+=09=09=09=09   SOF_TIMESTAMPING_TX_HARDWARE |
+=09=09=09=09   SOF_TIMESTAMPING_RX_HARDWARE;
+=09ts_info->phc_index =3D ptp_clock_index(priv->ptp_clock);
+=09ts_info->tx_types =3D BIT(HWTSTAMP_TX_ON);
+=09ts_info->rx_filters =3D BIT(HWTSTAMP_FILTER_ALL);
+=09return 0;
+}
+
+static int s2500_get_regs_len(struct net_device *dev)
+{
+=09return S2500_REGDUMP_LEN;
+}
+
+static void s2500_get_regs(struct net_device *ndev,
+=09=09=09   struct ethtool_regs *regs, void *p)
+{
+=09struct s2500_info *priv =3D netdev_priv(ndev);
+=09u32 *pbuff =3D (u32 *)p;
+=09u32 val, reg;
+=09int ret =3D 0;
+=09int i;
+
+=09regs->version =3D 0;
+=09memset(p, 0, S2500_REGDUMP_LEN);
+
+=09if (!netif_running(ndev))
+=09=09return;
+
+=09for (i =3D 0; i < S2500_NUM_REGS; i++) {
+=09=09val =3D 0;
+=09=09reg =3D phy_addr_list[i];
+=09=09ret =3D oa_tc6_read_register(priv->tc6, reg, &val);
+=09=09if (ret)
+=09=09=09continue;
+=09=09*pbuff++ =3D cpu_to_be32(reg);
+=09=09*pbuff++ =3D cpu_to_be32(val);
+=09}
+}
+
+static void s2500_lb_fill_payload(u8 *payload, u32 seq, u32 payload_len)
+{
+=09u32 sig =3D S2500_LB_DATA_SIGNATURE;
+=09int seq_offset;
+=09u32 i;
+
+=09seq_offset =3D sizeof(sig);
+=09memcpy(payload, &sig, sizeof(sig));
+=09memcpy(&payload[seq_offset], &seq, sizeof(seq));
+
+=09for (i =3D S2500_LB_TEST_DATA_OFFSET; i < payload_len; i++)
+=09=09payload[i] =3D (u8)(S2500_LB_DATA_PATTERN ^ (seq + i));
+}
+
+static bool s2500_lb_payload_valid(const u8 *payload, u32 exp_seq,
+=09=09=09=09   u32 payload_len)
+{
+=09int seq_offset;
+=09u32 sig, seq;
+=09u32 j;
+
+=09if (payload_len < S2500_LB_TEST_DATA_OFFSET)
+=09=09return false;
+
+=09memcpy(&sig, payload, sizeof(sig));
+=09if (sig !=3D S2500_LB_DATA_SIGNATURE)
+=09=09return false;
+
+=09seq_offset =3D sizeof(sig);
+=09memcpy(&seq, &payload[seq_offset], sizeof(seq));
+=09if (seq !=3D exp_seq)
+=09=09return false;
+
+=09for (j =3D S2500_LB_TEST_DATA_OFFSET; j < payload_len; j++) {
+=09=09if (payload[j] !=3D (u8)(S2500_LB_DATA_PATTERN ^ (exp_seq + j)))
+=09=09=09return false;
+=09}
+
+=09return true;
+}
+
+static void s2500_log_lb_failure(struct net_device *ndev,
+=09=09=09=09 const char *test_name, const char *reason)
+{
+=09netdev_err(ndev, "%s loopback test failed: %s\n", test_name, reason);
+}
+
+static void s2500_lb_capture_init(struct s2500_lb_capture *cap,
+=09=09=09=09  struct net_device *ndev,
+=09=09=09=09  const char *test_name,
+=09=09=09=09  u32 expected_frames)
+{
+=09init_completion(&cap->done);
+=09spin_lock_init(&cap->lock);
+=09cap->ndev =3D ndev;
+=09cap->test_name =3D test_name;
+=09cap->expected_frames =3D expected_frames;
+=09cap->received_frames =3D 0;
+=09cap->expected_seq =3D 0;
+=09cap->payload_len =3D S2500_LB_PAYLOAD_LEN;
+=09cap->failed =3D false;
+=09memset(&cap->pt, 0, sizeof(cap->pt));
+=09cap->pt.type =3D cpu_to_be16(S2500_LB_ETH_P);
+=09cap->pt.dev =3D ndev;
+=09cap->pt.func =3D NULL;
+}
+
+static int s2500_lb_capture_rx(struct sk_buff *skb, struct net_device *dev=
,
+=09=09=09       struct packet_type *pt,
+=09=09=09       struct net_device *orig_dev)
+{
+=09struct s2500_lb_capture *cap =3D container_of(pt,
+=09=09=09=09=09=09    struct s2500_lb_capture,
+=09=09=09=09=09=09    pt);
+=09u8 payload[S2500_LB_PAYLOAD_LEN];
+=09unsigned long flags;
+=09bool failed =3D false;
+=09u32 frame_seq;
+
+=09(void)dev;
+
+=09if (orig_dev !=3D cap->ndev)
+=09=09goto out_free;
+
+=09if (skb->len !=3D cap->payload_len) {
+=09=09s2500_log_lb_failure(cap->ndev, cap->test_name,
+=09=09=09=09     "RX frame length mismatch");
+=09=09failed =3D true;
+=09} else if (skb_copy_bits(skb, 0, payload, cap->payload_len) !=3D 0) {
+=09=09s2500_log_lb_failure(cap->ndev, cap->test_name,
+=09=09=09=09     "unable to copy RX payload");
+=09=09failed =3D true;
+=09}
+
+=09spin_lock_irqsave(&cap->lock, flags);
+=09frame_seq =3D cap->expected_seq;
+=09if (failed || cap->failed ||
+=09    cap->received_frames >=3D cap->expected_frames) {
+=09=09if (cap->received_frames >=3D cap->expected_frames)
+=09=09=09s2500_log_lb_failure(cap->ndev, cap->test_name,
+=09=09=09=09=09     "extra frame received");
+=09=09cap->failed =3D true;
+=09=09complete_all(&cap->done);
+=09=09spin_unlock_irqrestore(&cap->lock, flags);
+=09=09goto out_free;
+=09}
+
+=09if (!s2500_lb_payload_valid(payload, frame_seq,
+=09=09=09=09    cap->payload_len)) {
+=09=09s2500_log_lb_failure(cap->ndev, cap->test_name,
+=09=09=09=09     "payload mismatch");
+=09=09cap->failed =3D true;
+=09=09complete_all(&cap->done);
+=09=09spin_unlock_irqrestore(&cap->lock, flags);
+=09=09goto out_free;
+=09}
+
+=09if (frame_seq !=3D cap->received_frames) {
+=09=09netdev_err(cap->ndev,
+=09=09=09   "out-of-order RX frame, expected %u got %u\n",
+=09=09=09   cap->received_frames, frame_seq);
+=09=09cap->failed =3D true;
+=09=09complete_all(&cap->done);
+=09=09spin_unlock_irqrestore(&cap->lock, flags);
+=09=09goto out_free;
+=09}
+
+=09cap->received_frames++;
+=09cap->expected_seq++;
+=09if (cap->received_frames =3D=3D cap->expected_frames)
+=09=09complete_all(&cap->done);
+=09spin_unlock_irqrestore(&cap->lock, flags);
+
+out_free:
+=09kfree_skb(skb);
+=09return 0;
+}
+
+static int s2500_lb_enable(struct s2500_info *priv, u32 reg, u32 *saved)
+{
+=09int ret;
+=09u32 val;
+
+=09ret =3D oa_tc6_read_register(priv->tc6, reg, &val);
+=09if (ret)
+=09=09return ret;
+
+=09*saved =3D val;
+=09val |=3D BMCR_LOOPBACK;
+
+=09return oa_tc6_write_register(priv->tc6, reg, val);
+}
+
+static int s2500_lb_restore(struct s2500_info *priv, u32 reg, u32 saved)
+{
+=09return oa_tc6_write_register(priv->tc6, reg, saved);
+}
+
+static int s2500_read_lb_counters(struct s2500_info *priv,
+=09=09=09=09  struct s2500_lb_counters *cnt)
+{
+=09int ret;
+
+=09ret =3D oa_tc6_read_register(priv->tc6, S2500_REG_MAC_STFRAMESTXOK,
+=09=09=09=09   &cnt->tx_frames);
+=09if (ret)
+=09=09return ret;
+
+=09ret =3D oa_tc6_read_register(priv->tc6, S2500_REG_MAC_STFRAMESRXOK,
+=09=09=09=09   &cnt->rx_frames);
+=09if (ret)
+=09=09return ret;
+
+=09return 0;
+}
+
+static int s2500_send_lb_frames(struct net_device *ndev, int frame_count,
+=09=09=09=09u16 eth_proto)
+{
+=09struct s2500_info *priv =3D netdev_priv(ndev);
+=09const int payload_len =3D 64;
+=09unsigned char *frame;
+=09struct sk_buff *skb;
+=09int frame_len;
+=09int sent =3D 0;
+=09int ret, i;
+
+=09frame_len =3D ETH_HLEN + payload_len;
+=09for (i =3D 0; i < frame_count; i++) {
+=09=09skb =3D alloc_skb(frame_len + NET_IP_ALIGN, GFP_KERNEL);
+=09=09if (skb)
+=09=09=09skb_reserve(skb, NET_IP_ALIGN);
+=09=09if (!skb)
+=09=09=09break;
+
+=09=09frame =3D skb_put(skb, frame_len);
+=09=09memset(frame, 0xff, ETH_ALEN);
+=09=09memcpy(frame + ETH_ALEN, ndev->dev_addr, ETH_ALEN);
+=09=09frame[12] =3D (u8)((eth_proto >> 8) & 0xff);
+=09=09frame[13] =3D (u8)(eth_proto & 0xff);
+=09=09s2500_lb_fill_payload(frame + ETH_HLEN, i, payload_len);
+
+=09=09skb->dev =3D ndev;
+=09=09skb->protocol =3D htons(eth_proto);
+=09=09skb->priority =3D 0;
+
+=09=09ret =3D oa_tc6_start_xmit(priv->tc6, skb);
+=09=09if (ret =3D=3D NETDEV_TX_OK) {
+=09=09=09sent++;
+=09=09} else {
+=09=09=09netdev_warn(ndev, "TX frame %d failed\n", i);
+=09=09=09kfree_skb(skb);
+=09=09=09break;
+=09=09}
+
+=09=09udelay(S2500_LB_FRAME_GAP_US);
+=09}
+=09return sent;
+}
+
+static void s2500_eval_lb_result(struct net_device *ndev,
+=09=09=09=09 struct ethtool_test *eth_test, u64 *data,
+=09=09=09=09 unsigned int idx,
+=09=09=09=09 const char *test_name,
+=09=09=09=09 const struct s2500_lb_counters *before,
+=09=09=09=09 const struct s2500_lb_counters *after,
+=09=09=09=09 const struct s2500_lb_capture *capture,
+=09=09=09=09 int req_frames,
+=09=09=09=09 int sent_frames)
+{
+=09u64 tx_delta, rx_delta;
+=09bool failed =3D false;
+
+=09tx_delta =3D (after->tx_frames >=3D before->tx_frames) ?
+=09=09  (u64)(after->tx_frames - before->tx_frames) : 0;
+=09rx_delta =3D (after->rx_frames >=3D before->rx_frames) ?
+=09=09  (u64)(after->rx_frames - before->rx_frames) : 0;
+
+=09if (sent_frames < req_frames) {
+=09=09netdev_err(ndev,
+=09=09=09   "%s: transmit failure, sent %d of %d frames\n",
+=09=09=09   test_name, sent_frames, req_frames);
+=09=09failed =3D true;
+=09}
+=09if (tx_delta < (u64)req_frames) {
+=09=09netdev_err(ndev,
+=09=09=09   "%s: TX counter did not increment, delta=3D%llu expected=3D%d\=
n",
+=09=09=09   test_name, tx_delta, req_frames);
+=09=09failed =3D true;
+=09}
+=09if (rx_delta =3D=3D 0) {
+=09=09netdev_err(ndev,
+=09=09=09   "%s: no frames received back\n",
+=09=09=09   test_name);
+=09=09failed =3D true;
+=09} else if (rx_delta * 100 < (u64)req_frames * S2500_LB_PASS_PERCENT) {
+=09=09netdev_err(ndev,
+=09=09=09   "%s: received too few frames, rx delta=3D%llu expected=3D%d\n"=
,
+=09=09=09   test_name, rx_delta, req_frames);
+=09=09failed =3D true;
+=09}
+
+=09if (capture->failed ||
+=09    capture->received_frames !=3D capture->expected_frames) {
+=09=09if (capture->received_frames =3D=3D 0)
+=09=09=09netdev_err(ndev,
+=09=09=09=09   "%s: no received frames captured\n",
+=09=09=09=09   test_name);
+=09=09else if (capture->received_frames !=3D capture->expected_frames)
+=09=09=09netdev_err(ndev,
+=09=09=09=09   "%s: received frame count mismatch, got %u expected %u\n",
+=09=09=09=09   test_name, capture->received_frames, capture->expected_fram=
es);
+=09=09failed =3D true;
+=09}
+
+=09data[idx] =3D failed ? 1 : 0;
+=09if (failed)
+=09=09eth_test->flags |=3D ETH_TEST_FL_FAILED;
+}
+
+static int s2500_run_lb_test(struct net_device *ndev,
+=09=09=09     struct s2500_info *priv,
+=09=09=09     u32 loop_reg, bool use_phy_loopback,
+=09=09=09     const char *test_name,
+=09=09=09     struct ethtool_test *eth_test,
+=09=09=09     u64 *data, unsigned int idx)
+{
+=09struct s2500_lb_counters before;
+=09struct s2500_lb_capture capture;
+=09struct s2500_lb_counters after;
+=09u32 saved_val =3D 0;
+=09long timeout;
+=09int sent;
+=09int ret;
+
+=09s2500_lb_capture_init(&capture, ndev, test_name, S2500_LB_TEST_FRAMES);
+=09capture.pt.func =3D s2500_lb_capture_rx;
+
+=09if (use_phy_loopback)
+=09=09ret =3D phy_loopback(ndev->phydev, true, 0);
+=09else
+=09=09ret =3D s2500_lb_enable(priv, loop_reg, &saved_val);
+=09if (ret) {
+=09=09data[idx] =3D 1;
+=09=09eth_test->flags |=3D ETH_TEST_FL_FAILED;
+=09=09return 0;
+=09}
+
+=09/* First call clears the counters */
+=09ret =3D s2500_read_lb_counters(priv, &before);
+
+=09/* Counter values before starting the test (likely to be 0) */
+=09ret =3D s2500_read_lb_counters(priv, &before);
+=09if (ret) {
+=09=09data[idx] =3D 1;
+=09=09eth_test->flags |=3D ETH_TEST_FL_FAILED;
+=09=09goto restore;
+=09}
+
+=09dev_add_pack(&capture.pt);
+=09sent =3D s2500_send_lb_frames(ndev, S2500_LB_TEST_FRAMES,
+=09=09=09=09    S2500_LB_ETH_P);
+=09timeout =3D wait_for_completion_timeout(&capture.done,
+=09=09=09=09=09      msecs_to_jiffies(S2500_LB_CAPTURE_TIMEOUT_MS));
+=09dev_remove_pack(&capture.pt);
+=09if (!timeout)
+=09=09capture.failed =3D true;
+
+=09ret =3D s2500_read_lb_counters(priv, &after);
+=09if (ret) {
+=09=09data[idx] =3D 1;
+=09=09eth_test->flags |=3D ETH_TEST_FL_FAILED;
+=09=09goto restore;
+=09}
+
+=09s2500_eval_lb_result(ndev, eth_test, data, idx, test_name,
+=09=09=09     &before, &after, &capture,
+=09=09=09     S2500_LB_TEST_FRAMES, sent);
+
+restore:
+=09if (use_phy_loopback)
+=09=09ret =3D phy_loopback(ndev->phydev, false, 0);
+=09else
+=09=09ret =3D s2500_lb_restore(priv, loop_reg, saved_val);
+=09if (ret) {
+=09=09data[idx] =3D 1;
+=09=09eth_test->flags |=3D ETH_TEST_FL_FAILED;
+=09}
+
+=09return 0;
+}
+
+static void s2500_self_test(struct net_device *ndev,
+=09=09=09    struct ethtool_test *eth_test, u64 *data)
+{
+=09struct s2500_info *priv =3D netdev_priv(ndev);
+
+=09if (!priv)
+=09=09return;
+
+=09if (!mutex_trylock(&priv->selftest_lock)) {
+=09=09netdev_warn(ndev, "selftest already running\n");
+=09=09return;
+=09}
+
+=09eth_test->flags &=3D ~ETH_TEST_FL_FAILED;
+=09data[0] =3D 0;
+=09data[1] =3D 0;
+
+=09netif_stop_queue(ndev);
+=09if (eth_test->len < S2500_TESTS_LEN)
+=09=09goto unlock;
+
+=09/* MAC loopback is controlled directly through the PCS loopback bit;
+=09 * PHY loopback is routed through phylib so the PHY driver handles the
+=09 * standard BMCR loopback state transition.
+=09 */
+=09s2500_run_lb_test(ndev, priv, S2500_REG_PCS_CTRL,
+=09=09=09  false, "MAC", eth_test, data, 0);
+=09s2500_run_lb_test(ndev, priv, S2500_REG_PHY_CTRL,
+=09=09=09  true, "PHY", eth_test, data, 1);
+
+unlock:
+=09netif_start_queue(ndev);
+=09mutex_unlock(&priv->selftest_lock);
+}
+
+const struct ethtool_ops s2500_ethtool_ops =3D {
+=09.get_drvinfo        =3D s2500_get_drvinfo,
+=09.get_link           =3D ethtool_op_get_link,
+=09.get_link_ksettings =3D s2500_ethtool_get_link_ksettings,
+=09.set_link_ksettings =3D s2500_ethtool_set_link_ksettings,
+=09.get_sset_count     =3D s2500_get_sset_count,
+=09.get_strings        =3D s2500_get_strings,
+=09.get_ethtool_stats  =3D s2500_get_ethtool_stats,
+=09.get_ts_info        =3D s2500_get_ts_info,
+=09.get_regs_len       =3D s2500_get_regs_len,
+=09.get_regs           =3D s2500_get_regs,
+=09.self_test          =3D s2500_self_test,
+};
+
diff --git a/drivers/net/ethernet/onsemi/s2500/s2500_hw_def.h b/drivers/net=
/ethernet/onsemi/s2500/s2500_hw_def.h
new file mode 100644
index 000000000..fa79a2ee0
--- /dev/null
+++ b/drivers/net/ethernet/onsemi/s2500/s2500_hw_def.h
@@ -0,0 +1,255 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright 2026 Semiconductor Components Industries, LLC ("onsemi").
+ * onsemi's S2500 10BASE-T1S MAC-PHY driver
+ */
+
+#ifndef S2500_HW_DEF_H
+#define S2500_HW_DEF_H
+
+#include <linux/hrtimer.h>
+#include <linux/irq.h>
+#include <linux/irqdomain.h>
+#include <linux/kernel.h>
+#include <linux/netdevice.h>
+#include <linux/phylink.h>
+#include <linux/spi/spi.h>
+#include <linux/oa_tc6.h>
+#include <linux/net_tstamp.h>
+#include <linux/ptp_clock_kernel.h>
+#include <linux/delay.h>
+#include <linux/mutex.h>
+#include <linux/ktime.h>
+#include <linux/errno.h>
+
+#define DRV_NAME=09=09=09"s2500"
+#define DRV_VERSION=09=09=09"1.0.3.1"
+
+#define S2500_N_MCAST_FILTERS=09=093
+
+#define S2500_MODEL_ID=09=090xA7A8
+
+/* Number of stat counters for ethtool */
+#define S2500_STATS_NUM=09=09=0934
+
+/* List of device capabilities */
+#define S2500_CAP_MACADDR=09=09BIT(0)  /* MAC address in hardware */
+#define S2500_CAP_PTP=09=09=09BIT(1)  /* PTP support */
+
+/* S2500 registers */
+
+/* Definitions for MMS defined in Table 6 Open Alliance TC6 standard
+ * that not present in oa_tc6.h
+ */
+#define S2500_OA_TC6_MACPHY_MMS0=090
+#define S2500_OA_TC6_MAC_MMS1=09=091
+#define S2500_OA_TC6_VEND1_MMS12=0912
+
+#define S2500_MMS_MII=09=09=09(S2500_OA_TC6_MACPHY_MMS0 << 16)
+#define S2500_MMS_MAC=09=09=09(S2500_OA_TC6_MAC_MMS1 << 16)
+#define S2500_MMS_PCS=09=09=09(2 << 16)
+#define S2500_MMS_PMDPMA=09=09(3 << 16)
+#define S2500_MMS_VS1=09=09=09(S2500_OA_TC6_VEND1_MMS12 << 16)
+#define S2500_MMS_VS2=09=09=09(4 << 16)
+
+/* SPI OID and model register */
+#define S2500_REG_SPI_PHYID=09=090x1
+
+#define S2500_SPI_PHYID_OUI_SHIFT=0910
+#define S2500_SPI_PHYID_OUI_MASK=09GENMASK(31, S2500_SPI_PHYID_OUI_SHIFT)
+#define S2500_SPI_PHYID_MODEL_SHIFT=094
+#define S2500_SPI_PHYID_MODEL_MASK=09GENMASK(9, S2500_SPI_PHYID_MODEL_SHIF=
T)
+#define S2500_SPI_PHYID_REV_SHIFT=090
+#define S2500_SPI_PHYID_REV_MASK=09GENMASK(3, S2500_SPI_PHYID_REV_SHIFT)
+
+/* SPI configuration register #0 */
+#define S2500_REG_SPI_CFG0=09=09(S2500_MMS_MII + 0x4)
+
+#define S2500_SPI_CFG0_SYNC_BIT=09=09BIT(15)
+#define S2500_SPI_CFG0_TXFCSVE_BIT=09BIT(14)
+#define S2500_SPI_CFG0_CSARFE_BIT=09BIT(13)
+#define S2500_SPI_CFG0_TXCTHRESH_SHIFT=0910
+#define S2500_SPI_CFG0_TXCTHRESH_MASK=09GENMASK(11, S2500_SPI_CFG0_TXCTHRE=
SH_SHIFT)
+#define S2500_SPI_CFG0_TXCTE_BIT=09BIT(9)
+#define S2500_SPI_CFG0_RXCTE_BIT=09BIT(8)
+#define S2500_SPI_CFG0_FTSE_BIT=09=09BIT(7)
+#define S2500_SPI_CFG0_FTSS_BIT=09=09BIT(6)
+#define S2500_SPI_CFG0_PROTE_BIT=09BIT(5)
+#define S2500_SPI_CFG0_SEQE_BIT=09=09BIT(4)
+#define S2500_SPI_CFG0_CPS_SHIFT=090
+#define S2500_SPI_CFG0_CPS_MASK=09=09GENMASK(2, S2500_SPI_CFG0_CPS_SHIFT)
+
+#define S2500_TXCTHRESH_1=09=090x0
+#define S2500_TXCTHRESH_4=09=090x1
+#define S2500_TXCTHRESH_8=09=090x2
+
+#define S2500_CPS_8=09=09=090x3
+#define S2500_CPS_16=09=09=090x4
+#define S2500_CPS_32=09=09=090x5
+#define S2500_CPS_64=09=09=090x6
+
+/* SPI status register #0 */
+#define S2500_REG_SPI_ST0=09=09(S2500_MMS_MII + 8)
+
+#define S2500_SPI_ST0_CDPE_BIT=09=09BIT(12)
+#define S2500_SPI_ST0_TXFCSE_BIT=09BIT(11)
+#define S2500_SPI_ST0_TTSCAC_BIT=09BIT(10)
+#define S2500_SPI_ST0_TTSCAB_BIT=09BIT(9)
+#define S2500_SPI_ST0_TTSCAA_BIT=09BIT(8)
+#define S2500_SPI_ST0_PHYINT_BIT=09BIT(7)
+#define S2500_SPI_ST0_RESETC_BIT=09BIT(6)
+#define S2500_SPI_ST0_HDRE_BIT=09=09BIT(5)
+#define S2500_SPI_ST0_LOFE_BIT=09=09BIT(4)
+#define S2500_SPI_ST0_RXBOE_BIT=09=09BIT(3)
+#define S2500_SPI_ST0_TXBUE_BIT=09=09BIT(2)
+#define S2500_SPI_ST0_TXBOE_BIT=09=09BIT(1)
+#define S2500_SPI_ST0_TXPE_BIT=09=09BIT(0)
+
+/* SPI IRQ enable register #0 (use the S2500_SPI_ST0_*_BIT constants) */
+#define S2500_REG_SPI_IRQM0=09=09(S2500_MMS_MII + 0xc)
+
+/* SPI buffer status register */
+#define S2500_REG_SPI_BUFST=09=090xb
+
+#define S2500_SPI_BUFST_TXC_SHIFT=098
+#define S2500_SPI_BUFST_TXC_MASK=09GENMASK(15, S2500_SPI_BUFST_TXC_SHIFT)
+
+#define S2500_REG_MAC_CONTROL=09=09(S2500_MMS_MAC + 0)
+
+#define S2500_MAC_CONTROL_MCSF_BIT=09BIT(18)
+#define S2500_MAC_CONTROL_ADRF_BIT=09BIT(16)
+#define S2500_MAC_CONTROL_FCSA_BIT=09BIT(8)
+#define S2500_MAC_CONTROL_TXEN_BIT=09BIT(1)
+#define S2500_MAC_CONTROL_RXEN_BIT=09BIT(0)
+
+#define S2500_REG_PHY_CTRL=09=09(S2500_MMS_MII + 0xFF00)
+
+#define S2500_REG_PCS_CTRL=09=09(S2500_MMS_PCS + 0x8F3)
+
+/* MAC address filter registers */
+#define S2500_REG_MAC_ADDRFILTL(n)=09(S2500_MMS_MAC + (16 + 2 * (n)))
+#define S2500_REG_MAC_ADDRFILTH(n)=09(S2500_MMS_MAC + (17 + 2 * (n)))
+#define S2500_REG_MAC_ADDRMASKL(n)=09(S2500_MMS_MAC + (32 + 2 * (n)))
+#define S2500_REG_MAC_ADDRMASKH(n)=09(S2500_MMS_MAC + (33 + 2 * (n)))
+
+#define S2500_MAC_ADDRFILT_EN_BIT=09BIT(31)
+
+/* MAC statistic registers */
+#define S2500_REG_MAC_STOCTECTSTXL=09(S2500_MMS_MAC + 48)
+#define S2500_REG_MAC_STOCTECTSTXH=09(S2500_MMS_MAC + 49)
+#define S2500_REG_MAC_STFRAMESTXOK=09(S2500_MMS_MAC + 50)
+#define S2500_REG_MAC_STBCASTTXOK=09(S2500_MMS_MAC + 51)
+#define S2500_REG_MAC_STMCASTTXOK=09(S2500_MMS_MAC + 52)
+#define S2500_REG_MAC_STFRAMESTX64=09(S2500_MMS_MAC + 53)
+#define S2500_REG_MAC_STFRAMESTX65=09(S2500_MMS_MAC + 54)
+#define S2500_REG_MAC_STFRAMESTX128=09(S2500_MMS_MAC + 55)
+#define S2500_REG_MAC_STFRAMESTX256=09(S2500_MMS_MAC + 56)
+#define S2500_REG_MAC_STFRAMESTX512=09(S2500_MMS_MAC + 57)
+#define S2500_REG_MAC_STFRAMESTX1024=09(S2500_MMS_MAC + 58)
+#define S2500_REG_MAC_STTXUNDEFLOW=09(S2500_MMS_MAC + 59)
+#define S2500_REG_MAC_STSINGLECOL=09(S2500_MMS_MAC + 60)
+#define S2500_REG_MAC_STMULTICOL=09(S2500_MMS_MAC + 61)
+#define S2500_REG_MAC_STEXCESSCOL=09(S2500_MMS_MAC + 62)
+#define S2500_REG_MAC_STDEFERREDTX=09(S2500_MMS_MAC + 63)
+#define S2500_REG_MAC_STCRSERR=09=09(S2500_MMS_MAC + 64)
+#define S2500_REG_MAC_STOCTECTSRXL=09(S2500_MMS_MAC + 65)
+#define S2500_REG_MAC_STOCTECTSRXH=09(S2500_MMS_MAC + 66)
+#define S2500_REG_MAC_STFRAMESRXOK=09(S2500_MMS_MAC + 67)
+#define S2500_REG_MAC_STBCASTRXOK=09(S2500_MMS_MAC + 68)
+#define S2500_REG_MAC_STMCASTRXOK=09(S2500_MMS_MAC + 69)
+#define S2500_REG_MAC_STFRAMESRX64=09(S2500_MMS_MAC + 60)
+#define S2500_REG_MAC_STFRAMESRX65=09(S2500_MMS_MAC + 71)
+#define S2500_REG_MAC_STFRAMESRX128=09(S2500_MMS_MAC + 72)
+#define S2500_REG_MAC_STFRAMESRX256=09(S2500_MMS_MAC + 73)
+#define S2500_REG_MAC_STFRAMESRX512=09(S2500_MMS_MAC + 74)
+#define S2500_REG_MAC_STFRAMESRX1024=09(S2500_MMS_MAC + 75)
+#define S2500_REG_MAC_STRUNTSERR=09(S2500_MMS_MAC + 76)
+#define S2500_REG_MAC_STRXTOOLONG=09(S2500_MMS_MAC + 77)
+#define S2500_REG_MAC_STFCSERRS=09=09(S2500_MMS_MAC + 78)
+#define S2500_REG_MAC_STSYMBOLERRS=09(S2500_MMS_MAC + 79)
+#define S2500_REG_MAC_STALIGNERRS=09(S2500_MMS_MAC + 80)
+#define S2500_REG_MAC_STRXOVERFLOW=09(S2500_MMS_MAC + 81)
+#define S2500_REG_MAC_STRXDROPPED=09(S2500_MMS_MAC + 82)
+
+/* First/last statistic register for sequential access */
+#define S2500_REG_MAC_FIRST_STAT=09S2500_REG_MAC_STOCTECTSTXL
+#define S2500_REG_MAC_LAST_STAT=09=09S2500_REG_MAC_STRXDROPPED
+
+#define S2500_NUMBER_OF_STAT_REGS \
+=09(S2500_REG_MAC_LAST_STAT - S2500_REG_MAC_FIRST_STAT + 1)
+
+/* Permanent MAC address register */
+#define S2500_REG_VS_MACID0=09=09(S2500_MMS_VS1 + 0x1002)
+#define S2500_REG_VS_MACID1=09=09(S2500_MMS_VS1 + 0x1003)
+
+#define S2500_MACID1_UID_SHIFT=09=090
+#define S2500_MACID1_UID_MASK=09=09GENMASK(7, S2500_MACID1_UID_SHIFT)
+
+/* Chip identification register */
+#define S2500_REG_VS_CHIPID=09=09(S2500_MMS_VS1 + 0x1000)
+
+#define S2500_CHIPID_MODEL_SHIFT=0916
+#define S2500_CHIPID_MODEL_MASK=09=09GENMASK(31, S2500_CHIPID_MODEL_SHIFT)
+#define S2500_CHIPID_REVISION_SHIFT=090
+#define S2500_CHIPID_REVISION_MASK=09GENMASK(15, S2500_CHIPID_REVISION_SHI=
FT)
+
+/* MIIM IRQ status register */
+#define S2500_REG_MIIM_IRQ_STATUS=09(S2500_MMS_VS1 + 0x11)
+#define MIIM_IRQ_STATUS_RSTS_SHIFT=0915
+#define MIIM_IRQ_STATUS_RSTS=09=09BIT(MIIM_IRQ_STATUS_RSTS_SHIFT)
+
+/* PTP registers */
+#define S2500_REG_VS_PTP_SEC=09=09(S2500_MMS_VS1 + 0x1010)
+#define S2500_REG_VS_PTP_SETSEC=09=09(S2500_MMS_VS1 + 0x1012)
+#define S2500_REG_VS_PTP_ADJ=09=09(S2500_MMS_VS1 + 0x1014)
+
+/* prototypes / forward declarations */
+extern const struct ethtool_ops s2500_ethtool_ops;
+
+struct s2500_info;
+
+struct s2500_info {
+=09struct device *dev;
+=09struct net_device *ndev;
+
+=09/* model information */
+=09u32 model;
+=09u32 version;
+=09unsigned int capabilities;
+
+=09/* To have atomic set_rx_mode operation */
+=09spinlock_t lock;
+
+=09/* To avoid simultaneous selftest request */
+=09struct mutex selftest_lock;
+
+=09/* To have atomic operation when time is adjusted */
+=09struct mutex ptp_adj_lock;
+=09struct task_struct *thread;
+
+=09/* global state variables */
+=09bool event_pending;
+=09unsigned int ndev_flags;
+=09bool rx_flags_upd;
+
+=09bool tx_fcs_calc;
+
+=09signed long poll_jiff;
+
+=09struct spi_device *spi;
+
+=09/* statistic counters variables */
+=09u64 stats_data[S2500_STATS_NUM];
+
+=09/* PTP related variables */
+=09struct ptp_clock_info ptp_clock_info;
+=09struct ptp_clock *ptp_clock;
+=09u32 ts_frames;
+=09void *tc6;
+};
+
+void s2500_ptp_unregister(struct s2500_info *priv);
+void s2500_ptp_register(struct s2500_info *priv);
+
+#endif /* S2500_HW_DEF_H */
+
diff --git a/drivers/net/ethernet/onsemi/s2500/s2500_main.c b/drivers/net/e=
thernet/onsemi/s2500/s2500_main.c
new file mode 100644
index 000000000..5eb245d65
--- /dev/null
+++ b/drivers/net/ethernet/onsemi/s2500/s2500_main.c
@@ -0,0 +1,698 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright 2026 Semiconductor Components Industries, LLC ("onsemi").
+ * onsemi's S2500 10BASE-T1S MAC-PHY driver
+ */
+
+#include "s2500_hw_def.h"
+
+#include <linux/etherdevice.h>
+#include <linux/if_ether.h>
+#include <linux/irqchip.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/phy.h>
+
+/* S2500 functions & definitions */
+
+#define S2500_STATUS0_MASK=09(S2500_SPI_ST0_CDPE_BIT | \
+=09=09=09=09S2500_SPI_ST0_TXFCSE_BIT | \
+=09=09=09=09S2500_SPI_ST0_TTSCAC_BIT | \
+=09=09=09=09S2500_SPI_ST0_TTSCAB_BIT | \
+=09=09=09=09S2500_SPI_ST0_TTSCAA_BIT | \
+=09=09=09=09S2500_SPI_ST0_RESETC_BIT | \
+=09=09=09=09S2500_SPI_ST0_HDRE_BIT | \
+=09=09=09=09S2500_SPI_ST0_LOFE_BIT | \
+=09=09=09=09S2500_SPI_ST0_RXBOE_BIT | \
+=09=09=09=09S2500_SPI_ST0_TXBUE_BIT | \
+=09=09=09=09S2500_SPI_ST0_TXBOE_BIT | \
+=09=09=09=09S2500_SPI_ST0_TXPE_BIT)
+
+/* Converts a MACPHY ID to a device name */
+static inline const char *s2500_id_to_name(u32 id)
+{
+=09if (id =3D=3D S2500_MODEL_ID)
+=09=09return "S2500";
+=09return "unknown";
+}
+
+/* Initializes the net device MAC address by reading the UID stored
+ * into the device internal non-volatile memory.
+ */
+static int s2500_read_mac_from_nvmem(struct s2500_info *priv)
+{
+=09u8 addr[ETH_ALEN];
+=09u32 mac1 =3D 0;
+=09u32 mac0 =3D 0;
+=09int i, j;
+=09u32 val;
+=09int ret;
+
+=09ret =3D oa_tc6_read_register(priv->tc6, S2500_REG_SPI_PHYID, &val);
+=09if (ret)
+=09=09return ret;
+
+=09val =3D (val & S2500_SPI_PHYID_OUI_MASK) >> S2500_SPI_PHYID_OUI_SHIFT;
+
+=09/* Convert the OID in host byte order */
+=09for (i =3D 2; i >=3D 0; --i) {
+=09=09addr[i] =3D 0;
+=09=09for (j =3D 0; j < 8; ++j) {
+=09=09=09addr[i] |=3D (val & 1) << (7 - j);
+=09=09=09val >>=3D 1;
+=09=09}
+=09}
+
+=09ret =3D oa_tc6_read_register(priv->tc6, S2500_REG_VS_MACID1, &mac1);
+=09if (ret)
+=09=09return ret;
+
+=09ret =3D oa_tc6_read_register(priv->tc6, S2500_REG_VS_MACID0, &mac0);
+=09if (ret)
+=09=09return ret;
+
+=09/* Pre-production parts may have 0 */
+=09if (mac0 =3D=3D 0 && mac1 =3D=3D 0)
+=09=09return -ENXIO;
+
+=09addr[3] =3D mac1 & 0xff;
+=09addr[4] =3D (mac0 >> 8) & 0xff;
+=09addr[5] =3D mac0 & 0xff;
+
+=09__dev_addr_set(priv->ndev, addr, ETH_ALEN);
+=09priv->ndev->addr_assign_type =3D NET_ADDR_PERM;
+
+=09return ret;
+}
+
+/* Writes MAC address to macphy registers */
+static int s2500_set_mac_filter(struct net_device *ndev, const u8 *mac)
+{
+=09struct s2500_info *priv =3D netdev_priv(ndev);
+=09u32 val;
+=09int ret;
+
+=09/* Set unicast address filter */
+=09ret =3D oa_tc6_write_register(priv->tc6, S2500_REG_MAC_ADDRMASKL(0),
+=09=09=09=09    0xffffffff);
+=09if (ret)
+=09=09return ret;
+
+=09ret =3D oa_tc6_write_register(priv->tc6, S2500_REG_MAC_ADDRMASKH(0),
+=09=09=09=09    0xffff);
+=09if (ret)
+=09=09return ret;
+
+=09val =3D ((u32)mac[2] << 24) |
+=09       ((u32)mac[3] << 16) |
+=09       ((u32)mac[4] << 8) |
+=09       ((u32)mac[5]);
+
+=09ret =3D oa_tc6_write_register(priv->tc6, S2500_REG_MAC_ADDRFILTL(0), va=
l);
+=09if (ret)
+=09=09return ret;
+
+=09val =3D S2500_MAC_ADDRFILT_EN_BIT | ((u32)mac[0] << 8) | ((u32)mac[1]);
+
+=09return oa_tc6_write_register(priv->tc6, S2500_REG_MAC_ADDRFILTH(0), val=
);
+}
+
+static int s2500_mac_ctrl_clear_bits(struct s2500_info *priv, u32 in_bits,
+=09=09=09=09     bool clr)
+{
+=09u32 reg =3D S2500_REG_MAC_CONTROL;
+=09u32 rval =3D 0;
+=09int ret;
+
+=09ret =3D oa_tc6_read_register(priv->tc6, reg, &rval);
+=09if (!ret) {
+=09=09u32 wval =3D 0;
+
+=09=09if (clr)
+=09=09=09wval =3D rval & ~in_bits;
+=09=09else
+=09=09=09wval =3D rval | in_bits;
+=09=09if (rval !=3D wval)
+=09=09=09ret =3D oa_tc6_write_register(priv->tc6, reg, wval);
+=09}
+=09return ret;
+}
+
+static int s2500_init(struct s2500_info *priv)
+{
+=09u32 val;
+=09int ret;
+
+=09/* Configure the SPI protocol */
+=09val =3D (S2500_SPI_CFG0_SYNC_BIT) | S2500_SPI_CFG0_RXCTE_BIT |
+=09      (S2500_TXCTHRESH_8 << S2500_SPI_CFG0_TXCTHRESH_SHIFT) |
+=09      (S2500_CPS_64 << S2500_SPI_CFG0_CPS_SHIFT);
+
+=09if (priv->tx_fcs_calc)
+=09=09val |=3D S2500_SPI_CFG0_TXFCSVE_BIT;
+
+=09ret =3D oa_tc6_write_register(priv->tc6, S2500_REG_SPI_CFG0, val);
+=09if (ret)
+=09=09return ret;
+
+=09val =3D (u32)~(S2500_SPI_ST0_RESETC_BIT |
+=09=09     S2500_SPI_ST0_HDRE_BIT | S2500_SPI_ST0_LOFE_BIT |
+=09=09     S2500_SPI_ST0_RXBOE_BIT | S2500_SPI_ST0_TXBOE_BIT |
+=09=09     S2500_SPI_ST0_TXPE_BIT);
+
+=09ret =3D oa_tc6_write_register(priv->tc6, S2500_REG_SPI_IRQM0, val);
+=09if (ret)
+=09=09return ret;
+
+=09/* Read the initial value of TX credits */
+=09ret =3D oa_tc6_read_register(priv->tc6, S2500_REG_SPI_BUFST, &val);
+=09if (ret)
+=09=09return ret;
+
+=09/* Program the source MAC address into the device */
+=09ret =3D s2500_set_mac_filter(priv->ndev, priv->ndev->dev_addr);
+
+=09val =3D S2500_MAC_CONTROL_ADRF_BIT;
+=09if (!priv->tx_fcs_calc)
+=09=09val |=3D S2500_MAC_CONTROL_FCSA_BIT;
+
+=09return s2500_mac_ctrl_clear_bits(priv, val, false);
+}
+
+static void s2500_shutdown(struct s2500_info *priv)
+{
+=09u32 val =3D S2500_MAC_CONTROL_TXEN_BIT | S2500_MAC_CONTROL_RXEN_BIT;
+=09struct net_device *ndev =3D priv->ndev;
+
+=09netif_stop_queue(ndev);
+=09phy_stop(ndev->phydev);
+
+=09s2500_mac_ctrl_clear_bits(priv, val, true);
+}
+
+static int s2500_set_promiscuous_mode(struct s2500_info *priv,
+=09=09=09=09      unsigned int rx_flags)
+{
+=09u32 val =3D S2500_MAC_CONTROL_ADRF_BIT;
+=09bool clr =3D false;
+
+=09if (rx_flags & IFF_PROMISC)
+=09=09clr =3D true;
+=09return s2500_mac_ctrl_clear_bits(priv, val, clr);
+}
+
+static int s2500_set_multicast_mode(struct s2500_info *priv,
+=09=09=09=09    unsigned int rx_flags)
+{
+=09int i, ret =3D 0;
+=09u32 val;
+
+=09if ((rx_flags & IFF_ALLMULTI) ||
+=09    (netdev_mc_count(priv->ndev) > S2500_N_MCAST_FILTERS)) {
+=09=09/* Disable multicast filter */
+=09=09ret =3D s2500_mac_ctrl_clear_bits(priv,
+=09=09=09=09=09=09S2500_MAC_CONTROL_MCSF_BIT,
+=09=09=09=09=09=09true);
+=09=09if (ret)
+=09=09=09return ret;
+
+=09=09/* Accept all multicasts */
+=09=09ret =3D oa_tc6_write_register(priv->tc6,
+=09=09=09=09=09    S2500_REG_MAC_ADDRMASKL(1), 0);
+=09=09if (ret)
+=09=09=09return ret;
+
+=09=09ret =3D oa_tc6_write_register(priv->tc6,
+=09=09=09=09=09    S2500_REG_MAC_ADDRMASKH(1), 0x100);
+=09=09if (ret)
+=09=09=09return ret;
+
+=09=09ret =3D oa_tc6_write_register(priv->tc6,
+=09=09=09=09=09    S2500_REG_MAC_ADDRFILTL(1), 0);
+=09=09if (ret)
+=09=09=09return ret;
+
+=09=09val =3D S2500_MAC_ADDRFILT_EN_BIT | 0x00000100;
+=09=09ret =3D oa_tc6_write_register(priv->tc6,
+=09=09=09=09=09    S2500_REG_MAC_ADDRFILTH(1), val);
+=09} else if (netdev_mc_count(priv->ndev) =3D=3D 0) {
+=09=09/* Enable multicast filter */
+=09=09ret =3D s2500_mac_ctrl_clear_bits(priv,
+=09=09=09=09=09=09S2500_MAC_CONTROL_MCSF_BIT,
+=09=09=09=09=09=09false);
+=09=09if (ret)
+=09=09=09return ret;
+
+=09=09/* Disable filters */
+=09=09for (i =3D 1; i <=3D S2500_N_MCAST_FILTERS; i++) {
+=09=09=09ret =3D oa_tc6_write_register(priv->tc6,
+=09=09=09=09=09=09    S2500_REG_MAC_ADDRFILTH(i),
+=09=09=09=09=09=09    0);
+=09=09=09if (ret)
+=09=09=09=09return ret;
+=09=09}
+=09} else {
+=09=09struct netdev_hw_addr *ha;
+=09=09u32 addrh, addrl;
+
+=09=09/* Disable multicast filter */
+=09=09ret =3D s2500_mac_ctrl_clear_bits(priv,
+=09=09=09=09=09=09S2500_MAC_CONTROL_MCSF_BIT,
+=09=09=09=09=09=09true);
+=09=09if (ret)
+=09=09=09return ret;
+
+=09=09/* Disable filters */
+=09=09for (i =3D 1; i <=3D S2500_N_MCAST_FILTERS; i++) {
+=09=09=09ret =3D oa_tc6_write_register(priv->tc6,
+=09=09=09=09=09=09    S2500_REG_MAC_ADDRFILTH(i),
+=09=09=09=09=09=09    0);
+=09=09=09if (ret)
+=09=09=09=09return ret;
+=09=09}
+
+=09=09i =3D 1;
+=09=09netdev_for_each_mc_addr(ha, priv->ndev) {
+=09=09=09if (i > S2500_N_MCAST_FILTERS)
+=09=09=09=09break;
+
+=09=09=09addrh =3D ((ha->addr[0] << 8) | ha->addr[1] |
+=09=09=09=09 S2500_MAC_ADDRFILT_EN_BIT);
+=09=09=09addrl =3D ((ha->addr[2] << 24) | (ha->addr[3] << 16) |
+=09=09=09=09 (ha->addr[4] << 8) | (ha->addr[5]));
+
+=09=09=09ret =3D oa_tc6_write_register(priv->tc6,
+=09=09=09=09=09=09    S2500_REG_MAC_ADDRFILTH(i),
+=09=09=09=09=09=09    addrh);
+=09=09=09if (ret)
+=09=09=09=09return ret;
+
+=09=09=09ret =3D oa_tc6_write_register(priv->tc6,
+=09=09=09=09=09=09    S2500_REG_MAC_ADDRFILTL(i),
+=09=09=09=09=09=09    addrl);
+=09=09=09if (ret)
+=09=09=09=09return ret;
+
+=09=09=09ret =3D oa_tc6_write_register(priv->tc6,
+=09=09=09=09=09=09    S2500_REG_MAC_ADDRMASKL(i),
+=09=09=09=09=09=09    0xffffffff);
+=09=09=09if (ret)
+=09=09=09=09return ret;
+
+=09=09=09ret =3D oa_tc6_write_register(priv->tc6,
+=09=09=09=09=09=09    S2500_REG_MAC_ADDRMASKH(i),
+=09=09=09=09=09=09    0xffff);
+=09=09=09if (ret)
+=09=09=09=09return ret;
+=09=09=09i++;
+=09=09}
+=09}
+=09return ret;
+}
+
+/* Deferred function for applying RX mode flags in non-atomic context */
+static int s2500_rx_mode_update(struct s2500_info *priv)
+{
+=09unsigned int rx_flags;
+=09unsigned long flags;
+=09int ret;
+
+=09spin_lock_irqsave(&priv->lock, flags);
+
+=09rx_flags =3D priv->ndev_flags;
+=09priv->rx_flags_upd =3D false;
+
+=09spin_unlock_irqrestore(&priv->lock, flags);
+
+=09ret =3D s2500_set_promiscuous_mode(priv, rx_flags);
+=09if (ret)
+=09=09goto out;
+
+=09ret =3D s2500_set_multicast_mode(priv, rx_flags);
+out:
+=09return ret;
+}
+
+static int s2500_ioctl(struct net_device *ndev, struct ifreq *rq, int cmd)
+{
+=09struct s2500_info *priv =3D netdev_priv(ndev);
+=09int ret =3D -EOPNOTSUPP;
+
+=09if (cmd =3D=3D SIOCSHWTSTAMP || cmd =3D=3D SIOCGHWTSTAMP) {
+=09=09if (priv->capabilities & S2500_CAP_PTP)
+=09=09=09ret =3D oa_tc6_hwtstamp_ioctl(priv->tc6, rq, cmd);
+=09} else {
+=09=09ret =3D phy_do_ioctl_running(ndev, rq, cmd);
+=09}
+=09return ret;
+}
+
+static void s2500_set_rx_mode(struct net_device *ndev)
+{
+=09struct s2500_info *priv =3D netdev_priv(ndev);
+=09unsigned long flags;
+
+=09spin_lock_irqsave(&priv->lock, flags);
+
+=09priv->rx_flags_upd =3D true;
+=09priv->ndev_flags =3D ndev->flags;
+
+=09spin_unlock_irqrestore(&priv->lock, flags);
+
+=09if (priv->thread)
+=09=09wake_up_process(priv->thread);
+}
+
+static int s2500_set_mac_address(struct net_device *ndev, void *p)
+{
+=09struct sockaddr *addr =3D p;
+
+=09if (!is_valid_ether_addr(addr->sa_data))
+=09=09return -EADDRNOTAVAIL;
+
+=09eth_hw_addr_set(ndev, addr->sa_data);
+=09return s2500_set_mac_filter(ndev, addr->sa_data);
+}
+
+static netdev_tx_t s2500_start_xmit(struct sk_buff *skb,
+=09=09=09=09    struct net_device *ndev)
+{
+=09struct s2500_info *priv =3D netdev_priv(ndev);
+
+=09if (skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP)
+=09=09priv->ts_frames++;
+
+=09return oa_tc6_start_xmit(priv->tc6, skb);
+}
+
+static void s2500_process_events(struct s2500_info *priv)
+{
+=09u32 val;
+=09int ret;
+
+=09if (!priv->event_pending)
+=09=09return;
+
+=09priv->event_pending =3D false;
+
+=09ret =3D oa_tc6_read_register(priv->tc6, S2500_REG_SPI_ST0, &val);
+=09if (ret) {
+=09=09dev_err(&priv->spi->dev, "Error reading ST0 register");
+=09=09return;
+=09}
+}
+
+static int s2500_thread_fun(void *data)
+{
+=09struct s2500_info *priv =3D data;
+=09bool update_rx_mode =3D false;
+=09unsigned long flags;
+=09signed long tout;
+=09int ret =3D 0;
+
+=09tout =3D priv->poll_jiff;
+
+=09do {
+=09=09if (update_rx_mode) {
+=09=09=09ret =3D s2500_rx_mode_update(priv);
+=09=09=09if (unlikely(ret)) {
+=09=09=09=09dev_err(&priv->spi->dev, "Failed to set new RX mode");
+=09=09=09=09break;
+=09=09=09}
+=09=09}
+
+=09=09if (tout =3D=3D 0) {
+=09=09=09tout =3D priv->poll_jiff;
+
+=09=09=09/* Force checking the status register */
+=09=09=09priv->event_pending =3D true;
+=09=09}
+
+=09=09s2500_process_events(priv);
+
+=09=09spin_lock_irqsave(&priv->lock, flags);
+=09=09__set_current_state(TASK_INTERRUPTIBLE);
+
+=09=09update_rx_mode =3D priv->rx_flags_upd;
+=09=09ret =3D update_rx_mode;
+
+=09=09spin_unlock_irqrestore(&priv->lock, flags);
+
+=09=09if (!ret)
+=09=09=09tout =3D schedule_timeout(tout);
+=09=09else
+=09=09=09set_current_state(TASK_RUNNING);
+=09} while (!kthread_should_stop());
+=09return 0;
+}
+
+static int s2500_open(struct net_device *ndev)
+{
+=09struct s2500_info *priv =3D netdev_priv(ndev);
+=09int ret =3D 0;
+=09u32 val;
+
+=09dev_info(&priv->spi->dev, "%s", "s2500_open");
+=09phy_start(priv->ndev->phydev);
+
+=09priv->thread =3D kthread_run(s2500_thread_fun, priv, DRV_NAME "/%s:%d",
+=09=09=09=09   dev_name(&priv->spi->dev),
+=09=09=09=09   spi_get_chipselect(priv->spi, 0));
+
+=09if (IS_ERR(priv->thread)) {
+=09=09ret =3D PTR_ERR(priv->thread);
+=09} else {
+=09=09val =3D S2500_MAC_CONTROL_TXEN_BIT | S2500_MAC_CONTROL_RXEN_BIT;
+=09=09ret =3D s2500_mac_ctrl_clear_bits(priv, val, false);
+
+=09=09netif_start_queue(priv->ndev);
+=09}
+=09return ret;
+}
+
+static int s2500_stop(struct net_device *ndev)
+{
+=09struct s2500_info *priv =3D netdev_priv(ndev);
+
+=09dev_info(&priv->spi->dev, "%s", "s2500_stop");
+
+=09s2500_shutdown(priv);
+
+=09kthread_stop(priv->thread);
+=09priv->thread =3D NULL;
+
+=09return 0;
+}
+
+static int s2500_hwtstamp_get(struct net_device *ndev,
+=09=09=09      struct kernel_hwtstamp_config *cfg)
+{
+=09struct s2500_info *priv =3D netdev_priv(ndev);
+
+=09if (!priv->ptp_clock) {
+=09=09cfg->tx_type =3D 0;
+=09=09cfg->rx_filter =3D 0;
+=09} else {
+=09=09oa_tc6_hwtstamp_get(priv->tc6, cfg);
+=09}
+=09return 0;
+}
+
+static int s2500_hwtstamp_set(struct net_device *ndev,
+=09=09=09      struct kernel_hwtstamp_config *cfg,
+=09=09=09      struct netlink_ext_ack *extack)
+{
+=09struct s2500_info *priv =3D netdev_priv(ndev);
+
+=09if (!netif_running(ndev))
+=09=09return -EIO;
+=09if (!priv->ptp_clock)
+=09=09return -EPROTONOSUPPORT;
+=09return oa_tc6_hwtstamp_set(priv->tc6, cfg);
+}
+
+static const struct net_device_ops s2500_netdev_ops =3D {
+=09.ndo_open            =3D s2500_open,
+=09.ndo_stop            =3D s2500_stop,
+=09.ndo_start_xmit      =3D s2500_start_xmit,
+=09.ndo_set_mac_address =3D s2500_set_mac_address,
+=09.ndo_set_rx_mode     =3D s2500_set_rx_mode,
+=09.ndo_eth_ioctl       =3D s2500_ioctl,
+=09.ndo_hwtstamp_get    =3D s2500_hwtstamp_get,
+=09.ndo_hwtstamp_set    =3D s2500_hwtstamp_set,
+};
+
+static int s2500_update_model(struct s2500_info *priv)
+{
+=09u32 val =3D 0;
+=09int ret;
+
+=09ret =3D oa_tc6_read_register(priv->tc6, S2500_REG_VS_CHIPID, &val);
+=09if (ret)
+=09=09return ret;
+
+=09priv->capabilities =3D S2500_CAP_MACADDR;
+=09priv->version =3D val & S2500_CHIPID_REVISION_MASK;
+=09priv->version >>=3D S2500_CHIPID_REVISION_SHIFT;
+
+=09priv->model =3D val & S2500_CHIPID_MODEL_MASK;
+=09priv->model >>=3D S2500_CHIPID_MODEL_SHIFT;
+=09if (priv->model =3D=3D S2500_MODEL_ID)
+=09=09priv->capabilities |=3D S2500_CAP_PTP;
+=09else
+=09=09ret =3D -ENODEV;
+=09dev_info(&priv->spi->dev, "Macphy model %s, version %u\n",
+=09=09 s2500_id_to_name(priv->model), priv->version);
+=09return ret;
+}
+
+static int s2500_probe(struct spi_device *spi)
+{
+=09struct device *dev =3D &spi->dev;
+=09struct net_device *ndev;
+=09struct s2500_info *priv;
+=09u32 val;
+=09int ret;
+
+=09if (spi->irq < 0)
+=09=09return -ENODEV;
+
+=09ndev =3D devm_alloc_etherdev(dev, sizeof(struct s2500_info));
+=09if (!ndev)
+=09=09return -ENOMEM;
+
+=09priv =3D netdev_priv(ndev);
+=09priv->ndev =3D ndev;
+=09priv->spi =3D spi;
+=09priv->dev =3D dev;
+
+=09SET_NETDEV_DEV(ndev, dev);
+
+=09spin_lock_init(&priv->lock);
+=09mutex_init(&priv->selftest_lock);
+=09mutex_init(&priv->ptp_adj_lock);
+=09ndev->irq =3D spi->irq;
+
+=09spi->dev.platform_data =3D priv;
+=09spi_set_drvdata(spi, priv);
+
+=09ndev->netdev_ops =3D &s2500_netdev_ops;
+=09ndev->ethtool_ops =3D &s2500_ethtool_ops;
+=09ndev->if_port =3D IF_PORT_10BASET;
+=09ndev->priv_flags |=3D IFF_UNICAST_FLT;
+=09ndev->hw_features =3D NETIF_F_RXALL;
+
+=09priv->tx_fcs_calc =3D false;
+=09priv->poll_jiff =3D HZ * 5; /* Poll interval */
+
+=09if (!priv->tx_fcs_calc)
+=09=09priv->ndev->hw_features |=3D NETIF_F_RXFCS;
+
+=09priv->tc6 =3D oa_tc6_init(spi, ndev);
+=09if (!priv->tc6) {
+=09=09dev_err(&spi->dev, "OA TC6 init failed");
+=09=09return -ENODEV;
+=09}
+=09oa_tc6_set_vend1_mms(priv->tc6, S2500_OA_TC6_VEND1_MMS12);
+=09s2500_update_model(priv);
+
+=09/* Clear RSTS, if set */
+=09oa_tc6_read_register(priv->tc6, S2500_REG_MIIM_IRQ_STATUS, &val);
+=09val &=3D MIIM_IRQ_STATUS_RSTS;
+=09if (val !=3D 0)
+=09=09oa_tc6_write_register(priv->tc6, S2500_REG_MIIM_IRQ_STATUS,
+=09=09=09=09      MIIM_IRQ_STATUS_RSTS);
+
+=09/* Acknowledge all IRQ status bits */
+=09ret =3D oa_tc6_read_register(priv->tc6, S2500_REG_SPI_ST0, &val);
+=09if (!ret) {
+=09=09u32 mask =3D S2500_STATUS0_MASK;
+
+=09=09val &=3D mask;
+=09=09oa_tc6_write_register(priv->tc6, S2500_REG_SPI_ST0, val);
+=09}
+
+=09/* Start with non-protected control accesses for single register reads.
+=09 * NOTE: the device starts in this mode after reset, but it is possible
+=09 * that the PROTE bit was set by a previous module load/unload.
+=09 * In this case, non-protected register writes won't work, but -single-
+=09 * unprotected register reads will. Therefore, we can safely probe the
+=09 * device using regular control accesses and switch to protected mode
+=09 * later, when resetting the device.
+=09 */
+
+=09ret =3D oa_tc6_read_register(priv->tc6, S2500_REG_SPI_CFG0, &val);
+=09if (ret)
+=09=09goto err_reg_read;
+
+=09ret =3D device_get_ethdev_address(priv->dev, ndev);
+=09if (ret && (priv->capabilities & S2500_CAP_MACADDR))
+=09=09ret =3D s2500_read_mac_from_nvmem(priv);
+
+=09if (ret) {
+=09=09eth_hw_addr_random(ndev);
+=09=09dev_warn(&spi->dev, "Using random MAC address %pM", ndev->dev_addr);
+=09}
+
+=09ret =3D s2500_init(priv);
+=09if (unlikely(ret)) {
+=09=09dev_err(&spi->dev, "failed to s2500_init the device");
+=09=09goto err_reg_read;
+=09}
+
+=09/* Configure PTP if the model supports it */
+=09if (priv->capabilities & S2500_CAP_PTP)
+=09=09s2500_ptp_register(priv);
+
+=09ret =3D register_netdev(ndev);
+=09if (ret) {
+=09=09dev_err(&spi->dev, "failed to register the S2500 device\n");
+=09=09ret =3D -ENODEV;
+
+=09=09goto err_reg_read;
+=09}
+=09return 0;
+
+err_reg_read:
+=09dev_err(&spi->dev, "could not initialize macphy");
+=09return ret;
+}
+
+static void s2500_remove(struct spi_device *spi)
+{
+=09struct s2500_info *priv =3D spi->dev.platform_data;
+
+=09dev_info(&spi->dev, "%s", "s2500_remove");
+
+=09s2500_ptp_unregister(priv);
+=09unregister_netdev(priv->ndev);
+=09oa_tc6_exit(priv->tc6);
+}
+
+static const struct of_device_id s2500_of_match[] =3D {
+=09{ .compatible =3D "onnn,s2500" },
+=09{}
+};
+
+static const struct spi_device_id s2500_ids[] =3D {
+=09{ "s2500" },
+=09{}
+};
+
+MODULE_DEVICE_TABLE(spi, s2500_ids);
+
+static struct spi_driver s2500_driver =3D {
+=09.driver =3D {
+=09=09.name=09=3D DRV_NAME,
+=09=09.of_match_table =3D s2500_of_match,
+=09},
+=09.probe=09=09=3D s2500_probe,
+=09.remove=09=09=3D s2500_remove,
+=09.id_table=09=3D s2500_ids,
+};
+
+module_spi_driver(s2500_driver);
+
+MODULE_AUTHOR("Piergiorgio Beruto <Pier.Beruto@onsemi.com>");
+MODULE_DESCRIPTION("onsemi MACPHY ethernet driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/net/ethernet/onsemi/s2500/s2500_ptp.c b/drivers/net/et=
hernet/onsemi/s2500/s2500_ptp.c
new file mode 100644
index 000000000..26449a58e
--- /dev/null
+++ b/drivers/net/ethernet/onsemi/s2500/s2500_ptp.c
@@ -0,0 +1,247 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright 2026 Semiconductor Components Industries, LLC ("onsemi").
+ * onsemi's S2500 10BASE-T1S MAC-PHY driver
+ */
+
+#include "s2500_hw_def.h"
+
+static int s2500_ptp_get_time64(struct ptp_clock_info *ptp,
+=09=09=09=09struct timespec64 *ts,
+=09=09=09=09struct ptp_system_timestamp *ptp_sts)
+{
+=09struct s2500_info *priv =3D container_of(ptp, struct s2500_info,
+=09=09=09=09=09       ptp_clock_info);
+=09u32 data[2];
+=09int ret;
+
+=09ptp_read_system_prets(ptp_sts);
+=09ret =3D oa_tc6_read_registers(priv->tc6, S2500_REG_VS_PTP_SEC,
+=09=09=09=09    &data[0], 2);
+=09ptp_read_system_postts(ptp_sts);
+
+=09if (!ret) {
+=09=09ts->tv_sec =3D data[0];
+=09=09ts->tv_nsec =3D data[1];
+=09}
+
+=09return ret;
+}
+
+static int s2500_ptp_set_time64(struct ptp_clock_info *ptp,
+=09=09=09=09const struct timespec64 *ts)
+{
+=09struct s2500_info *priv =3D container_of(ptp, struct s2500_info,
+=09=09=09=09=09       ptp_clock_info);
+=09u32 data[2];
+
+=09if (ts->tv_sec >=3D (1ULL << 32))
+=09=09return -ERANGE;
+
+=09data[0] =3D (u32)ts->tv_sec;
+=09data[1] =3D ts->tv_nsec | BIT(31); /* bit 31 =3D execute set command */
+
+=09return oa_tc6_write_registers(priv->tc6, S2500_REG_VS_PTP_SETSEC,
+=09=09=09=09      &data[0], 2);
+}
+
+static int s2500_ptp_adjfine(struct ptp_clock_info *ptp, long scaled_ppm)
+{
+=09struct s2500_info *priv =3D container_of(ptp, struct s2500_info,
+=09=09=09=09=09       ptp_clock_info);
+=09u32 sign_bit =3D 0;
+=09long adj;
+=09u32 val;
+=09u64 ppm;
+
+=09if (scaled_ppm < 0) {
+=09=09/* split sign / mod */
+=09=09sign_bit =3D 1U << 31;
+=09=09scaled_ppm =3D ~scaled_ppm + 1;
+=09}
+
+=09/**
+=09 * Convert unsigned scaled_ppm to atto-seconds per clock cycles.
+=09 * The scaled_ppm format is Qx.16 --> 1 lsb =3D 1/65536 ppm.
+=09 * The clock period of the S2500 is 8ns (125 MHz), so 1 lsb of
+=09 * adj register LSB is 1 atto-sec / 8ns =3D 0.000125 ppm.
+=09 * Represented in Qx.16 format, this is 0.000125 * 2^16 =3D 8(.192)
+=09 * To convert scaled_ppm into a register value we need to divide
+=09 * it by the LSB value, hence adj =3D (scaled_ppm * 1000) / 8192 to
+=09 * minimize the precision loss due to the integer arithmetic.
+=09 * That further reduces to (scaled_ppm * 125) / 1024.
+=09 */
+=09ppm =3D (u64)scaled_ppm * 125;
+=09do_div(ppm, 1024);
+=09adj =3D (long)ppm;
+
+=09/* check overflow */
+=09if (adj >=3D (1L << 28))
+=09=09return -ERANGE;
+
+=09val =3D (u32)adj | sign_bit;
+=09return oa_tc6_write_register(priv->tc6, S2500_REG_VS_PTP_ADJ, val);
+}
+
+/* Implemented by using "settime" */
+static int s2500_ptp_adjtime(struct ptp_clock_info *ptp, s64 delta)
+{
+=09struct s2500_info *priv =3D container_of(ptp, struct s2500_info,
+=09=09=09=09=09       ptp_clock_info);
+=09struct ptp_system_timestamp sts;
+=09struct timespec64 target;
+=09unsigned int period_ms;
+=09struct timespec64 now;
+=09int max_iters =3D 3;
+=09s64 scaled_ppm;
+=09s64 remaining;
+=09s64 target_ns;
+=09int ret =3D 0;
+=09s64 now_ns;
+=09s64 num;
+=09s64 den;
+
+=09if (!ptp)
+=09=09return -EINVAL;
+
+=09/* Nothing to do */
+=09if (delta =3D=3D 0)
+=09=09return 0;
+
+=09if (mutex_lock_interruptible(&priv->ptp_adj_lock))
+=09=09return -EINTR;
+
+=09/* Try to slew the clock using adjfine for better accuracy. For large
+=09 * adjustments fall back to setting time directly.
+=09 */
+=09remaining =3D delta;
+
+=09while (remaining !=3D 0 && max_iters--) {
+=09=09s64 abs_delta =3D remaining > 0 ? remaining : -remaining;
+
+=09=09/* If the adjustment is very large, more than 1 second,
+=09=09 * use settime to avoid very long slewing periods or
+=09=09 * excessive frequency offsets.
+=09=09 */
+=09=09if (abs_delta > 1000000000LL) {
+=09=09=09memset(&sts, 0, sizeof(sts));
+=09=09=09ret =3D ptp->gettimex64(ptp, &now, &sts);
+=09=09=09if (!ret) {
+=09=09=09=09struct timespec64 delta_ts;
+
+=09=09=09=09if (remaining >=3D 0) {
+=09=09=09=09=09delta_ts =3D ns_to_timespec64(remaining);
+=09=09=09=09=09target =3D timespec64_add(now, delta_ts);
+=09=09=09=09} else {
+=09=09=09=09=09delta_ts =3D ns_to_timespec64(-remaining);
+=09=09=09=09=09target =3D timespec64_sub(now, delta_ts);
+=09=09=09=09}
+=09=09=09}
+
+=09=09=09if (target.tv_sec < 0 || target.tv_sec >=3D (1ULL << 32))
+=09=09=09=09ret =3D -ERANGE;
+=09=09=09else
+=09=09=09=09ret =3D ptp->settime64(ptp, &target);
+
+=09=09=09remaining =3D 0;
+=09=09=09break;
+=09=09}
+
+=09=09/* Choose a slewing period depending on magnitude */
+=09=09if (abs_delta <=3D 1000000LL) /* <=3D 1ms */
+=09=09=09period_ms =3D 1000; /* 1 s */
+=09=09else if (abs_delta <=3D 100000000LL) /* <=3D 100ms */
+=09=09=09period_ms =3D 10000; /* 10 s */
+=09=09else
+=09=09=09period_ms =3D 60000; /* 60 s */
+
+=09=09/* compute current time and fixed target for this iteration */
+=09=09memset(&sts, 0, sizeof(sts));
+=09=09ret =3D ptp->gettimex64(ptp, &now, &sts);
+=09=09if (ret)
+=09=09=09break;
+
+=09=09if (remaining >=3D 0)
+=09=09=09target =3D timespec64_add(now, ns_to_timespec64(remaining));
+=09=09else
+=09=09=09target =3D timespec64_sub(now, ns_to_timespec64(-remaining));
+
+=09=09/* Compute scaled_ppm (Qx.16). scaled_ppm =3D ppm * 2^16
+=09=09 * ppm =3D (delta_seconds / period_seconds) * 1e6
+=09=09 * =3D> scaled_ppm =3D delta_ns * 65536 / (period_ms * 1000)
+=09=09 */
+=09=09num =3D remaining * 65536LL;
+=09=09den =3D (s64)period_ms * 1000LL;
+
+=09=09/* Integer division rounds toward zero; keep sign in numerator */
+=09=09scaled_ppm =3D div_s64(num, den);
+
+=09=09/* Apply frequency adjustment */
+=09=09ret =3D ptp->adjfine(ptp, (long)scaled_ppm);
+=09=09if (ret)
+=09=09=09break;
+
+=09=09/* Sleep for the slew period (interruptible). If interrupted, clear
+=09=09 * the adjfine and return with -EINTR.
+=09=09 */
+=09=09if (msleep_interruptible(period_ms)) {
+=09=09=09/* Clear adjfine */
+=09=09=09ptp->adjfine(ptp, 0);
+=09=09=09ret =3D -EINTR;
+=09=09=09break;
+=09=09}
+
+=09=09/* Clear adjfine and measure remaining offset */
+=09=09ptp->adjfine(ptp, 0);
+
+=09=09memset(&sts, 0, sizeof(sts));
+=09=09ret =3D ptp->gettimex64(ptp, &now, &sts);
+=09=09if (ret)
+=09=09=09break;
+
+=09=09/* remaining =3D target - now (in ns) */
+=09=09target_ns =3D timespec64_to_ns(&target);
+=09=09now_ns =3D timespec64_to_ns(&now);
+=09=09remaining =3D target_ns - now_ns;
+
+=09=09/* If remaining is small (< 1us), finish */
+=09=09if (remaining > -1000 && remaining < 1000)
+=09=09=09remaining =3D 0;
+=09}
+
+=09mutex_unlock(&priv->ptp_adj_lock);
+=09return ret;
+}
+
+/* Support is not available for alarms, programmable periodic signals,
+ * pin configuration, external timestamping, programmable pins, and
+ * PPS support.
+ */
+void s2500_ptp_register(struct s2500_info *priv)
+{
+=09struct ptp_clock_info *info =3D &priv->ptp_clock_info;
+
+=09snprintf(info->name, sizeof(info->name), "%s", "S2500 PTP Clock");
+=09info->max_adj =3D 100000000;
+=09info->owner =3D THIS_MODULE;
+=09info->adjfine =3D s2500_ptp_adjfine;
+=09info->gettimex64 =3D s2500_ptp_get_time64;
+=09info->settime64 =3D s2500_ptp_set_time64;
+=09info->adjtime =3D s2500_ptp_adjtime;
+
+=09priv->ptp_clock =3D ptp_clock_register(info, priv->dev);
+=09if (IS_ERR(priv->ptp_clock)) {
+=09=09dev_err(&priv->spi->dev, "Registration of %s failed",
+=09=09=09info->name);
+=09=09return;
+=09}
+=09dev_info(&priv->spi->dev, "Registered %s index %d", info->name,
+=09=09 ptp_clock_index(priv->ptp_clock));
+}
+
+void s2500_ptp_unregister(struct s2500_info *priv)
+{
+=09if (priv->ptp_clock)
+=09=09ptp_clock_unregister(priv->ptp_clock);
+}
+
--=20
2.43.0


