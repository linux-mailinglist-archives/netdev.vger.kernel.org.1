Return-Path: <netdev+bounces-256139-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WFlUE7CHgWmzGwMAu9opvQ
	(envelope-from <netdev+bounces-256139-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 06:29:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ABCDD4B52
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 06:29:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 972E5300B9C4
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 05:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D670F366DB9;
	Tue,  3 Feb 2026 05:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Wl80OXUB"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010037.outbound.protection.outlook.com [52.101.69.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B0636607F;
	Tue,  3 Feb 2026 05:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770096264; cv=fail; b=fXdnPn17ih2BdhySI4aP225/hCfKTOrfyKo9Y+rA1piQw0B34rM7+jSSdZHmyYIi2Xsv5o55dwknIDqCB3EIFzPsYiOGQr4YDCmlm150W6h7KRsTNwF54mVaUlBHNgkmCQCroMGSX/60pLgDyvgUoApQJfSnynd/L0qWMvUOK1Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770096264; c=relaxed/simple;
	bh=6/A4wxfSHJLRKf9zWPNfeBRCyqWA3jcsrnhvJfGUKSM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=n1PzbOIa/V/p3ZNv3Az4mD8GzgLeN6MhdhDzGGfyMpHxzVrEHiFsUgeA8Ciz5yTnmcjC9+kUlRRZ/ih58OJokQu0UkYILF2iERtRpULJoXigRzkISFMXV882cBBac4bwBQ7eGY60JcsnNNuNI3VI6wCr+SwrNHWXNWhS0zqIGQ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Wl80OXUB; arc=fail smtp.client-ip=52.101.69.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BrkPY7njioVL36RU0OjJIbP1nc1jMX9//gpdiPOLFJswWTgkyZO6knUu+ucGztDhTMkPkjCH6ktrXE/6y3kHB96C1l8sgkdM7AGTxwc4Ow1b7nniFfsZV8rUVqwlBiLexwOABcjjFoM6pHdxv+evqsgOZXXD7/J5BTflKFhGTujY4uadLt0KYNSoFXO96go6qV2Mfmk22pjxyd3MzpRXfIVlM2r7kSmpTGg9n07XRQAU61EbJlMjyGnvlJcc8+vwcx/l1QxAAIVWM0NEa1ptgPHEwKyw8rMMjXTk4kBAis3BjrXP56aFkfHGWO4szFc6RabMmKfIeGSkX0YAla25+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a+EJSIY6w4aF889+kO+u9GsQ3UtoVdszZS4lMJopStE=;
 b=Fr7EOTJ/Z/AXK5iSnYjmD2mFqCrVbIDePsvSFomNx/Oxu793VU0Jwg1aCOCfxlAQOlARkjUph/earteAXu8Fb+b/wLcHVY9G9xrP8U+AK5aNghG7F4H020RDrvf0dM3tne4Jmz/aX/b27IZouYLjeAQ0/KNg0I280Bfa/IufU94ljVjYUG8a53nbchFxpQylMVWzaR3hNPtjkVrOBCLp4rqrxOHIxwHF0Y643n1H+dNSqNtb9mcg5GUs91Dm7W1ApBcSzimFHIY8K289FGqa2xtHisDOmKIWGqMZ0W3agpoRTn9Nf24ZfcZombRjetzqoStNansWuHH2p0/QAmchpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a+EJSIY6w4aF889+kO+u9GsQ3UtoVdszZS4lMJopStE=;
 b=Wl80OXUB+63NCA+OqEIS0oWU6xUEC1pg2CzC1sLwvOWBCpKbTgxrVqowBp1/8MHIjbE2TcPmYEDx4zKGN+5/A7vUm9C7frePeUbIqxpn4S8ucNm5LO7X+hEJfikRvdjsR/ucR79UTWZoD8xIEjRTHOr3MnQZ2LwYkur/jlT5ioX8QrNRFqRBVQ9zabZSpnGTgcFjsTzVLViKZcaA0aTmFR/XvgafGb52E2vxMHXL/74nJXfQBTfuMp+6CbfX9Mj6GCKYgCnL7gDrfYiw7LDC57w8W5/F9yHy5AMpqrvuysCLtlj582tgCAywevpTDjxTWhk69+hZbyKzU9aa3i/LEQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DB9PR04MB8252.eurprd04.prod.outlook.com (2603:10a6:10:24d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 05:23:05 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694%3]) with mapi id 15.20.9564.008; Tue, 3 Feb 2026
 05:23:05 +0000
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
Subject: [PATCH v6 net-next 10/15] net: fec: use switch statement to check the type of tx_buf
Date: Tue,  3 Feb 2026 13:23:24 +0800
Message-Id: <20260203052329.1085444-11-wei.fang@nxp.com>
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|DB9PR04MB8252:EE_
X-MS-Office365-Filtering-Correlation-Id: b8fac7ad-73dc-40a2-1bc3-08de62e44ee8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|366016|1800799024|19092799006|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FHdssbEdcTMwgfIjMD7i927jkf64lSxoAQJArpaGpD5fRD7JNR+JsmVgOi6b?=
 =?us-ascii?Q?3nZeBAgdrCaDqECKLVB7bGvrRZ3vVguymgZQBJONFpQRIqASwrnwm3zqij5R?=
 =?us-ascii?Q?/shz+Ep3G8Xjc7JOebQX9s3a9zK86OATk4bO/E2mLYr8c4+oBMWSGx2NvsUX?=
 =?us-ascii?Q?0VnLJYkZKykLc3nY0sI11LtbHAYJFFnliXnVvmPewvXvYEZYKx6gjc8eU5GN?=
 =?us-ascii?Q?fanXB/94FQEis8yqRkJeWKMObed7iCbbsmS2mucw4FlA07WFntH6OUCux7WY?=
 =?us-ascii?Q?QzHOKutd3siG/MApBDyjWZ1Gx/6KMRbuDmm7UtE8euHYIciuoesYop4dvLN5?=
 =?us-ascii?Q?Nk9TzTVHFrAfiknOw9/JMav8fDc6RdXR4S/JL281zH50kod0yUykflg0ABaO?=
 =?us-ascii?Q?gRXxH69wD7wD+2eXCdFhv04Ono2jayfbLo1SAHCPT3DF4s+VesSQZOlJxrTb?=
 =?us-ascii?Q?xQCBu1UI5nVAKefSv0qRxTyo+3aX7VPNIQw+3rNT10EftZLpVPXjY1wybpiS?=
 =?us-ascii?Q?QZztqui239IDBsXWwsaICCj/SVUv8X/9PklUXWC3IXB7pY6GU+ypEYtNzMX+?=
 =?us-ascii?Q?TWN0Q+ZWF91ZULBGP0EJiV2hFjExyvB6t0R737IIcpiH14fDUK8ZKYZUzOfu?=
 =?us-ascii?Q?SAxC7FsMYQ+O1ePFOuqoJ9JI8vofncZPMtmVh8y4EJxECbdbe+DmkZPLh5ZA?=
 =?us-ascii?Q?cPwbfXZgXPeG5trIO7Z+AyhE6zYaom0hTD9kvsqj3NF9sXbkvUk8VBj1B/+S?=
 =?us-ascii?Q?RGfcgQxsDE4scaUGQHMK9X2m7gpnF4Be/BRITvui+FM/CIVFmUTwk840qyxz?=
 =?us-ascii?Q?gPfopj1iv4kLlEGCuwBgTMy6XNvz/UNptW936iaZHMImT78ShQ5TIv4rRXTP?=
 =?us-ascii?Q?xtiry3fxAC0lJgsIi+8haxIR76hi+BnR1KpjWRzIEkguLMeekj5IzsxDMnbj?=
 =?us-ascii?Q?nlN1/TYJadYsEWLxQjW9kLW9jkEFlAG2FM4+WlcafEndItEzVBZ+7gl2Qsqb?=
 =?us-ascii?Q?1jt68aIC9mSWF1h/Zf7m5H4YwpOtf6N7i5ZHlGNTVNn6AUMCSyY05iFMAjTu?=
 =?us-ascii?Q?SApR4dZOeULm+DJdSGzmiiaJinNfjhQyITN4Lx5Kw7nfT7PqBLMuLILIURsB?=
 =?us-ascii?Q?WcD1knIhWi4+6ZY7KZtUw93zs3LsUrLyR51jgi82XuO31L6JSyg5WucZ6Lph?=
 =?us-ascii?Q?CzT6QsGcPg28klsqXHHE96oztYfRIUghH73+9BW9huwfYRSRXqr7GtTPeIux?=
 =?us-ascii?Q?GY9Sw2Vti0yh3LR4jidEDuW6d+V5qyqov13V99IVhKjK0g7T6GYVo1XAD4VV?=
 =?us-ascii?Q?/A+9JvQD705q69427ubAYfXek26S73RrKa9vi1LZIlVXElRO8vFze21wqpPR?=
 =?us-ascii?Q?8I6Awq+x33A1lBU5lyTU9XBbLYs6ETkh+OM8ICTlGsF5ykezoD5VGg6dwa24?=
 =?us-ascii?Q?TxuJm49TNGYRJhw0vL0rsqnbmTHdyhmbdpzkZxw6HGZu6VuRbx59BwkfMSSh?=
 =?us-ascii?Q?mJBf8KocyFRhOtkM3g6POIVfKk3tDiapxCT3sIeoL+KaTz+z71WgvC4dIEGk?=
 =?us-ascii?Q?L5qEBNPx37ncZVKRPsVZXhjvrJwYOfWbskRpGdBx5GTzGR/q4lfgBFzEFAwW?=
 =?us-ascii?Q?v0TKiU5x7CYUCLV5JFKkEHE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(366016)(1800799024)(19092799006)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DZzSsAO0gmFtdJHU5570QupLjsb/x2NdikhivbXpLmc1kbmIfIIDw9bvbXdo?=
 =?us-ascii?Q?P4kw1sQIvjPF9kuWGCdWrGsLwJmvfkRIcPESPAJgGNFSFQh0cUNUOLtogne+?=
 =?us-ascii?Q?H3KDDJygDrj5ZD6ioU59xa2dZ4fplYyQnHaiWr2x7LIaYP2PGQxP4ZDPTzU/?=
 =?us-ascii?Q?xBasRo4uA93SUtH+ASOTn1f9OQS6PAOXm+WEfmIpNBVvaGJTHRhfbsCSbvh4?=
 =?us-ascii?Q?rkKqJfX5J3TROoOs+/8RxOH0j2gNlw3vk9Evi93wsrG4e30yQj6Yj5ov96Ag?=
 =?us-ascii?Q?Q8tI9FgismAejUYBumdAI1WK6ewBVBhdGIaYW5GGrXMfSSMKgODbAPzbrpwF?=
 =?us-ascii?Q?j63kMaLoVE1kckbq2vzP/X6WSvtTXfmBH6cHQT3GZhks1KALN4duZPgAYECm?=
 =?us-ascii?Q?Hdw9KW9oYQv2ROMw3+924l//O1L1BrPi84md14vl6PLS+xvIYBIC0pt/tDYR?=
 =?us-ascii?Q?Hfv1gttc7iHgdU4aIhc8hh5bnHY2YFyk6u5L0wxUfzrmi/RF9VT+cUzCZyHm?=
 =?us-ascii?Q?Pbp+dtFJdMNwXezgAj1Lqj4Idmfq9Z0YV9ZtBWJ8dfE03Q7YHABbMp8ssOdG?=
 =?us-ascii?Q?UFvTiSo6fjUNxNIM68w32jEdOCQT4fD3Y79MgYegLT/I9VSJ69DGajsADcmw?=
 =?us-ascii?Q?ChVCN4KpI7i0WMZap8lNDCn+Yj/i6G+JnOeafP+0zlWL5dIDywfC0hzFeIG7?=
 =?us-ascii?Q?j88sERv+YjBE00UY+JKizigGFgK+H/dGRyTFPO/g78eQXmXR+12iR41PRyxR?=
 =?us-ascii?Q?HwFVRmLUfwxSjrv4GWrKGn3chYlnJuWilxzTfrjee/0Uy7VwCMwD//3aKcJD?=
 =?us-ascii?Q?E4DlsuP/jGbCxN60h2IFvzC4+0dNYPBTwGEPdR4jb3Gs90FVcn5qqoSA/lsi?=
 =?us-ascii?Q?ClrwOaX3nQID0nTvV3QH7Yu21pRyJOyhfR14za6JLwKcUtsjMpxhXfS8Wmui?=
 =?us-ascii?Q?IP5i5c55kNTEqS9xcGCBIWcRIF9dV6a3DyLWrJSAYhVggTmbQuJhVFxlJM+M?=
 =?us-ascii?Q?csfnR1t8Fzs2WHmC3F8yTwTqV5GkmoL5GP+Yc+bCua9mHRbHBVs09BArZTs2?=
 =?us-ascii?Q?wmQ8uSiSKNOlUWXjI2oPxT7ThtM7MsEhIH/3EgpE35DWI1L+G+In5HcBdoaa?=
 =?us-ascii?Q?N2hRtJoOOaNLsjzReZWhx5Mx0qxCVM0Z+7C/io6daOXA1z9t0jA00FchpUZE?=
 =?us-ascii?Q?/kmttKOqugddvh5ITp6Sk+7xFK9eZPyxIzoJ1/5hxTZI4O+i/2K+07GjQZYi?=
 =?us-ascii?Q?nO550w7zX5CM0jP+gPTcarIaCqg6X/P67a9NbFuqBXwJAGqE2dEcIj86DVCA?=
 =?us-ascii?Q?CfWL2HaXpim+Cz23DoYzhBAC4sZ2p1BcjuU9Ct6/zCGj/UumTg6CUhXg6hqS?=
 =?us-ascii?Q?EiUVWDF27yiWKY/G749AD1pGL6T1ZJzovBVIF/3NXf3H7nCiv4X0Pij7uU1e?=
 =?us-ascii?Q?Vu87RhZC5Ma57FmHY+/m2dboUJKz9qwz5IuK7IwuxpFSNg3oLk6Vq2GsXiwq?=
 =?us-ascii?Q?0T9Q4qNnEKp/FuyMHrbKOa5QVwTqMNuakuFTZ4DotH1BD9QSmGWsoHh1hgnz?=
 =?us-ascii?Q?FBPcXws7/SyGNXe3vEAKtCyQmuYlWW+K10Fty73zB1rjIoCeqF8hNpuc7vo5?=
 =?us-ascii?Q?0V1AxwRMwv3+iG1Fr9LQhClSc+yM3DY+Vxl4vcP93ATIVNMpX4YXB7+NUjGF?=
 =?us-ascii?Q?bihaQOwwyrkG5msbU+gbTFZ1nB/3K4wVQrN6vbd6jxcdPV1u7rC/Xf4g/Nvv?=
 =?us-ascii?Q?dpjkjRC+EQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8fac7ad-73dc-40a2-1bc3-08de62e44ee8
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 05:23:05.0064
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6BkqkeiR6xg2+qoCOd0tRtfxcYQDBiISHQJJQncEKqXDuwuc2IpBt67TLhRwxmIXO/OWX88Rl6Gdtsqx0YUuEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8252
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256139-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nxp.com:email,nxp.com:dkim,nxp.com:mid]
X-Rspamd-Queue-Id: 7ABCDD4B52
X-Rspamd-Action: no action

