Return-Path: <netdev+bounces-257066-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8OSzNVNehGnS2gMAu9opvQ
	(envelope-from <netdev+bounces-257066-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 10:09:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 03823F0567
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 10:09:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B1746305703E
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 09:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09DCF3A7F73;
	Thu,  5 Feb 2026 08:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="nUYQtEIR"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013020.outbound.protection.outlook.com [52.101.72.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4BC3A7F6C;
	Thu,  5 Feb 2026 08:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770281843; cv=fail; b=JjsKx2I9xRvLey8T5L3FM+CWHY9qC5wl2LdcWuUUTBNkcFn6Nimq7+a8Qvypm2t0vepZ0sHjfJqABmOSOmIIWH9zrjtx5ynJ1iUbyZGIrzRfDUhY8jFjsrYHbOkC2FuHSmmDPkSVdmfmO6+4U12NNmLdEEQAXjKW/+kz0moyA6U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770281843; c=relaxed/simple;
	bh=n9d1gpLjcv6fscTVso+T/uM5fEb7Q6EnJJEuFN/yVck=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SEJTl4hutQbykLZBasoQo8IlayKE00Sw6to/SMpraiBtVXbnx/CJml2+CEkwKkRrmz2b97NpUtNWfGPsGYx7cVckqKiUYtMEunFSWi4HOwsLRxKQfC9gj8UgTrjkvRQRwhtzNaLKXfA1CgOXglmzORfnO2gU9G2noCQnbbF94ts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=nUYQtEIR; arc=fail smtp.client-ip=52.101.72.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WpxKGH97Fe8hHj46kdicJwlK3bIa/Gstmkht8KiMYWhM6T2j3SjzA7YmBQ20Jn5uwRpicVvlRWAK7l9UWzhI5R0hjOkFbDvNuZgnWCwt11Ey1A3X/M4bZXIsGmQ+UChmVkILWyYO0ckN0Pi5GUVY0dNMZbKCWInDJYq4q92ny8IbD9toWdqL5wIYy9EPI/n4iGHZpmXs/Pm0t2uZYwJei2RWehS9AIVkMcZ+zxI2a0CGBm68gegJHea1dhOqyTtfUCQDz0ywTMnmLaxjbn18J4PBzicjMNZLKexsLFT9/3LOHjZvPEaqq6Bcem2Wl2Vm/zn02YXPoKUZoPgGUnNbVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AFJYNqjXX6OYmSNFTrWo3t7+yInzkGY9ICatj6vbevY=;
 b=ey9cxUwO9tXgz6Y6PRqp9sU8gg7R1eUnvUdfA8Ryn1f/y1Z3SMu+rfJy35X/EofiybYdJmSmzjpP687C20xTfoHdogDYnBC1S/22TFMqXPeikCEP+l7VsW2orpUOJDznXXcplxX0tG+Di5NPrOBZq8UovoLTgqmoJB7PyzvE4bbEQbH8q+B1GtFJQMSyrgbTUN4S3zHVm9GtSyySVlS+VsmRADAroHKBy6655PUIJ276TkNZWRycgckluK9N6v84aRUVOtmxgM6UhZ/b82kkkVoeu+Pqdp/5QpokzcxSiBQ52/Iv4ra5nzulj1GFTbSXW2IlQkf6YFmXtX4CKfsx1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AFJYNqjXX6OYmSNFTrWo3t7+yInzkGY9ICatj6vbevY=;
 b=nUYQtEIRzi33gdCdA7Kom5TY63fFpuNLVXIL/8Z0S4IF2qlZOrj254a6zUR+lm6G0RSOQDP8872uhkpxH595VkBcjqnOw+LmsHwC10QBpwj3qwiSMlYLgOG16rgMODii7auh/2VtrD8jShpNP2/6pACFPeITNujmiH7lyW/Wkr+M2SBHgBbnaLeHkSTjExhzUqbq3/ky7lCF0NRSszU3C4+TnBQDFR2MQ74nWarF+Mh5/JARsJnDdbq5fMnvWOGezkd8lzTuX+CDH4hQuNhDR4PDGidvHUL3mLXCir+4icNmTm8M42wpQx/8dDn3SuOfS5ISFTtqAJuL7Y9ELn/pJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PAWPR04MB10007.eurprd04.prod.outlook.com (2603:10a6:102:387::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.14; Thu, 5 Feb
 2026 08:57:20 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694%3]) with mapi id 15.20.9587.013; Thu, 5 Feb 2026
 08:57:20 +0000
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
Subject: [PATCH v7 net-next 13/15] net: fec: add fec_alloc_rxq_buffers_pp() to allocate buffers from page pool
Date: Thu,  5 Feb 2026 16:57:40 +0800
Message-Id: <20260205085742.2685134-14-wei.fang@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: b309d039-f927-4cd0-2edf-08de6494925d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|366016|7416014|52116014|376014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pycaffAms+BOSuTQ23gWnLVUrR+iS8l7Ffcssoc01OLcXF87/paRPUIy26CG?=
 =?us-ascii?Q?R9+acqFjSz4KYfRZO9IqCkNDPx8/pLNHUbyz8Sw0SP//qdF6i7kmLWGn6FbL?=
 =?us-ascii?Q?b4EEMi/ggsY48NIOvgWRNpOqNLUixKnuyzpgYxiTp/iJHNURmqFkR3bHi7xm?=
 =?us-ascii?Q?Y5Br7Ia2U3MTUHTrykN4sWNOOTdkPA0QQtP7NE3yuwD78gJCGmNy2LTMe02u?=
 =?us-ascii?Q?BZkmJ8DS92mNSbeRxF7RB3dun5WMxRiMNYdZiIJjiIYLDnSFDOsNJ8anmqjY?=
 =?us-ascii?Q?AX40iJWXpWVZ7qu7Ty0VCT1ao41r4/6HbqaRQJAVneO23AhrzcT5ThD8G+EM?=
 =?us-ascii?Q?TE9Q5sog/G/DeYtJNwMGPIngoZkCbgtWnVSinbMeFRf5MeEUxzF6WTgfY8K6?=
 =?us-ascii?Q?B900SQ24VExIMJnV8KFnE6RMI5V/EFW4MXy9eMY/+cRFUCGWkTpaHaVfUijH?=
 =?us-ascii?Q?dmxRDkyW3f7wDHY0yHQpTAlq+9B2cZcuh4DwbSseDozaPwk5vNO3a0x3T8ft?=
 =?us-ascii?Q?gTiAFhADprxcDNAumk68msVRIgRf0YgC/1zDJJHLzGTOA8gC1MpGKRUJW3n1?=
 =?us-ascii?Q?7AfAhiW0ppDrwWUCM33bMBfnYqdE9sdZzAbUbmxH+VxB0af+9irBWFU5QbVm?=
 =?us-ascii?Q?RXyBEhgytrtmhafy4jJOg9gnciTwNA337NyEtTvHFyiemG7QvNbA4PvOLbCV?=
 =?us-ascii?Q?1F9sV4SMPztJ8TmfwWRtLKhsy2soSuJdyxChG77QMFg+Mqw3bJFFeMH3XG4I?=
 =?us-ascii?Q?UOlCeU9KfD6gUkpbw/fXV1VINdEBAt+Ya3uHcw5rQPrSmUtn0pYmCC0W/QbK?=
 =?us-ascii?Q?hnIyUMrfJqwro5gaMdqb5MiBIeknJl6pFUZ5MXLW+rE0BgHqOzrb9JgW84zi?=
 =?us-ascii?Q?iK3X8rIyzcFY+eDvNckzbOV8kdloaaJ21lYTWn3S1QZ++fqdKVmQJuv2T4UB?=
 =?us-ascii?Q?2Qb+JkqEWGb3vVwIPmXNehcVcHfTZcWyZ+qLHuODMIwA+eUsEAT+TSypKKZs?=
 =?us-ascii?Q?agPdjvjYO3s7a1nNCWGWBz4UntfpSpwCjo2Crx/IUfYJz4ftViZTFOSGrjua?=
 =?us-ascii?Q?BPNo0tq9phwoyqFlcOfsazQszpqu9sfdWbBffg5VP+Bh/g4kiK7E0TB5YRv7?=
 =?us-ascii?Q?5pofQgK8VU5PaeC5zriNKDoxBfmggiUhh8zbllLDE9utWowjSD17C2+qbiMs?=
 =?us-ascii?Q?ozM+Wj3MblWg+d5eFjKu48IvoqNlUlYojHL6Lhc1mx8PN0Xb9o4bPdAPTHTG?=
 =?us-ascii?Q?YZbUKyHiWPNJX6SYXaYHPzLRZUaxUq5L/1LwBYHty8EYymTFpDF+uf720q5m?=
 =?us-ascii?Q?NljyRglCzHEb5EFoEohCRMklAj9bEMqaXcls8CTn7mOOittHipUV7eWPu9FV?=
 =?us-ascii?Q?CrsvQ5VhFIWsVsA+8RZgcgzlnH+ANjop+UyeB7U8weEu4dSiKpBFgysKWzEO?=
 =?us-ascii?Q?Pp2dTQ7ROSKlyKFekvRPy0HGjnv+gN8ag5Fjp16jOlBsP04C6MC9XIosbnlX?=
 =?us-ascii?Q?rFn5EgrArcU87r3i6BUssYXvq/ISdKhsA+Fqzbjm2MKrLChwVwTtf2UfZTlX?=
 =?us-ascii?Q?18CzVb9Unh9Fh+9YLZhGVxpAB2TjMG6+/xZxQOaB8Xr6Of647lDzQHXqg7Jn?=
 =?us-ascii?Q?08WK6oGik0I9DOWSiYOSkc5WQL2RRCDXDBGcIP3hCOwr?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(7416014)(52116014)(376014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kSUPNEegHdk+3sywLjLD+F2aJDOcwFeTZHzEx3viy3rHs/9DzVHrhoJOZqYm?=
 =?us-ascii?Q?8QFKL5AQo3me6pl/htwktiqdLHL8o7Nca0JjZ7o4YJqZduczQBlDGXSa/NEz?=
 =?us-ascii?Q?s0Af9yXdB7N5xArCumhf1rG7cBNwYCnlL1kusIjYO6+Op47zvR4ihOj56pPs?=
 =?us-ascii?Q?Wx4xbAimJtn0nO9iRHVeycvh1dRv0M86O+dGeUVMhuo1jxoGzGWfOT+/MzTw?=
 =?us-ascii?Q?r+tnctn25CUvUwp8FJ1wth1PQw6A+bsNbdlD11C0BKD//QfUxsbkVAc0pcfM?=
 =?us-ascii?Q?P8AIma+crlDsHT4JtNX4Wj9qVnxxjD67KJvAAU4l1v6OOsi05Wrfq8Zg2Ga1?=
 =?us-ascii?Q?ZagiP1ssgLAXFNP2sCRiID9xeeIsKZ5aUUwagEt0KA9g7qeE9sAkqBROe12W?=
 =?us-ascii?Q?FJfuT8c24JHq53SfdDr22PjSeTC/Iccj+FECtfrQ6LotptfcsJymqRr/Difo?=
 =?us-ascii?Q?VWtOIcJz/6FzvCy2qXhI8+s7DkSMiTImi2SZWm9vI+Jn2VExSedNZi86u4M8?=
 =?us-ascii?Q?Wb98Mw45zYo6XWmKLg0BG1TpK3nns8yGjTIcJECf4hmmfYOdYuMlnF8i9f+I?=
 =?us-ascii?Q?Kkw8UzT8nNVGmbnx2Rw3VcTRPcUN1SgWhwJfyGytmbLZDeaN+HDtONEnux7s?=
 =?us-ascii?Q?7++RHbeGA84JMtBfaLdDr28EpvjShK7LOuzWS7Slv3Gdb35npov62/ICET44?=
 =?us-ascii?Q?Ql5BbuHtxDQAz0sUF9KOax1JUX9YU0Mqa+r5nzMdrPlVaa3eKS0jZupi4Duq?=
 =?us-ascii?Q?UETR5rjjwXEZnxOIWkpHm6wBTNYfatYjX47rX3ozntRN/uOfzOfg2W/B/dH3?=
 =?us-ascii?Q?X+1PWWCEotySrPmvio3Kop4DZKBhYrLtcfEVsC1tu14HMQpPTsVmx/Q9Gie3?=
 =?us-ascii?Q?LXYp02iQ1OHww/qd3HrBiLJukOLyYFq1ugWHgKtE6DPGADX4a3Ixhvg3tTPs?=
 =?us-ascii?Q?BejkfqDkx0mSwOAx4zo9irfIybUxZuez9HMpG6ALXHx2sXXN+pOnq0JmAWW1?=
 =?us-ascii?Q?stzKZp1P078h2Qk41NqgSzvZjEDv97JQ1pZy18wAV4fFe9dZfymv1X6KGCnE?=
 =?us-ascii?Q?p+lexSvalFJbkU/TVjLQzsRZrQfaA7dKUsOKaq3dG++t3Q0T/weK/x/Em5/L?=
 =?us-ascii?Q?in1AAJBww8zyFcPy/03bf9Or1J3/T0epnqD2hIFMlOONoDkOIzdAB+JRa1T1?=
 =?us-ascii?Q?rMLhpF7eQo+VAwJaXb+UQG6fYB7gHfopF1MJv6mk/lXqBRXELOp+L3hC2OGg?=
 =?us-ascii?Q?RGuUOWamDMh5BMPHfZT+8S6yMTU6NyUyqwDFJKLVJilhFFIUSZ5F/6H3dcqY?=
 =?us-ascii?Q?wAG3U4fh0Z8cr5U7O28p0qMYt5ghF5zj3swJclWU5EZ+4UNsKWaRTUw0g3Bn?=
 =?us-ascii?Q?1NBtiBgtbAGJGCFvUhk+p8eDtgfpJUxys8KO6ZCrNIeDe9PaDdwZmsarea/j?=
 =?us-ascii?Q?C59qgdxo8f52mR9uGoJllGDIv3kapd80n2CExuC6XUCM+m4uK9JumaP7hfFK?=
 =?us-ascii?Q?K2WV3FAJ2r2hw4RSRD7tUKEfR1qz/aQwy5ll8OzQufRTVfT0B6ntWhdrzA6s?=
 =?us-ascii?Q?PNxJgkiCV5CzhanWQz8Evhc9cgF39QbLk3HYRfuta/+dL5Xkusv+0KSmGWmZ?=
 =?us-ascii?Q?/GOBHuU471UCDtDJhWU4QyDTkvdJJKkebcBdH+1CSb6ocakt3LdM5Lt1Q2Pk?=
 =?us-ascii?Q?Uv0tFKhpEtHwzQY5ffCdfSmSZrccsZQtf33c+tLDxlnMUx6Rd8YGOdrwJrSn?=
 =?us-ascii?Q?z024dlEZiQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b309d039-f927-4cd0-2edf-08de6494925d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 08:57:20.7932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I1lT9cpU7mrI20bTJO5dPzI3SsF3nh6cWRWMVNh3Z7x3BnfgfYvIokirjUNoKQVVU8g3ncb3MGPwUE3UlFSwoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB10007
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me];
	TAGGED_FROM(0.00)[bounces-257066-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 03823F0567
X-Rspamd-Action: no action

Currently, the buffers of RX queue are allocated from the page pool. In
the subsequent patches to support XDP zero copy, the RX buffers will be
allocated from the UMEM. Therefore, extract fec_alloc_rxq_buffers_pp()
from fec_enet_alloc_rxq_buffers() and we will add another helper to
allocate RX buffers from UMEM for the XDP zero copy mode. In addition,
fec_alloc_rxq_buffers_pp() only initializes bdp->bufaddr and does not
initialize other fields of bdp, because these will be initialized in
fec_enet_bd_init().

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 90 +++++++++++++++--------
 1 file changed, 58 insertions(+), 32 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 312d9b87e615..8f57040d515a 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -990,6 +990,13 @@ static void fec_enet_bd_init(struct net_device *dev)
 				bdp->cbd_sc = cpu_to_fec16(BD_ENET_RX_EMPTY);
 			else
 				bdp->cbd_sc = cpu_to_fec16(0);
+
+			if (fep->bufdesc_ex) {
+				struct bufdesc_ex *ebdp = (struct bufdesc_ex *)bdp;
+
+				ebdp->cbd_esc = cpu_to_fec32(BD_ENET_RX_INT);
+			}
+
 			bdp = fec_enet_get_nextdesc(bdp, &rxq->bd);
 		}
 
@@ -3436,6 +3443,24 @@ static void fec_xdp_rxq_info_unreg(struct fec_enet_priv_rx_q *rxq)
 	}
 }
 
