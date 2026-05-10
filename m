Return-Path: <netdev+bounces-286329-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GaLNHyqzAGoKLwEAu9opvQ
	(envelope-from <netdev+bounces-286329-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 18:32:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B75E05051D0
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 18:32:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B452E3009B2B
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 16:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1187939C00B;
	Sun, 10 May 2026 16:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="ZJzTKoMZ"
X-Original-To: netdev@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11023076.outbound.protection.outlook.com [40.93.201.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E137432BF41;
	Sun, 10 May 2026 16:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778430759; cv=fail; b=JX5DYLLVclM77gUCsf8BtF0Yg/RpDomF3qLiYfWl2F2CAt3J4OiODJvwt9E6uL0CPRb52vEX5cMsZbeRXI/psuS8nLGypwio13PkNuf0yRGo9l4ymqd8JgHjxxrv+SiHjPzoXZFaUHPiWflN0cCCnBSV1g5WihNyx1NsD8XdCUw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778430759; c=relaxed/simple;
	bh=jcHqW26RVvnSvLEfIblpPottigpPVSGTcS229pdPibk=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=jb8Em4E9naeXGp7RL1XuIttu7BASDWHfVLAnYe5cOepQ/atbT6SlCwIQlRb/FOO3xeIKJy/oaGsptNOBTl6kXz3HDUBxLyNBa89YFeaKtXRQl0cTU7LJvY6IqVFaJayboAUw0oOF+J3m/Xmg5bZQKiVAiQORTmMUen2XUljDOiM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=ZJzTKoMZ; arc=fail smtp.client-ip=40.93.201.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=thMZhyg6tb7vScMfKRNPPfqpkljG3PEOmP46FVR/qtA5xEhwz7kQvD8Pr44ixLk2MVJlAkysyjnw/u/1FEpB4+GdiXWLFI5uQOEcoByr3q23SisdODOPbYdgwuAT+7djwHZFwIF0wbbT4JdRWv18daPfD0od9AglCzXkUK1lMwY7Vno9Ha25wW4TcVGt+RqJG04vTFA5Bvzsj/CSeH4qc7kAwXL5lANp6cUFq8JsqeY5eQxGiCpM5HcPlr0OIANoKKeF8xnP2PoziXfmTMKKNlrGXH7Rv88msiM45sLDnRDaZjAZ8XUsGygJh7vkEEmt4PlnZR0Fxsrp9JzJxePxyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BXXZA7yF4Bh2hJGq1rR33bJlVuGabn9V8YMELoIaoUc=;
 b=NXcpyq3LJurQuSeyD2+ofkkGNCiR+k3M4Omo/BLRjViLJSWQou2dEQBrJBTbIlJoc912xkHKtm/Oxgn3BE6qFsi21iPj4gPoYMF9YItyJEqobdFiaQFOIPL53unlbmg2/C6dENHxoIh51mPDUoW4TNJhLlCdJmFd3hi0ByngdGhGDwleA5gSa/P4POVCs+9yXNwej3fJPZ/Nbgoq5TRGzUs6jby8DjCRoMM3CSGNMdueicd+iBGO/Ff40DmQTMF4HmEDiNmYyPuktD3aDfuhy3UgRSY64aiRyWLtIGbyE56WypVe8N9nfRAFXEy6uAPU85c2F3xNN7EerPC+FlzXaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BXXZA7yF4Bh2hJGq1rR33bJlVuGabn9V8YMELoIaoUc=;
 b=ZJzTKoMZ+44m+8XFG06pZuo832EZGFWzwMuB0BDF7tQQowr8ZuG6N2pTfk/vupilUrTemDZBVn8ePFIHXRD4pO7Ryl2PYnUKe1hNuPMUH6C9Sc36mjF+1hpRVEf/t7naix7/s82AI26RoIWaVBSBwiisPSKk0keryDmuXFiqz64=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 BY3PR01MB6707.prod.exchangelabs.com (2603:10b6:a03:36d::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.15; Sun, 10 May 2026 16:32:32 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::44f3:1050:dce8:1ea9]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::44f3:1050:dce8:1ea9%6]) with mapi id 15.20.9891.021; Sun, 10 May 2026
 16:32:32 +0000
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
Subject: [net-next v41] mctp pcc: Implement MCTP over PCC Transport
Date: Sun, 10 May 2026 12:32:27 -0400
Message-ID: <20260510163228.443778-1-admiyo@os.amperecomputing.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0406.namprd13.prod.outlook.com
 (2603:10b6:208:2c2::21) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|BY3PR01MB6707:EE_
