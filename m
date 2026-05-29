Return-Path: <netdev+bounces-293196-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kHDEISrhGWpmzggAu9opvQ
	(envelope-from <netdev+bounces-293196-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 20:55:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DDA4E6078F7
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 20:55:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7424C314E73B
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 18:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0D224219F2;
	Fri, 29 May 2026 18:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b="T7SQ0IKm"
X-Original-To: netdev@vger.kernel.org
Received: from usb-smtp-delivery-120.mimecast.com (usb-smtp-delivery-120.mimecast.com [170.10.151.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA5D438FEE
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 18:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.151.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780079980; cv=none; b=hEQ3peO2081Hkkhz46INNOdsNRlaZp0hf5DP8HMf6x2UsuRn+3xbf2LEOnOCBRm/M/IMvZqy2OZx/BESZF2dlGqxIPkniwa3f4Qw4MS0Xa+zOBy55zrKmal6oKhxtnMbAwZtixyDf37zNdQw8qUZLMqKg0TaR3wNe9452KXt+t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780079980; c=relaxed/simple;
	bh=P5uGnLytcynumY3jJAUPPByyBBARd49WjG8hbbM1rIg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ac0JmUB9TLguDMtDxJoJTMDODaVWq3P0QgyJWxJ2R8nXDT6jBWpjvHHhWd2ghHYjc3eJjLsCBHOweut6eFvQi2R895G67uuXzCrHQIweDuuoFdxZJqS1BHTh4b2R3vzpJw/Tk2vawgunEBBBuWVG3MA1mTa8/NnWoK+dklAtkcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com; spf=pass smtp.mailfrom=onsemi.com; dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b=T7SQ0IKm; arc=none smtp.client-ip=170.10.151.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onsemi.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onsemi.com;
	s=mimecast20250127; t=1780079978;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Frko0/vml0waADMkIJNrqgx5bI7UqZDcvlw7iW9652c=;
	b=T7SQ0IKmewatH9Cmqw0hJO92PStgslJ3FHYqk5ErlMNzI0XpZ79A+V8cXywbl95R0snMCE
	itXL5G4hRyM+XepLKmywdCcAMHqkf+P8GW3pe8zR/ryv/tHNX1erHTi1abUsex9//LOTFS
	7ysokAZm4oPq4R1XxYjL3x80YaFEapRcrqt9d3J6sHxB1Hsr2mvczI7Ju7wCXgnn/NLbLS
	z1IhodSDUpBrb5roVHCMXaz+kzNGsQOfob1fa/hqtZn0QyhXz4K26vw4FlhvQ/R1c4Ighh
	UvtAPiO5IwqbtvA3oiheLCuzVfwZVl6BMEAUnmkECXm0MfYAbP0Joj/qUbnaWw==
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013001.outbound.protection.outlook.com
 [40.93.196.1]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 usb-mta-63-tEhqUT5cOZ6IXck4s476tA-1; Fri, 29 May 2026 11:39:35 -0700
X-MC-Unique: tEhqUT5cOZ6IXck4s476tA-1
X-Mimecast-MFC-AGG-ID: tEhqUT5cOZ6IXck4s476tA_1780079974
Received: from CY8PR02MB9249.namprd02.prod.outlook.com (2603:10b6:930:9c::17)
 by DS0PR02MB9046.namprd02.prod.outlook.com (2603:10b6:8:c2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Fri, 29 May
 2026 18:39:32 +0000
Received: from CY8PR02MB9249.namprd02.prod.outlook.com
 ([fe80::e437:4ba8:6506:4cda]) by CY8PR02MB9249.namprd02.prod.outlook.com
 ([fe80::e437:4ba8:6506:4cda%3]) with mapi id 15.21.0071.011; Fri, 29 May 2026
 18:39:32 +0000
From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
To: Piergiorgio Beruto <Pier.Beruto@onsemi.com>,
	"parthiban.veerasooran@microchip.com" <parthiban.veerasooran@microchip.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v3 02/14] net: ethernet: oa_tc6: Move oa_tc6.c to its
 own directory
Thread-Topic: [PATCH net-next v3 02/14] net: ethernet: oa_tc6: Move oa_tc6.c
 to its own directory
Thread-Index: Adzvl+YGdZ19tjFJTzO7UJa3KzUQNQ==
Date: Fri, 29 May 2026 18:39:32 +0000
Message-ID: <CY8PR02MB9249E50ADFCA24B9902C743E83162@CY8PR02MB9249.namprd02.prod.outlook.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR02MB9249:EE_|DS0PR02MB9046:EE_
x-ms-office365-filtering-correlation-id: 972cd453-45e4-4126-3dca-08debdb19fcc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021|18002099003|6133799003|3023799007|56012099006|11063799006
x-microsoft-antispam-message-info: QY8U85+nY89WanmtnPyBxq4MkXw88GXxBJccA0juw1Nw1Hzql4mJqEYsyJi9C/QpAQIjyVLA0j4oDBcD4FJtZ/argiQPLBMgpn4ctucyA3feSl0Y85R6MqTjJdUyOaotHdZNINYW7dygBZE30TDYzaXfaXL+wDqdHAMGRVMlMuZzuJHkGA0kJW0VcqOUcBHA5QJFiSylAs/cbEvLergdOX8baKvib2hOFuFYecPd6nOMZSLbPDUhsvbNr54wEYHRR5T02w75hAJEHeEj7p65/JspW6cUJdS1kULia626r8V5e3jodP65PJw/9ISQm1RJ6tYMKed5ucmXlGG7FX6f7jPScY2aZFUbHCiDqxetnJxBfrqsPoV/zrlhenNcJ8GW2XRw69jLA1f3AVK8pzP0r2xyuf4BulB+4z08zuxWvkK892hiZL83h/d+3XdbXQmlm49OMipMyu5k8c9U0c3vue7reQJ+N+CANE4r496rrQIGSSq26guDEwTNCRSlmvwP2he3WPecgKyroJOXz59+Fmd3Hgca/hqR2RF8EtQX0TRUiXWLCLS5/5Sprk9OVsj/yJbE2/zjFNWgrYbOkgBq8epVKjKjhqeXTNBevxcLZJAzPbWB+GU4Fur/Df96k3iOsH5RjjHova0wVIHiNh9Y0NifzG3JZ47plx8wQzc++FtpIEgeM4mpgudNQ0Ra+unPICYzrra9jkitWxCd6qCHxjZkXtcmOi69qF7kblPDpg4aQA7ztmB3ZP9o2v0wth+A
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR02MB9249.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(18002099003)(6133799003)(3023799007)(56012099006)(11063799006);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bsgO4sZWeH0KsPxCyvuGJ3bcbhhZhzXowjQ6HpDloxB3mnKgsAEDNHHEBIPS?=
 =?us-ascii?Q?uhfq3bktwQoFX9dFG3KZGkg373LziuwDwnnb91npm/adjr+2pm9eM4Oz/blV?=
 =?us-ascii?Q?MymbWIFnhdtb1NnVMPDD4O+cbKb46AUo91Mk6QGSLew8F6QmwwsWF9JqtyNX?=
 =?us-ascii?Q?8uLezt0Y4pYzFYzYFKNiUJu5m4oMj7doYnRR6hSoYACIYaU4eOtYrSkG2Vlt?=
 =?us-ascii?Q?ZzBRDUjtQfoANGxJ+fOjTw4Lx1XBGnAsKz0c2s6bk3fOZy5fjWidIXu6E9T5?=
 =?us-ascii?Q?AujwBKBehC59l2ZHPXYpXlk2zIID7YXuoRpylTMnsW2KVTcci/nc5wKyYaoP?=
 =?us-ascii?Q?xm9y+MqL3WH6K8jmX55FbZyC1KvCrmYwwa0lTco/QxkLCiXr/Z0ioTWNjRy3?=
 =?us-ascii?Q?XqZYNNCaZQ59rJmOLTiHDexMlQwOTyUE6xUuUKKZ6WPnI4t5zPYHx1rOT8vI?=
 =?us-ascii?Q?laqqA8wZ01wHoaODzp3w3DNF35FCf1gXt6c7IHFd9/zi0w6sVI660Pkw7wR8?=
 =?us-ascii?Q?2phj86Zas2JJxwqaXq6D7zBFJ+TcpIGlRQbP0BBloWqGORxia8hY7lnZsBEA?=
 =?us-ascii?Q?KFebWzhIn2ndHH5jlyo2kXsgPUOGzC1LSGk8ePuV/8ipNHimLPAG3JKxW/VM?=
 =?us-ascii?Q?M5yFi0G8/yiY7HGuEkVUsUJapEDIHKJBvqoP02d94qC6cn8H3EW1A5s23DXe?=
 =?us-ascii?Q?qqVFDcdLwC/8FdAWCn7y7Mn7JWx3qceajuuPak/v90jtdD0QopS+/pyHwrZ9?=
 =?us-ascii?Q?txKowVlEMXWn+cV/Qnyd/xR7/XAc+5IXm0tPpCFSJS1t2d5O87Tr3ek0LwWK?=
 =?us-ascii?Q?buz9jcubP89mqaKbyn004OQaP22nyq3bGKxAt+tw0bj5aezhdGPCX8oQ+vTq?=
 =?us-ascii?Q?VVawpzvJK1OTKnUh1rSvyS/0gU+FOYwJvZsUHhopJYXhWTMwefHz+95ltjip?=
 =?us-ascii?Q?CuzJxUONQ0/bFsPStqLRxx7cCOUHHmV0hm+CkDTff7dLG/Dd1XuSriUwL1th?=
 =?us-ascii?Q?Lg55SBlJBhoy2c5eK4Z1iF03UWTu3BNrd5g+I9f/BIpe+I0oBqwDlzIza/+0?=
 =?us-ascii?Q?vaAKEgCRhZwN5fuf0uvODyL+Lxay9DalmMyFJANdakgtgHSSD+1z7nN7YmMY?=
 =?us-ascii?Q?7hTDmOA7CfACXKIf2KClVdOi7FYybo3okPgVWZzqsNTQALsiGQbfZoqVs1HA?=
 =?us-ascii?Q?2x9IqarhP2tAY446g+J/J2oftlQaZT0tBRBcfFjzSzxiSeHYheCtImXJ9bJt?=
 =?us-ascii?Q?GhgUx4QsP0JlLfxJ9k8zlilBAej5C9XHbHUSr12OAVwr98lmf5D+lTFmYRBY?=
 =?us-ascii?Q?bDMyuQrdNCDg40w4R/tPnWg23FPSW4Av0bsNEC45HHHpzKzGebNH3asUS5my?=
 =?us-ascii?Q?qmS4CNfDRKFRD21zTXkJ6bTW1LQgKvA67b4Tp+KVLT3/m7ZGTmtoycCDajHI?=
 =?us-ascii?Q?uauWAmbjChyhdTLnwFh+KuLwlPTg1M4sqWeHuEheUsfewfh1wX5w+WmHy7bB?=
 =?us-ascii?Q?1dY8GXJx5jANiaxskyYjFp3miCcsrBqE7nvT9fT7Mpwx50tV4/RgNsf0bmrv?=
 =?us-ascii?Q?AUT3c3HyDCmBZRVemMSHJc4ZwMpiWQGDS1KhpqDy0HCVckOq0Ql1zXHUQHgA?=
 =?us-ascii?Q?HrMQETC7c24p5vRR8Mx9i9Wi6gzdWUcpKBj83WMtIthud1aKOXiD7s/2PLLB?=
 =?us-ascii?Q?0rSStcjECZYLwtISA2+xmVReqIIpxIY03S7zTaZ4NOJlaLDeSRZWvezjU+x0?=
 =?us-ascii?Q?EAvlafQ6kg=3D=3D?=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: XZd7zemaHyn8OA0Ro/ZTHaEDp/Y2UQ89Vn53YTTvjG4lRXh8onkOINS4w6NmaoFSEpUiRiY8DOSWvSt1J6P1bVaUaHwqEld6M75iBmnIBQtG3z7MLbrLvwXTj2NkxlZJ/NOdY5cCAuMVpgmF98BYXFUWqcle2sUbkBoy0S9ncftfJ/KPOfyyQHHQkupgdeAtW2WkD0c6YRtxo/yxq3AX/7SxgG0O/I1Tl62M6U4mlUPy9qY8RI97xIVTj3YnLbOA55WsGwKfCT57KVQ4FbKwf2itRQuk5QotGUqNNrDg2Hvpa4n4feLMipDvb6LpyntzwHhJe+VDkmg8+qyUscUCOA==
X-OriginatorOrg: onsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR02MB9249.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 972cd453-45e4-4126-3dca-08debdb19fcc
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2026 18:39:32.0509
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04e1674b-7af5-4d13-a082-64fc6e42384c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dwmD1Qm1DZzdcSTHCsQ3Tou/NTEQW5XkxtuWkWCKXoDpN6ktwMQxSKRmTGX0m7/isS16HWPv4vL7it7yhDm1tqTKS//Usz3kZRgaTxcLTuM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR02MB9046
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: FdVrsXSOBQBGhD_JsWEQbUNlLx83esEMlKgmwVjtpQ0_1780079974
X-Mimecast-Originator: onsemi.com
Content-Language: en-US
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[onsemi.com,reject];
	R_DKIM_ALLOW(-0.20)[onsemi.com:s=mimecast20250127];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293196-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[onsemi.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Selvamani.Rajagopal@onsemi.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,CY8PR02MB9249.namprd02.prod.outlook.com:mid,onsemi.com:email,onsemi.com:dkim,microchip.com:email]
X-Rspamd-Queue-Id: DDA4E6078F7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Moving oa_tc6.c to its own directory, drivers/net/ethernet/oa_tc6. This
will facilitate adding more files to support other features
defined by OPEN Alliance 10BASE-T1x Serial Interface specification

This patch series is adding two files, one for hardware
timestamp related functions and one for PTP related APIs.

Signed-off-by: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
---
 MAINTAINERS                                |  2 +-
 drivers/net/ethernet/Kconfig               | 12 +-----------
 drivers/net/ethernet/Makefile              |  2 +-
 drivers/net/ethernet/oa_tc6/Kconfig        | 16 ++++++++++++++++
 drivers/net/ethernet/oa_tc6/Makefile       |  7 +++++++
 drivers/net/ethernet/{ =3D> oa_tc6}/oa_tc6.c |  0
 6 files changed, 26 insertions(+), 13 deletions(-)
 create mode 100644 drivers/net/ethernet/oa_tc6/Kconfig
 create mode 100644 drivers/net/ethernet/oa_tc6/Makefile
 rename drivers/net/ethernet/{ =3D> oa_tc6}/oa_tc6.c (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9ce5542ab2f3..2568ff304d9d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19998,7 +19998,7 @@ M:=09Parthiban Veerasooran <parthiban.veerasooran@m=
icrochip.com>
 L:=09netdev@vger.kernel.org
 S:=09Maintained
 F:=09Documentation/networking/oa-tc6-framework.rst
-F:=09drivers/net/ethernet/oa_tc6.c
+F:=09drivers/net/ethernet/oa_tc6/oa_tc6*
 F:=09include/linux/oa_tc6.h
=20
 OPEN FIRMWARE AND FLATTENED DEVICE TREE
diff --git a/drivers/net/ethernet/Kconfig b/drivers/net/ethernet/Kconfig
index 78c79ad7bba5..49d93488ba52 100644
--- a/drivers/net/ethernet/Kconfig
+++ b/drivers/net/ethernet/Kconfig
@@ -134,6 +134,7 @@ source "drivers/net/ethernet/netronome/Kconfig"
 source "drivers/net/ethernet/8390/Kconfig"
 source "drivers/net/ethernet/nvidia/Kconfig"
 source "drivers/net/ethernet/nxp/Kconfig"
+source "drivers/net/ethernet/oa_tc6/Kconfig"
 source "drivers/net/ethernet/oki-semi/Kconfig"
=20
 config ETHOC
@@ -146,17 +147,6 @@ config ETHOC
 =09help
 =09  Say Y here if you want to use the OpenCores 10/100 Mbps Ethernet MAC.
=20
-config OA_TC6
-=09tristate "OPEN Alliance TC6 10BASE-T1x MAC-PHY support" if COMPILE_TEST
-=09depends on SPI
-=09select PHYLIB
-=09help
-=09  This library implements OPEN Alliance TC6 10BASE-T1x MAC-PHY
-=09  Serial Interface protocol for supporting 10BASE-T1x MAC-PHYs.
-
-=09  To know the implementation details, refer documentation in
-=09  <file:Documentation/networking/oa-tc6-framework.rst>.
-
 source "drivers/net/ethernet/pasemi/Kconfig"
 source "drivers/net/ethernet/pensando/Kconfig"
 source "drivers/net/ethernet/qlogic/Kconfig"
diff --git a/drivers/net/ethernet/Makefile b/drivers/net/ethernet/Makefile
index bba55d9af387..77b11d5a7abf 100644
--- a/drivers/net/ethernet/Makefile
+++ b/drivers/net/ethernet/Makefile
@@ -71,6 +71,7 @@ obj-$(CONFIG_NET_VENDOR_NETRONOME) +=3D netronome/
 obj-$(CONFIG_NET_VENDOR_NI) +=3D ni/
 obj-$(CONFIG_NET_VENDOR_NVIDIA) +=3D nvidia/
 obj-$(CONFIG_LPC_ENET) +=3D nxp/
+obj-$(CONFIG_OA_TC6) +=3D oa_tc6/
 obj-$(CONFIG_NET_VENDOR_OKI) +=3D oki-semi/
 obj-$(CONFIG_ETHOC) +=3D ethoc.o
 obj-$(CONFIG_NET_VENDOR_PASEMI) +=3D pasemi/
@@ -104,4 +105,3 @@ obj-$(CONFIG_NET_VENDOR_XILINX) +=3D xilinx/
 obj-$(CONFIG_NET_VENDOR_XIRCOM) +=3D xircom/
 obj-$(CONFIG_NET_VENDOR_SYNOPSYS) +=3D synopsys/
 obj-$(CONFIG_NET_VENDOR_PENSANDO) +=3D pensando/
-obj-$(CONFIG_OA_TC6) +=3D oa_tc6.o
diff --git a/drivers/net/ethernet/oa_tc6/Kconfig b/drivers/net/ethernet/oa_=
tc6/Kconfig
new file mode 100644
index 000000000000..2c9a269b374b
--- /dev/null
+++ b/drivers/net/ethernet/oa_tc6/Kconfig
@@ -0,0 +1,16 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# onsemi network device configuration
+#
+
+config OA_TC6
+=09tristate "OPEN Alliance TC6 10BASE-T1x MAC-PHY support"
+=09depends on SPI
+=09select PHYLIB
+=09help
+=09  This library implements OPEN Alliance TC6 10BASE-T1x MAC-PHY
+=09  Serial Interface protocol for supporting 10BASE-T1x MAC-PHYs.
+
+=09  To know the implementation details, refer documentation in
+=09  <file:Documentation/networking/oa-tc6-framework.rst>.
+
diff --git a/drivers/net/ethernet/oa_tc6/Makefile b/drivers/net/ethernet/oa=
_tc6/Makefile
new file mode 100644
index 000000000000..ef79f2039016
--- /dev/null
+++ b/drivers/net/ethernet/oa_tc6/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Makefile for the onsemi network device drivers.
+#
+
+obj-$(CONFIG_OA_TC6) :=3D oa_tc6_mod.o
+oa_tc6_mod-objs :=3D oa_tc6.o
diff --git a/drivers/net/ethernet/oa_tc6.c b/drivers/net/ethernet/oa_tc6/oa=
_tc6.c
similarity index 100%
rename from drivers/net/ethernet/oa_tc6.c
rename to drivers/net/ethernet/oa_tc6/oa_tc6.c
--=20
2.43.0


