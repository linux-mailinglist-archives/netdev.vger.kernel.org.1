Return-Path: <netdev+bounces-252273-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ECo4ARkJcmmOagAAu9opvQ
	(envelope-from <netdev+bounces-252273-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 12:25:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C06B565F3E
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 12:25:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1B0D15AC0E1
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 10:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A83AD36826A;
	Thu, 22 Jan 2026 10:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="R7BQSoWy"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013022.outbound.protection.outlook.com [40.107.159.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F4A33C197;
	Thu, 22 Jan 2026 10:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769079433; cv=fail; b=C80wfP1ocgmX7ObDwU4QReToIpJl5NYBxERNWR26cn0AztciKpXCYb3BDj31cUfbtbpnCfiIROCcMHmp98jMcge9DP8MXG3hX8fWRPPwMj1s5fPKhQNk1vFtFE2eKlGoDonlKtIQkVZyUOJMguljf+8jsgVOr9aQT9VYJF+w9fo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769079433; c=relaxed/simple;
	bh=MwupKst/sqZDEKZQ4dPObhzHmDJPt/O3P+voCV1Gr1E=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=lsFb/dcz+YTSJJKkZenQiwBl5pWcW0GdiZq4qb0R7mpIRGKoV5rrTubUBpeuX5n0a46TC3muD/lun/B3R3o1Zx0GvFdk+gf+qpzpUM1moPpA8a9efjnM0aoLK4Q/KM/VTblifNxx/M+JS+Zz5FFIBS6HA2QuLaWPuJXIsn5IuqE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=R7BQSoWy; arc=fail smtp.client-ip=40.107.159.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sx4Bjhhqv0WGux6AGjrxpjPi2qugdFz0tF9qMhSvnCFAiislOdQeMGwKZEh8QcQWzWVeRkkgsTCeK0S50+GQS4Yc3IohEeRIRRXtxEb8NGpU2JTewXDObU158c/EqXAxrcul6XVpjUT8xZYPGs8APEpR9KpY2c5jFanEaHY17Y5PhSm40jsMR6VHu9z6VMf9FwRJrgWqmgi1uaT4GT3a89eBuexESvk64DY9d0U0OYNIC34e8m+0Gi9zbwlkzSAC3/czdpARMM2OiJeu0bQSiOneP5CUpmM6hGw+0ZCiJHem5yljMQRVAtxnyFwLb0ER9VDd8LIdcG+DO37M2DP1tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yppqh+DdcCJDUQLuL5zEHZ0Fuk1lWyUfD5qrD5USkGI=;
 b=hCsBVqvHS4oiXVWDXnwdyZwQwrjcxWTNnYX/zHFIE83NGEstXKxCn48WzWmOIJPQJpKLEXrOX7lOw72D2N5ZldsI1nluUEHU+A+l1H2UWrZdfETkyT0bXdNa7oJithv/On8RpJKVZVMnhczAuUpfk3tiYiPyTmLQ704kaIyyjtbVV7plZcXVT62NENcvE5RfiT2a63knIIAUqB3c7ucilSY+g/QXfYbQXqfeEpwobJ79wq9qPyPo5cFOmg8eCQ+3ZIulafu98a29uHLQo8pBts+vDWNisOqATpHixcqUB2qFCaIKOSpmswRe0FJe0WhY36P7OEET6iw20N7xmILWug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yppqh+DdcCJDUQLuL5zEHZ0Fuk1lWyUfD5qrD5USkGI=;
 b=R7BQSoWyOgYTBG3qYqMRG13hp8QUammcWSzk9eHUIeUxV0rXZoNVMlWL6BTxe8cuvgkhb9hGA9ozb7qWq2u1wRKAln+RGacwkSc+xj/mXFUWMAF0j3JSVQGR4jRQJq/iWOiQSA07W8009wPeDUlMx3H2sf/psOypwAjQh1YtA+FNw8GZawmaKyaldxDLDZFdPbTsuKP/79OP7xduSgmLqJVpWxkVQDE1axKhLL5wb3XwaHcy6inwJw4pDOZLOXBw8TIWt6zPCK+q8qrY+jJgZ6Pfo0gNSAVi5oE4+Pux7y8yLclV8xIFpG0ueqWiK5FEFosSXd7dDAauD+i4H01/9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by PA4PR04MB7902.eurprd04.prod.outlook.com (2603:10a6:102:c0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Thu, 22 Jan
 2026 10:57:07 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9520.011; Thu, 22 Jan 2026
 10:57:07 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Herve Codina <herve.codina@bootlin.com>,
	Mark Brown <broonie@kernel.org>,
	Serge Semin <fancer.lancer@gmail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Choong Yong Liang <yong.liang.choong@linux.intel.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v2 net-next 00/15] Probe SJA1105 DSA children as platform sub-devices
Date: Thu, 22 Jan 2026 12:56:39 +0200
Message-Id: <20260122105654.105600-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P192CA0029.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e1::14) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|PA4PR04MB7902:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b9181a4-90dc-4b4f-0843-08de59a4fc34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|7416014|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bXNlZ3RZQzV0dmYxMmhaUXIvRytHVzRrTWQvUGdlQjVqZ3NRL1RDTkRIYTFm?=
 =?utf-8?B?akZlWU5yQU4yNDA4YjBuTGpJalROakU4eFdHUVVycEQ5OGtUVTdyYk1tVmo3?=
 =?utf-8?B?M0QvMnZmL3RKNlJSbVlJUTRnZkRsaE5tYVA3NnlQc0dOR0V0MjBvUitMVXdB?=
 =?utf-8?B?OGQ0TjFMbjN2Q0Evekg2TG56TlRLZTVSbFpaZkZIdjZxbWJ0NHV0SEJsbnZX?=
 =?utf-8?B?ZmxpRmdEdmhHWDBGSXRIdU9kNTBtcGRQak04YjJGaGorZy9TZWZjcFdmaTRH?=
 =?utf-8?B?MVdPYTQ2Y1NncndHdzZBRldxME1WWXBqMC9tZDFTVGlFMkFhVkFMMVpwbXJr?=
 =?utf-8?B?bEdOVWM4TmNtZXBuOW94OGU0TCt4Ui9ENkk2RW5NT2pOVFd5YlJpNUJZR0lu?=
 =?utf-8?B?YWVORVdOZllrc1NOZHhSQWtDVTVoQUo1U3JZdkIwaVh6YzRwaGxjc2hvMHZm?=
 =?utf-8?B?dWhhK1hPaHk4aFE0R29KcW5hWjBkSDJuSkk2d1FNN1l1dVBidXlHM0ZJQ0Jm?=
 =?utf-8?B?Y2ZLdXJiOWdsdkxYRWJYU3dCa2RzanQzNmhPUWR4SmtVNlFZMGUxYk0wNDZY?=
 =?utf-8?B?V0pDYjFuQThHaFgreEtUdE00cjd6YVpKOVJNV3JFSkkxcE5XTDdWdmdhSFoz?=
 =?utf-8?B?cWt5cWh5d0lkaVIwZ21FZzN6Zkd2eW02Um42alRrSjBYTTlJZnB5bUpZZGZ1?=
 =?utf-8?B?aGF4RnQvSnF2U0trSk9PR3NNZVJsUW8zQlhyNTh5R2EwQUFCR2hoTUYyUFp6?=
 =?utf-8?B?NEZaNklBdXRTV001OUp1ZUttTnQxdTVVWFBJYldZT3pETlFHbllCV21CY3M5?=
 =?utf-8?B?cjQzbFJMR0tEaXg5MGNNSnhzYVBwY012WDdnd0cwSVd4RTcxYWY2U0dEN0pk?=
 =?utf-8?B?cFhZNUMvWDc2S292WG5WU2hVMHExUTc1WjZ0QStMQTR1cEQ1NU4vdFlrWGF0?=
 =?utf-8?B?ZXZVUjRublZkMkJ1NjJ2RXR4R2dyNTN1T1FOck1WcE91clRzZEpnMVlVRVpu?=
 =?utf-8?B?MEFraUJyOWNWTThWdkp4ZHlZSnIxQkNJM1V0Wm9jM1NnMEl6Z1lOQU5mNU1J?=
 =?utf-8?B?MGRDYlR0bitxQVQzazFGSXhEdUs5bzd4aVRyMTRCNWJNUjZrZExrWFBtUjVM?=
 =?utf-8?B?M2tZbkVlcDU3c3g1YXR2TzZWM1JJQUxKajU1ZDBOQXM0YjBWS3Y3dnZsRy9X?=
 =?utf-8?B?elZkVWRLN211T2Nnd1RhdTFNZVlLcDFDc3l6STFnQkk2Yk44Wm1sajJ5c0J2?=
 =?utf-8?B?R1V4bXNDR0pHMmJlZDF3SmVnUm00T2dXMDhuTytvTlJBM1NjblVhRzFzclRR?=
 =?utf-8?B?cmFieC9CVWV5R2hBVWFMVE4zV1BVTjh3M3NxUTBFV0RHY3FlUWJlNGNwdUF4?=
 =?utf-8?B?bHEzdzZ6Wm5haEFiNHVaZzFaV0NkeHZuTDhSamdhNFhwQ2NnK1ZZZkZ2aW0w?=
 =?utf-8?B?bVg5U28rSmRJdkRJYlVySUw2VkxOeVN6ekJkSkdDT0J3MDdveG9XZ0pKbDZr?=
 =?utf-8?B?dFNqUGtNbEVOWTJzT1dpL3VnZVZkbTdGNU5PMjE1OGxOQWcrWXB0ZnUzcHBM?=
 =?utf-8?B?Qy9QeHlUM2p5T0hhTDZBVTNDUE1vWC9PUFJwQUpDNXRLVEJSOGpaaS9vMXlQ?=
 =?utf-8?B?ZzZ5c3lRVThhdmlneFlML3p4OXgvVFBCdTVkdEM1Y3JqY2pLUXdyTmsxWWha?=
 =?utf-8?B?UWZvY1phQng2RjAzMlFObEZtR3NkU1RxdGdwcXZ1eUlLRVRRbTNWSklpL3pJ?=
 =?utf-8?B?UFU3bUtBVU9TYU1LVGhhQStXYmpQVmg0SkFpbENTcXBKNnBVM2ZJWlh0MzV6?=
 =?utf-8?B?b1lBNGwxMVJlUWxsZ0w3Vmwyc1RieVlaTDUzRzEyODBDOUpaNHRNWUlDUVBp?=
 =?utf-8?B?ZzlGbC9DRGhrZWtaNGxteDNGNTNuWHlPZFFtUmFSeWRjYUd1dkloa2RGVnRJ?=
 =?utf-8?B?WEp2c3A4TnJtWHc4aEZJdy9XaDYxSFFiZzdTbVNNd3A3eGRNTGV1RUpacVdL?=
 =?utf-8?B?TzJ5bXd0bnNiclRZMjlJZUhhUzd6T1dZTjFQWjk4V3VwVnNRalliUHZLb250?=
 =?utf-8?B?Q1Z2cnJaTjlmK3B2Mm0xeTY3eTNycGl1Z2ZJaEMwcXl6NWg1ZXJVdmlqR1hN?=
 =?utf-8?B?MkZFYU1LWkZOQlNYTkdLRy81MkRnS3JsdHlCUDZCTkd6ZThxZGxNVmZXQ0J1?=
 =?utf-8?Q?Owwm0uQ/LkZcc7a4egbi5W0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(7416014)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b2VaZkozOUx6a0JST3dWOWdrSzNHWGVSVnNGY0lIZXR2RVFRcFMvVzlMakQ4?=
 =?utf-8?B?RWF3VDAzbXMveUg1czNKU1h5K05tUlNpYjVuQTIycElrdHhuV2pXS01SVEtw?=
 =?utf-8?B?aE1DRXRuaGxIMmlFelZLTUc1V1NhV1pMNmhvTURXbkhxNnlyUDAxbFJPUGVB?=
 =?utf-8?B?UlZ6T3NsRlBVbFdqVXlYSURVT2hLcW9WOUNTaHp3S2xvNENraUlGSWlTWHZr?=
 =?utf-8?B?OUxkYWVUS1dDZWx2MitoNHFMODY2OENMV3dwWGdvYmxTYVIyTHhkNTVITEtV?=
 =?utf-8?B?TElKQTRZb0FsaVZKZmF2azhlOHA2ODF6YTg3Ykk1Uk11emR5THovZVFYOUJZ?=
 =?utf-8?B?c0hjejM3SjJOTVlMU2xNMVp3Yi9DYVgyWnNnRXFwVmVQeHJhTWo3S3BXQXI5?=
 =?utf-8?B?SkU5RStveWVpY0N6eFUyVUdUMGx6c1kzNE91dStNQ01PclJ0QTJBSnAyVFIr?=
 =?utf-8?B?VDIzWnJCTHRXeVFCUWs4YkVGOHNSbFdaQzlXVk1vVEZoQ0lzckFRSlBWVUhL?=
 =?utf-8?B?akc0WG9ONUZ5cjJsR3BzK2piZDQ1RzZKU3N2K08vbk04dDRyMXJtYk1xN0Va?=
 =?utf-8?B?RXV1bkRybUp5K0ZIVWdKVkFIKzhYOWxVN3UyYXM5RjNmcGhaMTdXSFNFUVdY?=
 =?utf-8?B?eVlObzBJenlzNTVGOUcyNENvSEh2UG5iZU56R1JHWG54d1dSRlNEZVZhUlBI?=
 =?utf-8?B?SVo1TjJRd24wYU1EbHdyWlJKYVpuQ0tTWnJoR1pOY0JFcnBKbGc2VHRKQVFC?=
 =?utf-8?B?ZlBXMm94NGhqY1NCUDh0USs0ckR4QVExQXhuTU5FQmZaWVJqMm1laGtFcE1y?=
 =?utf-8?B?dFBDV2QxczZVS0R6UkI1eDQvYWtUcnlhTkhBVVNyR0JoV0JFWGlyUGN5VHRT?=
 =?utf-8?B?d1o1b2xyaS9oNFlaMVZxai9ES0Fad2ZjNWMrbGJjWFBxN1NKcDVaS3EwNHFk?=
 =?utf-8?B?cGFjZlozL0kzTHgveWVwelpFc3ZUbVB0NjZWL3N0SjhxT254K2dXYkx3REto?=
 =?utf-8?B?V1BSNXlEZE9Ici92Z3Q1OEx4d0dDYnQwMUR0aUlyUEQ2cWpyRmtpckVEZGxG?=
 =?utf-8?B?MU5rdld5K0pUdFVlM1d0TXVJOWJ1NW9PUFBtV2hDSENWSzRJdklVNWVRbHIv?=
 =?utf-8?B?MG5yT2NpN3plcjM5L3dxcmlHUHZqNVEwRXk1OUFZcmVxZGt6NnU1S0d5ZHd3?=
 =?utf-8?B?U04zQXZlQ3d0RW5pWGV5eER1ZjhieUQrR2ZHS2FGTkI5cWducy9xNGJLYSsv?=
 =?utf-8?B?c1FmMVZCR1k3YkhHd1ZCQ2RoaGxSRTc3SjZKUkNoRXg1b2hWUlVneU1YYkZs?=
 =?utf-8?B?SnZ0dkh5bTdrOTkrWnRjSDZsQmFaUFZXbjQ5d0M2dVJqSHJXdVhBV2Yxcnhi?=
 =?utf-8?B?SzhJUXJ2Zi9yWlVOdmxRYSswTE95Tnc5eTNaeXpOdzIyNkEyem1TUG9NTm5G?=
 =?utf-8?B?SzdSNXBXbU50dFpHY0R3Uk1NNXRON0ZIVEFKb0JpbFYvaFNLNWJ0QU9SVmg3?=
 =?utf-8?B?QmcreVZLcnpKbG9FZ2dpNURvaDhhajRlR0NYdUhCK1VPbGk3VzRqRTArUDVZ?=
 =?utf-8?B?aEFaQkNaV04xbGlKOUVXVmcxcmgrRmtWQndWK3RvZnRpS3k1WVd0NnQ0M05E?=
 =?utf-8?B?NXMwMTJndlJtNkRxYmduekl5aGZZQmNPajlNWkZyV1ZkdnNEWXUyMUdPVXNI?=
 =?utf-8?B?eXRab3hoNU9SREhJRzBWS0xsWUNvak9xY2JtZ0JRRmJXNkNySzhGYm44dlAv?=
 =?utf-8?B?WkNRbXhIZ2RGY0dWNG9seU9pMmZ1aUMxdXZRd0hBdTdSVTF1VnFFK0xYWjZF?=
 =?utf-8?B?T09aVWp3WnJZTWc2NGZneXNHeWRoSzNHbXhjMjMwcEJIajNncmFvb245YWdL?=
 =?utf-8?B?NnhZakhVcVBIdWt6L0pCSTg2L01tMWlwTGZaMHdDaFRtU0I1TStQbFdKTEZv?=
 =?utf-8?B?ZGFTREFHMCt3ZXIzOHVCcWhxK0VVbnN3aDU3ZUZGRDF4MzNpNFVoOVF2MDdr?=
 =?utf-8?B?L1AzcU5TSEVuaFJpZ1JiTlVmd2Ztcmx1a3lzWDdZd1ZuRXBjYlFVU0tFKzF3?=
 =?utf-8?B?b0NxdjJxVWt5bzV0aFJFbDVqMWVqSkJBZFlBWm90aDYzQUhSYys1bXVwakJu?=
 =?utf-8?B?dlFNNnk3bE9wR0xEdnYwUWxtOFF5SUNQWEZDNnkvZXo4YUtUZDRYMnRnaStP?=
 =?utf-8?B?S2tEQUdTdzNiT0IvZmszV1FqUnNsWkR5NWVxL3lJMlhOQ1pkMzVtVzAxaGw2?=
 =?utf-8?B?ZFVGVmlScmI5bldtcG55TS9TNzVseEg2T2Y4cU0yWDFxOU9qNlI3d1pGR1N6?=
 =?utf-8?B?U3F3YW9QUFhGQVAwdC80Y3V5bS94ZExINUJWZ05HaGFIcXk4Mit1Zz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b9181a4-90dc-4b4f-0843-08de59a4fc34
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 10:57:07.7167
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0C4q+s+Pqd0U4+3ZjroswUyy/XJQtlxVivveqISVk0Lpa2HwmJtnKn2o2xam0dzfvzRriqX66hjswT4AbUhd0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7902
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[21];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252273-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,linux.intel.com,bootlin.com,trustnetic.com];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,netdev@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[nxp.com,none];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	TAGGED_RCPT(0.00)[netdev,dt];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:mid,nxp.com:dkim,ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: C06B565F3E
X-Rspamd-Action: no action

