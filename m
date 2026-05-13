Return-Path: <netdev+bounces-287550-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wIB+LG1jBGq6HgIAu9opvQ
	(envelope-from <netdev+bounces-287550-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 13:41:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 56ECA5326FA
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 13:41:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B72F1301C353
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 11:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 306CA3FE379;
	Wed, 13 May 2026 11:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=solid-run.com header.i=@solid-run.com header.b="czCNIUzA";
	dkim=pass (2048-bit key) header.d=solid-run.com header.i=@solid-run.com header.b="czCNIUzA"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021125.outbound.protection.outlook.com [52.101.70.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772093FBED0;
	Wed, 13 May 2026 11:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.125
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778672491; cv=fail; b=vGDmtF+VR4epuDJ7l54QVEaiqOWDKwK02akk9QXaUE+0WR78tcDwt5tEGSMZ6a0PdDlGseFe3dLx8sC/E6c9QnhfIX8WWMVT8ccDA6wMN9eiQ0zUMH4ojGrXrYBuBI8//y0q7gmrFUyjZQAiai0vOvhMPmXs4C2uGOex+mENkRE=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778672491; c=relaxed/simple;
	bh=NnWPpve4l5GTVudwPfCHptClBpNPw7HkLNdhqmVGh7U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Vcu7hxgSiVvDkTt0/caqK75sXZq87xs4jbo90cwzzdES061ol4KCb0/pnOWSi3b6r7DeQPVxwsIYVC/HfA0F1wHharmhmewt5eYxyR927NN5D0jRW17Donk0smdxR2li+G2VIT4ODzsOV18JAK/5X9qM3VePgcBVlUeT7k4ByIY=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (2048-bit key) header.d=solid-run.com header.i=@solid-run.com header.b=czCNIUzA; dkim=pass (2048-bit key) header.d=solid-run.com header.i=@solid-run.com header.b=czCNIUzA; arc=fail smtp.client-ip=52.101.70.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=aOduQ8w4aUIk8IBSQVs2TW8Vqwzl3aVi0849w8Mi7TNkIycLxu1C/ulSex96fBLUKvfFrQDoYJJpHG00Rok+RcRTNlKu62dycU77ZmzbNkZj3nkdwRdKMFREQ7PRMqFnrs73OeoIPwnJaNGPBAGZSOaMJlxeBhhU/V0J7A/wUt1pDzB4IjDKfRym8J+1YXjmEIYNyM7TInn5DVBXRPe+hkehwcGvu7XWPerUpJiP8n6D50d17if9ysV5Nf87bKTWLOO/M3NcAeiOlNp6faePxA+ewIeadYCy5JHBD13RoNMRx1ajbWZRgOysgA2RPUee564EWSFujwBqlahBvGwvtA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NnWPpve4l5GTVudwPfCHptClBpNPw7HkLNdhqmVGh7U=;
 b=DGaf840slWbl2QF89Lvpf50FOvezHhYA9pL22WhEfkuw+pSWygunW3alsFBZT+biX+eOGZl5pIIPiFqu230uobqOHRGTgbDMHeCPa591Igl/B8QO1wQrOim+8tc2X7jF177jiWJ52eQbgddJrMXGlsnv0Nc+IM99T7OuxvN2mlTcsFK2+XaNtTGvKJZmizxZZesQhkKisusecZR9/PUjqgoBgmPXGwKlnqETITStilKvVLHkMQBcKOdD5ATByVQHBHlO3GueKdyHVVV0DlM53fvv+/l9is18d1vAHqXmkVoi4bYb2bNtOA7YvW6HNhEqRo6TtYjBqmAQ8l4IE3WK3Q==
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
 bh=NnWPpve4l5GTVudwPfCHptClBpNPw7HkLNdhqmVGh7U=;
 b=czCNIUzAExHF3Ftk+xj4kLjfw9USNJaklWWjOdVQHwSQB1VR45ZHJjF66dwLQNJVwqf3W09k5mMDi3qcjayrOmqcTnogn223sR+TqHnHzjQH74qUXhUdkPZTOmWKTU5Loi9Ig99PfHzIrs4sx9UB28+Ew6ciQ+TumPqDlrNpUaWLXuRNs6ocNaPYHe/YtcJ9DStI5ayjKABGiPuCGD2DqYCVddPVqzAy+sSF78Atcbpqqlow4aZfSSskVl5VGhjQf1sXVBbFg70oAIFIGt08JZf/Y0kf+ah+bKXfyF2EfaO4OJ4NTYZR+8YwjPp1WbzEZI/NIy+Qnx3Zjs7GrIfAbg==
Received: from DUZPR01CA0343.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b8::23) by AM8PR04MB7907.eurprd04.prod.outlook.com
 (2603:10a6:20b:237::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 11:41:26 +0000
Received: from DU6PEPF0000A7E3.eurprd02.prod.outlook.com
 (2603:10a6:10:4b8:cafe::8c) by DUZPR01CA0343.outlook.office365.com
 (2603:10a6:10:4b8::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.12 via Frontend Transport; Wed,
 13 May 2026 11:41:26 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solid-run.com;dmarc=pass action=none header.from=solid-run.com;
Received-SPF: Fail (protection.outlook.com: domain of solid-run.com does not
 designate 52.17.62.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=52.17.62.50; helo=eu-dlp.cloud-sec-av.com;
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 DU6PEPF0000A7E3.mail.protection.outlook.com (10.167.8.41) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.13 via
 Frontend Transport; Wed, 13 May 2026 11:41:26 +0000
Received: from emails-5810944-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-6-103.eu-west-1.compute.internal [10.20.6.103])
	by mta-outgoing-dlp-305-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id F369B7FFFC;
	Wed, 13 May 2026 11:41:25 +0000 (UTC)
X-Mailbox-Line: From b'josua@solid-run.com' Wed May 13 11:41:09 2026
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qjGccXKEoB7GW0GudpZ7uWLdZoUT9m9Cjqt0jLhDkIwjqPMN1Q+2FWi/0twtWBBSGygWFduN0nbbTySnKiX65b+omXgcioyRAwQ43WIFs1Jx2d6pE/7McWudN49/eJL6xo2LN46oL6AuXpRrV4tOf+A1XfpJw0ke1afLrMFt2WI7T7pv4T0jmjmb1Zqy4fVbp4P9aFFaBPEhiQ41G3QxTwdzJ6/hl92TIZMHBckFh5kVcgpa/zyo5YKHgMk2N8KKxhvzJPgjl+vym2ffNLDjdRVvyp5I4OZ5N+b+WFLA8zjqWEW8tn+8rgYO3Olme5aGi/COVR24XtCjQISXcPNoLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NnWPpve4l5GTVudwPfCHptClBpNPw7HkLNdhqmVGh7U=;
 b=gjv9QbTNAxYQnBVoHTdsYZxX4MSQUu1i1HC++oOVpXMHQEyzDrpiMx9uTJ4BH5RvltrGi/J4VnbAcZasoDc026X5ivpP41SX+W/OyBMS4mjXh05NHsl3oXZagB3rrcN7OnKz5XpYE8HqzIFCRduwdc4AuGFZPhtfSW4WS8u3YimwAeEITnVd+GO8zF6fUXQAQHEuddjdesmsM9IPVjaOOYr5jIyn6rxHVDcck7o2kNax0LgNuJPuOYDZeOGWJdqhOhLA3gpEyoWARCSRTzQJ0acAEKl0bfk3jjPE1fQWei6wrU8FI1QIsFdqytR20THHDJOhfa+ElDXgk5fqkUa1bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=solid-run.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NnWPpve4l5GTVudwPfCHptClBpNPw7HkLNdhqmVGh7U=;
 b=czCNIUzAExHF3Ftk+xj4kLjfw9USNJaklWWjOdVQHwSQB1VR45ZHJjF66dwLQNJVwqf3W09k5mMDi3qcjayrOmqcTnogn223sR+TqHnHzjQH74qUXhUdkPZTOmWKTU5Loi9Ig99PfHzIrs4sx9UB28+Ew6ciQ+TumPqDlrNpUaWLXuRNs6ocNaPYHe/YtcJ9DStI5ayjKABGiPuCGD2DqYCVddPVqzAy+sSF78Atcbpqqlow4aZfSSskVl5VGhjQf1sXVBbFg70oAIFIGt08JZf/Y0kf+ah+bKXfyF2EfaO4OJ4NTYZR+8YwjPp1WbzEZI/NIy+Qnx3Zjs7GrIfAbg==
Received: from GVXPR04MB12057.eurprd04.prod.outlook.com
 (2603:10a6:150:313::24) by GV2PR04MB11634.eurprd04.prod.outlook.com
 (2603:10a6:150:2cb::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 11:41:06 +0000
Received: from GVXPR04MB12057.eurprd04.prod.outlook.com
 ([fe80::14f1:a127:2988:de5b]) by GVXPR04MB12057.eurprd04.prod.outlook.com
 ([fe80::14f1:a127:2988:de5b%7]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 11:41:06 +0000
From: Josua Mayer <josua@solid-run.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
CC: "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Ioana Ciornei
	<ioana.ciornei@nxp.com>, Vinod Koul <vkoul@kernel.org>, Neil Armstrong
	<neil.armstrong@linaro.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH phy-next 5/5] phy: lynx-28g: add support for 25GBASER
Thread-Topic: [PATCH phy-next 5/5] phy: lynx-28g: add support for 25GBASER
Thread-Index: AQHc4VcBNwfvvLflf0GuY4D0POuBgbYLzL+AgAAGGwCAAAU8AA==
Date: Wed, 13 May 2026 11:41:06 +0000
Message-ID: <7aa87d24-5501-4ca4-bb39-791beb7c95f2@solid-run.com>
References: <20260511150023.1903577-1-vladimir.oltean@nxp.com>
 <20260511150023.1903577-6-vladimir.oltean@nxp.com>
 <375dddbc-385c-4dcb-a280-33292215ae67@solid-run.com>
 <20260513112222.2szwvxptk2udv7ga@skbuf>
In-Reply-To: <20260513112222.2szwvxptk2udv7ga@skbuf>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
x-ms-traffictypediagnostic:
	GVXPR04MB12057:EE_|GV2PR04MB11634:EE_|DU6PEPF0000A7E3:EE_|AM8PR04MB7907:EE_
X-MS-Office365-Filtering-Correlation-Id: 52803ca5-dfaa-4c68-71fc-08deb0e490c5
x-cloud-sec-av-info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|376014|366016|3023799003|18002099003|56012099003|22082099003|38070700021;
X-Microsoft-Antispam-Message-Info-Original:
 iwErtbtIBmMBiFPpGJREiNLNZX/Mww40496dmgP+4Lkd29C1b7Xrw+xmpjeRCc5aOTRWiNd/KnA9WZ6Ls7iyI2a584jiydxmzKv4NW1bSn2N1Hdc941quPrtQ3eMX4SF6IWCxt7QPb8FZcgrDZdIRyTsdEZ9fRr9+FtcVnJ8cguuk96FnEvaSuBKiArvrmUGptAWAqgq9jVLWX63dbaAQQRC5qoVOxlYxsQkbE4/xlhOmv47/F3khXtKS9y27uxYnyQA/OL7gQ17G7bb/Gpi7ExARxmsw1QDiiZQ6F0MBn8pOQnmZSdJD3j5s5M63NrITfe49VRVU+mcLtkxK+pUzYuZ547QHrqi8KGX0BtwFZ38fcqmsREliYkBRCODd82hmi+dUrA/AC6AQfDYctiH8IeFe1rhm9MFAfcxs82v/+l74BxkccynSfl8uYNPLOLUCEPYJRTLDRFCM0HwlDrSMHEKS4f4m5QwwBQ8t5P1EytnZ7ClBcVGWemGyW2QMfgfhqrIj5wgQ31RLT8+zx6sGa2IO2rSowHszQNWb3/dRSoAwZNJ5aYH6Oi67aDK31tkRsRlGE1sX+RIr9VoIXemfI+fjocoADnwGEE1kzDbsRWn6KtZIxP77PPcxop3COIMEoVfc9GVBTGqu1J7SqTlqXPwj+1O+S234im/hiY8upIbgjtcQzBBIfuwiYp2OO5mgwaGp49PavyZKrAU3ORNHQwT93qApSdoQq42Hlr88wEgGTMNEbVdcCF5BoByL7jn
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12057.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(3023799003)(18002099003)(56012099003)(22082099003)(38070700021);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="utf-8"
Content-ID: <CE4160F7364669479D46E4E6BA7E8047@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
 JZJwgWLCAHCiZlw/jqrUfX8YSHEOkRNcdLWBaJS9LSdGZoAr3ZqJZ4Q8N0ZJpSQN3rrvu+/Rh6B6ZNoNYnqz77t/8QH17tDnJ/5a2DijlevE901W1BOMgAvdxjnE4C87FsJRUKA+dsjCILyVOdp2XuuKJd6KjZABdrscsGrjzK0Z5Ev5Q+XfVI+DR9C8VlH4FuvRteuGueCUdsYnk+aJcmy07R4q88vxtj0gc1VvGIwNbQj6cBsEw58iE6OP4iU112x0RYRrTmWUR8hNk3XQfkcT+ezAGyXVXaazMibQ2oKtU0zV8yw9tIrpT2Vi2YEUyEzPlW1KTMuom3rWOe5H0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11634
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2-7.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: c77dd1fc3a864cf3ad4adc50238fbc75:solidrun,office365_emails,sent,inline:1412bcce9e7a9c86e8f6ce96ca54cbf1
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU6PEPF0000A7E3.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	9c41ecd6-b4af-41fa-7fd3-08deb0e4851e
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|35042699022|14060799003|36860700016|376014|56012099003|3023799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	SqSM1rsSc9d9Fu7DyISAlDqOxsbt6R+DhZZnt34V83JOsS/BsVM9ddlxmVKqXPoG5IJt5YTomxJevTXP+6IR903960EFHrVReP/p/HfQz9B6Bvg2vek3nV2I+x16bwP/E39tGauYxpKrw9I3VLBf2TMjI+8trCeRj60Ejg3qHlL4Nj0oWfr72FkTxCO3pUsu9mVl6+/ampZJfEu9HHFC3/2KbjXIo4kTY3e1LJPXh7f6+SlmMcWHHmgF9iiGLM+VRVTHRKKA2J1j5fyVQ1L4xsWFE3rmMlSKkmrbTLLLUrQAP7VkjZzP5v7X5UQyemencUPWwASC+k76ydv9mk7gikw5bTPgiy7bvXrn+j0r2WawT/iU/44kjjyquZ/bl51SOqc/cFcon6HIXF2HPFp8oi/CiNgfHjTUjVmMrM98LjoZAh5xDaaoaX5RIOC8z8yBV54xfJoGA34cOphVEnCGkxnLfb+AKr/U14UmtcckWY8FBi1zdVyZ6wUwZknLLuN4mB3VFn7W3R183ZYHg28ZATZmTEgh37bfhD5BxeV/F8X3a7gM3XgemWbFfQacqkKWcKl9vMKIj5XTqD97yvG3JRrdm3Oeu2q0dsvs4SelrSeKUNX9N0V5ndAL5YWUPv+t4iYf1/ELztmBcDkLvqrk4XYq+8vLBkhoQDL5jM4KTMnNkVo1wVN7Jo/RYpfadM4fvrR6aWaGiYOlwgx0g47FSheGBxztYYPFRH3QMMOOKyI=
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(35042699022)(14060799003)(36860700016)(376014)(56012099003)(3023799003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ir+j3OBeUAOgbggoRW92iE+87Sn9ATyAR4/1/HPiuse2VoDYol9N8+HE/MJW+oo0/SsMOzTKlXnNzZmNa8elY99yp3FURpT7KPu/M7pDPM1zXTY7XZSHbcolBNzEGYjesPtxQnoXfe6V8WjNPu2jW7GrQ0iRv2ivGb1Crc0cCwU41BVTOlHPrQ+TWDozl8ChyXqqewGyKSH5k+YydwcGRgAfWc1dkhphFieAke9FnYxA/G188HfatTgA7Dp2igiUP24jSMjiPHUARTqh+Lp1SDJKbl/zzrZnM/OIKnOewGh4rD4A9aPHSrNT0OpX1c0N2b3k9bg3jyFb+nFoywC4UICt8Z3lVoaC0m2zmTMIkY1AKv/u/m+5jR5vPvR6QNhMdJfripNrYYc+0KoLCk2VGfBQRPAfN63+V5t6JRj6rjDPixhXaJXurOk48aOTaEHA
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 11:41:26.0613
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52803ca5-dfaa-4c68-71fc-08deb0e490c5
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000A7E3.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7907
X-Rspamd-Queue-Id: 56ECA5326FA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=3];
	DMARC_POLICY_ALLOW(-0.50)[solid-run.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[solid-run.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-287550-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[solid-run.com:mid,solid-run.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
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
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

QW0gMTMuMDUuMjYgdW0gMTM6MjIgc2NocmllYiBWbGFkaW1pciBPbHRlYW46DQoNCj4gT24gV2Vk
LCBNYXkgMTMsIDIwMjYgYXQgMTE6MDA6MzJBTSArMDAwMCwgSm9zdWEgTWF5ZXIgd3JvdGU6DQo+
PiBXb3VsZG4ndCBpdCBiZSBtb3JlIGNsZWFyIGluc3RlYWQgb2YgaW5kaXJlY3QgbGFuZSBvZmZz
ZXQgc2hpZnQgd2l0aA0KPj4gbHlueF8yOGdfZTI1Z19wY3Z0LCB0byBpbnN0ZWFkIGZpeCB0aGUg
RTI1R19DRkcgZGVmaW5pdGlvbj86DQo+Pg0KPj4gLSNkZWZpbmUgRTI1R19DRkcoaWQpICgyOCAt
IChpZCkgKiA0KSAvKiBPZmZzZXQgaW50byBQQ0NEICovDQo+PiArI2RlZmluZSBFMjVHX0NGRyhp
ZCkgKChpZCkgKiA0KcKgIMKgIMKgIC8qIE9mZnNldCBpbnRvIFBDQ0QgKi8NCj4+DQo+PiBUaGlz
IGlzIGVxdWl2YWxlbnQgd2hlbiBpbnNlcnRpbmcgKDcgLSBsYW5lKSBpbnRvIEUyNUdfQ0ZHIGlk
Og0KPj4NCj4+ICgyOCAtIChpZCkgKiA0KSA9wqAoMjggLSAoNyAtIGxhbmUpICogNCkgPcKgKDI4
IC0gNyo0ICsgbGFuZSo0KQ0KPiBUaGUgJ2luZGlyZWN0JyBsYW5lIG9mZnNldCBzaGlmdCBpcyBh
Y3R1YWxseSBhIHR3by1zdGVwIGxvb2t1cDoNCj4gbGFuZSAtPiBwcm90b2NvbCBjb252ZXJ0ZXIg
aW5kZXgNCj4gcHJvdG9jb2wgY29udmVydGVkIGluZGV4IC0+IG9mZnNldCBpbnRvIFBDQ0QNCj4N
Cj4gTFgyMTYwQVJNIGRvY3VtZW50cyBQQ0NEIGZpZWxkcyBhczoNCj4gRTI1R0FfQ0ZHLCBha2Eg
RTI1R19DRkcoMCkgaW4gY29kZTogMzA6MjgNCj4gRTI1R0JfQ0ZHLCBha2EgRTI1R19DRkcoMSkg
aW4gY29kZTogMjY6MjQNCj4gLi4uDQo+IEUyNUdIX0NGRywgYWthIEUyNUdfQ0ZHKDcpIGluIGNv
ZGU6IDI6MA0KPg0KPiBUaGUgb2RkIGJpdCBpcyB0aGF0IGxhbmUgMCB1c2VzIEUyNUcgcHJvdG9j
b2wgY29udmVydGVyIDcsIHVubGlrZSwgc2F5LA0KPiAxRyBhbmQgMTBHIHdoZXJlIHdlIGhhdmUg
YSBsYW5lOnBjdnQgaWRlbnRpdHkgbWFwcGluZy4NCj4gbHlueF8yOGdfZTI1Z19wY3Z0KCkgcGVy
Zm9ybXMgdGhhdCB0cmFuc2xhdGlvbi4NCj4NCj4gQWRkaXRpb25hbGx5LCBmb3IgbG9jYXRpbmcg
RTQwR0FfQ0ZHLCBFNDBHQl9DRkcgaW4gUENDRSwgSSd2ZSBhZG9wdGVkDQo+IHRoZSBzYW1lIHNj
aGVtZSBkb3duc3RyZWFtLCB3aGVyZSBFNDBHX0NGRygpIHJldHVybnMgYml0cyAzMDoyOCBmb3IN
Cj4gYXJndW1lbnQgMCAocGN2dCBBKSBhbmQgYml0cyAyNjoyNCBmb3IgYXJndW1lbnQgMSAocGN2
dCBCKSwgYW5kIGl0IGlzDQo+IGNhbGxlZCB3aXRoIHRoaXMgbGFuZS0+cGN2dCB0cmFuc2xhdGlv
biBmdW5jdGlvbjoNCj4NCj4gc3RhdGljIGludCBseW54XzI4Z19lNDBnX3BjdnQoaW50IGxhbmUp
DQo+IHsNCj4gCXJldHVybiBsYW5lIDwgNCA/IDEgOiAwOw0KPiB9DQo+DQo+IEFyZSB5b3Ugc2F5
aW5nIHRoYXQgbWVyZ2luZyB0aGUgdHdvIGxvb2t1cHMgd291bGQgYmUgbW9yZSBjbGVhciBiZWNh
dXNlDQo+IGFzIGEgcmVhZGVyIHlvdSdkIGdldCB0byBhc2sgeW91cnNlbGYgbGVzcyBxdWVzdGlv
bnMgKHRoZSBjb2RlIHdvdWxkDQo+IGZsb3cgbW9yZSBuYXR1cmFsbHkpIGRlc3BpdGUgdGhlIG5v
bi10cml2aWFsIGxhbmU8LT5wY3Z0IG1hcHBpbmcsDQpFeGFjdGx5IGZvciB0aGlzIHJlYXNvbi4g
RmV3ZXIgbG9vay11cCBzdGVwcy4NClJNIGRvcyBub3QgZG9jdW1lbnQgdGhpcyBtYXBwaW5nLCBi
dXQgbm93IHlvdSBkbyBpbiBzb3VyY2UtY29kZS4NCg0KUGVyaGFwcyBhIHNob3J0IGNvbW1lbnQg
b24gdGhlIGZ1bmN0aW9uIHdpbGwgaGVscCwgZS5nLg0KLyogZ2V0IHByb3RvY29sIGNvbnZlcnRl
ciBpZCBmb3IgbGFuZSAqLw0KDQo+IG9yIHdoeQ0KPiBleGFjdGx5PyBGb3IgbWUgaXQgaXMgdGhl
IGV4YWN0IG9wcG9zaXRlLiBJIGNhbiBmb2xsb3cgdGhlIFJNDQo+IGRlZmluaXRpb25zIGFuZCB0
aGVuIEkgaGF2ZSBhIHNlcGFyYXRlIGZ1bmN0aW9uIHRoYXQgdGVsbHMgbWUgaG93IGxhbmVzDQo+
IGFyZSBtYXBwZWQgdG8gdGhlIHByb3RvY29sIGNvbnZlcnRlcnMuDQpJIHRoaW5rIHlvdSBnaXZl
IGEgZ29vZCByZWFzb24gaGVyZSE=

