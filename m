Return-Path: <netdev+bounces-284908-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sOb6CQRd+2nbaAMAu9opvQ
	(envelope-from <netdev+bounces-284908-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 17:23:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D0B4DD1F3
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 17:23:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C387930B0C3E
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 15:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B1AD4963D2;
	Wed,  6 May 2026 15:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="G3ldjl2F"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013048.outbound.protection.outlook.com [40.107.159.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C484963AC;
	Wed,  6 May 2026 15:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778080607; cv=fail; b=KqaccLTgEl7oW9RyRy9q96McoRg1zki+ZEnLdkzN39wIwwFP/GkN957xBY7AyL5OVVRUIzRvVtCZ7ZWP5ah4COR9g7yWgU+lbyPQd+NXevyeHjp4HvhM5XEF5umghp7zwwKIKksqF6N2WlOWwE4M2h5hWizQMlRX3VIIdB5yJHg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778080607; c=relaxed/simple;
	bh=yAZaCKhPEFoTTrjUCevfx/8nX757OiGXQTuZBF4rx/c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bVUPTZjvnLR3TO78ixU/o8wPl0eOIKe0kmctsxWU5RZrCCMfAldoVGgV3rOyVKHf+dEbrEaqx8CqxxfPw73SWcWhX0GAWIgPMexYewaArkrqJJseHK2+1H2wHs2PpkFxJOFUb+mWu4wfctj8i/Ogd51MoqKy4n/P4jkAiVrzB5M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=G3ldjl2F; arc=fail smtp.client-ip=40.107.159.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QkTOjaSsYkNWQU6HfQJijC4mYdZ3sjG9zHRUBMTFuSkLsVzm4by6Yi954Vp0ggW/auQ1SSbwVtFThE1Idse8bzOSztj2u6pqSFb/A60xbiiPuVS6IPzG+OZKMXMBEvvlS5941f19h9Vo6aN2br8Flz7X1A2UgbbFvow2FKDKxXrUbCrny+tTQTYnhbQ3JiUZIpZNJ+o+aorhyM2ziAFWnpP991Ot3gLNvp7XKpBQU+YNXUwAFu7NJAcfLzZal567JowPqeZ5eWM0jrJGCnt+VQiAav2bZ6ei+cr7Mo5P+6t0CWZAEKr+ALDcO9ENmxoWwhWYBdsKjnCYGbnaaPBYhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8zIM199H5iP4KAvGTPe3p65N1nCTEh1ZRPpIu/c+Xs4=;
 b=NuVNtEw12UKt6Es8Fs96Y6ytLNwEaWq8AjioSYuNwcNNm2tu+awTGSzHEMHt6vNjXoz9TRPqgvD/QQ2HaTccS9HrJEUiNvjWgs8VEDP9tXMjUUsfNbOl0ikXMKLe+/xcpUSE1UnPrxN3pfTqV+SVEKz1hQ+0WkBIh0XUmsnbTsRNlM/sDZ+Puw+UxaJY/h/LaWH1eFBl3/mT/CgJ6jVtw7OARHII5cbcymvGqX8/cMVErSKPrQq2/sxddCezA0EgvtSsKuvXk7pNeiiw5zxs5W1CaCR/V7G0nBoyHwyg09nKQlvVOWVKB22w2PW0nnkBCrolG0uvLX4GAF8RD405Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8zIM199H5iP4KAvGTPe3p65N1nCTEh1ZRPpIu/c+Xs4=;
 b=G3ldjl2FtZob746ObtYmOiqRlW5dJdMAKFR99xS6J4efqBvxXP5BdybpBtvlolkAs75YVWwn2r7SSc225TgfkfBubdyVUYEgJPSjEswHj8/j0ylVWFiY7q+zw996atJnpS9NGje8T/nnnoqTnSyl7c9CwXOuwb/V8LUa3eJpkmJ8kS95JkCNIJnAxUtJ8TtzRIksOumcGqT2qf/kjwSFmGgpF1AxHa2CzH7F8bcvmsJpG5IiWoNe/4URzdApulrq0vns1A30LL5cx8qQDk4wmLVt1BZJeBSbtU7IvubbClfrEjTF+hRM8zDPX6zguX96KDn+ICX25c3kfDd1Bzt4iQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB11503.eurprd04.prod.outlook.com
 (2603:10a6:800:2c7::16) by AS8PR04MB8277.eurprd04.prod.outlook.com
 (2603:10a6:20b:3fc::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Wed, 6 May
 2026 15:16:24 +0000
Received: from VI0PR04MB11503.eurprd04.prod.outlook.com
 ([fe80::cbe9:4c03:71b6:359f]) by VI0PR04MB11503.eurprd04.prod.outlook.com
 ([fe80::cbe9:4c03:71b6:359f%6]) with mapi id 15.20.9870.023; Wed, 6 May 2026
 15:16:23 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH net-next 11/13] dpaa2-switch: trap all link local reserved addresses to the CPU
Date: Wed,  6 May 2026 18:15:38 +0300
Message-Id: <20260506151540.1242997-12-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260506151540.1242997-1-ioana.ciornei@nxp.com>
References: <20260506151540.1242997-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4PR10CA0005.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dc::13) To VI0PR04MB11503.eurprd04.prod.outlook.com
 (2603:10a6:800:2c7::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB11503:EE_|AS8PR04MB8277:EE_
X-MS-Office365-Filtering-Correlation-Id: 90b11b05-8103-4eab-e470-08deab826f5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|19092799006|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	hohbrGlGSszbiKdDyCOhsw6TCFngPIqcwway4t2ukYyYdcxe667vwTki5OJV28wubUhTdkWf1DatwEIgDRTlSbnztVnS1zMomYdzPNnL0bm4fj3aTrWf5U7XCFuFJCYetO29VmeixN19c5i9aXF/b66otVlcd34NWzqQRKqi846BKIRfjsEedACxV8EAiDKU0gq30kk/DQA28csvPGlodYDYn7Y+LK2nw4bVKDJPN+je9VPno100INwuhztEPHl7htNyV0RUjm9+gs4X8ju16swUDwOy5+k7qTEQ+8a9U5Drq5/D6gzPTO6w5ZZtiXU8+v5JBvxBsgZWqdqR5oEjgKeAsNgpWktQNA8LCfAw4zFcE2VbLTcErdIX2DBAK8smm5/bx+mnn6/kpbwg+6XBZgYNML+Koy0FsV8MzVro7yMm7DY2IEGW3LsNsRbvozAF5fTSjhnQ0bmT4FuGYRpazhvU11Lq/54jTybPeOWPbndGkOPchB6bHy0yHepow+lLg/+1TxTMqCjGqA32xNN1+KtnvDUD1EnOut15fhZm55IlmtfRTB+Wz3yQgZt330ZtqcBogzgo4YXcYTxc9zxW49TXFrXaUVBBvOtS8YZUADcCPkyRLXPsvMvyaz1VnEvWH3vbaODHDfOrWNsxt0XdwC2tq1zPJwAdFNEKrlt6nohXtvAqi/9gc3x+rTqWcjTT
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB11503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(19092799006)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CK7NQOuqeYKjWPHk8rNKktm3Bm8AsIT/lO4+VjWXfV36+RSgUshjudjbifBc?=
 =?us-ascii?Q?2uIfLi1L5DIpTWdMMHINfNXvLoN9n1RQ6SYnCTwJ89/GF1QylO6GLUISiZcp?=
 =?us-ascii?Q?BePWE3gDeTKBiaaPucKU2EgqyZoQfQ1p7qg/iFjBesTXXpIQCbmCG38nlXSQ?=
 =?us-ascii?Q?bOexUyiX4wiM9KIIT5NVU7WCROheAHWdgh454gl4IpnlDRVNQT8h9AnHXzRd?=
 =?us-ascii?Q?O5uULxxeR4QRrTCVc8bTSKJKtLpoQWM3T3Fb9Y2qZEcczogz7JGCff/IwTv2?=
 =?us-ascii?Q?5X4z60ykx8uLZbVEVnZ99PIje/kL9V/bHuforGGKB9eUvaTFzD6ujF2Pb0rf?=
 =?us-ascii?Q?LVVbAF3y1+ocNVxI1iBHWCfXUNIUtOXFJw3B7+cHg3pTPRJQlgA5JoJgR0d6?=
 =?us-ascii?Q?GJ3/yu6W3S5bBaW0njzUdhBFGDBAh0yiapu+xbQC9UHfge6z8+vbN92ewToy?=
 =?us-ascii?Q?UNEenCuRnGn71j52PlqExUbUT4i2Wo0SNgcS9tNQ0QOrhg+7JP5+zWJXT+2Z?=
 =?us-ascii?Q?bka67BdQexbKGfojp+zyniUgwrdKz9NqSS005/DkGhlF/pQaefgYKSxVDwkt?=
 =?us-ascii?Q?nxts+5VBlT78sGr9o9CYXulbuoustHB5AYZXkitnCJFFFiOJwxqvkKsD73no?=
 =?us-ascii?Q?WrQg2C9j2ZYMR3hHCEdOqiRa9wp54Ycq6uuvDTujqeT9jKpEttMSPAXBqx6Z?=
 =?us-ascii?Q?8k/HPfZ2DKc3o4MpjCHPe6wQfWaBbxWT0iSoWjoHdn4vqxJWtso9RG6M8m8T?=
 =?us-ascii?Q?Dh1+Hjx1wtckLi6Gxjvgz9/hG3iZIKXl13iVctfCbUyBZ+VdNpgAyLtyIdDj?=
 =?us-ascii?Q?kTbjtyitEj66Z7SzXugLLuK++ihr6FX8wK7PPQq5dUPCb6OnQrBFfMkr+sVW?=
 =?us-ascii?Q?w70PtHzmzSfxpBkC5cd/s2hQg29/Ow90ixAfCXVaDJ+tgoJSDiMo/aYxhxoV?=
 =?us-ascii?Q?0hv1d9hULJ87DBgCvgnRls1GUvjNYgUaTVPqs0GiMIp/2fFWUzdSaS1OE92l?=
 =?us-ascii?Q?oFWIXs419QDdyxbU8hlZGAXgcDUg99IRuXJs1VpuzOe/WiZ3VUxXBrVENKpu?=
 =?us-ascii?Q?CbCdDAyxrqVX0bY9UWC5FQwlfop9fT5ABZze7THqucinK4Jn0LDylIg1YHJf?=
 =?us-ascii?Q?QJ+dfp+r2k74VrabCHfCoT7t/LtHuUm3y/gpZjgqsCRuQwqjgrjgrdZc2Fjt?=
 =?us-ascii?Q?/QlZ9T4AUwE2mjng0QKAnHWSOGs/Ru47qF4PjEYFZTQn38GMrJAXdPeZXEb1?=
 =?us-ascii?Q?GFN05cW2b3q9CwCnk+YjNr6s+uK3zAl97bJpCDeFum4LkWmyFdt+fXpTOQu8?=
 =?us-ascii?Q?s5T9duVrE2yz29zCQHDPVE9kt6/Lu/ibavrockq/v6bvQHfuQ0i3GfI3grCq?=
 =?us-ascii?Q?zTNlmm0obcfxxik8ywPkyToSviiFe8YJSpdqgXveiNYOksJgX037trpLpmAy?=
 =?us-ascii?Q?NgpCYaPGxVQ7n2dEk5ZuHWPUXTZTnrMuNyGp9YsyijVBMSX64y1IGANJZkSm?=
 =?us-ascii?Q?AvoDKcBEriKI49fBdKfaHmfXq+79e5qU6zqe518QlxYLV8kVJv7Wbhq+jXBq?=
 =?us-ascii?Q?AISReYon7Oqs370TiraCMFIL36VqwGsvUDPqcFtusPltci3nRc+tva8fo+Iw?=
 =?us-ascii?Q?XFvKkhVkWGg8GD3uhAOKOSrxBAJGmYxLK19DF1Lx3ki9V4ySvfl1samSBD1M?=
 =?us-ascii?Q?SinpVyIlZAxZbxI7MBtqBP79AmeBnzCiOvZyoDzRorvQboqss31ygP7wVjLr?=
 =?us-ascii?Q?vEFeVajDgg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90b11b05-8103-4eab-e470-08deab826f5b
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB11503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 15:16:23.7055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xkAZx1XewH2aF5xAhThWJrTcyvseK2HWID7se0K9tHaQNaXWG02GU18y9R6Mp71uKGq0zdB2K0tlVQQmro1UJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8277
X-Rspamd-Queue-Id: 90D0B4DD1F3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_FROM(0.00)[bounces-284908-lists,netdev=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[nxp.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_NONE(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:dkim,nxp.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

Do not trap only STP frames to the control interface but rather trap all
link local reserved addresses. This will still be done by looking at the
destination MAC address but keeping in mind to not take into account the
last byte.

This change will benefit LACP frames which now will reach the control
interface.

While at it, change the prototype of the
dpaa2_switch_port_trap_mac_addr() function so that we directly pass a
'const u8 *' so that it matches the ether_addr_copy() used.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
index 17a7a64064b5..59ed06ed7ef6 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
@@ -3776,17 +3776,15 @@ static int dpaa2_switch_init(struct fsl_mc_device *sw_dev)
 	return err;
 }
 
-/* Add an ACL to redirect frames with specific destination MAC address to
- * control interface
- */
+/* Add an ACL to redirect frames to control interface based on the dst MAC */
 static int dpaa2_switch_port_trap_mac_addr(struct ethsw_port_priv *port_priv,
-					   const char *mac)
+					   const u8 *mac, const u8 *mask)
 {
 	struct dpaa2_switch_acl_entry acl_entry = {0};
 
 	/* Match on the destination MAC address */
 	ether_addr_copy(acl_entry.key.match.l2_dest_mac, mac);
-	eth_broadcast_addr(acl_entry.key.mask.l2_dest_mac);
+	ether_addr_copy(acl_entry.key.mask.l2_dest_mac, mask);
 
 	/* Trap to CPU */
 	acl_entry.cfg.precedence = 0;
@@ -3797,7 +3795,8 @@ static int dpaa2_switch_port_trap_mac_addr(struct ethsw_port_priv *port_priv,
 
 static int dpaa2_switch_port_init(struct ethsw_port_priv *port_priv, u16 port)
 {
-	const char stpa[ETH_ALEN] = {0x01, 0x80, 0xc2, 0x00, 0x00, 0x00};
+	const u8 ll_mac[ETH_ALEN] = {0x01, 0x80, 0xc2, 0x00, 0x00, 0x00};
+	const u8 ll_mask[ETH_ALEN] = {0xff, 0xff, 0xff, 0xff, 0xff, 0x00};
 	struct switchdev_obj_port_vlan vlan = {
 		.obj.id = SWITCHDEV_OBJ_ID_PORT_VLAN,
 		.vid = DEFAULT_VLAN_ID,
@@ -3872,7 +3871,7 @@ static int dpaa2_switch_port_init(struct ethsw_port_priv *port_priv, u16 port)
 	if (err)
 		return err;
 
-	err = dpaa2_switch_port_trap_mac_addr(port_priv, stpa);
+	err = dpaa2_switch_port_trap_mac_addr(port_priv, ll_mac, ll_mask);
 	if (err)
 		return err;
 
-- 
2.25.1