The NXP SJA1105 and SJA1110 switches have a linear address space thanks
to their SPI-to-AHB bridge. This address space contains not only the
Ethernet switch, but (depending on hw generation) SGMII PCS blocks,
MDIO controllers, interrupt controllers, GPIO controllers. Of these, the
SGMII PCS blocks and the MDIO controllers are supported today by the DSA
driver, through internal programming.

This series proposes registering platform devices for each non-switch
weakly coupled component, all such devices being backed by an OF node
(and reachable through phandles to it), one or more resources and the
switch global regmap. For backward compatibility and not only (DT author
convenience), if these OF nodes do not exist, they are created using the
dynamic of_changeset API.

The motivation must be explained top-down:

  The high-level goal is to customize the XPCS (SGMII PCS block) with
  board-specific device tree that describe the required differential
  lane polarity.

  But the XPCS is not presently described in the device tree in
  SJA1105/SJA1110, hence the desire to do that.

  However, instances of XPCS blocks described in the device tree already
  exist for the case where it is MMIO-mapped. Those bindings dictate how
  the XPCS in SJA1105/SJA1110 should be described.

v1 at:
https://lore.kernel.org/netdev/20251118190530.580267-1-vladimir.oltean@nxp.com/

Major changes since v1:
- Stop using MFD API due to pushback from Lee Jones. Create replacement
  of_subdevs_populate() API localized to sja1105 (can be moved if need
  be)
