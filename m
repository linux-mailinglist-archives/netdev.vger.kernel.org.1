Return-Path: <netdev+bounces-214733-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84A48B2B1E0
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 21:49:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 091AB1B65525
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 19:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C38C26FD8F;
	Mon, 18 Aug 2025 19:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b="dy9uU0sK"
X-Original-To: netdev@vger.kernel.org
Received: from rcdn-iport-6.cisco.com (rcdn-iport-6.cisco.com [173.37.86.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618A71F37D3
	for <netdev@vger.kernel.org>; Mon, 18 Aug 2025 19:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=173.37.86.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755546545; cv=fail; b=pAlnytAZL7XQ2QWJMBtwzskKnTDVTeSn2PIZsf9iTrki9Og4ILO1NlC+CiaxVZnykOxzjOKZyqZzA2PmLL+148q/OwJy0Dc28PkYlG1dt3PTjXJf6iULJxflNXGmMBDG7Y1w/u1eXNNMjy4wdRyD3NChOEhHO5s85LfFX1lNmT0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755546545; c=relaxed/simple;
	bh=oTh3e5RuKsuSnV+T+xC/1r9Ipufhl6tL1vusDQcPQ/I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CXhKKHCv8sppysh9qZNg0Cnd/AbdgpW/CvTx0H5hbwGMT+DPUu3R4271KOoCturbvmxE87qkMIlwEe00SNn6v/BeV9xqw30GZLaYzTmrkwMBJt6YkfsqfcMHq3lVeUgpcHDr7SHPtj2VzKbfujpBPMePWhd7utzSCTD8tBywbEQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b=dy9uU0sK; arc=fail smtp.client-ip=173.37.86.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=1890; q=dns/txt;
  s=iport01; t=1755546543; x=1756756143;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PwEJoTnBTCTIBvcgq0gvyTShCWAfuJ/8YjrEZGMULsA=;
  b=dy9uU0sK1udaizzB6T0FF1gVkc7Y4hJuN2o3r73GUKKIUmqICUYL1JvY
   YeBONy4Bm5aXx9bX1BkUxg9HlpjCsqIjpmB4H+EWSpyVqt6DP3lLkt2Fg
   ephYsY2sGjAejweDLVqzkCx62qcMdQSR32m5IfmcHXy63UXIcej31HGKc
   391/wg6Q91tjHXIrWZY+bKXLFzhYJqIASHLBHDQLq8f/+DZwsUMHFiQCM
   zdT2NpgexfDr8SrnWJG35Xh6A/eY1jGrfZ7PfK7w0VNTzj6PTbNQAXEO+
   UXwC11kZTrxzx18qp4KZLbHnskBYTlGcT2rXruelB5qfKm7HMJxSlNUOc
   A==;
X-CSE-ConnectionGUID: wQ+lOLl/QXKa66Uo3CCXiQ==
X-CSE-MsgGUID: 2XHsBVByTBiXn+vXG3wvAQ==
X-IPAS-Result: =?us-ascii?q?A0BGAAChgqNo/5IQJK1aGQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?RIBAQEBAQEBAQEBAQFAJYEugW5SB3qBHEkEiBwDhSyIeYJ+iGaUNQ8BAQENA?=
 =?us-ascii?q?i4WDQQBAYUHAowkAiY4EwECBAEBAQEDAgMBAQEBAQEBAQEBAQsBAQUBAQECA?=
 =?us-ascii?q?QcFgQ4Thk8NhloBAQEBAgEBESg/BQcEAgEIEQQBAR8QJwodCAIEDgUIGoJhg?=
 =?us-ascii?q?joDDyYDARCmFQGBQAKKK3iBNIEB4B8GgUkBiE8BhWwbhFwnG4FJRIFXeYFvP?=
 =?us-ascii?q?oIfQgSBYIQTgi8Egg0VRFKINoJohUGCaYZ+UngcA1ksAVUTFwsHBYEgQwOBD?=
 =?us-ascii?q?yNLBS0dgSd9hBmEJytPgiJ1gXdaP4NUEgwGaw8GgRUZHS4CAgIFAkM+gVwXB?=
 =?us-ascii?q?h4GHxICAwECAoEkQAMLbT03FBsFBIE1BZNEhGWBGHvFejBxCoQcjB6NPYIBh?=
 =?us-ascii?q?jEXqmuZBo4IhAmRd4UOAgQCBAUCEAEBBoF/JYFZcBWDIhM/GQ+XNK1AeAIBO?=
 =?us-ascii?q?QIHCwEBAwmTZwEB?=
IronPort-PHdr: A9a23:6+7Npxe3zP23gyavuZSzb7AJlGM/gIqcDmcuAtIPkblCdOGk55v9e
 RCZ7vR2h1iPVoLeuLpIiOvT5rjpQndIoY2Av3YLbIFWWlcbhN8XkQ0tDI/NCUDyIPPwKS1vN
 M9DT1RiuXq8NCBo
IronPort-Data: A9a23:gfNCJKniIOINBRBzl+Ao91fo5gzOJ0RdPkR7XQ2eYbSJt1+Wr1Gzt
 xIZXWuFOf2MYTPyL4h3b9++8ksG6JfTzd9iQAA/qyw9RVtH+JHPbTi7wugcHM8zwunrFh8PA
 xA2M4GYRCwMZiaC4E/raP649CMUOZigHtLUEPTDNj16WThqQSIgjQMLs+Mii+aEu/Dha++2k
 Y20+pK31GONgWYubzpEsvLb8XuDgdyr0N8mlg1mDRx0lAe2e0k9VPo3Oay3Jn3kdYhYdsbSb
 /rD1ryw4lTC9B4rDN6/+p6jGqHdauePVeQmoiM+t5mK2nCulARrukoIHKZ0hXNsttm8t4sZJ
 OOhGnCHYVxB0qXkwIzxWvTDes10FfUuFLTveRBTvSEPpqHLWyOE/hlgMK05FZIhueJQJWUJz
 Mw7IW5TUxfYrMmGwYvuH4GAhux7RCXqFIobvnclyXTSCuwrBMiSBa7L/tRfmjw3g6iiH96HO
 JFfMmQpNUqGOkERUrsUIMpWcOOAg2PwczpDqHqepLE85C7YywkZPL3FbIKEIoXTH5UK9qqej
 jj233/TPDsLCPae+TzG7EKD3fDRtBquDer+E5X9rJaGmma7wGEPBBAIfUW0rOP/iUOkXd9bb
 UsO9UITQbMa/UivSJz5Gha/unPB5k9aUNtLGOp84waIokbJ3zuk6qE/ZmcpQPQttdQ9Qnoh0
 Vrhoj8jLWUHXGG9IZ5FyoqpkA==
IronPort-HdrOrdr: A9a23:0+7L4aNqOctHksBcT47255DYdb4zR+YMi2TDiHoBKiC9I/b5qy
 nxppUmPEfP+UgssREb9expOMG7MBXhHO1OkPgs1NCZLUbbUQqTXc1fBOTZskfd8kHFh4pgPO
 JbAtdD4b7LfBZHZKTBkXSF+r8bqbHtntHL9ILjJjVWPH1Xgspbnn5E43OgYzZLrX59dOIE/f
 Snl616jgvlU046Ku68AX4IVfXCodrkqLLKCCRtOzcXrCO1oXeN8rDVLzi0ty1yb9pI+9gf2F
 mAtza8yrSosvm9xBOZ/XTU9Y5qlNzozcYGLNCQi+AOQw+cyjqAVcBEYfmvrTo1qOag5BIBi9
 /XuSotOMx19jf4Yny1mx3wwAPtuQxeqEMKiGXow0cLk/aJAA7SOPAxwr6xtSGprXbIiesMlZ
 6jGVjp7qa/QymwxBgVrOK4Jy2C3nDE0kbK19RjzkC2leAlGeVsRUt1xjIPLL4QWC3984wpC+
 9oEYXV4+tXa0qTazTDsnBo28HEZAV5Iv6qeDlKhiWu6UkfoFlpi08DgMAPlHYJ85wwD5FC+u
 TfK6xt0LVDVNUfY65xDPoIBZLfMB2BfTvcdGaJZVj3HqAOPHzA75bx/bUu/emvPJgF1oE7lp
 jNWE5R8WQyZ0XtA8uT24AjyGGGfEytGTD2js1O7ZlwvbPxALLtLC2YUVgr19Ctpv0Oa/erLc
 pb+KgmdMMLAVGebbqhhTeOKaW6AUNuJfEohg==
X-Talos-CUID: 9a23:JHDSP22dLq139QFkTPalpbxfBflmdlr5yDDpE2yxVzhUT+a+Ym+RwfYx
X-Talos-MUID: 9a23:sUimkQS0U/4mi4zlRXS2tBF5HvlC8piECXAL0os2lJKbKwVJbmI=
X-IronPort-Anti-Spam-Filtered: true
Received: from alln-l-core-09.cisco.com ([173.36.16.146])
  by rcdn-iport-6.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 18 Aug 2025 19:47:54 +0000
Received: from rcdn-opgw-4.cisco.com (rcdn-opgw-4.cisco.com [72.163.7.165])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by alln-l-core-09.cisco.com (Postfix) with ESMTPS id 59CCE1800021E
	for <netdev@vger.kernel.org>; Mon, 18 Aug 2025 19:47:54 +0000 (GMT)
X-CSE-ConnectionGUID: oW2CHkTTQi+96HYc63nrbw==
X-CSE-MsgGUID: 7kP5+SNOTyi5ogLOH7lW3w==
Authentication-Results: rcdn-opgw-4.cisco.com; dkim=pass (signature verified) header.i=@cisco.com
X-IronPort-AV: E=Sophos;i="6.17,300,1747699200"; 
   d="scan'208";a="57538444"
Received: from mail-dm6nam11lp2175.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.175])
  by rcdn-opgw-4.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 18 Aug 2025 19:47:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YI4vX1H1vUjqQH5PpCZJ7Yuw9Ccn1goB9QJlHa8ewFo3XaLWKdr8Spuw27MIpIzDK3uTU++koMsJXR7I5aEFACb/vPCGx5WUl5w7DzlLNPucxGl2f+dxa4D+mG9yeGFhESc2G2EbJnPCTKCcDBQNalMslzkNE5/l200h1MTHRG6iBcBD/UjCWh3xHf5rWdS3eTb5aPMa04QbHWClVCBRiOfnE2CNVTyMnIwuNmqNoiFIsyZaSLceAVf3NXz33GWOQlNf9SYXKsJd0qbysk2Yb7q+Kzw2+52JUoQnJBl07FMIl4jB8NzWarMmQKOkB2xKNoVNH8LkS5Mwe+tJcN5LMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PwEJoTnBTCTIBvcgq0gvyTShCWAfuJ/8YjrEZGMULsA=;
 b=l9UvppfUNiMkaSJNEJKTWCT5ly4TFdtLsNtEevpvT/GUAns0ZzgGY00+NHp8HDc5R/ZSjfIo7G/cU3aCNdAoGoseHV2PO/tQIYFDQh0pnxTDB0xRW4QNpRqWOuRYkwYmLW8L5Va2DTdjS+t6MrSLcm7+o6TsvyLTJLC185BgreirR0l7KcrQH2K0mlveLwSbS5ucg6eEevXLMoeyOmP9yD5CLPg4mlc4Oo8efHiwJ6QOX/yxFt6ph5xmVkEGAo4sLCpmG0SeYWRUeuiQ8HwawETN0EaRy6B+6KSPmzTFN92h/ho4LGVSKUA/Wr1j9KIVACnpLg1X0kQYjvjAisGj4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
