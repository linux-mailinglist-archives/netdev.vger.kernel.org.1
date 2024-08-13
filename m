Return-Path: <netdev+bounces-118180-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA19B950E3B
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 23:00:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D070B2132A
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 21:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 753A41A7060;
	Tue, 13 Aug 2024 20:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="GCLAKJOt";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="c9GS2C5y"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC5144C61;
	Tue, 13 Aug 2024 20:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.154.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723582786; cv=fail; b=MWXK3cop5SIkuYsWMQoch8R8q2B1yXCreR1m2vje+Qhd+Kl1qb3I6pd+qziE33WqhNRDQPqch+nnRDini5ZSwQFiuKPIXsuunztvjK3VvQWdASEcOAOkoxNrkwDA1P3jfkZuEqq11hh13H9QY+/7l5TIhQpl024t2L8elw6/oSo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723582786; c=relaxed/simple;
	bh=0l7Mce4hlP7Hmrdaa4RXuZZE4Rztfldj4DdKc+qscWE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gNPz8JaCqjW2lIXbyYIAkgyxZc5ioiqCYwd0wtIXeysQi8hPmyeRtWNnubbSlMgQedORplUD8HrJWY/6nU58uyDsJu/BryDnKqlFB5O7fWTOLTcCD7Plgb8kAOBdmDyivGX4b4B+Z9TQSmGP2BaQIxq6tg9UF/Ci0WN1xKGTyCU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=GCLAKJOt; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=c9GS2C5y; arc=fail smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1723582784; x=1755118784;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0l7Mce4hlP7Hmrdaa4RXuZZE4Rztfldj4DdKc+qscWE=;
  b=GCLAKJOtkcGru1CIcX/FhvW3yDw26OGawp7uTc4Y0XMpaBdCg7MhbhJn
   FZIPnxbrIen3slpcLlwYURAPlfxxhWJ0RTDkpy8sNM6M4ibZk5vHto7Fh
   oKtstzGdEKFgqev0JS0++06rA4iHJgi4KkKVtGRRfSP3EX6oB2vigRnOk
   rYIr2CXvMeclUGdNNTQfvlBEV6CSYLx1i5zWGYwer7Vvgy4wVyfN96oac
   7d7EW5jJUj22pgOJq3xCdxPwZC1JeX95o/VeKwX5sQjJkfXV09KMo7ngc
   H4zlcCwOX7VlIz2qOLSSE1bJkP3+tOz7xSwyYmJ7mHBKO+Hqp+5ooS8dy
   A==;
X-CSE-ConnectionGUID: W/lAXzXKTjqHxolnoPQc9Q==
X-CSE-MsgGUID: fLwMq2OWTmqxq1NEGsrziQ==
X-IronPort-AV: E=Sophos;i="6.09,287,1716274800"; 
   d="scan'208";a="31125427"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Aug 2024 13:59:42 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 13 Aug 2024 13:59:41 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 13 Aug 2024 13:59:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OBoALqDFroSF1ootKhh7uq/3KIGApuB1CqLvBVn3rAggBMdodet6CMgqB0lgOCmT+KwD7gPWtUEvXXTJ26k+j92VSOLdcVjO4wcXCCqCULmsN1f+TMqKrIcJdazaK5DRuRa+0uoNGSCjn+k0KvbOc0D4cP0jNTrxP1LlRklHLMBEDMf1lP/p67YDyZ75lNNO+AhBWQ+5SqBvla5GoQjI+5zfXSF4uX/3y5fljMAmBLLYkQvzcJ4IWOC4DDTIIB5HLRbHMxOfmDtMQiamHO2on8Gb/kKITlTn1sSlCPYuNAkjuHiXBwJyDsE9qBxmv813/1JlOdpJWn6YrHsnxw+8Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ucbi9u0QtePEcKUQigTV99nJ78AeslHb5dhikqYEZdk=;
 b=fWWWjOvg/IOPlljWBgO56v/+U8fIGkZVwuGMvepqZTziHN8PSbHea016zO7e9Eoropy21tVebEpnqn5HPQdnr9xTn5HEdsM7d6r+fR3pROM2/Y7BHVjzHTUDW/j7deLinv0QA00o0YaGKhnH5o2Q/KaaYSGyLkmQTwpQa6fyMgB/HPO/061uDOqgOsJFhxvF9c7UDlkVWwM0kcIwLh90swAh4xA6uHKg74jv5r7ohlmOXCQmXLWs3n6Ewt+upV/70W2tXtRWKuXFT6awpaiGLRfJxckLcLnLv3fCTkQjaEGdmUeDtudlBG8vm9KgC9sEfDK4Vmze6eL6S5rRUkXrUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ucbi9u0QtePEcKUQigTV99nJ78AeslHb5dhikqYEZdk=;
 b=c9GS2C5yuZZyrLqMMpNBsclkgnwB9m622XPTs5dpAQHEnUeAKZ6JHnoQjG9dNWh4Ws9I2mdKu0IR5rVyfKnQimoxy/zChUKxEE9tBg7SOCDVlRcXdqiCUqyReK8Rkd/RU+NkOrx+cZ7IG6secxvM4OzHLMCjDN2gXyfiaGMHfhBl+0GNX6PDZ4bD+T2N1KDbnsrs/HqUHvIBsn4enMIBG9lRi4QWyRaa/MsIIncBmT7f3uAGIgxAkHzpUjBZXl+F7TYbCVjLFC948pDSZs59ABPCyx7ZFTr1SdgXMfShS+iGN5VFaqV79i915nHch0uBIiKELVGXvhKfO+e+gedU9g==
