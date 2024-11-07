Return-Path: <netdev+bounces-142660-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5073C9BFE8A
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 07:37:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 102ED28353D
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 06:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16BCF1940B3;
	Thu,  7 Nov 2024 06:36:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2125.outbound.protection.partner.outlook.cn [139.219.146.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730CC192B63;
	Thu,  7 Nov 2024 06:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730961419; cv=fail; b=Sau3xDzFBmPGXyAvx0PJ4q0ib6MJZdUUzhQv+FENKWzOfhQDMFAwhueMlePKBJaDovIzZTIQHqc9oJXR+DMyrf8FJh1rDmAH4fl2XZFTKKAmVWSa5gmWos+soCcuFrELczSgAWfVmYDq8KMiM4E3RwBqnWvimjwSLBCgsCuxaGw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730961419; c=relaxed/simple;
	bh=MHYaM/57j6rqH6E+jPNmAAMc2+8YmqABHxo9InVrUZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=uyScq/wC2KJ0+CnUaBMFebGQ49E3ICsFcrefzvCu2kWsjpp2HSXWPeFEuvhbdB+jLbT1bmOjrCfx+pUr588AnaToTqlrdI1EmAsL9OXCtd0hhZvNJKY0Ufe3OFt+PB1VdXthQS0qGpTFbLkIIk4P/eyjmfig29DWPJV0puoCTh4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hRdCICiVTUs2FSW1RM/+oeNzt3bMYf/p3x9GWkF5PsEK45yzBhy28isVC72oSpcb01bJSrZna4QsO2cx06dvflplKid96lIxpS+tjameJ3d3QKX1ywVRJtjF5D+PlxocP7WQjYsWWoeU8d8GGFPPs6MSgIeroLQC91tbYN+u6qDjFUcAz6e5Ad5xeOVeyiVbW/3My2PEt2hFaLf7+zTUCXX4vVked/kQq90ngNwpcz03f7DYFQY41UIljre1i9XNpkIWINDyPYremo/iGQYNEqAyo3lf0x9Xz2k1RTkBdaUAJl2xVORAEMVUplQxUPOu82P1ysSH88bKTXYI3rryjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2+DSId5tgjrYNGj0oXSE9OIEN3QQ/X1J3SEAnuRbync=;
 b=Ct5ZdRdxCBa0a5uu1bngI9mBLyq4jJmow1HO2zr1gfP9hmMhm19TBt2Es/4tTetsD8FsK8fRUpYIcs22gqgcpljRMBsIc5/rQEnp9XILqZFFrnOstkdMUZQ714/0Vgmf7ZvZ80F0pSAVLbGc/DlNA/5xqXWVb/UcPvA6hIKBZdhEjzpeP6c+eTea0NfVBbZR4DFpxtf9nw1YbgykWNTv6uSvtPcNZ+/pdZyd4Mlpuo++ukN+nG/Q4GevH3I+vqELFaOcaKVvfcp7ejIwN+YcdpCRnSW4XmrjLcP2+/F3Lpe4xm08KdHWVDkBSmIP1NhprxCvuHjM9lM1Wo4CtTEdeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:f::12) by ZQZPR01MB0963.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:f::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.26; Thu, 7 Nov
 2024 06:37:03 +0000
Received: from ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn
 ([fe80::617c:34a2:c5bf:8095]) by
 ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn ([fe80::617c:34a2:c5bf:8095%5])
 with mapi id 15.20.8114.023; Thu, 7 Nov 2024 06:37:03 +0000
From: Ley Foon Tan <leyfoon.tan@starfivetech.com>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	lftan.linux@gmail.com,
	leyfoon.tan@starfivetech.com
