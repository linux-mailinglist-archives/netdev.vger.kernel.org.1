Return-Path: <netdev+bounces-251003-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A96D3A19C
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 09:30:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 71A2930038EE
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 08:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D193833F37A;
	Mon, 19 Jan 2026 08:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="A5BGfw/b";
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="A5BGfw/b"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021072.outbound.protection.outlook.com [52.101.70.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1840033F369;
	Mon, 19 Jan 2026 08:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.72
ARC-Seal:i=4; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768811430; cv=fail; b=XhRnA6ZGtHOxHroi/iZw3wwnDELOJT4goZYsoSzSpWz3Yvc9hTKKRXRgwwcWGLYDp4/ieKb18WR951o3hyq45sEfEwtIzN6AhFHFWyoKD2zBlDZ4HCA3FKwOZpFGE683fe66/LihGBikVAt/KhqSFVE0r/Rl3aNrOLbA+wrFKns=
ARC-Message-Signature:i=4; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768811430; c=relaxed/simple;
	bh=+jYTQ7e4N4xi3KPcWoljKEF6UVf2CRcY+Nf8KYWJInI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=T4DSi6LD07NlOTaugnCM2ZnNZkmY7rQYiU6zoicAZ31KLh9WaM83Fxrz/8QKeyMD7B3patzfUJjhLJV9uvZjxR/E5wf9rH6kS4R751GJTeemOIIhO3WjOft1rbqwqAB2GMncnILDgo5FSoKzK+T8mPrgl8WHhGKI34zzk/ejLmU=
ARC-Authentication-Results:i=4; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=A5BGfw/b; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=A5BGfw/b; arc=fail smtp.client-ip=52.101.70.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=3; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=q1a4eQKZ68SZcp0u1ORTX0AvFWk+zhzht9fwBlEkAr5DGwzy6uxTAC1g0c2WBldYyNr1d80T9kdoY46kN1Jd1aXZUGuonx/CCtam/bg/lbu9wsja1vk99ZGxQDlZbJ7KCThPSlnw7r6yobHH4dkvCMKcrVZSNCrq8r+V73pzXECTufbfHRoBT5TXV44Zpa/vvSo1JroEphbDBrNYWN/b/t7hxTJbb5JyqWyiMPcwqfvmnK6JYlIw1FPm/6Ae+QgOkkypUdewSFkD+YODCpuSOpGGdC2Hfu7sY8A67tmhkj3StNsLdIMCJBQxZ62zAnI7cblgwAgYnaNTcGa/mGG5mQ==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+jYTQ7e4N4xi3KPcWoljKEF6UVf2CRcY+Nf8KYWJInI=;
 b=NPF3kyvKbjHzgqZYw2WxQZdlH81XLW5scN4CRab2KsYLDye6InuV4x5ufBeQUWOcg6sQ5mDRCE6/O7p5DK9Y3yn21XhCsSYnHLujcVy+jH1Yi19jSPv1sjJEzbR7Vpz5CKB6AGWxJN4o0xA7wNhXczXttf2ssnFFFCThxIP1pxdWRIrvxQ/lZDb/57rOcBS2EJc9ubtwr6ul2ikvp6oA50VkWQMPwVCvlydz3Y+5g1x/Q0DH9OmeWZeeKTJqnxlsIc5oHUNUE2R4ihakx1XDT6CEJWGFm86G1y9iiLrC9AqDaRkKFxgffjTgnUAN9MSHsQPsyGG4qKHaVK4UteSK8A==
ARC-Authentication-Results: i=3; mx.microsoft.com 1; spf=fail (sender ip is
 52.17.62.50) smtp.rcpttodomain=armlinux.org.uk smtp.mailfrom=solid-run.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=solid-run.com;
 dkim=pass (signature was verified) header.d=solidrn.onmicrosoft.com; arc=pass
 (0 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=solid-run.com]
 dkim=[1,1,header.d=solid-run.com] dmarc=[1,1,header.from=solid-run.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+jYTQ7e4N4xi3KPcWoljKEF6UVf2CRcY+Nf8KYWJInI=;
 b=A5BGfw/bRY6dQ8LWCzaUZw22JMg1fNKGKO75UOPfm7ji2QsWZIlxBKpU/ujh0YkC5vaas7SaphW3haWctuAc5M1NbC5fvC2X893YoTQMjFJc3yDnzUFaUhLFz1TsY3r2vTrNiv/1qNBprLf8/6qvV3zDJGmPqCAeFWrw+kp7zhs=
Received: from DUZPR01CA0298.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b7::15) by AM8PR04MB7332.eurprd04.prod.outlook.com
 (2603:10a6:20b:1db::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 08:30:24 +0000
Received: from DU2PEPF00028D0B.eurprd03.prod.outlook.com
 (2603:10a6:10:4b7:cafe::22) by DUZPR01CA0298.outlook.office365.com
 (2603:10a6:10:4b7::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.12 via Frontend Transport; Mon,
 19 Jan 2026 08:31:04 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solidrn.onmicrosoft.com;dmarc=fail action=none
 header.from=solid-run.com;
Received-SPF: Fail (protection.outlook.com: domain of solid-run.com does not
 designate 52.17.62.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=52.17.62.50; helo=eu-dlp.cloud-sec-av.com;
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 DU2PEPF00028D0B.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.1
 via Frontend Transport; Mon, 19 Jan 2026 08:30:24 +0000
Received: from emails-4891271-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-6-235.eu-west-1.compute.internal [10.20.6.235])
	by mta-outgoing-dlp-467-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id 69DD1801EF;
	Mon, 19 Jan 2026 08:30:24 +0000 (UTC)
ARC-Authentication-Results: i=2; mx.checkpointcloudsec.com;
 arc=pass;
 dkim=none header.d=none
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=checkpointcloudsec.com; s=arcselector01; t=1768811424; h=from : to :
 subject : date : message-id : content-type : mime-version;
 bh=+jYTQ7e4N4xi3KPcWoljKEF6UVf2CRcY+Nf8KYWJInI=;
 b=BL5n3QqJx2QYN2vC3jdnozhvy/bICLZGtA1ZjD1lDX1sGV1Gmns07RUvEtNJFZF4TGcYu
 O0pNMnK9O7KDdEABgLbFUQ7YmjXDudBtu0Y6mne1qvOPQjkkVEtK+EAQPb1OwJTkEcbBryp
 ZhGCZX8MfVEFCNiMI7l4GjokSwwhOW0=
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=checkpointcloudsec.com;
 s=arcselector01; t=1768811424;
 b=RkDe0HqVlFLG1hXcCDJ0v1nP50ZhM33BaRWVRZNUpBnYAQHMdhKR+rbD03MzDtGFAcCY3
 rPAyNF7revigshQm/zveTTE7udAzJNjOxJCi2FZZe0EcO/xwcXa18HWxlcpGgR7bV9Fj80j
 ojiym3hkPvk6AuyDBjO7qX0WUxWtX6I=
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qUGlYRvfZ7PkytbdEOs4nko/j6y4zpjbobXT7HmQtYLyIvHVv2Kw33RB5dTunilYEMuHjxRVf4pb6SbX7qgSGHYyxK6aLZhvJiY80Y5lg4HFHYw1Mz/+GhUiYOIT5LOYredvgMTuOV/bH8DSux6HXXZnbeSq1lYOK0hTXrlfOfUHJx0YTqUMDCBGj9L3WfOnaFyPQ3REqQvI//rhQx+LUGFCeZ6wm5RxRf6Kioflwo9gfD/Zl+Zi5nry/RhKoL1xIPR2o+kdiJPtg0gY7uZ2NDupovYSqjqfulR36olDBxrOZaVz5IMrKFLS1M3q3nimnbL226KiZis7MXNWQNkFFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+jYTQ7e4N4xi3KPcWoljKEF6UVf2CRcY+Nf8KYWJInI=;
 b=VOdWKTHD+Ae7atcF+B2N7m0Q8YwrQ9tx9pZYR17wdK/M5glxcs/68f5h0FDwW2QtQlDZ0YHDu4zDB3LF+6XcI1NIPivthWBxtwNALIX/LfMf7zHQ7DErrbUStxu4gwmu6sP0z7X3tblhTojIupRy6g5RAexvkSDW3UV2uB1FNQxOA0N/vH5WPK51z7+6O7B0vyQarAuS4/9Ik5D5PqUBWMNu83xFc9vR4GboJgZTvGyu8VNIJTWtUB2aeHvG6b3KmztglZlubFdn9PGrqSa12J9KL4ThkXxDC5debNKJ8o113Rj17VO7+RLYAP3+fNQvRyreBG49KXFRfbXt0lnPKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+jYTQ7e4N4xi3KPcWoljKEF6UVf2CRcY+Nf8KYWJInI=;
 b=A5BGfw/bRY6dQ8LWCzaUZw22JMg1fNKGKO75UOPfm7ji2QsWZIlxBKpU/ujh0YkC5vaas7SaphW3haWctuAc5M1NbC5fvC2X893YoTQMjFJc3yDnzUFaUhLFz1TsY3r2vTrNiv/1qNBprLf8/6qvV3zDJGmPqCAeFWrw+kp7zhs=
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com (2603:10a6:102:21f::22)
 by GVXPR04MB12126.eurprd04.prod.outlook.com (2603:10a6:150:334::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 08:30:12 +0000
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::aa83:81a0:a276:51f6]) by PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::aa83:81a0:a276:51f6%4]) with mapi id 15.20.9520.005; Mon, 19 Jan 2026
 08:30:12 +0000
