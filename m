Return-Path: <netdev+bounces-290997-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id t9A6NJcBEWq2gQYAu9opvQ
	(envelope-from <netdev+bounces-290997-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 03:23:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E3F55BC4D3
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 03:23:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E7A3C30028F7
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 01:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BEEE224AF2;
	Sat, 23 May 2026 01:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uwaterloo.ca header.i=@uwaterloo.ca header.b="df8TvMsG"
X-Original-To: netdev@vger.kernel.org
Received: from esa.hc503-62.ca.iphmx.com (esa.hc503-62.ca.iphmx.com [216.71.135.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920A517BA2;
	Sat, 23 May 2026 01:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.135.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779499409; cv=fail; b=pILLoHpBDu7Jc6swaNqbk/3Hi+W12GCw9fG4yEtGV6MNeElGpdCw6oL0Fzq70/kCiM5zTILvI1FQpjIsMM4xsGLhCyeLYzsaXZwZY1ajpf6OzgE+FP7JAqmirEh0JbelGrlG2/g1ozaGKuK9UyxDJsU1GvEHd0cQz7WR8B0EOSI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779499409; c=relaxed/simple;
	bh=ztFtA03+g5Mvl5Ri/EcQP8ASo+thvcH47lLSXwbWOMA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=V0kP1l5lEjFHJw/bU7QVqZdOJKawr9GwWhf8oKEVci6knZ4lcYUTJer2NRZoE6fVauGNiO7/fDC6+z0iGB0Z33UV1cH7cW4XQIFSlgfoCpxktMCsVSPllsFHbFDuiD3RY1QmnYpgukTACJRkdDhmAt06ODLRVtWGUFokw06q5+Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uwaterloo.ca; spf=pass smtp.mailfrom=uwaterloo.ca; dkim=pass (1024-bit key) header.d=uwaterloo.ca header.i=@uwaterloo.ca header.b=df8TvMsG; arc=fail smtp.client-ip=216.71.135.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uwaterloo.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uwaterloo.ca
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=uwaterloo.ca; i=@uwaterloo.ca; q=dns/txt; s=ces1;
  t=1779499408; x=1811035408;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=ztFtA03+g5Mvl5Ri/EcQP8ASo+thvcH47lLSXwbWOMA=;
  b=df8TvMsGN5KCB7/w++3eADWSuvBWRWitCzH3tEq4kcubl5MD/9ZO1cUZ
   Lk5O8/83GEyIBT00Hh3NDS8ITx3zn1ltPubS4nxYWV6CLUHfJffyryZ7i
   Suw24QmkZl9LRlxxp5ku7NUYws4Cppl+kuEl5zopHlsW1/wKST317NF55
   Y=;
X-CSE-ConnectionGUID: 7R4I3+VtTQ+eLDzBzumk5A==
X-CSE-MsgGUID: rd0I4cVyTAGvVQZIuo1zzw==
X-Talos-CUID: 9a23:GaCkL24ns9Jy2yyqLdssq3RIO5tmTGHh9TTdB2OqI3R0Tb7IYArF
X-Talos-MUID: =?us-ascii?q?9a23=3AGsULuA5Vn4zZXOicxUoQ8nUExoxy7/yPVEszgKk?=
 =?us-ascii?q?vlNe6DB5RJjDEniaoF9o=3D?=
Received: from mail-canadaeastazon11020126.outbound.protection.outlook.com (HELO YQZPR01CU011.outbound.protection.outlook.com) ([52.101.191.126])
  by ob1.hc503-62.ca.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2026 21:23:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RiNfT0m+b/X7nusYCL1A7afCeP+z5tvlJ1/SK6mhPYNBHiHatRATQrgGWDSMSBBLHcbTW40HuUtUnnRXmcDvClVoUURMPq9RFCfc1Uzu6B7R7mLHBeA/ca3TZ20O+lXGNYoHIS28zVwRHkA0T7P7U0q5QADqLG3xbDUBxdES4zG3Uv5UfX1wKqAbvaIYqGsHuUd7/IcyIl3wrOKXJENFdWiIyx0z92UYjIDDejwv177HyxWyy9mnoG4/orZF5SU9zJ6cqWCB5Bo76Ej7eBcEMuE3O/t4HvXlScQukBZWFbECMoI1zmFxtQo9EMBycO5ZX79IvC1Yif71OaOpiWK+RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KgY07HY5HUFrjqZgzxjdO0OTs8kJXxg1cCGN3fsjGXQ=;
 b=OcBQhK0QQPVUsYpqkStQV1bMVLQ4QwYs5jv1+5Y3SypdP4UaBziDhromkf1SNfs+fSOeaVQWWtIRIP4NUDBvBMkHv7t8zPVMELC/28NrtddhRwHuHUUzz+mGjBAaWJyJ+IR6qoFuT+k/OdekPaAgfQX/FKcrwF7fwNUAB59sxH7DZgKJgXx3UftALlw00yMDe8T8WXiVpt6JKHdpXDxUL8Oevucgm6NNSKqdQzj8fb7XFU4qLYKrfz+IOQdCUXoJVk3MSMjZpUfezGFjDtK64EcjN3EySUjkARnizRR7is2O/yDa/zFjL3tsVlq+Hj+3tgXxSg5yiqS4pfK2DxGVIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=uwaterloo.ca; dmarc=pass action=none header.from=uwaterloo.ca;
 dkim=pass header.d=uwaterloo.ca; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=uwaterloo.ca;
Received: from YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4b::13) by YT3PR01MB5231.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:60::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.9; Sat, 23 May 2026
 01:23:17 +0000
Received: from YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::ec62:77d8:42d1:10fa]) by YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::ec62:77d8:42d1:10fa%6]) with mapi id 15.21.0071.007; Sat, 23 May 2026
 01:23:16 +0000
