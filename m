Return-Path: <netdev+bounces-271306-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0BX7N53+wmlXngQAu9opvQ
	(envelope-from <netdev+bounces-271306-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 22:14:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 45FBD31CBA9
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 22:14:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D4F58303A6E5
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 21:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C739359A8C;
	Tue, 24 Mar 2026 21:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="p2xN24pj"
X-Original-To: netdev@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11020137.outbound.protection.outlook.com [40.93.198.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1FA35AC34;
	Tue, 24 Mar 2026 21:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774386772; cv=fail; b=JDag7D13sq0eqCq7ePnTf0StlEEDwy93Le+agPnIGAkH2zjh5O2ZK3uPZOZhBb8KlaNTnAJMYQ423AkT0T6MMKtZi37PZkc0CNOb6ONY5UvDrwF7j6/h9vA/OUlWm/TGNWGEaBuKiwszzCT4SRrx8GP10FKNiIf+Y+7Kk5KKCF0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774386772; c=relaxed/simple;
	bh=jcAqxF/XkG76xR3TPt7ZjI/ynjxud/RRpmVAJ5PVv0I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Axn/1wsMw276xsNUyfGEhC9PRpPZs75e2W3pKNDJ+3UeMbTpop692aVYzJR+IZxydTufREUP8sBN/zdVLoJyDbaZimCILyOMYacuYl6BdVUjnf4kY8QN1o4/Jl9s0kDeQZ6dW9hknAa3XrNY22dWemQ19+A8uHT5IfD2Nbbn0lY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=p2xN24pj; arc=fail smtp.client-ip=40.93.198.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GlyoKXcJwWdbU4K8npgnpcTyR8wm4kLp5zC3xXzDW2owAT839ERwCYhYib79oI1hRITi0PbmqAAFM+bwxWY6+50VNU/hLUUUnGt2xV/ewopK6iYYjCmP/cEiD/2RQPzulMiXxJ2Jspghgs8oYVAnQznmpOk5IA70Qtxt/uagRuKYagVvP6Hfd2A/aR9Qzc6GZ3ohrZ9yNhn1n+Fw404BoB9po3w+VNO6egmZ6+/xOK1KY2x0+jyGx8z6349cZdizi7LvZdAaLqhrw1M1nzymeGhrKOjbCZHgPNbtKeXkhdp2dGQfYshC2AWKCcf18eVkEjOrEteL+R0GuKbEV0/0vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y+YrA/G5qr6AyulQqDDEc9Mlvksni/x9tKUB6Z1f9ag=;
 b=iNzBMB/WO5ZV9oN5tXoATPXQP5vRFFxfnal0CrcHfTdJR1hGDXRI7U/gPxcR9zLXiB83kJfpAoYmawDYdooD2n2jt17BOA96X0lWjAHDALmSI5eYuO9MV5joJaDLNU7AT+UZbuTp72aIUim27Msjm8f5bR0f92pb6ThFw8rH5QP0K5KJd6XDa27aUW+jBJP8rhjNMTUg6e8ov+HEQc3vA6lfUsqztRg0kpAb/i0WpMNeRSDU5vC3D0uw/gEyKLV1UScxELKXsEdk6ErcgvWzd5FjSre7wpIYwTUBHrktd4krnDA1c4JS77lK9URK69SDZRc2rWJCOFsUYrqSdgR1AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y+YrA/G5qr6AyulQqDDEc9Mlvksni/x9tKUB6Z1f9ag=;
 b=p2xN24pjdI+FIX+CH8gnRLv5LWGoiDKjXxoxMv61hk0kHfUzzfu1JjaFylEq8s422qguIwY8KMlnGgC0n8CVvntGm5Ac3Ud1JNpDI+3W8JlBWairLjo0wVsE4ytt+vW3Jo9uW3Wqpmy9K0kZhjgeddWxr1Ixie/MWLF5mY8zy2g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 CH3PR01MB8470.prod.exchangelabs.com (2603:10b6:610:1a4::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.20; Tue, 24 Mar 2026 21:12:46 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::44f3:1050:dce8:1ea9]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::44f3:1050:dce8:1ea9%6]) with mapi id 15.20.9723.030; Tue, 24 Mar 2026
 21:12:41 +0000
