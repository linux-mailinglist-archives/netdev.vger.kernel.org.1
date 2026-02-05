Return-Path: <netdev+bounces-257062-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CFhoLa1chGmn2gMAu9opvQ
	(envelope-from <netdev+bounces-257062-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 10:02:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AE96F038F
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 10:02:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 24970304AB8D
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 08:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E979638E5F3;
	Thu,  5 Feb 2026 08:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="mf5H2veR"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013010.outbound.protection.outlook.com [40.107.159.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91ED336EABF;
	Thu,  5 Feb 2026 08:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770281825; cv=fail; b=Ei8oRaskPaywqu+hus1jPkIHX3eUcWMhvv0vpv2eKcR9ucScRG4lJV+FZNxJcDmSp3A8nnYtsGL2pZ7abOA8ANNdGO9iQpkU3Fp5sXbhNgX/tcSqd7aE4T2w/fD12wApe9R0ufuFLU1cSPeU7iIKzA7jtO+7ASa5lktomZjs4A4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770281825; c=relaxed/simple;
	bh=q7z4wQqOSfGgn4xVxMb4y76HhRJDbP/UFBIZYMcO1ug=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Tc0sSRZVuGJIdpC0MbYxK3adguFw87BrXkLT3OHOhCc5zXzdSFJz9QKcKGIZZvo3YM2up79gOidUASSydhhdATJ4eQukQPENyxRGijrPoD0bIazKcnvpco6Xf7w09k2ssqXMtuXty2OjdaQdYQF/+98jkOI6j4vkKzGQeAKy2T0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mf5H2veR; arc=fail smtp.client-ip=40.107.159.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N/NDqXoIQ7WuW0c5EI+8xp0JH90TubG5UTeY/ng7C/5ZQZ6iK438hPvASfA+X+LsKniknLteL909nlco5lOd5LcB/zpZ9aS3u8yRWt/QtqHBtkH0B4YJRlz7tFLV5cc06miYu5QEK0GJYFwE4q+dMrI18XeasDF+yvArzucMCMNq3m0jN/VKemBXV7oiz0nLnue6tOHJoM4NHasm+rkG97UxQUl9nHYtDUXu/PIsAtEnXdMGusCXvFdEhOzUELhBUjzrxoBzVh2aLNKkpudJf/VplPn8yiQJBU4aj3OiN9TcgN2epClOQVfrx+/GB8zQo59DmsvVlRqwB0k+iGfp1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OmrAxm6pUEVXjbq83gqvby0o5+KOFZyjFnJjsvPhKvo=;
 b=kiTHpfw4rsUTFQ4P9IGfnpcKI/fUv1Zg5DCu9jZzxYu7v3ZkfbbQ0HpQL9ZiR5Yq+ZNrn81QcbvX9Bw8xAwewpivIahRqia4ZII55uf2SH3zVUsbs/Lu38+Gd8h4IS67cxlL6UaM30D0Vo9TbFzyp71aVF8FMPhfuiurPVOzqAGuzgyh6HNYoVUNnvR0fECR5RYc7WPNbYKTB7jrTtAYR4Z9E3Y5ZSmqqSjVZYtT/b61nVDq7U2mGyDrm4l/Metc0jw/k9u+PHi+f2uqZQ9PTi2EVN3JoQe6oW+HIRrRilV4K8RJSl3khNpD5N/V9iiQ9PCjLTLn04SxyaTDHKGQgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OmrAxm6pUEVXjbq83gqvby0o5+KOFZyjFnJjsvPhKvo=;
 b=mf5H2veRgdKjc/ybI1G9lnVyr4ceZTsmp7xjmXaq7jq7W7DnBHFb63mugcnOvY2xLml4RzaFw+V62hWyNGpQchNnx+FLiVV02+ek88IjAHCbvg0CCgVMrVzEr7hskp9A4IA/Srs473C/Do0xgXg1TZHBiWA4+5aYxz8yea99D7z+NPRNKRz+VFnwKCBCj/6MuTK0JIGagoyhBqnbnsY3jMwzftrv6vFuoMF9bQyqjZ0/MU34MrQPsi5JyNXng/GY3y5PKZkTIDbuD5KKkH9OrWeRLCLVefLoD6pFe/J3Ci3C7FXGBUndNMg3mEl3bdRaAIglec7v+ZaMFmhn9AFiUQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PAWPR04MB10007.eurprd04.prod.outlook.com (2603:10a6:102:387::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.14; Thu, 5 Feb
 2026 08:57:01 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694%3]) with mapi id 15.20.9587.013; Thu, 5 Feb 2026
 08:57:01 +0000
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
Subject: [PATCH v7 net-next 09/15] net: fec: remove unnecessary NULL pointer check when clearing TX BD ring
Date: Thu,  5 Feb 2026 16:57:36 +0800
Message-Id: <20260205085742.2685134-10-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260205085742.2685134-1-wei.fang@nxp.com>
References: <20260205085742.2685134-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0132.apcprd02.prod.outlook.com
 (2603:1096:4:188::15) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|PAWPR04MB10007:EE_
X-MS-Office365-Filtering-Correlation-Id: e1759f8f-0ba3-467b-0a17-08de64948685
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|366016|7416014|52116014|376014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XAy9Py38s82B9pFNjs7aK9gH8QL4iCvOypzIrWx5q47sUvfCQEJcElAkHsTG?=
 =?us-ascii?Q?jSPz/o9S9Wq5uDHLM1xBkx2O/ouUK3nZDROmkvkgKmfsRdypkNz4w2DnxaXn?=
 =?us-ascii?Q?6FbARqufLrLV0BzI+xRnroWGgRmiI0QX1Q3CBJmv7BBjcNHx8qPMkTfeu6+q?=
 =?us-ascii?Q?EGcJ4iSRgmBHCjlkhxmnFcNgqrfeEdw3tVfiFDv9QqhHe3g0oQtaTSzgNErn?=
 =?us-ascii?Q?8RQxh5Xg+jSeJXT40+veXumi0lBbR15XGvnQWz7B2fxcPurS/Bdz3wWOu44C?=
 =?us-ascii?Q?jIeWLbO65i1cZ0xeQk4XfOQyilAR53zm9qbkMYsvzrULfDjOlqDKA/f91bCp?=
 =?us-ascii?Q?G3lC6PcF/LUTxSWx5tiPMRGdmFiTlnnqfh3YeXo2kCWNAUqgSDxWUHKqeQht?=
 =?us-ascii?Q?UZ56o2Cj38wtZIp6iXr742QFblAmiLIQDtgKDJ8FQIAoRPmulCs6BzD4lPck?=
 =?us-ascii?Q?ScJnh+F57a3rzn3z4UHP+aVicTMIOueSMdDpuhWSbNftB3T5TnCpAhDv8PoG?=
 =?us-ascii?Q?5gIEtJYniB33dmQjkQBoqbORWumHEV8W8ZyM2YXgi1u90br2NoXP/PJPmNEn?=
 =?us-ascii?Q?w/77NpIC+j2Klh+XxdrwCe12iXYs1T4BaWM+mUv2BcOq4zsBHtiNFYl9CZ6Q?=
 =?us-ascii?Q?T6MPu05OMcIb6u5ZmL3eXOsSTwixjuc3rupBM0OScyclrV/Odc62KN6SNo9b?=
 =?us-ascii?Q?qyu6tdGfTS+5DcZDnXrzXMw8EeYhat0oU9JRIqouBq0AWYF5uKOXnC8bydr+?=
 =?us-ascii?Q?1izQ69EzZ7fXTPCzk3LyxwoRfu09DU+congeuLYEoJJmXYScjbJ8OsxP9W3S?=
 =?us-ascii?Q?+qovKD2oGe8+toEwjpt85EPHDPcG05TnDMY6OhUBsIiJvuN/cBpdFMcExdW1?=
 =?us-ascii?Q?OK42Kuk2cdUrKyykIRqiqU2IsMkQ9z7d0i30aOP9ZeH2OGbIkZJQpgwopm9C?=
 =?us-ascii?Q?lvImFzU8fB7qC269+EVRb4Kg0UVLx1QyYS8sW8+5JKTRSqMc2KSajnLo5w2t?=
 =?us-ascii?Q?NfQrisLnN18h3jjUKnQNgunNTpLtgsNk0UkKaHldbEflaqVFBOdFw+3TH7iz?=
 =?us-ascii?Q?qwR7VvLYHOxYJ+WfGH0+/VQBv7iQbOacFcHVD5c/YPdPKQtwbjFogBL0T1KH?=
 =?us-ascii?Q?cio8nrticZa1vDpJG7tw1ePEhbsuMAA+QpmcdB5tmA5syH/D/7ZYowcxeLIH?=
 =?us-ascii?Q?3hOPL2hiS2vJONueB2KF/2MQVfIFCRhvj7GJPnn25afoLoYvQ7Gke0eq1AS2?=
 =?us-ascii?Q?5L4PwKw/fglXiSqqaURg9Dw6+cEOy2deIIBQu3tpcDM+V1k5qJCkP1fMA2u6?=
 =?us-ascii?Q?t0r4qII/yIyafo3/X6tGAde4Ux9yiY8vpoXrqJ425PxqhpUdrsadsI6VVZ9d?=
 =?us-ascii?Q?z7q5z7wcECOR1TiCFJ6c8KjqCR3ctvX5V+dsGrzudD+8jjAADRLSbqb9QC2J?=
 =?us-ascii?Q?zoLAf8+tu5xaQaA6sQmev0MZwi4m1V+hl1f8gcZ+1TauY47jIB1xCGrMNteR?=
 =?us-ascii?Q?8IRXGP1NLuuuZ5l0xt7IyHe0MqdH/xs2wDUVKQYjkCs8RJLrJljlt2fuwzid?=
 =?us-ascii?Q?XeKF3q9c0E9bHCVQajH5uAiEfXZ7c9PyQG6cUUEXbYAoYChlNmDwcxM0DEtv?=
 =?us-ascii?Q?pLbsBcRO4z7gTBXlo2+0H0c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(7416014)(52116014)(376014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+2UpFaTgoeJz036w5y7dLbRLzRwpwapPcSUGCIdFz7oDDGSPbLyjwjihvMzG?=
 =?us-ascii?Q?1Q04CBhu/l3MlfEgLUeTWZ3DI3c9QrAXsxiRQk35JD52Sc3ANRqG3XB8zr7T?=
 =?us-ascii?Q?31dNMrubIXxK46vjoLoIiMzDm01aUprIQCak89YM+1O1uSxywF56bMF9RECp?=
 =?us-ascii?Q?0OJ+X3iCoGw3ozG9rRbyVcNzobQmiF2Q+RD7p2jpCC4JDVHuaMjFa78aO0Fz?=
 =?us-ascii?Q?Yg/MAE9mxZzpZ+SSgqtfoxAGkEgrjAYM+L3BFHAdcTqIE6HE/KlTSsL9+DR3?=
 =?us-ascii?Q?ZbSs+XCTs3ZJ1lM9LDlJEvRXNp+k74H0YixFWikwxbNOS5wUcPk1qgBd28YK?=
 =?us-ascii?Q?wgTYzGviyR5uFB33SUUeJ4fQy6EvQvHT7Wt3546wsjxIOPnXrkOJO7jVZzVw?=
 =?us-ascii?Q?ikElVL+mUtjJKGCsQ19InQvSs6SO4dBLfXPwrSVjbg25haGdMDaxnEd/jPZF?=
 =?us-ascii?Q?MbuUkoLkJ/wVdQSg4Jeq6mB0ZI6fR6wuUGynoOr16ijpEO+OoHJskvtJQppN?=
 =?us-ascii?Q?+0Dm5erUnCxTx4P84O+lTozkKCbh2scKQH5nG5Oa+NrVRvhuxO4Gw2t86iMc?=
 =?us-ascii?Q?xQMeVeWgiI7ltTxytS6z67lHs50MgWvMw1Qn1wys9/rPnKeP8jH7U4SAlxZV?=
 =?us-ascii?Q?8dQe9iI6txsoMc2dxOk1ECeCVYEKZPM870Zas8ULpVn+h+9E6egYGGXx+yPs?=
 =?us-ascii?Q?sPHX9tTslWCi63005VSKLqKfMUn26zNnzy7rrTNHkvOZZCdy2FcoJg4c3wTn?=
 =?us-ascii?Q?UZbiihtNrmJnEvFpNHRAMuIdN/l/xMjIT3nNSfS/pjvJ0G62HNBbRR6akQea?=
 =?us-ascii?Q?rI3UkxYTWWmKI6swS/EkLeVGDXVC+JDeuEEIN2nskv5wQnlJt8yncLMhtcUP?=
 =?us-ascii?Q?N0U+QrW6YzpC+5vkUBqyDm1AS+wY1MaCF6QiuPkYe1etpRwQc0fnQsHGzv6P?=
 =?us-ascii?Q?hfAyvgub+tsIKSDgIfKFB8tzqqWevauDfPmz2JDKfo6W7ritClkKcstxCKMp?=
 =?us-ascii?Q?7fsgZpgaS4x0MRWzH+ZWm8hoMuHO3NJ5VVqKAM2RBl/Z+GOthd06ZEKumzfE?=
 =?us-ascii?Q?eDtiUTwEYgjjxpcVF/lb5ClUSnH/tVbtO+fAkf1JF7W4DSD5506g+utSBbny?=
 =?us-ascii?Q?PNO8K9TUKj7f3Qppet6os58JXOx9rfSzycRcgNOLR6hh655pgyxAhDllRMUR?=
 =?us-ascii?Q?k3FtWBJHeCa1fTXOA/acy4DWh4AXtaZMdbr+sDnviXVQd325grwsXD/jJeGC?=
 =?us-ascii?Q?5BBZeiD1BU2rjDzMFBVmGgFARjmCx6uiy3VWXtOFhtbNh0WsPZStsAOh0aOe?=
 =?us-ascii?Q?VYlQ+2zaOLrSGKsPWpC/8YzS1aKrYedpNG+rrWsQUSqSCWLhWegmTW6Gkm3+?=
 =?us-ascii?Q?iGobPD3xc4D48GbDtZWyEg3PDgr46CeFGaXY8gDyhSIu/xDpf0zMZ7yAt657?=
 =?us-ascii?Q?BRfKPLGZJW50BWOoI4h2fdcZZvUXz2wiPBKYwcUO3200/TbNzfREc7PR08y+?=
 =?us-ascii?Q?YGoPzJuXDYi+3BBvTAWVli65jCra2WJoG+JwWcvFLPCXSx/klA9UVeIRZXUx?=
 =?us-ascii?Q?4DtY4LhdrQVGXwnXQdru7wIbdB5YAmYySy+h06SM+cJ35LygKJdggycC0WwD?=
 =?us-ascii?Q?cRcOYYgeE0AzwhhKoL3d7Bbs1YmmO+l/cb2hTGgdapLoft6nr+sfTND/Em7q?=
 =?us-ascii?Q?d/IWoFEkVuBab8X06ldZ2GTk9KuPDixB/by5ksmp9zBFhJ9Mtx8Gi4Uorszm?=
 =?us-ascii?Q?aGyvaQB13A=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1759f8f-0ba3-467b-0a17-08de64948685
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 08:57:00.9814
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JenbR6XL3gLnV60yTZ7PhJ9ULlWEhgMXax6s/zN9ZhFyy/mMwrWormFSc/h9dCFnbAMaU5NwbPOR/cabqaiKQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB10007
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me];
	TAGGED_FROM(0.00)[bounces-257062-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 5AE96F038F
X-Rspamd-Action: no action

The tx_buf pointer will not NULL when its type is FEC_TXBUF_T_XDP_NDO or
FEC_TXBUF_T_XDP_TX. If the type is FEC_TXBUF_T_SKB, dev_kfree_skb_any()
will do NULL pointer check. So it is unnecessary to do NULL pointer check
in fec_enet_bd_init() and fec_enet_tx_queue().

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 35 ++++++++---------------
 1 file changed, 12 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index fd89947c5f5f..1b4ce004ae46 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1032,24 +1032,19 @@ static void fec_enet_bd_init(struct net_device *dev)
 							 fec32_to_cpu(bdp->cbd_bufaddr),
 							 fec16_to_cpu(bdp->cbd_datlen),
 							 DMA_TO_DEVICE);
-				if (txq->tx_buf[i].buf_p)
-					dev_kfree_skb_any(txq->tx_buf[i].buf_p);
+				dev_kfree_skb_any(txq->tx_buf[i].buf_p);
 			} else if (txq->tx_buf[i].type == FEC_TXBUF_T_XDP_NDO) {
-				if (bdp->cbd_bufaddr)
-					dma_unmap_single(&fep->pdev->dev,
-							 fec32_to_cpu(bdp->cbd_bufaddr),
-							 fec16_to_cpu(bdp->cbd_datlen),
-							 DMA_TO_DEVICE);
+				dma_unmap_single(&fep->pdev->dev,
+						 fec32_to_cpu(bdp->cbd_bufaddr),
+						 fec16_to_cpu(bdp->cbd_datlen),
+						 DMA_TO_DEVICE);
 
-				if (txq->tx_buf[i].buf_p)
-					xdp_return_frame(txq->tx_buf[i].buf_p);
+				xdp_return_frame(txq->tx_buf[i].buf_p);
 			} else {
 				struct page *page = txq->tx_buf[i].buf_p;
 
-				if (page)
-					page_pool_put_page(pp_page_to_nmdesc(page)->pp,
-							   page, 0,
-							   false);
+				page_pool_put_page(pp_page_to_nmdesc(page)->pp,
+						   page, 0, false);
 			}
 
 			txq->tx_buf[i].buf_p = NULL;
