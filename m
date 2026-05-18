Return-Path: <netdev+bounces-288830-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qMYhEMqBCmoo2AQAu9opvQ
	(envelope-from <netdev+bounces-288830-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 05:04:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A490756543F
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 05:04:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ABF7A302A6DD
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 03:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A66937FF7B;
	Mon, 18 May 2026 03:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="PaqA9GGS"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013002.outbound.protection.outlook.com [52.101.72.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F347D37F741;
	Mon, 18 May 2026 03:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779073400; cv=fail; b=mnIRSbUAQwVQa+dVXuXvDjqWdNEEnO2eR3uldWNEUi8da3K90fdjD9OX49ZveIWUJ5VWsokRj/CPlNaCeDNA54fmQYxmUlcbEXzShKl1tWVpkDAfweO8k0cUg2D/rtc9PWn7Mz4uWnJxBRzRNMP01UO37FLMaWl4Ae4dWH8M8wE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779073400; c=relaxed/simple;
	bh=QXpYs20eHCvO/k2pYLJNeby5MwrdUFqNBPPbnb6OqA0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=meoXX8V4VTiVXHwUkO/tU5gv58kxi9A3fz5Esj9BAHuFzySL10XdN57tedfgPSMdHThjj8NG4A7Q+rNAIZ1mlzuLK5N8+PdjhF5wSpCyDrR46Z0ReQnX0VQnIzuN9K6gFSWD8OA0MKQx23BUtgdwsfYU2X0wWxl8EMJF2EhHPYE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=PaqA9GGS; arc=fail smtp.client-ip=52.101.72.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ODm+jy25wY/XFFnHuy2KlH9OAXsepGZIh64HkEy0yNvQqHKbYTCZnrQFd/BhFN2NC4WNCBPLNmvYRVetS2Z54iVMp/rIXDFUKBD3exXztofth2hEdf+9c7AYoXB7UPp4dSy8RAxjrD1IG5h8o7nf9w6cqhJk799BE0YQCNDze03SnF/8yX3rl7Mxew6Ga0ng4rHEzKQ+nE+0F+i9w7KbB9GNcOnH+UThsbZKCb+zezJrHxqihZ0fXchTquQV/0PoZ9ilPuJK3U+KRex/6Pj47U1BudIYY4E9f0im2Br2jSe9rqEeSUKnUm2TDLohepB8rRcNLuq+HLwQ55ztNvGJUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=It9D+0v8EQYKHxzIqko4U7MPJXO0y4lAV+5Who3xT8Y=;
 b=VRFjK/qup+C8d7TP3gU4l0z4xye8ACL18EjCjMSPrAcuyIbRslTRd36o2vJ9hDDZiPpSNrBWW4vCTRf9fUEF62n5R0TDCaOPB9V/aCeXvUqZudTphZDD5uC7QxNurdDgDn7VEjgml87otRAvWiY6Z8nNLMudW+rK9vpUx4pfEmOscpX349Ddc7tBp1L6Ev5CIdRLBukInqzGbK3rjYCMENtoeVuAyzgbQQgZAKCw/r8d2ru0rzVHXiihX8Nu2pxc8oI6E8MJxRnVfEuVcfg27agxpAmifxDAp2sLsUwBrUuc1mo24N44+oV/V2FHiNe2hN1SvgGfg83BmcjMss2QLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=It9D+0v8EQYKHxzIqko4U7MPJXO0y4lAV+5Who3xT8Y=;
 b=PaqA9GGSSWcX43A3U73tnDLbc45RN7CeCi0SLH4mka/o1vh2NWf5Wwpyhr+NLQV9UQc3ZTbtLN84XMYzrRjFcWlwC3bmN6WjbkEEEUd9R0cbSars3gGY1g6GbGG/kYY39cvDfu5QKblD52zEvieXbkQG7dtLGNTAdzEzbfVllWSVnO9j+xPegB7p7vRSQRYIMbvKXBOG+4aOvqWx4lquHLiwPOLAcdmQI3rfKefgBOvQb64kSn1SHK1c2wVkgq3iC5KmwRSdCjIBIX1VoxmS7u1zm6z4AhTvos3VdIYDNxd0siAY42NYrMlRRl8fXR5pw6aJCGqSoHnQJBcHGI5ZvQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com (2603:10a6:10:1f4::16)
 by PA3PR04MB11180.eurprd04.prod.outlook.com (2603:10a6:102:4b2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.21; Mon, 18 May
 2026 03:03:12 +0000
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7]) by DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7%6]) with mapi id 15.20.9913.009; Mon, 18 May 2026
 03:03:12 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	catalin.horghidan@nxp.com
