Return-Path: <netdev+bounces-264473-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CGUzMjyoqWmbBwEAu9opvQ
	(envelope-from <netdev+bounces-264473-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 16:58:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 448CB215036
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 16:58:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 971573069DC7
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 15:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECABE3CE488;
	Thu,  5 Mar 2026 15:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="EEKA56ER"
X-Original-To: netdev@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021081.outbound.protection.outlook.com [40.107.74.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92D73CE494;
	Thu,  5 Mar 2026 15:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772726219; cv=fail; b=fVtGqcnFj2yu4cQnvRLCc85xTgDnapHsAwCtXUcbx2NZeV93IwYXRBWdJuFJv5RetIt6K/UxM+BDoK/B9XVmHksLXCdhFIDeSH6+EcskbkoeZ8Rt8ekfEU1ETlhuvfr8NBBkOGTTW83PuA3QymR2f4XHMqV0KCJ0sxtVB5ccE04=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772726219; c=relaxed/simple;
	bh=9Swe8eXaL3wGyj1PPfuNXv0bx06Y0EF2oZtO4jeDuAc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SesB7THiy5dn1Smqb20J2rvfcefo7qp+kS2Va1vKjGE2GbKVsSP1S6Jmwsy2xFyJy059D00dkFHUMopp3qrA/0fRyspG9N4Lc/qc7akwmQxazx2zpcig3mBN4UqepAL9bs0mPmHRNJtReN2hnttE7SLSAjW2HNnSjXQfIzzCIWM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=EEKA56ER; arc=fail smtp.client-ip=40.107.74.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KzlqSbiEkFFZiG8e0oj70mSqxUleQQN2VxuV6sfFbwiAEKQ3hLY1ZuqdU/xarmNYimGZX3ON147dg0zjKEcp+k5rsndg0zO5qKTF46sCm1LrZ0k0swolk1fdBlL3q/t1wsVXQ9UyKRL2NCa7V/DEGSbqROndw9zbsYmqEEXocefZsAVQfFjWO2k92hweVdrbXL2mPYSGzauF1SqpupO6YLitv4xH0iHVT8rj37ej5HlLmBGaxo1fNFtnbqAm3LkVXAKCGoGV0g3pGH7aZSMv5t0hLA93JMkDqYHnTjTGBx+mue20nmS2cDne9VqP+ijyssDUWyEix708vfJzZlkZaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T+CgcqvbhMN/UfDLBLi7OyLlVkE3LBPFmQWBwhYA4yY=;
 b=GztUTPZ3yh4SoafYks0LmsGg6UW8FmPBhFTKAYiR9DqqYWWld5YzhJOONoZk1sdqHuWWmyLX+GEQLiPMTuKssIFfnfa3lFLcfBB5qNF6wSigmGWwl5v7vpuJC4TUNReDARwxRYDtmUhmz/XgUbBkfnaP8IrLXh8jscvb4k+AqnJIKBq4TX2UOuneVX+B5wBbCHIfkrstKf8iBDn0Ms5cu2y6cR4nKXXGl3Sg13rNp2GrcpPUE6FzFuhWoFZ7y9Ot1P5us0aPSZ8wNVwMy7cPO+7De+RifJ65zkJ5B33rg13ZBYo5TZN6eY06AVlV6u1pO6px5wLtcdB5B5YHmeHXEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T+CgcqvbhMN/UfDLBLi7OyLlVkE3LBPFmQWBwhYA4yY=;
 b=EEKA56ER1auRjSOVtZbnaQBpKrpItF68WXmfP23buPEIfYXGxixSWpoDEhBarjR9nIN55zJRrFP0xz27/ik+SdQhQ3Fk5l/U6dy5y7Mkb+leiFETqVWFk3GFXXr6bRiRmN7W7s44gsbYiUOYy96pDi2k4MLlm5PrPkbqbW5nS2w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:468::22)
 by TY3P286MB2756.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:23e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Thu, 5 Mar
 2026 15:56:47 +0000
Received: from OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM
 ([fe80::b7ab:6af2:d18e:4a71]) by OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM
 ([fe80::b7ab:6af2:d18e:4a71%3]) with mapi id 15.20.9678.017; Thu, 5 Mar 2026
 15:56:47 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: ntb@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/4] net: ntb_netdev: Support ethtool channels for multi-queue