+static void fec_free_rxq_buffers(struct fec_enet_priv_rx_q *rxq)
+{
+	int i;
+
+	for (i = 0; i < rxq->bd.ring_size; i++) {
+		struct page *page = rxq->rx_buf[i];
+
+		if (!page)
+			continue;
+
+		page_pool_put_full_page(rxq->page_pool, page, false);
+		rxq->rx_buf[i] = NULL;
+	}
+
+	page_pool_destroy(rxq->page_pool);
+	rxq->page_pool = NULL;
+}
+
 static void fec_enet_free_buffers(struct net_device *ndev)
 {
 	struct fec_enet_private *fep = netdev_priv(ndev);
@@ -3449,16 +3474,10 @@ static void fec_enet_free_buffers(struct net_device *ndev)
 		rxq = fep->rx_queue[q];
 
 		fec_xdp_rxq_info_unreg(rxq);
-
-		for (i = 0; i < rxq->bd.ring_size; i++)
-			page_pool_put_full_page(rxq->page_pool, rxq->rx_buf[i],
-						false);
+		fec_free_rxq_buffers(rxq);
 
 		for (i = 0; i < XDP_STATS_TOTAL; i++)
 			rxq->stats[i] = 0;
-
-		page_pool_destroy(rxq->page_pool);
-		rxq->page_pool = NULL;
 	}
 
 	for (q = 0; q < fep->num_tx_queues; q++) {
@@ -3557,22 +3576,18 @@ static int fec_enet_alloc_queue(struct net_device *ndev)
 	return ret;
 }
 
