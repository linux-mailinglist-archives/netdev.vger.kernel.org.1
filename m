Return-Path: <netdev+bounces-284256-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eEgGNLSn+WnF+gIAu9opvQ
	(envelope-from <netdev+bounces-284256-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 10:17:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 743FF4C88BD
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 10:17:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D0BB330144C1
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 08:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E95A43EAC82;
	Tue,  5 May 2026 08:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UR8KAD6q"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011032.outbound.protection.outlook.com [40.93.194.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C033E928E
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 08:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777969074; cv=fail; b=k8NU7YKWdlDp0S8OrcobT+vL8zjKEd0jSyu4qf5UwqBIdRbyvu4nc2BTsUicH+D0HiRLSjEAKehE4M7Ia8E+BYMf98SCPhfNic7bnmpEbJ4lauSJDhDPaabuhxJA8A+tOud7SvUtUyVQIi5Bia3EnZW18b3vtK7W3NwwSmdsdF0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777969074; c=relaxed/simple;
	bh=Et/TfnunoUx9fWtMXSLbtSjm39AYJeiyX8vdV1sZxCs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fludl6++Oz0XLHU3QBgJLE0fMq5EHi7mL+ZJUuoVYiLdq0xwbFgO4UcZkrCRWpFHB7N+IRYDa1o3U0M/+g6eO8cyKDdSJL/XIRB4qL7cr3aQwGM2EdNWJOJiBFTk7EXlnxV2a3kIe3cjoyiBm9tNY/p1lXaLOvDjftV7WNCkkaI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UR8KAD6q; arc=fail smtp.client-ip=40.93.194.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bauNizCoTUB8fpbJSabVL+oAcUKkD9VAmKpgbHDhgn+ncFWJbbHOeAiXQivXo2zxVoAM9cQaHw91jA2u46LBeJXUvc7sdrg4g8ZyH35jwrvmBn/1XVMpqW+0jdzF9aQGJabMiLU8X6EQOgRDU35PG4ExbW2eyEkPMtYTRqrrY9ShAnXkxqzJyUq30IZU7GY8muVezopMckulpJli/ITcEMt1mm2fe7zTdYuBTmzr30T0XEJC7VOxnkU67GZEhvMasXv+97+Dyrxu4gQzojHkrDf8rKo1P4/eTMy9CSpg+YYFBzNaI6yFp53OD874t7h4pKj/pEBTaINGz8dbAk6vfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I0UoGNp7qBiEAcouNQvuK/CdICIZHDtAc5/12gXH5Pg=;
 b=MYbs22Xs7nengxga0s3XRjh/FvSG1oUB6aHSGXYGMuQzUj4iaRqhJ5lnk+np8ZWxK5eLnxVaulgF+ROG3NWsvihCHP556qOijWhuWarUbMkZgtvOkGe3Op9Q5jkErX1xsfbneNy8Ve1HzIfgrIcicVjp42Kr3oENaXj4GyuZlCH2hooMAllh4ZKQ4VTfTAc2bNM026ciFyuJR+7xb5UnFA+gxoBxiTcudPzBrvJlJvF+DWUTFDNSR0QNVQKvWwii9ordICkrYzLlQiIy1t/t9wJFrkn6Df9waQijpIfwryaBSNWny2xV9BmRaySlMcGlvekeooZ5KYZaC8fX+Eo0og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I0UoGNp7qBiEAcouNQvuK/CdICIZHDtAc5/12gXH5Pg=;
 b=UR8KAD6qbiPqSFp300Ot991BqBdJAAgqe2eBgkCnb5louH1cmOfSzev6SsuP87JzWghe0eLIypI2Knr0Js0t+FExX5O2ZeLnYRdycKpUs7E4OKkGmrqNjjkcQ3h/2oprmUBLLF0zM8CLltihWm5xNplWOK9RWE+6vtzKH16vjq62exf/++EN0L5EKhnu3djREZKoP7G+FinyPoOhtRZ5FDiVRtiI9v8ph90gAmPCoOC1ErYlgGczlJvVV0LlewtSRGbahMxs5rj00qyOMRFhP8yT36RdARlCu6bkVGEDKw28B39PFjmzPyvv0lPaEDdWqUUs0KIedDFnX5d6jCVoeQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by CY8PR12MB7564.namprd12.prod.outlook.com (2603:10b6:930:97::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.27; Tue, 5 May
 2026 08:17:50 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 08:17:49 +0000
From: Ido Schimmel <idosch@nvidia.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	horms@kernel.org,
	petrm@nvidia.com,
	Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next v2 2/3] net: Do not unconditionally turn on carrier when turning off protodown
Date: Tue,  5 May 2026 11:16:54 +0300
Message-ID: <20260505081656.463158-3-idosch@nvidia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260505081656.463158-1-idosch@nvidia.com>
References: <20260505081656.463158-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0166.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::13) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|CY8PR12MB7564:EE_
X-MS-Office365-Filtering-Correlation-Id: a43608e9-4992-4a80-1238-08deaa7ecbd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	PhNIsCwnF+YKj40OViRgS1NraoGnwWdYi2RfYSrZy8qsDJYj2YpeJ2c1cq/vH9/hG/V1ME2v8H9a8W6ZBD8Xn8owUrtu9F1T2Q+0+LGpzpHvngJ3/uDGEOtOmwgIRqYmdEI67l6c/rHo3Jbe1zW4PaBkFaGWY3vIJRUreTGmREafWeQSKLpQh9PzQxCO6A31XD+8wTMTR6V+MrC/JLwA3tVOlKQuLswANtiulOAZh/CpYGQx3zaofmS7p0Nnb7BcPHrZcHExhpdVFw2yidWKsq2yqjttEet/KVDuNWFQWYrBRSoYMSnntOGUpl5aQtikOuyKeWY27N8R0WZKWPDZzf8f5+PxQ01xXvkbKgTNDG7frENGjBrVtoxOi1979DbfTBEO6NVZP1HpHPKDv8swyzlkTMcHcr++NS3LP2H8ivoX9M2TkfLkzJxFsL8gtxGiYJQnD9SCtMgUjHSzq+Lx5nW3IgNa/z+rrsi3wfM/fYa+EUYEaJEBbxct8A9Om25XCEO9SzuKKlALsj/YRugfmbVSC05BXWxZaXb38HRunwdttW79NZnnCCtWZGVJB3QpzWJyT/nPIKzGEhbdyTiEyoPVJapT4vm/bEfhHVcJU5oXTeyCJwTfL8HCgA2OaxjTXHXJ9tc7UQZgBwNUrAeDJoKJXVv5922xZ0oB5H3MVY4DrVhbsb/MNVPyHsydSCu0
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gKG/e0nqLAbpEPQv7clxfrR1PnNqAMr7XXXAVLFI2ZWFzpUOyjzKVT/3LbmJ?=
 =?us-ascii?Q?o8ka13eyyfSo6EPcvIlhTlowmaC2Zh6jXhA3CGl/EzOK7ji1kIHgLTCnhQ+O?=
 =?us-ascii?Q?QzRg450I4sGWLW9bNAlQq/Ae6xfcGX6qHZ3MNNy/BpeFjLNJrvLWAvM9sqwL?=
 =?us-ascii?Q?06KckOp+1AHNvy/TkHDcNxZOJD2YmMUb2SifLmfYzfCj0kvjHMXSfSC/4Eer?=
 =?us-ascii?Q?asWO75YYXKl/f19QHCOMHU1hEszjwa7BCqmXO0JK2SmWrZ4eRMAOmoY3YLQv?=
 =?us-ascii?Q?Sz03I+e0HyAuUzQWNfRC7Own9ys9X2uLZNfDaPXCY9YK5bF8KUQ3qhQBTttW?=
 =?us-ascii?Q?D31UL/L7ODfLTTA85dcbByiRn4gs48SguHwhvFdyfvbFoO3jZE/4EFJyEaTk?=
 =?us-ascii?Q?5GMflcqa5ryLkZm0J0mLsLeyfcBUfBJcUbBEz9xdHM5+SpA+DRoYk6Lh7wDa?=
 =?us-ascii?Q?zUx0CVkUVeVYD4q0EOhnsCw7sqBus4o+NS3eBjTEZ0X4ytZsDtnX2xl50HRr?=
 =?us-ascii?Q?dvqHg60P11PCG0GDC2hJTTC9a8rnEkjq8ZUNdfo1bLJGyeeaKr2wwkdtpj8a?=
 =?us-ascii?Q?P+SvA4z6DHp603sxUfWB+/jlBoyPXzBgjaeZb0je/UCJmW3EGxUv4ixYcxi3?=
 =?us-ascii?Q?GCQPc6QRCEjovLU2OQnEp6Btcv2TKN9JGGJ9Mc/Tk0yWWdRc9frjsq3+Ecus?=
 =?us-ascii?Q?Cm61FD0dlt82SaIuZxkuCLpu4iWGuoO01z5gAQ3+QJ/I7Ps/umk0qOXKL0WO?=
 =?us-ascii?Q?derH8r4lUvr382NRJZkiFuYLPiOIRJpS3+rtH84+GRUpkT36bUGp56Mas1c0?=
 =?us-ascii?Q?z5YJGPiBaxmK8VfHVDjqUtsNNhzUMIBLRv/YbW5xQjIJK0HxTRSLN9wKHiL7?=
 =?us-ascii?Q?YAEhFuW6GQ0AO1ayLDrA+vN7+rVk1wKfa68g81GGAkbaeCeDf4BtgmawcIHm?=
 =?us-ascii?Q?UeD4hoJF/d1LzGsnEIlj7QrdChG5hLesBnP1TNoVLri8HrI9sox6FcgsjGg/?=
 =?us-ascii?Q?HsmSdeXy2oiDN9JwzYy94RYNYust0s+k9HsveZ+SAiWmiKODkObpw5RIm82D?=
 =?us-ascii?Q?/C1VorE/fujznpGEK2PSGN3gCQH4P56KXyfSCVL2isHOgBCmt/HKgE+1kkIQ?=
 =?us-ascii?Q?lxSMuaY/LQZnCUyh6r6b/FywE2Fw2XDIhhC1xzDLAIpD6hMhxMIAvZ3IZXX6?=
 =?us-ascii?Q?DITrjMiCiVBI0Ho58DcitmNVONAv6n0IYWfvlhtbGax0j9ynACbB7MA2SAYF?=
 =?us-ascii?Q?1ShwJZOPtfTfVuI4mVnaoNCWaoUT7dW5Awt/auR5wH8FV3/aIsQsfrTTqoxT?=
 =?us-ascii?Q?ehtKblGGEDVHbOJ/ogIYVxwvcVTvDgdPvzkOdQLsU+j0zgdJ/DfS05K4XtMH?=
 =?us-ascii?Q?Ljud3ocICee+zODf69hUD4y9R86NuQ1sk4rFkBM7qlREsRRMO0VkIGazkJCA?=
 =?us-ascii?Q?N82O4Ho+UQqQUyVOmevBF0I3JEVaHCjsEgPhRnqWC0NI15bz6bv43w1iGaM5?=
 =?us-ascii?Q?XeJCF0Ecl/P+rTjEQNYEEnP7Kq5bWUVyNoxp5lZ7d+Xb9F62mC6zdFg46a30?=
 =?us-ascii?Q?q9qwUNcfui6UW+7NaOkVT+OvOQbz06wqk4HBt4XDug+zPnim06N5qQN2K8+l?=
 =?us-ascii?Q?JibzLvqH0InkyQx2i/ovN6rSQhQBakG+wMQpPThRxlcjGfurgW2W/dL5ncSg?=
 =?us-ascii?Q?4tRJxtvcmr2cZteHTfzqHMjq6XEijY6GYJqBj48SqfRxDV6y?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a43608e9-4992-4a80-1238-08deaa7ecbd0
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 08:17:49.7380
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lqx8cLt4VFjFxC2UZwllErPnx6yDW/IH0uUwmbG1WcNTyKkRQJDiTlSRPPrUC9zJik0TtKMnQkFFgJSq5sDZzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7564
X-Rspamd-Queue-Id: 743FF4C88BD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284256-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	FROM_HAS_DN(0.00)[]