- Exclude first patch "net: dsa: sja1105: let phylink help with the
  replay of link callbacks", upstreamed separately.
- Include XPCS lane polarity parsing.
Minor changes listed in individual patches.

Note that the current of_changeset API is "sufficient" for this use
case, but if its use is acceptable for XPCS, I will need to look at
expanding it with phandle support, for the interrupt controller
sub-device. I was able to "wing it" here by manually keeping dynamic
fwnode_handle references rather than reaching them through phandles,
but that has limits.

Vladimir Oltean (15):
  net: mdio-regmap: permit working with non-MMIO regmaps
  net: mdio: add driver for NXP SJA1110 100BASE-T1 embedded PHYs
  net: mdio: add generic driver for NXP SJA1110 100BASE-TX embedded PHYs
  net: dsa: sja1105: prepare regmap for passing to child devices
  net: dsa: sja1105: include spi.h from sja1105.h
  net: dsa: sja1105: transition OF-based MDIO controllers to standalone
    sub-devices
  net: pcs: xpcs: introduce xpcs_create_pcs_fwnode()
  net: pcs: xpcs-plat: convert to regmap
  dt-bindings: net: dsa: sja1105: document the PCS nodes
  net: pcs: xpcs-plat: add NXP SJA1105/SJA1110 support
  net: dsa: sja1105: fill device tree with ethernet-pcs sub-devices
    under "regs" node
  net: dsa: sja1105: replace mdiobus-pcs with xpcs-plat driver
  net: dsa: sja1105: permit finding the XPCS via pcs-handle
  dt-bindings: net: xpcs: allow properties from phy-common-props.yaml
  net: pcs: xpcs: allow generic polarity inversion

 .../bindings/net/dsa/nxp,sja1105.yaml         |  27 +
 .../bindings/net/pcs/snps,dw-xpcs.yaml        |  13 +-
 MAINTAINERS                                   |   2 +
 drivers/net/dsa/sja1105/Kconfig               |   1 +
 drivers/net/dsa/sja1105/Makefile              |   2 +-
 drivers/net/dsa/sja1105/sja1105.h             |  39 +-
 drivers/net/dsa/sja1105/sja1105_main.c        |  86 ++-
 drivers/net/dsa/sja1105/sja1105_mdio.c        | 507 -----------------
 drivers/net/dsa/sja1105/sja1105_spi.c         | 113 +++-
 drivers/net/dsa/sja1105/sja1105_subdev.c      | 513 ++++++++++++++++++
 drivers/net/dsa/sja1105/sja1105_subdev.h      |  10 +
 drivers/net/mdio/Kconfig                      |  22 +-
 drivers/net/mdio/Makefile                     |   2 +
 drivers/net/mdio/mdio-regmap-simple.c         |  80 +++
 drivers/net/mdio/mdio-regmap.c                |   7 +-
 drivers/net/mdio/mdio-sja1110-cbt1.c          | 179 ++++++
 drivers/net/pcs/Kconfig                       |   1 +
 drivers/net/pcs/pcs-xpcs-nxp.c                |  11 -
 drivers/net/pcs/pcs-xpcs-plat.c               | 146 +++--
 drivers/net/pcs/pcs-xpcs.c                    |  58 +-
 drivers/net/pcs/pcs-xpcs.h                    |   1 -
 include/linux/mdio/mdio-regmap.h              |   2 +
 include/linux/pcs/pcs-xpcs.h                  |   1 +
 23 files changed, 1185 insertions(+), 638 deletions(-)
 delete mode 100644 drivers/net/dsa/sja1105/sja1105_mdio.c
 create mode 100644 drivers/net/dsa/sja1105/sja1105_subdev.c
 create mode 100644 drivers/net/dsa/sja1105/sja1105_subdev.h
 create mode 100644 drivers/net/mdio/mdio-regmap-simple.c
 create mode 100644 drivers/net/mdio/mdio-sja1110-cbt1.c

-- 
2.34.1