From: Martin Karsten <mkarsten@uwaterloo.ca>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: Joe Damato <joe@dama.to>,
	Tariq Toukan <tariqt@nvidia.com>,
	Gal Pressman <gal@nvidia.com>,
	=?UTF-8?q?Bj=F6rn=20T=F6pel?= <bjorn@kernel.org>,
	Frederik Deweerdt <fdeweerdt@fastly.com>,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4] net: napi: Skip last poll when arming gro timer in busy poll
Date: Fri, 22 May 2026 21:22:20 -0400
Message-ID: <20260523012247.1574691-1-mkarsten@uwaterloo.ca>
X-Mailer: git-send-email 2.54.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0171.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:110::17) To YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4b::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YQBPR0101MB6572:EE_|YT3PR01MB5231:EE_
X-MS-Office365-Filtering-Correlation-Id: b713b6b8-5120-4c29-1f6d-08deb869ddc1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|786006|7416014|376014|18002099003|56012099003|11063799006|3023799007;
X-Microsoft-Antispam-Message-Info:
	tTM1g2LaAvvSXuTFrkxRk0hiqS4cg71WvzYVWwbrvelwAt8x9MUs689hvZtumaMFx5yuGJsV5KfynteganR+3tTZHUyA60rhJm6c5L4zHk59O3PJGuEoZF++UFa/RqA1WOEwQ3n5pzFO5cTlv5c2NTxO0DjS2TkaEL2Deic0JdGfMkhPNOM49j/KXvt9w3K5zTZ2flehn2RuVkz7JCNMUyc/MlJIpN7dQv17746q00AxEvZoaSrrEfevLXwYm8AQqwb8LdekYq17UWV4E1aj1N+ZRPlpkbUjav3D8liplqZ1gzwwcHTw9QMA2ttwHo6T58b101EgMHMcvCfXUguaFtkHHLZIdofFZArd3iBRafwo75IasIPHWWEsodVxkjmrxCiE5wv040aejl2y644xSsDj/CC5L96yytPH1cPRiN0JCSrnRvFZ8thUWYAOh/bOPi6bpiMq2BoT20e+UqrFrYt2wOxR0FhkBLEjETOLvEIZ3cOHIIJ3qDT26kFC9hJHPfh7+oF8XLmKwxC1016g5SofwZZd2AeCbsUcyy14x8s5QPMXn2N4k6rMidQEPMAsYxPGC0JSH1Ub8usFx4w8M9xRdwwyadfbxwLPtixgKOEA71ASb3SzWybOlBmDr721p0OySGcgE570w3ka2x+rW+0z7t0OmqikBMQ3/DavGwBqC6ULtBELjrxiqOrsWYYIupVfpHcJbayPI47CYBMuyQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(786006)(7416014)(376014)(18002099003)(56012099003)(11063799006)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iLxO3O9RpPY7armUFagXM/VOI76aYQbALR5OegcikxjfD+ZFXgeCTpCEfiT+?=
 =?us-ascii?Q?Xdl3euGyYYHKRb6P6MeCcU8F5edcwNUtTNTycwMo0jhLF0zUnKFE8J6AsNMz?=
 =?us-ascii?Q?czUdX8lm/seRJkMxwkLHYkRzYSNUdJDxgB1jYNNNVFiDH0Uq+mhGoufEfCtV?=
 =?us-ascii?Q?ALrCep7aXhOpdSTeuwaraSBcGxgL3472QoPIoWMT01UtFHVfoVj4jrqShB6j?=
 =?us-ascii?Q?2+svNVXK7ETOvlJB3ltdMt3UrM0BYSkmZTvtKzzBG1WlGa713dDWK6EwIQKt?=
 =?us-ascii?Q?mJCfOXePOYSQ4uLZcOP8eXgO98nBmVempkHekJEdMELxd+1hHZlUkqEMfrDA?=
 =?us-ascii?Q?fVpiXQ+Tvt5b2MIcNSNlH58Mwelmqcn0Bg8Bm6+0m2tuWJjdSm7fNj91qFoc?=
 =?us-ascii?Q?KF1UWHllqBRtSEcsMoYrvar5SYjEcAmMCqcNSr8oqXEbuDEvmqAEgiThLCv4?=
 =?us-ascii?Q?qjd/c9bs0RNkyF6uZ8LENATuE4brQwHu8PGSj7wIHjBk2tm0MZmwLE10EK7U?=
 =?us-ascii?Q?K9C/3JQqOW0PaAyiKy/GhPt4XSiRVzbDJwThgbbGs6wgUo4jq7orf4fKDI3x?=
 =?us-ascii?Q?n2ICP4k4mmFH17HWKQ8jqY2L3tTRJ9HOsnGkoLgoXi/Xq0G59eYDMe/yzeID?=
 =?us-ascii?Q?5z9Edpas4CiSfZakKPl8t5/iWnyayD7zgp6oIYSsb5bukP5v4x5TTdYfs5Ne?=
 =?us-ascii?Q?4KYbWK9aMKzi/POzzPJQdtFOY5UrpNo2doTJcVTTGtE6ApKEvXmDR7aAa5q+?=
 =?us-ascii?Q?lfdgXaMUocL8KGFeEqASM47sN4ha5kdRXV0/jJGkl1qC46bRnYTQqLY6nUG1?=
 =?us-ascii?Q?5PnkOGJvDipFzPNu6zglI44FviUX/Fok6cjyyPX7BM7bz+TB/y51dG1k9Nut?=
 =?us-ascii?Q?lVaLXuAPO8qIV39YHXM0BHj5PxE8nlzPDICVr5xU+deJOHzq7D5fKpJCvZb9?=
 =?us-ascii?Q?3SVjX4nfv2cr0ENrPIawxM6wJAUmSciarZXFsBPzlio2eaM/yhENMrdM4h2X?=
 =?us-ascii?Q?yKXmIk2H2tHq6ST3pcHQpkE+PGqYwli5pgh8A4SSZUe27aeWUFmEXHY4amTt?=
 =?us-ascii?Q?a/jVfH0ezNLQZR5O8PjmHDKrPnszf+vDknvCzcH6LU7Xkbf6vLkBptKwM48J?=
 =?us-ascii?Q?qF+RPcDp4baDWnbfef/OHHge3dtsyMqeP5YNiCcP7lDELhTQ9EeJmNaHsulI?=
 =?us-ascii?Q?nxxQmORIkTn3oPQ/KhAMGENM5s5nEvnBNqQ/DprR6xTzy9RBe/0Q4cMJyhrw?=
 =?us-ascii?Q?JlS4F6DcUKbe4lKXdcfpbQgUpGwoPu4mH1tjrK7lZ4Weu2MraFOtTU9nMvRf?=
 =?us-ascii?Q?0C6oK7IhfaGPnH13bLWdUqEyv9FFl2PDKLN77iSqM3lidZXQykhyTvoqVID8?=
 =?us-ascii?Q?pTvZvXS4Wr9VRJi10mFPOSM5B6HJUcIzIjS9HgM9PAXxwuHwr692K2EFI1L7?=
 =?us-ascii?Q?IPF6fOOJAB9M7ssMqQXzdKdRK5Xhypr0vYbm0It30jQZWMEwdYtvN/k6/Cp6?=
 =?us-ascii?Q?55489dyLEK2TuGLFhAaZ21x7zl10yhALsaQuYjO6CqZrrRtWwI0qMig6goxO?=
 =?us-ascii?Q?y2+6+0iakNTomoGrP02+vCPrkRX0Zi1s+rjtkOBNylpgyrsVGbI2KBomD9B+?=
 =?us-ascii?Q?8jiMGg6P5ebOYg8QvHb5aluHWl1ujtswcBalbBr+fwQwgVXFbdlr0BCdaHC5?=
 =?us-ascii?Q?BUM4VIHZEbl7gXzV7KW3f1j+TH1VkF30xA+GpTMzCY+eDdqCtw5phHuFb++S?=
 =?us-ascii?Q?6wqya8dJ+A=3D=3D?=
