Return-Path: <netdev+bounces-129289-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B178A97EB4B
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 14:07:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29E46B21B32
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 12:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F64D197A6B;
	Mon, 23 Sep 2024 12:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b="kQxEsHGc"
X-Original-To: netdev@vger.kernel.org
Received: from dispatch1-eu1.ppe-hosted.com (dispatch1-eu1.ppe-hosted.com [185.183.29.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60D3195803
	for <netdev@vger.kernel.org>; Mon, 23 Sep 2024 12:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.29.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727093218; cv=fail; b=FVYKsbABQ7btkhd5JmXF15VoNwFzHncR8Znsp9IOYC3ZQGsNZrOcZy3LZqZ7hSpdpyowNW9DprEVqzmOcH/FDszzqPzLQ0L25GM/FwPRnEmwzbeOM0NYRPFclBsXXi/MZ/3P+sK92hH3rO/KX+nuLXGu/RjfOgxPXsbCq2Qjsmk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727093218; c=relaxed/simple;
	bh=Udy5sDfZ2zAmpt98W3cXiRK3CfURR1GKZpJBJ929Crg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=i5HxQqYtJ4ODo5qXfBO3mRxag8wRlsVuGujl2EARmUAIP+ZjdmXwm6kJ1f80zSX+dgc3oPB+AkLqjqubUIJ798hSL1PJfP+ELAk8u/OT2XSIA4kFdod4VpTi0I2tRKSTME5bF5HAlSMsJiyShVbcxYaxAbC/mfOkNdM6LUSoiYU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com; spf=pass smtp.mailfrom=drivenets.com; dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b=kQxEsHGc; arc=fail smtp.client-ip=185.183.29.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drivenets.com
Received: from dispatch1-eu1.ppe-hosted.com (ip6-localhost [127.0.0.1])
	by dispatch1-eu1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 7BE5034125F
	for <netdev@vger.kernel.org>; Mon, 23 Sep 2024 12:00:18 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03lp2233.outbound.protection.outlook.com [104.47.51.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1-eu1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 9DB071C0071;
	Mon, 23 Sep 2024 12:00:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RE34pcZjfWnYxAEtN04FkyM05Ccdj/FHedLzl1sM+ojmJjrzMYdYqga9YhV974Vs/uaL64gzhNEvx2GO1gvsNDMp8nfJU/Ompc+DKo5eFALnZLxSVO7EmebmyVu8ATh/4i7Tr2Hvv2IhwzMzmzu8Qn45WWjzfJ0dUKv+YqtVzhwt1p6VMTejUrCBfosnrtWd2T/8N2ev3ycAxyVn4JDtkUEN9byLjEn0f+L2b7ucJAFCOOs57RUunt4vN4G+S4pqeclpW+M4FrACsW152LH2wh+LAmx7cixAVrf+7hl4RTzlPHNPFvkVr/dgIr8iCAqVPug0j6Sns8re98e9z9G2Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Udy5sDfZ2zAmpt98W3cXiRK3CfURR1GKZpJBJ929Crg=;
 b=X/r/XaIw4dfAZgAupimTsDIYVTpbGJr59Z2GhQCwpRgaAxU294auyPHPh23FJiMhD17E/lpuQK3ksrmg00CN5tytny/R2B7eE4gXfdFeJ0omal5tBhtMmc47sZuL55kTTDDtgcpluuSAJUqfn0/yuEksnbqskqPffBNsSyPCj0XosPiCOV0bnLZmD8nQP5iAJopWDH9SDrTy0NQH7Kj0IhYWaBpzJ8cyL3riwgmCb4haPgSehh+fnJleK/MTy46JkfVE7sFFypydjAAEXpTm9HfC5VM0r02iggTYwpdwLYUOxbNZJGnAIm1WHoqpp2NeniktWn8oR7mUReTT8jlrqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=drivenets.com; dmarc=pass action=none
 header.from=drivenets.com; dkim=pass header.d=drivenets.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=drivenets.onmicrosoft.com; s=selector2-drivenets-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Udy5sDfZ2zAmpt98W3cXiRK3CfURR1GKZpJBJ929Crg=;
 b=kQxEsHGcmgzlydOdQdvOQu34Ww+nmkPIK4xY1TynZmHZbPIlWlPdyUuWmUhJ4zEXZe2ku9z5Koz9pmfic1zI3vFKKKx92OLAR8emRnKltPD9jsfwTU3S5sv+P83aYPj+0yljc3erXMxE8ODy6PkFjV25qmIuaUScZePWZ8OUef4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=drivenets.com;
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com (2603:10a6:10:11c::7)
 by AS2PR08MB8670.eurprd08.prod.outlook.com (2603:10a6:20b:55d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.13; Mon, 23 Sep
 2024 12:00:04 +0000
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com
 ([fe80::29dd:6773:4977:dc4e]) by DB8PR08MB5388.eurprd08.prod.outlook.com
 ([fe80::29dd:6773:4977:dc4e%5]) with mapi id 15.20.8005.010; Mon, 23 Sep 2024
 12:00:03 +0000
From: gnaaman@drivenets.com
To: eric.dumazet@gmail.com
Cc: gnaaman@drivenets.com,
	netdev@vger.kernel.org
Subject: Re: Adding net_device->neighbours pointers
Date: Mon, 23 Sep 2024 11:59:54 +0000
Message-ID: <20240923115954.2188337-1-gnaaman@drivenets.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <adcec26e-7e08-41a0-afa6-943ab3c5a43e@gmail.com>
References: <adcec26e-7e08-41a0-afa6-943ab3c5a43e@gmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL0P290CA0002.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::10) To DB8PR08MB5388.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR08MB5388:EE_|AS2PR08MB8670:EE_
X-MS-Office365-Filtering-Correlation-Id: d3099391-5b44-43ed-be5f-08dcdbc74235
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2wDxQfcgDJ1GoXGzLf0UtlNHN6dlQGO4N2liEePg2/51QalQCsUbcZvTYJrK?=
 =?us-ascii?Q?Yo5d+APLXeFubYtcZeNkhSM9rI+HoFbmos0LFwU396hwFsUw+AdLhbN1xt/H?=
 =?us-ascii?Q?vTa6X3qIL7OmKi3LmtvNM5flXxZJntZuqi4b1Qe9qxj9KyMT4+05cH1UoTjV?=
 =?us-ascii?Q?7uL+GF3HWEqXuhXEROKJKFAXAGhorGexFqyKQTbsQu5W1N1bcoDURoJUWCdX?=
 =?us-ascii?Q?IaMMxZm6hEWFp+wLKuehueImX/N2RS0pQZ3jX/BGUXWl1pINAod4spP10E6X?=
 =?us-ascii?Q?kq7jdvNFsSGFMZ8MhPUYeEEW4CXVLri9ORZ+y6a0F2kQAU94K8vY5A9QY36/?=
 =?us-ascii?Q?iH4zN+0o01Sl1NyTczpZ3O+L7byuAKZNEmoxYYw6nwly125EXyWOx9nFuqhs?=
 =?us-ascii?Q?6pPIQnHY7q0ohvmPE2k84MRlfTtlXF6VavS0APgthJoGzapQv0FqO5QSyxBo?=
 =?us-ascii?Q?j3FBLhPbkf0hA+v9iQqavA1Whphte+D1cbSjKqTJBlKtTfesJm3hA1veFCjq?=
 =?us-ascii?Q?VvyNieS8M99EKnKmFlmNvKqBPZ4E/+eCaWcTUthFFadvco+wwEkZTGGDiyAp?=
 =?us-ascii?Q?RzkoRbr6xpn8Cq4sRcmkfmZspz3V6P6ra/VAyyiOHAoKu1jSyBXyKVeiBuHl?=
 =?us-ascii?Q?9K8wOUjfDZOADRUAJ8LfEydTU9Gb6A0cQ58r6ULT9aipTt8tpytxY48BZiq7?=
 =?us-ascii?Q?Z2FdXgiQLE1Xqwko0LSOD9b6ybf1g4IfHPrEvIMdKEKpKqPYd8hyviXS5HU4?=
 =?us-ascii?Q?4H2exO2/nNvUWpWyc0qQ1xXSJbJR5095ij+EAAI2wLD3ZobdvjPdoM6xNek8?=
 =?us-ascii?Q?dz+9m7kx7Q7bG2J9ezp5906vBgo9e6pP6SSYSlNtIWp8Z4draO0V+j6HCHmk?=
 =?us-ascii?Q?NZo/yvx96RZ1CI3OcCB9qk9ZLqt5DRovrCQc2q7D78JCVHiGMC2IhrzwfGCQ?=
 =?us-ascii?Q?f9u83MXtWbh5JFfsZSA+y4IqU98vt4bQgF+r4ELen19UkIVJzQlP60C738hr?=
 =?us-ascii?Q?3+Lb0D7BoFS1KvjcaJXVQUuXK97480nDqnMWMoNZBcAqZK4OhgUVLK5PCySR?=
 =?us-ascii?Q?jlXcrnQ3WL7izH6grpZmRuPrYrMvAeopyrHrYuRpwvNcV30aSP2slnIiRltw?=
 =?us-ascii?Q?mgGXRLpQMcDW/8l6gwLcumyNKtX7wdHGYIke7O+6XGGKZovvjnZBB/gFNS32?=
 =?us-ascii?Q?RIR0TN3/l0n/jofe8S5WOCtsUiO50cbU6snbOqErzExR0L3TEh5TifUxjDHm?=
 =?us-ascii?Q?psgMkm804jP/AjnoNmtK1GGeGh3v2CfG5fVEC5vXdT4/AihT9K/pKfcTHONc?=
 =?us-ascii?Q?cy5mJMsZ9wpX9T15LEqMSHZmz3zpqOJ/3cMabb46BJ+mNA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR08MB5388.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PuyZo4shvXFE3rDXZFSvO5TbVpLyNXuys76Eqf7p062YaLUpHYaCH5AsCfXK?=
 =?us-ascii?Q?3zl3NZg2dVd1NsoPjTrIe9J3La52RkyvjRba9UElHkeAPLNJp8Dd9UMbnm9W?=
 =?us-ascii?Q?8wMygmaRZ7yHS3IR50J23amie6oj079ArsTPPNlXGrN+WehOEMaWZLDr/4Dw?=
 =?us-ascii?Q?GtETUYUNQRiim9mW15sqizYnn/pp798qrz11fk7vkubMB3nSyoRsDOk6kFTe?=
 =?us-ascii?Q?RukNKhk2ywVLFmKhw2gqcK57tfDv4RBkhMqXqt/v0OpN0aIv2z9nUeiBX6Fq?=
 =?us-ascii?Q?XPZTgQ+NbQUT9pW5m+xGnzaRAZdVu4/KNJwNujOmqhKLsJFkL8kV198LBH+l?=
 =?us-ascii?Q?+Pqe97QxhSyv25vtrvZY3KZ+Kf381x9j4KcaqgYrxo6oITebNeoRJf6QUtxF?=
 =?us-ascii?Q?Sv0oe78Fb3kXFud18W9VAMdjAmqI3CAuY6ASj0bLcjei88J6zddGWd9lNu9b?=
 =?us-ascii?Q?4KqgqPVGgh6iBpGEmbR7sb/Wck4X+6Mo8mz1Cey/jianWetrmWOo5kBf5R3q?=
 =?us-ascii?Q?FqQ7UogUzW7EUaQ4rRNKNhYnv6mfxtBsQjjSR5c4hWw0jzeba8A9tNPNh0JG?=
 =?us-ascii?Q?jvw1u+e/ElchMJc2ZO/SedlG3pw6f3IR63tLuuachcTf1OK8yg+GQ8t3sv92?=
 =?us-ascii?Q?7QZ9vvO8nDSZVrjYmiS4DNE8DHjvDeDzZn3oobGFM+kyNAV6BhgJXtXWCmn8?=
 =?us-ascii?Q?Z4uLSp5YtqtH2w5DFXphi3QMXJ6P5fS6xVPFM6zZ5NIKQ84asJ9VcIBErInW?=
 =?us-ascii?Q?+zwPdrvcBcgBU6ZvIauGOBZYUePoE5DcBlLKq5FO9lkBpqT11NPATIs4rutY?=
 =?us-ascii?Q?VdVTxhuTrjAMxFn5f2VGa4UWdstgtlhzfTKueWRw29MyR+GQAvk87vB4WAo2?=
 =?us-ascii?Q?FjUvSK3QMzES/WPwwKTO/gBwCPA40I7yT8lhA38C7aE8tBYJ3Y/AoBFgsYWh?=
 =?us-ascii?Q?4RP+USTQYj9RLySxUt68HuPiX+JrEYbThw1ef/yykVGHmzFMTBDd7euk4T0x?=
 =?us-ascii?Q?3MdLYDipxyW8HkubZTPDXuF6759EGj7IXyNaXS6igw75ly+CNrLti+0jKjtC?=
 =?us-ascii?Q?8mkQjL2g5VgaVjEuklm+KCbbmQGHchn2wDgypZUQEHHfY/MUCf+52lSHyrR3?=
 =?us-ascii?Q?4oWtnFRb+7va6p5YKj5Tmxez50ib0ASGsHuwhOUwyEBXwBew5olbl3LURE36?=
 =?us-ascii?Q?1oDWyS51eo7qPNdht/YSAJ0Y2Ub6q6+ygTPuiWvQmYAOH8IuxyQZj6QDHrHF?=
 =?us-ascii?Q?Ij/GKDw+1zuwW0FiZXHLizl8UtCOqgRm8ZpDNJ/HI/vA12Y7tMh7G7mXghR5?=
 =?us-ascii?Q?mUARXS7Ao8RYC0WJKR1R085+HGM8nlITbZIcdrwKOxDm/ZxdrIM3RCOgA5Sx?=
 =?us-ascii?Q?BkAdyVLXdoIhjD2+4rJ/4uLnXaIROj8blFHoVMkh/KQOoCEEgpPXTVr/7alD?=
 =?us-ascii?Q?Hntrlrs2IPcC0OMKDC+4piUdwwJpoQuhP4bENnzFSE2OwsYp3F6i4c4A+pv9?=
 =?us-ascii?Q?Kz4aS7xo4CF3NO/NhBmXa2QhPMng0jzWzP8ITIk0RdhJKA31bLubF9H0+bLC?=
 =?us-ascii?Q?QJpZElXc1nV++HdhF2Eh1Ui2/ZDjszNmIKob7xUZ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	wY7tjW6MCYhXbR+UMSAqVGI2bYHrJGjnqYcGOLmxdD7UPzK4m50RBUTOSu1TptiJjhSuuyOQxDbciT14nsrygvZlBzLJq5P4oKoKDcali29cLu+Nc+5T02JFORMwRZjFeBovuQTzrrCbhtUHWJUov5gxmVJ6FNXiYMWpEUzNKW730u2Q3kIo1+g0EhUd1jje6Z5OvnZrEz+blfvEc/m91itaRhju+bwUrtG7ZLD1RqKcGTniFoEukWJymCkcWT4eLIeyb9L4x3+51iZ7qzRsqWIvqKmu5e5XPJS/uzhhHhQpL2BRKkV56fFITUEDsnAF2vHzCkWP7kfJ/XI6zFSEXtUK35GxHyS/xLL5OtZlgpKv+7ARYJ7V0bDhLyRrAO6C1Y+qRSxsrnZ9ppyu0xnQ+nEanCt+5eKGxN4kijKRat5Ul8tcaGEZdJsPc1pxM780EbfA9pPr+2L+EeomO/OdfBDd82xOs9uBfNWm3lo0wYrg8ff00Dz7oV3LXTwbAm+bhEc5d4NdiKbcQFroShBZLVtZ5MfoP9gaB+njm1GK6g3YLuGNnk6UWveVHpWscrBCYhvposjfBFZsaWJIGHt/S2FyF/lQPpVIjiA6HihhzIR/75RMmb1OCymxVcgyh5Qz
X-OriginatorOrg: drivenets.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3099391-5b44-43ed-be5f-08dcdbc74235
X-MS-Exchange-CrossTenant-AuthSource: DB8PR08MB5388.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2024 12:00:03.9128
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 662f82da-cf45-4bdf-b295-33b083f5d229
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 65VIQX7jGIZHAlfDfQbWiWkUxQ27we4dRnB+Yz9I5l2/OdKVCM6gHNK8rjIngLYQK88CaveOiRiRC9dcNjcOPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB8670
X-MDID: 1727092811-zMMfJjlLm8GR
X-MDID-O:
 eu1;ams;1727092811;zMMfJjlLm8GR;<gnaaman@drivenets.com>;a195e14e567b2fc7652d458ddfcfc4b8

Thank you for the feedback Eric,
will do!

