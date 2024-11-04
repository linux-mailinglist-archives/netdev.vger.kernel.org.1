Return-Path: <netdev+bounces-141419-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B5999BAD9F
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 09:05:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B17F281984
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 08:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5BEB1AA7B4;
	Mon,  4 Nov 2024 08:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b="ZYu8t/su"
X-Original-To: netdev@vger.kernel.org
Received: from dispatch1-eu1.ppe-hosted.com (dispatch1-eu1.ppe-hosted.com [185.183.29.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492E8198E81
	for <netdev@vger.kernel.org>; Mon,  4 Nov 2024 08:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.29.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730707510; cv=fail; b=pm0PAUNWd3OemHdN/uos8Q7uFlEys9cFqPIBjrvxv04PGjX6k/7NL+6pQ8bLZaG7wFGs1gR1FdaJ8shH0nWDS7R3OdBecGsJQQI2+fzcf+Zr0b34r3IbsydpT9ZZMjR05p4rq/OfYiiOwcEylCwn1kOohDTKXl2E0WdG+TwfHu0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730707510; c=relaxed/simple;
	bh=vVrFD+mYj8KaLwn71l4y1PgIZG/YTtZWZ4x8ILga3K4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gwEQDUPo/SggrzP+N8knlVB3PqFhW6146NrIjkTWtr1b0TNAHrqoVL4sGV9sIQzatWcQs82pNQ5e34Um6ZRGcgFuxMxb0EGwFp4rwMLA5GDZ04s7zl2UREZhrY9+HJI/Z4Vi5vZVsNmeDBb5rTiMYFsaytE5brqvaXXqFZb87H4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com; spf=pass smtp.mailfrom=drivenets.com; dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b=ZYu8t/su; arc=fail smtp.client-ip=185.183.29.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drivenets.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05lp2168.outbound.protection.outlook.com [104.47.17.168])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-eu1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 8EB1E200059;
	Mon,  4 Nov 2024 08:05:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AvBJA03RaKe5KIx7dAmLc7JrjKzkHUB/cG5K1qyFIHPjwinyMEAs5d60yYE/BewKc+ktLnvKxHcc+AiL7zhbQ5GP+xY6XKeaX8WiCGwacks1ENScSGlOxnPq75QOEy+nN6pGxFPR0bhtfqI897vTQ5dlmCa1Gpy/GWpaP+GqnxFAqpVSTxobrOzdixY6LtZNgDqxH64grRXgcDvQEw6EolTJ3l6jKV82DFVM7g2fmBx+oQ/Bx+sUyq77T0/R8Es5WfiDA84SnPNKfxp65mCe8cXYZftHgVt8cPMcGrX4NcwO4EYSRo77/V8RTEUQUTXEPCrG7ISKfeFfB5JKoMYBIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZbgFucxQvEkfPX3c4BS+jKyeG6S9cBJLgvhxhFnned4=;
 b=v5o+56qKYgQrYiQK4liwovnCggOQkztvfBDbYKJCgHpmCgBcAEGHptlSovRKxU27WapgOMwfdWlE6+/8HepSfYL41QcDXPsuyFtKAg7M4a3LCAujn3Pd2nMX0Q8Jzj55MpJDHqTHtDuhr1XJXuzGXR/2WQro9Fry5QHMMAOAKsetYjXWlYeJA7XMT1WcLJEmGpffQtj9RuVrVUMhfiMVbOzYzKP8AEcBmtm7aNdHptB6a7szOjW8HT88hQO3VXkUI+VsD5iEQqRwgZoxPpKvGMmQC0b1WzlftVBm7UulP91mTUriEnzNBpsTk9at6Z2Z7eGDBtdV7mlWSTWexouuag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=drivenets.com; dmarc=pass action=none
 header.from=drivenets.com; dkim=pass header.d=drivenets.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=drivenets.onmicrosoft.com; s=selector2-drivenets-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZbgFucxQvEkfPX3c4BS+jKyeG6S9cBJLgvhxhFnned4=;
 b=ZYu8t/su4CCOxg5ZzwNaisHqHPNsnB42xZHm70NiNYq61okIrzSoV1KZKLL1ZMZwqthFrrtPSAFAXiyhIBpQSt6kdyhZ8QXt8dg/4aUdaYnDJ0vCrFpMxK0yryL0UfL1MeukjWDPDStmOdZ9XC1KqgSFlJjn7kUFyk6wAhKdX2c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=drivenets.com;
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com (2603:10a6:10:11c::7)
 by AM8PR08MB5553.eurprd08.prod.outlook.com (2603:10a6:20b:1da::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Mon, 4 Nov
 2024 08:04:59 +0000
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com
 ([fe80::29dd:6773:4977:dc4e]) by DB8PR08MB5388.eurprd08.prod.outlook.com
 ([fe80::29dd:6773:4977:dc4e%6]) with mapi id 15.20.8114.028; Mon, 4 Nov 2024
 08:04:59 +0000
From: Gilad Naaman <gnaaman@drivenets.com>
To: netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Gilad Naaman <gnaaman@drivenets.com>
Subject: [PATCH net-next v8 4/6] neighbour: Convert iteration to use hlist+macro
Date: Mon,  4 Nov 2024 08:04:32 +0000
Message-ID: <20241104080437.103-5-gnaaman@drivenets.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241104080437.103-1-gnaaman@drivenets.com>
References: <20241104080437.103-1-gnaaman@drivenets.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0206.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a5::13) To DB8PR08MB5388.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR08MB5388:EE_|AM8PR08MB5553:EE_
X-MS-Office365-Filtering-Correlation-Id: ce8a3e5d-5af4-4d71-8242-08dcfca7609d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?h3MEMcyCIqHyZRFikKudxShbJ8lJUf264ooy73vsOF//N9fAnGJHmropQXKL?=
 =?us-ascii?Q?KTQs3bjsHk5jZ3d2jRqiXgM8VFRkoSylHlByVnXOF0MEVX5TcaZ/wT9H2YoL?=
 =?us-ascii?Q?E/9YWfN0gl2mDcILsRuoHoIMueZLE+wdteVWPmh2L3Eduwmi2oXZek8ZTgrv?=
 =?us-ascii?Q?jidiay9CHppu3sSDdW5B7Mi7lNI8S1/faDQGbu8+GwSo7Brd6h08+2XvJJCv?=
 =?us-ascii?Q?1UY222XK9dqJ51fsb4S6xPudFFvHmGyrDIhv2S8qUo1+o9piUV5N2BxXqxCO?=
 =?us-ascii?Q?A4Md5g10P9O3vuS3ORZBTLnRvnW6hAvVBcxfhTi+RApt2AR+vKK8AfJf99mE?=
 =?us-ascii?Q?i3/gWybvsulOPZo2Q323vU16WNih6LryZD/Eub3vo9hvHgawaBkBR+4jNEFz?=
 =?us-ascii?Q?b8H4BfUmnHMyZeV/GAAHv5aYsOkWMhPTuWI6gTdwW5nQkATiEbdp/BeEqTQV?=
 =?us-ascii?Q?+3CIwSoIkypNOltvSXL+KbTVXWLFNCjzPvAXKYCThvxY6DHXLPj1KmWn7imd?=
 =?us-ascii?Q?AFj2O5wSDJevkXOabcp48cJj6SzYUj/P7RYs4PPbW6yw8R1BuubAZLKiAz79?=
 =?us-ascii?Q?Ph29tWesRZXbYKZvgsoqyc/xBqJriF6NAHrC8NM8g+g3HhkMJCjAnrp/9WVb?=
 =?us-ascii?Q?dYp1dlRIfiNlO3HryS9PkikZi+hd0MLLmJnivi8gzg9QneqD6f8uP09GDRWr?=
 =?us-ascii?Q?8fg28ZLaK/eStzVAK2UdhRUaJmdVx2tvPOaGz+yqvSwjTxn9aZCTu7NFsln1?=
 =?us-ascii?Q?Kg4haoLjz3XYMPFvz2Y0SH8QF2f0rNVw2cCrC00+IRQRcD54udMZL2mwJir7?=
 =?us-ascii?Q?4WknXmMCJbZpjjF5rNmuEU4tP1mhXOAWcwlf1fOovnJtPXyBMZ1XpiTJHX6Q?=
 =?us-ascii?Q?44FxAKhVugSjNQcCodc0Tndjav4vkJ6UD8+Imu/qbg3FIzkCJXVIxfMCeThW?=
 =?us-ascii?Q?o/G8FL12HKawGYmQt6fRu7EoM+sOm4tn5s2Qb5JE4MxhNqMefJDK5VLpF6Eq?=
 =?us-ascii?Q?auXjkiXB8eqTKK24U+FFh5WziXF9LpFpARqzE41eSlZ3cB1s8TK9ARc/w7kB?=
 =?us-ascii?Q?j31IloeodJoLx/NVmByYnwey1V2MFsV00fHoHKRRGSkasJeDo0dL6DR/Dk7v?=
 =?us-ascii?Q?dAh42KA+U5wzIybRQUevcf7G1emF0eLDHL8nxwecb3uGorsKkTKKUVlVBd0b?=
 =?us-ascii?Q?/rZW0ZixO2GHDignU5ni+f7j78G6LlAc/iO+HmUnbdpQc9K2YTDX9a6e1x9J?=
 =?us-ascii?Q?obHQuXLJFlULA8MFRiGR4S7hymZVlRFR4zZsuGZ+wfb5pl/6vjiSLME0cWBw?=
 =?us-ascii?Q?C2/xu8MM2j2D/IqRmjqlkiZFfd/R9pB5fiGwxMIRxHd3qj5urGwtDx5sKfg3?=
 =?us-ascii?Q?mVarbI8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR08MB5388.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?j45KtvoJ1UKZVP5+3dUxzWwxW42XXbsfUiqPzzmG7O6R0A4Zbt459ogCIdqL?=
 =?us-ascii?Q?MgTKu1GZtqNFscOs1ZBVyWcq09qilL8AqTC1hFjcx+HxLbX2BjHDb7JwpjHF?=
 =?us-ascii?Q?3BN/PYLW1lFeFnrFrwgz/rIshtjrVqUrWZMT90JLEmBSiVAp/KYMUcO+CjOn?=
 =?us-ascii?Q?JxyMTGbQbQdp3Ny+pIt1B+5N8x3kF2YVCxbjBxVTuWtsJ7E1UxYVun8UWXme?=
 =?us-ascii?Q?vajVu+C/xVa2vcDAURC7Gc2FEvSBz+ETnfshH24aGMxZUcbQkSoHGAXljp4g?=
 =?us-ascii?Q?/QFV8+r2OZYVlPkVXJ54/Ej/L7OwzNLxap7jup83FlOvvPew5xNq6IQ1SXul?=
 =?us-ascii?Q?X0GKW0OpOlwhyS7sl5RTCwICHchk5b3iKKvDS3tkFCADx3hYYkbOsKlzhQMF?=
 =?us-ascii?Q?pdUEZ8xP08yKQCQ2z0DNlqwsfWyV1JOE857uqwi6LYD4++7retqS0hikFy2+?=
 =?us-ascii?Q?jJhcBXac5NeoRtKsANkwgYf2RpwB5v3zqecRJnAPAZhWnZZwdnjK74Q6uer4?=
 =?us-ascii?Q?XbT3PCdBLwGGI/gi/0IqYrii7Rsa0v4qTOfUVTZkeCa2VAMWYEBePpZC+M4n?=
 =?us-ascii?Q?yjMMWRaYBhx4yI+R8NpSGztvarhJgV9sOcjGjKtlnNYsZhEFLDxZpLMfW95z?=
 =?us-ascii?Q?WFP/2tdLBnThOYEAgxmg9V2QV+vLdXWNdIzYn21fpOYbSRLQAhl4t5Htt/gv?=
 =?us-ascii?Q?42949m/kfexWgll2CkDP8qzWJiTx9SsyK6li4cylVWfIvH0mw6dAKxCUMkNR?=
 =?us-ascii?Q?cwF2ym9z+rt9em0kt8l+KQg65js+nJSbXnnr/fYSJRdeIKMrGZkKr27sExg4?=
 =?us-ascii?Q?sa1A96Qsy1HvE36gQK8GCEYiOh4dJqWwTB+K/idcpJYbpMxpIcxhRMVL2FNg?=
 =?us-ascii?Q?2SthhVjx+bmEYXM6Uek5LljG7W8IEYO5EqyGVImjhysUwVmooghUC3Z842ov?=
 =?us-ascii?Q?g4DkfAlW2yU/LJgE+2TC+dUxKjjjqhPnR/TSrQymjSq9d0N2B9eOWoek/hQ/?=
 =?us-ascii?Q?xjS3VyE8Y+dYQCBj0Qf51VAPaOuWAMvU3AIzNVI9o4GqN92SurdBWvcU+PD4?=
 =?us-ascii?Q?w3TBweoUXqjjlcTo17u9ggip6W2gcNLQBeN8ovKqMJx403BhBv9MoCr+Acvh?=
 =?us-ascii?Q?luvIDklL+GYkzL91ZxK1QUMGVMbYM5aB3TT6Jt1ujmj4m+TYpNtxGCjorNuL?=
 =?us-ascii?Q?08Iaf15Uy3BuZStg1TBaE4XUiLWnmTYZg3FaKDdU+pTevPhXm0vImom+TP8Q?=
 =?us-ascii?Q?djlseO0fduFd52EeW8+CvDDpcAovS7nNvSQb9qU5kDmxiHY20Cl5LfHFiyzM?=
 =?us-ascii?Q?A1wfmIQ0QozZS3Rsd9O/q7rx8gEPfSirUh+fCqsBYxJiTvpMfP4/Bxn9pyzn?=
 =?us-ascii?Q?8Uj5EPRORe5bagGnhCDSy9BWfXaf8Tcb6H8wcpCHBsBF/8/g1+trlvMlHGsF?=
 =?us-ascii?Q?AgpSVrj/2FD8/mweC+omSBH/CQS5bX/NzodYBBHxWdVpifysSg2ePnJFoGVo?=
 =?us-ascii?Q?tIvOKiFtxDo9wx+LATCZ98C9+gBRpl8ai8lHWQ19UvAQz9XjmKLpyCDkJDTD?=
 =?us-ascii?Q?Rg8vWzntsJViS/po4ZU5/7ZM49kIJsG1gt5w5jc00crhmCcwOySLVhKX6/Dk?=
 =?us-ascii?Q?Sg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	C23KLylbM5pyCuxA9UzREpB94zVs7dR/yfPHqb3zdDzXboIEm6/27bG1HlOT/w3xmYYDRHLSlkZEZBCEqibaS75TltmFGudfB7DdPXcFk1oZB3XOBBSZYVMW1DJ3k8dUO2VpwnG7wllae8XmdDmFrz+1F03xdyrOieoIweG7W8xEojh/snRpYj4DaukTAanmO6ODkhQUDRUCgJsyDq0SKCAUKRMyD0nulkQHfGY1WrZu4pcSdn/aXKgAUcp2qBVQivG0WUvwVYJ1NKZMVHlp4vwKmc3y/3qhGpeGiVa+NzGGZkncsmjAZfxteALaWFXu+VBHg3KhAbfS/2eVsfXhqbv/6F7elC8XMhz8+n7QhFa4t5bSbuYJ633KCOhjG8YIjY73j/u02kst6mz3ZEVxkyuqijgIiaGE69NS2D1fE4T/WJxxPChUTA2BbT8H0URhA/k6n6OULwE898z5oh6eEaD1RWd+22X9bkM4q40P6lHPN2IrUe73TpOxc/C3tkly/YPKseOntqZUefcusf0LjY6MtWdpdt/A2DyRut5VhPIvmSY+xql+oWoI9zSbB1+TwRDhx4+m31/upQXVVkbCj3WozW+B1ziTbrZxNBtfesfnrxqYv45h0EwPTBiFPMrX
X-OriginatorOrg: drivenets.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce8a3e5d-5af4-4d71-8242-08dcfca7609d
X-MS-Exchange-CrossTenant-AuthSource: DB8PR08MB5388.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2024 08:04:59.1943
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 662f82da-cf45-4bdf-b295-33b083f5d229
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v/TMbZ/1lm8b2AW8Cy05t4km2Ic0hJaf3M4Po50OzGBlMdmYXRU72si4rlAJ8sZCLNq5w7zOzXFyetHiPkNgWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB5553
X-MDID: 1730707501-bVQLl_P179bN
X-MDID-O:
 eu1;ams;1730707501;bVQLl_P179bN;<gnaaman@drivenets.com>;495c1e7a27a6c3e35a5fabc922783896
X-PPE-TRUSTED: V=1;DIR=OUT;

Remove all usage of the bare neighbour::next pointer,
replacing them with neighbour::hash and its for_each macro.

Signed-off-by: Gilad Naaman <gnaaman@drivenets.com>
---
 include/net/neighbour.h |  5 +----
 net/core/neighbour.c    | 47 ++++++++++++++++-------------------------
 2 files changed, 19 insertions(+), 33 deletions(-)

diff --git a/include/net/neighbour.h b/include/net/neighbour.h
index 69aaacd1419f..68b1970d9045 100644
--- a/include/net/neighbour.h
+++ b/include/net/neighbour.h
@@ -309,12 +309,9 @@ static inline struct neighbour *___neigh_lookup_noref(
 	u32 hash_val;
 
 	hash_val = hash(pkey, dev, nht->hash_rnd) >> (32 - nht->hash_shift);
-	for (n = rcu_dereference(nht->hash_buckets[hash_val]);
-	     n != NULL;
-	     n = rcu_dereference(n->next)) {
+	neigh_for_each_in_bucket(n, &nht->hash_heads[hash_val])
 		if (n->dev == dev && key_eq(n, pkey))
 			return n;
-	}
 
 	return NULL;
 }
diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 3485d6b3ba99..f7119380d983 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -387,11 +387,11 @@ static void neigh_flush_dev(struct neigh_table *tbl, struct net_device *dev,
 					lockdep_is_held(&tbl->lock));
 
 	for (i = 0; i < (1 << nht->hash_shift); i++) {
-		struct neighbour *n;
 		struct neighbour __rcu **np = &nht->hash_buckets[i];
+		struct hlist_node *tmp;
+		struct neighbour *n;
 
-		while ((n = rcu_dereference_protected(*np,
-					lockdep_is_held(&tbl->lock))) != NULL) {
+		neigh_for_each_in_bucket_safe(n, tmp, &nht->hash_heads[i]) {
 			if (dev && n->dev != dev) {
 				np = &n->next;
 				continue;
@@ -587,18 +587,14 @@ static struct neigh_hash_table *neigh_hash_grow(struct neigh_table *tbl,
 		return old_nht;
 
 	for (i = 0; i < (1 << old_nht->hash_shift); i++) {
-		struct neighbour *n, *next;
+		struct hlist_node *tmp;
+		struct neighbour *n;
 
-		for (n = rcu_dereference_protected(old_nht->hash_buckets[i],
-						   lockdep_is_held(&tbl->lock));
-		     n != NULL;
-		     n = next) {
+		neigh_for_each_in_bucket_safe(n, tmp, &old_nht->hash_heads[i]) {
 			hash = tbl->hash(n->primary_key, n->dev,
 					 new_nht->hash_rnd);
 
 			hash >>= (32 - new_nht->hash_shift);
-			next = rcu_dereference_protected(n->next,
-						lockdep_is_held(&tbl->lock));
 
 			rcu_assign_pointer(n->next,
 					   rcu_dereference_protected(
@@ -693,11 +689,7 @@ ___neigh_create(struct neigh_table *tbl, const void *pkey,
 		goto out_tbl_unlock;
 	}
 
-	for (n1 = rcu_dereference_protected(nht->hash_buckets[hash_val],
-					    lockdep_is_held(&tbl->lock));
-	     n1 != NULL;
-	     n1 = rcu_dereference_protected(n1->next,
-			lockdep_is_held(&tbl->lock))) {
+	neigh_for_each_in_bucket(n1, &nht->hash_heads[hash_val]) {
 		if (dev == n1->dev && !memcmp(n1->primary_key, n->primary_key, key_len)) {
 			if (want_ref)
 				neigh_hold(n1);
@@ -949,10 +941,11 @@ static void neigh_connect(struct neighbour *neigh)
 static void neigh_periodic_work(struct work_struct *work)
 {
 	struct neigh_table *tbl = container_of(work, struct neigh_table, gc_work.work);
-	struct neighbour *n;
+	struct neigh_hash_table *nht;
 	struct neighbour __rcu **np;
+	struct hlist_node *tmp;
+	struct neighbour *n;
 	unsigned int i;
-	struct neigh_hash_table *nht;
 
 	NEIGH_CACHE_STAT_INC(tbl, periodic_gc_runs);
 
@@ -979,8 +972,7 @@ static void neigh_periodic_work(struct work_struct *work)
 	for (i = 0 ; i < (1 << nht->hash_shift); i++) {
 		np = &nht->hash_buckets[i];
 
-		while ((n = rcu_dereference_protected(*np,
-				lockdep_is_held(&tbl->lock))) != NULL) {
+		neigh_for_each_in_bucket_safe(n, tmp, &nht->hash_heads[i]) {
 			unsigned int state;
 
 			write_lock(&n->lock);
@@ -2730,9 +2722,8 @@ static int neigh_dump_table(struct neigh_table *tbl, struct sk_buff *skb,
 	for (h = s_h; h < (1 << nht->hash_shift); h++) {
 		if (h > s_h)
 			s_idx = 0;
-		for (n = rcu_dereference(nht->hash_buckets[h]), idx = 0;
-		     n != NULL;
-		     n = rcu_dereference(n->next)) {
+		idx = 0;
+		neigh_for_each_in_bucket(n, &nht->hash_heads[h]) {
 			if (idx < s_idx || !net_eq(dev_net(n->dev), net))
 				goto next;
 			if (neigh_ifindex_filtered(n->dev, filter->dev_idx) ||
@@ -3099,9 +3090,7 @@ void neigh_for_each(struct neigh_table *tbl, void (*cb)(struct neighbour *, void
 	for (chain = 0; chain < (1 << nht->hash_shift); chain++) {
 		struct neighbour *n;
 
-		for (n = rcu_dereference(nht->hash_buckets[chain]);
-		     n != NULL;
-		     n = rcu_dereference(n->next))
+		neigh_for_each_in_bucket(n, &nht->hash_heads[chain])
 			cb(n, cookie);
 	}
 	read_unlock_bh(&tbl->lock);
@@ -3113,18 +3102,18 @@ EXPORT_SYMBOL(neigh_for_each);
 void __neigh_for_each_release(struct neigh_table *tbl,
 			      int (*cb)(struct neighbour *))
 {
-	int chain;
 	struct neigh_hash_table *nht;
+	int chain;
 
 	nht = rcu_dereference_protected(tbl->nht,
 					lockdep_is_held(&tbl->lock));
 	for (chain = 0; chain < (1 << nht->hash_shift); chain++) {
-		struct neighbour *n;
 		struct neighbour __rcu **np;
+		struct hlist_node *tmp;
+		struct neighbour *n;
 
 		np = &nht->hash_buckets[chain];
-		while ((n = rcu_dereference_protected(*np,
-					lockdep_is_held(&tbl->lock))) != NULL) {
+		neigh_for_each_in_bucket_safe(n, tmp, &nht->hash_heads[chain]) {
 			int release;
 
 			write_lock(&n->lock);
-- 
2.34.1


