Return-Path: <netdev+bounces-252280-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AEQKNFwIcmmOagAAu9opvQ
	(envelope-from <netdev+bounces-252280-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 12:22:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DAB365E86
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 12:22:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D8E946C162D
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 10:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 020E042B757;
	Thu, 22 Jan 2026 10:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="G5eZbhQc"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010042.outbound.protection.outlook.com [52.101.84.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FCD83382E7;
	Thu, 22 Jan 2026 10:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769079451; cv=fail; b=lkDivrccgrdgJ0XcBNPzwq7djaTp10W3b7vzi/AMY83PGj31MUSJeKHY9JY8GKuQNKunM6BH1CYwqV0TDI0VNCx2SdzfIYaBQFLYZHyorHe7E6E3shykp9dtKXL7U8j7hoTF9gD0t3kpIIhQ51d0X8U5vjNtR1l13t5grywLGbY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769079451; c=relaxed/simple;
	bh=Osv/QR6asey3ws/OvS8gnMI8Us3hsjEwagnOQE9Q6CE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LeC2fUUMcqvApYiv/piZv1Lsxe+ffYjm5H2HMtdPcrI33bYhLvvDOnF05d3dFpfMDgiouH+gT/O+2TGYFLuIiUG9iVwVaz3XgqQrzKEEjZAIJ+Mv5CVmVN0VeLxkqvQWHmACDjzWObmIo5+aKYC1drBjLkcn025wYUrSFAg2QJk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=G5eZbhQc; arc=fail smtp.client-ip=52.101.84.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZR8+wAqaPbO3H9D5gal5WzfJSAsKFKymbRrIRCXMJSTIBg+TXM3FPNBmRXem9h3slOALR28HWfmUZTjdy2Gf4wvTisZQdUl4ohwwIokfIo7Goc2UFqHjypXtq1eASXZgOcqAEdJj5zvwHxY4eNOvCFztddlYbTjmJX97aqrxBqheexFah19Y6Hj7K+5zMEFO+G7ZWtUjuwNNmOcRxL7kTILXCplc/HLMxXDiVJk6FZQaZLPuVQP4KAgNssgE6unKHPebQ2d+LP5dkmN3FKkJV6E12eUFD6+p3zJnwcB2x5vK4wjjJwRf+hA1xPc50OTYQzYasOFRgehHGGKpM59NtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JoOwY6zmcza9v4Upky1UDD1nY64hJQCyLVHbzATL2MY=;
 b=dH3JSYsbBsYQdRd7VIYKElrZJTJypIG3LZOgtnR3dMh3rzlL2sDKo5h2DjsosP2of0CBO7Mu04DkSEjrYJ3e3lP8o8JFpF5ksBoYzPM1MQq2LT3qRXlvOgaGqgqsT8P7tmsKclTtYiOOJKUwoY0WcnfhEVz6k6niQ9but0YaGGAgFUsO8ZMUNT49Aa6XO9ixKk3GNFIf+nWEKWlr5jLeMafMENEggyNavDtGaDyDCXNbeMR+qdia5nJEzCt6ILZKMnlw7X/KQ5XblS5V77P7jIkf0uMj7AwDdaDZorfe2ldmDbUFsNirkY8XNr+2opOulMycf9vXXxQ6CSfNRCqLiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JoOwY6zmcza9v4Upky1UDD1nY64hJQCyLVHbzATL2MY=;
 b=G5eZbhQct1BYReXAhFCiZ73B5RDspaevH4A5C4PjGMdxbUFcCJZvc5WzGiVT/u07BAzhVbwF85xgIBchdM8Ms/nbZVneNx4/qkN5cFv6eDtFuggQBkuX5nzfoBIQqldThs0YXvoHKRhWJPaV6PX5c8wP1cPSL9kInSVnfgCpQ/ZYcLdJz6z1lcu2yZw4+4trZj4LTLxExGsYEnt4scggJVxPW5BK+KEK9XOwK2xMpt4xRtkMcJAuqiFv/PMWeZtME+llP5U9d44nQPv1CX2BCu35frDGZDn6nAESjhgAj1dlBdUWMkglw7WrH3tOSDujb5BRtJMaBHL8BGCeA1GS5Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by PA4PR04MB7902.eurprd04.prod.outlook.com (2603:10a6:102:c0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Thu, 22 Jan
 2026 10:57:18 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9520.011; Thu, 22 Jan 2026
 10:57:18 +0000
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
Subject: [PATCH v2 net-next 06/15] net: dsa: sja1105: transition OF-based MDIO controllers to standalone sub-devices
Date: Thu, 22 Jan 2026 12:56:45 +0200
Message-Id: <20260122105654.105600-7-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260122105654.105600-1-vladimir.oltean@nxp.com>
References: <20260122105654.105600-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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
X-MS-Office365-Filtering-Correlation-Id: f51d87ad-28bc-4eed-9dd5-08de59a502aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|7416014|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tJH3OZFM5MUaEt2TrVT0lWMuTq2W4NVMC0snV/alkAah+z7S3eV7zh+G5yQq?=
 =?us-ascii?Q?34qXQNE/T6mXEkWYQbwrJGdi6QeoaqjQwc1l4lT2caSPbXBoh7UJ+CjesKnD?=
 =?us-ascii?Q?9QV8j87JuqZ5wTpyPmFRAa/5ZJyJVdQYA1mxT16PkzcMrrC3N8unc7JLspnX?=
 =?us-ascii?Q?BHEQuIve8sizxi1IDgdLFZCPqr1JYQMhGRJLth425B3HeqzYo4UbaQySEUg/?=
 =?us-ascii?Q?+LkHLh6t53PfdGqpiRreqH13ZqycPA8EcfvC0JHt4747TF+K5OnuteQ+XODk?=
 =?us-ascii?Q?HuuY00pSUM3hJyzDbjTd7ZnUYR9EJWCrfcJdzVld2UhI8Yh6Urv4yVEc9SFG?=
 =?us-ascii?Q?AodWMESnJHWApg1eVqH7gZkx07O77tFtavMD9gr8JjlsrmMyAKgRroxGYuOf?=
 =?us-ascii?Q?jjb9ifNtZ7NqZmOLtirvSxa2N43jGJU03HlkDU3uh5fssaHX9SzgHoL/8DBP?=
 =?us-ascii?Q?R8E60e5PJ+UMFvbdfRp5fjtRSo1NXcs0IQ5v2L0XOtFfdmPe17un7iOZOrHQ?=
 =?us-ascii?Q?1BsH0cdw1X2AFIF/arMTB6YwCbWIuee1F+k1fKUqFB0u1ZqunbodL1HqAwfl?=
 =?us-ascii?Q?2fZc6G7ehJRYxqfZrUDyhm0kXPe4qrXyb4q4Ok+bL4Xw0Wba8sB0bqQ8rWTo?=
 =?us-ascii?Q?m2ECE3TFlGYbkyAfOKo+4/UNCIYWcvBoYLa3F2BI5aLaWwP9gHMxhIcV3spe?=
 =?us-ascii?Q?tcSMFGvm7IYC2N0mqidv6sSJ/1U9aKHQmA3KNlqQv9ojpk5FR6yBxeCsNo2W?=
 =?us-ascii?Q?i1G28dLsoeF1YE0bohP6UKWjXYTJY9z5UKo8MuAHUmV88iSScLky4V0F5u3c?=
 =?us-ascii?Q?mqYXKTa9XQ5NZAUINOmWmUcf+L3/vtCXtKq0H8kxO83TW4Jqm772loNytkTT?=
 =?us-ascii?Q?vcbt5mAHZNgX4HmAOHNLgvor0XJ0hdIJmMj0tQGsTD28IMfxCY9FDAo3KCMD?=
 =?us-ascii?Q?HyLyoOWiEbSnx+63Y9R24CTndR1FDyL3crYG3ac3UVj4z/Q7rTwXZ+NIGkL0?=
 =?us-ascii?Q?7DdND+M6WJV/88KKQQOVyElK+wC0Dw4phREFG8sSmWwrOdCicwmgxrtf6hKl?=
 =?us-ascii?Q?vML2+i86/x+pTosT8Yb+oU3w08q/bhqeNz71YpsSBpOC5PMAnGSq7/f4vcVP?=
 =?us-ascii?Q?UBazVo3XsoYYzmFqvO61jYDAis+sR+W0kvz4yhrSkFGBD+k/kbGB4XHJxY2L?=
 =?us-ascii?Q?uz+XU/T+737utlGIOrh++fNInOc0TNfTBC+SZkL+Q1CDoWc4949kd1yY146X?=
 =?us-ascii?Q?EQ1kDABuaE3bymdUqF23MLXLtbrhbxoVk1o63RQJ/FskY/FBSxlidgRcNOsh?=
 =?us-ascii?Q?VZrG8O3ADk3R19UjWTEb+fi+yS1GCWGiK/h3Cd9tUS6b2jNOoJcBdWF54fkB?=
 =?us-ascii?Q?NqENjOyEOVlR516RUnmLW8HA4341dN/I9sVIBoAXX4wvgKvHO2+vdTTfsAuP?=
 =?us-ascii?Q?4yPc4CUtl0lLWFdXFcVK+CRJQtZBAu4DIaS0B6NmuALw44nxB1BceThEjaoE?=
 =?us-ascii?Q?f6U6IP4kyS3a6+SIHdtzEEPNjtRRDAFb+LFXYP7rHllkDFzssi3gg4r9HcnM?=
 =?us-ascii?Q?BEYF7Qjy4kSm963OZnBxDxChZUY5q0U0cR1SGivhGBhs/u7gyMsj9i/PWJMb?=
 =?us-ascii?Q?oyG842Qf3GiUHlCKJ1ICpws=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(7416014)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FDCBAFzM7i7BOZMOF2LBSwgF7zgToL5hUH8xcpX0YQ4m+6t2LIhNZTLVbveG?=
 =?us-ascii?Q?0zjX3+ZXirFMR5eCGIlgZnrDVd2UxNgCneSV8Z4k5HYZZBzS4VreArmszq69?=
 =?us-ascii?Q?s9T9L/6dpHa+8IyP//CSkCHA2mohQKqThxhFSV7/8CThWjn4HWUEyRMKfH2h?=
 =?us-ascii?Q?BQ9avFDQt2zmOHP9pfz0DyT8qKO3lusFJkGwmSlHZPw3OCpb62HIZWkNGZXn?=
 =?us-ascii?Q?AvQbfFPfZUz4j9E8aCNjGm/ZVKzY5EU9FWNC+wJ9ogwLJhc23dHIeEZ+Wufg?=
 =?us-ascii?Q?HvarUDtNJynpm/0cOY2WTEOuteB27JaiBPRsoAMZnfmsRtvALlsaCtlQAvpB?=
 =?us-ascii?Q?Kx/tf9dlDqNOu7dDoDuQKiKvmNHwrjEqZK9M6J9ni9Wfxh5qo8iccdvwh9Ah?=
 =?us-ascii?Q?nTIz5reIDXFMrOvG92hB8Sqlgzk0tS9vR7u8RazMUyyoG1xX3hq02IgPjy1z?=
 =?us-ascii?Q?061o1GbenQxncsaMtHm0StafAhYFKHrWzrm152k/a88Eqbj4vx8tdCv/cei7?=
 =?us-ascii?Q?L4omSVQ+7NKsgDTkdjcn91GApDmUOqDdo1qWBEugv8KHvzrCTLew++ap5jGE?=
 =?us-ascii?Q?nbT7JT8MrL6kc11QjMsRTo8Bv/2qzCn7Jh9Yzntd2sytocxo0+VUl5pYeK7R?=
 =?us-ascii?Q?ZfOg3rBLe6pf3Ei7IRdYN5lLiK+p+XqJGxONBefJ/8IKADgdSVrGyxq8uvTv?=
 =?us-ascii?Q?IxDqVCPK0vHZvdc+CSPPK6Eo5j009Gg1oAvRU9gJeko//avER2DKcSjd1mo2?=
 =?us-ascii?Q?GJkBu0OQLB8dAFnX6PEDjRTd9myO4WKMLazsxB8K9LWOwfoQA5YiHZN6g7KX?=
 =?us-ascii?Q?CU+1BzFC/4oUJO3MlVmzrRVGq0D4lC7UZ8clzDUDTTfbePyQ7ANLgu5z/wVL?=
 =?us-ascii?Q?NB1ZkdxajSlGE42wOZ1w773f4L2HXommnFnQmezcT8SC2oewJH284vB5zb6y?=
 =?us-ascii?Q?USjtMMzyOQoy1tdqYOW/OD7YhcSpvQ0cilFY2O5jC22lN3lkR3cOB/6RV/oY?=
 =?us-ascii?Q?XuzH9FSEu/5cY7Q7uG1ki54HIkMxmVgeobkOPHeJd4NsMf4UQahDTOUuY6fH?=
 =?us-ascii?Q?qbeFyB1NGWxizvpDVxibkUIEUWugV4uJkWvIqwh1fBgmOmhmpkaI/HGqIGqy?=
 =?us-ascii?Q?DNqno9otipR0Vah84TN+5y5IC8PHKrhsMYSSXEndv/C9fE5ZVriwZCx1kU75?=
 =?us-ascii?Q?+JIa6lOYgSUnvDbDuLpa3Qp0E6KzS8+wdoCbwByrHPUaAw/Tun+vmFWXYr/r?=
 =?us-ascii?Q?K6OASWdbOgZiawlKTsn1ML4anxQYRUeBw7JgWGoPS8RAvhaxKvon/KTFNL1W?=
 =?us-ascii?Q?1ssm+ckLzyyhjQDqfET4d4Nxxs7hD6EAO9Da73sATTQtzfH1eaJWhfL0fmKm?=
 =?us-ascii?Q?JzMZvvsIazmYV3i1O/n+xs1bfZpsypfjMn7qFOQ+YPMJsKtjb9MFolBuwivy?=
 =?us-ascii?Q?31tgoQ5AWKgfeyRvtIU3M3JrPkuK95bZTSM0YjcItadsPCDI8zLrBsDECLQX?=
 =?us-ascii?Q?nBApmbAue4yDPxIaIM5752csZTyvFKgbFjwFiWa1nDmDUNeztHngLV1XXpHh?=
 =?us-ascii?Q?pJEyxr4VEXmyvRBPmI98UY/sShqNr4EbFkQNfw4sc2EJv+6teq5PKffGD3m5?=
 =?us-ascii?Q?fTR0A3Fvd/e7sB8MooSaqTDyuPWd4brq9jgmWY6AtFmBxeSU4+p/0f/FKPRf?=
 =?us-ascii?Q?4204EfxCQ+CGX+1HPKbEOXHEjn1blbggBW2Z2/tAMH8K7/uvhN73wLTsiotx?=
 =?us-ascii?Q?/GFrNXgS6w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f51d87ad-28bc-4eed-9dd5-08de59a502aa
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 10:57:18.5410
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 943V6e6/AB22T21UvETQDwR6RrOAIk5nreZ2jYGRnU5TUOUOfWsyZSBVfz8SIaeRaOrGH6bNfqG2Xed88rbv7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7902
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-252280-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,linux.intel.com,bootlin.com,trustnetic.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[nxp.com,none];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[netdev,dt];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:dkim,nxp.com:mid,ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: 7DAB365E86
X-Rspamd-Action: no action

The switch driver never interacts directly with the PHYs from its
internal 100Base-T1 or 100Base-TX MDIO buses, but rather, uses the
generic phylink library to follow "phy-handle" fwnode references to
them.

These MDIO buses are currently created by the DSA driver for historical
reasons, but they have well-defined address space regions for their
registers, which do not collide with the DSA switch registers. In the
SJA1110 memory map, the important resources look something like this:

Name         Description                                         Start      End
SWITCH       Ethernet Switch Subsystem                           0x000000   0x3ffffc
100BASE-T1   Internal MDIO bus for 100BASE-T1 PHY (port 5 - 10)  0x704000   0x704ffc
SGMII1       SGMII Port 1                                        0x705000   0x705ffc
SGMII2       SGMII Port 2                                        0x706000   0x706ffc
SGMII3       SGMII Port 3                                        0x707000   0x707ffc
SGMII4       SGMII Port 4                                        0x708000   0x708ffc
100BASE-TX   Internal MDIO bus for 100BASE-TX PHY                0x709000   0x709ffc
ACU          Auxiliary Control Unit                              0x711000   0x711ffc
GPIO         General Purpose Input/Output                        0x712000   0x712ffc

OTOH, dedicated standalone platform_device drivers now exist for the two
controllers found in the 100BASE-T1 and 100BASE-TX regions. If we could
leverage them, we could simplify the DSA driver code by removing the
weakly coupled components.

There was an initial attempt to use mfd_add_devices() to probe these
children, but:
- Using mfd_add_devices() liberally outside of drivers/mfd/ causes
  "minor chaos" in the words of the maintainer
- The SJA1110 dt-bindings, where there exists one more hierarchical
  level between the OF node of the parent and the OF nodes of the
  children (aka the "mdios" container node), is too unconventional for
  MFD:
  https://lore.kernel.org/netdev/20251118190530.580267-8-vladimir.oltean@nxp.com/

So I turned to something custom based on platform_device_register_full()
instead. The OF nodes of the known MDIO controllers are searched for,
platform devices are created for them, and they are given hardcoded
resources which correspond to the above 100BASE-T1 and 100BASE-TX regions.
The platform drivers will use these regions to segment the SPI device's
regmap in order to access just their own registers.

Delete the duplicated drivers for 100base-T1 and 100base-TX from the DSA
driver, which are now unnecessary.

Cc: Lee Jones <lee@kernel.org>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v1->v2:
- replace mfd_add_devices() with devm_sja1105_add_subdevs()

 drivers/net/dsa/sja1105/Makefile         |   1 +
 drivers/net/dsa/sja1105/sja1105.h        |   4 -
 drivers/net/dsa/sja1105/sja1105_main.c   |   8 +
 drivers/net/dsa/sja1105/sja1105_mdio.c   | 270 +----------------------
 drivers/net/dsa/sja1105/sja1105_spi.c    |   6 -
 drivers/net/dsa/sja1105/sja1105_subdev.c | 154 +++++++++++++
 drivers/net/dsa/sja1105/sja1105_subdev.h |   9 +
 7 files changed, 173 insertions(+), 279 deletions(-)
 create mode 100644 drivers/net/dsa/sja1105/sja1105_subdev.c
 create mode 100644 drivers/net/dsa/sja1105/sja1105_subdev.h

diff --git a/drivers/net/dsa/sja1105/Makefile b/drivers/net/dsa/sja1105/Makefile
index 40d69e6c0bae..7b5537d67072 100644
--- a/drivers/net/dsa/sja1105/Makefile
+++ b/drivers/net/dsa/sja1105/Makefile
@@ -5,6 +5,7 @@ sja1105-objs := \
     sja1105_spi.o \
     sja1105_main.o \
     sja1105_mdio.o \
+    sja1105_subdev.o \
     sja1105_flower.o \
     sja1105_ethtool.o \
     sja1105_devlink.o \
diff --git a/drivers/net/dsa/sja1105/sja1105.h b/drivers/net/dsa/sja1105/sja1105.h
index 30903fb62302..cf718e7c2b7b 100644
--- a/drivers/net/dsa/sja1105/sja1105.h
+++ b/drivers/net/dsa/sja1105/sja1105.h
@@ -91,8 +91,6 @@ struct sja1105_regs {
 	u64 rmii_ref_clk[SJA1105_MAX_NUM_PORTS];
 	u64 rmii_ext_tx_clk[SJA1105_MAX_NUM_PORTS];
 	u64 stats[__MAX_SJA1105_STATS_AREA][SJA1105_MAX_NUM_PORTS];
-	u64 mdio_100base_tx;
-	u64 mdio_100base_t1;
 	u64 pcs_base[SJA1105_MAX_NUM_PORTS];
 };
 
@@ -278,8 +276,6 @@ struct sja1105_private {
 	struct mutex dynamic_config_lock;
 	struct devlink_region **regions;
 	struct sja1105_cbs_entry *cbs;
-	struct mii_bus *mdio_base_t1;
-	struct mii_bus *mdio_base_tx;
 	struct mii_bus *mdio_pcs;
 	struct phylink_pcs *pcs[SJA1105_MAX_NUM_PORTS];
 	struct sja1105_ptp_data ptp_data;
diff --git a/drivers/net/dsa/sja1105/sja1105_main.c b/drivers/net/dsa/sja1105/sja1105_main.c
index e9e091cf8998..d3fb42772071 100644
--- a/drivers/net/dsa/sja1105/sja1105_main.c
+++ b/drivers/net/dsa/sja1105/sja1105_main.c
@@ -23,6 +23,7 @@
 #include <linux/units.h>
 
 #include "sja1105.h"
+#include "sja1105_subdev.h"
 #include "sja1105_tas.h"
 
 #define SJA1105_UNKNOWN_MULTICAST	0x010000000000ull
@@ -3329,6 +3330,13 @@ static int sja1105_probe(struct spi_device *spi)
 		return rc;
 	}
 
+	rc = devm_sja1105_add_subdevs(ds);
+	if (rc) {
+		dev_err(ds->dev, "Failed to create child devices: %pe\n",
+			ERR_PTR(rc));
+		return rc;
+	}
+
 	if (IS_ENABLED(CONFIG_NET_SCH_CBS)) {
 		priv->cbs = devm_kcalloc(dev, priv->info->num_cbs_shapers,
 					 sizeof(struct sja1105_cbs_entry),
diff --git a/drivers/net/dsa/sja1105/sja1105_mdio.c b/drivers/net/dsa/sja1105/sja1105_mdio.c
index 8d535c033cef..b803ce71f5cc 100644
--- a/drivers/net/dsa/sja1105/sja1105_mdio.c
+++ b/drivers/net/dsa/sja1105/sja1105_mdio.c
@@ -133,238 +133,6 @@ int sja1110_pcs_mdio_write_c45(struct mii_bus *bus, int phy, int mmd, int reg,
 				&tmp, NULL);
 }
 
-enum sja1105_mdio_opcode {
-	SJA1105_C45_ADDR = 0,
-	SJA1105_C22 = 1,
-	SJA1105_C45_DATA = 2,
-	SJA1105_C45_DATA_AUTOINC = 3,
-};
-
-static u64 sja1105_base_t1_encode_addr(struct sja1105_private *priv,
-				       int phy, enum sja1105_mdio_opcode op,
-				       int xad)
-{
-	const struct sja1105_regs *regs = priv->info->regs;
-
-	return regs->mdio_100base_t1 | (phy << 7) | (op << 5) | (xad << 0);
-}
-
-static int sja1105_base_t1_mdio_read_c22(struct mii_bus *bus, int phy, int reg)
-{
-	struct sja1105_mdio_private *mdio_priv = bus->priv;
-	struct sja1105_private *priv = mdio_priv->priv;
-	u64 addr;
-	u32 tmp;
-	int rc;
-
-	addr = sja1105_base_t1_encode_addr(priv, phy, SJA1105_C22, reg & 0x1f);
-
-	rc = sja1105_xfer_u32(priv, SPI_READ, addr, &tmp, NULL);
-	if (rc < 0)
-		return rc;
-
-	return tmp & 0xffff;
-}
-
-static int sja1105_base_t1_mdio_read_c45(struct mii_bus *bus, int phy,
-					 int mmd, int reg)
-{
-	struct sja1105_mdio_private *mdio_priv = bus->priv;
-	struct sja1105_private *priv = mdio_priv->priv;
-	u64 addr;
-	u32 tmp;
-	int rc;
-
-	addr = sja1105_base_t1_encode_addr(priv, phy, SJA1105_C45_ADDR, mmd);
-
-	rc = sja1105_xfer_u32(priv, SPI_WRITE, addr, &reg, NULL);
-	if (rc < 0)
-		return rc;
-
-	addr = sja1105_base_t1_encode_addr(priv, phy, SJA1105_C45_DATA, mmd);
-
-	rc = sja1105_xfer_u32(priv, SPI_READ, addr, &tmp, NULL);
-	if (rc < 0)
-		return rc;
-
-	return tmp & 0xffff;
-}
-
-static int sja1105_base_t1_mdio_write_c22(struct mii_bus *bus, int phy, int reg,
-					  u16 val)
-{
-	struct sja1105_mdio_private *mdio_priv = bus->priv;
-	struct sja1105_private *priv = mdio_priv->priv;
-	u64 addr;
-	u32 tmp;
-
-	addr = sja1105_base_t1_encode_addr(priv, phy, SJA1105_C22, reg & 0x1f);
-
-	tmp = val & 0xffff;
-
-	return sja1105_xfer_u32(priv, SPI_WRITE, addr, &tmp, NULL);
-}
-
-static int sja1105_base_t1_mdio_write_c45(struct mii_bus *bus, int phy,
-					  int mmd, int reg, u16 val)
-{
-	struct sja1105_mdio_private *mdio_priv = bus->priv;
-	struct sja1105_private *priv = mdio_priv->priv;
-	u64 addr;
-	u32 tmp;
-	int rc;
-
-	addr = sja1105_base_t1_encode_addr(priv, phy, SJA1105_C45_ADDR, mmd);
-
-	rc = sja1105_xfer_u32(priv, SPI_WRITE, addr, &reg, NULL);
-	if (rc < 0)
-		return rc;
-
-	addr = sja1105_base_t1_encode_addr(priv, phy, SJA1105_C45_DATA, mmd);
-
-	tmp = val & 0xffff;
-
-	return sja1105_xfer_u32(priv, SPI_WRITE, addr, &tmp, NULL);
-}
-
-static int sja1105_base_tx_mdio_read(struct mii_bus *bus, int phy, int reg)
-{
-	struct sja1105_mdio_private *mdio_priv = bus->priv;
-	struct sja1105_private *priv = mdio_priv->priv;
-	const struct sja1105_regs *regs = priv->info->regs;
-	u32 tmp;
-	int rc;
-
-	rc = sja1105_xfer_u32(priv, SPI_READ, regs->mdio_100base_tx + reg,
-			      &tmp, NULL);
-	if (rc < 0)
-		return rc;
-
-	return tmp & 0xffff;
-}
-
-static int sja1105_base_tx_mdio_write(struct mii_bus *bus, int phy, int reg,
-				      u16 val)
-{
-	struct sja1105_mdio_private *mdio_priv = bus->priv;
-	struct sja1105_private *priv = mdio_priv->priv;
-	const struct sja1105_regs *regs = priv->info->regs;
-	u32 tmp = val;
-
-	return sja1105_xfer_u32(priv, SPI_WRITE, regs->mdio_100base_tx + reg,
-				&tmp, NULL);
-}
-
-static int sja1105_mdiobus_base_tx_register(struct sja1105_private *priv,
-					    struct device_node *mdio_node)
-{
-	struct sja1105_mdio_private *mdio_priv;
-	struct device_node *np;
-	struct mii_bus *bus;
-	int rc = 0;
-
-	np = of_get_compatible_child(mdio_node, "nxp,sja1110-base-tx-mdio");
-	if (!np)
-		return 0;
-
-	if (!of_device_is_available(np))
-		goto out_put_np;
-
-	bus = mdiobus_alloc_size(sizeof(*mdio_priv));
-	if (!bus) {
-		rc = -ENOMEM;
-		goto out_put_np;
-	}
-
-	bus->name = "SJA1110 100base-TX MDIO bus";
-	snprintf(bus->id, MII_BUS_ID_SIZE, "%s-base-tx",
-		 dev_name(priv->ds->dev));
-	bus->read = sja1105_base_tx_mdio_read;
-	bus->write = sja1105_base_tx_mdio_write;
-	bus->parent = priv->ds->dev;
-	mdio_priv = bus->priv;
-	mdio_priv->priv = priv;
-
-	rc = of_mdiobus_register(bus, np);
-	if (rc) {
-		mdiobus_free(bus);
-		goto out_put_np;
-	}
-
-	priv->mdio_base_tx = bus;
-
-out_put_np:
-	of_node_put(np);
-
-	return rc;
-}
-
-static void sja1105_mdiobus_base_tx_unregister(struct sja1105_private *priv)
-{
-	if (!priv->mdio_base_tx)
-		return;
-
-	mdiobus_unregister(priv->mdio_base_tx);
-	mdiobus_free(priv->mdio_base_tx);
-	priv->mdio_base_tx = NULL;
-}
-
-static int sja1105_mdiobus_base_t1_register(struct sja1105_private *priv,
-					    struct device_node *mdio_node)
-{
-	struct sja1105_mdio_private *mdio_priv;
-	struct device_node *np;
-	struct mii_bus *bus;
-	int rc = 0;
-
-	np = of_get_compatible_child(mdio_node, "nxp,sja1110-base-t1-mdio");
-	if (!np)
-		return 0;
-
-	if (!of_device_is_available(np))
-		goto out_put_np;
-
-	bus = mdiobus_alloc_size(sizeof(*mdio_priv));
-	if (!bus) {
-		rc = -ENOMEM;
-		goto out_put_np;
-	}
-
-	bus->name = "SJA1110 100base-T1 MDIO bus";
-	snprintf(bus->id, MII_BUS_ID_SIZE, "%s-base-t1",
-		 dev_name(priv->ds->dev));
-	bus->read = sja1105_base_t1_mdio_read_c22;
-	bus->write = sja1105_base_t1_mdio_write_c22;
-	bus->read_c45 = sja1105_base_t1_mdio_read_c45;
-	bus->write_c45 = sja1105_base_t1_mdio_write_c45;
-	bus->parent = priv->ds->dev;
-	mdio_priv = bus->priv;
-	mdio_priv->priv = priv;
-
-	rc = of_mdiobus_register(bus, np);
-	if (rc) {
-		mdiobus_free(bus);
-		goto out_put_np;
-	}
-
-	priv->mdio_base_t1 = bus;
-
-out_put_np:
-	of_node_put(np);
-
-	return rc;
-}
-
-static void sja1105_mdiobus_base_t1_unregister(struct sja1105_private *priv)
-{
-	if (!priv->mdio_base_t1)
-		return;
-
-	mdiobus_unregister(priv->mdio_base_t1);
-	mdiobus_free(priv->mdio_base_t1);
-	priv->mdio_base_t1 = NULL;
-}
-
 static int sja1105_mdiobus_pcs_register(struct sja1105_private *priv)
 {
 	struct sja1105_mdio_private *mdio_priv;
@@ -459,49 +227,13 @@ static void sja1105_mdiobus_pcs_unregister(struct sja1105_private *priv)
 int sja1105_mdiobus_register(struct dsa_switch *ds)
 {
 	struct sja1105_private *priv = ds->priv;
-	const struct sja1105_regs *regs = priv->info->regs;
-	struct device_node *switch_node = ds->dev->of_node;
-	struct device_node *mdio_node;
-	int rc;
-
-	rc = sja1105_mdiobus_pcs_register(priv);
-	if (rc)
-		return rc;
-
-	mdio_node = of_get_available_child_by_name(switch_node, "mdios");
-	if (!mdio_node)
-		return 0;
 
-	if (regs->mdio_100base_tx != SJA1105_RSV_ADDR) {
-		rc = sja1105_mdiobus_base_tx_register(priv, mdio_node);
-		if (rc)
-			goto err_put_mdio_node;
-	}
-
-	if (regs->mdio_100base_t1 != SJA1105_RSV_ADDR) {
-		rc = sja1105_mdiobus_base_t1_register(priv, mdio_node);
-		if (rc)
-			goto err_free_base_tx_mdiobus;
-	}
-
-	of_node_put(mdio_node);
-
-	return 0;
-
-err_free_base_tx_mdiobus:
-	sja1105_mdiobus_base_tx_unregister(priv);
-err_put_mdio_node:
-	of_node_put(mdio_node);
-	sja1105_mdiobus_pcs_unregister(priv);
-
-	return rc;
+	return sja1105_mdiobus_pcs_register(priv);
 }
 
 void sja1105_mdiobus_unregister(struct dsa_switch *ds)
 {
 	struct sja1105_private *priv = ds->priv;
 
-	sja1105_mdiobus_base_t1_unregister(priv);
-	sja1105_mdiobus_base_tx_unregister(priv);
 	sja1105_mdiobus_pcs_unregister(priv);
 }
diff --git a/drivers/net/dsa/sja1105/sja1105_spi.c b/drivers/net/dsa/sja1105/sja1105_spi.c
index 856a751de53a..20757e166b08 100644
--- a/drivers/net/dsa/sja1105/sja1105_spi.c
+++ b/drivers/net/dsa/sja1105/sja1105_spi.c
@@ -495,8 +495,6 @@ static const struct sja1105_regs sja1105et_regs = {
 	.ptpclkval = 0x18, /* Spans 0x18 to 0x19 */
 	.ptpclkrate = 0x1A,
 	.ptpclkcorp = 0x1D,
-	.mdio_100base_tx = SJA1105_RSV_ADDR,
-	.mdio_100base_t1 = SJA1105_RSV_ADDR,
 };
 
 static const struct sja1105_regs sja1105pqrs_regs = {
@@ -534,8 +532,6 @@ static const struct sja1105_regs sja1105pqrs_regs = {
 	.ptpclkrate = 0x1B,
 	.ptpclkcorp = 0x1E,
 	.ptpsyncts = 0x1F,
-	.mdio_100base_tx = SJA1105_RSV_ADDR,
-	.mdio_100base_t1 = SJA1105_RSV_ADDR,
 };
 
 static const struct sja1105_regs sja1110_regs = {
@@ -618,8 +614,6 @@ static const struct sja1105_regs sja1110_regs = {
 	.ptpclkrate = SJA1110_SPI_ADDR(0x74),
 	.ptpclkcorp = SJA1110_SPI_ADDR(0x80),
 	.ptpsyncts = SJA1110_SPI_ADDR(0x84),
-	.mdio_100base_tx = 0x1c2400,
-	.mdio_100base_t1 = 0x1c1000,
 	.pcs_base = {SJA1105_RSV_ADDR, 0x1c1400, 0x1c1800, 0x1c1c00, 0x1c2000,
 		     SJA1105_RSV_ADDR, SJA1105_RSV_ADDR, SJA1105_RSV_ADDR,
 		     SJA1105_RSV_ADDR, SJA1105_RSV_ADDR, SJA1105_RSV_ADDR},
diff --git a/drivers/net/dsa/sja1105/sja1105_subdev.c b/drivers/net/dsa/sja1105/sja1105_subdev.c
new file mode 100644
index 000000000000..06957d44f084
--- /dev/null
+++ b/drivers/net/dsa/sja1105/sja1105_subdev.c
@@ -0,0 +1,154 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright 2025 NXP
+ */
+#include <linux/device/devres.h>
+#include <linux/ioport.h>
+#include <linux/platform_device.h>
+
+#include "sja1105.h"
+#include "sja1105_subdev.h"
+
+static const struct resource sja1110_mdio_cbt1_res =
+	DEFINE_RES_REG_NAMED(0x704000, 0x4000, "mdio_cbt1");
+
+static const struct resource sja1110_mdio_cbtx_res =
+	DEFINE_RES_REG_NAMED(0x709000, 0x1000, "mdio_cbtx");
+
+static bool fwnode_is_hierarchical_child(struct fwnode_handle *child,
+					 struct fwnode_handle *parent)
+{
+	struct fwnode_handle *next = child;
+
+	do {
+		if (next == parent)
+			return true;
+		next = fwnode_get_parent(next);
+	} while (next);
+
+	return false;
+}
+
+static void of_subdev_del(void *data)
+{
+	struct platform_device *pdev = data;
+
+	platform_device_unregister(pdev);
+}
+
+/**
+ * devm_of_subdev_add() - Register an OF sub-device as a managed platform device
+ * @pdevinfo: Platform device information structure containing parent, fwnode,
+ *	name, resources, etc.
+ *
+ * This function registers a platform device as a sub-device of
+ * @pdevinfo.parent using the information provided in @pdevinfo. The sub-device
+ * will be automatically unregistered when @pdevinfo.parent is removed, thanks
+ * to devres management.
+ *
+ * If the fwnode specified in @pdevinfo is not available (disabled in device
+ * tree), this function returns success without creating the device.
+ *
+ * For the sub-device drivers to access their registers, a form of
+ * devm_regmap_init(parent) should have been called prior to this, which
+ * makes the parent regmap visible via dev_get_regmap(&pdev->dev.parent)
+ * in the sub-device driver. The entire address space is made available through
+ * this regmap to all sub-devices, although they are expected to segment it
+ * according to the given resources.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+static int devm_of_subdev_add(const struct platform_device_info *pdevinfo)
+{
+	struct device *parent = pdevinfo->parent;
+	struct platform_device *pdev;
+
+	if (!fwnode_device_is_available(pdevinfo->fwnode))
+		return 0;
+
+	/* To avoid API abuse, ensure that the sub-device fwnode is,
+	 * in fact, related to the parent.
+	 */
+	if (!fwnode_is_hierarchical_child(pdevinfo->fwnode, dev_fwnode(parent)))
+		return -EINVAL;
+
+	pdev = platform_device_register_full(pdevinfo);
+	if (IS_ERR(pdev))
+		return PTR_ERR(pdev);
+
+	return devm_add_action_or_reset(parent, of_subdev_del, pdev);
+}
+
+static int devm_sja1105_add_mdio_subdev(struct device *parent,
+					struct device_node *np,
+					const struct resource *res,
+					size_t num_res)
+{
+	struct platform_device_info subdev;
+	char name[64];
+	u32 reg;
+	int err;
+
+	err = of_property_read_u32(np, "reg", &reg);
+	if (err)
+		return err;
+
+	snprintf(name, sizeof(name), "%s.%pOFn", dev_name(parent), np);
+	subdev = (struct platform_device_info) {
+		.parent = parent,
+		.fwnode = of_fwnode_handle(np),
+		.name = name,
+		.id = reg,
+		.res = res,
+		.num_res = num_res,
+	};
+
+	return devm_of_subdev_add(&subdev);
+}
+
+/* Legacy nodes which lack a proper resource description in the device tree,
+ * so we need to specify it manually.
+ */
+static int devm_sja1105_add_mdio_subdevs(struct dsa_switch *ds,
+					 struct device_node *mdio_node)
+{
+	struct device *parent = ds->dev;
+	struct device_node *np;
+	int err;
+
+	np = of_get_compatible_child(mdio_node, "nxp,sja1110-base-tx-mdio");
+	if (np) {
+		err = devm_sja1105_add_mdio_subdev(parent, np,
+						   &sja1110_mdio_cbtx_res, 1);
+		of_node_put(np);
+		if (err)
+			return err;
+	}
+
+	np = of_get_compatible_child(mdio_node, "nxp,sja1110-base-t1-mdio");
+	if (np) {
+		err = devm_sja1105_add_mdio_subdev(parent, np,
+						   &sja1110_mdio_cbt1_res, 1);
+		of_node_put(np);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
+int devm_sja1105_add_subdevs(struct dsa_switch *ds)
+{
+	struct device_node *switch_node = dev_of_node(ds->dev);
+	struct device_node *mdio_node;
+	int rc = 0;
+
+	mdio_node = of_get_available_child_by_name(switch_node, "mdios");
+	if (mdio_node) {
+		rc = devm_sja1105_add_mdio_subdevs(ds, mdio_node);
+		of_node_put(mdio_node);
+		if (rc)
+			return rc;
+	}
+
+	return 0;
+}
diff --git a/drivers/net/dsa/sja1105/sja1105_subdev.h b/drivers/net/dsa/sja1105/sja1105_subdev.h
new file mode 100644
index 000000000000..9b5a02401399
--- /dev/null
+++ b/drivers/net/dsa/sja1105/sja1105_subdev.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright 2025-2026 NXP
+ */
+#ifndef _SJA1105_SUBDEV_H
+#define _SJA1105_SUBDEV_H
+
+int devm_sja1105_add_subdevs(struct dsa_switch *ds);
+
+#endif
-- 
2.34.1