X-Exchange-RoutingPolicyChecked:
	Z0asZfTEZQ6++VXHszih0GAxPTWJ1cG+Zhpop4ndRNWQeemDgIgYKtJj4HAxDHjCD4FaZzO9f1KZlsVYPSWjcvb8baZ8x8Bh9cuPmuIvuaVKZGa5c0nqj7Cw+VLpLJQjdXjooxdPqxfMoH6ZxsYWu4UnmkNaiKgeFct9WWw9PTzvcw1ZCyi/qajGCnXMEGyjdLOLx1u/CMVp/DOlZ66jJvR4w9A+u0tsvWy7+tYbyk7zdNOv1LZHHpWWkH1S7niXEeqEnx/pyk32bNp+34nbeFloEAMnWFKf7cXKanGAoLEBDpA3xLRa37RD3jBpM3u+JLI+1L171yuhVOTzg/quMQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Bg/CL4oy97hNNUf1g3pNFy1w+TfKlvY4yXItQFLUAStmEQ6tEuFBio/Qqtrc9HRbWJJE70wYza7mz9CuOlZEBx77t52I16wpUR65EsqADZhxlY0UiaZx6Of1TYGlawVZNG7dNLfblDSoFUCtTwVDBc36pVjXXvjWCQY9R51QjkdUnN87ZZbONDZFYrIEbEGXpeaixZ+9hNrcBBij6bDHoTss8USF/LEEgp3CqfJZwa+Thab24QPw1ttKdBbsIu082Ch8JvPJWvzdOSMCCpG7cFpleD9qf1Fb6lR3Ow4VGV40upXhPxn8UGX6X9vj1RsHEssx7CdYymOSrevF6qhfufYoUiH//Q8xgGU+dUQzUuiKQrxfQ2LQwXU1RfLpIWtZpe8IqjNnfcDSPMh8/7o894U0o+RTpnrZ+/zAdY2Q6DvKjFi4M9x0TiJuVqAf09BtgUr+HsoZpwYf9qt85BuNzd5ImjRBuG2D8xkpte6wS92LOvOQxfYwsIaBOJFWV606UPZhjHYd70PvWdhC/D8xgjkNO5e755q0FhY9prtNv9sPw+pgKdvjdvdsopEqmKP0KwnF97y4hg04PJETeEmFDeW1L6IpxJTfxMpVnsIVi7dRWnkidkIVo0liagu5IdVv