Received: from BYAPR11MB3558.namprd11.prod.outlook.com (2603:10b6:a03:b3::11)
 by IA1PR11MB7679.namprd11.prod.outlook.com (2603:10b6:208:3f1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.29; Tue, 13 Aug
 2024 20:59:37 +0000
Received: from BYAPR11MB3558.namprd11.prod.outlook.com
 ([fe80::c03a:b12:f801:d3f6]) by BYAPR11MB3558.namprd11.prod.outlook.com
 ([fe80::c03a:b12:f801:d3f6%7]) with mapi id 15.20.7828.023; Tue, 13 Aug 2024
 20:59:37 +0000
From: <Tristram.Ha@microchip.com>
To: <andrew@lunn.ch>
CC: <Woojung.Huh@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<devicetree@vger.kernel.org>, <f.fainelli@gmail.com>, <olteanv@gmail.com>,
	<robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <marex@denx.de>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next 4/4] net: dsa: microchip: add SGMII port support
 to KSZ9477 switch
Thread-Topic: [PATCH net-next 4/4] net: dsa: microchip: add SGMII port support
 to KSZ9477 switch
Thread-Index: AQHa6rVcEZ4QnCCduEOREErJuDT1TLIgxryAgATqEPA=
Date: Tue, 13 Aug 2024 20:59:36 +0000
Message-ID: <BYAPR11MB355872F35F8758BA7F761B6DEC862@BYAPR11MB3558.namprd11.prod.outlook.com>
References: <20240809233840.59953-1-Tristram.Ha@microchip.com>
 <20240809233840.59953-5-Tristram.Ha@microchip.com>
 <2f59b854-c1d4-4007-bc6e-4c8e88eda940@lunn.ch>