From: Josua Mayer <josua@solid-run.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
CC: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC net-next v2 1/2] net: phy: marvell: 88e1111: define
 gigabit features
Thread-Topic: [PATCH RFC net-next v2 1/2] net: phy: marvell: 88e1111: define
 gigabit features
Thread-Index: AQHcezh9IJ4bsKzbBUi5qFtzpIf787U+1VwAgAATJ4CAGly0AA==
Date: Mon, 19 Jan 2026 08:30:12 +0000
Message-ID: <c2b6af56-57f7-4658-9e6f-e671be19e300@solid-run.com>
References:
 <20260101-cisco-1g-sfp-phy-features-v2-0-47781d9e7747@solid-run.com>
 <20260101-cisco-1g-sfp-phy-features-v2-1-47781d9e7747@solid-run.com>
 <aVe-SlqC0DfGS6O5@shell.armlinux.org.uk>
 <aVfOW3y0LTcwQncB@shell.armlinux.org.uk>
In-Reply-To: <aVfOW3y0LTcwQncB@shell.armlinux.org.uk>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-traffictypediagnostic:
	PAXPR04MB8749:EE_|GVXPR04MB12126:EE_|DU2PEPF00028D0B:EE_|AM8PR04MB7332:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e33d737-6ef6-4a7d-4170-08de5734fe1b