Received: from SN7PR11MB7491.namprd11.prod.outlook.com (2603:10b6:806:349::8)
 by SJ0PR11MB5200.namprd11.prod.outlook.com (2603:10b6:a03:2df::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 19:47:51 +0000
Received: from SN7PR11MB7491.namprd11.prod.outlook.com
 ([fe80::4b22:100c:8231:120]) by SN7PR11MB7491.namprd11.prod.outlook.com
 ([fe80::4b22:100c:8231:120%3]) with mapi id 15.20.9031.019; Mon, 18 Aug 2025
 19:47:51 +0000
From: "Mrinmoy Ghosh (mrghosh)" <mrghosh@cisco.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>,
	"mrinmoy_g@hotmail.com" <mrinmoy_g@hotmail.com>, "Patrice Brissette
 (pbrisset)" <pbrisset@cisco.com>
Subject: RE: [PATCH iproute2] bridge:fdb: Protocol field in bridge fdb
Thread-Topic: [PATCH iproute2] bridge:fdb: Protocol field in bridge fdb
Thread-Index: AQHcDmfg/HByRIHOeUmtdsgj6F/OWbRldqeAgANcO3A=
Date: Mon, 18 Aug 2025 19:47:51 +0000
Message-ID:
 <SN7PR11MB7491F1A40BB259F4EF7603C4A431A@SN7PR11MB7491.namprd11.prod.outlook.com>
References: <20250816031145.1153429-1-mrghosh@cisco.com>
 <20250816092051.1a8e4ed3@hermes.local>
In-Reply-To: <20250816092051.1a8e4ed3@hermes.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR11MB7491:EE_|SJ0PR11MB5200:EE_
x-ms-office365-filtering-correlation-id: e0ae95a5-731c-49c2-5bbf-08ddde901de6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|13003099007|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?dAxrMmTT2gP8L2vuV4pCqKhtT4bmjvRxa+JcX0u3APuFy5jViuSuxkncTzBs?=
 =?us-ascii?Q?GqgIFekNQQSCa9+1q6+ttfUUdsJXfWCcvNVJjwJhwyehqqWMGcjIChg6/ikp?=
 =?us-ascii?Q?A9nggwG4jJchgEfwLPRwuUfEWK5KKlJWJAQfomsE/jCMFqj2GOqPyhh5mkeg?=
 =?us-ascii?Q?W//UxccvqO75TdQ90vkAJje6d+uEc6j5+aJgpW5nt5SP6ItAwe2d36epZdUa?=
 =?us-ascii?Q?8rF/r4IJPkkiAGqXzctrAaDMlTHvsEbGHgNW2yRPkNNIlSZ4+3McADE/QLHG?=
 =?us-ascii?Q?pkelYeGPPk0GeZ5n8kvXfrVg9Nht+/MqerBLyT5+7OSEsNhQSTgRTkbpDyjH?=
 =?us-ascii?Q?V3+r3pB9XHEWhECewSx5+NPHZVDznWqiBCO4TBSt1ADvVwCOMAtQm3kTTRoI?=
 =?us-ascii?Q?9VqXCuon34oYvBP1qRa3Q3C9OokvHo7nFx2o12rGM4iZmyCsYytEoR+FpVYO?=
 =?us-ascii?Q?ru2st5Wj+g3G6ufoQ+P2i7onDm0rPIlDhGO78qEOtRWaCA+ofQdjmty/sgQb?=
 =?us-ascii?Q?7ZapRfO2J4PQOUdvJhXh7wqi9Wr35jG/oaZ95TaZqesWfNh0nheOj3XLkxgC?=
 =?us-ascii?Q?6pWToa6g2TDZLlxaVtqrRUilJXfnyA0nx70pcp6RG3DVJxpCansgJ9SCc7+j?=
 =?us-ascii?Q?KsbjDUk0B3lp50X+Z28psrPUK8lE0N17gBY96bCqarNyI+b1YiaGSkGNmAKW?=
 =?us-ascii?Q?LjPcPAsgT5u3te2gHQuv4XKuisM4R3omqjoYpM3agqMOphLDoejZVC4vRANg?=
 =?us-ascii?Q?dYffGV4E+/jT3pAZKqGIk79M/dnta+rGuuq8y64mK4MEZ0eg/P4VVSVrMNcZ?=
 =?us-ascii?Q?LM6Ix/a1kqXzUTLdHm1Oh9h9lgA+OnoCqq8SQHtmur+PnTZvVfsJce6KOwVG?=
 =?us-ascii?Q?nGYFvlN30DTuPnlkcGKsexPmxJgcmLyteIR4yDhLtueHsypMpEqnnG/PPuJ6?=
 =?us-ascii?Q?gVsUNDmksoDY846u43hzIBmG4vhIcFd3iYutrDdX2FbOR8PRrD149WORZVtk?=
 =?us-ascii?Q?dtZ1kPPvyFmQG0/CPvu60VIkFEnE24llWjUjlGGKvymYNri44pkTsKmmsa/u?=
 =?us-ascii?Q?qMfpCojTb+/jpF+wBXYWKmtZkdSIPSqiEQ6edSMBlJGbpt2VSz+fcKNzYPog?=
 =?us-ascii?Q?ikXT5W1+8Amex5UD+EGNdLXAr3bYtgRX+bWufuYzYQ4kugxksFRL+QpzbOMa?=
 =?us-ascii?Q?7PDVYkWd+nW2AWTdzpoXngTgmQmNjAVITf2kN9pn4KT29+u5R+qbrxWTc1BN?=
 =?us-ascii?Q?3bwVkot/sBSCJkms3LOLLaCapG3tX7GDviNleTt8KaLG7hWWtq/ZlLz3GCl9?=
 =?us-ascii?Q?/zSmWrs2y/OiD3PL1rhjaTFpfOP8GlVnsHrZhtIoz0VzXHO4Nnk1YCBfGdEe?=
 =?us-ascii?Q?ow5HDmPBGwni9o1gHQ/0ECLg0HWazY9/vezWNk0KklDz4SPVmUjdqe3YrUar?=
 =?us-ascii?Q?FWtwhFzD+vBgJYmX+s1HYnfCzzQhqc6O?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7491.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(13003099007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?blXw4Frl8i+2oA4WfFYsoO4EA4KJnHaVyoDyo7643ge0f5tiPl38zFT12n0U?=
 =?us-ascii?Q?e0BmMCglx8TNkIOrTgLrV+nPwtRaK50O9pVsUzWkEz9nT9aJqXFbGb3fm6pX?=
 =?us-ascii?Q?cjV1UvqJgSdvRR5a+oubpOgVLFN1Nr/4qsqVqctqgo3dG/vUtWBEde10Bcy+?=
 =?us-ascii?Q?nkz14Fsg4uczpVtzkFB5kEeVEH44s+o+QQKSQhJvtrBNt3MIv8YWEX6ybGVD?=
 =?us-ascii?Q?nAp4ydyCh/ihouyw6IbX9QRgFxrN6nZVRagwbZYHSmDehuJBcPY8z17dpdfI?=
 =?us-ascii?Q?MtGxauMZjXzTe08mN8PFszAzdXMxndIqMa4Lt2RZR6KLFuIMEizSkL1jR3tS?=
 =?us-ascii?Q?oqPl3wNtgeOB+Sagi7DnQzNiJBcFWtv5BQpbyGVqNl/5rqbXveqvBDAdSPSM?=
 =?us-ascii?Q?cdgb3QOHvAwIx0VUawa5zr1bDDt6sf3lrV5Np4reyqRywk3YgUf7IVmBYR5l?=
 =?us-ascii?Q?SoD6kMZKcGr/sDs7zmlvC3WeLOkjg7/J/gtB02dUPUV6y7dMVYXi/xII0UCT?=
 =?us-ascii?Q?fy4JJ7tQ9tmOYnz2yQn66bOiu3gAC21kmWM+tGakDSDQp/u1sZYvYD+cfFNY?=
 =?us-ascii?Q?uubOCr52QvSnvHQ+eOzF3AyiHWvaXMYXaR4S7g8LBeDLCvxHai9CpArUUqHV?=
 =?us-ascii?Q?sl4HhPzAXZQpNWIdfPkixW4unhYQNSCFzUstxHepYo+DgKMuZVAZQMWr//LV?=
 =?us-ascii?Q?csLPTyaiiMJFPYxT86vXTCpSXapzYJP5kYkgEmEksMsCGX8+L06wJiLu42li?=
 =?us-ascii?Q?BWH83m7w1xVjXs7rSU5CV55QX63L7csoyCuS1g8uqcimlWXTaH3WpiGc/Jny?=
 =?us-ascii?Q?r4fNK7dt+clswEeW7wkuut4CAYsI6GegiFx0v1vV3A7Gj1dfSmuvfrhX/YFj?=
 =?us-ascii?Q?LgUDo0hFRYL3/zvFIyQLQAwBJ7qvu+K/qoAaAL0lcogSZIFtDVtD0+Tdb52G?=
 =?us-ascii?Q?HQsH6K0NKnU7Hg55nFPy6hG8PJ9ZhV3VsN+12G7A1isZoosVzWxSGiaZnb95?=
 =?us-ascii?Q?+8Bza4z8xJFoiLhBYav458ZBdKh2m25rhaoS7mBiSa9x3KERgsW6UVHEZ9cK?=
 =?us-ascii?Q?zvPks6mUQUg5XZC1BILvibB1q1SVozr85dgJd1u+y9yLjT7V5wuI17MxbJSx?=
 =?us-ascii?Q?sPU4Tdp+SjNEKQXia+r8UVh6xKGWjtsHDF+9IL2VYueRQIFcqbg5A+n0MMUu?=
 =?us-ascii?Q?7qkl6dU6zRuqsWp9q6vcB2RlsZZvB+ayxmI6wS0jHwrkqDpMzScO6UhMcoOE?=
 =?us-ascii?Q?wsOzZfXF2EkQFg5drU02q9xHz5+IVBGgmjoCp6YMR2DA4lxUvhlJ929QG6w4?=
 =?us-ascii?Q?Ihjs++cMAg1gcTFxNAjBx/kb2xl+RKD3KsYCudPWvZDOeVNUKo7Z9IdT8qnK?=
 =?us-ascii?Q?iKmek6hIurzx2tJCxViHz1isdOAt/WJKsS/MBYzTAOLI5dlstht5Fz1L1+yU?=
 =?us-ascii?Q?rcys6Sl1ekvN06JLxshxf1hxbbKo8Rhd5KwpXNGU3+RvKs7qG29eWy1HFap6?=
 =?us-ascii?Q?qoT0Oer2A0r1aDtkBuj4v7jFArR53sTIUKMLQTD+QEotE7MpWqsGq9S+g6TT?=
 =?us-ascii?Q?9FoUF8ad4rj4Fj6y28w=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: cisco.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7491.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0ae95a5-731c-49c2-5bbf-08ddde901de6
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2025 19:47:51.4370
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VSTBG7VI403FNUVdphpgEkS+mD/tAyCze+gQwnWJuHzrlBhgKURbb948spj9slaXHe9vIphkFv0wm+2FbEt2IA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5200
X-Outbound-SMTP-Client: 72.163.7.165, rcdn-opgw-4.cisco.com
X-Outbound-Node: alln-l-core-09.cisco.com

Hi Stephen,

Thanks for the review.
The kernel patch is in:
https://lore.kernel.org/netdev/20250818175258.275997-1-mrghosh@cisco.com/T/=
#u

I have created a new patch review request for iproute2-next. Updated, the e=
tc/iproute2/rt_protos based on your review comments:
https://lore.kernel.org/netdev/20250818193756.277327-1-mrghosh@cisco.com/T/=
#u

Thanks,
Mrinmoy

-----Original Message-----
From: Stephen Hemminger <stephen@networkplumber.org>=20
Sent: Saturday, August 16, 2025 12:21 PM
To: Mrinmoy Ghosh (mrghosh) <mrghosh@cisco.com>
Cc: netdev@vger.kernel.org; bridge@lists.linux-foundation.org; mrinmoy_g@ho=
tmail.com; Mike Mallin (mmallin) <mmallin@cisco.com>; Patrice Brissette (pb=
risset) <pbrisset@cisco.com>
Subject: Re: [PATCH iproute2] bridge:fdb: Protocol field in bridge fdb

On Sat, 16 Aug 2025 03:11:45 +0000
Mrinmoy Ghosh <mrghosh@cisco.com> wrote:

> diff --git a/include/uapi/linux/rtnetlink.h=20
> b/include/uapi/linux/rtnetlink.h index 085bb139..1ff9dbee 100644
> --- a/include/uapi/linux/rtnetlink.h
> +++ b/include/uapi/linux/rtnetlink.h
> @@ -314,6 +314,7 @@ enum {
>  #define RTPROT_OSPF		188	/* OSPF Routes */
>  #define RTPROT_RIP		189	/* RIP Routes */
>  #define RTPROT_EIGRP		192	/* EIGRP Routes */
> +#define RTPROT_HW		193	/* HW Generated Routes */
> =20
>  /* rtm_scope
> =20
> diff --git a/lib/rt_names.c b/lib/rt_names.c index 7dc194b1..b9bc1b50=20
> 100644
> --- a/lib/rt_names.c
> +++ b/lib/rt_names.c
> @@ -148,6 +148,7 @@ static char *rtnl_rtprot_tab[256] =3D {
>  	[RTPROT_OSPF]	    =3D "ospf",
>  	[RTPROT_RIP]	    =3D "rip",
>  	[RTPROT_EIGRP]	    =3D "eigrp",
> +	[RTPROT_HW]	    =3D "hw",
>  };
> =20
>  struct tabhash {

This is iproute2-next material.

Where is the kernel patch for this?
Iproute headers are synced from kernel headers.

If you add new RTPROT entry also need new line into etc/iproute2/rt_protos