In-Reply-To: <2f59b854-c1d4-4007-bc6e-4c8e88eda940@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR11MB3558:EE_|IA1PR11MB7679:EE_
x-ms-office365-filtering-correlation-id: 0366aef4-bab4-4252-a461-08dcbbdad767
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3558.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?t1vD+dnKkaAOWZLd3QxivtwZYspWyWxKE56+tEbqWAPq0YGUyTEOFkHTvLkm?=
 =?us-ascii?Q?JdoMqgFyAnzTaswXI2VqlCsiYsJxs4ccbWiQxafLTOUwCodE3C/p14S90rOE?=
 =?us-ascii?Q?Y84tW6MJumf/5yZyR9LPzDITYPuPcCmLJ50K7SKMGdgLVv76jiBAZJpcrBsR?=
 =?us-ascii?Q?f0bYn6jSqcSS4o65KhyokScT+t7XdUQWZXW5sJHLpHR8NW52nuyICITl5v8G?=
 =?us-ascii?Q?jbltN7IE+pnmwpe7BpyJHAmkgl+UfiE3IXHa7FCClPuk3tAsjwVdS8/ervEj?=
 =?us-ascii?Q?PZDoWDDa/usCKSxUl+ZXMah9f+P55+m8bOCSReoBp7LebRagbvl/x+ld38sr?=
 =?us-ascii?Q?jmJOaOmu51N8BvQWLifzqbIdc6DiJYw+DgVByvaG5WtYBMAtuzRJHHi590Mg?=
 =?us-ascii?Q?ucmYmCkgZ9+YvmejqAfY69cFJYKEipy/n2G4bH25V6qVIDLL2eaVuvwUBd+u?=
 =?us-ascii?Q?j0n2UlDRCKCx4pGzDJLxTEbLb8+OR1OlIfLlBaR5Lua85A+FEmMPOB6mSdLh?=
 =?us-ascii?Q?9qJfKc8Uv7hSM3wY6UsAz4CVfHfsAEOfFUpG+I00/jcEDCLhUvJBPz6tN0KM?=
 =?us-ascii?Q?QbwiI47ZiQFqBnZGcWEOusjVPF+QF9e8iXeDIVXjZMWDVcubvAkH5hXxIZxl?=
 =?us-ascii?Q?FgxmKZXfsQBvMDsOqfaflwQIcxCytc3ss9Lxl9AMCJ8AEiMC5WNY3hPHdX0s?=
 =?us-ascii?Q?3sVdTp2j4qGOw1i7hVg1cTHqUH36O7BIwAI+jcduhbAbEOpI0dlaAhCTBPZH?=
 =?us-ascii?Q?fRIu3C3JDf/+08pyPEh8wTtyrfykE67ZMql8+2szRsple2dsalnLK47AJJxK?=
 =?us-ascii?Q?I6LIuuC9MgbPw0GqD/gMGV3aVrbBtcU9S3+DRmvnLZicg4KdfXsYvKcj4BQv?=
 =?us-ascii?Q?/xbiK8xF9ulKJHGhocHm99hN40m7/XAdkWqyrkMgdpUfWbFgXjjtCauTcjy0?=
 =?us-ascii?Q?fWg1TQCwvCBtHxzozTBHcnQqQB4/bGkCV13kkfm151wNVWwEZ1ecEnz7xLOG?=
 =?us-ascii?Q?Rd4S3BY+rq8thHOe/eZbIiXjnKFBgOIEFDZVIXRPOovRh/F5kjbbABhuowt0?=
 =?us-ascii?Q?AjWwsyHfeIsm2AbinL8PQ8WfABKCGywIvbQGmCDCMGuXghdSiRertVd8uK/F?=
 =?us-ascii?Q?q/n74jkKzW0h6/EsEanCixNvPVhGBgp9UQDsie3DE5WOmjlJ4EQeP1Wofqf0?=
 =?us-ascii?Q?sb8Z9hH5QJOJn0PnnGOxIVAo+MhcX2D4S0s8t6TK8rDkIClPni2wtzpErEeG?=
 =?us-ascii?Q?6O9wMh5og2yokUUpBkLQwhfg378h7m2423SxTzobAJgUeVlTkgwH2ssh1FOY?=
 =?us-ascii?Q?TYBGTp8poCOSvJIwI5RMS78IQJr/XPHBU3FGT48LnffdMrh+Zp7Y7n0kzA/P?=
 =?us-ascii?Q?x2mflfdJ2b4IBRbfZksFg6baV8u352hhDyJqxph3Clvce6fY+g=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lBZsF5g64YZFwGCpSZRwRaqFxso8Ph8hfvIZZ/0E+/K/FBwcNu/qGArxGut5?=
 =?us-ascii?Q?YP00H707AKFsAw+yhR1XpHYryLVBuFmvMPNlHtK3Q0zVwxY5lWZNcwsu0TJ2?=
 =?us-ascii?Q?dQs16vAUbJOV+2ETLkKBwr/WiqK9dcl7yf+T8BBUwPXKkfh5wXYl3Y5i7qUJ?=
 =?us-ascii?Q?lk7yvNKgmrMQ1xFXHTSHWYdHrC2LKOPX1oDGTuYqZ2zP0kyEyZ8ULzD4uwTp?=
 =?us-ascii?Q?uePl572uEITprAnKNrOrVNS3xLGW38rTZwY2Fm+JmiTcIzrXMlJ6S++g32eH?=
 =?us-ascii?Q?Lfdexr/wKHK4n9CBhy/I2R9fHCWqTowWD8g8hpcM4ZCvzMwgTSI9MbDTFui1?=
 =?us-ascii?Q?q9U8gYNKvLgSt0MbesHkWzS/8WzJc2MdYl31Ye3prezsYHNiAkNuBVYavyh5?=
 =?us-ascii?Q?mIBkJdYBH8kr52cUy5UU2vRcV8vktjAYSqB+11nrCMcCq9YO0NKt69aRQqa0?=
 =?us-ascii?Q?VJHRHB5QqvY/z9yBM+M0pK/cvKN3dzRSrwv5ZuHvURfoctK7ice6tCSjFp8z?=
 =?us-ascii?Q?s0jRxXkGa2kbpWA/lF+JPorBS4Vynp0eDSEf8SsyaHfQ8HgKa37dIlM8+ORc?=
 =?us-ascii?Q?0/M1VcxFKmiuNAryliTMbtvX+ELrKzQ4zCZwH12mh5ZPRjRgdmRpeb+mbk2z?=
 =?us-ascii?Q?1Q3dYmq1jWE/T+u+40tI6t2emNP5yc3J9kluwQqG0xOWCwTeJ5bHWKCTb7No?=
 =?us-ascii?Q?qbYBGWizOCJ46HFFXag9JybcV0j5Rv7sNOq5YwWnErRbQeektNJ9+A7zRqBZ?=
 =?us-ascii?Q?zZDILaUXj0Yauiy9yAyG7M5bcsaG+QD6MbVd3LHL55aKB+42LzngBfb+Bbii?=
 =?us-ascii?Q?6d0yvO0QgifUhd28nhQWg3rnm2b7miwJ1utM6AS/YXE9/nJRoa/EvGIsnWsB?=
 =?us-ascii?Q?TZSQAIDQM7pMN8azIZBslcDTCLwyoLMqgveFyNyPWZtCtzui7/VDol3CflOI?=
 =?us-ascii?Q?AkgnUfu+2PiWcnaVmLCpX3bUyl1N4Dy7JiVNacaMKl6CZl+IpfTNgnwEbV/b?=
 =?us-ascii?Q?hbKaJRJhn6J/nnqCQPRDpydev4xoDcAyya0TW4nwgEjLCFbhSvPRyKbsSuWe?=
 =?us-ascii?Q?Nz/flL98sIyBiLhYRKpSc3zI82KQUVFjlkpRKzxDKf1+p4NXfoIMlus0thvU?=
 =?us-ascii?Q?CgQ5iArtdwWSKV5SimlVcuBuQKFqgx+/0DQw7Su2iI1+l7W4s2Vw+cifmWbK?=
 =?us-ascii?Q?vp0/U7qls+dmIH+jKtMU+niZNl9OjLGXnzqgOW0wg8/ju21zurKxGsQZLBAb?=
 =?us-ascii?Q?ZdiaSAXrLE3B4DWatoGTCXjJy5b3tvrWrh/tbeB0/iKO/jNpSXOiUfqBYhMW?=
 =?us-ascii?Q?BHui610YIXJQtkCvaS4TuSSOFxtkmdHgqRZoZQgczYblnQEaDOjpCsbnXmZu?=
 =?us-ascii?Q?/BITy1yOBaDgTGLmTipjXLzxg2YjtvOggRF4ejWMmIgm4DDf8QPm2uibvHlY?=
 =?us-ascii?Q?xwmPI8Hg5dFQhGpeHqApty1mxAZu/fUGOTnHLckHWsZwBqfAb2swPveEKOkT?=
 =?us-ascii?Q?eqdelNMA/aitWX1rAZcnSOne+twsMm310fmnvNYYw9tytt42e9uaf/Y/Op9m?=
 =?us-ascii?Q?/3v1VHdGaNiO4iNCy5xIQS4J4uF587CKBOEtaK4+?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3558.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0366aef4-bab4-4252-a461-08dcbbdad767
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2024 20:59:37.0293
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HnFC+Ugt2EqgEpjncs+b++JcsLi0MKwCtx5kk9GAqOzUH4SITWCGIIiaQqpnLvOefECbPPNi4CWCn/BZ2zDt66EgRNq+dwIMkwlKl9c+Jjk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7679