x-cloud-sec-av-info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|366016|1800799024|38070700021;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?UHNJNCt0Y2RnWmxXNVU2dFlYbDBLTVNOYnJQaW5NWnMzcVpiLzhuSmVnVXRK?=
 =?utf-8?B?L1NBSUVRNlBxc0ZMTTE4WDBlZFp5cHE5SDVlVHg0V1doYm11Z01xM05qTjRl?=
 =?utf-8?B?K2ZuZUtqWmhiWjlvdlVVOS9JZlhPMWJkNkZpWVZFb0dENDBvSDNQSWtZNTB3?=
 =?utf-8?B?S1VLTFlFdGt0NzQ1Nk9oMXl4dUFZVCtScWFCeVp6OTI2QnhHU2g3SFVrcEdX?=
 =?utf-8?B?RVB0M053aGFQTTVTaWM2SzNFbS9uNDRLN2lHZnlnNzdpSTJmMmFJd2UvYWhL?=
 =?utf-8?B?cmRTbDV4V2J0Sm1Bc1ZwLzlSVWsxd2VyUUM2ZmxJU2RpVldsZkFYVnFKUWc3?=
 =?utf-8?B?bHU2cnk4M0QvMW5LOWhSVmhYb3dQMDNiRHM4V0tqazVUVm03K3Z1NWJBanVC?=
 =?utf-8?B?aWxsSjkxYjJsRXp3NDBPSWV0NVI2NmZNM3lhcm13N3RyUS9rN2VPSVIrSGti?=
 =?utf-8?B?WTdmaDJ5YXJPcGRuNURuVExycVhab05nYmFFQnAxTXhsQzJ3dGZTOG9ReUhZ?=
 =?utf-8?B?R2t3bzQ4MEs2U3BiVFh2b3VNK3JwN3U2SkNCS1cwR01rOVBFaGRmWTExZ01s?=
 =?utf-8?B?T2RiT2dHdzVyWDNoSmpyN3NoZ0FyaTU3eDhudXlWWXMvMVcxMGkzSTF1SGJI?=
 =?utf-8?B?bGZySFFPUDZCVkhUZ0pweW9oVWlqRTBxZENUK1RLNDBtZmQvaDA0WC9wSTRq?=
 =?utf-8?B?VElVbUF1eXhlVlppM1loTTl6bGRhZjQxT0lGYnA5ZnlNYnozY0JBYmhpZDgx?=
 =?utf-8?B?ZWI0TDVRME13R1FZZWorM3JGL0dHZUVuczlQczBqTzljT0tteVdKNWM5ZHd2?=
 =?utf-8?B?SzNRU05RTEk5U0UxbUR4WFRBTk9ER056MStMdnlrR1ZEeTlMTzlSYVphSUNS?=
 =?utf-8?B?TU9HbmRZUnYrYmtoUGpoM3RGTDZkNWRWUkgzZk9PQmtWSnJGejNVcGhqenky?=
 =?utf-8?B?bmprbHRHQnZhTjZuVTdNcW1GK2syTjdtaUE3U2VKN3owT2dIczZEN1BpOHpv?=
 =?utf-8?B?V0hYQ0ZicWF2RThFSGM3N0RFT0xaVDVmaG94bXBJOWF2YlpmaU1pZWUvUFk5?=
 =?utf-8?B?NzVrWXlZUFNyTjFQa1dqZ1BBWTFhS0pzbDFCZmw3OW1ITVBxTDVaNnJkL0Zq?=
 =?utf-8?B?RnNoSXVkdlVTSEp3UEwrQTF1MUpPbVhGV1ZiREl6cnNWT2o0M1ZOSUR4VFdZ?=
 =?utf-8?B?U2o5VzdRaVliWmZKNitZVEIyR1F6aWV3Q1RtWHk4U2FnUDZoeWlFRWJTUHNJ?=
 =?utf-8?B?WHZtWHg4ZGVvRzc4TzA3dDVIenM3TnI1RjBObU1yNy9odUpOQUFKMjA0Tm5V?=
 =?utf-8?B?a0pQZ0ZEaVZhUDBZNm5qMG9aYjVid3JjNS9nWnpMVndPM3E2N0JZcnNBK1Br?=
 =?utf-8?B?TFhzNDdybG9qbndKU0p6ODFsMDY3QTlLZ0RDUUVsL3BMRkRIcDFaQ0poT091?=
 =?utf-8?B?bzBKRFNqcG9JVThhaktUUHNxL3drMUFzVndNUnFjcmNMRnR1dGFnTGY1TG5V?=
 =?utf-8?B?ajM1Y1BLS1FvWUQ5S2gybTg5MmJaWGNHSzdFaGFSVSt4bGFoNjV1ZisvbzNl?=
 =?utf-8?B?TW1pMUhsTWYwcHloSkdxaExNUjVraDlseU5BSDB0RHN6dlBBSzVBTnBqZ3kx?=
 =?utf-8?B?Tk1oVkJUdzRIMnI0LzdEWG5IRCtRMHZocW0zMGRWZEFKYXJ1SHNUQXJnRlZt?=
 =?utf-8?B?d3l6UWtQRDBIdTY3WUZpcUpjRnVtQlo5SWordU5xNi9Da3Jhc3dMMEdwTXRL?=
 =?utf-8?B?YU9rK2M2dXE4RndjVGxpRElKVTJFVis2YS9HZ1ZkS2RHdmRrcS9UNmExZkJG?=
 =?utf-8?B?TnRGdXJ6TWo5VWFvNVIyM3R1OCthK1c1RFNoeVQwWnZtVlFLejhxdlBJb09k?=
 =?utf-8?B?bjNnV056S0dzTnpqeVBmM1g4ekh1eG00K256ejVMZmVjN25QM1lsQTk4a0Z2?=
 =?utf-8?B?YWFRMUxqdkM0cnZ3TWt2cVZNT2c3c0VFU0pQWXhvOWU1d0h4cHU5VzZuMjN0?=
 =?utf-8?B?MXlnL3ZYazI0clM1dGN3RG1LN0ovTDJUckdaK3FwWTgvanB0MGExWkdSWFVG?=
 =?utf-8?B?WXFJOU5pZXBUb0FSRHh5ZXNHN0pLcG1ad2tDYmhFYkNYSEFhZ1NIeGxpc3pV?=
 =?utf-8?Q?hG220N+lfCiZOA/CYelb1YcBy?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8749.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="utf-8"