The tx_buf has three types: FEC_TXBUF_T_SKB, FEC_TXBUF_T_XDP_NDO and
FEC_TXBUF_T_XDP_TX. Currently, the driver uses 'if...else...' statements
to check the type and perform the corresponding processing. This is very
detrimental to future expansion. To support AF_XDP zero-copy mode, two
new types will be added in the future, continuing to use 'if...else...'
would be a very bad coding style. So the 'if...else...' statements in
the current driver are replaced with switch statements.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 134 ++++++++++++----------
 1 file changed, 73 insertions(+), 61 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index d71615352a62..61bc267e0a5c 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1023,9 +1023,13 @@ static void fec_enet_bd_init(struct net_device *dev)
 		txq->bd.cur = bdp;
 
 		for (i = 0; i < txq->bd.ring_size; i++) {
+			struct page *page;
+
 			/* Initialize the BD for every fragment in the page. */
 			bdp->cbd_sc = cpu_to_fec16(0);
-			if (txq->tx_buf[i].type == FEC_TXBUF_T_SKB) {
+
+			switch (txq->tx_buf[i].type) {
+			case FEC_TXBUF_T_SKB:
 				if (bdp->cbd_bufaddr &&
 				    !IS_TSO_HEADER(txq, fec32_to_cpu(bdp->cbd_bufaddr)))
 					dma_unmap_single(&fep->pdev->dev,
@@ -1033,18 +1037,21 @@ static void fec_enet_bd_init(struct net_device *dev)
 							 fec16_to_cpu(bdp->cbd_datlen),
 							 DMA_TO_DEVICE);
 				dev_kfree_skb_any(txq->tx_buf[i].buf_p);
-			} else if (txq->tx_buf[i].type == FEC_TXBUF_T_XDP_NDO) {
+				break;
+			case FEC_TXBUF_T_XDP_NDO:
 				dma_unmap_single(&fep->pdev->dev,
 						 fec32_to_cpu(bdp->cbd_bufaddr),
 						 fec16_to_cpu(bdp->cbd_datlen),
 						 DMA_TO_DEVICE);
-
 				xdp_return_frame(txq->tx_buf[i].buf_p);
-			} else {
-				struct page *page = txq->tx_buf[i].buf_p;
-
+				break;
+			case FEC_TXBUF_T_XDP_TX:
+				page = txq->tx_buf[i].buf_p;
 				page_pool_put_page(pp_page_to_nmdesc(page)->pp,
 						   page, 0, false);
+				break;
+			default:
+				break;
 			}
 
 			txq->tx_buf[i].buf_p = NULL;
@@ -1510,39 +1517,69 @@ fec_enet_tx_queue(struct net_device *ndev, u16 queue_id, int budget)
 			break;
 
 		index = fec_enet_get_bd_index(bdp, &txq->bd);
+		frame_len = fec16_to_cpu(bdp->cbd_datlen);
 
-		if (txq->tx_buf[index].type == FEC_TXBUF_T_SKB) {
-			skb = txq->tx_buf[index].buf_p;
+		switch (txq->tx_buf[index].type) {
+		case FEC_TXBUF_T_SKB:
 			if (bdp->cbd_bufaddr &&
 			    !IS_TSO_HEADER(txq, fec32_to_cpu(bdp->cbd_bufaddr)))
 				dma_unmap_single(&fep->pdev->dev,
 						 fec32_to_cpu(bdp->cbd_bufaddr),
-						 fec16_to_cpu(bdp->cbd_datlen),
-						 DMA_TO_DEVICE);
+						 frame_len, DMA_TO_DEVICE);
+
 			bdp->cbd_bufaddr = cpu_to_fec32(0);
+			skb = txq->tx_buf[index].buf_p;
 			if (!skb)
 				goto tx_buf_done;
-		} else {
+
+			frame_len = skb->len;
+
+			/* NOTE: SKBTX_IN_PROGRESS being set does not imply it's we who
+			 * are to time stamp the packet, so we still need to check time
+			 * stamping enabled flag.
+			 */
+			if (unlikely(skb_shinfo(skb)->tx_flags & SKBTX_IN_PROGRESS &&
+				     fep->hwts_tx_en) && fep->bufdesc_ex) {
+				struct bufdesc_ex *ebdp = (struct bufdesc_ex *)bdp;
+				struct skb_shared_hwtstamps shhwtstamps;
+
+				fec_enet_hwtstamp(fep, fec32_to_cpu(ebdp->ts), &shhwtstamps);
+				skb_tstamp_tx(skb, &shhwtstamps);
+			}
+
+			/* Free the sk buffer associated with this last transmit */
+			napi_consume_skb(skb, budget);
+			break;
+		case FEC_TXBUF_T_XDP_NDO:
 			/* Tx processing cannot call any XDP (or page pool) APIs if
 			 * the "budget" is 0. Because NAPI is called with budget of
 			 * 0 (such as netpoll) indicates we may be in an IRQ context,
 			 * however, we can't use the page pool from IRQ context.
 			 */
 			if (unlikely(!budget))
-				break;
+				goto out;
 
-			if (txq->tx_buf[index].type == FEC_TXBUF_T_XDP_NDO) {
-				xdpf = txq->tx_buf[index].buf_p;
-				dma_unmap_single(&fep->pdev->dev,
-						 fec32_to_cpu(bdp->cbd_bufaddr),
-						 fec16_to_cpu(bdp->cbd_datlen),
-						 DMA_TO_DEVICE);
-			} else {
-				page = txq->tx_buf[index].buf_p;
-			}
+			xdpf = txq->tx_buf[index].buf_p;
+			dma_unmap_single(&fep->pdev->dev,
+					 fec32_to_cpu(bdp->cbd_bufaddr),
+					 frame_len,  DMA_TO_DEVICE);
+			bdp->cbd_bufaddr = cpu_to_fec32(0);
+			xdp_return_frame_rx_napi(xdpf);
+			break;
+		case FEC_TXBUF_T_XDP_TX:
+			if (unlikely(!budget))
+				goto out;
 
 			bdp->cbd_bufaddr = cpu_to_fec32(0);
-			frame_len = fec16_to_cpu(bdp->cbd_datlen);
+			page = txq->tx_buf[index].buf_p;
+			/* The dma_sync_size = 0 as XDP_TX has already synced
+			 * DMA for_device
+			 */
+			page_pool_put_page(pp_page_to_nmdesc(page)->pp, page,
+					   0, true);
+			break;
+		default:
+			break;
 		}
 
 		/* Check for errors. */
@@ -1562,11 +1599,7 @@ fec_enet_tx_queue(struct net_device *ndev, u16 queue_id, int budget)
 				ndev->stats.tx_carrier_errors++;
 		} else {
 			ndev->stats.tx_packets++;
-
-			if (txq->tx_buf[index].type == FEC_TXBUF_T_SKB)
-				ndev->stats.tx_bytes += skb->len;
-			else
-				ndev->stats.tx_bytes += frame_len;
+			ndev->stats.tx_bytes += frame_len;
 		}
 
 		/* Deferred means some collisions occurred during transmit,
@@ -1575,30 +1608,6 @@ fec_enet_tx_queue(struct net_device *ndev, u16 queue_id, int budget)
 		if (status & BD_ENET_TX_DEF)
 			ndev->stats.collisions++;
 
-		if (txq->tx_buf[index].type == FEC_TXBUF_T_SKB) {
-			/* NOTE: SKBTX_IN_PROGRESS being set does not imply it's we who
-			 * are to time stamp the packet, so we still need to check time
-			 * stamping enabled flag.
-			 */
-			if (unlikely(skb_shinfo(skb)->tx_flags & SKBTX_IN_PROGRESS &&
-				     fep->hwts_tx_en) && fep->bufdesc_ex) {
-				struct skb_shared_hwtstamps shhwtstamps;
-				struct bufdesc_ex *ebdp = (struct bufdesc_ex *)bdp;
-
-				fec_enet_hwtstamp(fep, fec32_to_cpu(ebdp->ts), &shhwtstamps);
-				skb_tstamp_tx(skb, &shhwtstamps);
-			}
-
-			/* Free the sk buffer associated with this last transmit */
-			napi_consume_skb(skb, budget);
-		} else if (txq->tx_buf[index].type == FEC_TXBUF_T_XDP_NDO) {
-			xdp_return_frame_rx_napi(xdpf);
-		} else { /* recycle pages of XDP_TX frames */
-			/* The dma_sync_size = 0 as XDP_TX has already synced DMA for_device */
-			page_pool_put_page(pp_page_to_nmdesc(page)->pp, page,
-					   0, true);
-		}
-
 		txq->tx_buf[index].buf_p = NULL;
 		/* restore default tx buffer type: FEC_TXBUF_T_SKB */
 		txq->tx_buf[index].type = FEC_TXBUF_T_SKB;
