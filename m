Return-Path: <netdev+bounces-254582-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4CH/Azv5emkwAQIAu9opvQ
	(envelope-from <netdev+bounces-254582-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 07:07:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 65726AC250
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 07:07:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AD177300F5F2
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 06:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FB9D377543;
	Thu, 29 Jan 2026 06:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="n3mmrc6a"
X-Original-To: netdev@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023101.outbound.protection.outlook.com [40.107.44.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1AE376BFD
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 06:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769666847; cv=fail; b=MyZ6LmoRBXN72FMVmYMGAVrzOmcgc4abgMYjIyc+DPN0mkYN8spqTUnCHBzL/r3lm7Y1zuPsYIjMQMDtfH3A45vFr8cOsbTj6g1rVwRggufsUoOWy1j4S/NFtBh8Q/AMBBjzKhbmRhKSGkOyG9jEvL4Pi23eu57k0ccBU+rDHYM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769666847; c=relaxed/simple;
	bh=HLTapAHLNJtHL8on/GdcCIE7OeuH/hK8ZqWEPifW95M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IjL62M9qWWBnwLOjSASrz4iT8ihe1qcK6ElwLJi8oActY/4ihgFzuqO20uLj92gIKb0IVu8R31KB0iBXWSDBy9z6r9HHse2j66eeRcOimX9zm6lEQroo6QEF9yGwgANOYCtb4G7yS3gph0gEfVDW4UQN/Dpusz98SXiILY2bByk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=n3mmrc6a; arc=fail smtp.client-ip=40.107.44.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MdS04nL68/FjjjhcPfL1t0GSU6GTehHVk00fR+tpQ1PKrge6v+Uu7KnonYrGKKNKUhGrj4I3rSBYAwIdvGZTpg0ft57e9rRuiK8M4oScUn2cFZUPa2AI9XVk9yYwo9N4q1EHX923gnYSOORM98HR0m5LfoYIKC+WPbrXgsxDKlM1p0VRAh7fJqF0XfYT2hVnKloFXaLK/IgfSio89QuSThJlzrN8ffcNVnF7tNnkE6i1F0Lv3ErStnIMCWxOkTJi8DECOrXDSWYUuYGU7yM3WXF64iwkm3FqrE8MRf/WBs8GNCUfiSHhl5XguCFXp7TomIQ4NuMZoELn7QykiLxAzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I9fOpeSommGxOzVHIWGPLY65CRo+udcY7iFKVUCje/U=;
 b=a3ITeD8uQW8lIDqZg0GSRuaGashdHw5YSh307rhuFUZp+2km1T1AGeyrx0bvbNq9NcW+zpYmWAGt6/CmjdJX8iTWob5toLzRF4TEPHoEJ64sH/IRcj02a5076wB+6diktEh++pz4gzKOMReXdbhR+wiqlOamMe5WCj/1DMfjwk7nP4SMywVo8IS2p0w1hCIY/8w2Q0PQvUXxh42QVi4dGjy2S7b558stQV+vUtMh/90ma5wXxVgdRWIpEL+8UlKoDSR+Ej+Wy6YcCgOpt5RMPLxUgUkMdADDWolu1AyH3zOgTPJh4SLYsukUR0apYbWtOVVVWP/7KyUM0Vnhpe96QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I9fOpeSommGxOzVHIWGPLY65CRo+udcY7iFKVUCje/U=;
 b=n3mmrc6asaQgiPx8vNgxhbMCOGInk2k23ZSxOB9z7d8JNN+KrWdtvsNfF8VD8kqSXc2i2i//taZOPiIJTX5VqgKwriecxzfVJ1ZwgQ8Dh/6L5hJUoFptTROy2R6NcfldXqOPA4qWCX2+gsMxOF+pf9OG4iweFPJHGYI6UXL0u3h7W0oDzW2+oOxNil9swv0jas3kgyxOfhm84AsikpY8TuYBNPo0STvPaEr3++o6voTP/7URho6CqmcGWN5w0B6m0BOYpxxmNckaG96OfzqIIpVN9dZ4WHNhgXDUgwzHrTxL71i9OiEggf/J2ZzaM6KPdzz66HDc5vs2AGQoSGH+kQ==
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com (2603:1096:101:5a::12)
 by JH0PR06MB6703.apcprd06.prod.outlook.com (2603:1096:990:36::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.9; Thu, 29 Jan
 2026 06:07:21 +0000
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::f53d:547a:8c11:fc6c]) by SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::f53d:547a:8c11:fc6c%4]) with mapi id 15.20.9564.006; Thu, 29 Jan 2026
 06:07:20 +0000
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Simon Horman <horms@kernel.org>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: [net-next,v2,09/15] net: ftgmac100: Always register the MDIO bus when
 it exists
