Return-Path: <netdev+bounces-287552-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0AlkEn5kBGq6HgIAu9opvQ
	(envelope-from <netdev+bounces-287552-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 13:46:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A115327BC
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 13:46:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D22F530DEAB8
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 11:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 729233FE656;
	Wed, 13 May 2026 11:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=solid-run.com header.i=@solid-run.com header.b="iWk7S4tu";
	dkim=pass (2048-bit key) header.d=solid-run.com header.i=@solid-run.com header.b="iWk7S4tu"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021143.outbound.protection.outlook.com [52.101.70.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4553FF889;
	Wed, 13 May 2026 11:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.143
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778672707; cv=fail; b=nKNP2MfMRFliYeqa10N2so3PlcBtuujq+Bz/ObKLUtB30tLly9h9pKzExTk2PixiPAZy4Me5Pz8i+WcwK8aDYSEIY8thXqBkGXS6xBibwlYLK5Kxp4VrgxvX9uQvNUDIJHra8T3VY+vmkvvws0aUa1zWxhOCqYVFqfIZHbgxMgI=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778672707; c=relaxed/simple;
	bh=eVDs4rnYc+bHngzBYa8RS0emyC6jw0GeL5BpxXy+VEg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=g/0jV8mHXg/8IvRW7C0JyzmFAk8+Y+ZqARworb2FX1Vmbcfsl0WEDmkDLfr1/oO4GPaCcdC62V/4DWOGmcfVUOkqAbpYD/rSJugYqEBTpim+HB9FpfIEUQzZdMkNIXqmUG1/ZNRjtjtQ2hAOwb5Ei/WaIVZFInwVyyuHqFhyU6A=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (2048-bit key) header.d=solid-run.com header.i=@solid-run.com header.b=iWk7S4tu; dkim=pass (2048-bit key) header.d=solid-run.com header.i=@solid-run.com header.b=iWk7S4tu; arc=fail smtp.client-ip=52.101.70.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=EhtrlbpvBH7LewG624s0TuGJnULDZYSEHC274+V1m9Zce6bhg8wUfyHQ/8IR3cs9Vmu9HrABIgT42gDZXg6qYOaj8oiqnYDbqwiQX3oIaL3GN7NxwdCrXyyVsd/SSaZpmFRuh7J3EHGph+ozAayGPor7KLOLAdAPHcWmeyjO68ChT5b1xJvMhw85r4bX02BP+dZ5CJ/u5N4AO3rqTmKoPg6uQMoAQkTOk3yi7nlTG3sXPkT0oqguj0yCA/H3gDAAD/ztf9ToRUZk45tCHs7vQadRf9mRSWtBIC4ssF+axNlS53eEUFQl6t+jFFmlHv9kle1uv/Qd+qU8GGnvU2xfbA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eVDs4rnYc+bHngzBYa8RS0emyC6jw0GeL5BpxXy+VEg=;
 b=gDv39jg3OqgLjJqUXqM3IrI3q6gYsspTRL8LgJRiXmba0cOHskCtvFERO3g74i/GjCW6vGV/gVUk3Iebbki0xCDzz76u1pcx5PEKjtoveuzLsM064cnmxmva/r9B11Rp8oCzl21mSZIfpbvA4I+txAzgSU/OZQ4qAmD/uf976Lz2IqCMbRG3We2uTzI258BvA7gdW4QOYMHfMDkEbQVuoDR04aNRsnJtM8uZZY2vvGRjD/zSOZrMPnHhDC3MjzHj3Is9NG9BTmEg9nwi88U1wC9vqXR8MxEDhzSGSBOTpulnATwijXTIKzx6JUeOYzhBN9I4jks8wEYI8OHuVjYoIQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=fail (sender ip is
 52.17.62.50) smtp.rcpttodomain=kernel.org smtp.mailfrom=solid-run.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=solid-run.com; dkim=pass (signature was verified)
 header.d=solid-run.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=solid-run.com] dkim=[1,1,header.d=solid-run.com]
 dmarc=[1,1,header.from=solid-run.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=solid-run.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eVDs4rnYc+bHngzBYa8RS0emyC6jw0GeL5BpxXy+VEg=;
 b=iWk7S4tus59vUBgCw4y3rRypz5JwNNV4Fbig5y2qYdcwAA9wetTdzTdqYSi1LBxKkaAe30JuZ+UqObvtLyINYmSWyfDzFEVziBPl4ibSBQrYsgw5YDKwN+GBCbI4NO98VFxAUCPc5xwUHKhhzbYj1INQVgYPEmpCmHt6KIzY+PFUS8VTbGljD/QsKOFSHgCwj+sVt3t7ZgP1MsjLoIAifnkBTVszovifiNr+uIfnMKoJuNTTNmLxOGbjVjPn9G4YovenuKt2jQrbt5/Dq/qYEsiuO531hctgd/OPHWkkKSQAuaeePZ1OG0rZRVFVTCIM/htuGHT43antQukpLYRmJA==
Received: from DU2PR04CA0057.eurprd04.prod.outlook.com (2603:10a6:10:234::32)
 by PA6PR04MB11888.eurprd04.prod.outlook.com (2603:10a6:102:519::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 11:44:59 +0000
Received: from DB5PEPF00014B9C.eurprd02.prod.outlook.com
 (2603:10a6:10:234:cafe::c8) by DU2PR04CA0057.outlook.office365.com
 (2603:10a6:10:234::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.12 via Frontend Transport; Wed,
 13 May 2026 11:44:59 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solid-run.com;dmarc=pass action=none header.from=solid-run.com;
Received-SPF: Fail (protection.outlook.com: domain of solid-run.com does not
 designate 52.17.62.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=52.17.62.50; helo=eu-dlp.cloud-sec-av.com;
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 DB5PEPF00014B9C.mail.protection.outlook.com (10.167.8.170) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.13
 via Frontend Transport; Wed, 13 May 2026 11:44:59 +0000
Received: from emails-47767-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-5-220.eu-west-1.compute.internal [10.20.5.220])
	by mta-outgoing-dlp-305-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id 504857FFFC;
	Wed, 13 May 2026 11:44:59 +0000 (UTC)
X-Mailbox-Line: From b'josua@solid-run.com' Wed May 13 11:44:49 2026
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oHTtrMTk8bK5THIypBs6rmcX6ftv0BCYiWt5mC9M2HlqN1+8eiLJFP4ZOGoW/frvcz61XbAslClRfA9VJzMYKZJutX6RBPHSnnoRj6nZw6I/JQrzBh/msV8kg4Cvt9r3QBI2K4LIGEj4wifKVfK0skc2888XUGL08IXaY5JA+RiR+36AlgP01KQi+LZuV/hih7qNtp5vlABmk7He9oAlBiNnbCZZREdBFeWDPH8oVWZR4fdHVaLx5LMd2jFnKbpX++nvwhbTVvxaOzI5E+3H04GRb4l57Dhiz3pKK/Qa54NPk64ZinrGPiaI1lrcUKD6tdNc74BYgKIuMzt0D0kZ1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eVDs4rnYc+bHngzBYa8RS0emyC6jw0GeL5BpxXy+VEg=;
 b=Tz6HxzF1JSCCDYApSFF/7yTI88e0nz1/AtYYW/j1Gh9jbfF/YvauNXGZPw/ol+yGGuK8QgMlWrhf/wbaeAQbLbxAakc2tRyZmLLtjMuivZNuVJoRpOA7q5UL8l23tJ7jeVXagUXi6jUa8CDX5PF9bxl3CMgWXU7C3ywJW2OelodUr0hSYuXYGnb930MpaIR18+y8OGjnRzfM95woAOuZKdS0Xtg4qWJc/knQbjijOCj8DusNtLkgWKrHCZlAzEIDsGwa9+z+Zs68XOIATo/gEakAb/jUTEvxiGXEeN8W+saTa6fXcwO5fH/jAjx0xxv2IpR7mdus7HxShn5pE8D7yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=solid-run.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eVDs4rnYc+bHngzBYa8RS0emyC6jw0GeL5BpxXy+VEg=;
 b=iWk7S4tus59vUBgCw4y3rRypz5JwNNV4Fbig5y2qYdcwAA9wetTdzTdqYSi1LBxKkaAe30JuZ+UqObvtLyINYmSWyfDzFEVziBPl4ibSBQrYsgw5YDKwN+GBCbI4NO98VFxAUCPc5xwUHKhhzbYj1INQVgYPEmpCmHt6KIzY+PFUS8VTbGljD/QsKOFSHgCwj+sVt3t7ZgP1MsjLoIAifnkBTVszovifiNr+uIfnMKoJuNTTNmLxOGbjVjPn9G4YovenuKt2jQrbt5/Dq/qYEsiuO531hctgd/OPHWkkKSQAuaeePZ1OG0rZRVFVTCIM/htuGHT43antQukpLYRmJA==
Received: from GVXPR04MB12057.eurprd04.prod.outlook.com
 (2603:10a6:150:313::24) by DB9PR04MB8105.eurprd04.prod.outlook.com
 (2603:10a6:10:24a::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 11:44:45 +0000
Received: from GVXPR04MB12057.eurprd04.prod.outlook.com
 ([fe80::14f1:a127:2988:de5b]) by GVXPR04MB12057.eurprd04.prod.outlook.com
 ([fe80::14f1:a127:2988:de5b%7]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 11:44:45 +0000
From: Josua Mayer <josua@solid-run.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>, "linux-phy@lists.infradead.org"
	<linux-phy@lists.infradead.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Ioana Ciornei
	<ioana.ciornei@nxp.com>, Vinod Koul <vkoul@kernel.org>, Neil Armstrong
	<neil.armstrong@linaro.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Rabeeh Khoury <rabeeh@solid-run.com>, Yazan
 Shhady <yazan.shhady@solid-run.com>
Subject: Re: [PATCH phy-next 5/5] phy: lynx-28g: add support for 25GBASER
Thread-Topic: [PATCH phy-next 5/5] phy: lynx-28g: add support for 25GBASER
Thread-Index: AQHc4VcBNwfvvLflf0GuY4D0POuBgbYL1wIAgAACGYA=
Date: Wed, 13 May 2026 11:44:45 +0000
Message-ID: <7e5ee76d-db29-417d-9e1c-513f051dfc42@solid-run.com>
References: <20260511150023.1903577-1-vladimir.oltean@nxp.com>
 <20260511150023.1903577-6-vladimir.oltean@nxp.com>
 <1ba1f688-9f68-4749-a18f-20ae91738ae0@solid-run.com>
In-Reply-To: <1ba1f688-9f68-4749-a18f-20ae91738ae0@solid-run.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
x-ms-traffictypediagnostic:
	GVXPR04MB12057:EE_|DB9PR04MB8105:EE_|DB5PEPF00014B9C:EE_|PA6PR04MB11888:EE_
X-MS-Office365-Filtering-Correlation-Id: b0538fa2-2224-468d-c1ee-08deb0e50ffb
x-cloud-sec-av-info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|366016|1800799024|3023799003|22082099003|18002099003|38070700021|56012099003;
X-Microsoft-Antispam-Message-Info-Original:
 5QV5oAiKGJ4npSPPAM7wcs8fjqwavIGBlhreRdXxTmMUYZEMeWp7UPxAq8BA7senBDX3B5yjIV9maxIVUQXW6ZsA7xkMibLQ74YeBCxv289E9Zq1QfoRij2TGzocI5K9VqUubDvx5mTgZqcQQBHpQ/AhF38DyJD/q5H+gXUIz4lMZZgLLHPQaIaVlYRQ7972lSGmrhrwIHo6baJjgkSJ/On4MtnvN7I4IBNuPHUG+eAEouPKbBk/rHNgn48gGlHcTk6CHHyII4X5ckYngcZ/pPdE78Ui/oBwqUCDvqgXSiQtxl/qHYCL0XcIyGiSRHck6qq1Gm96hxc+oWjtWAs5AxhRapv+2g5H7uxBig4ZcMhBb9lJqLu9QDACC7hxx5woGkJIKkSWc3aoTX93VrYappQ3UXFrI55lXjQtXWofj+ns6UNwQRaH6M+aFAoYtV8VgqpNgPkDqN9855msUuKnMwQ/Bs1Xl5gJksrxkBLZnObkrs1lR/AJtmeKMAk6qhIHopLFrpmDLEDabU2QmPRtcUFa3ol28VRQa0H+UOCPO6EUG8Mrci04BK4kGrIFNTSfamPpkZJK+Zh+8rYPuXoCTAVvwUZOGu7j1Xt6rQb5ycs/7Tz49OGC3YZWm5lmWx5UU6V6zdtFlTtIg716C50QQ7QTI5sK/AvPNmfB4UGu7Oo1VC0ZoPhXR9Weoey4rzlQnJaEHr/0Mn7voHzKaMmF0ppogAUYWJesip9f3K7MICNla7hxMLFpKh4BoKWwKPCY
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12057.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(3023799003)(22082099003)(18002099003)(38070700021)(56012099003);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="utf-8"
Content-ID: <D3B435CF2BCD8C4C87B92FAF411877E6@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
 uFfBlgAJzF1t3/iE0TkB4RXaUrb0plQTmbz3Ia+EfVCBN4qxgC+QJSVMKsDcKcCx5TDfrhER4XR+xPdzswG+TWBajHO2RkOM7djKO4CWdNbwW6Qrk81PE/vz/+SjtyZwtSMeK6eALUDQpXzznZuQKQ//IwqkP7MsyR/vaUtgvfpSIujn2sDBTN6mgmBsqT5AlSyZZdRbeveQtTZAveuLemf1+5YUN4OssvUM9EV008TxhAB8lVtajnb55kL0PQndhI1BWYtZ5OD+e03eIca/xDyEu1oG3b+BQ2j1D6QXD16t7rM73ItHIzfYNPztAUZxz8l9eU89bo/RVoiXCthN+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8105
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2-7.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: c871cd4d46fe4d07b82c978cc11e4a77:solidrun,office365_emails,sent,inline:1412bcce9e7a9c86e8f6ce96ca54cbf1
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB5PEPF00014B9C.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	c8187ac4-d2d6-4448-b10a-08deb0e5078e
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|14060799003|1800799024|35042699022|376014|13003099007|56012099003|18002099003|22082099003|3023799003;
X-Microsoft-Antispam-Message-Info:
	kWUyrhNV4AN5hkF7cEISvdduYcXqNm+eolhLyxxagdbodmg1dhtpCncIMqb3iXR1bqJvf8RjcoZCYIFpKBdZ/0qUIQ1tqFAoucVS8JyWG6XuufKG6cSGEvMeEXQiN3FCH6/204Yxih9jzh7xZvMo5FI3cPN6r87EmG/ZAtSsdbollv+XfdBeXSfnX4UhERLLdw6r9wkxiSaVaFwBOpFJZ+TsnyQMT/YC5OdmqGnxV4wrzt69+st9PxWP7ZWLK+Vg9oQNaUu4xQ0sBLdA7sD37ky5hlCVFrRT3SbA86MJz88puyKNAgzxzBXFaeuptD2Je3rp0jNXlZD8TI23Ly7ZmEKuMoNFYVsoDbKU6TqP8noQu3tFLu2grRXBKgYZZ4ZNuwkB4Cy/jWwwa3x+W75x5DdYMUD1jTjeslYxo7QYlUBqC5UI1DxBaYI1b8wl61eiml2pB5Hm/VFoVR3NbHEV7m0bEBrkmJF7+alnyw06EniFU3wOiX7XtFMvCSukU+4KUVOFOAXT4eMOCQ1RSxAdzkYF2JEe8uXso5meRcq8oRROIborxhKXwezHi6fNocL0Ql+oSTGUnWvrGjntV9W9j2YKus4rmqdYuqv6GqH9wUPO7yYDR9kAmscHvW+jLL7nP3coPYQXoaAHcnoQHkv9JsGMWexBEx5q2pg5kgGcSX6OgKreJiM2j6POPIZsGa0IoHwKxf89ac02LT6Gs3vPHphaudyvjwJWEQJC4gsIJy8=
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(14060799003)(1800799024)(35042699022)(376014)(13003099007)(56012099003)(18002099003)(22082099003)(3023799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	UUsfDT7hrZy01Sn2L4miveOm7/QkbBi2scY8FhS1wM/wRShdctIFxZXuZcK8Hj/NABEFU9Ul/OY0KSwnXLW+0AsPB01vW/NKoBIU3jByAtRXYpM1+mgy312tv+mfEB91oWQOT9zpibbZNJauTV26OGtT5TKzYwlunbGpRiVO/ZZJGsm7Oaj9of7v9XG9lw1hf1jb3q6Hata/yfYzFV+zQZjUgXC61c2EWXH4/Wnbdcbe/xzK9g1oy7jiWPAWizHeZRjpv6AM72cWxtE4eapiGN8znkSnv0NYII1DmQfT5Ed9y71ezwPiaDjRNVCEfZYEKvyuvqpXWZEiK1FDVvT3jiksEt8iC8Q5dPjrFANXi+YVa98wZoEUBBxeJ+xSZjFXNfvRGxWFKISBCvuEJKPgDvqKfJq1Igitsj67Y7HYRD+DXCKmEYcFe14qg3jFrZOM
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 11:44:59.4914
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0538fa2-2224-468d-c1ee-08deb0e50ffb
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B9C.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR04MB11888
X-Rspamd-Queue-Id: A6A115327BC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=3];
	DMARC_POLICY_ALLOW(-0.50)[solid-run.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[solid-run.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-287552-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[solid-run.com:mid,solid-run.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:email,localhost:email];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[solid-run.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[josua@solid-run.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

DQpBbSAxMy4wNS4yNiB1bSAxMzozNyBzY2hyaWViIEpvc3VhIE1heWVyOg0KPiBBbSAxMS4wNS4y
NiB1bSAxNzowMCBzY2hyaWViIFZsYWRpbWlyIE9sdGVhbjoNCj4+IEZyb206IElvYW5hIENpb3Ju
ZWkgPGlvYW5hLmNpb3JuZWlAbnhwLmNvbT4NCj4+DQo+PiBBZGQgc3VwcG9ydCBmb3IgMjVHQkFT
RS1SIGluIHRoZSBMeW54IDI4RyBTZXJEZXMgUEhZIGRyaXZlci4gVGhpcyB3aWxsDQo+PiBiZSB1
c2VkIGJ5IHRoZSBkcGFhMi1tYWMgY29uc3VtZXIgb24gTFgyMTYwQSB3aXRoOg0KPj4gLSBwaHlf
dmFsaWRhdGUocGh5LCBQSFlfTU9ERV9FVEhFUk5FVCwgUEhZX0lOVEVSRkFDRV9NT0RFXzI1R0JB
U0VSKSB0bw0KPj4gICBkZXRlY3Qgc3VwcG9ydC4NCj4+IC0gcGh5X3NldF9tb2RlX2V4dChwaHks
IFBIWV9NT0RFX0VUSEVSTkVULCBQSFlfSU5URVJGQUNFX01PREVfMjVHQkFTRVIpDQo+PiAgIHRv
IHJlY29uZmlndXJlIHRoZSBsYW5lIGZvciB0aGlzIHByb3RvY29sLg0KPj4NCj4+IFRoZSBpbnRl
bmRlZCB1c2UgY2FzZSBmb3IgZHluYW1pYyBwcm90b2NvbCBzd2l0Y2hpbmcgdG8gMjVHQmFzZS1S
IGlzDQo+PiB3aXRoIFNGUDI4IG1vZHVsZXMsIGFuZCBwcm90b2NvbCBzd2l0Y2hpbmcgaXMgdHJp
Z2dlcmVkIGJ5IHRoZSBTRlANCj4+IG1vZHVsZSBpbnNlcnRpb24uIFRoZXJlIGFsc28gZXhpc3Rz
IGEgMjVHQmFzZS1LUiB1c2UgY2FzZSwgd2hlcmUgdGhlDQo+PiBwcm90b2NvbCBzd2l0Y2hpbmcg
aXMgY292ZXJlZCBieSBJRUVFIDgwMi4zIGNsYXVzZSA3MyBhdXRvLW5lZ290aWF0aW9uLg0KPj4g
SG93ZXZlciwgdGhhdCBpcyBub3QgaGFuZGxlZCBoZXJlOyBpdCBtZXJlbHkgbmVlZHMgdGhlIHN1
cHBvcnQgYWRkZWQNCj4+IGhlcmUgYXMgYmFzaWMgZ3JvdW5kIHdvcmsuDQo+Pg0KPj4gVGhlIGxh
bmUgZnJlcXVlbmN5IGZvciAyNUdiRSBpcyBzb3VyY2VkIGZyb20gYSBjbG9jayBuZXQgZnJlcXVl
bmN5IG9mDQo+PiAxMi44OTA2MjUgR0h6LCBhcyBwcm9kdWNlZCBieSBQTExGIG9yIFBMTFMsIGZ1
cnRoZXIgbXVsdGlwbGllZCBieSB0aGUNCj4+IGxhbmUgYnkgMi4gVGhlIGNsb2NrIG5ldCBmcmVx
dWVuY2llcyBwcm9kdWNlZCBieSB0aGUgUExMcyBhcmUgdHJlYXRlZCBhcw0KPj4gcmVhZC1vbmx5
IGJ5IHRoZSBkcml2ZXIsIHNvIHRoZSBhYnNlbmNlIG9mIGEgUExMIHByb3Zpc2lvbmVkIGZvciB0
aGUNCj4+IHJpZ2h0IGNsb2NrIG5ldCBmcmVxdWVuY3kgaW1wbGllcyBhYnNlbmNlIG9mIDI1R2JF
IHN1cHBvcnQsIGV2ZW4gdGhvdWdoDQo+PiBhIGxhbmUgbWlnaHQgaGF2ZSB0aGUgYXBwcm9wcmlh
dGUgcHJvdG9jb2wgY29udmVydGVyIGZvciBpdC4NCj4+DQo+PiBJbiB0ZXJtcyBvZiBpbXBsZW1l
bnRhdGlvbiwgdGhlIGNoYW5nZSBjb25zaXN0cyBvZjoNCj4+IC0gZGV0ZXJtaW5pbmcgYXQgcHJv
YmUgdGltZSBpZiBhbnkgUExMIHdhcyBwcmVjb25maWd1cmVkIGZvciB0aGUNCj4+ICAgcmVxdWly
ZWQgY2xvY2sgbmV0IGZyZXF1ZW5jeSBmb3IgMjVHYkUNCj4+IC0gYWRkaW5nIHRoZSBkZWZhdWx0
IGxhbmUgcGFyYW1ldGVycyBmb3IgcmVjb25maWd1cmluZyBhIGxhbmUgdG8gMjVHYkUNCj4+ICAg
aXJyZXNwZWN0aXZlIG9mIHRoZSBvcmlnaW5hbCBwcm90b2NvbA0KPj4gLSBhbGxvd2luZyB0aGlz
IG9wZXJhdGluZyBtb2RlIG9ubHkgb24gc3VwcG9ydGVkIGxhbmVzLCBpLmUuIGFsbCBsYW5lcw0K
Pj4gICBvZiBMWDIxNjJBIFNlckRlcyAjMSwgYW5kIExYMjE2MEEgU2VyRGVzIGxhbmVzIDAtMSwg
NC03Lg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IElvYW5hIENpb3JuZWkgPGlvYW5hLmNpb3JuZWlA
bnhwLmNvbT4NCj4+IFNpZ25lZC1vZmYtYnk6IFZsYWRpbWlyIE9sdGVhbiA8dmxhZGltaXIub2x0
ZWFuQG54cC5jb20+DQo+PiAtLS0NCj4+IENoYW5nZSBwcmV2aW91c2x5IHN1Ym1pdHRlZCBhdDoN
Cj4+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LXBoeS8yMDI2MDExNDE1MjExMS42MjUz
NTAtNi12bGFkaW1pci5vbHRlYW5AbnhwLmNvbS8NCj4+DQo+PiBDaGFuZ2VzOg0KPj4gLSByZXdv
cmQgY29tbWl0IG1lc3NhZ2UNCj4+IC0tLQ0KPj4gIGRyaXZlcnMvcGh5L2ZyZWVzY2FsZS9waHkt
ZnNsLWx5bngtMjhnLmMgfCA5MCArKysrKysrKysrKysrKysrKysrKysrKy0NCj4+ICAxIGZpbGUg
Y2hhbmdlZCwgODggaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gSW4gb3JkZXIgdG8g
dGVzdCB0aGlzIHBhdGNoIHdpdGggMjVHYnBzIGxpbmssIGFkZGl0aW9uYWwgY2hhbmdlcyBvbiBv
dGhlciBkcml2ZXJzIGFyZSBuZWVkZWQuDQo+IFRoaXMgaXMgbm90IGEgc2hvcnQtY29taW5nIG9m
IHRoaXMgcGF0Y2guDQo+DQo+IDEuIEkgdGVzdGVkIHRoaXMgcGF0Y2gtc2V0IGFsb25lIG9uIExY
MjE2MiBDbGVhcmZvZyB3aXRoIFNEMSBQcm90b2NsIDE4IChpLmUuIDJ4IDEwRyBTRlAsIDJ4IDI1
RyBTRlApOg0KPg0KPiAxMEdicHMgcG9ydHMgYXJlIHdvcmtpbmcgZmluZSENCj4NCj4gMjVHYnBz
IGZhaWwgdG8gcHJvYmUgKGJ1dCB0aGlzIGlzIHBhcnRseSBleHBlY3RlZCk6DQo+DQo+IFvCoCDC
oCA4LjM3MzA0OF0gZnNsX2RwYWEyX2V0aCBkcG5pLjkgKHVubmFtZWQgbmV0X2RldmljZSkgKHVu
aW5pdGlhbGl6ZWQpOiBNQUMgcmV0dXJuZWQgUENTIHdoaWNoIGRvZXMgbm90IHN1cHBvcnQgMjVn
YmFzZS1yDQo+IFvCoCDCoCA4LjM3MzA2NV0gZnNsX2RwYWEyX2V0aCBkcG5pLjkgKHVubmFtZWQg
bmV0X2RldmljZSkgKHVuaW5pdGlhbGl6ZWQpOiBNQUMgcmV0dXJuZWQgUENTIHdoaWNoIGRvZXMg
bm90IHN1cHBvcnQgMjVnYmFzZS1yDQo+IFvCoCDCoCA4LjM3MzA3NF0gZnNsX2RwYWEyX2V0aCBk
cG5pLjkgKHVubmFtZWQgbmV0X2RldmljZSkgKHVuaW5pdGlhbGl6ZWQpOiBmYWlsZWQgdG8gdmFs
aWRhdGUgbGluayBjb25maWd1cmF0aW9uIGZvciBpbi1iYW5kIHN0YXR1cw0KPiBbwqAgwqAgOC4z
NzMwNzhdIGZzbF9kcGFhMl9ldGggZHBuaS45ICh1bm5hbWVkIG5ldF9kZXZpY2UpICh1bmluaXRp
YWxpemVkKTogRXJyb3IgY29ubmVjdGluZyB0byB0aGUgTUFDIGVuZHBvaW50OiAtRUlOVkFMDQo+
IFvCoCDCoCA4LjcyNTAwNF0gZnNsX2RwYWEyX2V0aCBkcG5pLjk6IHByb2JlIHdpdGggZHJpdmVy
IGZzbF9kcGFhMl9ldGggZmFpbGVkIHdpdGggZXJyb3IgLTIyDQo+IFvCoCDCoCA4LjkyMDc2Nl0g
ZnNsX2RwYWEyX2V0aCBkcG5pLjggKHVubmFtZWQgbmV0X2RldmljZSkgKHVuaW5pdGlhbGl6ZWQp
OiBNQUMgcmV0dXJuZWQgUENTIHdoaWNoIGRvZXMgbm90IHN1cHBvcnQgMjVnYmFzZS1yDQo+IFvC
oCDCoCA4LjkyMDc4M10gZnNsX2RwYWEyX2V0aCBkcG5pLjggKHVubmFtZWQgbmV0X2RldmljZSkg
KHVuaW5pdGlhbGl6ZWQpOiBNQUMgcmV0dXJuZWQgUENTIHdoaWNoIGRvZXMgbm90IHN1cHBvcnQg
MjVnYmFzZS1yDQo+IFvCoCDCoCA4LjkyMDc5MV0gZnNsX2RwYWEyX2V0aCBkcG5pLjggKHVubmFt
ZWQgbmV0X2RldmljZSkgKHVuaW5pdGlhbGl6ZWQpOiBmYWlsZWQgdG8gdmFsaWRhdGUgbGluayBj
b25maWd1cmF0aW9uIGZvciBpbi1iYW5kIHN0YXR1cw0KPiBbwqAgwqAgOC45MjA3OTVdIGZzbF9k
cGFhMl9ldGggZHBuaS44ICh1bm5hbWVkIG5ldF9kZXZpY2UpICh1bmluaXRpYWxpemVkKTogRXJy
b3IgY29ubmVjdGluZyB0byB0aGUgTUFDIGVuZHBvaW50OiAtRUlOVkFMDQo+IFvCoCDCoCA5LjI5
MDAwNV0gZnNsX2RwYWEyX2V0aCBkcG5pLjg6IHByb2JlIHdpdGggZHJpdmVyIGZzbF9kcGFhMl9l
dGggZmFpbGVkIHdpdGggZXJyb3IgLTIyDQo+DQo+IFBlcmhhcHMgZHJpdmVyIGNvdWxkIHN3aXRj
aCB0byAxMEcgaW5zdGVhZD8gSG93ZXZlciBub3QgaW1wb3J0YW50IGluIG15IG9waW5pb24uDQo+
DQo+IDIuIFRlc3RlZCB3aXRoIGFkZGl0aW9uYWwgb3V0IG9mIHRyZWUgcGF0Y2hlczoNCj4NCj4g
bmV0OiBwaHlsaW5rOiBleHRlbmQgcGh5bGlua19taWlfYzQ1X3Bjc19nZXRfc3RhdGUgYWxzbyBm
b3IgUEhZX0lOVEVSRkFDRV9NT0RFXzI1R0JBU0VSDQo+IG5ldDogcGNzOiBseW54OiBleHRlbmQg
c3VwcG9ydCB0byBhbHNvIGhhbmRsZSBQSFlfSU5URVJGQUNFX01PREVfMjVHQkFTRVINCj4NCj4g
VGhlbiBpbnNlcnQgMTBHYnBzIFNGUCBtb2R1bGUgYW5kIGxpbmstdXAgKyBUWC9SWCB3b3JraW5n
IGZpbmUhDQo+IEkuZS4gZHJpdmVyIHN3aXRjaGVkIHN1Y2Nlc3NmdWxseSBmcm9tIDI1R2JwcyBj
b25maWd1cmF0aW9uIHRvIDEwR2Jwcy4NCj4NCj4gVGhlbiBpbnNlcnQgMjVHYnBzIFNGUCBtb2R1
bGUuIEVycm9ycyBzdGFydCBvY2N1cmluZzoNCj4NCj4gW8KgIDM1Ny4wNDM4OTRdIGZzbF9kcGFh
Ml9ldGggZHBuaS45IGV0aDI6IExpbmsgaXMgRG93bg0KPiBbwqAgMzU3Ljk0MTAzNl0gc2ZwIHNm
cC1idDogbW9kdWxlIHJlbW92ZWQNCj4gW8KgIDM2NC4yNjk1ODBdIHNmcCBzZnAtYnQ6IG1vZHVs
ZSBGU8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgU0ZQLTI1R1NMLTg1wqAgwqAgwqByZXYgMUHCoCDC
oHNuIEMyNTAxMzMwMTI3wqAgwqAgwqAgZGMgMjUwMjAzwqDCoA0KPiBbwqAgMzY0LjI2OTYyNV0g
ZnNsX2RwYWEyX2V0aCBkcG5pLjkgZXRoMjogc3dpdGNoZWQgdG8gaW5iYW5kLzI1Z2Jhc2UtciBs
aW5rIG1vZGUNCj4gW8KgIDM2NC4yNzE2NzRdIGZzbF9kcGFhMl9ldGggZHBuaS45IGV0aDI6IHBo
eV9zZXRfbW9kZV9leHQoKSA9IC05NQ0KPiBbwqAgMzY0LjI5MzIzMl0gaHdtb24gaHdtb244OiB0
ZW1wMV9pbnB1dCBub3QgYXR0YWNoZWQgdG8gYW55IHRoZXJtYWwgem9uZQ0KPg0KPiBUaGUgbGlu
ayBzdGFydHMgZmxhcHBpbmcsIHdoaWNoIGlzIGxpa2VseSBkdWUgdG8gYSBjb21iaW5hdGlvbiBv
ZjoNCj4NCj4gMS4gdGhlIGxhbmUgaGFzIGJlZW4gaGFsdGVkIGJ1dCBub3Qgc3RvcHBlZA0KPiAy
LiB0aGUgbGFuZSBpcyBzdGlsbCBjb25maWd1cmVkIGZvciAxMEcgc3BlZWQNCj4gMy4gdGhlIHJl
dGltZXIgKG5vdCBzdXBwb3J0ZWQgYnkga2VybmVsKSBpcyBzdGlsbCBjb25maWd1cmVkIGZvciAx
MEcgc3BlZWQNCj4NCj4gW8KgIDM2NC4zMzM3NzddIGZzbF9kcGFhMl9ldGggZHBuaS45IGV0aDI6
IExpbmsgaXMgVXAgLSAyNUdicHMvRnVsbCAtIGZsb3cgY29udHJvbCBvZmYNCj4gW8KgIDM2NS4y
ODAyMzRdIGZzbF9kcGFhMl9ldGggZHBuaS45IGV0aDI6IExpbmsgaXMgRG93bg0KPiBbwqAgMzY1
LjI4Nzc1MF0gZnNsX2RwYWEyX2V0aCBkcG5pLjkgZXRoMjogTGluayBpcyBVcCAtIDI1R2Jwcy9G
dWxsIC0gZmxvdyBjb250cm9sIG9mZg0KPiBbwqAgMzY2LjMwNDQzNF0gZnNsX2RwYWEyX2V0aCBk
cG5pLjkgZXRoMjogTGluayBpcyBEb3duDQo+IFvCoCAzNjYuMzExODY4XSBmc2xfZHBhYTJfZXRo
IGRwbmkuOSBldGgyOiBMaW5rIGlzIFVwIC0gMjVHYnBzL0Z1bGwgLSBmbG93IGNvbnRyb2wgb2Zm
DQo+IFvCoCAzNjcuMzI4MzA2XSBmc2xfZHBhYTJfZXRoIGRwbmkuOSBldGgyOiBMaW5rIGlzIERv
d24NCj4gLi4uDQo+DQo+IFNvIEkgcmVjb25maWd1cmUgdGhlIHJldGltZXIgYnkgaTJjc2V0IGZv
ciAyNUdicHMgc3BlZWQsIGFuZCBsaW5rIGdvZXMgZG93biBwZXJtYW5lbnRseS4NCj4NCj4gcm9v
dEBsb2NhbGhvc3Q6fiMgZXRodG9vbCBldGgyDQo+IFNldHRpbmdzIGZvciBldGgyOg0KPiDCoCDC
oCDCoCDCoCBTdXBwb3J0ZWQgcG9ydHM6IFsgRklCUkUgXQ0KPiDCoCDCoCDCoCDCoCBTdXBwb3J0
ZWQgbGluayBtb2RlczrCoCDCoDI1MDAwYmFzZVNSL0Z1bGwNCj4gwqAgwqAgwqAgwqAgU3VwcG9y
dGVkIHBhdXNlIGZyYW1lIHVzZTogU3ltbWV0cmljIFJlY2VpdmUtb25seQ0KPiDCoCDCoCDCoCDC
oCBTdXBwb3J0cyBhdXRvLW5lZ290aWF0aW9uOiBObw0KPiDCoCDCoCDCoCDCoCBTdXBwb3J0ZWQg
RkVDIG1vZGVzOiBOb3QgcmVwb3J0ZWQNCj4gwqAgwqAgwqAgwqAgQWR2ZXJ0aXNlZCBsaW5rIG1v
ZGVzOsKgIE5vdCByZXBvcnRlZA0KPiDCoCDCoCDCoCDCoCBBZHZlcnRpc2VkIHBhdXNlIGZyYW1l
IHVzZTogTm8NCj4gwqAgwqAgwqAgwqAgQWR2ZXJ0aXNlZCBhdXRvLW5lZ290aWF0aW9uOiBObw0K
PiDCoCDCoCDCoCDCoCBBZHZlcnRpc2VkIEZFQyBtb2RlczogTm90IHJlcG9ydGVkDQo+IMKgIMKg
IMKgIMKgIFNwZWVkOiBVbmtub3duIQ0KPiDCoCDCoCDCoCDCoCBEdXBsZXg6IEhhbGYNCj4gwqAg
wqAgwqAgwqAgQXV0by1uZWdvdGlhdGlvbjogb2ZmDQo+IMKgIMKgIMKgIMKgIFBvcnQ6IEZJQlJF
DQo+IMKgIMKgIMKgIMKgIFBIWUFEOiAwDQo+IMKgIMKgIMKgIMKgIFRyYW5zY2VpdmVyOiBpbnRl
cm5hbA0KPiDCoCDCoCDCoCDCoCBMaW5rIGRldGVjdGVkOiBubw0KPg0KPiBJIHdvdWxkIGdpdmUg
dGhpcyBhIHBhcnRpYWwgdGVzdGVkLWJ5LCBjb25zaWRlcmluZyBpdCBzd2l0Y2hlZCBzdWNjZXNz
ZnVsbHkgdG8gMTBHLA0KPiBidXQgZmFpbGVkIHN3aXRjaGluZyB0byAyNUcsIHdoaWNoIGlzIG5l
dyB3aXRoIHRoaXMgcGF0Y2guIGFuZCBuZWVkcyBleHRyYSBwYXRjaGVzLg0KDQpJIHNob3VsZCBj
bGFyaWZ5IHRlc3Rpbmcgd2FzIGRvbmUgb24gdjcuMS1yYzIsIHBsdXM6DQoNCmh0dHBzOi8vbG9y
ZS5rZXJuZWwub3JnL3IvMC12MS00NGIyZmVmODhiMjUrZDMtaW9tbXVwdF9tYXBfcmNfamdnQG52
aWRpYS5jb20NCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvMjAyNjAyMjYxODI4NTMuMTEwMzYx
Ni0xLXZsYWRpbWlyLm9sdGVhbkBueHAuY29tDQpodHRwczovL2xvcmUua2VybmVsLm9yZy9yLzIw
MjYwMzIxMDExNDUxLjE1NTcwOTEtMS12bGFkaW1pci5vbHRlYW5AbnhwLmNvbQ0KaHR0cHM6Ly9s
b3JlLmtlcm5lbC5vcmcvci8yMDI2MDUxMTE1MDAyMy4xOTAzNTc3LTEtdmxhZGltaXIub2x0ZWFu
QG54cC5jb20NCg0KSSBtYXkgaGF2ZSBtaXNzZWQgc29tZXRoaW5nIGltcG9ydGFudC4NCg==

