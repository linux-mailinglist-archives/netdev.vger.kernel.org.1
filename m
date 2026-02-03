Return-Path: <netdev+bounces-256129-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +HaUASuGgWmzGwMAu9opvQ
	(envelope-from <netdev+bounces-256129-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 06:22:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A64FED49B6
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 06:22:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 14B153010780
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 05:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5817836604A;
	Tue,  3 Feb 2026 05:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="gHwGgyF1"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013065.outbound.protection.outlook.com [52.101.72.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E8B3570C1;
	Tue,  3 Feb 2026 05:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770096151; cv=fail; b=tWtnlRci2DoKXi1G+KtjSFZcikoSutgH3sxNE3E/ltuZqzXlxxhx9z+O0dH34ZUB4MBzpcnYxIjC4x7o3qLK+MGY8eptXKGwsRS2h/gADdmXzKQkudrV5esnuXdZMfRQ5hYzdYx2ZMjNzxLvKfCVOP8A4wGrZyMxv+5tqIgdWZo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770096151; c=relaxed/simple;
	bh=+FI2c+V0tYja//tX8lopvOZsJRTg7EwIyVpmjXVeeFg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dxCF9YgHaELRXyqKX0W886HExO5YYbEof/yKRVXnkfwENXHRsS8Ao+apa1s5t2QzIxeAUtM7iKzA9AnMfMw7SEvpC8+iD/h1+UgsQxtxCqqYSmTvivdkoRLCGXpfQy8Q8+FQpmmfMV/KRm4CL+1+R8QofliKTGXuHIAhT+1Wb5Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=gHwGgyF1; arc=fail smtp.client-ip=52.101.72.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H9slDg98hKn4lDgRTM9xrIRzB5A9RAxGj1yK53+mjOYam7+Fp1Ca9H+iRxqZt/hlJdgEITjn8lGsGLu7KPAI6Et4LvdfsvDwC8pfX3FzIoSRLpkVE40/BZNvKvWwlr4AoT94UgChQvyd7ShFjH1upcK/16NEC/dVvn/N8UrziZO/6E2t2SeM3RWh1frTYKSWLOryEP/ak9SpBerhLCeSw80cinXS1I+AvGI8CTRIK0dsXfTcplx+ccc/NE8s32NZCRaOkq3TZ3/+XrIrKnwoGzqNht5JseNGQc8GngyejSVjr5f/cwLk+Zx/OprJQTbatpE+MDTNy+Kb9kQa9Wi4zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xjIQafaFCqUBwxjoVs7S0Di5YfvMO/xXu531O9Znxyw=;
 b=mQ+vlsRAnBsw+Irny+fMNz3ky1oELWBEQP5vDlHkvG3X1+KgILO5RFZ06U05JOeZX5VFRNWLBgB+QDHwe4tu2Fb/oksF/5lYvh/9ZdbYY2pWtee3h+56yBNzFcO+tdpfKI9BFdd5CAZDEhH2VEZjN5vK3naN3N2XhDgPYfOoko6q1HjMXsT3wgJcT+EG5sME4v3VJbHBFkKk4U2BzEGawY7DItqHGn2M6zgfLiBoUZKWqd63Wo6e/UwtYYLgBqGZEnFfUp22HKCXG4Hf8UiQGbm7thOZCO7VwsIhtzsnTgJGn9OmDMk1SX+NPCRnCu4UFTz/p0DOXZKt/6wr82AtWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xjIQafaFCqUBwxjoVs7S0Di5YfvMO/xXu531O9Znxyw=;
 b=gHwGgyF1aBFm+wqyQ8i3YdUTTxcpu2L6MULiJfC5KMgZoGY/fmWohu5RAgfU+j+vNrcVzXxxuLzoTzCO2qIC/bRhKCFumc08vbYwlj/xcnmsTPwZzY8KHhXik0lWZ5dNaPQf6OWxiNTV4ORo1yP07rTg3C0hpMTuhK+hCVCEq1o2VPRz0t0ed0BSOzGferq2tay56P1CofJbCxogJq1ub5rpCkF9IbKUIXn3xTvyDyic8VpGUkVfptvXpDEQl2a8iHLePfOf4QzgyAXuoyQiDdFXQMuI4sBTqRgpfyOC/CqW1UDFATfJU0Q54kiEUz+e6rO5NabY4rwPtTtU5vo/6Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AM7PR04MB7141.eurprd04.prod.outlook.com (2603:10a6:20b:11d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 05:22:25 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694%3]) with mapi id 15.20.9564.008; Tue, 3 Feb 2026
 05:22:25 +0000
From: Wei Fang <wei.fang@nxp.com>
To: shenwei.wang@nxp.com,
	xiaoning.wang@nxp.com,
	frank.li@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	bpf@vger.kernel.org
Subject: [PATCH v6 net-next 02/15] net: fec: add fec_rx_error_check() to check RX errors
Date: Tue,  3 Feb 2026 13:23:16 +0800
Message-Id: <20260203052329.1085444-3-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260203052329.1085444-1-wei.fang@nxp.com>
References: <20260203052329.1085444-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0191.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::6) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|AM7PR04MB7141:EE_
X-MS-Office365-Filtering-Correlation-Id: 29608043-9264-45ff-c5ab-08de62e436dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|52116014|19092799006|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RfqwrjqXUG8Nou0K6S4GgBn3Fumm71+jjRCMn2GYQkUzHjQcsF9GeABYk7lT?=
 =?us-ascii?Q?gYNPaJIhdXGrhRB4wGv+PMnWo2DRchDDosRW113wWhJ4EwL+CGt/xq5a69ib?=
 =?us-ascii?Q?lp+e4B8KsaqNXOjLVQH8Z4n21tkkzH98gs+FSURR84gfjRyX/NEVVMkOAC6T?=
 =?us-ascii?Q?A3l3h1P6tNhdCmjQ3UfuLBb836hjHe3IaAjmJlMXi67Yi3TwzWPH8sQI6MuF?=
 =?us-ascii?Q?DTmwqVMEC2v8LEz2gmbO04utjt/r9IegS6PFI4SBwBOaKmsNqi1Wx44XVWAR?=
 =?us-ascii?Q?MIbejrryVumRJ4jB82UYqysmR1l6so7UCxrgjOZ1zliX1LCXwO0QMj7IlF7q?=
 =?us-ascii?Q?9/wYeaL+qXUlt3kfZFuRgAYiVI/30roaAi/vaQxprblkyNWskSL1HOZXlarV?=
 =?us-ascii?Q?z0fxmnkYxJ9/tAUQvYsZ9UCStC8flYob2Zcp+/pFyQ6kMH+cWAapQZW3O/Aa?=
 =?us-ascii?Q?8FdOTVb5a+0t+fYFYhvLilXvVo+BBxLaHr4SCfNhnOFXH90px6Xw+c9xrwDV?=
 =?us-ascii?Q?WA2hgYEwGZPUU3mei9lR1zFSxQj/WIpWiO7g6hdCpZhLg7jm1qjHnCO14RdI?=
 =?us-ascii?Q?Wf7yOSGSHW/+lKqulM16+6II+4I6AUQp6RVLptTjkNxmgm/w4+ZXXVG4tKUy?=
 =?us-ascii?Q?opVkfpHmHnA8lsAHVGVIicxJUs7CrzHHzLWEWqRUlh3kvj0WA/9dXuDYRFzr?=
 =?us-ascii?Q?mkF2uCorlmR3zOEiVrv0dYJvqrIJY3O2dGDcv1tgE/rWf9BMmcQYbu3MUsPU?=
 =?us-ascii?Q?fZAd2yVCpGskvpthK7i8LcvbLpUrJYQT3UitC83Q6VHIjJbrjkMmv5oulTFu?=
 =?us-ascii?Q?Odk1B4a4qski1pA6loW+SCEnMtXWJ1g5pqrigj4hB6Sg8stxUkuuEm0Ctif3?=
 =?us-ascii?Q?e/wwtns0xRDLy5D0dl6WixuAwZuiBIQzWlVbjhawP6ZsIhjOp8aKVgrMI5om?=
 =?us-ascii?Q?X7HleicXPRe0FL9okAo8S1NNEcrhA9W61A+1ut9hjjhs2G0mz/dQM+01DD8b?=
 =?us-ascii?Q?bf56drxVSOb3v3A/W0sjztPufhCfaTXqx32r21fctfgCqBAnzpdj8nzxl/uW?=
 =?us-ascii?Q?Rcaz/sqbr2RSYRumJMsKJMK+/xNfsjKEqwND15dy02kdsVAorYH7nwutkY2k?=
 =?us-ascii?Q?veseMnJispexGFotPMacJdzv8/K+ujxBWujo2FchkOgBpuHPZS4A3DbRiQg/?=
 =?us-ascii?Q?mx4TjsymPkNkiNXIJyvCdw9kayDZPB350ffIz0el2iiZeZnujsASSxwMBpt3?=
 =?us-ascii?Q?jOu7N98nClfUEzr8lmAYtTiujx3e+R80b0847DqPqOFk8UMat/U7oqbkNohh?=
 =?us-ascii?Q?aqM1gr40wPDlRC65nhEeb5GXLP4i9Q1DAPi5FDiARB+K6cFJZ2En5yxYhXWX?=
 =?us-ascii?Q?4YflTMtk8fbN97BBor9ZX6RpDF8MUJSjkkpvcrImrrMlxWtv0EYjLARygldP?=
 =?us-ascii?Q?8xx+T2/iPdqK5jffAhPESMSuLKJBNom+y+xvlhcf1bm4Z5XR6WGFZMjc1N8/?=
 =?us-ascii?Q?uHunuLPzFnXl5BjwtX1Vr7h3TgIcTTjdIFMhiSGsPzowM6xC6+LQhBCxq3Gl?=
 =?us-ascii?Q?iHlhrL3tTC8N8Y0j7z3d/1g9mcJHekjAIsU+akUkyoWsccBIS8DsWEIpEjMo?=
 =?us-ascii?Q?e6U9qyZnQM9Z4NP0iK5+Wyndg5SE+JkT3jyQCeN9iS63?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(52116014)(19092799006)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4esx45p0sDHvTwwoHU5+vR7qK3sjeJVyI/1P8PhSqDyvwxCOLiLILXUCBCsX?=
 =?us-ascii?Q?3vnJWW7a5EF5yzGP3Tijni2c4L9k4G3hWVAz/KqHglETy97Zttc2AGbav4HH?=
 =?us-ascii?Q?dGMc4S+og0RTY4O1wbLgXRTd6SjrnR4BB2Hks9Zkbd1Cc9kVPIR61fpI6x7L?=
 =?us-ascii?Q?vkoVwRRvfJogycuFD5NSQmx+NUgrJEC3HOzMPjDyrMm3TQfraEDzDRXY50PK?=
 =?us-ascii?Q?psELZgIwHLrXV5BDnkjWKBy225FEELH8VnfDz0e3TsNyFAm9xnLqqk99M3GY?=
 =?us-ascii?Q?NY7D8uc30IQbS8TjkcaHOl9wnUwav/jW31pXKYKHCRoG68XaounjWLQM3+xK?=
 =?us-ascii?Q?Gm0Tb4HgLl24w9dLRee9iXDR6tDJKvgas3hb5aGAgq7SL7mneJ4i4CeKaT71?=
 =?us-ascii?Q?pqizA82+me/R+jjO9yr6QPOG+WIQWJSU2DYv8YfRjJCKF5fKDi7/sp2EL5/c?=
 =?us-ascii?Q?AzzomaUezhvRbt7MG47J84ZoFUmYSIFMBagdsy3lIHTQywU5qo9e6v4ZlRNr?=
 =?us-ascii?Q?dU6h1T2w7lNJ/B9eCRvkrdgn+7wDsJxusp875KCdOKXB+2kM3DhM9Yvm+oEU?=
 =?us-ascii?Q?I/6igpquitvTbWA+grNdxwWcg/tmgPlFGd1cbVuh5lGBYRAUlVpKlLWgvOAr?=
 =?us-ascii?Q?umh3JwAHOcl0p4bI+amLHwYD+i3c+589rqTVso4hwt4b30hO1dw8D47ZHrBn?=
 =?us-ascii?Q?iltfH2V/MGhbX2sUVTi5h2fTbhOE8jylQUS/FBdp0S9twMwLrZveX8NAAwbZ?=
 =?us-ascii?Q?LdnHPDyLcyGlw6BGX1lShenNQFWSwB6PWLye+FpqNIDcLAHbQRPq929NSm44?=
 =?us-ascii?Q?6FmSjnXLN7FlDpq78m2e0Lqj4johhJi7BllLRIpal1SbJCESS6oPyROYAs63?=
 =?us-ascii?Q?PvxZ8Df1R/wkdkyR8m+A/FAjaxqeZD83FTJP3jD7oL0Iq0mahtEl9PZqC9Gt?=
 =?us-ascii?Q?chxH9Nw0ims7KvSgGB9SBKlZgTE776iCmqR9hg3wklYJDEKYb/8C99R7ntwL?=
 =?us-ascii?Q?Bj9vRsb7+Grm190XTE9VhaqkruBVBVZLeB65hE2iJdxwaquE4K9P7FUBUevL?=
 =?us-ascii?Q?B22HvesXPG1XlA3uSTKm5ducT9e1WGW2mgIgRaNybF/XA+e0Wh+oktdQmKzi?=
 =?us-ascii?Q?gOvWYxKCCUmcgFfrA8iHvXJ4K/N0lfPkzE36hnirXt5h0Nde3cryKaMQmR8e?=
 =?us-ascii?Q?NnBrWQ5lNxnhtYaqou0CGVlHut52UnI3mPqFRmouv8y0GYHNHXk7CU30nrE0?=
 =?us-ascii?Q?HGjH5sNh00eTAwUxzoszp4zA+y4QPiDvQge7S0l7VkEre+UNcJh0DDZ/9DWI?=
 =?us-ascii?Q?YR8a06N9Axrjwqt7QEj5culhVSrbMw/FWim5Vt+bwgUiBxKbv+5WB2Q7++e6?=
 =?us-ascii?Q?o7HCVOt8W/UpV0JhIX/ijGBiNkAU30yDiVp5AYOfrcFd1d1kWL9M9+oSIZBC?=
 =?us-ascii?Q?dK4eAka7VV2j+iQuq7ItQsTehG7E+K6p1Fjh0ql5RF+ssOT0JvefJnsqge9X?=
 =?us-ascii?Q?OJ5Q+Amw5/jkCMlbXBsZafALUrYU4E/gYYuIfb0hKLBkyCtVsjCM1TtrOuNP?=
 =?us-ascii?Q?jTMXbOhxT93qU2hoB+prvjJps535kYvu34/qicDwcL3XrmZ/xnzuHZ193W++?=
 =?us-ascii?Q?N3a6VWdzzNteqGBHA5kcwBMb95rMARsgnWjThCp10cSd1aJv1Budh0UsENzv?=
 =?us-ascii?Q?voNLOzCfIPLDbbzXgQUEMDEJIXSzrgYD9rN7p4TiuWPYZd/T?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29608043-9264-45ff-c5ab-08de62e436dd
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 05:22:25.1555
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fp/Wvx87n2M9hWwVpy+RWycDW3TglsSZnofNbqfiv1t6HSR6R6MuwXB1APNbkeOWuS01b8CN7p1n41DM1POhRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7141
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256129-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:dkim,nxp.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A64FED49B6
X-Rspamd-Action: no action

