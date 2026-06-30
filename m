Return-Path: <netdev+bounces-303025-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Q8FqB9d1Q2o8YwoAu9opvQ
	(envelope-from <netdev+bounces-303025-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 09:52:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A78616E1682
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 09:52:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=bfHt2ZcE;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303025-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303025-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 189693021749
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 07:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07FB83EA97E;
	Tue, 30 Jun 2026 07:49:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010066.outbound.protection.outlook.com [52.101.84.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665DE3EDAD2;
	Tue, 30 Jun 2026 07:49:45 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782805786; cv=fail; b=mKZYkutOmRZbmGQJI0aRwbfpPgJ3l/edwMGvU67Pme0U+dT8FtPWOGLi7a4Un27o4/FcTlFtVJH01TzvHulaYXqztAONHHUJbBih5buN+TOi4AeQwReLrzUUQyDDWjQqpijArRJVtAjUcQ/QeOxwCEQ63Ct1WeYbsQW0Gx+h0mU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782805786; c=relaxed/simple;
	bh=VZ6tklCrHxhfA0jIQY0+ogrwpEr9IkTTSVB8gBpNKFA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Fg4TASUH/mRYkMAr1AQy67HTdadA9Z8zPnfhQhzbE2INsIrN/5HJbIUpjdX9T6/JcOrG214zi1ChPmc8Z8okMwpnV2kD68CWpL/Ey+rBdECIKLflkashfMEHYjx1pNv3DB/SXihgD8dLy9+gUUN76/hjcyU85uixMeidS3zWvpw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=bfHt2ZcE; arc=fail smtp.client-ip=52.101.84.66
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SFvCYo6Yx0QrJzE0bMZ3LuZywBMqVIIx+tJgUYraJN3i2fqYx+SMnCR69c4nMNzRTT/yHPFQ6tvOxzGvmMZVfU2V6wUMZ9h9ztJ3osvmyfv1/jMF4Y+AVpH2fYzNZCs5FeP/hY6UFBbfVgHNgyads0gJZP5EURec11MHK9m3BULJcaAUfZf7wyYnBd7EUf53tv4qYv14MBzgwrmqYW85LEgxvyfG9R9pctL2jaiPMYCcYGLjRml6K7+zzZDAjPk/AcLXphIbklbgOMWkerSCcZu5/5FccTxeTEHUaqjvdkY++RIxvMZR4swnL6YvFj4yApQtikbTQaMhiGAd2KCGbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mgOknO2lE+xqVZxduxkSrQUwltbTHSa4nCtX4e8daq4=;
 b=jNOkptCmqHrmOO8+pI0pvar19cWiInQYyiGbKBrZsP1vPEfSJ7rEUyh3Il6gEbqnCqbobcgC5jhWrT4AUz3Aow//26TF6ua8HYMmT3w/dOk8FIk+AnB394r2VLd7wzWisYpxV3WXsL8MjMCS+4FyictbVpQQRvQMy6NKIjbyBpc1wb4mlIM5r4TzuyZPtHagfpfZDmkesm3KGPQgHLOYn9hZaou8qUWqgR6zsqnds61syu0gFfCQnki6l/W44gwIYbVzx/B/TfONwd8m+HFbPle1I4h7FJapHXMCwW1sdB4SRziWpUAN1LSn5FYDBsfy7cA/xxOOLwdp/a18/xayRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mgOknO2lE+xqVZxduxkSrQUwltbTHSa4nCtX4e8daq4=;
 b=bfHt2ZcECS3coLHP9FAoTKk1lY5FfImopw/Po6nMo7Jx6TfuCJABG1ttkgL4NMUP2PuM9YYokUVePfJS9QMmAPtd70/GFseDUyEZ6TyAA589+fXfnbRugW2lsxTVwbZeZsE4uNrhpQdnHfgrncievIqu0yg3vP2ak+U0pgixlV5Mv7pSCULpM8pIHzyjIbb7tJfEBf7XiUU+B6cYUypdJxrhDsfiYpiMaAZoAOfTyEp1J9Zdq/zMXaewz++Aiqmmveq9SDFIZ2DhO8Q9yOXb/Vb64hMZCEqtjDYjsiMsxoSrhq1wOF6xk9XWJss+tPmTp7oivYcbDvsSAu2vWYG5+g==
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by DUZPR04MB9918.eurprd04.prod.outlook.com (2603:10a6:10:4db::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.18; Tue, 30 Jun
 2026 07:49:42 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0159.018; Tue, 30 Jun 2026
 07:49:42 +0000
From: wei.fang@oss.nxp.com
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	wei.fang@nxp.com,
	chleroy@kernel.org
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH net-next 11/14] net: enetc: move enetc_set_si_vlan_promisc() to enetc_pf_common.c
Date: Tue, 30 Jun 2026 15:20:33 +0800
Message-Id: <20260630072036.382761-12-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260630072036.382761-1-wei.fang@oss.nxp.com>
References: <20260630072036.382761-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0006.apcprd04.prod.outlook.com
 (2603:1096:4:197::13) To VE1PR04MB7216.eurprd04.prod.outlook.com
 (2603:10a6:800:1b0::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|DUZPR04MB9918:EE_
X-MS-Office365-Filtering-Correlation-Id: 33d0058a-dae0-4027-b6b7-08ded67c2502
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|376014|19092799006|1800799024|366016|921020|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	nd0JXCM/hKUqGV/GWjH5JtokSlQ6nl94DdVQZRNUlCCNXxS3zMkCFHePhwZEoV8Bc2BoUq0njFIeOQ3KVKxajttpNYhPhDcCgpjtzy6hrKEEPuUEmN5aHgcNp9cRr25o43N7Adi4sw4IGhZWwtOXbCVoepk06zex5FKlpvY5p+uA8AjtuDBfTcOTL9VrJTy/PycxUUikbwNSzqON0vvcdA/I+PWx/ZhmgdM/VgUWtMcL+1SyaRvCbdTkS3SvnVqEZ0XgiPsZvPwpeaZ8UhJK8aO7rYvn3Auvf5ZvWOwAVOX+FARCC958W3vpHzrSSZ+33eixR/Urx5BSXpZS2NvkvwcQv95ypWf/+UoCGNTW+dJ63KZIjbjhvOWjn6r2RsuEyFKeaSr/aDXpdhNJ2TRaufuMCmzdqGnTvP4eCqvUnT8zEFxkUZTFVIsrsHLE9UdaflDak636rMD9R1rHJXq+OlkV/4+CckH4M+Zc+x0zkpODiyNRfJfokLzqzqlLfLUIIC3VVutCMK6uZ+zvI5IyILIMZHfHoEgF9dl+0X1XbHGp31GiaN4teDHaI+4pktIKzX6SCmpg5R4qu0Z1CRGNoa5CtqnTXmwhHaHl37zg4IJCDSvdrgjf3Ts6lsRK1Kmlgl+BzLFsqYAlo5BTJvYCgzb19NL29o0bX+Zb39IoYEbZg5W2spUXxBbuu6e9KEXmx6dYCXo8OF1HU+g+v/EN8g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(376014)(19092799006)(1800799024)(366016)(921020)(22082099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?n3g8D33kj/LtoikH11STT/+/8MpnL19bLbhbC1E2w5rvEGzDVtnToX/Gqcgi?=
 =?us-ascii?Q?EaW9bVbIIyM0Y0eDWL+Rp71Iv9CGdYWLkvPvvEsvBjgQCorKRCYZ6GNdJyDn?=
 =?us-ascii?Q?qH/9agBVJVxXABQST9ZaqSQ88K72Ku8oBxVfZprI/waQI+vvx36HikNNspwB?=
 =?us-ascii?Q?C5V8jKxZU47UibuGaLGzrKYHnY9duCHD6Ht8TGS81udH0LkOKG9pnzBf3WQE?=
 =?us-ascii?Q?TWAZ4O5zBvvnejehVY1SqrNB9VeM1KuKFY9zdB6o7gTMJlo1UL9kZdijZDuP?=
 =?us-ascii?Q?qVJUaqdbmyIKxw4YP2eCqFyowqkG/yLxGXummnVH8cPgtKla105LMacjDqzO?=
 =?us-ascii?Q?pFKjhZ7sS5yvYD+CCgUwq5FmR0iZSC6S07oHLrkYNrN7ShXStbFXHQz+4j0L?=
 =?us-ascii?Q?VyCS2TNb9GKSDMWp4nRqcUmWiVm3g92vWZbyUexqHt1ga7fZX+YIW8dtLSrV?=
 =?us-ascii?Q?gd8ajW8MfxmPNmCvl1zMF/d7JabKGLVin9cx+o51B+7EYE6imgE3NsdSpXA+?=
 =?us-ascii?Q?7O+Tn+ndKew881zoyJmHhrGZq++5sTo6ZoVHTrRcp3gbo8VRDW6lLHW+uxoL?=
 =?us-ascii?Q?437dYmkFRUjbjRj6TD9UiAQEUURA+uD3QKg8rtPFl2cHuKbTcBqbBohjy60Y?=
 =?us-ascii?Q?EqtjaUHWMRVPZA4qL43ZTHEmXTKHAEgLvjx6XHx34i43FzdzmfiXLaAIMAEW?=
 =?us-ascii?Q?0ACWdTeaP8utfsJd7jyzaTdQS79XsECxNyD70dlt8lzLVUemTUIZCYws3vi2?=
 =?us-ascii?Q?kQ09BkJvMXr+hb4UKa43qS/4NSYK1lMnNayzzNe/0qUa3c+ZmVplUKcsMHCj?=
 =?us-ascii?Q?03/4ayIfGFy8/LvCTKFFqpHwpXdDiiJuy1oTyD07mX7hqbC0TH2aXm7181Tl?=
 =?us-ascii?Q?aZ1MaKEHaewu1BwOUQfeS2YMlveuYDGhNpnh7NbsBspp+JieEZ63pJiTUC5f?=
 =?us-ascii?Q?ARS94FQlbpNpozNKqpO9UUhKcAuOV0d6bYMm7OsoUR5WxNBYRQUJ+UU0Ejvw?=
 =?us-ascii?Q?YEgbw4l4vQE9FZU2TR5nLwQiPrv5ckJQ5vkHIZhBXnx49hN+J1PUfl3gCU1R?=
 =?us-ascii?Q?Iy3rz4FJIs40UkrPrt8+bqYre+FsPimAIUWyxM/A2P17RB6/YlltHcmPcGQ8?=
 =?us-ascii?Q?/Hhppe3CQKQGwT72zdP7OjyEq4w78eDqeEHlOkqwres48vaxdaf9K/2IGbpm?=
 =?us-ascii?Q?lKM2XnO/grdNwu94J/AIRnxE+5++6VB4BU5SYc0H5laS04MATq8HQpkZCvJS?=
 =?us-ascii?Q?iDRGDUkONsN8rC3jRqKpVLt2TajE0DFLF/0jcxkLSTH4lyROJwTHw3bc4x/l?=
 =?us-ascii?Q?IfuiQUAV4+zuQ5cgjwjtkAcA/tOtOrm5z7oGB+p8RaL9xLkStLTiElzubAMQ?=
 =?us-ascii?Q?N569KX2irRSDhkC/rPhW/o0hJ4Th440nmJiY5rDY98tOHwBmPPyEzfgN3xk/?=
 =?us-ascii?Q?DjnwM5r9FiitjuuMG7KrVEGO/l/gQACfetqwO9R+EnTWAHrgmkNNZ42aUoOS?=
 =?us-ascii?Q?y5VNAyea53Lgm/1YQnhept9lK4luPWejjATJbO6S2Ywmx1HM6miXy689R2zd?=
 =?us-ascii?Q?v8OLEdTDEnvakOuZPEsebOlT9sM+8cNH38IL9uXa4HOoWVNSLBMMl9qNVufu?=
 =?us-ascii?Q?t6MmefjNKkEEAybSG6vVhJi4Z9jhr5LF4LO1JZ+rhsgbb8GWunlTRWO07q/Y?=
 =?us-ascii?Q?VnmHYU05NFga/kX/9gY+ohAj6rkOGde2w1J9gbQFu53oVkrSgJNvUAE+dGEB?=
 =?us-ascii?Q?gY/n46/MwL4nwhuj0HXhUw+4a/CecXU0nsY02Xv62JxUzpDhOArx?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33d0058a-dae0-4027-b6b7-08ded67c2502
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 07:49:41.9769
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EgyR7GEfOXiZJPQ6wNYjHrBvEdWbi6d0JoCr2taJXwkL/mg+4XBYQTXcad0F2gXe/PO022sahKPOlQc8yVUg5rP7oV2WNI3xH0yLn81t8y4lRFJavWNCtvwsXev5znrt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9918
X-Rspamd-Action: no action
X-Spamd-Result: default: False [3.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303025-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[wei.fang@oss.nxp.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:claudiu.manoil@nxp.com,m:vladimir.oltean@nxp.com,m:xiaoning.wang@nxp.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux@armlinux.org.uk,m:wei.fang@nxp.com,m:chleroy@kernel.org,m:imx@lists.linux.dev,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linuxppc-dev@lists.ozlabs.org,m:linux-arm-kernel@lists.infradead.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@oss.nxp.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.nxp.com:mid,oss.nxp.com:from_mime,nxp.com:email,NXP1.onmicrosoft.com:dkim,vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A78616E1682

From: Wei Fang <wei.fang@nxp.com>

The PSIPVMR in ENETC v4 has the same bit layout and functionality as the
PSIPVMR register in ENETC v1: bit n (n <= 15) controls VLAN promiscuous
mode for SI n. The only difference between the two hardware generations
is the register address offset.

Since the register functionality is identical, the VLAN promiscuous mode
setting code can be shared between ENETC v1 and v4 drivers.

Move enetc_set_si_vlan_promisc() from enetc_pf.c to enetc_pf_common.c
and export it so that it can be shared between the two drivers. Add a
revision check using is_enetc_rev1() to select the correct register
offset (ENETC_PSIPVMR for v1 and ENETC4_PSIPVMR for v4) while keeping
the same logic.

Remove the v4-specific enetc4_pf_set_si_vlan_promisc() from enetc4_pf.c
and replace its call site with the new common enetc_set_si_vlan_promisc()
to eliminate code duplication.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 .../net/ethernet/freescale/enetc/enetc4_pf.c  | 15 +------------
 .../net/ethernet/freescale/enetc/enetc_pf.c   | 16 --------------
 .../freescale/enetc/enetc_pf_common.c         | 22 +++++++++++++++++++
 .../freescale/enetc/enetc_pf_common.h         |  1 +
 4 files changed, 24 insertions(+), 30 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
index 43883b55974a..52f84b5b838e 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
@@ -298,18 +298,6 @@ static void enetc4_allocate_si_rings(struct enetc_pf *pf)
 	enetc4_default_rings_allocation(pf);
 }
 
-static void enetc4_pf_set_si_vlan_promisc(struct enetc_hw *hw, int si, bool en)
-{
-	u32 val = enetc_port_rd(hw, ENETC4_PSIPVMR);
-
-	if (en)
-		val |= BIT(si);
-	else
-		val &= ~BIT(si);
-
-	enetc_port_wr(hw, ENETC4_PSIPVMR, val);
-}
-
 /* Allocate the number of MSI-X vectors for per SI. */
 static void enetc4_set_si_msix_num(struct enetc_pf *pf)
 {
@@ -517,12 +505,11 @@ static int enetc4_pf_set_features(struct net_device *ndev,
 {
 	netdev_features_t changed = ndev->features ^ features;
 	struct enetc_ndev_priv *priv = netdev_priv(ndev);
-	struct enetc_hw *hw = &priv->si->hw;
 
 	if (changed & NETIF_F_HW_VLAN_CTAG_FILTER) {
 		bool promisc_en = !(features & NETIF_F_HW_VLAN_CTAG_FILTER);
 
-		enetc4_pf_set_si_vlan_promisc(hw, 0, promisc_en);
+		enetc_set_si_vlan_promisc(priv->si, 0, promisc_en);
 	}
 
 	if (changed & NETIF_F_LOOPBACK)
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.c b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
index 096ccb35508c..ac282d17c0d3 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
@@ -42,22 +42,6 @@ static void enetc_pf_destroy_pcs(struct phylink_pcs *pcs)
 	lynx_pcs_destroy(pcs);
 }
 
-static void enetc_set_si_vlan_promisc(struct enetc_si *si, int si_id,
-				      bool promisc)
-{
-	struct enetc_hw *hw = &si->hw;
-	u32 val;
-
-	val = enetc_port_rd(hw, ENETC_PSIPVMR);
-
-	if (promisc)
-		val |= PSIPVMR_SI_VLAN_P(si_id);
-	else
-		val &= ~PSIPVMR_SI_VLAN_P(si_id);
-
-	enetc_port_wr(hw, ENETC_PSIPVMR, val);
-}
-
 static void enetc_set_isol_vlan(struct enetc_hw *hw, int si, u16 vlan, u8 qos)
 {
 	u32 val = 0;
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
index adf79a99a8c8..cbcf43bac826 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
@@ -171,6 +171,28 @@ void enetc_set_si_mc_hash_filter(struct enetc_si *si, int si_id, u64 hash)
 }
 EXPORT_SYMBOL_GPL(enetc_set_si_mc_hash_filter);
 
+void enetc_set_si_vlan_promisc(struct enetc_si *si, int si_id, bool promisc)
+{
+	struct enetc_hw *hw = &si->hw;
+	int psipvmr_off;
+	u32 val;
+
+	if (is_enetc_rev1(si))
+		psipvmr_off = ENETC_PSIPVMR;
+	else
+		psipvmr_off = ENETC4_PSIPVMR;
+
+	val = enetc_port_rd(hw, psipvmr_off);
+
+	if (promisc)
+		val |= PSIPVMR_SI_VLAN_P(si_id);
+	else
+		val &= ~PSIPVMR_SI_VLAN_P(si_id);
+
+	enetc_port_wr(hw, psipvmr_off, val);
+}
+EXPORT_SYMBOL_GPL(enetc_set_si_vlan_promisc);
+
 void enetc_pf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
 			   const struct net_device_ops *ndev_ops)
 {
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h
index bf9029b0a017..8243ce0de57f 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h
@@ -21,6 +21,7 @@ void enetc_set_si_uc_promisc(struct enetc_si *si, int si_id, bool promisc);
 void enetc_set_si_mc_promisc(struct enetc_si *si, int si_id, bool promisc);
 void enetc_set_si_uc_hash_filter(struct enetc_si *si, int si_id, u64 hash);
 void enetc_set_si_mc_hash_filter(struct enetc_si *si, int si_id, u64 hash);
+void enetc_set_si_vlan_promisc(struct enetc_si *si, int si_id, bool promisc);
 
 static inline u16 enetc_get_ip_revision(struct enetc_hw *hw)
 {
-- 
2.34.1


