Return-Path: <netdev+bounces-135437-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A656C99DEE2
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 08:58:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D82521C21943
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 06:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEA1E18BB88;
	Tue, 15 Oct 2024 06:57:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2135.outbound.protection.partner.outlook.cn [139.219.146.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD8B18B488;
	Tue, 15 Oct 2024 06:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728975469; cv=fail; b=GWHsS87eWcgb8zysgputbBX7E0WN/2EcW186rIdqD5yYp4IEllITn8tSMYxlWhDf95nsKVL/mwCeir3xOx8BUEfbyvzzsk1CdDckVGRhUItgRTxcmroMqcM2yHx2r3bH1iz/pfVu2nJ8RfMVP6mzfRdDBIDR97LUxBElEfShdj4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728975469; c=relaxed/simple;
	bh=cwFPG2v4y379AqoMakhH/VOnujPrf2B50yJg/NWeECA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uYGO23fEIuywA1K9LwwUYKnr9E1KV4qRqi70bICLVt6VKnafFAK6HAZ6OFMJ4/2DXXDBp/v12reFjDPNvCJQiWw0l3oxX2OTMxJHLgrdMkGWi4ZMD0EDutT6whCaGGb8mjumNypmcmLTFuMgQVBCggXUzLY+IOc0FAxfYCa6OkY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NoWExZWAHL0Qf4YmTNlaDYX8BiRk4D3uN1JIrEXVeGia9ZUWm4ptxvk6HutqBpgEgMo+Rh8PlsZgvJzkaMq9aaYWR4KqhgBrg/JyhiegyNo5Y0T5K2n6fTOOgqA+Q4lgIYx+vVkxpcWc3sVt6+IdZXXdaR3OOTKvUMeoythZtvpeRhiKPKVM83h0nKJ5/bRyipThreoF+ND4tvtMQpzO8IT7XOuznhrZwLJJJTRLg0Rkk9BtnOiukPlh5SsG6mHHmPZvEeCLJQGy3uHOXk87QAIKKVsGVV6xZ9B4JNlfRLWhM7nQ72l4nQAV/IsvhZREH7e7wuYrKpRC6Sddu/2igQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Ew6yLX4RyYhanwluElRJwwRUtQZfe9CNPH8Z9hkpj0=;
 b=ccZO2hYECtQJEHEqDvNrMQmFBrUR8lg0F/vDASWjpB68NsVSpsRafUzui4Y+1RyccS9AFAnjtlaMl70LSGitGkGMVTkCD20XVcRftsYi+HKVC4SvAdKAnuOUSWpaKDSKN7lgFI1ZsYvDBdN+sOCL4fWDInW5wvIs6q9DXD2dixV2sl3MTfFriNmSxnuqULs0cEsB9SZyFVs065kIeQVsP5cnErTJF1K7u37weSscuBPFRHGrhffd1vzyq0s+uStQOfNX+W83CVk6KkGrSUZciZBgPsbG997luaScw3Xct1zcZF6nHv6z6I/JcIpKP+uStrm473qGSMpzKIx7901tlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:f::12) by ZQZPR01MB1075.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:b::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Tue, 15 Oct
 2024 06:57:37 +0000
Received: from ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn
 ([fe80::617c:34a2:c5bf:8095]) by
 ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn ([fe80::617c:34a2:c5bf:8095%4])
 with mapi id 15.20.8048.013; Tue, 15 Oct 2024 06:57:37 +0000