From: Adam Young <admiyo@os.amperecomputing.com>
To: Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sudeep Holla <sudeep.holla@arm.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Huisong Li <lihuisong@huawei.com>
Subject: [net-next v35 1/1] mctp pcc: Implement MCTP over PCC Transport
Date: Tue, 24 Mar 2026 17:12:34 -0400
Message-ID: <20260324211235.938599-2-admiyo@os.amperecomputing.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260324211235.938599-1-admiyo@os.amperecomputing.com>
References: <20260324211235.938599-1-admiyo@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CY5PR10CA0006.namprd10.prod.outlook.com
 (2603:10b6:930:1c::6) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|CH3PR01MB8470:EE_
X-MS-Office365-Filtering-Correlation-Id: 26a9b536-984b-4f23-e42c-08de89ea15d1
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|10070799003|1800799024|55112099003|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	tGHn/omCU9FscF8n0ZPqkWwZY7ePk8XC2303QSUmeRarxStmM7vfNjVVH1hYoaxw3PJFVDNKoDoNSpsXGNgK4wdb2YlLe8Ex3T2io5SgKT8/QF7usKzjcfP9mjvCgrD4mjErvHp845xSh4NUn8MrUu2YwMzdzYahx7HLBWpEDALRFHl5FI4hV65QswGpvYGIwGXyu7i9dCXcKOj+AuGUt1uj+e/HcSAFsEELYnGT8+WgXeb9A0rI7FowKtK+rW6bppmpMwq+/JIJ1k1NOSlmbyQWkd+fj/yek5WH17ZXe4Fz5RJZCgPVy1M7WMRgGX5Q1Z5HYkJF3Xlu54wJE9utESmHaqWZsoM6cmRZdG4By2ujpOvkk7cwk7u9ozf6YQ3T4NaED3nmDMcx1tOlTWy1Qcx/w0hOtoQcus9GuGk2CsEiWy4fxR7SDBCcvplTBdwnDcx/we3mfTBiovlk+gOAgTyy4nb3BGdN6pZzhTyMXKO62i+Uwgfekc6ldjjvvlOo+vb4h1ywUXBU257pWjy/S16i0xqz9rIdYOuQPMJD9hf/vpBEqD1umkKf7to+1fCAfKGYXKyvZCZOWwaxVBBnSgbr2FL+hFQrgWAfwmr3FoeTba5EU95aL3lu/7hm+vja5AaLkTPa8KUpQqA5M3qdqqLa3pj43o3ugfvohl72D8r0fNooasT/UTVqQYnVgKGj
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(10070799003)(1800799024)(55112099003)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rjvC8nEbPGehw99P0dcqga0kiYKMKi1rbLSojVJW9E27csItcDS8lM5kVpj1?=
 =?us-ascii?Q?NNhAAbjp0tDVlyFWAaKnZ2n2n+YU4993VOSXLGCmFIabn9ma6n9qCUts1yGg?=
 =?us-ascii?Q?d9SzDccf9Rl8DklrfrOX7aSMsGPhDUiBZnSPrjMWuGwyV/xhBfMf/VMk84Nt?=
 =?us-ascii?Q?EdwzltM1cXcBr8soN6ynLvNeRIsul0LmSP1zruMgtKMelR071hLgr4l265ti?=
 =?us-ascii?Q?+pCWpiwK8EpvY66pFxptSQX9plEE5eK/LENbU3GFwZw8g4yGG2rMmUfT0T/i?=
 =?us-ascii?Q?cY7Uj24dH1Aw3qEVZ82YhXne/Uj211rSVj8pSqOMf0m27DX6w2qNdM2gAt4i?=
 =?us-ascii?Q?hVGr3ZJjYA2SKXI3CjO6iNHyHmZYUV+ZYfBQQjsbA8x/J2YfDymZYoUpZfSX?=
 =?us-ascii?Q?WhiwcGxV51nwIYnLg2gS8/oKoMjjnkjQQ71F5KpJ9Fs4ROaCE1jsBmEjderv?=
 =?us-ascii?Q?l21VDg8fFoeJblWoJvRxl/Oxo/7JRSKIdUBWwkGOUSZszYwGihJy5+GPsaWI?=
 =?us-ascii?Q?JpMmwCN9/mYOzvc1fvUBcFxTv0jhwaSPJrPcX7Xub3D4ucl3mGhAVDK/4scu?=
 =?us-ascii?Q?jFUc6a4bwq+C0J3G4sfdyQIdA5TTGs0F4uyLOS8JOjDlZL4gkaSE3YkJaN3l?=
 =?us-ascii?Q?fquT9OuePN5TBxOy/BKWKpKqM/zg/qBzyrpzU+G+Et6xKJrewguj0mt97RfY?=
 =?us-ascii?Q?fYPomxScti7ITQWQ1C05vxE6TNI8sFh5IkEb+OwJqA0iccTRS5s/LEe0cbzK?=
 =?us-ascii?Q?9Cu3uj66MxjOjn0s2HtQ6Y+f77KTBI1GODqzeA22CTAWpLnP5Bw1rJBxBFZU?=
 =?us-ascii?Q?loSp3LevktMlS2BuckmASNEfgbRq1OI7j8fAUu3YD0ymcTZcQbQ5JghN4whx?=
 =?us-ascii?Q?YERgRz5gKeDPEpFb3UOgvX8lcAzbEidgH6PIbBc42ou0uOQ0l2lGxgQNdBig?=
 =?us-ascii?Q?SKotxBtHE/lQ8LoIZELBxqnmqR24QqftQUbPvorn6Pa1XYfC7V4E64jFa4RZ?=
 =?us-ascii?Q?jHoUWsYEFE1+LJV2gr7ndtVfc8MMCHbfo0fAU8b7sVSwDqCI/kfUUL+4ObMn?=
 =?us-ascii?Q?+N+DDm2kdtNJeWwrDKWCgKbhNHVqLVa0w8Bk9sWCmBBofyTdk0n9df7wdYoE?=
 =?us-ascii?Q?EqnWw3SztJjwYC7k3NSu3ppOtrKk04BEEwa1HYmU1OQRGp0mDNeRWuvmT7cG?=
 =?us-ascii?Q?DXcJ6aVSCLdC73LoeRVt5DYoq2pu3/bf7qdads/ynhg4GUsKNJgnWqIGeO8P?=
 =?us-ascii?Q?4esHnEzbtqxvtNVtQV4n+DqwjkLjYEW1PkCBrRag+9JE+L8tJUHWzD5Glp1l?=
 =?us-ascii?Q?UMLFqUbeNfIVSR4fktYLRpM8V62CrDj4VlPog1yNowdmYOizU10C9lCpSMjR?=
 =?us-ascii?Q?XaXI6JN7QmvYCHKvLjmNfjjAIedWxe7CQfi2mBrE6HiaqUrzbIkGuh3UgC79?=
 =?us-ascii?Q?+QHtDvAUcC0WtXOe6tahwZ6gDOWVEBzQquSX1SIr0ANhNvHH3gwwfdr1qt7Q?=
 =?us-ascii?Q?ZS4ZMiJq51+lIEhvgaMswuB1YdcZKt47fr4uZezu0ynwlxqP2/PgxuxtI9G+?=
 =?us-ascii?Q?Sa4+3c2uQ2Ysk6gHJjmaldJ7EFNuphL22GJWSKHLLbQDIiu79HSwfwoQc4Cp?=
 =?us-ascii?Q?Lsjh7v6/EP+ty4+892LC9SsiG2KG3uLcCOArdz/93DM2Yrobk6FP/8YcBsAR?=
 =?us-ascii?Q?1xu0X8fkuMPIYedN4AJsV8AMGAYDu7kDyp8b2MKohMuZi8pq7cFNALboBu9j?=
 =?us-ascii?Q?pA5tJwsvyo7XoZBD8KnztSK6BWxQQTd+bAxcNFL5KVqWClf4pYQzh0dOj0BR?=
