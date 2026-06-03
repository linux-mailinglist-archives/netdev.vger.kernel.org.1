Return-Path: <netdev+bounces-294788-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UhgqCKZAIGotzQAAu9opvQ
	(envelope-from <netdev+bounces-294788-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 16:56:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A550638D8B
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 16:56:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=nxp.com header.s=selector1 header.b=R8OUuZ3X;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294788-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294788-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=nxp.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3343E33D1D12
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 14:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 308813D9DB8;
	Wed,  3 Jun 2026 14:37:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013017.outbound.protection.outlook.com [40.107.162.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54333D9046;
	Wed,  3 Jun 2026 14:37:08 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780497430; cv=fail; b=Sgu4xRPfiq3vJZQ9eiiI92e/SWF5e8yG6cTOSyYzlT1vTuJF/IkOTUOJ6OgBRTpH8cmQ3SQxehRDz8tG8rA2TpSz2mYihvzPC9xUTSoO+cR+PD60FBbSH/E/er0molapO1YGNkKYP1hSI5CaE92mlECLPeIplEL/HlODAY7I1cU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780497430; c=relaxed/simple;
	bh=C1r5JZhHfD/qhtdQVOnxGj0sK9ec0Q/QDCtXSEi0/6Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BO404KEoEfxPCmzSzU7ZXt71zIU7SzLKAHS23gn/5+BvM4XBnk+dUsEKbEKMZfScZT4XaAoOAw8VgTC9pIu9kPRp7UHYy2GwqeLZKJB538eDP8LZEN2CcaBDSb6nVgqNeTWbsSUnW+KSwx64jSnBEos5vqaqnmrHj5EDD1X6WbQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=R8OUuZ3X; arc=fail smtp.client-ip=40.107.162.17
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uZzKqQ8Cr0YLsLzukC46OxDW9JbG6LhH5TkMVLQXmGASdbvIVL7xs4aHQGRBTSQJ+zL1Pkaw7wAr+GjltHMiu+M4mYoGDjYj9MJOYA1HmOZEBHoajApmyr6+sDRd9RmTgijPC24JPCRZGvS6cJdNObQpdV8E7GYiH/qTwZbHVS9Kda0+AnMleT5N1jumsdTrnyXwnV5nMpK4e5uwObVMo7J6RuxttI7qC2eIcImpQjVw1vMLAncWIfvE9hjNcwJcCuPhUgmETBCSZMdQO7v7F4sI2ymDXPrSa9FkXtplW/uo84eQmMgmtTgZ16PS2QvOrTqMuFn3c6YamaZNZjxNVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ToMkcisyNDw28yY/LZ9P3JpBnwZkLirQvDb7urwVYA=;
 b=aMTquxne3LMEk5QSbc4/VB1i4JbrP9bFvkyClw+775jBMM47Kw83m9IC0GsdWkgA5DYsnvDc7ki3w2SkRc+y59y/fbszTc43xl4Yg8+puw+xW5y5bo3cmAfS90e4RTWgakh6PwbRZUsjpaUd5LeDMNjJ1gs73+EmroscpzQjIqYiZiRNz557QhAd95LpQRgfQuY3YC/cIzOlGi7/NjXHm1cfnZSN7GwHxNN0SeWFoI9/7DWeDcvplr4Gdx0imX5IXej1jbgbGHlwZOgJ+agCq38tIVQZCPVs/oQK2hKqYAmCZ3gBX30R4KWzGsbW1HsCImdD909mKrKbAVP9vaNC2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ToMkcisyNDw28yY/LZ9P3JpBnwZkLirQvDb7urwVYA=;
 b=R8OUuZ3XxU1wYwY/lr/pfymEb4phHy1rwJDvhFo7Pt7nJ+cFKp3HwhFzbrYhx/57I1W10wYuMVQeYao1oedgjwqSCMXLjymNKUKcS0Hh7Sa1r3sZ8gIB1Coj4FrXOGmIG3Ienokxwo8VHcHI7cIKx/m4QqMvXymQyJAdqQflJD1nT4iKRZfKg2mmSwQhHX4Lf9gVCQDc3Obm8IfW/now2oCndM4w6sKqhid74XsGoNzW2QgrcoI/p/HhPH0/h6Cros2Yl1ERbSvcgmhah2U2982Gw8xU1tP/uF17OyKmCuM+USeO+RS6VTKfYaitnaBg/DyaxKkpPoi65iNBbWIV3A==
Received: from GVXPR04MB12290.eurprd04.prod.outlook.com
 (2603:10a6:150:319::13) by VI0PR04MB10974.eurprd04.prod.outlook.com
 (2603:10a6:800:269::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Wed, 3 Jun 2026
 14:37:05 +0000
Received: from GVXPR04MB12290.eurprd04.prod.outlook.com
 ([fe80::1739:3404:2175:33dd]) by GVXPR04MB12290.eurprd04.prod.outlook.com
 ([fe80::1739:3404:2175:33dd%6]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 14:37:05 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 11/12] dpaa2-switch: trap all link local reserved addresses to the CPU
Date: Wed,  3 Jun 2026 17:36:22 +0300
Message-Id: <20260603143623.3712024-12-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260603143623.3712024-1-ioana.ciornei@nxp.com>
References: <20260603143623.3712024-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0308.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::12) To GVXPR04MB12290.eurprd04.prod.outlook.com
 (2603:10a6:150:319::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12290:EE_|VI0PR04MB10974:EE_
X-MS-Office365-Filtering-Correlation-Id: 283ccbc7-f080-427f-860b-08dec17d9564
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|19092799006|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	/wKltENDklvIeKGGu4u8BhQZaPL6ZLk56q1QZ3oGHO1A2PfowGWcID9wgo7nRwHJVMvQWfH3X2zM4Kh05jwjyo3+t708eA5+CW+TfaygIQirVJuD3eWdcnv0Ej3ok9gu49SESVIn7wJhHZCjt59i3PSwLPM/tvzv9UA3NLLDcDW555R1Lk+50432MnQ3N/wA76OAdaFW/GA1zvhCfwhMYQGTSeNNa1LKib/HtWoXjfiLAGsMG2NwAHgsmKmPbcMSnmcd+zPHFKXC8jVeQDabBA2cERFf8ZCqvGEPKpRdqJM7lIoPZbdD1jbCJbe3+lHdvzOgYjcbUked6A1sm1mDkpjYRrDbedPgg1o9Th85HPP2CKFfST8k5EnKwdASZOuDMaLXJZwSII3cO7kV9f+G2CUouO6pQ+wGWi7nKKWX7fRz0T/pYQJPb/hh6UGZENxMBsh2QiydtJDdY77KkSgx2eVXV0XB6m3R09k02JrEIJ9fk7NVDihAcwsMaauPP1Wj2yizC2uoTAv0RgyZ0++BAEfjFPDRx1WSiOOE/g2qxqyhtv8WRaVLYZRExtlFtrPt7AqZOqjx60sexN1DJjnBvbSEsYQnjrgQppTC/Upa2w1HmfTW1lFIgvg4NcstZmIhxtiqULrjKhZ7q4EqOIjEPxQNl20NF0fHE02W5L1Ss2WCYmf1dpZTjNRpZLnqSdby
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12290.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(19092799006)(22082099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9FHPNq5nrSJLtY54CbF6Q9gf5d3ikH2SZGCeKfsuWR/TTjT6RvPRc7eFz9Iu?=
 =?us-ascii?Q?vOhvLcvzFxPFSi/PD1b7NwzVpu18DqwcslY6hl6GLHKO/uA5Xem7lZm/PldM?=
 =?us-ascii?Q?kdS1Ea452z4Za0U04bVGhiWOaWJHPZWAU+bVNOe3+3DVRo12MJNAwbQzHGC9?=
 =?us-ascii?Q?Ke8rCEOltit+nFz30YJX8s2azgEAc+iQRwEcF8AVo3EzCNOiiVVihf+imGIt?=
 =?us-ascii?Q?bPRl4Br5CA+E4/Mw3ZFT/ou1NN92ES2iebvTdDxDEaPpMXkrWFu7OQpZgrOj?=
 =?us-ascii?Q?uFHuYmmTCDQuYZGH5XlfWR3MZ/X6PBsnLltna5pq5dFjkrQJz7KBlo59dsan?=
 =?us-ascii?Q?R3JVmyHP/6PdLidxqMcBEBpixiGrbklH1egntRbwuSiVAEKEmpVq+kBZJY+W?=
 =?us-ascii?Q?oQ2cKvJpVdt0QPpS/1zPZyw7LN5oB1kqO+kj/2bNc4XstHbuTkPZ0bbwjUof?=
 =?us-ascii?Q?ngJPtgm2yWwv3pM9d3N9sGa3vZniarpN7whQQLD1tjvkEsRi1WVsPqJgYdiq?=
 =?us-ascii?Q?gl8wm6WKMQcJtQ4CgkBcnXRIW5crIEEfBXhAQGTDnUkMn5WvOpZluN97CDfo?=
 =?us-ascii?Q?yCTiDQCc29r+p5UYkdT5wYI0/IBBA8YLZenTf+woALE5ZSJ20RKm+LHdrVFy?=
 =?us-ascii?Q?0OXrE0j83TMzxnK/KVGgrkUGvgM7Lur71u634Vi/ZIQsKcOJlPFrXu1fRZaW?=
 =?us-ascii?Q?SxMTpuc1ADijo4zeclhKPdxf5xEVxD3NEjrh5SsBOvO0zdcsLp/BDd5TJpqo?=
 =?us-ascii?Q?3zlsmFAa3dd0n5hgBdknwNgjBkMoJZxVwAvwPJSBc0tSLZ3uHJm++A6EA1hX?=
 =?us-ascii?Q?9WD5jpUKEjrHp1yLusDZcfQDv0hk8M+Ywyq3ztJwmPQXTF5jWwvec+O8FkC0?=
 =?us-ascii?Q?uQ+gR3xsvsMWc1YcVodT+kEBgg6ZIImbOXWdNkNTSVxXTHCtUWUIzKZ80zGI?=
 =?us-ascii?Q?xR8pCMjOA7DEhtQqlRbcg5QI/K2DhkVSXsbfF8RPQUnTkliHCU1HWYJWq95Y?=
 =?us-ascii?Q?i1lsOSgrDqDLstBIxzUpjdxMQi3M5QrMB0vOkg0FGJvsU+oX4LxFIJK7gHoW?=
 =?us-ascii?Q?41ko0+pUylwkESloq3N1viGxl1aQ7rjwO15YLg2GCB8UBirb19CxexY0KLse?=
 =?us-ascii?Q?0kMUAq+oYkDCvtrBqAA07SapFqXWTp12nPSD2SOVV6vAk8Mqx85AWtDSX4i/?=
 =?us-ascii?Q?9NtKYJR9JSwCv9ClXZGyTjjDjXk9/Bgb+amGUdV8oo2EV8QkMlSqTggErmP7?=
 =?us-ascii?Q?b4OAeiwiOTtAMUEbZC9f2EJzANDmqqYYyc0E6Gb2VJ07aJ0Y10h87pxFJm+Q?=
 =?us-ascii?Q?Uelm+NysarRJ3+0CK0S5CY5lHD80M4iMVXkMI9276ODtwJ9kS3mIr4fsaOKJ?=
 =?us-ascii?Q?jd2KppVSiGg2VQnONRVAnBBRqAK2iBUelL1HkWwCvPtFYydlYmNksIt8Pq79?=
 =?us-ascii?Q?Ffds6ymoql4zvbcXQDN1/4WoZekyxuGNTkr3IS4avJE5DVUrV7IszjsP4yoR?=
 =?us-ascii?Q?fyzcXgYs55H0D+ZtnoWiA3t3zNHUTj/JFJn15N9PJ7sTlzVMWX7PFGZ5ITod?=
 =?us-ascii?Q?K8IheyogwBJyXbn2Smu/Kc4zyqtCE11Ml7v5dMrLCQULYkAZDlAltq6SsfI6?=
 =?us-ascii?Q?5Lx7xc5A6Zo7zFinPzwxqo3Pqgvy00KMioa6K48T3TS+lP+PUTZiGX/iiswt?=
 =?us-ascii?Q?Q4ZdTevEOzNMal5jPhCIlBqbXrc6o9ZW1oPXrtmZm0Tl6nvXjqPwbhBG5Vm8?=
 =?us-ascii?Q?6cFSaKj8jg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 283ccbc7-f080-427f-860b-08dec17d9564
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12290.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 14:37:05.5753
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: til5ZxdZsfKS+/a+me0E7ya/UZ015DFtcFMe4qFB8qSwzEvlI69T/bnbR3dTAUBuRMbjXItyTj4AnISqqWytXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10974
X-Rspamd-Action: no action
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
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-294788-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:mid,nxp.com:dkim,nxp.com:from_mime,nxp.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7A550638D8B

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
Changes in v3:
- Change the mask so that we restrict the trap only to the link local
addresses (01:80:c2:00:00:00 to 01:80:c2:00:00:0F) instead of the entire
reserved bridge block of addresses

Changes in v2:
- none
---
 drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
index 9aba5f348abc..7aef34778e22 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
@@ -3933,17 +3933,15 @@ static int dpaa2_switch_init(struct fsl_mc_device *sw_dev)
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
@@ -3954,7 +3952,8 @@ static int dpaa2_switch_port_trap_mac_addr(struct ethsw_port_priv *port_priv,
 
 static int dpaa2_switch_port_init(struct ethsw_port_priv *port_priv, u16 port)
 {
-	const char stpa[ETH_ALEN] = {0x01, 0x80, 0xc2, 0x00, 0x00, 0x00};
+	const u8 ll_mac[ETH_ALEN] = {0x01, 0x80, 0xc2, 0x00, 0x00, 0x00};
+	const u8 ll_mask[ETH_ALEN] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xf0};
 	struct switchdev_obj_port_vlan vlan = {
 		.obj.id = SWITCHDEV_OBJ_ID_PORT_VLAN,
 		.vid = DEFAULT_VLAN_ID,
@@ -4029,7 +4028,7 @@ static int dpaa2_switch_port_init(struct ethsw_port_priv *port_priv, u16 port)
 	if (err)
 		return err;
 
-	err = dpaa2_switch_port_trap_mac_addr(port_priv, stpa);
+	err = dpaa2_switch_port_trap_mac_addr(port_priv, ll_mac, ll_mask);
 	if (err)
 		return err;
 
-- 
2.25.1