From: Ley Foon Tan <leyfoon.tan@starfivetech.com>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lftan.linux@gmai.com
Subject: [PATCH net-next 1/4] net: stmmac: dwmac4: Fix MTL_OP_MODE_RTC mask and shift macros
Date: Tue, 15 Oct 2024 14:57:05 +0800
Message-ID: <20241015065708.3465151-2-leyfoon.tan@starfivetech.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241015065708.3465151-1-leyfoon.tan@starfivetech.com>
References: <20241015065708.3465151-1-leyfoon.tan@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BJXPR01CA0067.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:12::34) To ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:f::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQZPR01MB0979:EE_|ZQZPR01MB1075:EE_
X-MS-Office365-Filtering-Correlation-Id: d8551536-b04a-40d8-a9ab-08dcece6a713
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|1800799024|41320700013|38350700014;
X-Microsoft-Antispam-Message-Info:
	wWRL8LAAWcsFrSmdG6iV1gWUUybYE3z4yF2se4LBYcTAvN5G+b38M+JyTJLjuvaXdeYLrHkQ+XH78myP+VDHeJnkIdFBc4aAlcANglvgRpSm9mWo5nmfsICZQbrUznn9EWzvYMqr4aZVj79i2VokSH0uccpCbJOS60+3HWF6oykKap6hAHrYc+qz8AhlO5ileDMU4yghnMxAqECou8Ge9lzQC7qIVTVCD4WDGNRKMaH/hxaL+K30nq09AqPEfIYH/6xhwTcwzC5k5Bm9Cxt+0AINP4XAkD9HZ2yq8pAMFzjDVn1P/4H/CjyDZm5pWQvpQolEKhIl6yJIclBLifH7Kzz2LWHpBbVYU8vV6luVDbT/67ZWY6LRxl6XTSqzkzEYgiPfS4d4Cn1Pfh1+h2azqJ1G7sodjtmkSV2a78dcYC3kYdl/4KFT6/cAOCx8Bwo4jLi08vReefdQMxK/IUa5p+EVbyreB2MNDpPKzNDWxuavmyhoc6JXwoNFiDjoM5KoSAUx4EBQ9I/ku3AZV+EdQC6ivISfoGHI+0gzZnqmAlC7I0USsjhULTlAaC/dfAyT8qCEInejehUIdMurEngBhOrxhwDXaLtVG9p0xbA7LcTkZ96g7/5P2KAFmACGgC19
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(1800799024)(41320700013)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ujxJsdhfcgKZMSWe9s+VLPcMFgtO4xcYNKbORxl8JwgitbngVgKxiDhBDQ6M?=
 =?us-ascii?Q?6F2iEgdmRCzaDBQXXIuNN0xKCZ7XITEsFRRPOvlnJpQGkss8SlbDMR96LQzD?=
 =?us-ascii?Q?poMSv7v9T/WT7wwPk5GLXBV+hHAPvJfWcjytAFCZeZ/UklSsSC1/iBY0T9Ki?=
 =?us-ascii?Q?87IxsrsvEasWe0Iod5B3O+Vwv7trBpw9NGloLMKaLivoVLFQ+vRu4iArAOvi?=
 =?us-ascii?Q?5CrScbRNooy+FFDiHPTCNekF9woIYaz2eWdGZEaweNyJUeAbE5FvK+/lFWRO?=
 =?us-ascii?Q?geeRig8FT+44A2f8GYlXBvY9tTMeHFTJip+ScPAVRWd1WbY1j5b9NSOwbi6w?=
 =?us-ascii?Q?PlNIu1ThFLllxeQfG90WkfNbOJqipQa0QBeu+KTXI55uwlL5JTgaeOKX2h7E?=
 =?us-ascii?Q?+1zw7kKie28qPYhL4ptPnKDI6LVsJPWNgbleg8Tw/PIj0Ass71uyxBXn7OKv?=
 =?us-ascii?Q?rGepo6D9GTHfgEMzKQHa4H0W+IihurZoolWBFpcbp3cbT4N1eor1ZX0iuMzB?=
 =?us-ascii?Q?hnHs5ZQTRgT62ADomdku7Ww87yyVncZ0Q/tmSOM4OsjyqWSQAfhDMz505GKO?=
 =?us-ascii?Q?jitTS0XZAuOxTHj/6UzKSbOGoxGFoZ+F+9UAHamIlvgDK3oN4Fl/35UplqSL?=
 =?us-ascii?Q?b6csaMUdVXFToECIV/aLILYUYwlvuIl+Ks9Wf5hhT5wLo1ciwi6NyH/oTYyE?=
 =?us-ascii?Q?3dNlW4LZzoCZ5TcFZkAOWsOdfisBldXmKQk11fls85XEKvkFjrC/7erdIbML?=
 =?us-ascii?Q?rqVPYEDZ9PDzcnrQB/p/E8hKg0Mi7Zvp9XIxd/VeT86ZxYoEs6GCN6dybOsI?=
 =?us-ascii?Q?MHAdolxVRzFWSOW4E9wertILHGC8YuBMdvqgZkEnakX3XXyI+HVJg0MzXEti?=
 =?us-ascii?Q?V87yVwRcT+jfh7tOvVFXDvbGKxruEKqrLjuKhaTw1uRC409IZTWLcOI8MPUz?=
 =?us-ascii?Q?3HVInfEjsrbbWAZBsFYAWZkFvl2+qPbfgeJ3Qtc64eSjXvR9ZWVERvo8bx7Q?=
 =?us-ascii?Q?tJGuiZcL5Be313WHbvQBY2fevJPhwSiFl0PEbSL+xut+kukytVcgSuHIVbWk?=
 =?us-ascii?Q?tVxHBjG4Uk2+PGCT/flRgQDjkHVstXRhUnw1VP/a+O3bvcDVOfSHaRBnhphj?=
 =?us-ascii?Q?7sGatbY8LrygHM3Dw2ThdDvArUBU+CsyhNLIFRcW9H6xtv51bMpmaFdStTtq?=
 =?us-ascii?Q?5LM/i+RD4EDxrrZFdeEBuwkzHfF/KcCb6p5P136ZiY/FO9NgiocqHKm0GbPs?=
 =?us-ascii?Q?M3BUgCUTVTz/hQwGZf7F+uU24bSjpMLZt1/xs+h6a4TXCS0ChyMZWvk0b+7i?=
 =?us-ascii?Q?23phIzFLCEgCJj2xR4x+3x0s6sex4my3tLbdDf3FdVDP6+AD4XC6HXc0bcwz?=
 =?us-ascii?Q?Ztiu91k6JAOPHl/sHAOv7VrxpNjOPOqE8QOL9eHJT3+jv623uiDyUoOTRVBP?=
 =?us-ascii?Q?3/4afAARRWXcT5NOJGRX6zq+zzPmeniuKXzootgEhyXOsnmfI737H1zu+H9z?=
 =?us-ascii?Q?BQ25TXejJGiYxnlWraJb+MpI9mnlFi5enUEuCk/WytFTaFVZzSEBoZMbMM00?=
 =?us-ascii?Q?rYqDfwRu3GYnSZ+mE60VvsILfAxl/760+9WDRig2LOHbFkik2kuVZjlXBpF5?=
 =?us-ascii?Q?AQ=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8551536-b04a-40d8-a9ab-08dcece6a713
