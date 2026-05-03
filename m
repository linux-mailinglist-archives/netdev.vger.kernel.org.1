Return-Path: <netdev+bounces-283684-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MABpEfnB92mZlwIAu9opvQ
	(envelope-from <netdev+bounces-283684-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 23:45:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 985774B7922
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 23:45:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 10D69300BCAE
	for <lists+netdev@lfdr.de>; Sun,  3 May 2026 21:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E2ED3A9D84;
	Sun,  3 May 2026 21:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ericsson.com header.i=@ericsson.com header.b="Wbno27KC"
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011033.outbound.protection.outlook.com [40.107.130.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3CF2236E0;
	Sun,  3 May 2026 21:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777844723; cv=fail; b=oUtFkBLFcI8d57iDriWCIp9vHl9kR6jLtka9ZmE5Ua+o+4MuBgmTCW1EG6rcUU1ja+9R2K0VNrfAjuHnN7Wuhp+ysOJPyC7oB0WREd4R+9UgMk8MvyF4J3i/s65Ulpg41SzRkJBOxEe4N1Iw7lDhf9MEqbWtRrxRL3CwLpsvZBk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777844723; c=relaxed/simple;
	bh=tbiqzNcL/8G6Gt91N2TiKB9PYjuCYKL8/UC7Zf111+Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=teS7nVeuCARThf+erxLSPLMWFwqhpyCPzEnXAGp2vxFRAzmzvlT74Nnpw3VsOouyNOk4EBvwpfW/Ukq4+wV3MN6ySKD4FeceNpCEJnFyISlLEpAF4uXpYz1XUYdbcxLyMDfukOTCseEoE8mhvP+dEkRUvNC/UDLdIQ47izXUHyw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ericsson.com; spf=pass smtp.mailfrom=ericsson.com; dkim=pass (2048-bit key) header.d=ericsson.com header.i=@ericsson.com header.b=Wbno27KC; arc=fail smtp.client-ip=40.107.130.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ericsson.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ericsson.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oVyAZ55bapcOB/MoHIm1sVixRaBUsHWK+SPWLNK7XkVrqsz66KFdxENBLe/a8PPrWhg6lCQOl+stv15+bhXlmaqdpOsF5Y+ea/laWh0ub5t1skqT5bk/VM7Fkrdw1rM33qqsP+Y/BQe9eK5Ap4kKg9MJh8b7csiE6OUneM9BOi6j1nApBHj+aS9LLbuwc/41COozFDmtSUnvlh8fagH3lwu8iEUG/JGzbAvU9ajr0ZUnw+CYkqyAw2+iV7LafwEk/4GSmC+4tyv8kiRqU2thd0hYqVq4CAoMytQ3m+GfLp/ih0rmLNXiquJItKPKKrh6HmtsznNbzsYLEADRTg3OOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EFn9RzocGDRd+kPxcx6xt/XKnaKqjlfsD66nxlbRwEQ=;
 b=L9ehT9GmypZl0crC2IJbagc+VMO2ZIAXGDMMhF7WiHEJi/cZWifldHUbz72b0GXJWXgQbqE+cR4irAyUEm+c5ezHD0Rops/TLoCl2ozHGRiInxzTSaOcgPdPF5LJTnOU8ViS1Mv62N6UZcCp8tucMMkXljkjmkHUlrKrRN7BXlSAcCkGDWhSjAZqjc3azFI6eREgu48qHTtQ4GcoxzfbhK28yhYZ4CnUbkPpDzTqkZWHN94Jvlxqukr2pSkl6dUw/ymiHNriA2pgL8NyCztJWYRJwf0B8EFmY16lHzqNFWo/YSIv9YU05nUiAZ1ACm2Oynu/L12fWgLO3qS5i6D3qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=davemloft.net smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EFn9RzocGDRd+kPxcx6xt/XKnaKqjlfsD66nxlbRwEQ=;
 b=Wbno27KCFZWzPHacXn7frR/+FEv3IS7DAEH/nVKxLhG5tl01BaHN0s2+/GQ9MqiJTzqld3AImu44xQEcSmmllHtJ+hptyAOEp3K9/UiKrE0v9+XflHxbnTxn7ZaLrevSualpdjYN+JVMNFRzIq0fdbG7xp4eBwFTyWNmZGeZJ7a2X9HrVgv7ifQWMWhgF0iH4IB9jt4kGg2RMoJX1GubtqvTKTCuF63tsnO9VEzCg2XUXOL53uLrUwxsq1t83hHoJKqcBq9TthROCuGJcwmCudskqOwda9f7koDfI9o0FMtaboUrAvxfgKDpWxL8AJBvClvcBuazVSv0S76WaWPjQw==
Received: from CWLP265CA0329.GBRP265.PROD.OUTLOOK.COM (2603:10a6:401:57::29)
 by GV2PR07MB11750.eurprd07.prod.outlook.com (2603:10a6:150:2fd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Sun, 3 May
 2026 21:45:16 +0000
Received: from AMS0EPF0000019F.eurprd05.prod.outlook.com
 (2603:10a6:401:57:cafe::a9) by CWLP265CA0329.outlook.office365.com
 (2603:10a6:401:57::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.25 via Frontend Transport; Sun,
 3 May 2026 21:45:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.176.1.74)
 smtp.mailfrom=ericsson.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ericsson.com;
Received-SPF: Pass (protection.outlook.com: domain of ericsson.com designates
 192.176.1.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.176.1.74; helo=oa.msg.ericsson.com; pr=C
Received: from oa.msg.ericsson.com (192.176.1.74) by
 AMS0EPF0000019F.mail.protection.outlook.com (10.167.16.251) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Sun, 3 May 2026 21:45:15 +0000
Received: from seroius18814.sero.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Sun, 3 May 2026 23:45:14 +0200
Received: from seroius06448.sero.gic.ericsson.se (seroius06448.sero.gic.ericsson.se [10.117.92.228])
	by seroius18814.sero.gic.ericsson.se (Postfix) with ESMTP id EFE8C4025E84;
	Sun,  3 May 2026 23:45:09 +0200 (CEST)
Received: by seroius06448.sero.gic.ericsson.se (Postfix, from userid 7434092)
	id 7CF1A1005C88; Sun,  3 May 2026 23:45:09 +0200 (CEST)
From: Fidan Aliyeva <fidan.aliyeva.ext@ericsson.com>
To: <andrew@lunn.ch>
CC: <olteanv@gmail.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <thomas.eckerman.ext@ericsson.com>,
	<fidan.aliyeva.ext@ericsson.com>
Subject: Re: Re: [PATCH net-next v2 1/2] mv88e6xxx: Refactor 6352's serdes functions
Date: Sun, 3 May 2026 23:45:01 +0200
Message-ID: <20260503214501.3547612-1-fidan.aliyeva.ext@ericsson.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <beb7aba4-d704-4112-a29d-0382c31e0c2f@lunn.ch>
References: <beb7aba4-d704-4112-a29d-0382c31e0c2f@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF0000019F:EE_|GV2PR07MB11750:EE_
X-MS-Office365-Filtering-Correlation-Id: 22d6bfe6-49f0-49e4-f5d7-08dea95d430a
X-SMTP-Server: smtp-central.internal.ericsson.com
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	UIU15p9XZzUBzvgyXF2jER7qNOdigg1at8IETlxBLXta3CdZi8T9Ub11llUtnCWN8YV5aGJJ7/Ar8iriAl52StOJaEtdEBMXW/6aN7UEtA3zAoim9aI2QVWQmoQRGvHn+3QajNVVbD8tLAU84Vis5kDtt1T/rJrDP8X/Lo8H6xv6GT6tFFrWEfw2hfss9ow4/hdI5FJ3QuwIHYu5/PQMo0En4is0K9kTmZqktRh9ITKHi47bBXVGIxxSxxt4ckVK5SaWt6zwk2vcpKm7w1e7bSAXOriqfi+0tpoQqcM4FeqifhUL3XQ8wv/PyHGyDsBoBU/Potf9e1gSw5XUtxQwbJPJ2PK/vQM5DVdYdvAjNt7v8xJQG+cV05V60QQX/zVaJV6w2JrWjQAqevT5qBPjxm/b1hF+e65TSLi+7RoHuPEaBK/f5ZSF3fd/sOvS3kOcmI0ETbK4LeKueNKi8YKb/6JyuscnQo8Pg4iupkFqCyhvtRupDFr9H7j4C75mwMRM29VVF9EMbCynKu1gbXo8d/rH/6x5hPOevA8+w9uYfnzChnQ2ubD+s0+zi6ZivgypVe1+B5V2GHKrth55F5NmX6/rBVdeeUaRXS4dK5R9N8lCYH5u48Y7ByW/hijlVAVDo6zOEF619hR6AN+zt1G6TdGJqJzBuislf+aDTFPJwAq3dHgSpir3EXObR335id74iGEzy0m5//19EcEY1dl3TqN8T/4tYxHuktqf2nReB6A=
X-Forefront-Antispam-Report:
	CIP:192.176.1.74;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:oa.msg.ericsson.com;PTR:office365.se.ericsson.net;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	DJCidUOnZw6MUchTijWQ8ofm34R4c590nSuKbPAtzm9eB4HZNk798XOJXwWN+qtNn8hdtKAXXAJal9sB11SvS2rI1v7GPNUYMlQLskXaTihWEe9bqxUHJ6t9VGC4Fw691HkHJKIYntlpbQoWR4+9JxnGJXTs4CF5FB6tVE/FsA3HquZW1YyblfzwhheDx8Mz6TC+ACYH10+vTuHQMZyiXtzj7u3MCj18vTDm4KSknf09YEh7R2gnisyYEi+zlLTQO7A1oKpSB8KVPh2X8985+KqDg1ilbdU8N3cBqT9Z1Ic1NBir6QO1R+jryzylgQ734hsYKRhPttvsBxQwYzXSAvg3T9Y2tRUJiw7oPHCAtMOiQADhh2haIf8H2qtIdWLlyplgfTPRj4EzESBEDMzH/2o7V2Eh9dgpHsC2a6TIrZCkAAAPc6acRqQb+IbaUtkh
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2026 21:45:15.4412
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22d6bfe6-49f0-49e4-f5d7-08dea95d430a
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f;Ip=[192.176.1.74];Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF0000019F.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR07MB11750
X-Rspamd-Queue-Id: 985774B7922
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ericsson.com,reject];
	R_DKIM_ALLOW(-0.20)[ericsson.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_SEVEN(0.00)[9];
	FROM_NEQ_ENVFROM(0.00)[fidan.aliyeva.ext@ericsson.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,ericsson.com];
	TAGGED_FROM(0.00)[bounces-283684-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[ericsson.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ericsson.com:dkim,ericsson.com:mid]

> > > > I wanted to make those functions generic and not introduce new 
> > > > functions other than 6321_serdes_get_lane. However, those 
> > > > functions cannot be generalised the obvious way because they run 
> > > > with reg_lock already taken which would cause deadlock in mv88e6352_serdes_get_lane function.
> > >
> > > Ah, the scratch register. None of the other serdes_get_lane() functions need to read a register. O.K.
> > >
> > > So we don't expect the scratch register to change at runtime do we?
> > >
> > > Nope, the value in it is read during reset. After that, it does not matter what happens to the pin, the value in the scratch register is fixed. So maybe read it during mv88e6xxx_setup_port() and store the value in struct mv88e6xxx_port?
> >
> > Hi again. Thank you for your feedback. I can make the proposed change. 
> > But I do not have the functional specification for 6352 to refer the 
> > change to, neither do I have access to a 6352 to be able to test the change on.
> > Do you have the functional specification document of the switch, maybe?
>
> I have a 6352 board i can test with. It does not have any fibre ports, but i can test it does not deadlock, or give an error message about the lock not being held.

That is kind of you. We appreciate your help, thank you!

We will prepare the patch and send it for RFC.

Best,
Fidan