Thread-Topic: [net-next,v2,09/15] net: ftgmac100: Always register the MDIO bus
 when it exists
Thread-Index: AQHcigZP8DCE3uwsu0OrjMZguO4jabVbGG4AgAK0otCAA+8JgIAG94OA
Date: Thu, 29 Jan 2026 06:07:20 +0000
Message-ID:
 <SEYPR06MB5134A65B925BAC871927C9C69D9EA@SEYPR06MB5134.apcprd06.prod.outlook.com>
References: <20260116-ftgmac-cleanup-v2-9-81f41f01f2a8@aspeedtech.com>
 <20260120121407.795529-1-horms@kernel.org>
 <8ab0e121-5ffb-4dd8-afc8-11b6ce3898bb@lunn.ch>
 <SEYPR06MB513455F4FBCB9AF4F6E4CB199D97A@SEYPR06MB5134.apcprd06.prod.outlook.com>
 <e6f9ee03-91d8-4d3d-bf9b-c08ffa991c01@lunn.ch>
In-Reply-To: <e6f9ee03-91d8-4d3d-bf9b-c08ffa991c01@lunn.ch>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR06MB5134:EE_|JH0PR06MB6703:EE_
x-ms-office365-filtering-correlation-id: 4d371c45-4e2a-47e4-1258-08de5efca97c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?zZHySyA52NIMMZVIM2DANzepnlq8nwTCpohpn8DB4sNUvmy7c4zRY8bZUZ+w?=
 =?us-ascii?Q?9h+syR9x4EpdttZcGJwtULxbo+cDswhOjJ9dBze3mflX3GJhXFnaoLHyEKf3?=
 =?us-ascii?Q?+xVTXXOFYPxqXCKrh3q7zgzkuUEXz2qyV6s8OjjVumhNXM+hhGEkK2IWv9f0?=
 =?us-ascii?Q?WdHwDVwEYsfkQIibdmutlhrkDunWk14hFXULG05eyeLVVpuSspMLEELh/D8p?=
 =?us-ascii?Q?+4x8wot5Au3NxK+zC8fuFNYIGxtMbEdBWC7orArBD+Ui04pNsjS70+Oi/e9X?=
 =?us-ascii?Q?ij5yDppA11NR2NLrCXRfp4pNUNleXuq8eFl6udztaB0pyc7/BCD+PCiVgaJp?=
 =?us-ascii?Q?GYZ+8FkHrXMfie/FkCidPDVxvz8qgK60JVJCXN+fhKNqPk51N5TttLvglKZ9?=
 =?us-ascii?Q?K5l3fzWXVxurB/fRQIHHKWqzFVpQRB5u7MAR2VlMaC3L/uqgaFKdk+mnPUNW?=
 =?us-ascii?Q?lzdkN7nQ1kw3PY5NNHsIIlW/zOoOO9w2DfcaTARRRtuTp1bAySvNNpQRrzr3?=
 =?us-ascii?Q?8BSmcmzwTImZnEMD2pkNn4e9c03LblH2I7BG9xsORlifZ3hiM7/0NnwNxPqL?=
 =?us-ascii?Q?Q6rXAZOkXu6Np6ixqPPbnDEChGwCwzyDoa3xAUU8OofxMnj0KYI7laTkzNS2?=
 =?us-ascii?Q?56cnaYa+RFBskLI1gu60qmDW8RolQrvP8x4byLCSvlbPPU/etZp449QrqMAU?=
 =?us-ascii?Q?oKWWWUYKSG3QDhaDNNvBvaQBUTR+8p+pYLPpra1wl00AQ1AFfbjXQG2Fn4Nh?=
 =?us-ascii?Q?cP9eA4rkffqUk3dpcoEeE80Ckk8aoztMwCwVoKJ+RnV8m8TVgwURroAFnpU7?=
 =?us-ascii?Q?89a+qG3QIK73hqlkRpatc26yynJBOq8o0oFvAO6Qc39FZWV1JCb8ErdTId4F?=
 =?us-ascii?Q?3LGEmN3aLAMNv1JrE3/8Pnyd2oyUvXBS9G3y2h52m5fBYbbgh9gY1lmGlSLM?=
 =?us-ascii?Q?yOD6czERMjhB8+IAAMv+EFhYHxSuIMkiQpxMrJ/FvyPNRpPwYOd9Z6U7dCM8?=
 =?us-ascii?Q?YJZ1vfp6Vul4WkmbzK2zgUQ309WvqatOqRx9q9cJHAXWM3yXi/+qCah5oTKm?=
 =?us-ascii?Q?lDk507xTg0j9jdBkkJGl5bbTPdgbJCuFVAp18U2QyB1vRPGy4+KIKbiU5nwz?=
 =?us-ascii?Q?MnbifCLvJLeWjly4Vle3Db+H0ppP8U/+rwKiMol0gl3RuwpRD39xbsYBpD2j?=
 =?us-ascii?Q?0UQl8l/gs61K5z1r0uUewL8FTKdtUBSphZsDmDGtoo3FxnV4JKaCUcOhU98d?=
 =?us-ascii?Q?1YVMHjc8w+wNElHCBlJppY5aB2wPwsqGnMjnNjzurDbChI/1NmXP2HNxF56w?=
 =?us-ascii?Q?lysN/tECrjxhHo/rAtBErhFDJNR3mR8JZSyjtFq/b89Gq9pT9uA0dxStn8qt?=
 =?us-ascii?Q?zl2UNJWptqnNsls445X3VQgYFZfNJuBzrnLbusv9AkkseKB0l7HJDHXOCcOw?=
 =?us-ascii?Q?R/zOp4Om7VpFvfIEJVZGwFE7ibBmArrjFK82/Ist7LHcNhV6zgtg7tjoxVAm?=
 =?us-ascii?Q?zIxa4Vb613N/FG4AORhPXlNahjSAld+F6TV5Cvk7Fy7ByKvqzQJea+camuG0?=
 =?us-ascii?Q?OfQ7EjpM4PxazF+5yGpg56WNEUn+BOY/8guRP9tuSVAbNgW9QyIDRcThtJLO?=
 =?us-ascii?Q?2VGn068Gx/FXv9gNidsoeT8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB5134.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?hFncDUeaGKQlNmxAIvBR37W3VDvtTuFoqvh+2Wz2l3vmucxXXqI48JAkDYXf?=
 =?us-ascii?Q?3G9lWTBre7aH0LGO0mOSZzDd5sJJN6qmUy3Zeq5ZjePW6xxqP8S9QW/xTTJS?=
 =?us-ascii?Q?nM/1eZgXXSwFaXzy6UXEfzyZgwjDWeBq7NIYWHZ3sSgQ2pdowtiGnJG1qLXi?=
 =?us-ascii?Q?1rogg2vGwXVP3HdDkrAUjNE/wEprM9y5VUdLyzS+8zYtaf0NIkWvZrmsTtxl?=
 =?us-ascii?Q?+6B2H9HP0GGc8TR2sA2GfWj3y6QhLVsrmc+r8fFWzov035Ih2Lttc23RzHKt?=
 =?us-ascii?Q?76ykGY+BbLbD5UkIRq5T2XR0ja25lN3rDI5QCjGCJLo1vRY+jDKusWUBB1XH?=
 =?us-ascii?Q?1LFdzJbbsWp7NFQG53dHYq2Mgm3Cr/jW6irLiydNxDRJsfgzKpsBcEuMiP4d?=
 =?us-ascii?Q?vkFQ+fCEHiMYfZIdfCkyxK5mZwWmIwGpiNKz78AgV5cjfEwvjbYB6bTNaFJV?=
 =?us-ascii?Q?z/aM+hZ8tZnCTSCfbohxlA+M0WqII+B1CEdzZSBQcFxknMFIvKiIC63xQQ8V?=
 =?us-ascii?Q?gxuP7CAW+fiRwK6u1bAJtSzdNR6RtnqupgNG4YNGZtL9vbRlurYZT00IOLWv?=
 =?us-ascii?Q?li40W2uZyk06tvo7LklrE3iurHuuBDnJQzNT6i7wNcrQ31Qr7wvlgzTUUwfb?=
 =?us-ascii?Q?JfdOIVU5JRGV0uRF7HpooVicKhOGTnoOjd02IgE6TMxZ0l5nsZdYtpE6/r+N?=
 =?us-ascii?Q?gR0REtujNXT7R4YL/rpMRSGZcWXRQmHZyCXKv4ACdH4BQ1npmyS2ELn6BwXb?=
 =?us-ascii?Q?WE/c9A7GlZz68xKbmWcCpwY73DW9H7bA+BGO8xHv5WpjiTeTJvvJu+RvICew?=
 =?us-ascii?Q?qCfCKyuIVDMVDnenITskdIZrwnkhvn7g1NrA32ObG61PngbiyxHzcvHfJois?=
 =?us-ascii?Q?Lcob0LsTqY5MUCdexyoWPUyZe0qKtNNPMFCgsthAZLIgAjIk7klIbNBepYHp?=
 =?us-ascii?Q?XTwVJS1zW+/Hos1CEomFzplXtZ5sAmLPqumJR+WR6JiGEIBpG9egfuaeYMZh?=
 =?us-ascii?Q?bmuExWadKmGUmjgRrR6TPxXFaWUpFhm5A4z+0YafYLu7TAeTImK72dLjlN49?=
 =?us-ascii?Q?TTQA/tKXAfXrbK+jXh69akCAp5t1viQO9bWHNNInVZOlrrhMjNi9/3WC1+KH?=
 =?us-ascii?Q?CcsuiFCGVOmdtuRwmwv8oVFMWnEhuFr4VUxXzZInvI56GShb12/XdqNRjBRc?=
 =?us-ascii?Q?2qWrCpPbbdPgarNjDwRyhbt9tt8Z0BBetkPqVSu+j1JENShSKNmGyoZETTtD?=
 =?us-ascii?Q?hcfU1Qokn0Cx0731LgjFhjC7xpfj98n0w2u3a/+J7xxmAdndToow6ORmYfHx?=
 =?us-ascii?Q?Fi1aU6/HtjZuzaJLSeJ0wIDtsrBUdZw3bapWCj16bj8vP8xgrA9eXMC7A8lA?=
 =?us-ascii?Q?i17dM/gzejTdzjbQ/LnPMjrzr64b6hNefqEqUGXzx5V0tEWWmnA2hQedaBOG?=
 =?us-ascii?Q?ZRsF7/4yCgpKKKaksmLci4H6ZVPtVUHIKUeZo0HH4eU12RmQpqXn3dGBi3eD?=
 =?us-ascii?Q?REaoSqEuuTq6HiZ4Dm9BPcC/9xyOSj/e0iyLVVxh3A1WHE5JtJKl8PLn78SF?=
 =?us-ascii?Q?4S6ud6mDLZbRk9RaHeRdVxXdVHzHHYnX4yHKWrQ6OlZHK0/qoRx8bJm/XbFE?=
 =?us-ascii?Q?xpG619Kn8yB5VbQUcsMcXhcW+2kyLrB/8KzZmKDraskPJ/GoeLQVwZKE8anA?=
 =?us-ascii?Q?hUzrq9hc+OF2aiTTNd3cQg+1Z0HcmhUu8eb7JpCLEoOyxuDUkad0bU7zMtxi?=
 =?us-ascii?Q?L3t0xRvzPg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB5134.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d371c45-4e2a-47e4-1258-08de5efca97c
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2026 06:07:20.1401
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RtTfw8bnoZIs0BQo2iWqjFuj6QjCJQPzVDuQffZ0yvXKo12hN3koM763UKFeELGIvGAnRK6ddaKSTCCV10PUU9DrkMuo5WSnZ0EDuJhiiTc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6703
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[aspeedtech.com,quarantine];
	R_DKIM_ALLOW(-0.20)[aspeedtech.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254582-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[aspeedtech.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacky_chou@aspeedtech.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,SEYPR06MB5134.apcprd06.prod.outlook.com:mid]
X-Rspamd-Queue-Id: 65726AC250
X-Rspamd-Action: no action

> > > > > +	if (priv->mac_id =3D=3D FTGMAC100_FARADAY ||
> > > > > +	    priv->mac_id =3D=3D FTGMAC100_AST2400 ||
> > > > > +	    priv->mac_id =3D=3D FTGMAC100_AST2500) {
> > > > > +		err =3D ftgmac100_setup_mdio(netdev);
> > > > > +		if (err)
> > > > > +			goto err_phy_connect;
> > > > > +	}
> > > >
> > > > If ftgmac100_setup_mdio() fails after of_mdiobus_register()
> > > > returns an error, it calls mdiobus_free(priv->mii_bus) but does
> > > > not set
> > > > priv->mii_bus to NULL. The goto err_phy_connect then leads to
> > > > ftgmac100_destroy_mdio() which checks if (!priv->mii_bus) but
> > > > finds a dangling pointer, resulting in mdiobus_unregister() on
> > > > freed memory
> > > followed by a double free.
>=20
> I took another look at this. The goto err_phy_connect is wrong.  At this =
point,
> if there is an error nothing else needs cleaning up, so the goto should b=
e
> replaced with a return err;
>=20

Agreed.
When ftgmac100_setup_mdio() fails, the MDIO bus is not registered and the
probe function returns an error immediately.

> It is not however the full solution. If ftgmac100_probe_ncsi() fails, it =
jumps to
> err_setup_mdio, which currently just does a return, leaking the mdiobus. =
The
> ftgmac100_destroy_mdio() call needs moving after the err_setup_mdio: labe=
l.
>=20

In NC-SI mode, MDIO is not required.
Therefore, always registering the MDIO bus is redundant when the interface
operates in NC-SI mode.

Perhaps the adjustments in this patch could be moved to follow
"net: ftgmac100: Move DT probe into a helper".
And add to this location in ftgmac100_probe_dt() like below.

static int ftgmac100_probe_dt(struct net_device *netdev,
			      struct platform_device *pdev,
			      struct ftgmac100 *priv,
			      struct device_node *np)
{
	struct phy_device *phy;
	int err;

	if (of_get_property(np, "use-ncsi", NULL))
		return ftgmac100_probe_ncsi(netdev, priv, pdev);


=3D=3D=3D=3D=3D=3D=3D=3D > Add here
    if (priv->mac_id =3D=3D FTGMAC100_FARADAY ||
	    priv->mac_id =3D=3D FTGMAC100_AST2400 ||
	    priv->mac_id =3D=3D FTGMAC100_AST2500) {
		err =3D ftgmac100_setup_mdio(netdev);
		if (err)
			return err;
	}
=3D=3D=3D=3D=3D=3D=3D=3D

	if (of_phy_is_fixed_link(np) ||
	    of_get_property(np, "phy-handle", NULL)) {
		/* Support "mdio"/"phy" child nodes for ast2400/2500
		 * with an embedded MDIO controller. Automatically
		 * scan the DTS for available PHYs and register
		 * them. 2600 has an independent MDIO controller, not
		 * part of the MAC.
		 */
		phy =3D of_phy_get_and_connect(priv->netdev, np,
					     &ftgmac100_adjust_link);
		if (!phy) {
			dev_err(&pdev->dev, "Failed to connect to phy\n");
			return -EINVAL;
		}

		/* Indicate that we support PAUSE frames (see comment in
		 * Documentation/networking/phy.rst)
		 */
		phy_support_asym_pause(phy);

		/* Display what we found */
		phy_attached_info(phy);
		return 0;
	}
....
}

Thanks,
Jacky


