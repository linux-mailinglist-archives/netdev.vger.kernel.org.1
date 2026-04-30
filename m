Return-Path: <netdev+bounces-282622-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4KMLL1vD8mk2uAEAu9opvQ
	(envelope-from <netdev+bounces-282622-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 04:50:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BBEF449C830
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 04:50:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 643243021B6B
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 02:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F037331222;
	Thu, 30 Apr 2026 02:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Z6ocWYEv"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013022.outbound.protection.outlook.com [52.101.72.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B41032ED54;
	Thu, 30 Apr 2026 02:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777517306; cv=fail; b=fOvNpBV+swlAeDWPsM+1QOkteGGPhc0xn/DJIfKrD9PI5KzlqUb/8OXy6elzh+4RWCie4l8oNfL41pWoybFpIlPkIlELFohE9HkBD1o4OhDBb+VnMPxXjMwwU+iYxOVa6Ib75R/5rIe+Uw5cdMSo9/eVXyYNOiOgIFsIqvjylEI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777517306; c=relaxed/simple;
	bh=c+wJdH4oZgyt6QgiUg9RjNbPEo8VK216o+Z/SONP9UI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Yh/wBPPVZDe4LxplpqMxNUZijwEYDogFiIi4Pw04r+CNcqEZzqnTXoXuq6puqPdfe6Imuc16g9BKoRcTuARw2a5b8dzq/iwBWDSboH5Qg+t6qsaZr8S4bY2GH352LCwPQn7xs/w9lnWr/LU8VMug5aiwGJ4n4o8tDqjixRLDAyk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Z6ocWYEv; arc=fail smtp.client-ip=52.101.72.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NTN4xKPydrV6JwEt0oxrLPMB/yZCt735VyKk33EGFRUD9/IIe21PAscSHJRe7LrW5E+3dzyqdRDoN5DK2B9xOxBDkSRu2EM+p9ENN65E6mey4JnHOvfMTk9SKgN1t7ecS3llB72jrnPvIh661x+hS7Vb3RUWmO6ZQn3TWEPJ/s/Tsw6l4+2uN4amKSUubmHTJ1Cmo9ggLWkhrzIOPDsUnCD8EGW9ZU2kEAFVPGWPAmN9sLYrkiPA+MvfrFDbGsim5eyDhKm1mT8CeJOQixT8rreuslAmzPY57J/r1wU843WHE69VeXnHes+DXHyD99vszt+KyAi/mZZ+JnuEFJun6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dUoYI37GkQNNx46g2NDt3IUbaaHoWLfypsWkF7MaxNw=;
 b=e+F1oFar/OIyB+CGvnDVmNVcGSi1aGllrGw4cCtYTY73t3Dn/si9lUIv7CJ/WMb8Q8XguUQPZjMLMVjOtdc+Dve6rcmO5k6T9eSNbree1ZS7+Q7rBSybJgWjWHslLG4pBmMddoKRhWhYcmdG8a1Ul2Vig+Q5pWYZvtWjn0Ce8ZF14ld6xg57QGPFeLZEOVnlMF9yG5xhU8XoYoqQebfzArx6b6gcAqz0HVjfDGtJnPM5Vf0/9udYB1AvlvthGvrnx9r+HiXkj+RPBUqsV6ouxtamUpEV/4tK2Lsf4oamRAlvtDYFXSvNda0tw/CMVVUTAq4X0Q331u6ZUd64MSbeLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dUoYI37GkQNNx46g2NDt3IUbaaHoWLfypsWkF7MaxNw=;
 b=Z6ocWYEv9W4Nx2GJZ44okRsbUd00Xi2nItBgfx+WUgD0l/8K4yYs7I8G3PP1Cfz0ZQ5eaZQdkR4LVpxs+H4nD+/n1/oMjQMA58QQejCKiZ3C7CJ1ipo0FCNbUINzDGsWlr+NPuV4/GDY+guvLf+B8kD2mNZN+Qr/xSFmlXjgeozYWt6TZNUbPtToow3t6DLp0MD+fjoZ6P4tkNlH5zmYmXfwx+CHuMDGpE+GvjddqE1lK2FGNzguZCxbXFCj7Im94TqXmDC+m6HVLqWGzJMUArE9+KdKR/2MCRlpPz0CB5zPiEyNBfInnsJx0Cldp8NMvcPJLnMPCwjB1zL7mxWUow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com (2603:10a6:10:1f4::16)
 by PAXPR04MB8608.eurprd04.prod.outlook.com (2603:10a6:102:21b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.18; Thu, 30 Apr
 2026 02:48:22 +0000
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7]) by DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7%6]) with mapi id 15.20.9870.020; Thu, 30 Apr 2026
 02:48:22 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	f.fainelli@gmail.com,
	frank.li@nxp.com,
	chleroy@kernel.org,
	horms@kernel.org,
	linux@armlinux.org.uk
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev
Subject: [PATCH v5 net-next 08/15] net: enetc: add multiple command BD rings support
Date: Thu, 30 Apr 2026 10:49:38 +0800
Message-Id: <20260430024945.3413973-9-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260430024945.3413973-1-wei.fang@nxp.com>
References: <20260430024945.3413973-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0133.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::13) To DBBPR04MB7500.eurprd04.prod.outlook.com
 (2603:10a6:10:1f4::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7500:EE_|PAXPR04MB8608:EE_
X-MS-Office365-Filtering-Correlation-Id: 10cf210c-fe98-4e59-7085-08dea662f1da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|7416014|52116014|376014|38350700014|921020|56012099003|22082099003|20052099010|18002099003;
X-Microsoft-Antispam-Message-Info:
	G4MihIo7//5O8EEw4hbs8gSjokSMIeDo97bW8UBfVtllfOEuNoGSrhNiRQXcUkmiuvOWHNCVMHY215LURpRpQsuypDf1y9snClYlAE8whuOvpB4PYD/W5EcFbAaoNlmvwQKlMfeWXNr9XoQBeNqYVdkXpeqyo5HCaqKKK2b1smni7xHLMd4kGPE/r2+sskh0Hp07BZfkFG1SDZJcDFyI3MpqNMy+OGCxhH2Fkc20O5BMdc9NA9paJJgVERMYcjfaOrgku1jsuzv0yBM28l28FF537q7EcYLz5R3rpvmmfZ0ewZkcYJ6Qd+8iKq4HlSq8zZ42+UG4yVOeceNLstJbKvaE0/nQNqPh7nTiQZ/lQeUElcj0uCJSfADFEIxA7li6MvZtYCTHSrdP3J7jZrXDFso1Tz5iQteI2Dn/4lbI+dcF3nqtCNpgE2CIkP3VBCnKnxsaI6UMcVNHi5sxfMpN+NISRNyDSETOyb1CCkC9mOqPHXMgf+QS5AcNwGvy+Ewd0IufJo3vjc02q058G3sXZZrYE56fk7594lxqkWyfXnekOgbNyJHmIW7rm03+Ecxw9KRMY6C3HCvvE8rdkkutougI7Ehel2x6msbUDEEsywXjnF/xpIMGZdEMSVbs6kOijhIcNbs7UtLuCYAqWUEXqOO8xDpnc9oX0FMKzuehvRq1sz46HuedacKVu/11UpEG59Kvwas0iISZB8rjwZYz76CLdnfAtbpoG9sewzBdW4JsP3JVk5ReRerZrLvYz2xLLjB0bQ6s9WOVqIcnVMYQK/W0hzmRXB/QTkOp2q7Bv4P4pcJQEiqgOg6YUf5JbkWT
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7500.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(7416014)(52116014)(376014)(38350700014)(921020)(56012099003)(22082099003)(20052099010)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QYnDCpKPdp9QIWWnET0sKIo4Vwxme7JjwSfh6Diqj8XM3najOLC3HjnN8wky?=
 =?us-ascii?Q?H9pRupYIVw6zVLWjchfseImsQpBIzwfOSP67Yxm3jhlJNRmAw76TeKj+itAc?=
 =?us-ascii?Q?asgA3+GsADVr0C9Fu9NgJAkw+8GqKeQqi9EtPKaz52EPK+YOXsulnwN8XbPF?=
 =?us-ascii?Q?ULz7iuFi3xVTRiBbHxy+lOF9lCq53DFmEIjQ/AMkL4s+9Ffc+WSy08CTAL7v?=
 =?us-ascii?Q?ET6xVloSz6JWVQaqEb0QBiydTk8E9q+wr6teAalWXp+HXIIqRAq4dekPgBa9?=
 =?us-ascii?Q?8vpgb6jt+MJnVNuOuqj96Hh/jEf/GEonsLetstnRURPpCvYqpwgT/hO49J2J?=
 =?us-ascii?Q?pPPALE2kNwZBqF5PYrsIOQmiL4WyD65lQjpIZT6eYp9Mmra+rlxFjqVSQ9ST?=
 =?us-ascii?Q?fuNZsrH1UGG1vnLUa0EFSI8pgTkVlS9lMpfOpKfRSeXutuNvox9qmJ805hBu?=
 =?us-ascii?Q?v/cPBF1LX4khBgi+gdbg+gSNsTTXqD6++g//2f88Fs/Rho+tNBztj1y5uDsR?=
 =?us-ascii?Q?XCHxeUCtwhDu8WXZcsmYMjFpbcYA0J4apmR7/M/r803qclKV9o3ToSRvR6jb?=
 =?us-ascii?Q?O34nd58U3lSV4zV7ngaSImh0ul3mOivB4o7VAFE/Scm8cUBpuvr0i4FldgCI?=
 =?us-ascii?Q?pBcsuDS/7kYyMe+Ks69K9pjjLqwslJvHvcA0nkeQBVqvlfkMPDbjG3jBrocw?=
 =?us-ascii?Q?MzNkAlydMnPELo6FAmR57w33NsbNabR6ac62JBCR8ijsPptCtG5TDFaX5hU5?=
 =?us-ascii?Q?o0jv4BxpgIBpPt1mjNggF043Ddz9kjXbR4Jzp5lYoVe4ukDfaExl8NcYwSDg?=
 =?us-ascii?Q?PfudKGcQBiFFqu+eZt5oB3KQ3XlHDH/FJKo9GLBDOn+KPO4VPmLeqW6zPKlQ?=
 =?us-ascii?Q?mHNQ+VNgpCa6BY08fJc2h/fDH9HhmyBPlVHLCiBrOdGTvm+pWGlKU40psljK?=
 =?us-ascii?Q?wK8H58NeZeO3vX5OLClCzK8Tisj3CJopQzo4c6UrS5iPbjOvDj84M+6lPJ0s?=
 =?us-ascii?Q?QxAerhUaDmmWmm2/3sNhZtRosP7ywDKeKupa2dCMIum44WtvozW/0rQYmn5Z?=
 =?us-ascii?Q?g1OHwebYwsAXq/DIc39EC59oEUmd16zC6dA0e76TmzDyuy6e7Fln6Xblvb7O?=
 =?us-ascii?Q?PpV3L5Sh3rZRzo/6FEZamY7kv91ljIiNxUF7wb0g55m9ylIJ8EY/VyO8sGiK?=
 =?us-ascii?Q?r4WlpOuRj6NS2h6KQzXTE18jTA2xbrkNBr0GqBg0wlGDjHRD3xrFo4cXt5zh?=
 =?us-ascii?Q?vyi8e7j0TZ/rVvWfGnXMpssABFuwGYoOqVHjHksmLiAZfJDdYHooDKWkHbDx?=
 =?us-ascii?Q?9YLILK4o26O2xhfqKHJ8dGppKFIWJ2iAyo6tCCoDSAgSbx5w99/g0G8axnju?=
 =?us-ascii?Q?RdogKkAFNeylq2mYTtKZZ4HCR3NnNbTfFVL+5jNGd8XN06GEpS2yrOZ+9Ezl?=
 =?us-ascii?Q?/ATnMruRTb8Jw8Wk2joYSqNzjDoFXE/iMUZ5VxvJdjDaKzg5EGYPr4Q6x28Z?=
 =?us-ascii?Q?PwwA86azf0I+U7k9Af0ktIthHBBYiSh7BbwHUiuRF1ir84oxU6RYdi6DYFwN?=
 =?us-ascii?Q?KgYStTOYkyPwMWqziT1RsWYj7NgZBKOtF3HAAbd9+iFOJxOmWOVJtRPYNDh4?=
 =?us-ascii?Q?ehmkjv1L7d7N1VAvuW31wnHJ3sXCXChJ9u7O71fnadgUWtYxvCOSeM1qjKln?=
 =?us-ascii?Q?+LtBdh2+4hpoyFn2g24AzpdrPd7Y11HuldvtwE7u3pVQ95haty9QZlPR6svn?=
 =?us-ascii?Q?kzaajwW0Vw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10cf210c-fe98-4e59-7085-08dea662f1da
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7500.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 02:48:22.8814
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1FCWc39dXR4DshazATRszuHUK97PQWMinyI/6Tad/LXPj7ZFC4zIEW0G3jPBoSVvcrUsArH9fUe2SMmn624OOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8608
X-Rspamd-Queue-Id: BBEF449C830
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk];
	TAGGED_FROM(0.00)[bounces-282622-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_HAS_DN(0.00)[]

All the tables of NETC switch are managed through the command BD ring,
but unlike ENETC, the switch has two command BD rings, if the current
ring is busy, the switch driver can switch to another ring to manage
the table. Currently, the NTMP driver does not support multiple rings.
Therefore, update ntmp_select_and_lock_cbdr() to select a appropriate
ring to execute the command for the switch.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/ntmp.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/ntmp.c b/drivers/net/ethernet/freescale/enetc/ntmp.c
index add8e30a6061..4bb7d06e5dfd 100644
--- a/drivers/net/ethernet/freescale/enetc/ntmp.c
+++ b/drivers/net/ethernet/freescale/enetc/ntmp.c
@@ -144,11 +144,16 @@ static void ntmp_clean_cbdr(struct netc_cbdr *cbdr)
 static void ntmp_select_and_lock_cbdr(struct ntmp_user *user,
 				      struct netc_cbdr **cbdr)
 {
-	/* Currently only ENETC is supported, and it has only one command
-	 * BD ring.
-	 */
-	*cbdr = &user->ring[0];
+	for (int i = 0; i < user->cbdr_num; i++) {
+		*cbdr = &user->ring[i];
+		if (mutex_trylock(&(*cbdr)->ring_lock))
+			return;
+	}
 
+	/* If all command BD rings are locked, we need to select one of
+	 * them and wait for it.
+	 */
+	*cbdr = &user->ring[raw_smp_processor_id() % user->cbdr_num];
 	mutex_lock(&(*cbdr)->ring_lock);
 }
 
-- 
2.34.1