Extract fec_rx_error_check() from fec_enet_rx_queue(), this helper is
used to check RX errors. And it will be used in XDP and XDP zero copy
paths in subsequent patches.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 58 ++++++++++++++---------
 1 file changed, 36 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index ce433af02ad2..ee4a20d8c438 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1747,6 +1747,41 @@ static void fec_enet_rx_vlan(const struct net_device *ndev, struct sk_buff *skb)
 	}
 }
 
+static int fec_rx_error_check(struct net_device *ndev, u16 status)
+{
+	if (status & (BD_ENET_RX_LG | BD_ENET_RX_SH | BD_ENET_RX_NO |
+		      BD_ENET_RX_CR | BD_ENET_RX_OV | BD_ENET_RX_LAST |
+		      BD_ENET_RX_CL)) {
+		ndev->stats.rx_errors++;
+
+		if (status & BD_ENET_RX_OV) {
+			/* FIFO overrun */
+			ndev->stats.rx_fifo_errors++;
+			return -EIO;
+		}
+
+		if (status & (BD_ENET_RX_LG | BD_ENET_RX_SH |
+			      BD_ENET_RX_LAST)) {
+			/* Frame too long or too short. */
+			ndev->stats.rx_length_errors++;
+			if ((status & BD_ENET_RX_LAST) && net_ratelimit())
+				netdev_err(ndev, "rcv is not +last\n");
+		}
+
+		/* CRC Error */
+		if (status & BD_ENET_RX_CR)
+			ndev->stats.rx_crc_errors++;
+
+		/* Report late collisions as a frame error. */
+		if (status & (BD_ENET_RX_NO | BD_ENET_RX_CL))
+			ndev->stats.rx_frame_errors++;
+
+		return -EIO;
+	}
+
+	return 0;
+}
+
 /* During a receive, the bd_rx.cur points to the current incoming buffer.
  * When we update through the ring, if the next incoming buffer has
  * not been given to the system, we just set the empty indicator,
@@ -1807,29 +1842,8 @@ fec_enet_rx_queue(struct net_device *ndev, u16 queue_id, int budget)
 
 		/* Check for errors. */
 		status ^= BD_ENET_RX_LAST;
