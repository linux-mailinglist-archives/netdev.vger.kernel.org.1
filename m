Return-Path: <netdev+bounces-292255-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +ByVLQHUFmq+swcAu9opvQ
	(envelope-from <netdev+bounces-292255-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 13:22:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3149B5E3529
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 13:22:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 611993005D18
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 11:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D0BD3F39EA;
	Wed, 27 May 2026 11:14:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2118.outbound.protection.partner.outlook.cn [139.219.17.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11B93D79FE;
	Wed, 27 May 2026 11:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779880475; cv=fail; b=muT2xNnrWGo2w9IcweEh0JPiekJgt/yku3o72OCv9CFdSvYG9swZVbT4usY3qveNV+SWwi6srGgZuR0jkS8qvSq7mE12lZYqlHp86yFQ/EpNTpjeMmBkIpBanm6ojicroWLHG5D5Kb7R8NzFkGi0VMGKW55Io7MMw/Gl+bRHsaE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779880475; c=relaxed/simple;
	bh=90hz4BNcfKSl0naESe/IvFNxVymxBVDX9agIhlpj0e4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=T1EXDhqAu33hi8GX0G+SvVnjyCBTvbaJvXh+gw+ay0gYrg7dm/iRY+OrCIUAcmCKECZHIhaoVWekVs23MOyo5RLuRk0/+siIcjKlEv5MOYTqddicWribQaSrL26DHqTKJ1qNdCeSjSXrOOxxJZsi3gcTAstdg2tPnL7N3cu/+Wo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P+nhUiK0J7j9Eubo/Fj8fz+morVz00pkiKnu8sOtBTXq2Sdec8Quj36iIDo+50jyGaA2EuH0LT1kN2CLvYdxtRpmFjAvJ0tlGzJ6WDmy7fYuzO4R2IP7yvIp2vbUeETKf6B6Y1X3z+BX/uvGmsIx/OGyfhBQ5Ijfm0DU1qQzVO8k1Bdnn4aK+53LRThe0DW0sdZAk+U+bVZkb2zV+X6Gatj61yMY15Q3ULtbZCaIiuZiyCV8tw5t4rieCKjt5r5zIPmO56b3h4uJr3VTLr/r7lUfM8MuPjw46Xe81oIoICQ3IpbTWLcsvRLjr2/NkbWU6cIYynmKn8PIZ8tDo97RjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qvfzEu8uwAUkb/LGG2KjDhQRE+QjOYrCIOP6wkuiXck=;
 b=bd/dQE5JDq/0nDAVcU9cWhdCuO701IacokRwmuBXeH4cDpRDAQJQVz+owai7DfRFwPc2aRJMVJ5VnmDeXOFr2hGjub5K84Kfe31k2L2YWcyREoSfA3oFb6fTcwMDumTBtsYTdo9V5CC+hHfIbWX3Z3VPPg2q1agxEAOSFz4PdIVaJVwOuUbpFstj73l/DOBhzH/7OQnHxztUt4oH2iUamFKb4ihM2Og/XI8vfwzQORwkkD0je3M/BM6FQ9dqWVkkx2V293TDqDzJ41bcxPbTubQeNWbq5Gv5h5xVjUbAXBbdhfPkIIQrE7THLhneHPabs9Gjvdt6VJ1W3CeUMk9TkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0750.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.22; Wed, 27 May
 2026 08:41:19 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::9b99:12dc:a115:b90f]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::9b99:12dc:a115:b90f%3])
 with mapi id 15.20.9891.021; Wed, 27 May 2026 08:41:19 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor@kernel.org>,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	devicetree@vger.kernel.org,
	Minda Chen <minda.chen@starfivetech.com>
