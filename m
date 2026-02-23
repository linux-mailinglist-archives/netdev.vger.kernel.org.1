Return-Path: <netdev+bounces-259932-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8CX8AQICnGn6+wMAu9opvQ
	(envelope-from <netdev+bounces-259932-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 08:30:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A81AD172AD9
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 08:30:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 84CD0300B59A
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 07:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 549E534B68F;
	Mon, 23 Feb 2026 07:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gehealthcare.com header.i=@gehealthcare.com header.b="nHZ55Wps"
X-Original-To: netdev@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010038.outbound.protection.outlook.com [52.101.193.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF17634AAEA;
	Mon, 23 Feb 2026 07:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771831807; cv=fail; b=NYQhYfNLi6c3af8GVv640hjbQ0h6HDvCwHek0dDy5blcEQaVQm3ndss7DyyifBnCAkFdIXdJst/y8ve2gPrcnReWCLwuHG/bPdIwzmiIook/P1S966Csd1jksOVueWnrXsCFXz5rLpsaXpkgHln/K0r7af+Xbh8Rs0ExfNFpC4g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771831807; c=relaxed/simple;
	bh=vBvhRYKu7JDRcEmpymZ9cB6Xlxw9o6Wu3NRpvr6OFRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uatiH3xy4kgsOnTSOTt8d9oVNHcMsxtVHjht3cKdtSubEkZp4Iz9pDpyfpArYO59EY4uEpTqOXF5AwpPsYkrZeuDh8CrcEpAxiN8sj7xQpWk6o7jqfrmh1NibNkVFLpibXQIMr2NdMZTfKHj9kfFBBVMtbAqjZgBeP6GR5oqAwo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gehealthcare.com; spf=pass smtp.mailfrom=gehealthcare.com; dkim=pass (2048-bit key) header.d=gehealthcare.com header.i=@gehealthcare.com header.b=nHZ55Wps; arc=fail smtp.client-ip=52.101.193.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gehealthcare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gehealthcare.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qMV8zy73sKgWJOylUx3ROqRjwYevx/JTzXHbAYhf576fg3Be09pn4vuVaTcI4OHLYnkfWE+ALKFblz9g3o/mVlHcRTvZq1LL1gmzDt4fn8N/M8ENNMgNOuR+aTdRg5ZSOliFHWyF2wuZKDOn3nn5zCOOjlqjYlCx/VpeZW8B8uqmrkmIoD/HiDwJ3zf10/nj4yldauWoBqJ6r6RLTHAiTdz8/SyTemV2gyToCzLqRRzti91BTx9SrzSd8NMc8E5ZCoONB7jC6W7m+Rue5grYzdpqolP185ddO5uh8Gb0MYVUxyu3LNvNetU2BftZa7wy46IFw9r4aY4yB/sgPGXiRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rHk8mNYoR5jEscpOqQAXhjlgcqSps3pVyv1mGKC8ycI=;
 b=SlOKfcoOVRIMZjKjJ3dI+fhxUGUYJapOn6pic6jDWt68+YBE1+DEFQGgop5u1C0vP/jUYpNMa0cxG0jDqQ1QlrSnb8kKPmtJjtvG2J7VsHze/KLRLdMcFdMid2+hQGsRN45zofJgRzovDNlp4VqliCQJNcWAYiKsph2iDxRPo1+NpgLJpUiknBBR433DTdqoUMTfIjzsoKN5Fqdyydb5daBSWkd5k9QBoNxvXmgw6+SWijJEW0rq2PkV0M1p/Zl2D3VNhgqzXkYMT1IPE47J7a7k9hpMLMTw8yljzgw/s2fqkrMrmfAOdUKLLeTFUqsbM+qxVwqo568zZwsypVE4SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 165.85.157.49) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=gehealthcare.com; dmarc=fail (p=quarantine sp=quarantine
 pct=100) action=quarantine header.from=gehealthcare.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gehealthcare.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rHk8mNYoR5jEscpOqQAXhjlgcqSps3pVyv1mGKC8ycI=;
 b=nHZ55WpsnviSOxBahCrIcAGwPBWbwA8U9RFQsvICR6sWAUgcdeQAUb0S/SxpU9FPNHhk9nzFboTLCx3yYBImDtb/qQwn/qamcJjiqqKQ2Ru3Si+b6VHOHIMwSJ7TZtSX+PMK4nqz8eNqEGU56XTWjr0dgCRyzYN0HCQ35PEKoybpuDoqTdnV63Ze8pbrsKSf1/5wgVGvlUuxIFEiGkFos05X3FafWYJ435Cvpc9KLwZqpcKQyK6/fFMUB5SmiSTnMEWb5Ff6hGqEL+KZ8+wHySFAk7FaPY8uMLVTGDaqrsgyZBuM1n1dFaBO+w5w9C9wtPqJ1AbuLSHoVp44AX/B/A==
Received: from CH2PR07CA0002.namprd07.prod.outlook.com (2603:10b6:610:20::15)
 by SJ4PPFA8BF17EA6.namprd22.prod.outlook.com (2603:10b6:a0f:fc02::fc3) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.14; Mon, 23 Feb
 2026 07:30:03 +0000
Received: from CH3PEPF00000016.namprd21.prod.outlook.com
 (2603:10b6:610:20:cafe::a0) by CH2PR07CA0002.outlook.office365.com
 (2603:10b6:610:20::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21 via Frontend
 Transport; Mon, 23 Feb 2026 07:30:04 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 165.85.157.49)
 smtp.mailfrom=gehealthcare.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=gehealthcare.com;
Received-SPF: Fail (protection.outlook.com: domain of gehealthcare.com does
 not designate 165.85.157.49 as permitted sender)
 receiver=protection.outlook.com; client-ip=165.85.157.49;
 helo=mkerelay2.compute.ge-healthcare.net;
Received: from mkerelay2.compute.ge-healthcare.net (165.85.157.49) by
 CH3PEPF00000016.mail.protection.outlook.com (10.167.244.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.0 via Frontend Transport; Mon, 23 Feb 2026 07:30:02 +0000
Received: from zeus (zoo13.fihel.lab.ge-healthcare.net [10.168.174.111])
	by builder1.fihel.lab.ge-healthcare.net (Postfix) with SMTP id D0D0AFB3EB;
	Mon, 23 Feb 2026 09:29:59 +0200 (EET)
Date: Mon, 23 Feb 2026 09:29:59 +0200
From: Ian Ray <ian.ray@gehealthcare.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Jeremy Cline <jeremy@jcline.org>,
	Ryosuke Yasuoka <ryasuoka@redhat.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Ian Ray <ian.ray@gehealthcare.com>
Subject: Re: [PATCH] nfc: nci: Fix zero-length proprietary OIDs
Message-ID: <aZwB98JRGrv_uz9k@zeus>
References: <20260220112536.100017-1-ian.ray@gehealthcare.com>
 <20260220133601.53b3b7fe@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260220133601.53b3b7fe@kernel.org>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000016:EE_|SJ4PPFA8BF17EA6:EE_
X-MS-Office365-Filtering-Correlation-Id: 5dd05082-88b5-4ff9-d5e4-08de72ad5ba9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gj5WOSc/SuPLjcW3j8nss2pHht/zdMqkLGTOZNv4C4rcQ+Y8mgIskVKloGMw?=
 =?us-ascii?Q?gAPdAgayij92hYdnUsqtDBGhxDOG709KhsYS0SQM9RL8OIOHoFrT5g7mUZzL?=
 =?us-ascii?Q?a2ep2IyTKNzFnjABGZoF+/Nr8DXOS1IY6vBajjsT1A6hg6yo96k1huV3PeyH?=
 =?us-ascii?Q?0u5C/KJyTc5JN+RQBEXf2x/BX3dsOokdX8iboB6sOcCcEB79BDVR7R2GmKY8?=
 =?us-ascii?Q?WlcMGyZLxRSPKh29LAEB7vh5DyPwg+JdfKEFHbMmKFm7oUmIyfi7LAR+Hnys?=
 =?us-ascii?Q?dzcZrTGa3CmpMMPq6UdKqpPaDvhm+SiC/i5gv/8bXfS7VXmOEGoE11vl5lMc?=
 =?us-ascii?Q?6gHk1dowULOUs+Pen65SHfpRtU8wpCLQU+VqbqtxcrNpjhcUpa4Y/55XIJdF?=
 =?us-ascii?Q?VI/f81V//0OnNWClFYKNEOPAeHNiA0gFYnEr2L+Phh4ke3cFUMPLD4iCW8JA?=
 =?us-ascii?Q?FqctazRGCdfK/frDCKbrknAfgU5NJteXyHv2SKZ9odCtwe4w8Kw7mv0ILClL?=
 =?us-ascii?Q?imRr2lOj+ObDNxsVkuSeOd4Zy8pbU7YKJ7uiz8yxJI6UgtkDkJeWE/FhGxO7?=
 =?us-ascii?Q?s1zFVagZ7zcZ0nMe73B/ec95sf8YKyY8QVcvAnVNya+z/SR4T8Rbe+9573/S?=
 =?us-ascii?Q?RYwSj/mn7oCHAEvHuQ12yOjlt8CF7HXSALGRbxqjtTCaX7cdc1EG69MmSkI0?=
 =?us-ascii?Q?U2tC9Wc505vrQqnsbzTgLM4V9I1+E0Z6c6a6HYFnl+gsH84Yf4z2UmkqWpCD?=
 =?us-ascii?Q?4sWXdferOESWmvIrtkouJhJrXeG/Uhg4weUhj6WkH5tDYlWU0/CLmx68cflB?=
 =?us-ascii?Q?VbsMj9Mx3CJrKxrNVSsM8YDzn/9RzaopMf5mt9drX2KkU5Hc5dJ9IsGSAtrn?=
 =?us-ascii?Q?7vGeq4mFjkAj9Y7jHxOII4nCKY41Xyzr0cSSX0S/258iFXgpBxQT/pLWTtv9?=
 =?us-ascii?Q?iS2B2fA5arYcempba32cq4+/sQitRVrIgHps11m0YdVgtillJDFugXuk/boG?=
 =?us-ascii?Q?ZP98QaQWLvx3dsFQgKJrtVeFdqrHg3uxRa6TswMZVRjh2eZZ/sooA5lzv4zt?=
 =?us-ascii?Q?jNPdBayH5lBTQy5qeubsL7A0MF5tZio0Ds5B++7bl9AQZGt9Pv5DlHx270e/?=
 =?us-ascii?Q?40OWjBRXLaNzJO02pDvTAg1cPl0rscP9h6ZpaFWbCMUCfSl2Hh+viM1z0ya+?=
 =?us-ascii?Q?CUAdbyl9kPuhfRfRgmeBuTZYQjrpHl8FSz39cPIYHVdfAXIdFBMyjKgz/lwZ?=
 =?us-ascii?Q?h8w31LbAtCBW9BoZ2bciGQ/2/Z6bzqY+yIDhrA8p6OmyeZQe5ZLwwGiUq5el?=
 =?us-ascii?Q?VlVZ78MkjwDE3mz/t8q6f7DyJID0coY/tz22CAA7f5VzY8dy0sTanbA9gkMO?=
 =?us-ascii?Q?mBYMrNbLmwHA0taCreGHQC/15S7f0ysKkzkfSVIPQV6eg9eZrzyknnQjBoOf?=
 =?us-ascii?Q?cq+0LUQlSkKz7PPXJjINIE+1iTqa81WX8iNjs/qCZ1Px5LYz14ZbhuLJa5ZH?=
 =?us-ascii?Q?DbdY0VByoUQVBWAPilEdL1imevNQJ+z1Fprb4e+ZJE5M27/AnoxdW4YvT5Zp?=
 =?us-ascii?Q?YB5iErGjmryDuaygDBN2Qfd6shxQckihm3d9Rds4H3ms8C10NDuZHM+55xfh?=
 =?us-ascii?Q?0S/eb7esD5Ki4yx52xS/ANANZwfxURl6LKrHL4bxR991/wsmM2BrAxDiFVDY?=
 =?us-ascii?Q?GULQVw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.85.157.49;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mkerelay2.compute.ge-healthcare.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	j9RbOaFW8i7oJlca4G8IoWaAHMAIIyLZe+lVjYMIlMViG/QeN8kvOPEL2lIIkuDE7Y6mzJaerjPCgfzxI2CCrbRqPkl26WLqB7zjwnsHgCOOuVsT/E192SESo8ErD6StwCaQzFz2WBjd1KIhVBjQMnkrAI6o/W/LcQ8N114vQM2udSX3JMiCalgPfEcm7diPh+qrKZkbwwjAhqC6lqY7Mjwmmt7SB7vhEGxgjKfUi+sHMQ/nkmauQRQqS7oY2NRcxrwyNKmVJAmOEPPLYWE5GQ8y69LukMBhMYrr1dzoGEF99WCS2q0GNt3prbukfL0sVPRxlwVudD5Zb27RieTMGn3hnY0/ZDIExR98XC7f0HKUICmsYGxIyavwA9I6l9mfyk/wUml7qOe3S6g+ORO9vElF/OYCbWNdM7k3LPcBDHZsvGz9N0Ef5jy2wA5HcYXs
X-OriginatorOrg: gehealthcare.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2026 07:30:02.4424
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dd05082-88b5-4ff9-d5e4-08de72ad5ba9
X-MS-Exchange-CrossTenant-Id: 9a309606-d6ec-4188-a28a-298812b4bbbf
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=9a309606-d6ec-4188-a28a-298812b4bbbf;Ip=[165.85.157.49];Helo=[mkerelay2.compute.ge-healthcare.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-CH3PEPF00000016.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ4PPFA8BF17EA6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[gehealthcare.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gehealthcare.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259932-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,gehealthcare.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gehealthcare.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ian.ray@gehealthcare.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: A81AD172AD9
X-Rspamd-Action: no action

On Fri, Feb 20, 2026 at 01:36:01PM -0800, Jakub Kicinski wrote:
> On Fri, 20 Feb 2026 13:25:35 +0200 Ian Ray wrote:
> > Before:
> >
> > -- >8 --
> > kernel: nci: nci_recv_frame: len 3
> > -- >8 --
> >
> > After:
> >
> > -- >8 --
> > kernel: nci: nci_recv_frame: len 3
> > kernel: nci: nci_ntf_packet: NCI RX: MT=ntf, PBF=0, GID=0x1, OID=0x23, plen=0
> > kernel: nci: nci_ntf_packet: unknown ntf opcode 0x123
> > kernel: nfc nfc0: NFC: RF transmitter couldn't start. Bad power and/or configuration?
> > -- >8 --
> 
> FWIW the last message in "After" still doesn't sound particularly happy
> so it may be worth explaining why this makes the device usable ;)

The theory here is that we use +3.3V to power pn7160, but maybe the
evaluation kit requires a higher supply.  We will test and confirm this
before sending V2.

> If there's more that needs to be fixed for the device in question to
> work it'd be best to have all the necessary fixes in one series.
> 
> > [1] drivers/nfc/nxp-nci/core.c
> > [2] NXP_NCI_RF_TXLDO_ERROR_NTF
> 

Thanks,
Ian