-static int
-fec_enet_alloc_rxq_buffers(struct net_device *ndev, unsigned int queue)
+static int fec_alloc_rxq_buffers_pp(struct fec_enet_private *fep,
+				    struct fec_enet_priv_rx_q *rxq)
 {
-	struct fec_enet_private *fep = netdev_priv(ndev);
-	struct fec_enet_priv_rx_q *rxq;
+	struct bufdesc *bdp = rxq->bd.base;
 	dma_addr_t phys_addr;
-	struct bufdesc	*bdp;
 	struct page *page;
 	int i, err;
 
-	rxq = fep->rx_queue[queue];
-	bdp = rxq->bd.base;
-
 	err = fec_enet_create_page_pool(fep, rxq);
 	if (err < 0) {
-		netdev_err(ndev, "%s failed queue %d (%d)\n", __func__, queue, err);
+		netdev_err(fep->netdev, "%s failed queue %d (%d)\n",
+			   __func__, rxq->bd.qid, err);
 		return err;
 	}
 
@@ -3591,36 +3606,47 @@ fec_enet_alloc_rxq_buffers(struct net_device *ndev, unsigned int queue)
 
 	for (i = 0; i < rxq->bd.ring_size; i++) {
 		page = page_pool_dev_alloc_pages(rxq->page_pool);
-		if (!page)
-			goto err_alloc;
+		if (!page) {
+			err = -ENOMEM;
+			goto free_rx_buffers;
+		}
 
 		phys_addr = page_pool_get_dma_addr(page) + FEC_ENET_XDP_HEADROOM;
 		bdp->cbd_bufaddr = cpu_to_fec32(phys_addr);
-
 		rxq->rx_buf[i] = page;
-		bdp->cbd_sc = cpu_to_fec16(BD_ENET_RX_EMPTY);
-
-		if (fep->bufdesc_ex) {
-			struct bufdesc_ex *ebdp = (struct bufdesc_ex *)bdp;
-			ebdp->cbd_esc = cpu_to_fec32(BD_ENET_RX_INT);
-		}
-
 		bdp = fec_enet_get_nextdesc(bdp, &rxq->bd);
 	}
 
-	/* Set the last buffer to wrap. */
-	bdp = fec_enet_get_prevdesc(bdp, &rxq->bd);
-	bdp->cbd_sc |= cpu_to_fec16(BD_ENET_RX_WRAP);
+	return 0;
+
+free_rx_buffers:
+	fec_free_rxq_buffers(rxq);
+
+	return err;
+}
+
+static int
+fec_enet_alloc_rxq_buffers(struct net_device *ndev, unsigned int queue)
+{
+	struct fec_enet_private *fep = netdev_priv(ndev);
+	struct fec_enet_priv_rx_q *rxq;
+	int err;
+
+	rxq = fep->rx_queue[queue];
+	err = fec_alloc_rxq_buffers_pp(fep, rxq);
+	if (err)
+		goto free_buffers;
 
 	err = fec_xdp_rxq_info_reg(fep, rxq);
 	if (err)
-		goto err_alloc;
+		goto free_buffers;
 
 	return 0;
 
- err_alloc:
+free_buffers:
 	fec_enet_free_buffers(ndev);
-	return -ENOMEM;
+
+	return err;
 }
 
 static int
-- 
2.34.1


