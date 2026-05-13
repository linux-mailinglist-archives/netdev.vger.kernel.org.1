Return-Path: <netdev+bounces-287549-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cObqMchiBGq6HgIAu9opvQ
	(envelope-from <netdev+bounces-287549-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 13:38:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA9553263F
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 13:38:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C44D8302E400
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 11:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 418F03EF67E;
	Wed, 13 May 2026 11:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=solid-run.com header.i=@solid-run.com header.b="NLYCxq93";
	dkim=pass (2048-bit key) header.d=solid-run.com header.i=@solid-run.com header.b="NLYCxq93"
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11021099.outbound.protection.outlook.com [40.107.130.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6F237DE80;
	Wed, 13 May 2026 11:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.99
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778672265; cv=fail; b=W3O9DWMgm3TwA0tbiChg5nSINrWjN/YgHS0NnTHYrB5nmiQjvZ2i9LLi6YMvT6B7Bg2EcISpPyXUkMojAAReINMU5GaE42SYlThL8r1OylwbkHbJgHPPSC01R6Jt3A7tjRPuOR3sE1MlO4I41zd4jYdymOYbBP5cXFJAn6T96DY=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778672265; c=relaxed/simple;
	bh=sCfU/JPIXfpdxxNiJZ8bS+B1ExxU5lr8umRrCoETBz0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mccAEX+jBXE83GfGqytWClZ2ikrk+90uJKAIt2Dqr1M/MIXl+//EtficpXHDf1H19l+b6YXBP7KoEy5JbamDCV/knhKbztUwIplF3LBBaVSLn8j33R/N4iZzSyyUKwvXfSbsFDlOyCqHN7K2WEvF+GsPKnK3seJgz8pc6Y87W7Q=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (2048-bit key) header.d=solid-run.com header.i=@solid-run.com header.b=NLYCxq93; dkim=pass (2048-bit key) header.d=solid-run.com header.i=@solid-run.com header.b=NLYCxq93; arc=fail smtp.client-ip=40.107.130.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=T13ovZRJrYtg1ffshf43IMfKhaCu7DwojjmjEy09bGr0Q/b0ZqxfF3abXf157TDQCQWuKkDAbA59vL45oEVHSk8O47lZKJD5anJpF70rxAGs2MueO0XkP8DpSLUnEydVpQeUoKcRfl93oVkHNQoshqnRitqDm+3ZoBKChiVXVkjlJiZO2w+43qziUGKJ8dcS35Nv/srUwdyQ5xmVWKuQpLnnj8scE07O1NfzVOYmONwWZdCtJh0dugvXXcbo5a2RrKwdxEvLR4HAF4iKWgs8Gj5K+nHBxzBRtIhfQ+w1PZ1Hob+Gms3I7e7CCZBDNjaaWtT803xIOT+WTRdIcIXucw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sCfU/JPIXfpdxxNiJZ8bS+B1ExxU5lr8umRrCoETBz0=;
 b=xhf/25yByNeU5tfRZ3jtmof9RRunTRZMY8XrEonF8XFH7tlyXZnWMXgrhS5Sp3murJQHQ42bYbvni5WfKbydnh+TaSQfx0ouLOGII97uHGMnymUJSEgkI+pxv/WdomD89r1m9Y8B2h0IvmE9Uq7t16OW3abFXHP9+XTT6P6nwV23QVmZt1KQsYTa2tUfYb/HsyQ/WiPaCGXAqhAtqnAXicNXuHUgaidXw7NbFYXj+rT0fpCtaeWR3V7pRmFBpmg+JxdCQP8lCROFAGIqL9uPOvRXCf3XzW/w1Psz3iSbrhY7WcE8C44udhdPYLEWFHOdRqPM51yPs8kMqyIfgpEA4g==
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
 bh=sCfU/JPIXfpdxxNiJZ8bS+B1ExxU5lr8umRrCoETBz0=;
 b=NLYCxq936bG+kHXhQ05qxIH9RKc5I8wCiOEH7W4wLNHnyrB22EIca01Pe/OV1uE2lg2EenyhCpQ3NcAQakzxKLsJu4Uj2PNNtDyqOMTPilyhHbGlVjtFX+Blng/ne7vlP5PtQWrKDD5c/qU0I68gYAmynT5CucmGuLG+DX7G33+h7ZCWLgXglTM339uSv43i5jJ4dkz65hwwj2gKlk+kZRYVYmKtr56F2YXZKBsCMGtkIn7+2KQKxWtNE4WYmavPDAVm0MKREK5EBlFjXKVwCJYXOcMw0t8kAb0FUc5PoPiOtwzyMJp+Dspi2tkfU05061re2ohT8bEjAl6EwY1DjQ==
Received: from DUZPR01CA0340.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b8::13) by DU4PR04MB10694.eurprd04.prod.outlook.com
 (2603:10a6:10:582::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 11:37:36 +0000
Received: from DB1PEPF000509F2.eurprd02.prod.outlook.com
 (2603:10a6:10:4b8:cafe::7a) by DUZPR01CA0340.outlook.office365.com
 (2603:10a6:10:4b8::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.12 via Frontend Transport; Wed,
 13 May 2026 11:37:36 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solid-run.com;dmarc=pass action=none header.from=solid-run.com;
Received-SPF: Fail (protection.outlook.com: domain of solid-run.com does not
 designate 52.17.62.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=52.17.62.50; helo=eu-dlp.cloud-sec-av.com;
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 DB1PEPF000509F2.mail.protection.outlook.com (10.167.242.148) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.13
 via Frontend Transport; Wed, 13 May 2026 11:37:36 +0000
Received: from emails-5857029-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-6-103.eu-west-1.compute.internal [10.20.6.103])
	by mta-outgoing-dlp-588-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id 3E99F7FD94;
	Wed, 13 May 2026 11:37:36 +0000 (UTC)
X-Mailbox-Line: From b'josua@solid-run.com' Wed May 13 11:37:20 2026
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KdcDFleW9NexumSi4GDAfAKinncGuURhQsxjgPgSZhedCmC4GuKFbZ6HP33W7hwji5SOTQaMUtP91g+hN2iMTGxeSjeCO4z7+t50X5pVkuM3Pi+1wmRbURac9pg9jK4JOyyKjBIq16DlPrIFek2zkXvND6I1saI5aoMvZDQpBMM5ipJ0UQoBLyLVCSvLANEt1/vS/neFinAAqXV/aJ9Mq5Bb6oMd16a9wQKu4AUhzChM3V+N0S1Wt73JvX9Gkm7CeLQb2ATi3qJ4YXujbQJa6WRvfWZ/t+y1wc6ToBFJBzT6MJQMbJI9Zu92o4BkGpSJgO5dirspFRERj6FW6m6kKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sCfU/JPIXfpdxxNiJZ8bS+B1ExxU5lr8umRrCoETBz0=;
 b=TcPtXjiFAAPuGaPZaEWKQMr+CJ3e9pl2DA0hSmd8wgOLg9zt9C6Qb+ao6xl1MFCSX1jCa00Me/FAUrorYQ5uTE3MwWHJa54K24X7p8TLGJK6b7f8wdfU4/O+gqPSxiMuaOerTqABJC5jd2dqJ4mU8TxcYezS/KnbX1pkFFQ8mZ7Q/XFUU1zMEdpLIZP0KsllSTmIj7GLNbAvJlDSNlsLGHhXxnpxM/n9D0FfiMEqTNnsXVElK7nCicGb1ceXd8Id1FQL9RZze4d8nk9oVQJlKgV9TEAa8hTzwYk1w1coAYDF7PCpS6cfMA5/utXZ9LWs1ut2wXYyx2UASEBvBOhLkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=solid-run.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sCfU/JPIXfpdxxNiJZ8bS+B1ExxU5lr8umRrCoETBz0=;
 b=NLYCxq936bG+kHXhQ05qxIH9RKc5I8wCiOEH7W4wLNHnyrB22EIca01Pe/OV1uE2lg2EenyhCpQ3NcAQakzxKLsJu4Uj2PNNtDyqOMTPilyhHbGlVjtFX+Blng/ne7vlP5PtQWrKDD5c/qU0I68gYAmynT5CucmGuLG+DX7G33+h7ZCWLgXglTM339uSv43i5jJ4dkz65hwwj2gKlk+kZRYVYmKtr56F2YXZKBsCMGtkIn7+2KQKxWtNE4WYmavPDAVm0MKREK5EBlFjXKVwCJYXOcMw0t8kAb0FUc5PoPiOtwzyMJp+Dspi2tkfU05061re2ohT8bEjAl6EwY1DjQ==
Received: from GVXPR04MB12057.eurprd04.prod.outlook.com
 (2603:10a6:150:313::24) by VI0PR04MB10950.eurprd04.prod.outlook.com
 (2603:10a6:800:25a::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 11:37:14 +0000
Received: from GVXPR04MB12057.eurprd04.prod.outlook.com
 ([fe80::14f1:a127:2988:de5b]) by GVXPR04MB12057.eurprd04.prod.outlook.com
 ([fe80::14f1:a127:2988:de5b%7]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 11:37:14 +0000
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
Thread-Index: AQHc4VcBNwfvvLflf0GuY4D0POuBgbYL1wIA
Date: Wed, 13 May 2026 11:37:14 +0000
Message-ID: <1ba1f688-9f68-4749-a18f-20ae91738ae0@solid-run.com>
References: <20260511150023.1903577-1-vladimir.oltean@nxp.com>
 <20260511150023.1903577-6-vladimir.oltean@nxp.com>
In-Reply-To: <20260511150023.1903577-6-vladimir.oltean@nxp.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
x-ms-traffictypediagnostic:
	GVXPR04MB12057:EE_|VI0PR04MB10950:EE_|DB1PEPF000509F2:EE_|DU4PR04MB10694:EE_
X-MS-Office365-Filtering-Correlation-Id: 827a6f82-a1bf-41d3-eb9a-08deb0e407d5
x-cloud-sec-av-info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|366016|376014|22082099003|18002099003|56012099003|38070700021|3023799003;
X-Microsoft-Antispam-Message-Info-Original:
 li3v8tewUgHTdA8eDweJAogv/setYw92Je6jW7cd3XcFF4/EhwKgaMjqdAPdlXzquP033OkdVK1bGXzbq8edSO/uLUKLYdQAxg/DB+OBZWmRfJTbfKfwQAY4pPlpvutIsW+O0dhWRBVu9vg2sZwmQTqUqd38fIR9Y/BtE+QOY7d2ESIjEhuYJfJ015nVGFNy/nw2jjwvDBy1DKTV8r8I5y4e+LTEotw1/rMXBfoCu7S8ZTGAFEp5rU0qqbpStq4ner8Z4GQTzKf9MGiwZOzg0dzv9nOojF8FXRq6sCZj4ropeouETa+9j31ncsSmLrAspCK+ICuLSSPXEBp8LlTE4iNnsu3JtvHrDbxc/RXqMYYDtwjrHjMW5BZt8K9fr0X99EXKWnihqfeLjno/rbsPipXr1Y+mAlqdDS+X0CwDf8xGkHiGQu5bguc7dLL2WvPG1pi9uIPnEsHVAWyP51itBB6wXP4h387CvXCIzb58jNdyp1s+8aeuR9p6vAurA0cAii0X2o1bus5Y+LzJkmEVdmxsrM3w4cbMsDy8eTD8X2tXsavcBnjXjKfg/zblMTy3X6cayl4sAGdMzu/J4VCuvVTULeHaaEmjtUBjw1hZiLT4E0MYP22EWELhQvNswQxZH8dAlrisOHwr0DEcmgGy4NRGvSi4Cc61DFV7SwN13deT4xBDXetujgVdYMwrt4T/hZMpeq3DgePwxaPox4sa4JSyqV2Y8GpDEecIVyDVYmS6tVCoNp2X4G+aBgMhJpgT
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12057.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(22082099003)(18002099003)(56012099003)(38070700021)(3023799003);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="utf-8"
Content-ID: <00937F30D6E6DF4E9C47BC8A00037488@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
 DGTLioXZsRLSCQ6DAUlq3llJhHQCpqokmKn4m67EDYcFz1NRK681wSC346MTEJ7FDvzAbHHt/hzZtMTksVBZdP5lRHrftEP64g/qnyVZOgaEYN+Zg48GzLRmQHwUXIQEe6SijaX0dHuHIajBBf576DfspFQh262kkjYJgF450k7FsqFt7WQLNOOjrerlw8qCFfUZZ9iZi22u8tk38aewthbMdx7yYCWFn+amZh3yvoxFiJ7cunxvIKaE1AK8H5gZlE+tyeMp9zRHYLtEP12l8OUbYElDeWzvcaRJeVzCH1WfkmxDyTqxPG3gLKgnew/FERU8b/0KO871cQUzVIH90A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10950
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2-7.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: d01a1f3288f14e5189474106e32a8799:solidrun,office365_emails,sent,inline:1412bcce9e7a9c86e8f6ce96ca54cbf1
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF000509F2.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	0e8a1f81-072a-4458-76f4-08deb0e3fae0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|82310400026|14060799003|1800799024|35042699022|18002099003|22082099003|56012099003|13003099007|3023799003;
X-Microsoft-Antispam-Message-Info:
	aG55Lqh4QdvWhhxVNCWLBn/LzlNeC4XOtuZsf4VIeOXpM544x+HlvzyDvI/MH6E82DGOVa6/OJF79VvejDqqOAhz1OJxnAHABbR0N7OuvDJyTl8dyxqMUwJ3ZwFwq1dxVepHIfvzDm3kiSqF5+t5oK/SliqoAejvvs3KoLImAfOZBSe0YRJ85aduauCH91lP0Xn4pFUTOKRMTjiOHu1aQ1s3/5RzoxrOQn14i4LLB+nsB+wjfs+6QaTocDMl9n5lgTHyqDGxPkTNqdYvBKpWQtDOrN72sLZRlYOCdf0txWT2WD9cW/eFcyyJ2fhO5ZhcSCp0R5sB/5du+e/JOTd3LBlzuftEMpWhonqu4JBLfCDGfKjUkNifV/v5yCPyfREmnzJK3Es0npujQRfjCTP6vlELrImnSCzmab1+tqo32eqnKtl0i1iZ8mc6XZt459wcWyDm7QU5WRL90TmSEHOKAyhym+vFy5zBFuUYozuiaOxU3cWFaAtraSk1kzRlq1ELrhL/pgT5MLtP1rNPlWIc1lbmsbmbj2Dzo9TdcOtFjqJ9ERytE7xcruI2WLct28ccZNFnKxMYKch+D/fIDSPenrNt9h1KBsodH8mJQPNUDWgeeFid/EN39WaJIetsLdOL/Se+YRqGdKraAL34kAqC5qsZeaNgDSV4JOhV5eeFjFxd/iorWTIcmALnp5OfZuBwDVsXO/Y0YjXXrqTytLUp5nWsz9LmwAtZg5S306dtt2g=
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(36860700016)(376014)(82310400026)(14060799003)(1800799024)(35042699022)(18002099003)(22082099003)(56012099003)(13003099007)(3023799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	acowVbhCs/6bSqCIhjlb5oE4jBZ1FBsoJWDlZdMHRREVXxJCr18kh5YsoD+2TWlf0V4u9TqhMkuDKifcVdSsnQIYqAUVHsRBP2++r1xRW+PKGOTKm4R2uR2xQ6MWiwUNtCumN6j/jYMfJXmQeTlOBxqnQCyugL/9kTbPlRA+cRW3JTGm/BSMQ8oiEYDWN1zIZG1imeNh+/67drZbwwlk4ehywZrI1Ro2POcpVUiG13ipIRRdiEl8jyQMJqD94X4omE1WBWrRqcdaBcnrIjYSrkIAo1I+t9F6Xd/e8EReJeFPdcHhptJ/xNoXXrck6QcH6T8mAdu7lerYmmRpu1bAG3mGnVPRCLI6ekNc1A8Btx43dYDa0SCxosnjMQZATg8F0l9BQf1S8ThFk4bztqYLkEDMS1vSN8lGHQ8BFVTzLgBwpqobjyREOiN5RUUCrf2t
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 11:37:36.3248
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 827a6f82-a1bf-41d3-eb9a-08deb0e407d5
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509F2.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10694
X-Rspamd-Queue-Id: 4BA9553263F
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
	TAGGED_FROM(0.00)[bounces-287549-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,localhost:email,nxp.com:email,solid-run.com:mid,solid-run.com:dkim];
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

QW0gMTEuMDUuMjYgdW0gMTc6MDAgc2NocmllYiBWbGFkaW1pciBPbHRlYW46DQo+IEZyb206IElv
YW5hIENpb3JuZWkgPGlvYW5hLmNpb3JuZWlAbnhwLmNvbT4NCj4NCj4gQWRkIHN1cHBvcnQgZm9y
IDI1R0JBU0UtUiBpbiB0aGUgTHlueCAyOEcgU2VyRGVzIFBIWSBkcml2ZXIuIFRoaXMgd2lsbA0K
PiBiZSB1c2VkIGJ5IHRoZSBkcGFhMi1tYWMgY29uc3VtZXIgb24gTFgyMTYwQSB3aXRoOg0KPiAt
IHBoeV92YWxpZGF0ZShwaHksIFBIWV9NT0RFX0VUSEVSTkVULCBQSFlfSU5URVJGQUNFX01PREVf
MjVHQkFTRVIpIHRvDQo+ICAgZGV0ZWN0IHN1cHBvcnQuDQo+IC0gcGh5X3NldF9tb2RlX2V4dChw
aHksIFBIWV9NT0RFX0VUSEVSTkVULCBQSFlfSU5URVJGQUNFX01PREVfMjVHQkFTRVIpDQo+ICAg
dG8gcmVjb25maWd1cmUgdGhlIGxhbmUgZm9yIHRoaXMgcHJvdG9jb2wuDQo+DQo+IFRoZSBpbnRl
bmRlZCB1c2UgY2FzZSBmb3IgZHluYW1pYyBwcm90b2NvbCBzd2l0Y2hpbmcgdG8gMjVHQmFzZS1S
IGlzDQo+IHdpdGggU0ZQMjggbW9kdWxlcywgYW5kIHByb3RvY29sIHN3aXRjaGluZyBpcyB0cmln
Z2VyZWQgYnkgdGhlIFNGUA0KPiBtb2R1bGUgaW5zZXJ0aW9uLiBUaGVyZSBhbHNvIGV4aXN0cyBh
IDI1R0Jhc2UtS1IgdXNlIGNhc2UsIHdoZXJlIHRoZQ0KPiBwcm90b2NvbCBzd2l0Y2hpbmcgaXMg
Y292ZXJlZCBieSBJRUVFIDgwMi4zIGNsYXVzZSA3MyBhdXRvLW5lZ290aWF0aW9uLg0KPiBIb3dl
dmVyLCB0aGF0IGlzIG5vdCBoYW5kbGVkIGhlcmU7IGl0IG1lcmVseSBuZWVkcyB0aGUgc3VwcG9y
dCBhZGRlZA0KPiBoZXJlIGFzIGJhc2ljIGdyb3VuZCB3b3JrLg0KPg0KPiBUaGUgbGFuZSBmcmVx
dWVuY3kgZm9yIDI1R2JFIGlzIHNvdXJjZWQgZnJvbSBhIGNsb2NrIG5ldCBmcmVxdWVuY3kgb2YN
Cj4gMTIuODkwNjI1IEdIeiwgYXMgcHJvZHVjZWQgYnkgUExMRiBvciBQTExTLCBmdXJ0aGVyIG11
bHRpcGxpZWQgYnkgdGhlDQo+IGxhbmUgYnkgMi4gVGhlIGNsb2NrIG5ldCBmcmVxdWVuY2llcyBw
cm9kdWNlZCBieSB0aGUgUExMcyBhcmUgdHJlYXRlZCBhcw0KPiByZWFkLW9ubHkgYnkgdGhlIGRy
aXZlciwgc28gdGhlIGFic2VuY2Ugb2YgYSBQTEwgcHJvdmlzaW9uZWQgZm9yIHRoZQ0KPiByaWdo
dCBjbG9jayBuZXQgZnJlcXVlbmN5IGltcGxpZXMgYWJzZW5jZSBvZiAyNUdiRSBzdXBwb3J0LCBl
dmVuIHRob3VnaA0KPiBhIGxhbmUgbWlnaHQgaGF2ZSB0aGUgYXBwcm9wcmlhdGUgcHJvdG9jb2wg
Y29udmVydGVyIGZvciBpdC4NCj4NCj4gSW4gdGVybXMgb2YgaW1wbGVtZW50YXRpb24sIHRoZSBj
aGFuZ2UgY29uc2lzdHMgb2Y6DQo+IC0gZGV0ZXJtaW5pbmcgYXQgcHJvYmUgdGltZSBpZiBhbnkg
UExMIHdhcyBwcmVjb25maWd1cmVkIGZvciB0aGUNCj4gICByZXF1aXJlZCBjbG9jayBuZXQgZnJl
cXVlbmN5IGZvciAyNUdiRQ0KPiAtIGFkZGluZyB0aGUgZGVmYXVsdCBsYW5lIHBhcmFtZXRlcnMg
Zm9yIHJlY29uZmlndXJpbmcgYSBsYW5lIHRvIDI1R2JFDQo+ICAgaXJyZXNwZWN0aXZlIG9mIHRo
ZSBvcmlnaW5hbCBwcm90b2NvbA0KPiAtIGFsbG93aW5nIHRoaXMgb3BlcmF0aW5nIG1vZGUgb25s
eSBvbiBzdXBwb3J0ZWQgbGFuZXMsIGkuZS4gYWxsIGxhbmVzDQo+ICAgb2YgTFgyMTYyQSBTZXJE
ZXMgIzEsIGFuZCBMWDIxNjBBIFNlckRlcyBsYW5lcyAwLTEsIDQtNy4NCj4NCj4gU2lnbmVkLW9m
Zi1ieTogSW9hbmEgQ2lvcm5laSA8aW9hbmEuY2lvcm5laUBueHAuY29tPg0KPiBTaWduZWQtb2Zm
LWJ5OiBWbGFkaW1pciBPbHRlYW4gPHZsYWRpbWlyLm9sdGVhbkBueHAuY29tPg0KPiAtLS0NCj4g
Q2hhbmdlIHByZXZpb3VzbHkgc3VibWl0dGVkIGF0Og0KPiBodHRwczovL2xvcmUua2VybmVsLm9y
Zy9saW51eC1waHkvMjAyNjAxMTQxNTIxMTEuNjI1MzUwLTYtdmxhZGltaXIub2x0ZWFuQG54cC5j
b20vDQo+DQo+IENoYW5nZXM6DQo+IC0gcmV3b3JkIGNvbW1pdCBtZXNzYWdlDQo+IC0tLQ0KPiAg
ZHJpdmVycy9waHkvZnJlZXNjYWxlL3BoeS1mc2wtbHlueC0yOGcuYyB8IDkwICsrKysrKysrKysr
KysrKysrKysrKysrLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDg4IGluc2VydGlvbnMoKyksIDIgZGVs
ZXRpb25zKC0pDQoNCkluIG9yZGVyIHRvIHRlc3QgdGhpcyBwYXRjaCB3aXRoIDI1R2JwcyBsaW5r
LCBhZGRpdGlvbmFsIGNoYW5nZXMgb24gb3RoZXIgZHJpdmVycyBhcmUgbmVlZGVkLg0KVGhpcyBp
cyBub3QgYSBzaG9ydC1jb21pbmcgb2YgdGhpcyBwYXRjaC4NCg0KMS4gSSB0ZXN0ZWQgdGhpcyBw
YXRjaC1zZXQgYWxvbmUgb24gTFgyMTYyIENsZWFyZm9nIHdpdGggU0QxIFByb3RvY2wgMTggKGku
ZS4gMnggMTBHIFNGUCwgMnggMjVHIFNGUCk6DQoNCjEwR2JwcyBwb3J0cyBhcmUgd29ya2luZyBm
aW5lIQ0KDQoyNUdicHMgZmFpbCB0byBwcm9iZSAoYnV0IHRoaXMgaXMgcGFydGx5IGV4cGVjdGVk
KToNCg0KW8KgIMKgIDguMzczMDQ4XSBmc2xfZHBhYTJfZXRoIGRwbmkuOSAodW5uYW1lZCBuZXRf
ZGV2aWNlKSAodW5pbml0aWFsaXplZCk6IE1BQyByZXR1cm5lZCBQQ1Mgd2hpY2ggZG9lcyBub3Qg
c3VwcG9ydCAyNWdiYXNlLXINClvCoCDCoCA4LjM3MzA2NV0gZnNsX2RwYWEyX2V0aCBkcG5pLjkg
KHVubmFtZWQgbmV0X2RldmljZSkgKHVuaW5pdGlhbGl6ZWQpOiBNQUMgcmV0dXJuZWQgUENTIHdo
aWNoIGRvZXMgbm90IHN1cHBvcnQgMjVnYmFzZS1yDQpbwqAgwqAgOC4zNzMwNzRdIGZzbF9kcGFh
Ml9ldGggZHBuaS45ICh1bm5hbWVkIG5ldF9kZXZpY2UpICh1bmluaXRpYWxpemVkKTogZmFpbGVk
IHRvIHZhbGlkYXRlIGxpbmsgY29uZmlndXJhdGlvbiBmb3IgaW4tYmFuZCBzdGF0dXMNClvCoCDC
oCA4LjM3MzA3OF0gZnNsX2RwYWEyX2V0aCBkcG5pLjkgKHVubmFtZWQgbmV0X2RldmljZSkgKHVu
aW5pdGlhbGl6ZWQpOiBFcnJvciBjb25uZWN0aW5nIHRvIHRoZSBNQUMgZW5kcG9pbnQ6IC1FSU5W
QUwNClvCoCDCoCA4LjcyNTAwNF0gZnNsX2RwYWEyX2V0aCBkcG5pLjk6IHByb2JlIHdpdGggZHJp
dmVyIGZzbF9kcGFhMl9ldGggZmFpbGVkIHdpdGggZXJyb3IgLTIyDQpbwqAgwqAgOC45MjA3NjZd
IGZzbF9kcGFhMl9ldGggZHBuaS44ICh1bm5hbWVkIG5ldF9kZXZpY2UpICh1bmluaXRpYWxpemVk
KTogTUFDIHJldHVybmVkIFBDUyB3aGljaCBkb2VzIG5vdCBzdXBwb3J0IDI1Z2Jhc2Utcg0KW8Kg
IMKgIDguOTIwNzgzXSBmc2xfZHBhYTJfZXRoIGRwbmkuOCAodW5uYW1lZCBuZXRfZGV2aWNlKSAo
dW5pbml0aWFsaXplZCk6IE1BQyByZXR1cm5lZCBQQ1Mgd2hpY2ggZG9lcyBub3Qgc3VwcG9ydCAy
NWdiYXNlLXINClvCoCDCoCA4LjkyMDc5MV0gZnNsX2RwYWEyX2V0aCBkcG5pLjggKHVubmFtZWQg
bmV0X2RldmljZSkgKHVuaW5pdGlhbGl6ZWQpOiBmYWlsZWQgdG8gdmFsaWRhdGUgbGluayBjb25m
aWd1cmF0aW9uIGZvciBpbi1iYW5kIHN0YXR1cw0KW8KgIMKgIDguOTIwNzk1XSBmc2xfZHBhYTJf
ZXRoIGRwbmkuOCAodW5uYW1lZCBuZXRfZGV2aWNlKSAodW5pbml0aWFsaXplZCk6IEVycm9yIGNv
bm5lY3RpbmcgdG8gdGhlIE1BQyBlbmRwb2ludDogLUVJTlZBTA0KW8KgIMKgIDkuMjkwMDA1XSBm
c2xfZHBhYTJfZXRoIGRwbmkuODogcHJvYmUgd2l0aCBkcml2ZXIgZnNsX2RwYWEyX2V0aCBmYWls
ZWQgd2l0aCBlcnJvciAtMjINCg0KUGVyaGFwcyBkcml2ZXIgY291bGQgc3dpdGNoIHRvIDEwRyBp
bnN0ZWFkPyBIb3dldmVyIG5vdCBpbXBvcnRhbnQgaW4gbXkgb3Bpbmlvbi4NCg0KMi4gVGVzdGVk
IHdpdGggYWRkaXRpb25hbCBvdXQgb2YgdHJlZSBwYXRjaGVzOg0KDQpuZXQ6IHBoeWxpbms6IGV4
dGVuZCBwaHlsaW5rX21paV9jNDVfcGNzX2dldF9zdGF0ZSBhbHNvIGZvciBQSFlfSU5URVJGQUNF
X01PREVfMjVHQkFTRVINCm5ldDogcGNzOiBseW54OiBleHRlbmQgc3VwcG9ydCB0byBhbHNvIGhh
bmRsZSBQSFlfSU5URVJGQUNFX01PREVfMjVHQkFTRVINCg0KVGhlbiBpbnNlcnQgMTBHYnBzIFNG
UCBtb2R1bGUgYW5kIGxpbmstdXAgKyBUWC9SWCB3b3JraW5nIGZpbmUhDQpJLmUuIGRyaXZlciBz
d2l0Y2hlZCBzdWNjZXNzZnVsbHkgZnJvbSAyNUdicHMgY29uZmlndXJhdGlvbiB0byAxMEdicHMu
DQoNClRoZW4gaW5zZXJ0IDI1R2JwcyBTRlAgbW9kdWxlLiBFcnJvcnMgc3RhcnQgb2NjdXJpbmc6
DQoNClvCoCAzNTcuMDQzODk0XSBmc2xfZHBhYTJfZXRoIGRwbmkuOSBldGgyOiBMaW5rIGlzIERv
d24NClvCoCAzNTcuOTQxMDM2XSBzZnAgc2ZwLWJ0OiBtb2R1bGUgcmVtb3ZlZA0KW8KgIDM2NC4y
Njk1ODBdIHNmcCBzZnAtYnQ6IG1vZHVsZSBGU8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgU0ZQLTI1
R1NMLTg1wqAgwqAgwqByZXYgMUHCoCDCoHNuIEMyNTAxMzMwMTI3wqAgwqAgwqAgZGMgMjUwMjAz
wqDCoA0KW8KgIDM2NC4yNjk2MjVdIGZzbF9kcGFhMl9ldGggZHBuaS45IGV0aDI6IHN3aXRjaGVk
IHRvIGluYmFuZC8yNWdiYXNlLXIgbGluayBtb2RlDQpbwqAgMzY0LjI3MTY3NF0gZnNsX2RwYWEy
X2V0aCBkcG5pLjkgZXRoMjogcGh5X3NldF9tb2RlX2V4dCgpID0gLTk1DQpbwqAgMzY0LjI5MzIz
Ml0gaHdtb24gaHdtb244OiB0ZW1wMV9pbnB1dCBub3QgYXR0YWNoZWQgdG8gYW55IHRoZXJtYWwg
em9uZQ0KDQpUaGUgbGluayBzdGFydHMgZmxhcHBpbmcsIHdoaWNoIGlzIGxpa2VseSBkdWUgdG8g
YSBjb21iaW5hdGlvbiBvZjoNCg0KMS4gdGhlIGxhbmUgaGFzIGJlZW4gaGFsdGVkIGJ1dCBub3Qg
c3RvcHBlZA0KMi4gdGhlIGxhbmUgaXMgc3RpbGwgY29uZmlndXJlZCBmb3IgMTBHIHNwZWVkDQoz
LiB0aGUgcmV0aW1lciAobm90IHN1cHBvcnRlZCBieSBrZXJuZWwpIGlzIHN0aWxsIGNvbmZpZ3Vy
ZWQgZm9yIDEwRyBzcGVlZA0KDQpbwqAgMzY0LjMzMzc3N10gZnNsX2RwYWEyX2V0aCBkcG5pLjkg
ZXRoMjogTGluayBpcyBVcCAtIDI1R2Jwcy9GdWxsIC0gZmxvdyBjb250cm9sIG9mZg0KW8KgIDM2
NS4yODAyMzRdIGZzbF9kcGFhMl9ldGggZHBuaS45IGV0aDI6IExpbmsgaXMgRG93bg0KW8KgIDM2
NS4yODc3NTBdIGZzbF9kcGFhMl9ldGggZHBuaS45IGV0aDI6IExpbmsgaXMgVXAgLSAyNUdicHMv
RnVsbCAtIGZsb3cgY29udHJvbCBvZmYNClvCoCAzNjYuMzA0NDM0XSBmc2xfZHBhYTJfZXRoIGRw
bmkuOSBldGgyOiBMaW5rIGlzIERvd24NClvCoCAzNjYuMzExODY4XSBmc2xfZHBhYTJfZXRoIGRw
bmkuOSBldGgyOiBMaW5rIGlzIFVwIC0gMjVHYnBzL0Z1bGwgLSBmbG93IGNvbnRyb2wgb2ZmDQpb
wqAgMzY3LjMyODMwNl0gZnNsX2RwYWEyX2V0aCBkcG5pLjkgZXRoMjogTGluayBpcyBEb3duDQou
Li4NCg0KU28gSSByZWNvbmZpZ3VyZSB0aGUgcmV0aW1lciBieSBpMmNzZXQgZm9yIDI1R2JwcyBz
cGVlZCwgYW5kIGxpbmsgZ29lcyBkb3duIHBlcm1hbmVudGx5Lg0KDQpyb290QGxvY2FsaG9zdDp+
IyBldGh0b29sIGV0aDINClNldHRpbmdzIGZvciBldGgyOg0KwqAgwqAgwqAgwqAgU3VwcG9ydGVk
IHBvcnRzOiBbIEZJQlJFIF0NCsKgIMKgIMKgIMKgIFN1cHBvcnRlZCBsaW5rIG1vZGVzOsKgIMKg
MjUwMDBiYXNlU1IvRnVsbA0KwqAgwqAgwqAgwqAgU3VwcG9ydGVkIHBhdXNlIGZyYW1lIHVzZTog
U3ltbWV0cmljIFJlY2VpdmUtb25seQ0KwqAgwqAgwqAgwqAgU3VwcG9ydHMgYXV0by1uZWdvdGlh
dGlvbjogTm8NCsKgIMKgIMKgIMKgIFN1cHBvcnRlZCBGRUMgbW9kZXM6IE5vdCByZXBvcnRlZA0K
wqAgwqAgwqAgwqAgQWR2ZXJ0aXNlZCBsaW5rIG1vZGVzOsKgIE5vdCByZXBvcnRlZA0KwqAgwqAg
wqAgwqAgQWR2ZXJ0aXNlZCBwYXVzZSBmcmFtZSB1c2U6IE5vDQrCoCDCoCDCoCDCoCBBZHZlcnRp
c2VkIGF1dG8tbmVnb3RpYXRpb246IE5vDQrCoCDCoCDCoCDCoCBBZHZlcnRpc2VkIEZFQyBtb2Rl
czogTm90IHJlcG9ydGVkDQrCoCDCoCDCoCDCoCBTcGVlZDogVW5rbm93biENCsKgIMKgIMKgIMKg
IER1cGxleDogSGFsZg0KwqAgwqAgwqAgwqAgQXV0by1uZWdvdGlhdGlvbjogb2ZmDQrCoCDCoCDC
oCDCoCBQb3J0OiBGSUJSRQ0KwqAgwqAgwqAgwqAgUEhZQUQ6IDANCsKgIMKgIMKgIMKgIFRyYW5z
Y2VpdmVyOiBpbnRlcm5hbA0KwqAgwqAgwqAgwqAgTGluayBkZXRlY3RlZDogbm8NCg0KSSB3b3Vs
ZCBnaXZlIHRoaXMgYSBwYXJ0aWFsIHRlc3RlZC1ieSwgY29uc2lkZXJpbmcgaXQgc3dpdGNoZWQg
c3VjY2Vzc2Z1bGx5IHRvIDEwRywNCmJ1dCBmYWlsZWQgc3dpdGNoaW5nIHRvIDI1Rywgd2hpY2gg
aXMgbmV3IHdpdGggdGhpcyBwYXRjaC4gYW5kIG5lZWRzIGV4dHJhIHBhdGNoZXMuDQo=

