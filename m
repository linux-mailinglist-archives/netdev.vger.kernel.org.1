Return-Path: <netdev+bounces-251621-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6OzbF2L3b2m+UQAAu9opvQ
	(envelope-from <netdev+bounces-251621-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 22:45:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 142D34C757
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 22:45:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CC92A8EEB71
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 21:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE383C1FD5;
	Tue, 20 Jan 2026 21:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="h1BDVSvH"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011069.outbound.protection.outlook.com [52.101.65.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E7D363C77
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 21:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768943470; cv=fail; b=km2MSztxx0zIeIQKrSezi/jdBmjSp7macv92P7PVXnYwVsfbP1Ge6cMrjWV17Z5vJNIX6MgcQtIL5ypRLAg1/soAYaHNVXk1h8kVKoqeD6vA/guThLi1s7dBuosmYu06FGNkB4ymmpYZ+jLqKDDua5ZKpnCfV6DmkA2tKHK0JlE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768943470; c=relaxed/simple;
	bh=VT9dQu3sIGfny83cNljbAC7PK2gPeBGX3f0FkpMiayI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ocZFjRE0ibeE9wPrXIbDv8I9o/XJfNpyloYuNw4nFWdSqZYXK1g6AH3+g191ObdNBIP4esmXN95nRDORTT/m9EyjadqdWQg/+PY51oZOMULZOWUoV5hLm+VvzTZ/1cviGJkMhblym+DDPvixE89NZR3zPyjqD/t6F+fU6VYEt30=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=h1BDVSvH; arc=fail smtp.client-ip=52.101.65.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TFDVDxpgdGXSfe9FZDtdCFTXqNg9tUJPLpQF01kj2usG6gqcQT+JfbUjuHuSIn7jQEamVnNG9DpYT43DhV98GcE9lkqQx6kJLVM096Elfk2pUrtXnp/tx6QmtUO138r6+ZnbmZEELjqPu952W/s1cm2iOaCMRTw6UAl41oDLYQypLoyN1NcfLuF6SSyQk6zqB7ea3KIK7/xU8BPScwN1Vbi/Lx2JJYwF47NzN/mHqVXfq4qVonZmqg4lGTnsNCVgCj+7qkxHzvwNOmqFJ88fugiJSnudx3Ya1hzXIOThTNON0aUeWSFPn8l5sL9eASctADOfgTMrG90BzvXdC4v4yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8XIH04L+U8yK/pLBD6At550lhVxNvlsZJs9b2TIbezA=;
 b=uqZ+qgsCmVW0B4o9oNgUpaAfrhLWgDfarfKEYWLtaflVjeFcUi61liqVcRPprw9s5Q1EY4M+UesBeoJwVgOztFxo6qAAx2z+U30ASl8vnqtL8U4KFpKr2l9Sz7jDN0RoAnRrj82hv3O6Ey4iV4zZ92ljhLj+zCKTdXO6JPUUO9bcvKEKoFhmuyJNpCyaHOaQDEACKgHkAAg0rcvjZsjkq2DzsO52jsL9RRGySjrYePUYLZZ4l6tdbVbKrx9TemRS3ip1qMxUiM8TbRFqsFoCKCXLM0a9SGyM4ddlL31++TDyNXa7tGgby1LOBdsYoX+Er4FtoonacAyKFvwQZ2oe+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8XIH04L+U8yK/pLBD6At550lhVxNvlsZJs9b2TIbezA=;
 b=h1BDVSvHqt8cGvfeTRwYvXXWFioZkRlzjX/r43klSOHIiWUmgX6lVWudiSW2qm1LMuojx8Re9rCNv51fwkinTZgpXuMbbTz2IWaioTnSCTUSGNefzyqBTrNObtR+/o8sM5ZHWTTUK6Yv+h3yJeptE6Xgk+VNXMBz21mpa7AnpTRmOoAT7VpMC7US072c+RKLldDRpDUwE38j5ScO58S85iVvfPv0aIlJ3cCAKtH1zgjQCj++EdxNob4wu8s4ETkOflh94eHOcj30X69wuJnr6GMnOn6SgG2zwxLL+NBbSW01Vgf3qmm9Svs7xIVsww/2R7SWvg+lf9JmlaMmk6tsIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by GV1PR04MB9118.eurprd04.prod.outlook.com (2603:10a6:150:25::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 21:10:59 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9520.011; Tue, 20 Jan 2026
 21:10:59 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	=?UTF-8?q?Alvin=20=C5=A0ipraga?= <alsi@bang-olufsen.dk>
Subject: [PATCH net] net: dsa: fix off-by-one in maximum bridge ID determination
Date: Tue, 20 Jan 2026 23:10:39 +0200
Message-ID: <20260120211039.3228999-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1P194CA0025.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:803:3c::14) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|GV1PR04MB9118:EE_
X-MS-Office365-Filtering-Correlation-Id: bb698657-0821-4902-cede-08de586868c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|10070799003|1800799024|19092799006;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oQlTTPmMCYipjeOjWmMnrJ1HCj4ZYsjLiKhlxel+RlfYf7P3wqFxPem9PEr7?=
 =?us-ascii?Q?fV5/A9UWR7LCEOTcxB8RWO2hcMoSe65j5V6b1WQdEwWMI0LKHiaWyJ8QLGER?=
 =?us-ascii?Q?uGQMNFUjFunSu3nl+s4tqomeJduZdIGG2lxsnJTeddS6R5lZjWT+88zvEXEa?=
 =?us-ascii?Q?W9YOlA3IH6rlQoIBqlitzr5mAeCSLpiiF9frmpuHalwBQ3Ungja61zuoQBFo?=
 =?us-ascii?Q?TpQvPFUQPcub2WDVtCTQr6ex1fC+8loiDXZx+f8uxDU+73v6JU8sFsR4Jhxw?=
 =?us-ascii?Q?EpUrqW4m0JVKDeO5nm4ozwUm/lcgN5/yxX/EPCO+h9nPilZPEPyIYt7i0GSs?=
 =?us-ascii?Q?nVZ/FXhUbMH+mFtpJcZhU7LpkMOKcPWodtPVrKiMjaT1JbyZIjNE0TKTQM8j?=
 =?us-ascii?Q?jFGfx+u7Gu3yf/arxtIv2oTJGsd5Jjm3zsTPNnq8LApIUz1vlRuUZwygorBP?=
 =?us-ascii?Q?0COeM1mkgFSsAzWX51o5yXATsW4QCTXxAkw8gCE53p5odo26MRSJBH7kXIf1?=
 =?us-ascii?Q?ZezDUFekQNnFCdHXp+3eCQ3TzFi+11WxjeWnj39evXqSjqhlOL1g9G93EZZR?=
 =?us-ascii?Q?Po8SyFzOThvQqR399aNeRFy5UprTgI38RHZqNkMB4aTVehcQ7e3r8JdnHugr?=
 =?us-ascii?Q?HLMJd00IYr50/K+gNwfzLSdDa0fNWqBLl4qRZOWdCdkJhxanyTP/nqujbLxt?=
 =?us-ascii?Q?AJAW8W3htgkEIKBkffptonWbSIBOAdorqkocl3M+Qvz2OBY1HvhYr9gLCiiW?=
 =?us-ascii?Q?B1gKjI+aQX5RVUuES55N82TFef8Z4AxraZdLijt0MyX5ZHoHY2Rj1WKodb/H?=
 =?us-ascii?Q?Tr23bTZEN85dCSniQSv7yA5XCLttsov3Ptdd0CsbtBtqyVzI2PLNCd8Or1T3?=
 =?us-ascii?Q?MdSthxNoYU3OTGS2HV+T87wvckOUUKYR3ftX9sEce5nf5BqGLjgpDGQhZ06g?=
 =?us-ascii?Q?qARQM1bEW4/lFFuOsU6GhhE0ly1b2NuHgiyHQKGXLWy0UQ7/7QHjZ2lUz/wW?=
 =?us-ascii?Q?9eicaVCdzCIII8LDd2jD425S4nBQ4cGkekv98W4cmZJE1LhqpBkSG1kpiqwv?=
 =?us-ascii?Q?VgRez89tth0eR56F5LTX4HkrvNOP8o/QyoxkMmlMTvfDIP6i9h/XvNltynBr?=
 =?us-ascii?Q?ZopUst+JOIldsrpDMBk+6B1WPpVD54eGCJEw0si/qmLHxfQkPP0jyBYMR5Ys?=
 =?us-ascii?Q?h42u2Q3Z1bBGyNU2fivoZtanfV1H3tT/F5YLFSB8i3+hcnWDzvYHho+XzDZa?=
 =?us-ascii?Q?VBKsWijOUaNkFw1QBc0XEotkgfeRbPc0sOB4ZMj7LXpAbRLNrWcZjhkcZDzg?=
 =?us-ascii?Q?blAc4DSK4nuH+ZmOwr2iNklI1kPPEk/Q4UORZKuRwh4uyKupgdQmaYfTfBda?=
 =?us-ascii?Q?dGmhevzjQ7J+7C+SaJvJhnM0wqDa0W7CM7C7omlUwn6ewzqPNTR1632YOkQf?=
 =?us-ascii?Q?nXwF2h0wB97hmVot2eYOWtEsAnBhHskMxuudnmgNf/W4+BJU5HB+/z7V5ttE?=
 =?us-ascii?Q?eEHHLV/NoPSqzyrPpYWO/CdTDqqwbeQeI7rRHcBcYzasf/MXvrTZaUHIbi7O?=
 =?us-ascii?Q?P7Q9W3OZC8PGEcO3PBk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(10070799003)(1800799024)(19092799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?noi+XuQZLuDrJi8zz/srcXzZAKVbJroMqKfB4b84qkXxkgYjR//6ybouNIn1?=
 =?us-ascii?Q?XU7vEulXBA84oB+Bgq+Iy58fJ8y+9752K8OjGCAf+8ERkv96UsbSiv+jcTxU?=
 =?us-ascii?Q?EEJgVKXGUG8SEtY0tgwxXAvHvWTFDVeHHhd6vF1oSY11s9Svk+CwYplAznf1?=
 =?us-ascii?Q?zblR2UGcY3GcNbAuwe2Z5bGThxgC63crZp+DKioOuQGYj5qjXmBjtZ7auuuP?=
 =?us-ascii?Q?qhUECNEBIakhhv3sQfDlLTefx4jkaLsaOSsK2pEf32Wnt9uqNSe70vFMbhjp?=
 =?us-ascii?Q?a4kHsNj/rRq35MKXINMBaxDUe1ELXJ8aBr2SlXqTCPK0YIEIc744mlS4t9SB?=
 =?us-ascii?Q?n8rjA/ERLqO8ZFJzRXMGypvJUUmpDaI4jVL8BCIYsIf513wZLiZxWpzL6nRK?=
 =?us-ascii?Q?ExVznsHnUMrmDuihIB8Rlj3kFvq2J6vGDpbffMvsYmNo9sTxjYa8qT1aQzPi?=
 =?us-ascii?Q?yK29CplXBJwgBg+77NE/MRLlrF+f9LaJb6lfuGIQs/JF2W/2AV3Rfvk2sSR0?=
 =?us-ascii?Q?XJYM10oQeAx4FfvB0bHHC8dw5CbDCMWfs/nWZvHSKzyrzsWYelXV2myGGrCz?=
 =?us-ascii?Q?HNofjKu1pYYDxwni1moF7Y9s9nwZ26KsJZp3EEGJ18nJG+Cb3WfWpynFqCsG?=
 =?us-ascii?Q?enW+FP98TKVbesg3tyVgzEq0EkCWuP9vEoh3UeUNVNJUPeyeLGxJ8DeyCgKd?=
 =?us-ascii?Q?wzd75yEP4ypNTP33tncPd3OddV2xv+HoCUzZLRvGKY/zNRcZlj1M+Ucq3d9h?=
 =?us-ascii?Q?bk5c3xxfKDEvT8jSp/HRBJzvmOMTi8B+cpz1KEp/lz+ZXd9Rz7oR+03Y7U4A?=
 =?us-ascii?Q?49U9lUNt5uf7Sgxo85+jwnHB6+oeEvyLkdzdnfiXwn4QgAznjtbd6gQaDoew?=
 =?us-ascii?Q?pRnuZ6Xci3qv7+XeQ+cZgozppKRS081rmI+yFzOLgfFZJbQM7v1eyJjY9Fvb?=
 =?us-ascii?Q?g6IV1+/jfAhDqSizD/jZOtH95WBrvVy677mNzsbDsjtJJDXJmh8A+8mvu58c?=
 =?us-ascii?Q?UhpzBAZ4gmuiPqEfrMU04g2GG4ez8+FWdYu4jEpduUjIICGQZ0vkBO3MZ1rR?=
 =?us-ascii?Q?ZQ6A1wnDHgVxCYq3XhZGAiK3BJDfoJuHl82rh37RtuwdlIr8ckD8Dqci+M3g?=
 =?us-ascii?Q?ykYCYZF5mcEHinw0EKoOXJzMu8EkwkkA16ViwKCK7gUnERl8cy+5tdx80MQU?=
 =?us-ascii?Q?vi26oL2iueBjfr+BJ8Q8Vgev0IGqDsyYFE2m671NGumJi9gNRN6/MXRV9z88?=
 =?us-ascii?Q?GD1oM/3wK/HlCY8fPQqdEOoO1tlH1BJJZC2Q5yEQbRSCKcIQ7h8ZCn7dB/xA?=
 =?us-ascii?Q?6sKH3FaF/OijtuWvDdajf4ok1cTNrFTvgZjEnjN2WGkDOSOuLDibykjtkSO8?=
 =?us-ascii?Q?/wQl4i5FsvRaO6GoX5HlmGgj/d7NtPKZpIh2Ec2+ixxfeIHlThBJefpbE8+M?=
 =?us-ascii?Q?cY6bh5CiFcC6G15LakCb0WD5vSDqA6KwKBvoSsGFATKMGx2JjtsHnlvxgKk8?=
 =?us-ascii?Q?22kikhHRaQJ7nbv/kRNlDIEJiqFK+g6TPbMIpNlP13nKb0bF6AyCh+B8m8Yj?=
 =?us-ascii?Q?1FohOGHxwAaOtl1hfbPoD7MR8SldFijODvzkNRYxiYhr6RiGPHCQHK3wFJ6G?=
 =?us-ascii?Q?S3n6On0Sjial3sD7nA39auUbO6UzU+FkOSy7k6cJqnM0J29vnHgTthcpMqk+?=
 =?us-ascii?Q?RkXzYGFx8vKuQIJdCDM+hTTkb3DXXIiT3SkkKbgGK516TJmcP9pCC0XpUJSf?=
 =?us-ascii?Q?nA7OZbNiP0bOzr3zZeKz2szOu+5juVBxdKvY/D+dbCt7x0TT0bzaNqNnf3Js?=
X-MS-Exchange-AntiSpam-MessageData-1: jlQMfwbsFSjXGg==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb698657-0821-4902-cede-08de586868c0
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 21:10:59.3352
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: geF+bi2hIcPcuS2T15JlAY2QVnEQAtFG+82gDRRpqAR/wKKK8JTFLLDDgBopY+/xTnJEz8bRYjgip3mugSaq6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9118
X-Spamd-Result: default: False [1.54 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-251621-lists,netdev=lfdr.de];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,netdev@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[nxp.com,none];
	DKIM_TRACE(0.00)[nxp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 142D34C757
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Prior to the blamed commit, the bridge_num range was from
0 to ds->max_num_bridges - 1. After the commit, it is from
1 to ds->max_num_bridges.

So this check:
	if (bridge_num >= max)
		return 0;
must be updated to:
	if (bridge_num > max)
		return 0;

in order to allow the last bridge_num value (==max) to be used.

This is easiest visible when a driver sets ds->max_num_bridges=1.
The observed behaviour is that even the first created bridge triggers
the netlink extack "Range of offloadable bridges exceeded" warning, and
is handled in software rather than being offloaded.

Fixes: 3f9bb0301d50 ("net: dsa: make dp->bridge_num one-based")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 net/dsa/dsa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/dsa/dsa.c b/net/dsa/dsa.c
index 99ede37698ac..35ce3941fae3 100644
--- a/net/dsa/dsa.c
+++ b/net/dsa/dsa.c
@@ -158,7 +158,7 @@ unsigned int dsa_bridge_num_get(const struct net_device *bridge_dev, int max)
 		bridge_num = find_next_zero_bit(&dsa_fwd_offloading_bridges,
 						DSA_MAX_NUM_OFFLOADING_BRIDGES,
 						1);
-		if (bridge_num >= max)
+		if (bridge_num > max)
 			return 0;
 
 		set_bit(bridge_num, &dsa_fwd_offloading_bridges);
-- 
2.43.0