Subject: [PATCH net-next v3 0/3] net: stmmac: dwmac4: Fixes issues in dwmac4
Date: Thu,  7 Nov 2024 14:36:33 +0800
Message-ID: <20241107063637.2122726-1-leyfoon.tan@starfivetech.com>
X-Mailer: git-send-email 2.46.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0034.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:c::11) To ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:f::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQZPR01MB0979:EE_|ZQZPR01MB0963:EE_
X-MS-Office365-Filtering-Correlation-Id: b111c088-61a4-4ab5-fea3-08dcfef696fa
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|7416014|41320700013|38350700014;
X-Microsoft-Antispam-Message-Info:
	SWXKjiJE0ljF8HoNqygNsJ4DBpcAfeLxNTzp6jwOVCZ66FIMMvmFqvaKL29dlUH8xhqoa+tGBEzXnFMilzCQEA+oaMeBzQYE5fv5RO/JlIRwi/FLabIln4fBN/i6IrudctdQfr1m/auTHKgzFDU9GHADyPpsuSnFkwtremMQEku4001nXRKAgPXVdZ1bHM1dFMmtZQwj0BozEsvLUZjqeDvT+9eK3VVuwzNK0GAfcZhJDfXsA6dDTv9NGSs2VptLgwA0Ex5mAiwkstxgiAlW8uDwWxmFzhEUBB8S5dktcQgs9BSBGyTAdmlbgouZtdWIXu249NYXckpvRTqh+m/NFc+S/bbWRcKaJ7k83rn4xa8pDm7oYXyS/g6JmcsXJvXsTARIg8EBCwk1JxNOvxgt3oBaCurgkMrqeqAG/VReTw2ZM7mJyBOt7PJZAU5KVfIMqE4XwuLSenFaNptu9tRtvRtOxUn9yaZIUfS40zIftPGLaDZI3valTPec7fWn7UQByNyYSlkc7SA7KcNSubJJ1nnsWdlU9dclJ5UldMlA9HDAm+pbptwnMVgrsi3psrb7BhUo5PqhdWC5ft6rxz79jXPfKHtM12bE8e0BeuWxqop4Sf2SstcCI/zVtw9xA3lm
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(7416014)(41320700013)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jh0z/h1DCUFq5jVCBAlMXvxmWItPCahmCBaps9e44iKMterq2EGGr3kv0k2s?=
 =?us-ascii?Q?4hu29a/lRu7XbnrBR2TDMp5VyHBVgmVtFcV1porvUIoH/3+teWrRY6KYw7za?=
 =?us-ascii?Q?tgzrpIE53KOt7sMOklTV7ietgYEFfPEFx4ls1Nbhdg2HRJ7a+UHbcCrDf94v?=
 =?us-ascii?Q?5UCXqj1pwU44gn8baQ1yRm+Zpu3/6GiNIrNmXq81iVCD8bd3nl8ZYZCXtTW/?=
 =?us-ascii?Q?QJPTZ+HzyV+Va2fFM19NPYgAWHk4+XVVgV6rZ4t36VBFdz5H7N8OuqgHfXU/?=
 =?us-ascii?Q?ibYM6EQ7qMYyf1oUXhpo3nl2QnIW6a8tJsvA3ya2bL0SRNGOi6Tbg+3zZ1rc?=
 =?us-ascii?Q?Bum22dOnFmHGJ1gGr89utnmBE4+VyCix+28lPqQsj/19PC38hB5ulKMpy5T/?=
 =?us-ascii?Q?t7NtwMoR6UIql9BQHt5hVGpSlxhHAqzPZvr6CTXKJWbmHKUZc5XmvWEdrLCi?=
 =?us-ascii?Q?GJalzUKdzjSvheAznpgl6TIoBHroVII5z0s0co/TnPMxoQQW6iGAzfUFMsod?=
 =?us-ascii?Q?h215N3B3KppxHZVimb22dRgeYQOWU9qh1hKrwz4jmao6r0bkwYS31TT0ePB5?=
 =?us-ascii?Q?jIMadTH+zsw34b9vDQC53lWM+1XUGI8Xn815oZZHlz6HZnH4VZDxu/arBvLV?=
 =?us-ascii?Q?IlnjkABYgCZz3P2HJsWnY8oLDOmUbjCKyI6f+ROdyo5PkUXkmZwWnHhxumHx?=
 =?us-ascii?Q?HmYcwEmBlyRhN0AHe6amLBmUbTRyfjOTKFo8w9Y5O2i/zXL8c1aPnX+BfjFr?=
 =?us-ascii?Q?1QqNjL07FRansxZPTtVg9G/9TZrJtI5q0jnDfwXJc49dbaoA3xxbt28IvK+q?=
 =?us-ascii?Q?CIkNISXJLJAmVXvn3Gs1EqUSr3J8q2CHC2bCrlkb/1AptNtoOLYIt31A7uSF?=
 =?us-ascii?Q?pUPrVX1r9BPgL3DdO8wR42yVD/UwmSlPar7vpfNyjkz7FpLFlULNNwSwhu6B?=
 =?us-ascii?Q?DW2MpQBZb/Xrhoz9MPhOR16/tmuxm1cJzAosBjI065ZT1lkaG2zNLK23w3Oz?=
 =?us-ascii?Q?XpJlXolQp16CatDMvhGYI9n4D8Rz5Crh6jkqtV6mXe/UndRO5R4b3UQZZqU8?=
 =?us-ascii?Q?8PwhX0GThiLChxFxB5FeDsHb0GoPxPExxf/cMolhH0OAT4IwJJT8Egsri/bR?=
 =?us-ascii?Q?Ow9FEOsOhqPonaQ6O0Fx7Te7LGeK8FrGN6aLeW7qBfPKkt93kadM/ocbo4Lm?=
 =?us-ascii?Q?GEC+vk8RuFCG793NuG7CVdZSreDZj2Lb5r/WUmEMtNF+6HbaMGGe3fmq2ZjQ?=
 =?us-ascii?Q?N/+CtwpXy2KV89sYHWAsHg04KfBjYeS8WU8q7oFClqk7ZP2/Ii5WG7UE9V+S?=
 =?us-ascii?Q?PwjnXYwsZe82njIBl9Y9NKFkKHoMLkrlP2v7M3btKUG/nRMuC+zuVF67/Sxo?=
 =?us-ascii?Q?RTl8XpxsD458CWzpIQ0bNL6d2azt8jyh1PA3xi2JoDmjxtj1Q3SI8dMViu+M?=
 =?us-ascii?Q?D7sK2eNUddOR3ZIRv9XpjcS0tS+GKIx96PL9ub3h93mm3R3JhAwseQA9v6sp?=
 =?us-ascii?Q?BZ6BvFtQXwhjOyFg4fP8WfDovBoAdwZeJD52vBXIkRQlkU93cy/S9wbM7a71?=
 =?us-ascii?Q?uDyRE1m8C9QC5FMV7SpKx7+ta0MF3yKUnZ8D55Ti38Ey+Qkm3RniF4Qq8F+T?=
 =?us-ascii?Q?jQ=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b111c088-61a4-4ab5-fea3-08dcfef696fa