Content-ID: <E7DE3D0CC018F743811765D9877AD18D@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB12126
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: 20ba8153d6b04584ab143fe8ccf48ce8:solidrun,office365_emails,sent,inline:36a4ca125887fe6ad24e7179c2bb258d
Authentication-Results-Original: mx.checkpointcloudsec.com; arc=pass;
 dkim=none header.d=none
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF00028D0B.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	a670806f-76e4-4a30-17b4-08de5734f6fa
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|35042699022|1800799024|82310400026|14060799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZUluU0pUK2huVU03RkpZTDF2SW1Xa1JqNytpdWVjd2FKRW44QklLWlhWbnVL?=
 =?utf-8?B?cjVlWkVVZDlobVp4elJSYmI3cnVXbDNFVGszQ09yYTZ1WjF3WVc0eDRNcDgr?=
 =?utf-8?B?MmlhNXJod0ZUTHFMdU5jRU82akhsSy9qbjhFREVpMGpCRmFvN00yN2o3bkRm?=
 =?utf-8?B?dmdtL1p0THdhMUFNZzcrZzZEZXlnNjdQMXplZDQydVV3VFJnSGlITzZqRE1k?=
 =?utf-8?B?RVBkZjRJQUFXUXVmeXAwMUU4aDZ0SUxWQ0dWdG1FRnZDR2I1aWVkdXZzb051?=
 =?utf-8?B?ZlNMdlVlTGFCZmR3WXJ4bEc4OWpnNDNPNGI0LzF2aTlyWlFnY2x3bUxPZnht?=
 =?utf-8?B?cFJKTmxSK0lUclBybTVDYU9Fb0cwWU9mc2hycW8rRjBCYzVhN1pGcnVjYzJI?=
 =?utf-8?B?SjZtdWRjODRpVE5uYU02a2xVTGVyRkhaYjZMY1g2Z3lGbElTZGVOT1pTN3p3?=
 =?utf-8?B?ekl6WTdDSUJEbWpydS9jWk8zbkJxdkluK0I4dlA4MkQrVmRkc2lrZ2FHRTlD?=
 =?utf-8?B?ZzN5REFERFFrc295eldBVXNFN3Z0Wm94QkhzOStQSk0xTW1UV1NNUWxMdHlC?=
 =?utf-8?B?VGMxT2NJS3RMV2RtRzUwY3U2YkxKUjFiTE8rbVlqTGNHd25IZGR2eEQ3Rk11?=
 =?utf-8?B?ZEVQdGpHKzltUnh5Yk5YK01tU01BL2JRL21KVEhWZXhzb2VLLzJuVlBGTEFk?=
 =?utf-8?B?cEhFamhNSUkzejVZV2Z2YlFNTEU3VnFtdGoxc0NoSWU2RHNGQXdQTnRTTFE2?=
 =?utf-8?B?Y3BNSEJnOVBrOXhOZ2tjMjdzWlo0Z2NQM3VKQjJ1RDlRcC9DbVppZmplWDJm?=
 =?utf-8?B?clQ5KzlQdDBJUnY3VmtQV0t5ei9rQlR5aElSdE9ITzlicjB0RmY1NVE4RWtN?=
 =?utf-8?B?REM2NHFHZzBQZ1ltMWF4TUlhRno3QVpsUWlzdXUvbjZwUFo5Z21RdHpFWlVj?=
 =?utf-8?B?T21yUzExV3hpWERtSjlNN0V1NVJzNEVOV1N4WTB1L2RyN3RRQ001OEpOL3Er?=
 =?utf-8?B?ZlVGNVhCak94Y0RCbXV6Mnp0QkhNd0VETE02cmw5dE9QdUJnK0Z2dERsTDl3?=
 =?utf-8?B?Y0kzVkpuakQyMkdHeWIzTGUyY3BtRHNacFRMRE5kMHhzUm91MVhEN0NVQ2tR?=
 =?utf-8?B?ZzN4ZGdoL1NjUzh4enZkQ3Z0SEZ3NXN1Y0JkZHZhejhBdS8yTDBWUytwRmhW?=
 =?utf-8?B?V2lSd2k3WFAwdFFIZkFPVm9tYXhpbGI4V0xhYVltY3BKNUl2ZjBINC9TNmFG?=
 =?utf-8?B?ZXFOZE4yN2F0YVJlaGhnYWZub3Nsb25Ea0x0TVhqdUZKQ1MwQ3hSOGtvTjRx?=
 =?utf-8?B?YzhQMVNIRXQ4ajFrNVMxSEhEcURoNnRQVllBVHphSmd5WnVIV01Rd3Bad055?=
 =?utf-8?B?WUV6NFZaK1RXQmRqVys1Vmhpb1dOWkc1eEFDTGVKTVhDTHdWOFdGMUZWekRt?=
 =?utf-8?B?SmFsZncvcDRpK0V3a05zUldsNFQ0TEFmUDBDcE90TGY3S3k3MTJvY0RjaWRw?=
 =?utf-8?B?OUJySUZNSjVJYktUWmtuUGwzbzVwanliYzlTTlh6Mm5TSGFNKzV1Si9MclpI?=
 =?utf-8?B?VEZlbHJMZnFkVHpLb3lVZ1k0VTYwSFJlam5OUERQbDh0eEluMFJ4SURNZkhI?=
 =?utf-8?B?UWpDY0lQWlpONjNwQ2Z4ZFkvTncxeEFvK2dnM3MzZWlGd21JUVlndG9HRlpv?=
 =?utf-8?B?NlRrNVJiN0o1ZXJ6U0Zzd2hSWmFRNTlhdkRhM0NLSk9FTk91NW82VDFrc01S?=
 =?utf-8?B?Nit4R3ZkU2pXTXdnRzlZdnRUZlgvaWJ0U040TUhLQ0Evb1MzUTI3K20xRmNX?=
 =?utf-8?B?dEVqSmVKYzk3K2VlZ2dpTVFseDJvM3BYVm5mcDBhdDNJODdTVEZYazJHd25S?=
 =?utf-8?B?UG5FSEpyRkNWL0QybmRlTXh4RTdQRThsTS9XMUoyM3hjb2w2MDhaS1NyeWpO?=
 =?utf-8?B?ZTl4VEtVQjNDZXRwQitLMTBsaTJmaWJTUm5WaTJUVnBIRTJGSzA1M0lwaURQ?=
 =?utf-8?B?MWZHN2c0a1U2UVZsTlViM1Z2V1p1a2hPbUN3U3VhYXFONUE5UThlZWYvUGtq?=
 =?utf-8?B?RmZhMU52RXhQREdteEYxZVhvRVMrYXQrUzBGVE1wcXVJd2o2cXl3cEV2T3U3?=
 =?utf-8?B?ZGFORHNSOVFuaTNnNzBhTDhIbi9vR2hpend2aE5VakhUOHlQR3pEN3dISlpX?=
 =?utf-8?B?cnc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(35042699022)(1800799024)(82310400026)(14060799003);DIR:OUT;SFP:1102;
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 08:30:24.5886
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e33d737-6ef6-4a7d-4170-08de5734fe1b
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D0B.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7332