-		if (status & (BD_ENET_RX_LG | BD_ENET_RX_SH | BD_ENET_RX_NO |
-			   BD_ENET_RX_CR | BD_ENET_RX_OV | BD_ENET_RX_LAST |
-			   BD_ENET_RX_CL)) {
-			ndev->stats.rx_errors++;
-			if (status & BD_ENET_RX_OV) {
-				/* FIFO overrun */
-				ndev->stats.rx_fifo_errors++;
-				goto rx_processing_done;
-			}
-			if (status & (BD_ENET_RX_LG | BD_ENET_RX_SH
-						| BD_ENET_RX_LAST)) {
-				/* Frame too long or too short. */
-				ndev->stats.rx_length_errors++;
-				if (status & BD_ENET_RX_LAST)
-					netdev_err(ndev, "rcv is not +last\n");
-			}
-			if (status & BD_ENET_RX_CR)	/* CRC Error */
-				ndev->stats.rx_crc_errors++;
-			/* Report late collisions as a frame error. */
-			if (status & (BD_ENET_RX_NO | BD_ENET_RX_CL))
-				ndev->stats.rx_frame_errors++;
+		if (unlikely(fec_rx_error_check(ndev, status)))
 			goto rx_processing_done;
-		}
 
 		/* Process the incoming frame. */
 		ndev->stats.rx_packets++;
-- 
2.34.1