Date: Fri,  6 Mar 2026 00:56:39 +0900
Message-ID: <20260305155639.1885517-5-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260305155639.1885517-1-den@valinux.co.jp>
References: <20260305155639.1885517-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0162.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:383::17) To OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:468::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSOP286MB7730:EE_|TY3P286MB2756:EE_
X-MS-Office365-Filtering-Correlation-Id: a2b719f4-909a-42b8-8e85-08de7acfce7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	U/BETqv3/T4w/rgrXYrymH+X/y4mqZHN1BKpOHmjwjOhzhyXIFOJOIVHD8EpEI7gvsXyUjOYeHF20d/M1trw1jHoT1zxjHZrSrCs3xfOMJ79+ffNtvSm6AVtj6bOx/bRoxD+U8NDCGpPQjD7ukTtm+4hIepCBXKWzF1ZDeaPAjh8nDryD78KJq/MwIKj9f7qerjhZzxpbuZyvXbLBKVox+iIuf7JuFyCompiQ7MI5sRtr/1RRBs1QPMwHUTJm3317BUE/R80zqXDohq4kmfRuCTJ7wOq4kmrXzZS73nCk1t6ljt+He55+S54nKhn/Ipcuh3Z38B8fbG+M+BeasJsbTNI0BlYMmgROpEUuWGTnkb83hjn0HVQo5bnB8kWfWUdtjeLdV5WsNkQs+zYVVV8KtzC52mr5PLasb0Ez23Q9IAQk6zWNlHhW33N2lnZQSp/gwQucQPagoWLxPYu/YrFu2mGSxT8F/UGTPjYufEONFCXdmmu3BoLTb2w4P4bNqa/lT9rU5CD0ds7KN1wyKboPpDPDwmEkHx6R7/d7Or4q1jQ05AaWBFskS2URfLOlEEOPMuCijMPu6FKmsj8+zbcu+/rEHaFYCJHhh/QrjhyebtvzyZd7M6TvsoliFnfwblYY02aJNoqfGyjoTNZKdoMq1jzN1EhuFSa2vPX0rDa2RRJ9fmhfIxdZzxjfFFHMKUSBz4Oqfl5vFmWkQRdpt5b0kUrg8UXDVX5KfLcZNp2+gY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YwFoj5StAOsvMPJWFvlfgGHj8HqVjVGFe6Su+eFtQBqDas3gL2/ce0tW/2mx?=
 =?us-ascii?Q?bTMORdurnZezNjv6pWvLFlhhduRe5KB6w6c+sLSm568e/IB7ocMr7Xu3Q40f?=
 =?us-ascii?Q?VEjuXE72jeZDlGak4Sfzm4ZXz+V4VQlqQ5oP7bTG4fAYra/yrRs9BT45NR03?=
 =?us-ascii?Q?05l5bsUEd5GMXEzbnohn59vSZXKtDbRdeSaHgCtlPjOV2aBhw34SVHBRLIHK?=
 =?us-ascii?Q?I3OrVfw8pjOHZWx3nsmBnFvP+p2kXeC/OYnxPFUALHFLtbOsIWmTebHRzaiJ?=
 =?us-ascii?Q?I+Xl03bmDPjBM8KsicvEowyJM2g9Gt8Zd9giZUDZCFlqXDUujv1Gqbp1JzFV?=
 =?us-ascii?Q?L+QA8WsKs7lqmq9UAqfrz1dQKipNZokxooJ/LeqIrXsJvtD00zGylHCCFWZu?=
 =?us-ascii?Q?ZcQgrQ0qNAPAuoxl4fWLAkYxpfyl9iwYZBo743AC9kocxEAKXt8SMJynxxiT?=
 =?us-ascii?Q?FWvcWtMu2vcR8YM1a7zrzVp/yV8R1IoSjOdFxxazT1YMH/2hrYpBpK1TiZzS?=
 =?us-ascii?Q?Ug5kWdJIQz3jmiOPA8pydXg/Q18cUKyS0axeb1IDbq18U5ppSE5s7UwIBrTT?=
 =?us-ascii?Q?fyecgHSd2tt3V/DaeSl55K0LI//CsSAXWUQKLTw58axr72dOTHHhaLnyvxt1?=
 =?us-ascii?Q?Csok6Sr8kRiBUnoYB5tV1HKN5YO/ptAZ6A+sm4liQwQ5j9S95eD81TCv4gkE?=
 =?us-ascii?Q?qPyiRPfUBYQwDgq2HDMmMHjIvXjQuQwdiabDKJZihrzZwyuD2SjAIUvaSddE?=
 =?us-ascii?Q?MbULTIchmYJKiw1Vr2zpCIcN14Qe+SaqHOR7BOtBmP3hqRPegQehj4VEeoPK?=
 =?us-ascii?Q?imd0rCXbnn63RdHxHp6bqs2NYO5JH+h1sQkYDzxWFu1XnZDv5Zlu6ilyH6vC?=
 =?us-ascii?Q?eeldGl6VBanz3JfK3qyzeXjlP0h2ZDYByqq1KTBjbOppD5vW9cfqfZMmD+DA?=
 =?us-ascii?Q?jMYGs1KkybjGiMikBBliQyn3+Mtlr6EFeqnuf4wvAE5gAPfBjqjekabd2+Zh?=
 =?us-ascii?Q?BXcIc9WpK3zIROJZJwkU7VE+HQ7ZwvfTKmUFFqLQKiWatqDLDLenw45rL6KK?=
 =?us-ascii?Q?8qaAOu1FsgKyDvmRF/0d+CSgQOMGztAnuTPz9yVJvSMDv34OqD7FbSirCaPd?=
 =?us-ascii?Q?/J4LS7xJja6RD3Ze8452qf6DT3LNoDNsY9+pQWRLh4Wf+qlxRb/1BMhuBy7J?=
 =?us-ascii?Q?mJ9vp1zM5YLSkxH6xy9gF1EEC2HI3NzCu1UAKfA/aOnl13j+QGcef7YZjEWX?=
 =?us-ascii?Q?4DDChy2EWQ7PO+sZ4yXzvOKRer9ZOJX1YsvPIl59rPbR1835/Bjkgn2Sek/Z?=
 =?us-ascii?Q?BSjk36qUQL7/EFjDonkCfrGIq2rmY8sL5/mrYuGtuRf3SptV3GDkCrArUVR4?=
 =?us-ascii?Q?iGjTAKRFOqVVCUckmnKytPsIwbjhj9QOZhOfgkJO756/ymzanC5ATt1dPB3H?=
 =?us-ascii?Q?xHBVa3ecVpP4cGeKua9riVeAMzOscXGGS2Qs5eLGz1jdsqhgE6I6yAgzsxQA?=
 =?us-ascii?Q?ud1PA3pVFX7ggthKA+VOt6qa5te1wOAGCj9fkesUFpxCscQKc2MphxolLolK?=
 =?us-ascii?Q?f6XDXklLNO4qyZNZhvK4lUVE3JWxlE+LmOcQeQZZWHj+Zq86SnPn4wwD0cjv?=
 =?us-ascii?Q?N8sBPpxXYLWuDJNAyqtbDrWAYMU9IUF3Fvjj7Ztczh0HaU757ZfPI/ukry9U?=
 =?us-ascii?Q?P3YKLd3hZ2aWzR/ABF5XptV4eMVK7nz8xgVHSL6IS/1VIxF9W2w2F0zIqDEo?=
 =?us-ascii?Q?zaW1bWdz9doigb4u48GU5sQF70OEmlfyeGw/BrKS9IGQMAmldjwE?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: a2b719f4-909a-42b8-8e85-08de7acfce7e