SGkgUnVzc2VsbCwNCg0KVGhhbmsgeW91IGZvciB0aGUgZXh0ZW5zaXZlIGZlZWRiYWNrIQ0KDQpP
biAwMi8wMS8yMDI2IDE1OjU1LCBSdXNzZWxsIEtpbmcgKE9yYWNsZSkgd3JvdGU6DQo+IE9uIEZy
aSwgSmFuIDAyLCAyMDI2IGF0IDEyOjQ3OjA2UE0gKzAwMDAsIFJ1c3NlbGwgS2luZyAoT3JhY2xl
KSB3cm90ZToNCj4+IEkgZG8gaGF2ZSBwYXRjaGVzIHRoYXQgYWRkIHBoeWRldi0+c3VwcG9ydGVk
X2ludGVyZmFjZXMgd2hpY2ggYXJlDQo+PiBwb3B1bGF0ZWQgYXQgcHJvYmUgdGltZSB0byBpbmZv
cm0gcGh5bGluayB3aGljaCBob3N0IGludGVyZmFjZSBtb2Rlcw0KPj4gdGhhdCB0aGUgUEhZIGNh
biBiZSByZWNvbmZpZ3VyZWQgYmV0d2VlbiAtIGFuZCB0aGlzIG92ZXJyaWRlcyB0aGUNCj4+IGxp
bmttb2RlLWRlcml2YXRpb24gb2YgdGhhdCBpbmZvcm1hdGlvbiAtIGl0IGJhc2ljYWxseSBiZWNv
bWVzOg0KPj4NCj4+ICAgICAgICAgIHBoeV9pbnRlcmZhY2VfYW5kKGludGVyZmFjZXMsIHBoeS0+
c3VwcG9ydGVkX2ludGVyZmFjZXMsDQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICBwbC0+
Y29uZmlnLT5zdXBwb3J0ZWRfaW50ZXJmYWNlcyk7DQo+PiAgICAgICAgICBpbnRlcmZhY2UgPSBw
aHlsaW5rX2Nob29zZV9zZnBfaW50ZXJmYWNlKHBsLCBpbnRlcmZhY2VzKTsNCj4+ICAgICAgICAg
IGlmIChpbnRlcmZhY2UgPT0gUEhZX0lOVEVSRkFDRV9NT0RFX05BKSB7DQo+PiAgICAgICAgICAg
ICAgICAgIHBoeWxpbmtfZXJyKHBsLCAic2VsZWN0aW9uIG9mIGludGVyZmFjZSBmb3IgUEhZIGZh
aWxlZFxuIik7DQo+PiAgICAgICAgICAgICAgICAgIHJldHVybiAtRUlOVkFMOw0KPj4gICAgICAg
ICAgfQ0KPj4NCj4+ICAgICAgICAgIHBoeWxpbmtfZGJnKHBsLCAiY29wcGVyIFNGUDogY2hvc2Vu
ICVzIGludGVyZmFjZVxuIiwNCj4+ICAgICAgICAgICAgICAgICAgICAgIHBoeV9tb2RlcyhpbnRl
cmZhY2UpKTsNCj4+DQo+PiAgICAgICAgICByZXQgPSBwaHlsaW5rX2F0dGFjaF9waHkocGwsIHBo
eSwgaW50ZXJmYWNlKTsNCj4+DQo+PiBhbmQgcGh5bGlua19hdHRhY2hfcGh5KCkgd2lsbCByZXN1
bHQgaW4gdGhlIFBIWSBkcml2ZXIncyBjb25maWdfaW5pdA0KPj4gYmVpbmcgY2FsbGVkLCBjb25m
aWd1cmluZyB0aGUgYXBwcm9wcmlhdGUgb3BlcmF0aW5nIG1vZGUgZm9yIHRoZQ0KPj4gUEhZLCB3
aGljaCBjYW4gdGhlbiBiZSB1c2VkIHRvIHVwZGF0ZSBwaHlkZXYtPnN1cHBvcnRlZCBhcyBhcHBy
b3ByaWF0ZS4NCj4+DQo+PiBwaHlsaW5rIHdpbGwgdGhlbiBsb29rIGF0IHBoeWRldi0+c3VwcG9y
dGVkIG9uY2UgdGhlIGFib3ZlIGhhcw0KPj4gY29tcGxldGVkIHdoZW4gaXQgd2lsbCBkbyBzbyBp
biBwaHlsaW5rX2JyaW5ndXBfcGh5KCkuDQo+Pg0KPj4gRGVyaXZpbmcgdGhlIGhvc3Qgc2lkZSBQ
SFkgaW50ZXJmYWNlIG1vZGUgZnJvbSB0aGUgbGluayBtb2RlcyBoYXMNCj4+IGFsd2F5cyBiZWVu
IHJhdGhlciBza2V0Y2h5Lg0KPiBUaGVzZSBwYXRjaGVzIGNhbiBiZSBmb3VuZCBhdDoNCj4NCj4g
aHR0cDovL2dpdC5hcm1saW51eC5vcmcudWsvY2dpdC9saW51eC1hcm0uZ2l0L2xvZy8/aD1uZXQt
cXVldWUNCj4NCj4gU2VlOg0KPg0KPiBuZXQ6IHBoeWxpbms6IHVzZSBwaHkgaW50ZXJmYWNlIG1v
ZGUgYml0bWFwcyBmb3IgU0ZQIFBIWXMNCj4gbmV0OiBwaHk6IGFkZCBzdXBwb3J0ZWRfaW50ZXJm
YWNlcyB0byBBcXVhbnRpYSBBUVIxMTNDDQo+IG5ldDogcGh5OiBhZGQgc3VwcG9ydGVkX2ludGVy
ZmFjZXMgdG8gbWFydmVsbDEwZyBQSFlzDQo+IG5ldDogcGh5OiBhZGQgc3VwcG9ydGVkX2ludGVy
ZmFjZXMgdG8gbWFydmVsbCBQSFlzDQo+IG5ldDogcGh5OiBhZGQgc3VwcG9ydGVkX2ludGVyZmFj
ZXMgdG8gYmNtODQ4ODENCj4gbmV0OiBwaHk6IGFkZCBzdXBwb3J0ZWRfaW50ZXJmYWNlcyB0byBw
aHlsaWINCj4NCj4gVGhlIHJlYXNvbiBJIGRpZG4ndCBlbmQgdXAgcHVzaGluZyB0aGVtICh0aGV5
J3JlIGFsbW9zdCBzaXggeWVhcnMgb2xkKQ0KPiBpcyBiZWNhdXNlIEkgZGVjaWRlZCB0aGF0IHRo
ZSBob3N0X2ludGVyZmFjZXMgYXBwcm9hY2ggd2Fzbid0IGEgZ29vZA0KPiBpZGVhLCBhbmQgZHJv
cHBlZCB0aG9zZSBwYXRjaGVzLiBNYXJlayBCZWjDum4gdG9vayBteSBwYXRjaGVzIGZvcg0KPiBo
b3N0X2ludGVyZmFjZXMgYW5kIHRoZXkgd2VyZSBtZXJnZWQgaW4gMjAyMi4gSSBoYWQgYWxyZWFk
eSBqdW5rZWQNCj4gdGhlIGhvc3RfaW50ZXJmYWNlcyBhcHByb2FjaC4NCj4NCj4gVGhlIHByb2Js
ZW0gaXMgdGhhdCB3ZSBub3cgaGF2ZSB0d28gd2F5cyB0aGF0IFBIWSBkcml2ZXJzIGNvbmZpZ3Vy
ZQ0KPiB0aGVpciBpbnRlcmZhY2UgbW9kZSAtIG9uZSB3aGVyZSBjb25maWdfaW5pdCgpIGRlY2lk
ZXMgb24gaXRzIG93bg0KPiBiYXNlZCBvbiB0aGUgaG9zdF9pbnRlcmZhY2VzIHN1cHBsaWVkIHRv
IGl0LCBhbmQgdGhpcyBhcHByb2FjaCBhYm92ZQ0KPiB3aGVyZSBwaHlsaW5rIGF0dGVtcHRzIHRv
IGNob29zZSB0aGUgaW50ZXJmYWNlIGJhc2VkIG9uIHdoYXQgdGhlDQo+IFBIWSBhbmQgaG9zdCAo
YW5kIGRhdGFwYXRoKSBjYW4gc3VwcG9ydC4gVGhlc2UgdHdvIGFwcHJvYWNoZXMgYXJlDQo+IG11
dHVhbGx5IGluY29tcGF0aWJsZSBpZiB3ZSBnZXQgYm90aCBwaHlsaW5rIF9hbmRfIHRoZSBQSFkg
ZHJpdmVyDQo+IGF0dGVtcHRpbmcgdG8gZG8gdGhlIHNhbWUgdGhpbmcuDQoNCkFsbCB0aGlzIGxl
ZnQgbWUgcHV6emxlZC4NCg0KSSB1bmRlcnN0YW5kIHRoYXQgLmZlYXR1cmVzIC8gZ2V0X2ZlYXR1
cmVzIGhhcHBlbnMgdG9vIGVhcmx5DQphbmQgZG9lc24ndCBhY2NvdW50IGZvciBkaWZmZXJlbnQg
aG9zdCBpbnRlcmZhY2VzLg0KDQpGdXJ0aGVyIHBvcHVsYXRpbmcgc3VwcG9ydGVkIGJpdG1hc2sg
YmVmb3JlIGNvbmZpZ19pbml0IGlzIHdyb25nDQphdCBsZWFzdCBmb3IgdGhpcyBtb2R1bGUgd2hl
cmUgc3VwcG9ydGVkIGxpbmstbW9kZXMgYXJlIGRpZmZlcmVudA0KcGVyIGhvc3QgaW50ZXJmYWNl
Lg0KDQpUaGUgbWFydmVsbDEwZy5jIGRyaXZlciB3aGljaCBub3cgdXNlcyB0aGUgaG9zdF9pbnRl
cmZhY2VzIGJpdG1hc2sNCmlzIG5vdyBleHRlbmRpbmcgdGhlIHN1cHBvcnRlZF9pbnRlcmZhY2Vz
IGJpdG1hc2sgaW4gY29uZmlnX2luaXQuDQpZZXQgSSBkaWRuJ3QgdW5kZXJzdGFuZCB3aGF0IGl0
IG1lYW5zLg0KDQogRnJvbSBwaHkuaDoNCg0KIMKgKiBAcG9zc2libGVfaW50ZXJmYWNlczogYml0
bWFwIGlmIGludGVyZmFjZSBtb2RlcyB0aGF0IHRoZSBhdHRhY2hlZCBQSFkNCiDCoCrCoCDCoCDC
oCDCoCDCoCDCoCDCoHdpbGwgc3dpdGNoIGJldHdlZW4gZGVwZW5kaW5nIG9uIG1lZGlhIHNwZWVk
Lg0KDQpTbyBkb2VzIHRoaXMgbWVhbiB0aGUgaG9zdCBzaWRlPyBPciB0aGUgY29wcGVyIHNpZGU/
DQoNCklmIGl0IG1lYW5zIGhvc3Qgc2lkZSwgd291bGQgaXQgYmUgb2theSBmb3IgdGhlIDg4RTEx
MTEgcGh5IHRvIHBvcHVsYXRlDQpwb3NzaWJsZV9pbnRlcmZhY2VzIGZyb20gaXRzIGNvbmZpZ19p
bml0IGZvciAxMC8xMDAvMTAwMCBsaW5rLW1vZGVzLA0KaWYgaG9zdCBzaWRlIGlzIGNvbmZpZ3Vy
ZWQgZm9yIHNnbWlpPw0KT3IgcG9wdWxhdGUgcG9zc2libGVfaW50ZXJmYWNlcyBmcm9tIEJNU1Ig
YXQgdGhpcyBwb2ludD8NCg0KVW5mb3J0dW5hdGVseSBJIGRvIG5vdCBoYXZlIHRoZSBhZmZlY3Rl
ZCBTRlBzIG5lYXIgbWUgZm9yIGEgZmV3IHdlZWtzLg0KDQo=