X-MS-Exchange-CrossTenant-AuthSource: ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 06:57:37.1343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C/wiqGMHpHUg+r/fsQA/KidodZFBjY0SwX/EYYAav3Ff6fF5AiqsXMsvVQJ6Wp5moKRAzVu/nmstn8PF2siUz4ah76QcFQXe1fK8x6UQwI4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQZPR01MB1075

RTC fields are located in bits [1:0]. Correct the _MASK and _SHIFT
macros to use the appropriate mask and shift.

Fixes: 35f74c0c5dce ("stmmac: add GMAC4 DMA/CORE Header File")

Signed-off-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac4.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4.h b/drivers/net/ethernet/stmicro/stmmac/dwmac4.h
index 93a78fd0737b..acbe5a027c85 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4.h
@@ -389,8 +389,8 @@ static inline u32 mtl_chanx_base_addr(const struct dwmac4_addrs *addrs,
 
 #define MTL_OP_MODE_EHFC		BIT(7)
 
-#define MTL_OP_MODE_RTC_MASK		0x18
-#define MTL_OP_MODE_RTC_SHIFT		3
+#define MTL_OP_MODE_RTC_MASK		GENMASK(1, 0)
+#define MTL_OP_MODE_RTC_SHIFT		0
 
 #define MTL_OP_MODE_RTC_32		(1 << MTL_OP_MODE_RTC_SHIFT)
 #define MTL_OP_MODE_RTC_64		0
-- 
2.34.1