X-MS-Office365-Filtering-Correlation-Id: b04fe28f-075c-433d-8f7f-08deaeb1bbf4
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|366016|7416014|376014|55112099003|13003099007|18002099003|56012099003|3023799003;
X-Microsoft-Antispam-Message-Info:
	0mSdr+xP8d1Eb51THuDiS15AD1LS7J81vjITcllDdIMiXeGyn2qEKm/WZGIreqH5Ii846qdKWlRwn3CR3ET30/AaQZMIUxziH70YNqjpmns4D4S7U3czaSqyKkUdxbcmJS6SSBCX/lBELtmkmp65Fp/mBsejSglucsVRCTZhmuIBV3wJeA3e0CEjxJ3uRmFXfsBVTO6YySpjDsspIZvjD+Ca5Uqq12EbrO/yNXL3PizJhkZa8eYr/H/rO/mHTrWkc/viPUYGdc9sFpklZf0T0g7C7L1SoMWcPjHyME1HCu3vrT+4SMm1EAeL0+Ub9URFe5eb3YykbRKCRG0GjwgQ4bTaq3euZblqpxS/4KSCOWEjl7zXlwK9VJQHeDoAb+EiLznwc8MkUtHUYrB+usVUdEBazY0qKXSRbFIgJ3Xil4tJrYFnakkNObRRC2MahMSmTLK2A4Lf/XY7llPoI/IOsQwFt+Ri1g5g78wUsv8Uw76PWN3lILLjTzAJq8KBGaKbEZ4q3NJUWQlJfq21pWBolggM6YM6AF9Bqd+uI6I8M692EaS4opoHl9Rx7aNvc8AhOasoPadw5gCvmy9eAQn7kvd6kNTgLRu/1dJ9jyfCtKV/Po6/lJ2eHoo2sBJ1H1zqb+dfe1FEqMvrs6UxRqfObipnWsAnf1wroOR0OUljEuTCtFvhJs9QudBNYV4ZaK3GWhXqnwg3xbXCN8kRB7/L7Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(7416014)(376014)(55112099003)(13003099007)(18002099003)(56012099003)(3023799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?meOpcyc4/P7CiJBpNHyBbLanWNNcGW2ZDNbt4f/BcrqwO0870t7zSC1BNTrW?=
 =?us-ascii?Q?CiDbe/q6wWJ3z445xUNKA3ju4YlkUhntMZ1F0/b7uLDXr/VG0EivGWur4Pjz?=
 =?us-ascii?Q?EhFGC8kb/LoTuxJ04mR89VMnafQ86SbePpdv0r8adX7J8DwxVW8F7v9rMbwc?=
 =?us-ascii?Q?0zFpCKW/bxJRcJ8MmLVLqiSX9OCEna2TwgyAg27pg9vy/+GiZFrCO3yQTxZv?=
 =?us-ascii?Q?BNo+l2N6WIUxxpO5Km3WRipzQHln2KZjNxhkyf/+3UkFrna2u8bgeL4+trH6?=
 =?us-ascii?Q?NWO2JJ+tGJwqbH6v8CSJWtzBUkt6HbaC6jXpAgWduQDa6J+WrURTcAy9sVuI?=
 =?us-ascii?Q?5vuXgAcchNS1WAx+TLQs66k2jpRT67ajN12OKrqAWEkLdhAOMHWjfW+cVLPR?=
 =?us-ascii?Q?EAmfzcdKZiUqr1Mcab6CUilrz5JtBcfwq2nRjff1WfH4YJWJ0dYDgLZjNGBO?=
 =?us-ascii?Q?VIj5QUID5mfDJowHCGapH/ZLZNyZjXE6L7OTPqo6mmFKm1aEcvpIgCYwR/gu?=
 =?us-ascii?Q?3JSwZjdrjMFeAegXq4tLw5tBHy+jDlaC+FwlBbwD3x694E+Qa5KJLuXzJF1N?=
 =?us-ascii?Q?V5tlQea9TSsG5HlAysshL9iTezghotMZeKVK06G+0q7KShhBKt51L61vjy+c?=
 =?us-ascii?Q?ifK1ctXX6uJvWNbinYz7fqIIwhMx876gWibAV0HxAkkQTQTCnZGIX7Ryz/Oq?=
 =?us-ascii?Q?7m2IIdL/xoT1yflleNdB+cWGut9FNhn/JPWDeNcjk/EMDzvVeR2V3bl1+BCb?=
 =?us-ascii?Q?PQ83RRGxg1F7Xx2BKHV61MR1PWgf12iuLLiycBlPAjSnEe9FljHzLEHujz1v?=
 =?us-ascii?Q?LqarR9iArGBPjKpN+1OQvIX+jGph0pNdcNkzkfuE/yskiTbhthPAvpkqBFsa?=
 =?us-ascii?Q?7qONP5D2F56qD7X/p+WpU/sCtYNBUWwXwCqYA6Q4I8OPHyb/y8myO6WnK8UL?=
 =?us-ascii?Q?IRnGxlBJPwhuCU3zx0N8wlA0kelBgR/e3+5PmhAo85PD/yvcnA0qqbYv/SDe?=
 =?us-ascii?Q?LFnRA2b99klRRiK3pNLGFxiXY87tMmHeAbvn17yw7zdJVTaJuGiNpLlsfOjj?=
 =?us-ascii?Q?BbaTYL6ypx22Es1/9Uh6igkC6C+hXNcIavJy/aDUQrvm/Wr8iCL9upzpqV/+?=
 =?us-ascii?Q?qLkIt+7tpNty3X5IWOOZDPXyf+T/1PbrmHmA6hwyBG15OA60hzclXd1TkYxW?=
 =?us-ascii?Q?UggD+KeA7ot7ZBGdxAacJeUEzRSIkKKhq/k7R6a6yty84M/K98er2K+oEg4n?=
 =?us-ascii?Q?bw2h1PS718GuXpFbvwPKXjJjPhNRyFZKzLudQyocvVaG6TIC07MBm1u/KrTC?=
 =?us-ascii?Q?Inpwyr04df8FeJ19fcJ93qnaoAONO7HCEnsqa6nzTZ8OZVxL0/9XMkLPFnq+?=
 =?us-ascii?Q?hdiLsWbGcQsPDEWZQTuuX4ep3QiCg4V3rL819Cp+UJPwza0I3+B0aqMLyzTX?=
 =?us-ascii?Q?nRE9LJGZvelz0+sgduBhN0azERvdWdlXPvqRZVILrT7B9BsEVr7JNO0Vqvg7?=
 =?us-ascii?Q?jcMsZg+xePQp4JOqkRQE3UI4Of07HLKH26MYGPeTcDcK9HWGJ59CaLb8qFMh?=
 =?us-ascii?Q?rscxAjj7InaE2In90nm5lVxOCUrxAr3lEpg6yPUHF1RzHRAHzAGKarkF186H?=
 =?us-ascii?Q?1Pj2SMmtAeB7JK76nHm0gjvADBbSg2PsDsUNjqq8tkxHU70XG1H3V8JkN1dj?=
 =?us-ascii?Q?3EzSt1kfu4yY+CZZNC3+0yQOQDK44LWmVjM5WRPmNBTvkGT9Tu5WNbs9cv6O?=
 =?us-ascii?Q?fSWqZc4vk00ipUzj4sL6M1mMZzAcCy6wwhJHP2qB7D5vgegpceiY9NipBBat?=
X-MS-Exchange-AntiSpam-MessageData-1:
	6KH17QN+mKXqns5l+II3UhTOiuNW+mz9X6yZVcFJidwXGGgINK3/+XhC
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b04fe28f-075c-433d-8f7f-08deaeb1bbf4
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2026 16:32:32.0789
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: juU3cAiKmxle4+R1yut6/feM2ZRZUZrl0qugypkfa0lhmilXrUoW+TQ8E42GdrixRNu7CVGdkYVFwZVke5kLIKfVmLct6wzqhFDaJBkhC4nCy8pJRgbmy7gLw/3CAd3w
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR01MB6707
X-Rspamd-Queue-Id: B75E05051D0
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-286329-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[admiyo@os.amperecomputing.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[os.amperecomputing.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.996];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,uefi.org:url,amperecomputing.com:email,dmtf.org:url]
X-Rspamd-Action: no action

Implementation of network driver for
Management Component Transport Protocol(MCTP)
over Platform Communication Channel(PCC)

DMTF DSP:0292
Link: https://www.dmtf.org/sites/default/files/standards/documents/DSP0292_1.0.0WIP50.pdf

The transport mechanism is called Platform Communication Channels (PCC)
is part of the ACPI spec:

Link: https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/14_Platform_Communications_Channel/Platform_Comm_Channel.html

The PCC mechanism is managed via a mailbox implemented at
drivers/mailbox/pcc.c

MCTP devices are specified via ACPI by entries in DSDT/SSDT and
reference channels specified in the PCCT. Messages are sent on a type
3 and received on a type 4 channel.  Communication with other devices
use the PCC based doorbell mechanism; a shared memory segment with a
corresponding interrupt and a memory register used to trigger remote
interrupts.

The shared buffer must be at least 68 bytes long as that is the minimum
MTU as defined by the MCTP specification.

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
Stopping the interface will leave any packets that are cached in the
mailbox ringbuffer. They cannot safely be freed until the PCC mailbox
attempts to deliver them and has removed them from the ring buffer.

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

Link: https://www.dmtf.org/sites/default/files/standards/documents/DSP0292_1.0.0WIP50.pdf
Link: https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/14_Platform_Communications_Channel/Platform_Comm_Channel.html
Signed-off-by: Adam Young <admiyo@os.amperecomputing.com>

---

Previous Version:
https://lore.kernel.org/lkml/20260508032953.337036-1-admiyo@os.amperecomputing.com/

Changes from Previous version

Remove check for skb_is_nonlinear(skb) as it is done in skb_linearize(skb)
Removed comment about BE support
Spacing changes after gotos
Moved comment on IRQ unsafe stats from tx_done to tx_prepare
---
 MAINTAINERS                 |   5 +
 drivers/net/mctp/Kconfig    |  16 ++
 drivers/net/mctp/Makefile   |   1 +
 drivers/net/mctp/mctp-pcc.c | 410 ++++++++++++++++++++++++++++++++++++
 4 files changed, 432 insertions(+)
 create mode 100644 drivers/net/mctp/mctp-pcc.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 5bbbbde6b907..252c77b24791 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15403,6 +15403,11 @@ F:	include/net/mctpdevice.h
 F:	include/net/netns/mctp.h
 F:	net/mctp/
 
+MANAGEMENT COMPONENT TRANSPORT PROTOCOL (MCTP) over PCC (MCTP-PCC) Driver
+M:	Adam Young <admiyo@os.amperecomputing.com>
+S:	Maintained
+F:	drivers/net/mctp/mctp-pcc.c
+
 MAPLE TREE
 M:	Liam R. Howlett <liam@infradead.org>
 R:	Alice Ryhl <aliceryhl@google.com>
diff --git a/drivers/net/mctp/Kconfig b/drivers/net/mctp/Kconfig
index cf325ab0b1ef..e68d23794a80 100644
--- a/drivers/net/mctp/Kconfig
+++ b/drivers/net/mctp/Kconfig
@@ -47,6 +47,22 @@ config MCTP_TRANSPORT_I3C
 	  A MCTP protocol network device is created for each I3C bus
 	  having a "mctp-controller" devicetree property.
 
+config MCTP_TRANSPORT_PCC
+	tristate "MCTP PCC transport"
+	depends on ACPI
+	depends on PCC
+	depends on 64BIT
+	depends on CPU_LITTLE_ENDIAN
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
index 000000000000..a9962c67911c
--- /dev/null
+++ b/drivers/net/mctp/mctp-pcc.c
@@ -0,0 +1,410 @@
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
+#define PCC_HEADER_SIZE         sizeof(struct acpi_pcct_ext_pcc_shared_memory)
+#define MCTP_PCC_MIN_SIZE       (PCC_HEADER_SIZE + MCTP_MIN_MTU)
+#define PCC_EXTRA_LEN           (PCC_HEADER_SIZE - sizeof(pcc_header.command))
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
+static void mctp_pcc_client_rx_callback(struct mbox_client *cl, void *mssg)
+{
+	struct acpi_pcct_ext_pcc_shared_memory pcc_header;
+	struct mctp_pcc_ndev *mctp_pcc_ndev;
+	struct mctp_pcc_mailbox *inbox;
+	struct mctp_skb_cb *cb;
+	struct sk_buff *skb;
+	u32 header_length;
+	int size;
+
+	mctp_pcc_ndev = container_of(cl, struct mctp_pcc_ndev, inbox.client);
+	inbox = &mctp_pcc_ndev->inbox;
+	memcpy_fromio(&pcc_header, inbox->chan->shmem, sizeof(pcc_header));
+
+	// The message must at least have the PCC command indicating it is an MCTP
+	// message followed by the MCTP header, or we have a malformed message.
+	// This may be run on big endian system, but the data in the buffer is
+	// explicitly little endian.
+	header_length = le32_to_cpu(pcc_header.length);
+
+	if (header_length < sizeof(pcc_header.command) + sizeof(struct mctp_hdr))
+		goto error;
+
+	// If the reported size is larger than the shared memory minus headers,
+	// something is wrong and treat the buffer as corrupted data.
+	if (header_length > inbox->chan->shmem_size - PCC_EXTRA_LEN)
+		goto error;
+
+	if (memcmp(&pcc_header.command, MCTP_SIGNATURE, MCTP_SIGNATURE_LENGTH) != 0)
+		goto error;
+
+	size = header_length + PCC_EXTRA_LEN;
+	skb = netdev_alloc_skb(mctp_pcc_ndev->ndev, size);
+	if (!skb)
+		goto error;
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
+	return;
+error:
+	dev_dstats_rx_dropped(mctp_pcc_ndev->ndev);
+}
+
+static netdev_tx_t mctp_pcc_tx(struct sk_buff *skb, struct net_device *ndev)
+{
+	struct acpi_pcct_ext_pcc_shared_memory *pcc_header;
+	struct mctp_pcc_ndev *mpnd = netdev_priv(ndev);
+	int len = skb->len;
+
+	/* Consolidated a fragmented packet into contiguous memory */
+	if (skb_linearize(skb))
+		goto error;
+
+	if (skb_cow_head(skb, sizeof(*pcc_header)))
+		goto error;
+	pcc_header = skb_push(skb, sizeof(*pcc_header));
+	pcc_header->signature = PCC_SIGNATURE | mpnd->outbox.index;
+	pcc_header->flags = PCC_CMD_COMPLETION_NOTIFY;
+	memcpy(&pcc_header->command, MCTP_SIGNATURE, MCTP_SIGNATURE_LENGTH);
+	pcc_header->length = len + MCTP_SIGNATURE_LENGTH;
+
+	if (mbox_send_message(mpnd->outbox.chan->mchan, skb) < 0) {
+		// Remove the header in case it gets sent again
+		skb_pull(skb, sizeof(*pcc_header));
+		netif_stop_queue(ndev);
+		return NETDEV_TX_BUSY;
+	}
+
+	return NETDEV_TX_OK;
+error:
+	dev_dstats_tx_dropped(ndev);
+	kfree_skb(skb);
+	return NETDEV_TX_OK;
+}
+
+static void mctp_pcc_tx_prepare(struct mbox_client *cl, void *mssg)
+{
+	struct mctp_pcc_ndev *mctp_pcc_ndev;
+	struct mctp_pcc_mailbox *outbox;
+	struct sk_buff *skb = mssg;
+
+	mctp_pcc_ndev = container_of(cl, struct mctp_pcc_ndev, outbox.client);
+	outbox = &mctp_pcc_ndev->outbox;
+
+	/* The PCC Mailbox typically does not make use of the mssg pointer
+	 * The mctp-over pcc driver is the only client that uses it.
+	 * This value should always be non-null; it is possible
+	 * that a change in the Mailbox level will break that assumption.
+	 */
+	if (!skb) {
+		netdev_warn_once(mctp_pcc_ndev->ndev,
+				 "%s called with null message.\n", __func__);
+		return;
+	}
+
+	if (skb->len > outbox->chan->shmem_size) {
+		dev_dstats_tx_dropped(mctp_pcc_ndev->ndev);
+		return;
+	}
+	memcpy_toio(outbox->chan->shmem, skb->data, skb->len);
+
+	/*
+	 * This packet could still be dropped in the PCC layer,
+	 * But the only place that could deal with that is mctp_pcc_tx_done.
+	 * That is called from the Hard-IRQ handler, and it is not safe to
+	 * call stats functions from HARD-IRQ context.
+	 */
+
+	dev_dstats_tx_add(mctp_pcc_ndev->ndev, skb->len);
+}
+
+static void mctp_pcc_tx_done(struct mbox_client *c, void *mssg, int r)
+{
+	struct mctp_pcc_ndev *mctp_pcc_ndev;
+	struct sk_buff *skb = mssg;
+
+	/*
+	 * If there is a packet in flight during driver cleanup
+	 * It may have been freed already.
+	 */
+	if (!mssg)
+		return;
+	mctp_pcc_ndev = container_of(c, struct mctp_pcc_ndev, outbox.client);
+	dev_consume_skb_any(skb);
+	netif_wake_queue(mctp_pcc_ndev->ndev);
+}
+
+static int mctp_pcc_open(struct net_device *ndev)
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
+	if (outbox->chan->shmem_size < MCTP_PCC_MIN_SIZE) {
+		pcc_mbox_free_channel(outbox->chan);
+		return -EINVAL;
+	}
+
+	inbox->client.rx_callback = mctp_pcc_client_rx_callback;
+	inbox->chan = pcc_mbox_request_channel(&inbox->client, inbox->index);
+	if (IS_ERR(inbox->chan)) {
+		pcc_mbox_free_channel(outbox->chan);
+		return PTR_ERR(inbox->chan);
+	}
+	if (inbox->chan->shmem_size < MCTP_PCC_MIN_SIZE) {
+		pcc_mbox_free_channel(outbox->chan);
+		pcc_mbox_free_channel(inbox->chan);
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static int mctp_pcc_stop(struct net_device *ndev)
+{
+	struct mctp_pcc_ndev *mctp_pcc_ndev;
+	unsigned int count, idx;
+	struct mbox_chan *chan;
+	struct sk_buff *skb;
+
+	mctp_pcc_ndev = netdev_priv(ndev);
+	chan = mctp_pcc_ndev->outbox.chan->mchan;
+	pcc_mbox_free_channel(mctp_pcc_ndev->inbox.chan);
+	scoped_guard(spinlock_irqsave, &chan->lock) {
+		skb = chan->active_req;
+		chan->active_req = NULL;
+		if (skb) {
+			dev_dstats_tx_dropped(ndev);
+			dev_consume_skb_any(skb);
+		}
+		while (chan->msg_count > 0) {
+			count = chan->msg_count;
+			idx = chan->msg_free;
+			if (idx >= count)
+				idx -= count;
+			else
+				idx += MBOX_TX_QUEUE_LEN - count;
+			skb = chan->msg_data[idx];
+			dev_dstats_tx_dropped(ndev);
+			dev_consume_skb_any(skb);
+			chan->msg_count--;
+		}
+	}
+	pcc_mbox_free_channel(mctp_pcc_ndev->outbox.chan);
+	return 0;
+}
+
+static const struct net_device_ops mctp_pcc_netdev_ops = {
+	.ndo_open = mctp_pcc_open,
+	.ndo_stop = mctp_pcc_stop,
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
+	if (ares->type != ACPI_RESOURCE_TYPE_ADDRESS32)
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
+	default:
+		return AE_ERROR;
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
+static int initialize_mtu(struct net_device *ndev)
+{
+	struct mctp_pcc_ndev *mctp_pcc_ndev;
+	struct mctp_pcc_mailbox *outbox;
+	struct pcc_mbox_chan *pchan;
+	int mctp_pcc_max_mtu;
+
+	mctp_pcc_ndev = netdev_priv(ndev);
+	outbox = &mctp_pcc_ndev->outbox;
+	pchan = pcc_mbox_request_channel(&outbox->client, outbox->index);
+	if (IS_ERR(pchan))
+		return PTR_ERR(pchan);
+	if (pchan->shmem_size < MCTP_MIN_MTU + sizeof(struct acpi_pcct_ext_pcc_shared_memory)) {
+		pcc_mbox_free_channel(pchan);
+		return -EINVAL;
+	}
+	mctp_pcc_max_mtu = pchan->shmem_size - sizeof(struct acpi_pcct_ext_pcc_shared_memory);
+	pcc_mbox_free_channel(pchan);
+
+	ndev->mtu = MCTP_MIN_MTU;
+	ndev->max_mtu = mctp_pcc_max_mtu;
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
+	/*
+	 * Ensure we have exactly 2 channels: an outbox and an inbox.
+	 */
+	if (context.index != 2)
+		return -EINVAL;
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
+	rc = initialize_mtu(ndev);
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


