Return-Path: <netdev+bounces-135786-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7599C99F391
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 19:00:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 998D41C2165E
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 17:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C8FD1F9EA0;
	Tue, 15 Oct 2024 16:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b="IF48Xqbl"
X-Original-To: netdev@vger.kernel.org
Received: from dispatch1-eu1.ppe-hosted.com (dispatch1-eu1.ppe-hosted.com [185.183.29.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E25D1F76AF
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 16:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.29.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729011594; cv=fail; b=Yww5xqE6CIUmKfWkT/sm7YLveLcoVJCPfoYfphquSmBB9EHcDTWqnv/cS73lRj4EfwUBI0Fx74X8k942qO6T7wWdM5kBMPTK/Y0TVxUB0mXe7LABZnhIS7AKPfWp3xKtlXLmrfaf/nFtWiu/MYCV7s/maGzhLl5oSmIPcFBGJlI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729011594; c=relaxed/simple;
	bh=mqow4GwpKVCb4uKJl3IHqy1FHjQQ4/GCj9ypx3nUp74=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PufkklraZhB3d1KyUNlf/HK9KE2DR4NsUt52IfWtNWfVNw3q1pQJUN4AZjA9Y3Tr13BQVs6/2iZB0eYKE2TX1b0aKagz6MMFNlsPXx5ITr7a+Pl2PjEj33Ln8PpwWeuBQoLBx9vykrohiFtENKyHqitpTc6h9/EFCtJK0mIUurQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com; spf=pass smtp.mailfrom=drivenets.com; dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b=IF48Xqbl; arc=fail smtp.client-ip=185.183.29.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drivenets.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05lp2106.outbound.protection.outlook.com [104.47.17.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1-eu1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 387E0200058;
	Tue, 15 Oct 2024 16:59:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xSQVkTM7Xi9BChhjZbR41xjhdVKevSDVelCd7lDxAgd/nrsi4t53kxUfV5mzFqJ5+LL9d5BD3DlEFfGtG1Ks8cZoExPKPM3GOGM6FfuCNKoJKcH3Y5mgFiP+zgI+pMAySxlxuhO0NLcnW3T8jZMshoLacDnaIdnC1bTUQQIrKqRpPEuYRkEkEVdGBoOpwCcRYjbImJn+GzdixZGp3CRlaV6EM9r7eIioJvoh+RRWpIUCbJ85cJXlgQ9DVpJxtuLlwI7T1dxCRQSl66kxwnp+/5lUcGp4qyrWcz6ShNxMdSWO0X9d0CuFm7x8b9/RuQMPoioVXlWPX3E5gLT0Hvy1fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FH0kTpDubKw9a5AmpY/kCXXEW3xh2mammEcnEQ9jseA=;
 b=cd3vUwRIgvRC2OdpVl7nh8mww5LcgKd111A1BFwjwWDtHXYDhjsA4C4EAVXCRDP6fBeLVuFMm40SmvimjivVEK7BSKXkzNrlFfBXzsKq7TWBoslqb4vnXm58LxQ3i/0ZxZyfOJe+u+5YIWZ6jtZZ73Ss9gmRMAdMNjKu5Un0ByhwbQykGWpTZHCVs7i6Q8OZSqOE896aT3dfko6ouxwG/POJ6y7Q4rueNsBXbOZZHu2dFU8tT5xILnQ6gFaySdSbMPCxWo6Fuw17sZthySMLyYcWHYbgWRRefA0vq4CO5aJ9kP2C/bAypaUy5INORzRbD/wgz+zVz+zYk/L2qbHoTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=drivenets.com; dmarc=pass action=none
 header.from=drivenets.com; dkim=pass header.d=drivenets.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=drivenets.onmicrosoft.com; s=selector2-drivenets-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FH0kTpDubKw9a5AmpY/kCXXEW3xh2mammEcnEQ9jseA=;
 b=IF48XqblTuXPrhhpyYXdbxLMq60OmnuWAqsk1OkQrtXKA1+tc03S14UyHCa5486AvscH02EP8BgCMMcc3HPyhXezGUxDmtXL2A9gwL51kHRUBCV73y8coQmYD4q4c+VjQ3Nsbja7P2E6OnYthmb+Vgc2bqaystaqQMG5aoGlYrY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=drivenets.com;
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com (2603:10a6:10:11c::7)
 by AS8PR08MB8249.eurprd08.prod.outlook.com (2603:10a6:20b:53f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Tue, 15 Oct
 2024 16:59:43 +0000
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com
 ([fe80::29dd:6773:4977:dc4e]) by DB8PR08MB5388.eurprd08.prod.outlook.com
 ([fe80::29dd:6773:4977:dc4e%5]) with mapi id 15.20.8069.016; Tue, 15 Oct 2024
 16:59:43 +0000
From: Gilad Naaman <gnaaman@drivenets.com>
To: netdev <netdev@vger.kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Gilad Naaman <gnaaman@drivenets.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>
Subject: [PATCH net-next v4 2/6] Define neigh_for_each
Date: Tue, 15 Oct 2024 16:59:22 +0000
Message-ID: <20241015165929.3203216-3-gnaaman@drivenets.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241015165929.3203216-1-gnaaman@drivenets.com>
References: <20241015165929.3203216-1-gnaaman@drivenets.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0059.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:60::23) To DB8PR08MB5388.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR08MB5388:EE_|AS8PR08MB8249:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ec6ffc8-ffaf-44c6-4480-08dced3ac3ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?smCb+PvY4BMxTXTzDQomVB1sq2vjxkFdUolO/nnJEfA249U1jMm/680ojtxh?=
 =?us-ascii?Q?2EIs7PjRjf6p1QVsZvhhtG1NQmSg5L9ig6TjDUMcWtydk4p+9C/vIOXzaH62?=
 =?us-ascii?Q?hH/yX8jnqtr/XE1arvT+o4hnOi5iShY43x2s7rJfsEJuZagGFBEqWjtiv/7p?=
 =?us-ascii?Q?kGWX9bOXGxHyR/Qinwsm3cGWpWgvGywXUx0U728EL6FG604WO5RjSfi28FHi?=
 =?us-ascii?Q?g7Nsb13wLZ2lP8Ur5Cgy+8ZB5QZvCemfrU9uVF4osoQTwIhbk2kbMwoyOk4P?=
 =?us-ascii?Q?/paUtyEAs1oczLPCZ690wi2wdzQ5j1GWMGMc92TQ/3qQGinGEAZUpX/OAgYB?=
 =?us-ascii?Q?essufJ36IsoAaSRZEKtt7jTEZdPQJLSEWUKYaKgle8fxcbKTaJSqdaMPVUAr?=
 =?us-ascii?Q?bpi15Q8u9UK1nAq1s3meb6WMOfMaypm5Qwo5haAkiHBsYkQpuIvPOsUoDay6?=
 =?us-ascii?Q?F+vn0KmmzuX0YJs9jhl6WSE2evRYZ1Us635sld5eZ/jEY9EIop4+6/RZSJNm?=
 =?us-ascii?Q?KAfffA2PmQxogbL1imyDjq22sOL1P9S4WFwW9WG/xpEL+sRUEG3CaYitm3cK?=
 =?us-ascii?Q?w4vLYxuAscpypw3TqC5OpzahLyPP5gTDep65uwRXxKS/vpJzbFhKLG+2UU4v?=
 =?us-ascii?Q?mtNe13AkGaP5m8zVhAqMe0bNpWefieHcC+1yHnbtLo84A2DeiqUOjz1NNMEl?=
 =?us-ascii?Q?6fjfEwDwGAip4LIgRBE7c7s8t34xqEcafGpvRzaFHYmUCxIvat8VX7jTpGsR?=
 =?us-ascii?Q?sEQkDIQv9ne7skKQACKkctx4MVTpG7WZuJTZVuqUAdJ+tHhVrY5SATMuXpbQ?=
 =?us-ascii?Q?XMIpfRzlQqoCme1M6YcQ4Vtn+Rn3000qhL5rW5K2tNdr5HfamZNJqYa0vdvo?=
 =?us-ascii?Q?XPplcHt4i/eSAvdeCvkx6FKDCO19xEZ3EfR4BC72K2wRufjg24MPx3nokbEp?=
 =?us-ascii?Q?1HkX5VdZJeuwGY5tuGrMSXKIKW7F8tTMS9pJeDODteC3NKo42t5pgwdye14V?=
 =?us-ascii?Q?LefZzvdg9l+bGGA/DhuKizmfmqfTlREDxKwOb/E+qYembbP1NXviIrdm/Tfg?=
 =?us-ascii?Q?eBpCJvOz4+7Lz0jl/WBXjhkt0JUpveBG8x8iw/X9W7UC/PruYHZec8TIxBRk?=
 =?us-ascii?Q?5HpSGJ2DQdGFpHk3y23qsRNyCjmRzOU9u+ZYFCUjMT73E6oSzm3N49dExBF3?=
 =?us-ascii?Q?KACliFoUg6jYWe/5wIn5XwPoLhv52SaLTgQ7i5xyUflRPlGY8uCwZqjUYf2x?=
 =?us-ascii?Q?+yn3RKzrYvveSvkRzwbKQp8ZrU9U+1gbPqKi4aT7oy9k8zLpPhhjDzOERNJ+?=
 =?us-ascii?Q?o22TOumOEn+hQZShedHCAp0ceO6C8avF5yOXzmOQ5bkfrg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR08MB5388.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DxsVnk//JV5+KBbDgAeBDzbNV83NzBjMOfgoftiC/1G7P7h4MYhaaKrqAkfi?=
 =?us-ascii?Q?F4rpcOElWUwtneghYJ+6eAERQVGDckVCUm5GYCjsPWlD2O6EKpbS3Ky4vi85?=
 =?us-ascii?Q?3BREbZvdIYYQvU0Xfpah6522X3YXjE5D5SwD9mgeZjVDtkcvYl52TI44EjbU?=
 =?us-ascii?Q?0fgLPAxX45uaLhAcXfHxBUh7pc4xTgtncdmnG0q6bfjqHNgYF9vd2fKEA3iz?=
 =?us-ascii?Q?QqNrzJbP8bAbdx0CiR+mIZ8N4gABmSAbo+/Fa7EsdfU4hGflTLWKQrg8f/2o?=
 =?us-ascii?Q?FEMp/HpKJTVInTaOj8pcdNRcUExx8jYEhP0Yz3tLng8hjaPiCyTgUn2HtInT?=
 =?us-ascii?Q?+IxCDMZguB0jMlUhcPOWYQmH4qFS/136MqZiRTnLVyAdxS8gDz9j7Yi+YPxS?=
 =?us-ascii?Q?OBoX8h2u4sjG7v23xuMQAQ97OKdM7OUzx84PeAGgWcRqLB16NOKEA2UkJdQO?=
 =?us-ascii?Q?aTcd0N23HoTdK5H2Ik6zJN2lGdkXDsX9PJRzRBZUeNrVpjGPr2EGWj59iWdW?=
 =?us-ascii?Q?PdpLYinDjK0pBS/HxeoYYVb6gveb8mtHimogqf5LWvG8MRaipq7uwK0LuNYr?=
 =?us-ascii?Q?ZByICf6rdQGMaJ7jIDxAF2wmI12DKiHOplBXVSt0noHr+pbxZC8zBFWTK0I1?=
 =?us-ascii?Q?rmDuYezklVvIUbbCYP/rly6gWpV11U5GtL6OOrb/jQ0mK4S4JIL9HUKBjeui?=
 =?us-ascii?Q?diaQncJ8ZNcy4Kz0eozU+NrAfIATuumZ9jwldOb4CQBo70+/9eyFZaJ/cbPD?=
 =?us-ascii?Q?Jt45ikGfrNOrhMAb61KgYbX12G9Ymv5bPKEGZ6R9Cqkwq+tF9XThYANmAeV4?=
 =?us-ascii?Q?COshBHaLltHTKCMFD2v6BejSrx1gHgYti5T4+mC0upYwxVEUcjoPTk+fN7V0?=
 =?us-ascii?Q?+PKoiVoJGPdFeFseH00AkKqWdz+PkghuXXql8ptMo8IUZB8BbVynZOs8aLil?=
 =?us-ascii?Q?HQYhmt/oGv7947nfaN6UKXGZJktFXZ+3hgdYu4fA9GmmFol+bnDHHYGpOC/r?=
 =?us-ascii?Q?yoKYqcUQJ8w+Y+04StPjhiLHr/7m3MhyJTYSgw46MT8Kg1hXbr8zhNlFIgOE?=
 =?us-ascii?Q?8+QkWJD/WmKBuSPQFRyuzlHN55cjOAfTe2r9TR6gf9pB8C8nC/HuzPUcAON0?=
 =?us-ascii?Q?ZAGJAkVsyv9AbI6STYXEyiarJOHc2U/zY7a1Xw4v+nRqNVIdoLDId1M1+X6y?=
 =?us-ascii?Q?QY8TOa5z3iJjiGqvuRQS8WZXbLU/1yCx7n9sQhDiqC82MZ75llNeVezCZnMV?=
 =?us-ascii?Q?+gUAKzF9L6qGmM0GXFBAqq7cQ1jw5esVqFCrSS4sHtCGVYAWde4aPdB926NY?=
 =?us-ascii?Q?JPKHZqMSK1cF5oITu64d8WOeDc+FswlCiVMwvvZxm4RcnLWawENc8ijpuOtm?=
 =?us-ascii?Q?05J5nJJun9CK15l95ns1HdFnD+ovyKq5gaQYOeh9grn403WFdyo8ccFA/Tme?=
 =?us-ascii?Q?MXVoDNZng6kG0cBKHkOVyz2BQlFm0Qg4bEWYFNV5A3K9X1whF/tYJhrrFWqh?=
 =?us-ascii?Q?V75hh1YECVCRpBjNQLd45ApCvyZfIzCLySifUyPSD+itqXiF1NyPV1+awBUb?=
 =?us-ascii?Q?1F57QgQqzJ43+8cYrtrh+LD9OzXvVT/n2LBEzQpBK/2WbzTR2oWRszfAj8Py?=
 =?us-ascii?Q?Cw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	k3yylNO+18vzCEEEO9Ymafnmw9saSf+n85gYQ2z8w6KJg4CaaNfaM678ovtExyuUQYjeHTshj29Vt80CfJQWbxsG21s9FvBypplvDbcwVWncBQQ+PojLTAJU9LnLLrCQrdeEzdI/kLwTnOE4fE/vOv92Y8WC0MbfiZruaHdN3G+3OPL79Gvd55G9w2EAL+O9vWdl+Siz19O+iP3qNtWW3MJCt7AG5PT7/X0MDGuQ5o58xFRQPlTemWSoOWVB3EjNDGOwArN0zt0Qn0WxZBAb5a0LrQLfCNmQ+SiPZa8CkhM5G1lK2laVMgELOCG7gD9d4ErN/+2E4Y+ZT/6KsSfrSYiTSXty0J2PwdDornYVyy/T1BQgdQHN9+2Bm5be5gIae+v71OS5XxQdUb6QKq73TWlCX43Hgc1YuwrnU7EEwY3MdUjRzqjzbAbbDVVVseoPbQMCmO9w/w4gkT+4FBNKkGD3OwAdf5BVZPtuR/su05Bnthr2KGEd840zP25CL+hmUAcx0Nj1/2gpC9FD2jLUHMKQ4wqBHCWZ4+ypSK2/+V7VWy+SJEiHtgNwEkg4wuksHjBG5ikH32cWvIbvylecJmGnJm8YbQoZajRCD7uTe3YJg1klXebdo+DX/kAv2EqB
X-OriginatorOrg: drivenets.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ec6ffc8-ffaf-44c6-4480-08dced3ac3ec
X-MS-Exchange-CrossTenant-AuthSource: DB8PR08MB5388.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 16:59:43.1946
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 662f82da-cf45-4bdf-b295-33b083f5d229
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gYERo2tG7pyH7BJFEvpUp9GuwwmN2S+cO8R6QqfFwfsp//ZKtT+9xthPIxCCHJ5TPgqdCAMCzK+F13nJHL+tgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8249
X-MDID: 1729011585-yiIKYJ0fJwp4
X-MDID-O:
 eu1;ams;1729011585;yiIKYJ0fJwp4;<gnaaman@drivenets.com>;495c1e7a27a6c3e35a5fabc922783896
X-PPE-TRUSTED: V=1;DIR=OUT;

Define neigh_for_each in neighbour.h and move old definition
to its only point of usage within the mlxsw driver.

Signed-off-by: Gilad Naaman <gnaaman@drivenets.com>
---
 .../ethernet/mellanox/mlxsw/spectrum_router.c | 25 +++++++++++++++++--
 include/net/neighbour.h                       |  4 +--
 net/core/neighbour.c                          | 22 ----------------
 3 files changed, 25 insertions(+), 26 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
index 800dfb64ec83..0bb46aba2502 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
@@ -3006,6 +3006,27 @@ static void mlxsw_sp_neigh_rif_made_sync_each(struct neighbour *n, void *data)
 		rms->err = -ENOMEM;
 }
 
+static void mlxsw_sp_neigh_for_each(struct neigh_table *tbl,
+				    void (*cb)(struct neighbour *, void *),
+				    void *cookie)
+{
+	int chain;
+	struct neigh_hash_table *nht;
+
+	rcu_read_lock();
+	nht = rcu_dereference(tbl->nht);
+
+	read_lock_bh(&tbl->lock); /* avoid resizes */
+	for (chain = 0; chain < (1 << nht->hash_shift); chain++) {
+		struct neighbour *n;
+
+		neigh_for_each(n, &nht->hash_heads[chain])
+			cb(n, cookie);
+	}
+	read_unlock_bh(&tbl->lock);
+	rcu_read_unlock();
+}
+
 static int mlxsw_sp_neigh_rif_made_sync(struct mlxsw_sp *mlxsw_sp,
 					struct mlxsw_sp_rif *rif)
 {
@@ -3014,12 +3035,12 @@ static int mlxsw_sp_neigh_rif_made_sync(struct mlxsw_sp *mlxsw_sp,
 		.rif = rif,
 	};
 
-	neigh_for_each(&arp_tbl, mlxsw_sp_neigh_rif_made_sync_each, &rms);
+	mlxsw_sp_neigh_for_each(&arp_tbl, mlxsw_sp_neigh_rif_made_sync_each, &rms);
 	if (rms.err)
 		goto err_arp;
 
 #if IS_ENABLED(CONFIG_IPV6)
-	neigh_for_each(&nd_tbl, mlxsw_sp_neigh_rif_made_sync_each, &rms);
+	mlxsw_sp_neigh_for_each(&nd_tbl, mlxsw_sp_neigh_rif_made_sync_each, &rms);
 #endif
 	if (rms.err)
 		goto err_nd;
diff --git a/include/net/neighbour.h b/include/net/neighbour.h
index 5f2b7249ba02..2f4cb9e51364 100644
--- a/include/net/neighbour.h
+++ b/include/net/neighbour.h
@@ -278,6 +278,8 @@ static inline void *neighbour_priv(const struct neighbour *n)
 
 extern const struct nla_policy nda_policy[];
 
+#define neigh_for_each(pos, head) hlist_for_each_entry(pos, head, hash)
+
 static inline bool neigh_key_eq32(const struct neighbour *n, const void *pkey)
 {
 	return *(const u32 *)n->primary_key == *(const u32 *)pkey;
@@ -391,8 +393,6 @@ static inline struct net *pneigh_net(const struct pneigh_entry *pneigh)
 }
 
 void neigh_app_ns(struct neighbour *n);
-void neigh_for_each(struct neigh_table *tbl,
-		    void (*cb)(struct neighbour *, void *), void *cookie);
 void __neigh_for_each_release(struct neigh_table *tbl,
 			      int (*cb)(struct neighbour *));
 int neigh_xmit(int fam, struct net_device *, const void *, struct sk_buff *);
diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 01987368b6c5..e91105a4c5ee 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -3113,28 +3113,6 @@ static int neigh_get(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 	return err;
 }
 
-void neigh_for_each(struct neigh_table *tbl, void (*cb)(struct neighbour *, void *), void *cookie)
-{
-	int chain;
-	struct neigh_hash_table *nht;
-
-	rcu_read_lock();
-	nht = rcu_dereference(tbl->nht);
-
-	read_lock_bh(&tbl->lock); /* avoid resizes */
-	for (chain = 0; chain < (1 << nht->hash_shift); chain++) {
-		struct neighbour *n;
-
-		for (n = rcu_dereference(nht->hash_buckets[chain]);
-		     n != NULL;
-		     n = rcu_dereference(n->next))
-			cb(n, cookie);
-	}
-	read_unlock_bh(&tbl->lock);
-	rcu_read_unlock();
-}
-EXPORT_SYMBOL(neigh_for_each);
-
 /* The tbl->lock must be held as a writer and BH disabled. */
 void __neigh_for_each_release(struct neigh_table *tbl,
 			      int (*cb)(struct neighbour *))
-- 
2.46.0