X-MS-Exchange-CrossTenant-AuthSource: OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 15:56:47.4841
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nbYc4BPfr7kJqmXdc4cIT8zB799yEKdKQXWgQ0B1ZwFj7B5KZZ5VBdiq4rn0lwmJ1HGz9F6Aa1c2ivzTcBtMaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3P286MB2756
X-Rspamd-Queue-Id: 448CB215036
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[kudzu.us,intel.com,gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	TAGGED_FROM(0.00)[bounces-264473-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[valinux.co.jp:dkim,valinux.co.jp:email,valinux.co.jp:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

Support dynamic queue pair addition/removal via ethtool channels.
Use the combined channel count to control the number of netdev TX/RX
queues, each corresponding to a ntb_transport queue pair.

When the number of queues is reduced, tear down and free the removed
ntb_transport queue pairs (not just deactivate them) so other
ntb_transport clients can reuse the freed resources.

When the number of queues is increased, create additional queue pairs up
to NTB_NETDEV_MAX_QUEUES (=64). The effective limit is determined by the
underlying ntb_transport implementation and NTB hardware resources (the
number of MWs), so set_channels may return -ENOSPC if no more QPs can be
allocated.

Keep the default at one queue pair to preserve the previous behavior.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v3:
  - Remove redundant checks already handled by ethtool core.
  - Split ntb_set_channels() into helper functions.
  - Drop ntb_netdev_sync_subqueues(), which did more than necessary in
    some call sites. Adjust the original call sites to perform only the
    required operations.

 drivers/net/ntb_netdev.c | 157 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 151 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ntb_netdev.c b/drivers/net/ntb_netdev.c
index ac39652b0488..6397d898c991 100644
--- a/drivers/net/ntb_netdev.c
+++ b/drivers/net/ntb_netdev.c
@@ -284,6 +284,12 @@ static void ntb_netdev_tx_handler(struct ntb_transport_qp *qp, void *qp_data,
 	}
 }
 
+static const struct ntb_queue_handlers ntb_netdev_handlers = {
+	.tx_handler = ntb_netdev_tx_handler,
+	.rx_handler = ntb_netdev_rx_handler,
+	.event_handler = ntb_netdev_event_handler,
+};
+
 static netdev_tx_t ntb_netdev_start_xmit(struct sk_buff *skb,
 					 struct net_device *ndev)
 {
@@ -492,16 +498,155 @@ static int ntb_get_link_ksettings(struct net_device *dev,
 	return 0;
 }
 
+static void ntb_get_channels(struct net_device *ndev,
+			     struct ethtool_channels *channels)
+{
+	struct ntb_netdev *dev = netdev_priv(ndev);
+
+	channels->combined_count = dev->num_queues;
+	channels->max_combined = ndev->num_tx_queues;
+}
+
+static int ntb_inc_channels(struct net_device *ndev,
+			    unsigned int old, unsigned int new)
+{
+	struct ntb_netdev *dev = netdev_priv(ndev);
+	bool running = netif_running(ndev);
+	struct ntb_netdev_queue *queue;
+	unsigned int q, created;
+	int rc;
+
+	created = old;
+	for (q = old; q < new; q++) {
+		queue = &dev->queues[q];
+
+		queue->ntdev = dev;
+		queue->qid = q;
+		queue->qp = ntb_transport_create_queue(queue, dev->client_dev,
+						       &ntb_netdev_handlers);
+		if (!queue->qp) {
+			rc = -ENOSPC;
+			goto err_new;
+		}
+		created++;
+
+		if (!running)
+			continue;
+
+		timer_setup(&queue->tx_timer, ntb_netdev_tx_timer, 0);
+
+		rc = ntb_netdev_queue_rx_fill(ndev, queue);
+		if (rc)
+			goto err_new;
+
+		/*
+		 * Carrier may already be on due to other QPs. Keep the new
+		 * subqueue stopped until we get a Link Up event for this QP.
+		 */
+		netif_stop_subqueue(ndev, q);
+	}
+
+	rc = netif_set_real_num_queues(ndev, new, new);
+	if (rc)
+		goto err_new;
+
+	dev->num_queues = new;
+
+	if (running)
+		for (q = old; q < new; q++)
+			ntb_transport_link_up(dev->queues[q].qp);
+
+	return 0;
+
+err_new:
+	if (running) {
+		unsigned int rollback = created;
+
+		while (rollback-- > old) {
+			queue = &dev->queues[rollback];
+			ntb_transport_link_down(queue->qp);
+			ntb_netdev_queue_rx_drain(queue);
+			timer_delete_sync(&queue->tx_timer);
+		}
+	}
+	while (created-- > old) {
+		queue = &dev->queues[created];
+		ntb_transport_free_queue(queue->qp);
+		queue->qp = NULL;
+	}
+	return rc;
+}
+
+static int ntb_dec_channels(struct net_device *ndev,
+			    unsigned int old, unsigned int new)
+{
+	struct ntb_netdev *dev = netdev_priv(ndev);
+	bool running = netif_running(ndev);
+	struct ntb_netdev_queue *queue;
+	unsigned int q;
+	int rc;
+
+	if (running)
+		for (q = new; q < old; q++)
+			netif_stop_subqueue(ndev, q);
+
+	rc = netif_set_real_num_queues(ndev, new, new);
+	if (rc)
+		goto err;
+
+	/* Publish new queue count before invalidating QP pointers */
+	dev->num_queues = new;
+
+	for (q = new; q < old; q++) {
+		queue = &dev->queues[q];
+
+		if (running) {
+			ntb_transport_link_down(queue->qp);
+			ntb_netdev_queue_rx_drain(queue);
+			timer_delete_sync(&queue->tx_timer);
+		}
+
+		ntb_transport_free_queue(queue->qp);
+		queue->qp = NULL;
+	}
+
+	/*
+	 * It might be the case that the removed queues are the only queues that
+	 * were up, so see if the global carrier needs to change.
+	 */
+	ntb_netdev_update_carrier(dev);
+	return 0;
+
+err:
+	if (running) {
+		for (q = new; q < old; q++)
+			netif_wake_subqueue(ndev, q);
+	}
+	return rc;
+}
+
+static int ntb_set_channels(struct net_device *ndev,
+			    struct ethtool_channels *channels)
+{
+	struct ntb_netdev *dev = netdev_priv(ndev);
+	unsigned int new = channels->combined_count;
+	unsigned int old = dev->num_queues;
+
+	if (new == old)
+		return 0;
+
+	if (new < old)
+		return ntb_dec_channels(ndev, old, new);
+	else
+		return ntb_inc_channels(ndev, old, new);
+}
+
 static const struct ethtool_ops ntb_ethtool_ops = {
 	.get_drvinfo = ntb_get_drvinfo,
 	.get_link = ethtool_op_get_link,
 	.get_link_ksettings = ntb_get_link_ksettings,
-};
-
-static const struct ntb_queue_handlers ntb_netdev_handlers = {
-	.tx_handler = ntb_netdev_tx_handler,
-	.rx_handler = ntb_netdev_rx_handler,
-	.event_handler = ntb_netdev_event_handler,
+	.get_channels = ntb_get_channels,
+	.set_channels = ntb_set_channels,
 };
 
 static int ntb_netdev_probe(struct device *client_dev)
-- 
2.51.0