The protodown functionality allows user space to turn off the carrier of
a net device:

 # ip link add name dummy1 up type dummy
 # ip link add name macvlan1 up link dummy1 type macvlan mode bridge
 # ip link set dev macvlan1 protodown on
 $ ip -br link show dev macvlan1
 macvlan1@dummy1  DOWN           0a:5c:a3:05:c7:86 <NO-CARRIER,BROADCAST,MULTICAST,UP>

When protodown is turned off, the core unconditionally turns on the
carrier of the net device:

 # ip link set dev macvlan1 protodown off
 $ ip -br link show dev macvlan1
 macvlan1@dummy1  UP             0a:5c:a3:05:c7:86 <BROADCAST,MULTICAST,UP,LOWER_UP>

This is wrong as it means that a macvlan can end up with a carrier when
its lower device does not have a carrier:

 # ip link set dev dummy1 carrier off
 $ ip -br link show dev macvlan1
 macvlan1@dummy1  LOWERLAYERDOWN 0a:5c:a3:05:c7:86 <NO-CARRIER,BROADCAST,MULTICAST,UP>
 # ip link set dev macvlan1 protodown on
 # ip link set dev macvlan1 protodown off
 $ ip -br link show dev macvlan1
 macvlan1@dummy1  UP             0a:5c:a3:05:c7:86 <BROADCAST,MULTICAST,UP,LOWER_UP>

