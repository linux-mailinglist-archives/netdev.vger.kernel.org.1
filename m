Return-Path: <netdev+bounces-287162-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YA/eKiU3A2pK1wEAu9opvQ
	(envelope-from <netdev+bounces-287162-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 16:20:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 342BA52240A
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 16:20:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6A545353EDE1
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 13:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB8F93B1EE9;
	Tue, 12 May 2026 13:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="OLIqQXKj"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013027.outbound.protection.outlook.com [40.107.159.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465833AFB1A;
	Tue, 12 May 2026 13:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778591804; cv=fail; b=I4jxTsLe7BRh1Got4q2iaN1a89fKK7b65XKYgDiRw6595+LN1cfBwQrm3pnxz9wJqfF98HeGvGqZZmJRBQtKV0fYcofsqC2avDsmQGSkrOBYua5LZch5qZ2INpDN1vXlUfN5Olzu3cjp60XSX0t4lOKNN9f6D7f+mLLuCOrDtWE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778591804; c=relaxed/simple;
	bh=0FMXSJ9A8Xy1QWHtZFwXshy4x8Kxb1MK31TjXY0g8QA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JxmkDVucgXKG9MxesTULy9ithK3h2dbpHWRhFicGteCUTR5CRxJokWrQtKDWC9hAwZbEMdWf3Ow9+u/PW/GWJ5LAeFiq4T+hQ12CzkSeQoktvXnSH9akPWyl5u+9cyPqFydQn1q4DaFc5MjJbdyXjjaLnPeXuFLd/Ok/AamXmkU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=OLIqQXKj; arc=fail smtp.client-ip=40.107.159.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FeM71irIhfWWAD+47mUzwsKaWG26LZn5qbh/WCBdxtV6JgxJMNAlVXgWDCsNbHiqyEqINJ6JkU/ZPVMyjVpluz/1HGQy/nt20tIVRu7jnkLHqzmAPEf57htLwFIhp6z5SKuaYnTEBROzQJpMg5K7pY5cgJJNXBMmBEujI1C1nKu7o8EfdKEcvoQCZ0VLOlBnSQyicHBInsZiis9oqYtANWMqZ/9FKnE6Cb0cEushvbGL97JqZS5K4ZUwe0FygOfO6jnFfaiP6Ne1FR9XaS0ZWSa40YllAanEFB6ArI/FpED1vKZVDy8C1vDfJrQ+YI0Ydk76FwYRBcqhHF/gs+OTxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bCLX+VEt4SskTLpAPvCmImnFGIVDv1sF/4+RQITta+k=;
 b=FMhFIEo713kUdJ0hRCurI9qZYPL+F2FNtfJNgS00yFNpBeIWyQudAZiGca9OZS9v/reR3vMsYUm57RStQ6TnPH5aAsnFJEZ7oNBl9f6Hrm32SGdoTq7wJJZbYmfDrG3GgpYA59mfIv6S5g8+U2BufyFqKqggZj6JhFXcjkEeumWbvSU5k3QvsVwWh6jfHplltr+BA3uJixWfIAYO80Ucmit/053b05QG/Ve+EEaoOxh4RJsow5tgFVzb9gL0z5JzwrobNhJlcdey4CPfDLLPSZtfDhxmbmT8wx2j1d5oWKN5KLD3auDthXcDXSfUf+Su1TtgLYOiNXbRLWIgScwy9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bCLX+VEt4SskTLpAPvCmImnFGIVDv1sF/4+RQITta+k=;
 b=OLIqQXKjiF8xFOCziRHGXQGtPXsVfgt802wueSux67F4Kd3XR59zRB1uRg2ryef8I/sy8etPojPI8xz1sL88TauxIgb2WOepVGSnh9VhJ/lTnNpPmm585bn3BntlJSt2efGtfATfkYE047o17PV8R27K82HCflOgQe6euuTRH0YYeOaArWJIF+oR8xB1NKR8iqt0UKnFpKUeeeLql1OWtFl+VlmDnbKxAQ07LQuVJreJfqYcnmiqnaDUbv6x9HEU9NQw/OVKkyQuR4DWcuLiHaXYfRzXwcxhuiUjOzqDyLRvPF684rajJlj+11Xsj4+uyFSmjNBRr/tg7iZyykoetg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA1PR04MB11508.eurprd04.prod.outlook.com
 (2603:10a6:102:4e0::21) by DU4PR04MB12328.eurprd04.prod.outlook.com
 (2603:10a6:10:629::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Tue, 12 May
 2026 13:16:41 +0000
Received: from PA1PR04MB11508.eurprd04.prod.outlook.com
 ([fe80::ca15:d140:3af1:77b3]) by PA1PR04MB11508.eurprd04.prod.outlook.com
 ([fe80::ca15:d140:3af1:77b3%5]) with mapi id 15.20.9891.021; Tue, 12 May 2026
 13:16:41 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 11/13] dpaa2-switch: trap all link local reserved addresses to the CPU
Date: Tue, 12 May 2026 16:15:52 +0300
Message-Id: <20260512131554.952971-12-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260512131554.952971-1-ioana.ciornei@nxp.com>
References: <20260512131554.952971-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0020.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::7) To PA1PR04MB11508.eurprd04.prod.outlook.com
 (2603:10a6:102:4e0::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA1PR04MB11508:EE_|DU4PR04MB12328:EE_
X-MS-Office365-Filtering-Correlation-Id: 4331e124-ad96-4ab7-1528-08deb028b4a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|19092799006|18002099003|22082099003|11063799003|56012099003;
X-Microsoft-Antispam-Message-Info:
	hzZP3QsJ5EnjwXQEK+CoR29ziCVlttjhDVf+GHiSNGKbA+u2pp2KZ4o3DoUy0xPcSYxhDdJcwXxkoB4uhYYhdLRUcSfOxj6SHCMaMqoQ7BtO+dJEnCbu+Cs05sKDDXz4CyiGmW1DwJWSNgeF8ODHYLyT3lB2TFecH8/8iKGwrdRlOU3VE8u6Ta+BLkkH6kiBlJiZFm08dHpa/rzl2yC3s0Y3+nZzTEUlJjAFHcps2JzjcPMEIsM1zRfR0nTtWcBC+PhbFLrCv6JQnX8a/DU5QxyScP6vHFQwWTOkv+9lAZwaqW27lv9Q53m+76gODqHm2XyfOgz7GdZcrx3K8WBQCYJ0DzHSPGPLon9YXzcE6CWc9ccClfGg8YdGPly8MIY9CbXb5AM1Xb1YQ4lZyYxsNBSrxSCYz1XSPIXnS587PY6l8Q+xnS6xXKZKYcRIlHbLiMVQ6dP+1xnmNdvEy+JVyl10FDbdgUJUd2gtmGifP4/fOPiHF5dD3jwSpLSD520m4QjPyOn3SQm52P8jZWY8YiciXveywYkoR6p/k/QSR9PxekvUSgCUWRDXKUm0prV4iIKVk4G9aWY1pvUkyHACdUUaT1jufRvbbs1OHV8VLL/tVhMz/U4zky4T27j+XZJm85eimwsEQAOQd8AKcjB05M9+fTRPazRJ5tc9ymfsB5A//Vn+1Dpry1iQ2CzCwrEv
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA1PR04MB11508.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(19092799006)(18002099003)(22082099003)(11063799003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pXg5dW5Jcjf/YH/famjMjDodUCP1m9FVHCiMTegDxOcxAOzbsIeYmmiRxDR1?=
 =?us-ascii?Q?p3Ll4sbBvqRj+gXZ4DwZSqT1buGp71JBUT7hOGLLphTG6EeN9lPPtJdRXJ4t?=
 =?us-ascii?Q?cllsMhcPxuPoS8wWnJnKKVOREZ1AuTmjLwl0/6eBeaWAaCkKBZiQPtT8iGzn?=
 =?us-ascii?Q?8q0ffXVVa0z29cvdmwkqBMqJytfgSeFO4V1SzO1aPzx+Sz8K2sevC6e88PXx?=
 =?us-ascii?Q?PxJ+dway6/cgrPfhaL+yZXleNYLTqk2MwEi/PGaHERdWmQFbxX8GSc5VKwfU?=
 =?us-ascii?Q?M/WShKXQ8ZB4l3vdLNYl7W77e4lFO+i0HKhCth/eaQpdDM4rM8C6jR/4Z73o?=
 =?us-ascii?Q?3DGDYuV/QGujLVRpbkJSkAP6KAB3nLulURmh05uWYByGEMBe8tSX6Nf9H1xd?=
 =?us-ascii?Q?VmwctBIPuk6FwFcS7NuBHw+/rVlbdR9AZCVK21OKyq1qIztiM3x40E1qkagI?=
 =?us-ascii?Q?/K3miYblVlyq/u2fqXODiacQlD9tV0+tajGzR9h1qaZyoJdZPX2wjVZOVuLb?=
 =?us-ascii?Q?14yr2b8Zew/yYeFVDU5aRLuTHyBNPFDq+u+DrQUQer5czpcVXrzyqKwboU/2?=
 =?us-ascii?Q?iS59ZsAAbgGMSjalEpPXepCyCLpLALmiPS1cs2HKfFHetaBm/9DLag89Jtgx?=
 =?us-ascii?Q?5vnClVLFw2prUIstMBV4OAFhtwAQtmNeyz5IvPlkiIITldGCqFNoBBg/FiYk?=
 =?us-ascii?Q?nS3ofHFXu9gygrBlF/WygzNc0xJjxTrBz4cyJvLppExNq91JgXZ9JSO3gOD5?=
 =?us-ascii?Q?HtZozlXR4g59l2R+wxMn5445tyJTLxUeMfz/vPLqL66PclkkaqIXr4eIm0b3?=
 =?us-ascii?Q?L0PM6V6fW7MDNYwM1dAl9+mTshLF7YnDn+ENiSXcoNEgT+6XIybYBxjDtKKl?=
 =?us-ascii?Q?bAAUP11XImj2OKMM6fFTohJiox3XtDmKlhR5nK7jYMkdbSUDx9twUwVdOWhI?=
 =?us-ascii?Q?ToCWt26CoxMyqp2kg5QFwEpGwldjRoGUV4oSRm7NvYfRZvbMJB4jHKyRzO/W?=
 =?us-ascii?Q?ptVvAv4dSLIFj0sgUKNDrJazpEWSDz2rk0hlNJSOjkIoDeJHnTTbSdtGsrAZ?=
 =?us-ascii?Q?C3A5Zm3TsM284PRP4gkWy8AeLNYX838yW/pIxOx+zcWexhtCKXKwiO3NVw4i?=
 =?us-ascii?Q?0gb6g2rIcO2zNXN3onAKuImmZdo3kbGfHkbzMTzjogHGwkk+3aSrNLVc9sda?=
 =?us-ascii?Q?OR7v2kTX1SOY8xSmq+GxbWJW8FGGs4J8o+UTlVt1VOZmKi7Is6svkxd4vOtL?=
 =?us-ascii?Q?fWOeu+l4nbcdNpsyHpSdwkxcgyRV6M2wo7TIUNgc3rsLWPSByMec73Aq1gaT?=
 =?us-ascii?Q?lzc7oUw7WbmOQociJI9Meoir1YlAhRAmKrwkMO+8fDUnQtyaMbcnTeWzaZeM?=
 =?us-ascii?Q?Ut6ESWgDYhOpv28cr7SWDq7ogPv2KuxNtPY5/CTq/9+PrP7iFZz3qLy9Lkt6?=
 =?us-ascii?Q?0TY+ggXdUZVv97fb/7fbbivSW4a43CjZ5RKDer6hDkyG/VH3O0sgnF5UqUfF?=
 =?us-ascii?Q?gWBpJSRLzFHAlZMQf+2u2r+rChiOzisRVeGWfDYXOWudZAHj+xKX1JzaZPVG?=
 =?us-ascii?Q?Xpgy4TTuVS5QWBnoNX/CeyXanQtfXQbQN5SrTWkFqHei6I3Su6ReliSHubLs?=
 =?us-ascii?Q?E9n2r4wX4Fc/Im3sWRAnvj0FEz9+hTO67/0O++w60BsVp9GecmwwPKzcxWy/?=
 =?us-ascii?Q?9A8cC7xPnRfPJc9XguKYRi2BukHJUpCqB20Cde0pfmtPU1+Gp3GxPR8SiJAd?=
 =?us-ascii?Q?dotZ6Qz9Ug=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4331e124-ad96-4ab7-1528-08deb028b4a4
X-MS-Exchange-CrossTenant-AuthSource: PA1PR04MB11508.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 13:16:41.0679
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uBpueMWwqlvRI/lQHK7DfVnPQ6oJSgbt63n9jk24HdRSqZMzUPuy9kNjHqKgOEtDXT/MBf6uCYCjrerPQhl+ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB12328
X-Rspamd-Queue-Id: 342BA52240A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_FROM(0.00)[bounces-287162-lists,netdev=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[nxp.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_NONE(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:email,nxp.com:mid,nxp.com:dkim]
X-Rspamd-Action: no action

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
Changes in v2:
- none
---
 drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
index e8c00a269b98..98cf404d4ac8 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
@@ -3848,17 +3848,15 @@ static int dpaa2_switch_init(struct fsl_mc_device *sw_dev)
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
@@ -3869,7 +3867,8 @@ static int dpaa2_switch_port_trap_mac_addr(struct ethsw_port_priv *port_priv,
 
 static int dpaa2_switch_port_init(struct ethsw_port_priv *port_priv, u16 port)
 {
-	const char stpa[ETH_ALEN] = {0x01, 0x80, 0xc2, 0x00, 0x00, 0x00};
+	const u8 ll_mac[ETH_ALEN] = {0x01, 0x80, 0xc2, 0x00, 0x00, 0x00};
+	const u8 ll_mask[ETH_ALEN] = {0xff, 0xff, 0xff, 0xff, 0xff, 0x00};
 	struct switchdev_obj_port_vlan vlan = {
 		.obj.id = SWITCHDEV_OBJ_ID_PORT_VLAN,
 		.vid = DEFAULT_VLAN_ID,
@@ -3944,7 +3943,7 @@ static int dpaa2_switch_port_init(struct ethsw_port_priv *port_priv, u16 port)
 	if (err)
 		return err;
 
-	err = dpaa2_switch_port_trap_mac_addr(port_priv, stpa);
+	err = dpaa2_switch_port_trap_mac_addr(port_priv, ll_mac, ll_mask);
 	if (err)
 		return err;
 
-- 
2.25.1