X-OriginatorOrg: uwaterloo.ca
X-MS-Exchange-CrossTenant-Network-Message-Id: b713b6b8-5120-4c29-1f6d-08deb869ddc1
X-MS-Exchange-CrossTenant-AuthSource: YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2026 01:23:16.5888
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 723a5a87-f39a-4a22-9247-3fc240c01396
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JB2IBMOul0M8aSyy/AS5VKNRACUN0QSr0lNLZJjeB17FTh/aPAfGm1B80Xhx1AZqGpEq3UPPLuZFEWvSdGWZAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB5231
X-Spamd-Result: default: False [2.54 / 15.00];
	CC_EXCESS_QP(1.20)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[uwaterloo.ca,none];
	R_DKIM_ALLOW(-0.20)[uwaterloo.ca:s=ces1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-290997-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[mkarsten@uwaterloo.ca,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[uwaterloo.ca:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,nvidia.com:email]
X-Rspamd-Queue-Id: 7E3F55BC4D3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Skip the extra call to napi->poll(), if the gro timer is armed at the
end of busy polling. This removes the need for having a separate
__busy_poll_stop() routine and its code is moved directly into the
relevant places in busy_poll_stop(). Remove obsolete comment about
ndo_busy_poll_stop().

This is a follow-up to commit 58e2330bd455 ("net: napi: Avoid gro timer
misfiring at end of busypoll"), which has deferred arming the gro timer
to the end of __busy_poll_stop() to eliminate a race condition between
a short timer and long poll that could leave the queue stuck with
interrupts disabled and no timer armed.

Co-developed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Martin Karsten <mkarsten@uwaterloo.ca>
---
Changes since v3 [1]:
- Update comment following Paolo's and Jakub's suggestions - thanks!

Changes since v2 [2]:
- Fix patch formatting problems.
- Leave STATE_PREFER_BUSY_POLL bit set when timer is armed.
  Don't want interrupts anyway until timer clears STATE_PREFER_BUSY_POLL.

Changes since RFC [3]:
- Sending only the cleanup/improvement patch to net-next.
- Expand commit message to summarize original issue.
- Streamline control flow.
- Improve comments.

[1] https://lore.kernel.org/all/20260518181337.886459-1-mkarsten@uwaterloo.ca/
[2] https://lore.kernel.org/all/f0ecdde3-de16-47ba-b795-fe0042114e96@uwaterloo.c/
[3] https://lore.kernel.org/all/20260428175134.1197036-4-dtatulea@nvidia.com/
---
 net/core/dev.c | 62 ++++++++++++++++++++++----------------------------
 1 file changed, 27 insertions(+), 35 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 26ac8eb9b259..a50cd68c6bfa 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6863,22 +6863,6 @@ static void skb_defer_free_flush(void)
 
 #if defined(CONFIG_NET_RX_BUSY_POLL)
 
-static void __busy_poll_stop(struct napi_struct *napi, unsigned long timeout)
-{
-	if (!timeout) {
-		gro_normal_list(&napi->gro);
-		__napi_schedule(napi);
-		return;
-	}
-
-	/* Flush too old packets. If HZ < 1000, flush all packets */
-	gro_flush_normal(&napi->gro, HZ >= 1000);
-
-	clear_bit(NAPI_STATE_SCHED, &napi->state);
-	hrtimer_start(&napi->timer, ns_to_ktime(timeout),
-		      HRTIMER_MODE_REL_PINNED);
-}
-
 enum {
 	NAPI_F_PREFER_BUSY_POLL	= 1,
 	NAPI_F_END_ON_RESCHED	= 2,
@@ -6894,8 +6878,8 @@ static void busy_poll_stop(struct napi_struct *napi, void *have_poll_lock,
 	/* Busy polling means there is a high chance device driver hard irq
 	 * could not grab NAPI_STATE_SCHED, and that NAPI_STATE_MISSED was
 	 * set in napi_schedule_prep().
-	 * Since we are about to call napi->poll() once more, we can safely
-	 * clear NAPI_STATE_MISSED.
+	 * Since we either call napi->poll() once more or start the timer,
+	 * we can safely clear NAPI_STATE_MISSED.
 	 *
 	 * Note: x86 could use a single "lock and ..." instruction
 	 * to perform these two clear_bit()
@@ -6908,27 +6892,35 @@ static void busy_poll_stop(struct napi_struct *napi, void *have_poll_lock,
 
 	if (flags & NAPI_F_PREFER_BUSY_POLL) {
 		napi->defer_hard_irqs_count = napi_get_defer_hard_irqs(napi);
-		if (napi->defer_hard_irqs_count) {
-			/* A short enough gro flush timeout and long enough
-			 * poll can result in timer firing too early.
-			 * Timer will be armed later if necessary.
-			 */
+		if (napi->defer_hard_irqs_count)
 			timeout = napi_get_gro_flush_timeout(napi);
+	}
+	if (timeout) {
+		netpoll_poll_unlock(have_poll_lock);
+
+		/* Drain aged GRO packets before clearing SCHED since the NAPI
+		 * won't run again until after the timer fires. When HZ < 1000,
+		 * GRO age comparison is too coarse, so flush everything.
+		 */
+		gro_flush_normal(&napi->gro, HZ >= 1000);
+
+		clear_bit(NAPI_STATE_SCHED, &napi->state);
+		hrtimer_start(&napi->timer, ns_to_ktime(timeout),
+			      HRTIMER_MODE_REL_PINNED);
+	} else {
+		/* Use driver poll to re-enable device interrupts. */
+		rc = napi->poll(napi, budget);
+		/* Unless rc == budget we no longer own the NAPI instance,
+		 * IRQ may fire on another CPU, poll this NAPI, and enter GRO.
+		 */
+		trace_napi_poll(napi, rc, budget);
+		netpoll_poll_unlock(have_poll_lock);
+		if (rc == budget) {
+			gro_normal_list(&napi->gro);
+			__napi_schedule(napi);
 		}
 	}
 
-	/* All we really want here is to re-enable device interrupts.
-	 * Ideally, a new ndo_busy_poll_stop() could avoid another round.
-	 */
-	rc = napi->poll(napi, budget);
-	/* We can't gro_normal_list() here, because napi->poll() might have
-	 * rearmed the napi (napi_complete_done()) in which case it could
-	 * already be running on another CPU.
-	 */
-	trace_napi_poll(napi, rc, budget);
-	netpoll_poll_unlock(have_poll_lock);
-	if (rc == budget)
-		__busy_poll_stop(napi, timeout);
 	bpf_net_ctx_clear(bpf_net_ctx);
 	local_bh_enable();
 }

base-commit: 6ec863c1848167fdd7124717a24f0a2b99e160ba
-- 
2.54.0