Subject: [net-next v5 4/4] net: stmmac: starfive: Add STMMAC_FLAG_SPH_DISABLE flag
Date: Wed, 27 May 2026 16:41:08 +0800
Message-Id: <20260527084108.121416-5-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260527084108.121416-1-minda.chen@starfivetech.com>
References: <20260527084108.121416-1-minda.chen@starfivetech.com>
Content-Type: text/plain
X-ClientProxiedBy: SH0PR01CA0014.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:5::26) To SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0863:EE_|SHXPR01MB0750:EE_
X-MS-Office365-Filtering-Correlation-Id: 973cb098-5168-4bf1-b727-08debbcbb906
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|1800799024|366016|56012099006|38350700014|921020|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	ZNhA7ABKfeZBoQp/ZwYj8JGpljPxGkc+T1L9e6ztMRksfhkR+1r2j+NhdxAuu2UTmUru6VFwslP0vqzDyno/kav15AoVHyoIbpqXWbj85fCfxy1tOu+QzsIndjiIsdPbuX2frXgkFhyPPPITeoxxo8wlzRvtgwQWIcdk3LEmlB7o1dxHWEG0z4AoJyFn8whrBU84GF++y4hJjIyyMlQA2PueL5s1z9LqoYNnm0JTBXoquKEyrkHAFrL4QnK9HzHOuqQT/50L1kYpI9EQ2bef5R9e73SnB9mnM58ac+7j3mx6MJtYjrsP5KTD3opXXsQQX6A6/ZrsVrcNc1RmuJgY02GpulBa5kMFyBV8l7TV96PRrptYSpW8UYExd357afEqy9Yy/gHWWJ2YZiU4U45u+TsdyO27XpgtH7WB+AbUaGDbvE1pz3gGfrrR/cmi+FKUnJQpwtC0tr8W5NBJeHqrTISNgiYTmojKf/wkke27cepJwHiXc095UVzutxtnVvtmRwypk2zTg7oSDAxC5OPKeR/UNsln/hy/kPEeqvu6q+gTQNvOofF2ZlBPUCW5LaWFFfWPflDAQVXDY4fJf+ZMtg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(1800799024)(366016)(56012099006)(38350700014)(921020)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OFY0C9+a0wQQdXRVDMp9zNWExdgLzGeJgZLvtVdN3zABDlFaxBpDH10CuY9y?=
 =?us-ascii?Q?JQSmkSA8C2CtaxKx9YLdSIkQKvLiSYWqRncjmzG2pgGHKDlnM+LgMzrBUG95?=
 =?us-ascii?Q?kHJsmap9fVDLynbYr65Te/2445wKw0CamW7pj1x0KNhOMDT8Js2HkXaS4Pjm?=
 =?us-ascii?Q?Ro661SgaBcxmQASNmag1OFAkWkMtnJy6ZXq2WKY6i4rIjOOSysxlmyn6qxf6?=
 =?us-ascii?Q?Oln/F9cifHLOtcU8oAgCIhVOA0U1z2Zdcl4eRgBmdsaj3zfJaS9106C4tdQk?=
 =?us-ascii?Q?/P5aUuPC9FQvgDoOAXZoYwsRCAhTtVAaVUXhZkpdJmi7404d+ATo+XgTXneA?=
 =?us-ascii?Q?yJoKMHGlTGQs+CP8BblzgO7pqfqlRbvDXcWmLCrJ+4h9o8WLyol10BLGHpsq?=
 =?us-ascii?Q?8AH9dzv/2/QszGukBeY7mTa+8llCRUjpax1YBaFU73qA6rtCKZMQw+NZcCib?=
 =?us-ascii?Q?Ag3ZnHrPiwSTwcmFBoxfQpMYft5ze9YjD9OlNl/V0V/bQOU1PDoh+x70W7ON?=
 =?us-ascii?Q?smIEnPvOeNVCSE3ZR4z8DPRKIDBlq4H/HKPkex4XXTHvHPuaLiY8Jtq8l/Ts?=
 =?us-ascii?Q?d7qEhcp1QKGDUHePUvDwJMDv+SiJhFOVLik17D2liD5mBsWWxCx/9u0cbWZm?=
 =?us-ascii?Q?wgxKrPJtHpt3L0FXpoZBtFN9Ps75wBsrcbYI8ZLJ/kSQTG9lbv3S6WifGvaO?=
 =?us-ascii?Q?OWLrloJGY+U5eui3dWSb01qxCF41A8Nwn2SuzHY0ScyBC4VPo4YNg6I5TDPe?=
 =?us-ascii?Q?9k/mqvFoc7qgmf4uxmrz5YfWbflEQqMKOAhHhFiVOyOiZwW3t49SOCv0yHyt?=
 =?us-ascii?Q?iWr8fJ4eg6HaaxQikCFVf2OcWiG7NIT9I6SIyO+vO4sU8c2fg9MZDJGyhH54?=
 =?us-ascii?Q?FPIFR1H/wQgt50CxcSHZqcOCId5Aquvgy1dBJ34a0EwqdQW+1ZYei4u0LDRG?=
 =?us-ascii?Q?tjl+DpbTr7+uRKxRbcAk4Q34kdXwr3gqlKHFz7Cm5wBtakG34vio+Hqqe51l?=
 =?us-ascii?Q?1WXteh2Njqs6VT6l3QRCCoNqCzgRw11d6jnFdBj8SkRVCr51m4aCkQyaEBPw?=
 =?us-ascii?Q?nVDCVoUzEMKuwMmix5sZzTeXamY149jXWyPzER1ksbYxDBHfeJtqVUr3J9Df?=
 =?us-ascii?Q?sIMHLXLevaZFIA0oSdTQvfMvdexRSD4vlyVxGzb9PCCh/mdZHRy37+A7Z+Ru?=
 =?us-ascii?Q?kmha++0M1AZHmKeYDNSaVtRgIzFpwzV3oRkjxlAarFvURuIyhfELJyi48L0h?=
 =?us-ascii?Q?jyenWt9V0bDGCrH4+I0mlMYKkNUKt9Yh37AMBHZOivNpjwWpoNpUR51N/Yho?=
 =?us-ascii?Q?mteoPuRDNvRDi7IQou8G6+p52bEseheIAM0aoDJOiWtDBd9DmvTBgi+djNBp?=
 =?us-ascii?Q?OIWo/0aNglmulyr2g3E8CmJX3Ny6SRePkQs6tUYOLgWC5+23/eQ5Aet4KfBZ?=
 =?us-ascii?Q?IoyXOvM/R8VsdZmOT+CAfm8WugrHvBVOhYEp9a92U7RO/I/e6ltj8CQeatO5?=
 =?us-ascii?Q?imXvz/So6z+ObmdVWPgf5PJwWZPU/7R/b7n7QibuCazAbUvrTYxOVwrV2YJC?=
 =?us-ascii?Q?26OW1aVHjSj1eXpIIItEQWcAtID1hZN9BRWPXvN5eYlg4jsxpnG6kdvOUSGR?=
 =?us-ascii?Q?px6AzXg2aEFsbubt7M89c8mNmlp5kvR0pojr+MIsEMgle6hU0AwpOGR8DrZz?=
 =?us-ascii?Q?zQUGZKrMMeZEA/gscF8c6Ax2DJL6SXl2p4v1tdzhfJ5iSDwA/KKDWjrw4pat?=
 =?us-ascii?Q?UnTDq2+lpd6oFDcmx0nXD/fkBDvyIIc=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 973cb098-5168-4bf1-b727-08debbcbb906
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 08:41:19.1011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 18tWXMb9AXOhZiQwEMcBU+fTcuiTdHEg6OuQfn+pupTJeC1F4CoS/spOczFKAr47yq2bva5QhNR7nEUuPJGVbuvpToXrg1D6q2I8w5fdETw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0750
X-Spamd-Result: default: False [5.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_QUARANTINE(1.50)[starfivetech.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-292255-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	GREYLIST(0.00)[pass,body];
	FREEMAIL_TO(0.00)[foss.st.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,canonical.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_SPAM(0.00)[0.048];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[minda.chen@starfivetech.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev,dt];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,starfivetech.com:mid,starfivetech.com:email]
X-Rspamd-Queue-Id: 3149B5E3529
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add default disable split header flag in all the starfive
soc.

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c
index b1717a6f97f1..b1ea248e3311 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c
@@ -148,7 +148,7 @@ static int starfive_dwmac_probe(struct platform_device *pdev)
 			return err;
 	}
 
-	plat_dat->flags |= STMMAC_FLAG_EN_TX_LPI_CLK_PHY_CAP;
+	plat_dat->flags |= (STMMAC_FLAG_EN_TX_LPI_CLK_PHY_CAP | STMMAC_FLAG_SPH_DISABLE);
 	plat_dat->dma_cfg->dche = true;
 
 	return stmmac_dvr_probe(&pdev->dev, plat_dat, &stmmac_res);
-- 
2.17.1