> On Fri, Aug 09, 2024 at 04:38:40PM -0700, Tristram.Ha@microchip.com wrote=
:
> > From: Tristram Ha <tristram.ha@microchip.com>
> >
> > The SGMII module of KSZ9477 switch can be setup in 3 ways: 0 for direct
> > connect, 1 for 1000BaseT SFP, and 2 for 10/100/1000 SFP.
> >
> > SFP is typically used so the default is 1.  The driver can detect
> > 10/100/1000 SFP and change the mode to 2.  For direct connect this mode
> > has to be explicitly set to 0 as driver cannot detect that
> > configuration.
> >
> > The SGMII module can only report basic link status of the SFP, so it is
> > simulated as a regular internal PHY.
> >
> > Since the regular PHY in the switch uses interrupt instead of polling t=
he
> > driver has to handle the SGMII interrupt indicating link on/off.
> >
> > One issue for the 1000BaseT SFP is there is no link down interrupt, so
> > the driver has to use polling to detect link down when the link is up.
> >
> > Recent change in the DSA operation can setup the port before the PHY
> > interrupt handling function is registered.  As the SGMII interrupt can
> > be triggered after port setup there is extra code in the interrupt
> > processing to handle this situation.  Otherwise a kernel fault can be
> > triggered.
> >
> > Note the SGMII interrupt cannot be masked in hardware.  Also the module
> > is not reset when the switch is reset.  It is important to reset the
> > module properly to make sure the interrupt is not triggered prematurely=
.
>=20
> Why not model this as a PCS? Russell has been converting all PCS like
> things in DSA into try PCS drivers. So i suspect Russell will not like
> this code, and would prefer a PCS driver.

I am not familiar with PCS.  It seems too complicated after looking at
the phylink_pcs structure and associated phylink_pcs_ops functions.

The SGMII module can only report link and does not even restart
auto-negotiation.  It is a set once and forget operation.