@@ -1538,21 +1533,15 @@ fec_enet_tx_queue(struct net_device *ndev, u16 queue_id, int budget)
 
 			if (txq->tx_buf[index].type == FEC_TXBUF_T_XDP_NDO) {
 				xdpf = txq->tx_buf[index].buf_p;
-				if (bdp->cbd_bufaddr)
-					dma_unmap_single(&fep->pdev->dev,
-							 fec32_to_cpu(bdp->cbd_bufaddr),
-							 fec16_to_cpu(bdp->cbd_datlen),
-							 DMA_TO_DEVICE);
+				dma_unmap_single(&fep->pdev->dev,
+						 fec32_to_cpu(bdp->cbd_bufaddr),
+						 fec16_to_cpu(bdp->cbd_datlen),
+						 DMA_TO_DEVICE);
 			} else {
 				page = txq->tx_buf[index].buf_p;
 			}
 
 			bdp->cbd_bufaddr = cpu_to_fec32(0);
-			if (unlikely(!txq->tx_buf[index].buf_p)) {
-				txq->tx_buf[index].type = FEC_TXBUF_T_SKB;
-				goto tx_buf_done;
-			}
-
 			frame_len = fec16_to_cpu(bdp->cbd_datlen);
 		}
 
-- 
2.34.1


