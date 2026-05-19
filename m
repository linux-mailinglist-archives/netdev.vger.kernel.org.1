Return-Path: <netdev+bounces-289386-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WG/9EuU+DGqqawUAu9opvQ
	(envelope-from <netdev+bounces-289386-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 12:43:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 54FA857CAD8
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 12:43:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E6AD83116C2A
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 10:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4D3B4B8DC9;
	Tue, 19 May 2026 10:15:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2094.outbound.protection.partner.outlook.cn [139.219.17.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434EA4BCAB1;
	Tue, 19 May 2026 10:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779185736; cv=fail; b=EHZJb+lOhPx7bPRzlcOuiDeBzzKd+S4bBxJTkSJEAysG60LCeoImNHBE0Y+OsOpEJCZXxxOn7MerCw+zi9vZosYJ2QwrIsABaN0QO/7B/s2agpWDkTz5Jq7+hFnj567P3Fq7lUUEa1XQJyPUvsJgMcACT36yiG78ulpiRJhFdkc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779185736; c=relaxed/simple;
	bh=yL6ui8ktzhawcv/SdZY9elIupb0a0LP9TuR/Dy21ub8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nRgWSU5k8iBsrepiefV+MT1bD06yd66P5Z7NlkGFzSrdumz1+Rvm9Okv7a2IMqtB2MwsTrT4lz58e41H5pem6D6sK51VV8oDRozHTBDI2UMOPHu1s0IW1I0TCD+A0ascw5HQvpA0/zlRpiZx5v9rhRPe6RbuoVtNCu+aMq9d/Ag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ky45Nb9ynI4g9DVQx77Vme7BWq5WpaJXyifcSMB2m0Ig06SOuk9Y9fTI2MXDJcX5dWgjnGAgib4YJhuPpQRzabJGnuNZdyzaofOpAhDpqjdDXwplEJ6VkesPxEjUJhoZIdJf/2S5DR24YjGgGou4/0W0LzKRO+CWpzmagsYXSJuYkAEv+S3oqyf/sFP5Xm6EZfkxfBhbDi315Ag6QOjjbvkV5yvaDcF7gOQ4/6x+s0p8aeOhjidsZVhLcBHdEVlZYDdAVLD6TmMcSGl2+TTd/xVRlRSaAKSMBKX5ekoHPT0NZiEhAjL2H04dJq7DR4e5IkIicfxDkAPeQ47Re3ASUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1b/bV8x8x3pMZx3ArEvkkCyXtmTv4A3di3Ps5BMbChs=;
 b=h0Twmp0QKr11BXwnkwPng927yVuISVle4HFePKZYGQK4VB1nKf7qkN0wCpmfwSctbbrjHTlmor11Hg2EVeqFOAcIKW8Kn1EUs3vetZQ41ayP7AwAoiaX0UP2zPHPOelHUDAkoCAxvrw1un2DIE0PDzxOgHW9BTnoiEmfznQcTnKPiWno7V5rv3E0YBZaq0F3468Wc+nFH566GSi0nRlnp5f+3bSrADr3pHC3fRB1J6W4nr0s8c9VzTODv2h0+Rgyk2eQ/QMwZLrPOL+peU6x2sdUjE6qhtViiMVFzrzPrRSddi9pmS+uVzIIbnyL/k/7GFqT7yEG87y8DWS16YD+Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0493.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1e::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Tue, 19 May
 2026 10:14:53 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::9b99:12dc:a115:b90f]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::9b99:12dc:a115:b90f%3])
 with mapi id 15.20.9891.021; Tue, 19 May 2026 10:14:53 +0000
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
Subject: [net-next v4 5/5] net: stmmac: starfive: Add STMMAC_FLAG_SPH_DISABLE flag
Date: Tue, 19 May 2026 18:14:36 +0800
Message-Id: <20260519101436.111476-6-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260519101436.111476-1-minda.chen@starfivetech.com>
References: <20260519101436.111476-1-minda.chen@starfivetech.com>
Content-Type: text/plain
X-ClientProxiedBy: BJXPR01CA0056.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:12::23) To SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0863:EE_|SHXPR01MB0493:EE_
X-MS-Office365-Filtering-Correlation-Id: 191de377-879c-464d-bcdf-08deb58f77ee
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|7416014|1800799024|22082099003|18002099003|56012099003|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	6+SFH79ao7wQwh2p9PGG05IIm1z4VnfvuofBI0eGql8YNbbFGnEAIRL+vql3q1oXljUMjuvU1BLZFDIo28Na8NXNIle3xjbUiN6vEIAGUl8kQNEYypdn/W7IqSfGG18bGqdKLTXk89WORT3neNXrg7QDxJ7fHsY0Ob/blvHaIC/4cVoeG2iOWkgYF5JDMMb6/DZS9IuuGD9hMAqFvbC4woIUeS87d7dk+dbQgGmjVMJ1rnme/AOr7gXRTTnWsCFhtI3Ic0KqiprwCy3xut56SBpeNEaDbkkL7tF3At5os3DQqtzWFSr2JvFs/AajrycZ6Mz1g67CBUpLbSTBlYll+uYBx/E2FeBME5yPcnYamR5CW7wvEV9hK60HMGqZ35qg7W64R0i1xotTT5ttEKhk5Js24Yv7oV1dL+HMQ0fcz72romLsy2YZMjgmQ5BH/TawNdhWAUr5JFBZhuybe5DDTwm5KIj8oXL2EardZcHXAJSnKT2l1sxSpRfBGsSDiI7c7utH24SGOw4JbcFb4pCdFzxzRWClWuxVfNBMaAWRSMqOLc7Py9tmdrfHEEAeb90bNK0DijN76YldIfAHlNR9fQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(7416014)(1800799024)(22082099003)(18002099003)(56012099003)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ABue8PFQDJmD41bYyErUxUpXSaFsW7bhGIbhUMUEykLYosm2ZgKwITdLKs0g?=
 =?us-ascii?Q?p6cf67jijFotpSAT3q6Y/9r3lSdccrg4G9mP2PNsPvIAt9Nu3BleucoCA4Kb?=
 =?us-ascii?Q?57uqFlD5p81NJBCbpNTVo7s8ZaWy0o9BZruZzAf/YhI2fPPDbOILoBG2F21c?=
 =?us-ascii?Q?hYVZhe/3gwHOljFFwIIqYFXTBroekWEjCiC5HVVY9rtLKOVMa3ycD7XJOmVU?=
 =?us-ascii?Q?KcDfPLsSEvQO55kZHHJ2duYCgSrEgF5LtdADeficyKvCRJJ6NFQua7fMNogX?=
 =?us-ascii?Q?u9GTC4UN17kDAGTvmVmaw4lQXBWVGn2JTYGBTSuuKHlsUbQKkdBkklHOEB4/?=
 =?us-ascii?Q?sL1DElFM0tCFGhfibYabZt8ZmrCSZ7VBAE0wT0J5WHPOG9ZJMKezRaMbwsXZ?=
 =?us-ascii?Q?jqdlsJUp5G6r1g3zMBMXYz3xOvpRhxYm8KmG3DoMc6FS2xw4Gm/MQMx6hkbm?=
 =?us-ascii?Q?ZoNGjeJ1qEITHCuWYUjozgy0nWqQaonl7LSDCkb4u7MHnyYX0ZFrL4QK9sB+?=
 =?us-ascii?Q?fbth/0rZ4w2RlcdfHvrP1uXIUwmhBh40vmiLsUlvaE9ADUQF2Mt9bJOFmRwg?=
 =?us-ascii?Q?dEQu840Q6AbYi6DqfL3PXoxMJVYlv0pzWd2NQ9VFavZ+HNw/vviZu1MZFzl6?=
 =?us-ascii?Q?+jQTylfrC74MwrKLQzeHtrMZXr5nAHxqAHtJwfF/phs3AFII5TyS6TpG8gSq?=
 =?us-ascii?Q?zkvYXgqti8BWhuGX9COXYM1FLzMVrvzdlGPnQCkd3SWlU6EsxCrGQ+8iaHxZ?=
 =?us-ascii?Q?UafH1BXytNSIZBSyhLj4eima3JFUhSI0tv/cVTq8oR4ANSFre5/X000rVa8g?=
 =?us-ascii?Q?UvfDDnIThQJgROQvXI0ap9bDjRF+fOUy2MKyoCgERKETbieC2r4dKqEF0yMx?=
 =?us-ascii?Q?cY5JySFTnMAPgsnCNJbM5h+yBk4gohYnuPRBHCyDaqJ7NYUOC2VuHwvc6A6h?=
 =?us-ascii?Q?9LFUQloumhQuJ22RR0O6iTyNkXzjM53+uZway65gW19pOYhU6KO/JrVVZcW5?=
 =?us-ascii?Q?oNq4q4kPV/6mnEffGInZhL+ZVeQrBPuPmQLE3kRvkMnllPWxSOx+COSz8JK1?=
 =?us-ascii?Q?Dm4SVw0FDBPcdHoYRryw0hhUTWo2g+AvJwY3DSUUnCIepfQWT3O0nj1Pkmwv?=
 =?us-ascii?Q?GaPp5zOkOBLmUacMl92xQKa1KQBS89GkhvW7ZzbPlFYl09wwM2sanY/Cp9ca?=
 =?us-ascii?Q?luI2QjIYIL5PZUd192WSjXvBN9L86jnU+oC1YJvX6asCcPRjzAAPozRZYRrO?=
 =?us-ascii?Q?eknj4rwiRvBptjEpKJy1mhQyV3wXfzp/OEEOsALhdtAHB39vKZ0p2Q4lqV0H?=
 =?us-ascii?Q?zfWWfNLex5PdpiOJLCWAW/WcakOh/vEuNFOFQtg4EBLX66xdYP9yKgyBo/aH?=
 =?us-ascii?Q?r91gmVTsW0pYG75mHvbZA3cL52RYulQtn2JEHS/zxqqTpSrLTjnUnTizqhry?=
 =?us-ascii?Q?qZzuG6q0Hts7TqkWcOCuT758saFudheTRtF0Qcua9DscimP90bm7Gr6/sOVR?=
 =?us-ascii?Q?l+FEovgPAGyDxHmGVEp0VX1fANryh7kj+3UWYa+qmODeWDKgM9Cen7xUHujl?=
 =?us-ascii?Q?+6fPuKfe+disyQLgs4KOLgtWZ3W/y3LyKxqlczCnXmEWcEfHcdzv0yBnRx46?=
 =?us-ascii?Q?Quf6XlZp3YJd3/2B38ZxnFjnagYgoEJF1fYE1X7AbaQTfVo4qaQDR2v+X4Ld?=
 =?us-ascii?Q?qfed2ZTc3rTq7XgR5WczgbpQWALmSs/1aG1I/0k9KoS6nyDusjlH2hduL3lL?=
 =?us-ascii?Q?vzj0LJ4FK2B0e3Fx/C8GRoXrUNAdW6s=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 191de377-879c-464d-bcdf-08deb58f77ee
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 10:14:53.1410
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DadFYcw3ayDtnmGf3z81hwxqRAQAlpjDIHP332CpUN6PI7z+4LqM187/zza+0ZaQOAuWYnNJpCFpGG1EsHdXMmNz4hGyBAuJ55haLYPaC4k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0493
X-Spamd-Result: default: False [5.04 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[starfivetech.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[foss.st.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,canonical.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	GREYLIST(0.00)[pass,body];
	TAGGED_FROM(0.00)[bounces-289386-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[minda.chen@starfivetech.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	R_DKIM_NA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:email,starfivetech.com:mid,starfivetech.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 54FA857CAD8
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
index eb882ec14c8d..6a887260d5ee 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c
@@ -147,7 +147,7 @@ static int starfive_dwmac_probe(struct platform_device *pdev)
 			return err;
 	}
 
-	plat_dat->flags |= STMMAC_FLAG_EN_TX_LPI_CLK_PHY_CAP;
+	plat_dat->flags |= (STMMAC_FLAG_EN_TX_LPI_CLK_PHY_CAP | STMMAC_FLAG_SPH_DISABLE);
 	plat_dat->dma_cfg->dche = true;
 
 	return stmmac_dvr_probe(&pdev->dev, plat_dat, &stmmac_res);
-- 
2.17.1