X-MS-Exchange-CrossTenant-AuthSource: ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 06:37:02.9850
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SWwc7lWb+RTIJATE75PWnl44j3SUhNmYrkeuVTcNltQz/q62i7G0XMoQddj+tXClCn7zczMZaE/ZD2KRJ3R4igV9CG3+lEqw7JEAPvIy0Ro=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQZPR01MB0963

This patch series fixes issues in the dwmac4 driver. These three patches
don't cause any user-visible issues, so they are targeted for net-next.

Patch #1:
Corrects the masking logic in the MTL Operation Mode RTC mask and shift
macros. The current code lacks the use of the ~ operator, which is
necessary to clear the bits properly.

Patch #2:
Addresses inaccuracies in the MTL_OP_MODE_*_MASK macros. The RTC fields
are located in bits [1:0], and this patch ensures the mask and shift
macros use the appropriate values to reflect this.

Patch #3:
Moves the handling of the Receive Watchdog Timeout (RWT) out of the
Abnormal Interrupt Summary (AIS) condition. According to the databook,
the RWT interrupt is not included in the AIS.

Changes since v2:
- Added more description in cover letter.
- Fixed subject for the cover letter

Changes since v1:
- Updated CC list from get_maintainers.pl.
- Removed Fixes tag.
- Add more description in cover letter.

History:
v1: https://lore.kernel.org/linux-arm-kernel/20241023112005.GN402847@kernel.org/T/
v2: https://lore.kernel.org/netdev/20241101082336.1552084-3-leyfoon.tan@starfivetech.com/T/

Ley Foon Tan (3):
  net: stmmac: dwmac4: Fix MTL_OP_MODE_RTC mask and shift macros
  net: stmmac: dwmac4: Fix the MTL_OP_MODE_*_MASK operation
  net: stmmac: dwmac4: Receive Watchdog Timeout is not in abnormal
    interrupt summary

 drivers/net/ethernet/stmicro/stmmac/dwmac4.h     | 4 ++--
 drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c | 4 ++--
 drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c | 6 ++++--
 3 files changed, 8 insertions(+), 6 deletions(-)

-- 
2.34.1