Solve this by resolving the linked net device and if one exists, inherit
its operational state when protodown is turned off. Otherwise, as
before, simply turn on the carrier. Set 'dev->proto_down' before calling
netif_stacked_transfer_operstate() as this function is a NOP when
protodown is turned on.

Resolve the linked net device using a new helper and have it return the
device itself (in a similar fashion to dev_get_iflink()) if the device
does not implement both ndo_get_iflink() and get_link_net(). If the
latter is not implemented, it is unclear in which network namespace we
should look up the linked net device. Currently, this helper is only
used for net devices that support protodown (macvlan and vxlan) and for
both it returns the correct result.

Output with the patch:

 # ip link add name dummy1 up type dummy
 # ip link add name macvlan1 up link dummy1 type macvlan mode bridge
 # ip link set dev dummy1 carrier off
 $ ip -br link show dev macvlan1
 macvlan1@dummy1  LOWERLAYERDOWN 0a:5c:a3:05:c7:86 <NO-CARRIER,BROADCAST,MULTICAST,UP>
 # ip link set dev macvlan1 protodown on
 # ip link set dev macvlan1 protodown off
 $ ip -br link show dev macvlan1
 macvlan1@dummy1  LOWERLAYERDOWN 0a:5c:a3:05:c7:86 <NO-CARRIER,BROADCAST,MULTICAST,UP>
 # ip link set dev dummy1 carrier on
 $ ip -br link show dev macvlan1
 macvlan1@dummy1  UP             0a:5c:a3:05:c7:86 <BROADCAST,MULTICAST,UP,LOWER_UP>
 # ip link set dev macvlan1 protodown on
 # ip link set dev macvlan1 protodown off
 $ ip -br link show dev macvlan1
 macvlan1@dummy1  UP             0a:5c:a3:05:c7:86 <BROADCAST,MULTICAST,UP,LOWER_UP>

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 net/core/dev.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index bfb0f297b234..46f8a2efd982 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -10141,17 +10141,38 @@ bool netdev_port_same_parent_id(struct net_device *a, struct net_device *b)
 }
 EXPORT_SYMBOL(netdev_port_same_parent_id);
 