Subject: [PATCH v2 net 3/9] net: enetc: add ratelimiting to VF mailbox error messages
Date: Mon, 18 May 2026 11:05:29 +0800
Message-Id: <20260518030535.1057228-4-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260518030535.1057228-1-wei.fang@nxp.com>
References: <20260518030535.1057228-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0037.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::13) To DBBPR04MB7500.eurprd04.prod.outlook.com
 (2603:10a6:10:1f4::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7500:EE_|PA3PR04MB11180:EE_
X-MS-Office365-Filtering-Correlation-Id: de0ee4fa-9c96-468d-5124-08deb489ff60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|19092799006|52116014|366016|1800799024|38350700014|22082099003|56012099003|18002099003|11063799003|3023799003;
X-Microsoft-Antispam-Message-Info:
	owjGmwC3ioe5w68cqHsVNH4fO/lV1IrG3bYLbDARB9scZY4i5KFikRxq5X8dX49qyW9GF/ETUDpYrcBCpLqCQHAvb1ys09goc8CQD8rJJs3RSqM1pVWv/40NWN9dc8ByKaxSE4oxSNcoZYcvtGY4cTvj6xvNSXNeBJV5IYLB555Fn8II+MP7xHE7jxfibKUQLS11gmSKok+zJboCNGRnRxUZvvpbd40qYfU1/PJQA36QE/5JyU6PejaahcXl6Z7B1QV/PBOz2ri3tG33qWlc1uDqsjEGy3lHo/mbHEYIdd4ZQqhZIx6VD8HXO6SkgjrfM8GSUCmzkPQmhOLu72SRPJpclqEBCdwdpkUDc34P2u49QIe8PJ3VcVYFJpgH5brQ/3cI0AeJpv5vA9QUGnPjaQNI+B5PZiEvevMnwN/SufHrIC+gFADfLbhqzZzdqLFWt5D4SUYmQYlTYpHZANlKIMDDxhd+jbFXSTdQ30u8kjqfYX0OkkbejKXjrN/9Ihmqs/5Q9jRZ0s7DR0oWb60aTjvpo+pi6P41a7TLCvNqBsu2QTB0BLjUAQLcD/VOjisXgAbLrandlP+IG8+PA6rlpV+yynTyYripsG0bplPQ/84wFRxXxxgl+sBuBD3ojDoIr+YDBjkDd9bPC0ysXmmrat9gCSatfhuHpX6dM+n4zRA/IJvlH77l2Xn5cQkqIhuT
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7500.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(52116014)(366016)(1800799024)(38350700014)(22082099003)(56012099003)(18002099003)(11063799003)(3023799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FnsDczoet/9oLqQXAoeEW2jZyUuOjgOtvT3ybOdYsk64I0uRkfYFPOogq6VG?=
 =?us-ascii?Q?Z6PflwMUlDnjQerVm+GTA+POKQ83hSCpZMwXP1OmTt7A6tvXRVS7Ozxqhsb8?=
 =?us-ascii?Q?bCjDmbslGF43DQ1tRB7pOEd7ZHNFDeh5HuMbH7lzaLw3QOtqcz04DYmeNVMt?=
 =?us-ascii?Q?oXNf0pp6CylxJWbOB/pw+gl8QFkkSfR+bzJfHwhCaHwkg+oOM4M8nBsib2rs?=
 =?us-ascii?Q?zC2Y7uCSyEVYKufQcSGRUv6qveilpisf5ZWk9ZI4KN2N3qkeYhUcLmlM6dps?=
 =?us-ascii?Q?pszaB0qKO7a7Ilw1C9m8/AjowGsYDYYmM260WpaC3QROx8vDXZxXftLk9ZV8?=
 =?us-ascii?Q?0OYUWzhhHOT8q9IqIup+7KdX/0l8Mxukd1LspjLc9IGnnL3wK00kSM50ubpw?=
 =?us-ascii?Q?iyOmD6rPxtMcYNIAJUdt/v2tKBIjusInHi/MWTqGt4RN8BgLESL7MMH/g/og?=
 =?us-ascii?Q?O3cRnnithuq0enYp29oM4DLHuyFtrxV3tEwV+IHdKsMF73LjgdJcmINRE4Eb?=
 =?us-ascii?Q?SOe4MoE/Oyw3K4aIbi+4acsqrulP9g/Y3I5pnQARs16vjT1yF2aJ+WaWiySE?=
 =?us-ascii?Q?0Gf4qlsR4ik8E5SWpfQTCa5Gj7Lkcy0WI6v3BxewCIFz3RZNaSiKggXOH0GJ?=
 =?us-ascii?Q?p6dlcxP5MP3BxEJa28ifwIuK8uKwyfV2SMIej2m3PDuuNUiumTzW1WXm4DOe?=
 =?us-ascii?Q?yhmopg1CbaqmhWGKFkdmja9ch7C4FVErIB+1fHLOt9AEQY8vx5PYlOYwwFjG?=
 =?us-ascii?Q?6eLva0LP0b2ytYE7BDd5E3ciwItwfjzh7sKn+MtZKSB40DJgMjApe0To8JmF?=
 =?us-ascii?Q?nTEUWOfbsw+5IO+mZpvVCnqao8gijiPP0iOVFFBiJX6lrNv0kYQoefCzFFH4?=
 =?us-ascii?Q?s2gIEbdLTQl1Vy292/zk2fKRhg4VlkY5mObuBdONm0ToruE8COyMTzopa9t4?=
 =?us-ascii?Q?obnUAOti0ni6T8nzY537WoPpwreswqMTXr7ChH5y1Sx3Q4WBldAKfImW93Q/?=
 =?us-ascii?Q?qQ54rNE8axJv6ilGfo2PNWK/p2j3pQ9hU4WGFr+i06ar50wgGYAnQP5qVWqa?=
 =?us-ascii?Q?+mkqyf2bc62ZGGH//N3Zgvg8/q5I51ZSPv5HbvaeI4ijIv1iqxRreodGkmRG?=
 =?us-ascii?Q?FcynAkufsi46z+SVtDJNkki7GdVC2XE8ADR9KH6G0xEnAu88B3pJkWvVAgRT?=
 =?us-ascii?Q?6jfNICULzZPsZD49mNUS9yHHOiJ9YYZltPpmOV8rAaxrYLSqHnnu7lgAvPt9?=
 =?us-ascii?Q?K3Nr/npxiGq8DKxJEYfUx8fVTpJ59Huai2aGxwkxbbCsARnfu0bipBj7wTZa?=
 =?us-ascii?Q?v691ZRyG5m8vtykJCQkAXeKAaVqtD7+06Ip/agD5EMIBq26pmrPiyCfx8PKT?=
 =?us-ascii?Q?HB+TcMln+X3L7EqHXv8LT6stlKT1IW5JmPQguKW9WqQik1q52ga48q3khm1P?=
 =?us-ascii?Q?9KiVyf902PXaSflvuYPiHid2utAEld3eUCcQdyCTlArC/55w5o6sFaFJWMJX?=
 =?us-ascii?Q?CPcQfWp+q+kC709oJQrzuVB8UxXKlCV8gogmywjC3umhv578RVP0of5z56YD?=
 =?us-ascii?Q?/Debj1PNju7NJ/Sk2XnKwuuUOcL3r39bRuhTl0SaRuD9uFjfUdFvNdRMNY17?=
 =?us-ascii?Q?gyLgdWtxtfCqjQymZRsCod4J8X6j8GD0T7PJTEf8dQ1cDllCee56S++sGP3a?=
 =?us-ascii?Q?NjsFNZHmds/10BoYq3TMLpJ3wRi8VRHvYGd6dl0TfaStQwWU?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de0ee4fa-9c96-468d-5124-08deb489ff60
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7500.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 03:03:12.3941
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o8TNUepP+++LPjB+Op3q4zjqI2j3g1BuLEoK9+t9wfyTMCfQIq6syxaVKxJUc5xEecL+DHA6VzsFqIVBKYXYDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3PR04MB11180
X-Rspamd-Queue-Id: A490756543F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-288830-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[12];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:mid,nxp.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url]
X-Rspamd-Action: no action

Sashiko reported that a buggy or malicious guest VM can flood the host
kernel log by repeatedly sending VF-to-PF messages at a high rate,
degrading host performance and hiding important system logs [1].

Fix by replacing dev_err()/dev_warn() with dev_err_ratelimited(),
limiting output to the default kernel ratelimit. This ensures errors are
still logged for debugging while preventing log flooding attacks.

Link: https://sashiko.dev/#/patchset/20260511080805.2052495-1-wei.fang%40nxp.com #1
Fixes: beb74ac878c8 ("enetc: Add vf to pf messaging support")
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc_pf.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.c b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
index b743b6d33ccc..dea3a92c4722 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
@@ -494,8 +494,9 @@ static u16 enetc_msg_pf_set_vf_primary_mac_addr(struct enetc_pf *pf,
 
 	addr = cmd->mac.sa_data;
 	if (vf_state->flags & ENETC_VF_FLAG_PF_SET_MAC) {
-		dev_warn(dev, "Attempt to override PF set mac addr for VF%d\n",
-			 vf_id);
+		dev_err_ratelimited(dev,
+				    "VF%d attempted to override PF set MAC\n",
+				    vf_id);
 		return ENETC_MSG_CMD_STATUS_FAIL;
 	}
 
@@ -520,8 +521,9 @@ void enetc_msg_handle_rxmsg(struct enetc_pf *pf, int vf_id, u16 *status)
 		break;
 	default:
 		*status = ENETC_MSG_CMD_STATUS_FAIL;
-		dev_err(dev, "command not supported (cmd_type: 0x%x)\n",
-			cmd_type);
+		dev_err_ratelimited(dev,
+				    "command not supported (cmd_type: 0x%x)\n",
+				    cmd_type);
 	}
 }
 
-- 
2.34.1


