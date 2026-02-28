Return-Path: <netdev+bounces-262151-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AFZWEgcCo2kJ8wQAu9opvQ
	(envelope-from <netdev+bounces-262151-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 15:56:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 338B71C3BCC
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 15:56:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E615B30759E0
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 14:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23CCB44CF23;
	Sat, 28 Feb 2026 14:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="EuxSPmti"
X-Original-To: netdev@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020096.outbound.protection.outlook.com [52.101.228.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0816644CAC6;
	Sat, 28 Feb 2026 14:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772290552; cv=fail; b=ioXxFTY7RlA5iEYWcqksbqT2O9wHVbzBsrpcw18ISoussv2xffNajL+W347Wk8jI53U3WA6TjqnWSyPa07eEk/lljXbD83ehX8llUewAUQr1dy0KjwtTFDWKSOOELrDVxkZSpWJWc/lXAv9cLingPxlvyX/Yzpn8rUJYtOiRoEs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772290552; c=relaxed/simple;
	bh=YYkz/57aajK5A/fZjhk73b9JxyWQyo7bpOJ9DkuJaAo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=K3fkDUq6yETQnFGimZlM8fASh86W08047LwQrN/EBBDamYWUmepwxyHA2OjReUUNA+WtlGKytfaTHEHyEYAg8rExFKfiqPczfkSq82+TOGF8HL3CMQ+M1csj+oZbxjRfde3shs5nEqHS8j+hP0Vo7+m0qEtLkVy6BNwLju+jHLs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=EuxSPmti; arc=fail smtp.client-ip=52.101.228.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tpmqkMWya0jOURJU4kSa2B76551JD8qNXCLOdK2B1HJqM115gah2bupZZg9P0761S9eG7WZagx+AU0K6uM3dxsppVQ/UQaiR0XBMKmdwqwdySZPtcoEVi4Ur50SXMyW6wtFiENWQd6HfStl2edKF8b+0Ip+HTLyGfCSavgYx/sMbrkXj5O3ukyBEy2r6m/xhHPP95GDGy6HFN8xEkc/qArdz5LDqd9ZU60EYn9AsU5RSTQxzkN3UcKT9/fDMPb0kYfLXRkv9xTLsXtkH4TrMe/XHk+6i895mHXMOtBfQxhMZmF89MOToI1a8vQVKgKaUcBE/GADt0IfqJKrgoaaJ1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J5xkKyMWyjlAVwKnUGB+fgOGvC+OHlHB7MhJ+HQFSU8=;
 b=KXBmKZOCdo74GCPOP25qRbyCbzljga/SD6NITbq5d540REbpb7FhffL+VkCo2qMtmYPOIN+tLt7veaMaiOmzAnDUWTwqAZTg7T53WSH22wDKuSG0PNGsb+ebj2Tf9ZE9VZqw7uBzZlWTLRfspU7QoQIl64KiZrhhGVITKZmOqNf5CtENfVoQk2fRwO5XC4IbgkIMrW+NHYfcm6NhUlmNMrLpwGoTRgqMZ9MBwaSSqGZBOQLZGe3pVoM1HJZkKPYVbmgCCQHw2fZgTyMYngMMy0bIeGNR6ncviNkxFNdv5lw3gNeiUrwhgvEnPX0XLMNgZ2dH9QVqo7xcaH1//I9oSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J5xkKyMWyjlAVwKnUGB+fgOGvC+OHlHB7MhJ+HQFSU8=;
 b=EuxSPmtic02GTXHRdoCy705AVnFYwN2/rkWKarQdCPzkqxEQ7YnIV1o2APGn6z055TlDfL7ozMQPjlIFw8gjgSfPQ7DcfaZZ171KqtUvKLnE9LmnnN8DAYEyFsW9wGtsW/uZ9sj5Wp/axFKR+EnK937rtrQjS1FD5Pa8mp4eGBk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYYP286MB5182.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:164::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.18; Sat, 28 Feb
 2026 14:55:47 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9654.013; Sat, 28 Feb 2026
 14:55:47 +0000
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
Subject: [PATCH v2 2/4] net: ntb_netdev: Gate subqueue stop/wake by transport link
Date: Sat, 28 Feb 2026 23:55:36 +0900
Message-ID: <20260228145538.3955864-3-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228145538.3955864-1-den@valinux.co.jp>
References: <20260228145538.3955864-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0089.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:37a::10) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYYP286MB5182:EE_
X-MS-Office365-Filtering-Correlation-Id: 909edf0d-c865-43f6-1d8f-08de76d974c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|10070799003|366016;
X-Microsoft-Antispam-Message-Info:
	ELVAtFL0sE6Jt0DlZ//uhZZImRXuY9d5a6PHyRDX5F+eIAOUHYnpOazPpmhEW+5ga17VTyqIz+Jm93ki6BaxWvnLCoV9uFwIaKpPsvs3WmhuVnUthnEggiy6UIvgIN5Edraa+Hlgr2iOAlAB3HTzlwIaQBalbz8s3BNUYHBAXZ55RQ91to7FW5sNBWwHBcxXt+s+EQILyjCFTtFIrsVqzuMDqRPTbR30QpvkvoneKeupVQDFA9hP7q/IoH7MLhR6m6rJka6izymWXor9pWcADtrWIv+bIkMgFDe61b/RxHpD+kHk8/JEVYiBsAZNSOf49WrBnQSocwayhKHJ7JKBzCI0/webK72GYRmrTnZYltELCwtJ/YfmyFkjSX7v14U8+E5d+kmaynbOKkD6H95J44EtwfRcO/JvStS+D8z0Gk+jGMhC4TR6mNvmx6VkCW4Nq+2o2sNKZmepuyU3KRuZxA81gzEsUo1pOw/m2iUZUtXFDtB0vsxFvtau9ovsC0mPbphE5JlYXmy3xa3Bgivx/aBmkVF14S/saMV9a8gxvND0sF2uz6kGNq+62dVN2bk6Lc47WmKOpggjfMzB3lG/HmSbUUJnyz7OYtYYNtSugW7SBpcvvVfrvx/9KYvu6niiC72jGOAOHRJtyPUeRg6N+ZiXaeOgjfg3TEKn8PPSQkZCfKQY1oX4UPPtzBsJgws0WJEcCm+3ZVuW5oohYddrBU4uFLCVPaqltSO9lZl1IMU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(10070799003)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ddv6HNxGdu8CwXf4ovUMA0av8zOsO/Ik3K8D2lnZue0NGWGdyrzMLaMHiKdB?=
 =?us-ascii?Q?EWfSxE5WMD8Uhx7rg2nfUZbaiHUrK9T6d4yZVYxIHPevj0S2m/2Zgd8Vk3Fi?=
 =?us-ascii?Q?I44nMwQMRUWneE8lk8tHHdqGiE1ivVcNvdLFGnYl6oeqOjvETKXoXS7RG9OU?=
 =?us-ascii?Q?MaVTY1QpXcT0EdTCUYsKvO6NCzpSWYD6/vX/+KBDLQpnFPAwrMdnBREio+Lp?=
 =?us-ascii?Q?SuJBu0sXqJIMzIbTzYdHC3OJtC6T23SaoFykA7CtP5rIsZcJ9vo11MrJkTZp?=
 =?us-ascii?Q?ejsmsyPOniWAbxYUYV6/M6H7cuGtr8qNc9i0tpW88vmbeKlFxQPfoxZktAkf?=
 =?us-ascii?Q?WkyBTV2iAbmN/cECiPDucdbiXxEZb5zF4qHJpRkLdTEGTM3KxrvjmeM2Zvb+?=
 =?us-ascii?Q?GwLpibOyxkqM+TpWEOKAQkvsZ0A28fpqPHf7hMtMU1BEtVQUqQvuKs4TOuBg?=
 =?us-ascii?Q?ZDFCL/egv6gHmvNkYoeLnlspoWjIv2JoJhxuDzQ882V8MBcazOnRosLQce/j?=
 =?us-ascii?Q?hwpScyF8SXBIiS4ReopCcErrxrGYh3CUdNNY5ieMkgkKq6IrjxqongUJ8cB2?=
 =?us-ascii?Q?/Q2iR7cR0eHjE0ngjTwPqoker4m0rPWHTyhVVC0kDsUFNbehabnKY4R7PLb2?=
 =?us-ascii?Q?316rZ82OxaBxPtU4QMgwBQ7G3M7DPixqmEIR21Y0Fq/A5rnWxgdUyzdsjkbm?=
 =?us-ascii?Q?Pd1XkQwZFVaFkKHJVTzJh2l7NshjQcFVtPgDCDCqheCaTSKPuXlCuoA0G+p4?=
 =?us-ascii?Q?lKGHuTO6vOHzGdQ/fkM1ug1Csklxx5k4YMsMzHrSKg7D6ujdnVRGzBm4QKfa?=
 =?us-ascii?Q?iLXFcnoRAdSgwjM2a/fPrD2s4bwQa8h3EfckT+WKJKowZWU79xF+vLBLiyLh?=
 =?us-ascii?Q?A2QxkQyeQ4wTn5FGMAVZvHqRgMuk0rJXq94kZnZJIIN5ILEhKGXsjcJThZm1?=
 =?us-ascii?Q?eC3Fx72zBzgi7sXoepYOcmzuCyHsYS9/3d+5XZzmRLiZJ8w79az+KlJzGnsO?=
 =?us-ascii?Q?tHsvusyXz2pHQJeWLi+LceNtFOOkkr9TCwE73sFjUulicdUoAW/zw1qIo0u/?=
 =?us-ascii?Q?FFB3Bg9FboXZU6tq680VrMhHk16QcB/C6Lrj1T5vD3mMXm3wlA53IwYRIWOD?=
 =?us-ascii?Q?Y3Wp3lcE42PuSKh8TsoDeLQYoSpouW35NY1ZYuHaXGq6gsdvJ+i8eRX2aUXT?=
 =?us-ascii?Q?brycStQaYnPGAZWOYQP16MczkQw1u5VqXfxhVDTt7wjYePtCy4/dJDGB+2EK?=
 =?us-ascii?Q?wXcctSa7y50coUxWRJ8S8fPm2JH8Eb2PV1V60uHZ24CMekIiPqRXjqLeVKP1?=
 =?us-ascii?Q?D60VxLTmKl4rVxfcDqJJzbflJVndxfNLP2YCk7xwo/TyvzkGzpt23VAoIBek?=
 =?us-ascii?Q?k9gP89DYSJme21oC7orJ2ZRHxCOc5w2CBTPHCUe/kmcegWtD+g0vVOGH6GM6?=
 =?us-ascii?Q?kr8ZJzLp8wRfJ4vvLBcD9rhkrhBlP7H4TZ2FrgvmuLfqRyMH26cBKO38Z02r?=
 =?us-ascii?Q?JjU6UBQa+zyV3aue4kA7Kg6+T0trLIyAjFvP6b1w0HBz1U6mVB6lotmtx9kx?=
 =?us-ascii?Q?wDZU20MAm5b65KRaZbFKGEpd/kgLLW8YA15m5zemrh3/ORvRyDwkNVDJPpJ2?=
 =?us-ascii?Q?tlhIqClY9zTKJ55jr9cdhXqeDjZmczTd4aG64wbC+7xYef+YdIvIc297NUbX?=
 =?us-ascii?Q?VGoKKR3/gUDS9ODIAYl1zcG+D1oTUskxNUJ+jPUFbL1mMSMd7BDN2m05uTL2?=
 =?us-ascii?Q?g/zNQNH+2tQYU9eenBmDEt4ml7SPoELa9+0F3YQpv5tgCWmCUH3J?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 909edf0d-c865-43f6-1d8f-08de76d974c4
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2026 14:55:47.2667
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: usFJ0w0cqxtPFLf8MYG/XjKeGWHcf08SNP8ZeX8xbRBdVFhsbipDd0aLbD+2Ur3UVcqV0OmqutH8vuz2oHhmZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYP286MB5182
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[kudzu.us,intel.com,gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	TAGGED_FROM(0.00)[bounces-262151-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.993];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[valinux.co.jp:mid,valinux.co.jp:dkim,valinux.co.jp:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 338B71C3BCC
X-Rspamd-Action: no action

When ntb_netdev is extended to multiple ntb_transport queue pairs, the
netdev carrier can be up as long as at least one QP link is up. In that
setup, a given QP may be link-down while the carrier remains on.

Make the link event handler start/stop the corresponding netdev TX
subqueue and drive carrier state based on whether any QP link is up.
Also guard subqueue wake/start points in the TX completion and timer
paths so a subqueue is not restarted while its QP link is down.

Stop all queues in ndo_open() and let the link event handler wake each
subqueue once ntb_transport link negotiation succeeds.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/net/ntb_netdev.c | 42 ++++++++++++++++++++++++++++++----------
 1 file changed, 32 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ntb_netdev.c b/drivers/net/ntb_netdev.c
index 7437b4580dff..19a3383d86f8 100644
--- a/drivers/net/ntb_netdev.c
+++ b/drivers/net/ntb_netdev.c
@@ -99,16 +99,30 @@ static void ntb_netdev_event_handler(void *data, int link_is_up)
 	struct ntb_netdev_queue *q = data;
 	struct ntb_netdev *dev = q->ntdev;
 	struct net_device *ndev = dev->ndev;
+	bool any_up = false;
+	unsigned int i;
 
 	netdev_dbg(ndev, "Event %x, Link %x, qp %u\n", link_is_up,
 		   ntb_transport_link_query(q->qp), q->qid);
 
-	if (link_is_up) {
-		if (ntb_transport_link_query(q->qp))
-			netif_carrier_on(ndev);
-	} else {
+	if (netif_running(ndev)) {
+		if (link_is_up)
+			netif_wake_subqueue(ndev, q->qid);
+		else
+			netif_stop_subqueue(ndev, q->qid);
+	}
+
+	for (i = 0; i < dev->num_queues; i++) {
+		if (ntb_transport_link_query(dev->queues[i].qp)) {
+			any_up = true;
+			break;
+		}
+	}
+
+	if (any_up)
+		netif_carrier_on(ndev);
+	else
 		netif_carrier_off(ndev);
-	}
 }
 
 static void ntb_netdev_rx_handler(struct ntb_transport_qp *qp, void *qp_data,
@@ -177,7 +191,10 @@ static int __ntb_netdev_maybe_stop_tx(struct net_device *netdev,
 		return -EBUSY;
 	}
 
-	netif_start_subqueue(netdev, q->qid);
+	/* The subqueue must be kept stopped if the link is down */
+	if (ntb_transport_link_query(q->qp))
+		netif_start_subqueue(netdev, q->qid);
+
 	return 0;
 }
 
@@ -218,7 +235,8 @@ static void ntb_netdev_tx_handler(struct ntb_transport_qp *qp, void *qp_data,
 		 * value of ntb_transport_tx_free_entry()
 		 */
 		smp_mb();
-		if (__netif_subqueue_stopped(ndev, q->qid))
+		if (__netif_subqueue_stopped(ndev, q->qid) &&
+		    ntb_transport_link_query(q->qp))
 			netif_wake_subqueue(ndev, q->qid);
 	}
 }
@@ -269,7 +287,10 @@ static void ntb_netdev_tx_timer(struct timer_list *t)
 		 * value of ntb_transport_tx_free_entry()
 		 */
 		smp_mb();
-		if (__netif_subqueue_stopped(ndev, q->qid))
+
+		/* The subqueue must be kept stopped if the link is down */
+		if (__netif_subqueue_stopped(ndev, q->qid) &&
+		    ntb_transport_link_query(q->qp))
 			netif_wake_subqueue(ndev, q->qid);
 	}
 }
@@ -305,12 +326,11 @@ static int ntb_netdev_open(struct net_device *ndev)
 	}
 
 	netif_carrier_off(ndev);
+	netif_tx_stop_all_queues(ndev);
 
 	for (q = 0; q < dev->num_queues; q++)
 		ntb_transport_link_up(dev->queues[q].qp);
 
-	netif_start_queue(ndev);
-
 	return 0;
 
 err:
@@ -331,6 +351,8 @@ static int ntb_netdev_close(struct net_device *ndev)
 	unsigned int q;
 	int len;
 
+	netif_tx_stop_all_queues(ndev);
+	netif_carrier_off(ndev);
 
 	for (q = 0; q < dev->num_queues; q++) {
 		queue = &dev->queues[q];
-- 
2.51.0