+static struct net_device *dev_get_iflink_dev(struct net_device *dev)
+{
+	struct net *net;
+
+	ASSERT_RTNL();
+
+	if (!dev->netdev_ops->ndo_get_iflink || !dev->rtnl_link_ops ||
+	    !dev->rtnl_link_ops->get_link_net)
+		return dev;
+
+	net = dev->rtnl_link_ops->get_link_net(dev);
+	return __dev_get_by_index(net, dev_get_iflink(dev));
+}
+
 int netif_change_proto_down(struct net_device *dev, bool proto_down)
 {
+	struct net_device *iflink_dev;
+
 	if (!dev->change_proto_down)
 		return -EOPNOTSUPP;
 	if (!netif_device_present(dev))
 		return -ENODEV;
+	iflink_dev = dev_get_iflink_dev(dev);
+	if (!iflink_dev)
+		return -ENODEV;
+	WRITE_ONCE(dev->proto_down, proto_down);
 	if (proto_down)
 		netif_carrier_off(dev);
-	else
+	else if (dev == iflink_dev)
 		netif_carrier_on(dev);
-	WRITE_ONCE(dev->proto_down, proto_down);
+	else
+		netif_stacked_transfer_operstate(iflink_dev, dev);
 	return 0;
 }
 
-- 
2.54.0


