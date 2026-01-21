Return-Path: <netdev+bounces-251749-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uOWlFq5JcGnXXAAAu9opvQ
	(envelope-from <netdev+bounces-251749-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 04:36:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 19CAE50769
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 04:36:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DF0573E3823
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 03:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C7DE369983;
	Wed, 21 Jan 2026 03:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="OdaMMwKg"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013013.outbound.protection.outlook.com [40.107.159.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81194366DDB;
	Wed, 21 Jan 2026 03:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768966478; cv=fail; b=I9d4QmW3fddlBMu8EwbNgIsoRlYYT5ZkCh4z59M0nCgzYrjiEEyTro95PpIzoBIt8rx1PqFxuZ1f0KLdYlb3yxmI4FcxHZeXmgLVt05y8vSGuvv9GBC1qmWudjFYRh7ekFjIX2YyRveCHqV0ONy9zhfVShx9G3OQAZNI5yeuVG4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768966478; c=relaxed/simple;
	bh=hrOXuo72j3c6ITj6huu2FimsWjiiEBCzUo+9DyENXR0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FY772aXzR132HWqlxoLYF4GsJMjw3mxrL4eHPTSrB8UeSCbvi5BJg7IE2ZvS3+hOTNV0hEdELv8XxogsrvRlCj93BjGDEVrnTMrKWXygTeLIGN5dgi52eRbsK2qVyZgTmrN8G12aGnU8RcPZO7qUrID8sbzrwxAxW2sktJleBec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=OdaMMwKg; arc=fail smtp.client-ip=40.107.159.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kUiCA5VTfDHElqlSGyheDsXVDPXQYHmmAr8kGx8CB6DQSh9Nk95Ie3BMm5UgtUjiop4b0lrSotq4VYIF6rJHpI2zDxpLJyrXfxo01BEtwWlY1yYhpeS3v9Sbf65Ze92+GDjFMTkO3f/ZnVj+fDrStt0Y0KpaI75nY0eLaipKHXMXGrBSG6IdTCZX1ayKwYfU8QnoFlLM0fu3UubnLRtdVmVuGI81DwyQoydVzuYD0bS8G7TM2GGzgAqMuMZjriC6Dr94FJcAciP4TJx3UCdSV9Aq9b7WMq6untVS3/gEvs/TaJQFgnJuUQGDUjP7UZf86poLJtmg/C5wB7pp1ubXsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CUuI9yxuh89Kp3lTnrvIy34OFS5EOA5JgUX8IqWLaVA=;
 b=JgrrPkJoJv6KZVFYAmzv2M9sNO/xAH0BsTxvBhmhsd+u8GA08umd1w5i3ZgBnPMG0wlRnY2q0Syqzlrgkf7yUSSA/u3buYMiMxtDOjmeq5GFImS68AiMsBlfyseukY+vOzp02Q14W4Hxf7w8upi9xypDUU8gBTZKnw+gDM5MWNsjkBpRLhZUnWaXHYH/A7Bf7hxCSR6UYmmHYIWnA1kpNqucB/OfaqaQA+VCRFpYFTDY5TW7IqG5QaJiQrpUG5Isjk5P+sywLdyOe8zjVr5f/tOH9h/aU4S7d8r530xwB8dWNZIzWN3TB/nmgDqSl39Uz0J1/MTIPyQ+ykrhw/cSVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CUuI9yxuh89Kp3lTnrvIy34OFS5EOA5JgUX8IqWLaVA=;
 b=OdaMMwKgNKyt/hkMMimcP2rFnmQG6LaXjiecyWzchTV/bbzWt+iPdtVF4tuiJCFlba70sI2/d2TRQry4O8jFrcjEbfjrtj08978swMcr58amUOKuyPL4BO+pZtKCjACpR8Sp6rWutfZc7Sqq23qgpmRXyGvvTCk2rVYEz8Ehjn9A+3CiVYASjlM9ryGGLv/+cGboDPq3WwyW4w83o1V6qyS11GgSFF1wAmZTbEK2KzS3YGdA9gQSehjPBZZHF7UzaAk0pMdIvyyJmV90eJnbIGc41bc3EriSrA3F2NTPuapnFn6ubIgTNdEHQMcETtDcexCr2lttsooGxN5iJHSjYg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DU2PR04MB8773.eurprd04.prod.outlook.com (2603:10a6:10:2e0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 03:34:32 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9499.001; Wed, 21 Jan 2026
 03:34:32 +0000
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
	sdf@fomichev.me
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	bpf@vger.kernel.org
Subject: [PATCH v3 net-next 03/15] net: fec: add rx_shift to indicate the extra bytes padded in front of RX frame
Date: Wed, 21 Jan 2026 11:33:45 +0800
Message-Id: <20260121033357.3261464-4-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260121033357.3261464-1-wei.fang@nxp.com>
References: <20260121033357.3261464-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0049.apcprd02.prod.outlook.com
 (2603:1096:4:196::7) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|DU2PR04MB8773:EE_
X-MS-Office365-Filtering-Correlation-Id: 19cbf95f-f87b-4bfb-2ed1-08de589dfd95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|52116014|19092799006|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2A1D2Fymx3BDH/pqtsVnb2KhIGMAdfNNtxIchNj0cM/92sHnah4lJQXFqnPK?=
 =?us-ascii?Q?XTRjyq99+6vQ3+Ecr1nTq8qEiYbYoWfBCEXVizSgaN4+hx8boiLfNhC7QHne?=
 =?us-ascii?Q?MP4etQ6kN9Mu5YjgkYWYVFUU1YHwLeBNcQXPR/Ieg1IhmQAJ/ZMYUa+UPPLr?=
 =?us-ascii?Q?irGoSmpY98NNdadpSUWbYI5Y+CN2EdUmFiyIPoYu848lLf6oXYUOw/xAled/?=
 =?us-ascii?Q?Sz8m7W3r2uPy5ffKa3JcUHrz252o5tRxPtQ+F+QYF+YyM5ZPCdmIknNd3Dtm?=
 =?us-ascii?Q?Q/97SttvuihQZfAgMsWgB95fflV7bsJazMCUGdsoAMNO1SEoOqQqCHlgJv6u?=
 =?us-ascii?Q?YjYItVRDvYFh0FUC+8t4h7gTZsqiiNICv2EIaEazZ94jnA2833eQPpfUDXTM?=
 =?us-ascii?Q?9j3Wc6t+hH7GEyASK+ZcDlB/Vt+3j+53UOaI5OZ52OWyDPH/rOTiTbYLyqvG?=
 =?us-ascii?Q?1Kqv3d0ER1XnTr4SW3hrI1MM7ac0cnfZkFGZANi69b5P91s3KFuC+/yGb4yh?=
 =?us-ascii?Q?SzelB1dCiyZ9X2+Ehi7dpuyf7Dd3cxbsMCFYGRa3txueH+Y+wDwElj+VFFP1?=
 =?us-ascii?Q?tKEmNQo1pFyx65WIZOZp7QZxPOfDSLQySQDK/qIrjwhnEA+rwstb5Axa+03w?=
 =?us-ascii?Q?dnRVpJgWOhv+55nksU95VDqAe+a9bxEAG5QOKpVdGf57II8tPzCKjth6dJlp?=
 =?us-ascii?Q?waH6TJc1aPLgrfDbwtS+3qcZX8sS+wokGV08TJo6R5cA68GenfKntV7FtdaF?=
 =?us-ascii?Q?AVofNL+t6cVixwC8W3XC/WMDF6EaveY65HiM4B+SGQF6TDodusNEaRavffai?=
 =?us-ascii?Q?jeqzqSWuee+WeZ5BWa6p10+YxW7xoRikRIfE9Y4/lYV9krNMsg/cvh8S7Jdc?=
 =?us-ascii?Q?0XQxuePRTeD6lrjK5rDTMhGVZCbrSGIRW97vb9Vn/GWqo1P8xOSz70ebWdt7?=
 =?us-ascii?Q?DGQegWQbEzCIartXLD7UWTf9oX5Pvms/pnuh4IBhVMUX1XUQbWoRPQPnYy+j?=
 =?us-ascii?Q?ZHgzKcS7uo6NlRp+w0sqszjpsGPk6A5ZeYtUj22PYDZAvykHhisD2CmVxCnj?=
 =?us-ascii?Q?tQwUx9NCMFHP9F7/otwDQMldjpm93xrQ/wYpDSovycTwFNlSn90hiafG/l0e?=
 =?us-ascii?Q?L5byeJPAKsDtg1LRq0jKzBoDdHzcPZfYne4aqBl+jRghRAdAbsLov2GVAjR/?=
 =?us-ascii?Q?+FL5BSJ7lCVF/S5xGnM8eEKnIu+F7AiqEqiJadtbmNH4OHHmEndDKd1bLNXc?=
 =?us-ascii?Q?lJfgk8HPa8yJjafJIbxD8j3nEyoepfo48sgmCNW07yQKHy9nqpeqEk9T5xTD?=
 =?us-ascii?Q?qf8DOnz0PL6GIzU1UiN8CO4+ggRGVlqzFmq7IWhVnnEUXRTFXvZLhIL+VzIG?=
 =?us-ascii?Q?0vrUkbMoIBO+qbLkLNNEk681ofBKd/Z1CrCs6fQ/WZ2cMfYjDATmv7ClgKwN?=
 =?us-ascii?Q?wfTpQYzxFGyp+qapCEr7gtsL0jCLOp0FAq+xOlZRVrXoSNe0mg10hyb+kShq?=
 =?us-ascii?Q?zGtiD2JKPEb3ozOszQbBOz2mwRhwWnOPZlD9gw73tzuurdwlmHttqKxcq9ok?=
 =?us-ascii?Q?VMieWiRBMecPo7HUbvhH61hrHp6RkNk5G8JvpnlaWwYG4skyquvhoCOzXQl+?=
 =?us-ascii?Q?tV0qwWfJnEQLed55W7ChMfdjLXr0Wiyh1DNDZjlsvqJP?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(52116014)(19092799006)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fHdRfwnDCjJhIh2JkYBto2RXVUBDiFIJuc43aFXk6+gHkDmU9nlnK6M+tbZF?=
 =?us-ascii?Q?V7Sa7CHtComob3cAgDqzCR0LyV6/adA3oWusdgxhYwTdYUSy+hb/TfwJ6gy3?=
 =?us-ascii?Q?QRNwW/6KnpeAhpCBhJLUnOr4XCtniz/fUhdSfpqSvjF1kab9GAYEDFGOrYi2?=
 =?us-ascii?Q?uZSYhy/zUk8KNSq1pdJJpqkdMVtkOCkcEKTwEGc5HgOwhHRX6ZYVUTz6hLrC?=
 =?us-ascii?Q?Jyp1c6TDJPRxFWPGceaQ5Ec57WiETwtxlPIXT6d+GUsKhCQC1xcLnxkar8Do?=
 =?us-ascii?Q?maEJrypm/8h//VpxfGTQ6uLQTijII91hHlBqAtZWpd9wG3ezkT63LSMYFzfG?=
 =?us-ascii?Q?fD4uzJL66c+ZJ0XxlHPoOoVTBPot+n4GnIe6EJybLhPBMYG7LNR93xL4OnUk?=
 =?us-ascii?Q?cPAZij096uqsp9YP5qaAzzJBtmzEdwZbIPQsUvE1842hG5SZX+VcqNkTNtXi?=
 =?us-ascii?Q?oafVM/KKpCj4dGp1s1L/sPVW6FO5q62qKvGeKu/q0aS7T3R+Ws4P2ene1chM?=
 =?us-ascii?Q?EeNnkT618CzlfaS7lZ1H5mSdHAqTWsSt9viwCh4QX/0Ig5KKd7MGPgNgtM12?=
 =?us-ascii?Q?XcE3MB0kFlPakgHEPT7iY1WqNHABHjr8yVspceWB/dW+yd4mC3e04PkR9snb?=
 =?us-ascii?Q?bYPfReHKW2kpc9dwzjXc2Z5H4lftrh4W2+Rk4k5X/VaGzCHuH8Rs8VAzkkbf?=
 =?us-ascii?Q?5qTtu8SQ9dTXvFp+e/OpHAG2/R1ScXsMKjP2gx7D1AGOGJIWfgL8ZsizcjWE?=
 =?us-ascii?Q?G/K6XqYcWrK0LlyKwxE1/Xl1/WrkWnlXw4NtMIL3aC+u4X/u5j/TKRLXOyCD?=
 =?us-ascii?Q?5ms/b1CExdw9FJETssa2X+IAXaRqRhhD8/aSnTp5yCa9hYv2EvKek1/LqjWs?=
 =?us-ascii?Q?U5WQskMrdyd2TDrrmiaBy2EFGxzFUG3dxUhXlrZD7KbQwd0c+o0ajV7F9Mb5?=
 =?us-ascii?Q?yt+cJSKd4jC4GdMbLFC7WxB7IUgFVFJBYdzge6hVHAgo2dJNKBKGrl/hbAY8?=
 =?us-ascii?Q?AZehZkyg8nOVypQUIsqHvh+PSw7iIw2jA83uRsD9oPv2qXmBt24XPYlmdW8r?=
 =?us-ascii?Q?qNVkvI9NnA1Vof2nQVXd3KWlei9YzB5QNjsD1CecTnrahF3MNEaK7Q+Xb7hR?=
 =?us-ascii?Q?dNEdbnzKStUc4MwcgeVE3MdNSZq6594r52QkLeNUfJna5XcyyGsNoVn8c+YZ?=
 =?us-ascii?Q?LzkN6tFB/4qmDV+0qBY1yu+2I2njM5VwgzZjPr162rFgKhmzqv4O9KBNdDDH?=
 =?us-ascii?Q?DOedPekyjO2YmT+ShMHLBckR27VTTVX8WRJYpKjYl6EMfRYG26zTHfBOfzA7?=
 =?us-ascii?Q?0abPYHNyM1LgS+TPayhUysoEOXSv34TTIAo1AVX3wxinj3WCsMT8Kmd+lC8F?=
 =?us-ascii?Q?doGfdDlzCA+XdVKtJPkNF/oltp7SEA9p+zPcIUKxvPG3X3AzfbhEywd09JvY?=
 =?us-ascii?Q?qTJxQE+nVePOR8CJdQyDWrAjiL078Ed4eCBBDiCGWqn2q+3lzjFtYXYudD1j?=
 =?us-ascii?Q?3tJltKXUHiGzTpO8RZ/1ZD94TOjSBOX2++1ny7josnTMYkMwzV2VRAPcLXSO?=
 =?us-ascii?Q?yuFThpgNBao+Upuwh8UsF/InEH1pZxGF8wtxKvNzqdJCdIfFwbWV5UxbNbKQ?=
 =?us-ascii?Q?4IVPV5UWPqi71tt5TPOv5Tpmmyb+y8QkLe0aPL+ajFUfcGDO2PGPFX8sFLzZ?=
 =?us-ascii?Q?ewXSyoOxPHVmf5FF08t+Nr3kXGoYmBE8dBkXtYCI183FaSi2WT7Tn41HjMe5?=
 =?us-ascii?Q?fphGf82Y6w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19cbf95f-f87b-4bfb-2ed1-08de589dfd95
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 03:34:32.2184
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hy+XfeqVE6OVB1XHpOoPYAkOc4I6yA8TiQN5SesZy64/FqVyA38UQ9Fz3KU5ubiVo7vuF+ZKecswFpHw+Bw9gQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8773
X-Spamd-Result: default: False [3.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-251749-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[nxp.com,none];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:dkim,nxp.com:mid,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 19CAE50769
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The FEC of some platforms supports RX FIFO shift-16, it means the actual
frame data starts at bit 16 of the first word read from RX FIFO aligning
the Ethernet payload on a 32-bit boundary. The MAC writes two additional
bytes in front of each frame received into the RX FIFO. Currently, the
fec_enet_rx_queue() updates the data_start, sub_len and the rx_bytes
statistics by checking whether FEC_QUIRK_HAS_RACC is set. This makes the
code less concise, so rx_shift is added to represent the number of extra
bytes padded in front of the RX frame. Furthermore, when adding separate
RX handling functions for XDP copy mode and zero copy mode in the future,
it will no longer be necessary to check FEC_QUIRK_HAS_RACC to update the
corresponding variables.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/net/ethernet/freescale/fec.h      |  1 +
 drivers/net/ethernet/freescale/fec_main.c | 21 ++++++++-------------
 2 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec.h b/drivers/net/ethernet/freescale/fec.h
index fd9a93d02f8e..ad7aba1a8536 100644
--- a/drivers/net/ethernet/freescale/fec.h
+++ b/drivers/net/ethernet/freescale/fec.h
@@ -643,6 +643,7 @@ struct fec_enet_private {
 	struct pm_qos_request pm_qos_req;
 
 	unsigned int tx_align;
+	unsigned int rx_shift;
 
 	/* hw interrupt coalesce */
 	unsigned int rx_pkts_itr;
diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 0fa78ca9bc04..68410cb3ef0a 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1799,22 +1799,14 @@ fec_enet_rx_queue(struct net_device *ndev, u16 queue_id, int budget)
 	struct	bufdesc_ex *ebdp = NULL;
 	int	index = 0;
 	bool	need_swap = fep->quirks & FEC_QUIRK_SWAP_FRAME;
+	u32 data_start = FEC_ENET_XDP_HEADROOM + fep->rx_shift;
 	struct bpf_prog *xdp_prog = READ_ONCE(fep->xdp_prog);
 	u32 ret, xdp_result = FEC_ENET_XDP_PASS;
-	u32 data_start = FEC_ENET_XDP_HEADROOM;
+	u32 sub_len = 4 + fep->rx_shift;
 	int cpu = smp_processor_id();
 	struct xdp_buff xdp;
 	struct page *page;
 	__fec32 cbd_bufaddr;
-	u32 sub_len = 4;
-
-	/*If it has the FEC_QUIRK_HAS_RACC quirk property, the bit of
-	 * FEC_RACC_SHIFT16 is set by default in the probe function.
-	 */
-	if (fep->quirks & FEC_QUIRK_HAS_RACC) {
-		data_start += 2;
-		sub_len += 2;
-	}
 
 #if defined(CONFIG_COLDFIRE) && !defined(CONFIG_COLDFIRE_COHERENT_DMA)
 	/*
@@ -1847,9 +1839,7 @@ fec_enet_rx_queue(struct net_device *ndev, u16 queue_id, int budget)
 		/* Process the incoming frame. */
 		ndev->stats.rx_packets++;
 		pkt_len = fec16_to_cpu(bdp->cbd_datlen);
-		ndev->stats.rx_bytes += pkt_len;
-		if (fep->quirks & FEC_QUIRK_HAS_RACC)
-			ndev->stats.rx_bytes -= 2;
+		ndev->stats.rx_bytes += pkt_len - fep->rx_shift;
 
 		index = fec_enet_get_bd_index(bdp, &rxq->bd);
 		page = rxq->rx_buf[index];
@@ -4602,6 +4592,11 @@ fec_probe(struct platform_device *pdev)
 
 	ndev->max_mtu = fep->max_buf_size - ETH_HLEN - ETH_FCS_LEN;
 
+	if (fep->quirks & FEC_QUIRK_HAS_RACC)
+		fep->rx_shift = 2;
+	else
+		fep->rx_shift = 0;
+
 	ret = register_netdev(ndev);
 	if (ret)
 		goto failed_register;
-- 
2.34.1