X-MS-Exchange-AntiSpam-MessageData-1:
	azcumPguLpRuUA3XJwD3Ebd9NkUn5Vq3DGFPJr1YMfJKbvo9BlhatdIq
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26a9b536-984b-4f23-e42c-08de89ea15d1
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 21:12:41.5643
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a+8QRc4tBVw7AhFd7KOqi+lXokEPFurewwNZxleJHMfuhCdp9iEuW8eIb//zxAlIEIxjV3kO7WFBRmSIJE+cA7lrhptBkv0WtFOnTCWqoXkN0uz/gEcsMu2z/Zu4Mccb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR01MB8470
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amperecomputing.com,quarantine];
	R_DKIM_ALLOW(-0.20)[os.amperecomputing.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-271306-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[admiyo@os.amperecomputing.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[os.amperecomputing.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,os.amperecomputing.com:dkim,os.amperecomputing.com:mid,oracle.com:email,uefi.org:url]
X-Rspamd-Queue-Id: 45FBD31CBA9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Implementation of network driver for
Management Component Transport Protocol(MCTP)
over Platform Communication Channel(PCC)

DMTF DSP:0292
https://www.dmtf.org/sites/default/files/standards/documents/\
DSP0292_1.0.0WIP50.pdf

The transport mechanism is called Platform Communication Channels (PCC)
is part of the ACPI spec:

https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/
\14_Platform_Communications_Channel/Platform_Comm_Channel.html

The PCC mechanism is managed via a mailbox implemented at
drivers/mailbox/pcc.c

MCTP devices are specified via ACPI by entries in DSDT/SSDT and
reference channels specified in the PCCT. Messages are sent on a type
3 and received on a type 4 channel.  Communication with other devices
use the PCC based doorbell mechanism; a shared memory segment with a
corresponding interrupt and a memory register used to trigger remote
interrupts.

Unlike the existing PCC Type 2 based drivers, the mssg parameter to
mbox_send_msg is actively used. The data section of the struct sk_buff
that contains the outgoing packet is sent to the mailbox, already
properly formatted as a PCC exctended message.

If the mailbox ring buffer is full, the driver stops the incoming
packet queues until a message has been sent, freeing space in the
ring buffer.

When the Type 3 channel outbox receives a txdone response interrupt,
it consumes the outgoing sk_buff, allowing it to be freed.

Bringing up an interface creates the channel between the network driver
and the mailbox driver. This enables communication with the remote
endpoint, to include the receipt of new messages. Bringing down an
interface removes the channel, and no new messages can be delivered.
Stopping the interface also frees any packets that are cached in the
mailbox ringbuffer.

PCC is based on a shared buffer and a set of I/O mapped memory locations
that the Spec calls registers.  This mechanism exists regardless of the
existence of the driver. If the user has the ability to map these
physical location to virtual locations, they have the ability to drive the
hardware.  Thus, there is a security aspect to this mechanism that extends
beyond the responsibilities of the operating system.

If the hardware does not expose the PCC in the ACPI table, this device
will never be enabled. Thus it is only an issue on hardware that does
support PCC. In that case, it is up to the remote controller to sanitize
communication; MCTP will be exposed as a socket interface, and userland
can send any crafted packet it wants. It would also be incumbent on
the hardware manufacturer to allow the end user to disable MCTP over PCC
communication if they did not want to expose it.

Signed-off-by: Adam Young <admiyo@os.amperecomputing.com>
---
 MAINTAINERS                 |   5 +
 drivers/net/mctp/Kconfig    |  13 ++
 drivers/net/mctp/Makefile   |   1 +
 drivers/net/mctp/mctp-pcc.c | 366 ++++++++++++++++++++++++++++++++++++
 4 files changed, 385 insertions(+)
 create mode 100644 drivers/net/mctp/mctp-pcc.c

diff --git a/MAINTAINERS b/MAINTAINERS
index ff6f17458f19..43bc37f859d6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15288,6 +15288,11 @@ F:	include/net/mctpdevice.h
 F:	include/net/netns/mctp.h
 F:	net/mctp/
 
+MANAGEMENT COMPONENT TRANSPORT PROTOCOL (MCTP) over PCC (MCTP-PCC) Driver
+M:	Adam Young <admiyo@os.amperecomputing.com>
+S:	Maintained
+F:	drivers/net/mctp/mctp-pcc.c
+
 MAPLE TREE
 M:	Liam R. Howlett <Liam.Howlett@oracle.com>
 R:	Alice Ryhl <aliceryhl@google.com>
diff --git a/drivers/net/mctp/Kconfig b/drivers/net/mctp/Kconfig
index cf325ab0b1ef..77cd4091050c 100644
--- a/drivers/net/mctp/Kconfig
+++ b/drivers/net/mctp/Kconfig
@@ -47,6 +47,19 @@ config MCTP_TRANSPORT_I3C
 	  A MCTP protocol network device is created for each I3C bus
 	  having a "mctp-controller" devicetree property.
 
+config MCTP_TRANSPORT_PCC
+	tristate "MCTP PCC transport"
+	depends on ACPI
+	help
+	  Provides a driver to access MCTP devices over PCC transport,
+	  A MCTP protocol network device is created via ACPI for each
+	  entry in the DSDT/SSDT that matches the identifier. The Platform
+	  communication channels are selected from the corresponding
+	  entries in the PCCT.
+
+	  Say y here if you need to connect to MCTP endpoints over PCC. To
+	  compile as a module, use m; the module will be called mctp-pcc.
+
 config MCTP_TRANSPORT_USB
 	tristate "MCTP USB transport"
 	depends on USB
diff --git a/drivers/net/mctp/Makefile b/drivers/net/mctp/Makefile
index c36006849a1e..0a591299ffa9 100644
--- a/drivers/net/mctp/Makefile
+++ b/drivers/net/mctp/Makefile
@@ -1,4 +1,5 @@
 obj-$(CONFIG_MCTP_SERIAL) += mctp-serial.o
 obj-$(CONFIG_MCTP_TRANSPORT_I2C) += mctp-i2c.o
 obj-$(CONFIG_MCTP_TRANSPORT_I3C) += mctp-i3c.o
+obj-$(CONFIG_MCTP_TRANSPORT_PCC) += mctp-pcc.o
 obj-$(CONFIG_MCTP_TRANSPORT_USB) += mctp-usb.o
diff --git a/drivers/net/mctp/mctp-pcc.c b/drivers/net/mctp/mctp-pcc.c
new file mode 100644
index 000000000000..f8d620795349
--- /dev/null
+++ b/drivers/net/mctp/mctp-pcc.c
@@ -0,0 +1,366 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * mctp-pcc.c - Driver for MCTP over PCC.
+ * Copyright (c) 2024-2026, Ampere Computing LLC
+ *
+ */
+
+/* Implementation of MCTP over PCC DMTF Specification DSP0256
+ * https://www.dmtf.org/sites/default/files/standards/documents/DSP0292_1.0.0WIP50.pdf
+ */
+
+#include <linux/acpi.h>
+#include <linux/hrtimer.h>
+#include <linux/if_arp.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/mailbox_client.h>
+#include <linux/module.h>
+#include <linux/netdevice.h>
+#include <linux/platform_device.h>
+#include <linux/skbuff.h>
+#include <linux/string.h>
+
+#include <acpi/acpi_bus.h>
+#include <acpi/acpi_drivers.h>
+#include <acpi/acrestyp.h>
+#include <acpi/actbl.h>
+#include <acpi/pcc.h>
+#include <net/mctp.h>
+#include <net/mctpdevice.h>
+
+#define MCTP_SIGNATURE          "MCTP"
+#define MCTP_SIGNATURE_LENGTH   (sizeof(MCTP_SIGNATURE) - 1)
+#define MCTP_MIN_MTU            68
+#define PCC_DWORD_TYPE          0x0c
+
+struct mctp_pcc_mailbox {
+	u32 index;
+	struct pcc_mbox_chan *chan;
+	struct mbox_client client;
+};
+
+/* The netdev structure. One of these per PCC adapter. */
+struct mctp_pcc_ndev {
+	struct net_device *ndev;
+	struct acpi_device *acpi_device;
+	struct mctp_pcc_mailbox inbox;
+	struct mctp_pcc_mailbox outbox;
+};
+
+/**
+ * mbox_write_to_buffer - copy the contents of the data
+ * pointer to the shared buffer.  Confirms that the command
+ * flag has been set prior to writing.  Data should be a
+ * properly formatted extended data buffer.
+ * pcc_mbox_write_to_buffer
+ * @pchan: channel
+ * @len: Length of the overall buffer passed in, including the
+ *       Entire header. The length value in the shared buffer header
+ *       Will be calculated from len.
+ * @data: Client specific data to be written to the shared buffer.
+ * Return: number of bytes written to the buffer.
+ */
+static int mbox_write_to_buffer(struct pcc_mbox_chan *pchan, int len, void *data)
+{
+	struct acpi_pcct_ext_pcc_shared_memory *pcc_header = data;
+	/*
+	 * The PCC header length includes the command field
+	 * but not the other values from the header.
+	 */
+	pcc_header->length = len - sizeof(struct acpi_pcct_ext_pcc_shared_memory) + sizeof(u32);
+
+	if (len > pchan->shmem_size)
+		return 0;
+
+	memcpy_toio(pchan->shmem,  data, len);
+
+	return len;
+}
+
+static void mctp_pcc_client_rx_callback(struct mbox_client *cl, void *mssg)
+{
+	struct acpi_pcct_ext_pcc_shared_memory pcc_header;
+	struct mctp_pcc_ndev *mctp_pcc_ndev;
+	struct mctp_pcc_mailbox *inbox;
+	struct mctp_skb_cb *cb;
+	struct sk_buff *skb;
+	int size;
+
+	mctp_pcc_ndev = container_of(cl, struct mctp_pcc_ndev, inbox.client);
+	inbox = &mctp_pcc_ndev->inbox;
+	memcpy_fromio(&pcc_header, inbox->chan->shmem, sizeof(pcc_header));
+	size = pcc_header.length - sizeof(pcc_header.command) + sizeof(pcc_header);
+
+	if (size <= sizeof(pcc_header)) {
+		dev_dstats_rx_dropped(mctp_pcc_ndev->ndev);
+		return;
+	}
+	if (memcmp(&pcc_header.command, MCTP_SIGNATURE, MCTP_SIGNATURE_LENGTH) != 0) {
+		dev_dstats_rx_dropped(mctp_pcc_ndev->ndev);
+		return;
+	}
+
+	if (size > mctp_pcc_ndev->ndev->mtu)
+		dev_dbg(cl->dev, "MCTP_PCC bytes available exceeds MTU");
+
+	skb = netdev_alloc_skb(mctp_pcc_ndev->ndev, size);
+	if (!skb) {
+		dev_dstats_rx_dropped(mctp_pcc_ndev->ndev);
+		return;
+	}
+	skb_put(skb, size);
+	skb->protocol = htons(ETH_P_MCTP);
+	memcpy_fromio(skb->data, inbox->chan->shmem, size);
+	dev_dstats_rx_add(mctp_pcc_ndev->ndev, size);
+	skb_pull(skb, sizeof(pcc_header));
+	skb_reset_mac_header(skb);
+	skb_reset_network_header(skb);
+	cb = __mctp_cb(skb);
+	cb->halen = 0;
+	netif_rx(skb);
+}
+
+static netdev_tx_t mctp_pcc_tx(struct sk_buff *skb, struct net_device *ndev)
+{
+	struct acpi_pcct_ext_pcc_shared_memory *pcc_header;
+	struct mctp_pcc_ndev *mpnd = netdev_priv(ndev);
+	int len = skb->len;
+	int rc;
+
+	rc = skb_cow_head(skb, sizeof(*pcc_header));
+	if (rc) {
+		dev_dstats_tx_dropped(ndev);
+		kfree_skb(skb);
+		return NETDEV_TX_OK;
+	}
+
+	pcc_header = skb_push(skb, sizeof(*pcc_header));
+	pcc_header->signature = PCC_SIGNATURE | mpnd->outbox.index;
+	pcc_header->flags = PCC_CMD_COMPLETION_NOTIFY;
+	memcpy(&pcc_header->command, MCTP_SIGNATURE, MCTP_SIGNATURE_LENGTH);
+	pcc_header->length = len + MCTP_SIGNATURE_LENGTH;
+
+	rc = mbox_send_message(mpnd->outbox.chan->mchan, skb);
+	if (rc < 0) {
+		//Remove the header in case it gets sent again
+		skb_pull(skb, sizeof(*pcc_header));
+		netif_stop_queue(ndev);
+		return NETDEV_TX_BUSY;
+	}
+
+	return NETDEV_TX_OK;
+}
+
+static void mctp_pcc_tx_prepare(struct mbox_client *cl, void *mssg)
+{
+	struct mctp_pcc_ndev *mctp_pcc_ndev;
+	struct mctp_pcc_mailbox *outbox;
+	struct sk_buff *skb = mssg;
+	int len_sent;
+
+	mctp_pcc_ndev = container_of(cl, struct mctp_pcc_ndev, outbox.client);
+	outbox = &mctp_pcc_ndev->outbox;
+
+	if (!skb)
+		return;
+
+	len_sent = mbox_write_to_buffer(outbox->chan, skb->len, skb->data);
+	if (len_sent == 0)
+		dev_dstats_tx_dropped(mctp_pcc_ndev->ndev);
+	else
+		dev_dstats_tx_add(mctp_pcc_ndev->ndev, len_sent);
+}
+
+static void mctp_pcc_tx_done(struct mbox_client *c, void *mssg, int r)
+{
+	struct mctp_pcc_ndev *mctp_pcc_ndev;
+	struct sk_buff *skb = mssg;
+
+	mctp_pcc_ndev = container_of(c, struct mctp_pcc_ndev, outbox.client);
+	dev_consume_skb_any(skb);
+	netif_wake_queue(mctp_pcc_ndev->ndev);
+}
+
+static int mctp_pcc_ndo_open(struct net_device *ndev)
+{
+	struct mctp_pcc_ndev *mctp_pcc_ndev = netdev_priv(ndev);
+	struct mctp_pcc_mailbox *outbox, *inbox;
+
+	outbox = &mctp_pcc_ndev->outbox;
+	inbox = &mctp_pcc_ndev->inbox;
+
+	outbox->chan = pcc_mbox_request_channel(&outbox->client, outbox->index);
+	if (IS_ERR(outbox->chan))
+		return PTR_ERR(outbox->chan);
+
+	inbox->client.rx_callback = mctp_pcc_client_rx_callback;
+	inbox->chan = pcc_mbox_request_channel(&inbox->client, inbox->index);
+	if (IS_ERR(inbox->chan)) {
+		pcc_mbox_free_channel(outbox->chan);
+		return PTR_ERR(inbox->chan);
+	}
+	return 0;
+}
+
+static int mctp_pcc_ndo_stop(struct net_device *ndev)
+{
+	struct mctp_pcc_ndev *mctp_pcc_ndev = netdev_priv(ndev);
+
+	pcc_mbox_free_channel(mctp_pcc_ndev->outbox.chan);
+	pcc_mbox_free_channel(mctp_pcc_ndev->inbox.chan);
+	return 0;
+}
+
+static const struct net_device_ops mctp_pcc_netdev_ops = {
+	.ndo_open = mctp_pcc_ndo_open,
+	.ndo_stop = mctp_pcc_ndo_stop,
+	.ndo_start_xmit = mctp_pcc_tx,
+};
+
+static void mctp_pcc_setup(struct net_device *ndev)
+{
+	ndev->type = ARPHRD_MCTP;
+	ndev->hard_header_len = sizeof(struct acpi_pcct_ext_pcc_shared_memory);
+	ndev->tx_queue_len = 0;
+	ndev->flags = IFF_NOARP;
+	ndev->netdev_ops = &mctp_pcc_netdev_ops;
+	ndev->needs_free_netdev = true;
+	ndev->pcpu_stat_type = NETDEV_PCPU_STAT_DSTATS;
+}
+
+struct mctp_pcc_lookup_context {
+	int index;
+	u32 inbox_index;
+	u32 outbox_index;
+};
+
+static acpi_status lookup_pcct_indices(struct acpi_resource *ares,
+				       void *context)
+{
+	struct mctp_pcc_lookup_context *luc = context;
+	struct acpi_resource_address32 *addr;
+
+	if (ares->type != PCC_DWORD_TYPE)
+		return AE_OK;
+
+	addr = ACPI_CAST_PTR(struct acpi_resource_address32, &ares->data);
+	switch (luc->index) {
+	case 0:
+		luc->outbox_index = addr[0].address.minimum;
+		break;
+	case 1:
+		luc->inbox_index = addr[0].address.minimum;
+		break;
+	}
+	luc->index++;
+	return AE_OK;
+}
+
+static void mctp_cleanup_netdev(void *data)
+{
+	struct net_device *ndev = data;
+
+	mctp_unregister_netdev(ndev);
+}
+
+static int initialize_MTU(struct net_device *ndev)
+{
+	struct mctp_pcc_ndev *mctp_pcc_ndev;
+	struct mctp_pcc_mailbox *outbox;
+	struct pcc_mbox_chan *pchan;
+	int mctp_pcc_mtu;
+
+	mctp_pcc_mtu = MCTP_MIN_MTU;
+	mctp_pcc_ndev = netdev_priv(ndev);
+	outbox = &mctp_pcc_ndev->outbox;
+	pchan = pcc_mbox_request_channel(&outbox->client, outbox->index);
+	if (IS_ERR(pchan))
+		return -1;
+
+	mctp_pcc_mtu = pchan->shmem_size;
+	pcc_mbox_free_channel(pchan);
+
+	mctp_pcc_mtu = mctp_pcc_mtu - sizeof(struct acpi_pcct_ext_pcc_shared_memory);
+	ndev->mtu = MCTP_MIN_MTU;
+	ndev->max_mtu = mctp_pcc_mtu;
+	ndev->min_mtu = MCTP_MIN_MTU;
+
+	return 0;
+}
+
+static int mctp_pcc_driver_add(struct acpi_device *acpi_dev)
+{
+	struct mctp_pcc_lookup_context context = {0};
+	struct mctp_pcc_ndev *mctp_pcc_ndev;
+	struct device *dev = &acpi_dev->dev;
+	struct net_device *ndev;
+	acpi_handle dev_handle;
+	acpi_status status;
+	char name[32];
+	int rc;
+
+	dev_dbg(dev, "Adding mctp_pcc device for HID %s\n",
+		acpi_device_hid(acpi_dev));
+	dev_handle = acpi_device_handle(acpi_dev);
+	status = acpi_walk_resources(dev_handle, "_CRS", lookup_pcct_indices,
+				     &context);
+	if (!ACPI_SUCCESS(status)) {
+		dev_err(dev, "FAILED to lookup PCC indexes from CRS\n");
+		return -EINVAL;
+	}
+
+	snprintf(name, sizeof(name), "mctppcc%d", context.inbox_index);
+	ndev = alloc_netdev(sizeof(*mctp_pcc_ndev), name, NET_NAME_PREDICTABLE,
+			    mctp_pcc_setup);
+	if (!ndev)
+		return -ENOMEM;
+
+	mctp_pcc_ndev = netdev_priv(ndev);
+
+	mctp_pcc_ndev->inbox.index = context.inbox_index;
+	mctp_pcc_ndev->inbox.client.dev = dev;
+	mctp_pcc_ndev->outbox.index = context.outbox_index;
+	mctp_pcc_ndev->outbox.client.dev = dev;
+
+	mctp_pcc_ndev->outbox.client.tx_prepare = mctp_pcc_tx_prepare;
+	mctp_pcc_ndev->outbox.client.tx_done = mctp_pcc_tx_done;
+	mctp_pcc_ndev->acpi_device = acpi_dev;
+	mctp_pcc_ndev->ndev = ndev;
+	acpi_dev->driver_data = mctp_pcc_ndev;
+
+	rc = initialize_MTU(ndev);
+	if (rc)
+		goto free_netdev;
+
+	rc = mctp_register_netdev(ndev, NULL, MCTP_PHYS_BINDING_PCC);
+	if (rc)
+		goto free_netdev;
+
+	return devm_add_action_or_reset(dev, mctp_cleanup_netdev, ndev);
+free_netdev:
+	free_netdev(ndev);
+	return rc;
+}
+
+static const struct acpi_device_id mctp_pcc_device_ids[] = {
+	{ "DMT0001" },
+	{}
+};
+
+static struct acpi_driver mctp_pcc_driver = {
+	.name = "mctp_pcc",
+	.class = "Unknown",
+	.ids = mctp_pcc_device_ids,
+	.ops = {
+		.add = mctp_pcc_driver_add,
+	},
+};
+
+module_acpi_driver(mctp_pcc_driver);
+
+MODULE_DEVICE_TABLE(acpi, mctp_pcc_device_ids);
+
+MODULE_DESCRIPTION("MCTP PCC ACPI device");
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Adam Young <admiyo@os.amperecomputing.com>");
-- 
2.43.0