@@ -1622,6 +1631,8 @@ fec_enet_tx_queue(struct net_device *ndev, u16 queue_id, int budget)
 		}
 	}
 
+out:
+
 	/* ERR006358: Keep the transmitter going */
 	if (bdp != txq->bd.cur &&
 	    readl(txq->bd.reg_desc_active) == 0)
@@ -3414,6 +3425,7 @@ static void fec_enet_free_buffers(struct net_device *ndev)
 	unsigned int i;
 	struct fec_enet_priv_tx_q *txq;
 	struct fec_enet_priv_rx_q *rxq;
+	struct page *page;
 	unsigned int q;
 
 	for (q = 0; q < fep->num_rx_queues; q++) {
@@ -3437,20 +3449,20 @@ static void fec_enet_free_buffers(struct net_device *ndev)
 			kfree(txq->tx_bounce[i]);
 			txq->tx_bounce[i] = NULL;
 
-			if (!txq->tx_buf[i].buf_p) {
-				txq->tx_buf[i].type = FEC_TXBUF_T_SKB;
-				continue;
-			}
-
-			if (txq->tx_buf[i].type == FEC_TXBUF_T_SKB) {
+			switch (txq->tx_buf[i].type) {
+			case FEC_TXBUF_T_SKB:
 				dev_kfree_skb(txq->tx_buf[i].buf_p);
-			} else if (txq->tx_buf[i].type == FEC_TXBUF_T_XDP_NDO) {
+				break;
+			case FEC_TXBUF_T_XDP_NDO:
 				xdp_return_frame(txq->tx_buf[i].buf_p);
-			} else {
-				struct page *page = txq->tx_buf[i].buf_p;
-
+				break;
+			case FEC_TXBUF_T_XDP_TX:
+				page = txq->tx_buf[i].buf_p;
 				page_pool_put_page(pp_page_to_nmdesc(page)->pp,
 						   page, 0, false);
+				break;
+			default:
+				break;
 			}
 
 			txq->tx_buf[i].buf_p = NULL;
-- 
2.34.1


